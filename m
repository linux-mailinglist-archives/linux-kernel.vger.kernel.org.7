Return-Path: <linux-kernel+bounces-853052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E188BBDA8C4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 18:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BC31D4F2863
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6792C11D1;
	Tue, 14 Oct 2025 16:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NKvB6881"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012013.outbound.protection.outlook.com [52.101.66.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E8A2571A1
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 16:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760457659; cv=fail; b=Nj45lacYT5yPdrz6R8zJBS3Q712TlJO/q+vjkKPSs4eVDZNCCfi91jud5tyPmjwKNs3r7MSpnbeFNhlTgbyu4z9lFok3X+TJxFNF0fvlC5NBX/AOblcu4mIsj3Z4cV1TVb1we/BoTiTd2m93DkwujtkcLYKIPHlFTF3K60sUyy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760457659; c=relaxed/simple;
	bh=i55BBrLl2khUbpFeFyKoT78/S8M4+ngyetKx9Iuhsdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JLwejJYDjI9MAaucgzRaLJQ9NXIjt9hO/bFYyL65oll4Mb4ulUf+FypiNwgEQe9rI/InCoaKJ8XDKM3Ag0e8LncCpaipDmFyr9RtwDDDSF3ZdKisCXTawX5HWNlgjbw0KI+1q7CRfrTTLQYefrdT5pcXyz7NqepLC8GlO6VVOww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NKvB6881; arc=fail smtp.client-ip=52.101.66.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DgtgYE04Yyo2aAkhBQnLVsWw8usn98EF82adduPPe8VIfcI5mjGH8C0dxY5v0Nd6qP9Toefw69bK7qdeIY/GTlmvx8cOn0X8sYxCA3ItntgAminFVnpjeQIPLGvlRyg17nPQiiHrDxwXWCdsHYt7gnD9huFae8szxJ4d45BGwdXg2BqzXLXO2iaRzdXljtRz524moVyCBLtEowBpU+bsuKadZF/QrQUyp+XUS9k6bNPi+l6DQuWQ2JG25Q+vJXnUWgp//7RMtBcjiWebANKsXsmaypyc2C77FTwiLQSkugcZFNR+j2IfeHDoRTKWLVnve4AzKXnIVSgGRzECmQoHdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U0zwenFR3i16G3324C1bVaUaxAmsHjXcsj26LueBeTk=;
 b=Abz3AKyDMM0VULkNJ0IqWM/LUliySfrRjP734EQlEeYHO0WWNEWwBjvxGUIwZ+uBF/w+60kLfKtE2BHLnpafWOi1A0J7oRgvAcIWTu0UBUE8IPEhwYoV8QboHSQMRzXxfzFLPGZxJqAd/9jxzjvLMZ8rzUslQ2E3Lfy4JpIqv475/NlCDkdDN3mYw+y4djIjdLMXKyu3yRwgIjj5de6jRM/suV06xFznTB2Bvrb81tRD+Oka3Gn16GEamW6QTcIueedhjzQVHz+oHG2vkxCBnpCWAdxXT/NKwpeGiiBzs6Ao13EncYg9WC7I7E/t2gGwcDYNAvitZAGfjokomk97FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U0zwenFR3i16G3324C1bVaUaxAmsHjXcsj26LueBeTk=;
 b=NKvB688120On3fvag2B/+tUN1vcL2zK1uP3exKhU/kD5+kPX2fYFg5fbjp06D1n4S6SwvgrqpN8p0SQShZbaUECw44gaOaFGr1MI84AXZjJhZJmuvvULqzdrM8wnVbiLQqIAkupXgDsA21toTH49oiflOzxj+MklMe70ZCYIxcetRb0beQxmLAiTQITUpT+ifdyVhxFuwLzHOaZdTurIPVANUg1k6csybKC4r6MjHx26qfRRqU5InhGQW9Xj4Jp+C2PFSCdicIRuAoSQCUnM40XpuMJEexv088Nqooe604y1UTfHf7ODWn8L7Be2jfbfkls4CRsGSTuAhADvwkyjJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by VI0PR04MB11538.eurprd04.prod.outlook.com (2603:10a6:800:2ca::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Tue, 14 Oct
 2025 16:00:54 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 16:00:54 +0000
Date: Tue, 14 Oct 2025 12:00:47 -0400
From: Frank Li <Frank.li@nxp.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Dong Aisheng <aisheng.dong@nxp.com>, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] firmware: imx: scu: Update error code
Message-ID: <aO5zr3LnuZ9LHs9x@lizhi-Precision-Tower-5810>
References: <20251014-imx-firmware-v1-0-ba00220613ca@nxp.com>
 <20251014-imx-firmware-v1-6-ba00220613ca@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014-imx-firmware-v1-6-ba00220613ca@nxp.com>
