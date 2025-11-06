Return-Path: <linux-kernel+bounces-887615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE22C38B72
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 02:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12DD83B76C0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 01:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B03E238149;
	Thu,  6 Nov 2025 01:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="emeiMxGg"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013057.outbound.protection.outlook.com [52.101.83.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D248023183A;
	Thu,  6 Nov 2025 01:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762392935; cv=fail; b=IHXHiSxiYqowLpmU4udXF9PpUrrxNlUh/YqVkhRNYgQ2QsKLXoCarvcpGxv02jNt+wdFLg3LSJW5HplTcRYDEHkhy1cX/pIWGMLbUDznpAlsUhKm6BQMu83Dgy2CxDCqt/JKzjM4K/GmB1WgockQzXHvIpLv3+QKL8XlfxqxfjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762392935; c=relaxed/simple;
	bh=+pkCV7YGexZLVqVzLJqLul1dGC/6T0dCVeCuuNKhP/0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=gFw4UiEYxdQM6fusDbN6d6p4gDXhPGswNkIhH5JLpdYLkuaBFheh4seUnW9QMSdlT3rzyByBfRassZ4xEuTFp4Miy2v/yfTH1Ai6qHwSkcM9/PwjC7FhQ455FxqDLsRJV0x8vCEVYR3yvR9kFu/vH4srWeKnrI8zgqniyLyclHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=emeiMxGg; arc=fail smtp.client-ip=52.101.83.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wOtxF2qNuAeuiUfwEFBDVtzOvB9mN8x+mIAnBsuehaB4CTmATo2A48RT7Lp7br3Pri7dOZfwHD8urzH1Yv6XLylgJWj0zGtDlC1sK5rd4iHTtUfzPwdKl9yBT6acE7X8BqkBtnl5GtX4hwJPmvyXEl7fu6HSKTCAS8o3o0zIqo+QsuQL2h9JwBqHpCvBApCLOpzKNjipjFu3J9mlri7efYA7VOiR1Thqv+Qy0XZa87b2dQ/zVeOOjrYQCOBRFB5QCfxWLTkmgSaNKR1FjUgmtQ+z7x7Ph/nM8gvZ4xFlq1CJ30hnCG4MKtG9bPrH9XX5zPWcHoSagpla5/0tsWui0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vwDu+RrxtBllyQlp6iDC/DHypwN/98DxveNlu6YAmmk=;
 b=L2M2L7G8WeLAnYF3lw1jLuVqG00KJeGbdoltkYE9JDSt/JbwyUx7m3k7w2QLra+ZTw0myaUEcFrvubBPWD7PulwzXarg8od8Yxt8nAcXfczQBdpDIn1EM0+gvl8wKZqrA5uOnGcbeOr1tooNtVX1Tr3wWTxrW46dXL/Y+cNrbSygIwBFel0j53s/aDOWFZ8Ok2f19uLQ0BGrvN+wUCKT4NP5KNYDj+OYqXVzs0xTRFRWlHoA6xZZ3iTx/8a+B/l2KOIPJb2ijh6tWtwBv7f4HzbhVym6XSgMhPNgt98K1tWFVH6Udawzhc/KqidJQ0i1MXaZRtO3Rg9wjKkfif2SyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vwDu+RrxtBllyQlp6iDC/DHypwN/98DxveNlu6YAmmk=;
 b=emeiMxGg8YaTRKOtoMj9Bvu7M9Dxrhv7LUpFBgUrcX3cREP7eLeotjtFst21Tv0Sj7mmOsZecHFGKmcs8QOqJLYV/jFY6z5vm9ApbvN0WlwQSQYxcA9176aJFtqqo/A1Ojjz8iVnu2y9L6hgHSn40RYN8AU5R41LT75Fc4k0diOqDkbxJz6rTnMytrOObRX+UHlsAHSmjkI8bNuuePZqVL+f+B9OcVlF5bnNV1la5LDRvdDcatnqdr6/UKltCZ+rDVNMYCzqIjj5wmoPV3pH9whBHz2QsWfABQsrUZywY6ZXAUuR7eAYT0/nbj1rSLN/wzYvVcxFhia6wLLQo59HiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by DB9PR04MB11533.eurprd04.prod.outlook.com (2603:10a6:10:5e2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Thu, 6 Nov
 2025 01:34:17 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9298.006; Thu, 6 Nov 2025
 01:34:17 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Support Opensource <support.opensource@diasemi.com>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Michal Simek <michal.simek@amd.com>,
	Wensheng Wang <wenswang@yeah.net>,
	Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Naresh Solanki <naresh.solanki@9elements.com>,
	Grant Peltier <grantpeltier93@gmail.com>,
	Vasileios Amoiridis <vassilisamir@gmail.com>,
	Dixit Parmar <dixitparmar19@gmail.com>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] dt-bindings: mfd: Convert dlg,da9052-i2c.txt to yaml format
Date: Wed,  5 Nov 2025 20:33:56 -0500
Message-Id: <20251106013358.421809-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0222.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::17) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|DB9PR04MB11533:EE_
X-MS-Office365-Filtering-Correlation-Id: 61547566-9c97-4545-59c2-08de1cd499d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|7416014|52116014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U6Zm1qcDYsq/CO65tZ/1myN5xSCid/lkU1yp6h3VKpQ2ugpXfptInjswaeja?=
 =?us-ascii?Q?NN7xfa6KRNxNN3BBnX6XvcF3xOt/ABZFeeYIt8SADZm8YsDlz3WxWthq4wSZ?=
 =?us-ascii?Q?2I/wQJVuaoR/aWWeXm1y9pBdZOGhOWAtDTOQAADwFYcqRKuf24DMHjTcB37b?=
 =?us-ascii?Q?NXBqQCxIAKM+quVT8WGgvluBDF8PCqqjQ2L8yEwEYL0/w4GblOq1O4FjipeM?=
 =?us-ascii?Q?oR1RZgtoVBvBsICrOajgpUCJaTi5vc4+XnpoBkcQgJcEfenUXXQLMzCviCbq?=
 =?us-ascii?Q?3gBikOxhlXrW41BZ3XaBuPz+z8sHLaM5RudYekXwIX0BAM6c2HRHAWHFryEr?=
 =?us-ascii?Q?J3oniQuo+jORiD7G/goxJ9b9ZFiyf/FjlczWpxWQAgi8AlzXSpDI1VrsN6QK?=
 =?us-ascii?Q?j+mb2Zlv4FOhNdBQC1Nq3HYVxZwT3RA2sNrz8nWPkioORt4d/x+MOITCr0Xh?=
 =?us-ascii?Q?cruf1feloB+dQIzERgvJSQ3B1B4FLLWMELuMBzaD52gXwPyJWVlFA84ZFVb8?=
 =?us-ascii?Q?TCOtrR4uryXbibUXQQXHjAshfWIH8gVmsoMmP1YvGmuTSkc4e7zJCnR+Z1i4?=
 =?us-ascii?Q?B9QoWQ48iPHfs4a1FbocxKvIn3RNfucXUNTe5NTg5BDilbF4UzQGm7pykDRC?=
 =?us-ascii?Q?j+hf2QCRk4HqKZ0kqyepjbZHdTOu8GKVKzUjSYPX8IMNU3v1P2LFhZVL4lGm?=
 =?us-ascii?Q?S1hWPKs/x8Beg+bVH1qR6+oFEudmowi3Bc1KlNQtUHJxmlCseZ1G/dgqNz6i?=
 =?us-ascii?Q?XF39Yow4zYl7wxmueGbz/FEwrSqGOPPcySjqR9oD7vRFLAcYEyDP+9HlkgLi?=
 =?us-ascii?Q?EX4eorHbs/dqOcx1cD+6oDUr7Ju4EbhZZ5pf/B2C1cp3EDX2WKiiAFKa9zSB?=
 =?us-ascii?Q?H4h1duWvRJqqqS+cfozKFxXZbyJ8MOExBEwIVeAfKlobUYrCMVfyLJ87h9Ys?=
 =?us-ascii?Q?N56bxKiYTaugK0AyIkFDEEcteDUdj2OwbVx+yjOzogqgfIojdAw1nmmIz7f5?=
 =?us-ascii?Q?vEbZ7T1NXqSvVvrs0YrVQ9DKzw4YUfvLpR+qSdahw6UFhUf9uM9/vENsGoT1?=
 =?us-ascii?Q?481tRVYCs/EjEuwrT3w78rqaeD0yBtqGepSfTf1vacEno64bHXGnGQ1QO51V?=
 =?us-ascii?Q?hvNfz+ARezHfcqDHlvVRtWU0ga5LI3oLBWDUA7C/oZb3W7cpfv7IP2jupNGv?=
 =?us-ascii?Q?1SyoGXQlFghj0ICc2vZrtfgtQ/KzsGpzJL45N+rrGcaNnfyLpeHssATdLWxn?=
 =?us-ascii?Q?SHZiLnE0XJDArwV1eE+UxigP13w6sgTVt+pQAkqZWm2Br9JyGsXNKcvSOrAu?=
 =?us-ascii?Q?oBWsmNdB101KPLwtgeeZ2hsHBOCUup7Y9cPZLfbDjR2K7WyOW3nrScOQzkZu?=
 =?us-ascii?Q?qMYNUl3xgZmL23RygNNuj4wbmp8W/IZTZVWDLs4kFc2VLr/l91HUW3b2XvhU?=
 =?us-ascii?Q?BZFyT3JZpGzPzvwAzBmYU4Xjrm/RjdqdCkGSQxiFe3tZ80Zs0N6yosQdVbiP?=
 =?us-ascii?Q?k3T44Zf4o40+vss=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(7416014)(52116014)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DEFWlMpYWUiPGuLjcxmpXnSc/2zj4AMJnGSUyYroedbZVQ2LdoGA6OGFfbNE?=
 =?us-ascii?Q?fS6t0o7rk+vtIbKo5oyaBCnws/2/2tMaeI7WVce1zN8S2yvfE6FUR1uoWe6g?=
 =?us-ascii?Q?9bbv/lTeIpretdCm+zyIURXzyt6c/vRwo8RgjPnykTodNtus2QImbPuN0LwH?=
 =?us-ascii?Q?ETj5OFa0xI1RXD1fvTn/v9yQz1fFsfWiiqWZ0qjYVYfwOKdn/3k4KEAxs2EQ?=
 =?us-ascii?Q?FNtP+1HsiXe6LiGawpVEd4JAWRvwrEf/G/QeXwTkSlhrQGANwsFayB2TOr9p?=
 =?us-ascii?Q?gG6FkUygbdbPwiQBPIQqRjDICIVIBkSO4LgO5B0rEMbOcoS3s7q38ir4Jtl5?=
 =?us-ascii?Q?oRzSm6HPfz4UKQd8NDA+e6/h7Gcfr8VLtQZCFxMqjQTdN/toZmXcP9biqO0Z?=
 =?us-ascii?Q?jq9SuHJ9z5Pk2VgvY47hOs0z+j0bYvSkPrMVdqB518SFc5d7GDZhIRUG15+H?=
 =?us-ascii?Q?GYu+VUURWmN+DxEYytgBoT/IQDJM0eugbjJrvcR+S2YyJdt+uSuDUzb7iXx6?=
 =?us-ascii?Q?ysC7s7PIQlppHR3ipgXYIo/MAmix2q0oaTUMwMTm/9nH1Ab3MbuIfrhOqQFa?=
 =?us-ascii?Q?PF1adkThDlBkjkjsBFLh5QVfrEy+Q1uH1C25gyhTlYmWTl9UV8qKhXFSho+v?=
 =?us-ascii?Q?rXSN5V3+ncB+0gnhF2uNuFAR1sfUPBaV8WT4msIzF+FdnAtYaAOLlx9HVOYP?=
 =?us-ascii?Q?vjAmAkfMy96w/Y2kxG16xOidNjKoomRIVBmV7B19D0c1StIKuMHbqwn9fP3e?=
 =?us-ascii?Q?Kegm8NGjJ73sn4zB6oNXz/KjqOhvc4Wbw7oemLDYiKCAhxOBtm8LbftMlGw2?=
 =?us-ascii?Q?ahByInH3FZOoaTEfV+OY4HqvOemENH3maHYQVdUAdpHv3LtcIQgPbKywE6CH?=
 =?us-ascii?Q?W6O63reELidQuUURybf/kqGtgovj9fsULfWDpJ45qMdL6ge7dgqW8JXLePZr?=
 =?us-ascii?Q?pWEFvDqOhxFpQvsWOyW+ZLjd9ohQqCj7IZSSFnVOWnNdlK9+3kRqMI5MRHqC?=
 =?us-ascii?Q?JVAY2omHaLYD/FeHEM5VJdarxw/ScXxxjtztFw+30ZVIkOqOAg6h9bPNfUiR?=
 =?us-ascii?Q?1ZJARgf9ePj16acdhcOolmzARM2aZoLcUQIi6zigUETm/rg0c3/3NBTRIzNj?=
 =?us-ascii?Q?H7eOb0mcsr0JBMasWeRZjJ7GLEq7VIvkHO51cHZmFoYW6lkqD70FWwb/4+b+?=
 =?us-ascii?Q?w/4n1KiDQQmiruUFpYpVRLzNg7FxqiILDQrSMfSNFnvT8iRImxivmzl7DdQD?=
 =?us-ascii?Q?fx+qEyrcK5xCLSwAAVqNffJK19ubp2aDh/04DeNJfc9ZoTVEY1UrgO4goqMg?=
 =?us-ascii?Q?DheLBrl4wvmVwGiJSxdGe7/CCSeiQ6iHAqpsNPLg5jcEJrTdb/NM/OLfanki?=
 =?us-ascii?Q?JeyRblCNfFhJ9hKFJzDgDIE2CM+D+zecBpSg34g4lr/nBNpsEYtnri51z9NG?=
 =?us-ascii?Q?mlTkwmSL2aNAzDkvgBf9PCkzojZA/s/1DmHsJdLXiSlIcLyDu0c7AVrcmOzW?=
 =?us-ascii?Q?g2ejf9NAeomKNcUso9b886tkkMk+gwPh4WmAza+Z2Smhp1B5XZ0i29aIvWXd?=
 =?us-ascii?Q?JMH5Oypg+iU80z4mTbE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61547566-9c97-4545-59c2-08de1cd499d0
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 01:34:17.4556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QZBEYM/wJsCZ5L/X5+wzlInhThCfA37Jtdz7jSdBtGDqcFgjbN9XYiO1+TSRxhjg8wB59XApYJlxiuUgMVW8Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB11533

