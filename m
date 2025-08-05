Return-Path: <linux-kernel+bounces-756935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0DEB1BB33
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 21:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 383F2184E79
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 19:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36A6270551;
	Tue,  5 Aug 2025 19:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Odm4q/3W"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF5022CBD3
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 19:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754423680; cv=none; b=MdGuIocA84KIPQcCyPkpo/JG40sRGDQrIRoBvkqezuZTm7Xqxn01fuQz5cOlnsnoTYPPZ74v6wf9VoBpQ4wGMC3AWQU81OHgaVVd1/mvbwe72m3E5eL9jk1dXumrN1NMMrjjMS/DYbSiiOWGQO3eFECjjM3ZyPeUoRWGaHvqs4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754423680; c=relaxed/simple;
	bh=f47NBA1xQ05+tGqj8E2TiUwKpACiuW7lolj6ZcrUgRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PY5DL5GCZVVNFnnwn9lfNVGDPQBrgY286XtFGyQl/CuExledJZUoprUGp6Nt97uBM1f1jrU0s/oCahGGQC6p6hW2GaDILvPoSLRwHpwSST9PaFcVjymPH+nOGFMRfPOa4MK+mrDRS0Wf8S5X3+WLq/cguItaoPa7WzeBwfv2Ex0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Odm4q/3W; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b4209a0d426so6342123a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 12:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754423678; x=1755028478; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=PjrtWHVRsSWeqipGaCCShcBjkWxbAcWjrEUic7mEi4k=;
        b=Odm4q/3WhY+0FpphoVaAwoYU5JQsZWV3IwCNhcFLaRooI3oyR1p7hz36yrmRhdRuNa
         Bctqi6+lS7RO1AZrGt5FnXyVxjQHORDAyWNS7lYx2ZcNvw3qr5ji53b4a0/pNRY0DmCk
         hp3vSecJ0WFM+I74vJPG+Fs/ob9oIGb1PZWlaiTOUGKNBOTQK9sAfTNBHQgmoq2Ym04+
         Y5x39LKyYuqcP8K1Akz2BK+jJlotsAlb0mu5vabdW9VUA77l5fzTo8NC1+2hAtY5GwZr
         3wOPCmDBOqIXuHHo/72nEtw2XCNYtIg/cIMZc3Bv9kHKzsRzHa8W9r66KSpY7yB4mNFa
         Z7JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754423678; x=1755028478;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PjrtWHVRsSWeqipGaCCShcBjkWxbAcWjrEUic7mEi4k=;
        b=GK82qyLMBmKz+NTl/VgOBUP2SIO6jPzJKMG/J+h6O2Q1GzfMJd55rUQHcFt4rkb/o0
         lTbzQg6Z6PYQp/TvYqjw1mQsH3TifI8AZ6I8ZmirNRVXpMLPJ4gEex7gmWgZbIk8u3/b
         FilDEs6Oc3qlAV2a5iyS5hwGc2Z5Hjt/WEiPSvnzUT9avAwismoNJrewXHGWVZPF6u5Z
         TiLMkwB4MrZZkIMK092T+HSdh10pl8EJyITYNJzT06XIT95SG0vJsmS8WkdeVSQ62Mmd
         7xW1nUjUZhV3BKp6bQtOOkFOh7FN+rJtBtUMzskRUAKIgx7vhNvz09UKc+FaSw5MtYRp
         xTrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGxIodSp2z+pj4lZgpEHfLOdB9L2ViCnuxWSuEw/m91jafjAHMCUM5lNLf/DEOGt/B99DX0YCncsdYIuU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsgY3XQMNLdWOVndllrAfQShyhSnfFbPpipT5fNmIjobyakPok
	pdJ38gOS15TRuWWu0Qor3rTEuMVU+2RxvnYC+/jD+lB+Z/l/BIR8XgLcVUatsg==
X-Gm-Gg: ASbGncvCycAolw3j/F0ho9Z8H9SLq2cMCSlP2wIUd72SWUFXgxLXXk2A1gw5hIgMJiB
	wv9z0OyAcUv2YgF02tFRiyF2DtidblFFi1qu+0QS4O9YeGL7o+ltX6h5yH3jhMl+mareG5RORSF
	MPBZaMAwzXt+4jXqUcr3PFiQqHBmdCqMp0477JtGOqggOUq6ceH+7HMeI25KJaypH0uXAJWFiGf
	fBIhmw0dQRIpQFnGf6T2v5XUb6Rx6dn30KHb4HsuYA3ZnKHRk4nBrx83SK3pDwy8nvE38HsOfrF
	dALU9HC6zmBCVBavzZ0a+uVueoVyGq/Hl4vjhRi8jq4vIRRbqQi+mu8stJOTjB5N53E69FR4p+x
	X+lr0tvfzDX3y5/AQ21+py1ZAdWcdIRHY6tERaJrshrzczFyLkkgcAO5krhyCEoO9XVx9MX4=
