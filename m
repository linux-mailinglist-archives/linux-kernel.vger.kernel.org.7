Return-Path: <linux-kernel+bounces-892683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0379C459CD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F7903B68C0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDF6301010;
	Mon, 10 Nov 2025 09:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dX3gCMEC"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013002.outbound.protection.outlook.com [40.107.159.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60E52FF657
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762766590; cv=fail; b=XBQbkQ74VhHQJzk99z2mqY4+G+GZRQ5L2JdNjp3T8z2R8YOPKemEYxVdYwQYXwjsBEfxWHlmt3h5B4pH09f7St2eClQWHwJC3BIHAVpzwuAZsYQQYRLIIpHAlONq3gB+9RkbWacRHRuAY0iyT4UYercSUwC6vtSU82wi8N+e6Zs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762766590; c=relaxed/simple;
	bh=Dts9nOR/oreezVTtBKz+XTGEB7blLzLZyNtjUpKtBK0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YEkSehDjKdnZxF8d6gL527s8R5YVUnrce1c015Ee1/DDIZ2y9bw9ys5VZOqAhkGpE+cEdYD2F4ZLd+P+kLsFAaWNhd5gk/17obb0V0TwmUbppDeEzf2sfvV7XpUMUT3UV+OhTB/+Vplx8mhAA9leH9S0x9yT+1VXqoVuicy3ozQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dX3gCMEC; arc=fail smtp.client-ip=40.107.159.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tYYYgLP1VcK7c6HgoOiibdpXKBDTHNat/eAZSbgdXD5f7Rq0Xsdio+8jbgyZqW2K9RzEeLNwwdkRyG8bZl9GcgazOylshWs2NFUP8sqerjs7RfjvJoS+3jZOISGCVskBTXviVaZ3yJOK1T1q4cvbLzBgJABKUUtKcPf54EiFTotMmk5p3rEruNVX0BJGTRw2EMHNz9ZlvhrzHxNhR9ObWDRDvtoj0w2Kf7qWOiUI5ZtDc9rIvXgLZ1e/fH7rNyJnfoCqmhDNGSga4Fr4Pw6RjlgcKE7UpfN7Y7sJvuRWsqVIGEyQg0BkjBigQlw2QfmbAKXFgbn2SyaNabZ5oRlxbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cO8ERhb+Z48MHmY4Xw+40Pv/uAHClh1Ri4NvdIKr7fg=;
 b=J/ygYnCvbUnmiwyFimmhJ7l0dbm19/dlfv+rVhk9EU+gyX35KOPeHwE5Gz8dy+sxr/fO1HHdTbWic9LdfiUFtCAXidk7AmPYj0vBNUNbjH59RGBQyrs8HyRjw0x+CSoBSe5gA8d0K8qqkEmI5wQivHIjMB34wZgy/+wVTiuD4Whs15qEO4qSvuLc5e3yZnVrXK6+cQ7fzWO9TYZjrmi60ScfWIptO2oUUV3JvH9xybFr4RcsvEOycM3bl8O4KJDkotW8bGqw4HhzUKOEDx+LI49MpiS0D26ke/RGeJWrIbT8QGnDcnvDm3RSV/ufMX0iB8CK65ywVo0MfpmCdg+9IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cO8ERhb+Z48MHmY4Xw+40Pv/uAHClh1Ri4NvdIKr7fg=;
 b=dX3gCMECcK4jWGZelTrlVNHUEI1w60V4KykUQ8sm5BMu4tMrJ+A9X0Vib1J7MFYxQGo8ykwLZb72FJXd9FQEQhGaXeiY7Jk0Dj+rFHhjdvOmn1k1GTfM18Vz0igqhrYc3CsIY0EN5suarCX/aZ3vpiD/15PrcHwdp3vCVA9g8rRTRLUIrDuzIV8Q1nq8H30yKN1Hm4spiHvuGCf9J1pFiCiffLSno2kaa4F56odfM82I8uuWKCIXw7Vz353zrCXk+qysmMyoSramnCGnsmDe+FH17Lmsm85OwPuYkQ/qaYbCj7Vj6UmRnk5O5hqLEsbiTs1ggwEUbD8mIZoYfisQTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PA1PR04MB10468.eurprd04.prod.outlook.com (2603:10a6:102:448::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 09:23:01 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9298.010; Mon, 10 Nov 2025
 09:23:01 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Josua Mayer <josua@solid-run.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 phy 06/16] phy: lynx-28g: use FIELD_GET() and FIELD_PREP()
