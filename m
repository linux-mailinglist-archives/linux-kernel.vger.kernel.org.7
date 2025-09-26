Return-Path: <linux-kernel+bounces-834512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F48BA4D70
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 20:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D28A7A8555
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 18:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598993148B8;
	Fri, 26 Sep 2025 18:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Wd+EwCLq"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013068.outbound.protection.outlook.com [40.107.162.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4859830C343
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 18:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758909949; cv=fail; b=bYcbKaHU7m29851MgQFOL8vPG9u+snaAJztn21J5os8JoYugpVxpn+B2zA6hFiwi6AEeJnaCAbKg6bI/wqOlonZ8NN4ASEljbhxvcD/LieDphG/ELaWNcvMqBxP6zIhT2B1rgrOYzSC9wB5sNU4cBCdG8sskD1MnWX8XGBNgdI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758909949; c=relaxed/simple;
	bh=3KCX/hhqabmFGgUbn1JNTXx1gLGiOFqwr6KPfpfw9gM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lJawXu4u6bsxseQTsa3WYX1cCS7+Q0LQelPgqP+ZmK9vrCfff0TAWiSfVso8JkJ5hI5OvjNBvISq3JowNHvaOUmkV+uBYiOvsNIzqYAqJ1CtyZaBEPiAoyYtd7AwgPmcWrUVPtME3zgq+GFg/vRMP2t8WHhQ6VPjDXSeSH4Zx9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Wd+EwCLq; arc=fail smtp.client-ip=40.107.162.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iyjSU68R6NZS39x4x/6ot4XrBXMm0e4iH7EIK06b7XEucgpt12zw0o0zuNV1+5AhRxOz+hSIkjjq1tcnUag2vOFpenRwFt1ma7UQCFnBJ1mAM+lYZywiV3g1ZswrHb/99UCmWjq72Pr5tGCZ85qmbqPeYxYhVKkoKCy0pLB8qVCpMmi2i2EID/8BLkKFlyPzNMnGXz6W0IKsSXEIi/CsMGRGFnKgbUm9nZXaMW46T9C1Ctf2qSIhHNXy2C6SwJONXD+iHayiyJCGF6QhEgyDsO/JvNlg7/LDGl9UwPzMq/QeNgnXNp44+GsBEA6TfiXs70h6VRImSDbr8njXQ+xarw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9B5kwhAs0qOX+LCEsx3+wD4z097vkAIvwNfBxwLRGo0=;
 b=cYf4ETvwzT6F3Kc+hCgIZK8y/7fEuYgSIFXJ23cmNvp3AmfOiDn9cusPBpzBvSEHUsshMnU/2urVF93UMzVB+/jwc3xTvvzRtNk4ymqRyd6qbJ3nMqVQbsL71vW30rzoPcIQCuTl+SJxskAOHlx1MGUdpB+OomlLiI6AH9ulBVr/nUgG0Wp5xw7JQQ+FqB2/S8KCTOCg+RNxALG6KJGPkHlNpfYM2L1xGQFIn7Q5j42w8d2ZFd7E0AtcC+56H4wvUNt3i8m11qWYGlOcvsm2yjPrXtwN/mDCMIPCx4XThJX0zqu/B7UqaQJZk5p1I9drvHH+OAI8V+0RfH2q85UBzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9B5kwhAs0qOX+LCEsx3+wD4z097vkAIvwNfBxwLRGo0=;
 b=Wd+EwCLqWJAQ45K517tyrlcrc939ayozTjIDs8UpSn02BCUGgI8Day76KTH1/9XXXayoF7b6bqqnPrVOZG9TZ7KJeXIpUfXV08FuSWxTv/DPJssfyry/jOyk9FiOkXRHQU4Gu8XdTj2DR0M7sizXEkuvxgPCm3hdH1VY+z8LS7lAtQhB8ZL3itsN4GtXt+EFyOPO1h47Hyy2TZL78DvNGcrPR/DNPcLGBrzyhYIvUNKpLQ7Q9nu6n6r1/cHfJ3xWJLINvf+6gzRjJoCOoBnwa+DKUNjW8ADpOloZWD1VIcrrd1mfDzPkYnmauCAV8j2O/84sAizbm1jyNVZPrTxMrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PA4PR04MB7823.eurprd04.prod.outlook.com (2603:10a6:102:c1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.14; Fri, 26 Sep
 2025 18:05:35 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9160.010; Fri, 26 Sep 2025
 18:05:35 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Josua Mayer <josua@solid-run.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 phy 16/17] phy: lynx-28g: truly power the lanes up or down
