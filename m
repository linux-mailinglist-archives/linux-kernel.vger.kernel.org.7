Return-Path: <linux-kernel+bounces-750315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D59B159ED
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 09:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B15618C0E82
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 07:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D86292B40;
	Wed, 30 Jul 2025 07:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hqbuTHFk"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F40290D9C
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 07:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753861588; cv=none; b=Sypofj8CbQ3HSRAEZdd657cKdf07+bbbXVoepR3mtkz4Jlh1VfXEpNOQGFL7Zm0hIsr0QdNtfulOtAhsIzxgo2lekVdIdsgbMD9CISBBM0RNOmv5PBUKfpvcvlDJvhLdzk8gLIxU6RkNZZOFbKjbFj6XfpIi/cu+0kIavIVu+98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753861588; c=relaxed/simple;
	bh=hM0XLIeAi7J4Bjt83dta1H4ZcWgXJwvOP0OEhvwBKJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bAUXV9clKe85hs45ndSiHEjpsiZxsnyhgYO3FnpBKe55nknTyYliYKkEy/41m08DYf+GpDm97nSe3+1hEkhXL/pmbM2il8d9zfUC8lyN0yTvIx2Hrhhu6veDFCcZxaWPbYIRerYGnSvh9x6Cn6bmWdGtz9/kx2dl+IuoAi1uVok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=hqbuTHFk; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753861582; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Rw9coQSPDusbh6xlzH1libYuWMCbw8rIDakkSoz4oHQ=;
	b=hqbuTHFkY7Wd99fNVDc/QqD83GFNCXqkkwMFpGelhw77OH/bEsQtw/UHzl75K2aJJV94eSgtKY/fQ+k/QuSqZQ6ePnAxyv8XmapXC7+S1CKj/3fLtGARLRi9/3XxFMJgA36IpwmixhfcZetqDkr8NaBc0igUfgenII8Ou85fXPw=
Received: from 30.74.144.115(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WkU-UhV_1753861580 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 30 Jul 2025 15:46:20 +0800
Message-ID: <817c59dd-ad54-47f1-ac16-9cb9583308d1@linux.alibaba.com>
Date: Wed, 30 Jul 2025 15:46:19 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: shmem: fix the shmem large folio allocation for the
 i915 driver
To: Hugh Dickins <hughd@google.com>
Cc: akpm@linux-foundation.org, patryk@kowalczyk.ws,
 ville.syrjala@linux.intel.com, david@redhat.com, willy@infradead.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, jani.nikula@linux.intel.com,
 joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
 tursulin@ursulin.net, christian.koenig@amd.com, ray.huang@amd.com,
 matthew.auld@intel.com, matthew.brost@intel.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <0d734549d5ed073c80b11601da3abdd5223e1889.1753689802.git.baolin.wang@linux.alibaba.com>
 <ff93c415-7ce8-a331-9568-7543c6a37992@google.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <ff93c415-7ce8-a331-9568-7543c6a37992@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/7/30 14:54, Hugh Dickins wrote:
> On Mon, 28 Jul 2025, Baolin Wang wrote:
> 
>> After commit acd7ccb284b8 ("mm: shmem: add large folio support for tmpfs"),
>> we extend the 'huge=' option to allow any sized large folios for tmpfs,
>> which means tmpfs will allow getting a highest order hint based on the size
>> of write() and fallocate() paths, and then will try each allowable large order.
>>
>> However, when the i915 driver allocates shmem memory, it doesn't provide hint
>> information about the size of the large folio to be allocated, resulting in
>> the inability to allocate PMD-sized shmem, which in turn affects GPU performance.
>>
>> To fix this issue, add the 'end' information for shmem_read_folio_gfp()  to help
>> allocate PMD-sized large folios. Additionally, use the maximum allocation chunk
>> (via mapping_max_folio_size()) to determine the size of the large folios to
>> allocate in the i915 driver.
>>
>> Fixes: acd7ccb284b8 ("mm: shmem: add large folio support for tmpfs")
>> Reported-by: Patryk Kowalczyk <patryk@kowalczyk.ws>
>> Reported-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
>> Tested-by: Patryk Kowalczyk <patryk@kowalczyk.ws>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>   drivers/gpu/drm/drm_gem.c                 | 2 +-
>>   drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 7 ++++++-
>>   drivers/gpu/drm/ttm/ttm_backup.c          | 2 +-
>>   include/linux/shmem_fs.h                  | 4 ++--
>>   mm/shmem.c                                | 7 ++++---
>>   5 files changed, 14 insertions(+), 8 deletions(-)
> 
> I know I said "I shall not object to a temporary workaround to suit the
> i915 driver", but really, I have to question this patch.  Why should any
> change be required at the drivers/gpu/drm end?
> 
> And in drivers/gpu/drm/{i915,v3d} I find they are using huge=within_size:
> I had been complaining about the userspace regression in huge=always,
> and thought it had been changed to behave like huge=within_size,
> but apparently huge=within_size has itself regressed too.

I'm preparing a RFC patch to discuss this.

> Please explain why the below is not a better patch for i915 and v3d
> (but still a temporary workaround, because the root of the within_size
> regression must lie deeper, in the handling of write_end versus i_size).

OK. This looks good to me. Patryk, could you try Hugh's simple patch? 
Thanks.

> ---
>   mm/shmem.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 3a5a65b1f41a..c67dfc17a819 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -5928,8 +5928,8 @@ struct folio *shmem_read_folio_gfp(struct address_space *mapping,
>   	struct folio *folio;
>   	int error;
>   
> -	error = shmem_get_folio_gfp(inode, index, 0, &folio, SGP_CACHE,
> -				    gfp, NULL, NULL);
> +	error = shmem_get_folio_gfp(inode, index, i_size_read(inode),
> +				    &folio, SGP_CACHE, gfp, NULL, NULL);
>   	if (error)
>   		return ERR_PTR(error);
>   


