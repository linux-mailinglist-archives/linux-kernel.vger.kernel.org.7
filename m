Return-Path: <linux-kernel+bounces-888534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BEC3C3B21C
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 14:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B8A9564A00
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 13:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3655732C951;
	Thu,  6 Nov 2025 12:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y35TJK/e"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD8932AAD8
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 12:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762433751; cv=none; b=cc2QX/SSMJlFGTJfenhzBXdrL24VhEko6RM7NKW8NeC1v0++hl5SHhFyFN+Q+AxkMAN2KdH6GMBIKHPRgs35zkN74MCuQ1qYa3+7bZeKZPnMIeIlLoTDNpnPjb5U7avLJwVFBLs1tufPAsDylQoiKbJxHCaXnRwbjzZCp13wgvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762433751; c=relaxed/simple;
	bh=XuhO0g8VcDzYZWbylq4JYxXqVcEMmxbM9WLXFBerBDc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g7a0InK9vlVvjeKTZMdEFsPfC7sQJlhWNmMzH48zKFvBNHJA3WsCJVEZ27hNUK4JYnBLtMxXVI6E7uQmP5oUzyDZXpbXrugQUTEkMNGalZjsV1Xd+vYfyWHi2y+n315zWGlyTZefzJOjGolP4mmKxtRLgUV3aH0rg5yof3tiMJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y35TJK/e; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1783f8fc-6b9b-422e-999e-2a6f58d90807@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762433745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KIYRTh/lQ2wLhS2uIrTPJ7pte4vFCmXgbOw/IFvqqpY=;
	b=Y35TJK/eQ7WBITsWcOlG8qdbMu1yAerex0mNgY9AG2cmFFsR2cYJ6Z3yhmqju/bMhCUo7r
	LbYRNHDpUehRg7zl4T+shR4fHbuYdr+bApB7XZmc8cI6fpwPY5uIurbsnkvFMC9Qbx3tt6
	IxT8gpK9Qt/06OyU+orECwteIAdfhS0=
Date: Thu, 6 Nov 2025 20:55:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: madvise(MADV_COLLAPSE) fails with EINVAL on dirty file-backed
 text pages
Content-Language: en-US
To: "Garg, Shivank" <shivankg@amd.com>
Cc: linux-mm@kvack.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
 Dev Jain <dev.jain@arm.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Jann Horn <jannh@google.com>, David Hildenbrand <david@redhat.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Barry Song <baohua@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, zokeefe@google.com,
 Vlastimil Babka <vbabka@suse.cz>
References: <4e26fe5e-7374-467c-a333-9dd48f85d7cc@amd.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <4e26fe5e-7374-467c-a333-9dd48f85d7cc@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/11/6 20:16, Garg, Shivank wrote:
> Hi All,

Hi Shivank,

Good catch and a really clear analysis - thanks!
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
>      /*
>       * khugepaged only works on read-only fd,
>       * so this page is dirty because it hasn't
>       * been flushed since first write. There
>       * won't be new dirty pages.
>       *
>       * Trigger async flush here and hope the
>       * writeback is done when khugepaged
>       * revisits this page.
>       */
>      xas_unlock_irq(&xas);
>      filemap_flush(mapping);
>      result = SCAN_FAIL;
>      goto xa_unlocked;
> }
> 
> Why the text pages are dirty?
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
> 
> Reproduction using XFS/EXT4:
> 
> 1. Compile a test binary with madvise(MADV_COLLAPSE), ensuring the load TEXT segment is
>     2MB-aligned and sized to a multiple of 2MB.
>    Type           Offset   VirtAddr           PhysAddr           FileSiz  MemSiz   Flg Align
> LOAD           0x400000 0x0000000000400000 0x0000000000400000 0x1000000 0x1000000 R E 0x200000
> 
> 2. Create and mount the XFS/EXT4 fs:
>     dd if=/dev/zero of=/tmp/xfs-test.img bs=1M count=1024
>     losetup -f --show /tmp/xfs-test.img  # output: /dev/loop0
>     mkfs.xfs -f /dev/loop0
>     mkdir -p /mnt/xfs-mnt
>     mount /dev/loop0 /mnt/xfs-mnt
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
>     rather than a transient condition that could succeed on retry.
> 
> 2. Non-Transparent Handling: Users are unaware they need to flush dirty pages manually. Current
>     madvise_collapse assumes the caller is khugepaged (as per code snippet comment) which will revisit
>     the page. However, when called via madvise(MADV_COLLAPSE), the userspace program typically don't
>     retry, making the async flush ineffective. Should we differentiate between madvise and khugepaged
>     behavior for MADV_COLLAPSE?
> 
> Would appreciate thoughts on the best approach to address this issue.

Just throwing out a couple of ideas ...

We could just switch the return code to EAGAIN in the MADV_COLLAPSE 
path. At least that
gives the right hint that retrying is an option ;)

Or, what if we just handle it inside the syscall? When we hit a dirty 
page, we wait for
the writeback to finish and then try again right away. The call might be 
a little slower,
but MADV_COLLAPSE is best effort, right? That seems worth the trouble ...

Cheers,
Lance

