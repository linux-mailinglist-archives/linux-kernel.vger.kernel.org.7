Return-Path: <linux-kernel+bounces-791077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2FC4B3B1C6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 05:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA24E1C8157A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 03:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCB61EF38F;
	Fri, 29 Aug 2025 03:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F3V8sedP"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809AA27735
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 03:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756439370; cv=none; b=XjeGXPGYwKEWxuajA+MeqT7BDB4fi8U51SYZvgsyBy1a7ZvDJwkyriBG7EnoInu3lObeRK1f0XASWIkYdrmc3WLyf3EsP+XFSUfs7q54l3ZtCtPbZy/K656GH8CO66spRVTtd3hoQPuMCTEeJozBP9cDQs6RUWFDg7FrYM1XBFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756439370; c=relaxed/simple;
	bh=aSofS38qLmvfoyW/AEdjRcQEDXxC06Tr24plMMsSI0g=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=V3Zw/A4gkgcV++VsX3TNU/bPaCbZW9si+95xLY/lYfvhuNi51TiyZEmvsDEspNyXtrPHVJ6JZWvJFQ+mFPzGGmunEvKmF0eA5VvvYftYtyyESFRh5dc91QCdqByeHxxBXK16ioA6IC2DX0/PY2bQdyGlxZSp63rfcJSvHCSBwRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F3V8sedP; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-771f90a45easo1461032b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 20:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756439366; x=1757044166; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0UERytwwDGGJ/h+dcwywEihpzTblVylFNdoqu7pJIrY=;
        b=F3V8sedPyZ6Q57r6fqkbB+iy4YGTTUe28Ru46RpE022tObXJGj2hsMYyYYRSxMeH5D
         HXds5UzPuHUKSHxuBf8+IM3rdIYhMxpEUj48/ZBC8tRp+Yhpo8MuDmgTmmIBkQLliYnh
         IrdT41dVZ5oOCKXc0PkzqUoc0U3QoZsuXz/Ma45kIG22ySkKJUx+kgtP84v9pJmyJX87
         PUwiwNKCDEgeIWt77+Kbbsg3441Nk2JLwdgw5sQWi7a+8S1beSs1BBa2aO7P1qcoUn4O
         fOTi30uhx0lv51rXxTu6rqjzQ4kTAdLuka/NsvjQSqL3AF/ur6OZ8p2e2s/TsG+qdo9w
         40Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756439366; x=1757044166;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0UERytwwDGGJ/h+dcwywEihpzTblVylFNdoqu7pJIrY=;
        b=v3uyEWHO9dJwiUyGpVgVrU3f8zCWPnOZiKmRBl6eLz+l1KQwsB88gUeJhA+yWKTmEg
         N4FmEElGChFeegiKp91rRFciz7KDuwLHykJ6dpeUOri+SeMRAdN1ZBlvWRn/DafXCkHW
         zPWcPaMBp5x1hwhSFlpX1acYi8vj53qx8S65xXDYOLmaiBJ8sOMuhSeE8WDzlBpEG1au
         SZQTK9Gbqa0SwQIhvCvdvM2RyjhMLrQm1L7E4EAoPAZbiVKEbSJNW88lyX9vv+89lXY9
         YS6OuBSASe2ln3cdBty8ckUhuL3nee1hxG2e6Fzn4oUxtflucfWe2ZdCxWz7gLBytBOU
         0dyA==
X-Forwarded-Encrypted: i=1; AJvYcCXBZmyJodC4Dg4Hj3boEavvP3pXFNjwh1PDE48Ol2kQF3X1/t2vur/2o1T6Gmka2saFa+ATLA7/tzkl0qw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTZnq5DwbR1sTJymrWshwddWdgwVwagfHcAZvyo2vcR0TZ++PP
	jaSuyhkjso5nq91sI3eVel0CtpVvtCTORCciH8UBtkDRKTwhStLrlLzJw4rXHw==
