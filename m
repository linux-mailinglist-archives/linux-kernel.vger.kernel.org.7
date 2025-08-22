Return-Path: <linux-kernel+bounces-782575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A28AB3224C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 20:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFB921D61FF9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 18:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADDB28150F;
	Fri, 22 Aug 2025 18:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dG0JwvmE"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5218128EB
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 18:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755887649; cv=none; b=QaDgOYwYabZkgZ7E97a+gsQ5p6SMY9mzgCTofFznMi9zV9BmhKwWScVvlQy82ETrJ3BoBu/65QMW8gr3C4wae8Z5FVvHLOioM+mGvBC+yy9xq1fTwKF91vXOdKHM7ZFD+Fxe5glXgZTK06tY3yW/2MiTDO5E921olVHp647Ixfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755887649; c=relaxed/simple;
	bh=Px1A1rRlxAHOpUDObmiOI8UvsN5ZahEK5EhEdnVzqqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ofAloMZEdQCARXqB8HX0cpg8yDP0Lix6YYoJtjjW775Ats2asMPk3hpb+GrGn5wr3zmP27rit5Gr3r4QZaHRZbcw6/pe9M4qq+IIGOOB2QFdp2qLDY2T+y9r64JRCrdMCx7USpdvcKA3XLosVyLxpH9QZD9SahsU+lqgqixdhfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dG0JwvmE; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-76e2eb6d07bso2183959b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 11:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755887646; x=1756492446; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=HrFPlc+SabTcicmh9D3bxeGLicPpt2dGrkqv2bL1lPo=;
        b=dG0JwvmE5dml67JprOXCCBwDAD006CZKiDfdLKTuqYTzude7Dor+8l+xQcxq0f3jBP
         sbL06+CRp4TcU1n7U3KXgMvq6aYyzm6VUC6QW0F8DmuhWOM1M7CEaCYFLknCa6Vs3Xvy
         5P6YBO8CX2o1fp8/OLcSN6o3l5VhhYCE3NgqFmM+0XwXKMq95U+oa+Onzt1TNOrNh+T9
         97LknejGVKWgwp+akzbRw6V8P9JtuRiyzcPZpn0XtFeTlDiQfUnnnusGIGBNOuaDKhI2
         f43LvdxFHdY27nzIks59JjY8jyg/YAYP4SOtHSx4bJsEqKB9xkBH9Z232viDinLd8hBn
         9/Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755887646; x=1756492446;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HrFPlc+SabTcicmh9D3bxeGLicPpt2dGrkqv2bL1lPo=;
        b=c+9yqXy6jDQzdL/H/Z9KNe3WHhF+ap6EPiDGxk1j6okOlRPILlNa8vHLc+yLhK6ufR
         p7uOdit5PCdB2Tn8fA6BuCj/rd1gDtLgH8iMrPSuTDwCP/iZrNIJcEYJTE5DaPDbNuEn
         8aVntEJuLp/ycVt0+PO8no0c8j4aMyQ0DHab4VO0sJMELc3MLqvOAK3TU5e0dsBXBOF/
         PCZhhzQKU2uWccMuiHrvMBjALC7nBySftjzkOaXSuoEK4VnbbdC90KxIxTIm6cw7AHpK
         ottYLIyvDko7YSzFExbZn5WyfyHEKQf2O+g7vkWS2NiUUjyAsbPxgbM37yxoCEGZPVmm
         7gCA==
X-Forwarded-Encrypted: i=1; AJvYcCWn52oypklFYWylG6X5UH0IZAi0ARUFFkqXUyr3vWl5rd+3XmOEOUj9R+VR6OF0ujQYkDq9goKrXqstmuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEBYgBQkclRtl3eFE5P4K2lUif9auQC9+2bNY4UGLqwohh1TsX
	4UQXTqCjqfWABP+pekVK/SSg3v3BNpDmQ/9tplpXBFP4VClb8CY+cGbs
