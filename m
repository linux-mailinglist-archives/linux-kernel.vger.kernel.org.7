Return-Path: <linux-kernel+bounces-830849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38085B9AB82
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28462189D84C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A63A31197A;
	Wed, 24 Sep 2025 15:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CXdncvDW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2D330FF30
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 15:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758728162; cv=none; b=TwNPXlz6LuZkc7D5aZTfXxeyVunSvRTcpFULJK3Xnm8R8fSc9KfwJmNL3bCnuybTs2F9MGpjbvXqV6/lhfCPvv+0xCNr6bzil2oijWJT6gaTFdMfMQxX5JVGxsEAnbS6aoeqtE7V3EPktuRNy2fLtaN7y5q1gPDav5aTiytdweY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758728162; c=relaxed/simple;
	bh=zmDqwojMM1lnRKWK3WtRDJSTnmhgG5+OgO9n1/K/Jjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bLJ8eFF/HIapot8VBFoyGC8Ka20MS7i6NH+EIoebhExbygB/iJSAbGQX1EZH7ium1L+Gbc2P6DuCblyu9zR26GWfm2h8m0rS4PBmM9eWoLvpnRLD1XWE+Hj52begM6wr1roabsf8ruS39NfISFKVS13E0FJdQmc1GT764zMoMe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CXdncvDW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758728159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=LAyCGXo1P+EO9JKpvics0vv03BSPlHspewc/0vaRl1E=;
	b=CXdncvDWotT0X2Z2a3X9ojXD3DFhwq3qlHbscggvAWRHzeEfown2iJVVsSp5TvDMcUqOb3
	oFVuq0P247Kgq9mof9S4A+PdvQ+SxaurSbRt7k90b04FUE2F74P1T5jwmKuinjn/84x+73
	RJzIQDztVdIC8v3tzuzOg+N48pusNZQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-kE_KpW3AMlqWXC5f9XzbjA-1; Wed, 24 Sep 2025 11:35:57 -0400
X-MC-Unique: kE_KpW3AMlqWXC5f9XzbjA-1
X-Mimecast-MFC-AGG-ID: kE_KpW3AMlqWXC5f9XzbjA_1758728157
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ee13baf21dso14108f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:35:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758728156; x=1759332956;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LAyCGXo1P+EO9JKpvics0vv03BSPlHspewc/0vaRl1E=;
        b=cwjr7mwHvEu9c52MLYos0HprorJFYTLEgxWnHbRsev1ZByVipkLVY+pg64UQIUML2w
         8LFYUIevmINAaRhOGt/NLWiczJCfbbG5doxTKpgGoiBNrjVaEYvfn9eR2qWaOU/UOqBi
         NcVIONjJhM7rirZeKxRAzAJY13XrTHWvj9+zoLYzTl4pSxdZ9QK9of3hplxiGuOGN/tG
         CzTnFBvCgfTTumiS/hpzsXcsg8EUM7BETP3KF8h6o60+KED0DJyEpasf+kjCl5rc5HbN
         DcjwiowrzjuSIXBDQ/Ib2qFLaSV/v3RlJ2aPGOA8bo/udSejo4A/9Ti5AI8unR3Dz75d
         SZ2w==
X-Forwarded-Encrypted: i=1; AJvYcCVkxpz81thpsF+5LtTKSkAO+RNqmAUNqS+CArUZugmDmaYJ2U2NnFKwoslaOzoHKcw7n9BumUDC5fK16lY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsHRlP/pkBsR5bRdMr/yWOBcvLsXN/tA4/aF24oyKhsi4MoE+c
	NZ/KpcZK4PbtEcFsdnu1jMwucNNr7QQpBlR8+8/8Lh8LU8qMQLhnJVaFVaETfGfR/2N6edzOmpO
	c+pXDuCjdR//2TUNRwV0JDkvn9f+XESF2A5oYdqLZD22AqzB5uFyS/yfgyc5Hx9xv8A==
