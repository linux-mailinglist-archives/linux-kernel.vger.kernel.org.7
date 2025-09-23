Return-Path: <linux-kernel+bounces-829588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D652B9764C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 21:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8F257B3EAA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDEFE30B51C;
	Tue, 23 Sep 2025 19:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BVkF9J+/"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013012.outbound.protection.outlook.com [52.101.83.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD48309EEC
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 19:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758656730; cv=fail; b=dufh2O0JAQ1VcLeDH3rKKErhqaiP7IAACFpbK1fXyAlq7YeSonfANF99jyQsdVwQ7EbUU5ZbGR341NAx67g9WJ9MeToEC+FI/gCwr6R6yAlIChpEa+kelcSKX29x6nb5HQ4E03VfK2q1oPlOJm61sHWOhueJlDzmWIiQIrxVpWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758656730; c=relaxed/simple;
	bh=Ql/0OT/ADd89fINdp/AQxyHzGUWHgQtyT1w5VmHRrHc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YvVWoA1PxDx7tjezgwpFhCAt9nINxc4RLJNyFj0/RmSZwsWhTGFWBK2Uug337Fs8j3ycrfvGLmtS1vMbSBfk11gZvOvrrT7SWhp92xDktAcT1DQU717KoiJRYfu6RNOQqx/Q6dZ9oQ0XogNYf2dzQoVnEoTkJePchrRpencSIvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BVkF9J+/; arc=fail smtp.client-ip=52.101.83.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tlv7FSO/Nr3wm5P9U7vLiUVpc1mzmo7ws0N6Y3d3lQQK23BJd7Wg2SCA9vbBGkVrboF4KTutHwV8zh/cmd1t6TNgGUNsB4WH3blFO21Jfgac1I12stE9o2ev6vBwIMid1Ea+Is+/G31o34SakB1rpaH3egcYgE5YrgtiWkjOI98PoC3YdSKvUUXk0vQ1SzsqVxx11xQ80uPAZZaxhTRUy7kiQcq/3K/aN0MNgAifck2Brr58+R2vUHgUGlPp2Sl99XKDWu6qZsNLoOuGRZrxVyh3oMLan/hm/+LS2Aph320c1P29hDHHaIe/KISDRiTAGUNfdQ4mPfL9V2q9v2I2JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nai6gO08h07UKOPEmKd72CRrRDdMEvIYgs89hsAXpbQ=;
 b=kxbTgcTpRZMsTfCwiX3KsphAGtDat/9n4XMD1nDiZ+P8fypEgz2tLqCs74lglIBQkpEP6HQQObfuVDKBRCt2cESvSRMVVSRW+tnGpcNLfqMvMoA8LCTmmvIgjgilL/R75VIBtlQQY/pI/v8w00RgbQKExDgzhoZkMTyN609AocQnbTf+P8cPzwC/lSsrZds0oIb/AKPpWecXd07lDPDNfu/mk2AgH5cfQZCwknSHksecGEcrmstHJIHYu5Vre71LkdZnnyfGOjTYmnhVxOXTKS76YgohjOOVrgwr1rkXI8sZ4xKHjquLgCfO/c4/gUfRQORf7Pv/L9PsJYS8faSm8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nai6gO08h07UKOPEmKd72CRrRDdMEvIYgs89hsAXpbQ=;
 b=BVkF9J+/bte2aWXuYiPFDfzxevh+K0i9icolcYhZ4EZSyRxorVRQP9Bsx4crmhL/APzL0B2rtPj4AIVnQVRjU1LbZFnsaTflZ3nx5tSKHuA7nzVmadCA35GLOGm1MJbTdFSPPVsMFLTpDfbTec5Ck6SNPuNKEuOtQ7Ryp9UUWo3vuccPETFuZX4+5lx33cgtXjzsexKM87v80VtXmImgMeZgQ1Ds8c875zjZvznDpiO1e67wn4mb6TDGRMUQd/qCgL1V5nBbSZ4dqh7BbK1/PjxGz3gbKxvpBlMkHHwz4luioQIKUk8HpzwE+TWH3Ihn1HzAJ13/ImENkJYR6pcGYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DBAPR04MB7352.eurprd04.prod.outlook.com (2603:10a6:10:1a8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.8; Tue, 23 Sep
 2025 19:45:16 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 19:45:16 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Josua Mayer <josua@solid-run.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 phy 11/16] phy: lynx-28g: improve lynx_28g_probe() sequence
