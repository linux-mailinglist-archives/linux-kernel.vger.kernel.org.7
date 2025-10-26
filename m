Return-Path: <linux-kernel+bounces-870648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18850C0B5A7
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 23:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C82913B82D2
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 22:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E4B1BC5C;
	Sun, 26 Oct 2025 22:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="09Wo3W1c"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C197A286430
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 22:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761517479; cv=none; b=omSyDGk9eYj9xQ8Z0mbCQCAtkF0SUk+f9vP17py4N/hQxSbRT0yfGC6kcJG1HFLyKfmm+bsp22SU4h15bLh5UerBj+BA4xFdJOTQq0h27A+x1qi374/orn8hCTwvC8ZXhuorDgQIxDOw+VlJHFF6nEsSyULf/ISZc7xTXa/5wng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761517479; c=relaxed/simple;
	bh=CHKTxrHhk3PuuNpYTpNqI9oVV+PX8sv5diWwcABc3Xc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FwuuC+X5zzt5zaaMXZQAT6lOJ4FQ0kZ9aOEEXQl75bpCupCvsULFTL2mQDMhjTuZ2Qy53LANoWg3Mna/8VNxY63z2Ud1SewlhiBuN5jV7IN+GWqLrYso+Y1cLcFdHRQLvRnnsNrgHesLm3Cv3fP64qLz6APg8dHzRya6GZfMnaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=09Wo3W1c; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-426d4f59cbcso3197047f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 15:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761517476; x=1762122276; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cHGZJ/FWhRHS3eTWCGRfR1qdcXyKkde8moMbVfyV3dM=;
        b=09Wo3W1c1MZLIZIsV52Qet5kYTX9Ljn8sIIkWQc6a6YHYkPlvvIFUISXZxhbVIGC4c
         AnsbHatNx/om1dczOXS5gN3amOrNl4f9Muy2bLyO11ryYBIKMY7ydEcDFEdNVFHfh8aQ
         adT+x6x5UrJ0pkn/zSOQXWSbd4n7KcS1Yf63FJOJg1swbXmkP1PbKoHoNfWLluajTQL5
         Ng0k5qYuvsBYaKV4BsaVbh+ZsA2HXqXzkyMtETFWJDVV7t8eXi61kRj3tBkLfdTCvrxK
         0htxjd95Dbua6Ad1mUugy6ZqJ7WyE0V1ezX9h6S/wW3+5Dd4lPbEWx9rQ4NRclVKoniX
         3bFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761517476; x=1762122276;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cHGZJ/FWhRHS3eTWCGRfR1qdcXyKkde8moMbVfyV3dM=;
        b=DlImfZtsyFWLd5VxGvdux8P4NCRaJOuiX6JhSKvNht7v9AgZNB7eRwF6UoElBX/Lch
         U49lEt+DTBOCAZtyQU1B8C0Glcgi2+iwRq6KKL8HCWPMn4XpbF32iM0ux7pRp7hw3vLp
         nc0KHkhic+UKMBbGlS3iq4HLGL4S6+wuvuu8WP6Pq6nGbU9iJyLZVY1jfJZi+z56BsTn
         RzHv8YxoPBiF2xFS3icco5VlCPtTkxylC/HQE+PAEfN3ydTVLsG5MEcOWwWfuZNSeljJ
         pCBdNQcwcU7pIZ0NK1NOLKqtZ3VPz5m75cloKmbb4ok35NABejQhUVxG4uwQfqsPEQ8P
         T0mw==
X-Forwarded-Encrypted: i=1; AJvYcCV3disGxNbOIhc5/ApqQN8Z4XVnL5Hl3N/UD/rXG63KOOqjg+X1DYhR7uZyUbODUFAMpAWpaUUo9d5Qd9s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj17guqu2m8obP5EZrOrhGe7b885+txnjjv+sKgIrDTBBsjHq0
	DMcUfcpz79z/jCeux0UhpcxUhUUqnGzSK/WOr3AYsBbX3kSKVi6OnNjsjboYcDWdJGUp5a6whoC
	OJb4zLnK4koKeZA==
X-Google-Smtp-Source: AGHT+IHj/c8LyqHGoW5GCJEuHvxHaDbxWQRZUdfupcgzlN6fiqnXJsRG2h1ZOkjY2++CsrtrHb/vSh2pHHLn6Q==
X-Received: from wmol4.prod.google.com ([2002:a05:600c:47c4:b0:475:decb:4c4d])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3541:b0:46e:5302:7751 with SMTP id 5b1f17b1804b1-475d24259d9mr78139875e9.9.1761517475888;
 Sun, 26 Oct 2025 15:24:35 -0700 (PDT)
