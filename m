Return-Path: <linux-kernel+bounces-890654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 688C2C40951
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 16:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3E501A429DD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 15:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581B832C31A;
	Fri,  7 Nov 2025 15:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iJjHdCdK"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011065.outbound.protection.outlook.com [52.101.70.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7791E9B0D;
	Fri,  7 Nov 2025 15:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762529318; cv=fail; b=CtzztR84jLzK0vk8v0Y3CaMlb0976rS/Vfp6Rh5Ux910vJlZSdPs0RoLAPuvkkmtz6VPIezomZlyW7QHu6ZqqGQtRQs8Sf0SdeKllU4XmTOoAFGawr3yC/Q2mjQxHCqeTOheMEk7uWS7aGry/XnokUy8UVfcChhaVz2hwp4B8VE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762529318; c=relaxed/simple;
	bh=cbtogd2XibhtgoLICNEGzZjAShisCz4go8PSPHvtAGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sWY4sy3z5mZx9KqUGtlaf2NNVtQ5giRaY5GWzl0/k8zoHiQa1GTA8ONqp0EdbjYd3gmLTuqlsqu4LSTcifU8larRB+/2ARCuVGItp+7Glr6OH42MkUGvq/F01QMtatkFylPy16XKpJt2hb89uBrITecdwsJ+yh+zf1U4GrnkPHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iJjHdCdK; arc=fail smtp.client-ip=52.101.70.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m+C462w1YGUrC1yn3Xzy7piON222PzlEsmJds8n4pZfEO08yLU0h5X2p3H67YtTKIJQh4s7ZmC2BEoBjWAUA+TSnlCkPJr68h4hv4Q7+uKW6mbqT/khdYgZOaByoFSFtrPAXVrzC/mlcJIHsddTQYqHEZQfCebGR+9GuVvjCt1k4JMfbk2acRIQrucDhXe9gx6TtHyjFm2pTJYmUSX0RabKyi+01TJrUTw36sytaiMylh/GSiaEsOJERPrN9VeYO+sH9/fL2DCP65vB/9Nb3L6QPDYMBQOdZQHprR8DMiar5LmJm2w4zAMhSM/nn5CERGCllNLdH4cbCKSdUva+GRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DKm1j6ejRL/AH2ui09sTXphE6xORgTQz36q6N8k/Ek4=;
 b=oJMrwrY+mybif4jrMjrwHSlf7C/agaVq1I55CEGAnWOb9+OG5fHdVBGYfNP6+kCf/NaV5YErWRIR4wAf/MI1yRsM4tAuFww5hTWB0NpuGB23kn9qONXwdLz5Mg4nKpClaYqxFaPECRGjqdnnBZBZNsee2i6V0KPoJyhzfKVd3xVnxV+phPxYo7y//WGXHBBm3m4fC++zFQYxwlTkTLdnpQ9jaj+epuyqS1CLLhkkdl2zhciNJ0AW4IF0ikJKT1jamOOnKUrtpp8nvCY4+YqcT5y28Me9d3BHSEK0dRITio0/cA4ifbGecis2U24G2tTPKi4hUWdyCBjofYtNCMFBjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DKm1j6ejRL/AH2ui09sTXphE6xORgTQz36q6N8k/Ek4=;
 b=iJjHdCdKOvt2iMLkDsQLZwcpQptT7XX4/JJvJIoUfkjMMtAJvGfNJHSkQRmzvS2xXQMcc8i5mw+4LzBLywoJkCXrHIxkiLrmPwyVKrv3LuQbum4TsKKLqQ6fWFLHiguE2RgiKv+KAN9h35xugL/ivdiIOYXFl4kt5SW+TrUtOzvCMaoaFbKlcN/8Kgud+UFTTmGjZ2//wqmxEoVtyDJoGQKoGPrD/UT+xEHtrMpx/eBaYOIrU0mj3Jlm6BmYwCGye8ncvGUM0dnpzBKQGMFrLlVzm35iXpdFvnZgadU8E6eXpC5rKH1zkhCJCeSZLaVgTTKkvMdKtNIKdut3UTM/+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by DB9PR04MB11627.eurprd04.prod.outlook.com (2603:10a6:10:60c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 15:28:33 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 15:28:33 +0000
Date: Fri, 7 Nov 2025 10:28:24 -0500
From: Frank Li <Frank.li@nxp.com>
To: ming.qian@oss.nxp.com
Cc: mchehab@kernel.org, hverkuil-cisco@xs4all.nl, nicolas@ndufresne.ca,
	sebastian.fricke@collabora.com, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	linux-imx@nxp.com, xiahong.bao@nxp.com, eagle.zhou@nxp.com,
	imx@lists.linux.dev, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/4] media: v4l: dev-decoder: Add source change
 V4L2_EVENT_SRC_CH_COLORSPACE