X-Gm-Gg: ASbGnct0Bmz8U28G5ijkczMsbSoPoF/P83zn6Q4L05BNwbXIY975fVj+9Ewmw4Q1+mw
	y8W5lx7xD74yUuug+jYwvlsTgAhi/wzK66lo+G84tLapQLkZKxoisYRXogU/Y6iAepu4wtrNaVh
	3duu5eWa2CDX36A6sux47yLUah/1CcOMQ0cG4ePUkrrajL79r9LVhQdGfK95hkN2qqS1ZucTCBG
	pJkoQt+CBDcfMbcLJ2gzHKL+/ZLjnLoIcrBD5xB/QXwXXFZzn979BMHby7mBgHx3+TKiGIohT0s
	Ml6gND0yK575Nl62Cqa+Tqlu/zb4z58mkS/9mKbN9ChaevhIlXYdBv8lKxTZuLMjF5EFEyWerjO
	FTenOykdNnzJ6IfFPlQRhr8lavjFYo15QnOzx/EkFKpHMMWgnda8r40UDfFqnz7/x6Q==
X-Received: by 2002:a5d:64e3:0:b0:3f7:9dcf:c066 with SMTP id ffacd0b85a97d-40e49aa1238mr399439f8f.51.1758728156523;
        Wed, 24 Sep 2025 08:35:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwSsjpjzzXpCkKbUJHa5gYasxSGtyNZJegtW1mwoNm4LYZm7WRUs1eoF3xKALtC/ETkes1vg==
