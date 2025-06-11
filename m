Return-Path: <linux-kernel+bounces-682436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 726F7AD6002
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 22:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05E097A98E4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 20:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7766023644D;
	Wed, 11 Jun 2025 20:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="YpWeAupw"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6BD1DE4CD
	for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 20:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749673488; cv=none; b=ss9LY4t+VjVK5Aup/jFU27LtqskH/oRDHtFsAMa8j8PJZdg3DQtwj2C4PNKh1YmMK6Uq3h1t1QI7ptwwfote+E9pBmkbC973t/75cMWtda3vWKKAfv6DOMnnSYECOIixHeDFas04NugCed8ctLlZUwRwVQC6rU52jqmN5dhNxb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749673488; c=relaxed/simple;
	bh=fxigtX9/6pxEfcZeYEa4Qq7eq7CNRp0NUnEc6J7Nh70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HJ6RmiwjEUg2nbJru+6LNgO/aj5128duYoVAHQm5PNdYrByOdyX0kQJ9jH1IgarDwucEtfLW8hkDPXfviA0/M5qajXHkE0Rj/OVy5rjMlAPFr43VdOCCThcmPOGk3Chvnz9B1n7BSlc4wGQpuTM6Kvslc6RkR/QMVtCu1RhIatM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=YpWeAupw; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=urMjQ5pcYA9bXztsxyIkm8DNknDyIXbtY9fAwYXwP4w=; b=YpWeAupwXY3qCcRctIorCceEN5
	LCEytFR3x2mr9Q+BKbyaZm/SMTADN3IUKWWTupspYGRayaNMZwvAXPy7/sSwO5af4qas5kR5qCgjU
	u2NsFwF8cuGDXtsG0hAXiI3v5YdOhZrt4hDM+SOLsJwR6bs7Fwjeytew0jd+twGyZRZWB0iXjRvJH
	OftDrhu3+aaTOhtNJuvGe7tHOgH0p362W2e1tbK80+YwAQKmFRcmqOo8S7xz9bC1BqcJVdTp5xVmr
	fNgesq3HEiTNPmeQJf50XCkoccjwJCb5FWzNaI74P6GDnj/f9jqdr5Q3b6PYxXVnh8yI+Rdv/i0Nx
	cHCx2zEg==;
Received: from [187.36.208.198] (helo=[192.168.1.111])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1uPRzq-002M63-Ls; Wed, 11 Jun 2025 22:24:30 +0200
Message-ID: <0d522681-8a48-4f66-9b4c-32966068c6b8@igalia.com>
Date: Wed, 11 Jun 2025 17:24:22 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/8] drm/vkms: Change YUV helpers to support u16 inputs
 for conversion
To: Louis Chauvet <louis.chauvet@bootlin.com>,
 Melissa Wen <melissa.srw@gmail.com>, =?UTF-8?Q?Ma=C3=ADra_Canal?=
 <mairacanal@riseup.net>, Haneen Mohammed <hamohammed.sa@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Simona Vetter <simona.vetter@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, arthurgrillo@riseup.net,
 linux-kernel@vger.kernel.org, jeremie.dautheribes@bootlin.com,
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
 seanpaul@google.com, nicolejadeyee@google.com
References: <20250530-b4-new-color-formats-v4-0-ef5f9f48376c@bootlin.com>
 <20250530-b4-new-color-formats-v4-6-ef5f9f48376c@bootlin.com>