Date: Mon, 10 Nov 2025 11:22:31 +0200
Message-Id: <20251110092241.1306838-7-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110092241.1306838-1-vladimir.oltean@nxp.com>
References: <20251110092241.1306838-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0026.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::31) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PA1PR04MB10468:EE_
X-MS-Office365-Filtering-Correlation-Id: 307a7339-22e4-4d7b-61ed-08de203abea5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hTgEcDJfWWpYKHJZ6U4b4BxiF3cMpeq3h6vrUPZHeCDSYwLTKr177TY/ITXz?=
 =?us-ascii?Q?CHRqPdE8K7+NQU7YxRa1MgMeiMnvTGwAdD3DkAcrIS0qxvCtWwcbRcZ+OdLy?=
 =?us-ascii?Q?wjA3Wo4w9LQrG9Qou1Ix0PIyKKGCM8K5N2NkyKaHgYRcCwpiTLv54nfRKSa8?=
 =?us-ascii?Q?R0DZcvPZT2oQ4Y1Hg/OEWOcUSmCwOYaz3qocU4yLVnmpjq0aHIGAWflmuqgw?=
 =?us-ascii?Q?TQVWMlFaeCr4xGYHIfOiRwdMKo/jUfDhAPdMPur8F3kdItf34Z58vGrPaQBA?=
 =?us-ascii?Q?mR6tM1v0PL4g5O2MeOrI0QY9F3aUPCYrpRrOdWhl5JpgPt+cTgaBzbNBqiZp?=
 =?us-ascii?Q?tjWvQka3coyOJWCrAeJapRg0wldm+vgJlRsQL8gOC/Yejw5wBB2iC9GKA7Ru?=
 =?us-ascii?Q?dDI3UUPCVrwSb9yjsEnU+MmRExBlPPXmQMIykUbyym8jjqUzK9uc0Jpmthk5?=
 =?us-ascii?Q?2O4sfqRr6ziFdaH4bRE7I5f/KhylsXglpZ5eSfA/MlZi1rW06zDY0DtZes8T?=
 =?us-ascii?Q?tk0twg8qaU9yPzdXrXT6dLC5UL1J3ONlT4WZMOCCwx0tMDp17KFkWMHrYR2R?=
 =?us-ascii?Q?g3s8eMq7eSLvlajW515oa2Jkr8lM6dLU3fN4izQczAoiGOI1Qga5I/xKkkF/?=
 =?us-ascii?Q?1r8U5kByfw6C0ONw+cw11aX9tNTVDsDbOu1bI0g08sCUtEWPgEdGm8Vvpeqq?=
 =?us-ascii?Q?q2hvRukbxMNbi3IIAWwd7FHdExkDnF9ndy34xZ3gI/8uw++xuVeYEJU1e2LG?=
 =?us-ascii?Q?ZmyQL5nrwfHfJpEMgx+Thn0tuqvQldTKZu6JGplXLwKgXGUaiaHxYn2AlnwC?=
 =?us-ascii?Q?kwdgV5YWXgeKUdMYZYfL9CD46S87XrsEB28UVAL6RbkfEIDr6fQ4RlT4qqCz?=
 =?us-ascii?Q?AKAOQ0znwZtr1S+YzuYfgJsd5H6MTDgNYbKcjsz76lBliTHHheOEMi+kospJ?=
 =?us-ascii?Q?JhPTFih5JLLpzftwauO3mJ2ZlCiddV67u4taOgMYI3M2K+UymNhFp7euHIxI?=
 =?us-ascii?Q?QKOOybkyfIgC7ishOYUaDlcSoheFHfkjG1YWTVSPFMAp+RIsDPPybkNzhQmB?=
 =?us-ascii?Q?0oKC3QTDeRzbPCKjXyRLTcoO3t2b+AJo+TrOuv7F/X8uwPFpkN9RguhVPOU4?=
 =?us-ascii?Q?658u5nu1HkJ6gYQ2GeQXkQDIRhV3EcMdiZNb4HhSs9g1KMSkm5P91e3j/rtr?=
 =?us-ascii?Q?1dWathIAD6wVPrbK4np7TOLuKMMxu/Zbk0S0Cx6Sd3/Dg7hO4JFit73b+En7?=
 =?us-ascii?Q?Zs+u2fV/Jm5pz3gpkvLnSmaZHn23tMXGB/13VZk1oGV9MWkseRw2yRcqwO92?=
 =?us-ascii?Q?RRlSsTgambIQ0xyxQPWNk/+CQsXBRaGYma+JNsAE5E7bdZNan1tNxghDI8jv?=
 =?us-ascii?Q?jLc91TzfKUrfUL1lnjBUdE+Bzk82w17s4VxmzJe61lcI2xfl8awSTRV+nKoD?=
 =?us-ascii?Q?CCM4gaaG0v4t93DduOeBzem5vj9uEljobt6/ER5jvnoPYyh9cWIz0E3jzuBF?=
 =?us-ascii?Q?NhOdewG3+cqr/8KzXg6yiUyzoURZ6/r10GFO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1CF4cm6IiBymG9IBu9+FHy5uFqwCVrhhrTl8IuANcUpXAU4CJEw7bVweycc9?=
 =?us-ascii?Q?Z62gTn462vuFdSi+vTHubls8G2jMUZqhMPfEFUpmS7mrt8dI2GWm6MS3ZeVV?=
 =?us-ascii?Q?cMM/KEsf7rjP1yYtQZxa23Y9+GORqU7g3ZK35vZX/2W8T7CNilsqWhe5Y35r?=
 =?us-ascii?Q?Wyr6cWM8vUZ0txdsYf8DhHXyPf/C36V5LX738fLe71D39QaZ1PlX65xFY/K3?=
 =?us-ascii?Q?50N4huEDww6CKsxyo2Fmj2nO5eKHhm/m390le1Gmn0VZW9oPeZ9SeZR9W8oS?=
 =?us-ascii?Q?UqtIAWitQWuJ8Gu1D1ovgIzTglRfw7FjUF2ogDePvExPCEsA5QoUOXhSxTrf?=
 =?us-ascii?Q?UcNhZB9fzpVzzf7ChZiEi6SR2+9SPPq9Ns4Nb4jdUNWeJEZJvH7/vNGFrEhI?=
 =?us-ascii?Q?6qXBgPl8M92krCLsZZBsmoEd36XEp4vwq88xzlHThBkVecGrFzZgVsZOv1G+?=
 =?us-ascii?Q?aDsCzHWb4tONJmsiWoYDcER1rZQKDoXXH+XXx3U1qZpMIGs2AIOA2DdLbauA?=
 =?us-ascii?Q?UtnVBUbFqbyKTtLPfDB7Yjqz5bpUHBqPkAzzkECdQm4ls3gNx4Hw3OEwo4KB?=
 =?us-ascii?Q?0vv4lOXWY58ChPMCjQGw42o0piHpyyr2TmfcXJL3fWwNT6X7v9/MVOSlo/MU?=
 =?us-ascii?Q?Uq40CY4KsM3dP2AXGlmu1aSBpCed9fElus6MuWceAR4Koh3oKs4X9GIFvTtG?=
 =?us-ascii?Q?SREqeNB+3xAviMFb2WyDcH8bVpVNtQHyCy4xuSfZNsxZzxdEVMFAZgNudspt?=
 =?us-ascii?Q?/AmbmGvsYFe5TNrCXMDuRqVFXxrPs1UN+vIE0nqKeULl/R9+EJzrutzKnX0w?=
 =?us-ascii?Q?tmdIzKffbeHf6XTn7mm/M2OL6zxXlQEC8s8KZPRa4Tw4Svzn3wo2m4gr7g2F?=
 =?us-ascii?Q?hiKTAXjbWCRjmF9wk7PUQZ2F4IY/h4jEHlG4VLD+m0Otv5h+NS1Pdh7vsVxI?=
 =?us-ascii?Q?deBj/7ZPmQcaJs3scHURyDL4e3biJbq24brOaYOftQO/qe3na8R/cirrwU4r?=
 =?us-ascii?Q?2mjvTuvicjjTdWzskLBBYBoOchb/J7Y5acaB76zJ/ctRKaxNhwLBWOINAMiF?=
 =?us-ascii?Q?eo+OY8dw/+j/BidOgq3tfO0DFu+4KGhQGvN9Byf7Su9X9574LsHdiGLVN/Ax?=
 =?us-ascii?Q?fgTn9Wv5ugjvLGyMsBaruIL2F1nQ8UAgAeFuZy4ZTrmUcdKQd+9xfl1SBL35?=
 =?us-ascii?Q?5/I353iFmY9nK19Dz5fngtUGJKGmRF1NURP/pGYD8fBZ6u0fqaj4DF5q5zbS?=
 =?us-ascii?Q?4Oaqe2paCQZ3cAKQEfY7LXCDUEFxwT9Au+uYb0nT8Jc+cwOxwhrv0mXP6JUo?=
 =?us-ascii?Q?MmJu4MALHXl3OKA8y77J3KaY6A3lWowPFWkvuhtABu8Cgg5ZAULPX7djHazl?=
 =?us-ascii?Q?pvWJ3XOip9+06+JzAa3hW9JA9O8vwRtTTSU2YjAMxubnbKSZCPcSTsGx/4bH?=
 =?us-ascii?Q?U80xW7HJQjJDGlMLxtOd4zJKQOP+2Qu8QUw770au6fqap9xaFS3hlzSaoP1w?=
 =?us-ascii?Q?Fpx14MCD+evRHxPknQGpwl/naMPbVbVsyI224sRZN5141G92/+O2vCyva6S7?=
 =?us-ascii?Q?yyX/f8E0IzkWp6Jt7g5BmN1reIaOCAW1uWjIbFOWykqU0akiFaCGvpa+0Q53?=
 =?us-ascii?Q?uA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 307a7339-22e4-4d7b-61ed-08de203abea5
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 09:23:01.4563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ESh1B4KYP/WQ1QFmj4Sozia0Kav7ey4tBmKFi8ivm7YZLQel38ZIGvKR1+5waEJzb35hB41lXqKhxSuPnvZxFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10468