Date: Fri, 26 Sep 2025 21:05:04 +0300
Message-Id: <20250926180505.760089-17-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250926180505.760089-1-vladimir.oltean@nxp.com>
References: <20250926180505.760089-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P250CA0008.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5df::9) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PA4PR04MB7823:EE_
X-MS-Office365-Filtering-Correlation-Id: a1dce305-fe76-422b-c963-08ddfd274a60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qzWl9jx51sKq/mCtIVdCbumSrjkAV+jNvmHMkP0KPOm+J02Q58K/YrSHR+nC?=
 =?us-ascii?Q?qAArSMbBDKrOfz78j1lvmD/hAn274GIC9qr2xsxmizyeGpDLwe9B523hp3On?=
 =?us-ascii?Q?Y09rNy58h8Fu2s1fCsoLtbaCFWQJYISwB5ozPK++MHrXa6NTl1o/7sT4kstJ?=
 =?us-ascii?Q?uuvfq7O4YoDvL8vegKtdMDfP/yMf7w/yexma+S1hL/knUtuX0Aip1XP3FuGE?=
 =?us-ascii?Q?+t3BDZaGROqvqjDW1i+4pu0/Rm0Vg5kufE3EgA0OeqbbRGvxddV7jRIvxcrM?=
 =?us-ascii?Q?hlu7PRNYPyjD/7gMNgXuu3uSPIK/swYFicFhjMs0R5a2VMp1w2VJF3G/wwlX?=
 =?us-ascii?Q?EXkGs+kr4xTsIk8A80HSC4BL5AiG3uf+JAAkeTFKvDiVXCnhVgiByOL42Kle?=
 =?us-ascii?Q?IEgkFmyryZrvBh3wJ97NAgVaLgC/fLA8oL698bcmEAFEYnuAhSdaLu+6QRAO?=
 =?us-ascii?Q?gv3xcWaW4UkyGTB7aorzjjFDq+PcrLoXJ0YRKHvpzwbDhlBjJdUxf7EnRmpt?=
 =?us-ascii?Q?Bv/0jE7D81EJVDRG3Mqc8HKsLbIa3qzGd7r4XzCPsjvJkN4ljSuQ5JVmW+/k?=
 =?us-ascii?Q?/U9IaRR2tWLZTjHVzSuae9t+I0UryVqBSygsD/yO06D1F9/igOXxADXHP0tc?=
 =?us-ascii?Q?yFj9AXer9sBT03oY1yIwctmM/tcG0GbJOaPdy83TvYh1UoCJE3O4WuVxPILt?=
 =?us-ascii?Q?3X1wKPf2R0l9X2c3pc3dt4CzzwkBRQ3CpgDO1AfDRTXQEUZ2xMNGlO4KK7s8?=
 =?us-ascii?Q?dNNrdHg3WXPvKEyO12HacX3Xfrwt0Ew22p8vOm4ir4mhmIkU0hMuRpwAYTB0?=
 =?us-ascii?Q?X6Hj9DCErGRD5rGSVCSS/mcPeOoXURPmCIdVmobFSBXsayEwZ3YIIV2f9Qk/?=
 =?us-ascii?Q?BBZc9wvWaFc6yT9wKpXFRMpWQoTjaNu8zXES5/ugwrdyIaxgg9Pz3416d2n1?=
 =?us-ascii?Q?tciilfq2rqTlUeuoO9Q3IG820JCDDhC8FHZlqMN/j+XNISKWSnzX51vWrB40?=
 =?us-ascii?Q?wIy0KkZRy2d6ZgoNJXhguy6S3K4e8VB7Fxld7LqwxaOitt9tuAj+ViYTu9V1?=
 =?us-ascii?Q?qmwAVj0vicjERHRjkPs95sY8RRzohZ6TXDjUp1CjEZbQ1PTqxD14OyX4BzGP?=
 =?us-ascii?Q?N2BEgoHOk+x4hAi0jXEoGsLmEyQ9hj+o+E0nQ+/UcNwKo/dluWyxB1+a6eMK?=
 =?us-ascii?Q?DdaEnpzDeE4qpfTg5/Ey32f8qkNZMn71XLZl/T71Fn1gPes5n7B/PYXxZQi0?=
 =?us-ascii?Q?1BJGtESGiFl6JXACMIl7uxI87EgvBIxdBUhJS7HuR5Wtb2pEIzgo/GtxywBN?=
 =?us-ascii?Q?sJP/5jXmFNQPtAEVgawlP82bU+np+egK1v0pjHaa4BwGwe1cEVlYxTX9Mx52?=
 =?us-ascii?Q?rA6l/Ad/S5G4x+K8VrCRGuv5E5jRLz9HZlLHJXpvTH5juyOeSlfgfwbgy34c?=
 =?us-ascii?Q?A29XN6p67jyjRRZbCHYkFC6LBAVjyjwjfhQ/wcC4/33yTKQ/CazpYWD3edoH?=
 =?us-ascii?Q?w8CbVQcQzYwai0VSm9Cw/PKLF/HysPVsD+E1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gczhCc7rfmUcdLyC0b9/QlNLf9Yz+dyQPkhzCIcN2ujL6TAF1g9sHMgtdV/b?=
 =?us-ascii?Q?mr7LPdCaHH1uOoY1VxIlC2aTtzmGWk2FLspyB+5RGIphHeSn6jvKi+o8Kbtm?=
 =?us-ascii?Q?uxA9/tmuqhwqQmQIu1Ur3hBfmohrvNulD6N1ztvMLJ8eZ4engE50B/LvjLeU?=
 =?us-ascii?Q?y72qKAeIaJ6V0/2w8sI9xszb4ZnjhGQ+dB5ldD9awez9K+qtEjE4EQRAHYVt?=
 =?us-ascii?Q?B+3FiEQ9ddBmABKXWWOyprBeeOLXkgyM5GfxkVCoGbpwghrTchaHOGQD9IpY?=
 =?us-ascii?Q?ZEz+ST0h3wRXhSoGGmqaaA/YS3ZiIBnrh4oFgGxLtRjSlYkqjaZilCo8TIEp?=
 =?us-ascii?Q?Mloaw4wlB5RqHgVPwbRjSAtBKNd6ZdViyt3RS0dMhCgixJ9O3lupa9Cy4Ek1?=
 =?us-ascii?Q?XTyT5U6eLu8HNHHISG5yQlHwKdgZqJxjyOqwS9KaOCHSJyi/DyH8Yh/t3vPA?=
 =?us-ascii?Q?OVDKVQDnwJTl6wU40fXopo8lRQJNmpAU2q18csRfArACZpZPOpsvLAaXop0o?=
 =?us-ascii?Q?XdYkOU9ybi/f6JTrPjLbwvztuA7MkkI1UfgzYIjJ/TLGsN1fz7XFMpVhRYV9?=
 =?us-ascii?Q?zYQQqy2EUlZ41YmrcuO6s5mvtCP0wYg5TEqCfsXr+H9JgG2Sd+SSMGghTm9P?=
 =?us-ascii?Q?g7up0Hutyby2fjVao5tr2mF1yNmUY3+MUSteZTnfcQVc6X3NGyWWB7+qE/Na?=
 =?us-ascii?Q?sBE3HTUfGSBc1zGEPkWRx6/u/L+Z9my3s5Pd7dcmb32wbzxBfinReHGo8Q6N?=
 =?us-ascii?Q?iOKz3X0Oloptl2AfSghMprcLDrWsYlut3ECt/fV//Rm60warS9J3jg9w0bDv?=
 =?us-ascii?Q?MvCvrNxSQp2mlybyHbdrWozDTSO3N/fSUPkqdU7OJ73d/xq2Dk0BnEuFUfIG?=
 =?us-ascii?Q?d8/GT7LdMn5hCeBEnpVLHVMja5zhJl+wDIjSOBO31zlZIPXjtvhU2mz+vjTk?=
 =?us-ascii?Q?GJeKQRFnXO2h5ghm9HFZNu/yOtHmLNx1z9ab7XhQA3A8QjJ3GXT/X1NDzmwR?=
 =?us-ascii?Q?OXeD9e7DwfMCjbMpS4sie7FR9ckR9/eGVCVU7TtZU4gFfLipmJocvmVRKB4k?=
 =?us-ascii?Q?wTnDWVJqnor8VIPVPtDSbnMT2yHvMCrae9w2WjL27UWfItByMh4OJinElGqO?=
 =?us-ascii?Q?YpYmlSvDi/gqdwHffYstI6HdD9TBHNyERq2A08alp9NyUtQPJm+p+HOGRePY?=
 =?us-ascii?Q?Xa23hPrM7IL6HO7MJ8JqqMlUN3EYgle9CEC2URbBMU5XKuP26huWJQmgb+dY?=
 =?us-ascii?Q?s28lhQlFG7t69/cbQ7FlfctI2M5ahFF83DfEIOYWF/zshgAlK0nMbkQ3ZLNe?=
 =?us-ascii?Q?iIYDFeXwnhZxbRPCz+RNhgceSeZFlBuPa5bn3GWR26BKVecPRpVKLgIYWahY?=
 =?us-ascii?Q?Cr8a5cv42oVYKX/f3VrwSvRR/uWh2z7GSuMnm/HDAyJkd89XBTqQ5hrr7tFR?=
 =?us-ascii?Q?JqUeJmzFwC8WyWfE7hdRsrc4sGPgHDz9F/EAtMaQ1cJ/4XKDV6wLLwoB6TIW?=
 =?us-ascii?Q?LBpkBq9i+v7SJQP/XDZlODR5d6ynhZE/nZsNDsq7rbRdakPgz0kqBqkTnCvg?=
 =?us-ascii?Q?vjGGal2fwHwB5DieCLywY7KJI6OGTfd0WRLul4pKlsKlNAkVxBRaJqfTbJ+R?=
 =?us-ascii?Q?OQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1dce305-fe76-422b-c963-08ddfd274a60
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 18:05:35.1379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DAtfmw9PERq3/eHXpF/9K342SRNzVw5bjRS+XyFtWhwYLPvBGS+WlEKSg7QcG/F0wJkOT9ORg2OtEvcSXtlh3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7823

