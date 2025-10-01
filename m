Return-Path: <linux-kernel+bounces-838589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7C4BAFA5D
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 10:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A1117AE54C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 08:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC811266B6F;
	Wed,  1 Oct 2025 08:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gUnUx0rz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1221E22D9ED
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 08:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759307531; cv=none; b=pqKq9Rtz3Z8HNfFEPDy1f8nWZ0Lac/e+tuejW7Ctca6ZSVpbgah8N5wwCpJEcWdzgWtv+AdZzfRn3aHINjkNtg7eOemlIAfg5unqSqKxRUaMr7Oe9k8FCpWqoL4GV9+XrDl8Hqd1wAYI71h/RnoE0O6BKC2QMmAgEIMjQP712Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759307531; c=relaxed/simple;
	bh=CBNxLOECK1gpffXV9ftOvIK72frBSaZD91HCChhmsMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YR9oUo9k1zaIiMOB3WaFaQw6SVJbBAwPIrP0WEdksqqb7bCupYiI3dBQqbHqrQUpmubrjTrnSvHu4I4su+n2IEb736IwS0GJq57cfPLLozdLB8vyk0RNxWVU5YFwbnO8Sn4Z0ejAYGoflA2GgPY6n5HGhEJqbWUVWL/FKGd8I3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gUnUx0rz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759307528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=x3+EPaDu3mTLXOJJXfkxKlMbmHF7t6CqJIFRWvGx0uE=;
	b=gUnUx0rzTqbAaetUWsuaCoCBT1AyeciHpuX88ZF+ZBFw6SUFVTeU8nzSAAxhOqgE7gjkGD
	GT6goAHzQiMGB9YBBjUqvC3FyswanNs16rd39YMp7g6IulSHs+/Ad1EBRhMoBMe4Xf/Ruj
	MSMitYzCGxrUivPILJHwElJ3sYXhVIE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-MXM4N1GPPmqsyFNb8Cx4zA-1; Wed, 01 Oct 2025 04:32:07 -0400
X-MC-Unique: MXM4N1GPPmqsyFNb8Cx4zA-1
X-Mimecast-MFC-AGG-ID: MXM4N1GPPmqsyFNb8Cx4zA_1759307526
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3ece0cb7c9cso5650812f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 01:32:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759307526; x=1759912326;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x3+EPaDu3mTLXOJJXfkxKlMbmHF7t6CqJIFRWvGx0uE=;
        b=bLuBxuXLv8BIKTcfpMzRAPTABFjip2U0tIofHqg9QTM27YinRADn3eJdCkv2VE9moe
         5L13WEA4RoZDbdBmqPnOghwUez/bjZ1RpSWQ8HIA8dykiHT25loPYOBTDHKXOXn20Fym
         zMFDiShUCjupkdbtUGEMrcunEMuqPjtkkLgDBIsPlO35aHVg/P9jyTeWJiXPPHmFEnai
         gY1iRAgdQfpEOoEIgjb5I79yKvikPTs0KMitbovgyq/TpzG1r9vH5KQRER3XEojkS/6p
         C3YPMzn9R3XM2f7AU9r+E3rlDeRddj5plNpYHhdLwR2eFQ8CKIX34Z05aFWJckXIzhf5
         yEXA==
X-Forwarded-Encrypted: i=1; AJvYcCWzlWSPyk4JrrV21hgBAV+HoXxTXgsUjQnG9RN91SZ8SUVPLA+6Z5NmJFMZ2k2YVPm9rwzu0dzMmJ76Dh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT756XWdZWJQGxDh1B1y5Q6PqIF7LowFDa2SRJ8SP1vXk92ITZ
	XuQU4d5/FI01IpkDqV1VFs2B7miW/CXgssLkV1NnVTwCWyBcOK5HbhaVAoC2fjScsZiKQpSsefk
	lmCeP+0asUumf0aN4oyyK05MwhMmL5+aJexfY1b5t/WMFju6NdHuBuyzBpKFZaVJ9/A==