Reduce the number of bit field definitions required in this driver (in
the worst case, a read form and a write form), by defining just the
mask, and using the FIELD_GET() and FIELD_PREP() API from
<linux/bitfield.h> with that.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v4: none

 drivers/phy/freescale/phy-fsl-lynx-28g.c | 107 ++++++++++++-----------
 1 file changed, 57 insertions(+), 50 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-lynx-28g.c b/drivers/phy/freescale/phy-fsl-lynx-28g.c
index a5a76e0dff89..4c699829026c 100644
--- a/drivers/phy/freescale/phy-fsl-lynx-28g.c
+++ b/drivers/phy/freescale/phy-fsl-lynx-28g.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 /* Copyright (c) 2021-2022 NXP. */
 
+#include <linux/bitfield.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/phy.h>
@@ -29,26 +30,26 @@
 #define PLLnRSTCTL_LOCK(rstctl)			(((rstctl) & BIT(23)) >> 23)
 
 #define PLLnCR0(pll)				(0x400 + (pll) * 0x100 + 0x4)
-#define PLLnCR0_REFCLK_SEL(cr0)			(((cr0) & GENMASK(20, 16)))
+#define PLLnCR0_REFCLK_SEL			GENMASK(20, 16)
 #define PLLnCR0_REFCLK_SEL_100MHZ		0x0
