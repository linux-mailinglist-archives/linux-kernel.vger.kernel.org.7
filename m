Return-Path: <linux-kernel+bounces-801181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0200CB440E4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBD4C7A5CFE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A8E3009DF;
	Thu,  4 Sep 2025 15:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eBCB8t3q"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013019.outbound.protection.outlook.com [40.107.159.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D418F2F4A17
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 15:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757000670; cv=fail; b=JyKmT0B3moSZbnMZRpfTkBJsX+fbxKeXSQ/5hGHdXgGQSJnoGwHuPMcJRgGZCgMu6z4jBmuekxfsSdtIW5AgPoTOS6OP14DPRuJWA54JTogzN1w7McU/uRS1Rh+tyPUhH3PfSaHq/lX8G8cGPc1TdvsAvubn+q19zXuB7ic8wrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757000670; c=relaxed/simple;
	bh=IKm2L4NbxAejTj3sWWeWce0sshVdXwO/mb3CaERlmko=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C7/Nu1OJE/RvWDpaRH9TbtdZhWtoJYB3Hj79QvfuzRgyEnAX8J8Y/MZOdn36iqPEYYkBJKM6cu2Hr+6wE/28jum+v6YO4sPuVGAGje7gvvRps7YAoES1GDmRkBHNOZq4FVCcGq+ZAFToGK5pPxYVhOnzQveE0CriHm8uFGcNlFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eBCB8t3q; arc=fail smtp.client-ip=40.107.159.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YDEqee5NoWqNBLShBnXndehOU7rU3291iAb47t3dOmOkro6NcHq2tbavOoSQ79NCkeCaEyS1/vHJS0qRZGilnG/y0HVqhfSy9ftedufyCl0SzfznWCyPPr61F50jV7rMSHrZbpVZQQeNmO1buzOS40oaWxL5k9s9XR5tFurw/J2l+5MCKWNMxrowqdwfRatCqnMqjMXt+eLJv119hEr7TaXILxIT3rPDUovWCHpQr1EtCuk+83OZBqIbYbhnIY7YXNVPpFO2+aWlaB8jfVyCApRPibhwM+g7cjrffoHXCEg5Gvt/E1qUiZS16Wo8vpHTv7UiZJ6rrTfenW0//2Kcrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C1vlzcOVotw1/fmq65AAO0N3aOqxZk6iwMsVuahiRSM=;
 b=RIb+nSeU9HlPeX1jRTSp1XmsM7htSpPRbsKYCB6zz0ppq3gBT9ivO17YQUURHJY77lR52kckjsMNp8HoowtDvfLIGmbTYeICcSRbY6Cs3ji4b854vXrRJIq8mtQ7sz/0pHOWJIcpSvAliNVbUV0SCf8uHDmxI7nqBio28zRe1nMb7yZhFBmu1qaB5lxVtOLCuuQiko519c5U+0HdYY/XtdIJyi3pVyR/PRTj1NjpMUavdNGKVFKfh42LHCQltbOgHK82y4ULPYIiExfeiTS+SPodUQVwSiSa9V+qF/dETYRFNc64a/HqhSwq2v7ViGBdEiwYXT5lJrOtwqAIDNzMWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C1vlzcOVotw1/fmq65AAO0N3aOqxZk6iwMsVuahiRSM=;
 b=eBCB8t3qdIsPbpCX419gpXtABDNTTw8tLWbOSWpiIcLNkhW+Sn1DYv15s4diSpgiE2dvz2BTv8R+Vt27V7AIZ+veNVJKqzx5CMy5bFNvEOZW7xMq4n/skNRON101lspxKztut1Ic7a8ueFR9N5Uz09OPgOcdm7N0JIXgUWyMNt3UCwB3z1RapimUQEvxWO1L4zkVW8yKjJxySdXsnsy0MZb9gtOCgJFu9ioK3zm/E4GFmimHuOH5rBq9pX7QLBJ6SvU/CDeLDxzltrKvyufz1qiwuvxUBCcUcGSAvjIMHb6OOobr2jX9Msg2mGFFFENcTIkASaI5hmrCkMUYkXFpPg==
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
Subject: [PATCH phy 10/14] phy: lynx-28g: add support for 25GBASER
Date: Thu,  4 Sep 2025 18:43:58 +0300
Message-Id: <20250904154402.300032-11-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 200f71c5-70e3-48c2-3714-08ddebc9e899
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|19092799006|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WT1KsCM/b5lIA+edUHC9yVKNhtA8UPylRGimXMjaOlwzOosNgdSzxxyZS0OQ?=
 =?us-ascii?Q?RcZWSqnWWp7tAF+w2uhWilQEKlOa7Mey8JXIJ+BlYhnS14SQaAaxdHCmX6Kv?=
 =?us-ascii?Q?wG2UENMyq0AiQbV89ToTOoHqluQzHYfVuqzSmYcr/ZNJ60ASO6nGY0WSRkmR?=
 =?us-ascii?Q?fr1+l+1Hf+izf2ai/gV+B7mdJSsWXpRtFpZjmhyuo6s2ncc0V6otLlmL2PsY?=
 =?us-ascii?Q?LlQmEBgoKOTAYvCBvekNnI7ZzJBUWLqSeNDFrCQW3bKLiIIIe8bJ5sy8KqMu?=
 =?us-ascii?Q?CAjdQzHE3FEMArPmFJaIa1rnYRxuFmhrSfEGa8HzBgs8MIhiv7E4mfQzVlHr?=
 =?us-ascii?Q?l8vhkfICt8IV1+xf5LmacPZBLYav3zn/Ve5No6hGjQ/kkxQk7+APKbREK6ln?=
 =?us-ascii?Q?EzGpoq3r1M6WgL++lVK06c+5U9bqzd+IL+DnMor0DlJe3kmCoWRfO2Rzio8L?=
 =?us-ascii?Q?mX9c93TVlx29Wa6oa7uyIZkbJaa/CC51xAfDD1xS9FlI9SZ0vME7bOupNTpJ?=
 =?us-ascii?Q?+F4Iq4NhwsiSKVXmEBmJy/ZGtWbEFgzwKcTJXmEfhBcje9KdPPNrd0Qj123I?=
 =?us-ascii?Q?1jSbbaBPeWuVcE9YwEDGEZDeXGm/jzdwp1CiM0tvrQ9g8LMW8H3ApdonViRY?=
 =?us-ascii?Q?KQdQ/GejBPD9qfPFjd9FMgK0si2eyQ0tkbE/FcpkIdFutj9U8EWzhBjBE/SX?=
 =?us-ascii?Q?m8XN0bBb2AzZwAHtq9lCaxWyrsdqlEt7P4poAddGP3lkGjDmrqpNCGzCQjhG?=
 =?us-ascii?Q?HQd6JRk5yZN+CrgisAzUYbkmqTGUtEt/ZCPLkwr+UrpndE7KxHveKyZmBTID?=
 =?us-ascii?Q?OsjltC8lzJxFEzhG6lbi3bJD19RrjQJ/H8mBuRH66T5ry2t8kQZLCQjIb5QN?=
 =?us-ascii?Q?/wmI29iXg71tgne+/MXPUCz6ev2KeyijVr9QffHUyveiW/fG98OVwJiNDgCX?=
 =?us-ascii?Q?nFx0XeRM9LZgMu4KNBWLmz1AllK7j77n3WbNvGgXGydntInDBXL0t6Pzpgy7?=
 =?us-ascii?Q?0i7iGg4Ht7Ru/uGSv9U7enMvPxuBF4dVSKAxYLWwih7KQkzRKnnCr4AKHsJC?=
 =?us-ascii?Q?1kmryVn7mYQ3Wmxuvsy9yBhZbCd0UwENQJPod0Mm/7Sg+XtX77cOIdVJL+iS?=
 =?us-ascii?Q?EpWAUXAjmVNL7wXmR/EH384b5FYFIcNGgVfQ2UlYVbFbrAayg234pR+Trpot?=
 =?us-ascii?Q?YzjcmSQQxoFA1UoPFKKm1CHGilpVHBY0mq8JxU7h1W7CtjRM8HTeLdkU5h63?=
 =?us-ascii?Q?FMEbDA6MP40jx/nFWvFu/R3EKtWh6KMcjeUmDRzSzyR50d3b2BYKRU+2Yfzr?=
 =?us-ascii?Q?HIdm8v1LwjY3hy9u6KWWPh9qEsxMXVbhzxb6I7D9eQy90byh/6mSEXHF5SoX?=
 =?us-ascii?Q?tlBhJG4GoZgz0ni43tJFsJSh7HzQWc7/e+CNlCoVTm5qV00T854N2aRx6mYx?=
 =?us-ascii?Q?G6YdGpVMAX1kHS6rT6ZTWZuB2wxV5bBIr95l1H43Z51n0hdEU2B54Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(19092799006)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pIzI30KzDgqt0TAuSNHAQOc9yuO8bBGCfhFJYFgnDiZQCbfKX/V3Yu+XUF/I?=
 =?us-ascii?Q?2jr5ra1rUQMPI48won/8rne9UGcAkxnqEbJxX/BqAUMJpNXYzrcePZtGMV83?=
 =?us-ascii?Q?885kZIZdVH9eRJINWAg+PUYWlAG29eJy0+PCfQGU6KIGtV6UxQZol4zrWhlQ?=
 =?us-ascii?Q?bmrZQcx2YisRzFpi1lNgWBOf3Hja4JT2hy1zXj6J5HHHnxFQzTEHOCW4Evzh?=
 =?us-ascii?Q?E6Izf2cCAmfUyJbQbUZ8Qt0W1FDbwNUZwCcCqhVh/59BNRI746gYrNuBEqgj?=
 =?us-ascii?Q?2PseJ+nf6niUupqBg5JqQPnatHufIDVQsqtX3btxfwNZouuUwLRepQxcqhqs?=
 =?us-ascii?Q?KCs3vM93YPIR2YUsDQG6wHuyQnr274W3IbXtMXJd7H29xn+1uK2k2t6FMgNH?=
 =?us-ascii?Q?DJzgDraNmhliDtTwUxqUQ1PH0bolXtl0LRj6pwNr1FAHMqgMYSNVV1MRsPuU?=
 =?us-ascii?Q?W+zxiDlf2FAJRfoZOMSfCWYI0miOh2L9/V/z0N8sW1J84CoejAtWphblCBUr?=
 =?us-ascii?Q?H/mr2LsSJHSqV1fUuE1PMSvBZ7/4Y/2ZZ4karGJl4GUtTVGQaoK7Pp5j1lyF?=
 =?us-ascii?Q?WmtnpFKbnxp5RT9yHuODTpWlf3WqHBfg7hRZn4lcLlji/k6G9upVqKSbBQ4V?=
 =?us-ascii?Q?QuL8tt3Z674IUiMk+SZ/p1r+5dc04zUk1qYqI8s7+1Rq1+xCHvLbmiBLp3a7?=
 =?us-ascii?Q?GZj+FgAZFRp/emClnTKIZZyAyqSIJaDzQc+KdghJhhQNpcmHNpvbRknMZ7o0?=
 =?us-ascii?Q?a31dWAD/SNe0DygxrtK6yq9sEOYaOS8xUslwB1TYOo3iAOwUd8wZOF/fSRa1?=
 =?us-ascii?Q?uzTZBKiq4wjBOcRaJiIEqNgdm5hcpPgsP6+Gq56AU4PlwNEntl9ZMF1JWJ4h?=
 =?us-ascii?Q?p2mxsiFZMXUVGeqIoZCI81JGOft8yjHbN+jHpUPMGejM30Nb7Yp0aTh8lGB9?=
 =?us-ascii?Q?Kch5j7JHbcDqpV+xKfcrxtHobcptqpspOUhnEIYqgKrM6Wd3qLmUiADr4f9j?=
 =?us-ascii?Q?BekSJwjRTSsB8Aq6+0ISSvMoDsvAM1X5UTzlxBDPbuLp4+4CsLsc2BHOnFm7?=
 =?us-ascii?Q?ZwlBUmtEhUPqhzqIs089RJra9XehvW8KBUMUbAXCHw1JUgVDDQ+L2g1dG4km?=
 =?us-ascii?Q?vplKKfLaK2+k20ZeJPPtUs9hZIjDPNk0SlXfhKshpjRE4B7HD/dwJ1b1IVKo?=
 =?us-ascii?Q?BaTWEHElugk5ErPsN7yQ6vvfFgYw+jDEBh8F/NoZpcSJY7wPJQzN4kWRAsWU?=
 =?us-ascii?Q?rD57p0eD2riV7gCERcw/KY9Rg7HouI9ZrJFSKVZ3+tZm0u2BDe2iuS3GQp6G?=
 =?us-ascii?Q?WMDtkb+3fUiJ+h1zqPgwobMrpQUNaGiGxwZio4EyX2mOqQwjkBn5yqe1gEsi?=
 =?us-ascii?Q?EztcXJLpQK44FhxcMGInE/AxOJ6Ykoc2j0VT6R5Q/n1sSNdK/DRVPlgHLSKH?=
 =?us-ascii?Q?SUkJjqjqQXmJ7NG/5Om1FSHplentjY78gt+0lt3Ad3ZXhnlQpH8jCBaKrSmA?=
 =?us-ascii?Q?WNch6mAS1mGuWtvaAYiiIEbfIJktir4FpixErFU5YT1si5HEAE40NGgit+cn?=
 =?us-ascii?Q?7dF25q0pAVRuOswlphVTQ20lpHUlIs6rfSJdxKlUCve0nb+S+R6rWqrEMOq1?=
 =?us-ascii?Q?Lg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 200f71c5-70e3-48c2-3714-08ddebc9e899
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 15:44:18.1169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KcDwrtUU0AtXcMI8plV/VcrQ7eS07EMBV0TJQYm9Hixf/3zTn/EOs6thXBD1Ibl86Zjlff3u1J7hPxtMZcvF2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7635

