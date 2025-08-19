Return-Path: <linux-kernel+bounces-775870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CE5B2C5F3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90997520C4A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B4D33EAFA;
	Tue, 19 Aug 2025 13:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PxRmAgGY"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43F82EB853
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 13:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755610752; cv=none; b=oBI8Mrkmy/5aFtAuGV27AC5WJ5+1HTRxyrhHhl8FJgvTXMGWMMueEUs/Bl/ADa4oIxali4B0DhgSxLIcLW0ccPNQ41NX/kL//+YlJRL6SLbgRld8AFtgfw/BpCSG3DhUG0ek6W2fnuyvjvUCC6yzMoU3uBGLUfYw92LK+f7VbVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755610752; c=relaxed/simple;
	bh=LTIwfz+7ZLiUBkdM0n+yvwk0UNAWmFYk9FAr8uWbKkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sqZUxhqaJe94EXMP8uHK2K5x2YcUdzIXJn8Cz9+IK+t12P8rPPawWUvH9qP1Wr2pemhFbABE0X71H0j74gVlefZRtNebt4u8WNi7UuEqcOlXRrvzjRgg7a3T8QimiiJubgEkN229ck7sPThMBNVbi61jflsmHAUe7lM5ciZKp5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PxRmAgGY; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so709238266b.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 06:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755610747; x=1756215547; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=24+DhovLXRowK75nxtwEh/hEzG0jJ1R1pyylOLaj9mw=;
        b=PxRmAgGY1I7BRklItPjGIIoSqeouq7RJP+9tm88yv8DnBu4LDuph1TDBbc96/yJ56A
         35SHjzNiKGNs4JufuAPMYG2FBbJPV1m7qFvbFNSK0upPmQIeTuXkGHhOuexgTnfmrhFj
         aIIsukZtk7OVQvCdbGnR2GeuaGT6PPgXlg+1iAUs6C6QQldKn1FcI8JiBN1AXuozd93y
         AzEl3LZZIsxE7+NCUe2F/JeJKZXYzCDVLBA/NAXMTIuuSf1MP1YxKAV5dnutxMudWGGY
         w4hivcUl+q8Tcqefn8nbwqx/NhKU7A5QjfiahK0jLUpzU86BGeStfwkxsHeW3o1Bel/a
         k2Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755610747; x=1756215547;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=24+DhovLXRowK75nxtwEh/hEzG0jJ1R1pyylOLaj9mw=;
        b=WgbD3uE26d8NX+pn26jqcDQf/laxiFmnb76ct95BssM6ZGmiTVers2qiqY/ieDGlpE
         0Rp6pMb3AfZmlaYuxo5laSsKA0ipuflCMM5tZ5IHdR/tSldKN3j1XdifHftWI0lm1cnI
         KsCyjOg7Ud9IVFGmdR9iHeyv9/9VbrqRYBRmWGjOwFQGITdE9AGh21jk2bry+i/ps4Mo
         ZvBdkE5r17SvuqfpsRgQi0wcVs7T7hrSWhchpb67E5KjmgLH6zYaQyRNQ1TtTE34Cuyx
         XJI097L9lTmPD18H+UmU1UoByhVr14eXxPqMlq7q6V4ARXm8WK5REB94w1UV+iBFZVkI
         AXxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYlLULJcwzj9F+7vmQj+edJQEhEoZIJ35XBXaJgjArYk0tgVQzcBlQbLjIpcPDPK8k+IEPgOF0q+t4S5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNDywv3j1ehnQTy+Iv5pBonWqP9R7MLn/BXAS6GalEdQGdZ1Wx
	77aerXcrbIvFo0Cj9gSGzZeyPtuoXUJ7LVabaJPFfbAYwBDbHYPTBuX1UXj3lbqlkJM=