-#define PLLnCR0_REFCLK_SEL_125MHZ		0x10000
-#define PLLnCR0_REFCLK_SEL_156MHZ		0x20000
-#define PLLnCR0_REFCLK_SEL_150MHZ		0x30000
-#define PLLnCR0_REFCLK_SEL_161MHZ		0x40000
+#define PLLnCR0_REFCLK_SEL_125MHZ		0x1
+#define PLLnCR0_REFCLK_SEL_156MHZ		0x2
+#define PLLnCR0_REFCLK_SEL_150MHZ		0x3
+#define PLLnCR0_REFCLK_SEL_161MHZ		0x4
 
 #define PLLnCR1(pll)				(0x400 + (pll) * 0x100 + 0x8)
-#define PLLnCR1_FRATE_SEL(cr1)			(((cr1) & GENMASK(28, 24)))
+#define PLLnCR1_FRATE_SEL			GENMASK(28, 24)
 #define PLLnCR1_FRATE_5G_10GVCO			0x0
-#define PLLnCR1_FRATE_5G_25GVCO			0x10000000
-#define PLLnCR1_FRATE_10G_20GVCO		0x6000000
+#define PLLnCR1_FRATE_5G_25GVCO			0x10
+#define PLLnCR1_FRATE_10G_20GVCO		0x6
 
 /* Per SerDes lane registers */
 /* Lane a General Control Register */
 #define LNaGCR0(lane)				(0x800 + (lane) * 0x100 + 0x0)
