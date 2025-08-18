Return-Path: <linux-kernel+bounces-774130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8441B2AEF2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 19:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BBF15842C7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 17:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF4E32C323;
	Mon, 18 Aug 2025 17:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="qLr+pNy6"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010034.outbound.protection.outlook.com [52.101.84.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96E632C319
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 17:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755536577; cv=fail; b=cPSyulELLHmHvslAGhUEa0nEkc1/znPT6BZ2vwRhbLYP+tWJ1FyJVM0w3WMPvzgzIbRF74nqPdZybyuoa0JA2q3X2p2bV8r//Xg31+uPUOXfkMHBJH3xv2ifTx2ri8g791/KRPo2Gl+tbycTJp5khsaxWRpwdQefzOVYZrm05tc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755536577; c=relaxed/simple;
	bh=Kr58udKwrKBAWIJ5xhI2VfID9Y2FaBqwbcEIguhBss0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CKEglIPdz8is9/nfjGlv2AFl0lengfrx26zpNqwJo6OkNZNIsc53VoZfgXiuE/aGn59hVbx5ACZExdH7EbuI2GS4gh9QQqASi8o6A4hcFG62qcNrhDmHcvXaLA56SrGUz9yb+gLWTMpFME5b7VK8ln3j+KCFZUMIEBWA/vg6A+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=qLr+pNy6; arc=fail smtp.client-ip=52.101.84.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BiZIV3KxhTxv7U8ke05tm9yvrbyxXfgxpMKSMBntorxnmPItp7kp3aYdro8nJj0G3CEXtUPNgs0hJQ1mpfviVv4HiEaOLxXjWXmFDOvLUWrQU0kl6521j1fr0sCmMyzjvr2aavDLEpIIMqS01Lwz+qIWRMYqa94x3GrqIl2/fPdEm2JpgnaALX+xDf6fabasulQYyl2VJyzFRVsAMRXx/VswKGCYLYr0Zg9szfaSn6vlTKqBk3jyxyoWbkzDW5uH4GtukRJgnHXpCAtckZwAvkVWVveNA5tlGMvHImU+GrCrqTqJqfZ09WvrTdHfAB8GcdmHZV12QS12cAA3rMWyYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KuDGAB0nBFDVJioAbQaWAxY+e6GB9sqVKxaw8Ak9yqc=;
 b=Utg6iF+imernUTnsQzUppMVUjbYlkHM4S1D94A/Zb3CB2+AXVKT1NiF2J8CHXNEejoMbdtLQY1149ti6zJEgR9WqsYb5oavlxgzNQ4IYmOClMOuHLrfP4gc/g4ArhTaRjZT3TgAJsTxfyxXASRGXRhiTxTpIjeA3VRPgb5Gdr2XJImQS+RgLurrwqwl7HW7pGSPV9ZZLeunUhjnptiXTfhR71iE3z3mPUv8bnb5xaglftYByzP41pp3hQy+uM2cQiwLzLeGXIQNWHIXXZwanS9T7x9Jj+WkOLp8IPp0r3kN1ODcTgRd5RdARb/DcgcoKMWgbkv87cqqrP7yAbUaEtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=bootlin.com smtp.mailfrom=arri.de; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=arri.de; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KuDGAB0nBFDVJioAbQaWAxY+e6GB9sqVKxaw8Ak9yqc=;
 b=qLr+pNy6RaJJ7rNX5SuVGLpacezmUdanNQ8RI2wCrcSBb9dqsDJMhNktxzGhJ9AII50iNI5iTsU53mlACzr5O43eu20g7cItRhEjCWPNj1rBNjd4PjUxY+8X8NSd4JPKELGMAviNbrAixxcbXdo8vuMul1CQM/RDmZ3VhonrWds=
Received: from AS4P190CA0045.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5d1::16)
 by AM9PR03MB7932.eurprd03.prod.outlook.com (2603:10a6:20b:43b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 17:02:50 +0000
Received: from AM4PEPF00027A5E.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d1:cafe::a1) by AS4P190CA0045.outlook.office365.com
 (2603:10a6:20b:5d1::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.20 via Frontend Transport; Mon,
 18 Aug 2025 17:02:50 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AM4PEPF00027A5E.mail.protection.outlook.com (10.167.16.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Mon, 18 Aug 2025 17:02:50 +0000
Received: from n9w6sw14.localnet (192.168.54.13) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Mon, 18 Aug
 2025 19:02:49 +0200
From: Christian Eggers <ceggers@arri.de>
To: Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger
	<richard@nod.at>, <linux-mtd@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: mtd: rawnand: Inconsistent parameter page on Foresee FSNS8A002G ?
Date: Mon, 18 Aug 2025 19:02:49 +0200
Message-ID: <3542795.LZWGnKmheA@n9w6sw14>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A5E:EE_|AM9PR03MB7932:EE_
X-MS-Office365-Filtering-Correlation-Id: e1a372c2-295a-4585-4d01-08ddde79104f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qSRjZQxVMn7p1pQBgRBJgpTJbJunbdQv0BHImhx1jk+vKQ8TspdtxiKAcbKd?=
 =?us-ascii?Q?20Ng6ddGe86DA7uN+8ZZ80M3NNMqNyEXGmH/ZLyJtK0+t+nfFvZnzsYZ6V9X?=
 =?us-ascii?Q?hRqajF7xcGQhic2NfCzIwae/FWMFFSRHpH7Gp6BV6okAL/rK7KzJSsX/afYr?=
 =?us-ascii?Q?m1eqW2uzQevsEu8fZjH22tM67JQaQ5fa3lX/9f1AjCetLTzcd/C5tTwyh4Kp?=
 =?us-ascii?Q?GexFc68GaPkSWj1ocB/YvdB7HNerutFaf0e01dqTwqOvjpW5Qtnfylb7wJ5b?=
 =?us-ascii?Q?X+SAUWL3pcW3jf1SdMThE0QbHfpW5Nchp4hSGdBFU8GGK02XxQw6CzdI9ItT?=
 =?us-ascii?Q?lEnQjGS+Mq855xoiDCgtMX/P3apYCx7wc4Gof1pqJDmeLCnj4nhmIyxtfIF+?=
 =?us-ascii?Q?RSKYPGp72fF+vhxjjfMzHef/1Tos1KjBT48S+3z0sa9fxU6u2YKZ6y/4JNB7?=
 =?us-ascii?Q?u5QrYU/lbbmb601WEo/Qb/Q9qO2blXHEePzbNSi7dHv8b9pPkJWJy27/1qDX?=
 =?us-ascii?Q?t8HtTdzTXxC3WEH8ZkHLNlaYHsb9fGZMfZSpk6+uSPVNH5Lj2d9P6H48MYrX?=
 =?us-ascii?Q?AE0gcQYLh+jLAhyNnOURn4mQcLyn0zz6FLUnIikGJHEslVomY64WWww7+89B?=
 =?us-ascii?Q?eCSF8l920lhrIUgoGWN/mMIs6Mc6t9jUQgOaZxQWRArCfRX4S20lPEGp0prw?=
 =?us-ascii?Q?WujJgjMnslXfdS4ORKkMYqm8g8KmYEKmGmSCHwAvcQha6Q7ny9m/sCMSHsBM?=
 =?us-ascii?Q?mTCWYQXV8rJ0l1FUSsW6kmeWCPlBE68w31P2q4OYAQj8qeovToufqb8Iq83W?=
 =?us-ascii?Q?vZZwUbPx+aV4bcWb/ovGysFxvE6IsCFD+q/yLbFigOBGdRwk2hmdzQm9W20i?=
 =?us-ascii?Q?lTXkQYd6agVutINueJG+yuS4s/7K24W0j/IGC+NhAxG040EdP73rOrazxdew?=
 =?us-ascii?Q?tKH2l2mg5MNkv+Mw7Kbnmj66ubOnVhLHZHuWdv4wM7YlrPpoJ/Ed/R1xb40/?=
 =?us-ascii?Q?nJo1D57DzVHd+eyO3GQxV44I5ySJOQG2MJEGnbw3wyoNvR8wuFih9Axt/u15?=
 =?us-ascii?Q?FfDSWhhRgL7CgG8lSuktBSQob1cYyrrIe0L9aoiOsroGB9JlaaWoXkyhsNUp?=
 =?us-ascii?Q?kW+/d5NMduSOGc7QicOboMpNLfVUGIcax85DPTjeYr/8pmRtSNfP3uKis2t9?=
 =?us-ascii?Q?biAuye9HAkohRLNlFXTCUNFDSx347qWHb5nPL4WIQV9IaZmrp8ycg5CONQpu?=
 =?us-ascii?Q?bDEZ0a8C5D87VUWfJfInBVwYE1o70Q0Y5OQxeXLVquabS0OXpc/Vcvuoj34v?=
 =?us-ascii?Q?CO+i82XJsSkzPZZKC8DFe67sX5QAhz/qekSwLA71RMumoYEKceMqi3y59Yq3?=
 =?us-ascii?Q?Q37/gDYrSYzDRGFm063R/R1Pa/AuI2P1d5GmQJK8YAbUQIWmkYuOm3e8v6/x?=
 =?us-ascii?Q?n1ddEoprrIS0DesA+3zmCtQC1Z6NKE5pu7Zu09mci9vSvwlRvF6CvQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 17:02:50.2076
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1a372c2-295a-4585-4d01-08ddde79104f
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A5E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7932

I try to use a Foresee FSNS8A002G SLC flash chip on an i.MX6 GPMI controller:

https://www.lcsc.com/datasheet/C5126835.pdf

The kernel output looks promising, but one line looks suspicious:

...
nand: device found, Manufacturer ID: 0xcd, Chip ID: 0xda
nand: Foresee FSNS8A002G
nand: 256 MiB, SLC, erase size: 128 KiB, page size: 2048, OOB size: 64
nand: SDR timing mode 4 not acknowledged by the NAND chip
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Bad block table found at page 131008, version 0x01
Bad block table found at page 130944, version 0x01
3 fixed-partitions partitions found on MTD device gpmi-nand
...

According to the documentation of "Read Parameter Page", byte 129-130, 
SDR modes 0 to 5 should be supported (page 19 on the data sheet).
But the documentation of the GET_FEATURE/SET_FEATURE operation misses
the "Timing mode" register (data sheet, page 24).

I saw that there is a quirk for some Macronix chips which also seem
not to support getting/setting the timing mode (but declaring them
in the parameter page).

My main question is whether this is "normal variation within the flash
market" or a serious issue. In contrast to another device I currently
use, the Foresee chip also doesn't support "cached" operations. Is there
much value writing a fix for Timing Mode issue, or should I better
use another flash device?

regards,
Christian




