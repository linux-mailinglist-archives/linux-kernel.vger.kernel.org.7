Return-Path: <linux-kernel+bounces-833543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DA9BA246A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 05:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E06BC6278D0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 03:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C431925DD0C;
	Fri, 26 Sep 2025 03:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="g6Jg5jRw"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013016.outbound.protection.outlook.com [52.101.83.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297A61E5714;
	Fri, 26 Sep 2025 03:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758856103; cv=fail; b=pz3k7K2bmzI40BvDM63lmocq4OaB1+/G2juvPFDREPx9K6CdjglLRz72E22Gi4GOv4DYmgX2EKs2sGhr5bRhh3TV0z16QkqFeHwaUovjlWi7AvN2CrtW60lg03xqfTM3qMC+IF5VYS9COVn9JD90mh0GnWCO711WHtySkgVM2cg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758856103; c=relaxed/simple;
	bh=4GNZPUNeAr3/IW+xuXLG5aYKyIS8vcL4aYuJ+s8fu7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Gc7y7DE1NscNXJOlurr1fg/62Mq9h12r77+DELCm6NGu6bWyrgyAx8+3vQ8RiquMq1ljBSF6DKFwCr5AXHAgNwjn9itCIXaPu4nDZ2/OsQ+gudNlzyXmStjjtwo5I7T4MzmugZtrfbe9Ufxy93CvDFDWoIueXGfNl+5VDeD16gg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=g6Jg5jRw; arc=fail smtp.client-ip=52.101.83.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FseBb3NtDvoB5o9Amf/4JqITbfxXEA2d7FyyJDE4uwft+33Ckv2DDP7x71H5wHjzS0MaUceHWFXH8MvCvWprDdCYKG6opRdniCkSYRL8LTJINOEmgODP0VvYtJGTTAvUiJ+8dlLw6/8MurcXqtZTq7RTF4Q02/8xO8Vh7Bs2oC6U/ePzzqRcBGxQ01v6X2b4WVVTW2lxNowKC+1sSn3WOBQ+GL4rnKPtqhGYkYEV8gZSfFQ/YdDlk1tPxXo7CHPpLfWlGQVksGd4dgE44BcdjlQi6jiCDeT0DZePQLUMNt6Js1sm27Usl7uYzqpQC67k+rDSLBBRw4Kh1CEpvhn/0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z6ybyBnaJB7WGanXkZkteDcq9coRD37abXHJqYWZo6A=;
 b=TfVHncsVcn0Z0kQRpud/7YASwbp0nDWslrDFU/osH0hAFdotqWl03Z7ak6YbVdVp1rKshi/YtxeV5ilzo7RF2lc1/tMkpVbhya7KyGDGa/ngXgwl/EjplGu3m50ZjVUKiFmwcNX/zeLIfcXhuvMhRcttF+8XLmzlcokQak7dIKvuAx1g31LacHhOwPRRDbQZsS9K3wv2+5icLQOgTaxngwGJReS8rLZI7ifF3JDzxobxOBOPI95sXVdp3tq7Fa+9MNSYs6e6PwbuJ92RppglgGx40723rFKVBvdd2mA5J7B9f3WUxszH8cWjCy0syczGY4g7yp1Ydn0k7XtUJOykdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z6ybyBnaJB7WGanXkZkteDcq9coRD37abXHJqYWZo6A=;
 b=g6Jg5jRwleB9Xk5+g5V5tIPoNF4VN5LPhB3f2bOVCOM36v4d6F4+l2rFZa10KVahNy9nXYYcToLw2LpPhIS4efEdcDv7RwPweJSYeVNYrVm960ACqsin4LTQJmuitgah54K/RhadIzTDLtceYeW6+so1ih7CTiL1HJs/Q7uKVL7Vy07VPWhaDUmKJz6p89naj21xDckklKeQJ2UWv7M1Dl/gLc8FeIF9sMmnLsqM74vtKAWQHCPAIipqhpvPplR901UbTC/y8+SHFormAjSRjbneD+LZgFJ3Q+BsG26HAlL2ajcxSTzrL0yJP1qii9vdjb6fM3Yf4uygwN1U6H4mVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by VI0PR04MB10733.eurprd04.prod.outlook.com (2603:10a6:800:266::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Fri, 26 Sep
 2025 03:08:17 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce%4]) with mapi id 15.20.9160.011; Fri, 26 Sep 2025
 03:08:17 +0000
