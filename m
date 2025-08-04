Return-Path: <linux-kernel+bounces-755007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3A1B19FF4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 12:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DFFE179113
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 10:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F4423B62A;
	Mon,  4 Aug 2025 10:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LgB7aDkh"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013017.outbound.protection.outlook.com [40.107.159.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF9124EA80;
	Mon,  4 Aug 2025 10:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754304489; cv=fail; b=PqvBJozukNNA/1lgfy6WfgHrKpTSiO7Rb9wGQADhOwn3x5VMgGFDQYez4f5uEzcIOXxXgQuj1XprNpXenher1z7g76A1bDsMXD5dRkbZsAjGkGpcnPASdiU1kw8VTGRKRHOVenlILIZhvC9urKgWVvakG1RHjyOsBVaXNFFfM0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754304489; c=relaxed/simple;
	bh=SKQm2UcH+pv89CtRoA/ZEMP5gz4q3tKDUHJxgIUmecw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TdZBRZ44zDxt14cfROKWy0vtaxC4tMwiCTPTWKa211S0EjSmfBjKrGwyAHRA5kUx1HfMQwBlL/EbrTV2ksPVaYuG3YlXn982Qw/kLWcfrYzdb7Q8EfJ+jOd0BSkPXT/GqCvifkGiVLmSCFw4yqpVx12gtmBPitUPlc2e+xifgKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LgB7aDkh; arc=fail smtp.client-ip=40.107.159.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IW3jTdcM3/0SaznOznUrf55NziOwFwRVQ76v/dNJ0YJQ0pZFepfMiBJIIwv+ny4VIf1HPVCSRCOjGNMN4P/ze84KlEd8Aij/j6H4et2/JBDCRQtr2f66ha9NJNroPmh9Smr+KzqBUvCU6iUpiLKtQXa+JcZJP17XlrkyzZsiWNC6f46MELPNSyVrZh3dqV+I+rDT9C5MOxIHERXPf1Ef/Tf4YGjbD+mGIvQ8VVy1b8ZanKPzGvbjIzp88RCTUZcIroMa107J9G/TckmcOvploe9VtHEjnJFXpoRQZJ3NnbTOchkYT9EQAZL2JU4L3AjCCTdbAZyfaEmqSHB+Z9P7Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QJJk8waZAGUmtpJCix864mNIrqWzOzu0644eEgIapGU=;
 b=Ej22krcsOUCl5IEyqIxDaGUjZ20d6W3OHEwfN79ezu2xK8kgEyATKmeU/K9OC3aTUAs3/EYB+oUhXbBHKIOKVirwyrwarwJZgCab7uialfncC+8QP2H2o/EX2Bvrla6tstboJg+hzKsxHsnmWjtywzziMjlCK1n9TA8JEHljDC3nZr9R+mEw8zEXte1NCWuZdHqNQocjWc6dlqPYQPDoclU67s/RP3dt3BgqMJZK6w1e2/QRPd3HxDWhU3N3Fik2ZlqkkwETX5pXOlRIP37ujj5lnS7yF5HvSvPCkoJ2p6pSRHQyKMrphvV9uSbMkgbTM0yyGdVoe2ovIAo+i/gMzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJJk8waZAGUmtpJCix864mNIrqWzOzu0644eEgIapGU=;
 b=LgB7aDkhc96bkZqO+24gooxnROnlAztsrM3MlWcL0TWs+9WeXo3fxalWnbcWt8dPe6APvCK6KJtXP2dqN3BRWFVi4YfZT+Ok2gN5T29eeGeVat1oLsrx2Gtrxj8+/R3PEbW3b2Xu5Svm2K8CDBXMbU+x0wh3eetn3kMyjw6gdNdiKw5B4FmmwW+v37uCdGmZVj222iJ4FfBeIXoNU0dVI0w3auBp8eKhbJvqqLTQr/GNhbIrzxvnz3bsxkEghuQlVJi+/qPwCB2r/bHbjzvposbDd0DyXqCFe1qnqqwCCyyFZJdEAAIL0aHLEzGuLQco2TPpEvEodiKZ7NnU1/U4mw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by PAXPR04MB9643.eurprd04.prod.outlook.com (2603:10a6:102:241::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 10:48:04 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891%5]) with mapi id 15.20.8989.020; Mon, 4 Aug 2025
 10:48:04 +0000
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: andrzej.hajda@intel.com,
	neil.armstrong@linaro.org,
	rfoss@kernel.org,
	Laurent.pinchart@ideasonboard.com,
	jonas@kwiboo.se,
	jernej.skrabec@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	lumag@kernel.org,
	dianders@chromium.org,
	cristian.ciocaltea@collabora.com,
	luca.ceresoli@bootlin.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	victor.liu@nxp.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de,
	devicetree@vger.kernel.org,
	l.stach@pengutronix.de,
	shengjiu.wang@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH v3 2/6] ALSA: Add definitions for the bits in IEC958 subframe