X-Gm-Gg: ASbGncudaSBpCOk19BNt/83RgEMSkVZOZ1jPt8Dbz0J6+YfUwyfVBJNeRyL0TmpD+39
	rY6bMhaWl2kcDQlFkZAWdw63xuwfhSp8FEfZ4yH9QrzheX1ofAs5+Ocaft4WzGJa8X2f1jTKUfn
	rLBXbdyAvAFQr5sBbrfPa8ESS3xmC0cZW0DiYLCm8wavSsD5MzI0sQovukGsgyZIMjZMeI+Wru4
	aL9qKjv7bhgpgdJXVvMwdgv/YYpUZm1M3xe2D2j7DNt+8xmwJXeIgolGeJrWrmR7YHiLU3JSmLL
	NplN2vruCS9midwFFPUWqkOce9+p6UBcsXmyJUNCknc16n967UicTCbGVfeHn60bsPotUPFPUaG
	QPVs98B8e
X-Received: by 2002:a5d:5f53:0:b0:3e8:b4cb:c3dc with SMTP id ffacd0b85a97d-425577ee13dmr2185335f8f.3.1759307525623;
        Wed, 01 Oct 2025 01:32:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEamlFHKk0lW4qrWPYCPK/rhtvhoE8+VAFZFxpeTixsTjPGZGBvNgnUReYlehmrWW+5PQy6XQ==
X-Received: by 2002:a5d:5f53:0:b0:3e8:b4cb:c3dc with SMTP id ffacd0b85a97d-425577ee13dmr2185305f8f.3.1759307525126;
        Wed, 01 Oct 2025 01:32:05 -0700 (PDT)
