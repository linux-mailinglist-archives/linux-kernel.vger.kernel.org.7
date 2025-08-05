Return-Path: <linux-kernel+bounces-756259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E37CEB1B1FC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 12:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85F5218A0ADC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 10:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DE926E700;
	Tue,  5 Aug 2025 10:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="jza+E7+9"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A6A26C3A0
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 10:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754389613; cv=none; b=PNmZ/1mWSRGvbLsWwjbDUWHyClAVvKZ12ZwuAZ46xvg6vWYak6ybrUfpOWbqe1yuT3MVnuzKz1zH35xOwrLxi/HauUocBNpkLD3Nw6K2f1MyJVJiMgY9HNQeXEKIPzDDAivwNj4MP1e6gINpF8Mivbb4fQhEbiXtTzYh7ZrvM7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754389613; c=relaxed/simple;
	bh=LjFT9y5I+hjv3eqAddjy3g0pQrXjHiwpVJug9QXa7nI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UHS7NFY3zv+6UcCPVl4LF6tbfO3ceNMbrE7iTtmju8FdelTaBE3SMlbr9+hop9K8yzJW0Mqd7ngjCS4ZGgddQl6w/S1EtGJQ06Bc5ni2ttzWQZqCuj19McyNVjMGhxuK6TWs0xk9XeYIwPdyDtqTREyncG+R2ho1WzIsBmYDCYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=jza+E7+9; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2403ceef461so34652835ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 03:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1754389610; x=1754994410; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sDMXNgbn2CAVAwPiNUASjz9nyl/F4Fuacri7IGY04Qc=;
        b=jza+E7+9gpMyiNDB1lXXpn6C7ycG7PlYE31pm2ol6tCRZQrQqNKzUh5Tmx7OIOMvC5
         t1uVaHFKHlEaG0ONQVtDqi9D8eVjbf4GJE0VidcU+N9Qc2/9gw89uhyy3UPBN4QiPwm0
         k57HjF+FjXt3kytjQiesmaMRUTPJQUwOj/zfa775U/DPZf6HDekkw7nauYRkInNRynzn
         XdXpCYA0Rr2s9oH4UZ79HrPVYY5IBde8bdfxDXZwgbMDuTHwooEunZivTEc9JbIU5Sx0
         DRM0nnmrvNcf2Csk80YKuBt5z5s6/1TGz3vJUDYEZGqF+7U7l88YSuMUvY+HXFM2dAOL
         lRIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754389610; x=1754994410;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sDMXNgbn2CAVAwPiNUASjz9nyl/F4Fuacri7IGY04Qc=;
        b=O67xi6HoWobD3nsBEKM3o8SVXa/+gyNATh2s1JwgON/VhjI3733qau8fE/0EFvSC8w
         ziqJo4A4aG80hfug6vbERimAattB62Tnozz6AA24sgGxdMIdaGCFUUaFPYjqj1uowwmN
         OB2r4TPHjIckAetNUiuxbasbEDrVys6Ohrh+PmK8j73P+TrNt+wjLslL6bWK3JjJ/el1
         Aii3ZYqxRASKT+J/00rsrwut64GqVdANFvXO6tGjy+E+sqOhe3AU/ZHZw3Mz+9Wsm1e1
         iQ7Jrbvo5kMjf9PX58t2UVlnDqXEt1yAYCrNu8TI9WyatRASz/jFyf+JXwJwFI+KwnTy
         /FCg==
X-Gm-Message-State: AOJu0YxR717LTdW7R7Qf56IBMpW6BdTdyri4VdtmUVrZUPCofOjpkRF/
	qDokUFkNvB841Sv+uxELtly6wqv42YCSMzuvLqVnOl4nUblvnynocMS4XaedVO8HNog=
X-Gm-Gg: ASbGncvwAz5IDYzjiRUUXsSGsyIZTiv8u322ArHXrJGKng/K5ibgiVSDOfaQcKT+GFn
	etHZHlD6g6FOecZQQbFzmiqYipjf//ASacZp1mDl4QU0Yu3MG8au3reN2S9TNX7aP3TgW2EodcG
	rgaXQEqH6iHABAlbtut+C1dXFwoiiGuHrXu10FJozS4aAvHjWhwRO8hxqOKCy7LZfn47JwKONSp
	RYe/3qqtrT5vR7cR/S2wQXUwlTAj3/Ok9QUUJ/d3skGkM4W8wgBg47TsM1g0U/MO10o6a3Az9Lx
	8XmCIwGkZuark0CLBha1SeCsU/S9HM14z4jcvT6R59nmWxu1HDNkTOXBsR6HYy13wpngqT01ZkO
	22TP7pwePHxMmc09ehPRlkuzsokz3zARTkl0buvOb3hQ2
