Return-Path: <linux-kernel+bounces-829880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A88E6B981C4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 05:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DC2B3B5992
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 03:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53378221D87;
	Wed, 24 Sep 2025 03:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ry3iHDml"
Received: from out199-7.us.a.mail.aliyun.com (out199-7.us.a.mail.aliyun.com [47.90.199.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21FB218AB4
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 03:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758683542; cv=none; b=l8rDJoVnEBp5uyhQpyfvT4g0po1GQrVvhrsEN1Xw1Tpkh4DLD43ObW8dqHbKiVkpGqqHynpFi8QZdsM4Oqgu8SFyvDp6fE9S7B+u0UOycObkMsk38Q9772JFqgiXlteFfHStWXCN4Ftdvf98EaHjuZjmcUBFxmYWMyQLhWcKuPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758683542; c=relaxed/simple;
	bh=4KRzPk+WDjqQnffj3OHJj3feiD+xFaFO1BvB3rOsjc8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y0A1G+K52260ZXQJKG92x3FQCAGJwY5u/VboH2Gmz1yXDTK7q/6mgiYueBZ0MURssUyarWfeIQvQnpuL4VQi5RSb4kzCVSRoKZgiBDmr0t/K3IiA8gP6wjrjBNwQjquXkxeQU1pMjn6S52fpEjgbOZbnOxbaoDTFOgSe56o0POQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ry3iHDml; arc=none smtp.client-ip=47.90.199.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758683521; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=jpN6MR9tWHzIM5XbfO5zo6eTuKj59QIgIbF5cCp3dF8=;
	b=ry3iHDmlMOJFCVsLB0QrfCdy8xkhscZIEbjVYnvOSr5QOkmGlnin0ReRcAJAb6QTu9vtleZR4cFuSbSuTnXMwX3wVLfUcP4J4IHb+QKTCVnMo2TTmEIAxCWhcpbObbxSIqTvCaIy06sosyYV441Mje9d/LyrZk3rf3BXpH+NrbU=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0WohrEz9_1758683508 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 24 Sep 2025 11:11:59 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: Zi Yan <ziy@nvidia.com>
Cc: Shivank Garg <shivankg@amd.com>,  akpm@linux-foundation.org,
  david@redhat.com,  willy@infradead.org,  matthew.brost@intel.com,
  joshua.hahnjy@gmail.com,  rakie.kim@sk.com,  byungchul@sk.com,
  gourry@gourry.net,  apopple@nvidia.com,  lorenzo.stoakes@oracle.com,
  Liam.Howlett@oracle.com,  vbabka@suse.cz,  rppt@kernel.org,
  surenb@google.com,  mhocko@suse.com,  vkoul@kernel.org,
  lucas.demarchi@intel.com,  rdunlap@infradead.org,  jgg@ziepe.ca,
  kuba@kernel.org,  justonli@chromium.org,  ivecera@redhat.com,
  dave.jiang@intel.com,  Jonathan.Cameron@huawei.com,
  dan.j.williams@intel.com,  rientjes@google.com,
  Raghavendra.KodsaraThimmappa@amd.com,  bharata@amd.com,
  alirad.malek@zptcorp.com,  yiannis@zptcorp.com,  weixugc@google.com,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org
Subject: Re: [RFC V3 0/9] Accelerate page migration with batch copying and
 hardware offload
In-Reply-To: <C8E561B3-B9DB-4F58-A2C7-4EE17E08A993@nvidia.com> (Zi Yan's
	message of "Tue, 23 Sep 2025 22:03:18 -0400")
References: <20250923174752.35701-1-shivankg@amd.com>
	<87plbghb66.fsf@DESKTOP-5N7EMDA>
	<C8E561B3-B9DB-4F58-A2C7-4EE17E08A993@nvidia.com>
Date: Wed, 24 Sep 2025 11:11:36 +0800
Message-ID: <87tt0sfst3.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Zi Yan <ziy@nvidia.com> writes:

> On 23 Sep 2025, at 21:49, Huang, Ying wrote:
>
>> Hi, Shivank,
>>
>> Thanks for working on this!
>>
>> Shivank Garg <shivankg@amd.com> writes:
>>
>>> This is the third RFC of the patchset to enhance page migration by batching
>>> folio-copy operations and enabling acceleration via multi-threaded CPU or
>>> DMA offload.
>>>
>>> Single-threaded, folio-by-folio copying bottlenecks page migration
>>> in modern systems with deep memory hierarchies, especially for large
>>> folios where copy overhead dominates, leaving significant hardware
>>> potential untapped.
>>>
>>> By batching the copy phase, we create an opportunity for significant
>>> hardware acceleration. This series builds a framework for this acceleration
>>> and provides two initial offload driver implementations: one using multiple
>>> CPU threads (mtcopy) and another leveraging the DMAEngine subsystem (dcbm).
>>>
>>> This version incorporates significant feedback to improve correctness,
>>> robustness, and the efficiency of the DMA offload path.
>>>
>>> Changelog since V2:
>>>
>>> 1. DMA Engine Rewrite:
>>>    - Switched from per-folio dma_map_page() to batch dma_map_sgtable()
>>>    - Single completion interrupt per batch (reduced overhead)
>>>    - Order of magnitude improvement in setup time for large batches
>>> 2. Code cleanups and refactoring
>>> 3. Rebased on latest mainline (6.17-rc6+)
>>>
>>> MOTIVATION:
>>> -----------
>>>
>>> Current Migration Flow:
>>> [ move_pages(), Compaction, Tiering, etc. ]
>>>               |
>>>               v
>>>      [ migrate_pages() ] // Common entry point
>>>               |
>>>               v
>>>     [ migrate_pages_batch() ] // NR_MAX_BATCHED_MIGRATION (512) folios at a time
>>>       |
>>>       |--> [ migrate_folio_unmap() ]
>>>       |
>>>       |--> [ try_to_unmap_flush() ] // Perform a single, batched TLB flush
>>>       |
>>>       |--> [ migrate_folios_move() ] // Bottleneck: Interleaved copy
>>>            - For each folio:
>>>              - Metadata prep: Copy flags, mappings, etc.
>>>              - folio_copy()  <-- Single-threaded, serial data copy.
>>>              - Update PTEs & finalize for that single folio.
>>>
>>> Understanding overheads in page migration (move_pages() syscall):
>>>
>>> Total move_pages() overheads = folio_copy() + Other overheads
>>> 1. folio_copy() is the core copy operation that interests us.
>>> 2. The remaining operations are user/kernel transitions, page table walks,
>>> locking, folio unmap, dst folio alloc, TLB flush, copying flags, updating
>>> mappings and PTEs etc. that contribute to the remaining overheads.
>>>
>>> Percentage of folio_copy() overheads in move_pages(N pages) syscall time:
>>> Number of pages being migrated and folio size:
>>>             4KB     2MB
>>> 1 page     <1%     ~66%
>>> 512 page   ~35%    ~97%
>>>
>>> Based on Amdahl's Law, optimizing folio_copy() for large pages offers a
>>> substantial performance opportunity.
>>>
>>> move_pages() syscall speedup = 1 / ((1 - F) + (F / S))
>>> Where F is the fraction of time spent in folio_copy() and S is the speedup of
>>> folio_copy().
>>>
>>> For 4KB folios, folio copy overheads are significantly small in single-page
>>> migrations to impact overall speedup, even for 512 pages, maximum theoretical
>>> speedup is limited to ~1.54x with infinite folio_copy() speedup.
>>>
>>> For 2MB THPs, folio copy overheads are significant even in single page
>>> migrations, with a theoretical speedup of ~3x with infinite folio_copy()
>>> speedup and up to ~33x for 512 pages.
>>>
>>> A realistic value of S (speedup of folio_copy()) is 7.5x for DMA offload
>>> based on my measurements for copying 512 2MB pages.
>>> This gives move_pages(), a practical speedup of 6.3x for 512 2MB page (also
>>> observed in the experiments below).
>>>
>>> DESIGN: A Pluggable Migrator Framework
>>> ---------------------------------------
>>>
>>> Introduce migrate_folios_batch_move():
>>>
>>> [ migrate_pages_batch() ]
>>>     |
>>>     |--> migrate_folio_unmap()
>>>     |
>>>     |--> try_to_unmap_flush()
>>>     |
>>>     +--> [ migrate_folios_batch_move() ] // new batched design
>>>             |
>>>             |--> Metadata migration
>>>             |    - Metadata prep: Copy flags, mappings, etc.
>>>             |    - Use MIGRATE_NO_COPY to skip the actual data copy.
>>>             |
>>>             |--> Batch copy folio data
>>>             |    - Migrator is configurable at runtime via sysfs.
>>>             |
>>>             |          static_call(_folios_copy) // Pluggable migrators
>>>             |          /          |            \
>>>             |         v           v             v
>>>             | [ Default ]  [ MT CPU copy ]  [ DMA Offload ]
>>>             |
>>>             +--> Update PTEs to point to dst folios and complete migration.
>>>
>>
>> I just jump in the discussion, so this may be discussed before already.
>> Sorry if so.  Why not
>>
>> migrate_folios_unmap()
>> try_to_unmap_flush()
>> copy folios in parallel if possible
>> migrate_folios_move(): with MIGRATE_NO_COPY?
>
> Since in move_to_new_folio(), there are various migration preparation
> works, which can fail. Copying folios regardless might lead to some
> unnecessary work. What is your take on this?

Good point, we should skip copying folios that fails the checks.

>>
>>> User Control of Migrator:
>>>
>>> # echo 1 > /sys/kernel/dcbm/offloading
>>>    |
>>>    +--> Driver's sysfs handler
>>>         |
>>>         +--> calls start_offloading(&cpu_migrator)
>>>               |
>>>               +--> calls offc_update_migrator()
>>>                     |
>>>                     +--> static_call_update(_folios_copy, mig->migrate_offc)
>>>
>>> Later, During Migration ...
>>> migrate_folios_batch_move()
>>>     |
>>>     +--> static_call(_folios_copy) // Now dispatches to the selected migrator
>>>           |
>>>           +-> [ mtcopy | dcbm | kernel_default ]
>>>
>>
>> [snip]

---
Best Regards,
Huang, Ying

