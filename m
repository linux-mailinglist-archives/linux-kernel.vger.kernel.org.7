Return-Path: <linux-kernel+bounces-853059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4570DBDA8CA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 18:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 216C5546036
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0BF28BAB9;
	Tue, 14 Oct 2025 16:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aqF+0kU7"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012057.outbound.protection.outlook.com [52.101.66.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF01E301013
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 16:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760457758; cv=fail; b=KTvfSCnE9JFRWuLkPZKQX0rWy6ygZFFlQOfwQDPfJKvlZESa4fzfmfagNTmDwLSl9TzyoHuKn4fJu0HOMDz/i/uaRahnfh0T5IgvOmabl9+NOE3QcmpCpKjhrEvjhnSQPVBTjR21Xy/hiMh+yvoA5gv+TNaFBVtVJz9Y5SzPms8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760457758; c=relaxed/simple;
	bh=+m7ZpaLh5QrvORUmzH8nQQc7UCp573fSya2wG2WEtHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OUKJZtEwyJjL/Ybu2FfOzk4d+mOameIAYUneRtv5/d7UdE6uiYINbnAC3P48xWo2aiMI0fQcF0wogbB7UwV3HYwAYazyhyrRxLayHxM1UwTpYBgP8aT8jDp74nzgQLCxrccK6nOdFhKghoakEhfM3meBf1IJbWwgUcuNtc8HfOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aqF+0kU7; arc=fail smtp.client-ip=52.101.66.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PaEl4ngWRqtGFDxLkFHrfY8DKQHmfXk2HfQPLa4zuaqxduiMiATHSVPMOB7dYQnok4QgF/Hs+rmoTQTkuAij7CA8q0JuwWuVFhnZVqpBUXBzGr+rLYdExByZGSHOi+vGPDK1lYrNWEzCcIyRY4BEYWygbYKZd4n60LK8y1qnFbcMTxILORHBTlZbVDwwKB+E/1OlbZimzcXcQb49s7WwtgnP0bo3jcVWkbJKwKjMb3YfUm+HSzp8+jTFJwpUAR7W0dpORpzp/qsLB80Nh5hDePeyhpk+B+pxqJIZ/oLslPpDoxPAD7e/ANfrb7D9661BWPnRQKZE7SQRpfyQN5DA5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5JVmdwLPHTsadA/I/qDoDXQUqBW9NId41bq5LXRdXks=;
 b=smZjk/cpJXegzG8Bu1lPD7sWPBqueLNQEHLmFgIowxcFNHd6nbIFB9D/lO23fSVhKDZoH1t4nGfLeMGsN8vlvw2VvOocO2Kq9qXnw+rBrkDNsHGZ7Wpzpn7+T6tJkmsmi+Loaqc1R7e4+wAXDVQGxJhkOmt5L+fa6vVf6HBffaHYYOJOD9EUX2xjNJve14vPzAML2tPFqRqfy7n8M0DkgUjkw7nBzkzRizAvgVc746D0ER63aeG+qfPvztnaiGNuKFpBCNDi8B7+qHGRMFoHsBTUWlJAsPbtrccjU72hXdUzXlrlUzIRkKj2zxs8VqSLvRyEakdOSl1iKsgW5qoVDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5JVmdwLPHTsadA/I/qDoDXQUqBW9NId41bq5LXRdXks=;
 b=aqF+0kU7A8S8GJf3L7HxKtnvcgWKaLSehBuXD+OjG66Y2EoofxXZkj6TOqnscBTune0xef5sAtE6aIU1fXQQvuGMgD8+9HdxciOSFQR8f0sLSVMGltM3xa2EqNKMNfafcGMscxomh2VqWo68JCgGQ1vfmTn9I+TAnW4sGtUSuFrArx/8QHYnxzmbV979ctjz93nAnRxnQO9Yy9axQhLwLe4wsqO73wExyQh3TeyCG276VYkeUzAhWaotOOLGVvOE0nR+ZyzV1cMmkduufi4MFIeZeRa1FZnreW6LyZtolRVzZqxpQhKS2hnX8YjR2RhJOV0BMtvoss/ZJZplhRJ/BA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by VI0PR04MB11538.eurprd04.prod.outlook.com (2603:10a6:800:2ca::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Tue, 14 Oct
 2025 16:02:33 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 16:02:32 +0000
Date: Tue, 14 Oct 2025 12:02:26 -0400
From: Frank Li <Frank.li@nxp.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Dong Aisheng <aisheng.dong@nxp.com>, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] firmware: imx: scu: Use devm_mutex_init
Message-ID: <aO50EheJpp57v+8K@lizhi-Precision-Tower-5810>
References: <20251014-imx-firmware-v1-0-ba00220613ca@nxp.com>
 <20251014-imx-firmware-v1-8-ba00220613ca@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014-imx-firmware-v1-8-ba00220613ca@nxp.com>
