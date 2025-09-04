Return-Path: <linux-kernel+bounces-801158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 166CAB440A5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E92ACB605FF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B911FBE8B;
	Thu,  4 Sep 2025 15:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="C8U/y9EE"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013008.outbound.protection.outlook.com [52.101.83.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B1129B0;
	Thu,  4 Sep 2025 15:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756999843; cv=fail; b=AQD6XlXxhvfyBFOK4AXysXmCMnO//2zzXcPQMAKcBpxpranT2iYWPsfr/dYzl5hErMYIQUQyxBLlcgcrIyHq2yciiW/khwIJ15C7uIhoKe2dAMU3NgaZ/Dv9lZmpFRVaFyL8L1elK/cVkZnlVMuDD/biA1sQOEhjHKv+5kVle4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756999843; c=relaxed/simple;
	bh=/39AhQNh1Ql6gcFjKNDj1+ryBP9b6K4AmJtQQcd74bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ldYHh78F0Yfp7Q/mcWLLb1EGBDkkbszYgZ3zS++w31q+IBuJJEhFM9Px8IIZphOT35n02iedQSGb/6SwxPlZmsa/Tp/fen638oTOW13vtY0+4kLGOiF/V6ZtiUCdTdkj+0t++l4xEG1ZnIcPbN0MWH9DIytAgu6eNxUg1N//QFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=C8U/y9EE; arc=fail smtp.client-ip=52.101.83.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YzyFT7BU91aI+2ASkU50bnBpVUfRjNxxDefumCGZLaSxIfTJUGAkln9K7LEcEoXd8u6FckcbSIyb3HgFPIuO2u7hM6uqkzaH4ePqvjDolWLWa4qj92EPt/fTRO6or/9UD/2gDBKwnZTOGodLC7r5ZbacczEkTnV/9eIFg2uOGea9Ym65aAZIsZFgL6s1zY0LJedkZ0BXvNYW8qJTAQx9XUbVSAYxv0c+XR/rFvI9X5prvAkV8jQ4CpB7MDRiOtIFOGZGcVYt6Pz5Fgx+nfdUamf2YD7HCLQEWh4mydCW0MI6Trs2Py+s706TJKist1O5o1RPGfPnMV6uUhMwuflpuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mlTGJucx5i0NZAxAJnprPERVdTbuzBag27XaFz1Z80I=;
 b=VZnYApx7SefKW7TmJ91XJTWNyiJ1nv5v1Z2NNg5bdexB8sn56QSmwY3wGXekTZF8ZTCUBkhvh3nNPjPmFFQQFHToPp0TKV//ayg+JBgPU/EgrmelrztwaNPuYCLOnE5+liZ/0MbLJ/r6gtzgoiUBdqedf8442Gt9vOXsu1TYkYVJcsNOcKUxFiTwD93fLBgMnlWubGeJ1uS0frQ9K24W61C6+fpTSzK5YN1w1PgPfTcsTg9N4TDN4cGVdEqEc2EGiflnaon7+f4r8TQgCPAAMcy0OjN7DccxKd3ChoJOtHDOy1kHtu3nQZtldTHtF3Qxziogd6xJfgF/CzEvwIu/WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mlTGJucx5i0NZAxAJnprPERVdTbuzBag27XaFz1Z80I=;
 b=C8U/y9EEuoF1lQrC5UcMvE0KYbuKTpNsNUgP13EtQJYVWWhUuWrJg0ClV9VuYmlFTdho8I4Dl8yjNFxa62L1tQZ0eHer+I+tClGaB8BTBwqmZBK5uIBQifKs8fc4YnpL5UvGYXV6uwhLIrxfkZp2cAuaWGl2TOezOAq2NlivVWBjElSSDGJ3sCpD5BGPxbi87Nrf/W22bAxnu8flwZ/0SJovsXbyjc9g8NQOUF/AIVwCYdgJ4lKJsJGMFWcc2h6EcLLyiGrG4eC6VuxCF8Gnj10WGN3rozzp/WPjhXCoqI+PMOYn50Lr1O71H7T9xEAZOwOsi7eKRiIyXEQvhqRK3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DB9PR04MB8362.eurprd04.prod.outlook.com (2603:10a6:10:241::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 15:30:34 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%5]) with mapi id 15.20.9094.015; Thu, 4 Sep 2025
 15:30:34 +0000
