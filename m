Return-Path: <linux-kernel+bounces-796997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 090B1B40A8A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 18:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE2DB7B1FD3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FF732A825;
	Tue,  2 Sep 2025 16:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mnz2RLK4"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E8D3376B3
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 16:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756830366; cv=none; b=pC/byVU1bihQjrEqENp7MkIs2fIrP/+tmu3CvV6AtmvlJtSWkS14tKb3BPKuOhqDnlP//jUiTPr/zRLR8bpJXyMg5IAu1t9pNouDMij3Svd1M5Te3S47XMUcyRewj8Bu6czBtQo4fzoUWU1h/ktP8hFHZlkxV8dtG+p7O1FA3E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756830366; c=relaxed/simple;
	bh=WALewwHx2C+Gr6Q65PLmSt5V0bZuUMTVLBppkG5GReI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SjF9KdXybJaucY/gZ0GWzvaacDRzJFsgvq9BXv5xNvl90d1aMv/VbpSYu9/ujP9O0IU5WW51uTU5xRTAhCpRQEJ7nshoUj7USUUmXJgL6rnoZV++Lj3KEtAxD7zGYI0QbmJKUOI8+Sw+1CbT9YSS8S5uusaLNlE4WI0ylMAOyIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=mnz2RLK4; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1756830362;
	bh=WALewwHx2C+Gr6Q65PLmSt5V0bZuUMTVLBppkG5GReI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mnz2RLK4X3Hk5GbUktymH8Z7xV3xj05l/Ro6j5NbhrNjDWsApUu8raDBfmlyQaJpT
	 BVPoxC4eqLR3B+te5KPtj0FiQ1ymxK+fJo23QM2Kq8ihnBNB6t/lT0YvhU48OD/S1A
	 IT1BK+xCwrQDeZqG2pHK8ijHJcop/QUFi57O9hR4Fr6CNSb3WD8DE+/WImSnPaI2oV
	 3rSa7s6KWHrnrGj2EC+3BcOSJfOFz5IadIRB6dZq3G1FCxI68dOqclnUdZda5CKMnD
	 tnQcQvg0wg1GGHeLx/vLzWkxAfjYaO79PVi8Aj5VUf5a2Ifp4YkAoD7RepZN4x+vmf
	 OMyM4CwsQQqtQ==
Received: from [192.168.1.90] (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2FDA617E0B84;
	Tue,  2 Sep 2025 18:26:02 +0200 (CEST)
Message-ID: <2a8ab8c3-36ae-46bd-8f98-6b3760532cb5@collabora.com>
Date: Tue, 2 Sep 2025 19:26:01 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm: Add CRTC background color property
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>, kernel@collabora.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 Matt Roper <matthew.d.roper@intel.com>
References: <20250902-rk3588-bgcolor-v1-0-fd97df91d89f@collabora.com>
 <20250902-rk3588-bgcolor-v1-1-fd97df91d89f@collabora.com>
 <aLby6OPxgubt7kd_@intel.com>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <aLby6OPxgubt7kd_@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/2/25 4:36 PM, Ville Syrjälä wrote:
> On Tue, Sep 02, 2025 at 12:27:56PM +0300, Cristian Ciocaltea wrote:
>> Some display controllers can be hardware programmed to show non-black
>> colors for pixels that are either not covered by any plane or are
>> exposed through transparent regions of higher planes.  This feature can
>> help reduce memory bandwidth usage, e.g. in compositors managing a UI
>> with a solid background color while using smaller planes to render the
>> remaining content.
>>
>> To support this capability, introduce the BACKGROUND_COLOR standard DRM
>> mode property, which can be attached to a CRTC through the
>> drm_crtc_attach_background_color_property() helper function.
>>
>> Additionally, define a 64-bit ARGB format value to be built with the
>> help of a dedicated drm_argb64() utility macro.  Individual color
>> components can be extracted with desired precision using the
>> corresponding DRM_ARGB64_*() macros.
>>
>> Co-developed-by: Matt Roper <matthew.d.roper@intel.com>
>> Signed-off-by: Matt Roper <matthew.d.roper@intel.com>
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
>>  drivers/gpu/drm/drm_atomic_state_helper.c |  1 +
>>  drivers/gpu/drm/drm_atomic_uapi.c         |  4 ++++
>>  drivers/gpu/drm/drm_blend.c               | 37 +++++++++++++++++++++++++++----
>>  drivers/gpu/drm/drm_mode_config.c         |  6 +++++
>>  include/drm/drm_blend.h                   |  4 +++-
>>  include/drm/drm_crtc.h                    | 12 ++++++++++
>>  include/drm/drm_mode_config.h             |  5 +++++
>>  include/uapi/drm/drm_mode.h               | 30 +++++++++++++++++++++++++
>>  8 files changed, 94 insertions(+), 5 deletions(-)

[...]

>> +/*
>> + * Put 16-bit ARGB values into a standard 64-bit representation that
>> + * can be used for ioctl parameters, inter-driver communication, etc.
>> + */
>> +static inline __u64
>> +drm_argb64(__u16 alpha, __u16 red, __u16 green, __u16 blue)
>> +{
>> +	return (__u64)alpha << 48 | (__u64)red << 32 | (__u64)green << 16 | blue;
>> +}
>> +
>> +/*
>> + * Extract the specified number of least-significant bits of a specific
>> + * color component from a standard 64-bit ARGB value.
> 
> Why would you ever want the least significant bits?

Right, that's useless - will replace with proper helpers dealing with custom
precision.

Thanks,
Cristian

>> + */
>> +#define DRM_ARGB64_COMP(c, shift, numlsb) \
>> +	((__u16)(((c) >> (shift)) & ((1UL << (numlsb) % 17) - 1)))
>> +#define DRM_ARGB64_ALPHA_LSB(c, numlsb) DRM_ARGB64_COMP(c, 48, numlsb)
>> +#define DRM_ARGB64_RED_LSB(c, numlsb)   DRM_ARGB64_COMP(c, 32, numlsb)
>> +#define DRM_ARGB64_GREEN_LSB(c, numlsb) DRM_ARGB64_COMP(c, 16, numlsb)
>> +#define DRM_ARGB64_BLUE_LSB(c, numlsb)  DRM_ARGB64_COMP(c, 0, numlsb)
>> +
>> +/*
>> + * Convenience wrappers to extract all 16 bits of a specific color
>> + * component from a standard 64-bit ARGB value.
>> + */
>> +#define DRM_ARGB64_ALPHA(c)		DRM_ARGB64_ALPHA_LSB(c, 16)
>> +#define DRM_ARGB64_RED(c)		DRM_ARGB64_RED_LSB(c, 16)
>> +#define DRM_ARGB64_GREEN(c)		DRM_ARGB64_GREEN_LSB(c, 16)
>> +#define DRM_ARGB64_BLUE(c)		DRM_ARGB64_BLUE_LSB(c, 16)
>> +
>>  #if defined(__cplusplus)
>>  }
>>  #endif
>>
>> -- 
>> 2.51.0
> 