Message-ID: <aQ4QGN2kdHxKwLBj@lizhi-Precision-Tower-5810>
References: <20250418085422.193-1-ming.qian@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418085422.193-1-ming.qian@oss.nxp.com>
X-ClientProxiedBy: PH0PR07CA0071.namprd07.prod.outlook.com
 (2603:10b6:510:f::16) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|DB9PR04MB11627:EE_
X-MS-Office365-Filtering-Correlation-Id: cc8b188b-2ca4-494f-17eb-08de1e124fe1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C10Y84H3NfzF3U11zeHj9CsIetnFvArbpEqIbG/cxI9PkhZn8j3gDV6hsGys?=
 =?us-ascii?Q?t1xuN+Lbx/ynSb9e8jiu8L2hbauJyBmxmsXhdFTatg9ZBVqFXPCz69Msm2Kp?=
 =?us-ascii?Q?WCrV4T8eERj7og7x6rXsQfn7u7L/sdbBNH9alSSNrk6SStqXFbaACfslqocR?=
 =?us-ascii?Q?5LR/qvuAVxnVcZLaYp7MaUKlzP/Pza+w3zuhzIsLbNtrp/FiWn1CBMXwlIuB?=
 =?us-ascii?Q?2KU97x/pUq3oj1fFqhg1bTi3+ojLBT/mCJ+FgC9faN6DamsYqF3wuTt+BytL?=
 =?us-ascii?Q?SfIkLoWiqGKJQPVOl2qK+b5IxaW141IUm67HJCyDCp96D0VVcrtcS/e4BwC6?=
 =?us-ascii?Q?wlYPB48p7l/H9Jh70J+PwMHUDuDrxxFPuR8eOl7OTtoiuAeo/WRl27PQhgzk?=
 =?us-ascii?Q?6tKO9WqNA5FyFgSF30tRw8Za3vaHSsYZJw9vTSG/UrD/U5cVupeMvgh3bhBX?=
 =?us-ascii?Q?b9MxLpYgNkQMkPDjKJrhF5GNTQLzOFBpEiUYvimGexleBivGn58CI2PWIGhG?=
 =?us-ascii?Q?kGfsK7/fhVHz+1lnfhW/qQIXQYAPbnYbJzf4qJ6P2JJZTw4Kqx3LE4Omi6uB?=
 =?us-ascii?Q?kRAYK9C5LSwLc7uHPvHMS3ZLziZvfvmQqe68TNuHOoWxt4AlG4oSiYjt1dKj?=
 =?us-ascii?Q?1H5D3ijAPushNyz797dh5Rr/YuokL81qVqeVdSMUCZK4OnK1WLB5Hif3LZRx?=
 =?us-ascii?Q?KF8WBqsD166taKiseCEJB6ZwxtIUknnyTjGqqep15Oxx2WkZOHzJy0k515/+?=
 =?us-ascii?Q?KqyzBNavTXGR7XjmY2h7mEZHomYfFDEUP8Pht7YUbG0S73QBHl8vGxbCzhQP?=
 =?us-ascii?Q?JX+2M8okobGH+MrDRCfThFaxd5pdl0bHdZspfQilu5/hxMRdcfIv3RpoAwIy?=
 =?us-ascii?Q?VZVkSW+owR3eBLcNYkc/KWaPOyltPbXLaKIpOT852/YH4B3mRrCtaRuLKv6W?=
 =?us-ascii?Q?vr+j0G8fTvL7sFGs1yGmZ+/OwlTp7etq/qjeELRW2i4XhbsHOdS8Hzn/2qGf?=
 =?us-ascii?Q?dxSl63fZLF3198dxfpAr9oL75tPTuv4nxcqejw7SFp81rmB7jrjM7Z+cMI+z?=
 =?us-ascii?Q?WSJ0A8E/vq+VstGfpN6t81SfUgXAO7RgRMCBDA43Kiu5Fc7+razAfIaKgRH1?=
 =?us-ascii?Q?yg65f+NZnc4MBYmZqEd0g0Yt4BNXh/chXEGTDYF3ozFcIzsTzE0jn4Fn0lng?=
 =?us-ascii?Q?TS1YINZQkzkxhRGSk/vztoAS1KVqVymu6uvYBtWQezmymVPIo09ZkIoDtYag?=
 =?us-ascii?Q?kSNezIMxJjXGw/+/2IiGVoam28249OXtaJiioKIbF/j9IRg1c46cLstHfN/j?=
 =?us-ascii?Q?ZIrY2n7eEwJ0KLZG62zlF4B6wnSxaq3U5KwcL56MVtTr5c4xTWbmJc+e7A1/?=
 =?us-ascii?Q?Np0QV/DkNiIu84n+WSV4u5lP1UZBg17tRV2tiIXkvEZGPiHsoIJh26nwzltQ?=
 =?us-ascii?Q?roo+/xkh5pkH7C1MgAeQjx06MhvEm2k4pY43XezP/mH+94lUjQ46F34XvXbo?=
 =?us-ascii?Q?BzDdsi5kVAZkoVibl7tWOcqD13ZDqVW8WnO4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7VyTY0iD5T43awPUS/I9GykcE27Jc4yM6IteMC/LRYRsS++sNtr+pK/NZfpk?=
 =?us-ascii?Q?eu0EfmRrEWyKjVkNQoghLQxCBOi2JSijW/W071ZU7Ku8oakpr4lbNdGqL0ux?=
 =?us-ascii?Q?iV6UQW/EsbfSPF+SJze6uFUOABCDMrPlRuoMrkJRDtbCs4uWcmsgF0xmXKYD?=
 =?us-ascii?Q?ob1HGtJuMomevq4D1r17OEnZMdKKZnsoGJlAvdukbV8ZP2b0r1qvcxniL8Ii?=
 =?us-ascii?Q?C3J4Tpek0TYA2rPh9tpuVxezaPFTq5POcGioNmj45J0Qtr3o0JGpje4uNwmd?=
 =?us-ascii?Q?7YeYVm9CF/CYGfqLlKueIJIfShLHmABfIXeIDnYK3m1O0EAR/eA7qoj43cOr?=
 =?us-ascii?Q?hd9p01AovGUwFnLoxwz3toUfynPtncE96Zp3wqRB88ZddsqxhNgtIoSv9Wzg?=
 =?us-ascii?Q?4hld1cfSTYpZt+EqcbHhMC0LVleF5FihwWNCzIPqqxTyrShhKyBWCDyK4Ar1?=
 =?us-ascii?Q?9upylprGVqFFXpmAWAht1abkdrTEU382LWkIJeW+Eax0lCnBLgWUUDSC0HCp?=
 =?us-ascii?Q?HdVU7JjanWNcoTrG2uO09wwIsPhPwas/NniTZzQMk2KFQysTlf4F3B3AjMR2?=
 =?us-ascii?Q?iqjpStFInXiTfQ/lHDKi2gim1p0rSLkWq5kR40hImSsUMXhrtBLD1rjAjYnv?=
 =?us-ascii?Q?9mccFJWQ9ATA0qFudKUvTCQmz5AbWAhFdeVX5n8Jkc3LqkctuAuj1CLMmAbQ?=
 =?us-ascii?Q?9eSlvh8yLDhRrF4E4SbUkuJLd+URlR9XAnmNHfcJ+6FkvYkgt44glNvlrVoM?=
 =?us-ascii?Q?3Xth9IPjMcw3XgpIlS6/c2hKNbVj8R64MQTHqVeqmjMR05dG6JI+3knXhsmA?=
 =?us-ascii?Q?X74DnQ+VcFP0aBFdsVfYiaEjNdWmesNr7PounTGrOtUgdwna0JyV1V7Gvnix?=
 =?us-ascii?Q?5REOmgeSPTs14kSkuh9CaSz6GkNX/KJ9po3ZlwrAFKqmPiWNJRjg80hVj6Ws?=
 =?us-ascii?Q?Dzp3/5vda03XqnrcFZkLQOziwCfKrPxx9OT55RC4R1gmUU4SNGbjLjREwJD6?=
 =?us-ascii?Q?Iuj0oh1bC5W5eJxKXdZ4DzTZcTUXsJjCGsqOgok1tNf19QyfnfafOCdI+QRN?=
 =?us-ascii?Q?HNqxoGDzVG3VXnZOMSuBdJkrXq3Z3IeSvBjqWLQkcdb4grBiKLTcqvqZAqDe?=
 =?us-ascii?Q?0mTDVayM46R1CK78y9kho6hJYQN98cu0q5Pz/uV0ys4x2tToOQhmV34UPQ7h?=
 =?us-ascii?Q?reamkXTL2wPFrvZvWofqeOxUrvfCRMvaz+/m7Ww1hMBXtCRBcpjI72QddSKm?=
 =?us-ascii?Q?9gCbw5bRsAGlwf+CGa5K7CJosZ9u4AZUlzMVhremwxwukEGmtJJjn6IqyI14?=
 =?us-ascii?Q?04AtDs+knVo7DY4aepAThleJMAlm+LP8rDBYAYz5RX/gaUKc25y1dMluTdkq?=
 =?us-ascii?Q?wN6Fvq29+ZuNCHJR19DXoMbUaQXt8m+3CSLyLnAiun2FyUR+sSLRWGReVvO1?=
 =?us-ascii?Q?33LPQwe+0xyKJQ/pyhkQNa68hQmd0PXfVrlCjqUKJBe8SG8RMS/eC2dygi9B?=
 =?us-ascii?Q?MftnqteX8CHUJ8e0BVoYeOTeiFAtZ/hnp7DEWlR8llix/qtDfBPyL0y/EEAo?=
 =?us-ascii?Q?v8gpJsO5++AdRJxAhHs=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc8b188b-2ca4-494f-17eb-08de1e124fe1
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 15:28:33.4011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dUenlaFeULeBvUHJkS8KiJ4OfBwCok06y2yKDZICXEs8mTfoslf+6N8ufU0xLTQo7tOSJQRpaJBhzENiQ5dFjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB11627

