Return-Path: <linux-kernel+bounces-836118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DD5BA8CA2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD1E4173ED5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962E42EE5F4;
	Mon, 29 Sep 2025 09:55:33 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217722D595B
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759139733; cv=none; b=gfMVBQMyL+0QBM+5lR0IN2F7xfX/KEajGyBA04fNFFq/dWXRoXzCUTiiCNeENOFcAkxqd7EZ3MqO+RtbFQH5I79F5rzLjNBXR5VV6SivhYAomhzSXzaAUG1+kaxtn6n5gBArISWT5Ty2RgRcyV0Xi5lB6S76FsNnQCodGBUnxHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759139733; c=relaxed/simple;
	bh=1myuQmDNaxTZNE5dXXtM15OEf8D7Fc8fLTd1O2Ini78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q7kdoIUh7IJoJEkAtSl8aoDI6anRqvNYAtt3nnmxOq8qtyEbbbWptq1MekFtehkvP/JiN/vbz7PQr16cpDYP4Sqs+h5Xn1SLGjsjLyx7gWnCtpeuClo4D2s/Qdig2QmXXR4S690L5SLsWau0rRmC23MeEzkP391OPuEZioF6HZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 028D5150C;
	Mon, 29 Sep 2025 02:55:22 -0700 (PDT)
Received: from [10.163.32.148] (unknown [10.163.32.148])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 920603F66E;
	Mon, 29 Sep 2025 02:55:26 -0700 (PDT)
Message-ID: <738db21f-5026-4bcb-a102-969c4379c015@arm.com>
Date: Mon, 29 Sep 2025 15:25:23 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: hugetlb: avoid soft lockup when mprotect with
 PROT_MTE
To: Yang Shi <yang@os.amperecomputing.com>, muchun.song@linux.dev,
 osalvador@suse.de, david@redhat.com, akpm@linux-foundation.org,
 catalin.marinas@arm.com, will@kernel.org, carl@os.amperecomputing.com,
 cl@gentwo.org
Cc: linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250926162034.1785899-1-yang@os.amperecomputing.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20250926162034.1785899-1-yang@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 26/09/25 9:50 PM, Yang Shi wrote:
> When calling mprotect() with PROT_MTE, kernel will initialize MTE tags
> for every single page in the affected area. Soft lockup was observed
> when doing this for large HugeTLB memory area in our customer's workload
> (~300GB memory):
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
>   mte_clear_page_tags+0x14/0x24
>   set_huge_pte_at+0x25c/0x280
>   hugetlb_change_protection+0x220/0x430
>   change_protection+0x5c/0x8c
>   mprotect_fixup+0x10c/0x294
>   do_mprotect_pkey.constprop.0+0x2e0/0x3d4
>   __arm64_sys_mprotect+0x24/0x44
>   invoke_syscall+0x50/0x160
>   el0_svc_common+0x48/0x144
>   do_el0_svc+0x30/0xe0
>   el0_svc+0x30/0xf0
>   el0t_64_sync_handler+0xc4/0x148
>   el0t_64_sync+0x1a4/0x1a8
> 
> Soft lockup is not triggered with THP or base page because there is
> cond_resched() called for each PMD size.
> 
> So add cond_resched() for hugetlb to avoid soft lockup.
> 
> Fixes: 25c17c4b55de ("hugetlb: arm64: add mte support")
> Tested-by: Carl Worth <carl@os.amperecomputing.com>
> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
> ---
>  mm/hugetlb.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index cb5c4e79e0b8..fe6606d91b31 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -7242,6 +7242,8 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
>  						psize);
>  		}
>  		spin_unlock(ptl);
> +
> +		cond_resched();
>  	}
>  	/*
>  	 * Must flush TLB before releasing i_mmap_rwsem: x86's huge_pmd_unshare

LGTM

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

