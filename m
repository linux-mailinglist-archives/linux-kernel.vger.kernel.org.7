Return-Path: <linux-kernel+bounces-784775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C00B340E9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 15:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB1617B0E67
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 13:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070C82727F3;
	Mon, 25 Aug 2025 13:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xL2gfzC/"
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B67022C355
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 13:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756129016; cv=none; b=nCjWO/R13kZZMR8uvIYk2giyIcwZ51cHTR+Q86Y/HWGbkRVisRdWfNLCh6daPmemz0IlFG/NK42GZV5CWOIjy8N7LgOnELAQrZqLjrLZfYjbiU7mhlZgnHF4GNkMz0rNnuY1Yx3XXyyiRSYBvfUl34kG2JhQ2HrcdGN485TL8Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756129016; c=relaxed/simple;
	bh=4m9o+RKBgJ5Col1Fd/r0APHp/9BhO/z8l4G4dr4+Ozc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dwplkzV9ngYNx4/mMPbW9o95MOuG0ErqXCvSEBIVEnLoKlepLtxCvzDuxVSkmnB0TQtaWZXzLf0bxPc9EgzqHOS9dH1iCcmDd79sbAuySTHfxaCpp6ul84RGrw8YxEU1r2w75joiHO02x0wCWw27ErJxXJX5YCNbkwYNTB2vbb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xL2gfzC/; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-61c3360bbaeso2340504a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 06:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756129012; x=1756733812; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pDTMpOHUU+5woUIgWQOxnynpQcS2ptNxqXsiFnt7QfQ=;
        b=xL2gfzC/JZSqTjP4DzofRVYHI2qAkIHZpT7u21FrK0KTnUwZLRn0vkW5HAE1gjhUTq
         iXYnHA3QloE+DUNgTaC7EA463mQs92RXZbK3rX011+jwAZKhkkcvQizEB79cB7wFZ1SY
         uWFke1I2j+07d67e40aFOeas/bEDnmtVYYQXfxCXtck7fkmqS/tsbbbaGSzhVIQDiY03
         aj4xxQ5vd4G+JJgVTGLoBT3IpUYQ/575wtgIcOYyBHEyEgxjz/tsUJjtTfEmMcGM0Pt+
         S5WSxVOmcvmN5Sk3KaqONgghY2Kdme3ak6Wj2MFu4xmDoCzM1/iOJP4RWe6ZHB9lna6F
         kqLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756129012; x=1756733812;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pDTMpOHUU+5woUIgWQOxnynpQcS2ptNxqXsiFnt7QfQ=;
        b=GL6FzhrLHPFNdZ/92/yqiJort28AChRh881X6IQmkOiFOyrcn8aXbaDv34gAnOlh3G
         l+GNL/sX7CIfIQwP5gvas6eet2zyYl1Y4w2Q22kIjjleE6jeU8W9KpJq+rQnmMPeC/X7
         bLWTq/VIS3HdLKFkjRQ4PZQ2bXhDh5P4koQ2CRPVRYyOo2PCczyUTgrf9kRxuYUSwxAi
         Qj9rcTkHUlMnmnkHSM3b2Vs9Qr6MGJxpf0jnfVx519eUBzvZmL680ZvCXPnIHLtrxF8w
         0l3WJeWymN86pcbjG481i9zSvnXN0P0rV/eCSgtuAD3VTv1ykQUhuXVNWEkCy2DaICDI
         Lwog==
X-Gm-Message-State: AOJu0YzP/GKvJs5G6GzZd/HerLSYmRspSMJ+Ge7wwTXD9zuAlouvivJi
	7n6Tn9/0FttYSSqBA/J6cxXxTWcpbjfjtg76b21xh/iUzbhw3tPfBN3ELnghYjSq0Yk=
