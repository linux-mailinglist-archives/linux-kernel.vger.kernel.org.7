Return-Path: <linux-kernel+bounces-801178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 007D4B440E1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB5855A1B92
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E502F99B5;
	Thu,  4 Sep 2025 15:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PJvCcfbC"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013019.outbound.protection.outlook.com [40.107.159.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951772820B9
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 15:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757000667; cv=fail; b=iSIfpdHdREIBtcp0aPikOIGvICisLQ2WkjoBpNT2b+2MqKPQrv1ZRsT0xACS7Hhg7CK1zmfywDz1ddBv5DXN4wLr5MRq4NM4JqIHlqzifyRUQSLz5R/4oPa5mj0e0B5mMiDBboronDSdhSJOvPM+3Jz3QMzg24RMm/G5T18gNac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757000667; c=relaxed/simple;
	bh=SR03/UXG6M6OoVTsrjDeP+sLNJZNodUpGTtnTZDklIw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QJLHt/d6jhgupIRc9yP8NiNGr8+VgLxkYkjlbf3aPKovs84eS0UFKl8tr8uYUIKWsJdIKFfQLpro73M6AA8wPWlPBdbe3iVV7npbmp3iCjD7QNmyxzGj06A6mto9aJgMEkr3S6qT21icS0jcf+ivkTLeZHNX+mG/IMqCGOjHmuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PJvCcfbC; arc=fail smtp.client-ip=40.107.159.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UwwAvACqcv+C2e3jbEYHro7c91A8UFFz4dqc1ImgWND5wWS6NVGZwHJDZWjWAecucU3oLiMPXblvxstdOODIUm7GhFtd4A/NOkf+u/Y682sZW62XengCfkHHLWi9Vt73mNxJ2mcGvydQKVp8ISfqNaiyylxl5d6q6UwYX1/0qbgLFYe0cxlxPC01ie0/w6rOvuXq4RBPhmOobE/do3Zr2fuZm1pItLNUg2roCcW1FXULa2lWFtK0mLQ9Ikjjyz95EHyd+LdisNSO9ecmFrvkTf8dRvvQY+61N/t7uxjSR3qF8BoQ0KnZ+DU0/v2+tlPESE67Pb/mBhe8Nye49HeL3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JwW5BqSJdNVgMuE2YX/QZjhEMR2BGmW09zKuNyQRF+Y=;
 b=v+Ks3il8UBj5iDl7+4eDRXmi/rfkiJUn94To2DNAKIcNz8qR9vBr+P4m0pXoEnBuGUW2/XAIllvqYsUlnpFcktM201OZmPlxAxfA5MhRoI0rjZWticw5Noq6pLLGgO8eVM/UxfBoJsOlc5jTpCPtfPZbypIdDoKB137JxHu5ujbIxETd57iPjRaUyKm9IbOxf5hLEcKSuq0hjK1Ojx6sfdCR48lEnsd5R6PuqRqhDN3mWIiHjdPJcwH8ilFdUVWLB+SDOjkviRGjKA8pXhjqlQvq5i/VlVKRIznAsv0tUojNsfzGo/AfmtfMD/eGzkGxFwXoS0f+4uL7pEFOoDxKuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JwW5BqSJdNVgMuE2YX/QZjhEMR2BGmW09zKuNyQRF+Y=;
 b=PJvCcfbCFb8UJ9NOlEAKZwkhDAsOUNmJRfxZl1syTRyO33GxPQzUGb7p0poRb6//e7D0cDnlY0lD7VXwHQ5hciSVY9myD8sNLDAH1jEL53BFRpRU6lBD+Hiotfl5Ui8+rb0sr7YMMkBmlVMPHTxoE6Cj0P77POhWZhAqeTiNTTWmYBxl2bRes1QIq/fqmtlhJOsb2My1KavDcbwAzl5GQAAoIdPl5OPhj0JnVfiX81oADHkJWIowi7pceJNIgCyVxUjAimJUZG37Uot8fBHki9fWPLNQg5daBC6hXuEa9FA+oKfS7L4wvShcM5zlBFg/eqKj6dhNeL+U4JNtshkKOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AM9PR04MB7635.eurprd04.prod.outlook.com (2603:10a6:20b:285::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Thu, 4 Sep
 2025 15:44:18 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 15:44:18 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH phy 07/14] phy: lynx-28g: refactor lane->interface to lane->mode
