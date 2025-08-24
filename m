Return-Path: <linux-kernel+bounces-783719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F90B33198
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 19:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD9EB2032C7
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 17:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2CE2DF6EA;
	Sun, 24 Aug 2025 17:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="PfeJNVxe"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021093.outbound.protection.outlook.com [52.101.65.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1E9275AED
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 17:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756055628; cv=fail; b=Qtxk27Ebho9B+MIZSzsXzvHXdLXctHfDE5cpbQYw9v1RTHTmiAoXiWRa7V4LjvyySpTrtx54WvuRawxEfULA8CLFobueq/Cf+lZ4zhZJjVsuutkdDiiiQ2t4HGM02nSXXOvsuiD2FHKTw0ixkKbzXcJoWHER5/Ftqop/mOhYNxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756055628; c=relaxed/simple;
	bh=enXdG3k2lP8+ILqzF+56q4R63zfqfspac6Ynz69H75Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pWT6rkGIliKrjikTY65ydDJfuAYwynjYShNNcB3D/nxxzx9w64ME1Y5SiYtyuSHJAjd39On9BpX1aqNg1BbjYrL8fgwPRZN73C3Ogio0Q0UgtxnOoe5oPNtsFByOcjaYQ/WCmFMZDTDCqXA5Rumf9IeqUjEaW5Lr3jqvfJvh6Jo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=PfeJNVxe; arc=fail smtp.client-ip=52.101.65.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=amUQsgT1F3nS1uDkvsSNgMBaM3NL7ZDki67+NV8yutzvVJV4X0V8xaR/1/TSF3QWUUvK4X8zCUau+3s2e3UnNqXpeyFUjgdqeoPrV4jwJ0gkt1yYckXWYKCx3DP/yjQV6pOQOI40HGWWdsb7FoPbstpKf93Q4RbLTcX/h8Ei5xPAolvcDLIu8cJxT28hWcq+p3K05l3t+TlowtZulwcK5JjMcC0IaJpRPvzT8so5/Ac/hoC3X0R0BxYHD1Y9pmbAAGcZdPWgC9C7jx71fzJGJmxmTO6lL8GqJZjIsPwIXU3j/tPnrmxa6ZBggvenmkXhSkSb6vbF/PzmZiBg64eogQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CQATUBF0fnU0xBIpNZ0UIwL9CHxB3T/bvR2BEeSydgQ=;
 b=d6gkIgXtYHkglWUSEPVLJSsIGioiMEQwYstlHHXHEOHp3KQvLO2CYOWdrIlvPJaeB05Ct3Z8dM+zPAd8GJ0LxohaVGXTTrTSTlfNKmtMjcIDkEOJthS/K0cIhWd4/RRF3/7ThBNRhB3wvj+CGVl/En8jwu0jT9qhxMZRljz/rFhjJ7UFkHCv4SggAQVL0XKUtySlix3PKZFYUaxayvBrS9C2s2zpYJBiu1bjjNFYvg+PMfg49x3ZVJI/K4CUHO8HM0sX1qVDP1L+FLg938TvRtAWwfJIV/d2sW/UPo8JMxBseO0krL3q+lvTU42i0x3VLFLMppPZj5l7hyEpGLcbUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQATUBF0fnU0xBIpNZ0UIwL9CHxB3T/bvR2BEeSydgQ=;
 b=PfeJNVxecKcd/q3dPk49XugPwQIgGsVFyQfFdF+fy20FVbQt+hbUVKQEZexImrQOA8ckWmr1Hph6aEo8PiJ8vNoCJN+OVh6zvn00xE4P/oF1jk3fxJOqRZJViROAzDdSNlO+OshmgTSiLNnlrl7M2OvUZ8Hu3DZJy4EHlE54bxJkXieAxgZVB1Ao2WO/bBaZ77JSrnHKw+w3iz8CWwKEqtFdfI3R4qVpRn2+Zsfkf9zyk1w27uPmub8synIAcBU+Ii33VXMlWNqX9GT4TnR7W2FO0d4m33ARZTDMOylIQ3b99NrDVdbb7N8jYPcmvPwbmBG4NWZy1zZwZiwr+OLD0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB7908.eurprd08.prod.outlook.com (2603:10a6:10:3b0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Sun, 24 Aug
 2025 17:13:42 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Sun, 24 Aug 2025
 17:13:42 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Martin Kurbanov <mmkurbanov@salutedevices.com>,
	Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
	Cheng Ming Lin <chengminglin@mxic.com.tw>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v4 2/3] mtd: spinand: try a regular dirmap if creating a dirmap for continuous reading fails
Date: Sun, 24 Aug 2025 20:13:30 +0300
Message-ID: <20250824171331.3964537-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250824171331.3964537-1-mikhail.kshevetskiy@iopsys.eu>
References: <87bjo4it13.fsf@bootlin.com>
 <20250824171331.3964537-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF00004530.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::359) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB7908:EE_
