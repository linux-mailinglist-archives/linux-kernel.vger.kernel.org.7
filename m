Return-Path: <linux-kernel+bounces-771845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30708B28C27
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 11:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41DF31CE5060
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 09:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C189235055;
	Sat, 16 Aug 2025 09:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ItVfvCgr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D425531770C
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 09:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755334915; cv=none; b=sEVMoDsey+4OguYLzHjZn25MOh1vGheUYOD/XrChgdJOTzA1Z28YnvKo6uHkKTn5Wuq+QTDnhWNB8NQu93fgH2KYmvEubAVimuaumY6HrpN+wTkrYtsmhN1ItZDZLO9McR0iBB6/wwIgMMKNXOVlz/m7PJkB8Wy+lD4jeRqNhAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755334915; c=relaxed/simple;
	bh=yKYsjpWLMhWpBFNoBwSSSbfozL7DFY+CO5ldUUOYZVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JeTyZrAESqTWEwHlC/8A9NcWRizwuCb9aLtp9Qo9Mo2V2kyNMalDtPQY64YPS1nuxnDfTIQIQunKd14fQi0b1C6YwKTeTkI3xeWVZZNcMeVpOQ8c1irotz4wK6Q+J5yuAqtDj/A2qagSHazFHI5jRZGw+Fyl3gte92cdGtwofKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ItVfvCgr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755334912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GLRaqZk+G77LOdhKudPGgxUl7C3uWX/KsdNR5jlxTvw=;
	b=ItVfvCgrIGvG6A3Mse2Ycf9SPLBmCxMEdYbkiy0iSJr4jfmZgBRmgdHZlEpx6VAMc/7k1t
	HMaOSkhhlJAtPuHpRp9ympYFRirLuq5e41dPN37HS6awjtNnJGh/Jy1ze3Bv02Yp0tT2v8
	3pODL5A3yeMrbHiWewXT/SjIqu+iQzI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-VArAwcyaO-S4MU8lUg5mBA-1; Sat, 16 Aug 2025 05:01:51 -0400
X-MC-Unique: VArAwcyaO-S4MU8lUg5mBA-1
X-Mimecast-MFC-AGG-ID: VArAwcyaO-S4MU8lUg5mBA_1755334910
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3b9d41c1147so1546948f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 02:01:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755334910; x=1755939710;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GLRaqZk+G77LOdhKudPGgxUl7C3uWX/KsdNR5jlxTvw=;
        b=Q4nGFZklSQ0o91mAjfZ7wXD8gah0B2bwivB5Nafk0guqkgqAIyS5E8vvLBHTM201eP
         Kp86JHAyfznxf8B9kYIDMcBzqQSp8LCffWwzvKVdWoC8JP0AGcemLG0LdUPhg6rT8+17
         odl9TMJPj+4T7lo79xi4c/wDgZNwsBsI8bC3bu6Zjtr2FMqBQt7dJ6PAixVx3OZ9qEJb
         lqaEU+lipaea0gpo+tX04rFOXJSSsfxYKybgVlWUtG7SyXH7Zil/jyz0enNbX8OrAlZS
         p3QGWGcy4gi0mpPwPLLKSs1NtlCZ8zy2Xk9s8eQmFYWRjHr/teL+egiG2FjDE8+qKLCE
         ItiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOsx6uleSq+5NJnDvFNl5zIVqzhciSUWhUMBpE/RaRddmt9/ZJpq2zQeue/5dgsDnz/dg8q7+PSRHqTmc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBrLoZCtWeExvoDBfSQVCWeJTf2Un+RIGV5pxnC4TtV/W4INN9
	IeW6JXe/8LVbw03P2LaeXlhn0VKr1DFR9wDV2gF0undtvAFQ4YFMK36ll2UAwFYd/9x68piUq2C
	ZLICtWBs9i3VCQG+lzjAdelondN/oDdBuDxmyvfyQQki3v158rpLKzdeZa2XKf3akOw==
