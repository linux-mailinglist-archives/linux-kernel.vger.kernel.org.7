Return-Path: <linux-kernel+bounces-830250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B661B99338
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 11:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D81004C4F20
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 09:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4219B2D97AA;
	Wed, 24 Sep 2025 09:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="Je+lHbX5"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020110.outbound.protection.outlook.com [52.101.69.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622322D9EC2;
	Wed, 24 Sep 2025 09:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758706902; cv=fail; b=DncoWpSdoLnw+HyjECk/p0wWNHvsUwXe6NP7gyoiKYF5cZIJgTebW9w+5xMmFesmapTZIaWu1BWqdl/dj++axa5jMTzIgGX1jQOgNFsn0ek3T43EOZaDusEuCJPeS+i+I4JRTZCxJahRRWd8cKWAqSvTdVa9nIQpYSfGRkYELAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758706902; c=relaxed/simple;
	bh=UW0JxqB4O5AT141DO/igGmdB5ylfV7yjJmhJBePHJho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QBvDlPJ84jCbR0vRcWmn5SSYWC0kDIbxaTK+TmEFJ+V98o6tfbE8wDVPAKvOCzvhkV9/SjO8yIm7jFE/MMp20NGv+hrpkjQWM4hjHbRipC72J1Nj5Q7T4MvzlTFhV0q1aZ467Ga2QGPHJ2rpdylF32wZlX1U7l5JaZriXNvGk1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=Je+lHbX5; arc=fail smtp.client-ip=52.101.69.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eGN/RevX0VTV8hNXvE/0IFAlJzSqnTqsYq7Qesp1XYeASt5KSzHYAidPdt74xQ/s98g9DMgbsxQrIOn6wI5XmeFhvyXrb69y9g/rMXMcNuM6AThj3avBkx4BTZ25cIzMReaH6cmPqKiBwV8Zud8txnK1VXv7an3czV247FaeBmpoCJOVTiM4FkDVbcoRBYBFgo4+daSPhiobtN/0W5xJsUhxkdpfc/kjU3uPT1oNeqh8KSGBia9b7PAe+WpgK45m7GjkBv2Ncw3GKcBedJZJSw774mXAX1OD/nnWIefII6EqNmdM5QC8DnuNl9OIubba0/2/WBMUpQ1ZEYrSQGbRfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Rkm7PmTzmoNGXzyaRHNq2Ac4Bjo92vYvTFt305jT+c=;
 b=JvajG7WDuHWRU77Yhkus7ypZOY2eOb10y6s34ogKKwS301Mn1SQvckHl6iTL+QyqBLJqUwAjrcp/W0IgE5mErcTKvsUu8IQgoQFrW1kU2pxKvCd5KkOggSROsdXQA6Kl7wQJcjQZkhmXe1p3nl9JbuStcHnJNdneWZG0014piZwDlFm0eo+1sQDJ87raP7hdCv7jJt6QWZeTH+y71yPq5BWvD5zDMO8C31VTlBkhRdlI8FFXb4XstMyAakw6PKApcj8I79p4jxg2ep/84NxjgPhYuiJwZMo5pKvX14lMb6NmGmMB2XQcviRpCkNSRt5HWUi+1oC7KW8ptuYxzBwnhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Rkm7PmTzmoNGXzyaRHNq2Ac4Bjo92vYvTFt305jT+c=;
 b=Je+lHbX5J8Z1fhv4YZQ3D4svjHlavSdKN0+031Be8HAOCBm/8ed276dPWdOtkcsKBeIx7+kkKwbIoVA8QsTJvxtt6UVNaDmzEoz9rjX+2QKCQXIxoKz1fEs3eKvevmyFiR/67sZBqPbmnNlnjqjC6t0HppO/4LVRd8rw/5rXNVXNZXPR0WiAg55ioUlfvzZfwio3O/dtVKEzDdAaSY8Ah6J/SC78sxdwYYFGGb3tSONa6USUDPJMfBOagWn5JAaTZdfAHbaILwbju2Z8yO9qWG1VrRjhrAIDayVKstFeJhHPYecPZmBx+Ps0njaOvZYgpwULcdj+ihS23Zi+vnv0lQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM9PR08MB6098.eurprd08.prod.outlook.com (2603:10a6:20b:2d9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 09:41:23 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 09:41:23 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Felix Fietkau <nbd@nbd.name>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
	Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v2 2/3] clk: en7523: Add reset-controller support for EN7523 SoC
Date: Wed, 24 Sep 2025 12:41:11 +0300
Message-ID: <20250924094112.1918444-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924094112.1918444-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250924060509.1889131-1-mikhail.kshevetskiy@iopsys.eu>
 <20250924094112.1918444-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0091.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:8::25) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM9PR08MB6098:EE_
