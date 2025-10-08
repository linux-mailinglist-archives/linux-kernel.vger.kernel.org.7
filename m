Return-Path: <linux-kernel+bounces-846019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF43BC6CBA
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 00:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E2DA3AE212
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 22:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB9E2C17B2;
	Wed,  8 Oct 2025 22:28:28 +0000 (UTC)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094582C17A0
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 22:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759962507; cv=none; b=D/5UVoOrNGzBIcf8KQsYVwU1QI2na9ogrzhZrC5J/CHySOTSuFweCz+Y/yQvay4a3HuTJ0hPko/NNqHDD6X5BwfRIlYlYpQ24SbJ6dJRhfPiuKUJVcZ3s9ik681Nzf4nQ0KZDL/kNJXOnZq9GnmTQXDWGitM7VK5rxfsIUgxbp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759962507; c=relaxed/simple;
	bh=cy6O3Pxt+g1sxlQ84A5B/3CkrY+2pljML5VEBIzZDjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BJ+E4Qv+OGnChQk587oqmf3/xJ32+W8tIfvdyzsx+kyWg70w7jEtsAdpNm+ionpzwuLv7xUJGxFHBjNzc31OD2lEQCDKEyh1mh+zWu3jOKEMNM9/9ikbsVwzNkHO6acWjrD7ophqPDc5LajUL8iv2teZnUK++jhPQ1iHLY0mbQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-339a0b9ed6cso52390a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 15:28:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759962505; x=1760567305;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m+FDQ7zQAPnlAXJ0xUMPhBN5Vu4l6pnGvG4mZcfsdHU=;
        b=B73/EeIVd+0z5CtrpuZGN8aLTKQ7zs7NjcHbLtrHiwz3R4ro63u2+1Pfgl0brR2GWs
         abyNcS8UCqhSOpt7E21PMkj77uA5OZ2UER7w62RSHW6MlmNcTFWaMDQI0+RW4OtxBI3o
         OYlswY1O+05K202071r9JJ1UP/Jboz9Vb9rESunLg8DAhUBVycrAIbkKUYRvdS8TUtLn
         5RUEiSHVFN2m3BKoezA37skU7A81qc1cu2P8L4hocB6jOjlqcjUKbdNd858yZ4tfK+z2
         ocfm8Q13T+wgBaUspi2NMTDp+k2543L82FlnujuMbxM8jwXxNToDBPQGQ4l6jwyEjuIZ
         eNKg==
X-Forwarded-Encrypted: i=1; AJvYcCXtoP8Yk/LWB5w3yVJJkQkbOK0Rx8fpG/XrrWS08efe+mPrOR32UHZ2B5NpML5N8ZMUqqPqY+Re8WNaN30=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXTbz6+xT/6vYxa9W6uRCU/osfzTe5paxYpAYYVwm3+2UafgOe
	abvlAR1+52G19EAB55ks4HcXu+6bzsCpRckRWjKdh8KKvoOUEe/1OVjR
X-Gm-Gg: ASbGncswy0N39g5YqZx6uT6kG6CnEC37HQv49nDE3NYTCeNRNhoqGHWBPsP0XDn2Gpi
	BAEVdESA6x7Ja0mBFvPb0nLQr5OFp9gvmPn1e6zmO3vmBlgcXLbOS7IIjQSiINL3qHUD/RdWa9w
	3HkmYrbgMWdUC4owGjmnQcn0qJ7QuWs6sP1hGhev/0Qsu7IvszH0fsWy5I1jGKgryq08Xe6menp
	SwYnM2p6pellVlSY2DwwyJ0dSWU57SzJ9NMhIAdfL6/86DVQRoCKQj0xxYstM5/4r7BMHzHsm1c
	difKa7IGwcPv7VDwWSwGQm7NWhNw5zxIDCb3JP3CXA0z/RUWaipG9W5r0/Aisf+LoUQcht7p/RF
	/Zp1olYLFRVg0Cs1TZjXWJ80GjdyHm1g+ppxaTcz2ANoyRUxRptG265+GKM0Wni6Zzt4QVaE20B
	Td9WTY03EmpSLJv6BlAh7+mbRTBnOjOJ8HdabJ9PeFbg==
