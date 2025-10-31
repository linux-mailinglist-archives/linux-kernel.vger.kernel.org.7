Return-Path: <linux-kernel+bounces-879938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F760C24722
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A5151B24820
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0520F33EB01;
	Fri, 31 Oct 2025 10:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="O4XC4Fg8"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FED431197E
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761906183; cv=none; b=dC8LsP8kX4lnLg9EqsIMhPLx09h7SHNGhW+7tebjjjAuuXrmvjNapN/gmZk6gMygo2l/V//Ln+nPFZ67FVzz9t6gOgPRJjEoX9rr+Q2jEpQrY0eqNbCp+6Axng46ho2M5jzGasf+BaMCr1E/cCm8tYFd6R/nqt+Hn0q/CTX8bmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761906183; c=relaxed/simple;
	bh=x0APwdgJq2QNdYtTxizpNE+cPgYg7i0yrnCcPXpq4UE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tfPCh4GF+ypnn6MN7Dl9Oe3v1aZaHM/Q/UnPgzM5YYvjtp8tlbJVaO6sVw7NBl2es6Xx6r4EJBjRARUgo7Czf2Z3YOXoKp2l126bkaL/bcHLfLVVU+rXDlMYORquwpT1GioK3IygwSJ179SG7+lS/77OUvxe/xvQRiauzK4xqWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=O4XC4Fg8; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b5b823b4f3dso360317166b.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 03:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761906180; x=1762510980; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZdxuY3IVPNqf3Iy8yZi8Kt5lP5K/pAqirsL164MRDsY=;
        b=O4XC4Fg8zT3/JoGp4c2WpmfJLMXWqvHT+IF6JwqlawZ+byjZwQSC8Rb9odiDfdKG2Q
         sV5vGpVfTZm8EbGvjSn4UHmx4yOFNQvGEprZAAOZuDymYa+O9E5h7FsHILD9jUdlsjG2
         lytcYZGfosczcO/+DCBWFETipWp8WmLEXOI9HOByEyct2j0rKdklb2ls+2XEzkKJ4B3/
         TZLLROCz6vBZM5hmhY01qK/vGu933aeoVP9IoKu3t+o6WkcqvhCsQmpWazgswgd60yEj
         +fmoiAUvkamNWsl4iYI+lEJov6Ulz+W8HJBpbb1UK/5QH+pyGEgAtPxcWBNwE2gPnT59
         Wlaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761906180; x=1762510980;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZdxuY3IVPNqf3Iy8yZi8Kt5lP5K/pAqirsL164MRDsY=;
        b=nG3CAJaZp740PPr4YvXIUovjE/SOPnbYPC1fnWwBNGxhoFpGzguTH9rdFkukDFyWGA
         ymuwD4PMslbU1M+VwklH4+x3Y+3nY/pk05ncZqVa6/P38pudoOhPEya7/UF1WL92fStO
         rYoZ3se5nky8lGvbU3rGCLqXfQXar/ayuAAGeLpdjsLn3gTdJNN7J+3P/YFOWugkaB//
         UIQKAVnd8rw37GI0CyKwQbXwz0VkD7q13mN6EL5LBmY7q5UHfanQBlHrX/2BYfZCIL9d
         Xr5NhDc+6kcOcWi8W0JxEXGRsc4/u4NcXS4k1td6tx0c+lQ04UnPENqg2F2omKi1XRaJ
         BM9Q==
X-Forwarded-Encrypted: i=1; AJvYcCU2TJonG9nKbg1Et4XG2qheRPjjDibGBQdZIox1d3bwtWXSsxjLGV+HKQkXX4SLcxqPvMYHM5Fu6gbpWFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXjsiSHlGQU8D/os2d1DsUUQnJPp2HB8q5wvMKHir63RponKVz
	heguzdT78MdJo/fWcJ5H2qwlyrq4fn+eonOn6jZOxc7qEH5jY7pkbhdkiccLdIpW0WM=
