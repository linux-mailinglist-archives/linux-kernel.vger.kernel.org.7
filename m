Return-Path: <linux-kernel+bounces-734098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CC0B07D0E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 20:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF99C3B0396
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 18:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F36429ACFC;
	Wed, 16 Jul 2025 18:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FH+1nZQd"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013015.outbound.protection.outlook.com [40.107.162.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CFF29AAFE;
	Wed, 16 Jul 2025 18:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752691245; cv=fail; b=W+EUS9hQZ7jTvvlFt/jpIOcBF1eVD5kiRHo13de6fvn7tF3cFqk1jd5R91K97/XeLW38IfUCCYkqZZSJ1uXFPKd+P/euGdjK8i/bP0kDzdDFU0y+MQmoSFJR4mwZ0fkSXfZ3gbjA74+s2gMTsjcJu56fuDODSHPWjmTXU5NYLPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752691245; c=relaxed/simple;
	bh=fBntJdmAqnt00KnTPeF4w3bHh6hbQ4GxLMlsbrDfraM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZaDIHp6z+iztHSeSoToJWDo6BV+YFwGW6qiM54Ztb/hd2UCSsdNf6enjwxrk6mThfA/MTjRi+Tz8mYHBi+jo7bRKkoPWlKPuzVx8RUp9jWgiBkGQvE3rY/KgD4WvOESHiiGHjvvU483/GcdKy9FsZQpUoO/K/HsAQ6s0GkbOqsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FH+1nZQd; arc=fail smtp.client-ip=40.107.162.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HtHgLBdqxrvPp328P1W4En4OBh9ybaOJiBrIeg6CBwv1IANldh1GsnefWhS/deWT8E7ybZLw1dxsO5N7Ag0sBD6psPZBqMANWUzTc2IRxLNiceg+EWTZ9yjI1Q2/it78Bm5l+kzzoLlNSD5LN850dJcNvypVDa56bXcV/5dsse3ftTQattFkFB5letQWiUfuak4nKQ0m6uy85FjL37Ifej6A7Df7uk7wEOLsw7/zd5tPtcGLvIbqOugcBkOCVbSWXfLItDXPL0msdaG7eTVodvaQqoye17BamWjjGvE++A2E1HQDX+Rnd4jVqbtGQoMy0rwEKwT5pWE0HX8Y6+tdxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TV9sFRoKiJrwWF2LFa1rO8fhtoEYjqgpztwMubnrhLo=;
 b=x2KF+mQF+e3vmGuMpJBbZrzULRwfUVfXBKuq001yapbbI+/S64DpWZG84efhIuUH2TFCAedZEVfv1CgAH/w1ZoNvDYC2EhWjqiCpPkQCyxnOCldEB+kUiqyr1bqFzcN/E4ykRBp5/9DaVzHmz3paysRmG8mWU/rLsLO2OgekCqaJ6q7gLxE6URas2w/h9MOoHHMr8+nZLOgtwI/GawnTWyG6QKzDwlfxyJNY3jyUM+Pm3gfoXat2F3yrZSw8L1ybVOfohkir0/TKLtJfmeSlKv3heLpiLSmQsDvQIlI65PZ5MrowWNv45M59P7+ai7SCWwNrPZ7sAGfddNj4Grp44Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TV9sFRoKiJrwWF2LFa1rO8fhtoEYjqgpztwMubnrhLo=;
 b=FH+1nZQd37Gurr8sznFejkqUzs7UQ8zp60Ctao+VdadfnJjjqFy9hYaJloiyuoD+n4fKZeIF6Nd5opcho5+CwuutSvnsu1O7xfXKzbZkxXDiO0KSWkz3il0Ga/js88WdPbWG4Fhc8sAkx2642bcdeyTNal5pnlspkFtBlF1MQJmoLhLDYkmiYqR8aR62T+3Br38Vy0MXlJ+p/h1hHNbnHebsBPtufZ3M4RfZ1H4hkChjCZ1DnkXqovsomYsFb3SgXzbFHNzOUZ3LX6pPXFOoDC/Cm5LsmuufhYYh0YjFsG06Gh6dNopR3AOFbRdwANB5AYeuxzdXYcP/YAxB6Et72g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10897.eurprd04.prod.outlook.com (2603:10a6:150:215::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 18:40:38 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 18:40:38 +0000
Date: Wed, 16 Jul 2025 14:40:32 -0400
From: Frank Li <Frank.li@nxp.com>
To: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Cc: imx@lists.linux.dev, Philipp Zabel <p.zabel@pengutronix.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/10] dt-bindings: display: imx: Add bindings for
 i.MX94 DCIF