Content-Language: en-US
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Autocrypt: addr=mcanal@igalia.com; keydata=
 xsBNBGcCwywBCADgTji02Sv9zjHo26LXKdCaumcSWglfnJ93rwOCNkHfPIBll85LL9G0J7H8
 /PmEL9y0LPo9/B3fhIpbD8VhSy9Sqz8qVl1oeqSe/rh3M+GceZbFUPpMSk5pNY9wr5raZ63d
 gJc1cs8XBhuj1EzeE8qbP6JAmsL+NMEmtkkNPfjhX14yqzHDVSqmAFEsh4Vmw6oaTMXvwQ40
 SkFjtl3sr20y07cJMDe++tFet2fsfKqQNxwiGBZJsjEMO2T+mW7DuV2pKHr9aifWjABY5EPw
 G7qbrh+hXgfT+njAVg5+BcLz7w9Ju/7iwDMiIY1hx64Ogrpwykj9bXav35GKobicCAwHABEB
 AAHNIE1hw61yYSBDYW5hbCA8bWNhbmFsQGlnYWxpYS5jb20+wsCRBBMBCAA7FiEE+ORdfQEW
 dwcppnfRP/MOinaI+qoFAmcCwywCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQ
 P/MOinaI+qoUBQgAqz2gzUP7K3EBI24+a5FwFlruQGtim85GAJZXToBtzsfGLLVUSCL3aF/5
 O335Bh6ViSBgxmowIwVJlS/e+L95CkTGzIIMHgyUZfNefR2L3aZA6cgc9z8cfow62Wu8eXnq
 GM/+WWvrFQb/dBKKuohfBlpThqDWXxhozazCcJYYHradIuOM8zyMtCLDYwPW7Vqmewa+w994
 7Lo4CgOhUXVI2jJSBq3sgHEPxiUBOGxvOt1YBg7H9C37BeZYZxFmU8vh7fbOsvhx7Aqu5xV7
 FG+1ZMfDkv+PixCuGtR5yPPaqU2XdjDC/9mlRWWQTPzg74RLEw5sz/tIHQPPm6ROCACFls7A
 TQRnAsMsAQgAxTU8dnqzK6vgODTCW2A6SAzcvKztxae4YjRwN1SuGhJR2isJgQHoOH6oCItW
 Xc1CGAWnci6doh1DJvbbB7uvkQlbeNxeIz0OzHSiB+pb1ssuT31Hz6QZFbX4q+crregPIhr+
 0xeDi6Mtu+paYprI7USGFFjDUvJUf36kK0yuF2XUOBlF0beCQ7Jhc+UoI9Akmvl4sHUrZJzX
 LMeajARnSBXTcig6h6/NFVkr1mi1uuZfIRNCkxCE8QRYebZLSWxBVr3h7dtOUkq2CzL2kRCK
 T2rKkmYrvBJTqSvfK3Ba7QrDg3szEe+fENpL3gHtH6h/XQF92EOulm5S5o0I+ceREwARAQAB
 wsB2BBgBCAAgFiEE+ORdfQEWdwcppnfRP/MOinaI+qoFAmcCwywCGwwACgkQP/MOinaI+qpI
 zQf+NAcNDBXWHGA3lgvYvOU31+ik9bb30xZ7IqK9MIi6TpZqL7cxNwZ+FAK2GbUWhy+/gPkX
 it2gCAJsjo/QEKJi7Zh8IgHN+jfim942QZOkU+p/YEcvqBvXa0zqW0sYfyAxkrf/OZfTnNNE
 Tr+uBKNaQGO2vkn5AX5l8zMl9LCH3/Ieaboni35qEhoD/aM0Kpf93PhCvJGbD4n1DnRhrxm1
 uEdQ6HUjWghEjC+Jh9xUvJco2tUTepw4OwuPxOvtuPTUa1kgixYyG1Jck/67reJzMigeuYFt
 raV3P8t/6cmtawVjurhnCDuURyhUrjpRhgFp+lW8OGr6pepHol/WFIOQEg==
In-Reply-To: <20250530-b4-new-color-formats-v4-6-ef5f9f48376c@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Louis,

On 5/30/25 11:06, Louis Chauvet wrote:
> Some YUV format uses 16 bit values, so change the helper function for
> conversion to support those new formats.
> 
> Add support for the YUV format P010

Hum, I don't think this patch added support for P010.