Date: Thu,  4 Sep 2025 18:43:55 +0300
Message-Id: <20250904154402.300032-8-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 28b495e8-bcc6-4aff-f50e-08ddebc9e785
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|19092799006|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dTXu7PWImKRVQHevWLGmc3UKg1F6N3myzfunpE/nlku6qSW824ll6ZmuxFEu?=
 =?us-ascii?Q?/5qGjkEp7hiDIuIIdu7mVeG0dxbBBmJE+g4YVZAVpYDuwMytfFAyv0bhW7f4?=
 =?us-ascii?Q?DdYh4ZGh9THeXMpgiN1N+ceP9AdyjeiL3P4YGpaZX/Hx/MIkRfRJpZCVBps0?=
 =?us-ascii?Q?XdJOqJieDvd393cSRaSjYn69h9W0yYZn720cYrQAWbLXlgZqKzuilVqVuf/d?=
 =?us-ascii?Q?i/2mbdWSDQf2zvp5TjVA4lee5DuEqc026hun6Y7Aezui9UvUG9ZxUkNhaUhB?=
 =?us-ascii?Q?vk2rYGgmsWhPIhfLiM7SbAyolt5V8F0dHzCkRoeI+hgKBe8KzDu7V12spWGL?=
 =?us-ascii?Q?OvKHFNSthSJT7r/YX/jZwepB6HfpMHA9ix+r+SfpGQBQQhpLz7OaQbX11bIw?=
 =?us-ascii?Q?w5kKKi7qF46KGM7S4NcOMxZAawOns3hnMre8TPruHW6HpeUochpSyfFm2RHk?=
 =?us-ascii?Q?ZR0fJcCg5pC4VpP4AJL6iIrQQ/bz5LZWjGrPWBMfo18VK/E8iIYP3eAl4ovL?=
 =?us-ascii?Q?Pi0OeCSAWpxzJGles98pd4QD4cC3LT7G1x0wtDAI3pE++YL7oZP3ZXoS7F/D?=
 =?us-ascii?Q?gn+QQLUFazn1oUsj2vnMCV6heYVCGIE6kmOAtHkINTXSphdxfDJIyped1toA?=
 =?us-ascii?Q?Yz6H5tdJRZlz+AQ6uverT+g8/7hjkKwCJptRhjEW86BoydkFUWd6eVZglQM0?=
 =?us-ascii?Q?x+rMtj1XaawQd349iJHERMq7DwE2NMPjnM8NmzO4G+P/dxqbqzZkx3DtvEQq?=
 =?us-ascii?Q?alh03qYxsjKwyw8OyeeMSMm86eLiLgmoTgAi2TqpVT472xznCbnnGHqr4vHG?=
 =?us-ascii?Q?KvT0yCtjq1cITlCM0wrLQZmjBYwc0nHkR+khpL7+zc49TXeb9MWVPQGBiOcM?=
 =?us-ascii?Q?xSWtg607bjlH667jSgHV46Jk333Pxgasrpd4kD1Z6rfUqd8+IwKGHAs1vv4V?=
 =?us-ascii?Q?nWhZXGeP0OMzgXHp/VWFV2dkh9KQg4AA+0VnwNeWfrDaBP6ISV5uVLSe5jaC?=
 =?us-ascii?Q?+TkOQZppKZ1pDiPh1er7O9MhxnHvOVC2k/eiPJdK9iGIxsh92VoUjlm6eDgT?=
 =?us-ascii?Q?0wwPZ1Ie8pHmkQllQALlaJ8mDngSbZOy2bNtmrR8PxBkmNaC/Hr1UZY17sUL?=
 =?us-ascii?Q?GNIz0iUnOw0HB7iddcTEQTngCFK+r4i1STeWLg3F7pVgYCItjPcBN0lXj64P?=
 =?us-ascii?Q?jZ6alQUgVdPtUBRBwTT7TmuvyIceh7oXyD74EP7MxkWrug7fnVQJG8F4f5bU?=
 =?us-ascii?Q?PhCdDjVY9n7XNhMs/MCRDZTtS64zTcGHthHiwTOmNrYHoTA/4mo+CPfqZloM?=
 =?us-ascii?Q?gczALBug6vTiZcRG8QM8TmlpznpyNr66LXkQP5EHVAXhirqmy0eJJe2QBGcz?=
 =?us-ascii?Q?vOjAQ5z6G0/Opq0bhdy7Ow2K3IrT7q+gmTt3MaHB2TgP57XlUU4E4NM1J8zl?=
 =?us-ascii?Q?0tvCs3eBR3hojZUeRmt3XCeViu2m5jv65Er3r5gHSs1kiHKXPG2zhQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(19092799006)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xa/OrMDB48XEbVPjvC89D+1GHfWoFKByFX3RmanMurSITeqsmwsVQXKvvDbq?=
 =?us-ascii?Q?lpHvihtK8zAFmTAVQqcglhz2vshahxwtFjsX/lP0U2NBYw/RvoUVJ4F4Tsiw?=
 =?us-ascii?Q?+a1sycUcVq4SR8RzDtqcYS18YcBaBnLenwMscDuls0AwShOpkZX6Z2MxcGkC?=
 =?us-ascii?Q?SSd8APa7DzaKNcngEp4NsmGd9p65w27PTtdJz1NaLqUcMjBmdoTr8TNKCIXT?=
 =?us-ascii?Q?1Tal/sTP4nWUt9xv8jNyAhyX/VZBGa+NnMA6mrUf3jhK5qOOCpgXcYoAJqfv?=
 =?us-ascii?Q?ZJGfy/RU6Cg4tw+IEnbFnpm/HC51pfiMb7oBkhSPLz73ytze65ojH/qmDN1l?=
 =?us-ascii?Q?HA+rcRyKimBhzowjgK320BDKTOaC2Z3pL5/pvWpW66v57oVL/xsKKQm2f/BL?=
 =?us-ascii?Q?rsnmwwC7+0NLjzTvhIRNLETMcCSnp8VHXy/asgA13U8jUGsCRZfnv73TOYPq?=
 =?us-ascii?Q?kFoSnkxKkXcQl9RhVoZLuwbL3iCK5yxTbbWtr+S65Zr33kg6npZz51mvGdex?=
 =?us-ascii?Q?SLV/HQKkHT/TkDUgrb1itHSuiZsKTOuX+rrCT0X9/WGNqiRE7ekjZEv5QI5O?=
 =?us-ascii?Q?uTeWXnMF3XR9+5X6YCBzCk/IEX6rfdmfJoVWoR6zVXcHAcuptUNxogkYTl38?=
 =?us-ascii?Q?55uN+X0e9822y2+5VCl4GA+ErjDhVUv1ebhcSTvci3tJKtPyww4zFNxt6XzB?=
 =?us-ascii?Q?pD44aM3zlhQS5Yaf39QtbMJ2f3ag/w7gS92cziuOwCuo8tFlx0dr5kQE1p0k?=
 =?us-ascii?Q?bZGwi2Mqt37o0nx2QzQJdVR/L6nuBqhHovUQEJK5mzIV6U8Sn6N7Bmg8FEbb?=
 =?us-ascii?Q?Z6k65gkIQKJWmlBNQcx9LulXjHFYjMYF33PZAL5drpml+vD3UPC8+BxwQaVX?=
 =?us-ascii?Q?EjynzPZoRAttfUbipYAoptIbpOCWKw1m6l1V8F54BlZVve66xg9q805yDIEK?=
 =?us-ascii?Q?7qQIU5Hh9n0OZstaAess3jAGUyzXyam7NY51hWbZP2jSNKteC1Vq820Udvur?=
 =?us-ascii?Q?XGAFe6eUuezZ5X8BDBHCkc3Bn4z10xCJJCPLoOGBxVTH4dw2n1yasvJV9a2/?=
 =?us-ascii?Q?6/3AHUxH2+fZXzw7BmIHix+RE14s6Af6Ux0SiqJHHM8eWSRLEau4MBvHwDSf?=
 =?us-ascii?Q?HGDIcDM38oXgfSmVJEbY7/nnQv94yHJDg07VjunFQxA0rfFIV0r9/5OwaOZn?=
 =?us-ascii?Q?AaFHdOqtvlh25Surn+bVjmzRDGg0Odn1qq4q5274jX4YqJCprEVMh71IaGLW?=
 =?us-ascii?Q?ELusnniDLTRjcNJkLakCU/7XHIpMSM9ubd7y5+M4d3+aLDEJmvBUZ3T1QNtO?=
 =?us-ascii?Q?BMdHQvryFNXFYLTQfoUTr/5CpWQarziEfgPyqWHZ1xISGpkJGAicR/KyhlzX?=
 =?us-ascii?Q?73EDiyzYSl1/81+nGS6p/7kK0LGu+Y8VAauRgedohTn7fT4XqzJ3Qhd/kzHA?=
 =?us-ascii?Q?mmKFfZgPYB5ST7ppkxdC4JK09SxvteS6c7MutRvmbE3KPb2zq3f2fNmCN6Px?=
 =?us-ascii?Q?qY9QHtf7UEKjM+semPqKLCrJIm0jfWhifU2BZtjgTOfUGrw2b5QAf8AGA1RH?=
 =?us-ascii?Q?7FIGnUbrN54wuBmo8bL95PA7BbrI8cmHnhk1km+cDk1BNGckWU/Gbkf0DNfH?=
 =?us-ascii?Q?9Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28b495e8-bcc6-4aff-f50e-08ddebc9e785
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 15:44:16.3196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ocyyO6sETJ5BcmJaE6uUAu3iXXfQcR1Ypl4Hbx95qJwflXdXNnIRcQSoYl185FAUwfQPgCXdUk2LyrNQ/cmvGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7635

