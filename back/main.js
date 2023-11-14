import { DynamoDBClient } from "@aws-sdk/client-dynamodb";
import { DynamoDBDocumentClient, GetCommand, UpdateCommand } from "@aws-sdk/lib-dynamodb";

const client = new DynamoDBClient({});
const docClient = DynamoDBDocumentClient.from(client);


export const handler = async (event) => {
    try {
        const command = new GetCommand({
            TableName: "ViewsTable",
            Key: {
                ViewName: "www.khaldoun.tech",
            },
        });

        const response = await docClient.send(command);
        // console.log(response.Item);
        const updatedAt = response.Item.updatedAt

        const commandUpdate = new UpdateCommand({
            TableName: "ViewsTable",
            Key: {
                ViewName: "www.khaldoun.tech",
            },
            UpdateExpression: "SET #counter = if_not_exists(#counter, :zero) + :incr, #updatedAt = :newUpdatedAt",
            ExpressionAttributeValues: {
                ":incr": 1,
                ":newUpdatedAt": Date.now().toString(),
                ":oldUpdatedAt": updatedAt,
                ":zero": 0,
            },
            ExpressionAttributeNames: {
                "#updatedAt": "updatedAt",
                "#counter": "counter"
            }
            , 
            ConditionExpression: "#updatedAt = :oldUpdatedAt",
            ReturnValues: "UPDATED_NEW",
        });

        const responsUpdate = await docClient.send(commandUpdate);
        console.log(responsUpdate);
        return responsUpdate;
    }

    catch (err) {
        console.log(`Error updating the item because of error - ${err}`);
    }
};