From: Ioana Ciornei <ioana.ciornei@nxp.com>

Add support for 25GBASE-R in the Lynx 28G SerDes PHY driver.
This mainly means being able to determine if a PLL is able to support
the new interface type, to determine at probe time if a lane is
configured from the Reset Configuration Word (RCW) with this interface
type and to be able to reconfigure a lane.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/phy/freescale/phy-fsl-lynx-28g.c | 83 +++++++++++++++++++++++-
 1 file changed, 82 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/freescale/phy-fsl-lynx-28g.c b/drivers/phy/freescale/phy-fsl-lynx-28g.c
index 1a8751e79898..08553ffe273f 100644
--- a/drivers/phy/freescale/phy-fsl-lynx-28g.c
+++ b/drivers/phy/freescale/phy-fsl-lynx-28g.c
@@ -57,6 +57,7 @@
 #define PLLnCR1_FRATE_5G_10GVCO			0x0
 #define PLLnCR1_FRATE_5G_25GVCO			0x10
 #define PLLnCR1_FRATE_10G_20GVCO		0x6
+#define PLLnCR1_FRATE_12G_25GVCO		0x16
 
 /* Per SerDes lane registers */
 /* Lane a General Control Register */
@@ -64,9 +65,11 @@
 #define LNaGCR0_PROTO_SEL			GENMASK(7, 3)
 #define LNaGCR0_PROTO_SEL_SGMII			0x1
 #define LNaGCR0_PROTO_SEL_XFI			0xa