The current procedure for power_off() and power_on() is the same as the
one used for major lane reconfiguration, aka halting.

But one would expect that a powered off lane causes the CDR (clock and
data recovery) loop of the link partner to lose lock onto its RX stream
(which suggests there are no longer any bit transitions => the channel
is inactive). However, this does not take place (the CDR lock is still
there), so a halted lane is still active.

Implement the procedure mentioned in the block guide for powering down
a lane, and then back on.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v2->v3: reimplement lynx_28g_power_off() using read_poll_timeout()
v1->v2: slight commit message reword

 drivers/phy/freescale/phy-fsl-lynx-28g.c | 99 ++++++++++++++++++++----
 1 file changed, 83 insertions(+), 16 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-lynx-28g.c b/drivers/phy/freescale/phy-fsl-lynx-28g.c
index 4e3ff7ef47e4..8e38acd30224 100644
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
@@ -260,6 +264,9 @@
 #define LYNX_28G_LANE_RESET_SLEEP_US		100
 #define LYNX_28G_LANE_RESET_TIMEOUT_US		1000000
 
+#define LYNX_28G_LANE_STOP_SLEEP_US		100
+#define LYNX_28G_LANE_STOP_TIMEOUT_US		1000000
+
 enum lynx_28g_eq_type {
 	EQ_TYPE_NO_EQ = 0,
 	EQ_TYPE_2TAP = 1,
@@ -687,6 +694,15 @@ static bool lynx_28g_lane_halt_done(struct lynx_28g_lane *lane)
 	       !(rrstctl & LNaRRSTCTL_HLT_REQ);
 }
 
