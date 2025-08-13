Return-Path: <linux-kernel+bounces-767247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC31DB251A2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 19:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E46B97B0DC2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 17:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F71F303CB8;
	Wed, 13 Aug 2025 17:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rt6tv1c/"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEE5303CAA
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 17:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755104996; cv=none; b=UbdCIxrkH0BS8ZrESSQsxtoGTcrNHRWZn6f9VS8S1iwreHwj9lyXs33xWyhz2C5KdpcFKE++oECezVQciU/plF+47XKlVcEGTIvyHXaXvOI7r+1GcUPyCVyKnZXCSZGukNFzcrAfnDoJRGYzD/OZgT05LwhZYvax2LQLeo+1dmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755104996; c=relaxed/simple;
	bh=2w7qJu2Qv1Ydyw5zQvgxifVtZudIr0cPBV2WnRQtutE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O/MGjCq0MhyILSAEomSExo6CnkjLshfYF9hEzuQosIFmIrbxDcHPndXIIamtWRy/eIAywmE9UasE2d4yBvd0zq6M4+X1hm0nFJiL4VxxFiBZ8lK1xtwfxAeNA1WdAkQSuiRoZEgR3N0CWVrmGafzG8NzaIRc1++GM3R1ihZfXYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rt6tv1c/; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e931c8594a9so19613276.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 10:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755104993; x=1755709793; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AcsTss5oLC/ljy6iAHysAb6eyZj8eVj9r8dExzYu/U0=;
        b=Rt6tv1c/ht77Wfe/7ZxyBPYWsE+zarVC0qGe6EhOCJXksbNXmgHx9oMPHW44mhHAOg
         eDqKYtW5SLXMqmma+tK+DCrFEHe7QyoHgTvunHEph1vppELil60nttYCOAz4HXOB6g0D
         V8bi5Kl4kvwTd67yUEyGzQFQJ7G/TKf7u5ZcQpJsgpeUrceNuXte/mxp4zy0h8KmGcSv
         PUrVa95s1hI6qfeyOnJBG9Gqei87C+CXhJSVnX2MaKZf2OT2oRG+VOlUAqqo6f4E0pCg
         jy1yfGImN6iFVUElBfpSQmdH6ruxX7i81+F0x9i/cgxPjq0WP12XQz58NLEdyR/pV1qG
         htLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755104993; x=1755709793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AcsTss5oLC/ljy6iAHysAb6eyZj8eVj9r8dExzYu/U0=;
        b=eseNzzCAQkJYm27yKZcjrsCkBFOlS4ifOoswAZejlKkEHmMqYE1hKeH8uNu4/O1uoV
         ClizURwGtzuBcgtJiipLs+ikqJE180pBNuaaQa//SItkjOEiSOsSPZysc6gGLWeS6XFz
         wtHslnLBz3GpKF37O0mzqK4rCCMzTsTzYyZsPWHHgsrXh0ZwumgPZ9oNVoTf9SE0qsr8
         JtVoR0jxrI1tp0bVMGvA1/NUtpznTg1PnvtI5gxANlcGqkUgsVzHMlMp7EPYJY7uSdnn
         VQPd3a3LKbSssGEWvQ6BJSQuzy0ss+8BZFCH7lPpMLmaA3ROMHWk/cWny49gMHs+BjEJ
         gN4Q==
X-Gm-Message-State: AOJu0YwnK/AWjjuC8qfEYcRLNklmIjNhM7+SeNqrR+yP3FS12yoE5L/P
	z50jdah4z0pduIj1YH/SgeRcMhcErs3DJBJaMlcfXwRmP6w6fbCCa5KUP7dR15kGQ8r6Blg+UmB
	tPqwCPdkHgaWu+Dog/oYE9XsHYFEf7jQ=
X-Gm-Gg: ASbGncuXDnMsZFY0TIlNGoIzT7QGbi1YwUuat5UmzR3xgcy9ywKI0s+AjoHzx1In3d2
	3geDz9GJ8XcZUI7WBywrHOJZvtkhG53d9/+8jvPVdwUbOha9Bgsz6O6x26taEKVBsdt3Kpia+Em
	fag78VKvTjjusIfZ0ul0iokUF15YHAHxJ6k2mxuDOyPiEEBnZlNQWS4F3MYruEEqmzPHWtCfcWt
	AfQGw==