X-Gm-Gg: ASbGncvUP/4hFsp60zj4NOZrlnnG2dxMdx5xr2YBzOojYyVPZJE0NMEu8dV8g5Cu8dM
	7gVxRxujGth4s/5AEgQkHwb+A1ijgb/UU2sRS+unAiFJf/9Oi3YaKw5/miIsAe9XuAa+IyCZBFa
	U4vMytThUd1BxtEKQRyqI11oAH2zlGPnDq+u2oUFV29awrG+MSeiMwj31z40YEgeAy+X0WPWxB2
	63l/Rzh0aCp8iPAvvFg4ZSDBxKRp5HyPfOGtXX0FxriSxNY/xtOL2l2z99vVIkGp/FzpktNSkqz
	bPbTuo/VVJ1bJ3wbDWr0dkf99sTN+n9a4v0Yq8X0QMnEf5ckmSnAnQFd8muZ+gn6f9XdzYL51v8
	C11bcKps6R9x1KtF3MwJdLLZDnYyL2RWoPBFRpSi1FtZa3G6kZlV1xnFu/0l7zS/yER6EFzoVlZ
	dVyj+3G5+Z/eniy6AxK8g6HiXZIu61oSC4as7K
X-Google-Smtp-Source: AGHT+IGirAaLDY1QFXSsi/RJca0COpl8mwKRnBoaKaOTKJoMPzZzH/753W/M9H0VwnFwikAvQwUopA==
X-Received: by 2002:a17:907:728c:b0:b6d:2f3f:3f98 with SMTP id a640c23a62f3a-b70704bc291mr280087466b.41.1761906179710;
        Fri, 31 Oct 2025 03:22:59 -0700 (PDT)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [109.121.139.92])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6407b438536sm1263013a12.26.2025.10.31.03.22.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 03:22:59 -0700 (PDT)
Message-ID: <d255d8a9-8e45-485e-9853-80c343bbb73b@suse.com>
Date: Fri, 31 Oct 2025 12:22:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 50/56] x86/alternative: Add re-patch support
To: David Kaplan <david.kaplan@amd.com>, Thomas Gleixner
 <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
 Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>