Date: Fri, 26 Sep 2025 11:02:13 +0800
From: Xu Yang <xu.yang_2@nxp.com>
To: krzk@kernel.org, myungjoo.ham@samsung.com, cw00.choi@samsung.com, 
	robh@kernel.org, conor+dt@kernel.org
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, jun.li@nxp.com, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] dt-bindings: extcon: ptn5150: Allow "connector"
 node to present
Message-ID: <ssjqjllvmp7iiykgjbvzbxv657aj4pm3uvforv3rz5phxbhqkp@qjowhqbpnw7l>
References: <20250926025309.24267-1-xu.yang_2@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926025309.24267-1-xu.yang_2@nxp.com>
X-ClientProxiedBy: AM0PR02CA0033.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::46) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|VI0PR04MB10733:EE_
X-MS-Office365-Filtering-Correlation-Id: a86c8832-0e4c-41c1-5c57-08ddfca9f064
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|19092799006|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HTfoTs+BrabesQ3tZSA7oRAvkB+9/Gi6CzoRJGr/CFKvV52ErhqR64yF7CEi?=
 =?us-ascii?Q?j1RY4pN8CnjeKWOvvhVvEj7HaoP63YtB1cETW8TdU5KmQRgvJW7gUa+ZLv3n?=
 =?us-ascii?Q?yJWhhs2acousCqAimHPF/6YYhVC0K+3va4LKdwW4zUw0Vy67JnUJ3TfoQ1Ll?=
 =?us-ascii?Q?In1H9uyoHVdLaMd+LcrEnvgWJNPrXRBEZ0vM3ndGIRG41q8M3oI/fyUOu3St?=
 =?us-ascii?Q?NbCmGlN452ZHgJ81AoE/GaUizVlvfcFUkUvRHgNVP281Hyx7SqnkX63rUtde?=
 =?us-ascii?Q?25DlVxX8SPFJ2CoXIArQa3p+g7geuZgr4Jgrv5Q0YPtdU0CgUf6pAbnQdcYT?=
 =?us-ascii?Q?JfWM3dt70Ds74Nv/7ShEKvQ6Kz14y01RxpqU7Tg99x8ZxWFbm8HlnsIgllFV?=
 =?us-ascii?Q?nBpbXHe2f/xWLaKzBD+SgmH9FKO4Ax/vvbb1q0VHvIgisYYW/xRugdD05G/r?=
 =?us-ascii?Q?lvthnCwlnkH8BOQQ8xIbEJ7LdtHHr2vSIOd7unDQxPZH+d6nVQQvNH6ewv7X?=
 =?us-ascii?Q?8sIM6erlLfck7WwGinIUaJrVvXuPDoIJw8+UeQM1sDN1rCJyNV0EQOvfEMEG?=
 =?us-ascii?Q?dEIxVXuuB7sg2oGplZfOehzqVjxW5/zaAOVuAo6uGu828zSaNBJy973NNQTN?=
 =?us-ascii?Q?KEGXXfO6IeDSus8gshvVJ7FCJEaSnN8iUGwiifW9UO9/FDnCdqxsVU3uCf2v?=
 =?us-ascii?Q?9Qzv1UhQI3Wf8h8CUgQ6UM0L9W4qMuWO/YhI4AtaS7b/89K+YGBGFVXSditt?=
 =?us-ascii?Q?PVkqdhJKh0OcFwKPQZlOG9t8X5fj8MppnSMRzAVwBfI9vj4zBW7mG3DPik+e?=
 =?us-ascii?Q?s/xRYchaytWinX/uRYf2GYDrkT+SAD91g+DUC0V9nHZ3XTAlLAKbE7ttedV6?=
 =?us-ascii?Q?+aNDWoqCVsoLdPjNI4fsmbRpq33vZcOrbaAVWSQUpXDwlb9kX4hMwuv7H70p?=
 =?us-ascii?Q?/0wmlUUfzwhPb9JM/Nxraauwr2KyuVDEUGet1DzYlba3BrNTFYNqLsl/FDJO?=
 =?us-ascii?Q?8kmaPrCWfFfAi7sDn2ylKjHlKTXjllJMmfeQszI5lMoCEmtCb5ViGLIELMYO?=
 =?us-ascii?Q?Q86sIdp6oTcf/6xbYpTP4UjdUDJset/5zkuLG4YTcWcMxYYPWeb8XDs5K+o7?=
 =?us-ascii?Q?+0OxZkjCrneuEzO6XJSLLefEMpMmwbcTqUJFC0k6bj6m7IwehCGswFJlBADT?=
 =?us-ascii?Q?/9pya4lUukr6GBeV/8K7mgtO5H1W78ayhrPh4N1HiU3Z7rDujSB1Y7myBSQ3?=
 =?us-ascii?Q?0qrt8JN3xlhtYCtdd736YHv7vEqeTNUlsXmaUy1/ZSH+Z+9yztmQuYHA8mwn?=
 =?us-ascii?Q?TCSu94olaogCemXEHuzGT1O1WCAFu7Pc7Rx3BQYo+4Y3zNR3UWcGCurOnuMV?=
 =?us-ascii?Q?Gy7KYCB9N0Q+GXsM7uJD08nxTFLlU7d8grR5UhhJHzq6d+jjHDaMZsU6OMto?=
 =?us-ascii?Q?7J+IwwBKN0m8Ztg5JksrlI3Xby1FrcGl6V2nfKGhN5hXZpZWQZZs/w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(19092799006)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cvT0WZmbT2ufsrxD+DveHO2roW2zfhpQPJZqQSb6uCGE7a5pMGvbWLT41LLN?=
 =?us-ascii?Q?7BtuCq1X0WaH7aQVOMtJR4Fq7v+yBLPeNeME4iUuGY0sdYuWQ0fvjCTLHbkb?=
 =?us-ascii?Q?8RkU7A1VWNv69xj6Q9dEgSUV63UJVr0QTY9dwsOEnzrJyhWPIyY5TAFrkHxp?=
 =?us-ascii?Q?uO9prYmRONDJN0i17nKUb0IhLFNm+6eIzpApDn7K7CfQr42XRh+dpLw/AQt+?=
 =?us-ascii?Q?jzGXxrSGa/hwjlUmdY6rMtPJmKmQsU9L5FtSbtU485I4o/hcj+q2QW0CtwWl?=
 =?us-ascii?Q?hQb6iaMtPulakjN80fmckQjCthOJlTSHaK7mCFTnXQKeb6BsyWYWftaWReAf?=
 =?us-ascii?Q?BkroPXIsBOGFq/QYmtLs6+4MMmbhiUInBMe7S4FOkidmAhAY+/A5j1n+tM5f?=
 =?us-ascii?Q?onbR3DofXKL38q0qDWO398sIdhkMJyVIj2Gv5TfihkkbU4ylMwg3bHYd8Nkg?=
 =?us-ascii?Q?SswDSd2c8N/r6PtgwLA0sxQK3xHhimMf6lPXAKhEYSkx69bSY4rk3/sYXDbY?=
 =?us-ascii?Q?uDm9524Ex/w5wPcoVbdjsEj3nShWU9WJIj6ISMCKC9QkvyQ+p3Dcp8dmbHxx?=
 =?us-ascii?Q?5E3rXc4W7hkIm09bI7Q3vW59GjmnGAVJxfD1cuQxwbhc+lkHML7U595CHfbW?=
 =?us-ascii?Q?5PxpfyXWVB7Bsc7HJJNnAInVJBJh7kMQbHzToi7FOt4hAtZ15PvYxupUzwh/?=
 =?us-ascii?Q?7VcLOisqRfPrcNQWYuLk4LWAS+4kZEzbP/NLmzsrMPamLKIYOaZfA3yu33T+?=
 =?us-ascii?Q?8F1amDYluOfYIAMkZjhixTEzIVUx4Aptk/vLlKHtUliATx0IjYkmttSldkOp?=
 =?us-ascii?Q?GXSjJ31ZhjYzIa+j9OdcHETlhCi/bcqQKPK/p4Nwuor9HtVVfPh5uDFRUz02?=
 =?us-ascii?Q?laqwCzmMWvD4uQPWi+quWxuFnsHumLriUwuSwKwJ8hQNXpIXKETbz9iT3m8i?=
 =?us-ascii?Q?wSJwMcMIjUC/w5KUp8GQ9wd2Ud44EraR5VVmDzShpTqIxIOL3wDHq+0ykhsF?=
 =?us-ascii?Q?mX3X/fVSyN2L1LU9OtERZty51Nz8YW8FquafHiwJxTtJF1XOzmEWaM8LzicB?=
 =?us-ascii?Q?4klQ1DTL6B63pD3V76IZoas47oBkVtiB5OescU+o1525XTlGSHAzMzhuZXkO?=
 =?us-ascii?Q?W75LiV05b2jhUnlrYJn2kMw5P54kJ3F65YXpOksE6A4VDnvRyReEvb1LB4Ph?=
 =?us-ascii?Q?Lg8mqmh60WMSawkN3INk5nZE9bXOM5l3kIMlW5l6fDTjbVrQbzeRVXxPjpcb?=
 =?us-ascii?Q?21zaWj1wltWkjNlkN4ASeC3oUO1Y3aHjCX9aKD366NYGPpTAEJInm93HIQmH?=
 =?us-ascii?Q?BuWBvpnDRhzFLmokTEyC36nBOw/pkk+YofKVssRBSDO4kislwiCT5/6IasmR?=
 =?us-ascii?Q?NqCPZ+jvqe37/mSNRIXbqB0A/d5Z+LYrX+PKt8pozaZsi2aLwu3fzoQujA99?=
 =?us-ascii?Q?yYp39aRNh51NDRnjuoPh6331zzeqe32xOWp6vK42e9Ajw6n5MUW2KzYi1xOr?=
 =?us-ascii?Q?4FYA/C2poUH/NjS8KC+GHQUCPrNrlIi5B1yHrnsP34eRUOUiij8xMCb4fkJ9?=
 =?us-ascii?Q?jghbnb/eckpajpNZa6gl0V6EPNRsTCvk6tdK9Nwo?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a86c8832-0e4c-41c1-5c57-08ddfca9f064
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 03:08:17.0205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oe1ofGJw+NCtXVUqELq/dGAeaSjTHAPZ8EHjYCiYX0L3xXZ8llTmkEP1j88fizxPd3brL3UeWQKSTHg6yfTz/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10733

