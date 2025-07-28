Return-Path: <linux-kernel+bounces-747889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FB0B139C4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 13:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0C033B4260
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 11:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C106244698;
	Mon, 28 Jul 2025 11:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AEUb43C3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDC118FDBE
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 11:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753701568; cv=none; b=MaR6BMk/PxlgLiGIGob1Bq7xWJgg4z3D1rk8zgOtUJK1QpUaHxykDJyFzajRSdQKErOOYBxg8Ya68OmwtO5phx0RYRDC0LfY5RsZHbgrqtddwY5xuwiOXFa0UVWCCBjQShesVhh0PHLVI0JRylLXHkAJGQkKI2zFCvV4uqpY3hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753701568; c=relaxed/simple;
	bh=UASadEwMto6eZAN2FdlhaFDfLWT16VuVLwVrDXV7bqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jEjZJsLW1gNyLpkGw9h444yLEbtfbMFnLCxIlzxGimWN7juk2sEu+uH/gJRRxjK5mrirCXeOHB71pxK6EPnlcuWMGdz2sanLWYUSO4St2GQ1QnTY2+Tnl72QKFbyKNJ/AbhVwGwuqz7JodnbqnZE4gxiQhdbMYFMCzKZCUOgcBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AEUb43C3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753701565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=knoW5hXdYfxlMfaIaGdm6JpvBEpBbVPIky2WIJsx7bU=;
	b=AEUb43C3mDHx91kdf8LUenjbE8FY0kGqE7KHdt4efL8/uRK3LEUWJ0xeB6foNa9stLVmg3
	SzUPxq4mX/LWA7kOYp0bDKsf4zYy1jVXvaN4FhFN3MepgvCO8Zspu+HoBpzhf7MNg+KVWJ
	0ISml27D54ca7zErF56lqsH68M3TuO8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-zOj9HKQVOuKjhOMhX3w-og-1; Mon, 28 Jul 2025 07:19:24 -0400
X-MC-Unique: zOj9HKQVOuKjhOMhX3w-og-1
X-Mimecast-MFC-AGG-ID: zOj9HKQVOuKjhOMhX3w-og_1753701563
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3b782c29be3so1171336f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 04:19:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753701563; x=1754306363;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=knoW5hXdYfxlMfaIaGdm6JpvBEpBbVPIky2WIJsx7bU=;
        b=E8Jcej1QqfFwxPQEiw42cTuOcR3FCBU8PT7SNR1x9PEfwnkapppMhapKHYLZ96hqMC
         HFBVBp1WE+y5/bg7CbMTXFWsfVLoxl2/xR7EapLX++H84MO623Dj4peHSjty0m9NlJSO
         0i+4BQJMmWaQpYWH0SxPwHVOIa/zLT567o3sDVOID42GYThbE4thLeBULU3NidtgmWOv
         gSZj2iYrk0ekIJeJQxhiarrH9Ub0aYYjN0BHwZmeyS0GULP8SNPlxW5A+ivWmLcy5nz0
         fDNRz9UQRurmp/EJ0wQBJAH97AlBQ/IvM/vrx78dONXVE71X/8NXL/DHfzRLYxJWXC32
         9c5A==
X-Forwarded-Encrypted: i=1; AJvYcCVfasIJpdreulXRIfBDOjgk/IXmcF2AgAZR7YRq9UyL/HKVd+MK0EIRcVEHxmD/HU7+kmK18g0Z8yyrxqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJndpsUn21T5aSkXKP8SGRE3+ZhgjR8tit/5DLKt9qGEUD1S7H
	xqbsfh2hIpQmVeeGiuLPfNGENyTmYe+cg6OOD75ZyTw/PHvVJQT5IEp5R0AVThbUZieebUqt8Dy
	Mm3Ae2/oVrr/5puXejhb9yamZr23kdDRmPSNUXcZoKCa0omXZfV8oUJv3ayCjnGzEqQ==
X-Gm-Gg: ASbGncuOFtaO/5CrTVQvxo+p7vYxJ9fVc2j5KK/c3BZ3HiMVcweDzCntE55QHpz9KWZ
	baBuvhN9A6BVxzBtHwSaQAR3KNiUT2fDX4XvOMeDWMo5uBMJRxUNuoYxdMTyoedeEkp9JuyPF8o
	M8h+tB+q85wcXzv9wTZarzpZ/2POiE1/Mlwx+VmpDEo2nHT/CBHyM8FO5rZyQugFxaAxOlfGaO6
	0gQakEVlIgnR/zPfyv1t/FM+dG5aerqQ9ayBquMEqGl4sBUUT8zgaSsPumzOrxo0172Ycr/TljB
	GxyZelEC4Lp2BzItBFmtdw2D6xgqfpxKH4rHQwXOR/g3x9nkGRjkg23eujWSOmt8poPJo/ThEuy
	abZ8=
X-Received: by 2002:a05:6000:188e:b0:3b7:6d95:56d2 with SMTP id ffacd0b85a97d-3b776726a56mr8486690f8f.7.1753701562458;
        Mon, 28 Jul 2025 04:19:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuXibLYD4lVfKwwNJUe9jSKZO7qPSJvy9uo0aYNRx6AYDFqEJHDqBJXZr+qlT8lrhUVJX5RA==
