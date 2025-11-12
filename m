Return-Path: <linux-kernel+bounces-897466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D27C53464
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E803550771A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC2F33CEA1;
	Wed, 12 Nov 2025 14:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="HM9TdXxr"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010048.outbound.protection.outlook.com [52.101.84.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BBA33D6F1;
	Wed, 12 Nov 2025 14:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762958793; cv=fail; b=gyhqxhRQYYCQXS3DokPHztpS+3bm3aXbgx827VcKVgGx4PJreryBLemZfWCul+51zOoPh3yTs1HZlocCd9TbdrXlyjpVucMv+/Oac9HxV9WOhwn5a2o1qyaPK62oopGw9Djc30M6QgXW6LMlT/pHp7MqEElFS5NACDm6bKjCf+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762958793; c=relaxed/simple;
	bh=UrdGvvRI86ODIqkmTKiKA8jrpEP89FJ0SJR61grKv9U=;
	h=To:Cc:Subject:Date:Message-ID:Content-Type:From:MIME-Version; b=NnIZLXAUEcRD51y2b5RZ73Q/tkuO6tevx1elmZrsYGFowHJfguYTMKNE/XKDiFH8aHohMQosbpyCYqUu19tjZ0BU789B7V7oXmFTEm5LVfoh/lpgysivx57UxMwGsbDEE5M+e/fKznzjPBIxTtOvdPCXr+51Tw2hnF7jRk76DMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=HM9TdXxr; arc=fail smtp.client-ip=52.101.84.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jGjT9aMMnEfQhRU1dB2zY8MBMo/+n2OdKiHa0m7L+XzsyVjIRkDMDB3U1RfwPQHWK5xI0QaM4OOyaHDPzFppaH0sQn3NIJYCwUzl2oOsMTMBrgXWGRAH85r/KhrOvCSfP6MIvEv2blxldjmVm5sj2FZuXnd70qX+perWKsw7r3DvA+9sSu9cVLxAO6H0HXIEwzwZZjNDPbA8LhZl2fJOqdLmPB5u+uJV7jU+rRoXxb3Iz/C/UYa0rZyiUEjfEmBL9AWpyvTPWX++OSEpaRoz5lhJo+rBcIjkket/e2FTbnA/lO6dCQXpNioiOzyIaQy/4nDz/KTOshq92rSIOSY1SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cqMw1g4IHmJj9+geRGjPiNfadru45wEe5ApC5UBImAY=;
 b=xm84UaMeJLa2kP+FPgqgt0z+TuTvgMvLtcRXkqBnMyJLv/SfUf2GdXuXSNO4DMfJl1kxtv7mItD4XqbcWc8c0b9Hd4Gj200LinCjw9K2YVmqOyQlaT9LnFPniTCEwDhTxqkaLLrqtS+eJ2taDi3aJxGaxrQM7nUl0qZ9wuufeF6R0uhA5uAboh4sB8YZtaYFiI0KUTrTYGYFp+G/2gEplSwBYEH/Fe6h20j7KpW+uuav3BjytVogATO+gRwE0VHyjLOs+C8WHeo67uTjREdi6w3qLC6w+GAPtNX2Jc3bc8jJwcScaUldGnDJIRCfW/bacfL3uojm57ajk271galgcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cqMw1g4IHmJj9+geRGjPiNfadru45wEe5ApC5UBImAY=;
 b=HM9TdXxrpTTOvPO+oJKicAVK6gTIs2QgJn7Rf2QhbKweB+wdCzmGd2bBCDHyGT1rrLVMZ1ra3ttfAnnLwtKLEo2EtMuUfmc+jDb4265Op+e5vyWhM+DkC62uAbtdkBRusm+RiDKPfcWzfkhRN6SXci16z2CrtiIL8V8O82Wl4/w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AM0PR10MB2561.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:12c::15)
 by DU0PR10MB5218.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:346::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Wed, 12 Nov
 2025 14:46:24 +0000
Received: from AM0PR10MB2561.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::cce1:f0a3:698a:f450]) by AM0PR10MB2561.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::cce1:f0a3:698a:f450%5]) with mapi id 15.20.9298.015; Wed, 12 Nov 2025
 14:46:24 +0000