Message-ID: <aHfyIGchYEfOgG4h@lizhi-Precision-Tower-5810>
References: <20250716081519.3400158-1-laurentiu.palcu@oss.nxp.com>
 <20250716081519.3400158-7-laurentiu.palcu@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716081519.3400158-7-laurentiu.palcu@oss.nxp.com>
X-ClientProxiedBy: AM0PR03CA0074.eurprd03.prod.outlook.com
 (2603:10a6:208:69::15) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB10897:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ad31700-2ca1-43cc-6f11-08ddc4984253
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bzabGNxu5j33pRyo6E1kIkMNw1hPLIBeJLMw+0XsCpUIQVFOy9Tlg287yasI?=
 =?us-ascii?Q?mni1VdhfIhlU3aNpDgZSX64Gl2lqq7eGFUclT0/4eMFg9d3MX0vccNVP/0Lq?=
 =?us-ascii?Q?HKhFdFHeEeYhEVd7ByScpcOzQLmrzbY4fHd4t0BYj2mbGTYrp1AFEN4eTknZ?=
 =?us-ascii?Q?8+WWc1WQyZEndQBYy6PsKtVv/JucCXkenhY2WOtjSHlgtmZyYZNVM9q9KjQw?=
 =?us-ascii?Q?gHzzdjrf5evP5uSGxsGc6xrPDC/QPMD+diveyQdbGYbqW9AzvYbQnlSxjxz3?=
 =?us-ascii?Q?XPbyaTne8anMRDX+3NyW7rl4YXhfZP+nxoHrPCYpfpRvuVZMd8DOtp14oAd5?=
 =?us-ascii?Q?DlC0SI2/ECUV2WGpnyw64dGDQFr6nmVumc2Atq3sepJmpBcm3ckkrys/GYcU?=
 =?us-ascii?Q?Fmqm9Qcwq7pnj9+HdD78GYwtdF50GwyXAz1ahA399kDCNdgQtqqaMijAdT2D?=
 =?us-ascii?Q?J+066q39v4FO5YAOMdM9AwKu3+aktWd2y/uIdtZtPKZoaX2zaqgJvlKwxWz3?=
 =?us-ascii?Q?N+wh3LTtDKlySYzth6xLGzbu5gzs7Lq8XTGYV66Nc0s/JnLpVmn+hl2eH3EG?=
 =?us-ascii?Q?P7Ec0STKGoaW5yaDfMrb2J4syM/OscoTVYFskAH9on+/D9N5KK13uOBuBfg+?=
 =?us-ascii?Q?nD9sC6GTA6Z/PNMyACbMqFC6e+OJAMkBEQCaz+gGG1thXvJQoHzkeoAiRd7R?=
 =?us-ascii?Q?XmKtBxrxLCK2H8/x/YzWKkX6qWBKEr1MP/u4MroQ87IWAgHpe+Fn18r/H8Jk?=
 =?us-ascii?Q?6o82TytyaD5TqWVV/taBBInWu0WW19xf9BU2vq2K4WvKgBhvPMmiJ2diKM5c?=
 =?us-ascii?Q?0RRUHxlv4F/Jv/YiZaSK8lMn/uJrgw0rK9dzS69ZR0dmgZIXs2rpD8rRwae5?=
 =?us-ascii?Q?HjZVk/mJJz9jYiS1QRc+i6kd3aA3M6V9XHd2ntKNauEJKAKlxu7rWcy6IGF/?=
 =?us-ascii?Q?VEzqgbn7Mb9+KQUjFCDUUbrH2pQ0kIH6JZJQkGj5+gNex1WQ27Bm+GRAkcTX?=
 =?us-ascii?Q?acI66LrGh/0gRZ7MHQodRQWahp+ZjZdCz1u+C9/+5moo2Qg+UZ+2qfomX+7q?=
 =?us-ascii?Q?AXli+Ob85p90RGVnFFDIPfqvK1/bigPoMywj5czFmD2uCgGloCvyHdGJ8K0N?=
 =?us-ascii?Q?OvdJUbg5to5uWnpYT4M3Ap8UThnlKT+U0ZPYmbz3tE3AJUC7xzzRuYjWhMru?=
 =?us-ascii?Q?ZzVZOU4PEA0RrVBng6BGhRdCb2NxEoj/uYqIVmKjwAgvn0vcwbkgtQM2su06?=
 =?us-ascii?Q?7Ddbm/++MzPV7MmeBhf7MIa9bIdxAPZzgEDgZEE+AA3SahmcBf8BfDJFJFku?=
 =?us-ascii?Q?OlLPC8mlXRPrnV2lXccSHyjXmTmLQxvJEnYeguS7SZzhVdNETHbWMQ8XF7lM?=
 =?us-ascii?Q?z4aKNAHbseMWZ2d206SVAvr6Hx0f6uKdZgvYOOMJ1XIRLs3RGSUjK1/dVJ1o?=
 =?us-ascii?Q?qKQruY1LFbZwommB/3lpm5xkCtIWapjL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i2mMknQkfC4cG+AtXNyL6QrGTFycKD4N0oPoqgmAlcHVqFOCqo0n1zygV6Ns?=
 =?us-ascii?Q?mzUkw+g8E1lmBT6IX4FwZPCPDgzdVCS2TIQsHIESec2g1vTijJj2AE/u3a5D?=
 =?us-ascii?Q?UWPE1/DzDzqc0BLJcNvCSJ0gogQXnz8mX2mctLssK8v09HMWHvSE6xGj5kqv?=
 =?us-ascii?Q?VbPCBodDlyn4uEQJQYx2J8OT4zi4pNJ+amOc4kZOBWzytaZz5QtulDUHBfpB?=
 =?us-ascii?Q?THaYBAaThRZQM/CziOSX/Vpf/3dvwer25b4ALmC5GvXcbU+AR1PiHwFJL6zx?=
 =?us-ascii?Q?SfBxHQR8LN4PRPCD7jd09KxL4e1g6s5SbxacX3WEE7BzdCi0kxmJjhKbly1F?=
 =?us-ascii?Q?kub0//x/lQvLXGbpGAFMcPESZBFCpbJArzWHX8Ed/+sw3gLKUgjKrfa/q9Ec?=
 =?us-ascii?Q?SAiQ6mi3iZwEXKkri7BXSRxPx66eGvk/F7W0ce63CQrLYgQKYBsmBB3YmJug?=
 =?us-ascii?Q?uAtOxrsEKrGDRHecyGoos2rToVrcmTOtI7E2QmO8Aowu2jklL9BkheZKRNcV?=
 =?us-ascii?Q?h7lXzMZqHhvLKhXP+DwY9MNPhWW0a149vywKOCUe3uGwtQmxCljmJSTQ2Aff?=
 =?us-ascii?Q?Fu+2ZOu3KAMSAadJZHwrGPbYVfXH8gdi/xzRsIyFMgdfBcwdfghqauHNY36R?=
 =?us-ascii?Q?FK71wP9HjXXU0iRL45KzRRxgwTS/RVAcCRUD3kWslAD+gIUtVaTn5vgOWezw?=
 =?us-ascii?Q?tF06rgfDqI/WnMMMD+tyglDPTxbvpFDQSp7quR433ixJrj3fE16y2fqqWQCY?=
 =?us-ascii?Q?t8SWLqrjOQ7OeR13JmaCDfGadZDAWhF9H/DCxTgCDUiByLCKtaJPPmhL4TPM?=
 =?us-ascii?Q?koQKUCKJhPszthQhvuhZD7kfEBbwEEyQz8wyMpJ7PjjOfHss+EWagxVPaSZ4?=
 =?us-ascii?Q?ExS9JoEsixj3lHZ8RAS/W6drwkur9vsS6B0cVBXetO+pH/dmf205Qi9YtrLC?=
 =?us-ascii?Q?4d796V0c/sQQYOmpg6WhGK+4PcmrMgGrusMWNfTDdz54sPKcwrlPHSvG0jec?=
 =?us-ascii?Q?lT1koStmTwixsUvkmXIzgE1+A45S533TH92xjmxtSorL4ijCkJQKIp4I2lSG?=
 =?us-ascii?Q?iJVID1hdJwP7LMRWbvtHAnx00xd6eUVefgieFYkLGBKRNuvf9NkfAgY4nujd?=
 =?us-ascii?Q?tRZQu/nRNSPu2ah5nwgjPJ158d2JqvPzGm+pdLic8zMsZ2sR0w/mcGv2Wp3w?=
 =?us-ascii?Q?jP6kh99fvaO+5U7QbdKBtq+OxSB0YCu5//ID7gVGS0vPMOJySappDc3E1blv?=
 =?us-ascii?Q?y/WuE8Uk+OAnT0nFb748O/xcAVSaC9sKKzy3HlgsNGtnBuFsa8lHk2CH3CRb?=
 =?us-ascii?Q?ZLkKp1tN1XFSzLZtEMwv3rBH8R7JbaLX0vE79iur6uk4PxE4Ze41jinK1XJg?=
 =?us-ascii?Q?wAafPjSEihzq6eVlDBKhgqq3pYLtvxtRALTbWsr6PyNFQ4hhfXGBrdIF7Df0?=
 =?us-ascii?Q?HI/bvoYbZpX6C0ulpauoWm6K9GZs0TG8qGX/a6F3DOrJTRfirf6k3vraR4N9?=
 =?us-ascii?Q?RXnMHCMgke6rFxRhWPcvMGHdmkDP2Q6t9CX3U4umus+ZocZ9VhzD0BtzEwbn?=
 =?us-ascii?Q?2P/hJ+P7EcgDTor9las=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ad31700-2ca1-43cc-6f11-08ddc4984253
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 18:40:38.5223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gCpX5RALez4l5Q9u7jwlx4oAAR9E70vnkgpWPvBTAVfe5j2Dsz5dQfOzyaU8dCAf+TnlR89fxFwvdIvSdHTzaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10897