+#define LNaGCR0_PROTO_SEL_25G			0x1a
 #define LNaGCR0_IF_WIDTH			GENMASK(2, 0)
 #define LNaGCR0_IF_WIDTH_10_BIT			0x0
 #define LNaGCR0_IF_WIDTH_20_BIT			0x2
+#define LNaGCR0_IF_WIDTH_40_BIT			0x4
 
 /* Lane a Tx Reset Control Register */
 #define LNaTRSTCTL(lane)			(0x800 + (lane) * 0x100 + 0x20)
@@ -83,6 +86,7 @@
 #define LNaTGCR0_N_RATE_FULL			0x0
 #define LNaTGCR0_N_RATE_HALF			0x1
 #define LNaTGCR0_N_RATE_QUARTER			0x2
+#define LNaTGCR0_N_RATE_DOUBLE			0x3
 
 #define LNaTECR0(lane)				(0x800 + (lane) * 0x100 + 0x30)
 #define LNaTECR0_EQ_TYPE			GENMASK(30, 28)
@@ -112,6 +116,7 @@
 #define LNaRGCR0_N_RATE_FULL			0x0
 #define LNaRGCR0_N_RATE_HALF			0x1
 #define LNaRGCR0_N_RATE_QUARTER			0x2
+#define LNaRGCR0_N_RATE_DOUBLE			0x3
 
 #define LNaRGCR1(lane)				(0x800 + (lane) * 0x100 + 0x48)
 #define LNaRGCR1_RX_ORD_ELECIDLE		BIT(31)
