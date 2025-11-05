Return-Path: <linux-kernel+bounces-886743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 561F0C3669A
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 16:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7FCF24FEEA5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 15:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB426332EA3;
	Wed,  5 Nov 2025 15:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="pv2RJGvq"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0258832ED38
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 15:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762356388; cv=none; b=Sn7eL+PfPC02TSR5Fde5+5yXHvV7BfhiiITGLz9k7H2lD7aMybHqyb9NLzIJrYv3jlDFAtmgsqLs0o8pbGEXsttHsXJVsQFwswFGfmxZw8GeJqiTkgMM+r6+DheVI6SDS8Lvq1LVgEc8bPdc3RG8BZ/eYlPvrQweVfk1Xr7mqzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762356388; c=relaxed/simple;
	bh=5ue5tL8Jb7H7Gv3Q/MlTFY91FC7k7XwAJqyggs6Au6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IpqHi3o5juBw1gck+z09N43KBoiy/nD4cKnfoMNuDgc4UXQZEuHfTLRmWsRXxV2GgzhUlRNfHnvtWTbW8rBs8afJ59m98iG+AGwvuByaTyF5a1X8iPYg/f/FzLsAp/3YRRpFMPB+miGC6pcPjiYj01W8O8bsyATJR24zx8R163U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=pv2RJGvq; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-4331709968fso50327965ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 07:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1762356384; x=1762961184; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wJMw23ag07d9YyGaAXQZB3LwsXKp0Eq82MOZSboYNLA=;
        b=pv2RJGvqqlS6qwKxPM2/MUYvyx4JbywtIfIkm80E8mWJF1SMUBMqT35cxKcA9ayzPl
         46iD1ySEe94AvJSnMzzfq4DGbHtPV0kZU4zBxnwUR9oKzw7jeGmEaLwCRCQ1NncpJbxL
         N9vwF4+oe1bZVzsBvUT7S0w2dCgSWq7U14wVEoUGhuodwcQBnFV51exHDfds+6aesg2h
         F9DP89jla99t0+HXPqG2eepAzjL/hnS5kOpUUgc8j9GuQM3FY1Mov2kAsKammdG/PJ+R
         rkTr5FVY2n1p2h+7G3L9f1NvIwyXHwqIlH1ozkcAI6T4Jjxk2J84au1MgK5haYiMErg1
         pfZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762356384; x=1762961184;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wJMw23ag07d9YyGaAXQZB3LwsXKp0Eq82MOZSboYNLA=;
        b=fVXZjdKt2GX6vb7xdHFcBJXnd4atjb5xOvsBjbopG5pE7897OTZ3eph+8gGFsdhJpy
         nWG5HmZs1gWZZyicT1HOKcsnmwEmcWbV0QNJyMYBNDE+G5i/VSgdYPzz5MuOhAYG9ERw
         b5rixeeKTGR1yox8BbWJ4LR6wnAFS8k3/ZzihidD7HjBWS4PZn4veXlkxbQ9cT6YZAUg
         v/KWrZhkzlCzSsXKSuJYQGUjimDEDk8w+htXasfhqX/RS/P4FcC7pf4Pjh2FvSWJd9CK
         vFzau6iR/M5b5Cg+2nGAQ/lB6jb5GdyTaiQzowPzMVxHjkIkXq+nfmyL4RzoaabfbluG
         QUfw==
X-Forwarded-Encrypted: i=1; AJvYcCUqjvtZJyHhU7e6qt56IEpkLzX6o82q5wH2ZAg5NumR05I0SO0cTvTYTTQrASZOMgfGBHlkt1Qv7H8Y8BA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0nV5AHkZrghsGES2T2YbWxiPXn4jebnoToEIj207hKbyxHdsr
	gcjXMkmlg00SQ0enjPGnnOZPV04LFb1DheRwJk+CxO+X+Ygt4gZodmOPozoBVwX90mIOWg6ZEum
	OdAx8