Convert dlg,da9052-i2c.txt to yaml format.
Additional changes:
- compatible string fallback to dlg,da9052 to align existing dts files.
- Add interrupts property.
- Add ref to /schemas/spi/spi-peripheral-props.yaml#

Remove dlg,da9053 from trivial-devices.yaml.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../devicetree/bindings/mfd/da9052-i2c.txt    | 67 -------------
 .../devicetree/bindings/mfd/dlg,da9052.yaml   | 93 +++++++++++++++++++
 .../devicetree/bindings/trivial-devices.yaml  |  2 -
 3 files changed, 93 insertions(+), 69 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mfd/da9052-i2c.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/dlg,da9052.yaml

diff --git a/Documentation/devicetree/bindings/mfd/da9052-i2c.txt b/Documentation/devicetree/bindings/mfd/da9052-i2c.txt
deleted file mode 100644
index 07c69c0c6624c..0000000000000
--- a/Documentation/devicetree/bindings/mfd/da9052-i2c.txt
+++ /dev/null
@@ -1,67 +0,0 @@
-* Dialog DA9052/53 Power Management Integrated Circuit (PMIC)
-
-Required properties:
-- compatible : Should be "dlg,da9052", "dlg,da9053-aa",
-			 "dlg,da9053-ab", or "dlg,da9053-bb"
-
-Optional properties:
-- dlg,tsi-as-adc : Boolean, if set the X+, X-, Y+, Y- touchscreen
-                    input lines are used as general purpose analogue
-					input.
-- tsiref-supply: Phandle to the regulator, which provides the reference
-                 voltage for the TSIREF pin. Must be provided when the
-			     touchscreen pins are used for ADC purposes.
-
-Sub-nodes:
-- regulators : Contain the regulator nodes. The DA9052/53 regulators are
-  bound using their names as listed below:
-
-    buck1     : regulator BUCK CORE
-    buck2     : regulator BUCK PRO
-    buck3     : regulator BUCK MEM
-    buck4     : regulator BUCK PERI
-    ldo1      : regulator LDO1
-    ldo2      : regulator LDO2
-    ldo3      : regulator LDO3
-    ldo4      : regulator LDO4
-    ldo5      : regulator LDO5
-    ldo6      : regulator LDO6
-    ldo7      : regulator LDO7
-    ldo8      : regulator LDO8
-    ldo9      : regulator LDO9
-    ldo10     : regulator LDO10
-
-  The bindings details of individual regulator device can be found in:
-  Documentation/devicetree/bindings/regulator/regulator.txt
-
-Examples:
-
-i2c@63fc8000 { /* I2C1 */
-
-	pmic: dialog@48 {
-		compatible = "dlg,da9053-aa";
-		reg = <0x48>;
-
-		regulators {
-			buck1 {
-				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <2075000>;
-			};
-
-			buck2 {
-				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <2075000>;
-			};
-
-			buck3 {
-				regulator-min-microvolt = <925000>;
-				regulator-max-microvolt = <2500000>;
-			};
-
-			buck4 {
-				regulator-min-microvolt = <925000>;
-				regulator-max-microvolt = <2500000>;
-			};
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/mfd/dlg,da9052.yaml b/Documentation/devicetree/bindings/mfd/dlg,da9052.yaml
new file mode 100644
index 0000000000000..4ecd498864e4e
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/dlg,da9052.yaml
@@ -0,0 +1,93 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/dlg,da9052.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Dialog DA9052/53 Power Management Integrated Circuit (PMIC)
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - dlg,da9053
+              - dlg,da9053-aa
+              - dlg,da9053-ab
+              - dlg,da9053-bb
+          - const: dlg,da9052
+      - enum:
+          - dlg,da9052
+          - dlg,da9053-aa # Just for match existed old platform
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  dlg,tsi-as-adc:
+    type: boolean
+    description:
+      if set the X+, X-, Y+, Y- touchscreen input lines are used as general
+      purpose analogue input.
+
+  tsiref-supply:
+    description: The reference voltage for the TSIREF pin.
+
+  regulators:
+    type: object
+    additionalProperties: false
+
+    patternProperties:
+      "^(ldo([1-9]|10)|buck[1-4])$":
+        type: object
+        $ref: /schemas/regulator/regulator.yaml#
+        unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - regulators
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pmic@48 {
+            compatible = "dlg,da9053-aa";
+            reg = <0x48>;
+
+            regulators {
+                buck1 {
+                    regulator-min-microvolt = <500000>;
+                    regulator-max-microvolt = <2075000>;
+                };
+
+                buck2 {
+                    regulator-min-microvolt = <500000>;
+                    regulator-max-microvolt = <2075000>;
+                };
+
+                buck3 {
+                    regulator-min-microvolt = <925000>;
+                    regulator-max-microvolt = <2500000>;
+                };
+
+                buck4 {
+                    regulator-min-microvolt = <925000>;
+                    regulator-max-microvolt = <2500000>;
+                };
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 2eff6f274302a..17b72a8028e08 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -103,8 +103,6 @@ properties:
           - dfrobot,sen0322
             # DH electronics GmbH on-board CPLD trivial SPI device
           - dh,dhcom-board
-            # DA9053: flexible system level PMIC with multicore support
-          - dlg,da9053
             # DMARD05: 3-axis I2C Accelerometer
           - domintech,dmard05
             # DMARD06: 3-axis I2C Accelerometer
-- 
2.34.1