@@ -270,6 +275,7 @@ enum lynx_lane_mode {
 	LANE_MODE_1000BASEX_SGMII,
 	LANE_MODE_10GBASER,
 	LANE_MODE_USXGMII,
+	LANE_MODE_25GBASER,
 	LANE_MODE_MAX,
 };
 
@@ -408,6 +414,41 @@ static const struct lynx_28g_proto_conf lynx_28g_proto_conf[LANE_MODE_MAX] = {
 		.ttlcr0 = LNaTTLCR0_TTL_SLO_PM_BYP |
 			  LNaTTLCR0_DATA_IN_SSC,
 	},
+	[LANE_MODE_25GBASER] = {
+		.proto_sel = LNaGCR0_PROTO_SEL_25G,
+		.if_width = LNaGCR0_IF_WIDTH_40_BIT,
+		.teq_type = EQ_TYPE_3TAP,
+		.sgn_preq = 1,
+		.ratio_preq = 2,
+		.sgn_post1q = 1,
+		.ratio_post1q = 7,
+		.amp_red = 0,
+		.adpt_eq = 48,
+		.enter_idle_flt_sel = 0,
+		.exit_idle_flt_sel = 0,
+		.data_lost_th_sel = 0,
+		.gk2ovd = 0,
+		.gk3ovd = 0,
+		.gk4ovd = 5,
+		.gk2ovd_en = 0,
+		.gk3ovd_en = 0,
+		.gk4ovd_en = 1,
+		.eq_offset_ovd = 0x1f,
+		.eq_offset_ovd_en = 0,
+		.eq_offset_rng_dbl = 1,
+		.eq_blw_sel = 1,
+		.eq_boost = 2,
+		.spare_in = 3,
+		.smp_autoz_d1r = 2,
+		.smp_autoz_eg1r = 2,
+		.rccr0 = LNaRCCR0_CAL_EN |
+			 LNaRCCR0_CAL_DC3_DIS |
+			 LNaRCCR0_CAL_DC2_DIS |
+			 LNaRCCR0_CAL_DC1_DIS |
+			 LNaRCCR0_CAL_DC0_DIS,
+		.ttlcr0 = LNaTTLCR0_DATA_IN_SSC |
+			  FIELD_PREP_CONST(LNaTTLCR0_CDR_MIN_SMP_ON, 1),
+	},
 };
 
 struct lynx_pccr {
@@ -481,6 +522,8 @@ static const char *lynx_lane_mode_str(enum lynx_lane_mode lane_mode)
 		return "10GBase-R";
 	case LANE_MODE_USXGMII:
 		return "USXGMII";
+	case LANE_MODE_25GBASER:
+		return "25GBase-R";
 	default:
 		return "unknown";
 	}