X-Gm-Gg: ASbGncuXPI9DWbjW87vsRKYbg/4YTajwjy3GQ0KqSoqBd7bVseZtCQ/HBx8k4ELsgCY
	NmjGA+rrXINdhVCkzojJt0kFLk8sIk26EiiP+Xvc+JEQ04ODdKiqXQgh2d0Mr8W/RiRng+wKxCe
	zZt6VC6oG3n9GQ2zcaaApJxD8aL04qDA/hqlsct2NJonv/MUD2ap2GV2++jOGECXhNbu5ldddM/
	jQnh3CtNQmPM91dcOjUiTWv7Fzvg5uzpAuJgNCeYsaxiQjjMieYUeGM43yEPQ5WbZbmAd1do5Pg
	hm4OHxUJHgcoPs5qde+4LpDB1VILmtgD19EkI7WQxro9GGKEwhQGfzDqCtq58m5F77J30H2bH9g
	IZyZvrDqsmfjAekpyVWasbu0OM5TocPCWpqeRPEUxYR/0QoB+EqJ5wEZMZZHp+qvhu9pSTLi+6O
	nljwizvWQ=
X-Google-Smtp-Source: AGHT+IFOCqH9vMp8Y+tbAbwhk4CARwNNBKaPtY2QKZEvv3tWyjN4/HIZU+2nmwOokQud2POY49dJtA==
X-Received: by 2002:a05:6e02:164f:b0:431:f7df:f026 with SMTP id e9e14a558f8ab-43340753584mr55884735ab.2.1762356383969;
        Wed, 05 Nov 2025 07:26:23 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-43335aafb84sm26538755ab.16.2025.11.05.07.26.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 07:26:23 -0800 (PST)
Message-ID: <34e94983-3828-469b-bb87-6a08061c101a@kernel.dk>
Date: Wed, 5 Nov 2025 08:26:22 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ublk: use copy_{to,from}_iter() for user copy
To: Ming Lei <ming.lei@redhat.com>,
 Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251031010522.3509499-1-csander@purestorage.com>
 <aQQwy7l_OCzG430i@fedora>
 <CADUfDZoPDbKO60nNVFk35X2JvT=8EV7vgROP+y2jgx6P39Woew@mail.gmail.com>
 <aQVAVBGM7inQUa7z@fedora>
 <CADUfDZqKV2SzbWoe4gr4aSPaBtr+VwmEgEidZKo=LQBU9Quf2Q@mail.gmail.com>
 <aQqs2TlXU0UYlsuy@fedora>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aQqs2TlXU0UYlsuy@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/25 6:48 PM, Ming Lei wrote:
