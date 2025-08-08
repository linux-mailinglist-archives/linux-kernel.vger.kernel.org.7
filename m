Return-Path: <linux-kernel+bounces-760790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA4FB1F028
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 23:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 542721AA6D87
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 21:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7407B255F3F;
	Fri,  8 Aug 2025 21:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="MES/jXua"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A01D1F2BB5
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 21:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754687255; cv=none; b=c0IRMewnDg99dvJi5EnZCd9bhBLAGmmd0gPFzLjPLQwRFp4oDCniyzWJhPiXEfeA7w8g3/TnUqLXion7eW/IZMb7WBeemfo10215A01bO0hxJSNnYZUW2BIa+tiTF99FzI+sYjKAkE9pajabjZVNg0RSesigxOfLgvHzQm1Z4sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754687255; c=relaxed/simple;
	bh=tcxHkUheTKaMpvRXPpvP60VqhMSI5uaUZ+jA4ECsmew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rAigOc7JeFgn0n2wRXWEvMeUovpPKGmMF21Lr8OLKIIe7U1oGAqGpchFq8bo8BTgUrDcffiFMH005RUBSNFRDe9WhEqAPjmdYfnULD1QBbDIr0Ro2vpZGEgJQ4FZKovDgX2OgEwrKrLx6WIDzcW7euvifAPEljMcwhr3en72kik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=MES/jXua; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1ZE2xvEV5PnemVdZ0MxchTi5EMFs63TGOUmJ0xYtRso=; b=MES/jXuaSiVdVDyafZmuiR4i5n
	CotnKw9PosqzLpahCNClzYJ96Bp3bDb7yvkOa7dE+PtqHUlxDzRAV1wq5lr7ceHIVuyiigocRsiHT
	efSg1gLPFgo+uf4HES3t2L+dCBZ1PaCLfJZmjuv4NhszxMUPdpQLNywqHKVBOP4i7SAR85jriTHaL
	dokXN88wJCrW8xL8RirKbrrQGqygYQHI8iKuhoMgAWWqLP36/T7sbW5X+GVW/9SbQMGN0efjEVuyc
	DNBa69qP4EIGBhdIdkpmLu2g71cm5lhG84jUhhi3rAxQhxPxT2Jr7QRB/KLSk0RPay/AWuJrqKQBq
	iWHT3LCQ==;
Received: from [189.7.87.79] (helo=[192.168.0.7])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1ukUJ9-00BijS-Ay; Fri, 08 Aug 2025 23:07:23 +0200
Message-ID: <e4fe98ba-866c-4b59-bda4-0519d585a3db@igalia.com>
Date: Fri, 8 Aug 2025 18:07:18 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/vc4: plane: Add support for P01[026] and
 S01[026] formats
To: Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Maxime Ripard <mripard@kernel.org>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Robert Mader <robert.mader@collabora.com>
References: <20250807-drm-vc4-extra-formats-v2-0-fadc93844551@raspberrypi.com>
 <20250807-drm-vc4-extra-formats-v2-2-fadc93844551@raspberrypi.com>
Content-Language: en-US
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
In-Reply-To: <20250807-drm-vc4-extra-formats-v2-2-fadc93844551@raspberrypi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Dave,

On 07/08/25 10:28, Dave Stevenson wrote:
> There are now formats defined for 2-plane YUV420 at 10, 12,
> and 16 bit depth using the most significant bits of the 16bit
> word (P010, P012, and P016), and 3-plane YUV420 at those
> depths using the least significant bits of the 16 bit word
> (S010, S012, and S016).
> 
> VC4_GEN_6 can support all those formats although only using
> at most 10bits of resolution.
> Add them as supported formats for all planes, but filtered
> by hardware revision.
> 
> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

Acked-by: Maíra Canal <mcanal@igalia.com>

Best Regards,
- Maíra

