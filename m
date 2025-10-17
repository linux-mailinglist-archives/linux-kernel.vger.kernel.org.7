Return-Path: <linux-kernel+bounces-858693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CA959BEB738
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 22:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E73584E6DD4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 20:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4461131DD9B;
	Fri, 17 Oct 2025 20:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="eVukdDbE"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021085.outbound.protection.outlook.com [52.101.70.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676942566DD;
	Fri, 17 Oct 2025 20:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760731907; cv=fail; b=tKCamyh86N7ASB8VAmbPJ7e0Ez7b/rq8cXVAXPOkugzHZSz5eMezBzZ40qWUFbvTIBSNG0vURlXY96jRij2H9W6anLP+2SF77Pqc9JkKH+R/p5KLkMVU7ZV8KuHoQ/6w4/TIxAKggiCSQVxwruE6LOLzm3HoI9Pye9n5l/MlkGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760731907; c=relaxed/simple;
	bh=iTWzeGctc8AcS7LPJEL0z1vsOUblEWcfYQPZkF/2w+0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=eK6ugLvYqgfWuBSM42MsFvbBc4Q714Szm5N4nueBmGVSL1DSTE+pd8ydrmz8ZAkkqrPlM7GVf5jH0rqFPcBOFIX9Qf+wCpuM8DGdDd/cE/zD9H9YoRAHeewt11GOjU2nP4KhWkef6llr8vdx8SMG++EuU72j5/NDzmzjvZmTBsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=eVukdDbE; arc=fail smtp.client-ip=52.101.70.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E68ZbYIyp8MZi7s9tWo4iyIToGBwUcN9Etd9KfFP32rx0iUG4h7lwUrYpIbdFVwiAiTOIeUjdsZz7Q3FsymbxFxr0/rI0XcUdvxmyY2dT+ccgVgs1IjZSHsxtRulyYCnHDjDUv2ykgesj7E1k9+/jyayv/3wakOsGrfCKCQTLUHIgt2+v5KDsA8gwBo9ugk8lEOMrwFCFaNpZBlrPLZurwb3VjTgZ2G40CUep++Qej7CGbm4YXTcR1e1uZzEJ6WLelEYZ5SARqEcT6OGLxZO+SwSuCPN3Ut+3KqUpK9QwAgYCkR8IP6/8X4506Vb5CnQLuMI8NKiYfGaSxmuaXUBEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XgXBt5Vj7LkEI6yitIIm2GqmR4sgyd0J5qECpzRJKaI=;
 b=jsDzgJKicgJC4/I2Ne1OQCezijiWHRvemnfv8y4UGr6nMcU2xSgYCgRKSADoePqm9hGbpt5wDy7LUcsXrDdBol5r4hS8fjR77gTdkw1kpKbGAj32Vp9nF+h5UngZ1ipTTSdO8dgL9CWfbL+NOTcuXmpOW+LgiAXRHjFpAgUqJDeJBULJJZNIl2DhEM5H58oPXmlpKR/RUiNaVCubpjC1k8egOUCKD1DSD7ucPIY3AgcuNz/fV91WxVzBfCJuESZKdG7IwvcuZlEy62HQ+3SBudwX/RAcx+l5OGsQ9zxVKeopv2I0P+bpe6zuD70ze3NETGeSsQebBd/8i8V3Psi4pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XgXBt5Vj7LkEI6yitIIm2GqmR4sgyd0J5qECpzRJKaI=;
 b=eVukdDbE9C/aLeVejdNIuDBPx6ud+edPpXTBUBdJ4HrEKyGRGbnbaN1jSbKqtxW5Cs4cjZDeKbaqohJuJamSWg54em3P7MQ3pGixyAOiwJkqa4bIg2f7VX4r+EbV3yB586newtP80nK7vdhkj8+vAUsZ6yD3BA1s/jLI17tBg7mM1LmwCtaN2cfV+bWibxEHV7ZhcT8lhCE04nR1cgeCSNCzCm7W5ys1859BfDyP47n87KJ/SDXu1kZrNn1IW4EV0fedFmOzBp8acLXab4L98Ty7Aox9gLFhcUR46il5WAxtQkESipiwp9xQKbx5PB6Yd2x+/0HcbaHHyFmDhqYYVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV1PR08MB11247.eurprd08.prod.outlook.com (2603:10a6:150:283::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Fri, 17 Oct
 2025 20:11:36 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9228.012; Fri, 17 Oct 2025
 20:11:36 +0000
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
Subject: [PATCH RESEND v3 0/3] clk: en7523: reset-controller support for EN7523 SoC
Date: Fri, 17 Oct 2025 23:11:23 +0300
Message-ID: <20251017201126.493496-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVZP280CA0067.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:270::16) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV1PR08MB11247:EE_
X-MS-Office365-Filtering-Correlation-Id: 7897d9b6-add4-468e-42fa-08de0db95f9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L2xiHv/3fymll+MnFYSwDxaAYt5N2FRnUgIdT2th9liOYORnbV4infjeNP60?=
 =?us-ascii?Q?XY+mkmVcJrKdsP24s+jwql32QHj9ysZGUxwrIxtDID8erXPUp9TApXAsFdTm?=
 =?us-ascii?Q?32ZAou4IFXEoiTtg1XYOWK9FPhD0GllG+7Dw6jN98H91JZiiRFt6C9QsHLSx?=
 =?us-ascii?Q?uJmfnTdGwK74kmQe+TpC2QYuY7G/MHvqlz4bLLjxNDgppTno4l1xXeYYaJI/?=
 =?us-ascii?Q?JL8vA4ZhRUWQKDOltX5UTOySAlxynXM1I1dE0ykEQJpJ6AhpkccJKOwIhBe5?=
 =?us-ascii?Q?QpXvN13RPWPVCcCJ5lKJmniFugUaEPAntBD9w9kYGYIpma4UTDy75Z5dgEkM?=
 =?us-ascii?Q?xp7n2Cp6XViXVA9pI6HGjn7xwH3G6gmwxmEZv28w1Jt25VzH2bI0CPy5/H9O?=
 =?us-ascii?Q?AFMfXwduFe6z49bgnkIWa0Np2XA68ZFLkFtygOlCuWn0kFEUSLS1m28ntrCK?=
 =?us-ascii?Q?bKe+bvEEOWcNUKJuRfwngHtaCGqNSAEKhrpWZhRagcBh0aU87xoCrzvF5lTv?=
 =?us-ascii?Q?o1rqWu/LT0+O6tOn4e+yTE77Ot+GiJ53I+a87l8WLryRXbWS05Br5a69w28O?=
 =?us-ascii?Q?HPsyKUcbOQVj8Z3eFT0owU1KBKhB48jOfl4Ip3IN5Ulz7DX19dExtJQJ64BU?=
 =?us-ascii?Q?ywVL+ZNbjhO12Xj+5wd4iWvS1aHpG7bHe2PLCGf51XhMSKV4Jd49m47bVMt+?=
 =?us-ascii?Q?jSw8+Svxl+6vGDRj7jk7U5OFBeOZUrOoVfwjw+WdAW99PQXEdMGN90DoAN/V?=
 =?us-ascii?Q?paq9AM6J5rtYixoefGiyr13K/7fDyxFsV8Cly1a8FV59m+EMfpzvXiYj2mup?=
 =?us-ascii?Q?mLnWUM4oZaC3xOKaakNmDAefrv1l7k/hkJSi7TvBmX1mS6wfP/qAz+UULG4C?=
 =?us-ascii?Q?THo5ktllOBxTUIx3dDxnGZey9wfsZOCywWhWlliVEamNsc3dCmrjD+yIMVho?=
 =?us-ascii?Q?uj1zCcZLagqigiTaagPdzCHDvVkJNt8qffei7dIwbUgBzCq5cBZy1Zij2ord?=
 =?us-ascii?Q?CBA1GZa4t7n0D6B27wCT6Q0qUnh3+jaUTV2099nqQ2azT/rJQ4ATOe3wfXpc?=
 =?us-ascii?Q?k5uBEK1uNox9j8P6VQ4KFi4WHUnpsCzm1yXgvX5wbw2SIg6c4unObpPVpbuF?=
 =?us-ascii?Q?sM5A927giKd64Tx1MmPNiZKQN59hZ8FO1+OIs+7b/HmvPDvh4TsAp0+QIcZT?=
 =?us-ascii?Q?EDxaY7YYbYIeFfwTFKsW1bsvZ4Rh9anpF/SX7QTIEW/KUiP17qi1+nShqLoI?=
 =?us-ascii?Q?hdGW05+6KuFTQ5QbGd9j7H8mtcKgCUJPGXTSyRKS0OxzWuK0OAeKuX9Ib/LM?=
 =?us-ascii?Q?IEcGHso64KJkBVOgEc2/iGREajjiyjxmpBBRI9qGjumCyD2VuYeDZRZI5GjI?=
 =?us-ascii?Q?uOlDp7TfVKj8e2Ze2NPUPqyt04rVI4uZ+LPp4rMq0KJF7K9lOCMQn8rP4gsO?=
 =?us-ascii?Q?5uYYgSce2Of5RE4QF6567u8pMYPow/4ZvUze6oCXRqY27j6cH+Bgut8dTLoD?=
 =?us-ascii?Q?W8enAc8TfZXXWh7F2aSKnxzCZrEVIGsuHUoBu3yJjUFShpL2Epc4IWbrRQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZQR9ceGn50rkIgJY/7+odQhhTj7SG/hn5iVlbDfQY6a/98JyN5jVMWxVQnnY?=
 =?us-ascii?Q?9DQUOBI3JsOEsYxFg/QZo/QdTceocaFKmgwIPXrCSJk6/yYwnM5bKfbLb0sS?=
 =?us-ascii?Q?8Amvow/jPmXZ2OTlGCPN7GuibOvKIAe6Ui6V5Zf1erM71tHzGpB9+gf41qMj?=
 =?us-ascii?Q?ZP145ews835iwaahIFIAobGVq+QYH/5QKQLgMTqKzgiLpiSKrI+Vc9REWdW1?=
 =?us-ascii?Q?qCwdZjBbOzoltslSZzUkjLFyAi08noF9MUkSnHpGXuiMm5f9plMb5KDSTKeZ?=
 =?us-ascii?Q?qGfZ2Avf6OX4WnG/s3TYaPtVLVdmP0T1J+62rxN4lWxuMC8QP3WFTIBGaKBO?=
 =?us-ascii?Q?uApauruhuq0a4UuqqgP5axzqQkRE0LY++hJhy4Tfi7EpIX8UF6d8c6IJ2vgm?=
 =?us-ascii?Q?jDvZXJx76MeCA1bMX32zHLFxYY8Uk0r/6F06ZETz+g7RpehbpTNCnoP1369B?=
 =?us-ascii?Q?HD93xj+vx+AuXkinLQ8108FhT6VATYP5V7AjvqZtyxFMZYyrXRFX/Epz+LIV?=
 =?us-ascii?Q?bf++zHOmiiOMyGaoEt8DxgSiNHuJN62p+eag/NNi2KlYQqXcRl5qKYzoCOht?=
 =?us-ascii?Q?7ZJM3WsRkn21LUnfMUEbYKWY36mZaaMuMw7ilUrrEyoZ0LbwcGX9AM7DeOfD?=
 =?us-ascii?Q?3SwQMaXbOEAEfCxn+FXiMAVUpOClH3jnGYFqt+zOyanlYhkdfmYNW2R3cj9I?=
 =?us-ascii?Q?ZmKVmkOwR9Hhk7LR6cocuYby/MZuiSAUz8rbnRhEkl3HTwhnIdWISUw9vXVc?=
 =?us-ascii?Q?Y3fOrZ8qsbeZVUw69hlbwJZPSS49D3YJn4xXoY3OnV3mCHGnNQMBnE7WxwWc?=
 =?us-ascii?Q?IkjMxzpVTHND7DtOgHxgAc1RJiDcOXin5NaftHvHHA/O/jqUTcpp3etENSr4?=
 =?us-ascii?Q?ZKkCHi3B7Oj47oa+JASGgPAWwtUhpKKOoxroLK30D6YuKf7nm6EaAWs6XZu6?=
 =?us-ascii?Q?g40cG39VaQ2xuFkSzdnl1umMl67pdGEo7WlExyIveC+hw96zKzXVD3cukP0J?=
 =?us-ascii?Q?DGBiEjF0mTScgwFKacOG/0x3/EAgR6VQg83HkJm9C71VC2IZvIRe1vvYo7yI?=
 =?us-ascii?Q?mHNQKqlP8JqMWiptiBgRLWlE4QSlHTO4aU2LnCDxYkXHXX4yPSJ/NUW601lx?=
 =?us-ascii?Q?yX4KIsbLRwvOsAczklPoCzKodA3RL4FkQg5VS6oLV1S+YIMElHiwruy6B09e?=
 =?us-ascii?Q?t6RDiYOoGL7EuGLR7Qr6AxFY6X/D97vCKQwnv6Vc0jmK7YPBFtrfKsXGkH7m?=
 =?us-ascii?Q?xa17cUVEi0NGkZAWgHKHFGH4v5zrQGqgHsfVMEUzNdPKOSBerVXAd5xrroo7?=
 =?us-ascii?Q?jPwd9ICr4jZte+L1H19ySexAVpW7fS2YHG/mihec7D5OtG6Y+DxTWJiWu6ZI?=
 =?us-ascii?Q?NqhRGXScjWIsgRvnUtVf/7wEWX1rTOTNPCppHHF1RlTYEjIxqf3YUDphoKi+?=
 =?us-ascii?Q?EgBanFus4TXDQ009MgT+zhTVgqvMDs7Yw5g7ZnGeenpIdVUM6o2HQiRWevWF?=
 =?us-ascii?Q?3zWM4i0bq+I4y5vpy2gFFh1E/nv6CRoI51VUV25/uy4rSSoMk9nBigLf9VU6?=
 =?us-ascii?Q?wOa+07vDi2lj9vaAsvaNy07NVBZb/gtR2VDuGmkZItD+jkXyBlxIxQhkklUZ?=
 =?us-ascii?Q?31f417UgiPbo24aGt6aKKnw=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7897d9b6-add4-468e-42fa-08de0db95f9d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 20:11:36.0913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zDO+KSWgPmTnigYJzXspa5pbb1g+hiAKMt6mpkuWYFnj1gbWoH4j4DSBG+qPNIMsYkAyu+XIKh7CPL6pRNbYFOiWbaVpnY7drxKqL6hmRGM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB11247

No any activity for 3 weeks, so resend.

These patches:
 * adds reset-controller support for EN7523 SoC
 * updates dt-bindings
 * updates en7523 dtsi

Reset-controller support will allow us more easily reusing of en7581 drivers
for en7523.

Changes v2:
 * keep '#reset-cells' property optional
 * put dtsi changes to a separate commit
 * add missed dtsi include

Changes v3:
 * keep en7581 prefix for common en7523/en7581 variables and functions

Mikhail Kshevetskiy (3):
  dt-bindings: clock: airoha: Add reset support to EN7523 clock binding
  clk: en7523: Add reset-controller support for EN7523 SoC
  ARM: dts: airoha: update EN7523 dtsi to support resets

 .../bindings/clock/airoha,en7523-scu.yaml     |  3 +-
 arch/arm/boot/dts/airoha/en7523.dtsi          |  2 +
 drivers/clk/clk-en7523.c                      | 64 +++++++++++++++++--
 .../dt-bindings/reset/airoha,en7523-reset.h   | 61 ++++++++++++++++++
 4 files changed, 123 insertions(+), 7 deletions(-)
 create mode 100644 include/dt-bindings/reset/airoha,en7523-reset.h

-- 
2.51.0


