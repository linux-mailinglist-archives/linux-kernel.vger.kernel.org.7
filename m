Return-Path: <linux-kernel+bounces-811176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A43B52549
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 03:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EDC6464FCC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 01:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3591DF252;
	Thu, 11 Sep 2025 01:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AlHfvm4/"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75474224D6
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 01:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757552530; cv=none; b=RCgZQMp6dFlothHLxf4uM0AKKeGhl5aXrUznVSIIK8tcldqM4XumYmZdqnUsrtiTTkuYhIrqk+y09RuFVvWvzU+lqiTqYOKmjHT25kWVPsz+mPA+EHxhVM03iJGnBInqaFgP1HoBS65y4K/TiYfyaH12uku55EK1FtqyOGW7Z9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757552530; c=relaxed/simple;
	bh=5VBENt6A2Kmu9jGrmuhcVeNNjnb+1k9AjSplBpQiApo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bW7bgpJlUJWQgL1U/myKqd1jcEOcN/akL1ECOiSwEdPAj9Z/4yhQPEtyo0ExaAUZyc9RPtdtMI13hWHMJeNMEkU3PTI6ejxjnuJX7eHXLYmjbXyyPLqNSx/vTWMFBM3+Kny+GtIHlbGA7Vw7zTXjQrm3FTSUfw6WWUNjZr+CSc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AlHfvm4/; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-77256e75eacso167634b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 18:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757552528; x=1758157328; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c6RyKxrXBphbUIxCwH62JzKN1u04ZKF0pThPVVL+cJk=;
        b=AlHfvm4/1BbBv6RsZr79XTSPdZvbg0wNCU+iGFXaCMrjkor1QovGUftbE6fYELjsTw
         Ff8PVTuMAleN+WofHSO2JIEzJ8PAb67lMpHTKgF1sEvAimcwr7glpfAYxUiTumDjxAuo
         nA4xqIj6hJifw1zBoYodfrTZgBN1VQirCl6Fsq8nCfkrvnSZ2fS4GilWT4LZNsvDPPXN
         NyO9gNBa7fyAyX9F0jQDCplThw8mWw7yFafloPGrWpoG8zTvWPHG4oNwAgjtYSJNwjFr
         IbOiPsyaJgZKTPvQo3UctjfU4Nq2Q80a94IjE8rtUQZ9LddITgasqvROxv7/EFoF96tD
         246Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757552528; x=1758157328;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c6RyKxrXBphbUIxCwH62JzKN1u04ZKF0pThPVVL+cJk=;
        b=WD7uRW5+B4M5oq+Wq0pIi+9/BDo0AFssl4hdjnO+FdvOAiu7qMyGDZGYfqXLIEz3WY
         JyBLm3IgaR/VVkK8Os16fzG3snTzPX7eaDsj5Q7j2gP42EGjpqmtordYAa6haSmbRkeH
         qEjmbJw08ecYdGANZh8j1qZjx+qeFATGH7ZJ+WrobdI9ID7qom/5Z/F/Tq0YiYQUzUt6
         0OW39xTZwV9HUxtwI8PbZCrkPcqZtp9p28RxDZY5y5r1hvytlzGzm1PeZ/dbSNuYBoor
         qTZjyoiz1B9zH/gknsjTiCqp9IVlhotJ/BnN23ajpX02Uhp8pkU0+qcbFmpjZNiEW2vO
         8n1w==
X-Forwarded-Encrypted: i=1; AJvYcCXw1kFu7alYmC/EGkF679kYNO3bh1GhkdNejrGxaSMo/fj4m3tLvfqF2ZNwo1wsj2KAlJNIMSID96a5sD8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpEnmZleaW0eXJykaIV+dmr1ilGJDQS6FtG/oPb6gZ41Ms/A+b
	s536l+5gBBt+NtExDcqz1x/zlhnMkGPcE7Wzksjvoaurde5CPwpCxZO1
X-Gm-Gg: ASbGncvOrZgrQGyxV8W0A6GN3YtzlVk6kLbBa4JN7uYjNZl8DR+l/JR9Rl3rTVYw6QU
	90BMHmap+PjDKapW3hSWPQxBe1ht+Mp7nfRxX7CP0DQt/E0xDsQiqKbTE9OKS+rrLkcws+UdunY
	rW5+gjBWn46vTZ8UK7xUg5rev4PwWrFpNrhfMjClU/iEfqBKT9ELuxgH9HOqBSB4TIO4Lc/ra1i
	dgwB+UO24vf9h6ZHkoFmZdjz10R5Xcxc58AHA13gxB4my+BOysX9lnLt2xI99buYypPvf1f/I+m
	pJkqe+z7jn0MADbd3lx3KeCXG0RRjlpxuiTcvDqOh+WikH1J4KWY9ypfRbSSPc/NSefhnmcRZv2
	Z5B5bwAHzGSgoQEyoz55OwWlc9hw=
