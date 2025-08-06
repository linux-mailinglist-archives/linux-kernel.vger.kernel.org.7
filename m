Return-Path: <linux-kernel+bounces-757921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2204B1C850
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 17:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0598F18C4E16
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 15:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7AEF29B782;
	Wed,  6 Aug 2025 15:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="QSxw6mDp"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013040.outbound.protection.outlook.com [52.101.72.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC7429AAF5
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 15:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754492768; cv=fail; b=TAcllrXpXjeSSI69drloFVq4oqdDkM/cKM3x6DCM3cd0kTkWiz77XuY1qlUOtM1SCw3V6IiczFWpbtw0hx2qmyBlkqjgI4d68rR4KU929fEaHtSpaH4f/K/K4LG75NbhqxcquN4FjclLIeMwxNJtEADivDJ13b2d403BHcaX5uc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754492768; c=relaxed/simple;
	bh=5DdVTEUuO1Eulg42J+20+e47xZDJg7jyKaVFQBi63YI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rWmK5e4pbs3QuhJqxlxIEAnY5fEkCiX7Irc2C1E8xUCEyBdKe5MrEKUv6c2lMuWgokNPFfrFbPUEjlmW54IvkwE3aghgZH6TDOV3B3SwOUefA4SkiVuZoBJeZDiG5WcKkcEtlQ2eyPXfKt2HtJfK0sTASEif04WmsDJTlP7ExWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=QSxw6mDp; arc=fail smtp.client-ip=52.101.72.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=exvxeg45oGWHZnIQbe4vl3HVkzO/cuPakTuPueHQYyarcLCgIy38bKaJkPxBXmw1omYz/WM4k/7Y44i1Tdjlp78HdmIYLzCbsW8r2MiZJyvTZhp7smSmzcwJ8icrGiH7X0VRp7JN4pg+eNFTlWM6euMn61db/QiV5ljjXI4LB510CLQYAr8kqY3im6EAddd7YNb7BTK08CCo0CI88+K3vYRamFavAvaEpdLPdbMbGyHOn0jetajGsQpwYD/pswYlswooaOiJTiXKjarzEDPj4OrramCaHnoT1KTxxkAwugFbpMztCj/h1PU4J7y/C90yOFoEQ2ePpcF2cO5BXO+wWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iptkPTeX4v5pgNcJ//8N+teUDMh9lbYULDaPEeoAjUg=;
 b=ptqDLbG1fWId0XMdoYYLtMDr/A9a7zmTmgKD/ix+28mVUbCpPJOxgPe/1fMC2TGOazeEBiF6LhS8gnJboGTMMpft6lXXSsx2gFrVZ58pAgGMZnZqGWncfSuZaT9w1fJGBWwKkgU0e7fLs5zbyLbvIb3LPncTiXOX+2NDnow1nfaqMLG0ZRDAr6hovftTft+p5BJq5q4tIDrF3JTVY9WA54yEhws5qxoJq+qzl5p7KXJ/qXf4Ya2vNZHM6EKhyAiTAFP4oWgtDFmhVcFG+F2KvNdBn5OBcAXt3K5KcW6Ui6bLMSSNFfQK0sLiVZkOll0zOd2oPXxuLy3V9CYo/WrTOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iptkPTeX4v5pgNcJ//8N+teUDMh9lbYULDaPEeoAjUg=;
 b=QSxw6mDpdLxtZbUUw4ucnaFOA0ws8gfyAwVeUYrTw/I39JQlQ1mjmAyjgY1kgU4/QjBKWhvbq7aA7wal0Tz0gcOIKnP95w/NtPBbM8fTGPC7ZFyjDeOa4C5EYFsY+6ilxnLfaYz2UMsE7Dq6j/ABKl7ZCOgVAObXz60s0kAfLv1fqwipNBRW/vnCZyPLat8CIuQzFfRXgOL/ycARVmIImXF8eA3+BhtLG1kb8vAWlQKVN9msw4UBw7U5FA6Hz8zEIFTfncbarB2mhwYqnsFBT9P5+Ieu+B52hLQftn4OhjVur7DQBM2Qr9UnBbYB9pJLnVPG/tTlhIKFwbpPLT6p7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com (2603:10a6:150:26::19)
 by AS1PR04MB9429.eurprd04.prod.outlook.com (2603:10a6:20b:4db::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Wed, 6 Aug
 2025 15:06:03 +0000
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::b1f6:475e:de5d:8442]) by GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::b1f6:475e:de5d:8442%5]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 15:06:03 +0000
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: imx@lists.linux.dev
Cc: Frank Li <frank.li@nxp.com>,
	Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 9/9] MAINTAINERS: Add entry for i.MX94 DCIF driver