X-Gm-Gg: ASbGncueI7ZFwA5SypxXBTZVebZyjlvOzmGl28emgYtEI1iINfvmnV4c0FG5O7Cv2rW
	ClgzhaeOAugGHSPZTavnUOfok2LPk5Bghq51xH4DdKWZATTx8xb0WT5NPtpG+Wnl+nCewb0dYTe
	8QH8+/7fOWLl0zIJrLwCym4ha7oon9Pur8abmaeAGrAUintaLQKpQZAByCRB7PxDnA17rV3sXdm
	B+eB/rJBaQyxeU8FnBNYF/9r1sJRGd7bHcjKTC0L+SqGF67gwW+svb4lF0UKATuySWrioBgVDve
	yRA0nQ7qNJsEm8yowEfyEBD3mYZ9z1fCUjiRycforrk2Hf497XDO1W27u41mNpq/3lTdSz/+J4P
	Xmqdle0LX3Y0AFmmm2b8ZvRbL3s2xlmv19Kon8ZPxwn+JQK7D25Vxu7FRX6cQBKsr0Z8xU+0SbX
	fAbl6V5Q==
X-Google-Smtp-Source: AGHT+IHyhO1q7fGXGHHwxfOAlZk8GEnCxgLAWwhUqJP6x3jsOLcPSV6W/Ze1WKlvVLD1RPCrFqYQTQ==
X-Received: by 2002:a05:6a00:a02:b0:76e:987b:1dc with SMTP id d2e1a72fcca58-7702f9f5b6emr5781502b3a.12.1755887646415;
        Fri, 22 Aug 2025 11:34:06 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401ecc51sm532177b3a.75.2025.08.22.11.34.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Aug 2025 11:34:05 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <2143e074-c82f-4f38-84c7-6a39c6c6ecd3@roeck-us.net>
Date: Fri, 22 Aug 2025 11:34:04 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] genirq/test: Platform/architecture fixes
To: Brian Norris <briannorris@chromium.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, David Gow <davidgow@google.com>,
 linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com
References: <20250818192800.621408-1-briannorris@chromium.org>
 <9bfdbbed-52c1-4c5d-bdc3-963a902f2b4b@roeck-us.net>
 <aKduHcYINJvMsB58@google.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <aKduHcYINJvMsB58@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/21/25 12:06, Brian Norris wrote:
> On Thu, Aug 21, 2025 at 10:02:52AM -0700, Guenter Roeck wrote:
>> Build results:
>> 	total: 162 pass: 162 fail: 0
>> Qemu test results:
>> 	total: 637 pass: 637 fail: 0
>> Unit test results:
>> 	pass: 640616 fail: 13
>> Failed unit tests:
>> 	arm64:imx8mp-evk:irq_cpuhotplug_test
>> 	arm64:imx8mp-evk:irq_test_cases
>> 	m68k:q800:irq_test_cases
>> 	m68k:virt:irq_test_cases
>>
>> Individual failures:
>>
>> [   32.613761]     # irq_cpuhotplug_test: EXPECTATION FAILED at kernel/irq/irq_test.c:210
>> [   32.613761]     Expected remove_cpu(1) == 0, but
>> [   32.613761]         remove_cpu(1) == -16 (0xfffffffffffffff0)
>> [   32.621522]     # irq_cpuhotplug_test: EXPECTATION FAILED at kernel/irq/irq_test.c:212
>> [   32.621522]     Expected add_cpu(1) == 0, but
>> [   32.621522]         add_cpu(1) == 1 (0x1)
>> [   32.630930]     # irq_cpuhotplug_test: pass:0 fail:1 skip:0 total:1
> 
> I managed to get an imx8mp-evk setup running (both little and big
> endian) and couldn't reproduce. But I'm guessing based on the logs that
> we're racing with pci_call_probe(), which disables CPU hotplug
> (cpu_hotplug_disable()) for its duration.
> 
> I'm not sure how to handle that.
> 
> 1. I could just SKIP the test on EBUSY. But that'd make for flaky test
>     coverage.
> 2. Expose some method to block cpu_hotplug_disable() users temporarily.
> 3. Stop trying to do CPU hotplug in a unit test. (It's bordering on
>     "integration test"; but it's still useful IMO...)
> 4. Add an EBUSY retry loop? Or some other similar polling (if we had,
>     say, a cpu_hotplug_disabled() API).
> 

Here is an additional data point: It only happens with big endian tests.
This always happens in my setup, and it only happens when booting from
virtio-pci but not when booting from other devices.

I just re-ran the test and it passed this time, so this is apparently
a flake. I'd suggest to ignore it for now. If I see it again and find
a clean way to reproduce it we can have another look. The emulated PCIe
controller for imx8mp-evk isn't exactly stable, so this may just be a side
effect of emulation problems.

Guenter


