Return-Path: <linux-kernel+bounces-876687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F60C1C0AE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31CD91887762
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D142EAD15;
	Wed, 29 Oct 2025 16:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XtpvoPHi"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013009.outbound.protection.outlook.com [52.101.83.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC382D063E;
	Wed, 29 Oct 2025 16:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761754759; cv=fail; b=mprAUXfv08M16dgXv03RjlKTjnC/VEMsBCGFzwpDeuCmKzpRELUIhR62dJQKa8tQj1zuc3L2dYXIUmGxtVjKDdJTvY/0WJvUJU66xmzRdSdCsjW6YfsEJ92EV2PzgISh3w+If5iWMiPqKK7lOhmkJh7QR9RhEtGsBLZmrg3i3W4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761754759; c=relaxed/simple;
	bh=XxyOPUzALqUeDhkaGDUeZ3lXlSxYk5mnv6HKi3PFeG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EZfa0+Kai8X49vdOScwXaMtUqRpBE6Xnf0cNxYFshkEcNrKj2XAgvXYBWaMV4mD8O+DpnbVdh+QllWBMGYITzRiW3KAZ8ePp7L20o5oefFZHXc0u2qlj2+pfKon/3BA1ZfNM6KaQR67jrYrCuKiHzdxXoL/HiespfPhqB7WtVNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XtpvoPHi; arc=fail smtp.client-ip=52.101.83.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YkO5e8mCO0GKvpV/CCbk10AVmBq6YlRsmMxtSw88fO5FCwJcy6oLy/LNHCHcLe9JTCYe0fBvgRnFiubYpmzN3ADuY0dUc1xARhhiDjQwTb8GeCr1N7mE/A8mccjILdJfz4kRdb5qDN7J6c3yVrNIo76peZnfnnj1cC3BLaXynxLpxCEgTmnsq8r17dNyM/dq/D7FvqYmpQIcSIs3z+OwdjP+Uhjz1NKiyKt7ivvY0CcFA0uXZo+H9bMgrDrVQUmA+gnpf4NWI/7e5eJ12vr6Si6CNQzT3aavIBQVIE388ff/IDVU1wu1LscuAxHKnIdeFWEp2iphXHalFlVZcXNHDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FGe2yYoHzBO0txWm+GwxYhSgLGW+wdOKQo3C9ogVBqs=;
 b=PcNklCmtRVkQ3yMtK8P+frXs8Yi0nr4lCFRWy5+ocmAamDEH69zTgz15bu6cQqUhWd30ts3ubN8xjLgrWayU1Me6cvPSFMwk3FnUK3O3W0xPChezAyOzdggb/YnlFv/TuvRphmGIXUlbnFkWH/6TSxWqB6gbOqnoUERnAFfBbXSIc5UeUnCDKlYdGff/gBu7kEAD8LPX08SCm7MN5oxMCQ3dYjTYQpkVASdhoMK1ChN4eOdI3xtM0NjLdprFf3oUFQ4h/d1y5nKMBD1cBxYVslCyYzf7M7xLn2y+tUcgBihX3mRgAjyix2/prbuWSfvKXvNmQAmMBA6L1h9IRs0RkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FGe2yYoHzBO0txWm+GwxYhSgLGW+wdOKQo3C9ogVBqs=;
 b=XtpvoPHiR0D8FlXxbQcHyZD9MEkuUoq4bZksxNYMMlxM/lr+h7TgcVqeYrS9ovgMHlIPQmq3w16dGHAmuyOWGYkm7+uCVFWiQ9+NIgcxS5sOOrnT+kpMHYgXXVQiDy39QNet+fenv5FYopcrX3npusZSdFEEWfQKooVJfOV6Q9CTSDwxnKiAw42f1THgWiixejEmmE/Tm29P8XJSe1cl/RKXSujUYC2rQEvbgjySgQSk/OYEqcteLzI4BBZt/2TuK0Fl+Eogjo5bGyCmy4MZgm+OLlT+oISdI3eQNQthcrXSeQvjuCOLuMn/sGjDGK8EoXF9yb3zjsuQI5yEKJx2Pg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by DB9PR04MB8124.eurprd04.prod.outlook.com (2603:10a6:10:246::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.20; Wed, 29 Oct
 2025 16:19:14 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.011; Wed, 29 Oct 2025
 16:19:14 +0000
Date: Wed, 29 Oct 2025 12:19:04 -0400
From: Frank Li <Frank.li@nxp.com>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>, linux-clk@vger.kernel.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v3 4/8] reset: imx8mp-audiomix: Drop unneeded macros
Message-ID: <aQI+eMxlFs13JhaE@lizhi-Precision-Tower-5810>
References: <20251029135229.890-1-laurentiumihalcea111@gmail.com>
 <20251029135229.890-5-laurentiumihalcea111@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029135229.890-5-laurentiumihalcea111@gmail.com>
