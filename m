Return-Path: <linux-kernel+bounces-893621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47978C47FB0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 390DC3BE512
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76373277C9E;
	Mon, 10 Nov 2025 16:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ULh/a6K3"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013049.outbound.protection.outlook.com [52.101.83.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B68C2749CF;
	Mon, 10 Nov 2025 16:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762791233; cv=fail; b=Aj0KjD4qsxgf3yFiJlWWTpj6Z1OI4UY1N5Rs3LTUx+lc5naOnlrGc20uytJK4oNQ5UtMVdrG6E25Eer6jZgv0mak1T18KvS75vR2WiFaAL7lin1eunSo2+l24PY9qiAFEceMIecmbhIvL+ZSjFcS8LOXyOz3UvZmECwbyvtU2Qo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762791233; c=relaxed/simple;
	bh=I1yTmPChJ46xIV4HImX1EFftPP85GzZSdJgv9FNNo1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q2WNjAK/uoe4NrQnEVy4DX29YlDOjzFsoARzIfMCJ3yxBawy1MMxy3IBnl2hw7jtdU6pKVW/WflVBTyVvDjGIdRJyly2TJW1Vr8dqGLka3hpZCv7yhGjsipG7MB5wPuoY/pL1rMOeY7FoZu01Xh9Yzc+wZbWP8J930WYMY/pxc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ULh/a6K3; arc=fail smtp.client-ip=52.101.83.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=da8gJ+h587mBzT5Uz4Hdj8NczgUT/w+ojiVJXIgdr+E/mN5cj0nNA3Wx0BwaIs4McS5JBkzaIOLo7L2X51khqx/yhBLnjfskvBU/bxpLiHC1o+VBFX5lcoZQN/ehJeIm3dc4b2YtdtSALIVxEfoaToOko182SNVmS+nJ0S2tvfVv2cY9scwadHrhf9A8sEKzVrqXCkmAlXpzdig+tHKXdi7LQ2Ku7jNmWtFGeAinA0fctIpbqSZHMrq5MkXn09CY9mVSsMntqQokm3qEsIxglDl5TUqkKRCJbeTwtXWb+KYygJA5KxmvEZrmRsM9rF1Z2NoLGnqCg719p3PDeaY3ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bCZuBz3roU5kHbHxpIJJz4IMxfWkJmuRTI0WYMj8vrQ=;
 b=RFrpEepxEAKUMxiX/N1fKnyQK1GpwVA/nQU8nWjO0k+qJN4wkEZK2JX/BLYAwWY02NliSDVLCY38k2fK7OnYL3dYyplBLCO/Q4lhh+fnF845TK/1/nYxQ3QpcrFnCUn9KCQ8dL0XZ7WcEp6FyNOcQqnVXhheHHggf8muu0/r7J0pJ4YUY5ZiIc2UqqBnvJPNE/ufSc0pVbA/+de+yS762oXp5SO2ehSKt6INliT4TAOia6IMPW5q0mpeFUc/QuqDuYSpzmb9CsLByFVFaX1jCD1BBExZXJdUg1lXv9uSdnI55Cprx44f68fPpqZFFQeigepStPkCNpGjInp/FceNJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bCZuBz3roU5kHbHxpIJJz4IMxfWkJmuRTI0WYMj8vrQ=;
 b=ULh/a6K3O1rhgRIAsfFwp8dtvEbblAH5pt1RdFCLi+YmRJ3gKPJ/f+W/c5Lw0xpEyr0y3U1u0U/D/PXBN/CLGzlWz+BBqDrHrNtlwvNiL3k0dFsja9F1gcVwGY4gVil/WSzMLuUrt6dtYRYlRJYx6cZsHu5GqCifTBsqFhJ+8JgjFUt4eULpOKkFrLEqvhC82h0EsjmwxObo6yyXaYLygwnhueURfapiTaRsBM6FbnSKkGxtGQ/lPCeUru0+83IApk3ZQt64Avhn79qcUPIzk0pV4CtNxNOtihcs/jsNMvhwjg+D3gvw+D3fx4itqyR5WXVQVH9QvhFUwEsSHWoWiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DU4PR04MB10886.eurprd04.prod.outlook.com (2603:10a6:10:580::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 16:12:57 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 16:12:56 +0000
Date: Mon, 10 Nov 2025 11:12:49 -0500
From: Frank Li <Frank.li@nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] ARM: dts: imx: move nand related property under
 nand@0
Message-ID: <aRIPAagk2tzqnoSB@lizhi-Precision-Tower-5810>
References: <20251104-gpmi_dts-v1-0-886865393d0f@nxp.com>
 <20251104-gpmi_dts-v1-3-886865393d0f@nxp.com>
 <20251105115538.GA17091@francesco-nb>
 <aQttQb5GesjUtBw6@lizhi-Precision-Tower-5810>
 <20251107155201.GA119737@francesco-nb>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107155201.GA119737@francesco-nb>
