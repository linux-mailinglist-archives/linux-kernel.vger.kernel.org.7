Return-Path: <linux-kernel+bounces-771599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE030B28938
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 02:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F173E1CC247A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 00:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41F010957;
	Sat, 16 Aug 2025 00:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vf8CflML"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B9C38B
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 00:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755303869; cv=none; b=Fn+TgdSCDik3Ll2P5kaWgRAImOHQTsyxyIGRmttwf/ZxhjN9ZH4TXhMJjtNBxhK1CYkRoyBJ2aqXxi/zJ9LL/TkoDWmN753Jo9kaAVTBNbaXPay0Yy1+WqdDF7STqBtbdIDdue7jF6aoDzoq81qXYU84iJhV6LvBE53Il7vbIGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755303869; c=relaxed/simple;
	bh=YaHXC9UJe2kRkNDgTes5TCODfdy+PUCpeNCXcpCjRGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tu4u+jPESW+sDWjhk+Vd/2IqwEUNWKQX3BivjnIQ5pwpTXIGZr2aMUNKpHt2U4nK05dEzbOiMb2hnL5IBUv97eXZSyq9uuNS5k2971eALmzPFnPl+d62FDrsqt4nD6ECOyEV9HScazoTTq/etbh8vsGpItZ1yZsgSopJmK4agVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vf8CflML; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-76e2eb09041so2188611b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 17:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755303866; x=1755908666; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Hrdf0PH4nDjG8Z6fl/cCWOnZLeMF6CY5YBpf40ANKw0=;
        b=Vf8CflMLcH54us2bR5qFwJyGfBYuuJ9Ac4Fg0LDi9ERmjkBiN3R0j1DH8jiiiNeR8Y
         +F0AmH+Pi/yd+SDJz2Sv3s6v9MRUKbi3VqedGsmVKHbdMqUfYRyKoQ37pfi2pSkeJkXr
         02SAZbMQhJzvWX0FGTC6Jf79EdVOhnKBRYLrmRl9vVl3nMUkcrB4fbLgMechpvBSJ26+
         gNVTQ1aK6sNVocmKerMYI/SbX98CORKuJcJOoZdS12svvH1ESVfYVI6rI7Lwf1k2CxH1
         h9CpA7615LUi37L6X7oMYXu19Usl6FNPzUk8uBT/Gu3xknnbROvt9JcIb6sJvlXwiQyz
         tBZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755303866; x=1755908666;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hrdf0PH4nDjG8Z6fl/cCWOnZLeMF6CY5YBpf40ANKw0=;
        b=FrRPgLsvgSMdTX8GvFgjSweq2el8wRaxH9W8q4fjXQTB0wXz0va0hrmTF9eeUUUOw4
         qvFwrFMMIoTs3VkR3ZluZDDBtwrWQZMye57Ekq2Cwcrh16KCP15rkRIBQDDgQEDe3bxH
         4cHcMs87fDHThprP0FSvI02m8E1FsXVEhe2eeiPvJVMvisQzUTg4i0f1HdKyFeKqTbG9
         386YzsO4Z8S0R5xN605E1sgd+nXeCDp/Qe/YjRbRnaHtsfhZn58kGbDBmqX/Xd0Hax0T
         Z4zVF07dkUHsEir8t92lPSDAusy0H2HmRmxbc8NdpdULuydBvGRgzMWtwyuUwmWIqvhx
         AiCw==
X-Forwarded-Encrypted: i=1; AJvYcCWVveFG7zGKoodbcIGMSC3hgZoDcwKZZ9t38ZDEBHhYgJ06lzotIE/eix+23PNPqAUUPzBUdqJChNPofb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP/uK5Pt8NeeHDQc8AE3IiAxVILfylEm6/iSJCkHYJqX/vOavY
	ghHulw6BP1P3XNJcPe4oyW5EcKoYI8GmmCIq2s/BlyqCx3E67qpguFt9
X-Gm-Gg: ASbGnctqMHvFuRCmt0uJr2pd+vg5zJVndVftzTt4Vb9RVbvylU6x8vrf8Mj1NpOv8YG
	ToY9Xoipkb7cQCEgqH1d3fQwYl9qQGZH3wX5Q1wngn9Lteb136nlNSOAtnYw7HjCETOBSve0jRx
	6RMs4cDvHUoUuZQSAhDa04HTjNZZIDLM7GlZlaCUfCEPz7k24YEZ8WEsCcJkI8flDJV5OX+tvOn
	zB9YT74HQiTUBaMXT0cBKVemZIRRU7654fFju3vamT6vhuPeUhj38iqD/LKEQAL/rp/0SuN4O6x
	TJmoGVLa8J5B/kv4OPtydt9AH973yl+daV5dWNIBxBSAm5r7q1xXcKzoQltAYy0OMxIc9LoodPU
	GkaDydB17i3Erd5E5Rb/9MhWa/xhlVfKhpUtIj1kB51X0kiqIkxm10hF8pquvGlADCd37Ym4RYl
	8aFu3IYQ==
