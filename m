Return-Path: <linux-kernel+bounces-843004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C16D3BBE2D4
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 15:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 474B04E3C1E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 13:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299312C3258;
	Mon,  6 Oct 2025 13:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PqQ4jB3B"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E173298991
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 13:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759757171; cv=none; b=OmPJeUuKhvl9bPZ7XumQz5HaNMNp3OCzyO2sdVj5InmwCbwh6Al9w73K29hBYPjLizEL6vW5TeFhSlJ6SRXwar1DX6colNiLC8UKm4rAPc9fEcZVh2o+xAn84U/SbVtK/fuGF/wCG7hlCdSaOxrFnb+fId2kBGq3xBzC80+a0Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759757171; c=relaxed/simple;
	bh=UPEIO1q9s3v6EiLHhnEtvwRzF+JBuGEFKcg/DjYi36o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IBgQsiRU0TJ7o8+yQofK9g1zaT9jiohtd9i90emW7r+wSS437mUB05OkbivjDZ9Uo1NyF5ktmsb5S0c86Oj/9lAOMaqlaInnlEOupVYQekNeNDw4f4C7JGq3zNE0cpGwtcA7HIR56vsyMjK33irTChlFKutNfTyeGYdq2WRVgQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PqQ4jB3B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759757165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iwrArVYN6Hgp4+ZQLHEDAJ1uYbH7JoKb4sYghjkBJlo=;
	b=PqQ4jB3BNvxUuzxiVTG4e+fhAFhS8jpMM4kIVKjznDbnEQqGo15C2XRDmtr5BATj4sDnJq
	Dk+wVTEteDNqXBuoRnxqtjNAY3tS5vz5dYTIwQ+rpR1fT8PUFWlavk9NEN0RdCwk/JL+Co
	Y7s4CZqYohVm+qQ32n4iRWc9jLwXJBk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-l2-_x238ObCPRougIfIl2A-1; Mon, 06 Oct 2025 09:26:02 -0400
X-MC-Unique: l2-_x238ObCPRougIfIl2A-1
X-Mimecast-MFC-AGG-ID: l2-_x238ObCPRougIfIl2A_1759757161
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46e35baddc1so26339275e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 06:26:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759757161; x=1760361961;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iwrArVYN6Hgp4+ZQLHEDAJ1uYbH7JoKb4sYghjkBJlo=;
        b=C83NCXBiA1Vw1UcV6Mt9RJzI0au7rC+DCp/BhgCFf0fmgQ7B94ibUjd2O6KSCLs35Y
         emSloaDxqM9IZlcvOte6nwd49zNBdS4MiL+xNLoBJQDQOhorkS5n4Xs+jqP1LZdrzeun
         ksZFvpoORn/DS7SglmQ1vzhrUjtr7g3ZqYHtltNNqL/icICRUBWFdz1hTSYqiR4xHn+V
         QJQ/2nz88Oo5qjLiPtDFB6xesKNUbYyTCb9XE18Y6ec1dvGfkxe1s9xKe5m8ZjsQL35G
         m0wsjrg2lQpSjUQh3rEounqBoISdCV7erijDRqMVEPDI1YSGiHidIphr1QMDtZmbfUsP
         hCrQ==
X-Forwarded-Encrypted: i=1; AJvYcCV71vIDcumiu0j4dd6cvX5jsV51B9iS/t0C2i4b19uJXF/PO+jfyV7feGXl6mfZiy5iDab79p+PX+hhsNw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsH0SJstxPBiFRUmxs8rzEVrsNF32DgL+ujer90dqW0k7PWIsY
	hmffn96d/SPELEgVoAorxBJcggDGIsQsV22r0powRPPl3t9wLxSldU8VKNLAZZB/4wI5EFRNj/Q
	MUOm/eGpfbB/R51mfwjWGspuJBfmFMecSTR0uWveLfHgnAjsL5dqeGfwsFJCXt4lc3g==