+static bool lynx_28g_lane_stop_done(struct lynx_28g_lane *lane)
+{
+	u32 trstctl = lynx_28g_lane_read(lane, LNaTRSTCTL);
+	u32 rrstctl = lynx_28g_lane_read(lane, LNaRRSTCTL);
+
+	return !(trstctl & LNaTRSTCTL_STP_REQ) &&
+	       !(rrstctl & LNaRRSTCTL_STP_REQ);
+}
+
 static bool lynx_28g_lane_reset_done(struct lynx_28g_lane *lane)
 {
 	u32 trstctl = lynx_28g_lane_read(lane, LNaTRSTCTL);
@@ -696,15 +712,13 @@ static bool lynx_28g_lane_reset_done(struct lynx_28g_lane *lane)
 	       (rrstctl & LNaRRSTCTL_RST_DONE);
 }
 
-static int lynx_28g_power_off(struct phy *phy)
+/* Halting puts the lane in a mode in which it can be reconfigured */
+static int lynx_28g_lane_halt(struct phy *phy)
 {
 	struct lynx_28g_lane *lane = phy_get_drvdata(phy);
 	bool done;
 	int err;
 
-	if (!lane->powered_up)
-		return 0;
-
 	/* Issue a halt request */
 	lynx_28g_lane_rmw(lane, LNaTRSTCTL, LNaTRSTCTL_HLT_REQ,
 			  LNaTRSTCTL_HLT_REQ);
@@ -727,15 +741,12 @@ static int lynx_28g_power_off(struct phy *phy)
 	return 0;
 }
 
