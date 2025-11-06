Return-Path: <linux-kernel+bounces-889023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8821BC3C861
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 17:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A77A8420E52
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 16:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2245D3491EB;
	Thu,  6 Nov 2025 16:33:06 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF765214236
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 16:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762446785; cv=none; b=mxt+Tje/XHqwdIsON42skxjvzyhiUiYIXKWFzGTs7cqzzwiFpYHN/V2s17Ep3k8iKxyZ7YjuMuJE03+SEgL7hwyzYs8/AmrQs3VIJde7sEh6J54UhOgN99PhTU15ucm7DusXVoR06rqhN8ODpxsN3dvdY/k0oargJgVv3HViyME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762446785; c=relaxed/simple;
	bh=o9fiIS3uun1k3bj/Y0c2ckqno1Eb1lFwcu8R14ViDmI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j7OU7bv8fCwMiDVgV0TBvP8Do+xLzGCTbrMjCQvT8zSbg3TTf3iLAL0sBwIgXwK9DnD2kJJosVkiGXw3OBVrQVIldllCL2UO2ZMXAYymaN11r0YAsZAeaXoAJnXuC/u/5HiPtj4W6j/7z9eJzacLGcg66xwglAzRIXtvuvqGIm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 903721516;
	Thu,  6 Nov 2025 08:32:54 -0800 (PST)
Received: from [10.1.30.195] (XHFQ2J9959.cambridge.arm.com [10.1.30.195])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C8FFD3F66E;
	Thu,  6 Nov 2025 08:32:59 -0800 (PST)
Message-ID: <8bc796e2-f652-4c12-a347-7b778ae7f899@arm.com>
Date: Thu, 6 Nov 2025 16:32:58 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: madvise(MADV_COLLAPSE) fails with EINVAL on dirty file-backed
 text pages
Content-Language: en-GB
To: "Garg, Shivank" <shivankg@amd.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Vlastimil Babka <vbabka@suse.cz>,
 Jann Horn <jannh@google.com>, zokeefe@google.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <4e26fe5e-7374-467c-a333-9dd48f85d7cc@amd.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <4e26fe5e-7374-467c-a333-9dd48f85d7cc@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/11/2025 12:16, Garg, Shivank wrote:
> Hi All,
> 
> I've been investigating an issue with madvise(MADV_COLLAPSE) for TEXT pages
> when CONFIG_READ_ONLY_THP_FOR_FS=y is enabled, and would like to discuss the
> current behavior and improvements.
> 
> Problem:
> When attempting to collapse read-only file-backed TEXT sections into THPs
> using madvise(MADV_COLLAPSE), the operation fails with EINVAL if the pages
> are marked dirty.
> madvise(aligned_start, aligned_size, MADV_COLLAPSE) -> returns -1 and errno = -22
> 
> Subsequent calls to madvise(MADV_COLLAPSE) succeed because the first madvise 
> attempt triggers filemap_flush() which initiates async writeback of the dirty folios.
> 
> Root Cause:
> The failure occurs in mm/khugepaged.c:collapse_file():
> } else if (folio_test_dirty(folio)) {
>     /*
>      * khugepaged only works on read-only fd,
>      * so this page is dirty because it hasn't
>      * been flushed since first write. There
>      * won't be new dirty pages.
>      *
>      * Trigger async flush here and hope the
>      * writeback is done when khugepaged
>      * revisits this page.
>      */
>     xas_unlock_irq(&xas);
>     filemap_flush(mapping);
>     result = SCAN_FAIL;
>     goto xa_unlocked;
> }
> 
> Why the text pages are dirty?

This is the real question to to answer, I think...

What architecture are you running on?


> It initially seemed unusual for a read-only text section to be marked as dirty, but
> this was actually confirmed by /proc/pid/smaps.
> 
> 55bc90200000-55bc91200000 r-xp 00400000 07:00 133                        /mnt/xfs-mnt/large_binary_thp
> Size:              16384 kB
> KernelPageSize:        4 kB
> MMUPageSize:           4 kB
> Rss:                 256 kB
> Pss:                 256 kB
> Pss_Dirty:           256 kB
> Shared_Clean:          0 kB
> Shared_Dirty:          0 kB
> Private_Clean:         0 kB
> Private_Dirty:       256 kB
> 
> /proc/pid/smaps (before calling MADV_COLLAPSE) showing Private_Dirty pages in r-xp mappings.
> This may be due to dynamic linker and relocations that occurred during program loading.

On arm64 at least, I wouldn't expect the text to be modified. Relocations should
be handled in data. But given you have private dirty pages here, they must have
been cow'ed and are therefore anonymous? In which case, where is writeback
actually going?

> 
> Reproduction using XFS/EXT4:
> 
> 1. Compile a test binary with madvise(MADV_COLLAPSE), ensuring the load TEXT segment is
>    2MB-aligned and sized to a multiple of 2MB. 
>   Type           Offset   VirtAddr           PhysAddr           FileSiz  MemSiz   Flg Align
> LOAD           0x400000 0x0000000000400000 0x0000000000400000 0x1000000 0x1000000 R E 0x200000
> 
> 2. Create and mount the XFS/EXT4 fs:
>    dd if=/dev/zero of=/tmp/xfs-test.img bs=1M count=1024
>    losetup -f --show /tmp/xfs-test.img  # output: /dev/loop0
>    mkfs.xfs -f /dev/loop0
>    mkdir -p /mnt/xfs-mnt
>    mount /dev/loop0 /mnt/xfs-mnt
> 3. Copy the binaries to /mnt/xfs-mnt and execute.
> 4. Returns -EINVAL on first run, then run successfully on subsequent run. (100% reproducible)
> 5. To reproduce again; reboot/kexec and repeat from step 2. 
> 
> Workaround:
> 1. Manually flush dirty pages before calling madvise(MADV_COLLAPSE):
> 	int fd = open("/proc/self/exe", O_RDONLY);
> 	if (fd >= 0) {
> 		fsync(fd);
> 		close(fd);
> 	}
> 	// Now madvise(MADV_COLLAPSE) succeeds
> 2. Alternatively, retrying madvise_collapse on EINVAL failure also work.
> 
> Problems with Current Behavior:
> 1. Confusing Error Code: The syscall returns EINVAL which typically indicates invalid arguments
>    rather than a transient condition that could succeed on retry.
> 
> 2. Non-Transparent Handling: Users are unaware they need to flush dirty pages manually. Current
>    madvise_collapse assumes the caller is khugepaged (as per code snippet comment) which will revisit
>    the page. However, when called via madvise(MADV_COLLAPSE), the userspace program typically don't
>    retry, making the async flush ineffective. Should we differentiate between madvise and khugepaged
>    behavior for MADV_COLLAPSE?
> 
> Would appreciate thoughts on the best approach to address this issue.
> 
> Thanks,
> Shivank