X-Gm-Gg: ASbGnctLNY7os0FddC0TFl8CEBtUeOfl3pTBkrmC2r0q44pW4CPNY1q2UFQ0nYDHB91
	HI8YUGb9QAJ5fOMcimAJhHbd0NwgOOft7NMKeMPXDcf9luekV5/Jxr1NGnVGnqjW4io97nqad/p
	aa4edW2Bw6Vx+VVFKAk1YH8tp1PzopF8ihcBm4hw5XkqjLvvN4QMbACD9rObwyTY/mG40RUbtQV
	tcR8r02UrNORYxI4bT17PWiG4SWbeMAl5QJ0oDcMwxD3lOPRP7FFJj5aGCU8ocFCjS3ezAJmm+v
	nSyLAMM40EYCjJ1f8gyqYPPNvH8fLFN5W9lmVE8w5lnv9avc1FjvS3ZUmWIp1QQ3cWT7+xlRgii
	wZ5sOK1uq6EMO1IoSe/V6PV1cgSa+YQ3zPUqfWQW6K/e/Q4P1HpGQ0M/4/unSDYrVILs=
X-Received: by 2002:a05:6000:430b:b0:3a4:eed9:755d with SMTP id ffacd0b85a97d-3bb6665cef3mr3712056f8f.3.1755334909762;
        Sat, 16 Aug 2025 02:01:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEJeEK643AlfLu4zYVeo3CzuO7W32xxSVbF2ZLr/0L6Y10VTYefWkyiIkUj9b2SMeFimaHtg==
