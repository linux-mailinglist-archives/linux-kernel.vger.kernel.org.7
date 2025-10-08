Return-Path: <linux-kernel+bounces-846038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46915BC6D6A
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 01:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7B97406B35
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 23:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CC52C11ED;
	Wed,  8 Oct 2025 23:11:03 +0000 (UTC)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA760199FB0
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 23:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759965062; cv=none; b=XL1+x+qM9JEIybqY0VxNir+VwiTY1Js7o4GFBtUqLeIMfPzaIIvt+yBvT+6HgTlMsfmv10AEUPvorurCXkgi9I0oZsBLPfqPyyJbzSDAFRc9D280pQFRjoehY6p3suVZzCoBWJbg4uIqJjjbDb3b7xk7DBJI02CfHOhOzLlMEOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759965062; c=relaxed/simple;
	bh=reMMTVk9GCgjLzWhC5u6ZW9yEjOlsH5unRf9z9L8ptk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=AutzLqoQtc468e/34CaUA67qR18yIPVexEYXky2NrRGnnq6NEGT3G2/2PbAQjfcRnyR22Uwz3cj0FZkLAosxZxs9qTjJCoA4qXSx/O4GlONq7Q8D9EW9WWWbtD/nQQilP+s/RvEMPgljFgGb3JhV4ugv6xFZQPgZYBZx/WGnDHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3307e8979f2so88571a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 16:10:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759965059; x=1760569859;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+f6ArVeWZd2reFq0nlx9DebYmTrmGwR2XKW8kYdyUtM=;
        b=XMcqPKta6X97dahLiiPM4Wi+lC8jSc2KiO9Oz7SNC8t4HxWM/t3IsQ94XT1FE3KyaK
         2rHSl5nrRhNEmnbaepanvIe/I79XnRBd31lmz1ay1yWOyLahrTRIRR4GMmli1b2GG7Tp
         buMNgNtoLANokR5HvE/FnYqTt7NNz2dd+dQxwF6oiDbBq/aQpzmh3HTDTUZCMIdmStZR
         CwmgHrIcmvhZW+bv8B/UhNxOuClA83qSz5rIMAf85+4+iPrbJELVPCtz8tck6gz81uni
         9I91MIRzU1EVmqW2GT/y5eA2WkJAam8eQezzi4tyx2bRt614Qmoyw10nlwOMO+s1ZVGT
         iDIw==
X-Forwarded-Encrypted: i=1; AJvYcCXtIn4WAIJuZVfh5xY3cxJBLuMId24y3oW1B9hSccJF01UkzFT8UMfBlgpWDIWvBB3JBg8PKPR9+3sPTeg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC8tomiFfOGtf8CZTPMYGdKWZMrHx8T01lKd0PzTdG3QowxDMC
	0ESjAC8Um+G1lxWP1iCSxeZv3tEfD3ld+hd8UNtvGWSbOziwUjQz3NEs
X-Gm-Gg: ASbGncs5Qb7ck0VGH+qQDZc/QKbCd+MO/rcqMdrYAEODj1XKjb4rmbj34jDgzENRZTH
	kkwU/Pa9aGCn3dn5ECLSft12S/rStJIhuDry08ufI3Vza8/DBlUUGOsHobjtyjZ626Fhq8bYrqk
	bknmVkSBLNG/alSaYuwEVmoWf/04kiX3SeETg2jmg8wRd9VCwC60J4Diw5Plk7dX8Y+iL9ilhHz
	O26A3P75E4WeRwrfaUzov0bvtOggfVBZmIXJx25x4dop6fr7JS2J/pOVppdVlbtTbj0gJW0IwHl
	lvPx60I2z6W3jCXoAeMZ/pw3YGssGVNIyZBw6a1FqFYzHC1jYBT6kC+J5kWfiOCO3woQxeABlCo
	OnhfqNH+RRrDwq8y7W9I410l+SN8lgexsVB5ob/t/MaWI40Mpju917e0/IkPiYShOa4+KdnVbEe
	bQD86xrUSQ0pCB7VNZYVpO0viXz9dBoIrXJTpFtIVryA==
