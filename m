Return-Path: <linux-kernel+bounces-813371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD69B54449
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 09:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F6C91744FB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 07:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0762D3A91;
	Fri, 12 Sep 2025 07:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R5D4SIt/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272D32BD031
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 07:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757663857; cv=none; b=eU8Qs4Lawfn/8IPTCu0FpG0n31kl3WJkLcDzS+rfru0Y6VmVcHnvrVP8pV06GHqyZ3gnFYgVhv5uvO/+XOpdAEryii3wDqd9v96qbP2egCaw1BlvkKXPM/n7UzFPcffZu1wIz+pvnzLB2kLP5qAPuNvRzh35gNAW06a+ELQLd58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757663857; c=relaxed/simple;
	bh=5u0szFnsmz3jOdzApEVIbycNY2Ant7XU0MZjL/xAevo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oxe5xljyieJF0tlozEzroddUK6c+yyKRz4Xuozbg/h5+cQ2BXNZFuqxs1CYZX19T7A1JLphVJ4Y6+MAWvhAwVVydC5jLBqAU7cJW+fuaKivhDhaEwAMlTMnIVD5TddzxwVzZKxpnEJLW9phrusEkUR88qsR9IwpqiMhLZtb9kww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R5D4SIt/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757663855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=r+PqVYBDLbo+GI2XNIjczAPm5r0PaP1XGtlnWHDNHZk=;
	b=R5D4SIt/TVrDJrVgn4sszB6rXz1ukooUcmKbF80fyMB9qrTXl38QB3+fY516zg/UQQOO2S
	VCkQMbsj09WrefBzm4AJCtrb1ojuwiPatemhcMOBytzXel43j7eF+FUliDCoB7AXLzg5K6
	RvT4+5MALolxkWoujQp3czd9zI2tKaY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-z6Mt3E-JOSCluBWO54mR2g-1; Fri, 12 Sep 2025 03:57:31 -0400
X-MC-Unique: z6Mt3E-JOSCluBWO54mR2g-1
X-Mimecast-MFC-AGG-ID: z6Mt3E-JOSCluBWO54mR2g_1757663851
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3e40057d90aso590764f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 00:57:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757663850; x=1758268650;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r+PqVYBDLbo+GI2XNIjczAPm5r0PaP1XGtlnWHDNHZk=;
        b=Iyw3IYDaT0mUmisPGkg6Shs9Op5Cw7BxlLNSChiYN9DGUe7XFZ1uloRCrTnQ870HWG
         30kIqY5AkhDpf6Q7OF8/YvAzxJWV/u6NmX7nCczyX6EIy29gd5oEdRvK3Qwe4gmaupfv
         RvMw5ojRL6q0J05Lbl6nb9kyrUy3OxVypjcWdvNCTOd7hwEmHc3TFGERkIXSUPRD4Ung
         dRURninfLoM2+YmRcXc+88VYCOE1UuaDKycFlf1XnMhFCcxz8RU8zUcZJ7tsW/P4ws+N
         xFLQJdPeWwHXGD5BJj2/Y0LPGzXkIrj6LmzatcKh37J93Dnp5PcH1Q1Q2b6QQxTl+8VY
         R4DA==
X-Forwarded-Encrypted: i=1; AJvYcCX06jY5ZoWzRB+N+Ssn87ZSK5FW/bz5yDLeflUJb/TaQlleUm3ApaMWSrg9MaDRFfKlCrN6VmkOchUHGts=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9CNSP6AW8//LxxjPWt+fsw4db9L4hq6Hygf2qcYGdgqD2xOBX
	7ZNMG/KIM19fJdTovn39UytXSrnGHKU4ohT/Kfk9PyJzYx3v7BV4iSwORfmoC9wcj0eN+PK9BdK
	HlVSWG80KRc98vUtTEeoAROC/MqxGoISWzMrx04QjAuPtRzKJ5eyM58m/YwdoTXqiLg==
X-Gm-Gg: ASbGnctGnQIOfWbW5mzz/cDtV6sm1pocYZVgN/0Lq9QZbQZTfnrICjn9qtLDQwijjCk
	r7kUw6hDohR4i70syqGq+xQA1FCPSMGK5CYyU9V3XsrkVI9pvIvKarC9sj9DiykRX3L5eTOGvQT
	IWHWfcdGJXZiQoZ+ZlShz7rP0tsLfGJ2xjEPU8m0ruWE79fL0kq7v5x2+59Nmch1Vf6ifjVPagq
	sejzFurLOr7NpA6DvOVT7q4PG1AONbum+bb7v8Fti4G3gYRYPbCFrhjB7T8WOLb8P78Q/wFFrCV
	nhMhFhviOlfKE5aVI/5kbujiZL7DN/dP0GSWIDgb40URMV8iMJU5/bgpphligVSFS61IdMuIf5B
	7n6lX+3RCLa+jAhDewUl300Xt18V0tbpYqlarq7Fm64mESgvf2Rc0SrU4ftgNpzlgWa0=