Lynx 28G is a multi-protocol SerDes - it handles serial Ethernet, PCIe,
SATA.

The driver should not use the phylib-specific phy_interface_t as an
internal data representation, but something specific to its internal
capabilities, and only convert to phy_interface_t when PHY_MODE_ETHERNET
is selected and used.

Otherwise it has no way of representing the non-Ethernet lanes (which
was not a short-term goal when the driver was introduced, and is not a
goal per se right now either, but should nonetheless be possible).

Prefer the "enum lynx_lane_mode" name over "lynx_28g_lane_mode", in
preparation of future Lynx 10G SerDes support. This SerDes is part of
the same IP family and has similar capabilities, and will reuse some
code, hence the common data type.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/phy/freescale/phy-fsl-lynx-28g.c | 202 ++++++++++++-----------
 1 file changed, 103 insertions(+), 99 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-lynx-28g.c b/drivers/phy/freescale/phy-fsl-lynx-28g.c
index c483c2a80a77..5f1af4fdcb49 100644
--- a/drivers/phy/freescale/phy-fsl-lynx-28g.c
+++ b/drivers/phy/freescale/phy-fsl-lynx-28g.c
@@ -244,6 +244,13 @@ enum lynx_28g_proto_sel {
 	PROTO_SEL_25G_50G_100G = 0x1a,
 };
 