Date: Tue, 23 Sep 2025 22:44:40 +0300
Message-Id: <20250923194445.454442-12-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250923194445.454442-1-vladimir.oltean@nxp.com>
References: <20250923194445.454442-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P189CA0028.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::33) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DBAPR04MB7352:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eb10b7b-c3aa-4845-c72b-08ddfad9b815
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N8REwlj9SVy2zf+OSwO4b/iELywNPoFF915ozvJBtX1j3KN8b30PyhBEuhBb?=
 =?us-ascii?Q?Ym8vXIvJ/zLwwYtV1RhdZ76r4F6jhRemOGTbyqOHirq5WcUocFUI7wgDnggd?=
 =?us-ascii?Q?8wYh1i1ALDyUQ9dd/yUXgC4N7iZNF49V3PX0XUct3bXb3kaz2rbU4/DsajVY?=
 =?us-ascii?Q?1C2a37Q+Qa257DjtoODeAp8GPZKY3JPj6NsoFTn09HJWLweGUoH/jQvdhSbl?=
 =?us-ascii?Q?K+XuvMw5GPWKgSQtkV/ZR3NNrqWYGXteBBn2Dr51fe1SB9cCI9iVSMLe32ik?=
 =?us-ascii?Q?3u4i6JcZECd0zlHtJIyt5VNYSU2zKqOLSd9aDlYxrXGqqGUTmu/oIv4SBCN4?=
 =?us-ascii?Q?rovjKV/bqKmRKQKR5PxfwghEb5G4oi/0u3OtJey/WMZdiJ1nA0JTS/wGf7rM?=
 =?us-ascii?Q?qlILDwlDnfyOBp+XH9UZD50uLaqb3d7vdqR2os+kAmyTZH3VcFPY2dXHLu+6?=
 =?us-ascii?Q?SBMVbZbShyDG9cN28rZDj6UjFRvEmw3WE8s3vVWkHDEzoAde+v3MGrFBzTLn?=
 =?us-ascii?Q?Y0zO4isk0ygJsFZ47EDTqyugkqCPAWl1u8P1uyRO3c5qpVpttgNvaYwiyh4s?=
 =?us-ascii?Q?At27JYzzDgzelCgCFQTo/Y/29tfMTHM+kD/8CqFIVgyTGpQ/s6HQPPY1e+UQ?=
 =?us-ascii?Q?qfenID3MRMKwe3h0h/PLwvbC/wfGR+wMpWfvnh002lc/1NdtYAMCiv27rdi+?=
 =?us-ascii?Q?9EP/GsPhZpLzmVC3wCtrC+jl+PkKv5y7GZcHiaUtVsOgG22n7CYp8ShbhmFo?=
 =?us-ascii?Q?V3uvqz9IreVfw+Cg5IqxTtEE3thyiccgSjgDNqvQEuZ841w5UruClIT7Yosw?=
 =?us-ascii?Q?5BTu6N3EXQNQ4GqlF5SqK62FpfERFgl8ZKpEb6JxuOHsz4p2slVGMcvvjfK2?=
 =?us-ascii?Q?miYpuOC0srPr9zFnrn0kPElVcZNxvVcPrQDK7W88AVqeJ/GrKuy3L0M2mrCE?=
 =?us-ascii?Q?vJNvVd8+nHa2EHPXJckvvG/vbTHIjBTqG9LZNIdWZbSGv/x/DWyLhltoZncj?=
 =?us-ascii?Q?/WZBPC5maEfj6DfTzlJ0WNPz6xTfZrX/PCPEKlvUGaCB95lkr8ix/XAJU9sD?=
 =?us-ascii?Q?W6uKVqIPXvSSxvtY+erhgXvT20mWSHIx1HFX8YOwQvztSLDlqFXUOEsupllQ?=
 =?us-ascii?Q?2plgqzNqBRpxaRA03c7JCfdazpvemDLkvwN5AFOQOWuI4KZcYZ/Ie6fvD8tj?=
 =?us-ascii?Q?/J1Zd7vEOkF0PDD62e6bsv2yDwtClYD7Fp2icIkxXyIFOE1Vh/BYRIHj716H?=
 =?us-ascii?Q?ePo55ToOAhHEggaHLHtgWgTa9b8y0jBld0G853IurlQc9ndMHOnq0f1JIgRQ?=
 =?us-ascii?Q?HxC0e9jY5OfUpg1L8m4dDwxKeMfyMi34ULHt/A6467DBRO8oBD7py2HhIuPU?=
 =?us-ascii?Q?P4MenovYOK83yY5gX3RuwC0ngWwg+YPOJxscweKEX2hDVhqW5/4rEta8XXWR?=
 =?us-ascii?Q?UNX/kqSyg4ljwlt/kZjBb+xOOtrFnY9GV3g7MzEiH/4ELEr2vREZLQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SPF4UaxSk8jdFbISwjOa1tFMHFaVk+jEorIVQc6/4l5J/d1eCfI2xyeLaIx+?=
 =?us-ascii?Q?5lQCI/UU5JBfQeJiGk41cwAilpYl3A5qbmENfm4rwQeCNj9bBMa3lj3gOtI2?=
 =?us-ascii?Q?wp1/80BXSWiEx7RRcy3/b8GbQkRgDNI5Em+IjTN2FjrNG1L1WkgVvIdgJm6P?=
 =?us-ascii?Q?GZxuIJVWtRXB+6PHZnhDvib3TCGZEktgbx61qxyYB1uGWLDcoYWDlN1JvIqR?=
 =?us-ascii?Q?1EC+F171v42/Zm07//JO99DnKFJeBWO4L4L6aOCDPR5rP6jzfo3nN9M1fBfj?=
 =?us-ascii?Q?qshE1+U6P/MsluggMaZlKwZFqo6fzgMTVyeoSHRr+ZO8KDJXLU8om/akBFRh?=
 =?us-ascii?Q?puuerTvH4hu4Yq3sM8eyHw2IP45J750/7txacR91Ix8yn4OFGzEaBHrY9on9?=
 =?us-ascii?Q?0g0eSa+8DU118UVnz6ewUlUte1TZ/YGYFLkHiIWLXMKKU1jVnMd7353nrbfo?=
 =?us-ascii?Q?mL6dHThGxdZACL1JC3guM63tW/HbGQnr6x3LAmgCVhLOF3DRnvnAjOhK/J5P?=
 =?us-ascii?Q?CLrd0d4mh/1muEpARdnpKVy92b/zDINYpleozzkwzaU4N93OHRM1MrHfU9R5?=
 =?us-ascii?Q?SkY3LUL2vNS6wuLeRd0kSQLzE5BHD1jXby4xGkwXKlUhXWRkiX2QDMvlJ4iN?=
 =?us-ascii?Q?gv7QSRS/DcB/rWj7BLxzJIjUW2uiCAZuVtPn+u8wGR339R5qiAF5BtXmbsHv?=
 =?us-ascii?Q?gnN65gGXCoBW2Mabn21H3o5Pw0ljPqh49CJzCvh3WymvF5M+j7i7vi0wLM/c?=
 =?us-ascii?Q?DqAwv5HJtL9J6yc1doyiSLtwOCZrisd42dHzPECHxwu+IOVA9DJs4rcSlga/?=
 =?us-ascii?Q?mfYRu6Yk1zYVT8tTq5pYUvuhk1pyu7OUZzNaBrxanaMAzkWvSAWPqv4LOzxq?=
 =?us-ascii?Q?U93ZDxRYYGt3mjw1y7u8vqFjXryEvMbTYw2uVDSxT5mniGsa7vErXXkDnf1R?=
 =?us-ascii?Q?dGFhtTsv82nlwmKc5hhD32zqwtCEJLS1cJXWDOEhdOLYgoPv1mJQBzxaZyCz?=
 =?us-ascii?Q?FtLTRJiS7hRR4na7bi025q/YJP9NF3T1MCt9gPg6z7remWi9Aiy2h7g20Gub?=
 =?us-ascii?Q?7VO/FwWL62U2CKK9PT6jkDwgF8HLfvK/P7XRTS0yBmZyoZENcl7gVzpbfLb0?=
 =?us-ascii?Q?OYv7uJK6mwL535TVL2xtMipb19BLe1EF2dBtRjdKRxYp9dZfcYxzWej/mLqq?=
 =?us-ascii?Q?NuN/c/b8R40JdFFnBDTJrFG9ihraH1yxvBS6zA7JCgeF4BOV5xW974zKJ1Dz?=
 =?us-ascii?Q?jURLoA5rLP6RyE9KtvSl+nBN3qe3idT6iFNh0+T1+lzcf6YMr8nbdeQWE1jj?=
 =?us-ascii?Q?XhiPjwenNM2RFFSycE9Ye+/hx+0Q+AWPj1GunINu2i2ZcouVPgDj9iHbxFvk?=
 =?us-ascii?Q?lSzdf++07lXn2kO+kwXXYJpMYENqtYn9+5sw06PuedxcfUuR+FL+sza3vuTb?=
 =?us-ascii?Q?Z5w5sIUJEAAzNqI1TMCpm5FbB7YQQtypsxhKoUXVJuq6V4LcNJiCz90dYoBR?=
 =?us-ascii?Q?i/nNdnh7tlBJWrrXsh6nlmvwSrfsh0ND4ClX39lgbTjDyBQSfK57JSE8tCC4?=
 =?us-ascii?Q?+caJnsKp11GaHz/RWn7X/0pFcqR4VO6K4krOMh+YgZHIispEeyv9js33aM05?=
 =?us-ascii?Q?kw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eb10b7b-c3aa-4845-c72b-08ddfad9b815
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 19:45:16.1371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0sxezQQZVr5EnL7e7matbAILWfTrK3MdiFTalW+BXW/FPs2a/IZOSHv7/D8e614nRsauKU5R5VJe6Vb8TI4Hlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7352