X-Gm-Gg: ASbGncv8NFy5efzaH0nMFflDPXyUNaiYhVMbEJdT8iTnSAebYVktQc5pQ5J7O75j+KJ
	Fi1LON5NcsimivcPejUAJ0yklKErw09QwI25qyU6XeMhrq+wLnlTc5urYsGx3XfahLnxeL+queD
	1/b2jSsFFskIh30trY4+9bLWJaBuefJGL2h8mPIDsncprkJZpX8JxemPhII2f8PIozjKHlw9XAJ
	P1M6a9YgYiCP1gH/NBDiIW70vb2/txnd+bAOG+jj6s7MBU1tsidDSMXZ1qknTkNnTO3t9YyQutC
	54kZfxaJC2wSTT67uVPYt4vRec2p1jLITGd+0WKBq0qpjEFMacSC+ekrdiCcYJnHA7+kzVqjDPF
	BkeRv6Ti7Q6c39d5yfyOtItZom4LDtrItPFlq
X-Google-Smtp-Source: AGHT+IFp0IGZ5ZPsxOx8ZOcQIH9irjrlcYZTRa9qnfGYi1fwrDmtMMTExjhy4Qa5CnmntZ1UkEbjfA==
X-Received: by 2002:a17:907:86a9:b0:afa:1ef1:342a with SMTP id a640c23a62f3a-afddcb8326bmr270992966b.20.1755610746926;
        Tue, 19 Aug 2025 06:39:06 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdcfccd37sm1012541266b.80.2025.08.19.06.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 06:39:06 -0700 (PDT)
Date: Tue, 19 Aug 2025 15:39:04 +0200
From: Petr Mladek <pmladek@suse.com>
To: cuiguoqi <cuiguoqi@kylinos.cn>
Cc: catalin.marinas@arm.com, will@kernel.org, bigeasy@linutronix.de,
	clrkwllms@kernel.org, rostedt@goodmis.org, farbere@amazon.com,
	guoqi0226@163.com, tglx@linutronix.de, akpm@linux-foundation.org,
	feng.tang@linux.alibaba.com, joel.granados@kernel.org,
	john.ogness@linutronix.de, namcao@linutronix.de,
	takakura@valinux.co.jp, sravankumarlpu@gmail.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] printk: Fix panic log flush to serial console during
 kdump in PREEMPT_RT kernels
Message-ID: <aKR-eBMoMBa4fnrF@pathway.suse.cz>
References: <20250807112247.170127-1-cuiguoqi@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807112247.170127-1-cuiguoqi@kylinos.cn>

On Thu 2025-08-07 19:22:47, cuiguoqi wrote:
> When a system running a real-time (PREEMPT_RT) kernel panics and triggers kdump,
> the critical log messages (e.g., panic reason, stack traces) may fail to appear
> on the serial console.

How did you find this problem, please?
Were you investigating why a log was missing?
Or was is just be reading the code?

By other words, is this problem theoretial or did you found
it when debugging a real life problem?

I ask because there is no ideal solution. This change might help
in one situation and make it worse in other situations.
See below.