X-Gm-Gg: ASbGncvjcZH9HSciwPbSlfPNKeF3CpwxxdeK/GD/1esNDXk98tHNYcBnCEyJG503PB6
	FwQS6MsrO1cdjn6qr6r9rzo6s39a+crv03/VPLG7zrIQmkjeuWsvIG8q3FgicfeBJpS/y4AYl4K
	xzWGwpiOmyVoC8o/p/RqvDi3VLTOOYnRbcugkp72wfEb+droHyfRMKwwqDK2N5Iqc6Xa8TSLtTl
	WNi8/KX/I0FCZs4BqCTiv88IOgpSUm9bdji81gBZ1x+OwwOJJC1FRoasgW3I9jVDX7g9neY2SjU
	Ep0iXPapQ9REXtssE7QxnygaAV3qF7UPXLVzsF3nSYoyFPKbaLwFcF0HdPKFDvwv0/pr5eNJilO
	6zaAbET3jnmvMZR4CnRL9KWeG1XI3PA==
X-Google-Smtp-Source: AGHT+IFLBUsjEEaRTMKTTS5UYe1p7dIIzUWH6NZxIBU0sDo3Xlc4F0hHutvr4vh9c1wWtrm9SoU6bw==
X-Received: by 2002:a17:907:7202:b0:af9:bfef:156b with SMTP id a640c23a62f3a-afe296a7876mr865808766b.59.1756129012418;
        Mon, 25 Aug 2025 06:36:52 -0700 (PDT)
Received: from [192.168.0.24] ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe91744c66sm72984966b.88.2025.08.25.06.36.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 06:36:52 -0700 (PDT)
Message-ID: <01c67173-818c-48cf-8515-060751074c37@linaro.org>
Date: Mon, 25 Aug 2025 16:36:50 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH v2 22/29] mm/numa: Register information into Kmemdump
To: David Hildenbrand <david@redhat.com>, Michal Hocko <mhocko@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org, tglx@linutronix.de,
 andersson@kernel.org, pmladek@suse.com,
 linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org,
 corbet@lwn.net, mojha@qti.qualcomm.com, rostedt@goodmis.org,
 jonechou@google.com, tudor.ambarus@linaro.org,
 Christoph Hellwig <hch@infradead.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>
References: <20250724135512.518487-1-eugen.hristev@linaro.org>
 <20250724135512.518487-23-eugen.hristev@linaro.org>
 <ffc43855-2263-408d-831c-33f518249f96@redhat.com>
 <e66f29c2-9f9f-4b04-b029-23383ed4aed4@linaro.org>
 <751514db-9e03-4cf3-bd3e-124b201bdb94@redhat.com>
 <aJCRgXYIjbJ01RsK@tiehlicka>
 <e2c031e8-43bd-41e5-9074-c8b1f89e04e6@linaro.org>
 <23e7ec80-622e-4d33-a766-312c1213e56b@redhat.com>
 <f43a61b4-d302-4009-96ff-88eea6651e16@linaro.org>
 <77d17dbf-1609-41b1-9244-488d2ce75b33@redhat.com>
 <ecd33fa3-8362-48f0-b3c2-d1a11d8b02e3@linaro.org>
 <9f13df6f-3b76-4d02-aa74-40b913f37a8a@redhat.com>
 <64a93c4a-5619-4208-9e9f-83848206d42b@linaro.org>
 <f1f290fc-b2f0-483b-96d5-5995362e5a8b@redhat.com>
From: Eugen Hristev <eugen.hristev@linaro.org>
Content-Language: en-US
In-Reply-To: <f1f290fc-b2f0-483b-96d5-5995362e5a8b@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/25/25 16:20, David Hildenbrand wrote:
> 
>>>
>>> IIRC, kernel/vmcore_info.c is never built as a module, as it also
>>> accesses non-exported symbols.
>>
>> Hello David,
>>
>> I am looking again into this, and there are some things which in my
>> opinion would be difficult to achieve.
>> For example I looked into my patch #11 , which adds the `runqueues` into
>> kmemdump.
>>
>> The runqueues is a variable of `struct rq` which is defined in
>> kernel/sched/sched.h , which is not supposed to be included outside of
>> sched.
>> Now moving all the struct definition outside of sched.h into another
>> public header would be rather painful and I don't think it's a really
>> good option (The struct would be needed to compute the sizeof inside
>> vmcoreinfo). Secondly, it would also imply moving all the nested struct
>> definitions outside as well. I doubt this is something that we want for
>> the sched subsys. How the subsys is designed, out of my understanding,
>> is to keep these internal structs opaque outside of it.
> 
> All the kmemdump module needs is a start and a length, correct? So the 
> only tricky part is getting the length.

