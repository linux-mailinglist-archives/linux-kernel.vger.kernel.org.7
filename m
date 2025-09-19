Return-Path: <linux-kernel+bounces-824927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6504B8A7CF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 18:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6240B5A1782
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 16:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA6C31E0ED;
	Fri, 19 Sep 2025 16:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jzmW/36P"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013007.outbound.protection.outlook.com [52.101.83.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEB5244669;
	Fri, 19 Sep 2025 16:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758297835; cv=fail; b=Mo1AtLpajV6CEfRv79UZeFj1XK0VDQ3FMlxj9FEoU3TFThxuIwwq2xqHXL9Sd/4JQUVBxv2GtP5WkpX/USUdb8yqsW/yuQUUEAI+ZbYJsOjmVwcX7r7l/tgE2bEq4bqtea6xCtTxLHXWfgqT+Cfjyzun/2v1F7IMfAF5Ks4Z7eQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758297835; c=relaxed/simple;
	bh=que4LSyDnRvPka/qKiCWBXw+WsDJnuiHHSYvTwgP184=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UuTRpcaiuR8GED0rbYBXjutFqLNIXplZmN8ORvIMqXknWV/WLwGfDzD1gIltb/s+K8teA7UweGvD0zUnUgjcc6EozaBCB9pTczCoT7Sa6PAW8WLGq5bDp8f5H2qw5VepzZs7b4kvgRKKUco9xef9POTqW44aJCXDi3WzCP6TAi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jzmW/36P; arc=fail smtp.client-ip=52.101.83.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gb2bfBwh7WuBTDvy9o4t5AVYd6GCmv9lXGOxfTua3C6rSs+5jECbHvlkM8UFkaI24njtaTJEO3RoOm8XNKwPBj8ZjEXCjEocruRCEpwCcr9j3IITrWbpkcx8x0ImSOgxveR4aRCqOgjSfB72ObNNnsfKRrHL1NcJ+zTNTeu78ZNAVaAriAg6XSIJIGc0F5C4IBAPEB8vb+DS16Zc+GVql2mkK891K84JV00js38J7JY6tS5uMX6ioIsFXcPAaZ5vFqsv5BoYIuthbCmxOANOl8iqWvnKE3nGudIeqygtgstgEjKPt+w5x6cEgxulKlxhoGlkzr78NGHJNAyqR0e+FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UplXxKgsPGwsQ+tYuGNhlT26MtEoSfLB7PXO/aolmGc=;
 b=Zu2jH7lXCAuyLyLKNY6Mm4xxInzPtKe6M6u7WTGJV2y/BYzbQi+kSpoFQIDZWCU94FSLKKpyY6v3k1wKsS42c2huYxRvSus9ZS+6uZLfXjsjpwArqtIgIkTgsjdS4s95w5e7kwmmPQaOPTr96hggi3Sh7SlXgfJfNvE1X40pS91YUjd4FH9WKfP10iL6ZqnDADGLepUDUk1Z50MeQlCBhrmPiXfTJfMfGVXDZ0KDlTi6S4bmEIywraCXYKK4y8dxxPbRXFr/QrPSFEk8hJ1Tg6DHlpJR0NChxNuBhyNypSGcxApJv9gUHpxGIGfgfAXcoEzABnL7WXhDk63vFVgY6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UplXxKgsPGwsQ+tYuGNhlT26MtEoSfLB7PXO/aolmGc=;
 b=jzmW/36Pwamvr7EjGDDHK4QBqwDq4WVcsmbIN2UY31BbRYaEsZV7sQ3gPa0mSHWn7M1bLPljE3j3q5hfuFyUkndUMic51TQkX3uPrytWTs5XXBAv9ee4Dwi3SavI3y2uGl3G0Is12Xsx2LF7x/WmWA28nWEfWpgkmlC58BbXon3pAnp86A/uAfbmN1e5HbnunlGH9cAyMic4OBa4Z4WjKyxhcm2p7dA7UqaBdBtoLcg4ZjmwwsXaceNiLd7JNMquCLiaLS/JEvMf8scdC+XkwK7Kwl3B9PYlLvZiAHxxtxATlF5TsO9GEo8zmhEynJzUi3OhNB+tvgKih2su6VoANA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AM7PR04MB6872.eurprd04.prod.outlook.com (2603:10a6:20b:106::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Fri, 19 Sep
 2025 16:03:50 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9137.015; Fri, 19 Sep 2025
 16:03:50 +0000
Date: Fri, 19 Sep 2025 12:03:41 -0400
From: Frank Li <Frank.li@nxp.com>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: gregkh@linuxfoundation.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, jun.li@nxp.com,
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: usb: dwc3-imx8mp: dma-range is required
 only for imx8mp
Message-ID: <aM1+3WMeFln6pHwF@lizhi-Precision-Tower-5810>
References: <20250919062534.2443959-1-xu.yang_2@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919062534.2443959-1-xu.yang_2@nxp.com>
X-ClientProxiedBy: SJ0PR13CA0109.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::24) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AM7PR04MB6872:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d4a60b3-96de-4590-1695-08ddf7961f54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|1800799024|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?irO4PXKXLFcgUymET4mFASCzirQ167BO5csYe02q0tmijyTeztr0kOAGlHhw?=
 =?us-ascii?Q?zOiqzm2vEKabwNEcEfYoqa9Cy/JGz0uMA4HUKeCHemVmkCE1mQR5eEf/sDsm?=
 =?us-ascii?Q?sa99U0nb2tJWjrM47TXVAh0yCXu3LBAIQCWv4sd/YKhqC+PTj6eOOiQM8ZQm?=
 =?us-ascii?Q?wmyrx9HbQlRyYpyVzqkxL+Brp8PD2c1zVFW1yLvHufxXUV8J1vwh0JEoBKQR?=
 =?us-ascii?Q?vN/WDC68ZzDZg45McJ6+6Ws+qo4KzULeWEk3Q6Q/p4RG4aw5w8do/WvSTqs1?=
 =?us-ascii?Q?9P6dCicB8iKiAKjvWaIHvMZ8jAKevJ8Njyr+oXBrMJZphvejCecNAscMFB4M?=
 =?us-ascii?Q?AtzbFT1aVpoYv0HjxgKLBYw9LMZJ4rFEpbkG/wyxL4De9Yusriv6C6agD+Qk?=
 =?us-ascii?Q?gtkPdLdlpGju4gEswjRy7Kav5TyFaOFVbyi8znCyd3v8UPCb/x6TAsQAzgOp?=
 =?us-ascii?Q?TP/m89446O635BGDJa9lPN/q7mXvNIwtXAajM/DRr3JKYDgMi4HTCx+WWrH4?=
 =?us-ascii?Q?EzLxq3I/IR79jHm7EHKm5/ebb+77Wm3a8pnoi2kp0n/ZHyFmLi+1jZa+5ETT?=
 =?us-ascii?Q?tQzgySV5BYYt7u/sdUYlreymWgI87e4vt0WEoK2nKxBeu6lwzZhZ+VCXT8Qe?=
 =?us-ascii?Q?IaUBB6sHtKQ/un1bgOa3OLbYXz6Yw4xOzuTzwrkL74yyWFxaB+enQdP7kKX0?=
 =?us-ascii?Q?xR4zkPoG97bIjYfwN8lXIeS0vfWkcJEgFXs6F7gzzsSblKJaeaOrcmdR0wrl?=
 =?us-ascii?Q?4/bMNghF/4Ia0SpkYmqxA3V+y/U3fS2QOn9mwHGt078xJI/SCRd/9t4ZjN9s?=
 =?us-ascii?Q?/2KrlatQLSyLk4hMbDwwAWF3bAKvPYTRR+RzcS8yIaZr6plKeeuHIG+PvHII?=
 =?us-ascii?Q?wI8riiWq3toR+alRjgCqKKryBu2xde2E+t8JgjYTnlvQ/Fkw1+kFP70bsObm?=
 =?us-ascii?Q?KPxlCBi0+yB8579KOJW8Tot2v2PuLh3lNfSo+gGXJrXjLzvNAb6D9/cCjZPg?=
 =?us-ascii?Q?b/SPVfFsvSqS8VQBV8eWNQniRojb5DRiho1nv90wyRvnzw8oLM7GHsOpEB7l?=
 =?us-ascii?Q?kwfNqVW2MyhLIOmL32UreV7/QSrL84lB3pnaqczEx2J1CG4VxiBMy74su/7L?=
 =?us-ascii?Q?kf9SPVDmFN5nKnTt8bkX5WOax51KcWrQj8KeoWZgwRMGzpkMzWHOf9ln8Vf1?=
 =?us-ascii?Q?crEULgePdqlgKhCb7R8zYb6YdgYEWhum1dOFiQUIThbcAS9XfAzDyd2js1IH?=
 =?us-ascii?Q?bTIYSvHZIZ+zTrMbQsL5YwXATVvnA6NUlPz9PGlPuaA+qprRwrCTzzRLI3xW?=
 =?us-ascii?Q?lH5MTSewt5rsuRpNp7+ycEUwwZix32P0l4JqUQtb+7O/iUzzE18iVGSOErgZ?=
 =?us-ascii?Q?vIZ7B6vp79nC8y7TjVNQ8xgxJ1Zx9mreQ66pubJ8f63k6cO7Ybm10NxXMJkS?=
 =?us-ascii?Q?zZHpk6ufhNvY9sYoJCJTcxtixf3HEWhDkqTeSpkISy4KvausR2xDIA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(1800799024)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lnLxlh8o0OYvwR0jYWh+vZaXRQlYP7NvxPEQk8RyzT0fOZZIs4DlqFMB4NoP?=
 =?us-ascii?Q?TCl6/utz69We0HD3iMJwtutQxAQLaX2y5nxwYn8GbprTpj0b4pXN4w06dkr4?=
 =?us-ascii?Q?Eopm0j1z8GFNmNa4Sx9OBcne8f+UsJpwPYuuWtiTXhabmbC7B674ChQESDDy?=
 =?us-ascii?Q?wBH+k2t2NBEck0awuFFgcfG0xTL5PqHMmyYPYwrKbINgmzYmD22RCsnJfT1G?=
 =?us-ascii?Q?f06ITE7XGGxFjTvYEauYJScrsgLjnuEO8NgA4RmJpw5rHGSRUx2IQHM8PQfJ?=
 =?us-ascii?Q?skcel8hlS+uAkRhlWFtmnAFcleIjbxHZGvckeEz3menp/tuDnd+A53XONErp?=
 =?us-ascii?Q?kr93xBVajtAcSOpSE7f0It6GqBySCIFoA6uHABeTGSLk19njVw6y20+IMhQ+?=
 =?us-ascii?Q?eNsSDpkFeA/oDeHWaqceNogG/QUbdyCvqOyWWrboG/UaA9AHR1Beu0sDQD5Q?=
 =?us-ascii?Q?AHZfgP77uywCG4FzI0i/RrGLWoPKAQVH+4uZLs/oQGG6RVMTlW7y6DXO6O30?=
 =?us-ascii?Q?wdv0xB4Wuu8x/Z9uVRMekgdHg46VgG1qM/Whh4Ys4uUf3Nd9khIZaFXuXXqB?=
 =?us-ascii?Q?/sOtZ6ANwOcjMs/zQJPrfiJ8IU8Fr24fuHb8L8MlVhW4i8Yny0POjV4nAlff?=
 =?us-ascii?Q?mMR9OKQzDhfMIb3rpfA2DmBSH/uS2Dfpi5S9Q7YYnkYJF01pdchaXxjsfgRj?=
 =?us-ascii?Q?CPEyXvky2jvrBao9L9CH3LNgFofH1wpBEAlkdh3LH0ezqAZ2xiOWOOdCfNg9?=
 =?us-ascii?Q?puaSOUzXe6ccMZ9SBmf2b4dGlfh4SaqYFMsdaqozUBLU5edqSPoARoyN9qRE?=
 =?us-ascii?Q?HNXYpaOWTdmxtVNNROeWdID4ziMNDdmgOskJneuJZetac9IcW0Nvr3kXWRg0?=
 =?us-ascii?Q?8Ff0Wa2H9+zuDpOsqk0XSs5BGVx2iLO/U5fTk+6qHUXivh0ASN55XcISvj+h?=
 =?us-ascii?Q?PgNlCNmN6Q0fMbPZAVRFwmrqI0HtRFWo+knVMxdcjGbBrZgOnQ5H5BtOA/OK?=
 =?us-ascii?Q?M4ynwJmkjmqRfk47XSVKZVeFqsyCzdrWeH0trcggpcxa6hlwyIjXngltQNs0?=
 =?us-ascii?Q?4AxpXUxQ5XlWO2ndxmRJXeW2y7NBYMlBp5FZJtb7SCjz9IVrceK/RbmI73Vd?=
 =?us-ascii?Q?uSEOQCjF2+GKjdD+0c7wc8bChgNZLpI0LtD8SlieN+2wvgPOUe8f6w2Kj+pH?=
 =?us-ascii?Q?eafLBzOsgvbUY+EsSXOj70/opBWdxY0GCK9MGkn0FIEUG5JaA1Q4guZ7MVyS?=
 =?us-ascii?Q?8lkACSGTXjGTGNVHOj+XwBQtUXScD3vS3h5nXu9ydX4VJQmsVZ4Iy4KScLBf?=
 =?us-ascii?Q?jlPNMFh7VdZY9GxekO7K83IXEJGXZbhvFmX/PcghEgw3JuvTYuEIeG6tC5sE?=
 =?us-ascii?Q?Nq91HKlIjWfqsBJHRI5ZifchyYJ23h+8CnYAp7F54sc/0T8aa8R/b/yPhuqW?=
 =?us-ascii?Q?/wBjbbmRlgg0R2rDZnfQaDrGP+LujB0HT779xxKw5muIrtW3v36HyPP26R4G?=
 =?us-ascii?Q?sCPdfvoozcWSmHexVIqnT8GO6rJx/mlpYiIL3qxk3dazqa7iYnDM8c4Fqdaj?=
 =?us-ascii?Q?3j2HnX7zQ0P2YJ44vP6ymLnppu63aNTfDPuGTJV9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d4a60b3-96de-4590-1695-08ddf7961f54
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 16:03:50.0046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bUGFjONFTSmcxHW2mZ5Y5PC2kVEEsVKzbEvR+gq1TyG+FlwZYcZaDZE4HHqW/T3L1Uh/TBtf5D8CNdT+TnjVTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6872