X-ClientProxiedBy: PH7P221CA0078.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:328::9) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|DB9PR04MB8124:EE_
X-MS-Office365-Filtering-Correlation-Id: 58d6ba6e-1881-4afe-596f-08de1706e68d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BgmJUrN+xEs2jwvHY0gVesrek0lRF2M9THGPpW03v/szHBnUH1oSpd6HxLKa?=
 =?us-ascii?Q?DAvtEFgCufVfaaHtsG4fU/faVPrOFDJ6zZeUdSaiJXsXi99QHxV0m8i7HPex?=
 =?us-ascii?Q?gb/1jMjkC05F299tHRByOcJnCODc+xlZ0y3TWuQDSFXB/YUdBPggGOk9x2dF?=
 =?us-ascii?Q?toud4dGlpw5Ms9FKUqHzQuRooD+QYbSo8pp8OpGGZ9GnetQhQITsWte/4LBL?=
 =?us-ascii?Q?NDg5N2AQbCpPvFfS3DLzGE5VvFUUYgGqzzjusSJ6Fm0+Igy7VCbTF9LJqhwP?=
 =?us-ascii?Q?L8ukuIfZZSJOAitfKls2vpCT95WgjsQgUFp9EX73uczscUdSXZOw7o3eTr7G?=
 =?us-ascii?Q?8NoWeTNnoupPcrTC09cs7fswTE1jzOdLWAWO2w9a7BQEFEoijBC6hGG6kUER?=
 =?us-ascii?Q?VHuLHXHGS9z3wZwYrAODRMUvv4HG/H8A/YkmtwpoiE4Zy2U5CYYb23PF72Qo?=
 =?us-ascii?Q?XCNvW/CIbJVPB5R1iOw9mzsWmh0G3MH4mkUx7RSlO19VcNnbazIhoOs4inqZ?=
 =?us-ascii?Q?G208nr5ThA4Elq6888uZ0VbiXvaIW/aX7YmQjYMdhk7Dfa+/C7c1md0QxnVC?=
 =?us-ascii?Q?GWedlUb34+MhkE+h3n9hMPjsLcVGaHUbXKVU8C76O4/hgKn5uOYhEZt3Ea2/?=
 =?us-ascii?Q?iyJaEzc7BsmvaV99TYHh2ElO1Y3JnmS/G7okYT+zxO4CvDCoM+ofHuhXcrcM?=
 =?us-ascii?Q?B75i4B5pCIj7BkHXSP/Eh7mhvCzG2FN+t4qct2+ldvWSX5pgGjNH+BygEdP5?=
 =?us-ascii?Q?WVXnXMwikm8J+P8hpza+tpe9Ln1G7yFKNzxY2E7+eMIkz0rP9hcJrOlEoZf+?=
 =?us-ascii?Q?278PoQnj4Huts/ZdvL5Zno2NyFuMgM7Yg38ZeZk3D8zyA69nYBARLju/B/LD?=
 =?us-ascii?Q?k74vR5z/jxf7CDPNhjqSEsQN2Ii09geR9n4zOjAAOApoD6pUJiKxOlfPTNpB?=
 =?us-ascii?Q?ZmU5hIgJCXNsl54qJukzoSJOu4c1mChPLkb2jOmLDwjbDqaWERV/ur0vf7bf?=
 =?us-ascii?Q?yxnpfYc2DtW5kCATplzsWkegDTK9SoI8yUnR/1nGV/b48v983FhyGwjsC1Nm?=
 =?us-ascii?Q?+QzMO9IXpxMATdihX82T1v8x5vkZ76WKzT8uHQ/q1GtxVUvVS4tO/eRENHNu?=
 =?us-ascii?Q?EcYcY89wUHe+27gUUrP1zM+22W9tyjuEZN/mbVJY241tO9o0OUPZ0NTuCM3P?=
 =?us-ascii?Q?TzIksVLA5u7RWLL06wP4e8CLDTSUQTMDuaNftKMijpKh+KxOwN4bqlw4P+QH?=
 =?us-ascii?Q?FjRxrUhZDPjviADEOYCHs1qzvctN2ZyLfWj+E8ir2kqKnjBUPktIbaf6XDJD?=
 =?us-ascii?Q?Gqs+N6/GA4aPezaDJr8EyYtuh7gez+Cxz19uMCCrRy3sUi9k4ozzDe1qNeDc?=
 =?us-ascii?Q?F59jS0LR3KXRQEmPJ/rXrDD94TZeqa7HVLDLVe8G3+LMXiPZWswnseFXjsxE?=
 =?us-ascii?Q?SDIW2j9QmhqiWRnrwjqpxWBKWBxO6HBUDTQ1mZOL43KwU5d5GRBkfSYiG8uQ?=
 =?us-ascii?Q?NCWKYOEJKOjOExpqt93HGCaavqiDKY/aKbpn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yZm0lM2FlYr3PxFVzGFCG7EON0GRmric67D0LJX7pC9MH13bipKl2h7r6rOU?=
 =?us-ascii?Q?VVVGcFS0G0UeV8n3dnER6Xm8Z20aRyEwdNr6AeIgJfzKhbCx6aVstMBE9mBp?=
 =?us-ascii?Q?A6oWivPRf5V0zH9/z7I2ruBapW5ZujQzOGPj6oOEZ+euDKvyRwPqR95N6Hmw?=
 =?us-ascii?Q?VMF6TlRMSGNoPagmqLRMrfqSoTNh2rUGtIU0r7kLyJ5euSqbjXmBNbO9uMHN?=
 =?us-ascii?Q?+SMMiNEqs4ocVOUac+Hl2PvkBNkQ/ZFkJfbpFsCWlHKMkUjMPI88ZjddQYr3?=
 =?us-ascii?Q?UGWpz3MeL0Ub69pOL2vLL0fRB6i9cLB3cWBSFkLzE/kC1gvfDzmxUt50NB81?=
 =?us-ascii?Q?DXN5SBC8CtUoF0Ss+JUV5VrvjsQ4ID6BwzST776JP7BBK3rTQP++aYVRHC8q?=
 =?us-ascii?Q?4Z/rRbYTCbXgUjYujkVbwsNIdJKIYnShjxkl4kBh4gkuF5ZN5hNx4+fycUyS?=
 =?us-ascii?Q?4Cp4jhb0NTTXWGSGjSwLdbP+96qSxYwkSI6GCrS/L3WV3VcWnESN7EJjri/r?=
 =?us-ascii?Q?vuZ+95UgIliqnhOSJtY6MgC8pdh4sQXe4WdNB/RcKFz+MLrM1gl0pDHvRJUc?=
 =?us-ascii?Q?TVzsMXEmymi1zKuWKs85aFXn3LdrxO9WligjJFFniZ/PYgl8Bt4JXKVNRUH2?=
 =?us-ascii?Q?DVZvB/EdhSrDD+rdb7PUu/cUu1n00hZg0GdmqN25IjClA2rUjmyooApIrM0S?=
 =?us-ascii?Q?mnUhsoRg0DOpidRU8SEJzF3XdqmgnoZotSuiErNWIxR6G0ciPknen+AUHxTz?=
 =?us-ascii?Q?HH98aPCDPtk6/IlpISn+BhO09ykj0HegChIgz89fwDuLPfKH4Lt9Eaw/nUMB?=
 =?us-ascii?Q?MSdf/YUQZ+98m9rTHbKcpNuyZrJdppJKHzDjkA8NmvTbVS+4CSHUkk7wNnQT?=
 =?us-ascii?Q?YYrut/RfQOXZPxM59ZgvDZQpyvTDddKD55Cnv88+UsM02DIfhI67C/z/P+ep?=
 =?us-ascii?Q?96BC6HCElxBNGmWXVNhoePJNKxSpueTM520y/QKRlsi6qwLDz45gMKhKXGmO?=
 =?us-ascii?Q?YRpdt7yXHZ1rVQnMkxEs1F/9QKRPeTlA1H3/krYnxKPXpWaN3Z7Gtj/1jHDM?=
 =?us-ascii?Q?75cACwtKjVYUoNshybXN6Kwke3gItdc+ZGHhgzOys4H5u6UKvpuDSeRz0uQj?=
 =?us-ascii?Q?boMrdQPeEIDUL3s+7KpAlsVP5jJT0mE1ilbYL7AMermyi/Copx1xUj3NAf78?=
 =?us-ascii?Q?QN7jiHbTwLAgETSjygxMYJrSImDeitIbviB8pWg87cnRHASkDpwfTUxU7DMs?=
 =?us-ascii?Q?K7LOUPcR4QnWzjEO/Odv//tfm2GhzOv6sYTuegZFw9z3S2rdHB6MOaS3iVaT?=
 =?us-ascii?Q?vjyapmqZUREn6QURMv+ghE133QPxjJm8/Y1g8eBxRN/K9g2r9Xq77+x8Y7+/?=
 =?us-ascii?Q?vzqowh/P+3uAEdufQJ5j/BOWUJQODyOZ+4rJhtb8pw7JNHXXxvgl1Kl97zmN?=
 =?us-ascii?Q?qrZas+VkNAqW0C70csbT+SL26ccQDcAts/QdZzoAwcK6Ew2orbssFZu9EFAE?=
 =?us-ascii?Q?n3S3Ow7ztVZHZdcUy55SGKFNAyAjDLnfmQP2K5Vmb25jpvPb8dwr1d7xsMhY?=
 =?us-ascii?Q?Eid9FCfwuVBBF1wBhPdFFdrpLu7/aV2DcHMezCXl?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58d6ba6e-1881-4afe-596f-08de1706e68d
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 16:19:13.9435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /e/PUH9/8b2t4TGENOVcjQPDdw6td7bnxj6FonWWs6VQo1H+SwOkUEgpFlPWQlrX9oPTC3FnShU8ReBDcNHlJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8124