X-Received: by 2002:a05:6000:430b:b0:3a4:eed9:755d with SMTP id ffacd0b85a97d-3bb6665cef3mr3712023f8f.3.1755334909345;
        Sat, 16 Aug 2025 02:01:49 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f23:c700:d8ae:41bf:492a:9e4c? (p200300d82f23c700d8ae41bf492a9e4c.dip0.t-ipconnect.de. [2003:d8:2f23:c700:d8ae:41bf:492a:9e4c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb5d089e07sm5007536f8f.0.2025.08.16.02.01.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Aug 2025 02:01:48 -0700 (PDT)
Message-ID: <66ebc632-6704-4637-b62d-1cb11e5a4782@redhat.com>
Date: Sat, 16 Aug 2025 11:01:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/migrate: Fix NULL movable_ops if CONFIG_ZSMALLOC=m
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 Zi Yan <ziy@nvidia.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Harry Yoo <harry.yoo@oracle.com>, linux-kernel@vger.kernel.org,
 Minchan Kim <minchan@kernel.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20250815090539.1578484-1-chenhuacai@loongson.cn>
 <a20d605c-79a0-4d89-985b-9512a990b492@redhat.com>
 <CAAhV-H470h2HDEN_NY2qNBxUqQrSRQhLzwqZe9PB8GjnNsZVFQ@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <CAAhV-H470h2HDEN_NY2qNBxUqQrSRQhLzwqZe9PB8GjnNsZVFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 16.08.25 10:57, Huacai Chen wrote:
> Hi, David,
> 
> On Sat, Aug 16, 2025 at 3:22 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 15.08.25 11:05, Huacai Chen wrote:
>>
>> Hi,
>>
>> please CC the appropriate maintainers next time. You missed (some)
>> balloon and zsmalloc maintainers.
> OK, thanks.
> 
>>
>>> After commit 84caf98838a3e5f4bdb34 ("mm: stop storing migration_ops in
>>> page->mapping") we get such an error message if CONFIG_ZSMALLOC=m:
>>>
>>>    WARNING: CPU: 3 PID: 42 at mm/migrate.c:142 isolate_movable_ops_page+0xa8/0x1c0
>>>    CPU: 3 UID: 0 PID: 42 Comm: kcompactd0 Not tainted 6.16.0-rc5+ #2133 PREEMPT
>>>    pc 9000000000540bd8 ra 9000000000540b84 tp 9000000100420000 sp 9000000100423a60
>>>    a0 9000000100193a80 a1 000000000000000c a2 000000000000001b a3 ffffffffffffffff
>>>    a4 ffffffffffffffff a5 0000000000000267 a6 0000000000000000 a7 9000000100423ae0
>>>    t0 00000000000000f1 t1 00000000000000f6 t2 0000000000000000 t3 0000000000000001
>>>    t4 ffffff00010eb834 t5 0000000000000040 t6 900000010c89d380 t7 90000000023fcc70
>>>    t8 0000000000000018 u0 0000000000000000 s9 ffffff00010eb800 s0 ffffff00010eb800
>>>    s1 000000000000000c s2 0000000000043ae0 s3 0000800000000000 s4 900000000219cc40
>>>    s5 0000000000000000 s6 ffffff00010eb800 s7 0000000000000001 s8 90000000025b4000
>>>       ra: 9000000000540b84 isolate_movable_ops_page+0x54/0x1c0
>>>      ERA: 9000000000540bd8 isolate_movable_ops_page+0xa8/0x1c0
>>>     CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=CC DACM=CC -WE)
>>>     PRMD: 00000004 (PPLV0 +PIE -PWE)
>>>     EUEN: 00000000 (-FPE -SXE -ASXE -BTE)
>>>     ECFG: 00071c1d (LIE=0,2-4,10-12 VS=7)
>>>    ESTAT: 000c0000 [BRK] (IS= ECode=12 EsubCode=0)
>>>     PRID: 0014c010 (Loongson-64bit, Loongson-3A5000)
>>>    CPU: 3 UID: 0 PID: 42 Comm: kcompactd0 Not tainted 6.16.0-rc5+ #2133 PREEMPT
>>>    Stack : 90000000021fd000 0000000000000000 9000000000247720 9000000100420000
>>>            90000001004236a0 90000001004236a8 0000000000000000 90000001004237e8
>>>            90000001004237e0 90000001004237e0 9000000100423550 0000000000000001
>>>            0000000000000001 90000001004236a8 725a84864a19e2d9 90000000023fcc58
>>>            9000000100420000 90000000024c6848 9000000002416848 0000000000000001
>>>            0000000000000000 000000000000000a 0000000007fe0000 ffffff00010eb800
>>>            0000000000000000 90000000021fd000 0000000000000000 900000000205cf30
>>>            000000000000008e 0000000000000009 ffffff00010eb800 0000000000000001
>>>            90000000025b4000 0000000000000000 900000000024773c 00007ffff103d748
>>>            00000000000000b0 0000000000000004 0000000000000000 0000000000071c1d
>>>            ...
>>>    Call Trace:
>>>    [<900000000024773c>] show_stack+0x5c/0x190
>>>    [<90000000002415e0>] dump_stack_lvl+0x70/0x9c
>>>    [<90000000004abe6c>] isolate_migratepages_block+0x3bc/0x16e0
>>>    [<90000000004af408>] compact_zone+0x558/0x1000
>>>    [<90000000004b0068>] compact_node+0xa8/0x1e0
>>>    [<90000000004b0aa4>] kcompactd+0x394/0x410
>>>    [<90000000002b3c98>] kthread+0x128/0x140
>>>    [<9000000001779148>] ret_from_kernel_thread+0x28/0xc0
>>>    [<9000000000245528>] ret_from_kernel_thread_asm+0x10/0x88
>>>
>>> The reason is that defined(CONFIG_ZSMALLOC) evaluates to 1 only when
>>> CONFIG_ZSMALLOC=y, we should use IS_ENABLED(CONFIG_ZSMALLOC) instead.
>>
>> Ouch, I missed that CONFIG_ZSMALLOC can be configured like that. I
>> thought it would always be builtin.
> Make CONFIG_ZSMALLOC be bool can solve this, if you think it is reasonable.
> 
>>
>>> But when I use IS_ENABLED(CONFIG_ZSMALLOC), page_movable_ops() cannot
>>> access zsmalloc_mops because zsmalloc_mops is in a module.
>>>
>>> To solve this problem, we define a movable_ops[] array in mm/migrate.c,
>>> initialise its elements at mm/balloon_compaction.c & mm/zsmalloc.c, and
>>> let the page_movable_ops() function return elements from movable_ops[].
>>
>> Before I took that easy route to just get it working quickly, I
>> envisioned a proper registration interface. See below.
> When I found I cannot access zsmalloc_mops in a module I considered
> the registration interface. But in this case I think that is an
> over-design and not straight forward.
> 
> Moreover, a registration interface looks like a redesign and not
> suitable for hot-fix.

I think you misread my message: This is not debatable.

If you don't want to fix it properly, I can send a fix.

-- 
Cheers

David / dhildenb