To: Frank.li@nxp.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: Stefan Prisacariu <stefan.prisacariu@prevas.dk>
Subject: [PATCH v2] ARM: dts: imx6qdl: make VAR-SOM SoM SoC-agnostic
Date: Wed, 12 Nov 2025 15:44:16 +0100
Message-ID: <20251112144441.1827336-1-stefan.prisacariu@prevas.dk>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
From: <stefan.prisacariu@prevas.dk>
X-ClientProxiedBy: MM0P280CA0035.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::23) To AM0PR10MB2561.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:12c::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR10MB2561:EE_|DU0PR10MB5218:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ba30486-50e8-4638-8242-08de21fa40b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|7416014|13003099007|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3KELcon2lTlBUh+DuCninsJL0gOlJWxa143lDHhKlUEpQwPkagtvkB4z90M6?=
 =?us-ascii?Q?qAlsDBjNTK5Clx4KPtuOh4FinvAsOxIwyNO+l9mtrpQ1Pvf714lyyzLiH7mF?=
 =?us-ascii?Q?KEZNzDPAEpI+ebHI29MSzGwb7+ToI7UEYqIN2qtx0c9za/dYZtR8rWCR4r1I?=
 =?us-ascii?Q?NnIbn4ioGP/C1QquIQFXjuU/WOAjoj2toNd65aDi8XJd6APa5TMCX1Oej5NQ?=
 =?us-ascii?Q?ltafzxFTPxO0cZ51K7XbJzXZHySEiQ1hlKakJGYe/haL0JRrOz2A3kHlxbRF?=
 =?us-ascii?Q?iJmF8VvyUEWWiJ7yOLKC1OHLmJjNZ97Y7VQgJLJygahdkppLZzha+IXOTj0F?=
 =?us-ascii?Q?3gGE85Qxw4LMOfNpApRjEFIZBvd07RPw2+Tnin/qS0fO7WU9mu0tGsAMqkB0?=
 =?us-ascii?Q?mWWtPMZraiSMamgIVfHkaehgXrAee9al6Sp57BeQoDXGXcIJBAcm+ObOUmq8?=
 =?us-ascii?Q?mbJeVlX9sCULLSHLONOQZAE6TIh/+5aiuKmpU0aZqhwty3WE2dh46YLYMIkQ?=
 =?us-ascii?Q?Jt0DbRGqVsreWBCnZjEAGCWklVl/BM8f02eTgCnzmj6nps9HE7zslQBVArnx?=
 =?us-ascii?Q?/d9Cfy8Wb/6vEXTFgk9huuXxi4e/Yq1qAdtIDf079ZoYwR8mcMVz8aX1iYdg?=
 =?us-ascii?Q?sKN9/ssVC7uA3DfPV4OlxXd3jqJPEYHxomCTe0AVtzG//HX8U3SX39fBH/vu?=
 =?us-ascii?Q?XOC+hgeJHj+nIZGqec80pdox6TnLswhDa1664HbNHShlIpzVWvCmbmVoE6jp?=
 =?us-ascii?Q?iR5nrkFNugLWp3c2EpKgcwE1V1ILHQslBBRz16Symf0ttmgaRB6BXKs87/7s?=
 =?us-ascii?Q?qBXXhWMzhDYEvEumJt7M1b7L/mINbJ+xZsDgw11HHfbWIstBMKgtf10DBL+4?=
 =?us-ascii?Q?xLRxJMMgEP0UrsF3bBwAJ/0m8Z2R5UbB6IHHtJzdVPvX3kN2QB8XIAHaHpbn?=
 =?us-ascii?Q?LHp1Z7Dk31pv/nkgiKpacFtTsjZ7IRuZe66fiqLrnj9+E78BEX3jEs7zMt1R?=
 =?us-ascii?Q?XCCfWwUhSWOgwx4/h2z8jhJgYhk4ka5GW5eYkv/Kw2IKqW+BZvsNyUWQTb3E?=
 =?us-ascii?Q?sMuTbhZV948pLWm6l6PbsIAv4Zr+RWBRoJTnp5Aix9l3xpsHC44ZrOunL9Ov?=
 =?us-ascii?Q?79zpBtgWTpwTXE8IyyTnSMq3WhxdIKwEilqki0DSQiB2tqviUsiVwlz4Vdi6?=
 =?us-ascii?Q?K3LaQJ62a0b1I1v2BCk1gpq1I18BTQlFEd0LIWnGNceR//73XhA6usguAaul?=
 =?us-ascii?Q?asE9rLKMBqzS1d1wq1hP8m2R80y418y29XdNd9lZ7YcPCrFQrXSLguIzY9b7?=
 =?us-ascii?Q?AJthWwWWs1609GvQzAoCni5nARjcrDH63BlVKwnkyoKuXw4Po8gMNaHFQ4Ke?=
 =?us-ascii?Q?lZezajl9b+xqH0py62388N8r1FHIHe9iVRF/JNMeNgzL3QOYIJaQ6LnolfoT?=
 =?us-ascii?Q?DRj9hsTq0euX1zE9Yf5QPO9Jj7BoKjhOlHfdqjmZRQPN9Xon3KyvmvE2GbZb?=
 =?us-ascii?Q?BR/AuDo1zeeA9uzolcNbKmVIVa9klslHCtaQtLQYD4fGwz9WFJqgYxWxSA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2561.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(7416014)(13003099007)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fULk7b6UVhYaMzy2UvMUZIqg3okW/FpNNovpHsyk8khXAmRv5fD8YrqRwKxQ?=
 =?us-ascii?Q?KWLGB2jA6YwNZgRv3nUamCs6XFleTWxaDeFXcNax74VJWZn4/CD4YP1AjLuV?=
 =?us-ascii?Q?8Byg4vYpYbQthQtM/5AfNhUQ3hl3ahMEtrTKjFL76uJMwmFj9a84pKDdXZV/?=
 =?us-ascii?Q?1yYf80V54Sz8tSz3K0mGF3cgpWyRZoGar0pwVlu74E3pfTCdyQLKdDyQs2SX?=
 =?us-ascii?Q?sSWKJHvwKQqL3ejWOD96NdxIdhj2PuBpywyyAhbmmxVF02spxOzdXUV9oVzG?=
 =?us-ascii?Q?mt+fnr+9D7Mke7O++02ZGIeSBn98iJMgPBIdHtou3qpY42LXKMgZT7+tIiWz?=
 =?us-ascii?Q?TPOFh3D72FJr7MLVYKGwlzm4pvDaJL1PtzdceKDv0zvvc4v2ofzncSw1O/F5?=
 =?us-ascii?Q?udwF3rQQHA0uOHxbPwoznNzRDZK/t5IawrWuNRkPRa2Gb4YCf0aBOM5vUT6f?=
 =?us-ascii?Q?hmtJj5wr9l0lbiyTgKFEbnt8HdABDkaCikWfiL11uvVXCiZQdvHt3mkyk///?=
 =?us-ascii?Q?53Qf3KqvY9tdTeGnY4JRIn2CsCtWapGnkQVczTGlBqegJDFR6BkIRHdSAwwL?=
 =?us-ascii?Q?RbwguDhXUfXt/qIFgJY2Uns9yEcCLmfj6yp3wvOUvgz2pWYqR53/jAAS914I?=
 =?us-ascii?Q?OaIp1nONyyYWN754v5gLOXIoJymRLQS2RKQdYtuO92zEYRRHpwCH67oqtu7o?=
 =?us-ascii?Q?v7CrhFsTKj4WRJpK8HJuYd8lBdbbeUd0VSfb4y57W9ks1zMacSPF9m6Lwzgc?=
 =?us-ascii?Q?+w6ZyibGeI5OANykkPqNmwQfqRJXLD75BucJCgzkuteLTVAYMYc4YfbA7/9a?=
 =?us-ascii?Q?HXdWKITBFuT+mFgaRAAI4FqsQvai/I0e2S8Q7xDSuVLPtTaUaiQrkKGHSAu0?=
 =?us-ascii?Q?vbbmB+2msOEM3h1NgLrqdDVUsyRdGcNIOpnMIiU7HuF1UWeHTcBTNSIPoGKH?=
 =?us-ascii?Q?DVp0+4BhTF4kJUA6bdsHL81UdZU/KJr8ZrDOU55ZeX15yjs2zyuHhB2jtW7B?=
 =?us-ascii?Q?of8Zs5OdW9vyPw8e0SGyPAXF8N6LTymKjAe9I18E3T3c5Ds8hMSoG4/Lvqcq?=
 =?us-ascii?Q?R/2UuwYtjDqthfLwwLuF8ZqHkrFq+qMaednQvt9xcx1T2+1iH31jt3W7d+qv?=
 =?us-ascii?Q?4W5R1sVseXWLQNQ5tK4vCAoweKHXtzjQKntLv3pvlnKGUTfcZAzZw0kvRZTp?=
 =?us-ascii?Q?glmGRro13KttjABM9g4rI4Z6E91pgk6+BBXImFSvZiMWeRhgadlh4iIA6GXw?=
 =?us-ascii?Q?FBP9h5SXBLcRPNGrxHKTFHtwE/Aa1je90MZcRSctVpC1Judz4zC2rLS2taZ8?=
 =?us-ascii?Q?KyZrWf2dqKO4CuV6CY0b02/BVqS+hKT86XvNKpvyTrTI8U6PDI+Eszu8zuXB?=
 =?us-ascii?Q?M19pzmnYcb7FKatCJk5XLHKlFp+m4AmhF3T7yuZe7LWHp8NNU9sxG1o4aXf2?=
 =?us-ascii?Q?hycyu+ycC83iHoH5ZbTwjyykzzUWWKDmk6/ITXouiI8EjiH6u3SWb3qtKbqt?=
 =?us-ascii?Q?lB5YGv1PiwdAH5TKvLW44YcR78P3tVQEgHadrHUd2CHNOPGy3EPK52OPObp/?=
 =?us-ascii?Q?FzldZzbNEorxfd5alHJe2e/j2akRALqxDXvl9BAsittiSJGFOk5e06oU6fsQ?=
 =?us-ascii?Q?Pg=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ba30486-50e8-4638-8242-08de21fa40b4
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2561.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 14:46:24.5540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KNTMSjX2sdGSSYvKu/y2Cvc6FAurrP2rGTu5/qVo5h8aorxSDU/bidHL1mth5QtrbwSkswRASdIe0rLwBgB6Fq50vJUZ15AsUimmiMj36QA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5218

