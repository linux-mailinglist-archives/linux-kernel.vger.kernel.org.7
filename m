Return-Path: <linux-kernel+bounces-774474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F28F5B2B2D1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 22:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3519C628492
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 20:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCE22356B9;
	Mon, 18 Aug 2025 20:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="M3gQR9WK"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013027.outbound.protection.outlook.com [40.107.159.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6442120AF67;
	Mon, 18 Aug 2025 20:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755550115; cv=fail; b=D87NrQbu4T2jBOppJ9Q9SeKNFbgCgL73mSGoqN/QccygAk/HhpKOemT5ReAZ2lM7d8ziHc8YER1zmfaN/5tvQxOEAh3WYLjkuikaUjwN2jXHmzTkbD1RuH0H5CayECyKdt0m9PhtBn9BhorRQ/otmQvPtZ4XkMl/TDOBtGVmE5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755550115; c=relaxed/simple;
	bh=0/5ItEjlYt4QyObQQmHFOVIGHATWrnOxBdR689RYulw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=VoH6ZoSM3ZLa7lm0Dr4ihkfyBSJIWEaFfU1dSYAfTULgZ3GMb5UBym4To8T/BUXXnodoe9MYs+jcXG5AGEAkkkqsFJXLfqqz27HzuYndzZpCOoO/G4pOHTT7Zlrx8GgEpwrXVqtkw1X53O6iEE27sUKwSwoFuCwGFyx9pLJpgsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=M3gQR9WK; arc=fail smtp.client-ip=40.107.159.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v2a2c2l1+lqwHG+31zblPHbuRSx/Unrjg++XTQKXaFjYW2RVXWmSBECbCfYMRTYwvt0MrzM7aONCbkl2StVEbXSSm18RQSYmnrjSaRDhfvLArRE6PtfwnkBRKnrICiOi7VY3obgOMiMyQKwlUJ2pw4Bebp/3hqxITAtHwGzoMYuE34dfQtY1FpQMBDX+V7yGjupLzYbNpGD/o77lEM828fK511YkrknAmVIxxWGE9LM+XotM++OiwLGhFtXWvEQ9svVwL7PxudQeTtwh9aW7+6D9rS5ZYMxpMiVwP1Fprrb3b3pfurwyAotlpnfT9Fko/iEp8wpXPNbiKz4d/jefsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mO5kspH2m3u/hDW7655W1y/mWe2trxQJqrTuyVxNuf8=;
 b=EQVt0PElxpMpXykgCvs7zW6yd6GZqf9cAghJuda98HXp3hOhOrnzjTbOqn/JsUZR60LbQMdcD4jZFxlewWyVPgbsBCoMwb4kBB6CvtpQXBVd18vwZtJvG8n2k2g5qM8+JDke8lV4Boitw6MBO9TGH+ryb0duYVnaYldykUfuC7mwRuYwKlPVW8l8rMdKTrmBcj4y6Ax60qwp032GP8vv0R5kvieG7OkqVAaOBpBuA4suHBdNgCd3rNvfCvn4qdd6ARZjvyAB0kTFsqlecWJradRg/1Ip+eO6t/cOenx+gf74W3wg0ZJ8yy8bB9g6drKxgc01SgvTp50P/VebwqvKyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mO5kspH2m3u/hDW7655W1y/mWe2trxQJqrTuyVxNuf8=;
 b=M3gQR9WKN2LDvtAalc2klD6SnN08nxlHjoXnGhu0GFsQPLt2JYJC7W58GoxR8yBmCz2swRqWypj/tgN/VNL6+RQaG3agsTEVvkf4y3JN8ZH84AGEW9R+j7j4daux77LBsjUG3PXa2+UW4l8wXDyl/mC2OsXIc+CUsz34BNwjT/89zoId96baQL2fsC8EtT+Zyfb6oHPBGszJwnfPbxNw0qBw1bf07WXvkfTeqCCwYv21jj4dJOXhdgWjZtYFAttcagRqH2JL0wbjlRmG4s5Cu1jpeQj4rifL2iN1p6KtGnv8YevoR9h5nspG3K57rALtCBdK0VHQH5pI/KcLYnbOMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB7619.eurprd04.prod.outlook.com (2603:10a6:20b:284::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Mon, 18 Aug
 2025 20:48:30 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9052.011; Mon, 18 Aug 2025
 20:48:30 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 18 Aug 2025 16:48:12 -0400
Subject: [PATCH 01/15] ARM: dts: ls1021a: swap dma tx/rx channel to fix
 DTB_CHECK warning
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-ls1021a_dts_warning-v1-1-7a79b6b4a0e2@nxp.com>
References: <20250818-ls1021a_dts_warning-v1-0-7a79b6b4a0e2@nxp.com>
In-Reply-To: <20250818-ls1021a_dts_warning-v1-0-7a79b6b4a0e2@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755550106; l=1328;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=0/5ItEjlYt4QyObQQmHFOVIGHATWrnOxBdR689RYulw=;
 b=3kibbK2fJk/2g1aHH9HEC2o0lII0t3XkLRWilBtKYRck1A2m4QUafrEs03HXzUjVrWbRkpu4X
 ebE/MDqG3m3AD7jESRhxklbPBNcm3xPQ2p8w01dkmVv/reL546hrMh2
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: AM9P192CA0022.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::27) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB7619:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d203234-4224-4ec9-e9bd-08ddde98969b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZFVVV05FNW1Tc2tXYnNjMnlpMUQrZ2JuQTEyVDZnS1hzaERwOVIwcVc1TDFE?=
 =?utf-8?B?bnlUSjYxUXFHWnlCa290SldERVdNTkhPZndGdERlSzd6VEFNVG5MTFo0ZFJh?=
 =?utf-8?B?QzB2bFhvWFlIRkdxc1F1MEpjTEIvdENXMzJ3TVMwcXNMZGZhL3BYMjlhRy8w?=
 =?utf-8?B?SWdhdnFoUWp4eGFoeVJLd1llTER4OWVTOG1pUm9UdDN4NU5tdEZEd0NjQy9u?=
 =?utf-8?B?Z0JNQUw4TTAwcHlBYnB1NTNZcloxZmZBNWRHQW9VT0U2ZmxBTkFRRVdUS0pk?=
 =?utf-8?B?MWY4UmE1VjZ3S2Jsa1hCcnhsRFhDK2g1bnF0L2tObXh4WTZLN01GeFFidGc1?=
 =?utf-8?B?VDdVdlB4YUNodGNXY0RiQnlIV1E2WVpDSldrTzh2ak9DN0Jyek9mMk9UQ3ZP?=
 =?utf-8?B?NEhWOWNidTBRRUQxRGhpNmtBeEd1NDRqUVYxZG9PQnQ2blFIK3lOTEpHOFpO?=
 =?utf-8?B?TXllaGlWYWRPOTFDUkd4OS96UnBDTXBqTzUybjFVTnc3LzB1YTZmU2cwTTcr?=
 =?utf-8?B?RHIxcCtIRWxGV0h4NEpXVGhZWFdMTUcvenZRWGp5b2V6bWF3MnAyTUFXZHNH?=
 =?utf-8?B?Q0NSNklOMjFJVml4eU1CRzd6VDNIcFljd2NFaVczbFVNOGFhbGptM3dkQk1n?=
 =?utf-8?B?bEV5NktBSExwSGc4Z0xsTUpTckVCN01QcURLNDlmM09EK1I1bDVmbFl3ejNs?=
 =?utf-8?B?SFhSMlBmcmFpWi9GY0o2WnRiNHM0YktiWTRHTHJHbGlQcXlBUVhhRUJyQnli?=
 =?utf-8?B?c0RIODYrTFowRktiRjd3S2FQVFVOTjNKYU8zWHZaSWVvWDBjOFFwVDRBbVVW?=
 =?utf-8?B?V2tRTWJOOVpLNVNCT2VQVHR3bjhVQWxnVUttN2M5SHFkbTFhZWpLSmxzRWJj?=
 =?utf-8?B?VDc5Mi85Z2k0U2txZHl2aWZwY1ZobllzMVNKWXdoSEJCclJKUUwySXRBRGc1?=
 =?utf-8?B?bTZQaDI3TjJJeVRacll2Ui9IdnNzaVFNS21TZW1uRnB0c0ZBZjhTU0FiOEVH?=
 =?utf-8?B?cU1XWFNmdXNQSzB4R1dHN3NBR1FtQlRzVXBXREJwRUR6d0FJU0NrYkYyaWRt?=
 =?utf-8?B?RXFMMEVWWWF3bEZ0aEswR0VoajFUd0R4RTM5eXgvbWFKdUtaWWxOcEJvZC9P?=
 =?utf-8?B?VGNCVENoNEYwK0hSdXpEdWtZTUFOUmR2RUFQSGVBS0pCcWxKck84TVphV1Uv?=
 =?utf-8?B?VlRIdjJxaEIrM2RDN21mN3RiRVdadWhJbFV4TitBR2NoYUFBa3RrYnF5aXBZ?=
 =?utf-8?B?aGp0Z2JuM3JORnBJZUxHMnJWejlwMFJEdXpUdFQzVzEwMGNmeFMwRkRtS210?=
 =?utf-8?B?dzcxRVlrOXo0MVp3RURDWlhFaDZYM0hUSmN3emNIbXFTTGpuSFdlN3BSSTc2?=
 =?utf-8?B?d1JLendJRnFGQmxQdjZiR2k1Znp5Z3FXT3NJZEs0Y28xd1l3bTRyK21oWUlY?=
 =?utf-8?B?RkhpNGxwNlorTXBEQ0FHZDR1a1FJUEVOWVNybzN5MDdDR2xNMU9ua1Z2dXl1?=
 =?utf-8?B?VXpBNHVLYmpnbndiZlozczFmZCttajdSTW93TE9IbVc5LzBrQ210b0Q2RFJy?=
 =?utf-8?B?UGJURjBhZ3Q3Q21uaGVPTitGK0hIeTd6RlBYQ3NiNElKTll5L2lpdnpXNit4?=
 =?utf-8?B?N0l0emVRcjJTZUdQYkkwRDJncnkxTStuWE1sMHFBaUZ0dzQrdnZ4TldVSnpv?=
 =?utf-8?B?eHJ3V2xOTy80OWI2TXhBL09VNU1McmVBUWg5T2lHY0dhSVRvQkJRN1hnUDYv?=
 =?utf-8?B?RmpDc0ZlV1llSDlzU29WalM1eHUvc3V1UEozTmJjMld0bzdmM2xTZ0k5Ylkv?=
 =?utf-8?B?NnRtTU9Bb0ZJRjhuWENWY1UrQ0RVLzArUXhGMHNIS0ozc2c5WDZwcndKTjJq?=
 =?utf-8?B?WUFCT1cvVWJjTzJCS1llQ1NjcXJvdGpwTTRKQmtZa21TY0c3a0pTaTBxM09o?=
 =?utf-8?B?Y0xUOXh0NERrQU5peXVna3hjYVAxb05RbWdWYmo2UWFPN3Y5Ykt1Vk9JdWJy?=
 =?utf-8?B?Uk9vZHdReTZBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MUcyV1FGbHVlWE4vUi9adS9rS3gxZjY5NFJvU3R0aXhpdXBkZzlHWlFTSVZS?=
 =?utf-8?B?Q3dmbjlNRlVSRzkwaG81Q1FJd1BUQU5EOEVyc1pRMGxRYnh3QVdWd0w1WTBq?=
 =?utf-8?B?czBXRUtKNUxxM3BHbkVxL1VTbGNjVXVtN24xTkR6T2RpRU1vOG5MWmtQWGFm?=
 =?utf-8?B?QzYreUFKb1JSUzRBTGpoc2dDbi9reU13Y2QrUXVIemU0VDNjV0VKdFkrMHE5?=
 =?utf-8?B?Sm9sL25kb0h4Y25KcE96d08vTWM2anovZHdQamlsVGorcm9OMThuVEdudllW?=
 =?utf-8?B?VUZLRmlqZkZqQkNTVVFJWjdOSm5GRllxTTJ4UldLcW1LMkFqY0FEOW1oblhN?=
 =?utf-8?B?N0h1cjFQdUpDQk5hNWN1MXdOUFREdzZ1dTNxMlR5QXBISTRKbHJZTmZWZi8r?=
 =?utf-8?B?Nkp3b2NYaGZ2Sklyb0tOazg3bklJZzhGSHBXbUVRckNrbkF6dHQwOC9STkxS?=
 =?utf-8?B?OUZRTU9iRW54M1lhaWN6SG91OEZVK0tEc1dHZU1kQ2xhUExVRGdLbGRiN3VS?=
 =?utf-8?B?VHVDbTZxc1EyY2p3REJxY09vWTlhTnpmRnM0OC9HdmkwVVdWd0RIeVhCb2NJ?=
 =?utf-8?B?T3lSK3NpbzM1ejEvREpvQWJvayt2Y0EreVBYVHp6SGp0WEhCZTR6WGdWQ3I4?=
 =?utf-8?B?dWQ1TzZjaXFta002azBZWmh5UlBDZjlPRWVoZEtYSFhRQm1RYk1EY1JHRDFI?=
 =?utf-8?B?RkZkc3FyNmZlVVpyLzRreDJMZm5kWXgvUXlVcFVWWVZFNFNSKzVuS3VHZ3pP?=
 =?utf-8?B?dlY5OS85ZDlieVdTZ3JvVGx3cVRQd1hLbXc4K2diZWtxemw1ckM5VVQrY1ZO?=
 =?utf-8?B?SnNMQ1pTYUdKbWYzOWgxYlk0N0Q0WVpkUUxUQlRndXptaGtuYXRIbGxlSnhH?=
 =?utf-8?B?bHh1Qm5hbXZtQUU1aUIra09aTWwyZDRTdmJhMjFjMWsrMmVYMStUQlF6MklD?=
 =?utf-8?B?L3BNcUlLQ0ZSMlBjSTdaenJ3WFlsNzQwSVpvZ0w4UjlvcjFyenBzekVZRy9U?=
 =?utf-8?B?Y3laS3QzTTRTVDZsMkM1THd4QXh3Wm5xUldhdDltd29PTldrMkx1WW1kRlg1?=
 =?utf-8?B?N01oemVVMUNSWE5NTCt4OG5aWWl6U3NxbVk2dVVMdVNnYkdKc2RPaWtmNWhp?=
 =?utf-8?B?ejBpQzlYYjNUU0Yza1RMQzBGZUd6UVdhYlFTL25jMFg4aWNucGtVeXZIdEtw?=
 =?utf-8?B?Qk5FZmZ6S2RrNmFVbkxsVGsrcTgrTUZLbnNvckdHUjdJZS9sK1F0VllMTXVW?=
 =?utf-8?B?ekV3OHJNTGFCdWg4MGpwL0lkUnE0VGs3b2NiUTQ0MXgrcUlsb0UzZGJQdFVy?=
 =?utf-8?B?cnZyVnhRb1NtR2VyMmREQlV1WDVuYmtzdEFnTU1hUDFsZDFESEw5SG4zQ0hT?=
 =?utf-8?B?R0hOd3dGeDY4RnE0cCt0TGt4TUlNbzlmVU1KYThWNDJKekNxTGJxS2MwdDJX?=
 =?utf-8?B?eHl3a2w2YldGdSt6azhabStnclpOTEhVTGdJSXNRUXh6OEFWUmc2d2NNdE9u?=
 =?utf-8?B?YmVCZ1dCQlRMdXV4ZEloM3RBd2lWalRlTUd6UDducEYxdG9kQTVWVTg4eFRJ?=
 =?utf-8?B?K2JMbml5eVNaeWQwaTM2YTcvNDk1MFVLVWlKUllCSlZyK2pZN3FtMVRMS1NG?=
 =?utf-8?B?Nzk5ekdwWVNCbU9xakFGMEdRV0ZMaGtNdXpJY3E4dStPb3gxSkFqVlVDTG9Z?=
 =?utf-8?B?aEtHOXNEakVhQjJSYjdhN2ZwQndPK2trUGdVdHRvUGRWY0cvUEh6TFhxbGRS?=
 =?utf-8?B?cVdlU2Y0Qy9sc1F2cTJrd1JrQWU1dis4L3VQKzhDV2J0SWJNdmJVOTZuNWNz?=
 =?utf-8?B?SXIwdE10Und5Q3lFSXMwamVGeUtQYlRIdHdHcHRVcjR1SG05T0lRYzZId0dq?=
 =?utf-8?B?R1dSVm5LRW1KSFJKN2wzQmZyblVkYlFRRWV5UWxLb3BmUG5QZElsREg4MDRV?=
 =?utf-8?B?ZmdzcnhmQndTQS9OcXF1TFROdmFaT0dSOXhWeE5lZmRHaEp4RzRHRWlTVEdo?=
 =?utf-8?B?YnR6MTNwRHQzT2VZVHlUWVZsVlZXQ0tjUzM0M0dtY2xKVXZvM3Fod2JzYWR4?=
 =?utf-8?B?clJiZ0JKM0tPeUJzcWlUbXJEK3V4WU54KzRIVXBrWitzMUdyT202Z2I2WHpL?=
 =?utf-8?Q?/B5UfRkozlohloTba/xC1usGq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d203234-4224-4ec9-e9bd-08ddde98969b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 20:48:30.1708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wC5vMlMV7TAsGERLmfsa2+A9W7SOW34puAJx09Mw+nl9qqZf0Ml2hjlfL3qqS+ovhubMwO9pnVHPF7Q+ho8y/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7619

swap dmas and dma-names to fix build DTB_CHECK warning:
	sai@2b50000: dma-names:1: 'tx' was expected

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/ls/ls1021a.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi b/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
index e86998ca77d6ef03dcf196bf6d8271c0ee50cf4c..315f7fb8dbf4c5e9a482c285a8f394a3a2f6bfff 100644
--- a/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
+++ b/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
@@ -627,9 +627,9 @@ sai1: sai@2b50000 {
 			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
 				 <&clockgen 4 1>, <&clockgen 4 1>;
 			clock-names = "bus", "mclk1", "mclk2", "mclk3";
-			dma-names = "tx", "rx";
-			dmas = <&edma0 1 47>,
-			       <&edma0 1 46>;
+			dma-names = "rx", "tx";
+			dmas = <&edma0 1 46>,
+			       <&edma0 1 47>;
 			status = "disabled";
 		};
 
@@ -641,9 +641,9 @@ sai2: sai@2b60000 {
 			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
 				 <&clockgen 4 1>, <&clockgen 4 1>;
 			clock-names = "bus", "mclk1", "mclk2", "mclk3";
-			dma-names = "tx", "rx";
-			dmas = <&edma0 1 45>,
-			       <&edma0 1 44>;
+			dma-names = "rx", "tx";
+			dmas = <&edma0 1 44>,
+			       <&edma0 1 45>;
 			status = "disabled";
 		};
 

-- 
2.34.1


