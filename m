Return-Path: <linux-kernel+bounces-760761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9F2B1EFDC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 22:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1C207B729B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 20:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1214121CC6A;
	Fri,  8 Aug 2025 20:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="U9KmCqY7"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C294A11
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 20:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754686074; cv=none; b=E+1KVQ7fohc0AbxVKRnceJ9YSFlFZ2lIEtxHLyTeBMGxnsWSGyFi928nRCFRjIjEcATxRDnffL1NzeJCfERMZTf36msQih1wIrKaGfs72bhLEfP6sLv+yoyNlkTLyLNM14+84N4CBr+VHChC+xVojXWkLsX+CRj2gflsLFWN5oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754686074; c=relaxed/simple;
	bh=PxIQesoBG/GdT3V2JGa/pgIe3vLwcd+LYg1wxF/57mY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MF81BmUKYN2iAos1Cu7D0SjChB5CrBzN1h5iW1lk8ZYLUrGiGq5BXTzlr/t1DT7/EOxSwl3R2Tmi9zaOmfCsnhI0ySp5alQ47bDdo39QqgPHLu6bFZHOknQFtghNHRXAr9t/1ZHKE2J1/LIMLgvTd5gM4/xk1owfSRo4fltjPpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=U9KmCqY7; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3UHBFltu+vWIROL/lI0FPk1dZsJaXVXBDCV7KGLpb8o=; b=U9KmCqY7P3ykFDOHf/nsSF+IIu
	orXKYqvEvrGXGrn40bEFIAEH1WQdOE8SXVDo6nA+aKFP9mzsLpBWpqajaWTtgK9X9C/Q+n4vui+q3
	awtIboJkKYEl7Z8W3rswP/o3CW77F8xZ84/C/p/xMcC0rDLbNpl3NKDkHpM9NdSX1CvlJXEfatUN7
	tpLMTfHJ2RYCN2m74LHKfncA92oqChTYBqDygG7uhD/TG6+r4CGpYaqkWO5+qmDqfsXfSqaPYzhY9
	m0coy7E1OTVEMRAIILDFJ9ZgmaN4mQxCxIXNARCnIcTXcvMoKB5ghEiuvdTtMNGwIdLwnhA/RJevx
	ZPy/9bNg==;
Received: from [189.7.87.79] (helo=[192.168.0.7])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1ukTzu-00Bi2m-8O; Fri, 08 Aug 2025 22:47:30 +0200
Message-ID: <ffdd997c-51e0-40db-bdfd-ef4094bf1ad7@igalia.com>
Date: Fri, 8 Aug 2025 17:47:24 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/vc4: plane: Flag formats as having a minimum
 generation
To: Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Maxime Ripard <mripard@kernel.org>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Robert Mader <robert.mader@collabora.com>
References: <20250807-drm-vc4-extra-formats-v2-0-fadc93844551@raspberrypi.com>
 <20250807-drm-vc4-extra-formats-v2-1-fadc93844551@raspberrypi.com>
Content-Language: en-US
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
In-Reply-To: <20250807-drm-vc4-extra-formats-v2-1-fadc93844551@raspberrypi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Dave,

On 07/08/25 10:28, Dave Stevenson wrote:
> The bool hvs5_only is now mis-named as they are also supported on
> hvs6, and we're about to add formats that are only supported on
> hvs6.
> 
> Change from a bool to an enum vc4_gen giving the minimum generation
> that supports the format.
> 
> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

Reviewed-by: Maíra Canal <mcanal@igalia.com>

Best Regards,
- Maíra

> ---
>   drivers/gpu/drm/vc4/vc4_plane.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vc4/vc4_plane.c b/drivers/gpu/drm/vc4/vc4_plane.c
> index 056d344c5411..3bdd9466a7b0 100644
> --- a/drivers/gpu/drm/vc4/vc4_plane.c
> +++ b/drivers/gpu/drm/vc4/vc4_plane.c
> @@ -35,7 +35,7 @@ static const struct hvs_format {
>   	u32 hvs; /* HVS_FORMAT_* */
>   	u32 pixel_order;
>   	u32 pixel_order_hvs5;
> -	bool hvs5_only;
> +	enum vc4_gen min_gen;
>   } hvs_formats[] = {
>   	{
>   		.drm = DRM_FORMAT_XRGB8888,
> @@ -161,31 +161,31 @@ static const struct hvs_format {
>   		.drm = DRM_FORMAT_P030,
>   		.hvs = HVS_PIXEL_FORMAT_YCBCR_10BIT,
>   		.pixel_order_hvs5 = HVS_PIXEL_ORDER_XYCBCR,
> -		.hvs5_only = true,
> +		.min_gen = VC4_GEN_5,
>   	},
>   	{
>   		.drm = DRM_FORMAT_XRGB2101010,
>   		.hvs = HVS_PIXEL_FORMAT_RGBA1010102,
>   		.pixel_order_hvs5 = HVS_PIXEL_ORDER_ARGB,
> -		.hvs5_only = true,
> +		.min_gen = VC4_GEN_5,
>   	},
>   	{
>   		.drm = DRM_FORMAT_ARGB2101010,
>   		.hvs = HVS_PIXEL_FORMAT_RGBA1010102,
>   		.pixel_order_hvs5 = HVS_PIXEL_ORDER_ARGB,
> -		.hvs5_only = true,
> +		.min_gen = VC4_GEN_5,
>   	},
>   	{
>   		.drm = DRM_FORMAT_ABGR2101010,
>   		.hvs = HVS_PIXEL_FORMAT_RGBA1010102,
>   		.pixel_order_hvs5 = HVS_PIXEL_ORDER_ABGR,
> -		.hvs5_only = true,
> +		.min_gen = VC4_GEN_5,
>   	},
>   	{
>   		.drm = DRM_FORMAT_XBGR2101010,
>   		.hvs = HVS_PIXEL_FORMAT_RGBA1010102,
>   		.pixel_order_hvs5 = HVS_PIXEL_ORDER_ABGR,
> -		.hvs5_only = true,
> +		.min_gen = VC4_GEN_5,
>   	},
>   	{
>   		.drm = DRM_FORMAT_RGB332,
> @@ -2524,7 +2524,7 @@ struct drm_plane *vc4_plane_init(struct drm_device *dev,
>   	};
>   
>   	for (i = 0; i < ARRAY_SIZE(hvs_formats); i++) {
> -		if (!hvs_formats[i].hvs5_only || vc4->gen >= VC4_GEN_5) {
> +		if (vc4->gen >= hvs_formats[i].min_gen) {
>   			formats[num_formats] = hvs_formats[i].drm;
>   			num_formats++;
>   		}
> 