X-Google-Smtp-Source: AGHT+IGmKencFbOxswxXdRpsztzCwJ5AH/Th4B5DtSHjMq/d+ZVi7MSaKvTgXp67Nz9CocBaNryTAPkYWxX/xifnNYk=
X-Received: by 2002:a05:690c:6f0f:b0:71c:20fa:7b59 with SMTP id
 00721157ae682-71d4e3fba2emr24082237b3.2.1755104993287; Wed, 13 Aug 2025
 10:09:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813155941.014821755@linutronix.de> <20250813162824.228728594@linutronix.de>
In-Reply-To: <20250813162824.228728594@linutronix.de>
From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Date: Wed, 13 Aug 2025 21:09:41 +0400
X-Gm-Features: Ac12FXxVkaQaA9v8gzDUdKu6VdxVM6pLlRvzvD4NCfG3y4EgngmaRktwTRh90AQ
Message-ID: <CAE7dp2pxxKWdNJkwZZDw2GmR6vH8YVMGcTm55u1pxVygaeNydw@mail.gmail.com>
Subject: Re: [patch 07/11] entry: Cleanup header
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Michael Jeanson <mjeanson@efficios.com>, 
	Peter Zijlstra <peterz@infradead.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Wei Liu <wei.liu@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Typo in kernel-doc:
In irq-entry-common.h the doc line reads Pointer to currents pt_regs =E2=80=
=94
should be Pointer to current's pt_regs (or Pointer to current->pt_regs
depending on local style).


 Stray blank/trailing whitespace:
In entry-common.h there is an extra blank line inserted after the
ARCH_SYSCALL_WORK_ENTER) macro continuation =E2=80=94 remove the stray blan=
k
to avoid style/noise.

On Wed, Aug 13, 2025 at 8:39=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> Cleanup the include ordering, kernel-doc and other trivialities before
> making further changes.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> ---
>  include/linux/entry-common.h     |    8 ++++----
>  include/linux/irq-entry-common.h |    2 ++
>  2 files changed, 6 insertions(+), 4 deletions(-)
>
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -3,11 +3,11 @@
>  #define __LINUX_ENTRYCOMMON_H
>
>  #include <linux/irq-entry-common.h>
> +#include <linux/livepatch.h>
>  #include <linux/ptrace.h>
> +#include <linux/resume_user_mode.h>
>  #include <linux/seccomp.h>
>  #include <linux/sched.h>
> -#include <linux/livepatch.h>
> -#include <linux/resume_user_mode.h>
>
>  #include <asm/entry-common.h>
>  #include <asm/syscall.h>
> @@ -37,6 +37,7 @@
>                                  SYSCALL_WORK_SYSCALL_AUDIT |           \
>                                  SYSCALL_WORK_SYSCALL_USER_DISPATCH |   \
>                                  ARCH_SYSCALL_WORK_ENTER)
> +
>  #define SYSCALL_WORK_EXIT      (SYSCALL_WORK_SYSCALL_TRACEPOINT |      \
>                                  SYSCALL_WORK_SYSCALL_TRACE |           \
>                                  SYSCALL_WORK_SYSCALL_AUDIT |           \
> @@ -61,8 +62,7 @@
>   */
>  void syscall_enter_from_user_mode_prepare(struct pt_regs *regs);
>
> -long syscall_trace_enter(struct pt_regs *regs, long syscall,
> -                        unsigned long work);
> +long syscall_trace_enter(struct pt_regs *regs, long syscall, unsigned lo=
ng work);
>
>  /**
>   * syscall_enter_from_user_mode_work - Check and handle work before invo=
king
> --- a/include/linux/irq-entry-common.h
> +++ b/include/linux/irq-entry-common.h
> @@ -68,6 +68,7 @@ static __always_inline bool arch_in_rcu_
>
>  /**
>   * enter_from_user_mode - Establish state when coming from user mode
> + * @regs:      Pointer to currents pt_regs
>   *
>   * Syscall/interrupt entry disables interrupts, but user mode is traced =
as
>   * interrupts enabled. Also with NO_HZ_FULL RCU might be idle.
> @@ -357,6 +358,7 @@ irqentry_state_t noinstr irqentry_enter(
>   * Conditional reschedule with additional sanity checks.
>   */
>  void raw_irqentry_exit_cond_resched(void);
> +
>  #ifdef CONFIG_PREEMPT_DYNAMIC
>  #if defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
>  #define irqentry_exit_cond_resched_dynamic_enabled     raw_irqentry_exit=
_cond_resched
>
>

