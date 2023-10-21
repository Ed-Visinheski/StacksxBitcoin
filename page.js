"use client";

import Image from "next/image";
import { useEffect, useState } from "react";
import styles from "./page.module.css";

import { Connect } from "@stacks/connect-react";

import ConnectWallet, { userSession } from "../components/ConnectWallet";
import ContractCallVote from "../components/ContractCallVote";

export default function Home() {
  const [isClient, setIsClient] = useState(false);

  useEffect(() => {
    setIsClient(true);
  }, []); 

  if (!isClient) return null;

  return (
    <Connect
      authOptions={{
        redirectTo: "/",
        userSession,
      }}
    >
      <main className={styles.main}>
        <div className={styles.description}>
          <p>
            Get started by editing&nbsp;
            <code className={styles.code}>src/app/page.js</code>
          </p>

        </div>

        <div className={styles.center}>
          <h2>Chat Room</h2>
        </div>
      

      <div>
        {/* ConnectWallet file: `./src/components/ConnectWallet.js` */}
        <ConnectWallet />

        {/* ContractCallVote file: `./src/components/ContractCallVote.js` */}
        <ContractCallVote />
      </div>
      </main>
    </Connect>
  );
}