> When kdump cannot be used properly, serial console logs are crucial,
> whether for diagnosing kdump issues or troubleshooting the underlying problem.
> 
> This issue arises due to synchronization or deferred flushing of the printk buffer
> in real-time contexts, where preemptible console locks or delayed workqueues prevent
> timely log output before kexec transitions to the crash kernel.
> 
> The test results are as follows:
> [  T197] Kernel panic - not syncing: sysrq triggered crash
> [  T197] Call trace:
> [  T197]  dump_backtrace+0x9c/0x120
> [  T197]  show_stack+0x1c/0x30
> [  T197]  dump_stack_lvl+0x34/0x88
> [  T197]  dump_stack+0x14/0x20
> [  T197]  panic+0x3c4/0x3f8
> [  T197]  sysrq_handle_crash+0x20/0x28
> [  T197]  __handle_sysrq+0xd4/0x1e0
> [  T197]  write_sysrq_trigger+0x88/0x108
> [  T197]  proc_reg_write+0x9c/0xf8
> [  T197]  vfs_write+0xf4/0x450
> [  T197]  ksys_write+0x70/0x100
> [  T197]  __arm64_sys_write+0x20/0x30
> [  T197]  invoke_syscall+0x48/0x110
> [  T197]  el0_svc_common.constprop.0+0x44/0xe8
> [  T197]  do_el0_svc+0x20/0x30
> [  T197]  el0_svc+0x24/0x88
> [  T197]  el0t_64_sync_handler+0xb8/0xc0
> [  T197]  el0t_64_sync+0x14c/0x150
> [  T197] SMP: stopping secondary CPUs
> [  T197] Starting crashdump kernel...
> [  T197] Bye!
> 
> Signed-off-by: cuiguoqi <cuiguoqi@kylinos.cn>
> ---
>  arch/arm64/kernel/machine_kexec.c | 4 ++++
>  kernel/panic.c                    | 4 ++--
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> index 6f121a0..66c7d90 100644
> --- a/arch/arm64/kernel/machine_kexec.c
> +++ b/arch/arm64/kernel/machine_kexec.c
> @@ -24,6 +24,7 @@
>  #include <asm/page.h>
>  #include <asm/sections.h>
>  #include <asm/trans_pgd.h>
> +#include <linux/console.h>
>  
>  /**
>   * kexec_image_info - For debugging output.
> @@ -176,6 +177,9 @@ void machine_kexec(struct kimage *kimage)
>  
>  	pr_info("Bye!\n");
>  
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT) && in_kexec_crash)
> +		console_flush_on_panic(CONSOLE_FLUSH_PENDING);

IMHO, this is a bad idea. console_flush_on_panic() is supposed
to be called as the last attempt to flush the kernel messages
when there is no other chance to see them.

console_flush_on_panic() ignores console_lock() because it might
create a deadlock. This why vpanic() calls debug_locks_off() first.
But ignoring a synchronization might obviously bring another problems,
and break the system another way.

console_lock() should _not_ be ignored when we try to create
crash_dump(). It would increase the risk that the crash_dump
would fail. And crash_dump() is the preferred way to preserve
the kernel messages in this code path.

> +
>  	local_daif_mask();
>  
>  	/*
> diff --git a/kernel/panic.c b/kernel/panic.c
> index 72fcbb5..e0ad0df 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -437,6 +437,8 @@ void vpanic(const char *fmt, va_list args)
>  	 */
>  	kgdb_panic(buf);
>  
> +	printk_legacy_allow_panic_sync();

I do not like this as well.

The commit message for the commit  e35a8884270bae1 ("printk:
Coordinate direct printing in panic") says that the primary
purpose is to disable flushing legacy consoles when printing
the backtrace by dump_stack(). This change looks OK from this POV.

But we wanted to delay this after __crash_kexec() and
panic_other_cpus_shutdown() because the legacy consoles
are not safe in panic(). They ignore the internal spin locks
after calling bust_spinlocks(1).

This change would increase the risk that __crash_kexec() would
fail. Also the legacy consoles are more safe after stopping
other CPUs.

IMPORTANT: The legacy consoles are blocked only when some
	"nbcon" console is registered. And nbcon consoles are never
	blocked. It guarantees that the messages are flushed on some
	consoles even before this call.

> +
>  	/*
>  	 * If we have crashed and we have a crash kernel loaded let it handle
>  	 * everything else.
> @@ -450,8 +452,6 @@ void vpanic(const char *fmt, va_list args)
>  
>  	panic_other_cpus_shutdown(_crash_kexec_post_notifiers);
>  
> -	printk_legacy_allow_panic_sync();
> -
>  	/*
>  	 * Run any panic handlers, including those that might need to
>  	 * add information to the kmsg dump output.

Best Regards,
Petr

