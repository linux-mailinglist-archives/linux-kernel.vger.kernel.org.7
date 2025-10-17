Return-Path: <linux-kernel+bounces-858248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 50973BE9671
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 17:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DFE5F567B6A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 14:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED0F337111;
	Fri, 17 Oct 2025 14:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YbPL5Wqo"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010036.outbound.protection.outlook.com [52.101.69.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4452DC78A;
	Fri, 17 Oct 2025 14:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760713090; cv=fail; b=d31hwYB7Vly9Rw56KrIyR/6TQRbtJW9rMJhQNsOAtjnere+mDu7cN4VVYw2Bd0nBt/bhZVQuNLL5XPTOGJMtLEjuWwoVYyoYhUxsX38yQQH36SC+26vwacRKkGScynaKQuWzsK45ChFMoW/D0NN+jVn0JyjVFqTn3fHNkUwM9HM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760713090; c=relaxed/simple;
	bh=jyyGdAnd63hEbOvYPYUZ7p+Gq4MX0zwpvMJDQaDvjLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WUbFVittxW5gV9aRQ6RCtkEGtsx2PItUFVe1RXivejO9xrz4qKtY3IIsWwtSX6szocFqZniEOhzpZPBNJHaxKHya9sQ0N6r7zLZFC7dgUkKpGvBalT4Ou7ZfOvng5BDi9DH+tTcVxUDDTB4o1KxEbJUw9wI2EBKW33cXRyE4hLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YbPL5Wqo; arc=fail smtp.client-ip=52.101.69.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SkkFt8O5yUzRale0K0jVE7XjmiYkcDKcBYlLvpN9VfB8lttyBjfkotWwRSITDpf2M6OmQz8ZN2cTr3uOVr53OJmfVLoty1RvJ0lkM0tYIunTnq8SCnw5CyKYh46FYHWzqwOBN2fsHqV63k3z5CNodcII9hjdeloIU774wg5+egOwZi01y+ql4hoO2kqn4D0JPWCFQRTerReaxcwGaxR+p+LxEo1CJeHzKvyUlEPrW0cPMWRYfd3pCJCiwvt9kHxTLVEi8lSH2G8smeRSUQb5MMja5RNQzf+TrOdOE/A/Za3FlQPUCvo84kpHVgqClp+J0tbJM3a53DWmUP7bOE30OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DhbHfxBapUS48AaHnkpUu6W23KMKJqRQjEJlk29JuB0=;
 b=RjMkMk6Ikqxhn07ulUKeeZQhoZad3VStHt6xl1r6Uc7X3YGxEYdzrUCGHEeD8VxfuYZG4NsDhl4Xvyp7XRRTdmwTOrWEHcipSaFp62mkqx5W197A5Io9MCn3YE2ZgyfDe7EPylO8NRg88iNUcKbbutBNXQQX9/+2DG2OEbSLkZyF8vCRZUj9DA5VGU3xuEGwvXltRl9BKAI96qCi/Qk89S38QO56HVITSdfy+bRjpiFFr+ePUs9/udXxrgnuPOjceHRYaT9xJ2qbMrmlLOUNbAd1Qpg1vtWMZOwYkvcmuM68Ij3Zs0z1EZ8PwBldY6hqNChH/RPw8c9zS4Mi0UKDsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DhbHfxBapUS48AaHnkpUu6W23KMKJqRQjEJlk29JuB0=;
 b=YbPL5WqoTgG2Ti7RS2BxUSjeZXGG/XGAZtsWxkvTeLUyNFHNo2MwOk+qoh4fA2Jt8vQhJDKebJbxvHOSGNHOHnBt82sZKfNTyl3HfjbHT1pIwvy706Q6H2mdovNFFKtAIRo8TMQOwtVK/y03KGzgZvbGw+xBbfnN8NLRplzKYVGVc9SQVdI/ghwLVDC7+uXPePLaMH3mQtt1CF5WElMQjkfH19kM1WGS4f3ZLpcm4YU/yf7Gye+5eiBdvSdVyAxoWsShXHWX8/Lu2Qy4Fi5C3SwjGxmVbtAKPjoxhWiV+BxdXaxxJQYfgpTrMhKN3ttrLy4q9VJY1clMd3y4gVwmLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by DB9PR04MB8395.eurprd04.prod.outlook.com (2603:10a6:10:247::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 14:58:04 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9228.010; Fri, 17 Oct 2025
 14:58:04 +0000
Date: Fri, 17 Oct 2025 10:57:56 -0400
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
Subject: Re: [PATCH v2 7/8] reset: imx8mp-audiomix: Support i.MX8ULP SIM LPAV
Message-ID: <aPJZdAQwdoOP3cqN@lizhi-Precision-Tower-5810>
References: <20251017112025.11997-1-laurentiumihalcea111@gmail.com>
 <20251017112025.11997-8-laurentiumihalcea111@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017112025.11997-8-laurentiumihalcea111@gmail.com>
X-ClientProxiedBy: PH7P223CA0006.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:338::27) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|DB9PR04MB8395:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b63ce91-2f6c-4517-aaae-08de0d8d9315
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iQ4nB0u0bBkiFVitfZBDSJz/iE5QjEhrl5YFFld/34zgqF3qwHjQmfOT8vIR?=
 =?us-ascii?Q?h6YjxASb7s4AqESk+tmpj5M2E2YC7/VeI8Kre973BIkBljjGUIAZwIhbCsn9?=
 =?us-ascii?Q?4q+ONzGFx3w/178NNPRKnAgZ7AoZcAPNqNRbVC5Ew2A9TRxLhf2SVhFVsG8x?=
 =?us-ascii?Q?lKNSQ+XRlF49FaO2dMOqG/YfSN7rFhLBgj4houBhAElFshxG1pDTq2fh9/7S?=
 =?us-ascii?Q?COy7FPyrJ9tMw/hmzVKwCkL25iNXiWQjZn3hZLHzatZ43t9Mn0u/sN6HqIzN?=
 =?us-ascii?Q?HtoCzlg0PfxyR3jtsPqQFvzGItDATiild9IUcqEh6HFOkf5Rt7QmqUKQLUeh?=
 =?us-ascii?Q?xw+MK824p1jRKcrXOd8ZX/cvJfuAyQwRolZ+gVIX7MuBNW3U0SMtI3VcpRz6?=
 =?us-ascii?Q?NDVaa5qJc95UJedQ3FV/+Oz6t4svUMsKq4ozOfUYZ0ZbV16UausfoQa9NVYC?=
 =?us-ascii?Q?TYC8se1zpTUU/AeNWJUdd9G8c0FvT6uf1KM0bZCzIxqDkaN+4mVyQp21kozC?=
 =?us-ascii?Q?JJG5xgrGeDDdy6Wo9wwBvj9NUSOddQtxY0Au1em6OU8bVKiB9/h57BNBNImp?=
 =?us-ascii?Q?Bx01pS5oVjnlgUgz5r/bjQ6KZjUL6cd02UBe5ndnqjEqco47yArv/GyMFEPA?=
 =?us-ascii?Q?QPE9Le2ADbZeXUyByUwausyv8u5UJMtWjsYuENbCBcDipW9GjnHy7tRgLyqz?=
 =?us-ascii?Q?IgeFVpvjGyHL7zXA97xLi/ta/F3xT4c+moj/P7hu80bG5OIy2QSD0mIqvb4W?=
 =?us-ascii?Q?QEol7R76E0o99YPvfwJYm5AOfGGDbFKBI/o9PjY05p8VnEfakokmfoa4934y?=
 =?us-ascii?Q?S7EwDqEpiBKoxKxYGV1uxvt+JV/rP/7zk0ByN4EH2aBCGBCI/ppCNzhI8GfD?=
 =?us-ascii?Q?+0wKIrPc3BCdmbyfGyMCv7Pb3fWBaznMT4AID3nFgIByrH6QTgiZxsI61xsE?=
 =?us-ascii?Q?kurij3zqt6RvxY2A6qlm+1vpyyFLydbaqhLYTYWfsvZI0rVwTIo6vgK888a5?=
 =?us-ascii?Q?mNJ2TJdYNrWP+9Lj9NaF54Nl2r7zKT1g4s12SXCh2HM8lQB+8aV5QkdN7Z27?=
 =?us-ascii?Q?I57gD2Bl5x8acNu7OdjO6Trq0oTLmW2DsXjVKL/DF5/iwCgK62GFVmeBFDU5?=
 =?us-ascii?Q?8H3XgZqH3J86tUnhr+3hG95O8fIajJ89gsHu8wPosrsxiWa0Dq5a1BWgB1F+?=
 =?us-ascii?Q?Hn7XrftBCccXctzKeSB07g7HhOaHNAsqzRkhhCqiA5wc3yacte6MqguOePmO?=
 =?us-ascii?Q?Tr0tzE/9onnuMn7xtIbJdqYTykdGqBJekBzBV1ROiZdtCfLR4wd9DXeXIUGi?=
 =?us-ascii?Q?/yST+aLHm87AtPRxXqhdh2CCH+oMqIhvQDzgU2hNYAud01bxCKUoiA3daK31?=
 =?us-ascii?Q?8Tm75jv/+zq/i6iKI5KaAObRu1AsF9LnWQ2xryxkVUYkk5ceSG6r7yxx1oyV?=
 =?us-ascii?Q?fJaT7sq5ZG+FJSRJXkgBv/NySySRi8t7SutQ6umB2UoWiYIsSuv3zgpJH5aM?=
 =?us-ascii?Q?Y9b80erD2d/fyTEi0lEdWIx+W8XQBF6TvTEf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0L/RJlQAJblZGuzUiJawV0Q44kyhrF8oT6pJql34rHC6yTazSM3fmwIF+/zJ?=
 =?us-ascii?Q?Sr5ybc35X6FQ6Ae01GUPjWzzfLkk19PII5a1D9KXzsQN8JcGvJwW69be5qtK?=
 =?us-ascii?Q?18BOzf+ZK2rSD4N/fnSM8h4a4Z4a2X5YLWCqie+opxHkObijQCe5SCUB1gHh?=
 =?us-ascii?Q?93kiiN9XfpDGuQFew9huI0h4OuIsFfzyLxapz1JNnUfrtorYyBRSpZA2DDpH?=
 =?us-ascii?Q?jy3TA8E08GlVnQvmohufgGFbpkUsFkRjsEnTaYq1FxwTa0IUHf/FzVoEdmMx?=
 =?us-ascii?Q?dvrO8xOVbdiLqTcZOtVMGMlRx50xNHN/vKuirjsQ0jXS1rskZU4HRQXgtIBQ?=
 =?us-ascii?Q?zz7auvPO+UOugnV4x8DuRr4po+zpkajka9RCGvK10HRuSqrh7RoDNG2wQDWO?=
 =?us-ascii?Q?wmcCd7/3RtzvtRyM4wTxPsijrmXbfDDcHbW0rK9iIx1g61v+suW3pgzqhD4s?=
 =?us-ascii?Q?C3EiOZHTY1Q/9sEQDvmLRN+z/CTN/KNWSAZvu0wAUWeaSddE5TS/2quDXEGu?=
 =?us-ascii?Q?JO4BjYlQr5gMjG2/nh1rxUhsE0yeVq0SwIhA/3OhhXfOgY2YjYmfyI5UFNB8?=
 =?us-ascii?Q?pyaBJu6nthYSsK3ixxrShlAG3wpx9DWqYt5cJ+eVT02EwAkw1U+LSWlJZyV9?=
 =?us-ascii?Q?rp9DePnFb7QuXIufvBZUyPqDC11ODpXHLNvxsYxzS/hvCrd87qDO+r/J0ebt?=
 =?us-ascii?Q?8v2cYA13Knh8UNvHWdLuVokxwJ+D3g5MwyE2I8EZ9ZQOiutZUll6ylPsJEE9?=
 =?us-ascii?Q?h69KaXp+HGx8f+QBra2YAGCbT1JDB+grQ026CN9Em+dfrYn1TiD6VLjZ2+Dx?=
 =?us-ascii?Q?tpkYWnGMZHsJOlHfRhwZSl7nyc795ZxZaEYUmtmPaCNvV/jx9fLJ+CgqwU6x?=
 =?us-ascii?Q?ig7ri5JHurEuNFS2gNMc+cAjQFP/0rac+s0lwxMfJF/4s8jrx2uh3OViNrvr?=
 =?us-ascii?Q?fFJtKYlTjEZGhHenhFQ5sHXqMyePihEgoKVQy+D/6gwOscegenIglP9rBj8z?=
 =?us-ascii?Q?i1rAooczKD5TsEYteSpekfAdifHgOyGQhbhPL6AlP34KKGW5wQgVmP5PwQqr?=
 =?us-ascii?Q?Ryoxx//FFygI9cdoBl1lQlqwUhSOoFenLh0llK0B0jHEjMZPdvFhw/Oyz7+V?=
 =?us-ascii?Q?yEhgsnyZRFxxQ76+u3VvoS2vu7dmBhN4h51SIStKp/hdV7818My221ob4yCC?=
 =?us-ascii?Q?is2XrPG1ZWO2sLs5HagM5eikB0mKqsZ6ypjQyvDG02tTXT3gx7vxCYedgQmw?=
 =?us-ascii?Q?RTyYp8EDPVrAtFw2kGmnDUdjI3spyBFyznJPzYrs5irnCVsucZuRkboQ07O3?=
 =?us-ascii?Q?+RHaIWDfclrrlfG5C+HpXpARDdl475eReb7OMyRngwfUhYcDUTB4oN4ZQXLN?=
 =?us-ascii?Q?p0w186AVOX1KfTsp98xXfAmFbxb4l1+n7q+oGcsQw8KJBlahJRqe77pql0Hi?=
 =?us-ascii?Q?wnXl2LT/20vWupZXN2epEizGT1RBMkcSlP8rxtpC+d/BMgi7yz1rQPa8OwOo?=
 =?us-ascii?Q?AwEJvw7hJ02k0n5wfMIFW7YyoXxtxJJ5XjJcZpje2vvKBWQnzsv8qyxuGnjZ?=
 =?us-ascii?Q?r6/6ijg7cpYBrCUOu6o=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b63ce91-2f6c-4517-aaae-08de0d8d9315
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 14:58:04.4890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ylPAcopEsEOTo1+Ux9A6NruClFOXzADEZATYhIk5IpoowEwNtHB3/aRZdcrQm2CmqWarUTh5AVJcgdh1JlpmLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8395

