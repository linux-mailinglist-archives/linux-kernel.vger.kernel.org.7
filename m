Return-Path: <linux-kernel+bounces-839416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2625BB1956
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 21:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFD827A5523
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 19:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC542C159D;
	Wed,  1 Oct 2025 19:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WixW4Pd3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC3A258EDF
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 19:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759346667; cv=none; b=VbX+0itYopo4Mlmw1IRmoRBtclrOyU90CsYmyz75iIzWA5DLdzIxuKBHGPOdf2Evda6U36yVeUyGu2pfgqQGpdo1XeNH1MB/ID4YlUXyy5ruLXu6FapfSqRvH3Uhwd9zx2cOaE5UYM63Tey/5aBW1dnl1/FmZybQuVGvHcwxDZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759346667; c=relaxed/simple;
	bh=nRC46xEODH80MnbSgfC/kuQIrvaHgrZgSGpEKmC0rFQ=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=IlarJYwkKRkcWxaRkWtfdo9V79eRTSksnCm96q0YiblUA6B5Xxtlbv6bo1R7pWBzzs6FaSUp7BdZvnVVsm/C2YMKrFZGnSDuxj2U7sWn8g/3oQuERlPKBhZtxx3vkvK2u2aRkPkRDnQswOdMUHAnXCgy/lxoeAkdIKdY/2yqBNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WixW4Pd3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759346665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=It1UT3kjVaVEvGMYUZZVYUbJfdXTOcvLkqZghBBkKwY=;
	b=WixW4Pd3aHrvtf3JwytdBQOpWyg4zk27SCs5nC+WfQ13ST5r1kP0OonKkrwmxoRiDXfhgD
	4Ke0b1Uufu3BNmOH1BgOlihVkmS/2rzdGTJyfVMXeQcJsgdp23ZH5XO1PBRZZHNOiWu/Fi
	BFlx3JNj3oGPy81wX9LhyUKxDys6QgM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-paE5DzyjPzKWNV-iONUXlQ-1; Wed, 01 Oct 2025 15:24:23 -0400
X-MC-Unique: paE5DzyjPzKWNV-iONUXlQ-1
X-Mimecast-MFC-AGG-ID: paE5DzyjPzKWNV-iONUXlQ_1759346663
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-79538b281cdso3418686d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 12:24:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759346663; x=1759951463;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=It1UT3kjVaVEvGMYUZZVYUbJfdXTOcvLkqZghBBkKwY=;
        b=pkWJ6vKztyn6q9mmqQwePHqSkV8yh1ScXp/mQVWjzHZqSFtC9UjjTJk815hatNsbrX
         259m4CJqf+ps/IjdRC8rm+IQKXxhV8BZuiikfrEso0yd4oQmmY+/IIjPAuWWYX+e/e8C
         rpRofAVO5krP8u20LURS/k+SAisG2+iEfIQHPOpxaBTVac3ckE6tSJ9rXsgt1uwEr+u2
         1NT/9+t0qGEf2vJS/JR78WpYAV/ZFb5GBtO0ks1l+cvOSS9cFQV5A2f68hF9CCnMnTwr
         H89ggwTDWik+eSQ9ZeuVKN2aDm0KWRpbW5maItDbavsTHUqgKyqDdYZtakwdbcjzc5w4
         G77A==
X-Forwarded-Encrypted: i=1; AJvYcCUWKCu0Mhv1cSdUMfJ0t37rJ1xz/WDnpU5R3mg+o50QMCyUku8qHNF4Rw2feJSFK0RqHqvRgg6alb/kVfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYconf421jCryZ7su84PzIFGgmbYAMK2MP9NLlY7mF4XTeFSJD
	riSwNTIwQwV7NkbEWi+IrOzLYY+Tm3pH/NRI9Ahe7R5ioTZfp6BI1i6y8QwY5lM2hCGfZt7J9L0
	VEe5BsWCYIdmPhADEksdTBYJpW4Sx60/wffJTMkVakDLWw+ME2DaIARrIPYv4swFjaQ==
X-Gm-Gg: ASbGncvvi5HLf+XhPhi8ofOWvGZY5eopRhVDtp+e9sD02HvPXhFX3Kvms79PwB8hH5O
	z15hc6ltwzkwLnoGplRaumB0PdU18pK0G/svoWDRUL4gqPD0HKK+T2Z3bsCQsEE5Kby1BReEXY4
	Cqd7LylCEmMHYLKQBclxBALgKekuN+zb6XqyVbLvBWhWkUN7LYsaiACyUBc6v0wXy/HC18QGTZD
	ovnCDPezUecwF9V3RThA7f3AsUMzj/5wvJUYeUPg4p2YAHeh3S+Y2XcyTH1hV0x4brqxnfUI/hI
	Rw9UBUGT18unXQsKEKIkbgpPhiqDHTtTiQdnZP79rs4vRlNgomELU6SAmOL4jc949Ztg9eTia/B
	R6j9DqBmj+yLKvePI