Date: Sun, 26 Oct 2025 22:24:35 +0000
In-Reply-To: <20251025100642.GVaPyhMp4CEmsYW3xy@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250924-b4-asi-page-alloc-v1-0-2d861768041f@google.com>
 <20250924-b4-asi-page-alloc-v1-2-2d861768041f@google.com> <20251025100642.GVaPyhMp4CEmsYW3xy@fat_crate.local>
X-Mailer: aerc 0.21.0
Message-ID: <DDSLTWM2FL58.3MIDS5WUOEEZW@google.com>
Subject: Re: [PATCH 02/21] x86/mm/asi: add X86_FEATURE_ASI and asi=
From: Brendan Jackman <jackmanb@google.com>
To: Borislav Petkov <bp@alien8.de>, Brendan Jackman <jackmanb@google.com>
Cc: Andy Lutomirski <luto@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, <peterz@infradead.org>, 
	<dave.hansen@linux.intel.com>, <mingo@redhat.com>, <tglx@linutronix.de>, 
	<akpm@linux-foundation.org>, <david@redhat.com>, <derkling@google.com>, 
	<junaids@google.com>, <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, 
	<reijiw@google.com>, <rientjes@google.com>, <rppt@kernel.org>, 
	<vbabka@suse.cz>, <x86@kernel.org>, Yosry Ahmed <yosry.ahmed@linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Sat Oct 25, 2025 at 10:06 AM UTC, Borislav Petkov wrote:
> On Wed, Sep 24, 2025 at 02:59:37PM +0000, Brendan Jackman wrote:
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 6c42061ca20e581b5192b66c6f25aba38d4f8ff8..9b8330fc1fe31721af39b08b58b729ced78ba803 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -5324,6 +5324,14 @@
>>  
>>  			Not specifying this option is equivalent to pti=auto.
>>  
>> +	asi=		[X86-64] Control Address Space Isolation (ASI), a
>> +			technology for mitigating CPU vulnerabilities.
>
>> 			ASI is
>> +			not yet ready to provide security guarantees but can be
>> +			enabled for evaluation.
>
> Yeah, no need for such "temporary" statements in the help text since you're
> going to have to touch it again once it becomes a full-fledged feature.

Sure. Per Dave's feedback it is anyway gonna have to be merged in a
state where it already does something useful, so I guess this statement
will need to be updated regardless.

>> +			on   - unconditionally enable
>> +			off  - unconditionally disable
>
> "unconditionally" as opposed to some other setting which is conditional?

My assumption here is that eventually we'll end up with an "auto"
setting or something, where the big startup condiguration dance in
bugs.c decides whether to enable ASI based on your CPU/attack vector
controls/individual mitigation configs.

>> +
>>  	pty.legacy_count=
>>  			[KNL] Number of legacy pty's. Overwrites compiled-in
>>  			default number.
>> diff --git a/arch/x86/include/asm/asi.h b/arch/x86/include/asm/asi.h
>> index 53acdf22fe33efc6ccedbae52b262a904868459a..32a4c04c4be0f6f425c7cbcff4c58f1827a4b4c4 100644
>> --- a/arch/x86/include/asm/asi.h
>> +++ b/arch/x86/include/asm/asi.h
>> @@ -2,4 +2,14 @@
>>  #ifndef _ASM_X86_ASI_H
>>  #define _ASM_X86_ASI_H
>>  
>> +#include <asm/cpufeature.h>
>> +
>> +void asi_check_boottime_disable(void);
>> +
>> +/* Helper for generic code. Arch code just uses cpu_feature_enabled(). */
>> +static inline bool asi_enabled_static(void)
>
> "static" because? There will be a dynamic one too?

Actually... no, probably not - should drop this from the name, thanks.

(At some point I think I was worried about spamming the kernel image
with too many static branches, but this seems like a bridge to cross if
we ever actually come to it).

