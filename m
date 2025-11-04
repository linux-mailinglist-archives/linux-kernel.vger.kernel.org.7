Return-Path: <linux-kernel+bounces-885389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8326EC32C50
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 20:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CAB6427567
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 19:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7182D8395;
	Tue,  4 Nov 2025 19:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JdxpvGGE"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012054.outbound.protection.outlook.com [52.101.66.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C1C2D47F6;
	Tue,  4 Nov 2025 19:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762284358; cv=fail; b=nE6SG3GZCEV/l9HCU26/R0yrsedHbauIn/dDlL9A8l0hRrzKUrhQS/rkL+Nn7tB1+ChemwZqF05rDOP2R7iSc77yqVVuMnkJljAo11H8CUrDd4KwlqgLFmsLfIf4YWmTI7gzpL4Y0DAVXHkRFDRoAw+XTpVA+HJDZbN9dH7ePis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762284358; c=relaxed/simple;
	bh=r7dMJ4KiIG8WbBKzx2b0spn+aRvmqB+E8+Xi7UcqQCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qEYxo9z2kkCQVwXQmi+Isbq8ipSFjRhqrwAqcPCPO+VYq1t6EDrv3FUGamQ3Cgm/nEn863kvOZgDwgnc3HzxLuUgAUvgktptEd3ADONBfYfmQwO4yUtDwSbVTFUmijIvyFDWrdJfCSWJF3QFPsqeOYovuSE1OY3/SFsvMoSaTOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JdxpvGGE; arc=fail smtp.client-ip=52.101.66.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g6gaH5xLH/iFtse4SQcoLzv1B/pN2Z6VzYF/M/TCh5XE30DWQidOkkPzbIcF8YhugvRd9du1wCgqTKNvuwLhnuWOKb61LRbj7cqilntph3SNLc+C18hC++sfH5ZYgfwBJR3XcOnkQVMAuTM0i+T/Ywa+PLKynks6qbP0ipG7R5vL/NflqnOTDioEeP/nxAkNqrAM4o7gqiZzJ4/epNq17NpybDIpukbkpeQ5/ar0qq/3BvXYI6dEqJXeDkflVoWyd6SWCxXXN3QcUKyK3JqaM2Y0JKn3P6Fi3AGVp61Avtdy9xLPq+KfssDDHw+U5XOdSlK7EvjsP6RCozbQEGknsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D+f3pVL9I7pB6FVetVM9PgPqiHVa365z6jfwwLwTlFM=;
 b=eOjVFk/vA4YTCxb3yrdbT8fp7CbmlFQA2I1u4l51gGK5ilRDkj99KBGV52Pa6Mc5OE3vMTHRDaXdwHjjsOMyykdhp2OW0RfawjsID5WGir1K8aPnHd0bHNKk0gPieHsuT8o+MEdpjrOGhw4vj1QQs5yFDhF6cOyKmBZ6xNXqNlsR2LvAuyzR3ZstV3Iw2HGoyb1y9WDFRiv31ONoUyJlS+uoQnQ+9YfEgOEdUyK5+0gtTq5Dw81+fUaq72Gb/6TYKyv3E44qpmLqt5yigrCBLeI9p80w8Dmo7cXVYO9zmON8oPn1Mc6XvmOF6CFVFp+PehCcWLcVfQGuSchn0S/y/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+f3pVL9I7pB6FVetVM9PgPqiHVa365z6jfwwLwTlFM=;
 b=JdxpvGGELP1M/sNYt6Lbj2OXd+xMqdTFvfkOGWLWoVQqHqA/TEdNBSKO948BDTn8qeGoTC9hijp6seXGvqpJ8F97eoqMmjMnN6KJLHcXqPVVjNLzbqA+BiPDwc8nfa8OOuQ4Rr0bUYSRCnxD96UBJSsOHbHCmzRsRpYbd5qhlCPPqOSouX2VxLkHZDISg8ZrWCt3KN+0q6iW2MQN64bnbh1iRmoNYxRFTjOzZNrYVaF5saYbrMe/I8ZQAblWrq6XGck9BuAYczRjhaGM6deECjPIWWdQU5qBoK1kjUa510ckATDQpZhqB46TmYTvV6830+iTHW+MvongPYON16PgkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by GVXPR04MB10684.eurprd04.prod.outlook.com (2603:10a6:150:218::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 19:25:52 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 19:25:52 +0000
Date: Tue, 4 Nov 2025 14:25:45 -0500
From: Frank Li <Frank.li@nxp.com>
To: adrianhoyin.ng@altera.com
Cc: alexandre.belloni@bootlin.com, wsa+renesas@sang-engineering.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	dinguyen@kernel.org, linux-i3c@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: i3c: Add snps,dev-nack-retry-cnt
 property to Synopsys I3C master
Message-ID: <aQpTOXIPzHI5q7Y7@lizhi-Precision-Tower-5810>
References: <cover.1762245890.git.adrianhoyin.ng@altera.com>
 <9c16c22f67858e24fe7c3a7184537cb5c2c1a85c.1762245890.git.adrianhoyin.ng@altera.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c16c22f67858e24fe7c3a7184537cb5c2c1a85c.1762245890.git.adrianhoyin.ng@altera.com>
X-ClientProxiedBy: PH8P221CA0064.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:349::16) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|GVXPR04MB10684:EE_
X-MS-Office365-Filtering-Correlation-Id: b249f347-ef16-4762-15ec-08de1bd7f78d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|52116014|376014|366016|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xHBd1KFUCNM2+EAtiV/VeHWdL/SyBIUDXjp6Eh5scQN9vtDItYPgERGCeoWY?=
 =?us-ascii?Q?IT2r0Nnqgv32+rtOdcaqeAJOAh0iIAp8BbZn2fRPSTs3Wf4kcaP/VQg3Qp/H?=
 =?us-ascii?Q?aO2NsdVokVh/xOp6uFfUU62zZ14xRzL4/leCF8HQT5QVOCqeCFujzzB17YeP?=
 =?us-ascii?Q?uiaYX4CFaK5P9PBVCO53JtFLNGMjWlL3W9gbEcxtSY1fzY/ZPKj/2YC7mK2t?=
 =?us-ascii?Q?aoI0c+Cxf1bgVuPdP+/kTeakprrk4qUq/sTeS3hmdGgqlINn1WrVkUV8A+R4?=
 =?us-ascii?Q?by6FjNyZtykouSHDgALFUBC83o8gDDl0tnoueDqBBcnHwDmtB+iHJSUZLqA1?=
 =?us-ascii?Q?YM8GAUVEPxjVIpASDdx1bESW6u8oilKPuuv8TW7c1Dwy64qddvJZmDNLuqdj?=
 =?us-ascii?Q?k50w5hLVmG99tSchpoy72Icdu4xNwNDAJC1AUb9sKMKHdhNJYD/p6uNTs66j?=
 =?us-ascii?Q?aN7OKHqqeNePLe1uRP3rp9+PkUeeg04m43WQomAzNM/+iKeaCMf74d3hVbKC?=
 =?us-ascii?Q?lsvNPKFGH7RRonVxh3HsSHLcqEk1sYZ99TYS4DcewTp+eEBAr+Z2m/Mxf7a9?=
 =?us-ascii?Q?Kp8FSdeqbGY3eFKjaOycT4TmxDBkBCxsMlEvBiKYw1+Xo9cwyK2UgsRUiCYU?=
 =?us-ascii?Q?mUE0JDwYGCL+ejVwWULfVA1fqBdifcMJbHatULGL3vR9WYX8WXgkjJK6H/e9?=
 =?us-ascii?Q?p2nbJjRoQCnlRsfp0SDsOQ9HwdxKwfb4bI/j6gkd/C7bZa5k485BqpNo9ZOG?=
 =?us-ascii?Q?VTNC8Uapu+itjTd/3RFQv1A7Hf01FHRJj2DkF1ebbiFy9UZHNWr2w4z5SgKs?=
 =?us-ascii?Q?kShd5tiHknRv/1ktPH3FA8ADIRuxSDoKhrhroOFERu3khbx7Swrx3Ia8nb20?=
 =?us-ascii?Q?g5z5VyZPLqDMLTy34ZVfFsEtmXf69g9khIv0HzpKt/vHQxfdVWlzcMfHHHVZ?=
 =?us-ascii?Q?qom82N1vdK8frpPAWMDf0jnQcx0+sNuGeanxHpOpQkHMUksEHfgHIOwmU/Lz?=
 =?us-ascii?Q?YTXyt8VbcsBeGP5EvfreLSuV8QLr3gpTsddoDyTgSKpgT2dI9yglHwAma0Yc?=
 =?us-ascii?Q?uzEdqgAN7fm+LsAF0erJ/oNjieoJxS0uWKJ7FaubJl9iShHvJDPwJRcFYqo6?=
 =?us-ascii?Q?G+YC0dQGC6vVrqch/vSo8/sXHGjg5Tpmux9vMgx0uOtM4mHNEyuSw0Xq9X3a?=
 =?us-ascii?Q?0UxAmCxUMxiQUBxu2RT+f1W8gLMa0bIRBnFCleitpDeXbk+W8uefsI0jbIey?=
 =?us-ascii?Q?MsGPWnZaRSw7MtLHuha7ffAXUMXXue1cEymcFykC895aykGtoJjx84OOxqw7?=
 =?us-ascii?Q?r7O9pYgse8aQDC+yVsZ2wfKsTRsidFdtKeQXLuLGVusECGoHPdshaRXMxEjJ?=
 =?us-ascii?Q?7R9+VkIHG50ZuA7+htEFJ7eY2odb9E9qNxxrUdh0IBkXX+gegOPfHuGtjwoI?=
 =?us-ascii?Q?gHvA9KG76yjpXgZuuktYXF9d1lsN3YfwjlO04yAAcpO8KGca5AZx0JEP8ZcD?=
 =?us-ascii?Q?ycopYV7YpvreqbLuEC+K2D5xwWQbZOBZC2NC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(52116014)(376014)(366016)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n91L+h/donlrFWj8Nzv17surJERlI2ErBZkWCtTZYL5yihFXui8CH/Gig1iZ?=
 =?us-ascii?Q?Etv1Y9Nt95jb7I5XyUJsNtgWLhPkVw9i5QaaJCqmKMA4wh56KYxVML1Kn/4F?=
 =?us-ascii?Q?W4cV5q2UoGvtWLCymPVgNLxNxq/J6rucikloEKGP8MGRxgt2T6fWZMcjfDlg?=
 =?us-ascii?Q?pnkWVJGfonQV0UigXW9BHk0O6bz96MfXLMmUBoQB1AvnAGBMtXbl0Gu8N0Jk?=
 =?us-ascii?Q?kKwbDXZwUVhN5Ln6QDQ4Bn14r0P9JmzZCeWJImneDlJB8+UbYo4098goajIK?=
 =?us-ascii?Q?5+H6mEiqxoeLoN20BOkDqzxiwme7nd6wXMGbv+w16HFdb/svjRX8rvTTzJlX?=
 =?us-ascii?Q?9ovzmU+B6tcrsS0YaJ1/Fo3okCKrwfsTXnp1skEwxOsiqy9E/4tgz4cJWQe+?=
 =?us-ascii?Q?MxYRLI6rgwT3VFhR6tNIGPoE9L1HMdPm81YSrXFvbPiw1IjmXHU/EuyvLnKl?=
 =?us-ascii?Q?my5PbG7NZ+mMJHHODjhxtCO/8yEhOGZWdqZlO53ELjhFpX8/59uS3P1FIrNw?=
 =?us-ascii?Q?bCNC7QRZ8RVoRidr46zbor1CZQriVFKzf98QJsY8m4vy5iepFbxs6FWnsM3S?=
 =?us-ascii?Q?AMCuz+O1DXqHOZBSNewZTMNK7cj/n999yIH1FX1prKwNDSruzwZOvDytnuuT?=
 =?us-ascii?Q?CX49uKc79OoEQvYHwKe8yylJY1LsoTmNcVXwaSAxiaTHnUN80eJ6VxyY9YKr?=
 =?us-ascii?Q?lBvR+69rYJfprjzM0qnpkMM7z74n0Jk11naUmB+cOZeYT8+iNbz84f/JtjuW?=
 =?us-ascii?Q?w4DgEeGKpixyR0gsTxAdfVgxAPcIu155pm0aOGvrxoEpFallIqrm2i9+UAD7?=
 =?us-ascii?Q?oBhyqNHem3v5ejAysGMsCnBPqtazM/HhMnIIPMSrnbq0fG+Cbz+vS0VPN7fK?=
 =?us-ascii?Q?MHBIOuw+NamYp/ndqmdwKgP17ryxYdVewkn4x8mZZ/VTvh6psuyK7piwcjSF?=
 =?us-ascii?Q?R3HzJ0K95MsWtl3p1179lDlwZ76QdgFZ7cxYsbMTyr+zxaL9TwMf2+Iz35Gk?=
 =?us-ascii?Q?Q9ojR0pFUc8EFj8pAoBWMAVkS31+EGjqTt8U8ADlnkYoKlJSezkGJx3VEM55?=
 =?us-ascii?Q?grwmNDK9wQzrtj2fPhVy4I29KIHm2/A8rQGjM3W43rfiMYARvFKFNWhqvbHh?=
 =?us-ascii?Q?OyvTkHRFixic7PLq/YSZ9cSdcicZ8Gy0x3XyNHNT7BsuHv1D3nzdoxxqHjYn?=
 =?us-ascii?Q?2OTRRNn0ZyVIR4hHQ0TZqCh3hae1tUD1NFPbE96EoUsKOEnHdXcIkGs3UDzT?=
 =?us-ascii?Q?lqrcetYiPBQngXEbgvOUV21sJCLBA2qhKa1TspmYvpDyd0cdqWpGN57wzMKQ?=
 =?us-ascii?Q?3hu/Rqw1yhP9PITvoU05K1pa/fLHovOX0My3Hzf+lqjkfNvCps9g4KqPNrng?=
 =?us-ascii?Q?M0VIs02RpoGU4NT3thYfGVRv8BQMWjaDLczABvrhKWFXnjUup7P8psMSf4Fp?=
 =?us-ascii?Q?4DH9AQ6KNViNypDgmK/KoZuRLtdrRegBqtS0JNyqpoBRAqY5QtM/sj8UG2O1?=
 =?us-ascii?Q?x6NgQmHaOK3igis4ZPGakyEyVRI2ESdokGICxUfiCrhS9j9AQ0BnTwgtWDa0?=
 =?us-ascii?Q?X3LynN+vtQDtp6uBNni39kCGZFterp8RK77unS56?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b249f347-ef16-4762-15ec-08de1bd7f78d
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 19:25:52.0310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Nd49rzvoqZphVf5GClcFXM0u4fhVinA1hwuTjyEI/nj7+b3pu13M6P8mQrnePfb3IUy+BFJv1ZVRp5ZWFF+Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10684

On Tue, Nov 04, 2025 at 04:51:08PM +0800, adrianhoyin.ng@altera.com wrote:
> From: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
>
> Add a new optional property 'snps,dev-nack-retry-cnt' to the Synopsys
> DesignWare I3C master device tree binding. This property allows
> configuration of the Device NACK Retry count, which determines how many
> times the controller retries a transaction when a slave device responds
> with NACK.

Look like it is software property, why need put in dt?

Frank

>
> Valid values range from 0 to 3, with a default of 0
>
> Signed-off-by: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
> ---
>  .../devicetree/bindings/i3c/snps,dw-i3c-master.yaml       | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml b/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml
> index 5f6467375811..c233be2d4a3c 100644
> --- a/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml
> +++ b/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml
> @@ -37,6 +37,14 @@ properties:
>    power-domains:
>      maxItems: 1
>
> +  snps,dev-nack-retry-cnt:
> +    description: |
> +      This field is used to set the Device NACK Retry count for the
> +      particular slave device.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 0
> +    maximum: 3
> +
>  required:
>    - compatible
>    - reg
> --
> 2.49.GIT
>

