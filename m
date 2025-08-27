Return-Path: <linux-kernel+bounces-788494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9AFB3854D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 16:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 646C2462815
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 14:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FF221767D;
	Wed, 27 Aug 2025 14:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPWSINux"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF8B21767A
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 14:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756305914; cv=none; b=b0PY48QsAxL8ySDQOTUeI5MN703Aj73DRuAsP+A5mIw2PEmEKZ9dn9X0bGipHuyIji00CON5Ze9qeGGTnxmve17wx/0j6wEQkGKIeVoUjn6tS/2iSHr2d6iL40rq4gJCfBXze9GI9PCTwkWogebkA1J6VD34Hvv/4bb3bmSmSIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756305914; c=relaxed/simple;
	bh=Hv6YZaZ21feASXN0Y7K7TnaduLNMdkV8PQ1IS9csDvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cdRrUDvml3fOl/RBcgGz0Qob8R3yeGqsCoWpID4DLw64qlyuP9FO5b4B+DFMlE3ZFi1OUwO+5Fi6LMBNFUibmZ8v7Jl1Flc7Zf/6vwdblS2toRcV3nYrA787NA5pOFYWoHCCXdTJtg6dWJiATLbouVSp0csNQo2dkdlwk+KOd14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TPWSINux; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-55f348d46e3so158281e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 07:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756305910; x=1756910710; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t5LAEH9vHi7cDSVxQmP6q8/GqdocT71rXV0Hwx9XnXM=;
        b=TPWSINuxgH4YTn/aNgPy6hjNCwC43BHZJYsHFd/PI16DomG6C65EU8Id55K3Vh2i5r
         rSCUXLcg+Yh0l2uT6oCcNLa7a41sElwI1529OxJ7GVaDWn2sHVz3u37AnL1ILV44imUW
         qF1VGask8nJN1m1LchnHwPSwEMBJUe8LeC+oZOgpotmA4AjPuuYlwLxa8FZ/WqpCLY4K
         pxHFz65l4lyiz7ThPy/dzNyZKhFmG9kXuwv2p3lmXBNXGRlPf7BdkNkYTEBAoRT37i72
         mdBtWaQIaVGqOXvFR3kLbr2uyRm/GekAnnVC7VdkFRMiXq9mjsOC5jD0EZSTMGd9cuEg
         E24Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756305910; x=1756910710;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t5LAEH9vHi7cDSVxQmP6q8/GqdocT71rXV0Hwx9XnXM=;
        b=Uo32YQ4+urQpQIeCDyUnn+5ACuEPIGgef2D56Dr9+T8gB57BiRbuKhZ/8VCzHuik0o
         sV89aD2x7rxF79YezO9mU44xX0f+gQ6MUBiPb7Sr37jsVUJKTRjhQitl8icHnNLWZiVV
         JfNVrcQJaGOhLR9VRRU/VSm0+MebxmwMS2Jhf1TDwMxX+j0kIIMQzOTI7juI0MNgI4Un
         kccfHSk8Ut+UxghIkmjSbjowK1rJUHASGkFQsRtP4xKhk8qjUm9UJUnhG1O0BLsi9Il/
         heF+Iihtnun5zjxEflbpnFVj1c4vddgswqxxNLimg5+jIdGalg1sAz60avohnWJDLxjH
         1dHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzF53cnzM1lLFJJawooVmLbdEGJa7em86hXkHv62ib+9qMAEgCFIeX2R42MfMqFAs+AMuBM4bKV5xFnW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlCTmt8U7m+USQJfnhdHActIWWx4Zf9S2VPyFxJIJpJN3TOD6R
	gF1ZwRCs8FRjUlXCYLaoK1HEZNkWn/ZiKdNlRkiox6uZt05FuhomwD/0
