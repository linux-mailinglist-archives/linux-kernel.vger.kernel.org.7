Return-Path: <linux-kernel+bounces-784131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19081B33711
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 09:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84098176024
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 07:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63B1288C96;
	Mon, 25 Aug 2025 07:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FFlDOqL6"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013033.outbound.protection.outlook.com [40.107.162.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8002882BD
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 07:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756105255; cv=fail; b=HoF9XJiHX6EvHT8WNTV5agpL18vstiLJgKnLmgprDI40HP7Mk17fUcRAjtoulUY8cSuFEb/r0fMU3cw5IrX5MNdlloRjLhLPkj4FZ7OFO1563gxNPQwHojTsOFXxOVfssLzvJym22e0/NR4scm95VDdwZlR+9I/ANRDkvZy75hM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756105255; c=relaxed/simple;
	bh=B9DUXmPMcF/CQaLAI0NXEFCN8Krsy8Rqx9Y85110q/8=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=iH2Aaa11iq44hhAaTBeaPQMdp3LKy6YjHx2wd74SzUSTodyNpAxp2jGJqGubkPQZQLErmEhnvGn1TGIMADb5uW1871pmR85sOSYIQrRDCiUaaQ3uQPvVJbXKgJTihLX73GlXX987Z8kS0+e4UKgwiFO7uuNJ6fyhS6FjjrM8amM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FFlDOqL6; arc=fail smtp.client-ip=40.107.162.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BFHc5PJqzOpWzvOHgGlgf2p7eCKDMG7hF69va0JLrcqiZKL+NGLOPelzGOGZwSHq02g2ihWVGkNzljPMaIYZqCgavBLFrtkwokPEOqn5KNOiUwWrh3KylWyrQsrnlfG0lup6xXkSF3BlURXhCc1EREPyCabDxMtN+nEC0NRaIQYXqGp695Ekal8suFO2fmsIgZudePt7rP7syQMgXJHmhrRy2bAguxoHkUzC8ueway2SF0CENBTG23/YeyjJhPJBwzsNVbyY17d3TXHHDxa095IfwEPdq4alUUR5iGVNWFnF1POXKM7KdSm6LthRK7BNVmVwBOZ0n3n4fblZeXAcGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZ2dhOLCDV1rrcyGFbMxTgnNu5iTuar9+IFGz48itGI=;
 b=R01yKxFn/klLEiHynoVJOIHbcyihAySSrHYv13Sk8lD+Mf70+ySootf2bhThDcqklyj5ZedFcfN7U22otqGlEPM2wkzc9AtnvJjk7i3Rf62bUEv30ZFACYtS7pz9ZACXhdhs1zqI/GhPqbaM0T7X1kdwvafyEAw2SbtsrTqfii/LmooHdtInB11pQduO7GqecfWvB3uIo+GRxN99+yhlPxJqGvyUyTtdhTBtM3mkLTu7SCOtXvBfa+jd8fbeJZ2latqyifhwgi2YvGmo5o0WDTnSVZ7JrZKXuwSuFUz9ytyO7mGbfosyaxK3/5jq7AToGfaVmKlg982DvQ0gZwTyDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZ2dhOLCDV1rrcyGFbMxTgnNu5iTuar9+IFGz48itGI=;
 b=FFlDOqL6bHUnJEgp7uh28Pgvd6Y5RlbfnxM0ycFVzEsvFUdBAknwhwuFv2g6ga4ULcUoWxl2GoJ6SieXz/STAMbksNa/NyTD0jqolCum9chB/K5rDAGWI2tsgpq3fw+O7esIjBgYfRU794RXNxru3MV9xJfi28WmHhjAisVFFbgwTSJrRhJA4M3KI+jbxGMo2Ggy1HLj1PXUtlQBudfGEZf9LdaiVYrqr+09Qy9XtWQG+a7ATuZaSzrGfiRB9M+cb0L0hTBST7K/zcE/yYThudQM4dJ1atnOOtmyCrrwjtE6SwC62iz+Nqti88JfjEBmFPwlXN6lzKgrGXcoTtUVPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GVXPR04MB10325.eurprd04.prod.outlook.com (2603:10a6:150:1e6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.11; Mon, 25 Aug
 2025 07:00:48 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9073.009; Mon, 25 Aug 2025
 07:00:47 +0000
From: Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v2 0/3] firmware: imx: Add stub functions for MISC/CPU/LMM
 APIs