On Fri, Apr 18, 2025 at 04:54:16PM +0800, ming.qian@oss.nxp.com wrote:
> From: Ming Qian <ming.qian@oss.nxp.com>
>
> Add a new source change V4L2_EVENT_SRC_CH_COLORSPACE that
                   change event V4l2...

> indicates colorspace change in the stream.

wrap at 75 char and add empty line between paragraph.

> The change V4L2_EVENT_SRC_CH_RESOLUTION will always affect
  The event ...

Frank
> the allocation, but V4L2_EVENT_SRC_CH_COLORSPACE won't.
>
> Signed-off-by: Ming Qian <ming.qian@oss.nxp.com>
> ---
> v3
> - Improve the description according to comments
>
>  .../userspace-api/media/v4l/vidioc-dqevent.rst       | 12 ++++++++++++
>  .../userspace-api/media/videodev2.h.rst.exceptions   |  1 +
>  include/uapi/linux/videodev2.h                       |  1 +
>  3 files changed, 14 insertions(+)
>
> diff --git a/Documentation/userspace-api/media/v4l/vidioc-dqevent.rst b/Documentation/userspace-api/media/v4l/vidioc-dqevent.rst
> index 8db103760930..f317af57a92c 100644
> --- a/Documentation/userspace-api/media/v4l/vidioc-dqevent.rst
> +++ b/Documentation/userspace-api/media/v4l/vidioc-dqevent.rst
> @@ -369,6 +369,18 @@ call.
>  	loss of signal and so restarting streaming I/O is required in order for
>  	the hardware to synchronize to the video signal.
>
> +    * - ``V4L2_EVENT_SRC_CH_COLORSPACE``
> +      - 0x0002
> +      - This event gets triggered when a colorspace change is detected at
> +	an input. This can come from a video decoder or a video receiver.
> +	Applications will query the new colorspace information
> +	(if any, the signal may also have been lost). If the signal is lost,
> +	then that is a CH_RESOLUTION change, not CH_COLORSPACE.
> +
> +	For stateful decoders follow the guidelines in :ref:`decoder`.
> +	If CH_COLORSPACE is set, but not CH_RESOLUTION, then only the
> +	colorspace changed and there is no need to reallocate buffers.
> +
>  Return Value
>  ============
>
> diff --git a/Documentation/userspace-api/media/videodev2.h.rst.exceptions b/Documentation/userspace-api/media/videodev2.h.rst.exceptions
> index 35d3456cc812..ac47c6d9448b 100644
> --- a/Documentation/userspace-api/media/videodev2.h.rst.exceptions
> +++ b/Documentation/userspace-api/media/videodev2.h.rst.exceptions
> @@ -526,6 +526,7 @@ replace define V4L2_EVENT_CTRL_CH_RANGE ctrl-changes-flags
>  replace define V4L2_EVENT_CTRL_CH_DIMENSIONS ctrl-changes-flags
>
>  replace define V4L2_EVENT_SRC_CH_RESOLUTION src-changes-flags
> +replace define V4L2_EVENT_SRC_CH_COLORSPACE src-changes-flags
>
>  replace define V4L2_EVENT_MD_FL_HAVE_FRAME_SEQ :c:type:`v4l2_event_motion_det`
>
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> index c8cb2796130f..242242c8e57b 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -2559,6 +2559,7 @@ struct v4l2_event_frame_sync {
>  };
>
>  #define V4L2_EVENT_SRC_CH_RESOLUTION		(1 << 0)
> +#define V4L2_EVENT_SRC_CH_COLORSPACE		(1 << 1)
>
>  struct v4l2_event_src_change {
>  	__u32 changes;
> --
> 2.43.0-rc1
>

