Return-Path: <linux-kernel+bounces-810522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 479F8B51BC4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 17:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3E3C546080
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 15:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDFB327A0E;
	Wed, 10 Sep 2025 15:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="nQn2vXcB"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D00324B33
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 15:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757518478; cv=none; b=cec2D4BeUJSgxwg9HEAprZ8d4XBBB6G7axmRRC3xj6AbBPWguQrcn7JnxavDMQA2YIXc2PCbMLtRkPC1C0H/FM7NnGlGxoAz+N3dtmhXpBXE9dbIg/jbdnY6+7m1R+D1+Egiyc2L4mqc5/pqPVlAoHO44JhabHyuswowKrCLkPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757518478; c=relaxed/simple;
	bh=+q2+Xu/IRD1e3gMqmeepZIuQ3wuLE1LLkqW1ux/g3Lg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=umC5DmhHsFvqo5glkDiI/Fbjpf8wWLub4oHf4HNzeHOTJ3PVZBrroA8vrBi1NJW6nLeaOQNJ7VPgo9KE9D4nH86yWpNO+Z6kIj/0v5N3OpwdsCjxHPepiUT/4JR2IGvZ1VgCvCKLaGE6uNwIWFTnFVUPZdjyevTdoeX7xrzX6dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=nQn2vXcB; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-88432d9cfcaso66910539f.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 08:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1757518476; x=1758123276; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3vRPFcqil5SBFGWxr6KWfBmqpBpY6ibY3g+VscnfO/0=;
        b=nQn2vXcBsQeVBHRDXnVXI5bG8bzuFf4fDu2dAtZtUxjr7oz4/Db/ReAN5woiJwLyZi
         llKC1wSBI43vqipGwabSj7kuh5vi59i2nWsFT7wnMLB/wU3KBRlEnC6dSpljSnBlygfC
         iScBAvNvkIpLWSaN1rhZX92ywvdBvlBDHk198FCszvAhd0tDS0SPOaW9Bnf0y7rX7+gG
         iGLSMj2tiBNHau39WqFJ5pi3qZNT4xTTMd+/pEo7KgNko9Pahm6j2Z6TDGE13NNAeeKg
         nyLP9DAjpnhwAqcWM1MxHVYLlk7dd9VI7faQRGf9O8YaCpRGalbS3Bjijf94RpaUuE7j
         trEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757518476; x=1758123276;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3vRPFcqil5SBFGWxr6KWfBmqpBpY6ibY3g+VscnfO/0=;
        b=soKtRJvJpSLsWgc60rjgVI2Z/SoOCpW5ZYHZUvJoQv+tw+5QgdC2MnMQeTme39/coV
         gH15+//QUkQh0zVAjRAytmroDqPIAoYw/3aBZeS3NixZbFV69JFj/7QJ8rRAhM1Qn50r
         iCcReg3sS6RRs8ZEH3Gg9Fs14YYxVCv78+c1gyX4Dlg/2bHoT+CSqwGl3bl6Ci9nYpkd
         eZdLZjnED8wKJ8vr/SNvbxA2cE9Bng+xKdHpuC3d5/J7YX0MkCnpiRANrzJYPvvzuru0
         oAOdV/g+mM6Y0u3GyV6EhOF9B9PuGFVtuWz5TBl/gAtVkyZisW0+nuDZwDEmqBEDdw+o
         Dz5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVpdyTZRUnF0pNGp5ROXErOiIHKOat/stNF2A5fooKx5jWZW4RUnGD+9e9NQfArPKMWasqqLxB8X2cC82c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEnAxm3EIf9SLQqAwYc7LCWyOf1oRHigdBhweLj5O4FkDDNOAr
	a51v+lm+IibRnrV0TGTAnGQaVSDJwCVlvZTfl3XM8QiRt5Dc424XGrqnW+JE5TSqbF0=