Date: Mon, 25 Aug 2025 15:00:29 +0800
Message-Id: <20250825-imx9-sm-v2-0-0bae0265e66a@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA0KrGgC/2XMQQ7CIBCF4as0sxYzIFbalfcwXWA72FnQNmAIp
 uHuYrcu/5eXb4dIgSlC3+wQKHHkdamhTg2Ms11eJHiqDQrVFQ3eBPvciejFkyxK47BFraC+t0C
 O8yE9htozx/caPgec5G/9N5IUKC7adKSlbd1k70vezuPqYSilfAG58duWnAAAAA==
X-Change-ID: 20250807-imx9-sm-bea018f06042
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
 Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>
Cc: imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756105242; l=1670;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=B9DUXmPMcF/CQaLAI0NXEFCN8Krsy8Rqx9Y85110q/8=;
 b=EpqSQl+ab0cPmCqPRgg/To++XI/REjehOpsIdyc0ihRH596i/v+snxz3qoNbkwxBazw98HdBZ
 5ZWDGM2CAZQCGmWe5xekKt/m23QsiulVlptVUVBrGuLppsBzKDUpea7
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2P153CA0006.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::22) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GVXPR04MB10325:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f04f3a2-9fd8-4b5d-721f-08dde3a51e1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|7416014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TzRINHB0UHNESGhPUkNSZ05KTHgvV29GU2xOL3M2NDJCM1NGTjVQSGsxZitt?=
 =?utf-8?B?azgyMng2UmhSUjRxRDBaSHd1MGJodEJGdUpKTkVHR3BUV1paczdMcmw1bkJs?=
 =?utf-8?B?dHhDcHVUZzhFS1JwaWh4ejZ3LzJOZUJHSVJrUUpaaTdtNzZBd1Yzc0F4b3Zm?=
 =?utf-8?B?RHRoMEZyc043eFB1V3R2Mk1NN2hXWFJoaXNsT1kvRjNpdnVHckRjYXorZlFu?=
 =?utf-8?B?dFBpMjR1bkdpdnhhUmM5VUgydExncm1mQS9OY282amRXV0x1N3ZrWWhJQmZL?=
 =?utf-8?B?WHRPZ2xKMWpsSTIzN2NYeGRSZE01Ymdld01VZ2o0c3M2dEl6OGFMZjJPcnNq?=
 =?utf-8?B?clBEc3ErV1NUZFlCNzV2Z0EwMUpZNWNheGxPWFNNajM5SEt6aHRpcG5Uc1dD?=
 =?utf-8?B?OFJhZGwvM2RZa25iSXpHYXZzNG5zWDhxbElEd1pZVFhzR1I2ZkU1T2UxNEpt?=
 =?utf-8?B?MjVGT1diVlRWdWVKSXV4aGNJaWczcUJ0U0RkbTRvTnBNWVVRSzREQk9IUmlh?=
 =?utf-8?B?cWhhMUhOYUlHN0RPL0lFQ0toam5nZlMzWmNDTWJuVEhjd2xrUFRoNG9kdVJF?=
 =?utf-8?B?cWlrUWQ5L0dUQW9JaUQyUXU0bjdyUTc5eUp6S3piby8rTTlxV3p1SzJXc09t?=
 =?utf-8?B?QVRxTXIyNzh5MnZlclo2eThYUjFDMXVRWWNVbnpCdUdqVzZLdE9FVi9CUm9M?=
 =?utf-8?B?NGs4K3Z2cGtxMGxTOEcyd1pWNnhNN3Y3NGM1eFhPSGxoUVAzMVdzbFpEZzkz?=
 =?utf-8?B?RFcxQmpKL3hWdTNja0xoTjFiSzAwUUd6bFFXTU45S2hnc1BDdXEwSWdUV0V6?=
 =?utf-8?B?d0JUSWJHZTQ1bnZ3MTBHZW5jUVRyNlRvTTM3R3FVNzAvM3dpS2pjRHhsQUFt?=
 =?utf-8?B?OExHcVZNYStnMlhxOGJkYlpScm04aks1eWhZejVxcm9ldm9TZ2dxekROcTZ2?=
 =?utf-8?B?ZnpWQXIrSTN5QVJrQ2hYc1FheTRxSk9EbTdSMm9GSVIvbUgzL0dUSmhLZ0ZP?=
 =?utf-8?B?UVdJaGZpTlRmbWwrcnRqRmRCRmF2NXVYRzlIM3dIU2c1VnBCNVJzQS9DNXl0?=
 =?utf-8?B?Wm1nY2d3Tjh0OUdHTnFhbXlkMnJwSUk1WE1aUCtzOFpsdFZwQnFPRnZ0S3ZU?=
 =?utf-8?B?UUI0WHhZQVkrVSswYzd0a1dQOUwxQjMzUXo3Q0lUMGo0MzhTNmhMVTJGMC9X?=
 =?utf-8?B?dGNuZzdVT2dKdlpyQ1Bja1pXdG9GTVl5WndNTTRiSnQrRVVFRTNCVFJzOWRK?=
 =?utf-8?B?QmFnOUlCWnN1TllKNzhaMHdZTGpiVTRjaSszbEEvM2pFR2NGY1VjbFhPV1FM?=
 =?utf-8?B?MVd3Z0lHQlNIQmFpd3hHN1Y5K2NINmFacTI2ZHdYeE1yV0gvVGR1YUVoWGRJ?=
 =?utf-8?B?cFVXRkxRNmMzSlRTWXVpcjVmaE5ZSktGdGlNTGpmK3ZQSUhTemErTU5GeU52?=
 =?utf-8?B?RUdteUdWZVp2eHJ1RTh2dEpiUGljOTh1QkpIbHFxN3hoRUpINER4UmkyQkIx?=
 =?utf-8?B?ME93MkFibUJuWTFzNWx5aEJsOW1IRmN2M2JHOUs3ZUhCd0VpMUxrMmN3T09V?=
 =?utf-8?B?MjZnSTY2dlVOQ0gwL082NVNUdUNrdDhjZXFwMlRMN1BhSkUramYxcUFmOEZm?=
 =?utf-8?B?My9jd2dUZ0svS1QvcmYrOFhvaVZjN3creWZCN1VRTjdFcVYzS05uY3NPTkVv?=
 =?utf-8?B?M0M2Y0lCSTgzNklpMW1DdFRqT254byszRFplUFY2TUNOa2k4RTF6ekpxWkc0?=
 =?utf-8?B?UjNST2ZKNDgrRXk5YlZPeXcvZGlrejFXVytCWGVhRUdEektLT2YvRWlYMzVs?=
 =?utf-8?B?bVFXVG8yZGpYamF2N1BTdDhDOFNXM3gxT2JlZlp4VVh0elorTVdKaUlZdk9z?=
 =?utf-8?B?Z2RrN2hwZ3l4V0s2ZVcrL1FYcWYwMG9CN0doWXI5NW1NNjhqOC9DeThzdnFq?=
 =?utf-8?B?TFN3dE1PNThQakhPOGlnV0xJMVBnV2R1YXVicXoza1p4OGRTaEJxUnJGVlFv?=
 =?utf-8?Q?T4l2sqY7N3XQvZnxAnwOwxnwQo9PC8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(7416014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UkYvWnJ3ZVBjZlZrSzNDc3BTK1F4ajZOcC96VDF5YzZWeUc2cldqMlpjWWZB?=
 =?utf-8?B?Vjh5dm45My9XWEFabGRwYk1TcFlzRjVrcTNJeWtHQS9aUHBubzVzRzJzc2FB?=
 =?utf-8?B?VzE3dGJzZVB2c1czRXRTTjFvVEpKdkc4VWVKZjQyY3RZVTM0eFdKWit4d2wy?=
 =?utf-8?B?M0V2a3AycXJaYS9CLy93Yk5HRXdaVkwyUDAwTFg5YUI0T085c3FERUxiczFw?=
 =?utf-8?B?VE9vUlFwNHNTSi9ESUNtSmtvbHY1QXdzeGtzWE5SNENBcmxpZk5McVBvNGt6?=
 =?utf-8?B?TCtncTVHUGFvNkRma2xnWGZ2cWNnNXlpdnpwdC96dHZPamZ2Z1A2d0lGL1lv?=
 =?utf-8?B?K1pqWHJGVXl5anRrdno0enJkUEVNVEQwZ2hlSHd4ZG8yYURZekFVcHBlV0lE?=
 =?utf-8?B?cUJORzZFUmpIL2VUU1kyRWdrN1VvNXFsd3IvMW9JcnFLazFtMG1KbjVPY3VI?=
 =?utf-8?B?bzZFYjJ4OU9HbWdEQUFYNlkrMVZ4SXN2UTFFVGVieVlQZ04wMm56dkN4Y3VS?=
 =?utf-8?B?aUovQk56Qld3UFdDR2VoV2Q5R3N5b0haZDdhN2Zvd1Z2QmZPOUpzYXg5dVpB?=
 =?utf-8?B?R21VWlgrTVJKdWgwZlY2WHRycWNRR2tXNHorSWNRZmUwVmlDKzRoRU9Fb3dv?=
 =?utf-8?B?amJhY1ZBeHpkSVFFWFkzNnhCbXJyMWNKd2VSZzYzWHljckIwcmVSZzZxZHhC?=
 =?utf-8?B?dS96NmlhSnoxSjJWcWpRSzVlUGc5M2szZEFWbFp5UVJXWGVaSkduUkRnejZ0?=
 =?utf-8?B?NGpSUHZIdERxTjNkVnNjNFNub2MwTWgyTWpTNlR5NTNuVU5US2Rta3JHRUxC?=
 =?utf-8?B?cXZlcGhRcUFmYkFrNm9nQWdYY3JiWlF3OHRna24xZDkwM0VTTUNCMDNsN09u?=
 =?utf-8?B?eW1ob1dHL0tEZ2p4K3pGLzB6RGhCSS9FTVRJTm9mckljK2F1WUxqUWFrL0J0?=
 =?utf-8?B?UDNkZERrS2ptbXF3NVNTVjV1Y29LZU1XL29QK01pZGNCUnI3bkdWZlMvMFIz?=
 =?utf-8?B?Umxib0FSNUlGdmNiZ1JrN0l1cDFWdnFST2dud2tIbHB3Z3hSekdpS1l1WGda?=
 =?utf-8?B?RnJ2cjNpRTZGdTlweFRoalJyRGhVOWZWaWlwWGVRUFVFU2pLamxXOGN2R1hO?=
 =?utf-8?B?M1dsS2JOWnB3RXA1Vi8wTmt0bUhKb0hicUxhZ2ZJVnBaZVNLbXNzOWEydFZG?=
 =?utf-8?B?RDhjL25pTGJ2OVRoc1JBWHJEa082RWlVc0M0ZnBsOG9wQzVka2F1ZU5TNkZp?=
 =?utf-8?B?T24vV0xWWW00dlgrL3pIekRGaDNTQ0JQTXc3aXZ4T0EyS2d3cDIxMVBkektX?=
 =?utf-8?B?V0FHVEh6endSL2NUeWFWc2JWc1YzQjNDQUJXVHRDMkNPTkh6WXE2azlOU2Ji?=
 =?utf-8?B?eG9oVXdOM3dNeFVpcUN0OVZhcXV5bEE4akFubXhTVHZ3QjhRNVJ6bTcwVWNi?=
 =?utf-8?B?c2Fxb21BMGJrbVhYK2cwYmo1OTVkb2w5bWxyczNKdGJ6TkxlN2JqVjIxSDBx?=
 =?utf-8?B?TDlDWFZaSUdVRjNWaElackt6SGlvaWpYYXhKbEhma1pVRko5RFRiaUFGQ1N2?=
 =?utf-8?B?dlNTQmdqQ0t2M2QrWTZIWC9jL0JBc0VkYmdNVEwzUWlJSU9SSlZubU5wQjdq?=
 =?utf-8?B?MW8rQUIvZmI0eGRhLzY1RVoxb1BDWEFJcUtZNFRrYlcveGQ3aFFtR200Vjlu?=
 =?utf-8?B?RmRiWWw1UU5JZXN2NzdWd2ZlNzI1KzVRWTYwSGZybnd6ZXREN0N3ZDRVTTBl?=
 =?utf-8?B?OUNrV3E5RFM4ZEc3SWZxc3VKQnFxVEQ1ZUtQRlZKWXhkUHVSNnR6cFFtRVRu?=
 =?utf-8?B?TkxtUFlQb29DemU0NEFIMjRuUXphTjZ3ajA4anV1TmxoVVBjNUQzM0h4c000?=
 =?utf-8?B?d3FYaUdpbUtLSmV5OVdaQ1FrNzBHRGE4THR2QzJKVFJNcU84bUFLczVwSGpM?=
 =?utf-8?B?R1ZtSlBqZlowRGNYdnhiY3BFU1NzeXBrU0c1bVhudldad0hQbms3V3gxNGxa?=
 =?utf-8?B?YnhzM0VKRUpVSWIxK28ra20vZFlxRGxpRTJ0NE12ZThlajIxTC9pdEJWeGV0?=
 =?utf-8?B?VmR6dWwyV0t6dmFDMVE1OC85aEtLRU5aSVloV3NWR2tPVTZaaDVOKzBIQTE0?=
 =?utf-8?Q?UJBMNB9lq/Lr8kBWnb0Lmr8v2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f04f3a2-9fd8-4b5d-721f-08dde3a51e1f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 07:00:47.3419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ow0lBNQ6Y/2VxD2o7DHs/nMDx9zTpL/fsLKXLT6gAOgsljd9+f2zak38UE2nzncxLRB6zqgGHF/dkyWIGEb7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10325

To ensure successful builds when CONFIG_IMX_SCMI_[MISC,CPU,LMM]_DRV are not
enabled, this patchset adds static inline stub implementations:

These stubs return -EOPNOTSUPP to indicate that the functionality is not
supported in the current configuration. This avoids potential build or
link errors in code that conditionally calls these functions based on
feature availability.

The initial support for SCMI MISC API was to use CONFIG_IMX_SCMI_MISC_EXT
to guard the API. But this is wrong. There was an commit [1] that tried to
address build issue for MISC API, but the better fix should use
CONFIG_IMX_SCMI_MISC_DRV to guard the APIs. Because when user driver
reference the APIs, but CONFIG_IMX_SCMI_MISC_DRV is not defined, there
will be link error.

This patchset is to fix the issues for all the three drivers.

I add Fixes tag to the patchset, so I not delay the sending until RC1.

[1] 540c830212ed ("firmware: imx: remove duplicate scmi_imx_misc_ctrl_get()")

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v2:
- Add R-b from Cristian
- Update commit log in patch 1 per Arnd
- Link to v1: https://lore.kernel.org/r/20250807-imx9-sm-v1-0-3489e41a6fda@nxp.com

---
Peng Fan (3):
      firmware: imx: Add stub functions for SCMI MISC API
      firmware: imx: Add stub functions for SCMI LMM API
      firmware: imx: Add stub functions for SCMI CPU API

 include/linux/firmware/imx/sm.h | 47 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)
---
base-commit: 706168a6b4c3560b7930a2b00899f4e6e8520b22
change-id: 20250807-imx9-sm-bea018f06042

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