On Fri, Sep 19, 2025 at 02:25:34PM +0800, Xu Yang wrote:
> Only i.MX8MP need dma-range property to let USB controller work properly.

"dma-ranges"

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Remove dma-range from required list and add limitation for imx8mp.
>
> Fixes: d2a704e29711 ("dt-bindings: usb: dwc3-imx8mp: add imx8mp dwc3 glue bindings")
> Reviewed-by: Jun Li <jun.li@nxp.com>
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> ---
>  .../devicetree/bindings/usb/fsl,imx8mp-dwc3.yaml       | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/usb/fsl,imx8mp-dwc3.yaml b/Documentation/devicetree/bindings/usb/fsl,imx8mp-dwc3.yaml
> index baf130669c38..73e7a60a0060 100644
> --- a/Documentation/devicetree/bindings/usb/fsl,imx8mp-dwc3.yaml
> +++ b/Documentation/devicetree/bindings/usb/fsl,imx8mp-dwc3.yaml
> @@ -89,13 +89,21 @@ required:
>    - reg
>    - "#address-cells"
>    - "#size-cells"
> -  - dma-ranges
>    - ranges
>    - clocks
>    - clock-names
>    - interrupts
>    - power-domains
>
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          const: fsl,imx8mp-dwc3
> +    then:
> +      required:
> +        - dma-ranges
> +
>  additionalProperties: false
>
>  examples:
> --
> 2.34.1
>