On Fri, Oct 17, 2025 at 04:20:24AM -0700, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>
> Support i.MX8ULP's SIM LPAV by adding its reset map definition.
>
> Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> ---
>  drivers/reset/reset-imx8mp-audiomix.c | 51 +++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>
> diff --git a/drivers/reset/reset-imx8mp-audiomix.c b/drivers/reset/reset-imx8mp-audiomix.c
> index c370913107f5..b333d7c1442a 100644
> --- a/drivers/reset/reset-imx8mp-audiomix.c
> +++ b/drivers/reset/reset-imx8mp-audiomix.c
> @@ -3,6 +3,7 @@
>   * Copyright 2024 NXP
>   */
>
> +#include <dt-bindings/reset/fsl,imx8ulp-sim-lpav.h>
>  #include <dt-bindings/reset/imx8mp-reset-audiomix.h>
>
>  #include <linux/auxiliary_bus.h>
> @@ -17,6 +18,8 @@
>  #define IMX8MP_AUDIOMIX_EARC_RESET_OFFSET	0x200
>  #define IMX8MP_AUDIOMIX_DSP_RUNSTALL_OFFSET	0x108
>
> +#define IMX8ULP_SIM_LPAV_SYSCTRL0_OFFSET	0x8
> +
>  struct imx8mp_reset_map {
>  	unsigned int offset;
>  	unsigned int mask;
> @@ -55,6 +58,50 @@ static const struct imx8mp_reset_info imx8mp_reset_info = {
>  	.num_lines = ARRAY_SIZE(imx8mp_reset_map),
>  };
>
> +static const struct imx8mp_reset_map imx8ulp_reset_map[] = {
> +	[IMX8ULP_SIM_LPAV_HIFI4_DSP_DBG_RST] = {
> +		.offset = IMX8ULP_SIM_LPAV_SYSCTRL0_OFFSET,
> +		.mask = BIT(25),

Register defination still perfer use macro. If not, let me know.

Frank
> +		.shift = 25,
> +		.active_low = false,
> +	},
> +	[IMX8ULP_SIM_LPAV_HIFI4_DSP_RST] = {
> +		.offset = IMX8ULP_SIM_LPAV_SYSCTRL0_OFFSET,
> +		.mask = BIT(16),
> +		.shift = 16,
> +		.active_low = false,
> +	},
> +	[IMX8ULP_SIM_LPAV_HIFI4_DSP_STALL] = {
> +		.offset = IMX8ULP_SIM_LPAV_SYSCTRL0_OFFSET,
> +		.mask = BIT(13),
> +		.shift = 13,
> +		.active_low = false,
> +	},
> +	[IMX8ULP_SIM_LPAV_DSI_RST_BYTE_N] = {
> +		.offset = IMX8ULP_SIM_LPAV_SYSCTRL0_OFFSET,
> +		.mask = BIT(5),
> +		.shift = 5,
> +		.active_low = true,
> +	},
> +	[IMX8ULP_SIM_LPAV_DSI_RST_ESC_N] = {
> +		.offset = IMX8ULP_SIM_LPAV_SYSCTRL0_OFFSET,
> +		.mask = BIT(4),
> +		.shift = 4,
> +		.active_low = true,
> +	},
> +	[IMX8ULP_SIM_LPAV_DSI_RST_DPI_N] = {
> +		.offset = IMX8ULP_SIM_LPAV_SYSCTRL0_OFFSET,
> +		.mask = BIT(3),
> +		.shift = 3,
> +		.active_low = true,
> +	},
> +};
> +
> +static const struct imx8mp_reset_info imx8ulp_reset_info = {
> +	.map = imx8ulp_reset_map,
> +	.num_lines = ARRAY_SIZE(imx8ulp_reset_map),
> +};
> +
>  struct imx8mp_audiomix_reset {
>  	struct reset_controller_dev rcdev;
>  	void __iomem *base;
> @@ -183,6 +230,10 @@ static const struct auxiliary_device_id imx8mp_audiomix_reset_ids[] = {
>  		.name = "clk_imx8mp_audiomix.reset",
>  		.driver_data = (kernel_ulong_t)&imx8mp_reset_info,
>  	},
> +	{
> +		.name = "clk_imx8ulp_sim_lpav.reset",
> +		.driver_data = (kernel_ulong_t)&imx8ulp_reset_info,
> +	},
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(auxiliary, imx8mp_audiomix_reset_ids);
> --
> 2.43.0
>