Date: Mon,  4 Aug 2025 18:47:18 +0800
Message-Id: <20250804104722.601440-3-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250804104722.601440-1-shengjiu.wang@nxp.com>
References: <20250804104722.601440-1-shengjiu.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:196::6) To AM0PR04MB7044.eurprd04.prod.outlook.com
 (2603:10a6:208:191::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:EE_|PAXPR04MB9643:EE_
X-MS-Office365-Filtering-Correlation-Id: 79ab1d4d-93e9-4ee4-6721-08ddd34463fa
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?h+8ZvtLvHz2gmuOFuEePfefqC4lzyaXTFY5YTpqJuDws+rWJOLpH+XEtXr/v?=
 =?us-ascii?Q?bTQysVOI8wBj4WaYf21HbWybe3S0jusVWVUudX+gylYE56qA/oPwLeqyAv/G?=
 =?us-ascii?Q?JnHbkT1TIYP9HD/sMI9OQguXuIu4ohe11kBAMHtBq7IUGDPainQH5DO6emdz?=
 =?us-ascii?Q?EPHmCT50XqeSvdQreOZnBJhXXlvAlYfmTDAQD9hFtcfxqAFL1WB9oN+i84QV?=
 =?us-ascii?Q?d0AzrbIWlpsyGYRX/MD+ud9zhoXrxajMdzvHq0R6aHl5UUkOXJC8mhyyOECY?=
 =?us-ascii?Q?4yn765UhShIZ09fqiOg54z/1ivPxwuPQk8gN2QOaWj5+7egbXkvRdfTWE3uV?=
 =?us-ascii?Q?W4xlsrDVPi3kieGYXeDibBVF7p9TFzXeuVAejMTp/HWEv3iyasinolE3bot4?=
 =?us-ascii?Q?L9G1ksC8Fs9XzfvH0kogO/6mbtFuKUiiPnal9gYtdM0gS7/Zqg2m21v+D5Ve?=
 =?us-ascii?Q?BrNm7oBr9t9RQa99LMJgMFtNF6W+Hm1rzDmFOja37kWfrdL8FyanflFEvzkW?=
 =?us-ascii?Q?7genipZjB3OPaaiQHkx/JIuQfGVOA1jLXUHAxQuWwWf6lAIZoG70dtYg+wvM?=
 =?us-ascii?Q?sAxh+RoWLkYep5uDVrpCFgiHq/CPSpv2Lg10Fg3sd1W67eA24MF8ObTLPQjS?=
 =?us-ascii?Q?SX2I0Rnf5EBJczZhB7F9PGxYWA72zhAe/UtMzoT5BXBKvzrXZeCTosIYFCY5?=
 =?us-ascii?Q?fH6czhU/TJzOa0gtrTgIDe3zMr4MQKa34mZi/cA6ZGq2FMjgvc2jM45iE4Mh?=
 =?us-ascii?Q?fq7wefslhGYx43ihbP6PNjsciEAp9hU13XAiRi6dEPctQtqSrcEhcuvN3nUs?=
 =?us-ascii?Q?ohq2s5waWgdGOvsiG2DVdV6JtDoaQ8aGwHsRDQyBDBcCH+XgdoRpZu76H0MA?=
 =?us-ascii?Q?X9v8tNGEZeYbfTTgFMgQOGpR/Z9GDc2f1w8bYgBOXUuhN5QaZARbytXQxVST?=
 =?us-ascii?Q?bIpQtRV+m+ktmu1kET3YrO/fgLF7vVYZvZN/r5xcbUDh82azogHgb0xGaSCV?=
 =?us-ascii?Q?UzuZhZr6YdtCwZAELOo2ui3iY0Nkf7yVEEu4vYr0Q55qXaE8Zp4cZar1yi+a?=
 =?us-ascii?Q?A7uMtBYRhqgTL0p6Ic6TT29TwloSk9BLUwZYMYWS0HdlW9X4AjFwOZh1VZPV?=
 =?us-ascii?Q?fjTzLOlCImhrJqqekIYQxbAv7qgzUQZSEE0vioqvtP03qQNQPkqSCywSpY3c?=
 =?us-ascii?Q?rCyHsRe+cKu+ynejgxjPy0iuJse3yBD75qDlIqNgE+7vN5cdnTAoikq3kWp5?=
 =?us-ascii?Q?qCvFe5AAOhxVRs0hObp+dywh3E36iQEsZ+UocMc6JmdAPR6/FERHpKAHn2yq?=
 =?us-ascii?Q?eaiuPkfAyBJ2+wDS33/P4TfHURmPcOOXjfW+B9r4nWY/XsIRvUCaAVjSm94/?=
 =?us-ascii?Q?lsQYCJg3SCF7rxa2N3JB/m6aC9L9G4JuKT9ia3vYrdjauq+BPglZFtzuA2FV?=
 =?us-ascii?Q?8iehetUYrtCB7WdfEQ6EWqAbWWpInmtzvN/c9aAQfXiz/zlRp9c/Sm+ncOck?=
 =?us-ascii?Q?Sc46D3b4opcaq2Y=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?Hg6L5BCQA3FbKaqmdc8KPj6inGMMuLuD6XOmpbiso469LlR8BY5A7dlULZoU?=
 =?us-ascii?Q?pNsYnjvmNR9C+IOENXPvQhLT7pqtoo9p1wYvU96D2MMzA76/q87rfH88RPEx?=
 =?us-ascii?Q?HzCVQi5ZBjxB0+yB4KPbD/rPiLwFZa1JBS7zu2iL2imrwPAoWvpPD//1sdUW?=
 =?us-ascii?Q?ukP8Hvn27s+MtxzC5gkKwJCjSTGrlOD7tguIz+CHX9FadHCTS3uf3FI50XM/?=
 =?us-ascii?Q?P2o5fTb/9TrYzHk7AucEKzhdM3okEUstcxnDn1IYvzSYS4TkXe5wH71vlP8A?=
 =?us-ascii?Q?CeIqLdT+MGyY4LvVeVK7g5vJQ79sseaJu7w9xyT1Ixwq/vxqabbIRdzdm5Dq?=
 =?us-ascii?Q?xmPd/4fzqUFDXW4le+PvaYxhYA73aU9zzqDtm5ByfyL1uV75kaEZb5oqGoY4?=
 =?us-ascii?Q?2XSK3qObXurlNwRudhoDSunAhSg6SQhjXIPNN2V378EheX9pHwc6HAkpc33V?=
 =?us-ascii?Q?0f2SVoiysQIlawGVr+kjs40Du3OWjk3jUXScd9yFtvndEfPYg7VsyBgvuavU?=
 =?us-ascii?Q?07TZ8fkdto5b5LU3SD35jSkC2YvWzxfQ3K3YTNvl4A4C4CLMPZe0hy1DLfu2?=
 =?us-ascii?Q?+iFF1H4vFnC8DVh4lA0im7XeNEZP6jn0O6lVPZiDQfFCOmVBJrBT2+NtCiQP?=
 =?us-ascii?Q?jjpDCwDh8OsbwUsdu616rXvM0UENyz6e/1DUC/TGBdHZqikm4Qmvdk51fJ6V?=
 =?us-ascii?Q?jW0J5uaLf0zAZSg+lbmJWoq8+Jtcnfs7ep4B+7x3LmUmsiBUYReYxr1A8cwB?=
 =?us-ascii?Q?kq7dC4KS2kAs6fEULxrHjflPOt9KG61Me/n7iO3Mt03pl3h3eB+Td6FNjme1?=
 =?us-ascii?Q?k5OC2xcDxi8jyCIraaIf7HwFR1x+0reW1WuN/lH74yDFoerZtpEU8R2VMYMV?=
 =?us-ascii?Q?iutFbTtJkKy0L+lJtMsFIEEaN/dcKKMzjLVinwQMB+Qgc/aMrVcgyzWX3qZX?=
 =?us-ascii?Q?7gJ5CPxSVxi7p5YiwxoM1RA8ofQImDNlqvDT/r4B2HmmugMix3gNxKAosc/x?=
 =?us-ascii?Q?QYgQvr4RPYW8YhnmDOmQWE6jK4tYkktZvw6/U3uVTyIy310dLt/wuNye+xLa?=
 =?us-ascii?Q?wDJ6ep+DhYfQcbU8sfJv2q16o+gYVf43TVz8mk3zjcL8sHsgwFUTTfY+E3KY?=
 =?us-ascii?Q?isXYGUjqWhnyxilGCaQwYPAfeeRAQaa+OzyY/txXk53ZqlYNoLmzfCsXGfwf?=
 =?us-ascii?Q?8w6dKIFb2iItIb5T8sGe3IsYNS7PI5d3qHIk0aOz3+rHuzJwmH7fuQQ05vZC?=
 =?us-ascii?Q?YfREJgP0y9Y9gSylvHrjygcq7H/T+tvTtN35brUmNy1LVIN+lo3pUWIxVqVn?=
 =?us-ascii?Q?QltRQHZpR2PHYbI68e8fomwMVRYjds217oa/GIkI67ewpnaABeXGH719NAHF?=
 =?us-ascii?Q?dIYLnln3YJps1LGVORh3Qu2jtFT6VnyMdwmJIS5QZ7YASxSF7iR/vM+5FjjF?=
 =?us-ascii?Q?jTOF9MvT2FHHtFxb5q9P0QiJsWbtqJjJgZ7i5H6YGj22++G3nyoy3V9ywXO7?=
 =?us-ascii?Q?b31E6Bqvlc+5yNpwWTD0LPrz5CN1ceTSr1NaRUWNIwl2BB5cyFKffmVqrfRt?=
 =?us-ascii?Q?JMuirsS3zWvle3ByrPQlv3jUfWeNk0YX8JK7/8hg?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79ab1d4d-93e9-4ee4-6721-08ddd34463fa
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 10:48:04.6810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EZduZ954xSQeYMTUu9eMGIEi81EkyS/8thFWuF2w8UQ47Zyqcmbshx/36wENbkOHmG8RVDG0I/0COHtlFiwpIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9643

The IEC958 subframe format SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_LE are used
in HDMI and DisplayPort to describe the audio stream, but hardware device
may need to reorder the IEC958 bits for internal transmission, so need
these standard bits definitions for IEC958 subframe format.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/asoundef.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/sound/asoundef.h b/include/sound/asoundef.h
index 09b2c3dffb30..c4a929d4fd51 100644
--- a/include/sound/asoundef.h
+++ b/include/sound/asoundef.h
@@ -12,6 +12,15 @@
  *        Digital audio interface					    *
  *                                                                          *
  ****************************************************************************/
+/* IEC958 subframe format */
+#define IEC958_SUBFRAME_PREAMBLE_MASK	(0xfU)
+#define IEC958_SUBFRAME_AUXILIARY_MASK	(0xfU << 4)
+#define IEC958_SUBFRAME_SAMPLE_24_MASK	(0xffffffU << 4)
+#define IEC958_SUBFRAME_SAMPLE_20_MASK	(0xfffffU << 8)
+#define IEC958_SUBFRAME_VALIDITY	(0x1U << 28)
+#define IEC958_SUBFRAME_USER_DATA	(0x1U << 29)
+#define IEC958_SUBFRAME_CHANNEL_STATUS	(0x1U << 30)
+#define IEC958_SUBFRAME_PARITY		(0x1U << 31)
 
 /* AES/IEC958 channel status bits */
 #define IEC958_AES0_PROFESSIONAL	(1<<0)	/* 0 = consumer, 1 = professional */
-- 
2.34.1


