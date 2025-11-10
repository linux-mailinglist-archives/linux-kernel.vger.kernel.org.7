Return-Path: <linux-kernel+bounces-893398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04803C4742A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBA0C188F288
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DEFD31283E;
	Mon, 10 Nov 2025 14:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="fq/6bZr3"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B492FE07F;
	Mon, 10 Nov 2025 14:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762785583; cv=none; b=OP3ONRBSJcKWrNrJ3k9igYYcgQbaDrol4hDHIQgc9cLUk/oGJTnnpLRKzGDvDYJ+DQVp+9vscXAPeFIyJAxR19rtgXvqcQqQduAUWuiK5X3c9D4jlBmNwkCZWGE6IW3uPbpn8BuCBbHbNqknG3JGqaWuHwTOTUbDZz1+AJaDVuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762785583; c=relaxed/simple;
	bh=PmfHj5puT5EuJo5jMH3r8sbaCa9NbA7iIIBw3q5tS7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y1JF2q/LAVuk8zCh2TBt8WZ4gZJHNepY7IeZM0X5scVsMFdMOycFXrCrywyRhAC2Q54a0GHgyXnwtDOYPvDO04zdNuFF2LFGXJD7vofpCoKl5/Qaj3QtD4jRETtkj6U5pzWgeQxeBP1AER1zIB/42HEdDKSiRAueJJ8PD8LF63s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=fq/6bZr3; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1762785579;
	bh=PmfHj5puT5EuJo5jMH3r8sbaCa9NbA7iIIBw3q5tS7U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fq/6bZr3AF2h2wkMNGSn1bXsocPuQEeBd+ezF2avzPXvHo/lvHsrcNC+tZbS8E5Iq
	 xkJB4+am2a5IfxqIp+ehb9NPVKFSgvleVHdn4CivlgZRwnuPF9SnL8ajyR0NknfvP2
	 s7xp9Kqk+2jipyZbRtQfHx9eyAwAhm/ABmTkeAkIjdOiTtc2+8qqtYFcn7QauIky0J
	 qi2AkZfthvSdYWmtrRTHuQs5oTa836l4Rwoz4pKgCE7iGHMIdDFb3F2YXgGACOPt1d
	 jxQdyUfGkeW7/htZh8Ig5e8reM+6vEQVZbJRkW4WM4vf5Ct5o9PibWgvFUQrFyq3hO
	 0R67ZlTin9JNA==
Received: from [IPV6:2a01:e0a:5e3:6100:7aed:fe0e:8590:cbaa] (unknown [IPv6:2a01:e0a:5e3:6100:7aed:fe0e:8590:cbaa])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: loicmolinari)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 17CAE17E0610;
	Mon, 10 Nov 2025 15:39:38 +0100 (CET)
Message-ID: <e19cdd3a-0d33-4c06-9c9a-7e9e2df51c4b@collabora.com>
Date: Mon, 10 Nov 2025 15:39:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/13] drm/shmem-helper: Map huge pages in fault
 handlers
To: Matthew Wilcox <willy@infradead.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>, Melissa Wen <mwen@igalia.com>,
 =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Hugh Dickins <hughd@google.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Andrew Morton <akpm@linux-foundation.org>,
 Al Viro <viro@zeniv.linux.org.uk>, =?UTF-8?Q?Miko=C5=82aj_Wasiak?=
 <mikolaj.wasiak@intel.com>, Christian Brauner <brauner@kernel.org>,
 Nitin Gote <nitin.r.gote@intel.com>, Andi Shyti
 <andi.shyti@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Christopher Healy <healych@amazon.com>, Bagas Sanjaya
 <bagasdotme@gmail.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 linux-mm@kvack.org, linux-doc@vger.kernel.org, kernel@collabora.com
References: <20251015153018.43735-1-loic.molinari@collabora.com>
 <20251015153018.43735-4-loic.molinari@collabora.com>
 <aO_ZmA6yoqbzTKt9@casper.infradead.org>
 <f564735b-7cbd-486c-9dd4-a4555e73edde@collabora.com>
 <aPK4YwMmYTDsKHcL@casper.infradead.org>
Content-Language: fr
From: =?UTF-8?Q?Lo=C3=AFc_Molinari?= <loic.molinari@collabora.com>
Organization: Collabora Ltd
In-Reply-To: <aPK4YwMmYTDsKHcL@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Matthew,

On 17/10/2025 23:42, Matthew Wilcox wrote:
> On Thu, Oct 16, 2025 at 01:17:07PM +0200, Loïc Molinari wrote:
>>> It looks to me like we have an opportunity to do better here by
>>> adding a vmf_insert_pfns() interface.  I don't think we should delay
>>> your patch series to add it, but let's not forget to do that; it can
>>> have very good performnce effects on ARM to use contptes.
>>
>> Agreed. I initially wanted to provide such an interface based on set_ptes()
>> to benefit from arm64 contptes but thought it'd better be a distinct patch
>> series.
> 
> Agreed.
> 
>>>
>>>> @@ -617,8 +645,9 @@ static vm_fault_t drm_gem_shmem_fault(struct vm_fault *vmf)
>>> [...]
>>>> -		ret = vmf_insert_pfn(vma, vmf->address, page_to_pfn(page));
>>>> +	if (drm_gem_shmem_map_pmd(vmf, vmf->address, pages[page_offset])) {
>>>> +		ret = VM_FAULT_NOPAGE;
>>>> +		goto out;
>>>>    	}
>>>
>>> Does this actually work?
>>
>> Yes, it does. Huge pages are successfully mapped from both map_pages and
>> fault handlers. Anything wrong with it?
> 
> No, I just wasn't sure that this would work correctly.
> 
>> There seems to be an another issue thought. There are failures [1], all
>> looking like that one [2]. I think it's because map_pages is called with the
>> RCU read lock taken and the DRM GEM map_pages handler must lock the GEM
>> object before accessing pages with dma_resv_lock(). The locking doc says:
>> "If it's not possible to reach a page without blocking, filesystem should
>> skip it.". Unlocking the RCU read lock in the handler seems wrong and doing
>> without a map_pages implementation would be unfortunate. What would you
>> recommend here?
> 
> I'm not familiar with GEM locking, so let me describe briefly how
> pagecache locking works.
> 
> Calling mmap bumps the refcount on the inode.  That keeps the inode
> around while the page fault handler runs.  For each folio, we
> get a refcount on it, then we trylock it.  Then we map each page in the
> folio.
> 
> So maybe you can trylock the GEM object?  It isn't clear to me whether
> you want finer grained locking than that.  If the trylock fails, no big
> deal, you just fall through to the fault path (with the slightly more
> heavy-weight locking that allows you to sleep).

I proposed a series v5 using dma_resv_trylock(). This actually fails 
later because the vmf_insert_pfn*() functions end up locking too. Not 
sure how to fix that yet so I proposed a v6 with no fault-around path 
and will get back to it (along with contptes) later.

Loïc