X-Gm-Gg: ASbGncsQo4/AZWxbrazBw62lrz9EF/NvJOcpRjtnJ5G8vS4IZku97ldg4aqK+59S8pc
	llxdgpCDp7Q5Tus0PmC+Lle/1LFTQgA3EotrWOiIOh0CIAz66D+GMPHqG7b3ki/i1ik5shoLux4
	s7FUHUJ6N6pOtdZEpcoaZSQVQ3IPgSuUsI2JjRdFNHmjHo9WvAnumpaald5ESqFj56/e1ur1fFr
	64GnyaytPeN5WIazIaWF+TYTV97cEJdhGl07j2uwEA/AwKml9c3EWWpc8vl/BptquQe9rnzUiQB
	SxrZcZjh/Ffc4FwagyxBPIobHPVPbRwThMOInqPBYN2MU4O30XwGwRItsvjjkJ1cR4E+vXMqok0
	ypcjL3+RRpDs2Dsa/odpyrKNDcw==
X-Google-Smtp-Source: AGHT+IEMAHHXLDxdG1bpNQzRYVh+4u2VlQ8X0kCscAvkN0YeF/j/ERa1DIFLlWFgSB3atG35kIT6rQ==
X-Received: by 2002:a05:6a20:2450:b0:243:b38b:eb94 with SMTP id adf61e73a8af0-243b38beeebmr6357860637.50.1756439366074;
        Thu, 28 Aug 2025 20:49:26 -0700 (PDT)
Received: from dw-tp ([171.76.86.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-327d932efd5sm1239497a91.5.2025.08.28.20.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 20:49:25 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC 3/3] arm64/ptdump: Add ARM64_PTDUMP_CONSOLE
In-Reply-To: <7302615c-e190-43ac-bc29-e82d7b048403@arm.com>
Date: Fri, 29 Aug 2025 09:12:08 +0530
Message-ID: <87zfbikd4f.fsf@gmail.com>
References: <20250818091436.938517-1-anshuman.khandual@arm.com> <20250818091436.938517-4-anshuman.khandual@arm.com> <87bjo2qe5w.fsf@gmail.com> <7302615c-e190-43ac-bc29-e82d7b048403@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Anshuman Khandual <anshuman.khandual@arm.com> writes:

> On 26/08/25 9:16 PM, Ritesh Harjani (IBM) wrote:
>> Anshuman Khandual <anshuman.khandual@arm.com> writes:
>> 
>>> Enable early kernel page table dump for debug purpose when required via new
>>> config ARM64_PDUMP_CONSOLE. This calls existing ptdump_walk() early on just
>>> after ptdump has been initialized with ptdump_init().
>> 
>> I happen to stumble upon this while looking for something else related
>> to ptdump and was curious to understand where this will be really
>> useful? 
>> 
>> So instead of dumping it via cat /sys/kernel/debug/kernel_page_tables,
>> this will dump at early boot during arch setup and before start_kernel().
>
> Right, primarily before vmalloc() space gets crowded. Also this provides
> an opportunity to do a diff between early boot and after boot kernel page
> table states.

Just want to understand this better - the diff here will mainly show the
new page table entries for the remaining layout which will get populated
in start_kernel() right? The existing mappings created during
setup_arch() won't get changed right?

>> 
>> I was curious, since this anyway gets enabled only in debug kernels.
>> There we can always just boot with minimal busybox image which can jump
>> to shell quickly and dump the kernel page tables, correct?
>
> Here the kernel page table dump could happen earlier than that as well.
>> 
>> Also is ARM64_PTDUMP_CONSOLE config option added on purpose? A kernel cmdline
>> like early_ptdump=yes|1|true could come much handy, right?
>
> Currently this is just for arm64 platform but could be enabled in general
> for other platforms as well. Yes, early_ptdump=yes|1|true will be useful
> as well. ARM64_PTDUMP_CONSOLE just build guards the additional code. But
> if required cmdline option "early_ptdump=" could just provide the runtime
> switch and then this could always be built enabled on CONFIG_PTDUMP.
>> 
>> (Since I am fixing few issues on powerpc ptdump - hence was just curious
>> to know whether this can come useful for me too or not :) )
>
> This feature could be extended in general to other platforms. Let me know
> if you find this useful for powerpc.

Sure - as of now I don't have a direct usecase. But let me try to do
an early page table dump by taking some inspiration from your patch to
see if this adds value for powerpc case or not.

Thanks for sharing the info.

-ritesh