-#define LNaGCR0_PROTO_SEL_MSK			GENMASK(7, 3)
-#define LNaGCR0_PROTO_SEL_SGMII			0x8
-#define LNaGCR0_PROTO_SEL_XFI			0x50
-#define LNaGCR0_IF_WIDTH_MSK			GENMASK(2, 0)
+#define LNaGCR0_PROTO_SEL			GENMASK(7, 3)
+#define LNaGCR0_PROTO_SEL_SGMII			0x1
+#define LNaGCR0_PROTO_SEL_XFI			0xa
+#define LNaGCR0_IF_WIDTH			GENMASK(2, 0)
 #define LNaGCR0_IF_WIDTH_10_BIT			0x0
 #define LNaGCR0_IF_WIDTH_20_BIT			0x2
 
@@ -60,13 +61,13 @@
 
 /* Lane a Tx General Control Register */
 #define LNaTGCR0(lane)				(0x800 + (lane) * 0x100 + 0x24)
+#define LNaTGCR0_USE_PLL			BIT(28)
 #define LNaTGCR0_USE_PLLF			0x0
-#define LNaTGCR0_USE_PLLS			BIT(28)
-#define LNaTGCR0_USE_PLL_MSK			BIT(28)
+#define LNaTGCR0_USE_PLLS			0x1
+#define LNaTGCR0_N_RATE				GENMASK(26, 24)
 #define LNaTGCR0_N_RATE_FULL			0x0
-#define LNaTGCR0_N_RATE_HALF			0x1000000
-#define LNaTGCR0_N_RATE_QUARTER			0x2000000
-#define LNaTGCR0_N_RATE_MSK			GENMASK(26, 24)
+#define LNaTGCR0_N_RATE_HALF			0x1
+#define LNaTGCR0_N_RATE_QUARTER			0x2
 
 #define LNaTECR0(lane)				(0x800 + (lane) * 0x100 + 0x30)
 
@@ -79,14 +80,13 @@
 
 /* Lane a Rx General Control Register */
 #define LNaRGCR0(lane)				(0x800 + (lane) * 0x100 + 0x44)
+#define LNaRGCR0_USE_PLL			BIT(28)
 #define LNaRGCR0_USE_PLLF			0x0
-#define LNaRGCR0_USE_PLLS			BIT(28)
-#define LNaRGCR0_USE_PLL_MSK			BIT(28)
-#define LNaRGCR0_N_RATE_MSK			GENMASK(26, 24)
+#define LNaRGCR0_USE_PLLS			0x1
+#define LNaRGCR0_N_RATE				GENMASK(26, 24)
 #define LNaRGCR0_N_RATE_FULL			0x0
-#define LNaRGCR0_N_RATE_HALF			0x1000000
-#define LNaRGCR0_N_RATE_QUARTER			0x2000000
-#define LNaRGCR0_N_RATE_MSK			GENMASK(26, 24)
+#define LNaRGCR0_N_RATE_HALF			0x1
+#define LNaRGCR0_N_RATE_QUARTER			0x2
 
 #define LNaRGCR1(lane)				(0x800 + (lane) * 0x100 + 0x48)
 
@@ -97,13 +97,12 @@
 #define LNaRSCCR0(lane)				(0x800 + (lane) * 0x100 + 0x74)
 
 #define LNaPSS(lane)				(0x1000 + (lane) * 0x4)
-#define LNaPSS_TYPE(pss)			(((pss) & GENMASK(30, 24)) >> 24)
+#define LNaPSS_TYPE				GENMASK(30, 24)
 #define LNaPSS_TYPE_SGMII			0x4
 #define LNaPSS_TYPE_XFI				0x28
 
 #define SGMIIaCR1(lane)				(0x1804 + (lane) * 0x10)
 #define SGMIIaCR1_SGPCS_EN			BIT(11)
-#define SGMIIaCR1_SGPCS_MSK			BIT(11)
 
 struct lynx_28g_priv;
 