X-MS-Office365-Filtering-Correlation-Id: f3953b94-cdf0-4a31-3051-08dde3319387
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y4vIua6XaxEdDKyFo0ibRvXGloJD2Hx5icoGtJtbauDp/G/oPXno5rOSpcBJ?=
 =?us-ascii?Q?w1pGddqH62mVZ9DueV45BvqPtw1D6oTFJC2P7mACx0txUV1W66lC+AOset0J?=
 =?us-ascii?Q?qLG0p5uHLz6ytr9+A+fUhrH3JFRTa/mDHc2dcs8E2G2yVQRogTgMXekxC5TW?=
 =?us-ascii?Q?tDDjuXqy2UqWJGF0UxMTPyLsGQg8xOMIcZvh59aCOZOckUe5WiNWr2tM50Q4?=
 =?us-ascii?Q?q0AKoG3rbgu6oMqOuY5KP8UyIHDZ2xF131B9KFk0pxcEa78NO6ry3HlyKx6Z?=
 =?us-ascii?Q?Wni275+ZbuNoZ6D366Mnl32OXRwf1/4EHHz6CHcv+/vwmOimlq5HOqfH+5Fy?=
 =?us-ascii?Q?5myRnHsxSfapnoJd7pDPdAUswdB/lPgjbtVD+B9Z+QZ6yr/aoOwv4tEQJz0U?=
 =?us-ascii?Q?PcHAwS61fFLXbya/qqB2MYnyQNWbDwJmmMZuruOchm4Iw2xlGOw5j9akeFek?=
 =?us-ascii?Q?fW2Jky3He5ldUrbsSQgm9IVoJU8oNv+R1Y1zR3y1V1sxi1cgpn4dwdAhXr91?=
 =?us-ascii?Q?MxU3xQ8izRc7dSXb7AXMkq8jvBBIGx2FXz6oRbV3xASpSnoiGQYMhLDY0GQT?=
 =?us-ascii?Q?BpvgNPDVhKYjaPJ/qXdxbKQXwKWohGZ30Km4gFGnOER9XwD6Yj99sMAnF6rH?=
 =?us-ascii?Q?YJE3XmzdDQvQKnvI3qZatxhSX/ZrFGudy+LJDXL0SJToHTPtFrLr96S942xt?=
 =?us-ascii?Q?K8QD+yEk4NnCqoQAkLuGB95oRdsRbRvSPhgk+ih/8XjlCUt9fDlPM3iTuHoU?=
 =?us-ascii?Q?8k130bEv29o0h0mKBgeEgv6NEyco1oMZKNPbn88LtGAn+NCqW3oP0e55eaxA?=
 =?us-ascii?Q?Qdwe6dCaQDIVoJPoUOQKlujLxel6aX3gkVjuhmb2YicyLf1T/IzlwmN1PTLT?=
 =?us-ascii?Q?66OHRMurwwd6MsbyMClpsRqaKni0V3nusOhLLjokOtfbu5AoJU9OlFO7CM+p?=
 =?us-ascii?Q?jacHIP6YT9qabMF364BxDxfyfU9buY1a5gWpfn2iAMALi+vjxv/LNaUgzJlu?=
 =?us-ascii?Q?dxb46PEambfVlABGKfa45ixtvs+WOULp2gXFyRnakeEoqErdcbuEWfsY7Zun?=
 =?us-ascii?Q?RBiiqtUpo7GnD3WhVXC8QO+l8luI11EMCNyhlGaMygcjCmrZ7DbzHS5INeVE?=
 =?us-ascii?Q?6z+k66/JzQPFamNRFBVfjQFl2dET9cqptfxCL07KyBHM/EarKY6+4ZGTySZW?=
 =?us-ascii?Q?0t86oEJngQbOo4DZ5roM88sdA5p/hE0xEYeFxxitdzSZN/O5VbBQOtCr150K?=
 =?us-ascii?Q?YRuMnMKy+7ZPLpqgiORZWdXYwgeOwW7075+xtGHejGqe4YZ5T9+tkzj0SQf0?=
 =?us-ascii?Q?mtdYDfx5WLn7FyIP3ZOMtc/E04bVPHyRyp7Q2rcy+B0ls4cZQ9IY27Ei8fYb?=
 =?us-ascii?Q?14I9eWmXp8k4aqhMNL7n+VDxiAsfH8Skhp15eOaSiOKmRo96XkOzKH/vi+nO?=
 =?us-ascii?Q?GH6WDMDHHoaCT3JZTkuenDKJhnLDh6JK3vCLsp9NPkzTAl3qbG1VJw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kn8PgZdTiqF3gjH0aplHsNGnGQO3bQ56oBxPNUXlMglZVC+8It6ua6KbdoTu?=
 =?us-ascii?Q?rZuWlaU6XDqZVG1KKFvp3//CsXy63SwrL2X7kbmqliRuIv/MZoaa9wdkny+/?=
 =?us-ascii?Q?irSQRrp7CSYw6jTiAYKK6so3Wj1MP8SJSqoBXrqMR6B6YxeuC7C3WyZhVf/b?=
 =?us-ascii?Q?YQp28bZGB1fOHgaGom7xaIyxcfVN8Jc22PEwYpr/tFjpM68duUtp7aU090dp?=
 =?us-ascii?Q?BK8kgxx2Jw1EPatg0xqr+10clg7eKiXeFdpnE1yyd7KSrOKxRhCrkgR6wvUz?=
 =?us-ascii?Q?wGKAy0ddaPO845MR2Qb/GCmWOWq6eMTQuvl5TSmMwVEVb7qPuw9+1j/1Wtkz?=
 =?us-ascii?Q?OG/xcFXFRmrTMzPSQ8PDszfnuPzSiZWYLUYF42cpJ/dy7L1zO5gT9CTjamsB?=
 =?us-ascii?Q?wjSRMQRgABgp7YcVE2di1p89Bur55FuQlmv4lKszWzCfUzBoZsSfQKExkJaK?=
 =?us-ascii?Q?FVarYfEJ//PP2SBdTrZuYn1937p4l4VhXbvwciyDsylrOE9JkUg8MW+Ycva/?=
 =?us-ascii?Q?NtwwMKgP0ZN2y0Tjjma5VyKdzQR+xLgcgS4/s5u+ox3Y2CoS+6xvftDwJnOU?=
 =?us-ascii?Q?IfTiF7FbKAHA+U8fHmZS/aEU8XM5EWcaUtr+fKT3IteydytWKAR13nOfZBle?=
 =?us-ascii?Q?Cqp57upnPJkHm9oeEj7cnIX8CubIgA5mGG4mesQr89sFpHeXAo62vjNSf/ir?=
 =?us-ascii?Q?cex0oEOqyjlCceTx+bkcJBk9IOY5SI8aNVrC0eU21vKdHhNlr5QV/iXAb8iG?=
 =?us-ascii?Q?m7KM6IM+YjeYzQoZE2cYN0pv1ekjWpX+Vjk+wk6WHvLunwM0tx6/MqYCrXx+?=
 =?us-ascii?Q?GTHqXnuTT9Qu+EzGpRAbMZNp22hUZMObY8aJfjnj1SYchFTzDy9IiTvcWi3Q?=
 =?us-ascii?Q?o9WGn/jxc8lSgHZtueOuTLzI2+fHaghfz0hwMWuEXW3Mv+sMwjbIlJ9F6tH5?=
 =?us-ascii?Q?inWoj/T59phrrZEZgT3eUOZYeKvYpxjNp9s9986Vu6qVuX5q/UjEPAxMp6Nb?=
 =?us-ascii?Q?bqsVIGI+ZVJXfRgGDO9Hsyk+EyjcOWXP6Z0jPPSMpjHhSndcvsenTfswIGGm?=
 =?us-ascii?Q?vW7ghBjaZvOta09DX5NNeFvg5t9k91y2gX6Q63a9frH2T6LzISaHdG7br7P0?=
 =?us-ascii?Q?D+08fF3bwcliaqqMeHSiQn/SVrgcpVuGH3rGKwZpunQiDmuDIx5fCb8geb2u?=
 =?us-ascii?Q?spyMYm6eFGRouMVYhWjvfpjy22tcBaGoPS0Ai8WPtuYwqNyBTqSCrsfZ1VgA?=
 =?us-ascii?Q?T91lvfCwNkYL0BOJ7HNBELpFe51b9VFbhWQtNt6sXhgABfSKSnnFmdNy+0K6?=
 =?us-ascii?Q?PNM2NATyJTw+954+9KkMoSwkkftfEIrxrIzvYvVS+r5sBSnfGws6BCaMQQ/4?=
 =?us-ascii?Q?y19niKN0VCYNwnV2ym6uDqwQcqKyrurXoV6edHomXakxehis15qAhwx6yIf5?=
 =?us-ascii?Q?B28xKaFPjhVEXoRt0JOVbkScJtlxCOcjRwijLXFbAOoOeYoWI5xTOLdtOFzu?=
 =?us-ascii?Q?ClP88kSORzUN1vDjDL858WB9ciTky8uSyx2lXA+u6lpYWNBuxaXn1U1Zqt4Y?=
 =?us-ascii?Q?vkdVu9F/HaeuHCcERUHmDgpP2ER0kPPZ+2f/nx4Uy+fa6dUeo9M8pj4g6kgI?=
 =?us-ascii?Q?KCX1cYmjc9IwbNEe1uNt30A=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: f3953b94-cdf0-4a31-3051-08dde3319387
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2025 17:13:42.6511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wmeNQCxRI3jwDIXj3xJZuJHx3mDYAeY0ebFYY8LBP7qIiVHOEbj+7GvBN5bFDXZM6sM/DYgGZedUi6tHB9sGNBYlTia/jo2fhoFsCoT2UFw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7908