-static int lynx_28g_power_on(struct phy *phy)
+static int lynx_28g_lane_reset(struct phy *phy)
 {
 	struct lynx_28g_lane *lane = phy_get_drvdata(phy);
 	bool done;
 	int err;
 
-	if (lane->powered_up)
-		return 0;
-
 	/* Issue a reset request on the lane */
 	lynx_28g_lane_rmw(lane, LNaTRSTCTL, LNaTRSTCTL_RST_REQ,
 			  LNaTRSTCTL_RST_REQ);
@@ -750,9 +761,64 @@ static int lynx_28g_power_on(struct phy *phy)
 	if (err) {
 		dev_err(&phy->dev, "Lane %c reset failed: %pe\n",
 			'A' + lane->id, ERR_PTR(err));
+	}
+
+	return err;
+}
+
+static int lynx_28g_power_off(struct phy *phy)
+{
+	struct lynx_28g_lane *lane = phy_get_drvdata(phy);
+	bool done;
+	int err;
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
+	err = read_poll_timeout(lynx_28g_lane_stop_done, done, done,
+				LYNX_28G_LANE_STOP_SLEEP_US,
+				LYNX_28G_LANE_STOP_TIMEOUT_US,
+				false, lane);
+	if (err) {
+		dev_err(&phy->dev, "Lane %c stop failed: %pe\n",
+			'A' + lane->id, ERR_PTR(err));
 		return err;
 	}
 
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
+	int err;
+
+	if (lane->powered_up)
+		return 0;
+
+	/* Power up the RX and TX portions of the lane */
+	lynx_28g_lane_rmw(lane, LNaRRSTCTL, 0, LNaRRSTCTL_DIS);
+	lynx_28g_lane_rmw(lane, LNaTRSTCTL, 0, LNaTRSTCTL_DIS);
+
+	err = lynx_28g_lane_reset(phy);
+	if (err)
+		return err;
+
 	lane->powered_up = true;
 
 	return 0;
@@ -1166,7 +1232,7 @@ static int lynx_28g_set_mode(struct phy *phy, enum phy_mode mode, int submode)
 	 * the reconfiguration is being done.
 	 */
 	if (powered_up) {
-		err = lynx_28g_power_off(phy);
+		err = lynx_28g_lane_halt(phy);
 		if (err)
 			return err;
 	}
@@ -1182,12 +1248,13 @@ static int lynx_28g_set_mode(struct phy *phy, enum phy_mode mode, int submode)
 	lane->mode = lane_mode;
 
 out:
+	/* Reset the lane if necessary */
 	if (powered_up) {
-		int err2 = lynx_28g_power_on(phy);
+		int err2 = lynx_28g_lane_reset(phy);
 		/*
 		 * Don't overwrite a failed protocol converter disable error
-		 * code with a successful lane power on error code, but
-		 * propagate a failed lane power on error.
+		 * code with a successful lane reset error code, but propagate
+		 * a failed lane reset error.
 		 */
 		if (!err)
 			err = err2;
-- 
2.34.1


