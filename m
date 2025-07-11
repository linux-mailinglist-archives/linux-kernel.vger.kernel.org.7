Return-Path: <linux-kernel+bounces-728168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8189B0241A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 20:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 944AE3B40C5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C86E28DF27;
	Fri, 11 Jul 2025 18:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sBx9bKt3"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5AE1D618C
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 18:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752259808; cv=none; b=aqdJfyHE360990vHwYGon2HVLpCn3xmIHRs8sQProBMo9/SI4vmHvtbsUZmRkOgoJDoWX6AlxVK0jgS7IItXwoZIGDxuXYZMXddmozI3aoBgemaFudkqErpcZuW2h8kOFFdX5wEWbkBdAkxhtYn0nIYeDnwy9q4dOPu/UdVqt0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752259808; c=relaxed/simple;
	bh=uKsxT/BD17OYI1TvueJzTB7MSRcSpvBm5d7/ESnv4X8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vBYQwos1ktN359rwkB1l9XGy/DL+7wu/FPRrm6wazsU+Dn6PiLA4apd9/T/5dTv4lFpji3awOoSMGu1gxDX1qTgpk6HNqBA+Dlfw+Sr/qE5nfXaZcyBzofJJRmmeIG/rsuphLkEJPpfJgG8fg4wgYMIEky++YSsdxQsEitNYo6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sBx9bKt3; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-235e389599fso29195ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 11:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752259806; x=1752864606; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yp9Z/2QTyMOyDYIkU7CbCU89ReiAiNnkjU7WZOcGUCk=;
        b=sBx9bKt30cj8r/AbZjltVu2+DdjQqVk7/UJGEBO+CTP84+FveeKbGI+b1NbtoAZG03
         sPIpWQ0CioQFcntjFmpaGazH+4jK6Ox1UUlexu4RyzaknE2G95zl24HU0tZOFf67Q0xP
         zt0SDCtpAoKikAQRvKarprLesTugBM4HyHXZV+gR8fhCuT6GweFA7QdZTYSZp3+mZEt7
         XQ+2doy8ub663gF4zbTXULAPKmJ+U+wQmd+fUXXcZWNbM8cKZ45Ia3orAtPsTQAM9zV3
         y6bAhgjCPCOnzDQVWZ0Tvce155fQu/PiNXi7M658eQ5O0AtUR0vZ1v+p1uUOReQOepdh
         Vuug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752259806; x=1752864606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yp9Z/2QTyMOyDYIkU7CbCU89ReiAiNnkjU7WZOcGUCk=;
        b=g5JYl3/h8uamrSgjAjfj9im3XviM4fwCoAgu1zMBYgHbOHXuN1dbLsRMtMVRelU7Zk
         4liWkDTHANI1Cga+Ej7/fyNQVnjx9LYMQQggWjJcQgP8WaFb8gmXGfNOV1AHeqQZmo34
         5dYXtrvHDasGRMmEkzvI7fbLg3QuE28qJxlGFfAILD0T47VT80W01oFOOikCef8BRnaw
         ISWGY+XSq3cR3pJncn0v3azE6whGuWTd3o9O8277DoT5+7Dj450hZsh+rosOS/ny5++f
         +tBbYzMZaRz2+hXNwHB22i7esb4tKdMhdGuYICpZKLNiic0oPeLSQD/1pSCIR3CZtnbz
         FqvQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5+EiNkIiscd+4VNMUb67PzecE+39NI0SPKSkUhQWInl7qOpwgnMNc6p/bBsqDbrGuk+ycK/1QVFRJiY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKlHfAIQnP6vQ3ENAgYLbPXwfO72x4MXvBBt3WNjUQMSQZfDdO
	WEt3eoofxpEjr5lnjdfXv0a/4lTjhBwHVD7ml2T/OdSZf/1oXHOYxBpYOmzAdAlt2bSf7nYQoCh
	g3ftvDx9NIbrXeUoT46EREmWoge4abe20Crf84b73
X-Gm-Gg: ASbGncvbJMiBKW1klfmZv0bsmErvYp4Wp5SayJeR/IvXDzaPbUVKULYoPcuEvU+sXtx
	MbIpwc0HnKl7PuDYWxLV5kFxfKgrs+WDYYJ06Xa9AK4/CqYARh7/XlERxjLp6/r8rhrUa5g/PRZ
	R5+pw2FnkrsYJilxInsReaRmKLNejzTh9pNyHAmatxWNZPJ8qPTQzEGnLQFoaVZZBWFN0atXs0L
	d7A
X-Google-Smtp-Source: AGHT+IHU8vaSeRw3fnyhcApiWIogTWqlYunNBPIhkLH9T3BHCSjrfAUuHQ1RgOSIgmx/uz7hFi2rTfco22+EbD0PTx8=
X-Received: by 2002:a17:903:1b0c:b0:215:65f3:27ef with SMTP id
 d9443c01a7336-23df6954f30mr379485ad.12.1752259806082; Fri, 11 Jul 2025
 11:50:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250505223437.3722164-4-samitolvanen@google.com>
 <20250505223437.3722164-6-samitolvanen@google.com> <aHEfJZjW9dTXCgw3@willie-the-truck>