X-ClientProxiedBy: SJ0PR03CA0138.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::23) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|VI0PR04MB11538:EE_
X-MS-Office365-Filtering-Correlation-Id: d372aad1-b9d4-4e30-a496-08de0b3adb2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D3M4YRAX5y/iKcbJx3ia9xViby8nidkD/J6ii5touZ7tEPAJa1tbz6nFTGde?=
 =?us-ascii?Q?W8NQUpDLxAPSvQPqRdTvRV71gdc9AN+x8Q7oQRJwnuAFgSueJ6Ai5vd+lMIh?=
 =?us-ascii?Q?UBS+rh7qPJLW6OvMqykC8uldVUCHvhYWEtur6a/5SvNjquSVhITcnWdLe0X6?=
 =?us-ascii?Q?tlONlVl/WXm3hXbpvf/jI4wtXC4tlLVm55XvPDi75v4iYxTqiLxYiQ06Uzv1?=
 =?us-ascii?Q?p14KgpKvZK+e0USK0NpH1RRpOFz7hfyhUOioTi8KaYUyS8VVhZHFn276oe/r?=
 =?us-ascii?Q?20CauVDFoGYqqy8gOMggpUJIatClyHMaSYya0jIXTiUMynppoHQFpnRQGukr?=
 =?us-ascii?Q?wzLCNoKjsr8z8X74t4ziTNL5+HDXwsqvxIhzMq49cXuGuNqtxiN0meiME4E6?=
 =?us-ascii?Q?aSMkUOME5SpLtVQQrayMgH/VCl4M5a5qO0uankR96ckorj2HtyYLCdpBUVvG?=
 =?us-ascii?Q?1oj54b/ktn8WOWwh5/n+sb2TVDtFMph1iIDCJ4lsEcILzvSjBalsxFEHYyns?=
 =?us-ascii?Q?Jo3T3/mdNTu3lzgq0U7LjsFFKVOAlsR3koDqzxNTLRqmtOv4lBmRlRRt5U5H?=
 =?us-ascii?Q?ks1Naz8iUlcpkY1R3DrodcXmtBYl3O0KQwcI8ICteEUHhTZVBN8iov0nSEmG?=
 =?us-ascii?Q?6JRzAVSr1oJvUIK709+Mqv/2vIoR1kNk2E4rr52EopbyaktDWrsW6NGCPCne?=
 =?us-ascii?Q?UiCd6ySGi23a9kp9jMVwM122XC6o60gIcRpKCi75k56gB4/KOxFqtrVbblKZ?=
 =?us-ascii?Q?or+rne0wRF4/FFwPaRmq7DA+/NHWtFKM/peV74447c1l17K7sJHTt0fkc8o/?=
 =?us-ascii?Q?JqZij8zHaajhQJIS7mr9AHPajC8fIHoArpi2y1sG4Q7ukPDZjGQzt3xDIpdN?=
 =?us-ascii?Q?XUEqocD2WhUWJ9hlyc3NxCRAwnuwZ4UXawj9ex3n/6y2dHbujCGUeOkKyYqa?=
 =?us-ascii?Q?U1nMZjqYxGXed/pTMR0rQlf6RHoAviOMRq+CLf9kA+KNmV/DeJhxxqeqYuuX?=
 =?us-ascii?Q?YquwUtqtKdQCoztJ1iMbIy8o3/16cw7X6y91EV0k35FFvTlF5PwEHrFItHVl?=
 =?us-ascii?Q?v+j5oUKKjvAS3rL5Xn4kXLLIUb0yaBjri/WlharOYhYMievyqecJ3qHHLQT4?=
 =?us-ascii?Q?+r6UB6INf5gdsXpeTGEr/7cYw78U+H/UNAdXU1hs0hNJsMKgH+sEo5zMIy9L?=
 =?us-ascii?Q?qqHluM/v5ArI1i6BVVHOxKvhwzbyPc1D2Ri5L2ScEq5JZL7w54EqfEAk/OPY?=
 =?us-ascii?Q?P0/aih/ifUhooaCyfG1wp+Z+adWHxt6EvtaUbKdv87niZ5lWDlwixpWFGqz6?=
 =?us-ascii?Q?DQUyV++MttiZLLtkjdDfJ+ttRCY+I9CybBUuz2/Zzi8VgtnvKfo0P7wT4q88?=
 =?us-ascii?Q?VWwaygrEg4pNq0LK3ziXGhQcokQvy+tB1en505FewxApovIdup59F8bVzkiS?=
 =?us-ascii?Q?72S0LYazpC7uvGrdwNd0mDAELYftWsecifgN+52PjmJaj/mPx5gALDlJbxA6?=
 =?us-ascii?Q?Y3RJ/5SyAsFO/oi1ZZUTK5lsrEgApqXWKYhu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g9c3QzL7t8YXwhUfxUNNAxl85yb4PHgurJ0veo9482WiAbwkghaB+9hWm63J?=
 =?us-ascii?Q?1tfO9Z2WvR1v7kYLcN1H2XqPza2Sjv2WDImA1aaWZzVmgLkh/ToTN7auicjO?=
 =?us-ascii?Q?N79CAyi1sv01B76TqX6X5ujc0tu+YFeSFa8y70wo+2/3xYr3+/4gMr67OZ5k?=
 =?us-ascii?Q?huJEsx0AgD5uf8PtVzpC3e3uyZRcBUFBYHlbQf2qBF03sAme1iELbEW6utO1?=
 =?us-ascii?Q?V/XmjnrL8HUG6E+ztHGjcQC0vn0PG+g9eTgJaROVo9ZOo0TzyHbf+l7bOG6t?=
 =?us-ascii?Q?gGuDH86IFAgNF0+esPymXK6tbV2uoun/HDomt0SQm4+7fqLTzhnVq5DDt3Jc?=
 =?us-ascii?Q?Amj4qwaG5pEAdg6+UCCYqx346aji4em3A1iQeUevGILA6XcoLA2t5bO63rlA?=
 =?us-ascii?Q?0z0E8qNm7mtW+j9VJ/zRBAJde0Lal2G29pzn32Nx3QEef8xhs7P1JOaatTeJ?=
 =?us-ascii?Q?MBsEc3x0Rkkf2IZX6+k9LI0C8IH/dT5EDlJmOnSXbfgr2DfGESOAgdLawCYG?=
 =?us-ascii?Q?JaDLg9xmYgFGLZUBS5AYyj+NXCBz/oRp4f5pBbyw4hrQApcqYdto/mVwnEnL?=
 =?us-ascii?Q?59rMpYWlzEEF7f82zblZ5BMARu6lJIXCcdiujSb/5JShQUJne/R79qhEDq8O?=
 =?us-ascii?Q?leCQrlnPkHxabhK7Ihb5IdFpRtkLo+WXPOhtPmP1ZOddss5f4xUiQ5gf2qAK?=
 =?us-ascii?Q?7scCK0rOgQRg2C3KJ6YbPZguX49mBO+JWYw2dkG2jIbP9+qKTaaryzBt1yKa?=
 =?us-ascii?Q?t0mtYYrmRj+b+KvEkx1uttdjJ2MwGe4Es5BRjWKxi4Sk34lCpTZu0hN9GTyp?=
 =?us-ascii?Q?kCFl3kZI+zsp/n1AIP41KNGR0415mrMJlGEcnj1S6zaZOEKszanEu9PTc8TA?=
 =?us-ascii?Q?4c9eL6mhhIsAPZJVyt26vqoQZlhUeqyqbKCIUkO+jG/m/EwVdOKl5NlFqRNf?=
 =?us-ascii?Q?cvKVpgB1Ui8ZuqjnurcaKUtG9S+5CYrdEySZqPQDQy4q+svdPVhP1KZ5ig8T?=
 =?us-ascii?Q?EX/OvWtukJPIo66HSH3QiwzQJI5N98dq8uE/gb5vqUKS71B6OGwHwTunb71N?=
 =?us-ascii?Q?8wMSw+IZGQ0uKjz07XGFP7YErNCblGObAEpmL6bBzrMfQGLjjXi55TKJAooy?=
 =?us-ascii?Q?lKtihg346jwJ1+cIS/WvX9MfIllBjvDaFoSRGpdE2iCUmJvnnG9FEvEqznvC?=
 =?us-ascii?Q?81Ebkr1GT7Ph0ojoer1mysgh5Bnsqp/9dNoVGpl7vK/Xy2JyK7TwjtMvvgxt?=
 =?us-ascii?Q?oWK/8Z9dIF1GkYzi1QuZO+v5gKVffirEgUn5BD0qltS8QVTIun6OBcR1pBKw?=
 =?us-ascii?Q?2coSN0AU4q4le12KSCAKZj1/xgsA5ShBBIlLMyIhu4HtDN2JVrViZeNBn3+r?=
 =?us-ascii?Q?HnGty9plVSt7M5EYTlhwz+ti2AgvP6Kx1ttO+Cxcai+m5WlV2crgSHZUp/LX?=
 =?us-ascii?Q?weT+VUJHYb3updeDDbFWvo6kU2R2MOipEF3mHvqrXJ4OMnGRZ1wk+gSsUqZy?=
 =?us-ascii?Q?7Ttbmb8Iu/uzcioIEIRLwzhOUatRg4pkyRbIfvvd0rxffLucqBRSvsEu9L8Z?=
 =?us-ascii?Q?6xmZlAZkxTDgWt9rl4FUhU5sqE+0AW+mJZHb+CXw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d372aad1-b9d4-4e30-a496-08de0b3adb2e
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 16:00:54.7759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gUh0GUDvImT/89I+Ra5BoPP//FKFz/CKL6faFbUTedPzU7RKKH6vQUNiU9wkt7ZZ7yD1tvXNGOegusmNWGCIaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11538