X-Received: by 2002:a05:6214:19c4:b0:789:52eb:2bf2 with SMTP id 6a1803df08f44-878b96f1c8amr12556056d6.2.1759346663207;
        Wed, 01 Oct 2025 12:24:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlm7ZAgEs+bKq/EvjUX5mjxTrOeSPCDA0Y46chfCyC1AxVmu3PWcJptUKJm0ibHjpf7GZUGw==
X-Received: by 2002:a05:6214:19c4:b0:789:52eb:2bf2 with SMTP id 6a1803df08f44-878b96f1c8amr12555816d6.2.1759346662822;
        Wed, 01 Oct 2025 12:24:22 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878bd785963sm4306356d6.35.2025.10.01.12.24.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 12:24:22 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <339a4e0b-f323-4d48-8a1a-b7459aec53a2@redhat.com>
Date: Wed, 1 Oct 2025 15:24:21 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] documentation: seqlock: fix the wrong documentation
 of read_seqbegin_or_lock/need_seqretry
To: Oleg Nesterov <oleg@redhat.com>, Waiman Long <llong@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, David Howells <dhowells@redhat.com>,
 Ingo Molnar <mingo@redhat.com>, Li RongQing <lirongqing@baidu.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20250928161953.GA3112@redhat.com>
 <20250928162029.GA3121@redhat.com>
 <b83e9c1d-2623-4abf-8c63-1110a0b92d2e@redhat.com>
 <20251001190625.GA32506@redhat.com>
Content-Language: en-US
In-Reply-To: <20251001190625.GA32506@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/1/25 3:06 PM, Oleg Nesterov wrote:
> On 10/01, Waiman Long wrote:
>> On 9/28/25 12:20 PM, Oleg Nesterov wrote:
>>> --- a/Documentation/locking/seqlock.rst
>>> +++ b/Documentation/locking/seqlock.rst
>>> @@ -218,13 +218,14 @@ Read path, three categories:
>>>      according to a passed marker. This is used to avoid lockless readers
>>>      starvation (too much retry loops) in case of a sharp spike in write
>>>      activity. First, a lockless read is tried (even marker passed). If
>>> -   that trial fails (odd sequence counter is returned, which is used as
>>> -   the next iteration marker), the lockless read is transformed to a
>>> -   full locking read and no retry loop is necessary::
>>> +   that trial fails (sequence counter doesn't match), make the marker
>>> +   odd for the next iteration, the lockless read is transformed to a
>>> +   full locking read and no retry loop is necessary, for example::
>>>   	/* marker; even initialization */
>>> -	int seq = 0;
>>> +	int seq = 1;
>>>   	do {
>>> +		seq++; /* 2 on the 1st/lockless path, otherwise odd */
>>>   		read_seqbegin_or_lock(&foo_seqlock, &seq);
>>>   		/* ... [[read-side critical section]] ... */
>> It is kind of odd to initialize the sequence to 1 and add an sequence
>> increment inside the loop.
> Sure. But a) in this patch my only point is that the current documentation is
> wrong, and b) the pseudo-code after this change becomes correct and the new
> pattern already have the users. For example, do_io_accounting() and more.
Thank for letting me know, but I believe my suggested change will work 
with this modified loop iteration.
>
>> Perhaps we can do something like:
> Perhaps. But could you please read the "RFC 2/1" thread? To me it is kind of
> odd that the simple loops like this example have to even touch the sequence
> counter inside the loop.
>
>> +static inline int need_seqretry_once(seqlock_t *lock, int *seq)
>> +{
>> +       int ret = !(*seq & 1) && read_seqretry(lock, *seq);
>> +
>> +       if (ret)
>> +               *seq = 1;       /* Enforce locking in next iteration */
>> +       return ret;
>> +}
> And this is exactly what I tried to propose in "RFC 2/1". Plus more...

I had read that. You used _xxx() suffix which I think a good choice will 
be to use _once() to indicate that we only want one retry.

Note that I believe the current read_seqbegin_or_lock() API was made to 
be consistent with how the read_seqbegin() or read_seqcount_begin() APIs 
are being used. I am not against your suggested single helper function, 
but it may cause confusion because it differs from the others. So it 
must be clearly documented to highlight its difference from the other 
similar APIs.

Cheers,
Longman