On Wed, Jul 16, 2025 at 11:15:10AM +0300, Laurentiu Palcu wrote:
> DCIF is the i.MX94 Display Controller Interface which is used to
> drive a TFT LCD panel or connects to a display interface depending
> on the chip configuration.
>
> Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
> ---
>  .../bindings/display/imx/nxp,imx94-dcif.yaml  | 93 +++++++++++++++++++
>  1 file changed, 93 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/imx/nxp,imx94-dcif.yaml
>
> diff --git a/Documentation/devicetree/bindings/display/imx/nxp,imx94-dcif.yaml b/Documentation/devicetree/bindings/display/imx/nxp,imx94-dcif.yaml
> new file mode 100644
> index 0000000000000..207ddf0f550df
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/imx/nxp,imx94-dcif.yaml
> @@ -0,0 +1,93 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2025 NXP
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/imx/nxp,imx94-dcif.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: i.MX94 Display Control Interface (DCIF)
> +
> +maintainers:
> +  - Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
> +
> +description:
> +  The Display Control Interface(DCIF) is a system master that fetches graphics
> +  stored in memory and displays them on a TFT LCD panel or connects to a
> +  display interface depending on the chip configuration.
> +
> +properties:
> +  compatible:
> +    const: nxp,imx94-dcif
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    items:
> +      - description:
> +          Interrupt output for CPU domain 0 (controlled by common registers group).
> +      - description:
> +          Interrupt output for CPU domain 1 (controlled by background layer registers group).
> +      - description:
> +          Interrupt output for CPU domain 2 (controlled by foreground layer registers group).
> +
> +  interrupt-names:
> +    items:
> +      - const: common
> +      - const: bg_layer
> +      - const: fg_layer
> +
> +  clocks:
> +    items:
> +      - description: APB bus clock
> +      - description: AXI bus clock
> +      - description: Pixel clock