> ---
>   drivers/gpu/drm/vc4/vc4_plane.c | 42 +++++++++++++++++++++++++++++++++++++++++
>   drivers/gpu/drm/vc4/vc4_regs.h  |  9 +++++++++
>   2 files changed, 51 insertions(+)
> 
> diff --git a/drivers/gpu/drm/vc4/vc4_plane.c b/drivers/gpu/drm/vc4/vc4_plane.c
> index 3bdd9466a7b0..5fc26f705425 100644
> --- a/drivers/gpu/drm/vc4/vc4_plane.c
> +++ b/drivers/gpu/drm/vc4/vc4_plane.c
> @@ -247,6 +247,42 @@ static const struct hvs_format {
>   		.pixel_order = HVS_PIXEL_ORDER_BGRA,
>   		.pixel_order_hvs5 = HVS_PIXEL_ORDER_RGBA,
>   	},
> +	{
> +		.drm = DRM_FORMAT_P010,
> +		.hvs = HVS_PIXEL_FORMAT_YCBCR_YUV420_15_6_2PLANE,
> +		.pixel_order_hvs5 = HVS_PIXEL_ORDER_XYCBCR,
> +		.min_gen = VC4_GEN_6_C,
> +	},
> +	{
> +		.drm = DRM_FORMAT_P012,
> +		.hvs = HVS_PIXEL_FORMAT_YCBCR_YUV420_15_6_2PLANE,
> +		.pixel_order_hvs5 = HVS_PIXEL_ORDER_XYCBCR,
> +		.min_gen = VC4_GEN_6_C,
> +	},
> +	{
> +		.drm = DRM_FORMAT_P016,
> +		.hvs = HVS_PIXEL_FORMAT_YCBCR_YUV420_15_6_2PLANE,
> +		.pixel_order_hvs5 = HVS_PIXEL_ORDER_XYCBCR,
> +		.min_gen = VC4_GEN_6_C,
> +	},
> +	{
> +		.drm = DRM_FORMAT_S010,
> +		.hvs = HVS_PIXEL_FORMAT_YCBCR_YUV420_9_0_3PLANE,
> +		.pixel_order_hvs5 = HVS_PIXEL_ORDER_XYCBCR,
> +		.min_gen = VC4_GEN_6_C,
> +	},
> +	{
> +		.drm = DRM_FORMAT_S012,
> +		.hvs = HVS_PIXEL_FORMAT_YCBCR_YUV420_11_2_3PLANE,
> +		.pixel_order_hvs5 = HVS_PIXEL_ORDER_XYCBCR,
> +		.min_gen = VC4_GEN_6_C,
> +	},
> +	{
> +		.drm = DRM_FORMAT_S016,
> +		.hvs = HVS_PIXEL_FORMAT_YCBCR_YUV420_15_6_3PLANE,
> +		.pixel_order_hvs5 = HVS_PIXEL_ORDER_XYCBCR,
> +		.min_gen = VC4_GEN_6_C,
> +	},
>   };
>   
>   static const struct hvs_format *vc4_get_hvs_format(u32 drm_format)
> @@ -2490,6 +2526,12 @@ static bool vc4_format_mod_supported(struct drm_plane *plane,
>   	case DRM_FORMAT_YVU420:
>   	case DRM_FORMAT_NV16:
>   	case DRM_FORMAT_NV61:
> +	case DRM_FORMAT_P010:
> +	case DRM_FORMAT_P012:
> +	case DRM_FORMAT_P016:
> +	case DRM_FORMAT_S010:
> +	case DRM_FORMAT_S012:
> +	case DRM_FORMAT_S016:
>   	default:
>   		return (modifier == DRM_FORMAT_MOD_LINEAR);
>   	}
> diff --git a/drivers/gpu/drm/vc4/vc4_regs.h b/drivers/gpu/drm/vc4/vc4_regs.h
> index 27158be19952..4536e3c0533b 100644
> --- a/drivers/gpu/drm/vc4/vc4_regs.h
> +++ b/drivers/gpu/drm/vc4/vc4_regs.h
> @@ -1079,6 +1079,15 @@ enum hvs_pixel_format {
>   	HVS_PIXEL_FORMAT_AYUV444_RGB = 15,
>   	HVS_PIXEL_FORMAT_RGBA1010102 = 16,
>   	HVS_PIXEL_FORMAT_YCBCR_10BIT = 17,
> +	/* 10 bit YUV420 formats with data with various alignments */
> +	HVS_PIXEL_FORMAT_YCBCR_YUV420_15_6_2PLANE = 24,
> +	HVS_PIXEL_FORMAT_YCBCR_YUV420_15_6_3PLANE = 25,
> +	HVS_PIXEL_FORMAT_YCBCR_YUV420_13_4_2PLANE = 26,
> +	HVS_PIXEL_FORMAT_YCBCR_YUV420_13_4_3PLANE = 27,
> +	HVS_PIXEL_FORMAT_YCBCR_YUV420_11_2_2PLANE = 28,
> +	HVS_PIXEL_FORMAT_YCBCR_YUV420_11_2_3PLANE = 29,
> +	HVS_PIXEL_FORMAT_YCBCR_YUV420_9_0_2PLANE = 30,
> +	HVS_PIXEL_FORMAT_YCBCR_YUV420_9_0_3PLANE = 31,
>   };
>   
>   /* Note: the LSB is the rightmost character shown.  Only valid for
> 


