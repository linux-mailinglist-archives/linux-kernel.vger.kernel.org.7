Return-Path: <linux-kernel+bounces-837133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68964BAB774
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 07:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D68CC1920691
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 05:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD6226FA70;
	Tue, 30 Sep 2025 05:26:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD63B56B81
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 05:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759209985; cv=none; b=AO3Ka+/bgTrKq8eqZfmljn+YDyXihGFvOZXxtxlVv3ojMsTWBXFdH+wxbINNSor8aedYE9Vd6triRv6zIYgbmKmnORfxBhF+JjWvLEVLSq9PQ3u7LFtzzLKhaWjOiic6B/w19dfhor1JwrsPKiRNT/Klau6rZgyNFZZxQkkTbP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759209985; c=relaxed/simple;
	bh=vaekgufu7e17ibSD/1+KqWanG9gui0O5PHhadNh/0WE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EuRbLC+0A/2NuWqLSpXZlcBNx29tlUUNRIg44883omkEvzQrQa6kAP+PwoGgNjfgqGV28aASyxZ3G1wfRxOvFiBxg+WZ4w5IeTlRaduMNMQC9BJQAhJGVxav+/91GCAVJtRVhLIKkAhpVPaFgD0t3Zt0gUlmzQEoS7oUKH4W/1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 054201424;
	Mon, 29 Sep 2025 22:26:15 -0700 (PDT)
Received: from [10.164.18.53] (MacBook-Pro.blr.arm.com [10.164.18.53])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 145EE3F5A1;
	Mon, 29 Sep 2025 22:26:18 -0700 (PDT)
Message-ID: <cc40d827-3b98-4e15-ad45-5c2033e4ce20@arm.com>
Date: Tue, 30 Sep 2025 10:56:15 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 PATCH] mm: hugetlb: avoid soft lockup when mprotect to large
 memory area
To: Yang Shi <yang@os.amperecomputing.com>, muchun.song@linux.dev,
 osalvador@suse.de, david@redhat.com, akpm@linux-foundation.org,
 catalin.marinas@arm.com, will@kernel.org, anshuman.khandual@arm.com,
 carl@os.amperecomputing.com, cl@gentwo.org
Cc: linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250929202402.1663290-1-yang@os.amperecomputing.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250929202402.1663290-1-yang@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 30/09/25 1:54 am, Yang Shi wrote:
> When calling mprotect() to a large hugetlb memory area in our customer's
> workload (~300GB hugetlb memory), soft lockup was observed:
>
> watchdog: BUG: soft lockup - CPU#98 stuck for 23s! [t2_new_sysv:126916]
>
> CPU: 98 PID: 126916 Comm: t2_new_sysv Kdump: loaded Not tainted 6.17-rc7
> Hardware name: GIGACOMPUTING R2A3-T40-AAV1/Jefferson CIO, BIOS 5.4.4.1 07/15/2025
> pstate: 20400009 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : mte_clear_page_tags+0x14/0x24
> lr : mte_sync_tags+0x1c0/0x240
> sp : ffff80003150bb80
> x29: ffff80003150bb80 x28: ffff00739e9705a8 x27: 0000ffd2d6a00000
> x26: 0000ff8e4bc00000 x25: 00e80046cde00f45 x24: 0000000000022458
> x23: 0000000000000000 x22: 0000000000000004 x21: 000000011b380000
> x20: ffff000000000000 x19: 000000011b379f40 x18: 0000000000000000
> x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
> x11: 0000000000000000 x10: 0000000000000000 x9 : ffffc875e0aa5e2c
> x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000000
> x5 : fffffc01ce7a5c00 x4 : 00000000046cde00 x3 : fffffc0000000000
> x2 : 0000000000000004 x1 : 0000000000000040 x0 : ffff0046cde7c000
>
> Call trace:
>    mte_clear_page_tags+0x14/0x24
>    set_huge_pte_at+0x25c/0x280
>    hugetlb_change_protection+0x220/0x430
>    change_protection+0x5c/0x8c
>    mprotect_fixup+0x10c/0x294
>    do_mprotect_pkey.constprop.0+0x2e0/0x3d4
>    __arm64_sys_mprotect+0x24/0x44
>    invoke_syscall+0x50/0x160
>    el0_svc_common+0x48/0x144
>    do_el0_svc+0x30/0xe0
>    el0_svc+0x30/0xf0
>    el0t_64_sync_handler+0xc4/0x148
>    el0t_64_sync+0x1a4/0x1a8
>
> Soft lockup is not triggered with THP or base page because there is
> cond_resched() called for each PMD size.
>
> Although the soft lockup was triggered by MTE, it should be not MTE
> specific. The other processing which takes long time in the loop may
> trigger soft lockup too.
>
> So add cond_resched() for hugetlb to avoid soft lockup.
>
> Fixes: 8f860591ffb2 ("[PATCH] Enable mprotect on huge pages")
> Tested-by: Carl Worth <carl@os.amperecomputing.com>
> Reviewed-by: Christoph Lameter (Ampere) <cl@gentwo.org>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Acked-by: Oscar Salvador <osalvador@suse.de>
> Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
> ---
> v2: - Made the subject and commit message less MTE specific and fixed
>        the fixes tag.
>      - Collected all R-bs and A-bs.
>
>   mm/hugetlb.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index cb5c4e79e0b8..fe6606d91b31 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -7242,6 +7242,8 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
>   						psize);
>   		}
>   		spin_unlock(ptl);
> +
> +		cond_resched();
>   	}
>   	/*
>   	 * Must flush TLB before releasing i_mmap_rwsem: x86's huge_pmd_unshare

Reviewed-by: Dev Jain <dev.jain@arm.com>

Does it make sense to also do cond_resched() in the huge_pmd_unshare() branch?
That also amounts to clearing a page. And I can see for example, zap_huge_pmd()
and change_huge_pmd() consume a cond_resched().