Received: from [192.168.3.141] (tmo-080-144.customers.d1-online.com. [80.187.80.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc5602dc2sm25902920f8f.32.2025.10.01.01.32.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 01:32:04 -0700 (PDT)
Message-ID: <819891f6-4e30-470c-b641-350a14b395a2@redhat.com>
Date: Wed, 1 Oct 2025 10:32:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 PATCH] mm: hugetlb: avoid soft lockup when mprotect to large
 memory area
To: Dev Jain <dev.jain@arm.com>, Yang Shi <yang@os.amperecomputing.com>,
 muchun.song@linux.dev, osalvador@suse.de, akpm@linux-foundation.org,
 catalin.marinas@arm.com, will@kernel.org, anshuman.khandual@arm.com,
 carl@os.amperecomputing.com, cl@gentwo.org
Cc: linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250929202402.1663290-1-yang@os.amperecomputing.com>
 <cc40d827-3b98-4e15-ad45-5c2033e4ce20@arm.com>
 <6cde8290-3aa2-411c-bf29-eb91a99e33a5@os.amperecomputing.com>
 <746c4dd3-2285-4353-9e15-a0a2fbd4e6b5@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <746c4dd3-2285-4353-9e15-a0a2fbd4e6b5@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 01.10.25 06:23, Dev Jain wrote:
> 
> On 30/09/25 11:38 pm, Yang Shi wrote:
>>
>>
>> On 9/29/25 10:26 PM, Dev Jain wrote:
>>>
>>> On 30/09/25 1:54 am, Yang Shi wrote:
>>>> When calling mprotect() to a large hugetlb memory area in our
>>>> customer's
>>>> workload (~300GB hugetlb memory), soft lockup was observed:
>>>>
>>>> watchdog: BUG: soft lockup - CPU#98 stuck for 23s! [t2_new_sysv:126916]
>>>>
>>>> CPU: 98 PID: 126916 Comm: t2_new_sysv Kdump: loaded Not tainted
>>>> 6.17-rc7
>>>> Hardware name: GIGACOMPUTING R2A3-T40-AAV1/Jefferson CIO, BIOS
>>>> 5.4.4.1 07/15/2025
>>>> pstate: 20400009 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>>> pc : mte_clear_page_tags+0x14/0x24
>>>> lr : mte_sync_tags+0x1c0/0x240
>>>> sp : ffff80003150bb80
>>>> x29: ffff80003150bb80 x28: ffff00739e9705a8 x27: 0000ffd2d6a00000
>>>> x26: 0000ff8e4bc00000 x25: 00e80046cde00f45 x24: 0000000000022458
>>>> x23: 0000000000000000 x22: 0000000000000004 x21: 000000011b380000
>>>> x20: ffff000000000000 x19: 000000011b379f40 x18: 0000000000000000
>>>> x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
>>>> x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
>>>> x11: 0000000000000000 x10: 0000000000000000 x9 : ffffc875e0aa5e2c
>>>> x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000000
>>>> x5 : fffffc01ce7a5c00 x4 : 00000000046cde00 x3 : fffffc0000000000
>>>> x2 : 0000000000000004 x1 : 0000000000000040 x0 : ffff0046cde7c000
>>>>
>>>> Call trace:
>>>>     mte_clear_page_tags+0x14/0x24
>>>>     set_huge_pte_at+0x25c/0x280
>>>>     hugetlb_change_protection+0x220/0x430
>>>>     change_protection+0x5c/0x8c
>>>>     mprotect_fixup+0x10c/0x294
>>>>     do_mprotect_pkey.constprop.0+0x2e0/0x3d4
>>>>     __arm64_sys_mprotect+0x24/0x44
>>>>     invoke_syscall+0x50/0x160
>>>>     el0_svc_common+0x48/0x144
>>>>     do_el0_svc+0x30/0xe0
>>>>     el0_svc+0x30/0xf0
>>>>     el0t_64_sync_handler+0xc4/0x148
>>>>     el0t_64_sync+0x1a4/0x1a8
>>>>
>>>> Soft lockup is not triggered with THP or base page because there is
>>>> cond_resched() called for each PMD size.
>>>>
>>>> Although the soft lockup was triggered by MTE, it should be not MTE
>>>> specific. The other processing which takes long time in the loop may
>>>> trigger soft lockup too.
>>>>
>>>> So add cond_resched() for hugetlb to avoid soft lockup.
>>>>
>>>> Fixes: 8f860591ffb2 ("[PATCH] Enable mprotect on huge pages")
>>>> Tested-by: Carl Worth <carl@os.amperecomputing.com>
>>>> Reviewed-by: Christoph Lameter (Ampere) <cl@gentwo.org>
>>>> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
>>>> Acked-by: David Hildenbrand <david@redhat.com>
>>>> Acked-by: Oscar Salvador <osalvador@suse.de>
>>>> Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>>> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
>>>> ---
>>>> v2: - Made the subject and commit message less MTE specific and fixed
>>>>         the fixes tag.
>>>>       - Collected all R-bs and A-bs.
>>>>
>>>>    mm/hugetlb.c | 2 ++
>>>>    1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>>> index cb5c4e79e0b8..fe6606d91b31 100644
>>>> --- a/mm/hugetlb.c
>>>> +++ b/mm/hugetlb.c
>>>> @@ -7242,6 +7242,8 @@ long hugetlb_change_protection(struct
>>>> vm_area_struct *vma,
>>>>                            psize);
>>>>            }
>>>>            spin_unlock(ptl);
>>>> +
>>>> +        cond_resched();
>>>>        }
>>>>        /*
>>>>         * Must flush TLB before releasing i_mmap_rwsem: x86's
>>>> huge_pmd_unshare
>>>
>>> Reviewed-by: Dev Jain <dev.jain@arm.com>
>>
>> Thank you.
>>
>>>
>>> Does it make sense to also do cond_resched() in the
>>> huge_pmd_unshare() branch?
>>> That also amounts to clearing a page. And I can see for example,
>>> zap_huge_pmd()
>>> and change_huge_pmd() consume a cond_resched().
>>
>> Thanks for raising this. I did think about it. But I didn't convince
>> myself because shared pmd should be not that common IMHO (If I'm
>> wrong, please feel free to correct me). At least PMD can't be shared
>> if the memory is tagged IIRC. So I'd like to keep the patch minimal
>> for now and defer adding cond_resched() until it is hit by some real
>> life workload.
> 
> If we have large swathes of hugetlb memory like in your workload, and it
> is MAP_SHARED, then there should be high chances of sharing the PMD.
> Although, I incorrectly
> 
> observed that we are clearing a page there - we are only clearing the
> pud entry which is 8 bytes. So yes a soft lockup should be highly
> unlikely. But since cond_resched()
> 
> is cheap (I assume this is the case since it is liberally sprinkled all
> over the codebase) I think we should be consistent. Probably not an
> immediate concern and not a matter

Right, that's one of the cases where we might just want to wait either 
until is is reported or until hugetlb is finally removed in a couple of 
decades ;)

-- 
Cheers

David / dhildenb