X-Received: by 2002:a05:6000:188e:b0:3b7:6d95:56d2 with SMTP id ffacd0b85a97d-3b776726a56mr8486656f8f.7.1753701561737;
        Mon, 28 Jul 2025 04:19:21 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:d5:a000:d252:5640:545:41db? ([2a01:e0a:d5:a000:d252:5640:545:41db])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587ac5816dsm94919535e9.17.2025.07.28.04.19.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 04:19:21 -0700 (PDT)
Message-ID: <a7ada116-5613-4518-a151-7c8db9874ede@redhat.com>
Date: Mon, 28 Jul 2025 13:19:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 03/10] drm/i915/display/i9xx: Add a disable_tiling()
 for i9xx planes
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Christian Koenig
 <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20250618094011.238154-1-jfalempe@redhat.com>
 <20250618094011.238154-4-jfalempe@redhat.com> <aHviiKb0EnQbNksL@intel.com>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <aHviiKb0EnQbNksL@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/07/2025 20:23, Ville Syrjälä wrote:
> On Wed, Jun 18, 2025 at 11:31:21AM +0200, Jocelyn Falempe wrote:
>> drm_panic draws in linear framebuffer, so it's easier to re-use the
>> current framebuffer, and disable tiling in the panic handler, to show
>> the panic screen.
>> This assumes that the alignment restriction is always smaller in
>> linear than in tiled.
>> It also assumes that the linear framebuffer size is always smaller
>> than the tiled.
>>
>> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
>> ---
>>
>> v7:
>>   * Reword commit message about alignment/size when disabling tiling (Ville Syrjälä)
>>
>>   drivers/gpu/drm/i915/display/i9xx_plane.c     | 23 +++++++++++++++++++
>>   .../drm/i915/display/intel_display_types.h    |  2 ++
>>   2 files changed, 25 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/i915/display/i9xx_plane.c b/drivers/gpu/drm/i915/display/i9xx_plane.c
>> index 8f15333a4b07..0807fae12450 100644
>> --- a/drivers/gpu/drm/i915/display/i9xx_plane.c
>> +++ b/drivers/gpu/drm/i915/display/i9xx_plane.c
>> @@ -905,6 +905,27 @@ static const struct drm_plane_funcs i8xx_plane_funcs = {
>>   	.format_mod_supported_async = intel_plane_format_mod_supported_async,
>>   };
>>   
>> +static void i9xx_disable_tiling(struct intel_plane *plane)
>> +{
>> +	struct intel_display *display = to_intel_display(plane);
>> +	enum i9xx_plane_id i9xx_plane = plane->i9xx_plane;
>> +	u32 dspcntr;
>> +	u32 reg;
>> +
>> +	dspcntr = intel_de_read_fw(display, DSPCNTR(display, i9xx_plane));
>> +	dspcntr &= ~DISP_TILED;
>> +	intel_de_write_fw(display, DSPCNTR(display, i9xx_plane), dspcntr);
>> +
>> +	if (DISPLAY_VER(display) >= 4) {
>> +		reg = intel_de_read_fw(display, DSPSURF(display, i9xx_plane));
>> +		intel_de_write_fw(display, DSPSURF(display, i9xx_plane), reg);
>> +
>> +	} else {
>> +		reg = intel_de_read_fw(display, DSPADDR(display, i9xx_plane));
>> +		intel_de_write_fw(display, DSPADDR(display, i9xx_plane), reg);
>> +	}
>> +}
> 
> I thought I already shot this down before, but apparently this
> got merged now :(

Sorry for that. I replied to that thread, but I didn't get answer [1]

> 
> Just to reiterate why we don't want these 'disable tiling' hacks:
> - different tiling formats have different stride/alignment/watermark
>    requirements so one can't safely change from one tiling to another

I agree that going from one tiling format to another is not safe. But 
from my understanding, going from tiling to linear should be possible.
Do you have an example, where the stride/alignment/watermark requirement 
in tiled would be incompatible in Linear (for the same resolution)?

> - this completely fails to account for the TILEOFF vs. LINOFF stuff

Pardon my ignorance, can you explain what it is, and how it can break or 
make the output unreadable?

> - etc.
> 
> So IMO these hacks must be removed and instead the code must learn how
> to propetly write the tiled data. igt has all the code for that btw
> (twice over IIRC) so shouldn't be that hard.

Regarding the tiling format, I usually test on hardware to check that 
the image is correct. But I have only a few of them, and as the format 
is platform dependent, and sometime also depends on the memory 
configuration. For me it looks very hard to get it right.
I've done it only for Y-tile and 4-tile, but only when DPT is enabled 
(which means it's only the few latest generations).

> 
> I suppose the only hack we need to keep is to disable compression,
> mainly because (IIRC) on flat CCS systems the CPU doesn't have access
> to the AUX data to clear it manually.
> 
> I also wonder if there are actual igts for this? I think what is needed
> is a test that sets random things (different panning, rotation, pixel
> foramts, etc.) and triggers the dumper. Not quite sure how the test
> could validate that the output is correct though. CRCs might be a bit
> tricky since you need an identical reference image.

No, I didn't write igts for this yet. I test by triggering a kernel 
panic, as it's the only way to make sure it works.
Also I didn't consider rotation yet, I think if the panic screen is not 
rotated, it's still useful.

> 
> /me off to summer vacation. Good luck
> 

Sorry for that, my goal is just to have drm panic working on intel GPU.
Enjoy your vacation, and let's find a solution when you're back.

[1] 
https://lore.kernel.org/intel-gfx/72fa1da6-caaa-41c9-aef1-4e780bde6acf@redhat.com/

Best regards,

-- 

Jocelyn


