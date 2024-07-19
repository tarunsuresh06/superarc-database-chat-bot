"use client";
import CustomTable from "@/components/CustomTable";
import { useState, ChangeEvent, KeyboardEvent } from "react";

interface Message {
  role: "user" | "bot";
  content: any;
}

const ChatPage = () => {
  const [messages, setMessages] = useState<Message[]>([]);
  const [input, setInput] = useState<string>("");
  const [disabled, setDisabled] = useState(false);

  const sendMessage = async () => {
    if (!input.trim()) return;

    const userMessage: Message = { role: "user", content: input };
    setMessages((prevMessages) => [...prevMessages, userMessage]);

    setInput("");

    try {
      setDisabled(true);
      const response = await fetch("http://127.0.0.1:5000/query", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({ question: input }),
      });
      const data = await response.json();

      const botMessage: Message = { role: "bot", content: data.answer };

      setMessages((prevMessages) => [...prevMessages, userMessage, botMessage]);
      setDisabled(false);
    } catch (error) {
      console.error("Error sending message:", error);
      setDisabled(false);
    }
  };

  const handleInputChange = (e: ChangeEvent<HTMLInputElement>) => {
    setInput(e.target.value);
  };

  const handleKeyPress = (e: KeyboardEvent<HTMLInputElement>) => {
    if (e.key === "Enter") {
      sendMessage();
    }
  };

  return (
    <div className="p-4 bg-black text-white">
      <h1 className="text-xl font-semibold text-center underline underline-offset-4">
        AI CHAT DB
      </h1>
      <div className="flex flex-col min-h-screen max-w-4xl lg:mx-auto p-5 md:px-10 xl:px-0 w-full py-2">
        <div className="flex flex-col items-end overflow-y-auto mb-4 h-[75vh]">
          {messages.map((msg, index) => (
            <div
              key={index}
              className={`p-2 rounded-lg mb-2 ${
                msg.role === "user"
                  ? "bg-blue-600 max-w-[600px]"
                  : "bg-gray-700 self-start"
              }`}
            >
              {msg.role === "bot" ? (
                <CustomTable data={msg.content} />
              ) : (
                msg.content
              )}
            </div>
          ))}
        </div>
        <div className="flex self-center max-w-[600px] w-full bg-gray-800 p-6 rounded-lg">
          <input
            type="text"
            className="flex-1 p-2 rounded-lg bg-gray-800 border border-gray-700 focus:outline-none focus:border-blue-500"
            placeholder="Type your message..."
            value={input}
            onChange={handleInputChange}
            onKeyPress={handleKeyPress}
            disabled={disabled}
          />
          <button
            onClick={sendMessage}
            className="ml-2 py-2 px-8 rounded-lg bg-blue-600 hover:bg-blue-700"
            disabled={disabled}
          >
            Send
          </button>
        </div>
      </div>
    </div>
  );
};

export default ChatPage;