@@ -496,6 +539,8 @@ static enum lynx_lane_mode phy_interface_to_lane_mode(phy_interface_t intf)
 		return LANE_MODE_10GBASER;
 	case PHY_INTERFACE_MODE_USXGMII:
 		return LANE_MODE_USXGMII;
+	case PHY_INTERFACE_MODE_25GBASER:
+		return LANE_MODE_25GBASER;
 	default:
 		return LANE_MODE_UNKNOWN;
 	}
@@ -576,6 +621,20 @@ static void lynx_28g_lane_set_nrate(struct lynx_28g_lane *lane,
 			break;
 		}
 		break;
+	case PLLnCR1_FRATE_12G_25GVCO:
+		switch (lane_mode) {
+		case LANE_MODE_25GBASER:
+			lynx_28g_lane_rmw(lane, LNaTGCR0,
+					  FIELD_PREP(LNaTGCR0_N_RATE, LNaTGCR0_N_RATE_DOUBLE),
+					  LNaTGCR0_N_RATE);
+			lynx_28g_lane_rmw(lane, LNaRGCR0,
+					  FIELD_PREP(LNaRGCR0_N_RATE, LNaRGCR0_N_RATE_DOUBLE),
+					  LNaRGCR0_N_RATE);
+			break;
+		default:
+			break;
+		}
+		break;
 	default:
 		break;
 	}
