Return-Path: <linux-kernel+bounces-782717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8CEB3240D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 23:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4450D4E2091
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 21:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12ACA2ED153;
	Fri, 22 Aug 2025 21:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="arYkT+sL"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FBF283C9D
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 21:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755897617; cv=none; b=gHZhBZ+P/FziTQsR3ltU+1qJckKeyO07vEFkVyl8OgzdKDmI+i1rECYVHkzo3OQ8PePetZMG2jCamcpxkZ7ptxZBDrH8kDR/cA84k3ACOoGizvy3v/9hbz725vkT0/ANdDw3ggzuLOC0rQmskP4EGm4K3N8NJBKqGRmiEqlm4b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755897617; c=relaxed/simple;
	bh=9fA0yHG8SS2Fd7s3upe/4ZWUaSmlKYSByXORV1ojuDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lA4adQwgE7k/brQMPwja5of3tMyjThdkd8k2dPRrj91XW7RR0kbe0n/Qy23qJzpT30m1Nv/MLuA2QglmdnDP5qI5DgLv7HInYkolYjKq/gtjxZaLs1gGxvSjq1Ohdvqx9HfiOjaI9CIOdMXnON4UwmPmYBi4Q2mqRG7fWsi6ZS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=arYkT+sL; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9uZLhzPEmMwp8D7S73NTMgQyO+O6LpYFyWrFqzJc7vM=; b=arYkT+sLUfSekCdSUtkDWfZFab
	/M5zuPdpjW/R27iXLK8WNRIWl1Ma6ocvoAs55hPqAi8Q8XUU051sgda0oFwjEWS1mCv3tQNCd28XS
	VTyiOUyneFP84wycyt9kGYGh75Q71oKNffNiTBXFZ6VbhisqKq0HXRNxpdT2UklJYUHcK2PUuHcC6
	n+bXpbb0yfgS8mL6w7xPzlotyQQNQmAIygHo5FTErKtzY3y/U8MuAWxgm0hjmHbcvuZaVqvsZdWBv
	wqPsrbWcJJk7hNGabw+/kpTBcD7Xnc1/Pdbfl3zz+6wGZLTm/KTXmfTI+i/4F3xrWf+4JiQo5l3Pm
	H1+E86Cg==;
Received: from [189.6.13.79] (helo=[192.168.31.42])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1upZB5-000I7b-Rv; Fri, 22 Aug 2025 23:20:04 +0200
Message-ID: <9c544984-7b73-46df-a63a-fc8820d2ccba@igalia.com>
Date: Fri, 22 Aug 2025 18:19:58 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix kernel-doc comments for some LUT
 properties
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>
Cc: kernel@collabora.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250823-amdgpu-fix-kdoc-lut-v1-1-306bcad41267@collabora.com>
Content-Language: en-US
From: Melissa Wen <mwen@igalia.com>
In-Reply-To: <20250823-amdgpu-fix-kdoc-lut-v1-1-306bcad41267@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 22/08/2025 18:11, Cristian Ciocaltea wrote:
> The following members of struct amdgpu_mode_info do not have valid
> references in the related kernel-doc sections:
>
>   - plane_shaper_lut_property
>   - plane_shaper_lut_size_property,
>   - plane_lut3d_size_property
>
> Correct all affected comment blocks.
>
> Fixes: f545d82479b4 ("drm/amd/display: add plane shaper LUT and TF driver-specific properties")
> Fixes: 671994e3bf33 ("drm/amd/display: add plane 3D LUT driver-specific properties")
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Nice catch. Thanks for reviewing docs and fixing them.

Reviewed-by: Melissa Wen <mwen@igalia.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
> index 6da4f946cac008ac865cd6d8a06fb0bd84d646d5..c3ad371658065388c10b7cfc45377b0465bd24ca 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
> @@ -366,15 +366,15 @@ struct amdgpu_mode_info {
>   
>   	struct drm_property *plane_ctm_property;
>   	/**
> -	 * @shaper_lut_property: Plane property to set pre-blending shaper LUT
> -	 * that converts color content before 3D LUT. If
> -	 * plane_shaper_tf_property != Identity TF, AMD color module will
> +	 * @plane_shaper_lut_property: Plane property to set pre-blending
> +	 * shaper LUT that converts color content before 3D LUT.
> +	 * If plane_shaper_tf_property != Identity TF, AMD color module will
>   	 * combine the user LUT values with pre-defined TF into the LUT
>   	 * parameters to be programmed.
>   	 */
>   	struct drm_property *plane_shaper_lut_property;
>   	/**
> -	 * @shaper_lut_size_property: Plane property for the size of
> +	 * @plane_shaper_lut_size_property: Plane property for the size of
>   	 * pre-blending shaper LUT as supported by the driver (read-only).
>   	 */
>   	struct drm_property *plane_shaper_lut_size_property;
> @@ -398,10 +398,10 @@ struct amdgpu_mode_info {
>   	 */
>   	struct drm_property *plane_lut3d_property;
>   	/**
> -	 * @plane_degamma_lut_size_property: Plane property to define the max
> -	 * size of 3D LUT as supported by the driver (read-only). The max size
> -	 * is the max size of one dimension and, therefore, the max number of
> -	 * entries for 3D LUT array is the 3D LUT size cubed;
> +	 * @plane_lut3d_size_property: Plane property to define the max size
> +	 * of 3D LUT as supported by the driver (read-only). The max size is
> +	 * the max size of one dimension and, therefore, the max number of
> +	 * entries for 3D LUT array is the 3D LUT size cubed.
>   	 */
>   	struct drm_property *plane_lut3d_size_property;
>   	/**
>
> ---
> base-commit: 0f4c93f7eb861acab537dbe94441817a270537bf
> change-id: 20250823-amdgpu-fix-kdoc-lut-357db8b57fee
>