X-Google-Smtp-Source: AGHT+IHUOAVAQHz3idSYj5nys6cI/bHY5gZyfohGrwr8daOoE0VK7vof3uFEPeF4o7bw1uft+fXvaw==
X-Received: by 2002:a17:903:1c9:b0:240:6766:ac01 with SMTP id d9443c01a7336-2446d6f0386mr59160705ad.2.1755303866233;
        Fri, 15 Aug 2025 17:24:26 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446ca9eaa5sm23482675ad.2.2025.08.15.17.24.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Aug 2025 17:24:25 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <fc42ed34-e87d-4868-94bb-30554a3f6ec4@roeck-us.net>
Date: Fri, 15 Aug 2025 17:24:24 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] genirq: Add kunit tests for depth counts
To: Brian Norris <briannorris@chromium.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Tsai Sung-Fu <danielsftsai@google.com>,
 Douglas Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org
References: <20250522210837.4135244-1-briannorris@chromium.org>
 <ded44edf-eeb7-420c-b8a8-d6543b955e6e@roeck-us.net>
 <aJ91RRsMB-duD2yR@google.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <aJ91RRsMB-duD2yR@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/15/25 10:58, Brian Norris wrote:
> On Sun, Aug 10, 2025 at 12:37:31PM -0700, Guenter Roeck wrote:
>> The new code calls irq_domain_alloc_descs(), making it dependent
>> on IRQ_DOMAIN. However, specifying that dependency directly is not
>> possible:
>>
>>   config IRQ_KUNIT_TEST
>>          bool "KUnit tests for IRQ management APIs" if !KUNIT_ALL_TESTS
>>          depends on KUNIT=y
>> +       depends on IRQ_DOMAIN
>>          default KUNIT_ALL_TESTS
>>          imply SMP
>>          help
>>
>> results in:
>>
>> *** Default configuration is based on 'defconfig'
>> error: recursive dependency detected!
>> 	symbol SMP is implied by IRQ_KUNIT_TEST
>> 	symbol IRQ_KUNIT_TEST depends on IRQ_DOMAIN
>> 	symbol IRQ_DOMAIN is selected by IRQ_DOMAIN_HIERARCHY
>> 	symbol IRQ_DOMAIN_HIERARCHY is selected by GENERIC_IRQ_IPI
>> 	symbol GENERIC_IRQ_IPI depends on SMP
>>
>> This is seen with alpha configurations such as alpha:defconfig after
>> adding the IRQ_DOMAIN dependency.
>>
>> I have no idea how to resolve this. For now I disabled IRQ_KUNIT_TEST
>> for my alpha test builds.
> 
> How about 'select'? That's the usual way IRQ_DOMAIN is managed anyway.
> 
> It builds for me, but my distro doesn't provide an Alpha QEMU, so I
> can't test it.
> 

I can try, but the irq test code fails for me all over the place, so I am
not sure if it is worth it.

 From my current upstream test results (6.17-rc1):

Build results:
	total: 162 pass: 162 fail: 0
Qemu test results:
	total: 637 pass: 637 fail: 0
Unit test results:
	pass: 640017 fail: 649

The failures are all from the irq test code. I didn't have time to analyze it.
You can find details at https://kerneltests.org/builders in the "master" column
if you have time.

Note that "imply SMP" does not make SMP mandatory. I can still disable it after
enabling IRQ_KUNIT_TEST on x86. Frankly I don't really understand what "imply"
is supposed to be useful for.

Guenter

> --- a/kernel/irq/Kconfig
> +++ b/kernel/irq/Kconfig
> @@ -148,6 +148,7 @@ config IRQ_KUNIT_TEST
>   	bool "KUnit tests for IRQ management APIs" if !KUNIT_ALL_TESTS
>   	depends on KUNIT=y
>   	default KUNIT_ALL_TESTS
> +	select IRQ_DOMAIN
>   	imply SMP
>   	help
>   	  This option enables KUnit tests for the IRQ subsystem API. These are


