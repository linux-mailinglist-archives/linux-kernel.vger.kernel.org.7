Return-Path: <linux-kernel+bounces-801203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC742B441F2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 18:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 911DA7B6B2F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41654288511;
	Thu,  4 Sep 2025 15:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UVXKkAzy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE33285078
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 15:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757001561; cv=none; b=jQEkJdOt+plrJf+AdoUvAA0+3dgm9f3gx+8z7c4kWsncM11g1rsNqJCUj2p/1+hJk6lFJaBgqNQ0s3nZe5IZHnZVMdLEdWKXQ9ZzROjDUyyaD1Flnmd3FKqBjxMiIMKUQKhDVySALR2SrrlYxFdMrurIJiPspdEP9s7XkeIaiEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757001561; c=relaxed/simple;
	bh=wP1mjY7oYAykBHuPl6UXlsQfY4pE3+EORBKDNCB2amw=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=kmLjkh5oD9IUJ+kZfgZAfFG1GICf1Wma2rk9BbEWxD32jZitLgnw8XHkqiYZLc/9bep2hSiNaBYFAFgFUpSgyutNsE2vv6/iTnhlsKRXt6m3L2u2KtnFDF2pr8kIPkz6QQp310qnzdBWafz1GNwCpiXJljchYA0p3QyQDcgcFG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UVXKkAzy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757001558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=07dkFvxcmTc5OCWDxxC6GUlNPtAy7YoAfUUe6s4/Nw0=;
	b=UVXKkAzyMyglFDO8adhVUMZPl5ZViUrXtbriJefgVr1GXYspOH72UFSIK4NoHjZOv+f17m
	AijS5WY7yGIdLS6iVbNXZaj7DiE/78kuy8G1veswQoROw9v+2XT6Ua3Nuh+Ot8lINk4w0Q
	hJF25GCHqJyqG6Kqmsac1Z3zFiGXTSM=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-YQNVhj-SMQOCsTcFQLYNMA-1; Thu, 04 Sep 2025 11:59:17 -0400
X-MC-Unique: YQNVhj-SMQOCsTcFQLYNMA-1
X-Mimecast-MFC-AGG-ID: YQNVhj-SMQOCsTcFQLYNMA_1757001556
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b34c87dad0so23627971cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 08:59:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757001556; x=1757606356;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=07dkFvxcmTc5OCWDxxC6GUlNPtAy7YoAfUUe6s4/Nw0=;
        b=KSJG/8VTeeyCO+pXTCplgbwosZLAru4UlxFob2Q1FiWgK/YAdkmAEi8uAzUKlGFkvV
         Mxk00uTkDsyC08Q6YB3gXwcmkkmd8rQ1sLkwklUv8fIxQUqKra/QqxAFDRkqYVqdd2kS
         7vKsom8IpFk6hhNXcTU1MMhL6SX6KE6N6dSqxihmwImLIOtAR/QuAgujgNAVAdT0l/kL
         mY9bi8mA2C7Wxv2ONpCOPNis8PK/mv5nfnMz5iB7/X26GEU6ZQUm1Pl5/4xJx/VXo9Wn
         BZg2E5XLX5pVnesFl6Ogm3it4HU29ih0k3y5t5PeBj7u+ZWPc2f8ezcbCeQrnF2MV/x/
         KR9A==
X-Gm-Message-State: AOJu0Yx0irDXmdibF0cckcTcqnmLStN55Pu7ufUN/g1TBsh+yK3oZw7Z
	urIxvGFn9pMF9P02ncMgVJw0nsxYVSd64d2YX1oEIOI4GQEb3zEUjrsCtLW65sR/L4ov9pz3IM2
	XFV/Kfw5Vmt5keZjxN6UqK1yReyZP0vVZqioTWG+1NwqhFKC/pybmBDUGMX56U1RLDw==
X-Gm-Gg: ASbGncuC133jAD9xe8MH5fiRIOCaGWv1ZshCek97AW2Anh2M+1+vC3ONiEHmTyxpTEC
	shYRl13hDhrMK7bOUL4XMgJ9xb1ohqHZzCCEEsGbv2MGQIi1yQkrxpYtJ6cbTmw+ncDs2bMUbqf
	yhrdZn/3EW611E1jKXsk20rlEURPVHjwezO0ajWjDZzwv8mFbWA4GforGL20HjARbcv8w9N7Adv
	JNz7arnu5iEjiHttnQLEJnIoq9P9dBS/Ydd3iNWGQBjFhvepey5KFkf+k1aCOmCxav8br//Af8T
	sL3XJ/oEwpXJHrUBfcVNJ/rIr7FQmZ2WzubvHmI1trImxtgeVTVlEmH5y5arrYImgiw0dskXyp3
	BGtM86DyHkg==
