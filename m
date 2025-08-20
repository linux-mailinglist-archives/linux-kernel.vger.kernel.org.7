Return-Path: <linux-kernel+bounces-777094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A76EB2D524
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 09:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6864C724964
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 07:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE9C2D8DC3;
	Wed, 20 Aug 2025 07:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=damsy.net header.i=@damsy.net header.b="rAX0BG3v";
	dkim=permerror (0-bit key) header.d=damsy.net header.i=@damsy.net header.b="zm8Xthxv"
Received: from jeth.damsy.net (jeth.damsy.net [51.159.152.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397A121CC58
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 07:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.152.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755675801; cv=none; b=Y2P9nVI0Q87eHtPMZ9o5gmIQsfcXXMogJDGIGUed+9tnqA6oM46blfT4QsFxR4x398SauoF56xfAVK3570u2n8YX6s7Wxvu+RcBI913dyLUQycB7ptifXXaoaRpGnfw06aT3CfJnAqmkccwWJ7R+hIha3uBP3VLONa5EDrF8h70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755675801; c=relaxed/simple;
	bh=dTZfagQ0+o7nxH3bkE5UlsCnkY0SHpqO/vTGX9XGphg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FQXxG7d7Z/7lPnM+J+CFIFPSLAP2V5bgEgfh4b+0X7GKPBmVnC6FALWyT993oXGYrwf1VvJDpInCYIDtNM5Hu4VbVnViiuekOePNWdhQFEBim4x6cZA60ODV6XM5I+YbWKzs7Bu//VAn/YMVoVxRd+cFqms0D6xi236sHJpRMVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=damsy.net; spf=pass smtp.mailfrom=damsy.net; dkim=pass (2048-bit key) header.d=damsy.net header.i=@damsy.net header.b=rAX0BG3v; dkim=permerror (0-bit key) header.d=damsy.net header.i=@damsy.net header.b=zm8Xthxv; arc=none smtp.client-ip=51.159.152.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=damsy.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=damsy.net
DKIM-Signature: v=1; a=rsa-sha256; s=202408r; d=damsy.net; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1755675773; bh=w9SlD7ICoHxzqoTlV8Z7Rg/
	8uwfey5HI6LYxS9+8BWE=; b=rAX0BG3v0QpJZ3qELpbEuE1Gnf64gsxn3p30lNCslrTapWnxa0
	96q75Ty6EAUb+vhLw4Mp5Zycd4zEolapYeyBfWPx+FHf0ZddnV27HcZ8oGslepQMi+5ZpU8Psud
	RQRl8letQVMEeo8/nuV2Lmh9gWWzPFDdQ42OqUC+iOcVwEZPttvpiG5rtW2gQFVFO+Id2Tn4mTS
	gAkfv0mNwsRDHr+2XCxjfJKMljocgMF3yowrbrdQpfS79UL20TlwK94ceXuxEZOnWYUn+ZFou2E
	+J1U+NA9X289Bq2EYkM1P17dj2PwwgUJGEuReHgXS9NBZMk3bJqeJgbpraMly5Ebrlw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202408e; d=damsy.net; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1755675773; bh=w9SlD7ICoHxzqoTlV8Z7Rg/
	8uwfey5HI6LYxS9+8BWE=; b=zm8XthxvusftN8sHmI0QViGO57N+qOWk3A0FtE0PtJhy6ni+vY
	WW35Mb0I3jwxH/MeRss7mfEzj5j9AH+Q/ACQ==;
Message-ID: <fb30efd4-1950-4b76-89fc-51c089319950@damsy.net>
Date: Wed, 20 Aug 2025 09:42:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/6] amdgpu: Avoid powering on the dGPU on
 vkEnumeratePhysicalDevices()
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Philipp Zabel <philipp.zabel@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 "Pelloux-Prayer, Pierre-Eric" <Pierre-eric.Pelloux-prayer@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20250731-b4-dont-wake-next-v1-0-e51bdc347fa3@gmail.com>
 <601a40fd-e508-4e9d-8dd3-14329f3a637b@amd.com>
 <41b37595c42e4f492704a31970936d52b96dae97.camel@pengutronix.de>
 <ce732501-131d-420d-ad75-61ae987f51d0@amd.com>
Content-Language: en-US
From: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>
In-Reply-To: <ce732501-131d-420d-ad75-61ae987f51d0@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

[resend because the previous email didn't make it to most recipients]

Hi,

Le 06/08/2025 à 15:17, Christian König a écrit :
> On 06.08.25 12:15, Philipp Zabel wrote:
>> On Mi, 2025-08-06 at 10:58 +0200, Christian König wrote:
>>> On 31.07.25 07:36, Philipp Zabel wrote:
>>>> This is an attempt at fixing amd#2295 [1]:
>>>>
>>>>    On an AMD Rembrandt laptop with 680M iGPU and 6700S dGPU, calling
>>>>    vkEnumeratePhysicalDevices() wakes up the sleeping dGPU, even if all
>>>>    the application wants is to find and use the iGPU. This causes a delay
>>>>    of about 2 seconds on this system, followed by a few seconds of
>>>>    increased power draw until runtime PM turns the dGPU back off again.
>>>>
>>>> [1] https://gitlab.freedesktop.org/drm/amd/-/issues/2295
>>>>
>>>> Patch 1 avoids power up on some ioctls that don't need it.
>>>> Patch 2 avoids power up on open() by postponing fpriv initialization to
>>>> the first ioctl() that wakes up the dGPU.
>>>> Patches 3 and 4 add AMDGPU_INFO to the list of non-waking ioctls,
>>>> returning cached values for some queries.
>>>> Patch 5 works around an explicit register access from libdrm.
>>>> Patch 6 shorts out the syncobj ioctls while fpriv is still
>>>> uninitialized. This avoids waking up the dGPU during Vulkan syncobj
>>>> feature detection.
>>>
>>> This idea came up multiple times now but was never completed.
>>>
>>> IIRC Pierre-Eric last worked on it, it would probably be a good idea to dig up his patches from the mailing list.
>>
>> Thank you, I wasn't aware of those patches [1]. Pierre-Eric did mention
>> them in https://gitlab.freedesktop.org/mesa/mesa/-/issues/13001, but I
>> didn't pick up on that back then.
>>
>> [1] https://lore.kernel.org/all/20240618153003.146168-1-pierre-eric.pelloux-prayer@amd.com/
>>
>> Is that the latest version?
> 
> I honestly don't know. @Pierre-Eric?


https://lore.kernel.org/all/ZnvJHwnNAvDrRMVG@phenom.ffwll.local/ killed the approach taken by this 
patchset.

After that I've reworked the series, and sent 
https://lists.freedesktop.org/archives/amd-gfx/2024-September/114417.html to do fine grain runtime 
pm in drm/amd/pm as a first step.

I also have a local branch that I never sent that implements Sima's suggestion: pushing rpm handling 
down into the ioctl implementation.

I'll try to rebase it and push it out on gitlab soon.

Pierre-Eric


> 
>> It looks to me like the review stalled out
>> on a disagreement whether the GB_ADDR_CONFIG query should be a separate
>> ioctl or whether it should be added to drm_amdgpu_info_device. The
>> discussion was later continued at
>> https://gitlab.freedesktop.org/mesa/libdrm/-/merge_requests/368,
>> seemingly coming to the conclusion that keeping the register read (but
>> cached) is the way to go? I didn't find a newer series with that
>> implemented.
> 
> Could be that Pierre-Eric dropped the work after that.
> 
> But IIRC we already use a cached value for GB_ADDR_CONFIG because of GFXOFF.
> 
> Regards,
> Christian.
> 
>>
>>>>
>>>> regards
>>>> Philipp
>>>>
>>>> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
>>>> ---
>>>> Alex Deucher (1):
>>>>        drm/amdgpu: don't wake up the GPU for some IOCTLs
>>>>
>>>> Philipp Zabel (5):
>>>>        drm/amdgpu: don't wake up the GPU when opening the device
>>>>        drm/amdgpu: don't query xclk in AMDGPU_INFO_DEV_INFO
>>>>        drm/amdgpu: don't wake up the GPU for some AMDGPU_INFO queries
>>>>        drm/amdgpu: don't wake up the GPU for mmGB_ADDR_CONFIG register read
>>>
>>> That is both unnecessary an insufficient. Unnecessary because we already have a mechanism to cache register values and insufficient because IIRC you need to add a bunch of more registers to the cached list.
>>
>> This series was (just barely) sufficient for my purpose, which was only
>> to make vkEnumeratePhysicalDevices() not wake the dGPU on my Laptop.
>> I didn't realize there already was a caching mechanism in the lower
>> layers.
>>
>>> See Pierre-Erics latest patch set, I think we already solved that but I'm not 100% sure.
>>
>> If I found the correct version, it seems Sima's suggestion of pushing
>> runtime pm handling down from amdgpu_drm_ioctl into the amdgpu ioctl
>> callbacks [2] would be the best first next step?
>>
>> [2] https://lore.kernel.org/amd-gfx/ZnvJHwnNAvDrRMVG@phenom.ffwll.local/
>>
>> regards
>> Philipp


