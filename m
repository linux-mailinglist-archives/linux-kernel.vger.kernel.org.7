Return-Path: <linux-kernel+bounces-581624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2858A762EC
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Mar 2025 11:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5B921888AF4
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Mar 2025 09:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7BC1547D2;
	Mon, 31 Mar 2025 09:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ls2j7hF3"
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5425738F80
	for <linux-kernel@vger.kernel.org>; Mon, 31 Mar 2025 09:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743411959; cv=none; b=s/ZjTjIt8vlbERGWF9EDaYvOjn0YZVxmRWDn5aLykHRwve7ZauYc0kkP7gPyj9akVJtsoqoxdrVjPv2ool1TgFfQPc/Yl38sT5hcWPpHbPMwKhFgEJPqq57kVYobMrarIwETUmPKb6aJ5tbKc4k28LMgpgrNhbcAytSHpR42G8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743411959; c=relaxed/simple;
	bh=zJ8Z+pdAxNUzJR1B1ibFK4msNtLxcqUN/V/IBVzo1+s=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hhEHyfXKXB7nmn4BjLnWNvFqs7b3VHGpE4gUPJZ640ePdn88j7z9Xp5uSPXJXxS9n57kRcp3PEm+pqagGckyOnr963UICfVdWMKc0PQVIn0C3nXrzAnpJeqM2sG/9f7vMNKIVjqoUyYMP49Mh1Q2fxdYjSQOW0B3EIGrG0FxZss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ls2j7hF3; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-5e5e8274a74so6697050a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Mar 2025 02:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1743411955; x=1744016755; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Llm9pma7GB9kBl93sCNj/g39MW9hKI2/XXZsXMDyXJU=;
        b=Ls2j7hF3Z0Fm59JwAkqMYUrTivYOiOibYsJEfTroceT8nY/htHh+094zzjXfLNoRHL
         u10s4VquO0n6x3SQIm3jXvXHuHmq1UtQMCqQkcldJYHAaQzM1L8HA90BSafSS98+tcdt
         ykNyZIblyzV4dNakFDteLa6mbV8U1RMPrE0RhKAdojkzMEzwlVgilMrKzeBvvpzoj7Vm
         QQsjULyWTAeefTTBvgbeqxlEi6msLuQtMQ+GQDqABbQ1ErLVQY3mXBwRbbkV1ifzi4Nb
         Z8ED9ss8yeusBJTiJk0Uf0kQFaFA/DFj6xo+xDVkVRVO5OVE8Qz+bA/uEil3HXWAYv67
         g4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743411955; x=1744016755;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Llm9pma7GB9kBl93sCNj/g39MW9hKI2/XXZsXMDyXJU=;
        b=SXwn3WJpHXqduf24JYllQoY/6ykbZfE+1OBUlkaWAUHqv1Mst6tweIdOtEJttuuqZ7
         QJL2akVHWl55dYdLf0GJ7+FMHDJFdflEViDOJpUQ65QB5MuueZ3MY8bIKubF5AnphcZY
         JEvp9l941jpJ65d3TA/lS/Vl0k/1PovesC9I9Ojy5g+7H5x1+zinK3CFhkVuUjoCyiLo
         afCuEq0IbQHQ4l9cepb7fWwvCJgNbgOiuKoLAAjqTX5HL0tvZxpqA4xnd3dNVw0c0PY+
         HO6VhmXBnU+wCVRsndiiSevYPtyZlhu+YP2DSPNE+0wfHXEqo6M/IhvM9LaflcToJ8YK
         zWFw==
X-Forwarded-Encrypted: i=1; AJvYcCUBT/mLc9pbfMhaLx1Ve+Dle2S/fLl9c7KUaz2KiixtZrtVnyS34vIZNqeAvxMaG7R9AVdgqO24FA/NK0w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy5PaNDytGjgoR4E92etwhoqLpSZCD9NqCE7HORuHeNvupTL5a
	vjDfslxsExlwiaoriDx/wq0K3kSLGFv2XsMEwICNwhnvaXFyVjpryyJlym6KnNc=
