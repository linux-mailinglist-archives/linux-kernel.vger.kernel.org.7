Return-Path: <linux-kernel+bounces-798520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF4DB41F28
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E9E93B069E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05B52FF14D;
	Wed,  3 Sep 2025 12:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="p3bs7scC"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011060.outbound.protection.outlook.com [52.101.65.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028B530101A
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 12:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756902866; cv=fail; b=XzQX8RR+4xxNYBwx4CqhwF/tPjqRYYnSpGK7zNLSQ/RXMyftIuA4Gx9yJLxKDUKk3Bq22O3tghV9SvxWlpFA+Ji+WVUsdXdXy4a6WfiNE7IeVQAXiMijzbo43P1IZL3Nz4Vtt5d3gZtS7bjfmWDm3Opm5I/CdBqtEvAL4tQLd5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756902866; c=relaxed/simple;
	bh=HAXIQszgEbgcuVo6Is5uSb8flg19YMshRhxydjAzSZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dwVFhfn4OhOTQsrmLCPj7UIQIyn5G2PUC4tYLMw0adQYzrUAZc9ay7sK5CghON/D2MepewOMU5lsiWiWrQqbp57eyqgHbyaBbfUb55bljSWIOwY3YZOdL+IQm26lss3O/k2/V8chKxBMLEheo5hnrjuhuyHJyVuV2A4slAIt0kA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=p3bs7scC; arc=fail smtp.client-ip=52.101.65.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JwT5S/ceONRnuh5U/V4JuMJiSyniWTsI+jkaBZTTEOodoXAOitq5wV2H3td71TMJqK3qHiqW81C2K/qLM9Czf0T5u0b4xJsMgnNXBnFNEwYF+pLVbgMIpcNS4NKR5NhYuES+M8shaWR1s3kidMByF/lT1t/gZ/7cYxRR/zdIGvDjx5mIuwraoG4mz1jLp+nvxX5zyS9+QweKR7jt+XdJe2R5OqOaBCnNlCNjwnZDy4jN3A+XUG11jgaBpMO08Y5ZEebL4A3R2AsUyI6F0O3m8Vslq4cG0b8X+MmsBrwqm9WXKo2FpFs8udgGVL9RxCnEJw9fDPGgRi8/9FMBpMWYpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Frp2GD8hwiHOtp/3E4Vt5ehBnzpCzRS6f/alAqw+U1U=;
 b=ELxDuQjxJUbF9ksV8ARYwP7ZYkXCUjRaRdEWe+GRZb6ng0b6h5ah5PjauEvs1a5wTHrDhtAn1jeHEo86nyuNviE6PeLiMNFuCzmEdktDkvmNc7kWB1Q4l1Oe2IBeZr/ISq9zKfNSFeY2rAAuGnFSg5iSSXv3J6joA6pbbZHtAxiYceNewm437lpHgpvBiVp16sBR04wlR6Bhp0UQkpl8TTFOOFufEbJcm2VunwTkoSJ3juDz16rXNwUTuGvnbiTYqFjG/CNbkolTs49iX12NjhHyvTZa5vSsxU0ibC5suhcz983Y/+JWEAa+BJo6NU85nD+k9UzFNsYZ4iA6jnya+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Frp2GD8hwiHOtp/3E4Vt5ehBnzpCzRS6f/alAqw+U1U=;
 b=p3bs7scCo46LRfJrNPSb7Yz3mvzCq84wStSVOG6DozzkYZ7xt1RGsTziSTB6UApY8HVpDVN4bZE0mAu9UDFiRo7NXoxOyHIA3njjEMGPeOneLx9ctU+BYb1XuUamVzzW6AvK+Qk5sTCpB/FUkxo5gcW2QWgMJ1IqRR+DgW4dxudwXmiTfLBRyIigu8aMK7fw5LcjeQ/q2Y8SNjCZR29TkA68+FmMgxO5IX8/35NFIAoTu9x0oqRFN6pNe27Neljxc/0WrBmrsqL9k3a9pItTiC6a4gnfw6G2k3WXlEjCJ3qpzsvCd1wphEUcDptAPdwaYCdvTyPlcFoAZnEI59lbjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com (2603:10a6:150:26::19)
 by DB9PR04MB8233.eurprd04.prod.outlook.com (2603:10a6:10:24b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 12:34:22 +0000
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::b1f6:475e:de5d:8442]) by GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::b1f6:475e:de5d:8442%5]) with mapi id 15.20.9094.015; Wed, 3 Sep 2025
 12:34:22 +0000
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: imx@lists.linux.dev
Cc: Frank Li <frank.li@nxp.com>,
	Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 9/9] MAINTAINERS: Add entry for i.MX94 DCIF driver