X-ClientProxiedBy: PH7P220CA0099.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32d::23) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|VI0PR04MB11538:EE_
X-MS-Office365-Filtering-Correlation-Id: 44b18216-89d4-4815-76cf-08de0b3b1580
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pxExcf+xpxw/1klHlQQO8Scc8f8nnD2PCL+GxSOxHA2iFpNIEzXM9wljgHDr?=
 =?us-ascii?Q?hvrJNrxnLY053Z22QF0qSsSPzsMqqbTHTX38+visfcuqP8kWiFhvKwznKTsA?=
 =?us-ascii?Q?w84ACO+5Liv4f0DquKqRGyjOV4ZGPQBwmfnEfNg5BW4Sw0tlD7SrkwrWucZS?=
 =?us-ascii?Q?n32Ycp5UwG/NDSiouFPgordxbOJlpEazLVqz2/sCtWb/Q2TI1wAqxPUh90ax?=
 =?us-ascii?Q?CpHyTJdc6iCLzA61bWxaAymuqaacBm9v7WXMcwhK1CZE9VYmWg9q9DbJONoL?=
 =?us-ascii?Q?2J25r7kEVwH5Gi3KgWkiPq3H/elTAoCxpLLRm9rqluuAUXPU62+x4FcIZeRk?=
 =?us-ascii?Q?uVWirLBVXnSbeVI9eGR1Wn0RPwYCd8fyRGrr2pMTaQU/sZp61tEeSSlyM7hy?=
 =?us-ascii?Q?dz4I2szmREg+BVKq1W7jMyBTPnt6NNQQE7Ah1d9BWdK3t4escS8zz3r/Fmhe?=
 =?us-ascii?Q?G1LwVeaCS8mttl4ukNlMDwQd61Ve6RsbMoSvrAcNiyiHcdEel/yRbEdgY3ZB?=
 =?us-ascii?Q?JOgNPfs5Ky9Aa9qhvHjDhqpPJAk9n0gZ3nzQ4WGkZVrEqaMx9jJgBuuw85Tv?=
 =?us-ascii?Q?sbSm6e8ksUnpNrBclO6bzU/a7WH/eZLTAiWTzptrJEGm824USBDTcLXi2eVC?=
 =?us-ascii?Q?cQaldG39IjSgGW7NI1I1Quu2fKJTya/gtizn2QEWomgznB9csi32IWSkANkk?=
 =?us-ascii?Q?iVtIkeNxFxHI9hZzjOOiXsalU0vptwIwrVQIBzUtlbXTndOPFm67Quok1LSD?=
 =?us-ascii?Q?FhaOGLX13AoqIpQmsAHkVtgv1SbMF11Y6cTPMbY5m04A0AObtLRjrpKB6x4X?=
 =?us-ascii?Q?5G4HuRTbglVF1/cgCWtgjn2RwXwc5RpF2V3nhlYGbWuPKxFeFObii0GeJWog?=
 =?us-ascii?Q?BhTmIGkAmkiYm5wJEdkgGTyYSV8nM5IF+wIS611BAVcx5Z6XxcdjBMAvlm4v?=
 =?us-ascii?Q?5ql5M7/N4Nt2a1i8GaGcJD2QgRIXBD1cy8xSBlFDPWMGIY5Hj1t1DTpUw+lS?=
 =?us-ascii?Q?vB3ClXgwqU7Mv6OpkTyHXJ/xpb1SSMDB2PhkkF/HDTbQ3uqmmDk9JCmcSXi6?=
 =?us-ascii?Q?eDzT/SoV8gIDOOQtWcRbkqceFY+gLJoFNfCsTL+w0ngiQzsaIhL6riw2WCCS?=
 =?us-ascii?Q?mCnzTNyAY0uwSVhcnhYrWQuQaIXX6Wv9HlFwrMoZTr7jgR9LAe0SMwTL/9FC?=
 =?us-ascii?Q?rk6IpArNIREuko722bxp3oJi19v9DM3QBrqyRbkM/AgYAeyJAb4pm3zL7Uq2?=
 =?us-ascii?Q?C/lSXN2Hc3IhCwBPSqk7MG5cTwi4BGKotZ0zQOKE03KX9dNMg8MIIIkwWSXM?=
 =?us-ascii?Q?uHvvm2P6fVPEeyzggoN7U+RP7FbBm7hY2jmwfD/SBP0yPv22gskZFRYKNsID?=
 =?us-ascii?Q?lEdElFslBoZw2Z3a8brxld1LQt9dUYivWfTTSnLJBofMSEA0OhR6jay6iYoV?=
 =?us-ascii?Q?oYkG5Gdl6vfkDMrh9v6EJqzS0s8gpvh7Q526YskP5Jwy15VXzokyCFBDBwus?=
 =?us-ascii?Q?AXH/QDOTQQ7NP1DsVzxCmJ5GWhR3wqSoMKrr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0xJccuvM/QaXbUy54zhZ21SVRnqkMrnnHUHPHlmntmRDDsAv4vMgVtoRfAl5?=
 =?us-ascii?Q?Xy0Lk++dZsjIUo8p4VJyiCrGNdFho++9xoA7TT6EM0E//cmG6wkfs9Pg62z4?=
 =?us-ascii?Q?YkKoL/YXAgj8XPQvI0gk3PC73E9ABlIffVmNoC5iX+1LkrAvRVMNWZuWNecm?=
 =?us-ascii?Q?euajtsiroWn2yXU6C9b1a7Em5D/idpBHK+39Wp4DKuTOSO583p26O9V2cDJQ?=
 =?us-ascii?Q?SgG242t3Du0lBdX2PfN5my2HU5//Y0qOUwI5tey2P0WpS2gLENvBbSEoRJnm?=
 =?us-ascii?Q?j6uK/u4zz/FOj76K3mk9FSMjods6q5BNPl0y1ZKOdMuYkaNn5PW2KGKv5feQ?=
 =?us-ascii?Q?2RQoChIzgQaYxfgCmPRzkd9GMPUQ+JzIxRMdO+XoFuXMWWovVbZn5dQ94uwz?=
 =?us-ascii?Q?SDS8uD+NFZlTkW/vwpyoLlao5aQvhjYPoj6Wp5cAJ2HGgnCLC4BwbZpJ1rWL?=
 =?us-ascii?Q?GqgtNCDC1BiNVV2E+KVS5RayMVSEfi8gX227I9EFbboXW+RORf8RQy+YVa0Q?=
 =?us-ascii?Q?Lxpxt3vq3ql4uNKGI5qlVfzJe9adCq0VYYUdWmO2WZyS+yWGhL7J7H+pVVKD?=
 =?us-ascii?Q?YDrayfutzwF+qC3R/ylyWHsu9L2HvRkLvgU5mvSXAKHGgYaRqNdzQs1qVDJP?=
 =?us-ascii?Q?kj4uddzgNrgYbd6OBUchcquehI9PfdixbpceNf086gm9xi2YJpWBlk5oP795?=
 =?us-ascii?Q?lnd7nptfQ3NLixcla/6U04vPdLVm9Z/Afum00f3QCATVRnkRF2/Q00ytT7Ny?=
 =?us-ascii?Q?7DR6cZf5Iig/OKwjI2w3KwbthQYQ/We3SDXVASojXLrOFWIuhmbf22Zl3aUK?=
 =?us-ascii?Q?I+oYjhNEsyTErvaT3BNj8qmGJ6pFYBI++dDZD/RRTK/BbJiIQQaQu1QLIiGi?=
 =?us-ascii?Q?TZSNcljtzmH/ReaiBawxrRTSwsAOQhZypnv39tpm7u90lHcm9Yq4xqCf75dj?=
 =?us-ascii?Q?vbwZsaf4e2tjduqRDKmso08J0aUy3CHZaatyOhArN4GLakdX7Eo8BLw4Q8XB?=
 =?us-ascii?Q?x1yj/PgbqNfkdsZnegc+fGaJNY+U8JOXoioVby2oBbJ3LVaBziVCQ+ZambZ0?=
 =?us-ascii?Q?6DIs3tJtvHXbWjEZwfaz5zp1v6iOAQ3IWViEQ8p1JD9iQp/fBsrMovANdJjT?=
 =?us-ascii?Q?LzGWHmvhX4AmRqj5JA8eHcLDFYxvS9w/BOxskAueH7XAuGZFEROay0Yzplhu?=
 =?us-ascii?Q?bJ1y8bDDp9bgBK9gCSfhfDFgxO8CVzUGfyDhqOxknnlNz1MZrbaM1HTk2EW8?=
 =?us-ascii?Q?BH7uJXvR8pYM8+Zea4vTMmXSwmGfzQS7tfMZ54LVGGWYI1yykpqZZEnKd0v1?=
 =?us-ascii?Q?/rhbbyz0AAHHwHipKUkqmBwvlbUMdwF9vz1ucKwtrOHDqIp/3DN9u3Z7NdmV?=
 =?us-ascii?Q?Br7+tSfDXaQ2KdpJaPfCqVIpCAEYCnFJsvjI1ipCqGPbnHVuC5hScyIzX5bK?=
 =?us-ascii?Q?5fY5x5TfO8xX5aZ5UfCdLGu4cYoUaUWOlVG/mzvoFtzEWGYcAXnNa84IUyZL?=
 =?us-ascii?Q?M3KvkvA4g5fFVXIodIxpwGZfeShddHsewmGr/4Jmc6h51K70MY4l8t4n4tbQ?=
 =?us-ascii?Q?3KAyK0PfFg1qj4YTxbulL6wEAnhnBzFzKMAL47yA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44b18216-89d4-4815-76cf-08de0b3b1580
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 16:02:32.8731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NwG+yX9USsNxypgGCHCCsp9VBi8DYKWgmd1BpbeDNDLMkGR7CkxY5N0LvaNLgQuc+i7s/iVNuGesJm7XhBBFoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11538

On Tue, Oct 14, 2025 at 12:54:45PM +0800, Peng Fan wrote:
> In normal case, there is no need to invoke mutex_destroy in error path,
> but it is useful when CONFIG_DEBUG_MUTEXES, so use devm_mutex_init().
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/firmware/imx/imx-scu.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/imx/imx-scu.c b/drivers/firmware/imx/imx-scu.c
> index 630e3dba4db15961ae4d77273af6248be614145e..67b267a7408a12deed77d2c8f52d5f64b239a408 100644
> --- a/drivers/firmware/imx/imx-scu.c
> +++ b/drivers/firmware/imx/imx-scu.c
> @@ -324,7 +324,9 @@ static int imx_scu_probe(struct platform_device *pdev)
>  	}
>
>  	sc_ipc->dev = dev;
> -	mutex_init(&sc_ipc->lock);
> +	ret = devm_mutex_init(dev, &sc_ipc->lock);
> +	if (ret)
> +		return ret;
>  	init_completion(&sc_ipc->done);
>
>  	imx_sc_ipc_handle = sc_ipc;
>
> --
> 2.37.1
>

