Return-Path: <linux-kernel+bounces-833538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9B8BA241F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 04:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5275A6245A7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 02:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D165266EE7;
	Fri, 26 Sep 2025 02:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VvVKJYyt"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010011.outbound.protection.outlook.com [52.101.84.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED44246BD2;
	Fri, 26 Sep 2025 02:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758855204; cv=fail; b=e5ppkhYijiQvwoawuj9dbFqCj/85Ed/ddYibg0Po4ab0S93kgYtYg4OE71YKijphOqdn5sWrE+daMUSO9pikd2q4NVxtQ++ys3zymCu74GwjQx7LPxkmO68WFHKrJAxH9Wjv5/uqh+2EMTxw97bKNVj49YLh0S6DkmcNPItKOrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758855204; c=relaxed/simple;
	bh=uNg2bK+F+2HIWY5gyLTsL12uiLmTsMG6QI/4/+roMFA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aawVGytXhFRF0lUrpLN+lvUzcECF2n2p3sq9fIB0Fq+8CPQHy8fNsn93Nj/Ca5jXANMiSCoso27HNBIsbLOgO8IiPUU74BeR4BlrLehFHgREc/Ikxh9nAMkji96X5HMhkvp/h/uMiKHjEYj+jiCokrW2CB+/No1DQElyiY/Z1RA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VvVKJYyt; arc=fail smtp.client-ip=52.101.84.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JNg/OdRAB3tsKd+oULTPJbuMBU70peNZ8lSt59L0JhE0zh/GL/AjqCpa6FjPqfQe8m9LM0yV/nk/YaEoYRGqHrlWwQZAr3zZ+QqY0Y+zcLX3KPprmd5HLQ3MHa1cIyI+WfXsVRJhN5OYzheoGrpURSu1cEnhM4U2ulZIDHMJuORPF3UtgNLn+GeG8x9NtXtCmVPONJxhPsToJdLi6p1DM6bQY9sFbsyDJH7obxZMbKiXEX/7+9uzzm1pssa82ALPWoDwqHSVXiXJJwC8xfah6j4X8kVycFbwqcwY/1WapLjX1ogpM3164R6rtDd4+fx6GKTvQtj+c62n9c+YpCfYcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8DKiN3n42TE67r4TPX8F7Wxdv8gfI+TeZ1QSV+X4n0U=;
 b=SHK4R4sNY9Y2Ns10dXTx2i/+6CXzxXyfySOh24LH2mIRnMHjmhQP9NI2uoiuqmJjomAXyRlctTsJlY90LQ0nUrXzYtc0JqKI39ChUHYM/ZoOeYLFrpJ8F3GGOkhr/Vb3ZXZ/BBXGeZKQCKEuLManOxyZ08k7wnuXCh3IHcrDzIxtaJvanpwCSXSMJpXn3yZlYELVvbIyWAkj4fN1OJE9l51M7rz3Lm1xhinPA0qCKrGyjFYWJr4SY6yeUC/eHqFZ1FeSc0KJZ23cVqvrCF+jKJ9RbQBz5LYWYb32asCGJWiJ+MiM7BpPb1xK3aKftJshvYtYvuvojtIQt54F+9NSgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8DKiN3n42TE67r4TPX8F7Wxdv8gfI+TeZ1QSV+X4n0U=;
 b=VvVKJYytneiuAlXULw7aNsXvMSbJmkbmxJMjVpUmfz7YCKgz5fcEfUJE4imPzimhDl9S9f9wX6LR66ociqkptmYJdPGHS0JH7fw9+fWyPHrJfa6OSBQ/Bd4pqwesdGDq30Jwf/5fhKIDVeArLz/oN8O7nClhkPdlrljm4UW74cKxMiKATyjGD9k8IZ91A8YB9xec7dq/VnAdoE1I8AKdZqWeRYWuZxiSYG/NKXsF0HvLjfdMXIeIiKkve79xTkLyYczM4MR6zX8/KwjT4n1HP3y+viS5OHP9l7gpzc2E/8sf1K+B+uwk+RUAH2f3atact0cy47vFx1rsFoG1YciHMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AS8PR04MB8403.eurprd04.prod.outlook.com (2603:10a6:20b:3f7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Fri, 26 Sep
 2025 02:53:19 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce%4]) with mapi id 15.20.9160.011; Fri, 26 Sep 2025
 02:53:19 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: krzk@kernel.org,
	myungjoo.ham@samsung.com,
	cw00.choi@samsung.com,
	robh@kernel.org,
	conor+dt@kernel.org