@@ -653,6 +712,11 @@ static int lynx_28g_power_on(struct phy *phy)
 	return 0;
 }
 
+static int lynx_28g_e25g_pcvt(int lane)
+{
+	return 7 - lane;
+}
+
 static int lynx_28g_get_pccr(enum lynx_lane_mode lane_mode, int lane,
 			     struct lynx_pccr *pccr)
 {
@@ -668,6 +732,11 @@ static int lynx_28g_get_pccr(enum lynx_lane_mode lane_mode, int lane,
 		pccr->width = 4;
 		pccr->shift = SXGMII_CFG(lane);
 		break;
+	case LANE_MODE_25GBASER:
+		pccr->offset = PCCD;
+		pccr->width = 4;
+		pccr->shift = E25G_CFG(lynx_28g_e25g_pcvt(lane));
+		break;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -683,6 +752,8 @@ static int lynx_28g_get_pcvt_offset(int lane, enum lynx_lane_mode lane_mode)
 	case LANE_MODE_USXGMII:
 	case LANE_MODE_10GBASER:
 		return SXGMIIaCR0(lane);
+	case LANE_MODE_25GBASER:
+		return E25GaCR0(lynx_28g_e25g_pcvt(lane));
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -924,6 +995,9 @@ static int lynx_28g_lane_enable_pcvt(struct lynx_28g_lane *lane,
 	case LANE_MODE_USXGMII:
 		val |= PCCC_SXGMIIn_CFG;
 		break;
+	case LANE_MODE_25GBASER:
+		val |= PCCD_E25Gn_CFG;
+		break;
 	default:
 		break;
 	}
@@ -1050,8 +1124,12 @@ static void lynx_28g_pll_read_configuration(struct lynx_28g_priv *priv)
 			__set_bit(LANE_MODE_10GBASER, pll->supported);
 			__set_bit(LANE_MODE_USXGMII, pll->supported);
 			break;
+		case PLLnCR1_FRATE_12G_25GVCO:
+			/* 12.890625GHz clock net */
+			__set_bit(LANE_MODE_25GBASER, pll->supported);
+			break;
 		default:
-			/* 6GHz, 12.890625GHz, 8GHz */
+			/* 6GHz, 8GHz */
 			break;
 		}
 	}
@@ -1108,6 +1186,9 @@ static void lynx_28g_lane_read_configuration(struct lynx_28g_lane *lane)
 		else
 			lane->mode = LANE_MODE_USXGMII;
 		break;
+	case LNaPSS_TYPE_25G:
+		lane->mode = LANE_MODE_25GBASER;
+		break;
 	default:
 		lane->mode = LANE_MODE_UNKNOWN;
 	}
-- 
2.34.1