From: Stefan Prisacariu <stefan.prisacariu@prevas.dk>

Make SoM .dtsi SoC-agnostic by moving SoC include to board level

imx6qdl-var-som.dtsi currently includes imx6q.dtsi, which makes this SoM
description Quad/Dual specific and prevents reuse from i.MX6DL boards.

Changes:
 - Move imx6q.dtsi include from imx6qdl-var-som.dtsi to
imx6q-var-mx6customboard.dts.
 - Remove /dts-v1/; from imx6qdl-var-som.dtsi (dtsi files should not declare
version)

This keeps the SoM .dtsi SoC-agnostic (it already relies on imx6qdl.dtsi for
family-common parts) and allows boards using the DualLite or Solo to include
imx6dl.dtsi instead.

Why this is needed:
To reuse imx6qdl-var-som.dtsi on i.MX6DL board.

No functional changes for imx6q-var-mx6customboard are intended.

Signed-off-by: Stefan Prisacariu <stefan.prisacariu@prevas.dk>
Link: https://lore.kernel.org/all/20250925104942.4148376-1-stefan.prisacariu@prevas.dk/
---
v2: Updated git commit message to better explain the changes
v1: https://lore.kernel.org/all/20250925104942.4148376-1-stefan.prisacariu@prevas.dk/
---
 arch/arm/boot/dts/nxp/imx/imx6q-var-mx6customboard.dts | 1 +
 arch/arm/boot/dts/nxp/imx/imx6qdl-var-som.dtsi         | 3 ---
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-var-mx6customboard.dts b/arch/arm/boot/dts/nxp/imx/imx6q-var-mx6customboard.dts
index 18a620832a2a..a55644529c67 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6q-var-mx6customboard.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-var-mx6customboard.dts
@@ -8,6 +8,7 @@
 
 /dts-v1/;
 
+#include "imx6q.dtsi"
 #include "imx6qdl-var-som.dtsi"
 #include <dt-bindings/pwm/pwm.h>
 
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-var-som.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-var-som.dtsi
index 59833e8d11d8..51bcaf04546b 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-var-som.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-var-som.dtsi
@@ -9,9 +9,6 @@
  * Copyright 2022 Bootlin
  */
 
-/dts-v1/;
-
-#include "imx6q.dtsi"
 #include <dt-bindings/clock/imx6qdl-clock.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/sound/fsl-imx-audmux.h>
-- 
2.47.2