dev_set_drvdata() is called twice, it is sufficient to do it only once.

devm_of_phy_provider_register() can fail, and if it does, the
&priv->cdr_check work item is queued, but not cancelled, and the device
probing failed, so it will trigger use after free. This is a minor risk
though.

Resource initialization should be done a little earlier, in case we need
to dereference dev_get_drvdata() in lynx_28g_pll_read_configuration() or
in lynx_28g_lane_read_configuration().

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2: patch is new

 drivers/phy/freescale/phy-fsl-lynx-28g.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-lynx-28g.c b/drivers/phy/freescale/phy-fsl-lynx-28g.c
index 7a1ef35f823f..5b2a5b1e674f 100644
--- a/drivers/phy/freescale/phy-fsl-lynx-28g.c
+++ b/drivers/phy/freescale/phy-fsl-lynx-28g.c
@@ -1136,7 +1136,11 @@ static int lynx_28g_probe(struct platform_device *pdev)
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
+
 	priv->dev = dev;
+	dev_set_drvdata(dev, priv);
+	spin_lock_init(&priv->pcc_lock);
+	INIT_DELAYED_WORK(&priv->cdr_check, lynx_28g_cdr_lock_check);
 
 	priv->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->base))
@@ -1161,18 +1165,14 @@ static int lynx_28g_probe(struct platform_device *pdev)
 		lynx_28g_lane_read_configuration(lane);
 	}
 
-	dev_set_drvdata(dev, priv);
-
-	spin_lock_init(&priv->pcc_lock);
-	INIT_DELAYED_WORK(&priv->cdr_check, lynx_28g_cdr_lock_check);
+	provider = devm_of_phy_provider_register(dev, lynx_28g_xlate);
+	if (IS_ERR(provider))
+		return PTR_ERR(provider);
 
 	queue_delayed_work(system_power_efficient_wq, &priv->cdr_check,
 			   msecs_to_jiffies(1000));
 
-	dev_set_drvdata(dev, priv);
-	provider = devm_of_phy_provider_register(dev, lynx_28g_xlate);
-
-	return PTR_ERR_OR_ZERO(provider);
+	return 0;
 }
 
 static void lynx_28g_remove(struct platform_device *pdev)
-- 
2.34.1