X-Received: by 2002:a5d:64e3:0:b0:3f7:9dcf:c066 with SMTP id ffacd0b85a97d-40e49aa1238mr399410f8f.51.1758728156071;
        Wed, 24 Sep 2025 08:35:56 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f14:2400:afc:9797:137c:a25b? (p200300d82f1424000afc9797137ca25b.dip0.t-ipconnect.de. [2003:d8:2f14:2400:afc:9797:137c:a25b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbefd5csm30761348f8f.51.2025.09.24.08.35.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 08:35:55 -0700 (PDT)
Message-ID: <70522abd-c03a-43a9-a882-76f59f33404d@redhat.com>
Date: Wed, 24 Sep 2025 17:35:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] WARNING in memory_failure
To: Zi Yan <ziy@nvidia.com>
Cc: syzbot <syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com>,
 akpm@linux-foundation.org, linmiaohe@huawei.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, nao.horiguchi@gmail.com,
 syzkaller-bugs@googlegroups.com
References: <68d2c943.a70a0220.1b52b.02b3.GAE@google.com>
 <ce93b55c-75a7-4b4d-a68b-9d80baf1578b@redhat.com>
 <DB0E39CD-36A9-4929-BCC6-33F27E387AEA@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <DB0E39CD-36A9-4929-BCC6-33F27E387AEA@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.09.25 17:03, Zi Yan wrote:
> On 24 Sep 2025, at 7:32, David Hildenbrand wrote:
> 
>> On 23.09.25 18:22, syzbot wrote:
>>> Hello,
>>>
>>> syzbot found the following issue on:
>>>
>>> HEAD commit:    b5db4add5e77 Merge branch 'for-next/core' into for-kernelci
>>> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=10edb8e2580000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=d2ae34a0711ff2f1
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=e6367ea2fdab6ed46056
>>> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
>>> userspace arch: arm64
>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14160f12580000
>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1361627c580000
>>>
>>> Downloadable assets:
>>> disk image: https://storage.googleapis.com/syzbot-assets/6eee2232d5c1/disk-b5db4add.raw.xz
>>> vmlinux: https://storage.googleapis.com/syzbot-assets/a8b00f2f1234/vmlinux-b5db4add.xz
>>> kernel image: https://storage.googleapis.com/syzbot-assets/fc0d466f156c/Image-b5db4add.gz.xz
>>>
>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>>> Reported-by: syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com
>>>
>>> Injecting memory failure for pfn 0x104000 at process virtual address 0x20000000
>>> ------------[ cut here ]------------
>>> WARNING: CPU: 1 PID: 6700 at mm/memory-failure.c:2391 memory_failure+0x18ec/0x1db4 mm/memory-failure.c:2391
>>> Modules linked in:
>>> CPU: 1 UID: 0 PID: 6700 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT
>>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/30/2025
>>> pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
>>> pc : memory_failure+0x18ec/0x1db4 mm/memory-failure.c:2391
>>> lr : memory_failure+0x18ec/0x1db4 mm/memory-failure.c:2391
>>> sp : ffff8000a41478c0
>>> x29: ffff8000a41479a0 x28: 05ffc00000200868 x27: ffff700014828f20
>>> x26: 1fffffbff8620001 x25: 05ffc0000020086d x24: 1fffffbff8620000
>>> x23: fffffdffc3100008 x22: fffffdffc3100000 x21: fffffdffc3100000
>>> x20: 0000000000000023 x19: dfff800000000000 x18: 1fffe00033793888
>>> x17: ffff80008f7ee000 x16: ffff80008052aa64 x15: 0000000000000001
>>> x14: 1fffffbff8620000 x13: 0000000000000000 x12: 0000000000000000
>>> x11: ffff7fbff8620001 x10: 0000000000ff0100 x9 : 0000000000000000
>>> x8 : ffff0000d7eedb80 x7 : ffff800080428910 x6 : 0000000000000000
>>> x5 : 0000000000000001 x4 : 0000000000000001 x3 : ffff800080cf5438
>>> x2 : 0000000000000001 x1 : 0000000000000040 x0 : 0000000000000000
>>> Call trace:
>>>    memory_failure+0x18ec/0x1db4 mm/memory-failure.c:2391 (P)
>>>    madvise_inject_error mm/madvise.c:1475 [inline]
>>>    madvise_do_behavior+0x2c8/0x7c4 mm/madvise.c:1875
>>>    do_madvise+0x190/0x248 mm/madvise.c:1978
>>>    __do_sys_madvise mm/madvise.c:1987 [inline]
>>>    __se_sys_madvise mm/madvise.c:1985 [inline]
>>>    __arm64_sys_madvise+0xa4/0xc0 mm/madvise.c:1985
>>>    __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
>>>    invoke_syscall+0x98/0x254 arch/arm64/kernel/syscall.c:49
>>>    el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
>>>    do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
>>>    el0_svc+0x5c/0x254 arch/arm64/kernel/entry-common.c:744
>>>    el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:763
>>>    el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596
>>
>> We're running into the
>>
>>          WARN_ON(folio_test_large(folio));
>>
>> in memory_failure().
>>
>> Which is weird because we have the
>>
>>          if (folio_test_large(folio)) {
>>                  /*
>>                   * The flag must be set after the refcount is bumped
>>                   * otherwise it may race with THP split.
>>                   * And the flag can't be set in get_hwpoison_page() since
>>                   * it is called by soft offline too and it is just called
>>                   * for !MF_COUNT_INCREASED.  So here seems to be the best
>>                   * place.
>>                   *
>>                   * Don't need care about the above error handling paths for
>>                   * get_hwpoison_page() since they handle either free page
>>                   * or unhandlable page.  The refcount is bumped iff the
>>                   * page is a valid handlable page.
>>                   */
>>                  folio_set_has_hwpoisoned(folio);
>>                  if (try_to_split_thp_page(p, false) < 0) {
>>                          res = -EHWPOISON;
>>                          kill_procs_now(p, pfn, flags, folio);
>>                          put_page(p);
>>                          action_result(pfn, MF_MSG_UNSPLIT_THP, MF_FAILED);
>>                          goto unlock_mutex;
>>                  }
>>                  VM_BUG_ON_PAGE(!page_count(p), p);
>>                  folio = page_folio(p);
>>          }
>>
>> before it.
>>
>> But likely that's what I raised to Zi Yan recently: if try_to_split_thp_page()->split_huge_page()
>> silently decided to split to something that is not a small folio (the min_order_for_split() bit),
>> this changed the semantics of the function.
>>
>> Likely split_huge_page() should have failed if the min_order makes us not split to order-0,
>> or there would have to be some "parameter" that tells split_huge_page() what expectation (order) the
>> callers has.
>>
>> We can check folio_test_large() after the split, but really, we should just not be splitting at
>> all if it doesn't serve our purpose.
> 
> But LBS might want to split from a high order to fs min_order.

Yes.

> 
> What I can think of is:
> 0. split code always does a split to allowed minimal order,
>     namely max(fs_min_order, order_from_caller);

Wouldn't max mean "allowed maximum order" ?

I guess what you mean is "split to this order or smaller" -- min?

> 1. if split order cannot reach to order_from_caller, it just return fails,
>     so most of the caller will know about it;

Yes, I think this would be the case here: if we cannot split to order-0, 
we can just fail right away.

> 2. for LBS code, when it sees a split failure, it should check the resulting
>     folio order against fs min_order. If the orders match, it regards it as
>     a success.
> 
> At least, most of the code does not need to be LBS aware. WDYT?

Is my understand correct that it's either that the caller wants to

(a) Split to order-0 -- no larger folio afterwards.

(b) Split to smallest order possible, which might be the mapping min order.

If so, we could keep the interface simpler than allowing to specify 
arbitrary orders as request.

-- 
Cheers

David / dhildenb