> 
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
>   drivers/gpu/drm/vkms/tests/vkms_format_test.c | 103 +++++++++++++-------------
>   drivers/gpu/drm/vkms/vkms_formats.c           |  26 ++++---
>   drivers/gpu/drm/vkms/vkms_formats.h           |   4 +-
>   3 files changed, 68 insertions(+), 65 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/tests/vkms_format_test.c b/drivers/gpu/drm/vkms/tests/vkms_format_test.c
> index 2e1daef94831..272e18a82f9c 100644
> --- a/drivers/gpu/drm/vkms/tests/vkms_format_test.c
> +++ b/drivers/gpu/drm/vkms/tests/vkms_format_test.c
> @@ -23,7 +23,7 @@ MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
>    *     machine endianness
>    */
>   struct pixel_yuv_u8 {
> -	u8 y, u, v;
> +	u16 y, u, v;
>   };
>   
>   /*
> @@ -64,7 +64,7 @@ static struct yuv_u8_to_argb_u16_case yuv_u8_to_argb_u16_cases[] = {
>   	 *                     in_bits = 16,
>   	 *                     in_legal = False,
>   	 *                     in_int = True,
> -	 *                     out_bits = 8,
> +	 *                     out_bits = 16,
>   	 *                     out_legal = False,
>   	 *                     out_int = True)
>   	 *
> @@ -76,13 +76,13 @@ static struct yuv_u8_to_argb_u16_case yuv_u8_to_argb_u16_cases[] = {
>   		.range = DRM_COLOR_YCBCR_FULL_RANGE,
>   		.n_colors = 6,
>   		.colors = {
> -			{ "white", { 0xff, 0x80, 0x80 }, { 0xffff, 0xffff, 0xffff, 0xffff }},
> -			{ "gray",  { 0x80, 0x80, 0x80 }, { 0xffff, 0x8080, 0x8080, 0x8080 }},
> -			{ "black", { 0x00, 0x80, 0x80 }, { 0xffff, 0x0000, 0x0000, 0x0000 }},
> -			{ "red",   { 0x4c, 0x55, 0xff }, { 0xffff, 0xffff, 0x0000, 0x0000 }},
> -			{ "green", { 0x96, 0x2c, 0x15 }, { 0xffff, 0x0000, 0xffff, 0x0000 }},
> -			{ "blue",  { 0x1d, 0xff, 0x6b }, { 0xffff, 0x0000, 0x0000, 0xffff }},
> -		},
> +			{ "white",	{ 0xffff, 0x8000, 0x8000 }, { 0xffff, 0xffff, 0xffff, 0xffff }},
> +			{ "gray",	{ 0x8080, 0x8000, 0x8000 }, { 0xffff, 0x8080, 0x8080, 0x8080 }},
> +			{ "black",	{ 0x0000, 0x8000, 0x8000 }, { 0xffff, 0x0000, 0x0000, 0x0000 }},
> +			{ "red",	{ 0x4c8b, 0x54ce, 0xffff }, { 0xffff, 0xffff, 0x0000, 0x0000 }},
> +			{ "green",	{ 0x9645, 0x2b33, 0x14d1 }, { 0xffff, 0x0000, 0xffff, 0x0000 }},
> +			{ "blue",	{ 0x1d2f, 0xffff, 0x6b2f }, { 0xffff, 0x0000, 0x0000, 0xffff }},

Is there an explicit need of those tabs? They make the line length
exceed 100 columns.

[...]

> diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
> index 5106441f916b..261e822e9618 100644
> --- a/drivers/gpu/drm/vkms/vkms_formats.c
> +++ b/drivers/gpu/drm/vkms/vkms_formats.c
> @@ -279,16 +279,17 @@ static struct pixel_argb_u16 argb_u16_from_BGR565(const __le16 *pixel)
>   	return out_pixel;
>   }
>   
> -VISIBLE_IF_KUNIT struct pixel_argb_u16 argb_u16_from_yuv888(u8 y, u8 channel_1, u8 channel_2,
> -							    const struct conversion_matrix *matrix)
> +VISIBLE_IF_KUNIT
> +struct pixel_argb_u16 argb_u16_from_yuv161616(const struct conversion_matrix *matrix,
> +					      u16 y, u16 channel_1, u16 channel_2)
>   {
>   	u16 r, g, b;
>   	s64 fp_y, fp_channel_1, fp_channel_2;
>   	s64 fp_r, fp_g, fp_b;
>   
> -	fp_y = drm_int2fixp(((int)y - matrix->y_offset) * 257);
> -	fp_channel_1 = drm_int2fixp(((int)channel_1 - 128) * 257);
> -	fp_channel_2 = drm_int2fixp(((int)channel_2 - 128) * 257);
> +	fp_y = drm_int2fixp((int)y - matrix->y_offset * 257);
> +	fp_channel_1 = drm_int2fixp((int)channel_1 - 128 * 257);
> +	fp_channel_2 = drm_int2fixp((int)channel_2 - 128 * 257);
 >   >   	fp_r = drm_fixp_mul(matrix->matrix[0][0], fp_y) +
>   	       drm_fixp_mul(matrix->matrix[0][1], fp_channel_1) +
> @@ -310,7 +311,7 @@ VISIBLE_IF_KUNIT struct pixel_argb_u16 argb_u16_from_yuv888(u8 y, u8 channel_1,
>   
>   	return argb_u16_from_u16161616(0xffff, r, g, b);
>   }
> -EXPORT_SYMBOL_IF_KUNIT(argb_u16_from_yuv888);
> +EXPORT_SYMBOL_IF_KUNIT(argb_u16_from_yuv161616);
>   
>   /**
>    * READ_LINE() - Generic generator for a read_line function which can be used for format with one
> @@ -504,8 +505,8 @@ static void semi_planar_yuv_read_line(const struct vkms_plane_state *plane, int
>   	const struct conversion_matrix *conversion_matrix = &plane->conversion_matrix;
>   
>   	for (int i = 0; i < count; i++) {
> -		*out_pixel = argb_u16_from_yuv888(y_plane[0], uv_plane[0], uv_plane[1],
> -						  conversion_matrix);
> +		*out_pixel = argb_u16_from_yuv161616(conversion_matrix, y_plane[0] * 257,
> +						     uv_plane[0] * 257, uv_plane[1] * 257);
>   		out_pixel += 1;
>   		y_plane += step_y;
>   		if ((i + subsampling_offset + 1) % subsampling == 0)
> @@ -549,8 +550,9 @@ static void planar_yuv_read_line(const struct vkms_plane_state *plane, int x_sta
>   	const struct conversion_matrix *conversion_matrix = &plane->conversion_matrix;
>   
>   	for (int i = 0; i < count; i++) {
> -		*out_pixel = argb_u16_from_yuv888(*y_plane, *channel_1_plane, *channel_2_plane,
> -						  conversion_matrix);
> +		*out_pixel = argb_u16_from_yuv161616(conversion_matrix,
> +						     *y_plane * 257, *channel_1_plane * 257,
> +						     *channel_2_plane * 257);
>   		out_pixel += 1;
>   		y_plane += step_y;
>   		if ((i + subsampling_offset + 1) % subsampling == 0) {
> @@ -690,9 +692,9 @@ pixel_read_line_t get_pixel_read_line_function(u32 format)
>   	case DRM_FORMAT_BGRX8888:
>   		return &BGRX8888_read_line;
>   	case DRM_FORMAT_RGB888:
> -		return RGB888_read_line;
> +		return &RGB888_read_line;
>   	case DRM_FORMAT_BGR888:
> -		return BGR888_read_line;
> +		return &BGR888_read_line;

This should be in the previous patch.

Best Regards,
- Maíra