Continuous reading may result in multiple flash pages reading in one
operation. Typically only one flash page has read/written (a little bit
more than 2-4 Kb), but continuous reading requires the spi controller
to read up to 512 Kb in one operation without toggling CS in beetween.

Roughly speaking spi controllers can be divided on 2 categories:
 * spi controllers without dirmap acceleration support
 * spi controllers with dirmap acceleration support

Usually, first of them have no issues with large reading support.
Second group often supports acceleration of single page only reading.
Thus enabling of continuous reading can break flash reading.

This patch tries to create dirmap for continuous reading first and
fallback to regular reading if spi controller refuses to create it.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 43 ++++++++++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 09dd6e40e308..0f8636047365 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1093,6 +1093,39 @@ static int spinand_mtd_block_isreserved(struct mtd_info *mtd, loff_t offs)
 	return ret;
 }
 
+static struct spi_mem_dirmap_desc *spinand_create_rdesc_helper(
+					struct spinand_device *spinand,
+					struct spi_mem_dirmap_info *info)
+{
+	struct nand_device *nand = spinand_to_nand(spinand);
+	struct spi_mem_dirmap_desc *desc = NULL;
+
+	if (spinand->cont_read_possible) {
+		/*
+		 * spi controller may return an error if info->length is
+		 * too large
+		 */
+		info->length = nanddev_eraseblock_size(nand);
+		desc = devm_spi_mem_dirmap_create(&spinand->spimem->spi->dev,
+						  spinand->spimem, info);
+	}
+
+	if (IS_ERR_OR_NULL(desc)) {
+		/*
+		 * continuous reading is not supported by flash or
+		 * its spi controller, use regular reading
+		 */
+		spinand->cont_read_possible = false;
+
+		info->length = nanddev_page_size(nand) +
+			       nanddev_per_page_oobsize(nand);
+		desc = devm_spi_mem_dirmap_create(&spinand->spimem->spi->dev,
+						  spinand->spimem, info);
+	}
+
+	return desc;
+}
+
 static int spinand_create_dirmap(struct spinand_device *spinand,
 				 unsigned int plane)
 {
@@ -1112,11 +1145,8 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 
 	spinand->dirmaps[plane].wdesc = desc;
 
-	if (spinand->cont_read_possible)
-		info.length = nanddev_eraseblock_size(nand);
 	info.op_tmpl = *spinand->op_templates.read_cache;
-	desc = devm_spi_mem_dirmap_create(&spinand->spimem->spi->dev,
-					  spinand->spimem, &info);
+	desc = spinand_create_rdesc_helper(spinand, &info);
 	if (IS_ERR(desc))
 		return PTR_ERR(desc);
 
@@ -1139,12 +1169,9 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 
 	spinand->dirmaps[plane].wdesc_ecc = desc;
 
-	if (spinand->cont_read_possible)
-		info.length = nanddev_eraseblock_size(nand);
 	info.op_tmpl = *spinand->op_templates.read_cache;
 	info.op_tmpl.data.ecc = true;
-	desc = devm_spi_mem_dirmap_create(&spinand->spimem->spi->dev,
-					  spinand->spimem, &info);
+	desc = spinand_create_rdesc_helper(spinand, &info);
 	if (IS_ERR(desc))
 		return PTR_ERR(desc);
 
-- 
2.50.1