On Wed, Oct 29, 2025 at 06:52:25AM -0700, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>
> The macros defining the mask values for the EARC, EARC PHY resets,
> and the DSP RUN_STALL signal can be dropped as they are not and will
> not be used anywhere else except to set the value of the "mask" field
> from "struct imx8mp_reset_map". In this particular case, based on the
> name of the "mask" field, you can already deduce what these values are
> for, which is why defining macros for them doesn't offer any new
> information, nor does it help with the code readability.
>
> Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/reset/reset-imx8mp-audiomix.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/reset/reset-imx8mp-audiomix.c b/drivers/reset/reset-imx8mp-audiomix.c
> index eceb37ff5dc5..e9643365a62c 100644
> --- a/drivers/reset/reset-imx8mp-audiomix.c
> +++ b/drivers/reset/reset-imx8mp-audiomix.c
> @@ -14,11 +14,7 @@
>  #include <linux/reset-controller.h>
>
>  #define IMX8MP_AUDIOMIX_EARC_RESET_OFFSET	0x200
> -#define IMX8MP_AUDIOMIX_EARC_RESET_MASK		BIT(0)
> -#define IMX8MP_AUDIOMIX_EARC_PHY_RESET_MASK	BIT(1)
> -
>  #define IMX8MP_AUDIOMIX_DSP_RUNSTALL_OFFSET	0x108
> -#define IMX8MP_AUDIOMIX_DSP_RUNSTALL_MASK	BIT(5)
>
>  struct imx8mp_reset_map {
>  	unsigned int offset;
> @@ -29,17 +25,17 @@ struct imx8mp_reset_map {
>  static const struct imx8mp_reset_map reset_map[] = {
>  	[IMX8MP_AUDIOMIX_EARC_RESET] = {
>  		.offset	= IMX8MP_AUDIOMIX_EARC_RESET_OFFSET,
> -		.mask	= IMX8MP_AUDIOMIX_EARC_RESET_MASK,
> +		.mask = BIT(0),
>  		.active_low = true,
>  	},
>  	[IMX8MP_AUDIOMIX_EARC_PHY_RESET] = {
>  		.offset	= IMX8MP_AUDIOMIX_EARC_RESET_OFFSET,
> -		.mask	= IMX8MP_AUDIOMIX_EARC_PHY_RESET_MASK,
> +		.mask = BIT(1),
>  		.active_low = true,
>  	},
>  	[IMX8MP_AUDIOMIX_DSP_RUNSTALL] = {
>  		.offset	= IMX8MP_AUDIOMIX_DSP_RUNSTALL_OFFSET,
> -		.mask	= IMX8MP_AUDIOMIX_DSP_RUNSTALL_MASK,
> +		.mask = BIT(5),
>  		.active_low = false,
>  	},
>  };
> --
> 2.43.0
>