In-Reply-To: <aHEfJZjW9dTXCgw3@willie-the-truck>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Fri, 11 Jul 2025 11:49:29 -0700
X-Gm-Features: Ac12FXxCyxWVkaFXO4hBzmagkiWunDFY19ZG9WQU670r1_7gDr_nTSfNwBp2hpE
Message-ID: <CABCJKued2XsLp5+ZW1ZWQn6=CgYkhjEDyJdfTRTR1MGkvDtmXg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 2/2] arm64/cfi,bpf: Support kCFI + BPF on arm64
To: Will Deacon <will@kernel.org>
Cc: bpf@vger.kernel.org, Puranjay Mohan <puranjay@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Catalin Marinas <catalin.marinas@arm.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Maxwell Bland <mbland@motorola.com>, 
	Puranjay Mohan <puranjay12@gmail.com>, Dao Huang <huangdao1@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Will,

On Fri, Jul 11, 2025 at 7:26=E2=80=AFAM Will Deacon <will@kernel.org> wrote=
:
>
> On Mon, May 05, 2025 at 10:34:40PM +0000, Sami Tolvanen wrote:
> > From: Puranjay Mohan <puranjay12@gmail.com>
> >
> > Currently, bpf_dispatcher_*_func() is marked with `__nocfi` therefore
> > calling BPF programs from this interface doesn't cause CFI warnings.
> >
> > When BPF programs are called directly from C: from BPF helpers or
> > struct_ops, CFI warnings are generated.
> >
> > Implement proper CFI prologues for the BPF programs and callbacks and
> > drop __nocfi for arm64. Fix the trampoline generation code to emit kCFI
> > prologue when a struct_ops trampoline is being prepared.
> >
> > Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> > Co-developed-by: Maxwell Bland <mbland@motorola.com>
> > Signed-off-by: Maxwell Bland <mbland@motorola.com>
> > Co-developed-by: Sami Tolvanen <samitolvanen@google.com>
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > Tested-by: Dao Huang <huangdao1@oppo.com>
> > ---
> >  arch/arm64/include/asm/cfi.h    | 23 +++++++++++++++++++++++
> >  arch/arm64/kernel/alternative.c | 25 +++++++++++++++++++++++++
> >  arch/arm64/net/bpf_jit_comp.c   | 22 +++++++++++++++++++---
> >  3 files changed, 67 insertions(+), 3 deletions(-)
> >  create mode 100644 arch/arm64/include/asm/cfi.h
> >
> > diff --git a/arch/arm64/include/asm/cfi.h b/arch/arm64/include/asm/cfi.=
h
> > new file mode 100644
> > index 000000000000..670e191f8628
> > --- /dev/null
> > +++ b/arch/arm64/include/asm/cfi.h
> > @@ -0,0 +1,23 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _ASM_ARM64_CFI_H
> > +#define _ASM_ARM64_CFI_H
> > +
> > +#ifdef CONFIG_CFI_CLANG
> > +#define __bpfcall
> > +static inline int cfi_get_offset(void)
> > +{
> > +     return 4;
>
> Needs a comment.

Ack.

> > +}
> > +#define cfi_get_offset cfi_get_offset
> > +extern u32 cfi_bpf_hash;
> > +extern u32 cfi_bpf_subprog_hash;
> > +extern u32 cfi_get_func_hash(void *func);
> > +#else
> > +#define cfi_bpf_hash 0U
> > +#define cfi_bpf_subprog_hash 0U
> > +static inline u32 cfi_get_func_hash(void *func)
> > +{
> > +     return 0;
> > +}
> > +#endif /* CONFIG_CFI_CLANG */
> > +#endif /* _ASM_ARM64_CFI_H */
>
> This looks like an awful lot of boiler plate to me. The only thing you
> seem to need is the CFI offset -- why isn't that just a constant that we
> can define (or a Kconfig symbol?).

