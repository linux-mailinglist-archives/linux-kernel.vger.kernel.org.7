Return-Path: <linux-kernel+bounces-855249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4A9BE09CE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 22:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 782964E7D1E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 20:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF1A2BE652;
	Wed, 15 Oct 2025 20:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJfr3dfN"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5795229C338
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 20:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760559534; cv=none; b=hZiGjoQpww5Jy/PVcWfV+90ZkiMRIS9ds8xE9Bi+uwXlpV29NtHRdonvixvbwFcYtY20IuodNvjM27filU7LsvMl6wFb7OhWNXqfpFXx+McejuIrbMrixulK+dbxWnEV0vvH08GHXjWXHw7T3kAdDCU0rTGIxD7Au3ryTaUwoeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760559534; c=relaxed/simple;
	bh=RMU247VBfdCk1PNbG3GvfLLm7n0H5cFPzUvQhXwUYYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I1iikpCy8V3hJZjBL/ABwxOC7AhiD2YQgCDJqNXWADU1dEBQ7O5qkAW3W8nkgE6GXuZsvof0mmLDLMRNx8W6WGMNUqm0plc5GDCycl+SN8Da2Df55FtTtao9PlGxZ0J6ob6u9FH6iJUm80p/IMXw02sqDQmlXe9s4eC4IkXqZ7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UJfr3dfN; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-63b6dfd85d4so9338195a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 13:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760559531; x=1761164331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJg9X9PlIoB/ST2nyyuoIjib7x+oaPTrM9+LsomMQTU=;
        b=UJfr3dfNkLHutdKzb+g0EIecpLScCVUKlYyIgzB4++gjqZR84q4eeXDpdCMxKFkFa1
         cC7eTs/h7prczMZm/TNHxmKRch1fcmZO0yrj5w0UtykTrex26ktnTFIQ4Izjqxgg0m2K
         RFaXb6F9j7kfGjwgtA3OewjeC8XO1tGknEarIHAk6vJgsennBpm9vChhJ/UpO9E+K78f
         Th76Ng+lzjRDB/IrWGN8Xbxm/Gf4ed19SAbsBTf3QhPQmhPruijC7JmCDLMbzNiC6Y+C
         Peheo9MP9aWuhN/bMtZpeUNUzhi/ZeTY+l3FevokjzeUMaRcslAXi3WxcjqcRF4ZF5ml
         xfSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760559531; x=1761164331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xJg9X9PlIoB/ST2nyyuoIjib7x+oaPTrM9+LsomMQTU=;
        b=lsKnfm5Uvcd58vGnmWn1ChZAX2aq2E8xfhmir8ikUsZuYQJWfc5NWRdEOVuPCPL6V7
         dPyXj5xZaEKE2LPaU4S/FCgSkMuQKM/ELVO00hYvn/NPQmPZ6HcTvvCvSLwQDXMqwhP9
         lIjzb5UUsGVy+MNgU9S6+JAhPDhtPUHTu/8AmLCSEqowZ8JwfaCLdtpNSn8iZXMvnei2
         JpkJFsAhiigq2qJdh2+6sKtKfJz0Mv20nMdxO5y5epysyexxVweWMpPTrQ68siYvw9uB
         dMRD4i4V7rqdzsZXjOH8oPlhJymt6CTPHS61TFd3qf5A0QXHaJK7H1t5/zWcKB2nf8nc
         ftXw==
X-Forwarded-Encrypted: i=1; AJvYcCXhBS5EGH2VYgOsDOhrgTB2EWEyKg4O00PtgoKbF7Y4lrEim6q6ZeqYwxDSJukJfcTw7JvhetKU3MOIQp4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXebgXjtnD9c83ybJi7EmenOxVNFA7JNnF8zeu6oVeJjo+RTrr
	2xvtJA+B3+3/9VH8dF1hdpHlWuAxITj0rF8jIuuw1PdwrWMWnWekCqK9ofhodGCTDVVv1D4oPcU
	KEWUQGAqXZTEAVba/P6N3EcQzj677Gi0=