X-ClientProxiedBy: BYAPR02CA0034.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::47) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DU4PR04MB10886:EE_
X-MS-Office365-Filtering-Correlation-Id: 374c3591-61dc-48e6-ac47-08de2074028d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OY6a9tbO4wMRwtk9e1h7zOFr0ZNNbOelxsr+2p4JRsqWZkBTxhEgPKTzgie+?=
 =?us-ascii?Q?H/ju5hPsjcVTUF8iE0A+JEZoe0neyKhZTuwDgnIjp5kPNlPWEfFcmRyEiMKV?=
 =?us-ascii?Q?bIgYvCGJ9CvVBDbQXu0QkljuadonLINMxrakvP9B1Exxvk/Asp77qAAdkaUx?=
 =?us-ascii?Q?DXLbHS7DRkX/2PnFiV9yrHDA1hYlHB9SRNFZGZ2U+4wA1uqxNmKb+EJMvMjN?=
 =?us-ascii?Q?hTF3yFUWZHBWSQ3rqFuoQCOzDBOt0WqzMcnahx89sVb3+uUaQqH8LrswMwt9?=
 =?us-ascii?Q?Ocr9jGLQas57PJyIYpZWy48B8U1EKyiEAK9A2A374xSIEiUs5F4jgU8X+miQ?=
 =?us-ascii?Q?GQKy2yBQrXqqBEl4GBWU7Pfqya0TQomSa5fUFM4b9zuK6o9Mv0D2BWDfiZBc?=
 =?us-ascii?Q?MCOsX5PrRw/t0g71jD3LCzUStryY9VpHJFJcCw2i2soImK9V/zlgzO4QX+Ry?=
 =?us-ascii?Q?nqiyOXGWZM2hV/3MfTTNFdIQbHCEHVgwPj/0+Pzt3XKpJoD4bEcl2GycpFEn?=
 =?us-ascii?Q?QCW4E0GrTJfXzTae5yE7nsUEvo/QliepCHXP7AfVrVmuHx0W2LlBYtRkxxzd?=
 =?us-ascii?Q?N1WDN9reGS1bPd6GKhkm5QGldaUfsTqQrOdSMV8MVnx+h4c3HjxBsAUWj9Nr?=
 =?us-ascii?Q?tn+KijfuOuVFqkiRfqdoJrb/jQBuQ3WvWee3LgZl5oickjKCXPkv5XA96xRs?=
 =?us-ascii?Q?NAReofg6o2KQmi82l5ywICgWvTh9n0EthNUT9IHIG9m7f4N9i9XzJMKOITUe?=
 =?us-ascii?Q?oApETrxWn1/0fPFyVOqQBgN0xj5+iGwjn0xLqxFO1UKnvhQR9Pl9xm6PPEIp?=
 =?us-ascii?Q?c/YfBmU56pnrO6LUmmwBlfTcdJZT2oJzVI3f1U0jc3M8mdWLJCdCoAHFUwzk?=
 =?us-ascii?Q?DejJC3Lc+LVYww/SsVtATsBW38hm8ufVCdUt+BmBmuUHhL3h2zSROxA/eoFT?=
 =?us-ascii?Q?+DcopS1KgkRdCpsUQSXOD/EIIQn1lWtsuBsDHsqsPbhEiVIBc4B/XBvOUk5f?=
 =?us-ascii?Q?72OyNg3zKvNdB1sJ6eN53POzktQp6FzNKCbvrQqUPl/41K+6YUiSw6GNUeo4?=
 =?us-ascii?Q?7cKUn+4+AogUdCMyX+YkxNVWH6DRNhmtEQjV1uVHaxGiF0vI1c2UmkjLf4Nr?=
 =?us-ascii?Q?O/mizzZhUvNf/m+nApSgNAlpSK3do3O+Fbv/JPWN+hHU41Ar+VqnuMIAzVwe?=
 =?us-ascii?Q?0TAHsqnO8WZa47KlkAoXk660ULcAGwRHTz15tHioQs40Liipu6RBNpVuUQ7O?=
 =?us-ascii?Q?zpceeX3EIsbe7yJ/zW1kWavGitXQrUUuSMcs5i9YV2PU9tedylTBqnERb0gC?=
 =?us-ascii?Q?nUdSn1Nm/S94Z+CDC6/c/OH1htmoWEng2kRo/yosh2BKtZLnS4gcWHBdheYH?=
 =?us-ascii?Q?nNwZ4DXyvctfmxO8waM5AZ/9BLfxaZXracgZSQpjIxIHUpTRzkkgFV+pLPDp?=
 =?us-ascii?Q?Tbt17+czupWWdIXc8IaPUq5hrNmZLwfe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mkMoA0Chp1PKBdF9SDEWKXFN/1bcTT/4ihkreHEfSY9s9NlDvJduFUjgPtzj?=
 =?us-ascii?Q?MSmrz7zGGagpB6+4H1UVVQtJK5/9dfBh4kDdRnXSp/6o12+9GrFS9OcV0oEL?=
 =?us-ascii?Q?u+Iej6Lw71yHIf80pg0PuN3zcb5crb0aNe6O6FDYBsCYtP83n7VoA4IYZmDE?=
 =?us-ascii?Q?fwL5/5VKrEe2QGblJ1ckzYJErzsPc0X9c92al2TBXH+ccno4oxSskxFaVDA0?=
 =?us-ascii?Q?fvum2lIA8dbHYRqzOtNRAdXBRIMLHpfrOiyriChmY/fVz9j/agqGDk5ZrkRs?=
 =?us-ascii?Q?B2MrLtObqH+1s7wsF9swZeXBcJ8EUBMGjPNSlLOLpxAuYDiCyTKCPPH6S0wX?=
 =?us-ascii?Q?P+DWIgGYbpYNanfMcdURgQTt2SQx1gIuWzu8gaMlOsJIbcCyoDYAU5aTPqHa?=
 =?us-ascii?Q?UeRuFRpxsyezrta3WOnTWbwph2+0tQKwh95G/yTBiRX56NwlnlrsS4pjmei8?=
 =?us-ascii?Q?0itea6ElVMBCWtw6nFAcNS+RtjexjAzed4DYUbZ8s6ej5QX6slLsfKq0mzuq?=
 =?us-ascii?Q?U0UQGjFEHDcwUJq4pue7pq5Y3h3+EFcmcq71Y3gJQFpOpgep09UUO5sDQa/A?=
 =?us-ascii?Q?22Ne5LrSAJi5quBPSHvQ8pxaRXx8qbjKoZcYx/DP3Txue8B60HTqJqzGUiOo?=
 =?us-ascii?Q?gncTGKkA9YBIyMp9Y68vhauDm1ErjAgBVzlw8qopHPr0K2nb8pIJSVtO4HhX?=
 =?us-ascii?Q?b2VaXC5rVHbr9qEy0ncdBd/I/nxiZ3Cp+ahJf9pc+UywTivWsjFzIc3koW4w?=
 =?us-ascii?Q?Q6htS+UTKTX85xBFiCLenWH9AC+mMIYVOunJ+vxsB7e+WQEKA9CRM6Vbfbkd?=
 =?us-ascii?Q?EdP9l2/n3hgfLS/aAx9K4n/1GeotXrxoAkBzV0Q7m2fs6SqKsMfPkkH6Nl/z?=
 =?us-ascii?Q?1Z3QLX7NSw60M9GCcdIWqXbz6t33Ehnfjz55ph7xgMhYQSmqjxNTe2NaLegw?=
 =?us-ascii?Q?djdGqWd9QN4SywwxIzMjv8o0oJEER/cm9tPSoM8QONa0oTuROtLtT7IG/k2A?=
 =?us-ascii?Q?AHBLahPYie4STtEspWaGvPdI9AYhmh4d8lkvTozY6BW75SXIDxOQrT21VMHt?=
 =?us-ascii?Q?bKW9JkN4/YFnBGCWFZVZCAtCRpXIi1IYFYukEI4SQu0FvaDQPI288+HkwW2L?=
 =?us-ascii?Q?jxWqdsP1jVEGjwUlqe+gwBECih2AG+7CTToRqEvN915JQH7O21DpZau/CeaT?=
 =?us-ascii?Q?OY/Ll+487dpc0PSuUklVEEBiG1lBPfkcXdIbM0sYE7yY3jRXjG0BYDwX9CLm?=
 =?us-ascii?Q?5ypJv7Zllo/r5BdAQT6qZpJuG5wCZMGJLY+BIi2sXWfs4Of9W+YjUUe8iK4P?=
 =?us-ascii?Q?31cvmZU+9nQuOlxZfmXP22g+9ziGWGKCGcar/UyfX04cH+AauZpFshXljEkT?=
 =?us-ascii?Q?QMfKISSbPREGcejs/YImaOvoCaFcWCFci0VSB7KMjiJWG6bHDtMjPg5Pi3Zg?=
 =?us-ascii?Q?InaFNrf4meC925xhinlIxQ5X5qrVI1JgId7MTeGQpBThNm1ouS5SXOBGkCmo?=
 =?us-ascii?Q?cBkZQKVJ/cNtfEUm1B/FhpmppLjQKYb1nGW5F9FqTV5tluUSnG1qcOIVPLbw?=
 =?us-ascii?Q?I7FCf46W5dsFKPVcwyU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 374c3591-61dc-48e6-ac47-08de2074028d
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 16:12:56.6298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +B40LqbkEYhnKZmn6g3P3wYYDV2ukyuu21IMAsdmoHI7VjQ2yZgu/D/I2KTbPCsrlt46GXCxVdIJ9TlybwV95Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10886