X-Received: by 2002:a05:622a:54b:b0:4b0:78fb:39da with SMTP id d75a77b69052e-4b31d846113mr232112171cf.21.1757001556488;
        Thu, 04 Sep 2025 08:59:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkGpLl66+pXtPFx4EcxN3PEzIt/mqyBU6nj68kcsF8hJ9qMsL8t56zLath7e07jSH1WHfitQ==
X-Received: by 2002:a05:622a:54b:b0:4b0:78fb:39da with SMTP id d75a77b69052e-4b31d846113mr232111601cf.21.1757001555782;
        Thu, 04 Sep 2025 08:59:15 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b48f757a0fsm30464181cf.30.2025.09.04.08.59.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 08:59:15 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <a408ea95-2a03-4c87-a620-a455ca390630@redhat.com>
Date: Thu, 4 Sep 2025 11:59:13 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] selftest/futex: Make the error check more precise for
 futex_numa_mpol
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 Waiman Long <llong@redhat.com>
Cc: linux-kernel@vger.kernel.org, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Juri Lelli <juri.lelli@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Valentin Schneider <vschneid@redhat.com>, Borislav Petkov <bp@alien8.de>,
 kernel-dev@igalia.com
References: <20250901203327.53887-1-andrealmeid@igalia.com>
 <1d6a0c1e-5fa2-4c21-b3c1-7bfb2f9dd669@redhat.com>
 <fd720337-ebc8-4039-b9bf-062be642f5d3@igalia.com>
Content-Language: en-US
In-Reply-To: <fd720337-ebc8-4039-b9bf-062be642f5d3@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/4/25 11:23 AM, André Almeida wrote:
> Hi Waiman,
>
> Thanks for the feedback!
>
> Em 03/09/2025 14:53, Waiman Long escreveu:
>> On 9/1/25 4:33 PM, André Almeida wrote:
>>> Instead of just checking if the syscall failed as expected, check as
>>> well what is the error code returned, to check if it's match the
>>> expectation and it's failing in the correct error path inside the
>>> kernel.
>>>
>>> Signed-off-by: André Almeida <andrealmeid@igalia.com>
>>> ---
>>> This patch is aimed for 6.18
>>> ---
>>>   .../futex/functional/futex_numa_mpol.c        | 36 
>>> +++++++++++--------
>>>   1 file changed, 21 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/futex/functional/ 
>>> futex_numa_mpol.c b/tools/testing/selftests/futex/functional/ 
>>> futex_numa_mpol.c
>>> index 802c15c82190..c84441751235 100644
>>> --- a/tools/testing/selftests/futex/functional/futex_numa_mpol.c
>>> +++ b/tools/testing/selftests/futex/functional/futex_numa_mpol.c
>>> @@ -77,7 +77,7 @@ static void join_max_threads(void)
>>>       }
>>>   }
>>> -static void __test_futex(void *futex_ptr, int must_fail, unsigned 
>>> int futex_flags)
>>> +static void __test_futex(void *futex_ptr, int err_value, unsigned 
>>> int futex_flags)
>>>   {
>>>       int to_wake, ret, i, need_exit = 0;
>>> @@ -88,11 +88,17 @@ static void __test_futex(void *futex_ptr, int 
>>> must_fail, unsigned int futex_flag
>>>       do {
>>>           ret = futex2_wake(futex_ptr, to_wake, futex_flags);
>>> -        if (must_fail) {
>>> -            if (ret < 0)
>>> -                break;
>>> -            ksft_exit_fail_msg("futex2_wake(%d, 0x%x) should fail, 
>>> but didn't\n",
>>> -                       to_wake, futex_flags);
>>> +
>>> +        if (err_value) {
>>> +            if (ret >= 0)
>>> +                ksft_exit_fail_msg("futex2_wake(%d, 0x%x) should 
>>> fail, but didn't\n",
>>> +                           to_wake, futex_flags);
>>> +
>>> +            if (errno != err_value)
>>> +                ksft_exit_fail_msg("futex2_wake(%d, 0x%x) expected 
>>> error was %d, but returned %d (%s)\n",
>>> +                           to_wake, futex_flags, err_value, errno, 
>>> strerror(errno));
>>> +
>>> +            break;
>>
>> If (ret >= 0), the 2nd (errno != err_value) failure message will 
>> likely be printed too. Should we use "else if" so that only one error 
>> message will be printed?
>>
>>
>
> ksft_exit_fail_msg() calls exit(), so the code will exit before 
> executing the second failure message.
>
> If this was a  ksft_test_result_error() call, then the message would 
> be printed twice.

I didn't realize that. Thanks for letting me know. In that case, the 
code should be OK.

Cheers,
Longman


