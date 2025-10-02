Return-Path: <linux-kernel+bounces-840150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBEA9BB3B01
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 12:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7679016D831
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 10:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7836330C63D;
	Thu,  2 Oct 2025 10:48:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B5D30C375
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 10:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759402129; cv=none; b=E+HGD8egmAYgDTcQonFHqXIp9CtkAsB5b3EeAA6d6UFCI7TPLAd1QvP5xTtMaOMp8q9IjStaPMfZX/bux8KrybRyisO9ydpyjlGxHh8FAOdX6la7s/A+Q7vybW1HNnCzTSz3ukyVMCzb+nZbKtY5kt6dkS0feRDwdkYL5plVN0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759402129; c=relaxed/simple;
	bh=se6eEsy/TQwDLOrh2LvOYEanoi1FPmiqneRDmuDWBss=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Mrq44yACoFgN437vHU6VqqpCzFKYM6bq8uYh1xyh1XSNc2TyswsQ1kpEPSVK5kP6a7lCzKmF9/y8RPmMmMhkm6pxkvyoYPf4SCx660OuOVR9S5IXm2G9/eJbYu+sCd06AdDpEh7vvOGsLZ8ZBwgfoopmdWxJ6j3Kf4yLSCf8coY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 034551596;
	Thu,  2 Oct 2025 03:48:39 -0700 (PDT)
Received: from [10.57.2.240] (unknown [10.57.2.240])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2BE7B3F66E;
	Thu,  2 Oct 2025 03:48:45 -0700 (PDT)
Message-ID: <04c19e70-d895-45ff-b221-974abaa8dff8@arm.com>
Date: Thu, 2 Oct 2025 11:48:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] drm/panthor: minor AS_CONTROL clean up
To: Chia-I Wu <olvaffe@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Grant Likely <grant.likely@linaro.org>, Heiko Stuebner <heiko@sntech.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250916210823.4033529-1-olvaffe@gmail.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20250916210823.4033529-1-olvaffe@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/09/2025 22:08, Chia-I Wu wrote:
> This series performs minor AS_CONTROL clean up.
> 
> Patch 1 to 5 rename and document AS_CONTROL config functions. There is
> no functional change. All functions are now prefixed by mmu_hw_ for
> consistency. All of them also expect locking. I choose not to suffix
> them by _locked, but I can be convinced.
> 
> Patch 6 to 7 eliminiate redundant mmu_hw_wait_ready. This is the main
> functional change of the series. panthor_vm_flush_range no longer waits
> for UNLOCK to complete.
> 
> Patch 8 to 10 give mmu_hw_flush_caches final touches, to improve error
> handling, simplifying code, etc.

I think you need to provide better justification for these changes. Some
of them might make some sense, but in general most of the "cleanup"
patches by themselves seem to make the code harder to read. Which can be
fine if they are a precursor to achieving an improvement in a following
patch, but as things stand I'm having a hard time to figure out what the
benefit is.

The cover letter implies that we have redundant mmu_hw_wait_ready calls
(which I can believe). But we need a proper justification on why they
are redundant, and proper patch descriptions for the precursor patches
so that anyone coming to them in the future can understand why they were
applied (without having to hunt through mail archives for the cover
letter, or guess from the later patches).

Having said the above, I do appreciate the time you took to write the
documentation blocks - we do have a bunch of fairly confusing functions.

Thanks,
Steve

> Chia-I Wu (10):
>   drm/panthor: rename and document wait_ready
>   drm/panthor: rename and document lock_region
>   drm/panthor: add mmu_hw_cmd_unlock
>   drm/panthor: add mmu_hw_cmd_update
>   drm/panthor: rename and document mmu_hw_do_operation_locked
>   drm/panthor: remove write_cmd
>   drm/panthor: remove unnecessary mmu_hw_wait_ready calls
>   drm/panthor: improve error handling for mmu_hw_flush_caches
>   drm/panthor: move size check to mmu_hw_flush_caches
>   drm/panthor: simplify mmu_hw_flush_caches
> 
>  drivers/gpu/drm/panthor/panthor_mmu.c | 157 +++++++++++++++-----------
>  1 file changed, 94 insertions(+), 63 deletions(-)
> 