X-Gm-Gg: ASbGncthabNywbfRiiIJQpYeOcC8CzN4lr3pFekUY/BB8JhDEeZZdBmTpaWPFQqYJoS
	GNoMRwueidqh5SpQOOHni9Oq/whoAY5qy1gZEXn4SU8oPoJLcpZyooNtrzkThOZepTioZQ88DPO
	TUu+UIGReBa4VpzSW1670G1xPJrEjkcKqEAXVhstz8czt8PcaQlwuQ57yqfKEoLYp2T/WKX+6fV
	75d8hgJgLFKOrAepd2RFVYxzROfHRD40a84KoQ4fY84PXc4OGEC7SNC5zle474218xuTsDu7/PC
	AViT/L7Z47QBjNz3dxi3I/CaxcspG/FUVplp4LnjwOt1uThtN6W/1vDqHWckqOQvshsUES+5swq
	sDAfP5g5hk2qj
X-Google-Smtp-Source: AGHT+IGHsMCAoVAwG4CE1fni04ClvtPYfCFVP4V9SvKvPyt4K6GKejVrsoR2ClYLTTrY2bxgzG9t7g==
X-Received: by 2002:a05:6402:2793:b0:5ec:939e:a60e with SMTP id 4fb4d7f45d1cf-5edfb36bf62mr6145611a12.0.1743411954999;
        Mon, 31 Mar 2025 02:05:54 -0700 (PDT)