X-Gm-Gg: ASbGncvw4hpC1sh4DtwW+rnVCYdj7JAK7pHX+4BPJf7pJrwPIKaiAOrSy1TLIWbLQmD
	xsQ0o0Jb/AJ79Ut8fhj8xFN6o6bq4yoFSLoAXlLd+T8hPJi7wTptc/p6KDcByuY5SRrwTaBMD9I
	RWVwq2PgORU8xaXQiwRLqhHI9M3K6nfmtsQ6j3+UBVFu/XREnmd/QLCUUUxJGgO4GtD5KqnO2M8
	lNOt9fLBNrBTDdX14ka0PNkqcO6bNzIsiI5J0IK6ctG6e3yPp7g1CzMUrcoLLQKd8+6AaJZr+Ev
	yoSsQ+HmXB6JnCTqe93ZH+xk5GAdQ/JoYyAiTxL9M61bZBqCMXDA0fHn1LgVePcFb2l+GHrK2Jw
	MPameD2+0MxrmpIGhu/Y=
X-Google-Smtp-Source: AGHT+IGJKJyq5HyVv6wD5xuxx5W0imCUkzPCO88BUFyie8jzKeX7viqHcJaTTRewa4p6MBeNZQqKlA==
X-Received: by 2002:a05:6e02:19cd:b0:407:dc0b:7ba2 with SMTP id e9e14a558f8ab-407dc0b7d0cmr187128555ab.3.1757518475682;
        Wed, 10 Sep 2025 08:34:35 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50d8f0d56d2sm10695913173.30.2025.09.10.08.34.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 08:34:35 -0700 (PDT)
Message-ID: <9ca56545-8d58-412d-94ed-d875adc3976c@kernel.dk>
Date: Wed, 10 Sep 2025 09:34:33 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V4 00/36] rseq: Optimize exit to user space
To: Michael Jeanson <mjeanson@efficios.com>,
 Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
 <seanjc@google.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, x86@kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>
References: <20250908212737.353775467@linutronix.de>
 <4029c2d2-7a0c-4531-aa1e-b35be9098bb1@kernel.dk>
 <86b0eb6a-9a16-44f5-8ff0-5003624f107e@efficios.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <86b0eb6a-9a16-44f5-8ff0-5003624f107e@efficios.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/10/25 8:45 AM, Michael Jeanson wrote:
> On 2025-09-10 09:55, Jens Axboe wrote:
>> On 9/8/25 3:31 PM, Thomas Gleixner wrote:
>>> For your convenience all of it is also available as a conglomerate from
>>> git:
>>>
>>>      git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git rseq/perf
>>
>> I used this branch for some quick testing. Since I last looked at the
>> rseq performance overhead, glibc must have improved a few things. FWIW,
>> box is running libc 2.41 at the moment. Test box is on debian unstable,
>> so gets frequent updates. In any case, for one of my usual kernel
>> overhead runs of checking running a basic IOPS based test, I see the
>> following on the stock (-rc5 + 6.18 targeted changes) kernel running
>> that test:
>>
>> +    0.89%  io_uring  [kernel.kallsyms]  [k] __get_user_8
>> +    0.58%  io_uring  [kernel.kallsyms]  [k] __put_user_8
>> +    1.13%  io_uring  [kernel.kallsyms]  [k] __rseq_handle_notify_resume
>>
>> which is about 2.6% of purely rseq related overhead. Pulling in the
>> above branch and running the exact same test, all of the above are gone
>> and perusing the profile has nothing jump out at me in terms of shifting
>> those cycles to other bookkeeping.
>>
>> So yes, this work does make a very noticeable difference!
> 
> If you have time, could you also run the same test on this branch with glibc rseq registration disabled, just to see of there is some noticable differences.
> 
> To disable glibc automatic registration, just export this variable:
> 
>   GLIBC_TUNABLES="glibc.pthread.rseq=0"
> Thanks!

Running that same branch (-rc5 + pending stuff + tglx rseq changes)
doesn't show any noticeable differences in perf diff between having rseq
enabled or not via the above tunable. All I see are really minor
fluctuations between unrelated functions, as the run-to-run consistency
isn't entirely 0. But the trace doesn't have any signs of any
rseq/exit_to_usermode activity even with rseq enabled at this point.

-- 
Jens Axboe