X-Gm-Gg: ASbGnctBv/ig6mHsivoWMOjhh+EQTPl1+rxiPjhVmm+soEHyBhTLaTriLUMNdiY8o9A
	HlaOW5nHWIgihHa1TtjxE26IB09RC/C/WK4cqC6bSZq7Rj6piek0PBkvjOj4tJzA7uh9ZjqH3aa
	96c/u6ImMnAfxovL78M5L01K5N47do0RTsxiPD3T14seVtP4LZ0jTJbsM61QlY3bBYilcMQ+Ee4
	tZh4BIOfhZrs0uj8uelis+OOXwwv/0uzfwJdacDnfa5RV7ZsNcXV5IHWnkw/Npr6spa7Rl8MDlw
	vXnRD6oIAdvVUdwSmCWTH/h+83tVCmxlErID/JSnhy8SQ7Hu2SZP/IO+Xtumf7FULzUUx3GJscT
	fK9rUoblcO6E9LLCL7AL5o8g31nPRxTiZGE6vUwI=
X-Google-Smtp-Source: AGHT+IFlh1NaHlH+2xlwnY7Qi+fAlBWEVAk4XZOx1L6NVmE3uvh7e0HE7DjJr/IlSfm82zsDaf0oCw==
X-Received: by 2002:a05:6512:e9c:b0:55f:4bf6:eff7 with SMTP id 2adb3069b0e04-55f4bf6f57bmr1227624e87.6.1756305909663;
        Wed, 27 Aug 2025 07:45:09 -0700 (PDT)
Received: from [10.214.35.248] ([80.93.240.68])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f35c20123sm2856350e87.68.2025.08.27.07.45.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 07:45:09 -0700 (PDT)
Message-ID: <1cd29a46-3c17-42ca-af41-ed0a645b29c3@gmail.com>
Date: Wed, 27 Aug 2025 16:45:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] x86: Prevent KASAN false positive warnings in
 __show_regs()
To: Tengda Wu <wutengda@huaweicloud.com>, x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Alexander Potapenko <glider@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, Dmitry Vyukov
 <dvyukov@google.com>, Ingo Molnar <mingo@redhat.com>,
 linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>
