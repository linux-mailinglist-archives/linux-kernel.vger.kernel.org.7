Return-Path: <linux-kernel+bounces-824156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC22B883DC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3E443B81D4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 07:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD5F2D1F68;
	Fri, 19 Sep 2025 07:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="XIiY+eHE"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03042C1581
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 07:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758267837; cv=none; b=sZg8BhFYtihBETYdX5f2naQcazVVtW2ne85M/9qX8/etpekisTN5U8srjpDK27Cuj9qTKVWAouyf44mmrq/8FPqOGtxFjNlFr1Kx3i1u3mEx6ot7K1diF5ISAa5VZgJI4EisxHUCCfUQ6BcLC56B5sdb0yMJoE2ytX2I8BCBg8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758267837; c=relaxed/simple;
	bh=P35/rdFAeKRuKPGCGL09b21TWIuSEXzxsGQOegr6Vx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E3GeM4N6pHgjEUdRUYTUCvEqLhYu0aTfpjDmnD6TTR8iw2X4Y94uhUnVziJ4e0YaqkJKpB9iaKBXnCFwoT4qnCL880CpQpGhYkRyd7WsdBTx0Tf51ZCiq5/BG8QDj9d8mBjTzPPDnjbXXJbVKlCQgFYDbD27qJLfAwMG8GzXEJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=XIiY+eHE; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/a3owossTaz7vPApbtBeXVP5NB17BVoTWqzVH8GxeYA=; b=XIiY+eHEeLNIdYbQUSRMWqNKrV
	2dXwe6sp/iqsPSb2T9FVZeRv0NJ3i9C3r0egaPn9gZHeafCXPGK7bSkExcLkKezx9kZp00bduHxyI
	CSbII0SKUcmJiRNg+UHADUymBxoCwiMVEEA6NYc7h3QwaypmUQLTmKAiLrfWpEiSYdlQZ3PysVvE7
	unEk++valrBF22ui1uGgSiLH8gNtRKwzDE78QRCVW6vmxXEuLfhFKYm+S+6KwZUDZW8zZUvEKrvE3
	3Sew0khOzTte5JfDl/ojJIB0/V1Ky+O4FApvXUokgNbug0Z2w+NkDGVO+FtdTJoNJGNogVurs18vM
	/DoC4JTg==;
Received: from [84.66.36.92] (helo=[192.168.0.101])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1uzVmJ-00DzoJ-4B; Fri, 19 Sep 2025 09:43:35 +0200
Message-ID: <67c83b24-01b6-4633-8645-52dc746c32e2@igalia.com>
Date: Fri, 19 Sep 2025 08:43:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 0/3] drm/ttm: allow direct reclaim to be skipped
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
 Huang Rui <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
 Sergey Senozhatsky <senozhatsky@chromium.org>
References: <20250918-ttm_pool_no_direct_reclaim-v2-0-135294e1f8a2@igalia.com>
 <6f92ff06-04c3-440b-becb-50a7693ecc39@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <6f92ff06-04c3-440b-becb-50a7693ecc39@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 19/09/2025 07:46, Christian König wrote:
> On 18.09.25 22:09, Thadeu Lima de Souza Cascardo wrote:
>> On certain workloads, like on ChromeOS when opening multiple tabs and
>> windows, and switching desktops, memory pressure can build up and latency
>> is observed as high order allocations result in memory reclaim. This was
>> observed when running on an amdgpu.
>>
>> This is caused by TTM pool allocations and turning off direct reclaim when
>> doing those higher order allocations leads to lower memory pressure.
>>
>> Since turning direct reclaim off might also lead to lower throughput,
>> make it tunable, both as a module parameter that can be changed in sysfs
>> and as a flag when allocating a GEM object.
>>
>> A latency option will avoid direct reclaim for higher order allocations.
>>
>> The throughput option could be later used to more agressively compact pages
>> or reclaim, by not using __GFP_NORETRY.
> 
> Well I can only repeat it, at least for amdgpu that is a clear NAK from my side to this.
> 
> The behavior to allocate huge pages is a must have for the driver.

Disclaimer that I wouldn't go system-wide but per device - so somewhere 
in sysfs rather than a modparam. That kind of a toggle would not sound 
problematic to me since it leaves the policy outside the kernel and 
allows people to tune to their liking.

One side question thought - does AMD benefit from larger than 2MiB 
contiguous blocks? IIUC the maximum PTE is 2MiB so maybe not? In which 
case it may make sense to add some TTM API letting drivers tell the pool 
allocator what is the maximum order to bother with. Larger than that may 
have diminishing benefit for the disproportionate pressure on the memory 
allocator and reclaim.

Regards,

Tvrtko

> The alternative I can offer is to disable the fallback which in your case would trigger the OOM killer.
> 
> Regards,
> Christian.
> 
>>
>> Other drivers can later opt to use this mechanism too.
>>
>> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
>> ---
>> Changes in v2:
>> - Make disabling direct reclaim an option.
>> - Link to v1: https://lore.kernel.org/r/20250910-ttm_pool_no_direct_reclaim-v1-1-53b0fa7f80fa@igalia.com
>>
>> ---
>> Thadeu Lima de Souza Cascardo (3):
>>        ttm: pool: allow requests to prefer latency over throughput
>>        ttm: pool: add a module parameter to set latency preference
>>        drm/amdgpu: allow allocation preferences when creating GEM object
>>
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c    |  3 ++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |  3 ++-
>>   drivers/gpu/drm/ttm/ttm_pool.c             | 23 +++++++++++++++++------
>>   drivers/gpu/drm/ttm/ttm_tt.c               |  2 +-
>>   include/drm/ttm/ttm_bo.h                   |  5 +++++
>>   include/drm/ttm/ttm_pool.h                 |  2 +-
>>   include/drm/ttm/ttm_tt.h                   |  2 +-
>>   include/uapi/drm/amdgpu_drm.h              |  9 +++++++++
>>   8 files changed, 38 insertions(+), 11 deletions(-)
>> ---
>> base-commit: f83ec76bf285bea5727f478a68b894f5543ca76e
>> change-id: 20250909-ttm_pool_no_direct_reclaim-ee0807a2d3fe
>>
>> Best regards,
> 