X-MS-Office365-Filtering-Correlation-Id: 333473b1-cba0-4e05-ee4d-08ddfb4e85f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Nv8MpJST96I/DR2DGq7rxYYCRoEJgzDwndQirTMd+XDJwwMVQGZICr3WfOeT?=
 =?us-ascii?Q?O9gZg9hYbB1/b5SfbtC516fMsIgSWvvPj16PXyQ7Z8CsS7JnsbN/N8C5BdNc?=
 =?us-ascii?Q?wUxifTz2kteelO2R29q8MMN6D2VbxMmqreQQeDcQJxGh5Ru/pwzFTK6R1Gfh?=
 =?us-ascii?Q?yK1KX38s3WLq2Kz7131c8hedLfs+0FCRWSL/CKF7QCbJvVIcRCuqJZ1JrlCL?=
 =?us-ascii?Q?5bEE+TEw3+aUqNANZRqN51zUC1QstDBF5+Gt+Xr4Zrv/EXh3sgSnAPUVX0/2?=
 =?us-ascii?Q?RlWSPBELbXRx3T4rCVpHYB5c95iyE2DEzn8wMA6bd+yxNsYClz7jQNotQ98s?=
 =?us-ascii?Q?oGoJMgZxVmPLLIPOG5o3gIc29dcJneJk5hBSMOICpgHNAj1ahxZGvtVBo8MR?=
 =?us-ascii?Q?jGrJZO0TEaUeS6926UXVFsZ/oIreDyZFaK5gpHpE3NDKF3fs4XJxF3XD52Pa?=
 =?us-ascii?Q?ypgMDrY8nv4et2LpWaA0vvyfA/oDGnpE6XKoVQ20O3RwsW8/voqDT0J5geQl?=
 =?us-ascii?Q?jMmfq/sZOWWZCw9N4gyg10aE6q6e11e0aNAr4p2Hcxqlk98BMJ1Mw7wskHlm?=
 =?us-ascii?Q?MW5z/3Noc4OW0Cd5xEVSJAPXvBWxaL27cDzSDeiyK5fQSVsWfD/oSd/v+9nU?=
 =?us-ascii?Q?bF4tjqUYddDm6knYssg7R40eOjnyvxTQodiFoXTrQbf7EuB+CHHNuNliQxTm?=
 =?us-ascii?Q?fxLavrcn3gaFVsEAJzV1r6mIKSu48aSxwYZiwFLIK8n0CFB5nFgMsqYfASCG?=
 =?us-ascii?Q?nFW0sok2Z+0i4Qz3zbtQ9Gyg+jCtJZQ5mZOaZRrKNg0z6YTOdPgKyVBytCk2?=
 =?us-ascii?Q?dDj+mOur6u03Y46fYF+1e4tm93U3GrXQT1WjP2GrMWe5qprumDNABLBU7M8E?=
 =?us-ascii?Q?e0qR22CRwj+iSghLGR9fNqQI9K8fQ8sk4WJTtmrQoYrfiGyr3976Lf6aR5uL?=
 =?us-ascii?Q?IAF1+bjVgf5+XvnQLiy/aQ/L5rOsyyrcxpXezAwpWsjEaf7XxQwiN/4gW2wI?=
 =?us-ascii?Q?H7aEhYhWXmtVVAFxsWBxTd1XKCBsTZWHR+puk4p8BkAgfYgvOkn0Bs1ArUMU?=
 =?us-ascii?Q?XzRkj08fjCKDsMjgbqHN0iiVfAMQigitQpizeKwi8dT3QswI+5loQMLDB1mC?=
 =?us-ascii?Q?RqOmqDUE6JCvgRBo2rYmaP6EBDdZ8VlNJ/Kqi62ChzG19qtJocKkb5y+RPPY?=
 =?us-ascii?Q?Zm/E4234jg2UVMA2XlwR84I1l7vb6ncIQDltSewntyz9MukfD7p2UulAQNUH?=
 =?us-ascii?Q?4lf43KxE1ktxpqEFdZbugNNzOKhVIZn6fwwrX9kQDb0PvrOQhcHzV2Ef5Y98?=
 =?us-ascii?Q?uiioTyZl1PeTZ9UBk1+8wpHBudJgXg1Gi6jarEjpdlIq/t7+pFbyabtDRGMC?=
 =?us-ascii?Q?cW2jrBbGpjjyz2L6OfY9byKkciPNT2ZOvzsG7yvZ5exJHkNohAVrwu45jvUB?=
 =?us-ascii?Q?suOMa/Cy05qj2E/Aha1XpI1dhtmZAU24zjc7GV1skmabwOnt+5kbYYE92K9b?=
 =?us-ascii?Q?9InHSwZI4XEWylU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DkgAEElD1lILYLyp/01CA2Kil7gcd5s1Twy8Zujuj6A55saP2dgZBI6050RG?=
 =?us-ascii?Q?/w/vTD+DO3Gpg8jrRSr09nacDlqQc+m84+n0wg7iMigEYOZ9p3qkrK1BL1WT?=
 =?us-ascii?Q?SnfMwgiEZvY5Ok0xCVxU38y0DkhTLFV9r7/bI4goBkSxWtpaCaO2WtBJtsXJ?=
 =?us-ascii?Q?c/RaGlb6dt71ReYEeJ3/bMKZKBNStfeDxRrxR775aESHeZcboD+IKkkN4Evr?=
 =?us-ascii?Q?rkF4NYyo7d5zykgjYp1xEqjnHsZGkYLrJ11AxuqxIVBzKmLfEDRkSzWSQxHF?=
 =?us-ascii?Q?RSKs50mb7Z52CmI0Bqqwan1lalcGpzWnh4efafc1JxxCbXOS62VPlkiDYVGt?=
 =?us-ascii?Q?CHczbw7nVi+hI4HCuJJW1k64j0ILu/zStFFytqFcQ4vrB/aACRPYMqgafRai?=
 =?us-ascii?Q?Z9OyDw2IizZr8pmgzt7hYzj7A+9QUO2YJ0fO0IFsUgamlLd0/Z8WWeSOtXrv?=
 =?us-ascii?Q?bNqgpE29SXho6ZsiVidjT0wqKP1+jHORkKRim8vAqshqivwakLOzN9hUjPl6?=
 =?us-ascii?Q?aqx1KDVSOXIgwSPxrQIwrPsiDLAPF4oDCXHovuQgb1zas9uN5UASuVAEF8aF?=
 =?us-ascii?Q?5kWxy6+EcXvd8nqGmWV3AJ/6og/h7eNyQN+7XwfmOLXt3wCrlqKCXh6+itta?=
 =?us-ascii?Q?o+tiDawg6LF60XwiA7VXcTyHlcPMOELMr6qQzM43a0QGVhfe3PYiwsUXEk/G?=
 =?us-ascii?Q?65hZTJkZLRSMholBuYykWdHtJyS73grcx9jIFU4m7Z4JBfIyrWnlF2l1dLch?=
 =?us-ascii?Q?9RnOEPPyJZLtQjv9/NJgsjj9T+LmhzlNAYAfyXjyqrNVFedZ6JcOb/J29Ytb?=
 =?us-ascii?Q?5sCjjTSSBIva8QSAgUP/quBRtj86tjLjfX5urRxeIPiuonC/pPJYVgxPViX2?=
 =?us-ascii?Q?tJW9EF0JIFUJfxVQ3ooTDG4bG2r8KlnPg261XRU/qadhYf6A4s7zHKxKl5Nq?=
 =?us-ascii?Q?V3o11FQZx6/YvgDvtUEXaVosqqaH44hGK9Im1+/v7+/ElLrYyEJ42cid4l0k?=
 =?us-ascii?Q?OlhG9mlgTEPJAq5I/TFB8yxe7a4yPVW6wmOK0kNb2a3+o9BC7jTOtePqJeCP?=
 =?us-ascii?Q?z/yFHy44bE90aFOLkbzaw4a9N+fVDTS8osq5XK3CX3Ph5aYWwMUmg34tu7kD?=
 =?us-ascii?Q?0OpqOZIP7q+ANuhQPJb+wVyBmxmGlHHJNs3bW5ijClqkMlxRW7VZ5vm7TIBK?=
 =?us-ascii?Q?YtXEFgzUsphZAjEbVJO9Q8Hp93mDN3/uEFx8/cjuZm4NhMKXK09TxUOCA7RL?=
 =?us-ascii?Q?bghjV5iqRDd+979CiQbKKtIXkylSfpQn7FtALyZltV3QYx/s3fMFQCfQT6zm?=
 =?us-ascii?Q?hl8FlcfA/oQyza49vH6/+E+ob8FUYIaN360npfKzasdCEHGFHiOEiLD5bCJT?=
 =?us-ascii?Q?fN3BIoRv9nb9UfJU2yDU96wAdHfBFUzCD6p2cQq9JuGN51qb74sw44BmyKNL?=
 =?us-ascii?Q?LNwmXSf0TmZP6mJrLeXz+fpGJSGcy+eDuJD+bNWhrTeglllyqdD1N0YOciPr?=
 =?us-ascii?Q?sc0yDzVz2Jd2Y4UN9finxI273GBSWX2cJ/fASccfNBZLYyMFLJrNwQ4k5Mx6?=
 =?us-ascii?Q?tfon+Wle/sTKzekTss060WpVducQ22DLv1QnNqdtkXHrvj0xMMTbNKMxbUSP?=
 =?us-ascii?Q?3gIB57bRqtroXWmfpJcWIrY=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 333473b1-cba0-4e05-ee4d-08ddfb4e85f9
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 09:41:23.2469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WuePPci4tqdZ68ulKCGD+6X1Ml2R6ukjpHR5Tj92rrKSyDMW/LyUx9cODpKNBkyjZXXNAUQ9b1gI+BScBfVZFyE06+HxAL95gtEXVxXv09I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6098