X-Gm-Gg: ASbGncvHR3DQuWN29ieU8PSQJY+HWf7PP8RHy71bS7BSW8PyWETwiZkwkejyxUBL8EX
	u/N4PQKAN37kgjxE9lnGbWvMGrtMjtDFDWqsYKWD21jXdJew2sEy3wk0IKm1yzXopYBct+IgR9l
	95OC7VCG1UjHW2wu3Wvb1SG0ey+xg0MU5+mG38R/M+WGG4oU8rnqaw1i9WxngaywRMaKp4wtKwt
	T63T2n+8jIy+0CeaursNnErTmLeTEilnroxECJOnw1cRWQ9ompSGfVHPxuB218ep4tyHo7RQ0d/
	N4FhQ33mxvtOqeYReefT0klwjIVlR6A/LkrlIxzAYRAkqlhmcAfzlyn2kHEJrUtesQ4yoRRp9bx
	XUaxryNdH
X-Received: by 2002:a05:600c:3149:b0:46e:33b2:c8da with SMTP id 5b1f17b1804b1-46e7114829cmr73081735e9.32.1759757161015;
        Mon, 06 Oct 2025 06:26:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEB001Cs9Kie3XUKMPuCcgnWS4oQSNxtEp884mpAdG/6G6PtAWiaGPAxipwUeejHIFC7ewNJg==
X-Received: by 2002:a05:600c:3149:b0:46e:33b2:c8da with SMTP id 5b1f17b1804b1-46e7114829cmr73081485e9.32.1759757160599;
        Mon, 06 Oct 2025 06:26:00 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-110.customers.d1-online.com. [80.187.83.110])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e723431f5sm156675695e9.2.2025.10.06.06.25.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 06:26:00 -0700 (PDT)
Message-ID: <1d5df7c9-8eec-49ad-b4c7-39c70bd172d7@redhat.com>
Date: Mon, 6 Oct 2025 15:25:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [arm?] WARNING in copy_highpage
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: syzbot <syzbot+d1974fc28545a3e6218b@syzkaller.appspotmail.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, will@kernel.org,
 Kefeng Wang <wangkefeng.wang@huawei.com>
References: <68dda1ae.a00a0220.102ee.0065.GAE@google.com>
 <aOACSWYIOD3llWnj@arm.com> <7af02ceb-563a-4bad-84ee-620aaa513bed@redhat.com>
 <aOPBdNLJUdN4EAF0@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <aOPBdNLJUdN4EAF0@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.10.25 15:17, Catalin Marinas wrote:
> On Mon, Oct 06, 2025 at 09:55:27AM +0200, David Hildenbrand wrote:
>>>> Modules linked in:
>>>> CPU: 1 UID: 0 PID: 25189 Comm: syz.2.7336 Not tainted syzkaller #0 PREEMPT
>>>> Hardware name: linux,dummy-virt (DT)
>>>> pstate: 00402009 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>>> pc : copy_highpage+0x150/0x334 arch/arm64/mm/copypage.c:55
>>>> lr : copy_highpage+0xb4/0x334 arch/arm64/mm/copypage.c:25
>>>> sp : ffff800088053940
>>>> x29: ffff800088053940 x28: ffffc1ffc0acf800 x27: ffff800088053b10
>>>> x26: ffffc1ffc0acf808 x25: ffffc1ffc037b1c0 x24: ffffc1ffc037b1c0
>>>> x23: ffffc1ffc0acf800 x22: ffffc1ffc0acf800 x21: fff000002b3e0000
>>>> x20: fff000000dec7000 x19: ffffc1ffc037b1c0 x18: 0000000000000000
>>>> x17: fff07ffffcffa000 x16: ffff800080008000 x15: 0000000000000001
>>>> x14: 0000000000000000 x13: 0000000000000003 x12: 000000000006d9ad
>>>> x11: 0000000000000000 x10: 0000000000000010 x9 : 0000000000000000
>>>> x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000000
>>>> x5 : ffff800088053b18 x4 : ffff80008032df94 x3 : 00000000ff000000
>>>> x2 : 01ffc00003000001 x1 : 01ffc00003000001 x0 : 01ffc00003000001
>>>> Call trace:
>>>>    try_page_mte_tagging arch/arm64/include/asm/mte.h:93 [inline] (P)
>>>>    copy_highpage+0x150/0x334 arch/arm64/mm/copypage.c:55 (P)
>>>>    copy_mc_highpage include/linux/highmem.h:383 [inline]
>>>>    folio_mc_copy+0x44/0x6c mm/util.c:740
>>>>    __migrate_folio.constprop.0+0xc4/0x23c mm/migrate.c:851
>>>>    migrate_folio+0x1c/0x2c mm/migrate.c:882
>>>>    move_to_new_folio+0x58/0x144 mm/migrate.c:1097
>>>>    migrate_folio_move mm/migrate.c:1370 [inline]
>>>>    migrate_folios_move mm/migrate.c:1719 [inline]
>>>>    migrate_pages_batch+0xaf4/0x1024 mm/migrate.c:1966
>>>>    migrate_pages_sync mm/migrate.c:2023 [inline]
>>>>    migrate_pages+0xb9c/0xcdc mm/migrate.c:2105
>>>>    do_mbind+0x20c/0x4a4 mm/mempolicy.c:1539
>>>>    kernel_mbind mm/mempolicy.c:1682 [inline]
>>>>    __do_sys_mbind mm/mempolicy.c:1756 [inline]
>>>
>>> I don't think we ever stressed MTE with mbind before. I have a suspicion
>>> this problem has been around for some time.
>>>
>>> My reading of do_mbind() is that it ends up allocating pages for
>>> migrating into via alloc_migration_target_by_mpol() ->
>>> folio_alloc_mpol(). Pages returned should be untagged and uninitialised
>>> unless the PG_* flags have not been cleared on a prior free. Or
>>> migrate_pages_batch() somehow reuses some pages instead of reallocating.
>>
>> Staring at __migrate_folio(), I assume we can end up successfully calling
>> folio_mc_copy(), but then failing in __folio_migrate_mapping().
>>
>> Seems to be as easy as failing the folio_ref_freeze() in
>> __folio_migrate_mapping().
>>
>> We return -EAGAIN in that case, making the caller retry, stumbling into an
>> already-tagged page. (with the same source / destination parameters) IIRC)
>>
>> So likely this is simply us re-doing the copy after a migration failed after
>> the copy.
>>
>> Could it happen that we are calling it with a different source/destination
>> combination the second time? I don't think so, but I am not 100% sure.
> 
> Thanks David. I can now see how it would retry on the same pages without
> reallocating. At least we know it's not causing any side-effects, only
> messing up the MTE safety warnings.

As long as the folio is not getting reused elsewhere, yes.

I haven't fully understood yet if there could be cases where we use the 
folio for another source. But I think it's not trivially possible, 
because I think we allocate dst folios based on source-folio properties 
(order, node, zone, etc).

> 
>> The most reliable way would be to un-tag in case folio_mc_copy succeeded but
>> __folio_migrate_mapping() failed.
> 
> Clearing an MTE specific flag in the core code doesn't look great. Also
> going for some generic mask like PAGE_FLAGS_CHECK_AT_PREP may have
> side-effects as we don't know where the page is coming from (we have
> those get_new_folio()/put_new_folio() arguments passed on by higher up
> callers).

As an alternative, I would probably have done something like providing a 
simple folio_mc_copy_abort().

> 
> I'm tempted to just drop the warning in the arm64 copy_highpage(),
> replace it with a comment about migration retrying on a potentially
> tagged page. It will have to override the tags each time (as it
> currently does but also warns).

Works for me. Maybe we could warn if the tag would change, because I 
think after we unmapped the folio during migration, the tag can no 
longer change.

-- 
Cheers

David / dhildenb