X-Received: by 2002:a05:6000:1acb:b0:3e5:d2f1:403d with SMTP id ffacd0b85a97d-3e7659e981fmr1992703f8f.36.1757663850568;
        Fri, 12 Sep 2025 00:57:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5jTihNZ8u71EpurEXi9WIL859gU0373T54vnlvHENg3fNIgXreHhMHhAU/LbYZT2vWSOlPw==
X-Received: by 2002:a05:6000:1acb:b0:3e5:d2f1:403d with SMTP id ffacd0b85a97d-3e7659e981fmr1992669f8f.36.1757663850093;
        Fri, 12 Sep 2025 00:57:30 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f20:da00:b70a:d502:3b51:1f2d? (p200300d82f20da00b70ad5023b511f2d.dip0.t-ipconnect.de. [2003:d8:2f20:da00:b70a:d502:3b51:1f2d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607e1400sm5516947f8f.55.2025.09.12.00.57.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 00:57:29 -0700 (PDT)
Message-ID: <e326949b-5d8f-4a35-8116-015e784df421@redhat.com>
Date: Fri, 12 Sep 2025 09:57:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: boot failure because of inaccurate page_pool_page_is_pp() on
 32-bit kernels
To: Helge Deller <deller@kernel.org>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vu?=
 =?UTF-8?Q?sen?= <toke@redhat.com>,
 Linux Kernel Development <linux-kernel@vger.kernel.org>,
 Linux Memory Management List <linux-mm@kvack.org>,
 linux-parisc <linux-parisc@vger.kernel.org>
Cc: Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>,
 Helge Deller <deller@gmx.de>, Byungchul Park <byungchul@sk.com>
References: <5a004aef-9df1-4126-b167-1aae27d4240d@gmx.de>
 <1756327287@msgid.manchmal.in-ulm.de> <aMNJMFa5fDalFmtn@p100>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <aMNJMFa5fDalFmtn@p100>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12.09.25 00:12, Helge Deller wrote:
> As reported earlier in this mail thread, all 32-bit Linux kernels since v6.16
> fail to boot on the parisc architecture like this:
> 
>   BUG: Bad page state in process swapper  pfn:000f7
>   page: refcount:0 mapcount:0 mapping:00000000 index:0x0 pfn:0xf7
>   flags: 0x0(zone=0)
>   raw: 00000000 118022c0 118022c0 00000000 00000000 00000000 ffffffff 00000000
>   raw: 00000000
>   page dumped because: page_pool leak
>   Modules linked in:
>   CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.15.0-rc1-32bit+ #2730 NONE
>   Hardware name: 9000/778/B160L
>   Backtrace:
>    [<106ece88>] bad_page+0x14c/0x17c
>    [<10406c50>] free_page_is_bad.part.0+0xd4/0xec
>    [<106ed180>] free_page_is_bad+0x80/0x88
>    [<106ef05c>] __free_pages_ok+0x374/0x508
>    [<1011d34c>] __free_pages_core+0x1f0/0x218
>    [<1011a2f0>] memblock_free_pages+0x68/0x94
>    [<10120324>] memblock_free_all+0x26c/0x310
>    [<1011a4d8>] mm_core_init+0x18c/0x208
>    [<10100e88>] start_kernel+0x4ec/0x7a0
>    [<101054d0>] start_parisc+0xb4/0xc4
> 
> git bisecting leads to this patch which triggers the crash:
> 
>   commit ee62ce7a1d909ccba0399680a03c2dee83bcae95
>   Author: Toke Høiland-Jørgensen <toke@redhat.com>
>   Date:   Wed Apr 9 12:41:37 2025 +0200
>      page_pool: Track DMA-mapped pages and unmap them when destroying the pool
> 
> It turns out that the patch itself isn't wrong.
> 
> But it's the culprit which leads to the kernel bug since it modifies
> PP_MAGIC_MASK for 32-bit kernels from:
> 
> -#define PP_MAGIC_MASK ~0x3UL
> +#define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
> 
> Function page_pool_page_is_pp() needs to unambiguously identify page pool
> pages (using PP_MAGIC_MASK), but since the patch now reduced the valid bits to
> check in PP_MAGIC_MASK from 0xFFFFFFFC to 0xc000007c, the remaining bits are
> not sufficient to unambiguously identify such pages any longer.
> 
> Because of that, page_pool_page_is_pp() sometimes wrongly reports pages as
> page pool pages and as such triggers the kernel BUG as it believes it found a
> page pool leak.
> 
> IMHO this is a generic 32-bit kernel issue, not just affecting parisc.
> 
> Do you see any options other than:
> a) revert the patch (ee62ce7a1d90), or:
> b) return false in page_pool_page_is_pp() when !defined(CONFIG_64BIT),
>     which means to effectively disable the page pool page test on 32bit
>     machines

We should have a change coming soon that would use a page type and fix 
it as well I think.

https://lkml.kernel.org/r/20250728052742.81294-1-byungchul@sk.com

Until then, the easiest fix would be indeed to go with b).

But maybe the page type thing could be backported?

-- 
Cheers

David / dhildenb