dupicated information with clock-names.

	maxItems: 3

If clock-names provided, clocks genernally just need maxItems except description
can provide more information than clock names.

Frank
> +
> +  clock-names:
> +    items:
> +      - const: apb
> +      - const: axi
> +      - const: pix
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  nxp,blk-ctrl:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: A phandle which points to NXP displaymix blk-ctrl.
> +
> +  port:
> +    $ref: /schemas/graph.yaml#/properties/port
> +    description: Display Pixel Interface(DPI) output port
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        display-controller@4b120000 {
> +            compatible = "nxp,imx94-dcif";
> +            reg = <0x0 0x4b120000 0x0 0x300000>;
> +            interrupts = <GIC_SPI 377 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 378 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 379 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-names = "common", "bg_layer", "fg_layer";
> +            clocks = <&scmi_clk 69>, <&scmi_clk 70>, <&dispmix_csr 0>;
> +            clock-names = "apb", "axi", "pix";
> +            assigned-clocks = <&dispmix_csr 0>;
> +            assigned-clock-parents = <&ldb_pll_pixel>;
> +            power-domains = <&scmi_devpd 11>;
> +            nxp,blk-ctrl = <&dispmix_csr>;
> +
> +            port {
> +                dcif_out: endpoint {
> +                    remote-endpoint = <&ldb_in>;
> +                };
> +            };
> +        };
> +    };
> --
> 2.34.1
>