References: <20250818130715.2904264-1-wutengda@huaweicloud.com>
Content-Language: en-US
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <20250818130715.2904264-1-wutengda@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/18/25 3:07 PM, Tengda Wu wrote:
> When process A accesses process B's `regs` from stack memory through
> __show_regs(), the stack of process B keeps changing during runtime.
> This causes false positives like "stack out-of-bounds" [1] or
> "out-of-bounds" [2] warnings when reading `regs` contents.
> 
> Add __no_sanitize_address attribute to __show_regs() to suppress these
> false positives while maintaining the ability to debug register states
> across processes.
> 
> [1] https://lore.kernel.org/all/000000000000cb8e3a05c4ed84bb@google.com/
> [2] A similar KASAN report:
> [332706.552324] BUG: KASAN: out-of-bounds in __show_regs+0x4b/0x340
> [332706.552433] Read of size 8 at addr ffff88d24999fb20 by task sysrq_t_test.sh/3977032
> [332706.552562]
> [332706.552652] CPU: 36 PID: 3977032 Comm: sysrq_t_test.sh Kdump: loaded Not tainted 6.6.0+ #20
> [332706.552783] Hardware name: Huawei RH2288H V3/BC11HGSA0, BIOS 3.35 10/20/2016
> [332706.552906] Call Trace:
> [332706.552998]  <TASK>
> [332706.553089]  dump_stack_lvl+0x32/0x50
> [332706.553193]  print_address_description.constprop.0+0x6b/0x3d0
> [332706.553303]  print_report+0xbe/0x280
> [332706.553409]  ? __virt_addr_valid+0xed/0x160
> [332706.553512]  ? __show_regs+0x4b/0x340
> [332706.553612]  kasan_report+0xa8/0xe0
> [332706.553716]  ? __show_regs+0x4b/0x340
> [332706.553816]  ? asm_exc_page_fault+0x22/0x30
> [332706.553919]  __show_regs+0x4b/0x340
> [332706.554021]  ? asm_exc_page_fault+0x22/0x30
> [332706.554123]  show_trace_log_lvl+0x274/0x3b0
> [332706.554229]  ? load_elf_binary+0xf6e/0x1610
> [332706.554330]  ? rep_stos_alternative+0x40/0x80
> [332706.554439]  sched_show_task+0x211/0x290
> [332706.554544]  ? __pfx_sched_show_task+0x10/0x10
> [332706.554648]  ? _find_next_bit+0x6/0xc0
> [332706.554749]  ? _find_next_bit+0x37/0xc0
> [332706.554852]  show_state_filter+0x72/0x130
> [332706.554956]  sysrq_handle_showstate+0x7/0x10
> [332706.555062]  __handle_sysrq+0x146/0x2d0
> [332706.555165]  write_sysrq_trigger+0x2f/0x50
> [332706.555270]  proc_reg_write+0xdd/0x140
> [332706.555372]  vfs_write+0x1ff/0x5f0
> [332706.555474]  ? __pfx_vfs_write+0x10/0x10
> [332706.555576]  ? __pfx___handle_mm_fault+0x10/0x10
> [332706.555682]  ? __fget_light+0x99/0xf0
> [332706.555785]  ksys_write+0xb8/0x150
> [332706.555887]  ? __pfx_ksys_write+0x10/0x10
> [332706.555989]  ? ktime_get_coarse_real_ts64+0x4e/0x70
> [332706.556094]  do_syscall_64+0x55/0x100
> [332706.556196]  entry_SYSCALL_64_after_hwframe+0x78/0xe2
> 
> Fixes: 3b3fa11bc700 ("x86/dumpstack: Print any pt_regs found on the stack")
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
> ---
>  arch/x86/include/asm/kdebug.h | 2 +-
>  arch/x86/kernel/process_32.c  | 1 +
>  arch/x86/kernel/process_64.c  | 1 +
>  3 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/kdebug.h b/arch/x86/include/asm/kdebug.h
> index d1514e70477b..2e0570d75bbc 100644
> --- a/arch/x86/include/asm/kdebug.h
> +++ b/arch/x86/include/asm/kdebug.h
> @@ -36,7 +36,7 @@ extern void die(const char *, struct pt_regs *,long);
>  void die_addr(const char *str, struct pt_regs *regs, long err, long gp_addr);
>  extern int __must_check __die(const char *, struct pt_regs *, long);
>  extern void show_stack_regs(struct pt_regs *regs);
> -extern void __show_regs(struct pt_regs *regs, enum show_regs_mode,
> +extern void __no_sanitize_address __show_regs(struct pt_regs *regs, enum show_regs_mode,
>  			const char *log_lvl);
>  extern void show_iret_regs(struct pt_regs *regs, const char *log_lvl);
>  extern unsigned long oops_begin(void);
> diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
> index 3ef15c2f152f..1b7ed4dee18b 100644
> --- a/arch/x86/kernel/process_32.c
> +++ b/arch/x86/kernel/process_32.c
> @@ -56,6 +56,7 @@
>  
>  #include "process.h"
>  
> +__no_sanitize_address
>  void __show_regs(struct pt_regs *regs, enum show_regs_mode mode,
>  		 const char *log_lvl)
>  {
> diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
> index 52a5c03c353c..921c96154ce3 100644
> --- a/arch/x86/kernel/process_64.c
> +++ b/arch/x86/kernel/process_64.c
> @@ -66,6 +66,7 @@
>  #include "process.h"
>  
>  /* Prints also some state that isn't saved in the pt_regs */
> +__no_sanitize_address
>  void __show_regs(struct pt_regs *regs, enum show_regs_mode mode,
>  		 const char *log_lvl)
>  {


__no_sanitize_address affects only __show_regs() function.
But the `regs` are passed down in show_iret_regs()->show_ip()->show_opcodes()
and all these also accesses `regs`

I see several options here:

1. Use kasan_disable_current()/kasan_enable_current() to wrap code accessing `regs`.
And maybe something like:
         if (!on_current_stack(regs))
                 kasan_disable_current();

so we skip kasan reports only if `regs` belong to other task.

2. Sprinkle over __no_sanitize_address all functions accessing `regs`.
But this disable all memory access checks all the time in these functions.

3. Use READ_ONCE_NOCHECK() to read regs->

4. Introduce memcpy_no_sanitize_address(), and use it to copy snapshot of `regs`
somewhere (on the stack of current task ?). But pt_regs is 168 bytes, I'm not sure if this
is acceptable stack usage increment.