X-Google-Smtp-Source: AGHT+IHWKYeBfZHFw5wp0lGo2/j/+43qoXRd/Q4Cw1fK4Uyl50WB09aLvc51pAjyyTCeRnBJqpSTow==
X-Received: by 2002:a05:6a00:4652:b0:772:5ba4:d75 with SMTP id d2e1a72fcca58-7742dd1270emr21626263b3a.4.1757552527499;
        Wed, 10 Sep 2025 18:02:07 -0700 (PDT)
Received: from [127.0.0.1] ([2a11:3:200::20f3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607b34254sm122807b3a.75.2025.09.10.18.01.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 18:02:06 -0700 (PDT)
Message-ID: <5ed43490-6894-4780-8faf-52d5f25bf3cc@gmail.com>
Date: Thu, 11 Sep 2025 09:01:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/19] x86/hw_breakpoint: introduce
 arch_reinstall_hw_breakpoint() for atomic context
Content-Language: en-US
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Mike Rapoport <rppt@kernel.org>,
 "Naveen N . Rao" <naveen@kernel.org>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Alexander Potapenko <glider@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, kasan-dev@googlegroups.com,
 "David S. Miller" <davem@davemloft.net>, Steven Rostedt
 <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250910052335.1151048-1-wangjinchao600@gmail.com>
 <20250910052335.1151048-2-wangjinchao600@gmail.com>
 <20250911094609.5f30e9767ffc3040068ed052@kernel.org>
From: Jinchao Wang <wangjinchao600@gmail.com>
In-Reply-To: <20250911094609.5f30e9767ffc3040068ed052@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/11/25 08:46, Masami Hiramatsu (Google) wrote:
> Hi Jinchao,
>
> On Wed, 10 Sep 2025 13:23:10 +0800
> Jinchao Wang <wangjinchao600@gmail.com> wrote:
>
>> Introduce arch_reinstall_hw_breakpoint() to update hardware breakpoint
>> parameters (address, length, type) without freeing and reallocating the
>> debug register slot.
>>
>> This allows atomic updates in contexts where memory allocation is not
>> permitted, such as kprobe handlers.
>>
>> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
>> ---
>>   arch/x86/include/asm/hw_breakpoint.h |  1 +
>>   arch/x86/kernel/hw_breakpoint.c      | 50 ++++++++++++++++++++++++++++
>>   2 files changed, 51 insertions(+)
>>
>> diff --git a/arch/x86/include/asm/hw_breakpoint.h b/arch/x86/include/asm/hw_breakpoint.h
>> index 0bc931cd0698..bb7c70ad22fe 100644
>> --- a/arch/x86/include/asm/hw_breakpoint.h
>> +++ b/arch/x86/include/asm/hw_breakpoint.h
>> @@ -59,6 +59,7 @@ extern int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
>>   
>>   
>>   int arch_install_hw_breakpoint(struct perf_event *bp);
>> +int arch_reinstall_hw_breakpoint(struct perf_event *bp);
>>   void arch_uninstall_hw_breakpoint(struct perf_event *bp);
>>   void hw_breakpoint_pmu_read(struct perf_event *bp);
>>   void hw_breakpoint_pmu_unthrottle(struct perf_event *bp);
>> diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
>> index b01644c949b2..89135229ed21 100644
>> --- a/arch/x86/kernel/hw_breakpoint.c
>> +++ b/arch/x86/kernel/hw_breakpoint.c
>> @@ -132,6 +132,56 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
>>   	return 0;
>>   }
>>   
>> +/*
>> + * Reinstall a hardware breakpoint on the current CPU.
>> + *
>> + * This function is used to re-establish a perf counter hardware breakpoint.
>> + * It finds the debug address register slot previously allocated for the
>> + * breakpoint and re-enables it by writing the address to the debug register
>> + * and setting the corresponding bits in the debug control register (DR7).
>> + *
>> + * It is expected that the breakpoint's event context lock is already held
>> + * and interrupts are disabled, ensuring atomicity and safety from other
>> + * event handlers.
>> + */
>> +int arch_reinstall_hw_breakpoint(struct perf_event *bp)
>> +{
>> +	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
>> +	unsigned long *dr7;
>> +	int i;
>> +
>> +	lockdep_assert_irqs_disabled();
>> +
>> +	for (i = 0; i < HBP_NUM; i++) {
>> +		struct perf_event **slot = this_cpu_ptr(&bp_per_reg[i]);
>> +
>> +		if (*slot == bp)
>> +			break;
>> +	}
>> +
>> +	if (WARN_ONCE(i == HBP_NUM, "Can't find a matching breakpoint slot"))
>> +		return -EINVAL;
>> +
>> +	set_debugreg(info->address, i);
>> +	__this_cpu_write(cpu_debugreg[i], info->address);
>> +
>> +	dr7 = this_cpu_ptr(&cpu_dr7);
>> +	*dr7 |= encode_dr7(i, info->len, info->type);
>> +
>> +	/*
>> +	 * Ensure we first write cpu_dr7 before we set the DR7 register.
>> +	 * This ensures an NMI never see cpu_dr7 0 when DR7 is not.
>> +	 */
>> +	barrier();
>> +
>> +	set_debugreg(*dr7, 7);
>> +	if (info->mask)
>> +		amd_set_dr_addr_mask(info->mask, i);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(arch_reinstall_hw_breakpoint);
> Please do not expose the arch dependent symbol. Instead, you should
> expose an arch independent wrapper.
>
> Anyway, you also need to share the same code with arch_install_hw_breakpoint()
> like below;
>
> Thanks,

You are right. The arch-dependent symbol has been removed and the code 
is shared

with arch_install_hw_breakpoint() in the next version of the patch.

https://lore.kernel.org/lkml/20250910093951.1330637-1-wangjinchao600@gmail.com


>
> diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
> index 89135229ed21..2f3c5406999e 100644
> --- a/arch/x86/kernel/hw_breakpoint.c
> +++ b/arch/x86/kernel/hw_breakpoint.c
> @@ -84,6 +84,28 @@ int decode_dr7(unsigned long dr7, int bpnum, unsigned *len, unsigned *type)
>   	return (dr7 >> (bpnum * DR_ENABLE_SIZE)) & 0x3;
>   }
>   
> +static void __arch_install_hw_breakpoint(struct perf_event *bp, int regno)
> +{
> +	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
> +	unsigned long *dr7;
> +
> +	set_debugreg(info->address, regno);
> +	__this_cpu_write(cpu_debugreg[i], info->address);
> +
> +	dr7 = this_cpu_ptr(&cpu_dr7);
> +	*dr7 |= encode_dr7(i, info->len, info->type);
> +
> +	/*
> +	 * Ensure we first write cpu_dr7 before we set the DR7 register.
> +	 * This ensures an NMI never see cpu_dr7 0 when DR7 is not.
> +	 */
> +	barrier();
> +
> +	set_debugreg(*dr7, 7);
> +	if (info->mask)
> +		amd_set_dr_addr_mask(info->mask, i);
> +}
> +
>   /*
>    * Install a perf counter breakpoint.
>    *
> @@ -95,8 +117,6 @@ int decode_dr7(unsigned long dr7, int bpnum, unsigned *len, unsigned *type)
>    */
>   int arch_install_hw_breakpoint(struct perf_event *bp)
>   {
> -	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
> -	unsigned long *dr7;
>   	int i;
>   
>   	lockdep_assert_irqs_disabled();
> @@ -113,22 +133,7 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
>   	if (WARN_ONCE(i == HBP_NUM, "Can't find any breakpoint slot"))
>   		return -EBUSY;
>   
> -	set_debugreg(info->address, i);
> -	__this_cpu_write(cpu_debugreg[i], info->address);
> -
> -	dr7 = this_cpu_ptr(&cpu_dr7);
> -	*dr7 |= encode_dr7(i, info->len, info->type);
> -
> -	/*
> -	 * Ensure we first write cpu_dr7 before we set the DR7 register.
> -	 * This ensures an NMI never see cpu_dr7 0 when DR7 is not.
> -	 */
> -	barrier();
> -
> -	set_debugreg(*dr7, 7);
> -	if (info->mask)
> -		amd_set_dr_addr_mask(info->mask, i);
> -
> +	__arch_install_hw_breakpoint(bp, i);
>   	return 0;
>   }
>   
> @@ -146,8 +151,6 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
>    */
>   int arch_reinstall_hw_breakpoint(struct perf_event *bp)
>   {
> -	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
> -	unsigned long *dr7;
>   	int i;
>   
>   	lockdep_assert_irqs_disabled();
> @@ -162,22 +165,7 @@ int arch_reinstall_hw_breakpoint(struct perf_event *bp)
>   	if (WARN_ONCE(i == HBP_NUM, "Can't find a matching breakpoint slot"))
>   		return -EINVAL;
>   
> -	set_debugreg(info->address, i);
> -	__this_cpu_write(cpu_debugreg[i], info->address);
> -
> -	dr7 = this_cpu_ptr(&cpu_dr7);
> -	*dr7 |= encode_dr7(i, info->len, info->type);
> -
> -	/*
> -	 * Ensure we first write cpu_dr7 before we set the DR7 register.
> -	 * This ensures an NMI never see cpu_dr7 0 when DR7 is not.
> -	 */
> -	barrier();
> -
> -	set_debugreg(*dr7, 7);
> -	if (info->mask)
> -		amd_set_dr_addr_mask(info->mask, i);
> -
> +	__arch_install_hw_breakpoint(bp, i);
>   	return 0;
>   }
>   EXPORT_SYMBOL_GPL(arch_reinstall_hw_breakpoint);
>
-- 
Thanks,
Jinchao