X-Google-Smtp-Source: AGHT+IE7udqz4Z8P2+ay6Fs9O3TlMTfx95QIGhKGwNAnIdFC+HoQyX/YfLatr4F2cIhJ3GEVGHghBw==
X-Received: by 2002:a17:903:46c8:b0:234:d292:be7a with SMTP id d9443c01a7336-2429f2f52e8mr4814525ad.1.1754423678157;
        Tue, 05 Aug 2025 12:54:38 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef6bcfsm141757635ad.5.2025.08.05.12.54.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 12:54:37 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <d3ff0792-5811-40b5-ae98-e6d30281930b@roeck-us.net>
Date: Tue, 5 Aug 2025 12:54:36 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] genirq/test: Resolve irq lock inversion warnings
To: Brian Norris <briannorris@chromium.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Tsai Sung-Fu <danielsftsai@google.com>,
 Douglas Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org
References: <20250522210837.4135244-1-briannorris@chromium.org>
 <31a761e4-8f81-40cf-aaf5-d220ba11911c@roeck-us.net>
 <aJJONEIoIiTSDMqc@google.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <aJJONEIoIiTSDMqc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/5/25 11:32, Brian Norris wrote:
> irq_shutdown_and_deactivate() is normally called with the descriptor
> lock held, and interrupts disabled. Nested a few levels down, it grabs
> the global irq_resend_lock. Lockdep rightfully complains [1].
> 
> Grab the descriptor lock, and disable interrupts, to resolve the
> complaint.
> 
> Tested with:
> 
>    tools/testing/kunit/kunit.py run 'irq_test_cases*' \
>        --arch x86_64 --qemu_args '-smp 2' \
>        --kconfig_add CONFIG_DEBUG_KERNEL=y \
>        --kconfig_add CONFIG_PROVE_LOCKING=y \
>        --raw_output=all
> 
> [1]
> ========================================================
> WARNING: possible irq lock inversion dependency detected
> 6.16.0-11743-g6bcdbd62bd56 #2 Tainted: G                 N
> --------------------------------------------------------
> kunit_try_catch/40 just changed the state of lock:
> ffffffff898b1538 (irq_resend_lock){+...}-{2:2}, at: clear_irq_resend+0x14/0x70
> but this lock was taken by another, HARDIRQ-safe lock in the past:
>   (&irq_desc_lock_class){-.-.}-{2:2}
> 
> and interrupts could create inverse lock ordering between them.
> 
> other info that might help us debug this:
>   Possible interrupt unsafe locking scenario:
> 
>         CPU0                    CPU1
>         ----                    ----
>    lock(irq_resend_lock);
>                                 local_irq_disable();
>                                 lock(&irq_desc_lock_class);
>                                 lock(irq_resend_lock);
>    <Interrupt>
>      lock(&irq_desc_lock_class);
> 
> [...]
> 
>   ... key      at: [<ffffffff898b1538>] irq_resend_lock+0x18/0x60
>   ... acquired at:
>     __lock_acquire+0x82b/0x2620
>     lock_acquire+0xc7/0x2c0
>     _raw_spin_lock+0x2b/0x40
>     clear_irq_resend+0x14/0x70
>     irq_shutdown_and_deactivate+0x29/0x80
>     irq_shutdown_depth_test+0x1ce/0x600
>     kunit_try_run_case+0x90/0x120
>     kunit_generic_run_threadfn_adapter+0x1c/0x40
>     kthread+0xf3/0x200
>     ret_from_fork+0x140/0x1b0
>     ret_from_fork_asm+0x1a/0x30
> 
> [    5.766715]     ok 2 irq_free_disabled_test
> [    5.769030]
> [    5.769106] ========================================================
> [    5.769159] WARNING: possible irq lock inversion dependency detected
> [    5.769355] 6.16.0-11743-g6bcdbd62bd56 #1 Tainted: G                 N
> [    5.769413] --------------------------------------------------------
> [    5.769465] kunit_try_catch/122 just changed the state of lock:
> [    5.769532] ffffffffb81ace18 (irq_resend_lock){+...}-{2:2}, at: clear_irq_resend+0x14/0x70
> [    5.769899] but this lock was taken by another, HARDIRQ-safe lock in the past:
> [    5.769967]  (&irq_desc_lock_class){-.-.}-{2:2}
> [    5.769989]
> [    5.769989]
> [    5.769989] and interrupts could create inverse lock ordering between them.
> ...
> [    5.776956]  ret_from_fork_asm+0x1a/0x30
> [    5.776983]  </TASK>
> [    5.778916]     # irq_shutdown_depth_test: pass:1 fail:0 skip:0 total:1
> [    5.778953]     ok 3 irq_shutdown_depth_test
> 
> Fixes: 66067c3c8a1e ("genirq: Add kunit tests for depth counts")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Closes: https://lore.kernel.org/lkml/31a761e4-8f81-40cf-aaf5-d220ba11911c@roeck-us.net/
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Tested-by: Guenter Roeck <linux@roeck-us.net>

Thanks for the quick turnaround!

Guenter


