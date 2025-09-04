Return-Path: <linux-kernel+bounces-801182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9690B440E5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 690E85A2A1D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4AC3090CA;
	Thu,  4 Sep 2025 15:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EeLvkb79"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010029.outbound.protection.outlook.com [52.101.69.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F143C28850F
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 15:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757000672; cv=fail; b=pkPUSkUkcPXVhYVXD8Jc6bTHZmp9yB/KhLIX7BdgvRz3T2Txa5MAtIyIIpio5HCT6zpKXbKPxXYD7qwwbzv+MfpuD01XnTAHnU4fn8nYnzprR930gYGjmqxVu+3hAwareLLm21L+Li9bdLUbd97J/CEuVGXMXuIggJlYFMmXEQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757000672; c=relaxed/simple;
	bh=UF8Z2Uyrw+Ldi1ZSxRJcGNoCDhhXOn+72Ha8d2/K9kc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kcVLfTb3mrvYIBxdgH4uLtDRPUhnyhSDfdVFMhtJOssfq0CCqC0V8tK7jbk2B/aAJTDZoXz6YPW78FoGgzCgR4RWq/+3MVBAvuDugU4fKM6rJBDLoPMEDB58vC2FU++iaSVvIoEuvgp9toX6ZuKovrswz1GsRPtFP+N392ZS3rc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EeLvkb79; arc=fail smtp.client-ip=52.101.69.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oVV5sqhq91J4yjvFgRW9ipFYQ11DVtCWyFJ3p1V9zc82rBA+UaeEs0Nhtk+JPhPePPUhn60aeWWoquHHddh8y4nvfeqYPyx+mGiKY8WJ5+DpvCFI61mUomcANZiZyFfN7kP1k+zGACJoJLMLyp0KWuKscMqP+ovf64xhb21r3DL9wJbCssoGPkfsPDb5RrJ6genFlVrEynQ/dbUXNkN4doUvHNXsaQx3/itdnQe8+CB6A348IN93UTPFFh0uuQrRrumW2eocyeq0OeRwQs/+HiOO8mnPDBfqGSuUF441TRp3NoSnCUcZKLnu1Y4uvXBPop9vnL6B0MAd5QWm+u3z4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qn7G5uBAoD3yWq6TW0r6z8yAK8XBT9TFJzfF2OFKFYo=;
 b=RsctxeS5wg7mfP3PyT9k1OBakDS/EJj8Aoze+yPMfH2nr8tDjJ230wE1LfzZAswlhalLY2V2mDFNZYNEs9npZ/nFP39tT1PdUMMxEtBjO3BkF5mvCiu2zhAdVtngWPUpncKxCpdn47g30DfFn1g2cjqgEIuW9O36vvhUJiMGisoYxx3201TalUkWGTAsgUoEiP/rf8DqAYY1sbP7dnovCVbo3sJMYKnZ+paCifnJ/8EMW0pYD8Opd+VEnTMezcVX9KY0RN+hH4yX11PT8+DunXohbtrzdVQzDT9wnx6vSSahD2j31kJp2vtfuT0lhdFzQN+cv5vbaVJKFOAfBpreEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qn7G5uBAoD3yWq6TW0r6z8yAK8XBT9TFJzfF2OFKFYo=;
 b=EeLvkb79b5vrVuQdeBZLbr4PfUZQYbz3+L4cGyomNvrVOnF3vJGaGD1k0/9olNMgNHkWADwyGAmMOFyq5UnztGAoOMLNS23UwHWJvPzYvRlgJ5jvcwuD7x49NDbgHtONCRPrnPYeKJLnNQAhB4NeAkPukFV00yMCQ8opOQyDAMNyeOlGCgf6U8BxpAaKiyYV3s7A9UrRm4zOCY54H0QBFrdAkvuZ1HkrTiu6YufBvgmJ0tEvHb6Qylaj0K4KoHUCzbSB+cVkbzSknSUZm+UJURTbhWv0CYKMVuo4spTY28a6eriWMt05fvX4FS3tlrDOWYpCmZYa0BgrRSW0giq06A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AM9PR04MB7635.eurprd04.prod.outlook.com (2603:10a6:20b:285::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Thu, 4 Sep
 2025 15:44:19 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 15:44:19 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH phy 11/14] phy: lynx-28g: truly power the lanes up or down