X-Google-Smtp-Source: AGHT+IHYx7yW+JTJ5Vs8n0h3lqIBDwvHJUxcle/Y9dCGu8zkNMcwMzSHyFZOcfaJ/LG/hQU90oGRKA==
X-Received: by 2002:a17:90b:3889:b0:32b:dfd7:e42c with SMTP id 98e67ed59e1d1-33b5139575bmr3708891a91.5.1759965058889;
        Wed, 08 Oct 2025 16:10:58 -0700 (PDT)
Received: from [192.168.50.136] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b510ff99dsm4801947a91.6.2025.10.08.16.10.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 16:10:58 -0700 (PDT)
Message-ID: <2b8e3ca5-1645-489c-9d7f-dd13e5fc43ed@kzalloc.com>
Date: Thu, 9 Oct 2025 08:10:53 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: cpufeature: Don't cpu_enable_mte() when
 KASAN_GENERIC is active
From: Yunseong Kim <ysk@kzalloc.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
 James Morse <james.morse@arm.com>, Will Deacon <will@kernel.org>,
 Yeoreum Yun <yeoreum.yun@arm.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>, Marc Zyngier <maz@kernel.org>,
 Mark Brown <broonie@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 Ard Biesheuvel <ardb@kernel.org>, Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kasan-dev@googlegroups.com
References: <20251008210425.125021-3-ysk@kzalloc.com>
 <CA+fCnZcknrhCOskgLLcTn_-o5jSiQsFni7ihMWuc1Qsd-Pu7gg@mail.gmail.com>
 <d0fc7dd9-d921-4d82-9b70-bedca7056961@kzalloc.com>
Content-Language: en-US
Organization: kzalloc
In-Reply-To: <d0fc7dd9-d921-4d82-9b70-bedca7056961@kzalloc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

To summarize my situation, I thought the boot panic issue might be due
to incompatibility between MTE and KASAN Generic, so I sent this patch.

However, it seems that the problem is related to the call path involving
ZERO page. Also, I am curious how it works correctly in other machine.

On 10/9/25 7:28 AM, Yunseong Kim wrote:
> Hi Andrey,
> 
> On 10/9/25 6:36 AM, Andrey Konovalov wrote:
>> On Wed, Oct 8, 2025 at 11:13 PM Yunseong Kim <ysk@kzalloc.com> wrote:
>>> [...]
>> I do not understand this. Why is Generic KASAN incompatible with MTE?
> 
> My board wouldn't boot on the debian debug kernel, so I enabled
> earlycon=pl011,0x40d0000 and checked via the UART console.
> 
>> Running Generic KASAN in the kernel while having MTE enabled (and e.g.
>> used in userspace) seems like a valid combination.
> 
> Then it must be caused by something else. Thank you for letting me know.
> 
> It seems to be occurring in the call path as follows:
> 
> cpu_enable_mte()
>  -> try_page_mte_tagging(ZERO_PAGE(0))
>    -> VM_WARN_ON_ONCE(folio_test_hugetlb(page_folio(page)));
> 
>  https://elixir.bootlin.com/linux/v6.17/source/arch/arm64/include/asm/mte.h#L83

 -> page_folio(ZERO_PAGE(0))
  -> (struct folio *)_compound_head(ZERO_PAGE(0))

 https://elixir.bootlin.com/linux/v6.17/source/include/linux/page-flags.h#L307