Date: Thu, 4 Sep 2025 11:30:27 -0400
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: dt: writing-schema: Describe defining properties
 in top-level
Message-ID: <aLmwk/0gqrivgl1U@lizhi-Precision-Tower-5810>
References: <20250904142400.179955-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904142400.179955-2-krzysztof.kozlowski@linaro.org>
X-ClientProxiedBy: BYAPR05CA0107.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::48) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DB9PR04MB8362:EE_
X-MS-Office365-Filtering-Correlation-Id: ac03a1e0-3568-4cde-77b1-08ddebc7fd7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|52116014|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OpzhX37xsP9GfBhumFNNFNx0jzrZC7CyEOXL+SnCFtI3ZxQ7jQijRf8ViTjI?=
 =?us-ascii?Q?Js3xnWXLxIYjOR7cYWB8qNY4+YFdL1LvgA926qWCObQF+wG7g9qpBXxS1oO0?=
 =?us-ascii?Q?mmBbPERXOfVfWR2hv2U7jqu9ja5ShgcuhVa4lQLaGGNw9W6kKzVFHSjXou/d?=
 =?us-ascii?Q?A02SXaWBV58TxNZUzyxuixZe8K1ENnF9tbvMYlY6OjRR6GOVF5q1z1EhZRSe?=
 =?us-ascii?Q?8iBWdg8EL7dSPW0BCwQKkMx4FlYxLOnimLE92kHN3MeRc0fyInam+EvGNeoM?=
 =?us-ascii?Q?EYr21xSuncYacTiA+EE8zP7Ffy57mr9RgpNqllJp8bsCgsoneZQfQNZRFSrW?=
 =?us-ascii?Q?yfZKHVCg9DEZaSSoqXM8O0QkA4aIVLrNN/wR1Q1+tgpH5cq+BQ6LPw8WU9/B?=
 =?us-ascii?Q?UJR+13wBraM2l2QaEN266ZpvuxbsfTfbSHp6Q4LFfpr3QaaiyIicbA6hUtiw?=
 =?us-ascii?Q?oBKxMhT9uCDSMoRDyONlefUEFHHT3eE8G+0d5Mo1eoRxGF9phlVpe1/kIfxv?=
 =?us-ascii?Q?8akmeAkknp4TpkzZ6o7xx2RZDCPGD3ESljzZo9TYJ4DgJuiJkUnlNCltbcMj?=
 =?us-ascii?Q?4RJhowiciPZy3zRZ6BQenfyKaZb5udaS5itY2DmGfATn7FGgS5HoRN0K3E9x?=
 =?us-ascii?Q?B8mFMRWgwDjInyQFqZvT31O4fqkuKi7ecxMnObuLM1N1Gy7pNZMw6vixaRwt?=
 =?us-ascii?Q?bhXOrXa2BwiD9IMwK71FJsYK5AgeFWFNXdOyA/RqIFlnd36fwUK1ZtlZ9lu5?=
 =?us-ascii?Q?nUaufUsPWOyUY0TLYphqDKdNQuaWldE8NVr4LnvPywtfZEFFiG4oJOwa+67D?=
 =?us-ascii?Q?4QnVwpLIpcdIiy3a8z/tpacp9hliTM+xq7ZGZ+aB2bs6IyYWSaKtrRWCth8d?=
 =?us-ascii?Q?ZhBJ63/aqcTTaPd5CtPq2oFCH2tT1F7+jP+yDbkLBV8Om6o1+IPxMbgNpbCw?=
 =?us-ascii?Q?Y+v/G/z+VnegBmOIO30lBBjrLXV4ws3LYBkLpq8eqiQjo3W510P3bhjSIxG8?=
 =?us-ascii?Q?bTj1aAFU8mO+AIFOOCQk40wwZmT3IY/iAhWovmleuEBKJb8DG80YHYnhx0gT?=
 =?us-ascii?Q?0NHR0Eba81DJ8dgON+uR2VprPQoUcw/v2Y8QLFnA7+25qWMnwgGS81jJ4ILF?=
 =?us-ascii?Q?I0pkrrU+pVQVyGVXNtjuFgNAJyTKfhMFrrWWrViIkY4DFXqBcmeh14w+JouX?=
 =?us-ascii?Q?C6LEcFJZHHrwk3ZjlUMa9uFQDFKUp9sDIxs59n7Ci8YCQGUJ8/QjKYSnPjaV?=
 =?us-ascii?Q?TfxkwkfieiHG3F+vltp4IedKbEBZuUZMO7lqLOMExSogBu81N1G7OkWq5c8s?=
 =?us-ascii?Q?g0ThWkEmFHTUfG8oBJr8rRY06lPwowrVUCRbU6yFo9LotNdm3m5n+RrE8sJm?=
 =?us-ascii?Q?QRv1wHlxHQmDvzyhdH0bRCGLuVMk4qfy/pkKxvnFq2EsaEX4OB5fvZETMcGf?=
 =?us-ascii?Q?RLWGavwATYLgpXT5kLriHQH67paeKKmVH1cklO4NcMIKOSM37i0rdw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(52116014)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lUVsD5URmH5/eqQVh/fGr8mOGZIWLPk1/k0xjYouwhydWLGL9NDhl+Lvs54K?=
 =?us-ascii?Q?ysNEM3zMNhoOoUfT0+BEgY1UzymdXxfeJ1QaLHp6yZABhxrEvSIK0trYVgLb?=
 =?us-ascii?Q?nBkujOSL/TqC89iFPEHrlkORiP7f3ASHBeXbt92Yz3yOwDMzP1vdmRCwtpqz?=
 =?us-ascii?Q?THuJ5pZSHhWLku1ct0tKY6vf5BbPs5mDTsavVr/7FnqiYARU3HHEVTIH3PHp?=
 =?us-ascii?Q?RZHP8RXZhewG0iBya4rfJkSwig/R0L/IV57Y//nWB00wYbtX44efn8e31oTW?=
 =?us-ascii?Q?VQq7DHoBPb45iBwe6BDXB+uNVccLH42OHIHDvQh3V5GzrMXP8BwJ4kX25ujV?=
 =?us-ascii?Q?IDpcMPzAX5bOMiq/g0nU2kKiQdLrYstabbWVjoW2Jr9be4D2eymnYhEettR5?=
 =?us-ascii?Q?ZY38idvv2ZSq8anNb5vwkCx/nRhWFzaE7w8sPFiKRwY37QaaWWbJUVUmO3iw?=
 =?us-ascii?Q?oTkAEKns1HLUK9ofQDt4WyqCpbanKJFaDINAy6rLCH9dhi0u8V6tEUaKS/KL?=
 =?us-ascii?Q?3voj0n6QY7L8GvJYcVfWET+jCMQ9VmKcr+FRmegvpCI9VJheqMGbh3WASvUD?=
 =?us-ascii?Q?mMW9u84jcAXWNm2vqVa5GjIzZpQ/lrNWfeXSk+vFh/RQst3Yh5X4SohvpzA5?=
 =?us-ascii?Q?adWExPdm1rqKFQFXNPucgIgPwFBRy1mzHcdhYPTXsUlAgZSZHTrRzVBeqcdy?=
 =?us-ascii?Q?7VeTiV7Gm78aFHkK5hj2HoqhGU8NZft3pwpYPopyBx7JSHa+i28llt2oj0oc?=
 =?us-ascii?Q?6HCy/+ye7fMF80ayo7p93lcLcvb4l88HZBvQKV0KUKTgTsGknFy6Cz48wV/R?=
 =?us-ascii?Q?sgGs0hw9f3nx2qJbNAlgjco7pTyXi+m8gXtWrOUL1CKMnflMYY9tUWSJPTPR?=
 =?us-ascii?Q?Jbql8SiHdjwRQqoeiC6aqr2/4Lo3Lfw4+X7WFkL/T4CORnDPJP7kQkfIs8/u?=
 =?us-ascii?Q?fZPrtOXEd9MaUPvzwkl0eVPqxSJmGWDA7/F2X2G4kao2TN3Zse8j32Sg0hlF?=
 =?us-ascii?Q?VnAfIbcgAi+UNNmWW70dcaTaFebFRhhbRRETCTNtAztrSraBZ3HY658ehBGh?=
 =?us-ascii?Q?uCP9/oEZNYA4Hdx1oz5TuzQYkyQhZcNCk7+b6ZwRw9qoUDrWhusdK6NgInar?=
 =?us-ascii?Q?oOLSpW27HBaKo5fb5JyX4Db+E7HGIx8QG4VF7Ly38AXqjWFRjO8nYxVtZi+/?=
 =?us-ascii?Q?AszWJpFNgI2tGzGaQ92BeNrHe7qZvjpxYQ2/ELI71aMDBLYCyF/orTjY5nk0?=
 =?us-ascii?Q?IobAiGHUp1IyxAQBjKCgtwkS+vqoM7lJcB19J/6qXIrR1KxNKYVmAADj2t1d?=
 =?us-ascii?Q?ipSqNmbFjDiu0Q1UNJ3Zp/1mHr3iO5sUW1py0wvWqaW9xSNBSdpRELkwpFdE?=
 =?us-ascii?Q?GEG4cD90YDv+vOhmg6Nxpmr49dfdA6VBjHUw5rD2COzdVp+SZk4mvv9rGVH4?=
 =?us-ascii?Q?XJ0VYzuKs/PVquR/fep5vb+zdylzVABGXLcFO9hmV5tU11VkokwPTHn3b8aG?=
 =?us-ascii?Q?9jAefFhYfheNT9+pl1alBeUkFTNmDQhH5bUQI7VgOJPwhGT2+qbRPuOSj2Tc?=
 =?us-ascii?Q?MHXfliWP6DAzLank7pjw0A6fqqtdh4T0GAzEioAP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac03a1e0-3568-4cde-77b1-08ddebc7fd7b
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 15:30:34.2683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CAk2BroWzig5vOWfQxFS1A7hlMMOsO2W6qbK0/KLR09vE31O3P9W2UfPWqpBLMrt5JsbjnaixzENDEKH6tz8/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8362