Date: Thu,  4 Sep 2025 18:43:59 +0300
Message-Id: <20250904154402.300032-12-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250904154402.300032-1-vladimir.oltean@nxp.com>
References: <20250904154402.300032-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0060.eurprd03.prod.outlook.com (2603:10a6:208::37)
 To AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AM9PR04MB7635:EE_
X-MS-Office365-Filtering-Correlation-Id: 968ca221-7603-44ec-8fdf-08ddebc9e8f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|19092799006|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b2EUdVwz5BL3eRVGTnt7+Hurvs+ZJ5Na9jLMcC0INFlgYaxcOob4DimKeiOM?=
 =?us-ascii?Q?xAWpmq3MVtx1iN66phCX14aPZU9yPeMb6DG2UjYlBSKRU881hyf2y2EKZxot?=
 =?us-ascii?Q?rIgC28Try6NTxjljMmY1pvWE2wZ2/0kXaMf+zZO3vv4q3I2GJgbI0OLPZmvf?=
 =?us-ascii?Q?o1HXOr2G+4eN/YpDp6a4sFuL0ZvIU3Zz5R1cryKuTs8VbJd8INaBa+08Q+or?=
 =?us-ascii?Q?O5CH0QxfBnFHUVEdMsaK/g6caRnpoiijzTdzohy0GxoQeE0DwK+70pxbrZCJ?=
 =?us-ascii?Q?lhR9KskVdxp4aq9YMgjmqp8lmzRsYDwX97FcYUoZSgCJmkXCfzHmTroGO/YM?=
 =?us-ascii?Q?0OKuomLIcrdvSZkIjN1/x5Rf9kXajHYfaw33RiQwzTnjn8K9nng7Q+YWC+m3?=
 =?us-ascii?Q?qOH6sRila0K6Yn7brtAxAP7HXdiMsCYKqxHO8oPfNZmythoYqbyIJ5j1c/0R?=
 =?us-ascii?Q?PujuETdlZY0E3zRWVP82aZPffEJ6UyrzppyLI9yp1gIdjCWosLa59SE/dqG/?=
 =?us-ascii?Q?lmvXbTic8so1RZZJC6jcCDt4J9GYkkWfHR6BR+emwiox0dU5j8z4ztCThdj3?=
 =?us-ascii?Q?RDqnyARykI6DmmWBSwXI3XimtsQaeWJLqKMVcIbc4ssesYO3xg5fDhZc34hQ?=
 =?us-ascii?Q?3l07zTK7llyvG/hrOmD2sHzsICCJEkOsRcI/xrRqD8n7zi1nnfBt+7qPTfJb?=
 =?us-ascii?Q?ICEvrcQfqhgKsP0B4GSJPqN8gX1FyR74tbqccTZg0Mq1dBKYhNnu0CWBaWoi?=
 =?us-ascii?Q?65CbQ2i7dVUK84ZNbQ2cKb52uWxhvtUWEwI3Ei3sOWIjgWh3CkdLzOtrTgfd?=
 =?us-ascii?Q?ohC8S2K+aCtRnCC88Qjgc2+wWcKe07BFq2NaI0WDcUBocuPgvN2GTFBymCog?=
 =?us-ascii?Q?7gBzCSed2DOVF4TcHbPjaNGkNKzgzHB2Jg49J6dCQwmfAl1/p4LN6kmvIUcf?=
 =?us-ascii?Q?SvVVEbTfN1Hw7NPT7afubhqlcdK5Lm3GUwOj7m4fF2QX3EUW8+c1jcXHTlWT?=
 =?us-ascii?Q?LqoyWnfw03kEs2XNl38qw/SoNvBHzz8Y/ksR2nayTSdFw5Zt+1BLA2hQvaGq?=
 =?us-ascii?Q?j2DtJU4WEtJZZEMjbwqvgPOhh1hh06jLMj25EHxLCIeG/djt5fFvVGLpI7cd?=
 =?us-ascii?Q?cbSq7S5X1Ey1bptHw+Tq2Y9H8H/6nBKjuLCbqE6TaR5mpjea0B9l5Inz++1h?=
 =?us-ascii?Q?w7PosQRiDcM9UAfCArIZs6lfi9395KQmMOhchWOEf1wfuDi2aWV/A+u2c3GQ?=
 =?us-ascii?Q?k8NppyZ3nPVU7k3xuqK0ouqBId9fVzhc8JpJsYDzJQsMg9F7ogidXX1eRhZy?=
 =?us-ascii?Q?ZTxS2KVpp+Fv5oVYl/Rmhiw1PWLiI+RQgwTriDl+MiSuMJtoQFW6nevedEFs?=
 =?us-ascii?Q?F5T5eDXFbTRqUjc2IbKcgt/q5lgBzKmW/PbzsdpiCsasMZujLjA5tQmPVzB1?=
 =?us-ascii?Q?Y7ZhBhUI3PU8M9gWjq6w+ydfbNTnEDRoIwvblWxPntv3vnK63thpig=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(19092799006)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rqOwwsHDevex29zxCjgOIJs7WmoU5axDAqGKkX3TRauGQmgHdVO9DCz+S/fm?=
 =?us-ascii?Q?5nuVxeDwO0rPr6VFWiY6Kt/At9YyfP+BdoJ7zIeXweXMQlCn/DgbO51rjKwZ?=
 =?us-ascii?Q?JXubTO+T33LiHFu43lyIVILQ8XscJmGnqhb9QqilOPg74y1Jnz/chCwZPrJq?=
 =?us-ascii?Q?mPaS3snParKLYSF2sI+CpMr+9AKoyYewBDZg/I15LlApPnRnerpztMmdHlXh?=
 =?us-ascii?Q?XXDKLb0y065oJSB84F/CdU5F/WUT4k97QYG5bB8eTI3PbG0+CBGyBaCTMsM9?=
 =?us-ascii?Q?qqvTdp3y+vLqB+Dlz6P1zJt2YSQCCMFimHmwDcg3vuVgi+pkKdh9dtftHVP4?=
 =?us-ascii?Q?HcTVjKVc8F9RMR2TViIgtfxOmB0MJT9+AkC1o8YH3az1Ageyv7W0t9Z4tsRX?=
 =?us-ascii?Q?svSujnuXRkC7HBTYhkPUS8ea7dY04peyvL/wqbd1NjC0OsZ5Aye5jPIeFtk9?=
 =?us-ascii?Q?tYkSUNxVKbIxYKlFNfqggg7f+4jYbtHlcyDAI5PKTc8wfg6hJ06XJtQCN18c?=
 =?us-ascii?Q?4QkLGlQfbWqHnTSfbb2Ch8MWssDaymWMZCqtSYiztsQiHw7nCayGuwt/Bp+X?=
 =?us-ascii?Q?6cJkyiW5YZc/BhmID/VHNQnrGj8oQEspVmlSb+58m3Maeg8qSsVoyplCdoG6?=
 =?us-ascii?Q?zw8rn0dTguRM4gJGog3CD80xT8BqhHzN+TXcLKdLRkRdfb/7jpvhc+46To96?=
 =?us-ascii?Q?G2tQdQiSZrp1PBOhXLkDfaFcF+4msOSGI+x7nhs9Pv4qPMzDTJumf5T5yD9g?=
 =?us-ascii?Q?0NR2EMe2yVQqozpmK5IRBAhIVEZZ4SiJgmxlV6zg5DrBJ2QNRd1roJzTMI2p?=
 =?us-ascii?Q?2SV3acMMq6eTUml2MZ2YSgvJpd/G0fynnAu5XPMRdqAdEB3ga3tXkxsaiivM?=
 =?us-ascii?Q?d4HFyoSBxMtDKtELF65XgbFlTsz8pLdnHaQ8NiFzV8fSTM3VEjotllN2j0iT?=
 =?us-ascii?Q?bdOVLKJMgOHiC92iHoE82rgDl9U0qqVJehNELGmnsEyH2FmOKQH3JY5GFY22?=
 =?us-ascii?Q?+1lVZqoYKbjiaX3tTj4/E7sAV06ckt5d5jW1VRm6FHt9ZGvhoQVwqBcwdHg2?=
 =?us-ascii?Q?yC4sXUJ6ONPN1toyvoW46M0WBZcc0VYJAKne4hzTE6wbYY22IEB/xgPIozr6?=
 =?us-ascii?Q?rWuNtH49Wt+XZe9a2Cfbf7z7aXeYHo2wquN2QKeCe7Q0Gm+VMFTemb5ieKcu?=
 =?us-ascii?Q?ShVOYLWgwckH4bH8jJx3bOZY5qZatEsRAXcv3lDvWnkBWS9ntxs8BIEt8IWC?=
 =?us-ascii?Q?yLCOihP6lj20mghF07f8P2lx2EwpP5wC0b65GuVDI7Qo8ca6G9wtPo+XnDUM?=
 =?us-ascii?Q?/DZiF5mpLIoUuCaHtuxyYV9FnfuFIU2BmCYtYsoWOpFNhxupPSSH71ddwYFG?=
 =?us-ascii?Q?4BTbUvgGT9C9mc6vwe4ORghfrwkgIdrhnFelN1MzKPtJoB5ly8X6Sw/RFuTx?=
 =?us-ascii?Q?5MJEML3Wa7WnOCFVYm4PL9AZY4kzxnMRzsV4FKcH/VF9NZIniONxQG1doxJo?=
 =?us-ascii?Q?iYnCmucCajIwMEDroxeuRjFB36Azvd9svecon46dTckbi1R3qNeGY1O3E7A2?=
 =?us-ascii?Q?f5COOBrk9931foAHqbtJadthPA5j/LGOan5scn1ALwkoahHmwhrXBl3rZelL?=
 =?us-ascii?Q?UQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 968ca221-7603-44ec-8fdf-08ddebc9e8f6
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 15:44:18.7252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cUuxbjJE48Hs/dvXoAi0qNDQLucP+XHd+T7G4cIB540Nj7kOq62qz7E7HqFpThA1kTc89Xjw8yeIzssY/KbOZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7635