>> The crash log above looks like a NULL-ptr-deref. On which line of code
>> does it happen?
> 
> Decoded stack trace here:
> 
> [    0.000000] Unable to handle kernel paging request at virtual address dfff800000000005
> [    0.000000] KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
> [    0.000000] Mem abort info:
> [    0.000000]   ESR = 0x0000000096000005
> [    0.000000]   EC = 0x25: DABT (current EL), IL = 32 bits
> [    0.000000]   SET = 0, FnV = 0
> [    0.000000]   EA = 0, S1PTW = 0
> [    0.000000]   FSC = 0x05: level 1 translation fault
> [    0.000000] Data abort info:
> [    0.000000]   ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
> [    0.000000]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> [    0.000000]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [    0.000000] [dfff800000000005] address between user and kernel address ranges
> [    0.000000] Internal error: Oops: 0000000096000005 [#1]  SMP
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.17+unreleased-debug-arm64 #1 PREEMPTLAZY  Debian 6.17-1~exp1
> [    0.000000] pstate: 800000c9 (Nzcv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    0.000000] pc : cpu_enable_mte (debian/build/build_arm64_none_debug-arm64/include/linux/page-flags.h:1065 (discriminator 1) debian/build/build_arm64_none_debug-arm64/arch/arm64/include/asm/mte.h:83 (discriminator 1) debian/build/build_arm64_none_debug-arm64/arch/arm64/kernel/cpufeature.c:2419 (discriminator 1))
> [    0.000000] lr : cpu_enable_mte (debian/build/build_arm64_none_debug-arm64/include/linux/page-flags.h:1065 (discriminator 1) debian/build/build_arm64_none_debug-arm64/arch/arm64/include/asm/mte.h:83 (discriminator 1) debian/build/build_arm64_none_debug-arm64/arch/arm64/kernel/cpufeature.c:2419 (discriminator 1))
> [    0.000000] sp : ffff800084f67d80
> [    0.000000] x29: ffff800084f67d80 x28: 0000000000000043 x27: 0000000000000001
> [    0.000000] x26: 0000000000000001 x25: ffff800084204008 x24: ffff800084203da8
> [    0.000000] x23: ffff800084204000 x22: ffff800084203000 x21: ffff8000865a8000
> [    0.000000] x20: fffffffffffffffe x19: fffffdffddaa6a00 x18: 0000000000000011
> [    0.000000] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> [    0.000000] x14: 0000000000000000 x13: 0000000000000001 x12: ffff700010a04829
> [    0.000000] x11: 1ffff00010a04828 x10: ffff700010a04828 x9 : dfff800000000000
> [    0.000000] x8 : ffff800085024143 x7 : 0000000000000001 x6 : ffff700010a04828
> [    0.000000] x5 : ffff800084f9d200 x4 : 0000000000000000 x3 : ffff8000800794ac
> [    0.000000] x2 : 0000000000000005 x1 : dfff800000000000 x0 : 000000000000002e
> [    0.000000] Call trace:
> [    0.000000]  cpu_enable_mte (debian/build/build_arm64_none_debug-arm64/√ (discriminator 1) debian/build/build_arm64_none_debug-arm64/arch/arm64/include/asm/mte.h:83 (discriminator 1) debian/build/build_arm64_none_debug-arm64/arch/arm64/kernel/cpufeature.c:2419 (discriminator 1)) (P)
> [    0.000000]  enable_cpu_capabilities (debian/build/build_arm64_none_debug-arm64/arch/arm64/kernel/cpufeature.c:3561 (discriminator 2))
> [    0.000000]  setup_boot_cpu_features (debian/build/build_arm64_none_debug-arm64/arch/arm64/kernel/cpufeature.c:3888 debian/build/build_arm64_none_debug-arm64/arch/arm64/kernel/cpufeature.c:3906)
> [    0.000000]  smp_prepare_boot_cpu (debian/build/build_arm64_none_debug-arm64/arch/arm64/kernel/smp.c:466)
> [    0.000000]  start_kernel (debian/build/build_arm64_none_debug-arm64/init/main.c:929)
> [    0.000000]  __primary_switched (debian/build/build_arm64_none_debug-arm64/arch/arm64/kernel/head.S:247)
> [    0.000000] Code: 9100c280 d2d00001 f2fbffe1 d343fc02 (38e16841)
> All code
> ========
>    0:	9100c280 	add	x0, x20, #0x30
>    4:	d2d00001 	mov	x1, #0x800000000000        	// #140737488355328
>    8:	f2fbffe1 	movk	x1, #0xdfff, lsl #48
>    c:	d343fc02 	lsr	x2, x0, #3
>   10:*	38e16841 	ldrsb	w1, [x2, x1]		<-- trapping instruction
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	38e16841 	ldrsb	w1, [x2, x1]
> [    0.000000] ---[ end trace 0000000000000000 ]---
> [    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
> [    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---
> 
> 
> If there are any other points you'd like me to check or directions, please
> let me know.
> 
> Thank you!
> 
> Yunseong

Best regards,
Yunseong