Cc: devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	jun.li@nxp.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/3] extcon: ptn5150: Support USB role switch via connector fwnode
Date: Fri, 26 Sep 2025 10:53:09 +0800
Message-Id: <20250926025309.24267-3-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250926025309.24267-1-xu.yang_2@nxp.com>
References: <20250926025309.24267-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:194::8) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|AS8PR04MB8403:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e0aa265-58fd-4b5d-46e9-08ddfca7d93f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aZnllrU/JR8P6YdIrTQi+0mXoFs56yuy9zl3S6voXL/gvQmFf76U2rN6mGZ+?=
 =?us-ascii?Q?KqhGSWNDP4DjZntWJuo0if010hbxM68BDDJA8q0r2nKJM8dfabzVMu6ski2e?=
 =?us-ascii?Q?fTUV3dJsBZvT0InznvSBJti8eRrOjPlHoxXfgr1Ufsfhwwe/+p6bpjrK3cFc?=
 =?us-ascii?Q?JJSQy8mAAP0uP2VeVHJMHvEkanG/FKPBCJ2mnfUwjqUkv3CdcXmZ2xjKxoyX?=
 =?us-ascii?Q?Y6yr6ePWfH8lv85gVkHRYK3WdC1UDlsNH6P0bBxtWcdB9yHWprUoWQKMy/Pq?=
 =?us-ascii?Q?2gct1gIfvb0iMvC090bJqSeQ2T6kkDaVdGfp93c9wF1wWbH6qIRUON5odX2x?=
 =?us-ascii?Q?ikhoFOpp7rONiaHhQwkUQZwtI8r+LZcQq50YOq5p9sKAyTLTddkf7Uwbi4XP?=
 =?us-ascii?Q?HYZ4gW7GMlZ4ij1sB1uaG/vGhI3biw++Pxzq6W+igsWr4dOuhDO2jFEzxUn9?=
 =?us-ascii?Q?yFKLfgNEFuP0EJ1O9kTtz8qT4s+VCHD6qzY4QPoXtW3YBphLTiFWPTivlhVU?=
 =?us-ascii?Q?AHcL+Dlhk7B+nM7N94dQCOXK35K/8XhfIYPCGd87QoxcC1qZP7QQpksAaVJZ?=
 =?us-ascii?Q?CSeEcs8BE2rDWuBf4Wu28aKmafUPOrwaKG3mG0hTI9wd9ToBNauy8u1O+Np7?=
 =?us-ascii?Q?GwXNnEUCTNecAaI94sVbDVtFOLW4YIjnepyAfMvvTiXA0a8ZhpHuA4yLr800?=
 =?us-ascii?Q?NpvdhartoHlw3i5y8ToOZakW/5TCpRz+NR6yxMztxr7dgWg/0K7B4e0sRj/v?=
 =?us-ascii?Q?1zEMKebZoRZ2mdqCkwXZBP6cKDxnxD9Q8IHMW7Zp3AqPA9Kjw9VoaJR9L409?=
 =?us-ascii?Q?c7D15Y9R/m56IptKJgh0x11/LBaXCo4Oq2Hyfke7WlJCygPIwCupAxdhEKLN?=
 =?us-ascii?Q?e1Qbaq5pXo5vsyZ4aWRQsoKyJNyPYsterVApoMDZj+gKyUUwRzkXRveEsole?=
 =?us-ascii?Q?fIkk52HoQlYGUKejqybboF/8TJ1yWQFzXBG1biYRH5JLDt2DJq924lFdixSk?=
 =?us-ascii?Q?F5U433b912DxaPLFaiA5HLadwzwOgt+IBnJWPtXWGQFIeOHpmOtLpM6fC36M?=
 =?us-ascii?Q?6mxivGCsBgPp7Go/vEkkDys3xFXs+YOGQ+SRhXgponvw83rfogRHzvDmQca3?=
 =?us-ascii?Q?0eyBLxFnna04g61u+7SIb1ScKdssT81Rt1z4a2Una5J+cFQcwiL1e/+IFp4O?=
 =?us-ascii?Q?UyKDwZFxdvUwPE4BmZ0i3p/WFpq7g7eprd1pbYXSYpp55e2D56R6oUqM0Eze?=
 =?us-ascii?Q?B11Qs5WAzaNJzqMVegyh+qUC3s+thkraGcoURyyShQRdBMJmXOb48iFcCKPQ?=
 =?us-ascii?Q?3JcHl1pEeht18j7JALxuvxNi4G8nyyqSRTAFXhBgrJe731muw+cbMHhyaGQN?=
 =?us-ascii?Q?ReWv0qwNJqOd4z0st41xOWSFIgwy4WGx0ahMIlwfo/QjkZg41VqJly35CQ7k?=
 =?us-ascii?Q?Ocr1Eptt9lOUCOjOwbG09m06Uv/MWfCa7H8jAsRbmngz+kaOtgSY48O7GNLn?=
 =?us-ascii?Q?js7c8oXFXDOEkmlhveZ9h4+CNNy8AcWLAdpL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?79qylBXG0K0eukaBDj4AcOoBYo4s/HgBRWVTIOtv6rmyHGqBtkBXLoOZloUk?=
 =?us-ascii?Q?KcaoeL8Dy83e/Xtf469n7GUUNQkJWLbEChlB48+lWLnMlY4UaPy9PhDQmoPv?=
 =?us-ascii?Q?Fluo+sH+aMobnUjlpi7hcTe4ubCCid/180ckx4lCSQpGHJvvMVxnQwfoEefv?=
 =?us-ascii?Q?vU+XavLJhoLFS3bWx/gq5/HAZesW/F3OP7pFXBJ0ZlvR7rbUdXvTP7da0odu?=
 =?us-ascii?Q?KERMu8OMR5JEoTEcEJLdsgg0q0kjnYzJq0bUhlf6pwPGiDNnp408pS/SJ8wC?=
 =?us-ascii?Q?ofjEUE0tsMxjVLcdLAO0XuAifOc0nSeVZCdPKUOsu+MMCYS1MkvfFpx/wfwI?=
 =?us-ascii?Q?9XkJKOMRQ4cia3CAzGbAKMvC4Y4kH2aQDrI4WFcAuwvDty8q8mb5QqR/7IO0?=
 =?us-ascii?Q?rlrepgeX+cu6RcWqUbwFa0nkMDP184zipcJKfihN8oP2W5gYXU58Szy0PhGS?=
 =?us-ascii?Q?/RwNJAlbVg7pWdPljH51qFOW5gkUjD2J+nwzKiXM4TZ2I3rEh841pltxO59S?=
 =?us-ascii?Q?L3KKG6rwiZzKGfq49RMWS8xMbslPVyllBudHoKJPjcsAHRfD/TTvznRL29II?=
 =?us-ascii?Q?1EZBnpeNED9NVDJb3h3Ecjs9bk/+vhLUSzanBwkWpQnpC9kI8JYDA87hh5P9?=
 =?us-ascii?Q?/dm7MbhuZqH/pvfe1cI/V6WjCs1eVdpIIGwpynyjG3Vho3+BcZUqDmpixPgR?=
 =?us-ascii?Q?I7+IslOPTMBK853ZjBjYoQ7aPvfJgja7q7XcuVxYyNQ+Jn3rCF+C/UeSF32m?=
 =?us-ascii?Q?3B3RqA4B5wp4zRe9Gd6Y803c/70InrYbMPkWqJkVd0zY7QRiaPvDupeG555f?=
 =?us-ascii?Q?zCAaqK6tZDNGOLz5xMGjDaPBt7INT3ghXC4WRGH/1QYptT2rtQvGK0jeBaxd?=
 =?us-ascii?Q?SUHVgxJ3M8YK8hD65L2wcbJsyP7eAM4gKgDrXifq7v9UeL+BovNu+HtB5aoK?=
 =?us-ascii?Q?T3w+9R/s9jVWYFW5nqwmhXxRs20BBcfAp4GZjYgKjBHpGosmd+ehnAzpUZXt?=
 =?us-ascii?Q?Y+zxDfowfmd8o3oFY04LnF1NwbZT8yHy30nijAAtUkjEBKvit1ES2rrnevaK?=
 =?us-ascii?Q?YlLX0MTp8okDdOwGgIpXLltbNtmNlg63U56yyc1Sjira4CrIrtmH6RdalGrv?=
 =?us-ascii?Q?LroUBFn/4j2axORYqSIkt4EDRJhbEt4gVbeGEPUnqtYPYbFYWf5/49fdTdSG?=
 =?us-ascii?Q?6ndfQPQCPLhvdQfOAsO7WFCVaKPhZoKH9F6y4NwG4YNoSYoLwMF5mPSrJscz?=
 =?us-ascii?Q?yz8Pv06tzXqL5tu2gvP3qVvIpaiSBNhvEwmap+4KuwpOMpw7I9GKgsRLjY/E?=
 =?us-ascii?Q?Gvks1MnrxzZR0pLi+38GR8W7+n+xakN/SpzbyV74Ym551TJO0QsyduEjqLc8?=
 =?us-ascii?Q?cKcZhrLx7ffGObRL4vM/qLnFU/bHt3M+bCfME/vyjqrFMmqhAPoiAFRghROi?=
 =?us-ascii?Q?oW5hPhNCX4DkmPe4KuOFW1NggvOjbvKd8C4o3mcHp9zE39I8ZRsafHoT5fAU?=
 =?us-ascii?Q?A5QifvKidZ9t0eAj6T8KRheWKlCdwiWSWyxOy2LyS3pvQWcwqJKqqUDxU7O3?=
 =?us-ascii?Q?AQCsxgZJbifyua/Wh1CC2CoOZid4VvaNwG6om7WW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e0aa265-58fd-4b5d-46e9-08ddfca7d93f
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 02:53:19.4074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jt+3NVo/+dqgKmBhEecvpl9tVeJgK5ZUo9YnD41CjYKUUrOX5EjDox7+peQ+E484WGXh5ZcXJqhlf1edWztByw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8403

Since the PTN5150 is a Type-C chip, it's common to describe related
properties under the connector node. To align with this, the port
node will be located under the connector node in the future.

To support this layout, retrieve the USB role switch using the
connector's fwnode. For compatibility with existing device trees,
keep the usb_role_switch_get() function.

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v5:
 - add Acked-by tag
Changes in v4:
 - add Rb tag
Changes in v3:
 - no changes
Changes in v2:
 - improve commit message
---
 drivers/extcon/extcon-ptn5150.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/extcon/extcon-ptn5150.c b/drivers/extcon/extcon-ptn5150.c
index 768428d306ce..f33f80e103c2 100644
--- a/drivers/extcon/extcon-ptn5150.c
+++ b/drivers/extcon/extcon-ptn5150.c
@@ -352,6 +352,8 @@ static int ptn5150_i2c_probe(struct i2c_client *i2c)
 	}
 
 	info->role_sw = usb_role_switch_get(info->dev);
+	if (!info->role_sw && connector)
+		info->role_sw = fwnode_usb_role_switch_get(connector);
 	if (IS_ERR(info->role_sw))
 		return dev_err_probe(info->dev, PTR_ERR(info->role_sw),
 				     "failed to get role switch\n");
-- 
2.34.1