The current procedure for power_off() and power_on() is the same as the
one used for major lane reconfiguration, aka halting. But one can
observe that a halted lane does not cause, for example, the CDR loop of
the link partner to lose lock on its RX stream.

Implement the procedure mentioned in the block guide for powering down
a lane, and then back on.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/phy/freescale/phy-fsl-lynx-28g.c | 78 ++++++++++++++++++------
 1 file changed, 60 insertions(+), 18 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-lynx-28g.c b/drivers/phy/freescale/phy-fsl-lynx-28g.c
index 08553ffe273f..5055ddba0363 100644
--- a/drivers/phy/freescale/phy-fsl-lynx-28g.c
+++ b/drivers/phy/freescale/phy-fsl-lynx-28g.c
@@ -73,9 +73,11 @@
 
 /* Lane a Tx Reset Control Register */
 #define LNaTRSTCTL(lane)			(0x800 + (lane) * 0x100 + 0x20)
-#define LNaTRSTCTL_HLT_REQ			BIT(27)
-#define LNaTRSTCTL_RST_DONE			BIT(30)
 #define LNaTRSTCTL_RST_REQ			BIT(31)
+#define LNaTRSTCTL_RST_DONE			BIT(30)
+#define LNaTRSTCTL_HLT_REQ			BIT(27)
+#define LNaTRSTCTL_STP_REQ			BIT(26)
+#define LNaTRSTCTL_DIS				BIT(24)
 
 /* Lane a Tx General Control Register */
 #define LNaTGCR0(lane)				(0x800 + (lane) * 0x100 + 0x24)
