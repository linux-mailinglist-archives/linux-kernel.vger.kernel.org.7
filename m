Return-Path: <linux-kernel+bounces-773622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF83B2A2DF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 15:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08FBA18986BC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 12:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F29B320CAB;
	Mon, 18 Aug 2025 12:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iGhAOf4s"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8152831E0FF
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755521677; cv=none; b=F3d1dTnuPWAINUBCb/P4OVJkGNGZwABQWhuF118Yh2p6QwMHX1mS6ryTQ2tNczKfy5oKt7/B37z217jzSYTm99Q7FfRX2NsMiPlJQuFPNBUkJdHC7VvJHR3JvZvDcB0w/d6n8J34M8xlZRiO9qQ3JSE3EqymTr5sUROO4ZTykYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755521677; c=relaxed/simple;
	bh=uzZg3gU0j2BYwk56jizTPFQZk4FoA/g0xb6OEOLdklQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o4e1kA59CWod0QFzGk1kLJu/mxknG4l8Z7bMBEegesG7xinuCwCug0UgZxB9mfM5fwf3NvwaNIFtLT6nf9B3aEO1wlescZYslGp7hF7UU9oz5WaQp7fdFHB9bQL0JDbrN5nAk/Q5dmkuTrmhefiEW37b0oCnCLgCzdJZJA+u0ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iGhAOf4s; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755521674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=BSfQdikloqcDL9542CPxmBCkUvXeLc4c3xxgRGWoAUo=;
	b=iGhAOf4szbTkosY1M+gX3MsIOcf9Jx+wrGdrEBkyPdVgOuyhsGqa48pTAcrVudVDpOW5m9
	qDYhE+P9o4iXGcd2vmDmDh9VYlP7uHRxImlHbSmB4m0TUq795ZurSwG6U+IJbQcl/t7iJY
	jBLT7L61bE72v1EFD3c4HhaJN23GKzg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-VIqYRtJXMEO5PFRss013sQ-1; Mon, 18 Aug 2025 08:54:32 -0400
X-MC-Unique: VIqYRtJXMEO5PFRss013sQ-1
X-Mimecast-MFC-AGG-ID: VIqYRtJXMEO5PFRss013sQ_1755521672
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3b9edf332faso1911590f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 05:54:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755521672; x=1756126472;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BSfQdikloqcDL9542CPxmBCkUvXeLc4c3xxgRGWoAUo=;
        b=Qa3YVuj9bBi7GMDKYBjqIJ825vcOMuYNIw6SQ95/2C/5VNn8XfL+jQI9p+bb3SANH/
         9rLpgzxESWl3YSOKVBztfFp3GyGBfm0TP616fr99KUY8ODLwAlm/1kN8r/Xti/xpuR4L
         2QrCb4ZJymVeQIvSW8Zw6cslvGl5KtqlQ2jHtVNU/wBL0fJe6/xwVPuE9ZmyRqLftO5x
         u9qB1WvGsuaBg31tKkOluybA5cRlAJGgN2zyD2roly937Ljunyvh6j9LGqUNOdldBPp2
         SXyB7On/c/MbpaVvjKUb3dsANGrON4Fn0Tm4Kb3hIF4TLgch0oRv7F7l+yRh7/j5fJR0
         ok4w==
X-Forwarded-Encrypted: i=1; AJvYcCVU9FpvWXpBeHwK/JmoIndyOcfgTSMlvgHH4c0UgtpNaU50TnT6nCRWq9swwk2CIbWMMjxj8xaLD+eHlR8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx7WHi4PS1FWDm/WHg+VrS3Eui9OSwc653FU8DsoZofr7GKjl4
	ePSsOvpCRJcAmmycGVd2rs7zBMOsLRxRFP+aXRM8Zx8wsGfyaQNgUy3VgDffS6Li87v6fDBzTaW
	Bhux17ywX0HaUJmX7tLnRgZl4OzBvpDHfqeVeuRbaiv+MqWlZR23U1InyMTaJN7YdOA==
X-Gm-Gg: ASbGncvAYig/MQxZSdlvuuzaN9+wJ6WQJK3tfucYYhY7VmLdQAZpUgjgNr0m3luoy1r
	rCPsW6tX5KzgoO2kLcc8BID/JGXxCda/0JFS0RTqzhYQQPSGjTDGgWbbMJqMbAY1EnVyldM6TnY
	2qGCLNhRu6tbZj+3goKXwhzV9NKYneAL3WCyrFDZ/shio0TpCxek+GcSzS8lom+jalsXT0K6VA4
	UwbllATLSAAnAu9c745UDE0He4hjmfw5LUY6FuCj7WBl8lNO5Oc6qWKzTEtpdsR/xaM8kh1X1gz
	nliDFS1rlMP30CeIF1mUL/gM8JFsAEmXri87ZjuKkMC2hQy3Kr9s757BC5+OUIDTBDp+CGQGfbH
	UIJA78YihxR8k5bA3DvRRPMIVmE7LNeUoZXsUll0kGiU9X3BbNr0guKFv/BWCTJyS