X-Google-Smtp-Source: AGHT+IEdZv4j3V0V2ftmpYVdLCo1oL6MXTicZXNitpsrrWfaGVXXmpVpfjZcQG1gnntbQIiScsAVNQ==
X-Received: by 2002:a05:6a20:12c4:b0:2c1:b47d:bcde with SMTP id adf61e73a8af0-32da80da615mr3884733637.1.1759962505124;
        Wed, 08 Oct 2025 15:28:25 -0700 (PDT)
Received: from [192.168.50.136] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b62e3508744sm15811209a12.30.2025.10.08.15.28.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 15:28:24 -0700 (PDT)
Message-ID: <d0fc7dd9-d921-4d82-9b70-bedca7056961@kzalloc.com>
Date: Thu, 9 Oct 2025 07:28:19 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: cpufeature: Don't cpu_enable_mte() when
 KASAN_GENERIC is active
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 James Morse <james.morse@arm.com>, Yeoreum Yun <yeoreum.yun@arm.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, Marc Zyngier
 <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
 Oliver Upton <oliver.upton@linux.dev>, Ard Biesheuvel <ardb@kernel.org>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kasan-dev@googlegroups.com
References: <20251008210425.125021-3-ysk@kzalloc.com>
 <CA+fCnZcknrhCOskgLLcTn_-o5jSiQsFni7ihMWuc1Qsd-Pu7gg@mail.gmail.com>
Content-Language: en-US
From: Yunseong Kim <ysk@kzalloc.com>
Organization: kzalloc
In-Reply-To: <CA+fCnZcknrhCOskgLLcTn_-o5jSiQsFni7ihMWuc1Qsd-Pu7gg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Andrey,

On 10/9/25 6:36 AM, Andrey Konovalov wrote:
> On Wed, Oct 8, 2025 at 11:13 PM Yunseong Kim <ysk@kzalloc.com> wrote:
>> [...]
> I do not understand this. Why is Generic KASAN incompatible with MTE?

My board wouldn't boot on the debian debug kernel, so I enabled
earlycon=pl011,0x40d0000 and checked via the UART console.

> Running Generic KASAN in the kernel while having MTE enabled (and e.g.
> used in userspace) seems like a valid combination.

Then it must be caused by something else. Thank you for letting me know.

It seems to be occurring in the call path as follows:

cpu_enable_mte()
 -> try_page_mte_tagging(ZERO_PAGE(0))
   -> VM_WARN_ON_ONCE(folio_test_hugetlb(page_folio(page)));

 https://elixir.bootlin.com/linux/v6.17/source/arch/arm64/include/asm/mte.h#L83

> The crash log above looks like a NULL-ptr-deref. On which line of code
> does it happen?

Decoded stack trace here:

[    0.000000] Unable to handle kernel paging request at virtual address dfff800000000005
[    0.000000] KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
[    0.000000] Mem abort info:
[    0.000000]   ESR = 0x0000000096000005
[    0.000000]   EC = 0x25: DABT (current EL), IL = 32 bits
[    0.000000]   SET = 0, FnV = 0
[    0.000000]   EA = 0, S1PTW = 0
[    0.000000]   FSC = 0x05: level 1 translation fault
[    0.000000] Data abort info:
[    0.000000]   ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
[    0.000000]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[    0.000000]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[    0.000000] [dfff800000000005] address between user and kernel address ranges
[    0.000000] Internal error: Oops: 0000000096000005 [#1]  SMP
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.17+unreleased-debug-arm64 #1 PREEMPTLAZY  Debian 6.17-1~exp1
[    0.000000] pstate: 800000c9 (Nzcv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    0.000000] pc : cpu_enable_mte (debian/build/build_arm64_none_debug-arm64/include/linux/page-flags.h:1065 (discriminator 1) debian/build/build_arm64_none_debug-arm64/arch/arm64/include/asm/mte.h:83 (discriminator 1) debian/build/build_arm64_none_debug-arm64/arch/arm64/kernel/cpufeature.c:2419 (discriminator 1))
[    0.000000] lr : cpu_enable_mte (debian/build/build_arm64_none_debug-arm64/include/linux/page-flags.h:1065 (discriminator 1) debian/build/build_arm64_none_debug-arm64/arch/arm64/include/asm/mte.h:83 (discriminator 1) debian/build/build_arm64_none_debug-arm64/arch/arm64/kernel/cpufeature.c:2419 (discriminator 1))
[    0.000000] sp : ffff800084f67d80
[    0.000000] x29: ffff800084f67d80 x28: 0000000000000043 x27: 0000000000000001
[    0.000000] x26: 0000000000000001 x25: ffff800084204008 x24: ffff800084203da8
[    0.000000] x23: ffff800084204000 x22: ffff800084203000 x21: ffff8000865a8000
[    0.000000] x20: fffffffffffffffe x19: fffffdffddaa6a00 x18: 0000000000000011
[    0.000000] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
[    0.000000] x14: 0000000000000000 x13: 0000000000000001 x12: ffff700010a04829
[    0.000000] x11: 1ffff00010a04828 x10: ffff700010a04828 x9 : dfff800000000000
[    0.000000] x8 : ffff800085024143 x7 : 0000000000000001 x6 : ffff700010a04828
[    0.000000] x5 : ffff800084f9d200 x4 : 0000000000000000 x3 : ffff8000800794ac
[    0.000000] x2 : 0000000000000005 x1 : dfff800000000000 x0 : 000000000000002e
[    0.000000] Call trace:
[    0.000000]  cpu_enable_mte (debian/build/build_arm64_none_debug-arm64/√ (discriminator 1) debian/build/build_arm64_none_debug-arm64/arch/arm64/include/asm/mte.h:83 (discriminator 1) debian/build/build_arm64_none_debug-arm64/arch/arm64/kernel/cpufeature.c:2419 (discriminator 1)) (P)
[    0.000000]  enable_cpu_capabilities (debian/build/build_arm64_none_debug-arm64/arch/arm64/kernel/cpufeature.c:3561 (discriminator 2))
[    0.000000]  setup_boot_cpu_features (debian/build/build_arm64_none_debug-arm64/arch/arm64/kernel/cpufeature.c:3888 debian/build/build_arm64_none_debug-arm64/arch/arm64/kernel/cpufeature.c:3906)
[    0.000000]  smp_prepare_boot_cpu (debian/build/build_arm64_none_debug-arm64/arch/arm64/kernel/smp.c:466)
[    0.000000]  start_kernel (debian/build/build_arm64_none_debug-arm64/init/main.c:929)
[    0.000000]  __primary_switched (debian/build/build_arm64_none_debug-arm64/arch/arm64/kernel/head.S:247)
[    0.000000] Code: 9100c280 d2d00001 f2fbffe1 d343fc02 (38e16841)
All code
========
   0:	9100c280 	add	x0, x20, #0x30
   4:	d2d00001 	mov	x1, #0x800000000000        	// #140737488355328
   8:	f2fbffe1 	movk	x1, #0xdfff, lsl #48
   c:	d343fc02 	lsr	x2, x0, #3
  10:*	38e16841 	ldrsb	w1, [x2, x1]		<-- trapping instruction

Code starting with the faulting instruction
===========================================
   0:	38e16841 	ldrsb	w1, [x2, x1]
[    0.000000] ---[ end trace 0000000000000000 ]---
[    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
[    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---


If there are any other points you'd like me to check or directions, please
let me know.

Thank you!

Yunseong