Date: Wed,  6 Aug 2025 18:05:16 +0300
Message-Id: <20250806150521.2174797-10-laurentiu.palcu@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250806150521.2174797-1-laurentiu.palcu@oss.nxp.com>
References: <20250806150521.2174797-1-laurentiu.palcu@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0057.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::6) To GV1PR04MB9135.eurprd04.prod.outlook.com
 (2603:10a6:150:26::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9135:EE_|AS1PR04MB9429:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d58c091-8551-47de-3222-08ddd4fac2f5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NUbLbwX4afiEPgHSnOdIbJVSKGru1YVrh/ongnXo4JWpK698p/PDQV3XcD9d?=
 =?us-ascii?Q?nYtCserUhLlQ8l3wh8of4mZjMf/9Qd9nqGpEnyOO/0CjCUmRQPddzckPYLV0?=
 =?us-ascii?Q?StVjXYxf0384MO2CuMFLPpWImSbk1P9zU95mZ05WtN+AC1tGhnzCU3aCnlbd?=
 =?us-ascii?Q?26GMtZI0XRfkkLn0u0wT60qIgP4mQU/zwwwI/yWZziCu88XhawyMq+zDv5YX?=
 =?us-ascii?Q?xcIoh7cJ/kzxnb6RzRnrUUmlJk9WHfkT0gca3XJyCBF8LSjRs20LIGCQkrWB?=
 =?us-ascii?Q?jRC6nVXdgqwZxsOgNlX5nwtEavMrNUtZkbQu8rPl7LAWieZ2eYV2UnwazwL/?=
 =?us-ascii?Q?53UnOLsCILvscvFwuu/25s0M7ONZSz1GlII9LbCLR0qzjAYhzacT/NRNiDrN?=
 =?us-ascii?Q?7hnoVEKv6qss3lm948sbCyHjMjUHMkiXr5iZf0Bm9ccr6RFK9mrwPIWms1vW?=
 =?us-ascii?Q?C7E3BXF9BK5BKexESsrJS+2D21zUv8vwAUkb8ljkn35XMoe40VioAHtqk9Xc?=
 =?us-ascii?Q?pRwWv3MQ8OYuNizxx2HpGwQWdIPtJrOe9c3BHXYDWXQszYVgrPcLBfx/4/pa?=
 =?us-ascii?Q?gzqaMwhboYuRUDnt9G5mb/9RO44g0vUZzh6ieeroUI+BUTlAVLOYP3l9e3/A?=
 =?us-ascii?Q?VV6qDYfdpxFS5F/vxcHAXg4YHI8UbOXjeQpYiOyV4M5wX3HMfYM2JI2Kbyvi?=
 =?us-ascii?Q?024ux28I0cb8zm7UsofefEZJGjdXhNQvrOjH8K1NphqzO7iJkMkebTo0KaBo?=
 =?us-ascii?Q?13SHDtcGc2xv2mGy9rjUUxEWYoh+a4aLbHVtv6A5LOVobohXP0OLrxXb+Wqc?=
 =?us-ascii?Q?TObFdRZ4ysf3T5vqv5xiDlIYhxB8JmtzDAkwYpAGoezkDjsncq7wJ6rOLB4p?=
 =?us-ascii?Q?cgC/kdtePIMiBHyWt+OmZfhlm59FquYhCUvBPNAR7CA6I/k3EwxsqdJAxwXq?=
 =?us-ascii?Q?8iLbyLaLK/8jvlY2saxvo55+N4kaMGAu8/FkiU8e1xvVLvX9UlIhyWh6piqZ?=
 =?us-ascii?Q?nUvIonRnCBCcaYx2z7sAm4uUkCihfEPcZDk6MeofQd0rm0ILY5bMRPLDD1SO?=
 =?us-ascii?Q?6aEt94fY1y1obpQUOAXf50Kt2Vg0ZJC4EOlDHyhSVqkzaU3v94S5xyVgnGRO?=
 =?us-ascii?Q?K8HEU6gsBcm+vbSdWgyiFU9GYuShw1OKRLE4ObvHN3ixJmidBz0L6UZLKe2a?=
 =?us-ascii?Q?p+ORdgFcLIQtkn+iI06rJCjb7dyJpvIyiXKRKJ2qje/JocX68IFVGr2JGM5U?=
 =?us-ascii?Q?z1AsCrq0MHfex8CKALsMu+iouY6CqHvMe4mQbUwkyOzURgJQmG5rnKychobZ?=
 =?us-ascii?Q?135pnLEhVQ5lXbI7nBnMtw+ZBrQuWYqS31731qhrLNDc4PIvUR3jn0NKft6Q?=
 =?us-ascii?Q?BxZCQIQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9135.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9FVnxBtQJRlpMUuomS3tbqjp0EmDD4/bNJ3YX5F64xdzmS1JaeBeAFzLpdzC?=
 =?us-ascii?Q?lqtHXLk2ZZs9LJecLqoFTJ7fJXWfTvR7lGjKeT+wWL8b6t4yxX+wSj7hgkiA?=
 =?us-ascii?Q?7h6JUUc2WKavBbJ4tokDpOQxE+RXYeDO2Fxmis7TDXUi/4E9SDS/WDiCwDi/?=
 =?us-ascii?Q?3OSMDi+4nGubrLCLAT2UfgKYIY8diRZ6d3gPGWYDdDBLK56XBdr1PTiWvkKJ?=
 =?us-ascii?Q?xd8HkU/+q1qSDaS58aEmC8D6wZUyUGbwzwf27sFop9KTfNkSdmRABhz+nEwV?=
 =?us-ascii?Q?KYXACVRdi7v2JN/TWqcPVByYWv5R6M+/DjKIKdEEB/Uaasm2P7r44hjhD/QY?=
 =?us-ascii?Q?tMW+0NjWd/WU3uzJERVlYwpB24LVZcWU+NflSVAbRLeKmzuYSi/NpffPgTL6?=
 =?us-ascii?Q?oERFJPrP6ZCQ2MKAu70HM2oSQtVtdZy6NHS3K+FRlfLbCZQuSQh7r4r9NFEJ?=
 =?us-ascii?Q?x/KcFVwvuCWFhrBk35nB3Ypm2u/fBcXpryCAYLpEQVqMJRkXZbdiUMJjpkGQ?=
 =?us-ascii?Q?2mrhgoIsoVrt7fkuy1SGVfUDkbSSFbZXU1Itpq8yOjanT6kZzy/Fsj72EHic?=
 =?us-ascii?Q?R/8Vjtknxul0SIw7s7Bw0/OJvK2nbhfKwRbPGS4wwaJLXN+ErA1JoygIfSlk?=
 =?us-ascii?Q?J1ySMd2Br+TUbOsOHApR2Ory/1bm4WSO/a30+c5DIVwnV9Qh9oUY2uzyAU3b?=
 =?us-ascii?Q?jUyyjtPbOOltlsnU94TxyHoLiYxXNQuCuupONhuepTvK73bv+xh6rEnJf26x?=
 =?us-ascii?Q?oRJ+fIihv2Ruwh1fwK00khFLnnCEhGsgvG6Qz3BXq9UA2+nsJo/1Nz4kt3KC?=
 =?us-ascii?Q?3Rh+VvfzjuJWFPYIhg3fBWJXQu/4K0Tooo55TGbHpYDKqEQZ6DNdx/s5nxO9?=
 =?us-ascii?Q?Rj6zCkMHmEBMU6vZk8wyaCp8DJw/osqtf3JLs/ROK+0t9X04WujdmzJ0yksE?=
 =?us-ascii?Q?w+/ep3rpkptUjVLBMFsaVX9s/EGoKlJXyGhWjvzgnDcAkD4RQxyUlOudtjVN?=
 =?us-ascii?Q?LUgU7r9kb69NCH5cX57NzKiaajIqy6tmNKAjmo7rYuO6y4aawq9IATYpCu4f?=
 =?us-ascii?Q?m0aX4WH6raXOzYPPas1HKT/GKhxNeAqztwyZOexAMM98o/d4rgAaiP+cVPSc?=
 =?us-ascii?Q?wO+OElXfURZIlqkWv1/+GNHxL5+XJbKSlYYNaMdk2OS74MAVrTzle457m+Me?=
 =?us-ascii?Q?oSf2g46nYLGlAARbbpvpfT1960301cCgRgS266kdTxNjgG0i6/q4iUpav0xR?=
 =?us-ascii?Q?BVylnjtudz3h5tEoPh1PjkJ+jD6swQU8fPT5Z/Gz8EiwJJo5r/ZN5evFFGV0?=
 =?us-ascii?Q?76EwLVO8npqZmXTLO9sPCBCBSBYm4F0GM1lxed84yIsjyacrL7cA/avaPppV?=
 =?us-ascii?Q?WTp4g29M+KDTT7dRybx9FxGjTMJlJ/KVa3uSJ0pvV8JY1lKlTsO0Y8Yb9bOL?=
 =?us-ascii?Q?7nlmo5qTyVhay5ohU5oI66Se7g1zLK0YJ2pS7+JQIfUtzgoBkjQWyPS5ykRG?=
 =?us-ascii?Q?+3MJBaomKP+wp5M3HHWuNAqFwQb6WdcnAyC5xt2G2HSCLQZhmKdiUBSw2KuS?=
 =?us-ascii?Q?8jCc06FmO9ETeUNSTF7MBu12Qrl7Bj7O99KNZchC6iKlCodTlVbyJk6gmg2N?=
 =?us-ascii?Q?ow=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d58c091-8551-47de-3222-08ddd4fac2f5
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9135.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 15:06:03.6900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wEQlKoebGf8SBgg2uGbIuuDfG1zHIaQRucAuCsvuzKmpD6w74BsnEUaaCSOSchQEtEqaYJ2UPIGes71ior3wUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9429

The driver is part of DRM subsystem and is located in
drivers/gpu/drm/imx/dcif.

Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a31fcb521929e..f0de9edc2bbae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18250,6 +18250,15 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
 F:	drivers/media/platform/nxp/imx-jpeg
 
+NXP i.MX 94 DCIF DRIVER
+M:	Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
+L:	dri-devel@lists.freedesktop.org
+L:	imx@lists.linux.dev
+S:	Maintained
+T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
+F:	Documentation/devicetree/bindings/display/imx/nxp,imx94-dcif.yaml
+F:	drivers/gpu/drm/imx/dcif/
+
 NXP i.MX CLOCK DRIVERS
 M:	Abel Vesa <abelvesa@kernel.org>
 R:	Peng Fan <peng.fan@nxp.com>
-- 
2.49.0


