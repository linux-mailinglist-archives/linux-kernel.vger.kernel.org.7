Return-Path: <linux-kernel+bounces-871331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDA6C0CF2C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 11:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EBCF64F08C5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A302F5A37;
	Mon, 27 Oct 2025 10:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="WBKBwro+"
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010016.outbound.protection.outlook.com [52.101.61.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7FF1DF252
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 10:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761560717; cv=fail; b=Rvhyg/d4VLAlQ26lmPNf9fPtSbhKB6Z4g2kyeJfDl5fKYmKCREoTwuZXphb6r+IOKUwiTAVf4W03LX4AmkFJ4R3a3V3oWAk0J6XjMYmfaTY0+dxFmy5bave+bKiJMolreGoNbcQwTwKq7E7t4fkcejGXX+bPQGbKCwxHUPzqOyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761560717; c=relaxed/simple;
	bh=p3N5i6RIZ3pqAgN4U5rfVCuyVR4UYacb2Qo92B6ZMXE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=V1+vCdV4S0guANqGxItP/xOZfD9uzfGTNywadFF0EsFFBIMbWFXkQY0jeU4lqQ36WG0XSTA8x6pq8P0yik7tDU6SkM8A3xpKMMr/0t0FqXSOeTmcBOlljAbUFnT3hds/ST5mKYaK3RKu352cr7dmBgahic6VQiJQgkRAjrP3V8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=WBKBwro+; arc=fail smtp.client-ip=52.101.61.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nx4AjkQ2BkAjX6Vw7I293z6AVv555cTiE0FWiFuSHKiDltFjqKnyrMQMZbSbjV0P5YFxFKo/y6tuopJpP9OuhagXOVD6AumpIoGzb1dqicCv21wOj1lIDhSUVM3bT0II4Ly6smDFX2ykLHCA7dl+C4T6CFxVPYqR7eZHv2Q6Wt4uh+2NUdQhRtPHQONHVmrPsWbpzcqBzbrlG+QWJl4Cc3JjXw6SpAbKtpuGfCZycwFEGkztGIrfiffar+6mmrASBhmBbAjUv/c+O4V2mo8FV7tEdcvwuIaE6zEHTf9cRQebSRjbc7anIgLUPBn3dQs/sW/teavWiyg5m4J2SAitLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Io1P/vXVUIHmxtHNY0wzqGHXd2keKDE2yo11z3Ylw4=;
 b=VVu0urYbsFSdIMYs7WHq6pfR2AC17pls9+qthx1SrQVVwnmxZhoz4eyBCITmUUIvUJoZIiaM/hDmHrLD5meFEz2WJuNZGUd8XEeH80azLDm7a6Rka6muTr38DtwMB+Anla85TC2R0Bb8dXgimnl8Hq8pGwtS6CX10HXEnpOcI6QCnD3jpizd+sH10JaAc2oY9o/4Cxdc9FSk0BXCTm/PXOYjdutp86Ht7MoLdJlNfxGRRVkO/rNMQUgQutEo2msZZEc1EMBDyFdgBrAe1u533s5p+yMKEbeCF2e1Ku/c0j6ucYhk11UnSUc6fne29cNnYF12syrZyedKuh8MtMeCdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Io1P/vXVUIHmxtHNY0wzqGHXd2keKDE2yo11z3Ylw4=;
 b=WBKBwro+SfLMjRagrZe4Sigr+t++uU41Mpqp9PHS4tuhRinXFo+jRIQarlVbLlBha7uzIEmn1C3RZq4lKrDgdxixka57aUPXeY9TWA2HbI/+EwJcZxZHptIMbD2gzO4p5hZ+jSiEns4wrw9GXIvwJfgE7mKNn2/GyHK7+MT4Yl8aWKPwIV4mtLrCeT5q5wOG3pTygThVZNEwa80SJGybF3jfFhYcAvCgLFlyPzGS9M2kyZZ5mgLde8Vr5FcEC6TER8+TvRsZf/OrMdAPR7Sidd29xjGEgjtw8yQPnpdOv1U3NFlu2FSwGa0kyXmwtN+vpmVPw85qrDxp4m2kUEo2Ow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BL1PR03MB6037.namprd03.prod.outlook.com (2603:10b6:208:309::10)
 by SJ0PR03MB5406.namprd03.prod.outlook.com (2603:10b6:a03:28e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Mon, 27 Oct
 2025 10:25:11 +0000
Received: from BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1]) by BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1%3]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 10:25:11 +0000
From: niravkumarlaxmidas.rabara@altera.com
To: miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
Subject: [PATCH v3] mtd: rawnand: cadence: Add support for NV-DDR interface mode
Date: Mon, 27 Oct 2025 18:23:04 +0800
Message-Id: <20251027102304.658490-1-niravkumarlaxmidas.rabara@altera.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KU3P306CA0007.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:15::6) To BL1PR03MB6037.namprd03.prod.outlook.com
 (2603:10b6:208:309::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR03MB6037:EE_|SJ0PR03MB5406:EE_
X-MS-Office365-Filtering-Correlation-Id: f54ed439-3f8e-47bf-c28b-08de15431c18
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2cPtQAnEF69bN3GAIHrC58eVbaIlAkDrLf3Pov5olwNVkYO4YL/bx131lX0h?=
 =?us-ascii?Q?2WVAD2lovZOUOkZHnjUHdpDEdB5lW5aeDZ3fYd7PDpth8g1GdF73Zz/JH/2G?=
 =?us-ascii?Q?90FFIspP6Wg2tr7wec6/lKlbtF7RRO5tWGZlOKf98Sjq0ywgZR7KxjqNylmG?=
 =?us-ascii?Q?HFmlFnYkGNJeHscqGFzfpMYRfZQsNg0+tT82c4wWhtn1/jw4PrMeYWxqp64f?=
 =?us-ascii?Q?j5j1fajgqiTzLk+C1LNhxcIx68dit8tZXWRoLW7a3ptbxvKHob28v/7TXjuj?=
 =?us-ascii?Q?Y3LrhlOAwShb4F3HDIR6iXmAIxGttBKZWQVQ40g4q9qAWnEUdUf4Gf6tr0Af?=
 =?us-ascii?Q?qURL+bl4fXVNpEz0WcDB3Y5XyDZGWr+uuwbS4ZxMfgTW4Vw/QGbSLc8ogp2C?=
 =?us-ascii?Q?KPsvO630xwTmfpZ3eRpgwheXWFUnNbZtrF/v3C/vYSpS/TBak/1GFoiQpKpA?=
 =?us-ascii?Q?ypvNT3F09CUT4knn9Y1+4z25vhuyKmf5n8cfO+rDrTt//FcgiD1YrdX879A5?=
 =?us-ascii?Q?yS6mOCNmhATX1n+SH5CleGQ38r2VzizB8MTydcEveL5BhmU+5mTXN7jGvXmo?=
 =?us-ascii?Q?ZXUQS3JACHIf3fcIxIqhTcQIBmXXyv/iKN3TleMAfi06pmV9oXqEJPFVVdpm?=
 =?us-ascii?Q?9P0+qs75ohekWslubr+oXv/cq3r8BdK9HkdOzUY/pbzVd7ZucIx8IYL0T6us?=
 =?us-ascii?Q?hdS/jtDX/xfSjcI8qTZl4XQURL3GZh8LwJkMTzErjY+eSW29/pqGTRaY4mOg?=
 =?us-ascii?Q?wiBfAO3l581JLEebs+N2d+0ULFD2/TggjQSDxk/NuooksDdCx9uaXyG/XfXB?=
 =?us-ascii?Q?DzgYRxXzZ1rPvKBHV1/avNEaflkgdmUOQYSH33DLqW6+p8Q/mMTgqWnmc4ne?=
 =?us-ascii?Q?Qzc13BzVqQwxOcXdR0Btmux1OA6DdhkfXla8CECbjotBSwrVtktnOvkDiUJF?=
 =?us-ascii?Q?NMpZgJQ+hlOpZIf7O/Aj9VJDX2PwXNfhSUUO7hsFV+zhYr7ffEjt59whxoh1?=
 =?us-ascii?Q?r7RUsMqNlvHdEXsgEMYhZ6Pcj5Sxe0a/Y4Afo45KzcTwYueshszP8wSKisNW?=
 =?us-ascii?Q?T8SpFHgcfz8Kcr6zZxIVTaBhLaiilX5w0PyUmUkmXSD97j5/20oLynctEvEk?=
 =?us-ascii?Q?ubYgFbJoH47LQiEyYSvx8nOcY4c8NCNsghXVMFTbbiir4DlAg0mXt4KCxM/x?=
 =?us-ascii?Q?Q3fb69nCZ8J4sjoLgaHJj31wqE9n2UrNWRQJJ4vylT1d53oRmWRGxk0jfdw8?=
 =?us-ascii?Q?XCpNmNqrHcxJ7Zs5ODfxbm/bABnzFw9wGDjhJRbvkYaYSBdHK8dk7LRp8JYT?=
 =?us-ascii?Q?CzLHPEHVEeRFTd4EpX/C0n5FiDL71bF4T4Y5jhmZVquPOvp9g6W6UIMXhNcb?=
 =?us-ascii?Q?svMi53wegGhIXjV1gT8u+0aLBWinhya+XdWsC0SGd0hc2cof0Fp+Ga6LFZgR?=
 =?us-ascii?Q?vaw49ehEt9aAuRQaDXZi+boxiI47IeIc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR03MB6037.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LP9Darx6RWS0KrcfpHcLas5vNn+uLqR0GPXbCN19w4XuL/T39+/m5mXz/oEY?=
 =?us-ascii?Q?BKx1LrPWkECmFPfpnq1NInR7CPOHk+nB8iA9vUxuyjGEc8HQN2BHPCnt65tH?=
 =?us-ascii?Q?C5SQ2NtLjjebb4tQXXU5F73g0avgjNWHR/lgwc0vGlqzQnTzHx5JZGJnIySv?=
 =?us-ascii?Q?/1seWMB2kO2+C/KeMd8qZDUdLIhFeo8SvfSLmhvi+R0/RFjjfwoJzrBJwgHL?=
 =?us-ascii?Q?ekngUgETBvSxfYb0jea4BqVkvISSXf8fCPM68d/RsG+vYkLyMB3PZ3aIKURP?=
 =?us-ascii?Q?Y1x+nkK2YW6+bjEjwiHKML9g3+XHjJ+L8eCxgV+3spc8MvU/HxOr2mmzZFNt?=
 =?us-ascii?Q?/0tCQtnCd7CitrGsfCM8aD9JUOfYZMQTJozwgtgi1AxP0l4UB7RYCeWHDSvu?=
 =?us-ascii?Q?cJYmrvlKMdFQE5ia38XbUX8FBsDvEu8FLhl8hLDxY6hRe4Ozh1kxdawtp7M3?=
 =?us-ascii?Q?q1HefNbRnwy+n53cUVJswAkXkN+IEOms+HhAv9k8qxfWMXhY3OoN+6LDQp4w?=
 =?us-ascii?Q?cTQ6hBSIe5Xi9IKePbwjLxs12aA6IYjdY3wod7LoB2ZfjFxRO3mIeksC4dLM?=
 =?us-ascii?Q?gwlWQCc0aEXzwslE6d6upGBVHrQwo6G+ako5dp5DpajRr9V9m/UE+wqGay6A?=
 =?us-ascii?Q?tE/RWzHel6fGGN8ypoatOKsRMbXozYgmuX4Ywyj2HzrJHhMo3VIecaTsBby/?=
 =?us-ascii?Q?+cHrh7cIZJOXyzn4xSa0t5BycjG5usVblIXSqSNNoTbdVYp0TepMUAksUHUe?=
 =?us-ascii?Q?flnRMOQ7Lj6SXkGsXjQ4h7FLCTKhqqzwK8iRUMabYhfnn4u60knqTjQ2nKvu?=
 =?us-ascii?Q?4TUcPgCAGwp5LyqEKxGWdqbhu+D+77TI+sDvSHI9gdQTV2gRcRJIVFATP3y2?=
 =?us-ascii?Q?ObcLw7ArIFmZScTCOzVUSBCVfOB2SGeOazMtVA9nbXY8GaBAjw5xDTq0VRL/?=
 =?us-ascii?Q?3Vz7QDRX+ehpsDXfOJQLOSzt3F5knY9wQnSwBFGiKgVMJce3gOBE94zjeb5G?=
 =?us-ascii?Q?D13vN2Hp8+QvqChxDpAkxCMOFho7o0mZBG9pMhIC34YffiPeL+iz0fEdzNhE?=
 =?us-ascii?Q?DUIQ78oB39aFO4WrKaE/oqU+yGwtUiUO9hW1IG2csNl0RBw4F9L/pYXfpAjR?=
 =?us-ascii?Q?BbirPzKluRg5VncZd43j1DZWF/S0087AV0AfEO7vHAoeqYauHJh2VYZb/U/h?=
 =?us-ascii?Q?ALSkDAVWSgB6fcGxgEDO8vG9lfGh2Tk8+Agz/323gUFkgRgxiz6q04LO+djd?=
 =?us-ascii?Q?cgv2ZcW+Bos2S053SYhZ4/+7BBixee7YhC9UZCMwZVjXVSfrQF802EalZ+a1?=
 =?us-ascii?Q?CM8W7roN1eAJDAEPyvod9jPbqbL1TumaqmcVxzlUAYfTQC8l1LmYuBTlMq9o?=
 =?us-ascii?Q?x6NXaYyLpPyL1ao501ghDEe0sP0TnI5f+81Zo+E3xBeNR1uFbIzuTxBgtutk?=
 =?us-ascii?Q?+kdyl8jmSNV6XJ5A3IWJi1IMnTkZBtevWfOfhnfAHnjPciXLXWeIhILEvkfK?=
 =?us-ascii?Q?Rg29J34tIOLdYuxuPUrUHps/VRTTOFxyblryMmj1GBMiQnURrLbOsgbMAyf7?=
 =?us-ascii?Q?/UgmY3w27HHDBPSTsBxqVbTopbC8tkdm1a11HMM/m+A2Xh50qsIlzJ/XYcnT?=
 =?us-ascii?Q?8EGv/YV1JJXCHHkCsYa5zn2QLhJygPKaokl3QE2T+8Fk?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f54ed439-3f8e-47bf-c28b-08de15431c18
X-MS-Exchange-CrossTenant-AuthSource: BL1PR03MB6037.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 10:25:11.5199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GHscGO6VGAN6Eirq9yN735F5hATLYu+O5GJV7vO0yRoQEWPh3hpar+JQ8YLa0wSN1LKEcVyjHdroeS6rXmFH6qZGOAq7co/WMxap2u0RMetl2Kuul4UWok11WuJLN9OO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5406

From: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>

Add support for NV-DDR mode in the Cadence NAND controller driver.

Signed-off-by: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
---

Changes in v3:
* Moved chipnr condition check befor SDR/NVDDR check as per the review
  comment in v2.
* link to v2:
https://lore.kernel.org/all/20251024102611.310568-1-niravkumarlaxmidas.rabara@altera.com/

Changes in v2:
* Rename NVDDR_GATE_CFG_MIN to NVDDR_GATE_CFG_STD to avoid confusion.
* Add a separate condition check for 'chipnr' to avoid mixing up with SDR
  vs NVDDR choice.
* link to v1:
  https://lore.kernel.org/all/20251024071306.242227-1-niravkumarlaxmidas.rabara@altera.com/

 .../mtd/nand/raw/cadence-nand-controller.c    | 273 +++++++++++++++++-
 1 file changed, 264 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/nand/raw/cadence-nand-controller.c b/drivers/mtd/nand/raw/cadence-nand-controller.c
index 32ed38b89394..5f037753f78c 100644
--- a/drivers/mtd/nand/raw/cadence-nand-controller.c
+++ b/drivers/mtd/nand/raw/cadence-nand-controller.c
@@ -199,6 +199,7 @@
 
 /* Common settings. */
 #define COMMON_SET				0x1008
+#define OPR_MODE_NVDDR				BIT(0)
 /* 16 bit device connected to the NAND Flash interface. */
 #define		COMMON_SET_DEVICE_16BIT		BIT(8)
 
@@ -211,12 +212,20 @@
 #define		 SKIP_BYTES_OFFSET_VALUE	GENMASK(23, 0)
 
 /* Timings configuration. */
+#define TOGGLE_TIMINGS_0			0x1014
+#define TOGGLE_TIMINGS_1			0x1018
+
 #define ASYNC_TOGGLE_TIMINGS			0x101c
 #define		ASYNC_TOGGLE_TIMINGS_TRH	GENMASK(28, 24)
 #define		ASYNC_TOGGLE_TIMINGS_TRP	GENMASK(20, 16)
 #define		ASYNC_TOGGLE_TIMINGS_TWH	GENMASK(12, 8)
 #define		ASYNC_TOGGLE_TIMINGS_TWP	GENMASK(4, 0)
 
+#define	SYNC_TIMINGS				0x1020
+#define		SYNC_TCKWR			GENMASK(21, 16)
+#define		SYNC_TWRCK			GENMASK(13, 8)
+#define		SYNC_TCAD			GENMASK(5, 0)
+
 #define	TIMINGS0				0x1024
 #define		TIMINGS0_TADL			GENMASK(31, 24)
 #define		TIMINGS0_TCCS			GENMASK(23, 16)
@@ -226,6 +235,7 @@
 #define	TIMINGS1				0x1028
 #define		TIMINGS1_TRHZ			GENMASK(31, 24)
 #define		TIMINGS1_TWB			GENMASK(23, 16)
+#define		TIMINGS1_TCWAW			GENMASK(15, 8)
 #define		TIMINGS1_TVDLY			GENMASK(7, 0)
 
 #define	TIMINGS2				0x102c
@@ -243,14 +253,23 @@
 
 /* Register controlling DQ related timing. */
 #define PHY_DQ_TIMING				0x2000
+#define		PHY_DQ_TIMING_OE_END	GENMASK(2, 0)
+#define		PHY_DQ_TIMING_OE_START	GENMASK(6, 4)
+#define		PHY_DQ_TIMING_TSEL_END	GENMASK(11, 8)
+#define		PHY_DQ_TIMING_TSEL_START	GENMASK(15, 12)
+
 /* Register controlling DSQ related timing.  */
 #define PHY_DQS_TIMING				0x2004
 #define		PHY_DQS_TIMING_DQS_SEL_OE_END	GENMASK(3, 0)
+#define		PHY_DQS_TIMING_DQS_SEL_OE_START	GENMASK(7, 4)
+#define		PHY_DQS_TIMING_DQS_SEL_TSEL_END	GENMASK(11, 8)
 #define		PHY_DQS_TIMING_PHONY_DQS_SEL	BIT(16)
 #define		PHY_DQS_TIMING_USE_PHONY_DQS	BIT(20)
 
 /* Register controlling the gate and loopback control related timing. */
 #define PHY_GATE_LPBK_CTRL			0x2008
+#define		PHY_GATE_LPBK_CTRL_GATE_CFG		GENMASK(3, 0)
+#define		PHY_GATE_LPBK_CTRL_GATE_CFG_CLOSE	GENMASK(5, 4)
 #define		PHY_GATE_LPBK_CTRL_RDS		GENMASK(24, 19)
 
 /* Register holds the control for the master DLL logic. */
@@ -260,6 +279,12 @@
 /* Register holds the control for the slave DLL logic. */
 #define PHY_DLL_SLAVE_CTRL			0x2010
 
+/* Register controls the DQS related timing. */
+#define PHY_IE_TIMING				0x2014
+#define		PHY_IE_TIMING_DQS_IE_START		GENMASK(10, 8)
+#define		PHY_IE_TIMING_DQ_IE_START		GENMASK(18, 16)
+#define		PHY_IE_TIMING_IE_ALWAYS_ON		BIT(20)
+
 /* This register handles the global control settings for the PHY. */
 #define PHY_CTRL				0x2080
 #define		PHY_CTRL_SDR_DQS		BIT(14)
@@ -375,15 +400,41 @@
 #define BCH_MAX_NUM_CORR_CAPS		8
 #define BCH_MAX_NUM_SECTOR_SIZES	2
 
+/* NVDDR mode specific parameters and register values based on cadence specs */
+#define NVDDR_PHY_RD_DELAY		29
+#define NVDDR_PHY_RD_DELAY_MAX		31
+#define NVDDR_GATE_CFG_OPT		14
+#define NVDDR_GATE_CFG_STD		7
+#define NVDDR_GATE_CFG_MAX		15
+#define NVDDR_DATA_SEL_OE_START		1
+#define NVDDR_DATA_SEL_OE_START_MAX	7
+#define NVDDR_DATA_SEL_OE_END		6
+#define NVDDR_DATA_SEL_OE_END_MIN	4
+#define NVDDR_DATA_SEL_OE_END_MAX	15
+#define NVDDR_RS_HIGH_WAIT_CNT		7
+#define NVDDR_RS_IDLE_CNT		7
+#define NVDDR_TCWAW_DELAY		250000
+#define NVDDR_TVDLY_DELAY		500000
+#define NVDDR_TOGGLE_TIMINGS_0		0x00000301
+#define NVDDR_TOGGLE_TIMINGS_1		0x0a060102
+#define NVDDR_ASYNC_TOGGLE_TIMINGS	0
+#define NVDDR_PHY_CTRL			0x00004000
+#define NVDDR_PHY_TSEL			0
+#define NVDDR_PHY_DLL_MASTER_CTRL	0x00140004
+#define NVDDR_PHY_DLL_SLAVE_CTRL	0x00003c3c
+
 struct cadence_nand_timings {
 	u32 async_toggle_timings;
+	u32 sync_timings;
 	u32 timings0;
 	u32 timings1;
 	u32 timings2;
 	u32 dll_phy_ctrl;
 	u32 phy_ctrl;
+	u32 phy_dq_timing;
 	u32 phy_dqs_timing;
 	u32 phy_gate_lpbk_ctrl;
+	u32 phy_ie_timing;
 };
 
 /* Command DMA descriptor. */
@@ -2345,11 +2396,9 @@ static inline u32 calc_tdvw(u32 trp_cnt, u32 clk_period, u32 trhoh_min,
 	return (trp_cnt + 1) * clk_period + trhoh_min - trea_max;
 }
 
-static int
-cadence_nand_setup_interface(struct nand_chip *chip, int chipnr,
-			     const struct nand_interface_config *conf)
+static int cadence_nand_setup_sdr_interface(struct nand_chip *chip,
+					    const struct nand_sdr_timings *sdr)
 {
-	const struct nand_sdr_timings *sdr;
 	struct cdns_nand_ctrl *cdns_ctrl = to_cdns_nand_ctrl(chip->controller);
 	struct cdns_nand_chip *cdns_chip = to_cdns_nand_chip(chip);
 	struct cadence_nand_timings *t = &cdns_chip->timings;
@@ -2370,13 +2419,8 @@ cadence_nand_setup_interface(struct nand_chip *chip, int chipnr,
 	u32 dll_phy_dqs_timing = 0, phony_dqs_timing = 0, rd_del_sel = 0;
 	u32 sampling_point;
 
-	sdr = nand_get_sdr_timings(conf);
-	if (IS_ERR(sdr))
-		return PTR_ERR(sdr);
-
 	memset(t, 0, sizeof(*t));
 	/* Sampling point calculation. */
-
 	if (cdns_ctrl->caps2.is_phy_type_dll)
 		phony_dqs_mod = 2;
 	else
@@ -2633,10 +2677,221 @@ cadence_nand_setup_interface(struct nand_chip *chip, int chipnr,
 			PHY_DLL_MASTER_CTRL_BYPASS_MODE);
 		dev_dbg(cdns_ctrl->dev, "PHY_DLL_SLAVE_CTRL_REG_SDR\t%x\n", 0);
 	}
+	return 0;
+}
+
+static int
+cadence_nand_setup_nvddr_interface(struct nand_chip *chip,
+				   const struct nand_nvddr_timings *nvddr)
+{
+	struct cdns_nand_ctrl *cdns_ctrl = to_cdns_nand_ctrl(chip->controller);
+	struct cdns_nand_chip *cdns_chip = to_cdns_nand_chip(chip);
+	struct cadence_nand_timings *t = &cdns_chip->timings;
+	u32 board_delay = cdns_ctrl->board_delay;
+	u32 clk_period = DIV_ROUND_DOWN_ULL(1000000000000ULL,
+					    cdns_ctrl->nf_clk_rate);
+	u32 ddr_clk_ctrl_period = clk_period * 2;
+	u32 if_skew = cdns_ctrl->caps1->if_skew;
+	u32 tceh_cnt, tcs_cnt, tadl_cnt, tccs_cnt;
+	u32 twrck_cnt, tcad_cnt, tckwr_cnt = 0;
+	u32 tfeat_cnt, trhz_cnt, tvdly_cnt, tcwaw_cnt;
+	u32 trhw_cnt, twb_cnt, twhr_cnt;
+	u32 oe_start, oe_end, oe_end_dqsd;
+	u32 rd_del_sel = 0;
+	u32 dqs_driven_by_device, dqs_toogle_by_device, gate_open_delay;
+	u32 dll_phy_gate_open_delay, gate_close_delay, ie_start;
+	u32 dll_phy_rd_delay;
+	u32 reg;
+
+	memset(t, 0, sizeof(*t));
+	twrck_cnt = calc_cycl(nvddr->tWRCK_min, ddr_clk_ctrl_period);
+	tcad_cnt = calc_cycl(nvddr->tCAD_min, ddr_clk_ctrl_period);
+
+	reg = FIELD_PREP(SYNC_TWRCK, twrck_cnt);
+	reg |= FIELD_PREP(SYNC_TCAD, tcad_cnt);
+	t->sync_timings = reg;
+	dev_dbg(cdns_ctrl->dev, "SYNC_TIMINGS_NVDDR\t%08x\n", reg);
+
+	tadl_cnt = calc_cycl((nvddr->tADL_min + if_skew), ddr_clk_ctrl_period);
+	tccs_cnt = calc_cycl((nvddr->tCCS_min + if_skew), ddr_clk_ctrl_period);
+	twhr_cnt = calc_cycl((nvddr->tWHR_min + if_skew), ddr_clk_ctrl_period);
+	trhw_cnt = calc_cycl((nvddr->tRHW_min + if_skew), ddr_clk_ctrl_period);
+	reg = FIELD_PREP(TIMINGS0_TADL, tadl_cnt);
+	reg |= FIELD_PREP(TIMINGS0_TCCS, tccs_cnt);
+	reg |= FIELD_PREP(TIMINGS0_TWHR, twhr_cnt);
+	reg |= FIELD_PREP(TIMINGS0_TRHW, trhw_cnt);
+	t->timings0 = reg;
+	dev_dbg(cdns_ctrl->dev, "TIMINGS0_NVDDR\t%08x\n", reg);
+
+	twb_cnt = calc_cycl((nvddr->tWB_max + board_delay),
+			    ddr_clk_ctrl_period);
+	/*
+	 * Because of the two stage syncflop the value must be increased by 3
+	 * first value is related with sync, second value is related
+	 * with output if delay.
+	 */
+	twb_cnt = twb_cnt + 3 + 5;
+	tvdly_cnt = calc_cycl(NVDDR_TVDLY_DELAY + if_skew, ddr_clk_ctrl_period);
+	tcwaw_cnt = calc_cycl(NVDDR_TCWAW_DELAY, ddr_clk_ctrl_period);
+	trhz_cnt = 1;
+	reg = FIELD_PREP(TIMINGS1_TWB, twb_cnt);
+	reg |= FIELD_PREP(TIMINGS1_TVDLY, tvdly_cnt);
+	reg |= FIELD_PREP(TIMINGS1_TRHZ, trhz_cnt);
+	reg |= FIELD_PREP(TIMINGS1_TCWAW, tcwaw_cnt);
+	t->timings1 = reg;
+	dev_dbg(cdns_ctrl->dev, "TIMINGS1_NVDDR\t%08x\n", reg);
+
+	tfeat_cnt = calc_cycl(nvddr->tFEAT_max, ddr_clk_ctrl_period);
+	if (tfeat_cnt < twb_cnt)
+		tfeat_cnt = twb_cnt;
+
+	tceh_cnt = calc_cycl(nvddr->tCEH_min, ddr_clk_ctrl_period);
+	tcs_cnt = calc_cycl((nvddr->tCS_min + if_skew), ddr_clk_ctrl_period);
+	reg = FIELD_PREP(TIMINGS2_TFEAT, tfeat_cnt);
+	reg |= FIELD_PREP(TIMINGS2_CS_HOLD_TIME, tceh_cnt);
+	reg |= FIELD_PREP(TIMINGS2_CS_SETUP_TIME, tcs_cnt);
+	t->timings2 = reg;
+	dev_dbg(cdns_ctrl->dev, "TIMINGS2_NVDDR\t%08x\n", reg);
+
+	reg = FIELD_PREP(DLL_PHY_CTRL_RS_HIGH_WAIT_CNT, NVDDR_RS_HIGH_WAIT_CNT);
+	reg |= FIELD_PREP(DLL_PHY_CTRL_RS_IDLE_CNT, NVDDR_RS_IDLE_CNT);
+	t->dll_phy_ctrl = reg;
+	dev_dbg(cdns_ctrl->dev, "DLL_PHY_CTRL_NVDDR\t%08x\n", reg);
+
+	reg  = PHY_CTRL_SDR_DQS;
+	t->phy_ctrl = reg;
+	dev_dbg(cdns_ctrl->dev, "PHY_CTRL_REG_NVDDR\t%08x\n", reg);
+
+	dqs_driven_by_device = (nvddr->tDQSD_max + board_delay) / 1000 +
+				if_skew;
+	dqs_toogle_by_device = (nvddr->tDQSCK_max + board_delay) / 1000 -
+				if_skew;
+	gate_open_delay = dqs_toogle_by_device / (clk_period / 1000);
+	if (dqs_toogle_by_device > clk_period / 1000) {
+		if (gate_open_delay > NVDDR_GATE_CFG_OPT)
+			dll_phy_gate_open_delay = NVDDR_GATE_CFG_MAX;
+		else
+			dll_phy_gate_open_delay = gate_open_delay + 1;
+		gate_close_delay = 0;
+	} else {
+		twrck_cnt = calc_cycl(dqs_driven_by_device * 1000, clk_period);
+		dll_phy_gate_open_delay = 1;
+		gate_close_delay = 0;
+
+		reg = FIELD_PREP(SYNC_TCKWR, tckwr_cnt);
+		reg |= FIELD_PREP(SYNC_TWRCK, twrck_cnt);
+		reg |= FIELD_PREP(SYNC_TCAD, tcad_cnt);
+		t->sync_timings = reg;
+		dev_dbg(cdns_ctrl->dev, "SYNC_TIMINGS_NVDDR\t%08x\n", reg);
+	}
 
+	if (dll_phy_gate_open_delay > NVDDR_GATE_CFG_STD)
+		ie_start = NVDDR_GATE_CFG_STD;
+	else
+		ie_start = dll_phy_gate_open_delay;
+
+	dll_phy_rd_delay = ((nvddr->tDQSCK_max + board_delay) +
+				(clk_period / 2)) / clk_period;
+	if (dll_phy_rd_delay <= NVDDR_PHY_RD_DELAY)
+		rd_del_sel = dll_phy_rd_delay + 2;
+	else
+		rd_del_sel = NVDDR_PHY_RD_DELAY_MAX;
+
+	reg = FIELD_PREP(PHY_GATE_LPBK_CTRL_GATE_CFG, dll_phy_gate_open_delay);
+	reg |= FIELD_PREP(PHY_GATE_LPBK_CTRL_GATE_CFG_CLOSE, gate_close_delay);
+	reg |= FIELD_PREP(PHY_GATE_LPBK_CTRL_RDS, rd_del_sel);
+	t->phy_gate_lpbk_ctrl = reg;
+	dev_dbg(cdns_ctrl->dev, "PHY_GATE_LPBK_CTRL_REG_NVDDR\t%08x\n", reg);
+
+	oe_end_dqsd = ((nvddr->tDQSD_max / 1000) / ((clk_period / 2) / 1000))
+				+ NVDDR_DATA_SEL_OE_END_MIN;
+	oe_end = (NVDDR_DATA_SEL_OE_END_MIN + oe_end_dqsd) / 2;
+	if (oe_end > NVDDR_DATA_SEL_OE_END_MAX)
+		oe_end = NVDDR_DATA_SEL_OE_END_MAX;
+
+	oe_start = ((nvddr->tDQSHZ_max / 1000) / ((clk_period / 2) / 1000)) + 1;
+	if (oe_start > NVDDR_DATA_SEL_OE_START_MAX)
+		oe_start = NVDDR_DATA_SEL_OE_START_MAX;
+
+	reg = FIELD_PREP(PHY_DQ_TIMING_OE_END, NVDDR_DATA_SEL_OE_END);
+	reg |= FIELD_PREP(PHY_DQ_TIMING_OE_START, NVDDR_DATA_SEL_OE_START);
+	reg |= FIELD_PREP(PHY_DQ_TIMING_TSEL_END, NVDDR_DATA_SEL_OE_END);
+	reg |= FIELD_PREP(PHY_DQ_TIMING_TSEL_START, NVDDR_DATA_SEL_OE_START);
+	t->phy_dq_timing = reg;
+	dev_dbg(cdns_ctrl->dev, "PHY_DQ_TIMING_REG_NVDDR\t%08x\n", reg);
+
+	reg = FIELD_PREP(PHY_DQS_TIMING_DQS_SEL_OE_END, oe_end);
+	reg |= FIELD_PREP(PHY_DQS_TIMING_DQS_SEL_OE_START, oe_start);
+	reg |= FIELD_PREP(PHY_DQS_TIMING_DQS_SEL_TSEL_END, oe_end);
+	t->phy_dqs_timing = reg;
+	dev_dbg(cdns_ctrl->dev, "PHY_DQS_TIMING_REG_NVDDR\t%08x\n", reg);
+
+	reg = FIELD_PREP(PHY_IE_TIMING_DQS_IE_START, ie_start);
+	reg |= FIELD_PREP(PHY_IE_TIMING_DQ_IE_START, ie_start);
+	reg |= FIELD_PREP(PHY_IE_TIMING_IE_ALWAYS_ON, 0);
+	t->phy_ie_timing = reg;
+	dev_dbg(cdns_ctrl->dev, "PHY_IE_TIMING_REG_NVDDR\t%08x\n", reg);
+
+	reg = readl_relaxed(cdns_ctrl->reg + DLL_PHY_CTRL);
+	reg &= ~(DLL_PHY_CTRL_DLL_RST_N |
+		 DLL_PHY_CTRL_EXTENDED_RD_MODE |
+		 DLL_PHY_CTRL_EXTENDED_WR_MODE);
+	writel_relaxed(reg, cdns_ctrl->reg + DLL_PHY_CTRL);
+	writel_relaxed(OPR_MODE_NVDDR, cdns_ctrl->reg + COMMON_SET);
+	writel_relaxed(NVDDR_TOGGLE_TIMINGS_0,
+		       cdns_ctrl->reg + TOGGLE_TIMINGS_0);
+	writel_relaxed(NVDDR_TOGGLE_TIMINGS_1,
+		       cdns_ctrl->reg + TOGGLE_TIMINGS_1);
+	writel_relaxed(NVDDR_ASYNC_TOGGLE_TIMINGS,
+		       cdns_ctrl->reg + ASYNC_TOGGLE_TIMINGS);
+	writel_relaxed(t->sync_timings, cdns_ctrl->reg + SYNC_TIMINGS);
+	writel_relaxed(t->timings0, cdns_ctrl->reg + TIMINGS0);
+	writel_relaxed(t->timings1, cdns_ctrl->reg + TIMINGS1);
+	writel_relaxed(t->timings2, cdns_ctrl->reg + TIMINGS2);
+	writel_relaxed(t->dll_phy_ctrl, cdns_ctrl->reg + DLL_PHY_CTRL);
+	writel_relaxed(t->phy_ctrl, cdns_ctrl->reg + PHY_CTRL);
+	writel_relaxed(NVDDR_PHY_TSEL, cdns_ctrl->reg + PHY_TSEL);
+	writel_relaxed(t->phy_dq_timing, cdns_ctrl->reg + PHY_DQ_TIMING);
+	writel_relaxed(t->phy_dqs_timing, cdns_ctrl->reg + PHY_DQS_TIMING);
+	writel_relaxed(t->phy_gate_lpbk_ctrl,
+		       cdns_ctrl->reg + PHY_GATE_LPBK_CTRL);
+	writel_relaxed(NVDDR_PHY_DLL_MASTER_CTRL,
+		       cdns_ctrl->reg + PHY_DLL_MASTER_CTRL);
+	writel_relaxed(NVDDR_PHY_DLL_SLAVE_CTRL,
+		       cdns_ctrl->reg + PHY_DLL_SLAVE_CTRL);
+	writel_relaxed(t->phy_ie_timing, cdns_ctrl->reg + PHY_IE_TIMING);
+	writel_relaxed((reg | DLL_PHY_CTRL_DLL_RST_N),
+		       cdns_ctrl->reg + DLL_PHY_CTRL);
 	return 0;
 }
 
+static int
+cadence_nand_setup_interface(struct nand_chip *chip, int chipnr,
+			     const struct nand_interface_config *conf)
+{
+	int ret = 0;
+
+	if (chipnr < 0)
+		return ret;
+
+	if (nand_interface_is_sdr(conf)) {
+		const struct nand_sdr_timings *sdr = nand_get_sdr_timings(conf);
+
+		if (IS_ERR(sdr))
+			return PTR_ERR(sdr);
+
+		ret = cadence_nand_setup_sdr_interface(chip, sdr);
+	} else {
+		const struct nand_nvddr_timings *nvddr = nand_get_nvddr_timings(conf);
+
+		if (IS_ERR(nvddr))
+			return PTR_ERR(nvddr);
+
+		ret = cadence_nand_setup_nvddr_interface(chip, nvddr);
+	}
+	return ret;
+}
+
 static int cadence_nand_attach_chip(struct nand_chip *chip)
 {
 	struct cdns_nand_ctrl *cdns_ctrl = to_cdns_nand_ctrl(chip->controller);
-- 
2.25.1


