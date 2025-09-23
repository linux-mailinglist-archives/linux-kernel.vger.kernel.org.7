Return-Path: <linux-kernel+bounces-829582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDB7B97649
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 21:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 691983BDC53
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A747930506A;
	Tue, 23 Sep 2025 19:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="i7EBCPqy"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013012.outbound.protection.outlook.com [52.101.83.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80915302CB2
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 19:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758656725; cv=fail; b=lZrTbUeNljWetWuxy4BFkxKMlUOTRM9SZS2lIX2HfaguWO4gAi6VwmGaPXOpTh+L01DyesYuykkah/beuMhdij2lOzNiGSxK/FpyAfDBP5/gvVRkppTZUdIf9XRKNR76FKBS0Bpp/Af1EvlyAo6t0X6GAGH0nzpeMewDVtZ/FAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758656725; c=relaxed/simple;
	bh=rnJRhiASwiRi5hy8CiwlQKsy4Amvh/lWlBPrqy7RWAg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J0z4IaphB6e6HZNDE76JDfTt/Ql2NVOh87O7rbRbxXukZhEGr2HTzlYjk4q2/ju7gBOSwdyNpbxLSjoBl9J0cB/T4jz0GGln4ycWUiVD8LVXGCklVtW5MnEEwgjU7dX9OVuAJtMMPI5tet4M7S+eHEj035ySeB53VLECeW7trVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=i7EBCPqy; arc=fail smtp.client-ip=52.101.83.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bMR5n+tpDMoCybkMCvccw9+foofR3Pj9vx44VzTn0t2Nc8fgbxmyz0krIEq2BPiqvm8lsKojTj6ZExMVAcz6cw54JZHIWgKfJQ5ayCOPdXUIlp0S/9niEYhHfHOLrKevKVQm7NxMWc8McAApX/fRTjU64/1PxZuV3Z4nGetIYDUue6GIMhDQ01qI6g0PzeWR/3JWiuIYRV+yU83M8YodfUAkXDTdv+C8g/SoB+zXlLW8+iGrQkq/rOa/o7AnPW87USlqQ2EV19QA9p1zVULVOjtP9DsJNj502NKH9Djr7bNZNBf19+LP7+y7gn1qjMmXgvxq/lduiIoly1wlXp4ZZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j1Mp/7y1ee/u8NibkEzMq94Pf9bqqHQb6CKeHEDCTAk=;
 b=T/HIJCdtToQu34DsxkrYe7biqqzOzi4twraSiypquYgOTij/Qw5IqysPorsDm3aLFArk97ms6XaUv6xxsqrC4CHE4WFE1aq/LX4dvpGsUSMYIp/J8wqk+TTaitRqYT1Po1VA2wpj93kJgGWbfO3MN/ayVZXt2oHgfHIh4r5L8mIhzNagWrcotJEngnkj+ll4XyAS/Nq6vpbeE5Il4vV6hztnOpcyW+c1NoixPWB3oVUc9k/eycFYYCxS7oGHFYULq7wM2SuUWCiME0IBv0ZZoHglRRISCHJJHGeseEWa0F2xVhvfcqRKcQh9cZJb/TtqRdD/7zON/C8PF6lNvU97sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j1Mp/7y1ee/u8NibkEzMq94Pf9bqqHQb6CKeHEDCTAk=;
 b=i7EBCPqyny7Q90rN36Rj68HnBAHT72nYzWGFnTEZm609oNf3emNrJAQKKRx6D+PBDdk/lFPMyX35GXOi2aZAY+r9zPE7kmiCxS/RhrbQVnTS0yihyyR3E34ni43ohfNJJWVUPpunFKFRkG5y5ODkN2pIzhP30zpkaqFyo8OznibulwNhJwdHfdUcHNhbsihLz6nMSW38S1hx0pRY4ldV2Hq9oTMD73oeWCnBQ9Jb0Kcq9miyI/oLIh9cm2MIkBzd8mesN3ciy4BKYOv46g9UmhIBNnGnTEwsuRc+AbVwnmoxWt/CucIswhGjOAYLYLxbZgRRxBQ/+8GC8lyc9b2BTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DBAPR04MB7352.eurprd04.prod.outlook.com (2603:10a6:10:1a8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.8; Tue, 23 Sep
 2025 19:45:14 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 19:45:14 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Josua Mayer <josua@solid-run.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 phy 06/16] phy: lynx-28g: make lynx_28g_set_lane_mode() more systematic
Date: Tue, 23 Sep 2025 22:44:35 +0300
Message-Id: <20250923194445.454442-7-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5aaaffe7-bb2d-4ac7-8689-08ddfad9b5e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0Q6B6MZ7Fa+rkYJRu3OCzeW0yl6vUkjBZXZiLu9B9rXLodeqq5RTlLRXdCTM?=
 =?us-ascii?Q?4sV48pQw4vR3/nXeh3UfSjA1xA9DUV9dQ4xWpOkk2/BFeOeIJ+HNv4EqrIRq?=
 =?us-ascii?Q?Mu0Acj1CNKpTqpRKjFOJ/6byDMGx2VbWXgAF1dsm7Ao4gV+OwdZJua7q0zN3?=
 =?us-ascii?Q?Spzpyma62u4pBBrwCDhPgxrSOLlezRpihPAOLPXB60OdWw7q5qoDMbBg2tnY?=
 =?us-ascii?Q?nBRHhIbm2m+Hu8V+fqwnuLuSIrMl0PqXPxclneEFM1PiTdAOUOIVf3A0L4jD?=
 =?us-ascii?Q?iFXbtSgxIO/x0GC2kaHqhv8ngiQDHJj6/sPw5hPTk5lVIlF3JlOlQuNgY9v8?=
 =?us-ascii?Q?wXIjgt1FXtFSKx7GP14StTl8ek0LjSy/0upCpPZjhbQBnxOhwTwJPUhFaVtm?=
 =?us-ascii?Q?cFOhdNudEgRJ8WaVI3PSYaAXrB8pyFLTtXgYalwRZVBnYJARHKeELOAdg+65?=
 =?us-ascii?Q?hfk6AYZM3D4+oaJatuwW5tSmoLGlH4H940od5IZlJFc63xAoKfwNLEQrqHIp?=
 =?us-ascii?Q?Z5oqT6hwoW9HsjO8Nb/RHk7fOU0wzI+KWP5DlSQ3EkUQt/sGREuIEemgCIzL?=
 =?us-ascii?Q?H1jZqwbNzRuxAcJpkp4pfqnQRrCoyvX9ThkEdzRS70ayXM2QURYubDxe7skw?=
 =?us-ascii?Q?VRHK2vCa/GuD5ywv2yCVmvmnTYJcjKDpOWNU2EkRegWkMfuPgHKyT0HoOxSe?=
 =?us-ascii?Q?0+TJzfkbKkiKe9+IB44yRHdu6A/H9L6E7Rznkx8ZWX8vlzKzyrNooLwMUeRH?=
 =?us-ascii?Q?Q16kC5u7x53qq3oGV6BZSe8JMTi+tC6pk/wtr+6oDOeuQHrJ+ktGWC2b0J3H?=
 =?us-ascii?Q?GEPVZSgiL9YbVMWrvZ1wCFAVSTFvZ2cDNPakgccKxvzuTS2JdCQunCGbj6sr?=
 =?us-ascii?Q?BDXSse6pylqmSwSnrhRc2/z4VrR2m05UYIJSSnJl9NO+5ezNh9ytSS5OfWrD?=
 =?us-ascii?Q?vy9VIJAcLw7T4fm3qL0zq4jTkezUc9tLY5gxUBgsz6daAGShfLPQIjeEzPyL?=
 =?us-ascii?Q?o9QN65UjuHLVizVtoTEC/4wUtNgR4Mp9EBbTHhlmLk+MD35Lh0NtmHnJUzLQ?=
 =?us-ascii?Q?MRDK8+DXt2v36YwdcYcG5WFeqltYW1RbSpwsvUxMtQGwtKZGpT6MjEObxueC?=
 =?us-ascii?Q?pclIhmMEQJfwe6hb2CFCIrEGQ3zgkbwUImnKDxSS0c69gk3SZGLqpUrzcYbF?=
 =?us-ascii?Q?XRzUqpXbFMigPftIfqaG+vTDWbzjdLv4fTuL1rcTP1CWFSHzgLyKMSrXWDjz?=
 =?us-ascii?Q?QxXWWOlW6mWgEss8H9GVhMLpzxpe86/sJ4y64R/iwuOTT1K3POn9oLvGBIJD?=
 =?us-ascii?Q?VISc3PWb4Upxzjgq3oZTnmNGTphYBioEKsrRfyLvLYHk9xNq0noTCFTcVPN0?=
 =?us-ascii?Q?H7GpMjEZ8u9XxXUWHQXvUsryDGazzUoNL0eLZyMi3whUuK4rcX1x+kGNuAfq?=
 =?us-ascii?Q?za91P9q80vgyeAd+ee8tVfRSZqUluz9bawsXeyyJW0sybbL6+HX9Rg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0J60zWOYJGPmGxwoZGvIDXURv7J+F+gLhpxRdDyPF0w7HZqQrwPVtWwETegu?=
 =?us-ascii?Q?1uQgoJlnAgXUUgYtV7DKIMmKVtpY4XHpDV0xxJqlE/jPp52ZNtiJHw6cj/nQ?=
 =?us-ascii?Q?5VFOCmJp1s3DGCgRKtM5fryBx5ErR+eRyPsb+lzQ3byZfar4eU7VyBFK8ovr?=
 =?us-ascii?Q?VchhS1wq7P+jgow0nj4QVJTZueymQ+92IkO+bV5HqqylsQ2VGUnC2NRJHOvS?=
 =?us-ascii?Q?24JlCkXdKOYMKAR723DRFchWJsVfhiRdouWIxs9yElm/NqouGpMMyy7ZTD+8?=
 =?us-ascii?Q?ZhEdj/CFT39zo8Fg0DKOLzIgT75rO4tKQ/an4SNX9XUDer3uO4+D/oFX3WPg?=
 =?us-ascii?Q?18pUY2+P3CZRpFeL0kxqg5quN0tmUVAgG2CyKLNohVLvFRW9IZU2zMfy7NS/?=
 =?us-ascii?Q?H2SKfxQaYyroWzl9BCgf0L8TPmKOmxmKGv7yHHr46JBfPtLNw03ruhmJlgZU?=
 =?us-ascii?Q?qdHgu8bnFBhPeT64/3nPSa3gmkw+okCqlPzGhe5yiVD82Ldo+9RlANy5yxED?=
 =?us-ascii?Q?8m3ntjZIHXe3nZEw+qvb1OtU8A4vdXRBdW06dojcsch4+aUrhC9ziTDhmujW?=
 =?us-ascii?Q?L2eDALwC+oclEMnrLlKyJ04J9QDQST3FL8vdrfzxBNrd8PNDbvfgX65NzaOe?=
 =?us-ascii?Q?qyukSOxiHCf+J+6bCOHce4lGr1FizdIkjCWMtqv1lUjGM9uv5dOYPosKrf1d?=
 =?us-ascii?Q?eRHaaWp+P91EBlVUrvF3pfs3ZXhqYZ0Y59h+YfJLiSR7lfn9RHxwnUSx+/er?=
 =?us-ascii?Q?6mDBQHCAeOfxrFfldLOFhI2GckApdbkJfouriMG7ShGphvfuLdsZ0cQgmk+j?=
 =?us-ascii?Q?OcuwfAS41sf9ZVcBbbKIUW7A9XcMmbk3/dnSroHRPKwJ27PB15rmT6dogxj8?=
 =?us-ascii?Q?O1P3ExprusgBPfI/SsLWs1wJGPP4LcPxOmXd8ih15JssLggST8c3yhPInIlX?=
 =?us-ascii?Q?Jbf+EW3QDPjU12iFDncqz+ew1aDle6lyPwxiQ7PByKh/u1Mm9cvozo3Ay7mJ?=
 =?us-ascii?Q?eSWPry93g4DO1RaM7o+0SenFqkq/xlFSA2ka28VRh93Q3tqgOxhHg3XKD9Qr?=
 =?us-ascii?Q?XB0d4dr7cfDTfCY73UzSs8wkQJ6V4Nwovoham3R9CVyWTOV3gXxIQloYQGXG?=
 =?us-ascii?Q?3xhz+2/aO0Nl35e6pxYW4BuMPjabARBfjZuwJvS6rQop3Fn8JTIxMMldPo3j?=
 =?us-ascii?Q?Vytdzm6B+39M0mbs4hgIVZ9Xk4oIIh38BT2TvPFqtVUEfDWwYBxJeBa4g6WQ?=
 =?us-ascii?Q?sPzVKQnP7UJudZzB48uaDmWJ8BoZmsWNbAV9S8bqdvXTO890YEORaEY/i9hW?=
 =?us-ascii?Q?kSYiddJO0IDdoSrQnU8evvLT5NxKMlCtC4QIzLJepAdFJzYTuCLq96HDe+W6?=
 =?us-ascii?Q?FsLpQ/oOiJkNb3JlQfbogubQYH1ltRjlhyxsKrNaTSrKdtvOGat23J6vA8dc?=
 =?us-ascii?Q?CxJN07NWdRzV4hWZn8bVNjbVZN2F30IfMoj1t9QAPK0LYYnvHmwsPEurpXMo?=
 =?us-ascii?Q?ZhQKBtHQhM3ytTWyN+pULD6Ss6XOkrj7XZFcyyXt2/ea5HYNlk70lchA/5Vh?=
 =?us-ascii?Q?lzWWemlcWPc0qNlF+il6MaNDLXMCPN2eeiH2xsGqA9uGC6+xpPfRzkYN20Gw?=
 =?us-ascii?Q?yw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aaaffe7-bb2d-4ac7-8689-08ddfad9b5e8
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 19:45:12.5442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rCKAplKyH2+fQybJmj1+CEmoLrgWkDUf4qThOiGJP7qheegbS+PZ99hvxtks7MJaIU0GNiDZWqSs1VGJTZw4vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7352

The current approach of transitioning from one SerDes protocol to
another in lynx_28g_set_lane_mode() is too poetic.

Because the driver only supports 1GbE and 10GbE, it only modifies those
registers which it knows are different between these two modes. However,
that is hardly extensible for 25GbE, 40GbE, backplane modes, etc.

We need something more systematic to make sure that all lane and
protocol converter registers are written to consistent values, no matter
what was the source lane mode.

For that, we need to introduce tables with register field values, for
each supported lane mode.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2: fix LNaGCR0_PROTO_SEL | LNaGCR0_IF_WIDTH access by using
        FIELD_PREP()

 drivers/phy/freescale/phy-fsl-lynx-28g.c | 659 +++++++++++++++++------
 1 file changed, 496 insertions(+), 163 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-lynx-28g.c b/drivers/phy/freescale/phy-fsl-lynx-28g.c
index 41a346ac38e2..65eb00938b72 100644
--- a/drivers/phy/freescale/phy-fsl-lynx-28g.c
+++ b/drivers/phy/freescale/phy-fsl-lynx-28g.c
@@ -12,32 +12,32 @@
 #define LYNX_28G_NUM_LANE			8
 #define LYNX_28G_NUM_PLL			2
 
-#define LNa_PCC_OFFSET(lane)			(4 * (LYNX_28G_NUM_LANE - (lane->id) - 1))
-
-/* General registers per SerDes block */
+/* SoC IP wrapper for protocol converters */
 #define PCC8					0x10a0
-#define PCC8_SGMIInCFG(lane, x)			(((x) & GENMASK(2, 0)) << LNa_PCC_OFFSET(lane))
-#define PCC8_SGMIInCFG_EN(lane)			PCC8_SGMIInCFG(lane, 1)
-#define PCC8_SGMIInCFG_MSK(lane)		PCC8_SGMIInCFG(lane, GENMASK(2, 0))
-#define PCC8_SGMIIn_KX(lane, x)			((((x) << 3) & BIT(3)) << LNa_PCC_OFFSET(lane))
-#define PCC8_SGMIIn_KX_MSK(lane)		PCC8_SGMIIn_KX(lane, 1)
-#define PCC8_MSK(lane)				PCC8_SGMIInCFG_MSK(lane) | \
-						PCC8_SGMIIn_KX_MSK(lane)
+#define PCC8_SGMIIa_KX				BIT(3)
+#define PCC8_SGMIIa_CFG				BIT(0)
 
 #define PCCC					0x10b0
-#define PCCC_SXGMIInCFG(lane, x)		(((x) & GENMASK(2, 0)) << LNa_PCC_OFFSET(lane))
-#define PCCC_SXGMIInCFG_EN(lane)		PCCC_SXGMIInCFG(lane, 1)
-#define PCCC_SXGMIInCFG_MSK(lane)		PCCC_SXGMIInCFG(lane, GENMASK(2, 0))
-#define PCCC_SXGMIInCFG_XFI(lane, x)		((((x) << 3) & BIT(3)) << LNa_PCC_OFFSET(lane))
-#define PCCC_SXGMIInCFG_XFI_MSK(lane)		PCCC_SXGMIInCFG_XFI(lane, 1)
-#define PCCC_MSK(lane)				PCCC_SXGMIInCFG_MSK(lane) | \
-						PCCC_SXGMIInCFG_XFI_MSK(lane)
+#define PCCC_SXGMIIn_XFI			BIT(3)
+#define PCCC_SXGMIIn_CFG			BIT(0)
 
 #define PCCD					0x10b4
-#define PCCD_E25GnCFG(lane, x)			(((x) & GENMASK(2, 0)) << LNa_PCCD_OFFSET(lane))
-#define PCCD_E25GnCFG_EN(lane)			PCCD_E25GnCFG(lane, 1)
-#define PCCD_E25GnCFG_MSK(lane)			PCCD_E25GnCFG(lane, GENMASK(2, 0))
-#define PCCD_MSK(lane)				PCCD_E25GnCFG_MSK(lane)
+#define PCCD_E25Gn_CFG				BIT(0)
+
+#define PCCE					0x10b8
+#define PCCE_E40Gn_LRV				BIT(3)
+#define PCCE_E40Gn_CFG				BIT(0)
+#define PCCE_E50Gn_LRV				BIT(3)
+#define PCCE_E50GnCFG				BIT(0)
+#define PCCE_E100Gn_LRV				BIT(3)
+#define PCCE_E100Gn_CFG				BIT(0)
+
+#define SGMII_CFG(id)				(28 - (id) * 4) /* Offset into PCC8 */
+#define SXGMII_CFG(id)				(28 - (id) * 4) /* Offset into PCCC */
+#define E25G_CFG(id)				(28 - (id) * 4) /* Offset into PCCD */
+#define E40G_CFG(id)				(28 - (id) * 4) /* Offset into PCCE */
+#define E50G_CFG(id)				(20 - (id) * 4) /* Offset into PCCE */
+#define E100G_CFG(id)				(12 - (id) * 4) /* Offset into PCCE */
 
 /* Per PLL registers */
 #define PLLnRSTCTL(pll)				(0x400 + (pll) * 0x100 + 0x0)
@@ -92,6 +92,10 @@
 #define LNaTECR0_EQ_POST1Q			GENMASK(12, 8)
 #define LNaTECR0_EQ_AMP_RED			GENMASK(5, 0)
 
+#define LNaTECR1(lane)				(0x800 + (lane) * 0x100 + 0x34)
+#define LNaTECR1_EQ_ADPT_EQ_DRVR_DIS		BIT(31)
+#define LNaTECR1_EQ_ADPT_EQ			GENMASK(29, 24)
+
 /* Lane a Rx Reset Control Register */
 #define LNaRRSTCTL(lane)			(0x800 + (lane) * 0x100 + 0x40)
 #define LNaRRSTCTL_HLT_REQ			BIT(27)
@@ -147,6 +151,21 @@
 #define LNaRECR2_EQ_BIN_DATA_AVG_TC		GENMASK(5, 4)
 #define LNaRECR2_SPARE_IN			GENMASK(1, 0)
 
+#define LNaRECR3(lane)				(0x800 + (lane) * 0x100 + 0x5c)
+#define LNaRECR3_EQ_SNAP_START			BIT(31)
+#define LNaRECR3_EQ_SNAP_DONE			BIT(30)
+#define LNaRECR3_EQ_GAINK2_HF_STAT		GENMASK(28, 24)
+#define LNaRECR3_EQ_GAINK3_MF_STAT		GENMASK(20, 16)
+#define LNaRECR3_SPARE_OUT			GENMASK(13, 12)
+#define LNaRECR3_EQ_GAINK4_LF_STAT		GENMASK(4, 0)
+
+#define LNaRECR4(lane)				(0x800 + (lane) * 0x100 + 0x60)
+#define LNaRECR4_BLW_STAT			GENMASK(28, 24)
+#define LNaRECR4_EQ_OFFSET_STAT			GENMASK(21, 16)
+#define LNaRECR4_EQ_BIN_DATA_SEL		GENMASK(15, 12)
+#define LNaRECR4_EQ_BIN_DATA			GENMASK(8, 0) /* bit 9 is reserved */
+#define LNaRECR4_EQ_BIN_DATA_SGN		BIT(8)
+
 #define LNaRSCCR0(lane)				(0x800 + (lane) * 0x100 + 0x74)
 #define LNaRSCCR0_SMP_OFF_EN			BIT(31)
 #define LNaRSCCR0_SMP_OFF_OV_EN			BIT(30)
@@ -161,20 +180,199 @@
 #define LNaRSCCR0_SMP_AUTOZ_EG1R		GENMASK(5, 4)
 #define LNaRSCCR0_SMP_AUTOZ_EG1F		GENMASK(1, 0)
 
+#define LNaTCSR0(lane)				(0x800 + (lane) * 0x100 + 0xa0)
+#define LNaTCSR0_SD_STAT_OBS_EN			BIT(31)
+#define LNaTCSR0_SD_LPBK_SEL			GENMASK(29, 28)
+
 #define LNaPSS(lane)				(0x1000 + (lane) * 0x4)
 #define LNaPSS_TYPE				GENMASK(30, 24)
-#define LNaPSS_TYPE_SGMII			0x4
-#define LNaPSS_TYPE_XFI				0x28
+#define LNaPSS_TYPE_SGMII			(PROTO_SEL_SGMII_BASEX_KX << 2)
+#define LNaPSS_TYPE_XFI				(PROTO_SEL_XFI_10GBASER_KR_SXGMII << 2)
+#define LNaPSS_TYPE_40G				((PROTO_SEL_XFI_10GBASER_KR_SXGMII << 2) | 3)
+#define LNaPSS_TYPE_25G				(PROTO_SEL_25G_50G_100G << 2)
+#define LNaPSS_TYPE_100G			((PROTO_SEL_25G_50G_100G << 2) | 2)
 
+/* MDEV_PORT is at the same bitfield address for all protocol converters */
+#define MDEV_PORT				GENMASK(31, 27)
+
+#define SGMIIaCR0(lane)				(0x1800 + (lane) * 0x10)
 #define SGMIIaCR1(lane)				(0x1804 + (lane) * 0x10)
 #define SGMIIaCR1_SGPCS_EN			BIT(11)
 
+#define ANLTaCR0(lane)				(0x1a00 + (lane) * 0x10)
+#define ANLTaCR1(lane)				(0x1a04 + (lane) * 0x10)
+
+#define SXGMIIaCR0(lane)			(0x1a80 + (lane) * 0x10)
+#define SXGMIIaCR0_RST				BIT(31)
+#define SXGMIIaCR0_PD				BIT(30)
+
+#define SXGMIIaCR1(lane)			(0x1a84 + (lane) * 0x10)
+
+#define E25GaCR0(lane)				(0x1b00 + (lane) * 0x10)
+#define E25GaCR0_RST				BIT(31)
+#define E25GaCR0_PD				BIT(30)
+
+#define E25GaCR1(lane)				(0x1b04 + (lane) * 0x10)
+
+#define E25GaCR2(lane)				(0x1b08 + (lane) * 0x10)
+#define E25GaCR2_FEC_ENA			BIT(23)
+#define E25GaCR2_FEC_ERR_ENA			BIT(22)
+#define E25GaCR2_FEC91_ENA			BIT(20)
+
+#define E40GaCR0(pcvt)				(0x1b40 + (pcvt) * 0x20)
+#define E40GaCR1(pcvt)				(0x1b44 + (pcvt) * 0x20)
+
+#define E50GaCR1(pcvt)				(0x1b84 + (pcvt) * 0x10)
+
+#define E100GaCR1(pcvt)				(0x1c04 + (pcvt) * 0x20)
+
+#define CR(x)					((x) * 4)
+
 enum lynx_28g_eq_type {
 	EQ_TYPE_NO_EQ = 0,
 	EQ_TYPE_2TAP = 1,
 	EQ_TYPE_3TAP = 2,
 };
 
+enum lynx_28g_proto_sel {
+	PROTO_SEL_PCIE = 0,
+	PROTO_SEL_SGMII_BASEX_KX = 1,
+	PROTO_SEL_SATA = 2,
+	PROTO_SEL_XAUI = 4,
+	PROTO_SEL_XFI_10GBASER_KR_SXGMII = 0xa,
+	PROTO_SEL_25G_50G_100G = 0x1a,
+};
+
+struct lynx_28g_proto_conf {
+	/* LNaGCR0 */
+	int proto_sel;
+	int if_width;
+	/* LNaTECR0 */
+	int teq_type;
+	int sgn_preq;
+	int ratio_preq;
+	int sgn_post1q;
+	int ratio_post1q;
+	int amp_red;
+	/* LNaTECR1 */
+	int adpt_eq;
+	/* LNaRGCR1 */
+	int enter_idle_flt_sel;
+	int exit_idle_flt_sel;
+	int data_lost_th_sel;
+	/* LNaRECR0 */
+	int gk2ovd;
+	int gk3ovd;
+	int gk4ovd;
+	int gk2ovd_en;
+	int gk3ovd_en;
+	int gk4ovd_en;
+	/* LNaRECR1 ? */
+	int eq_offset_ovd;
+	int eq_offset_ovd_en;
+	/* LNaRECR2 */
+	int eq_offset_rng_dbl;
+	int eq_blw_sel;
+	int eq_boost;
+	int spare_in;
+	/* LNaRSCCR0 */
+	int smp_autoz_d1r;
+	int smp_autoz_eg1r;
+};
+
+static const struct lynx_28g_proto_conf lynx_28g_proto_conf[PHY_INTERFACE_MODE_MAX] = {
+	[PHY_INTERFACE_MODE_SGMII] = {
+		.proto_sel = LNaGCR0_PROTO_SEL_SGMII,
+		.if_width = LNaGCR0_IF_WIDTH_10_BIT,
+		.teq_type = EQ_TYPE_NO_EQ,
+		.sgn_preq = 1,
+		.ratio_preq = 0,
+		.sgn_post1q = 1,
+		.ratio_post1q = 0,
+		.amp_red = 6,
+		.adpt_eq = 48,
+		.enter_idle_flt_sel = 4,
+		.exit_idle_flt_sel = 3,
+		.data_lost_th_sel = 1,
+		.gk2ovd = 0x1f,
+		.gk3ovd = 0,
+		.gk4ovd = 0,
+		.gk2ovd_en = 1,
+		.gk3ovd_en = 1,
+		.gk4ovd_en = 0,
+		.eq_offset_ovd = 0x1f,
+		.eq_offset_ovd_en = 0,
+		.eq_offset_rng_dbl = 0,
+		.eq_blw_sel = 0,
+		.eq_boost = 0,
+		.spare_in = 0,
+		.smp_autoz_d1r = 0,
+		.smp_autoz_eg1r = 0,
+	},
+	[PHY_INTERFACE_MODE_1000BASEX] = {
+		.proto_sel = LNaGCR0_PROTO_SEL_SGMII,
+		.if_width = LNaGCR0_IF_WIDTH_10_BIT,
+		.teq_type = EQ_TYPE_NO_EQ,
+		.sgn_preq = 1,
+		.ratio_preq = 0,
+		.sgn_post1q = 1,
+		.ratio_post1q = 0,
+		.amp_red = 6,
+		.adpt_eq = 48,
+		.enter_idle_flt_sel = 4,
+		.exit_idle_flt_sel = 3,
+		.data_lost_th_sel = 1,
+		.gk2ovd = 0x1f,
+		.gk3ovd = 0,
+		.gk4ovd = 0,
+		.gk2ovd_en = 1,
+		.gk3ovd_en = 1,
+		.gk4ovd_en = 0,
+		.eq_offset_ovd = 0x1f,
+		.eq_offset_ovd_en = 0,
+		.eq_offset_rng_dbl = 0,
+		.eq_blw_sel = 0,
+		.eq_boost = 0,
+		.spare_in = 0,
+		.smp_autoz_d1r = 0,
+		.smp_autoz_eg1r = 0,
+	},
+	[PHY_INTERFACE_MODE_10GBASER] = {
+		.proto_sel = LNaGCR0_PROTO_SEL_XFI,
+		.if_width = LNaGCR0_IF_WIDTH_20_BIT,
+		.teq_type = EQ_TYPE_2TAP,
+		.sgn_preq = 1,
+		.ratio_preq = 0,
+		.sgn_post1q = 1,
+		.ratio_post1q = 3,
+		.amp_red = 7,
+		.adpt_eq = 48,
+		.enter_idle_flt_sel = 0,
+		.exit_idle_flt_sel = 0,
+		.data_lost_th_sel = 0,
+		.gk2ovd = 0,
+		.gk3ovd = 0,
+		.gk4ovd = 0,
+		.gk2ovd_en = 0,
+		.gk3ovd_en = 0,
+		.gk4ovd_en = 0,
+		.eq_offset_ovd = 0x1f,
+		.eq_offset_ovd_en = 0,
+		.eq_offset_rng_dbl = 1,
+		.eq_blw_sel = 1,
+		.eq_boost = 0,
+		.spare_in = 0,
+		.smp_autoz_d1r = 2,
+		.smp_autoz_eg1r = 0,
+	},
+};
+
+struct lynx_pccr {
+	int offset;
+	int width;
+	int shift;
+};
+
 struct lynx_28g_priv;
 
 struct lynx_28g_pll {
@@ -218,6 +416,10 @@ static void lynx_28g_rmw(struct lynx_28g_priv *priv, unsigned long off,
 	iowrite32(tmp, reg);
 }
 
+#define lynx_28g_read(priv, off) \
+	ioread32((priv)->base + (off))
+#define lynx_28g_write(priv, off, val) \
+	iowrite32(val, (priv)->base + (off))
 #define lynx_28g_lane_rmw(lane, reg, val, mask)	\
 	lynx_28g_rmw((lane)->priv, reg(lane->id), val, mask)
 #define lynx_28g_lane_read(lane, reg)			\
@@ -326,130 +528,6 @@ static void lynx_28g_lane_set_pll(struct lynx_28g_lane *lane,
 	}
 }
 
-static void lynx_28g_cleanup_lane(struct lynx_28g_lane *lane)
-{
-	struct lynx_28g_priv *priv = lane->priv;
-
-	/* Cleanup the protocol configuration registers of the current protocol */
-	switch (lane->interface) {
-	case PHY_INTERFACE_MODE_10GBASER:
-		/* Cleanup the protocol configuration registers */
-		lynx_28g_rmw(priv, PCCC, 0, PCCC_MSK(lane));
-		break;
-	case PHY_INTERFACE_MODE_SGMII:
-	case PHY_INTERFACE_MODE_1000BASEX:
-		/* Cleanup the protocol configuration registers */
-		lynx_28g_rmw(priv, PCC8, 0, PCC8_MSK(lane));
-
-		/* Disable the SGMII PCS */
-		lynx_28g_lane_rmw(lane, SGMIIaCR1, 0, SGMIIaCR1_SGPCS_EN);
-
-		break;
-	default:
-		break;
-	}
-}
-
-static void lynx_28g_lane_set_sgmii(struct lynx_28g_lane *lane)
-{
-	struct lynx_28g_priv *priv = lane->priv;
-	struct lynx_28g_pll *pll;
-
-	lynx_28g_cleanup_lane(lane);
-
-	/* Setup the lane to run in SGMII */
-	lynx_28g_rmw(priv, PCC8, PCC8_SGMIInCFG_EN(lane), PCC8_MSK(lane));
-
-	/* Setup the protocol select and SerDes parallel interface width */
-	lynx_28g_lane_rmw(lane, LNaGCR0,
-			  FIELD_PREP(LNaGCR0_PROTO_SEL, LNaGCR0_PROTO_SEL_SGMII) |
-			  FIELD_PREP(LNaGCR0_IF_WIDTH, LNaGCR0_IF_WIDTH_10_BIT),
-			  LNaGCR0_PROTO_SEL | LNaGCR0_IF_WIDTH);
-
-	/* Find the PLL that works with this interface type */
-	pll = lynx_28g_pll_get(priv, PHY_INTERFACE_MODE_SGMII);
-	if (unlikely(pll == NULL))
-		return;
-
-	/* Switch to the PLL that works with this interface type */
-	lynx_28g_lane_set_pll(lane, pll);
-
-	/* Choose the portion of clock net to be used on this lane */
-	lynx_28g_lane_set_nrate(lane, pll, PHY_INTERFACE_MODE_SGMII);
-
-	/* Enable the SGMII PCS */
-	lynx_28g_lane_rmw(lane, SGMIIaCR1, SGMIIaCR1_SGPCS_EN,
-			  SGMIIaCR1_SGPCS_EN);
-
-	/* Configure the appropriate equalization parameters for the protocol */
-	lynx_28g_lane_write(lane, LNaTECR0,
-			    LNaTECR0_EQ_SGN_PREQ | LNaTECR0_EQ_SGN_POST1Q |
-			    FIELD_PREP(LNaTECR0_EQ_AMP_RED, 6));
-	lynx_28g_lane_write(lane, LNaRGCR1,
-			    FIELD_PREP(LNaRGCR1_ENTER_IDLE_FLT_SEL, 4) |
-			    FIELD_PREP(LNaRGCR1_EXIT_IDLE_FLT_SEL, 3) |
-			    LNaRGCR1_DATA_LOST_FLT);
-	lynx_28g_lane_write(lane, LNaRECR0,
-			    LNaRECR0_EQ_GAINK2_HF_OV_EN |
-			    FIELD_PREP(LNaRECR0_EQ_GAINK2_HF_OV, 31) |
-			    LNaRECR0_EQ_GAINK3_MF_OV_EN |
-			    FIELD_PREP(LNaRECR0_EQ_GAINK3_MF_OV, 0));
-	lynx_28g_lane_write(lane, LNaRECR1,
-			    FIELD_PREP(LNaRECR1_EQ_OFFSET_OV, 31));
-	lynx_28g_lane_write(lane, LNaRECR2, 0);
-	lynx_28g_lane_write(lane, LNaRSCCR0, 0);
-}
-
-static void lynx_28g_lane_set_10gbaser(struct lynx_28g_lane *lane)
-{
-	struct lynx_28g_priv *priv = lane->priv;
-	struct lynx_28g_pll *pll;
-
-	lynx_28g_cleanup_lane(lane);
-
-	/* Enable the SXGMII lane */
-	lynx_28g_rmw(priv, PCCC, PCCC_SXGMIInCFG_EN(lane) |
-		     PCCC_SXGMIInCFG_XFI(lane, 1), PCCC_MSK(lane));
-
-	/* Setup the protocol select and SerDes parallel interface width */
-	lynx_28g_lane_rmw(lane, LNaGCR0,
-			  FIELD_PREP(LNaGCR0_PROTO_SEL, LNaGCR0_PROTO_SEL_XFI) |
-			  FIELD_PREP(LNaGCR0_IF_WIDTH, LNaGCR0_IF_WIDTH_20_BIT),
-			  LNaGCR0_PROTO_SEL | LNaGCR0_IF_WIDTH);
-
-	/* Find the PLL that works with this interface type */
-	pll = lynx_28g_pll_get(priv, PHY_INTERFACE_MODE_10GBASER);
-	if (unlikely(pll == NULL))
-		return;
-
-	/* Switch to the PLL that works with this interface type */
-	lynx_28g_lane_set_pll(lane, pll);
-
-	/* Choose the portion of clock net to be used on this lane */
-	lynx_28g_lane_set_nrate(lane, pll, PHY_INTERFACE_MODE_10GBASER);
-
-	/* Disable the SGMII PCS */
-	lynx_28g_lane_rmw(lane, SGMIIaCR1, 0, SGMIIaCR1_SGPCS_EN);
-
-	/* Configure the appropriate equalization parameters for the protocol */
-	lynx_28g_lane_write(lane, LNaTECR0,
-			    FIELD_PREP(LNaTECR0_EQ_TYPE, EQ_TYPE_2TAP) |
-			    LNaTECR0_EQ_SGN_PREQ |
-			    FIELD_PREP(LNaTECR0_EQ_PREQ, 0) |
-			    LNaTECR0_EQ_SGN_POST1Q |
-			    FIELD_PREP(LNaTECR0_EQ_POST1Q, 3) |
-			    FIELD_PREP(LNaTECR0_EQ_AMP_RED, 7));
-	lynx_28g_lane_write(lane, LNaRGCR1, LNaRGCR1_IDLE_CONFIG);
-	lynx_28g_lane_write(lane, LNaRECR0, 0);
-	lynx_28g_lane_write(lane, LNaRECR1, FIELD_PREP(LNaRECR1_EQ_OFFSET_OV, 31));
-	lynx_28g_lane_write(lane, LNaRECR2,
-			    LNaRECR2_EQ_OFFSET_RNG_DBL |
-			    FIELD_PREP(LNaRECR2_EQ_BLW_SEL, 1) |
-			    FIELD_PREP(LNaRECR2_EQ_BIN_DATA_AVG_TC, 2));
-	lynx_28g_lane_write(lane, LNaRSCCR0,
-			    FIELD_PREP(LNaRSCCR0_SMP_AUTOZ_D1R, 2));
-}
-
 static int lynx_28g_power_off(struct phy *phy)
 {
 	struct lynx_28g_lane *lane = phy_get_drvdata(phy);
@@ -502,6 +580,268 @@ static int lynx_28g_power_on(struct phy *phy)
 	return 0;
 }
 
+static int lynx_28g_get_pccr(phy_interface_t interface, int lane,
+			     struct lynx_pccr *pccr)
+{
+	switch (interface) {
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_1000BASEX:
+		pccr->offset = PCC8;
+		pccr->width = 4;
+		pccr->shift = SGMII_CFG(lane);
+		break;
+	case PHY_INTERFACE_MODE_10GBASER:
+		pccr->offset = PCCC;
+		pccr->width = 4;
+		pccr->shift = SXGMII_CFG(lane);
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static int lynx_28g_get_pcvt_offset(int lane, phy_interface_t interface)
+{
+	switch (interface) {
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_1000BASEX:
+		return SGMIIaCR0(lane);
+	case PHY_INTERFACE_MODE_10GBASER:
+		return SXGMIIaCR0(lane);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int lynx_pccr_write(struct lynx_28g_lane *lane,
+			   phy_interface_t interface, u32 val)
+{
+	struct lynx_28g_priv *priv = lane->priv;
+	struct lynx_pccr pccr;
+	u32 old, tmp, mask;
+	int err;
+
+	err = lynx_28g_get_pccr(interface, lane->id, &pccr);
+	if (err)
+		return err;
+
+	old = lynx_28g_read(priv, pccr.offset);
+	mask = GENMASK(pccr.width - 1, 0) << pccr.shift;
+	tmp = (old & ~mask) | (val << pccr.shift);
+	lynx_28g_write(priv, pccr.offset, tmp);
+
+	dev_dbg(&lane->phy->dev, "PCCR@0x%x: 0x%x -> 0x%x\n",
+		pccr.offset, old, tmp);
+
+	return 0;
+}
+
+static int lynx_pcvt_read(struct lynx_28g_lane *lane, phy_interface_t interface,
+			  int cr, u32 *val)
+{
+	struct lynx_28g_priv *priv = lane->priv;
+	int offset;
+
+	offset = lynx_28g_get_pcvt_offset(lane->id, interface);
+	if (offset < 0)
+		return offset;
+
+	*val = lynx_28g_read(priv, offset + cr);
+
+	return 0;
+}
+
+static int lynx_pcvt_write(struct lynx_28g_lane *lane, phy_interface_t interface,
+			   int cr, u32 val)
+{
+	struct lynx_28g_priv *priv = lane->priv;
+	int offset;
+
+	offset = lynx_28g_get_pcvt_offset(lane->id, interface);
+	if (offset < 0)
+		return offset;
+
+	lynx_28g_write(priv, offset + cr, val);
+
+	return 0;
+}
+
+static int lynx_pcvt_rmw(struct lynx_28g_lane *lane, phy_interface_t interface,
+			 int cr, u32 val, u32 mask)
+{
+	int err;
+	u32 tmp;
+
+	err = lynx_pcvt_read(lane, interface, cr, &tmp);
+	if (err)
+		return err;
+
+	tmp &= ~mask;
+	tmp |= val;
+
+	return lynx_pcvt_write(lane, interface, cr, tmp);
+}
+
+static void lynx_28g_lane_remap_pll(struct lynx_28g_lane *lane,
+				    phy_interface_t interface)
+{
+	struct lynx_28g_priv *priv = lane->priv;
+	struct lynx_28g_pll *pll;
+
+	/* Switch to the PLL that works with this interface type */
+	pll = lynx_28g_pll_get(priv, interface);
+	if (unlikely(pll == NULL))
+		return;
+
+	lynx_28g_lane_set_pll(lane, pll);
+
+	/* Choose the portion of clock net to be used on this lane */
+	lynx_28g_lane_set_nrate(lane, pll, interface);
+}
+
+static void lynx_28g_lane_change_proto_conf(struct lynx_28g_lane *lane,
+					    phy_interface_t interface)
+{
+	const struct lynx_28g_proto_conf *conf = &lynx_28g_proto_conf[interface];
+
+	lynx_28g_lane_rmw(lane, LNaGCR0,
+			  FIELD_PREP(LNaGCR0_PROTO_SEL, conf->proto_sel) |
+			  FIELD_PREP(LNaGCR0_IF_WIDTH, conf->if_width),
+			  LNaGCR0_PROTO_SEL | LNaGCR0_IF_WIDTH);
+
+	lynx_28g_lane_rmw(lane, LNaTECR0,
+			  FIELD_PREP(LNaTECR0_EQ_TYPE, conf->teq_type) |
+			  FIELD_PREP(LNaTECR0_EQ_SGN_PREQ, conf->sgn_preq) |
+			  FIELD_PREP(LNaTECR0_EQ_PREQ, conf->ratio_preq) |
+			  FIELD_PREP(LNaTECR0_EQ_SGN_POST1Q, conf->sgn_post1q) |
+			  FIELD_PREP(LNaTECR0_EQ_POST1Q, conf->ratio_post1q) |
+			  FIELD_PREP(LNaTECR0_EQ_AMP_RED, conf->amp_red),
+			  LNaTECR0_EQ_TYPE |
+			  LNaTECR0_EQ_SGN_PREQ |
+			  LNaTECR0_EQ_PREQ |
+			  LNaTECR0_EQ_SGN_POST1Q |
+			  LNaTECR0_EQ_POST1Q |
+			  LNaTECR0_EQ_AMP_RED);
+
+	lynx_28g_lane_rmw(lane, LNaTECR1,
+			  FIELD_PREP(LNaTECR1_EQ_ADPT_EQ, conf->adpt_eq),
+			  LNaTECR1_EQ_ADPT_EQ);
+
+	lynx_28g_lane_rmw(lane, LNaRGCR1,
+			  FIELD_PREP(LNaRGCR1_ENTER_IDLE_FLT_SEL, conf->enter_idle_flt_sel) |
+			  FIELD_PREP(LNaRGCR1_EXIT_IDLE_FLT_SEL, conf->exit_idle_flt_sel) |
+			  FIELD_PREP(LNaRGCR1_DATA_LOST_TH_SEL, conf->data_lost_th_sel),
+			  LNaRGCR1_ENTER_IDLE_FLT_SEL |
+			  LNaRGCR1_EXIT_IDLE_FLT_SEL |
+			  LNaRGCR1_DATA_LOST_TH_SEL);
+
+	lynx_28g_lane_rmw(lane, LNaRECR0,
+			  FIELD_PREP(LNaRECR0_EQ_GAINK2_HF_OV_EN, conf->gk2ovd_en) |
+			  FIELD_PREP(LNaRECR0_EQ_GAINK3_MF_OV_EN, conf->gk3ovd_en) |
+			  FIELD_PREP(LNaRECR0_EQ_GAINK4_LF_OV_EN, conf->gk4ovd_en) |
+			  FIELD_PREP(LNaRECR0_EQ_GAINK2_HF_OV, conf->gk2ovd) |
+			  FIELD_PREP(LNaRECR0_EQ_GAINK3_MF_OV, conf->gk3ovd) |
+			  FIELD_PREP(LNaRECR0_EQ_GAINK4_LF_OV, conf->gk4ovd),
+			  LNaRECR0_EQ_GAINK2_HF_OV |
+			  LNaRECR0_EQ_GAINK3_MF_OV |
+			  LNaRECR0_EQ_GAINK4_LF_OV |
+			  LNaRECR0_EQ_GAINK2_HF_OV_EN |
+			  LNaRECR0_EQ_GAINK3_MF_OV_EN |
+			  LNaRECR0_EQ_GAINK4_LF_OV_EN);
+
+	lynx_28g_lane_rmw(lane, LNaRECR1,
+			  FIELD_PREP(LNaRECR1_EQ_OFFSET_OV, conf->eq_offset_ovd) |
+			  FIELD_PREP(LNaRECR1_EQ_OFFSET_OV_EN, conf->eq_offset_ovd_en),
+			  LNaRECR1_EQ_OFFSET_OV |
+			  LNaRECR1_EQ_OFFSET_OV_EN);
+
+	lynx_28g_lane_rmw(lane, LNaRECR2,
+			  FIELD_PREP(LNaRECR2_EQ_OFFSET_RNG_DBL, conf->eq_offset_rng_dbl) |
+			  FIELD_PREP(LNaRECR2_EQ_BLW_SEL, conf->eq_blw_sel) |
+			  FIELD_PREP(LNaRECR2_EQ_BOOST, conf->eq_boost) |
+			  FIELD_PREP(LNaRECR2_SPARE_IN, conf->spare_in),
+			  LNaRECR2_EQ_OFFSET_RNG_DBL |
+			  LNaRECR2_EQ_BLW_SEL |
+			  LNaRECR2_EQ_BOOST |
+			  LNaRECR2_SPARE_IN);
+
+	lynx_28g_lane_rmw(lane, LNaRSCCR0,
+			  FIELD_PREP(LNaRSCCR0_SMP_AUTOZ_D1R, conf->smp_autoz_d1r) |
+			  FIELD_PREP(LNaRSCCR0_SMP_AUTOZ_EG1R, conf->smp_autoz_eg1r),
+			  LNaRSCCR0_SMP_AUTOZ_D1R |
+			  LNaRSCCR0_SMP_AUTOZ_EG1R);
+}
+
+static int lynx_28g_lane_disable_pcvt(struct lynx_28g_lane *lane,
+				      phy_interface_t interface)
+{
+	struct lynx_28g_priv *priv = lane->priv;
+	int err;
+
+	spin_lock(&priv->pcc_lock);
+
+	err = lynx_pccr_write(lane, interface, 0);
+	if (err)
+		goto out;
+
+	switch (interface) {
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_1000BASEX:
+		err = lynx_pcvt_rmw(lane, interface, CR(1), 0,
+				    SGMIIaCR1_SGPCS_EN);
+		break;
+	default:
+		err = 0;
+	}
+
+out:
+	spin_unlock(&priv->pcc_lock);
+
+	return err;
+}
+
+static int lynx_28g_lane_enable_pcvt(struct lynx_28g_lane *lane,
+				     phy_interface_t interface)
+{
+	struct lynx_28g_priv *priv = lane->priv;
+	u32 val;
+	int err;
+
+	spin_lock(&priv->pcc_lock);
+
+	switch (interface) {
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_1000BASEX:
+		err = lynx_pcvt_rmw(lane, interface, CR(1), SGMIIaCR1_SGPCS_EN,
+				    SGMIIaCR1_SGPCS_EN);
+		break;
+	default:
+		err = 0;
+	}
+
+	val = 0;
+
+	switch (interface) {
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_1000BASEX:
+		val |= PCC8_SGMIIa_CFG;
+		break;
+	case PHY_INTERFACE_MODE_10GBASER:
+		val |= PCCC_SXGMIIn_CFG | PCCC_SXGMIIn_XFI;
+		break;
+	default:
+		break;
+	}
+
+	err = lynx_pccr_write(lane, interface, val);
+
+	spin_unlock(&priv->pcc_lock);
+
+	return err;
+}
+
 static int lynx_28g_set_mode(struct phy *phy, enum phy_mode mode, int submode)
 {
 	struct lynx_28g_lane *lane = phy_get_drvdata(phy);
@@ -518,33 +858,26 @@ static int lynx_28g_set_mode(struct phy *phy, enum phy_mode mode, int submode)
 	if (!lynx_28g_supports_interface(priv, submode))
 		return -EOPNOTSUPP;
 
+	if (submode == lane->interface)
+		return 0;
+
 	/* If the lane is powered up, put the lane into the halt state while
 	 * the reconfiguration is being done.
 	 */
 	if (powered_up)
 		lynx_28g_power_off(phy);
 
-	spin_lock(&priv->pcc_lock);
-
-	switch (submode) {
-	case PHY_INTERFACE_MODE_SGMII:
-	case PHY_INTERFACE_MODE_1000BASEX:
-		lynx_28g_lane_set_sgmii(lane);
-		break;
-	case PHY_INTERFACE_MODE_10GBASER:
-		lynx_28g_lane_set_10gbaser(lane);
-		break;
-	default:
-		err = -EOPNOTSUPP;
+	err = lynx_28g_lane_disable_pcvt(lane, lane->interface);
+	if (err)
 		goto out;
-	}
+
+	lynx_28g_lane_change_proto_conf(lane, submode);
+	lynx_28g_lane_remap_pll(lane, submode);
+	WARN_ON(lynx_28g_lane_enable_pcvt(lane, submode));
 
 	lane->interface = submode;
 
 out:
-	spin_unlock(&priv->pcc_lock);
-
-	/* Power up the lane if necessary */
 	if (powered_up)
 		lynx_28g_power_on(phy);
 
-- 
2.34.1