On Thu, Sep 04, 2025 at 04:24:01PM +0200, Krzysztof Kozlowski wrote:
> Document established Devicetree bindings maintainers review practice:
> Properties having differences per each device in the binding, e.g.
> different constraints for lists or different allowed values, should
> still be defined in top-level 'properties' section and only customized
> in 'if:then:'.

'customized' is not easy understand in my view.

only restrict (such as limit number of item, limit data range, disabllow
properties) in 'if: then:' section.

>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/writing-schema.rst | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/writing-schema.rst b/Documentation/devicetree/bindings/writing-schema.rst
> index 470d1521fa17..e0859094575d 100644
> --- a/Documentation/devicetree/bindings/writing-schema.rst
> +++ b/Documentation/devicetree/bindings/writing-schema.rst
> @@ -165,6 +165,14 @@ The YAML Devicetree format also makes all string values an array and scalar
>  values a matrix (in order to define groupings) even when only a single value
>  is present. Single entries in schemas are fixed up to match this encoding.
>
> +When bindings cover multiple similar devices that differ in some properties,
> +those properties should be constrained for each device. This usually means:
> +
> + * In top level 'properties' define the property with the broadest constraints.
> + * In 'if:then:' blocks, further narrow the constraints for those properties.
> + * Do not define the properties within an 'if:then:' block (note that
> +   'additionalItems' also won't allow that).
> +

I can understand what your said. I think it would be better if add some
simple examples.

Frank

>  Coding style
>  ------------
>
> --
> 2.48.1
>