X-Google-Smtp-Source: AGHT+IETnZQFipLlvzA1gXFWt9A88wLEwXr/LrqzR0JMFbgEn9V8WGBPOWwHU3svG4LLBT1wi4QAYQ==
X-Received: by 2002:a17:902:e74d:b0:240:3d07:9ea4 with SMTP id d9443c01a7336-24246f2d5aemr148163345ad.7.1754389610564;
        Tue, 05 Aug 2025 03:26:50 -0700 (PDT)
Received: from [10.4.54.91] ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e89a6ec2sm129225305ad.145.2025.08.05.03.26.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 03:26:50 -0700 (PDT)
Message-ID: <a12e9a51-0ee4-4a10-9ec4-d4c0d34ccff9@bytedance.com>
Date: Tue, 5 Aug 2025 18:26:41 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Fix the race between collapse and PT_RECLAIM under
 per-vma lock
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
 David Hildenbrand <david@redhat.com>, Barry Song <21cnbao@gmail.com>,
 akpm@linux-foundation.org, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>,
 "Lai, Yi" <yi1.lai@linux.intel.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Suren Baghdasaryan <surenb@google.com>, Lokesh Gidra
 <lokeshgidra@google.com>, Tangquan Zheng <zhengtangquan@oppo.com>,
 Lance Yang <ioworker0@gmail.com>, Zi Yan <ziy@nvidia.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache
 <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>
References: <20250805035447.7958-1-21cnbao@gmail.com>
 <35417160-86bf-4580-8ae9-5cadd4f6401d@bytedance.com>
 <d73213ba-5ca0-451c-b82b-f590d10da6d7@linux.alibaba.com>
 <b594a315-8458-439c-b535-fc7f052a3fae@bytedance.com>
 <c6f9dacf-d520-4cc3-88ac-c5937916aa2c@linux.alibaba.com>
 <064cca31-442d-4847-b353-26dc5fd0603c@bytedance.com>
 <5ac2ec58-3908-4d0e-a29b-8b4d776410e3@redhat.com>
 <46f0b251-237c-421d-aec0-adff6c2e1bb4@linux.alibaba.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <46f0b251-237c-421d-aec0-adff6c2e1bb4@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/5/25 6:07 PM, Baolin Wang wrote:
> 
> 

[...]

> 
>>>
>>> What types of this 'valid page' could be? If __pte_offset_map() returns
>>> non-NULL, then it is a PTE page. Even if it is not the original one, it
>>> should not cause panic. Did I miss some key information? :(
> 
> Sorry for not being clear. Let me try again.
> 
> In the race condition described above, the '_pmd' value is NONE, meaning 
> that when restoring the pmd entry with ‘pmd_populate(mm, pmd, 
> pmd_pgtable(_pmd))’, the 'pmd_pgtable(_pmd)' can return a struct page 
> corresponding to pfn == 0 (cause the '_pmd' is NONE) to populate the pmd 
> entry. Clearly, this pfn == 0 page is not a pagetable page, meaning the 
> corresponding ptl lock of this page is not initialized.
> 
> Additionally, from the boot dmesg, I can see that the BIOS reports an 
> address range with pfn == 0, indicating that there is a struct page 
> initialized for pfn == 0 (possibly a reserved page):
> 
> [    0.000000] BIOS-provided physical RAM map:
> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] 
> usable
> [    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] 
> reserved
> [    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] 
> reserved
> [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000007ffdffff] 
> usable
> [    0.000000] BIOS-e820: [mem 0x000000007ffe0000-0x000000007fffffff] 
> reserved
> [    0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] 
> reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] 
> reserved
> 

Now I understand, thank you very much for your patient explanation!

And for this patch:

Acked-by: Qi Zheng <zhengqi.arch@bytedance.com>

Thanks!

> Of course, this is my theoretical analysis from the code perspective. If 
> there are other race conditions, I would be very surprised:)
> 
>> Wasn't the original issue all about a NULL-pointer de-reference while 
>> *locking*?
> 
> Yes.
> 
>> Note that in that kernel config [1] we have CONFIG_DEBUG_SPINLOCK=y, 
>> so likely we will have ALLOC_SPLIT_PTLOCKS set.
>>
>> [1] https://github.com/laifryiee/syzkaller_logs/blob/ 
>> main/250803_193026___pte_offset_map_lock/.config
>>