Introduce reset API support to EN7523 clock driver. EN7523 uses the
same reset logic as EN7581, so just reuse existing code. The patch
renames:
 * en7581_rst_ofs to en75xx_rst_ofs,
 * en7581_reset_register() to en75xx_reset_register()
because they are not en7581 specific.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/clk/clk-en7523.c | 72 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 63 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/clk-en7523.c b/drivers/clk/clk-en7523.c
index 15bbdeb60b8e..f276937181b9 100644
--- a/drivers/clk/clk-en7523.c
+++ b/drivers/clk/clk-en7523.c
@@ -9,6 +9,7 @@
 #include <linux/regmap.h>
 #include <linux/reset-controller.h>
 #include <dt-bindings/clock/en7523-clk.h>
+#include <dt-bindings/reset/airoha,en7523-reset.h>
 #include <dt-bindings/reset/airoha,en7581-reset.h>
 
 #define RST_NR_PER_BANK			32
@@ -294,11 +295,58 @@ static const struct en_clk_desc en7581_base_clks[] = {
 	}
 };
 
-static const u16 en7581_rst_ofs[] = {
+static const u16 en75xx_rst_ofs[] = {
 	REG_RST_CTRL2,
 	REG_RST_CTRL1,
 };
 
+static const u16 en7523_rst_map[] = {
+	/* RST_CTRL2 */
+	[EN7523_XPON_PHY_RST]		= 0,
+	[EN7523_XSI_MAC_RST]		= 7,
+	[EN7523_XSI_PHY_RST]		= 8,
+	[EN7523_NPU_RST]		= 9,
+	[EN7523_I2S_RST]		= 10,
+	[EN7523_TRNG_RST]		= 11,
+	[EN7523_TRNG_MSTART_RST]	= 12,
+	[EN7523_DUAL_HSI0_RST]		= 13,
+	[EN7523_DUAL_HSI1_RST]		= 14,
+	[EN7523_HSI_RST]		= 15,
+	[EN7523_DUAL_HSI0_MAC_RST]	= 16,
+	[EN7523_DUAL_HSI1_MAC_RST]	= 17,
+	[EN7523_HSI_MAC_RST]		= 18,
+	[EN7523_WDMA_RST]		= 19,
+	[EN7523_WOE0_RST]		= 20,
+	[EN7523_WOE1_RST]		= 21,
+	[EN7523_HSDMA_RST]		= 22,
+	[EN7523_I2C2RBUS_RST]		= 23,
+	[EN7523_TDMA_RST]		= 24,
+	/* RST_CTRL1 */
+	[EN7523_PCM1_ZSI_ISI_RST]	= RST_NR_PER_BANK + 0,
+	[EN7523_FE_PDMA_RST]		= RST_NR_PER_BANK + 1,
+	[EN7523_FE_QDMA_RST]		= RST_NR_PER_BANK + 2,
+	[EN7523_PCM_SPIWP_RST]		= RST_NR_PER_BANK + 4,
+	[EN7523_CRYPTO_RST]		= RST_NR_PER_BANK + 6,
+	[EN7523_TIMER_RST]		= RST_NR_PER_BANK + 8,
+	[EN7523_PCM1_RST]		= RST_NR_PER_BANK + 11,
+	[EN7523_UART_RST]		= RST_NR_PER_BANK + 12,
+	[EN7523_GPIO_RST]		= RST_NR_PER_BANK + 13,
+	[EN7523_GDMA_RST]		= RST_NR_PER_BANK + 14,
+	[EN7523_I2C_MASTER_RST]		= RST_NR_PER_BANK + 16,
+	[EN7523_PCM2_ZSI_ISI_RST]	= RST_NR_PER_BANK + 17,
+	[EN7523_SFC_RST]		= RST_NR_PER_BANK + 18,
+	[EN7523_UART2_RST]		= RST_NR_PER_BANK + 19,
+	[EN7523_GDMP_RST]		= RST_NR_PER_BANK + 20,
+	[EN7523_FE_RST]			= RST_NR_PER_BANK + 21,
+	[EN7523_USB_HOST_P0_RST]	= RST_NR_PER_BANK + 22,
+	[EN7523_GSW_RST]		= RST_NR_PER_BANK + 23,
+	[EN7523_SFC2_PCM_RST]		= RST_NR_PER_BANK + 25,
+	[EN7523_PCIE0_RST]		= RST_NR_PER_BANK + 26,
+	[EN7523_PCIE1_RST]		= RST_NR_PER_BANK + 27,
+	[EN7523_PCIE_HB_RST]		= RST_NR_PER_BANK + 29,
+	[EN7523_XPON_MAC_RST]		= RST_NR_PER_BANK + 31,
+};
+
 static const u16 en7581_rst_map[] = {
 	/* RST_CTRL2 */
 	[EN7581_XPON_PHY_RST]		= 0,
@@ -357,6 +405,9 @@ static const u16 en7581_rst_map[] = {
 	[EN7581_XPON_MAC_RST]		= RST_NR_PER_BANK + 31,
 };
 
+static int en75xx_reset_register(struct device *dev, void __iomem *base,
+				 const u16 *rst_map, int nr_resets);
+
 static u32 en7523_get_base_rate(const struct en_clk_desc *desc, u32 val)
 {
 	if (!desc->base_bits)
@@ -552,7 +603,8 @@ static int en7523_clk_hw_init(struct platform_device *pdev,
 
 	en7523_register_clocks(&pdev->dev, clk_data, base, np_base);
 
-	return 0;
+	return en75xx_reset_register(&pdev->dev, np_base, en7523_rst_map,
+				     ARRAY_SIZE(en7523_rst_map));
 }
 
 static void en7581_register_clocks(struct device *dev, struct clk_hw_onecell_data *clk_data,
@@ -646,13 +698,14 @@ static int en7523_reset_xlate(struct reset_controller_dev *rcdev,
 	return rst_data->idx_map[reset_spec->args[0]];
 }
 
-static const struct reset_control_ops en7581_reset_ops = {
+static const struct reset_control_ops en75xx_reset_ops = {
 	.assert = en7523_reset_assert,
 	.deassert = en7523_reset_deassert,
 	.status = en7523_reset_status,
 };
 
-static int en7581_reset_register(struct device *dev, void __iomem *base)
+static int en75xx_reset_register(struct device *dev, void __iomem *base,
+				 const u16 *rst_map, int nr_resets)
 {
 	struct en_rst_data *rst_data;
 
@@ -660,13 +713,13 @@ static int en7581_reset_register(struct device *dev, void __iomem *base)
 	if (!rst_data)
 		return -ENOMEM;
 
-	rst_data->bank_ofs = en7581_rst_ofs;
-	rst_data->idx_map = en7581_rst_map;
+	rst_data->bank_ofs = en75xx_rst_ofs;
+	rst_data->idx_map = rst_map;
 	rst_data->base = base;
 
-	rst_data->rcdev.nr_resets = ARRAY_SIZE(en7581_rst_map);
+	rst_data->rcdev.nr_resets = nr_resets;
 	rst_data->rcdev.of_xlate = en7523_reset_xlate;
-	rst_data->rcdev.ops = &en7581_reset_ops;
+	rst_data->rcdev.ops = &en75xx_reset_ops;
 	rst_data->rcdev.of_node = dev->of_node;
 	rst_data->rcdev.of_reset_n_cells = 1;
 	rst_data->rcdev.owner = THIS_MODULE;
@@ -698,7 +751,8 @@ static int en7581_clk_hw_init(struct platform_device *pdev,
 	val = readl(base + REG_NP_SCU_PCIC);
 	writel(val | 3, base + REG_NP_SCU_PCIC);
 
-	return en7581_reset_register(&pdev->dev, base);
+	return en75xx_reset_register(&pdev->dev, base, en7581_rst_map,
+				     ARRAY_SIZE(en7581_rst_map));
 }
 
 static int en7523_clk_probe(struct platform_device *pdev)
-- 
2.51.0