@@ -102,9 +104,11 @@
 
 /* Lane a Rx Reset Control Register */
 #define LNaRRSTCTL(lane)			(0x800 + (lane) * 0x100 + 0x40)
-#define LNaRRSTCTL_HLT_REQ			BIT(27)
-#define LNaRRSTCTL_RST_DONE			BIT(30)
 #define LNaRRSTCTL_RST_REQ			BIT(31)
+#define LNaRRSTCTL_RST_DONE			BIT(30)
+#define LNaRRSTCTL_HLT_REQ			BIT(27)
+#define LNaRRSTCTL_STP_REQ			BIT(26)
+#define LNaRRSTCTL_DIS				BIT(24)
 #define LNaRRSTCTL_CDR_LOCK			BIT(12)
 
 /* Lane a Rx General Control Register */
@@ -660,14 +664,12 @@ static void lynx_28g_lane_set_pll(struct lynx_28g_lane *lane,
 	}
 }
 
-static int lynx_28g_power_off(struct phy *phy)
+/* Halting puts the lane in a mode in which it can be reconfigured */
+static void lynx_28g_lane_halt(struct phy *phy)
 {
 	struct lynx_28g_lane *lane = phy_get_drvdata(phy);
 	u32 trstctl, rrstctl;
 
-	if (!lane->powered_up)
-		return 0;
-
 	/* Issue a halt request */
 	lynx_28g_lane_rmw(lane, LNaTRSTCTL, LNaTRSTCTL_HLT_REQ,
 			  LNaTRSTCTL_HLT_REQ);
@@ -680,20 +682,13 @@ static int lynx_28g_power_off(struct phy *phy)
 		rrstctl = lynx_28g_lane_read(lane, LNaRRSTCTL);
 	} while ((trstctl & LNaTRSTCTL_HLT_REQ) ||
 		 (rrstctl & LNaRRSTCTL_HLT_REQ));