Received: from localhost (host-87-5-222-245.retail.telecomitalia.it. [87.5.222.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5edc16d41f6sm5579663a12.25.2025.03.31.02.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 02:05:54 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Mon, 31 Mar 2025 11:07:12 +0200
To: Song Liu <song@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-toolchains@vger.kernel.org, live-patching@vger.kernel.org,
	indu.bhagat@oracle.com, puranjay@kernel.org, wnliu@google.com,
	irogers@google.com, joe.lawrence@redhat.com, jpoimboe@kernel.org,
	mark.rutland@arm.com, peterz@infradead.org,
	roman.gushchin@linux.dev, rostedt@goodmis.org, will@kernel.org,
	kernel-team@meta.com, Suraj Jitindar Singh <surajjs@amazon.com>,
	Torsten Duwe <duwe@suse.de>, Miroslav Benes <mbenes@suse.cz>,
	Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH v3 2/2] arm64: Implement HAVE_LIVEPATCH
Message-ID: <Z-pbQJtwdAxyR0Fg@apocalypse>
References: <20250320171559.3423224-1-song@kernel.org>
 <20250320171559.3423224-3-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320171559.3423224-3-song@kernel.org>

On 10:15 Thu 20 Mar     , Song Liu wrote:
> This is largely based on [1] by Suraj Jitindar Singh.
> 
> Test coverage:
> 
> - Passed manual tests with samples/livepatch.
> - Passed all but test-kprobe.sh in selftests/livepatch.
>   test-kprobe.sh is expected to fail, because arm64 doesn't have
>   KPROBES_ON_FTRACE.
> - Passed tests with kpatch-build [2]. (This version includes commits that
>   are not merged to upstream kpatch yet).
> 
> [1] https://lore.kernel.org/all/20210604235930.603-1-surajjs@amazon.com/
> [2] https://github.com/liu-song-6/kpatch/tree/fb-6.13
> Cc: Suraj Jitindar Singh <surajjs@amazon.com>
> Cc: Torsten Duwe <duwe@suse.de>
> Signed-off-by: Song Liu <song@kernel.org>
> Acked-by: Miroslav Benes <mbenes@suse.cz>
> Tested-by: Breno Leitao <leitao@debian.org>
> ---
>  arch/arm64/Kconfig                   | 3 +++
>  arch/arm64/include/asm/thread_info.h | 4 +++-
>  arch/arm64/kernel/entry-common.c     | 4 ++++
>  3 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 31d5e1ee6089..dbd237b13b21 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -277,6 +277,7 @@ config ARM64
>  	select USER_STACKTRACE_SUPPORT
>  	select VDSO_GETRANDOM
>  	select HAVE_RELIABLE_STACKTRACE
> +	select HAVE_LIVEPATCH
>  	help
>  	  ARM 64-bit (AArch64) Linux support.
>  
> @@ -2501,3 +2502,5 @@ endmenu # "CPU Power Management"
>  source "drivers/acpi/Kconfig"
>  
>  source "arch/arm64/kvm/Kconfig"
> +
> +source "kernel/livepatch/Kconfig"
> diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
> index 1114c1c3300a..4ac42e13032b 100644
> --- a/arch/arm64/include/asm/thread_info.h
> +++ b/arch/arm64/include/asm/thread_info.h
> @@ -64,6 +64,7 @@ void arch_setup_new_exec(void);
>  #define TIF_UPROBE		4	/* uprobe breakpoint or singlestep */
>  #define TIF_MTE_ASYNC_FAULT	5	/* MTE Asynchronous Tag Check Fault */
>  #define TIF_NOTIFY_SIGNAL	6	/* signal notifications exist */
> +#define TIF_PATCH_PENDING	7	/* pending live patching update */
>  #define TIF_SYSCALL_TRACE	8	/* syscall trace active */
>  #define TIF_SYSCALL_AUDIT	9	/* syscall auditing */
>  #define TIF_SYSCALL_TRACEPOINT	10	/* syscall tracepoint for ftrace */
> @@ -92,6 +93,7 @@ void arch_setup_new_exec(void);
>  #define _TIF_SYSCALL_TRACEPOINT	(1 << TIF_SYSCALL_TRACEPOINT)
>  #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
>  #define _TIF_SYSCALL_EMU	(1 << TIF_SYSCALL_EMU)
> +#define _TIF_PATCH_PENDING	(1 << TIF_PATCH_PENDING)
>  #define _TIF_UPROBE		(1 << TIF_UPROBE)
>  #define _TIF_SINGLESTEP		(1 << TIF_SINGLESTEP)
>  #define _TIF_32BIT		(1 << TIF_32BIT)
> @@ -103,7 +105,7 @@ void arch_setup_new_exec(void);
>  #define _TIF_WORK_MASK		(_TIF_NEED_RESCHED | _TIF_SIGPENDING | \
>  				 _TIF_NOTIFY_RESUME | _TIF_FOREIGN_FPSTATE | \
>  				 _TIF_UPROBE | _TIF_MTE_ASYNC_FAULT | \
> -				 _TIF_NOTIFY_SIGNAL)
> +				 _TIF_NOTIFY_SIGNAL | _TIF_PATCH_PENDING)
>  
>  #define _TIF_SYSCALL_WORK	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | \
>  				 _TIF_SYSCALL_TRACEPOINT | _TIF_SECCOMP | \
> diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
> index b260ddc4d3e9..b537af333b42 100644
> --- a/arch/arm64/kernel/entry-common.c
> +++ b/arch/arm64/kernel/entry-common.c
> @@ -8,6 +8,7 @@
>  #include <linux/context_tracking.h>
>  #include <linux/kasan.h>
>  #include <linux/linkage.h>
> +#include <linux/livepatch.h>
>  #include <linux/lockdep.h>
>  #include <linux/ptrace.h>
>  #include <linux/resume_user_mode.h>
> @@ -144,6 +145,9 @@ static void do_notify_resume(struct pt_regs *regs, unsigned long thread_flags)
>  				       (void __user *)NULL, current);
>  		}
>  
> +		if (thread_flags & _TIF_PATCH_PENDING)
> +			klp_update_patch_state(current);
> +
>  		if (thread_flags & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL))
>  			do_signal(regs);
>  
> -- 
> 2.47.1
> 

Tested-by: Andrea della Porta <andrea.porta@suse.com>

Thanks,
Andrea