@@ -197,18 +196,18 @@ static void lynx_28g_lane_set_nrate(struct lynx_28g_lane *lane,
 				    struct lynx_28g_pll *pll,
 				    phy_interface_t intf)
 {
-	switch (PLLnCR1_FRATE_SEL(pll->cr1)) {
+	switch (FIELD_GET(PLLnCR1_FRATE_SEL, pll->cr1)) {
 	case PLLnCR1_FRATE_5G_10GVCO:
 	case PLLnCR1_FRATE_5G_25GVCO:
 		switch (intf) {
 		case PHY_INTERFACE_MODE_SGMII:
 		case PHY_INTERFACE_MODE_1000BASEX:
 			lynx_28g_lane_rmw(lane, LNaTGCR0,
-					  LNaTGCR0_N_RATE_QUARTER,
-					  LNaTGCR0_N_RATE_MSK);
+					  FIELD_PREP(LNaTGCR0_N_RATE, LNaTGCR0_N_RATE_QUARTER),
+					  LNaTGCR0_N_RATE);
 			lynx_28g_lane_rmw(lane, LNaRGCR0,
-					  LNaRGCR0_N_RATE_QUARTER,
-					  LNaRGCR0_N_RATE_MSK);
+					  FIELD_PREP(LNaRGCR0_N_RATE, LNaRGCR0_N_RATE_QUARTER),
+					  LNaRGCR0_N_RATE);
 			break;
 		default:
 			break;
@@ -218,10 +217,12 @@ static void lynx_28g_lane_set_nrate(struct lynx_28g_lane *lane,
 		switch (intf) {
 		case PHY_INTERFACE_MODE_10GBASER:
 		case PHY_INTERFACE_MODE_USXGMII:
-			lynx_28g_lane_rmw(lane, LNaTGCR0, LNaTGCR0_N_RATE_FULL,
-					  LNaTGCR0_N_RATE_MSK);
-			lynx_28g_lane_rmw(lane, LNaRGCR0, LNaRGCR0_N_RATE_FULL,
-					  LNaRGCR0_N_RATE_MSK);
+			lynx_28g_lane_rmw(lane, LNaTGCR0,
+					  FIELD_PREP(LNaTGCR0_N_RATE, LNaTGCR0_N_RATE_FULL),
+					  LNaTGCR0_N_RATE);
+			lynx_28g_lane_rmw(lane, LNaRGCR0,
+					  FIELD_PREP(LNaRGCR0_N_RATE, LNaRGCR0_N_RATE_FULL),
+					  LNaRGCR0_N_RATE);
 			break;
 		default:
 			break;
@@ -236,15 +237,19 @@ static void lynx_28g_lane_set_pll(struct lynx_28g_lane *lane,
 				  struct lynx_28g_pll *pll)
 {
 	if (pll->id == 0) {
-		lynx_28g_lane_rmw(lane, LNaTGCR0, LNaTGCR0_USE_PLLF,
-				  LNaTGCR0_USE_PLL_MSK);
-		lynx_28g_lane_rmw(lane, LNaRGCR0, LNaRGCR0_USE_PLLF,
-				  LNaRGCR0_USE_PLL_MSK);
+		lynx_28g_lane_rmw(lane, LNaTGCR0,
+				  FIELD_PREP(LNaTGCR0_USE_PLL, LNaTGCR0_USE_PLLF),
+				  LNaTGCR0_USE_PLL);
+		lynx_28g_lane_rmw(lane, LNaRGCR0,
+				  FIELD_PREP(LNaRGCR0_USE_PLL, LNaRGCR0_USE_PLLF),
+				  LNaRGCR0_USE_PLL);
 	} else {
-		lynx_28g_lane_rmw(lane, LNaTGCR0, LNaTGCR0_USE_PLLS,
-				  LNaTGCR0_USE_PLL_MSK);
-		lynx_28g_lane_rmw(lane, LNaRGCR0, LNaRGCR0_USE_PLLS,
-				  LNaRGCR0_USE_PLL_MSK);
+		lynx_28g_lane_rmw(lane, LNaTGCR0,
+				  FIELD_PREP(LNaTGCR0_USE_PLL, LNaTGCR0_USE_PLLS),
+				  LNaTGCR0_USE_PLL);
+		lynx_28g_lane_rmw(lane, LNaRGCR0,
+				  FIELD_PREP(LNaRGCR0_USE_PLL, LNaRGCR0_USE_PLLS),
+				  LNaRGCR0_USE_PLL);
 	}
 }
 
@@ -286,8 +291,9 @@ static void lynx_28g_lane_set_sgmii(struct lynx_28g_lane *lane)
 
 	/* Setup the protocol select and SerDes parallel interface width */
 	lynx_28g_lane_rmw(lane, LNaGCR0,
-			  LNaGCR0_PROTO_SEL_SGMII | LNaGCR0_IF_WIDTH_10_BIT,
-			  LNaGCR0_PROTO_SEL_MSK | LNaGCR0_IF_WIDTH_MSK);
+			  FIELD_PREP(LNaGCR0_PROTO_SEL, LNaGCR0_PROTO_SEL_SGMII) |
+			  FIELD_PREP(LNaGCR0_IF_WIDTH, LNaGCR0_IF_WIDTH_10_BIT),
+			  LNaGCR0_PROTO_SEL | LNaGCR0_IF_WIDTH);
 
 	/* Find the PLL that works with this interface type */
 	pll = lynx_28g_pll_get(priv, PHY_INTERFACE_MODE_SGMII);
@@ -302,7 +308,7 @@ static void lynx_28g_lane_set_sgmii(struct lynx_28g_lane *lane)
 
 	/* Enable the SGMII PCS */
 	lynx_28g_lane_rmw(lane, SGMIIaCR1, SGMIIaCR1_SGPCS_EN,
-			  SGMIIaCR1_SGPCS_MSK);
+			  SGMIIaCR1_SGPCS_EN);
 
 	/* Configure the appropriate equalization parameters for the protocol */
 	iowrite32(0x00808006, priv->base + LNaTECR0(lane->id));
@@ -328,8 +334,9 @@ static void lynx_28g_lane_set_10gbaser(struct lynx_28g_lane *lane)
 
 	/* Setup the protocol select and SerDes parallel interface width */
 	lynx_28g_lane_rmw(lane, LNaGCR0,
-			  LNaGCR0_PROTO_SEL_XFI | LNaGCR0_IF_WIDTH_20_BIT,
-			  LNaGCR0_PROTO_SEL_MSK | LNaGCR0_IF_WIDTH_MSK);
+			  FIELD_PREP(LNaGCR0_PROTO_SEL, LNaGCR0_PROTO_SEL_XFI) |
+			  FIELD_PREP(LNaGCR0_IF_WIDTH, LNaGCR0_IF_WIDTH_20_BIT),
+			  LNaGCR0_PROTO_SEL | LNaGCR0_IF_WIDTH);
 
 	/* Find the PLL that works with this interface type */
 	pll = lynx_28g_pll_get(priv, PHY_INTERFACE_MODE_10GBASER);
@@ -343,7 +350,7 @@ static void lynx_28g_lane_set_10gbaser(struct lynx_28g_lane *lane)
 	lynx_28g_lane_set_nrate(lane, pll, PHY_INTERFACE_MODE_10GBASER);
 
 	/* Disable the SGMII PCS */
-	lynx_28g_lane_rmw(lane, SGMIIaCR1, 0, SGMIIaCR1_SGPCS_MSK);
+	lynx_28g_lane_rmw(lane, SGMIIaCR1, 0, SGMIIaCR1_SGPCS_EN);
 
 	/* Configure the appropriate equalization parameters for the protocol */
 	iowrite32(0x10808307, priv->base + LNaTECR0(lane->id));
@@ -513,7 +520,7 @@ static void lynx_28g_pll_read_configuration(struct lynx_28g_priv *priv)
 		if (PLLnRSTCTL_DIS(pll->rstctl))
 			continue;
 
-		switch (PLLnCR1_FRATE_SEL(pll->cr1)) {
+		switch (FIELD_GET(PLLnCR1_FRATE_SEL, pll->cr1)) {
 		case PLLnCR1_FRATE_5G_10GVCO:
 		case PLLnCR1_FRATE_5G_25GVCO:
 			/* 5GHz clock net */
@@ -570,7 +577,7 @@ static void lynx_28g_lane_read_configuration(struct lynx_28g_lane *lane)
 	u32 pss, protocol;
 
 	pss = lynx_28g_lane_read(lane, LNaPSS);
-	protocol = LNaPSS_TYPE(pss);
+	protocol = FIELD_GET(LNaPSS_TYPE, pss);
 	switch (protocol) {
 	case LNaPSS_TYPE_SGMII:
 		lane->interface = PHY_INTERFACE_MODE_SGMII;
-- 
2.34.1