>> +{
>> +	return cpu_feature_enabled(X86_FEATURE_ASI);
>> +}
>> +
>>  #endif /* _ASM_X86_ASI_H */
>> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
>> index 4091a776e37aaed67ca93b0a0cd23cc25dbc33d4..3eee24a4cabf3b2131c34596236d8bc8eec05b3b 100644
>> --- a/arch/x86/include/asm/cpufeatures.h
>> +++ b/arch/x86/include/asm/cpufeatures.h
>> @@ -499,6 +499,7 @@
>>  #define X86_FEATURE_IBPB_EXIT_TO_USER	(21*32+14) /* Use IBPB on exit-to-userspace, see VMSCAPE bug */
>>  #define X86_FEATURE_ABMC		(21*32+15) /* Assignable Bandwidth Monitoring Counters */
>>  #define X86_FEATURE_MSR_IMM		(21*32+16) /* MSR immediate form instructions */
>> +#define X86_FEATURE_ASI			(21*32+17) /* Kernel Address Space Isolation */
>
> I think we really will need to show this in /proc/cpuinfo as it is a real, big
> feature which gets proper kernel glue vs some silly CPUID bit.
>
> IOW,
>
> #define X86_FEATURE_ASI			(21*32+17) /* "asi" Kernel Address Space Isolation */
> 						      ^^^^
>
> Not sure, though, when we should make it an ABI - perhaps once the whole pile
> has landed...

Hm yeah, I actually also thought I had some direct feedback from one of
the x86 maintainers saying not to expose it here. I can no longer find
that feedback on Lore so I think I must be misremembering, the flag
was already hidden back in [0].

[0] https://lore.kernel.org/linux-mm/20240712-asi-rfc-24-v1-5-144b319a40d8@google.com/

If that feedback indeed doesn't exist then personally I'd lean towards
exposing it right away, I don't see that much downside in terms of ABI,
since ASI kinda "doesn't do anything", from a SW point of view it's just
a very weird and complicated NOP. It's hard for me to see how userspace
could grow a functional dependency on this flag. Whereas for general
monitoring it's handy.

Still, there's definitely no hill I'd die on here.

>>  /*
>>   * BUG word(s)
>> diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
>> index 5b9908f13dcfd092897f3778ee56ea4d45bdb868..5ecbff70964f61a903ac96cec3736a7cec1221fd 100644
>> --- a/arch/x86/mm/Makefile
>> +++ b/arch/x86/mm/Makefile
>> @@ -52,6 +52,7 @@ obj-$(CONFIG_ACPI_NUMA)		+= srat.o
>>  obj-$(CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS)	+= pkeys.o
>>  obj-$(CONFIG_RANDOMIZE_MEMORY)			+= kaslr.o
>>  obj-$(CONFIG_MITIGATION_PAGE_TABLE_ISOLATION)	+= pti.o
>> +obj-$(CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION)	+= asi.o
>>  
>>  obj-$(CONFIG_X86_MEM_ENCRYPT)	+= mem_encrypt.o
>>  obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_amd.o
>> diff --git a/arch/x86/mm/asi.c b/arch/x86/mm/asi.c
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..8c907f3c84f43f66e412ecbfa99e67390d31a66f
>> --- /dev/null
>> +++ b/arch/x86/mm/asi.c
>> @@ -0,0 +1,28 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +#include <linux/asi.h>
>> +#include <linux/init.h>
>> +#include <linux/string.h>
>> +
>> +#include <asm/cmdline.h>
>> +#include <asm/cpufeature.h>
>> +
>> +void __init asi_check_boottime_disable(void)
>> +{
>> +	bool enabled = false;
>> +	char arg[4];
>> +	int ret;
>> +
>> +	ret = cmdline_find_option(boot_command_line, "asi", arg, sizeof(arg));
>> +	if (ret == 3 && !strncmp(arg, "off", 3)) {
>> +		enabled = false;
>> +		pr_info("ASI explicitly disabled by kernel cmdline.\n");
>> +	} else if (ret == 2 && !strncmp(arg, "on", 2)) {
>> +		enabled = true;
>> +		pr_info("ASI enabled.\n");
>
> I'm not sure about those pr_info()s. When it is disabled, you can clear
> X86_FEATURE_ASI so you won't see it in /proc/cpuinfo and then it is disabled.
> And the same when it is enabled.

Agreed, if we expose the CPU flag we don't need the printks.

>> +	} else if (ret) {
>> +		pr_err("Unknown asi= flag '%s', try 'off' or 'on'\n", arg);
>> +	}
>> +
>> +	if (enabled)
>> +		setup_force_cpu_cap(X86_FEATURE_ASI);
>> +}
>
> Not an early_param() ?

Oh this is just for consistency with pti_check_boottime_disable(). But,
I think that function actually exists because of init ordering issues
that aren't relevant here, so early_param() seems fine to me (or, if I
find some reason why it doesn't, work, I'll add a comment in v2 to
explain why we don't use it).

Thanks for taking a look :)