> On Mon, Nov 03, 2025 at 08:40:30AM -0800, Caleb Sander Mateos wrote:
>> On Fri, Oct 31, 2025 at 4:04?PM Ming Lei <ming.lei@redhat.com> wrote:
>>>
>>> On Fri, Oct 31, 2025 at 09:02:48AM -0700, Caleb Sander Mateos wrote:
>>>> On Thu, Oct 30, 2025 at 8:45?PM Ming Lei <ming.lei@redhat.com> wrote:
>>>>>
>>>>> On Thu, Oct 30, 2025 at 07:05:21PM -0600, Caleb Sander Mateos wrote:
>>>>>> ublk_copy_user_pages()/ublk_copy_io_pages() currently uses
>>>>>> iov_iter_get_pages2() to extract the pages from the iov_iter and
>>>>>> memcpy()s between the bvec_iter and the iov_iter's pages one at a time.
>>>>>> Switch to using copy_to_iter()/copy_from_iter() instead. This avoids the
>>>>>> user page reference count increments and decrements and needing to split
>>>>>> the memcpy() at user page boundaries. It also simplifies the code
>>>>>> considerably.
>>>>>>
>>>>>> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
>>>>>> ---
>>>>>>  drivers/block/ublk_drv.c | 62 +++++++++-------------------------------
>>>>>>  1 file changed, 14 insertions(+), 48 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
>>>>>> index 0c74a41a6753..852350e639d6 100644
>>>>>> --- a/drivers/block/ublk_drv.c
>>>>>> +++ b/drivers/block/ublk_drv.c
>>>>>> @@ -912,58 +912,47 @@ static const struct block_device_operations ub_fops = {
>>>>>>       .open =         ublk_open,
>>>>>>       .free_disk =    ublk_free_disk,
>>>>>>       .report_zones = ublk_report_zones,
>>>>>>  };
>>>>>>
>>>>>> -#define UBLK_MAX_PIN_PAGES   32
>>>>>> -
>>>>>>  struct ublk_io_iter {
>>>>>> -     struct page *pages[UBLK_MAX_PIN_PAGES];
>>>>>>       struct bio *bio;
>>>>>>       struct bvec_iter iter;
>>>>>>  };
>>>>>
>>>>> ->pages[] is actually for pinning user io pages in batch, so killing it may cause
>>>>> perf drop.
>>>>
>>>> As far as I can tell, copy_to_iter()/copy_from_iter() avoids the page
>>>> pinning entirely. It calls copy_to_user_iter() for each contiguous
>>>> user address range:
>>>>
>>>> size_t _copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
>>>> {
>>>>         if (WARN_ON_ONCE(i->data_source))
>>>>                 return 0;
>>>>         if (user_backed_iter(i))
>>>>                 might_fault();
>>>>         return iterate_and_advance(i, bytes, (void *)addr,
>>>>                                    copy_to_user_iter, memcpy_to_iter);
>>>> }
>>>>
>>>> Which just checks that the address range doesn't include any kernel
>>>> addresses and then memcpy()s directly via the userspace virtual
>>>> addresses:
>>>>
>>>> static __always_inline
>>>> size_t copy_to_user_iter(void __user *iter_to, size_t progress,
>>>>                          size_t len, void *from, void *priv2)
>>>> {
>>>>         if (should_fail_usercopy())
>>>>                 return len;
>>>>         if (access_ok(iter_to, len)) {
>>>>                 from += progress;
>>>>                 instrument_copy_to_user(iter_to, from, len);
>>>>                 len = raw_copy_to_user(iter_to, from, len);
>>>>         }
>>>>         return len;
>>>> }
>>>>
>>>> static __always_inline __must_check unsigned long
>>>> raw_copy_to_user(void __user *dst, const void *src, unsigned long size)
>>>> {
>>>>         return copy_user_generic((__force void *)dst, src, size);
>>>> }
>>>>
>>>> static __always_inline __must_check unsigned long
>>>> copy_user_generic(void *to, const void *from, unsigned long len)
>>>> {
>>>>         stac();
>>>>         /*
>>>>          * If CPU has FSRM feature, use 'rep movs'.
>>>>          * Otherwise, use rep_movs_alternative.
>>>>          */
>>>>         asm volatile(
>>>>                 "1:\n\t"
>>>>                 ALTERNATIVE("rep movsb",
>>>>                             "call rep_movs_alternative",
>>>> ALT_NOT(X86_FEATURE_FSRM))
>>>>                 "2:\n"
>>>>                 _ASM_EXTABLE_UA(1b, 2b)
>>>>                 :"+c" (len), "+D" (to), "+S" (from), ASM_CALL_CONSTRAINT
>>>>                 : : "memory", "rax");
>>>>         clac();
>>>>         return len;
>>>> }
>>>>
>>>> Am I missing something?
>>>
>>> page is allocated & mapped in page fault handler.
>>
>> Right, physical pages certainly need to be allocated for the virtual
>> address range being copied to/from. But that would have happened
>> previously in iov_iter_get_pages2(), so this isn't a new cost. And as
>> you point out, in the common case that the virtual pages are already
>> mapped to physical pages, the copy won't cause any page faults.
>>
>>>
>>> However, in typical cases, pages in io buffer shouldn't be swapped out
>>> frequently, so this cleanup may be good, I will run some perf test.
>>
>> Thanks for testing.
> 
> `fio/t/io_uring` shows 40% improvement on `./kublk -t null -q 2` with this
> patch in my test VM, so looks very nice improvement.
> 
> Also it works well by forcing to pass IOSQE_ASYNC on the ublk uring_cmd,
> and this change is correct because the copy is guaranteed to be done in ublk
> daemon context.

We good to queue this up then?

-- 
Jens Axboe