I also have in mind the kernel user case. How would a kernel programmer
want to add some kernel structs/info/buffers into kmemdump such that the
dump would contain their data ? Having "KMEMDUMP_VAR(...)" looks simple
enough.
Otherwise maybe the programmer has to write helpers to compute lengths
etc, and stitch them into kmemdump core.
I am not saying it's impossible, but just tiresome perhaps.

> 
> One could just add a const variable that holds this information, or even 
> better, a simple helper function to calculate that.
> 
> Maybe someone else reading along has a better idea.

This could work, but it requires again adding some code into the
specific subsystem. E.g. struct_rq_get_size()
I am open to ideas , and thank you very much for your thoughts.

> 
> Interestingly, runqueues is a percpu variable, which makes me wonder if 
> what you had would work as intended (maybe it does, not sure).

I would not really need to dump the runqueues. But the crash tool which
I am using for testing, requires it. Without the runqueues it will not
progress further to load the kernel dump.
So I am not really sure what it does with the runqueues, but it works.
Perhaps using crash/gdb more, to actually do something with this data,
would give more insight about its utility.
For me, it is a prerequisite to run crash, and then to be able to
extract the log buffer from the dump.

> 
>>
>>  From my perspective it's much simpler and cleaner to just add the
>> kmemdump annotation macro inside the sched/core.c as it's done in my
>> patch. This macro translates to a noop if kmemdump is not selected.
> 
> I really don't like how we are spreading kmemdump all over the kernel, 
> and adding complexity with __section when really, all we need is a place 
> to obtain a start and a length.
> 

I understand. The section idea was suggested by Thomas. Initially I was
skeptic, but I like how it turned out.

> So we should explore if there is anything easier possible.
> 
>>>
>>>>
>>>> So I am unsure whether just removing the static and adding them into
>>>> header files would be more acceptable.
>>>>
>>>> Added in CC Cristoph Hellwig and Sergey Senozhatsky maybe they could
>>>> tell us directly whether they like or dislike this approach, as kmemdump
>>>> would be builtin and would not require exports.
>>>>
>>>> One other thing to mention is the fact that the printk code dynamically
>>>> allocates memory that would need to be registered. There is no mechanism
>>>> for kmemdump to know when this process has been completed (or even if it
>>>> was at all, because it happens on demand in certain conditions).
>>>
>>> If we are talking about memblock allocations, they sure are finished at
>>> the time ... the buddy is up.
>>>
>>> So it's just a matter of placing yourself late in the init stage where
>>> the buddy is already up and running.
>>>
>>> I assume dumping any dynamically allocated stuff through the buddy is
>>> out of the picture for now.
>>>
>>
>> The dumping mechanism needs to work for dynamically allocated stuff, and
>> right now, it works for e.g. printk, if the buffer is dynamically
>> allocated later on in the boot process.
> 
> You are talking about the memblock_alloc() result, correct? Like
> 
> new_log_buf = memblock_alloc(new_log_buf_len, LOG_ALIGN);
> 
> The current version is always stored in
> 
> static char *log_buf = __log_buf;
> 
> 
> Once early boot is done and memblock gets torn down, you can just use 
> log_buf and be sure that it will not change anymore.
> 
>>
>> To have this working outside of printk, it would be required to walk
>> through all the printk structs/allocations and select the required info.
>> Is this something that we want to do outside of printk ?
> 
> I don't follow, please elaborate.
> 
> How is e.g., log_buf_len_get() + log_buf_addr_get() not sufficient, 
> given that you run your initialization after setup_log_buf() ?
> 
> 

My initial thought was the same. However I got some feedback from Petr
Mladek here :

https://lore.kernel.org/lkml/aBm5QH2p6p9Wxe_M@localhost.localdomain/

Where he explained how to register the structs correctly.
It can be that setup_log_buf is called again at a later time perhaps.