>> 
>> Thanks!
>> -ritesh
>> 
>>>
>>> Suggested-by: Ryan Roberts <ryan.roberts@arm.com>
>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>> ---
>>>  arch/arm64/Kconfig.debug        | 12 ++++++++++++
>>>  arch/arm64/include/asm/ptdump.h |  7 +++++++
>>>  arch/arm64/kernel/setup.c       |  1 +
>>>  arch/arm64/mm/ptdump.c          |  7 +++++++
>>>  4 files changed, 27 insertions(+)
>>>
>>> diff --git a/arch/arm64/Kconfig.debug b/arch/arm64/Kconfig.debug
>>> index 265c4461031f..0f8af0dd0f4c 100644
>>> --- a/arch/arm64/Kconfig.debug
>>> +++ b/arch/arm64/Kconfig.debug
>>> @@ -20,4 +20,16 @@ config ARM64_RELOC_TEST
>>>  	depends on m
>>>  	tristate "Relocation testing module"
>>>  
>>> +config ARM64_PTDUMP_CONSOLE
>>> +	bool "Dump early kernel page table"
>>> +	depends on DEBUG_KERNEL
>>> +	depends on ARCH_HAS_PTDUMP
>>> +	select PTDUMP
>>> +	help
>>> +	  Enable this option to dump early kernel page table entries during
>>> +	  boot using the PTDUMP framework. This helps in examining kernel's
>>> +	  page table mapping entries and their attributes etc.
>>> +
>>> +	  If in doubt, say N.
>>> +
>>>  source "drivers/hwtracing/coresight/Kconfig"
>>> diff --git a/arch/arm64/include/asm/ptdump.h b/arch/arm64/include/asm/ptdump.h
>>> index 27e774134e7f..81dc53ca9643 100644
>>> --- a/arch/arm64/include/asm/ptdump.h
>>> +++ b/arch/arm64/include/asm/ptdump.h
>>> @@ -74,8 +74,15 @@ void __init ptdump_debugfs_register(struct ptdump_info *info, const char *name);
>>>  static inline void ptdump_debugfs_register(struct ptdump_info *info,
>>>  					   const char *name) { }
>>>  #endif /* CONFIG_PTDUMP_DEBUGFS */
>>> +
>>> +#ifdef CONFIG_ARM64_PTDUMP_CONSOLE
>>> +void __init arm64_kernel_pgtable_dump(void);
>>> +#else
>>> +static inline void __init arm64_kernel_pgtable_dump(void) { }
>>> +#endif /* CONFIG_ARM64_PTDUMP_CONSOLE */
>>>  #else
>>>  static inline void __init ptdump_init(void) { }
>>> +static inline void __init arm64_kernel_pgtable_dump(void) { }
>>>  static inline void note_page(struct ptdump_state *pt_st, unsigned long addr,
>>>  			     int level, pteval_t val) { }
>>>  static inline void note_page_pte(struct ptdump_state *st, unsigned long addr, pte_t pte) { }
>>> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
>>> index 0a3812c8e177..86bf7607d304 100644
>>> --- a/arch/arm64/kernel/setup.c
>>> +++ b/arch/arm64/kernel/setup.c
>>> @@ -361,6 +361,7 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
>>>  	init_bootcpu_ops();
>>>  	smp_init_cpus();
>>>  	smp_build_mpidr_hash();
>>> +	arm64_kernel_pgtable_dump();
>>>  
>>>  #ifdef CONFIG_ARM64_SW_TTBR0_PAN
>>>  	/*
>>> diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
>>> index c78e6b496dea..f6d22462add6 100644
>>> --- a/arch/arm64/mm/ptdump.c
>>> +++ b/arch/arm64/mm/ptdump.c
>>> @@ -407,6 +407,13 @@ void __init ptdump_init(void)
>>>  	ptdump_initialize();
>>>  }
>>>  
>>> +#ifdef CONFIG_ARM64_PTDUMP_CONSOLE
>>> +void __init arm64_kernel_pgtable_dump(void)
>>> +{
>>> +	ptdump_walk(CONSOLE, &kernel_ptdump_info);
>>> +}
>>> +#endif
>>> +
>>>  static int __init ptdump_debugfs_init(void)
>>>  {
>>>  	ptdump_debugfs_register(&kernel_ptdump_info, "kernel_page_tables");
>>> -- 
>>> 2.25.1