The cfi_get_offset function was originally added in commit
4f9087f16651 ("x86/cfi,bpf: Fix BPF JIT call") because the offset can
change on x86 depending on which CFI scheme is enabled at runtime.
Starting with commit 2cd3e3772e41 ("x86/cfi,bpf: Fix bpf_struct_ops
CFI") the function is also called by the generic BPF code, so we can't
trivially replace it with a constant. However, since this defaults to
`4` unless the architecture adds pre-function NOPs, I think we could
simply move the default implementation to include/linux/cfi.h (and
also drop the RISC-V version). Come to think of it, we could probably
move most of this boilerplate to generic code. I'll refactor this and
send a new version.

> > diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/altern=
ative.c
> > index 8ff6610af496..71c153488dad 100644
> > --- a/arch/arm64/kernel/alternative.c
> > +++ b/arch/arm64/kernel/alternative.c
> > @@ -8,11 +8,13 @@
> >
> >  #define pr_fmt(fmt) "alternatives: " fmt
> >
> > +#include <linux/cfi_types.h>
> >  #include <linux/init.h>
> >  #include <linux/cpu.h>
> >  #include <linux/elf.h>
> >  #include <asm/cacheflush.h>
> >  #include <asm/alternative.h>
> > +#include <asm/cfi.h>
> >  #include <asm/cpufeature.h>
> >  #include <asm/insn.h>
> >  #include <asm/module.h>
> > @@ -298,3 +300,26 @@ noinstr void alt_cb_patch_nops(struct alt_instr *a=
lt, __le32 *origptr,
> >               updptr[i] =3D cpu_to_le32(aarch64_insn_gen_nop());
> >  }
> >  EXPORT_SYMBOL(alt_cb_patch_nops);
> > +
> > +#ifdef CONFIG_CFI_CLANG
> > +struct bpf_insn;
> > +
> > +/* Must match bpf_func_t / DEFINE_BPF_PROG_RUN() */
> > +extern unsigned int __bpf_prog_runX(const void *ctx,
> > +                                 const struct bpf_insn *insn);
> > +DEFINE_CFI_TYPE(cfi_bpf_hash, __bpf_prog_runX);
> > +
> > +/* Must match bpf_callback_t */
> > +extern u64 __bpf_callback_fn(u64, u64, u64, u64, u64);
> > +DEFINE_CFI_TYPE(cfi_bpf_subprog_hash, __bpf_callback_fn);
> > +
> > +u32 cfi_get_func_hash(void *func)
> > +{
> > +     u32 hash;
> > +
> > +     if (get_kernel_nofault(hash, func - cfi_get_offset()))
> > +             return 0;
> > +
> > +     return hash;
> > +}
> > +#endif /* CONFIG_CFI_CLANG */
>
> I don't think this should be in alternative.c. It's probably better off
> either as a 'static inline' in the new cfi.h header.

Sure, I'll find a better place for this. RISC-V again seems to have
the exact same function, so I think a __weak implementation in
kernel/cfi.c would work here, allowing x86 to still conveniently
override the function.

> > diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_com=
p.c
> > index 70d7c89d3ac9..3b3691e88dd5 100644
> > --- a/arch/arm64/net/bpf_jit_comp.c
> > +++ b/arch/arm64/net/bpf_jit_comp.c
> > @@ -9,6 +9,7 @@
> >
> >  #include <linux/bitfield.h>
> >  #include <linux/bpf.h>
> > +#include <linux/cfi.h>
> >  #include <linux/filter.h>
> >  #include <linux/memory.h>
> >  #include <linux/printk.h>
> > @@ -164,6 +165,12 @@ static inline void emit_bti(u32 insn, struct jit_c=
tx *ctx)
> >               emit(insn, ctx);
> >  }
> >
> > +static inline void emit_kcfi(u32 hash, struct jit_ctx *ctx)
> > +{
> > +     if (IS_ENABLED(CONFIG_CFI_CLANG))
> > +             emit(hash, ctx);
> > +}
> > +
> >  /*
> >   * Kernel addresses in the vmalloc space use at most 48 bits, and the
> >   * remaining bits are guaranteed to be 0x1. So we can compose the addr=
ess
> > @@ -474,7 +481,6 @@ static int build_prologue(struct jit_ctx *ctx, bool=
 ebpf_from_cbpf)
> >       const bool is_main_prog =3D !bpf_is_subprog(prog);
> >       const u8 fp =3D bpf2a64[BPF_REG_FP];
> >       const u8 arena_vm_base =3D bpf2a64[ARENA_VM_START];
> > -     const int idx0 =3D ctx->idx;
> >       int cur_offset;
> >
> >       /*
> > @@ -500,6 +506,9 @@ static int build_prologue(struct jit_ctx *ctx, bool=
 ebpf_from_cbpf)
> >        *
> >        */
> >
> > +     emit_kcfi(is_main_prog ? cfi_bpf_hash : cfi_bpf_subprog_hash, ctx=
);
> > +     const int idx0 =3D ctx->idx;
> > +
> >       /* bpf function may be invoked by 3 instruction types:
> >        * 1. bl, attached via freplace to bpf prog via short jump
> >        * 2. br, attached via freplace to bpf prog via long jump
> > @@ -2009,9 +2018,9 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_p=
rog *prog)
> >               jit_data->ro_header =3D ro_header;
> >       }
> >
> > -     prog->bpf_func =3D (void *)ctx.ro_image;
> > +     prog->bpf_func =3D (void *)ctx.ro_image + cfi_get_offset();
> >       prog->jited =3D 1;
> > -     prog->jited_len =3D prog_size;
> > +     prog->jited_len =3D prog_size - cfi_get_offset();
>
> Why do we add the offset even when CONFIG_CFI_CLANG is not enabled?

The function returns zero if CFI is not enabled, so I believe it's
just to avoid extra if (IS_ENABLED(CONFIG_CFI_CLANG)) statements in
the code. IMO this is cleaner, but I can certainly change this if you
prefer.

Thanks for taking a look!

Sami