Cc: Alexander Graf <graf@amazon.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, linux-kernel@vger.kernel.org
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <20251013143444.3999-51-david.kaplan@amd.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 xsFNBGcrpvIBEAD5cAR5+qu30GnmPrK9veWX5RVzzbgtkk9C/EESHy9Yz0+HWgCVRoNyRQsZ
 7DW7vE1KhioDLXjDmeu8/0A8u5nFMqv6d1Gt1lb7XzSAYw7uSWXLPEjFBtz9+fBJJLgbYU7G
 OpTKy6gRr6GaItZze+r04PGWjeyVUuHZuncTO7B2huxcwIk9tFtRX21gVSOOC96HcxSVVA7X
 N/LLM2EOL7kg4/yDWEhAdLQDChswhmdpHkp5g6ytj9TM8bNlq9I41hl/3cBEeAkxtb/eS5YR
 88LBb/2FkcGnhxkGJPNB+4Siku7K8Mk2Y6elnkOctJcDvk29DajYbQnnW4nhfelZuLNupb1O
 M0912EvzOVI0dIVgR+xtosp66bYTOpX4Xb0fylED9kYGiuEAeoQZaDQ2eICDcHPiaLzh+6cc
 pkVTB0sXkWHUsPamtPum6/PgWLE9vGI5s+FaqBaqBYDKyvtJfLK4BdZng0Uc3ijycPs3bpbQ
 bOnK9LD8TYmYaeTenoNILQ7Ut54CCEXkP446skUMKrEo/HabvkykyWqWiIE/UlAYAx9+Ckho
 TT1d2QsmsAiYYWwjU8igXBecIbC0uRtF/cTfelNGrQwbICUT6kJjcOTpQDaVyIgRSlUMrlNZ
 XPVEQ6Zq3/aENA8ObhFxE5PLJPizJH6SC89BMKF3zg6SKx0qzQARAQABzSZOaWtvbGF5IEJv
 cmlzb3YgPG5pay5ib3Jpc292QHN1c2UuY29tPsLBkQQTAQoAOxYhBDuWB8EJLBUZCPjT3SRn
 XZEnyhfsBQJnK6byAhsDBQsJCAcCAiICBhUKCQgLAgQWAgMBAh4HAheAAAoJECRnXZEnyhfs
 XbIQAJxuUnelGdXbSbtovBNm+HF3LtT0XnZ0+DoR0DemUGuA1bZAlaOXGr5mvVbTgaoGUQIJ
 3Ejx3UBEG7ZSJcfJobB34w1qHEDO0pN9orGIFT9Bic3lqhawD2r85QMcWwjsZH5FhyRx7P2o
 DTuUClLMO95GuHYQngBF2rHHl8QMJPVKsR18w4IWAhALpEApxa3luyV7pAAqKllfCNt7tmed
 uKmclf/Sz6qoP75CvEtRbfAOqYgG1Uk9A62C51iAPe35neMre3WGLsdgyMj4/15jPYi+tOUX
 Tc7AAWgc95LXyPJo8069MOU73htZmgH4OYy+S7f+ArXD7h8lTLT1niff2bCPi6eiAQq6b5CJ
 Ka4/27IiZo8tm1XjLYmoBmaCovqx5y5Xt2koibIWG3ZGD2I+qRwZ0UohKRH6kKVHGcrmCv0J
 YO8yIprxgoYmA7gq21BpTqw3D4+8xujn/6LgndLKmGESM1FuY3ymXgj5983eqaxicKpT9iq8
 /a1j31tms4azR7+6Dt8H4SagfN6VbJ0luPzobrrNFxUgpjR4ZyQQ++G7oSRdwjfIh1wuCF6/
 mDUNcb6/kA0JS9otiC3omfht47yQnvod+MxFk1lTNUu3hePJUwg1vT1te3vO5oln8lkUo9BU
 knlYpQ7QA2rDEKs+YWqUstr4pDtHzwQ6mo0rqP+zzsFNBGcrpvIBEADGYTFkNVttZkt6e7yA
 LNkv3Q39zQCt8qe7qkPdlj3CqygVXfw+h7GlcT9fuc4kd7YxFys4/Wd9icj9ZatGMwffONmi
 LnUotIq2N7+xvc4Xu76wv+QJpiuGEfCDB+VdZOmOzUPlmMkcJc/EDSH4qGogIYRu72uweKEq
 VfBI43PZIGpGJ7TjS3THX5WVI2YNSmuwqxnQF/iVqDtD2N72ObkBwIf9GnrOgxEyJ/SQq2R0
 g7hd6IYk7SOKt1a8ZGCN6hXXKzmM6gHRC8fyWeTqJcK4BKSdX8PzEuYmAJjSfx4w6DoxdK5/
 9sVrNzaVgDHS0ThH/5kNkZ65KNR7K2nk45LT5Crjbg7w5/kKDY6/XiXDx7v/BOR/a+Ryo+lM
 MffN3XSnAex8cmIhNINl5Z8CAvDLUtItLcbDOv7hdXt6DSyb65CdyY8JwOt6CWno1tdjyDEG
 5ANwVPYY878IFkOJLRTJuUd5ltybaSWjKIwjYJfIXuoyzE7OL63856MC/Os8PcLfY7vYY2LB
 cvKH1qOcs+an86DWX17+dkcKD/YLrpzwvRMur5+kTgVfXcC0TAl39N4YtaCKM/3ugAaVS1Mw
 MrbyGnGqVMqlCpjnpYREzapSk8XxbO2kYRsZQd8J9ei98OSqgPf8xM7NCULd/xaZLJUydql1
 JdSREId2C15jut21aQARAQABwsF2BBgBCgAgFiEEO5YHwQksFRkI+NPdJGddkSfKF+wFAmcr
 pvICGwwACgkQJGddkSfKF+xuuxAA4F9iQc61wvAOAidktv4Rztn4QKy8TAyGN3M8zYf/A5Zx
 VcGgX4J4MhRUoPQNrzmVlrrtE2KILHxQZx5eQyPgixPXri42oG5ePEXZoLU5GFRYSPjjTYmP
 ypyTPN7uoWLfw4TxJqWCGRLsjnkwvyN3R4161Dty4Uhzqp1IkNhl3ifTDYEvbnmHaNvlvvna
 7+9jjEBDEFYDMuO/CA8UtoVQXjy5gtOhZZkEsptfwQYc+E9U99yxGofDul7xH41VdXGpIhUj
 4wjd3IbgaCiHxxj/M9eM99ybu5asvHyMo3EFPkyWxZsBlUN/riFXGspG4sT0cwOUhG2ZnExv
 XXhOGKs/y3VGhjZeCDWZ+0ZQHPCL3HUebLxW49wwLxvXU6sLNfYnTJxdqn58Aq4sBXW5Un0Q
 vfbd9VFV/bKFfvUscYk2UKPi9vgn1hY38IfmsnoS8b0uwDq75IBvup9pYFyNyPf5SutxhFfP
 JDjakbdjBoYDWVoaPbp5KAQ2VQRiR54lir/inyqGX+dwzPX/F4OHfB5RTiAFLJliCxniKFsM
 d8eHe88jWjm6/ilx4IlLl9/MdVUGjLpBi18X7ejLz3U2quYD8DBAGzCjy49wJ4Di4qQjblb2
 pTXoEyM2L6E604NbDu0VDvHg7EXh1WwmijEu28c/hEB6DwtzslLpBSsJV0s1/jE=