Hi Chanwoo,

The prevoius dependant patch was already in linux-next.
You can pick up these patches without concerns.

Thanks,
Xu Yang

On Fri, Sep 26, 2025 at 10:53:07AM +0800, Xu Yang wrote:
> PTN5150 is usually used with a Type-C connector, so allow a "connector"
> node to be defined under it.
> 
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> 
> ---
> Changes in v5:
>  - add Acked-by tag
> Changes in v4:
>  - no changes
> Changes in v3:
>  - add Acked-by tag
> Changes in v2:
>  - improve commit message
> ---
>  Documentation/devicetree/bindings/extcon/extcon-ptn5150.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/extcon/extcon-ptn5150.yaml b/Documentation/devicetree/bindings/extcon/extcon-ptn5150.yaml
> index 072b3c0c5fd0..79f88b5f4e5c 100644
> --- a/Documentation/devicetree/bindings/extcon/extcon-ptn5150.yaml
> +++ b/Documentation/devicetree/bindings/extcon/extcon-ptn5150.yaml
> @@ -42,6 +42,9 @@ properties:
>      description:
>        A port node to link the usb controller for the dual role switch.
>  
> +  connector:
> +    $ref: /schemas/connector/usb-connector.yaml#
> +
>  required:
>    - compatible
>    - interrupts
> -- 
> 2.34.1
> 