-
-	lane->powered_up = false;
-
-	return 0;
 }
 
-static int lynx_28g_power_on(struct phy *phy)
+static void lynx_28g_lane_reset(struct phy *phy)
 {
 	struct lynx_28g_lane *lane = phy_get_drvdata(phy);
 	u32 trstctl, rrstctl;
 
-	if (lane->powered_up)
-		return 0;
-
 	/* Issue a reset request on the lane */
 	lynx_28g_lane_rmw(lane, LNaTRSTCTL, LNaTRSTCTL_RST_REQ,
 			  LNaTRSTCTL_RST_REQ);
@@ -706,6 +701,52 @@ static int lynx_28g_power_on(struct phy *phy)
 		rrstctl = lynx_28g_lane_read(lane, LNaRRSTCTL);
 	} while (!(trstctl & LNaTRSTCTL_RST_DONE) ||
 		 !(rrstctl & LNaRRSTCTL_RST_DONE));
+}
+
+static int lynx_28g_power_off(struct phy *phy)
+{
+	struct lynx_28g_lane *lane = phy_get_drvdata(phy);
+	u32 trstctl, rrstctl;
+
+	if (!lane->powered_up)
+		return 0;
+
+	/* Issue a stop request */
+	lynx_28g_lane_rmw(lane, LNaTRSTCTL, LNaTRSTCTL_STP_REQ,
+			  LNaTRSTCTL_STP_REQ);
+	lynx_28g_lane_rmw(lane, LNaRRSTCTL, LNaRRSTCTL_STP_REQ,
+			  LNaRRSTCTL_STP_REQ);
+
+	/* Wait until the stop process is complete */
+	do {
+		trstctl = lynx_28g_lane_read(lane, LNaTRSTCTL);
+		rrstctl = lynx_28g_lane_read(lane, LNaRRSTCTL);
+	} while ((trstctl & LNaTRSTCTL_STP_REQ) ||
+		 (rrstctl & LNaRRSTCTL_STP_REQ));
+
+	/* Power down the RX and TX portions of the lane */
+	lynx_28g_lane_rmw(lane, LNaRRSTCTL, LNaRRSTCTL_DIS,
+			  LNaRRSTCTL_DIS);
+	lynx_28g_lane_rmw(lane, LNaTRSTCTL, LNaTRSTCTL_DIS,
+			  LNaTRSTCTL_DIS);
+
+	lane->powered_up = false;
+
+	return 0;
+}
+
+static int lynx_28g_power_on(struct phy *phy)
+{
+	struct lynx_28g_lane *lane = phy_get_drvdata(phy);
+
+	if (lane->powered_up)
+		return 0;
+
+	/* Power up the RX and TX portions of the lane */
+	lynx_28g_lane_rmw(lane, LNaRRSTCTL, 0, LNaRRSTCTL_DIS);
+	lynx_28g_lane_rmw(lane, LNaTRSTCTL, 0, LNaTRSTCTL_DIS);
+
+	lynx_28g_lane_reset(phy);
 
 	lane->powered_up = true;
 
@@ -1035,7 +1076,7 @@ static int lynx_28g_set_mode(struct phy *phy, enum phy_mode mode, int submode)
 	 * the reconfiguration is being done.
 	 */
 	if (powered_up)
-		lynx_28g_power_off(phy);
+		lynx_28g_lane_halt(phy);
 
 	err = lynx_28g_lane_disable_pcvt(lane, lane->mode);
 	if (err)
@@ -1048,8 +1089,9 @@ static int lynx_28g_set_mode(struct phy *phy, enum phy_mode mode, int submode)
 	lane->mode = lane_mode;
 
 out:
+	/* Reset the lane if necessary */
 	if (powered_up)
-		lynx_28g_power_on(phy);
+		lynx_28g_lane_reset(phy);
 
 	return err;
 }
-- 
2.34.1