X-Gm-Gg: ASbGnct9eXUSA+TSaFPHCYve9w97ikY/84KO6HmZhyiFvvuQRBnzVgu22Ly6Urrw4UF
	UtMaTZo2NnbfyXftZMShsEH4jOB7jFVU2pOhXG/4w8ZY6ZTKn0l5Oslnq9nMv5aTOo8nK4MjC1H
	R/HJQUXnZH9M3kpjihqXw1efxBT/WnKdIx9ermenZwQsjFX3t4OT8pGh4Je1Ik1CTEdPnCaMkMx
	lL4RLzwLv/bpK1lRtlHnkQ=
X-Google-Smtp-Source: AGHT+IENKf4WvhhBBJ2iUPr22yFEcCC4h7iTdaK4CP7B8HphHP1g/duXTL3pcv4SsEGCtifhINNijtPNnW4w/XdOi2o=
X-Received: by 2002:a05:6402:5205:b0:634:5297:e3bc with SMTP id
 4fb4d7f45d1cf-639d5b5e42bmr29802751a12.6.1760559530474; Wed, 15 Oct 2025
 13:18:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007115840.2320557-1-geomatsi@gmail.com> <20251007115840.2320557-5-geomatsi@gmail.com>
In-Reply-To: <20251007115840.2320557-5-geomatsi@gmail.com>
From: Andy Chiu <andybnac@gmail.com>
Date: Wed, 15 Oct 2025 15:18:38 -0500
X-Gm-Features: AS18NWAb6axIg7I2IqjVTHpzLs99BpK8lkg12YGdZJcKZxCb1gstwLw4-MW_Txc
Message-ID: <CAFTtA3MObvXRHxbULghGcT=ThrBDeFDJzUY7LOhgNnarzpYeGg@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] riscv: vector: allow to force vector context save
To: Sergey Matyukevich <geomatsi@gmail.com>
Cc: linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Oleg Nesterov <oleg@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Jisheng Zhang <jszhang@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Thomas Huth <thuth@redhat.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Han Gao <rabenda.cn@gmail.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Nam Cao <namcao@linutronix.de>, 
	Joel Granados <joel.granados@kernel.org>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 6:58=E2=80=AFAM Sergey Matyukevich <geomatsi@gmail.c=
om> wrote:
>
> When ptrace updates vector CSR registers for a traced process, the
> changes may not be immediately visible to the next ptrace operations
> due to vector context switch optimizations.
>
> The function 'riscv_v_vstate_save' saves context only if mstatus.VS is
> 'dirty'. However mstatus.VS of the traced process context may remain
> 'clean' between two breakpoints, if no vector instructions were executed
> between those two breakpoints. In this case the vector context will not
> be saved at the second breakpoint. As a result, the second ptrace may
> read stale vector CSR values.

IIUC, the second ptrace should not get the stale vector CSR values.
The second riscv_vr_get() should be reading from the context memory
(vstate), which is updated from the last riscv_vr_set(). The user's
vstate should remain the same since last riscv_vr_set(). Could you
explain more on how this bug is observed and why only CSRs are
affected but not v-regs as well?

Thanks,
Andy