X-Received: by 2002:a05:6000:2002:b0:3b8:d79a:6a35 with SMTP id ffacd0b85a97d-3bb66e16f8amr9053933f8f.20.1755521671604;
        Mon, 18 Aug 2025 05:54:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoBXhfwxqv95/4yHVjpurPEyJagTWHd/HzfhJfFuUekvtXBYgU5MmLe7RX24srAW0Lf5onsA==
X-Received: by 2002:a05:6000:2002:b0:3b8:d79a:6a35 with SMTP id ffacd0b85a97d-3bb66e16f8amr9053910f8f.20.1755521671102;
        Mon, 18 Aug 2025 05:54:31 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f22:600:53c7:df43:7dc3:ae39? (p200300d82f22060053c7df437dc3ae39.dip0.t-ipconnect.de. [2003:d8:2f22:600:53c7:df43:7dc3:ae39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb64758463sm12795586f8f.4.2025.08.18.05.54.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 05:54:30 -0700 (PDT)
Message-ID: <6bd5ffe2-8f28-497e-9092-085e5d1cbc1f@redhat.com>
Date: Mon, 18 Aug 2025 14:54:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] WARNING in move_page_tables
To: Harry Yoo <harry.yoo@oracle.com>,
 syzbot <syzbot+4d9a13f0797c46a29e42@syzkaller.appspotmail.com>,
 Peter Xu <peterx@redhat.com>
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, jannh@google.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 lorenzo.stoakes@oracle.com, pfalcato@suse.de,
 syzkaller-bugs@googlegroups.com, vbabka@suse.cz,
 Ryan Roberts <ryan.roberts@arm.com>,
 =?UTF-8?Q?Miko=C5=82aj_Lenczewski?= <miko.lenczewski@arm.com>
References: <689bb893.050a0220.7f033.013a.GAE@google.com>
 <aJyDAX8bHZCp93Dq@hyeyoo>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZoEEwEIAEQCGwMCF4ACGQEFCwkIBwICIgIG
 FQoJCAsCBBYCAwECHgcWIQQb2cqtc1xMOkYN/MpN3hD3AP+DWgUCaJzangUJJlgIpAAKCRBN
 3hD3AP+DWhAxD/9wcL0A+2rtaAmutaKTfxhTP0b4AAp1r/eLxjrbfbCCmh4pqzBhmSX/4z11
 opn2KqcOsueRF1t2ENLOWzQu3Roiny2HOU7DajqB4dm1BVMaXQya5ae2ghzlJN9SIoopTWlR
 0Af3hPj5E2PYvQhlcqeoehKlBo9rROJv/rjmr2x0yOM8qeTroH/ZzNlCtJ56AsE6Tvl+r7cW
 3x7/Jq5WvWeudKrhFh7/yQ7eRvHCjd9bBrZTlgAfiHmX9AnCCPRPpNGNedV9Yty2Jnxhfmbv
 Pw37LA/jef8zlCDyUh2KCU1xVEOWqg15o1RtTyGV1nXV2O/mfuQJud5vIgzBvHhypc3p6VZJ
 lEf8YmT+Ol5P7SfCs5/uGdWUYQEMqOlg6w9R4Pe8d+mk8KGvfE9/zTwGg0nRgKqlQXrWRERv
 cuEwQbridlPAoQHrFWtwpgYMXx2TaZ3sihcIPo9uU5eBs0rf4mOERY75SK+Ekayv2ucTfjxr
 Kf014py2aoRJHuvy85ee/zIyLmve5hngZTTe3Wg3TInT9UTFzTPhItam6dZ1xqdTGHZYGU0O
 otRHcwLGt470grdiob6PfVTXoHlBvkWRadMhSuG4RORCDpq89vu5QralFNIf3EysNohoFy2A
 LYg2/D53xbU/aa4DDzBb5b1Rkg/udO1gZocVQWrDh6I2K3+cCs7BTQRVy5+RARAA59fefSDR
 9nMGCb9LbMX+TFAoIQo/wgP5XPyzLYakO+94GrgfZjfhdaxPXMsl2+o8jhp/hlIzG56taNdt
 VZtPp3ih1AgbR8rHgXw1xwOpuAd5lE1qNd54ndHuADO9a9A0vPimIes78Hi1/yy+ZEEvRkHk
 /kDa6F3AtTc1m4rbbOk2fiKzzsE9YXweFjQvl9p+AMw6qd/iC4lUk9g0+FQXNdRs+o4o6Qvy
 iOQJfGQ4UcBuOy1IrkJrd8qq5jet1fcM2j4QvsW8CLDWZS1L7kZ5gT5EycMKxUWb8LuRjxzZ
 3QY1aQH2kkzn6acigU3HLtgFyV1gBNV44ehjgvJpRY2cC8VhanTx0dZ9mj1YKIky5N+C0f21
 zvntBqcxV0+3p8MrxRRcgEtDZNav+xAoT3G0W4SahAaUTWXpsZoOecwtxi74CyneQNPTDjNg
 azHmvpdBVEfj7k3p4dmJp5i0U66Onmf6mMFpArvBRSMOKU9DlAzMi4IvhiNWjKVaIE2Se9BY
 FdKVAJaZq85P2y20ZBd08ILnKcj7XKZkLU5FkoA0udEBvQ0f9QLNyyy3DZMCQWcwRuj1m73D
 sq8DEFBdZ5eEkj1dCyx+t/ga6x2rHyc8Sl86oK1tvAkwBNsfKou3v+jP/l14a7DGBvrmlYjO
 59o3t6inu6H7pt7OL6u6BQj7DoMAEQEAAcLBfAQYAQgAJgIbDBYhBBvZyq1zXEw6Rg38yk3e
 EPcA/4NaBQJonNqrBQkmWAihAAoJEE3eEPcA/4NaKtMQALAJ8PzprBEXbXcEXwDKQu+P/vts
 IfUb1UNMfMV76BicGa5NCZnJNQASDP/+bFg6O3gx5NbhHHPeaWz/VxlOmYHokHodOvtL0WCC
 8A5PEP8tOk6029Z+J+xUcMrJClNVFpzVvOpb1lCbhjwAV465Hy+NUSbbUiRxdzNQtLtgZzOV
 Zw7jxUCs4UUZLQTCuBpFgb15bBxYZ/BL9MbzxPxvfUQIPbnzQMcqtpUs21CMK2PdfCh5c4gS
 sDci6D5/ZIBw94UQWmGpM/O1ilGXde2ZzzGYl64glmccD8e87OnEgKnH3FbnJnT4iJchtSvx
 yJNi1+t0+qDti4m88+/9IuPqCKb6Stl+s2dnLtJNrjXBGJtsQG/sRpqsJz5x1/2nPJSRMsx9
 5YfqbdrJSOFXDzZ8/r82HgQEtUvlSXNaXCa95ez0UkOG7+bDm2b3s0XahBQeLVCH0mw3RAQg
 r7xDAYKIrAwfHHmMTnBQDPJwVqxJjVNr7yBic4yfzVWGCGNE4DnOW0vcIeoyhy9vnIa3w1uZ
 3iyY2Nsd7JxfKu1PRhCGwXzRw5TlfEsoRI7V9A8isUCoqE2Dzh3FvYHVeX4Us+bRL/oqareJ
 CIFqgYMyvHj7Q06kTKmauOe4Nf0l0qEkIuIzfoLJ3qr5UyXc2hLtWyT9Ir+lYlX9efqh7mOY
 qIws/H2t
In-Reply-To: <aJyDAX8bHZCp93Dq@hyeyoo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13.08.25 14:20, Harry Yoo wrote:
> On Tue, Aug 12, 2025 at 02:56:35PM -0700, syzbot wrote:
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    53e760d89498 Merge tag 'nfsd-6.17-1' of git://git.kernel.o..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=165fe9a2580000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=f9319a42cfb3bf57
>> dashboard link: https://syzkaller.appspot.com/bug?extid=4d9a13f0797c46a29e42
>> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14172842580000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15b04c34580000
>>
>> Downloadable assets:
>> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-53e760d8.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/584b4139c7e3/vmlinux-53e760d8.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/4d2474607300/bzImage-53e760d8.xz
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+4d9a13f0797c46a29e42@syzkaller.appspotmail.com
> 
> [Cc'ing Ryan, Mikołaj, David and Peter]
> 
> I was able to reliably reproduce this (with the reproducer provided
> by syzbot) and performed bisection.
> 
> The first bad commit is 0cef0bb836e mm: clear uffd-wp PTE/PMD state on
> mremap(), which was introduced in v6.13.
> 


Okay, so we're hitting the

	if (WARN_ON_ONCE(!pmd_none(*new_pmd)))
		return false;

in move_normal_pmd().

Given that the reproducer involves allocation fault injection during move_page_tables(),
I assume we run into this warning when we are trying to restore our previous state,
so when we call move_page_tables() the
second time from copy_vma_and_data().

Something when moving stuff back after a failed PTE table allocation is broken.


Ah, maybe I know what happens.

When we move the first time, we check "vma_has_uffd_without_event_remap(orig_vma)"
and see that "yes, this thing has uffd" and decide to move PTE level

When we move back, we check "vma_has_uffd_without_event_remap(new_vma)" and see
that "no, this thing does not have uffd" and decide to move PMD level.

But the original PTE table is still there ...

As a side-note: It's confusing to call vma_has_uffd_without_event_remap() to make
a decision during mremap to handle WP, when WP might not even be active.
We should likely slap in a uffd-wp check on the VMA as a follow-up cleanup.

#syz test

diff --git a/mm/mremap.c b/mm/mremap.c
index 33b642076205d..a9730f4373b77 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -323,6 +323,26 @@ static inline bool arch_supports_page_table_move(void)
  }
  #endif
  
+static inline bool uffd_supports_page_table_move(struct pagetable_move_control *pmc)
+{
+	/*
+	 * If we are moving VMAs that have uffd-wp registered but with
+	 * remap events disabled (new VMA will not be registered with uffd), we
+	 * need to ensure that the uffd-wp state is cleared from all pgtables.
+	 * This means recursing into lower page tables in move_page_tables().
+	 *
+	 * We setup the uffd-wp context on the new VMA after moving the page
+	 * tables succeeded, so checking the old VMA looks reasonable. However,
+	 * when we have to recover from a failed page table move attempt, we
+	 * get called with inverse VMAs. Recursing into lower page tables during
+	 * the original move but not during the recovery move will cause
+	 * trouble, because we run into already-existing page tables during
+	 * the recovery phase. Consequently, check both VMAs.
+	 */
+	return !vma_has_uffd_without_event_remap(pmc->old) &&
+	       !vma_has_uffd_without_event_remap(pmc->new);
+}
+
  #ifdef CONFIG_HAVE_MOVE_PMD
  static bool move_normal_pmd(struct pagetable_move_control *pmc,
  			pmd_t *old_pmd, pmd_t *new_pmd)
@@ -335,6 +355,8 @@ static bool move_normal_pmd(struct pagetable_move_control *pmc,
  
  	if (!arch_supports_page_table_move())
  		return false;
+	if (!uffd_supports_page_table_move(pmc))
+		return false;
  	/*
  	 * The destination pmd shouldn't be established, free_pgtables()
  	 * should have released it.
@@ -361,15 +383,6 @@ static bool move_normal_pmd(struct pagetable_move_control *pmc,
  	if (WARN_ON_ONCE(!pmd_none(*new_pmd)))
  		return false;
  
-	/* If this pmd belongs to a uffd vma with remap events disabled, we need
-	 * to ensure that the uffd-wp state is cleared from all pgtables. This
-	 * means recursing into lower page tables in move_page_tables(), and we
-	 * can reuse the existing code if we simply treat the entry as "not
-	 * moved".
-	 */
-	if (vma_has_uffd_without_event_remap(vma))
-		return false;
-
  	/*
  	 * We don't have to worry about the ordering of src and dst
  	 * ptlocks because exclusive mmap_lock prevents deadlock.
@@ -418,6 +431,8 @@ static bool move_normal_pud(struct pagetable_move_control *pmc,
  
  	if (!arch_supports_page_table_move())
  		return false;
+	if (!uffd_supports_page_table_move(pmc))
+		return false;
  	/*
  	 * The destination pud shouldn't be established, free_pgtables()
  	 * should have released it.
@@ -425,15 +440,6 @@ static bool move_normal_pud(struct pagetable_move_control *pmc,
  	if (WARN_ON_ONCE(!pud_none(*new_pud)))
  		return false;
  
-	/* If this pud belongs to a uffd vma with remap events disabled, we need
-	 * to ensure that the uffd-wp state is cleared from all pgtables. This
-	 * means recursing into lower page tables in move_page_tables(), and we
-	 * can reuse the existing code if we simply treat the entry as "not
-	 * moved".
-	 */
-	if (vma_has_uffd_without_event_remap(vma))
-		return false;
-
  	/*
  	 * We don't have to worry about the ordering of src and dst
  	 * ptlocks because exclusive mmap_lock prevents deadlock.
-- 
2.50.1

-- 
Cheers

David / dhildenb


