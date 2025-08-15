Return-Path: <linux-kernel+bounces-771010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1C1B28192
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94CC3B68143
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 14:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B51121CC5A;
	Fri, 15 Aug 2025 14:22:48 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A4B19004E
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 14:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755267767; cv=none; b=lLCWvUvEjBdoTb2sK/YrS9yuX/XzoBZKXp9u51eryjd6UxaeRH+U7aKOGlE1yX/6w7JffUUCHEd+4HEv3eeMP9GD76JqpbiUE0MHOAPNew0l5zWLoQEVH+gJPQEEUSDLf0a38Hl5E9Z9eUEwwgA/GXXzbOPe/08ZEEpfT1YV7NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755267767; c=relaxed/simple;
	bh=LsQxnapi14IVSPkKXJP+334qnhehujh6iolQkLFy5Fk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=nbMRyJJpBrrpaVuY00v8nVoehXbb3nDsph0FYqEHvg0HovGxemxPM8yYWAUV3P3UEUN1BZ5V5BpwHkPGqbIjloJwkuAgaFjGMI+NpEF/g9+5vNZiEja/BWFfOY1BB9JCSexFTv2kwrQ9o1B0BcETr3a495uG7SY8OFE7Xi1uEiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE0B81691;
	Fri, 15 Aug 2025 07:22:36 -0700 (PDT)
Received: from [10.1.29.14] (e122027.cambridge.arm.com [10.1.29.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0DB2E3F738;
	Fri, 15 Aug 2025 07:22:42 -0700 (PDT)
Message-ID: <4825140d-a03e-4b22-a7ed-1de17b07714e@arm.com>
Date: Fri, 15 Aug 2025 15:22:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/80] drm/panfrost: Remove redundant
 pm_runtime_mark_last_busy() calls
From: Steven Price <steven.price@arm.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250704075225.3212486-1-sakari.ailus@linux.intel.com>
 <20250704075411.3218059-1-sakari.ailus@linux.intel.com>
 <eee19dfc-c8ee-44d4-b9d7-9335ec3ad73e@arm.com>
Content-Language: en-GB
In-Reply-To: <eee19dfc-c8ee-44d4-b9d7-9335ec3ad73e@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/07/2025 10:18, Steven Price wrote:
> On 04/07/2025 08:54, Sakari Ailus wrote:
>> pm_runtime_put_autosuspend(), pm_runtime_put_sync_autosuspend(),
>> pm_runtime_autosuspend() and pm_request_autosuspend() now include a call
>> to pm_runtime_mark_last_busy(). Remove the now-reduntant explicit call to
>> pm_runtime_mark_last_busy().
>>
>> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> 
> Reviewed-by: Steven Price <steven.price@arm.com>
> 
> But this can't be merged via drm-misc until the PM changes have hit
> Linus' tree and been backmerged to drm-misc-next.

The back merged of -rc1 happened, so I've now merged this to drm-misc-next.

Thanks,
Steve

> Thanks,
> Steve
> 
>> ---
>> The cover letter of the set can be found here
>> <URL:https://lore.kernel.org/linux-pm/20250704075225.3212486-1-sakari.ailus@linux.intel.com>.
>>
>> In brief, this patch depends on PM runtime patches adding marking the last
>> busy timestamp in autosuspend related functions. The patches are here, on
>> rc2:
>>
>>         git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
>>                 pm-runtime-6.17-rc1
>>
>>  drivers/gpu/drm/panfrost/panfrost_perfcnt.c | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
>> index 563f16bae543..0dd62e8b2fa7 100644
>> --- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
>> +++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
>> @@ -203,7 +203,6 @@ static int panfrost_perfcnt_disable_locked(struct panfrost_device *pfdev,
>>  	panfrost_mmu_as_put(pfdev, perfcnt->mapping->mmu);
>>  	panfrost_gem_mapping_put(perfcnt->mapping);
>>  	perfcnt->mapping = NULL;
>> -	pm_runtime_mark_last_busy(pfdev->dev);
>>  	pm_runtime_put_autosuspend(pfdev->dev);
>>  
>>  	return 0;
>> @@ -279,7 +278,6 @@ void panfrost_perfcnt_close(struct drm_file *file_priv)
>>  	if (perfcnt->user == pfile)
>>  		panfrost_perfcnt_disable_locked(pfdev, file_priv);
>>  	mutex_unlock(&perfcnt->lock);
>> -	pm_runtime_mark_last_busy(pfdev->dev);
>>  	pm_runtime_put_autosuspend(pfdev->dev);
>>  }
>>  
> 