Date: Wed,  3 Sep 2025 15:33:27 +0300
Message-Id: <20250903123332.2569241-10-laurentiu.palcu@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250903123332.2569241-1-laurentiu.palcu@oss.nxp.com>
References: <20250903123332.2569241-1-laurentiu.palcu@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0153.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::20) To GV1PR04MB9135.eurprd04.prod.outlook.com
 (2603:10a6:150:26::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9135:EE_|DB9PR04MB8233:EE_
X-MS-Office365-Filtering-Correlation-Id: f2b50b3f-452c-4968-64dc-08ddeae63571
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VmQq7bPqcYLN11Wqn9pa1ItM+TkJRiVxqr6WLUCuOLU7/+mc6UYHx9kjp0xM?=
 =?us-ascii?Q?NDDjHj/LnTXon4OhJKAua6qQroiRRiQG/SVyNhJdyEHZcjDSkD32mjm3SXxu?=
 =?us-ascii?Q?vD8Wjjci0DXrjlCRZhC3vsKJFcdDToZEoXxucL31+QRH5iqhimjTP2ZleNaV?=
 =?us-ascii?Q?5vcuPHkgvZvuCF5ExoF+y7bOH7/DDOGjBwrh6rc1tVWg8RklsM3ujY5P/5sN?=
 =?us-ascii?Q?wQjFKSXqHz00v3jUrtQW/aRqrBtLGSqdwMKgakctOyoVy1xjiu7p90+L5RGZ?=
 =?us-ascii?Q?r0OEg8aDDJDhr6CsVHxK2K3OZbsfN83NInL2bFkjaTYAWEsRF4wKSRpk/ScS?=
 =?us-ascii?Q?AVMoVf43XnaAv2xtvUIxo9xCwSdqn+YMY92PEu2jSJTZYDA1YzIrDAhBJ7Wp?=
 =?us-ascii?Q?Rcq4L0GT0iiUzpr9Ib7CVYTgDDQMJHBazXsvyPGPzNHMD8sWzQ0yhNuskmYR?=
 =?us-ascii?Q?4/Wggpp8G+GB6qqnsB9cuK/wGtxbfbhnXyIrnOG0j1XZHJytUgtBJw4VaRSZ?=
 =?us-ascii?Q?mCKc7WJnio6Y/QZ4omczbdimVSxmvBw8nEVACOKIm6A+si3Y0yE1P8cHAmg4?=
 =?us-ascii?Q?ulwvBMcio5nJxNK7JfViLJAT7h0mlpv588WogytcaxehK373QQwjM2LuQXfm?=
 =?us-ascii?Q?pgAdWvaXT1pKKJMoCWq9tIxCkTfxHiCgkfZswhYAt6p1/0VdimBgLnA0lm/y?=
 =?us-ascii?Q?rLa7kn8nXhYePeq8lRr6uIHY0a5iQTxuJewzGrEAc4G6QmGAtkV2NZb7lhkW?=
 =?us-ascii?Q?1UFj7p5x1sBRwXWX+ck2fS6mwth7eWw/C+h+PbSRu+Rf31oJ1ws1QGlrKxuS?=
 =?us-ascii?Q?2R6At8g0pHH7m6HX4SJCa6/a8MC3hAuHea409/gpGnFtXakFpx9c/VCBWK2D?=
 =?us-ascii?Q?3OKnl4k6r4hbDKCjxJ01mGLINnQiTzSBuDip6niZUfTDsmfCS9GrhyoWs0UH?=
 =?us-ascii?Q?jz3h3NLdWjSJarLUCSGK7XGwalbYFfJDX+kCG2dYTEfglOz+fr3S8iESirTC?=
 =?us-ascii?Q?fAJQ4WRYwcrwVHZhO/9DvxjCw18hzajJvN0ZjHnBOYETE1PESFby2EGXH5F+?=
 =?us-ascii?Q?v1SQjdGK/aqkyM/WAXF8mqga2BvnDXCSvBFtBSAP5pH6vGfbLSlEY0/3J753?=
 =?us-ascii?Q?Hrw6lmz0xugsHixwGn2Re0Ii4rAopHKJgnw6edx0jkspnivq95lfuHg2rqio?=
 =?us-ascii?Q?O350cLtKOlnkSLHSIUZAOuxrgbC2dOgsmM4tTFUT6wi0p5C7eVBXa3RIcnpf?=
 =?us-ascii?Q?o0qbXgkWzj2H2H0fIwQgKdKAa9E2jRkwkrFjdbWvQJbwtqCVXCoMYuksflks?=
 =?us-ascii?Q?uGFBN4No/qeHhtbdFrl/VihC46TvvhZ98VcXgrio/RmUM7jmgwfva+beNtb9?=
 =?us-ascii?Q?UYf9uhM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9135.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RkgvbqIKec4mhij2xo30i0moqo9IbYtATlwEb4/+Fy5Ze/hT7dYyvA2QmqkE?=
 =?us-ascii?Q?TZBUr3P8bcygHMDYP+ZeCs/hiD6CNjWAVxiFmIR52ZGChPtmaEgVIvRZKGTj?=
 =?us-ascii?Q?xceFtx4s+hZkHjUCES4W+SGG1KrmNPvarZEb8xOBcDS9PuuOgMtdsLtxfsDi?=
 =?us-ascii?Q?ktWoGEtFhrVqzpFgDKTySW+IoClBryrJl8xpoYj+F58gK1/V5/D8hxouBOX9?=
 =?us-ascii?Q?VTXtbSGqptEFdjqxGw0en4N5oOwKv1zpr9t+Bx/717xfaYe88A0fipTE/mCZ?=
 =?us-ascii?Q?njl9iD/gE0UXdh6tvrHadFxjXKBa9l6AvSom/oSCuDoLwmPw9fOoC7+1oESk?=
 =?us-ascii?Q?e4BPfUreWtYfhyzeJakoa9HkfZkaigJq+lsU4RuK56oE4jpJYsEQ6W+ZwXPU?=
 =?us-ascii?Q?Ieh2o73dcUk9Tx68miX2SgwXsxMpUKR9b9u8eZQL9XZede24qnxAs9iIsDHd?=
 =?us-ascii?Q?R3JnQ3kd7/xJPfiI/O9Oq1sfOlprGxTtpTiKWls2lpnV33wqZimcZkwn2wv0?=
 =?us-ascii?Q?TzjjcKIMdTcVeULwjOB+xVsdeb7obwsruUtwegQk0Xp6Oejh8zQzFRAbFWyv?=
 =?us-ascii?Q?ePargVP6BySwWgEJBnewF7YPDRe08BdZweMoEShStylVyNAhW8nA57T5s0ap?=
 =?us-ascii?Q?5yxQg2x0XmgZcfO8BVtS+gDCBxWIjZvblOXYOYgB38nl9om3g/PEww0XOxV9?=
 =?us-ascii?Q?kHYSgChDxKoSs9d41ccAuor4qCCxqqpprIbJQ9ZxX4VvVdoUKA0O9FYdVTIz?=
 =?us-ascii?Q?1Y6uP0VkUsb0NmcvL/7Jt8HArapqf303EWRolbSCpBtfNUnh1dDK51SKsJKz?=
 =?us-ascii?Q?4ArghGQu9U/c2d55zNmJY9Hz1NhZz0vXET1B4IMvljMqkH5n3We+vDz0PRQp?=
 =?us-ascii?Q?szBUIWiCN2J7ja77cJqUeERY8HfOC5LqZi739hPcmRU+bqu4TmaXPLyKOMB5?=
 =?us-ascii?Q?d/quPwEgHQhj3WLLF/khNqe3Aqi6zH3LlxD35JVpBmwAMJZoDRuo/r6jsika?=
 =?us-ascii?Q?cFDvbZEJ5lPDszPGAhEv38rjnUzjbO0y6/zxpcNAN+r3x4+cQRdNusjMXU0Z?=
 =?us-ascii?Q?GIkmDtjPEMSInBhgPJgaCEY8/h9wW3s2fAK4M8MOz7q1BSO78P5eLurahvTl?=
 =?us-ascii?Q?uDcKl2cREnyxLdSn1uofqmYzrRqeREclykxX/T8be0e4GW5RlNY8JB7Aki9r?=
 =?us-ascii?Q?xqzhnUjvbe1UDURiyjtn+G6sCx6yMxQ1NjC+B2Oo1ZYJ0gRdreOl+0/NSC9o?=
 =?us-ascii?Q?h/8rG4mrVGyGVtAoXgcaWS0wUnqi58l01QWtqIPBQay7DqRfEOThUtw6x1EG?=
 =?us-ascii?Q?+A9UKDVp/jcKWjLCseXmyJLojOAU9LgLNOsqru7HvKIGmcwKl0IVIwRVTznM?=
 =?us-ascii?Q?XiAYULv9ikJxQzWKe1B2tswLMS+b9GioX1WJ2DJl/f6JsNCZDLnOtj0JYlzk?=
 =?us-ascii?Q?cgoZdhJz0n3Xj3u46xVjnxEwYpECNman6WvE6JsH8R/XMKTl7hT4M9jOVNrT?=
 =?us-ascii?Q?zGe939LDsJ2KCMirXImw1mv+FVQ4pqrs0Qn42m1cFiX+ZHNptKIP+qgvRX5D?=
 =?us-ascii?Q?1RYOEJy9fXRXVgJiUh/13y89s6sCB+DH34So8l4lDOycj0p9Iqm1T4CHlTEw?=
 =?us-ascii?Q?rA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2b50b3f-452c-4968-64dc-08ddeae63571
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9135.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 12:34:21.9829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AtnYGlamtA2JVs3zRFLKJxONXHicMp2aw91FShHDDESvpNB6ybvt3DdYYibAD82Dnxzckx3dZQJBzq1BAuyVyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8233

The driver is part of DRM subsystem and is located in
drivers/gpu/drm/imx/dcif.

Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1af81124bba3f..dca6b1ffcbc47 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18360,6 +18360,15 @@ S:	Maintained
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