On Fri, Nov 07, 2025 at 04:52:01PM +0100, Francesco Dolcini wrote:
> Hello Frank,
>
> On Wed, Nov 05, 2025 at 10:29:05AM -0500, Frank Li wrote:
> > On Wed, Nov 05, 2025 at 12:55:38PM +0100, Francesco Dolcini wrote:
> > > On Tue, Nov 04, 2025 at 05:27:14PM -0500, Frank Li wrote:
> > > > Add child node nand@0 and move NAND related property under it to align
> > > > modern nand-controller.yaml.
> > > >
> > > > Fix below CHECK_DTBS warnings:
> > > >   arch/arm/boot/dts/nxp/imx/imx6ull-colibri-aster.dtb: nand-controller@1806000 (fsl,imx6q-gpmi-nand): Unevaluated properties are not allowed ('nand-ecc-mode', 'nand-ecc-step-size', 'nand-ecc-strength', 'nand-on-flash-bbt' were unexpected)
> > > >         from schema $id: http://devicetree.org/schemas/mtd/gpmi-nand.yaml#
> > > >
> > > > Since 2019 year, commit
> > > > (212e496935929 dt-bindings: mtd: Add YAML schemas for the generic NAND options)
> > > > NAND related property is preferred located under nand@<n> even though only
> > > > one NAND chip supported.
> > > >
> > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > ---
> > > >  arch/arm/boot/dts/nxp/imx/imx6-logicpd-som.dtsi           |  6 +++++-
> > > >  arch/arm/boot/dts/nxp/imx/imx6qdl-icore.dtsi              |  6 +++++-
> > > >  arch/arm/boot/dts/nxp/imx/imx6qdl-phytec-pfla02.dtsi      |  6 +++++-
> > > >  arch/arm/boot/dts/nxp/imx/imx6qdl-phytec-phycore-som.dtsi |  6 +++++-
> > > >  arch/arm/boot/dts/nxp/imx/imx6qdl-skov-cpu.dtsi           |  6 +++++-
> > > >  arch/arm/boot/dts/nxp/imx/imx6qdl-tx6.dtsi                |  6 +++++-
> > > >  arch/arm/boot/dts/nxp/imx/imx6ul-geam.dts                 |  6 +++++-
> > > >  arch/arm/boot/dts/nxp/imx/imx6ul-isiot.dtsi               |  6 +++++-
> > > >  arch/arm/boot/dts/nxp/imx/imx6ul-phytec-phycore-som.dtsi  |  6 +++++-
> > > >  arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul.dtsi               |  6 +++++-
> > > >  arch/arm/boot/dts/nxp/imx/imx6ull-colibri.dtsi            | 12 ++++++++----
> > > >  arch/arm/boot/dts/nxp/imx/imx6ull-engicam-microgea.dtsi   | 12 ++++++++----
> > > >  arch/arm/boot/dts/nxp/imx/imx6ull-myir-mys-6ulx.dtsi      |  6 +++++-
> > > >  arch/arm/boot/dts/nxp/imx/imx6ulz-bsh-smm-m2.dts          |  6 +++++-
> > > >  arch/arm/boot/dts/nxp/imx/imx7-colibri.dtsi               |  8 ++++++--
> > > >  15 files changed, 82 insertions(+), 22 deletions(-)
> > > >
> > >
> > > Was any of these changes tested? Is the driver able to cope with the
> > > binding change?
> >
> > I have not board to do direct test. This format is used at imx8 platform,
> > which use the same gpmi driver.
> >
> > This properties are parsed at mtd common part
> > drivers/mtd/nand/raw/nand_base.c
> >
> > If you have one of above board to test it, it will be appericated.
>
> I did a minimal boot test, on colibri-imx6ull, and the board was booting
> fine, with Linux 6.18.0-rc4 and this patch applied.
>
> I am wondering if there is any impact with the bootloader, this DT is
> used as it is also in U-Boot, and there the NAND driver is for sure
> different. Any comment on this? I was not able to test this combination.

Uboot should have theirself tree, which copy dts and not direct use it.
I worry uboot parser kernel's dtb to do some hot fix for specific boards.
But most likely not related these proptetry, maybe just add partitions.

Frank
>
> Francesco
>
>