>
> Fix this by introducing a TIF flag that forces vector context save on
> the next context switch, regardless of mstatus.VS state. Set this
> flag on ptrace oprations that modify vector CSR registers.
>
> Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
> ---
>  arch/riscv/include/asm/thread_info.h | 2 ++
>  arch/riscv/include/asm/vector.h      | 3 +++
>  arch/riscv/kernel/process.c          | 2 ++
>  arch/riscv/kernel/ptrace.c           | 5 +++++
>  4 files changed, 12 insertions(+)
>
> diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/as=
m/thread_info.h
> index 836d80dd2921..e05e9aa89c43 100644
> --- a/arch/riscv/include/asm/thread_info.h
> +++ b/arch/riscv/include/asm/thread_info.h
> @@ -118,7 +118,9 @@ int arch_dup_task_struct(struct task_struct *dst, str=
uct task_struct *src);
>
>  #define TIF_32BIT                      16      /* compat-mode 32bit proc=
ess */
>  #define TIF_RISCV_V_DEFER_RESTORE      17      /* restore Vector before =
returing to user */
> +#define TIF_RISCV_V_FORCE_SAVE         13      /* force Vector context s=
ave */
>
>  #define _TIF_RISCV_V_DEFER_RESTORE     BIT(TIF_RISCV_V_DEFER_RESTORE)
> +#define _TIF_RISCV_V_FORCE_SAVE                BIT(TIF_RISCV_V_FORCE_SAV=
E)
>
>  #endif /* _ASM_RISCV_THREAD_INFO_H */
> diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm/vec=
tor.h
> index b61786d43c20..d3770e13da93 100644
> --- a/arch/riscv/include/asm/vector.h
> +++ b/arch/riscv/include/asm/vector.h
> @@ -370,6 +370,9 @@ static inline void __switch_to_vector(struct task_str=
uct *prev,
>  {
>         struct pt_regs *regs;
>
> +       if (test_and_clear_tsk_thread_flag(prev, TIF_RISCV_V_FORCE_SAVE))
> +               __riscv_v_vstate_dirty(task_pt_regs(prev));
> +
>         if (riscv_preempt_v_started(prev)) {
>                 if (riscv_v_is_on()) {
>                         WARN_ON(prev->thread.riscv_v_flags & RISCV_V_CTX_=
DEPTH_MASK);
> diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
> index 31a392993cb4..47959c55cefb 100644
> --- a/arch/riscv/kernel/process.c
> +++ b/arch/riscv/kernel/process.c
> @@ -183,6 +183,7 @@ void flush_thread(void)
>         kfree(current->thread.vstate.datap);
>         memset(&current->thread.vstate, 0, sizeof(struct __riscv_v_ext_st=
ate));
>         clear_tsk_thread_flag(current, TIF_RISCV_V_DEFER_RESTORE);
> +       clear_tsk_thread_flag(current, TIF_RISCV_V_FORCE_SAVE);
>  #endif
>  #ifdef CONFIG_RISCV_ISA_SUPM
>         if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SUPM))
> @@ -205,6 +206,7 @@ int arch_dup_task_struct(struct task_struct *dst, str=
uct task_struct *src)
>         memset(&dst->thread.vstate, 0, sizeof(struct __riscv_v_ext_state)=
);
>         memset(&dst->thread.kernel_vstate, 0, sizeof(struct __riscv_v_ext=
_state));
>         clear_tsk_thread_flag(dst, TIF_RISCV_V_DEFER_RESTORE);
> +       clear_tsk_thread_flag(dst, TIF_RISCV_V_FORCE_SAVE);
>
>         return 0;
>  }
> diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
> index 906cf1197edc..569f756bef23 100644
> --- a/arch/riscv/kernel/ptrace.c
> +++ b/arch/riscv/kernel/ptrace.c
> @@ -148,6 +148,11 @@ static int riscv_vr_set(struct task_struct *target,
>         if (vstate->vlenb !=3D ptrace_vstate.vlenb)
>                 return -EINVAL;
>
> +       if (vstate->vtype !=3D ptrace_vstate.vtype ||
> +           vstate->vcsr !=3D ptrace_vstate.vcsr ||
> +           vstate->vl !=3D ptrace_vstate.vl)
> +               set_tsk_thread_flag(target, TIF_RISCV_V_FORCE_SAVE);
> +
>         vstate->vstart =3D ptrace_vstate.vstart;
>         vstate->vl =3D ptrace_vstate.vl;
>         vstate->vtype =3D ptrace_vstate.vtype;
> --
> 2.51.0
>