In-Reply-To: <20251013143444.3999-51-david.kaplan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/13/25 17:34, David Kaplan wrote:
> Updating alternatives is done under the biggest hammers possible.  The
> freezer is used to freeze all processes and kernel threads at safe
> points to ensure they are not in the middle of a sequence we're about to
> patch.  Then stop_machine_nmi() synchronizes all CPUs and puts them into
> a tight spin loop while re-patching occurs.  The actual patching is done
> using simple memcpy, just like during boot.
> 
> Signed-off-by: David Kaplan <david.kaplan@amd.com>
> ---
>   arch/x86/include/asm/alternative.h |   6 ++
>   arch/x86/kernel/alternative.c      | 131 +++++++++++++++++++++++++++++
>   2 files changed, 137 insertions(+)
> 
> diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
> index 61ce8a4b1aa6..f0b863292c3c 100644
> --- a/arch/x86/include/asm/alternative.h
> +++ b/arch/x86/include/asm/alternative.h
> @@ -19,6 +19,7 @@
>   #ifndef __ASSEMBLER__
>   
>   #include <linux/stddef.h>
> +#include <linux/static_call_types.h>
>   
>   /*
>    * Alternative inline assembly for SMP.
> @@ -89,6 +90,9 @@ extern s32 __cfi_sites[],	__cfi_sites_end[];
>   extern s32 __ibt_endbr_seal[],	__ibt_endbr_seal_end[];
>   extern s32 __smp_locks[],	__smp_locks_end[];
>   
> +extern struct static_call_site __start_static_call_sites[],
> +			       __stop_static_call_sites[];
> +
>   /*
>    * Debug flag that can be tested to see whether alternative
>    * instructions were patched in already:
> @@ -98,6 +102,8 @@ extern int alternatives_patched;
>   struct module;
>   
>   #ifdef CONFIG_DYNAMIC_MITIGATIONS
> +extern void cpu_update_alternatives(void);
> +extern void cpu_prepare_repatch_alternatives(void);
>   extern void reset_retpolines(s32 *start, s32 *end, struct module *mod);
>   extern void reset_returns(s32 *start, s32 *end, struct module *mod);
>   extern void reset_alternatives(struct alt_instr *start, struct alt_instr *end,
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index 23bb3386ec5e..613cb645bd9f 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -6,12 +6,15 @@
>   #include <linux/vmalloc.h>
>   #include <linux/memory.h>
>   #include <linux/execmem.h>
> +#include <linux/stop_machine.h>
> +#include <linux/freezer.h>
>   
>   #include <asm/text-patching.h>
>   #include <asm/insn.h>
>   #include <asm/ibt.h>
>   #include <asm/set_memory.h>
>   #include <asm/nmi.h>
> +#include <asm/bugs.h>
>   
>   int __read_mostly alternatives_patched;
>   
> @@ -3468,4 +3471,132 @@ void its_free_all(struct module *mod)
>   	its_page = NULL;
>   }
>   #endif
> +static atomic_t thread_ack;
> +
> +/*
> + * This function is called by ALL online CPUs but only CPU0 will do the
> + * re-patching.  It is important that all other cores spin in the tight loop
> + * below (and not in multi_cpu_stop) because they cannot safely do return
> + * instructions while returns are being patched.  Therefore, spin them here
> + * (with interrupts disabled) until CPU0 has finished its work.
> + */
> +static int __cpu_update_alternatives(void *__unused)
> +{
> +	if (smp_processor_id()) {
> +		atomic_dec(&thread_ack);
> +		while (!READ_ONCE(alternatives_patched))
> +			cpu_relax();
> +
> +		cpu_bugs_update_speculation_msrs();
> +	} else {
> +		repatch_in_progress = true;
> +
> +		/* Wait for all cores to enter this function. */
> +		while (atomic_read(&thread_ack))
> +			cpu_relax();
> +
> +		/* These must be un-done in the opposite order in which they were applied. */
> +		reset_alternatives(__alt_instructions, __alt_instructions_end, NULL);
> +		reset_builtin_callthunks();
> +		reset_returns(__return_sites, __return_sites_end, NULL);
> +		reset_retpolines(__retpoline_sites, __retpoline_sites_end, NULL);
> +
> +		apply_retpolines(__retpoline_sites, __retpoline_sites_end, NULL);
> +		apply_returns(__return_sites, __return_sites_end, NULL);

This triggers the following splat:

[  363.467469] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:575
[  363.467472] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 18, name: migration/0
[  363.467472] preempt_count: 110001, expected: 0
[  363.467473] RCU nest depth: 0, expected: 0
[  363.467474] no locks held by migration/0/18.
[  363.467474] irq event stamp: 1280
[  363.467475] hardirqs last  enabled at (1279): [<ffffffff91fd1444>] _raw_spin_unlock_irq+0x24/0x50
[  363.467479] hardirqs last disabled at (1280): [<ffffffff913c98f9>] multi_cpu_stop+0x119/0x170
[  363.467482] softirqs last  enabled at (0): [<ffffffff9129eaab>] copy_process+0x7fb/0x1990
[  363.467484] softirqs last disabled at (0): [<0000000000000000>] 0x0
[  363.467485] Preemption disabled at:
[  363.467486] [<ffffffff913c8e63>] cpu_stopper_thread+0x93/0x150
[  363.467488] CPU: 0 UID: 0 PID: 18 Comm: migration/0 Not tainted 6.18.0-rc1-default+ #9 PREEMPT(none)
[  363.467490] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  363.467491] Stopper: multi_cpu_stop+0x0/0x170 <- __stop_cpus.constprop.0+0x77/0xb0
[  363.467493] Call Trace:
[  363.467494]  <NMI>
[  363.467496]  dump_stack_lvl+0x62/0x90
[  363.467498]  __might_resched+0x19f/0x2b0
[  363.467501]  ? its_return_thunk+0x10/0x10
[  363.467503]  __mutex_lock+0x67/0x1060
[  363.467504]  ? look_up_lock_class+0x59/0x130
[  363.467506]  ? look_up_lock_class+0x59/0x130
[  363.467508]  ? __static_call_fixup+0x4f/0xa0
[  363.467510]  ? insn_get_prefixes+0x1a4/0x3f0
[  363.467512]  ? __SCT__tp_func_emulate_vsyscall+0x8/0x8
[  363.467513]  ? its_return_thunk+0x10/0x10
[  363.467514]  ? its_return_thunk+0x10/0x10
[  363.467516]  ? __static_call_fixup+0x4f/0xa0
[  363.467517]  __static_call_fixup+0x4f/0xa0
[  363.467518]  ? __SCT__tp_func_emulate_vsyscall+0x8/0x8
[  363.467519]  apply_returns+0x13e/0x370
[  363.467523]  ? __SCT__tp_func_emulate_vsyscall+0x8/0x8
[  363.467524]  ? __SCT__x86_pmu_disable_all+0x7/0x8
[  363.467525]  ? __SCT__x86_pmu_handle_irq+0x5/0x8
[  363.467527]  ? __copy_user_flushcache+0xf3/0x100
[  363.467528]  ? its_return_thunk+0x10/0x10
[  363.467529]  __cpu_update_alternatives+0x1e3/0x240
[  363.467531]  ? x2apic_send_IPI+0x40/0x60
[  363.467533]  stop_machine_nmi_handler+0x29/0x40
[  363.467534]  default_do_nmi+0x137/0x1a0
[  363.467536]  exc_nmi+0xef/0x120
[  363.467538]  end_repeat_nmi+0xf/0x53

[  363.467578] ================================
[  363.467578] WARNING: inconsistent lock state
[  363.467578] 6.18.0-rc1-default+ #9 Tainted: G        W
[  363.467579] --------------------------------
[  363.467579] inconsistent {INITIAL USE} -> {IN-NMI} usage.
[  363.467580] migration/0/18 [HC1[1]:SC0[0]:HE0:SE1] takes:
[  363.467581] ffffffff92668c28 (text_mutex){+.+.}-{4:4}, at: __static_call_fixup+0x4f/0xa0
[  363.467583] {INITIAL USE} state was registered at:
[  363.467584] irq event stamp: 1280
[  363.467584] hardirqs last  enabled at (1279): [<ffffffff91fd1444>] _raw_spin_unlock_irq+0x24/0x50
[  363.467586] hardirqs last disabled at (1280): [<ffffffff913c98f9>] multi_cpu_stop+0x119/0x170
[  363.467587] softirqs last  enabled at (0): [<ffffffff9129eaab>] copy_process+0x7fb/0x1990
[  363.467588] softirqs last disabled at (0): [<0000000000000000>] 0x0
[  363.467589]
                other info that might help us debug this:
[  363.467590]  Possible unsafe locking scenario:

[  363.467590]        CPU0
[  363.467590]        ----
[  363.467590]   lock(text_mutex);
[  363.467591]   <Interrupt>
[  363.467591]     lock(text_mutex);
[  363.467592]
                 *** DEADLOCK ***

[  363.467592] no locks held by migration/0/18.
[  363.467592]
                stack backtrace:
[  363.467593] CPU: 0 UID: 0 PID: 18 Comm: migration/0 Tainted: G        W           6.18.0-rc1-default+ #9 PREEMPT(none)
[  363.467594] Tainted: [W]=WARN
[  363.467595] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  363.467595] Stopper: multi_cpu_stop+0x0/0x170 <- __stop_cpus.constprop.0+0x77/0xb0
[  363.467597] Call Trace:
[  363.467598]  <NMI>
[  363.467598]  dump_stack_lvl+0x62/0x90
[  363.467600]  print_usage_bug.part.0+0x22c/0x2c0
[  363.467602]  lock_acquire+0x208/0x2d0
[  363.467604]  ? __static_call_fixup+0x4f/0xa0
[  363.467605]  ? its_return_thunk+0x10/0x10
[  363.467607]  __mutex_lock+0xb3/0x1060
[  363.467607]  ? __static_call_fixup+0x4f/0xa0
[  363.467608]  ? look_up_lock_class+0x59/0x130
[  363.467610]  ? look_up_lock_class+0x59/0x130
[  363.467611]  ? __static_call_fixup+0x4f/0xa0
[  363.467613]  ? insn_get_prefixes+0x1a4/0x3f0
[  363.467614]  ? __SCT__tp_func_emulate_vsyscall+0x8/0x8
[  363.467615]  ? its_return_thunk+0x10/0x10
[  363.467617]  ? its_return_thunk+0x10/0x10
[  363.467618]  ? __static_call_fixup+0x4f/0xa0
[  363.467619]  __static_call_fixup+0x4f/0xa0
[  363.467619]  ? __SCT__tp_func_emulate_vsyscall+0x8/0x8
[  363.467621]  apply_returns+0x13e/0x370
[  363.467624]  ? __SCT__tp_func_emulate_vsyscall+0x8/0x8
[  363.467625]  ? __SCT__x86_pmu_disable_all+0x7/0x8
[  363.467626]  ? __SCT__x86_pmu_handle_irq+0x5/0x8
[  363.467627]  ? __copy_user_flushcache+0xf3/0x100
[  363.467628]  ? its_return_thunk+0x10/0x10
[  363.467630]  __cpu_update_alternatives+0x1e3/0x240
[  363.467631]  ? x2apic_send_IPI+0x40/0x60
[  363.467633]  stop_machine_nmi_handler+0x29/0x40
[  363.467634]  default_do_nmi+0x137/0x1a0
[  363.467635]  exc_nmi+0xef/0x120
[  363.467637]  end_repeat_nmi+0xf/0x53


The reason being apply_returns->__static_call_fixup acquires text_mutex from NMI context.


<snip>



