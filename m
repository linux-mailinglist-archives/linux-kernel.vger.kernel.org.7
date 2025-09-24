Return-Path: <linux-kernel+bounces-830692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BC3B9A4FE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 16:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B5431B269D7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6859E30AAB8;
	Wed, 24 Sep 2025 14:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UqZ2CQuw"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010004.outbound.protection.outlook.com [52.101.69.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F83F1B21BD;
	Wed, 24 Sep 2025 14:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758724979; cv=fail; b=gANlnh/yau/6yDcmyXoFTMhM5HlXa+LvUMB+qlrl7iGeqGPTJ4xUohBANTs6DmqBFe6WabNnrCRiUhIZ8jR3iGeEVrseM1xJjrLLpYsR91AuwOe1SZjvGelTQZTKQaRYAc9mh59N2Nidr1w2FPu5NFAYqnI+YfcwfXVQy7QMsJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758724979; c=relaxed/simple;
	bh=6GR7nNVqo5KuvJMNaC4C8EjlWgjCVMWXR+Tu8mLJOK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Fx4fXgSjDGyjfyrrTdminQcCvQwaReT769wQwJBm99oCIL2EkfPmfTvPI5n38JaIQWoPZUkLUBtP0E7dHFBVpQZB1MYDph3DDl8irBbaBlgCOMXemJ3+G5iy7C9m8iqRDRDMH56SjGx3iOHvBxOZujA6qI58+2dbUBM7TL4rR4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UqZ2CQuw; arc=fail smtp.client-ip=52.101.69.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JIeD9T3UVBzRlBakMOCv9uAWdWLgqbRacY04AnWI7/s3KUHPIIIqKnw3xMJkQzGQwU1YwhA0jwhPN40e+hmKjY10DhQtKSBUm/YTfDX8C6vBbC2Afq0V3tAmE+FYETvITHKeiA0MFrlgehLxOH90+oX2B47tWroM1Dk8kCV/wIrVzT0dQqiTHRtgjSnOVMBOkHsPaoBeTVDYiixUYmKUESlXboNApa3CY30zrVvKlL0ia+Tbjlh5W1iHK2pt/nRfXzOoD3JfFpJFIHqXuZRB5XYpUnQyMrbLznG3taBLzJ8OWg2087eBgDD8nADlJn8fkW8u2hFaGsl0qdEfq13nnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VqmrF/QaR3BBXGvZDdwN4m8VRJ7LJCcATT5ettLxRSg=;
 b=p5i4W62+eG7eYgN9Um3AV5m8OUsoS9XcE+/v+l0ERMne2kUyFJ4iOZJFuYejuERM/IRlVYam0HCoZjnqc8DcHHKj+0WX+/Mliv5Rsurw715VCDzc0bbwY1rvrOeTmkjSKaqvu1KjHafHH/lkjizmiCI6T4sTAGc5l3nsZWv1bE+yprqvWD+ZBWLtwB1brlc83BYxMUHRxNqwG19tGvwx8rAJsI+zmhCUyzHM/FsQTlLycJ2tpp+qb5bzd+jgY86xkvC8WPXYD9dG/Y1XYpS8sh/LRqvumNaw8FzsYaWLUCXJbmuV2b43f2krUO46DxQixqQZVx2fCXinvt2iWScgRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VqmrF/QaR3BBXGvZDdwN4m8VRJ7LJCcATT5ettLxRSg=;
 b=UqZ2CQuwTqxK9pHddGCxDbsa9Vovl1TN3uiV9eoDHf8f8Wr3Cg4cZzGthY8IirYCoSIEUq5M55iv2uL6X2y5Mf7OmulfXC+HF5qBCogKcmfe6zZNpEuVjwHf/nIQw29FTKWs01544bdfLTkQAFebhGCRAmnbYoKJ6dED5SNTBE7qA8sDFK1YJ0feaNs6RYi/WqcKVlCycZ8XyE+794l2RxchTzEtBIwSecu9mgZzKtpR5MJ8Sq0R/tgOrEiDZ1IOMYPPTXtpvpdm8hGgaqJvK+Sl/xdZ2hCgigSPOb4Ae05cl8cgM5SrIpJhbClf1fCZxwOj86+Gcv7NoIg3zIN/wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by AMDPR04MB11554.eurprd04.prod.outlook.com (2603:10a6:20b:718::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 14:42:54 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 14:42:54 +0000
Date: Wed, 24 Sep 2025 10:42:46 -0400
From: Frank Li <Frank.li@nxp.com>
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc: Srinivas Kandagatla <srini@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Alice Guo <alice.guo@nxp.com>
Subject: Re: [PATCH v1 1/3] dt-bindings: nvmem: imx-ocotp: Add binding for
 i.MX94
Message-ID: <aNQDZqHDIw7RLLfk@lizhi-Precision-Tower-5810>
References: <20250924-imx943-v1-0-0d32d7852ecb@oss.nxp.com>
 <20250924-imx943-v1-1-0d32d7852ecb@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924-imx943-v1-1-0d32d7852ecb@oss.nxp.com>
X-ClientProxiedBy: PH7PR17CA0024.namprd17.prod.outlook.com
 (2603:10b6:510:324::21) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|AMDPR04MB11554:EE_
X-MS-Office365-Filtering-Correlation-Id: cbefe7f8-49f1-4697-4d25-08ddfb78a4ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6ZxTJEUzaUhfk1GGAEhivszoqS3j/UL1cj6JWrW4nU9H6Y18UDCsdkqHTKl7?=
 =?us-ascii?Q?D79HBtbGE8on/6CNh/YlyYh+Ytt3M/NCdXb30xX26XrniZMVsVTu7hlQm8QZ?=
 =?us-ascii?Q?HN0jRWPBxYJMTVxDQSRrNyhBrXj3CJTTS0cBl82Zh0I9Ad04pg4pJl0pxymk?=
 =?us-ascii?Q?p5zC7Wk/BWjx6iPW6dycDybmGm6vLFtdzGyNm217Bjn1Jo62zPuRtMRxGH09?=
 =?us-ascii?Q?dUun0IKot/M1RmOl7BseEPtV0NlnJzgTOzpnv/YQ7QEZ/WPthTtWqX79QuZ6?=
 =?us-ascii?Q?u/yVvNcM5bRgZ8y3RWHgNniQgzGNihw+WMnF8mMsY6BhHk6zbHvgdiLce4yv?=
 =?us-ascii?Q?3GHbuxLrOji/z0CUnz+gcbBLerysOWDnyRYo/oQ1Ut+JJGc3EnElE2Y7DKgU?=
 =?us-ascii?Q?mlGmE8QCP8BKZr/P5zbr6pf5F0+5s2rvUREq0eTQqoKniLfF/NCs6JdLW1Fr?=
 =?us-ascii?Q?vq9CWDfAJZEnJZt6GpafpwHaopaP3UTDXDBjxGskZtBl9PlFlWBh0JAUOgQU?=
 =?us-ascii?Q?rGhuUQz6J/HkmibxrO2FvqNyzzxkVvmfs/aDtgrWPo7v+7B7HJdXtyfQKN/z?=
 =?us-ascii?Q?IRWEQRUAyvbF0NbvaFkv8BfxbqXYLSD6rZ7mb9vnpb/XsmTRmlKY+D+BaKu8?=
 =?us-ascii?Q?EkkWchVj+Np2aKG7BULgcJ91moPZYbcSN0MxoTlMLQYIn9BUhzWtdE57DUVS?=
 =?us-ascii?Q?BuZshjw1ph7GdxiCPqmxEbCgu7JxswKiWnFXviZPCaSKFIf2h1NniH5/lhLj?=
 =?us-ascii?Q?sVOjETaDapPjQwcs7TKnE1zxzUvNnPFy6JiTP6wJONK4k4exLIcmHg9hzZYN?=
 =?us-ascii?Q?utAbUBOw3LqSS2JhGxB9AXPgROLNdqGJwgbZhlqgpTBMMRf8d6hv3y0YUoIh?=
 =?us-ascii?Q?veTpnteVlSN6ZxRBPb+eMlv05HuYpS1/Kh6DF3CodizEOPfIBfugd9u1qDxZ?=
 =?us-ascii?Q?J+UQ6mRqGX0cTcwK0rgIutNfrL4in+bkTBrR4sq/+3omUMz2oaZpwEmJHQZb?=
 =?us-ascii?Q?K9Ac4I1/UKr0bjNgCC3tm04ZdG+P45SFgelgwsnB/Hqvr2PW9hAqIvcew+Xx?=
 =?us-ascii?Q?NptMDdtmOJtviQARyGRmR2WCZDjZkWFj7+NwhjPEPVaBj/swkPIS+p2vWWqo?=
 =?us-ascii?Q?qIHeMYNRTEpqSXa3DwKlU8IVz37J6SAtbmFDMd4ZhvtG6XU/h4wOJuUtwp9j?=
 =?us-ascii?Q?paDd/mGspXrM9pXS6+WmSd2BUH20bd73bmLpgW+IGl7mMoidNyFfITzB4hXz?=
 =?us-ascii?Q?ubqGYRsj6tB/H3XX2XZPBGjHAx1XG8O0gXi0IrABhv62SyMQZf2bHjbngBMv?=
 =?us-ascii?Q?RZ+R1/ZFrwJuSkhqcokPFuJ5/deOtiH1tersijrTOWaP6PKYS3Mk8WmvQInc?=
 =?us-ascii?Q?Plce414Q6zsrt5EONwu34on2XaD7qBbJ9BmVzpAhQNkiH0jnAG5o7qdt1nj/?=
 =?us-ascii?Q?Ke5F+I3N14SEXMFsx81NGA9s5wEcmtBolrt/u+uRnEMoUYU8+tPGnA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x7TkzSrRAPQHCq474idkl39IWxENGZY9ircfhR+32eh0yBZFiP2vvOw5B+oZ?=
 =?us-ascii?Q?zMYqaV1bn8d0JsdRmaEFXmsL5uHzS7nqTL3WTFkTiMHksfiXMgph1MrPUk5/?=
 =?us-ascii?Q?vUpbIUPN126fQGesW3QyinAn8fghJuvzbjKkTHLx+sWEeDL5gb7HC4Ngp6+h?=
 =?us-ascii?Q?XE7ACQaS+ZwCSpjx8b/4HNrIQbmnr9ljD8n1QOf/cl3oZSXpATrOUFiIZuto?=
 =?us-ascii?Q?jTxm9aoK20oQrseZ0X73WemUiwg2+4UHTj5UkcqRuKirCACVmItr5t5Uv8GG?=
 =?us-ascii?Q?NNCHE/eA9HvQC+3I5i1rZi995q8Eqg/ZZUcQ/5ldSpZVTKJjAHKBgexWvUNc?=
 =?us-ascii?Q?HDw06UpCRjA8sX1CpPElviG2myWPuf6F7QzmEzGQeVdXJKL+aiHOIW8/polS?=
 =?us-ascii?Q?mO/EcAjDWzDBCo7+R4hLJAvel6pjFtye5eBhViqxgYGq/rqtXpEaQBWCHSrF?=
 =?us-ascii?Q?WEuOIhLWtOA/h0SIANp2zCizx0MMUHPlUTxlhSRhksEvPSnGRUc6cp2M97kO?=
 =?us-ascii?Q?O0Ip0Sejcf29AMWTq21YVOIxqUBDPVQ6xXAZqkOGXemL0NR2fmeyNI0xkKJf?=
 =?us-ascii?Q?krdqYtgZLXn6oxgcfKbNlC+3dKdDheZQqVVZTzR4wDsyU9JTAuC/odtp/Bq2?=
 =?us-ascii?Q?ycWLdB+VJJS6LpACpIf3G7LZjmH1BiG9iKwOgolg4lU4IiO4NtCywVo/1b2P?=
 =?us-ascii?Q?aD/fYkCvdy9jcVOknBvD9TuvK+/cuZpC783+woBefbD3bLw0mbw4Kbfcx4pj?=
 =?us-ascii?Q?dtC0K4flqnLS4aics1t+yJHL9NNNKXyFkHCkTFqxGUgo3FIYBKTcL+xavjUs?=
 =?us-ascii?Q?/NRj54qa+cY7+ZNcr+E9+G8veBzGnVRV2d4a/n3ePW9g5ERiB8z5M74Xt7QN?=
 =?us-ascii?Q?yAvt3vmWNO72wUC2YSvq/Q4d+XP/YvL0fsm0cKTInDGnXExiaZTNqSIE5XnP?=
 =?us-ascii?Q?h0KIa7xV1Ci3f8phUAxvtU9oyk+H+Hac9xqnhfFlg3nBU2a4W7JE2Fg/KBBc?=
 =?us-ascii?Q?Qn4Do93vDg7Mz/pW6xxvhOB/ZXybGCuU6ti+JaZNwIuIShWuTIRst277ng+e?=
 =?us-ascii?Q?/j64a/tE18Y+Tsb1ZAX65koj6aXt3SkeewemftINBqKboNSrNS1KqeXgdTpw?=
 =?us-ascii?Q?PhXNezLZsr7/ZDX6mEM1pLamfUCV4gc+m1Cm4U/9fR1N/FxtEjH03nkdRe2E?=
 =?us-ascii?Q?hbZ9oAdKphhcM0ML5yWuEiDX74Lad/pEmqnfXd5LwCHCS9ZrtWxFNgk25lki?=
 =?us-ascii?Q?FHpwFdiZD8yI9PLmXMcSdBjoEVs7RI8fO6ygFq/t/nyJsl/Y8SBtU8QB9g9+?=
 =?us-ascii?Q?4eIeOPAAPcY8BAsVI/eicQbnjDSSbuUB+hpTnuD0ys9fotLtw8E4gOL1Hlrr?=
 =?us-ascii?Q?adM3AMSdAGbMAL1ZSKrmT/jqV3WqENTyHaISeSmMg6rTx1ycO+nanbU447RC?=
 =?us-ascii?Q?Wwp79BHhrO8nt2jwQYGPhUalPyClit45BrA5p59diim7WaG9FamHLkq+YWo2?=
 =?us-ascii?Q?cmS6PLvG0/PZRU4mKbZoLPA6O+ipwzzrZyz7lqa6oHOyKdPF+SbnErLC5k2+?=
 =?us-ascii?Q?XmaGUS9ihaW6RlDqtDJfpx5DQDieVqsqbI+pf/vE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbefe7f8-49f1-4697-4d25-08ddfb78a4ec
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 14:42:54.0357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 07q0OYdd+Wgbd3YE34nYrOH0KOXiUx2x0tsADO5N+9mA6hZBpJdAnR6FL4hGtOy2bx8fIllwHZJUMMljwg7ZtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB11554

On Wed, Sep 24, 2025 at 06:06:23PM +0800, Alice Guo (OSS) wrote:
> From: Alice Guo <alice.guo@nxp.com>

Subject needn't "binding" again.

dt-bindings: nvmem: imx-ocotp: Add compatible string fsl,imx94-ocotp

or Add i.MX94 support.

Frank

>
> Update the imx-ocotp device tree binding documentation to include
> support for the i.MX94 SoC.
>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> ---
>  Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml b/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
> index b2cb76cf9053..a8076d0e2737 100644
> --- a/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
> @@ -14,7 +14,8 @@ maintainers:
>  description: |
>    This binding represents the on-chip eFuse OTP controller found on
>    i.MX6Q/D, i.MX6DL/S, i.MX6SL, i.MX6SX, i.MX6UL, i.MX6ULL/ULZ, i.MX6SLL,
> -  i.MX7D/S, i.MX7ULP, i.MX8MQ, i.MX8MM, i.MX8MN i.MX8MP and i.MX93/5 SoCs.
> +  i.MX7D/S, i.MX7ULP, i.MX8MQ, i.MX8MM, i.MX8MN i.MX8MP, i.MX93, i.MX94,
> +  and i.MX95.
>
>  allOf:
>    - $ref: nvmem.yaml#
> @@ -36,6 +37,7 @@ properties:
>                - fsl,imx8mq-ocotp
>                - fsl,imx8mm-ocotp
>                - fsl,imx93-ocotp
> +              - fsl,imx94-ocotp
>                - fsl,imx95-ocotp
>            - const: syscon
>        - items:
>
> --
> 2.43.0
>