On Tue, Oct 14, 2025 at 12:54:43PM +0800, Peng Fan wrote:
> IMX_SC_ERR_NOTFOUND should map with -ENOENT, not -EEXIST. -ENODEV makes
> more sense for IMX_SC_ERR_NOPOWER, and -ECOMM makes more sense for
> IMX_SC_ERR_IPC.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/firmware/imx/imx-scu.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/firmware/imx/imx-scu.c b/drivers/firmware/imx/imx-scu.c
> index 8c28e25ddc8a650d2d191c40193cf1fb5e70bc35..6046156bc3c9abcd8f62b46f04571b1a9decc0eb 100644
> --- a/drivers/firmware/imx/imx-scu.c
> +++ b/drivers/firmware/imx/imx-scu.c
> @@ -73,9 +73,9 @@ static int imx_sc_linux_errmap[IMX_SC_ERR_LAST] = {
>  	-EACCES, /* IMX_SC_ERR_NOACCESS */
>  	-EACCES, /* IMX_SC_ERR_LOCKED */
>  	-ERANGE, /* IMX_SC_ERR_UNAVAILABLE */
> -	-EEXIST, /* IMX_SC_ERR_NOTFOUND */
> -	-EPERM,	 /* IMX_SC_ERR_NOPOWER */
> -	-EPIPE,	 /* IMX_SC_ERR_IPC */
> +	-ENOENT, /* IMX_SC_ERR_NOTFOUND */
> +	-ENODEV, /* IMX_SC_ERR_NOPOWER */
> +	-ECOMM,	 /* IMX_SC_ERR_IPC */
>  	-EBUSY,	 /* IMX_SC_ERR_BUSY */
>  	-EIO,	 /* IMX_SC_ERR_FAIL */
>  };
>
> --
> 2.37.1
>