+enum lynx_lane_mode {
+	LANE_MODE_UNKNOWN,
+	LANE_MODE_1000BASEX_SGMII,
+	LANE_MODE_10GBASER_USXGMII,
+	LANE_MODE_MAX,
+};
+
 struct lynx_28g_proto_conf {
 	/* LNaGCR0 */
 	int proto_sel;
@@ -281,36 +288,8 @@ struct lynx_28g_proto_conf {
 	int smp_autoz_eg1r;
 };
 
-static const struct lynx_28g_proto_conf lynx_28g_proto_conf[PHY_INTERFACE_MODE_MAX] = {
-	[PHY_INTERFACE_MODE_SGMII] = {
-		.proto_sel = LNaGCR0_PROTO_SEL_SGMII,
-		.if_width = LNaGCR0_IF_WIDTH_10_BIT,
-		.teq_type = EQ_TYPE_NO_EQ,
-		.sgn_preq = 1,
-		.ratio_preq = 0,
-		.sgn_post1q = 1,
-		.ratio_post1q = 0,
-		.amp_red = 6,
-		.adpt_eq = 48,
-		.enter_idle_flt_sel = 4,
-		.exit_idle_flt_sel = 3,
-		.data_lost_th_sel = 1,
-		.gk2ovd = 0x1f,
-		.gk3ovd = 0,
-		.gk4ovd = 0,
-		.gk2ovd_en = 1,
-		.gk3ovd_en = 1,
-		.gk4ovd_en = 0,
-		.eq_offset_ovd = 0x1f,
-		.eq_offset_ovd_en = 0,
-		.eq_offset_rng_dbl = 0,
-		.eq_blw_sel = 0,
-		.eq_boost = 0,
-		.spare_in = 0,
-		.smp_autoz_d1r = 0,
-		.smp_autoz_eg1r = 0,
-	},
-	[PHY_INTERFACE_MODE_1000BASEX] = {
+static const struct lynx_28g_proto_conf lynx_28g_proto_conf[LANE_MODE_MAX] = {
+	[LANE_MODE_1000BASEX_SGMII] = {
 		.proto_sel = LNaGCR0_PROTO_SEL_SGMII,
 		.if_width = LNaGCR0_IF_WIDTH_10_BIT,
 		.teq_type = EQ_TYPE_NO_EQ,
@@ -338,7 +317,7 @@ static const struct lynx_28g_proto_conf lynx_28g_proto_conf[PHY_INTERFACE_MODE_M
 		.smp_autoz_d1r = 0,
 		.smp_autoz_eg1r = 0,
 	},
-	[PHY_INTERFACE_MODE_10GBASER] = {
+	[LANE_MODE_10GBASER_USXGMII] = {
 		.proto_sel = LNaGCR0_PROTO_SEL_XFI,
 		.if_width = LNaGCR0_IF_WIDTH_20_BIT,
 		.teq_type = EQ_TYPE_2TAP,
@@ -380,7 +359,7 @@ struct lynx_28g_pll {
 	struct lynx_28g_priv *priv;
 	u32 rstctl, cr0, cr1;
 	int id;
-	DECLARE_PHY_INTERFACE_MASK(supported);
+	DECLARE_BITMAP(supported, LANE_MODE_MAX);
 };
 
 struct lynx_28g_lane {
@@ -389,7 +368,7 @@ struct lynx_28g_lane {
 	bool powered_up;
 	bool init;
 	unsigned int id;
-	phy_interface_t interface;
+	enum lynx_lane_mode mode;
 };
 
 struct lynx_28g_priv {
@@ -430,7 +409,34 @@ static void lynx_28g_rmw(struct lynx_28g_priv *priv, unsigned long off,
 #define lynx_28g_pll_read(pll, reg)			\
 	ioread32((pll)->priv->base + reg((pll)->id))
 
-static bool lynx_28g_supports_interface(struct lynx_28g_priv *priv, int intf)
+static const char *lynx_lane_mode_str(enum lynx_lane_mode lane_mode)
+{
+	switch (lane_mode) {
+	case LANE_MODE_1000BASEX_SGMII:
+		return "1000Base-X/SGMII";
+	case LANE_MODE_10GBASER_USXGMII:
+		return "10GBase-R/USXGMII";
+	default:
+		return "unknown";
+	}
+}
+
+static enum lynx_lane_mode phy_interface_to_lane_mode(phy_interface_t intf)
+{
+	switch (intf) {
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_1000BASEX:
+		return LANE_MODE_1000BASEX_SGMII;
+	case PHY_INTERFACE_MODE_10GBASER:
+	case PHY_INTERFACE_MODE_USXGMII:
+		return LANE_MODE_10GBASER_USXGMII;
+	default:
+		return LANE_MODE_UNKNOWN;
+	}
+}
+
+static bool lynx_28g_supports_lane_mode(struct lynx_28g_priv *priv,
+					enum lynx_lane_mode mode)
 {
 	int i;
 
@@ -438,7 +444,7 @@ static bool lynx_28g_supports_interface(struct lynx_28g_priv *priv, int intf)
 		if (PLLnRSTCTL_DIS(priv->pll[i].rstctl))
 			continue;
 
-		if (test_bit(intf, priv->pll[i].supported))
+		if (test_bit(mode, priv->pll[i].supported))
 			return true;
 	}
 
@@ -446,7 +452,7 @@ static bool lynx_28g_supports_interface(struct lynx_28g_priv *priv, int intf)
 }
 
 static struct lynx_28g_pll *lynx_28g_pll_get(struct lynx_28g_priv *priv,
-					     phy_interface_t intf)
+					     enum lynx_lane_mode mode)
 {
 	struct lynx_28g_pll *pll;
 	int i;
@@ -457,27 +463,27 @@ static struct lynx_28g_pll *lynx_28g_pll_get(struct lynx_28g_priv *priv,
 		if (PLLnRSTCTL_DIS(pll->rstctl))
 			continue;
 
-		if (test_bit(intf, pll->supported))
+		if (test_bit(mode, pll->supported))
 			return pll;
 	}
 
 	/* no pll supports requested mode, either caller forgot to check
 	 * lynx_28g_supports_lane_mode, or this is a bug.
 	 */
-	dev_WARN_ONCE(priv->dev, 1, "no pll for interface %s\n", phy_modes(intf));
+	dev_WARN_ONCE(priv->dev, 1, "no pll for lane mode %s\n",
+		      lynx_lane_mode_str(mode));
 	return NULL;
 }
 
 static void lynx_28g_lane_set_nrate(struct lynx_28g_lane *lane,
 				    struct lynx_28g_pll *pll,
-				    phy_interface_t intf)
+				    enum lynx_lane_mode lane_mode)
 {
 	switch (FIELD_GET(PLLnCR1_FRATE_SEL, pll->cr1)) {
 	case PLLnCR1_FRATE_5G_10GVCO:
 	case PLLnCR1_FRATE_5G_25GVCO:
-		switch (intf) {
-		case PHY_INTERFACE_MODE_SGMII:
-		case PHY_INTERFACE_MODE_1000BASEX:
+		switch (lane_mode) {
+		case LANE_MODE_1000BASEX_SGMII:
 			lynx_28g_lane_rmw(lane, LNaTGCR0,
 					  FIELD_PREP(LNaTGCR0_N_RATE, LNaTGCR0_N_RATE_QUARTER),
 					  LNaTGCR0_N_RATE);
@@ -490,9 +496,8 @@ static void lynx_28g_lane_set_nrate(struct lynx_28g_lane *lane,
 		}
 		break;
 	case PLLnCR1_FRATE_10G_20GVCO:
-		switch (intf) {
-		case PHY_INTERFACE_MODE_10GBASER:
-		case PHY_INTERFACE_MODE_USXGMII:
+		switch (lane_mode) {
+		case LANE_MODE_10GBASER_USXGMII:
 			lynx_28g_lane_rmw(lane, LNaTGCR0,
 					  FIELD_PREP(LNaTGCR0_N_RATE, LNaTGCR0_N_RATE_FULL),
 					  LNaTGCR0_N_RATE);
@@ -581,17 +586,16 @@ static int lynx_28g_power_on(struct phy *phy)
 	return 0;
 }
 
-static int lynx_28g_get_pccr(phy_interface_t interface, int lane,
+static int lynx_28g_get_pccr(enum lynx_lane_mode lane_mode, int lane,
 			     struct lynx_pccr *pccr)
 {
-	switch (interface) {
-	case PHY_INTERFACE_MODE_SGMII:
-	case PHY_INTERFACE_MODE_1000BASEX:
+	switch (lane_mode) {
+	case LANE_MODE_1000BASEX_SGMII:
 		pccr->offset = PCC8;
 		pccr->width = 4;
 		pccr->shift = SGMII_CFG(lane);
 		break;
-	case PHY_INTERFACE_MODE_10GBASER:
+	case LANE_MODE_10GBASER_USXGMII:
 		pccr->offset = PCCC;
 		pccr->width = 4;
 		pccr->shift = SXGMII_CFG(lane);
@@ -603,13 +607,12 @@ static int lynx_28g_get_pccr(phy_interface_t interface, int lane,
 	return 0;
 }
 
-static int lynx_28g_get_pcvt_offset(int lane, phy_interface_t interface)
+static int lynx_28g_get_pcvt_offset(int lane, enum lynx_lane_mode lane_mode)
 {
-	switch (interface) {
-	case PHY_INTERFACE_MODE_SGMII:
-	case PHY_INTERFACE_MODE_1000BASEX:
+	switch (lane_mode) {
+	case LANE_MODE_1000BASEX_SGMII:
 		return SGMIIaCR0(lane);
-	case PHY_INTERFACE_MODE_10GBASER:
+	case LANE_MODE_10GBASER_USXGMII:
 		return SXGMIIaCR0(lane);
 	default:
 		return -EOPNOTSUPP;
@@ -617,14 +620,14 @@ static int lynx_28g_get_pcvt_offset(int lane, phy_interface_t interface)
 }
 
 static int lynx_pccr_write(struct lynx_28g_lane *lane,
-			   phy_interface_t interface, u32 val)
+			   enum lynx_lane_mode lane_mode, u32 val)
 {
 	struct lynx_28g_priv *priv = lane->priv;
 	struct lynx_pccr pccr;
 	u32 old, tmp, mask;
 	int err;
 
-	err = lynx_28g_get_pccr(interface, lane->id, &pccr);
+	err = lynx_28g_get_pccr(lane_mode, lane->id, &pccr);
 	if (err)
 		return err;
 
@@ -639,13 +642,13 @@ static int lynx_pccr_write(struct lynx_28g_lane *lane,
 	return 0;
 }
 
-static int lynx_pcvt_read(struct lynx_28g_lane *lane, phy_interface_t interface,
-			  int cr, u32 *val)
+static int lynx_pcvt_read(struct lynx_28g_lane *lane,
+			  enum lynx_lane_mode lane_mode, int cr, u32 *val)
 {
 	struct lynx_28g_priv *priv = lane->priv;
 	int offset;
 
-	offset = lynx_28g_get_pcvt_offset(lane->id, interface);
+	offset = lynx_28g_get_pcvt_offset(lane->id, lane_mode);
 	if (offset < 0)
 		return offset;
 
@@ -654,13 +657,13 @@ static int lynx_pcvt_read(struct lynx_28g_lane *lane, phy_interface_t interface,
 	return 0;
 }
 
-static int lynx_pcvt_write(struct lynx_28g_lane *lane, phy_interface_t interface,
-			   int cr, u32 val)
+static int lynx_pcvt_write(struct lynx_28g_lane *lane,
+			   enum lynx_lane_mode lane_mode, int cr, u32 val)
 {
 	struct lynx_28g_priv *priv = lane->priv;
 	int offset;
 
-	offset = lynx_28g_get_pcvt_offset(lane->id, interface);
+	offset = lynx_28g_get_pcvt_offset(lane->id, lane_mode);
 	if (offset < 0)
 		return offset;
 
@@ -669,43 +672,44 @@ static int lynx_pcvt_write(struct lynx_28g_lane *lane, phy_interface_t interface
 	return 0;
 }
 
-static int lynx_pcvt_rmw(struct lynx_28g_lane *lane, phy_interface_t interface,
+static int lynx_pcvt_rmw(struct lynx_28g_lane *lane,
+			 enum lynx_lane_mode lane_mode,
 			 int cr, u32 val, u32 mask)
 {
 	int err;
 	u32 tmp;
 
-	err = lynx_pcvt_read(lane, interface, cr, &tmp);
+	err = lynx_pcvt_read(lane, lane_mode, cr, &tmp);
 	if (err)
 		return err;
 
 	tmp &= ~mask;
 	tmp |= val;
 
-	return lynx_pcvt_write(lane, interface, cr, tmp);
+	return lynx_pcvt_write(lane, lane_mode, cr, tmp);
 }
 
 static void lynx_28g_lane_remap_pll(struct lynx_28g_lane *lane,
-				    phy_interface_t interface)
+				    enum lynx_lane_mode lane_mode)
 {
 	struct lynx_28g_priv *priv = lane->priv;
 	struct lynx_28g_pll *pll;
 
 	/* Switch to the PLL that works with this interface type */
-	pll = lynx_28g_pll_get(priv, interface);
+	pll = lynx_28g_pll_get(priv, lane_mode);
 	if (unlikely(pll == NULL))
 		return;
 
 	lynx_28g_lane_set_pll(lane, pll);
 
 	/* Choose the portion of clock net to be used on this lane */
-	lynx_28g_lane_set_nrate(lane, pll, interface);
+	lynx_28g_lane_set_nrate(lane, pll, lane_mode);
 }
 
 static void lynx_28g_lane_change_proto_conf(struct lynx_28g_lane *lane,
-					    phy_interface_t interface)
+					    enum lynx_lane_mode lane_mode)
 {
-	const struct lynx_28g_proto_conf *conf = &lynx_28g_proto_conf[interface];
+	const struct lynx_28g_proto_conf *conf = &lynx_28g_proto_conf[lane_mode];
 
 	lynx_28g_lane_rmw(lane, LNaGCR0, conf->proto_sel | conf->if_width,
 			  LNaGCR0_PROTO_SEL | LNaGCR0_IF_WIDTH);
@@ -774,21 +778,20 @@ static void lynx_28g_lane_change_proto_conf(struct lynx_28g_lane *lane,
 }
 
 static int lynx_28g_lane_disable_pcvt(struct lynx_28g_lane *lane,
-				      phy_interface_t interface)
+				      enum lynx_lane_mode lane_mode)
 {
 	struct lynx_28g_priv *priv = lane->priv;
 	int err;
 
 	spin_lock(&priv->pcc_lock);
 
-	err = lynx_pccr_write(lane, interface, 0);
+	err = lynx_pccr_write(lane, lane_mode, 0);
 	if (err)
 		goto out;
 
-	switch (interface) {
-	case PHY_INTERFACE_MODE_SGMII:
-	case PHY_INTERFACE_MODE_1000BASEX:
-		err = lynx_pcvt_rmw(lane, interface, CR(1), 0,
+	switch (lane_mode) {
+	case LANE_MODE_1000BASEX_SGMII:
+		err = lynx_pcvt_rmw(lane, lane_mode, CR(1), 0,
 				    SGMIIaCR1_SGPCS_EN);
 		break;
 	default:
@@ -802,7 +805,7 @@ static int lynx_28g_lane_disable_pcvt(struct lynx_28g_lane *lane,
 }
 
 static int lynx_28g_lane_enable_pcvt(struct lynx_28g_lane *lane,
-				     phy_interface_t interface)
+				     enum lynx_lane_mode lane_mode)
 {
 	struct lynx_28g_priv *priv = lane->priv;
 	u32 val;
@@ -810,10 +813,9 @@ static int lynx_28g_lane_enable_pcvt(struct lynx_28g_lane *lane,
 
 	spin_lock(&priv->pcc_lock);
 
-	switch (interface) {
-	case PHY_INTERFACE_MODE_SGMII:
-	case PHY_INTERFACE_MODE_1000BASEX:
-		err = lynx_pcvt_rmw(lane, interface, CR(1), SGMIIaCR1_SGPCS_EN,
+	switch (lane_mode) {
+	case LANE_MODE_1000BASEX_SGMII:
+		err = lynx_pcvt_rmw(lane, lane_mode, CR(1), SGMIIaCR1_SGPCS_EN,
 				    SGMIIaCR1_SGPCS_EN);
 		break;
 	default:
@@ -822,19 +824,18 @@ static int lynx_28g_lane_enable_pcvt(struct lynx_28g_lane *lane,
 
 	val = 0;
 
-	switch (interface) {
-	case PHY_INTERFACE_MODE_SGMII:
-	case PHY_INTERFACE_MODE_1000BASEX:
+	switch (lane_mode) {
+	case LANE_MODE_1000BASEX_SGMII:
 		val |= PCC8_SGMIIa_CFG;
 		break;
-	case PHY_INTERFACE_MODE_10GBASER:
+	case LANE_MODE_10GBASER_USXGMII:
 		val |= PCCC_SXGMIIn_CFG | PCCC_SXGMIIn_XFI;
 		break;
 	default:
 		break;
 	}
 
-	err = lynx_pccr_write(lane, interface, val);
+	err = lynx_pccr_write(lane, lane_mode, val);
 
 	spin_unlock(&priv->pcc_lock);
 
@@ -846,18 +847,21 @@ static int lynx_28g_set_mode(struct phy *phy, enum phy_mode mode, int submode)
 	struct lynx_28g_lane *lane = phy_get_drvdata(phy);
 	struct lynx_28g_priv *priv = lane->priv;
 	int powered_up = lane->powered_up;
+	enum lynx_lane_mode lane_mode;
 	int err = 0;
 
 	if (mode != PHY_MODE_ETHERNET)
 		return -EOPNOTSUPP;
 
-	if (lane->interface == PHY_INTERFACE_MODE_NA)
+	if (lane->mode == LANE_MODE_UNKNOWN)
 		return -EOPNOTSUPP;
 
-	if (!lynx_28g_supports_interface(priv, submode))
+	lane_mode = phy_interface_to_lane_mode(submode);
+
+	if (!lynx_28g_supports_lane_mode(priv, lane_mode))
 		return -EOPNOTSUPP;
 
-	if (submode == lane->interface)
+	if (submode == lane->mode)
 		return 0;
 
 	/* If the lane is powered up, put the lane into the halt state while
@@ -866,7 +870,7 @@ static int lynx_28g_set_mode(struct phy *phy, enum phy_mode mode, int submode)
 	if (powered_up)
 		lynx_28g_power_off(phy);
 
-	err = lynx_28g_lane_disable_pcvt(lane, lane->interface);
+	err = lynx_28g_lane_disable_pcvt(lane, lane->mode);
 	if (err)
 		goto out;
 
@@ -874,7 +878,7 @@ static int lynx_28g_set_mode(struct phy *phy, enum phy_mode mode, int submode)
 	lynx_28g_lane_remap_pll(lane, submode);
 	WARN_ON(lynx_28g_lane_enable_pcvt(lane, submode));
 
-	lane->interface = submode;
+	lane->mode = lane_mode;
 
 out:
 	if (powered_up)
@@ -892,7 +896,8 @@ static int lynx_28g_validate(struct phy *phy, enum phy_mode mode, int submode,
 	if (mode != PHY_MODE_ETHERNET)
 		return -EOPNOTSUPP;
 
-	if (!lynx_28g_supports_interface(priv, submode))
+	if (!lynx_28g_supports_lane_mode(priv,
+					 phy_interface_to_lane_mode(submode)))
 		return -EOPNOTSUPP;
 
 	return 0;
@@ -945,12 +950,11 @@ static void lynx_28g_pll_read_configuration(struct lynx_28g_priv *priv)
 		case PLLnCR1_FRATE_5G_10GVCO:
 		case PLLnCR1_FRATE_5G_25GVCO:
 			/* 5GHz clock net */
-			__set_bit(PHY_INTERFACE_MODE_1000BASEX, pll->supported);
-			__set_bit(PHY_INTERFACE_MODE_SGMII, pll->supported);
+			__set_bit(LANE_MODE_1000BASEX_SGMII, pll->supported);
 			break;
 		case PLLnCR1_FRATE_10G_20GVCO:
 			/* 10.3125GHz clock net */
-			__set_bit(PHY_INTERFACE_MODE_10GBASER, pll->supported);
+			__set_bit(LANE_MODE_10GBASER_USXGMII, pll->supported);
 			break;
 		default:
 			/* 6GHz, 12.890625GHz, 8GHz */
@@ -1001,13 +1005,13 @@ static void lynx_28g_lane_read_configuration(struct lynx_28g_lane *lane)
 	protocol = FIELD_GET(LNaPSS_TYPE, pss);
 	switch (protocol) {
 	case LNaPSS_TYPE_SGMII:
-		lane->interface = PHY_INTERFACE_MODE_SGMII;
+		lane->mode = LANE_MODE_1000BASEX_SGMII;
 		break;
 	case LNaPSS_TYPE_XFI:
-		lane->interface = PHY_INTERFACE_MODE_10GBASER;
+		lane->mode = LANE_MODE_10GBASER_USXGMII;
 		break;
 	default:
-		lane->interface = PHY_INTERFACE_MODE_NA;
+		lane->mode = LANE_MODE_UNKNOWN;
 	}
 }
 
-- 
2.34.1


