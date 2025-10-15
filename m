Return-Path: <linux-kernel+bounces-855268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E85BBE0AC5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 22:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7BE294EF455
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 20:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780A430CD8D;
	Wed, 15 Oct 2025 20:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MuAGazgH"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7F33090FD;
	Wed, 15 Oct 2025 20:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760560924; cv=none; b=b80iPONF/cyLJHwx0ausaC4nVfKIiFqarQtyxiqfcLyLVySoU39Nbjd9t9ihzeMFLOHBvx691duei7DYrE6xUR0yYSt7FzjGousPQs3bZqt4boeCRK0RNlu/0hmOhPbJtrRd4SXBryAHl6J+Nbjgd8MT0LieuIl94Wbg+reGKbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760560924; c=relaxed/simple;
	bh=6NFItZksUnL4AeNLzkE9uW56mfjFXSMe3I2p1k1atTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oSHeNGqxmKYmG2ZA3qw2n+yqPHujAvscZATHUwdxFzCUqr9+yjzjleUIgmHbFjMMy1b/YTZSYxFFvAeKt3k8vrkubbfX2hxfyrqK/wl+8Lgh2OSWC1NdUyJ4noUpZwvqcBl504U1XceI73My1Gw1jqn50xCK19KPLPVBuC1D0Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MuAGazgH; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760560920;
	bh=6NFItZksUnL4AeNLzkE9uW56mfjFXSMe3I2p1k1atTk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MuAGazgHFf5NMEd+91RF7Wbfyfomf3WrSUyB9/IZolPbvVH5lTuwAPCHd7tE6/Bq7
	 QqCVAo7pOpD5H83FsAH3RRWYz68OQPN+OeXkMVTIM6jkrZS4ylGZUoy4zi8xMfgBdW
	 cD+AO81Ijw1bO1YB494nBepz2rX7bX43B0L+WMFhLbczgk3sm91zprnGct2I7/iP0D
	 G38aiNIDYCkYwl/E2lkzLt7zE0PVuX3pGypRYRN5cqRJbG7stRBmvSZVJF9dedIGdW
	 7mU087gqoePoUadp0Z94Elm1QCIxIMvrH+Uwil+z9n3QN0DEgbVvE/3cjWk9jflzhe
	 RfSGnUk7yuuFQ==
Received: from [IPV6:2a01:e0a:5e3:6100:7aed:fe0e:8590:cbaa] (unknown [IPv6:2a01:e0a:5e3:6100:7aed:fe0e:8590:cbaa])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: loicmolinari)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B526017E0C54;
	Wed, 15 Oct 2025 22:41:59 +0200 (CEST)
Message-ID: <efc1d805-1613-45a9-aa15-fcc009adf27c@collabora.com>
Date: Wed, 15 Oct 2025 22:41:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/13] drm/v3d: Fix builds with
 CONFIG_TRANSPARENT_HUGEPAGE=n
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, Rob Herring <robh@kernel.org>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Melissa Wen <mwen@igalia.com>, =?UTF-8?Q?Ma=C3=ADra_Canal?=
 <mcanal@igalia.com>, Hugh Dickins <hughd@google.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Andrew Morton <akpm@linux-foundation.org>, Al Viro
 <viro@zeniv.linux.org.uk>, =?UTF-8?Q?Miko=C5=82aj_Wasiak?=
 <mikolaj.wasiak@intel.com>, Christian Brauner <brauner@kernel.org>,
 Nitin Gote <nitin.r.gote@intel.com>, Andi Shyti
 <andi.shyti@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Christopher Healy <healych@amazon.com>, Matthew Wilcox
 <willy@infradead.org>, Bagas Sanjaya <bagasdotme@gmail.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, kernel@collabora.com
References: <20251015153018.43735-1-loic.molinari@collabora.com>
 <20251015153018.43735-9-loic.molinari@collabora.com>
 <20251015201737.3956f801@fedora>
Content-Language: fr
From: =?UTF-8?Q?Lo=C3=AFc_Molinari?= <loic.molinari@collabora.com>
Organization: Collabora Ltd
In-Reply-To: <20251015201737.3956f801@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15/10/2025 20:17, Boris Brezillon wrote:
> On Wed, 15 Oct 2025 17:30:12 +0200
> Loïc Molinari <loic.molinari@collabora.com> wrote:
> 
>> Don't declare "super_pages" on builds with CONFIG_TRANSPARENT_HUGEPAGE
>> disabled to prevent build error:
>>
>> ERROR: modpost: "super_pages" [drivers/gpu/drm/v3d/v3d.ko] undefined!
> 
> I believe this is a bug introduced by the previous commit: the
> compiler probably drops any code between the
> IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) check and the err label
> because IS_ENABLED() evaluates to false at compile time. So I'd squash
> those changes in the previous commit.

Right, it's been introduced in previous commit.

>
>>
>> Signed-off-by: Loïc Molinari <loic.molinari@collabora.com>
>> ---
>>   drivers/gpu/drm/v3d/v3d_drv.h | 2 ++
>>   drivers/gpu/drm/v3d/v3d_gem.c | 2 ++
>>   2 files changed, 4 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
>> index 99a39329bb85..481502104391 100644
>> --- a/drivers/gpu/drm/v3d/v3d_drv.h
>> +++ b/drivers/gpu/drm/v3d/v3d_drv.h
>> @@ -564,7 +564,9 @@ extern const struct dma_fence_ops v3d_fence_ops;
>>   struct dma_fence *v3d_fence_create(struct v3d_dev *v3d, enum v3d_queue q);
>>   
>>   /* v3d_gem.c */
>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>   extern bool super_pages;
>> +#endif
>>   int v3d_gem_init(struct drm_device *dev);
>>   void v3d_gem_destroy(struct drm_device *dev);
>>   void v3d_reset_sms(struct v3d_dev *v3d);
>> diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
>> index 635ff0fabe7e..0039063eb8b2 100644
>> --- a/drivers/gpu/drm/v3d/v3d_gem.c
>> +++ b/drivers/gpu/drm/v3d/v3d_gem.c
>> @@ -269,7 +269,9 @@ v3d_huge_mnt_init(struct v3d_dev *v3d)
>>   	 * match our usecase.
>>   	 */
>>   
>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>   	if (super_pages)
>> +#endif
>>   		err = drm_gem_huge_mnt_create(&v3d->drm, "within_size");
> 
> Why not
> 
> #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>    	if (super_pages)
>    		err = drm_gem_huge_mnt_create(&v3d->drm, "within_size");
> #endif
> 
> I guess
> 
> 	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) && super_pages)
> 		err = drm_gem_huge_mnt_create(&v3d->drm, "within_size");
> 
> would also do, since it's likely to rely on the same optimization the
> previous v3d_gemfs_init() implementation was relying on, but it's
> fragile (not sure what happens when compiled with -O0).

I'll remove the #ifdef/#endif around the super_pages declaration in 
v3d_drv.h because it isn't necessary if super_pages is compiled out in 
v3d_huge_mnt_init().

In v3d_huge_mnt_init(), I'd add the #ifdef before the ret variable 
declaration and the #endif right after the last else so that it's clear 
drm_notice("THP is recommended...") is called unconditionally when 
CONFIG_TRANSPARENT_HUGEPAGE=n, whatever the optim level. What do you think?

> 
>>   
>>   	if (v3d->drm.huge_mnt)
> 


