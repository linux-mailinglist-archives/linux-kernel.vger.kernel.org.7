Return-Path: <linux-kernel+bounces-736328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D47E2B09B92
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 08:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 419111C234D4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 06:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E2F1FDA8C;
	Fri, 18 Jul 2025 06:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="BLO8Rttl"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD281EDA03
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 06:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752820862; cv=none; b=lxbZU2SXoVqyJX9i8dZmHj+QkErmaQC+kGShHSdNcxEjxmXy086QKH1kH7ltW0p7fUo3Vw5tevdpfmimQ7pBXcRFbubZ6asX4CFRrx5/a5iYTUIQqNq8qWA9Dp9skphIk7YV/8vGFbzYIbeRLDvyzxOLrRDvIw0n63CQbS3g1fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752820862; c=relaxed/simple;
	bh=ATL6hMLXs6JKus3MhyX5eic0CZfZYiudcGoxF0SusTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K64ftI5ZWspL0G8+IjkjEYHG/1EaeMfpC8KNwMs6/+vWt4diM6GZfafKYd8BTyIVvLYVorS3KsBeQmkSIeeezEEFQDM6okOz0bmOYqx4ae1afFaYA45Pt0Qr0rpg7nJh4K9Jj+bSOM2Exz1OkYvYJa3T0S++REtAR2+KEDTNzGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=BLO8Rttl; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6159fb8b2aaso720414eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 23:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1752820859; x=1753425659; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X7dKWbZdVMrwFL5WdZSRxXUx2ZtPr1EjW0b8TdOPUJg=;
        b=BLO8RttlQLcQk270LwiXVYPyYW59KoquXrcxFh7r0HdI5HveaRX/qtfAkXmX7ksBAy
         1Gc3Rn2y73etF4OhBVpRWG+pOCmZcf45hsWniIN1OTUjn6GtWPzzq8Y0Qw2fEOpEdHIj
         wA8RnaaWRJcHm8fJPXmCjEBZ+PasLZ3yJOtEdZAknsvCjoccRNiyJ1gQoxLLr+gdNvO9
         k723TMvoQMQVMEQfxeIFRmUjOyP3Di/Ry5Nj4BVjJmcDqZNzvIVa1P+DUNXhD8TQS3S/
         gi0vo42TOgNEFZWewye2k9xH/nzI6TE0DfLzI6TITBM8emubUUNbQG3G4vwVrPfugyhS
         lZOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752820859; x=1753425659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X7dKWbZdVMrwFL5WdZSRxXUx2ZtPr1EjW0b8TdOPUJg=;
        b=qMoUbHv8e8yIS0Hm/n0iyA4I9QCvAxlkeUQBO0MAQ078shg/Tj/lkcuWkENu0/W/9D
         SeQnpZLSl9m4cnSIIvJ7VR12LvjY0dtTk5kswoBbGRO93uNT4jTnOk7yG4FJpqeMk6dZ
         5dnUOXEQF14u4KcCfFeK44JWHazlq+ca3+/5qmhuQeuqof7alDp6tyB+VrCSk9k544cU
         H+DGLvaH5gAyZKSK+/05T3K3NJhjrNFO2Bpf+4vhrSO6+2sg8DeoXcIZZlwS2wDKL3Ih
         dhhnfhDrhkdwXaY5MITza6pTakPUHvL0K64aTF8ozNbLWT4yz/jMgbmvN7cXQNHO+dpH
         r+Ww==
X-Forwarded-Encrypted: i=1; AJvYcCV3HEhHiSz2nJWUSVSByYD4G7Wi8V+qehGX3FF4g3MeC3D0Xf2zddSX+gdWVTotAstdu+g1xKv/XC9+hdg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY7UJ8zkDZV7fGqwgExX3L63Zx8W4lZT+umycHJqGlozRtg+eJ
	jfPijy9f+p1Ppz6tJ0//YVUv1IfHGcO//LOAQzl9gi3mpiQI0LJFBgWOC7aFZrBHghc/rwKMwk+
	f0X3qlC741AUDWjOiQyT+aWhG+u5JxQDDlvjFwKRN3A==
X-Gm-Gg: ASbGncvgDehbq5NkKZrjJNwI0YCNhx5qO3FwbFe5zRa3mM1xYOSB6rNWM26bznjEQlc
	fjpuLY1dc/XngN4sqxDpxzfk0r416ersHM3/2C+6ckFca/uZ7k/vEz4FgvUjWrnZjAJgRpEE5YL
	IKRIHI3b7W0RORKeILGLWvPhODGi0syj0Pr776aM68Mx8+yt/bhUvR/uN4mJ6nwipSxpWOpk7xz
	BDarNHw0nwrQVbNzOIQ8oSm
X-Google-Smtp-Source: AGHT+IGXQx+9+D6Byk3UXF81OJJT/N94+GYvK1ZOdYb5atejUT67iwYQFLmGj8mi5zdY0L0jDSNAUdYsuxI2RrKi4vk=
X-Received: by 2002:a4a:ee05:0:b0:615:b344:927 with SMTP id
 006d021491bc7-615b3440a8amr3164215eaf.3.1752820858950; Thu, 17 Jul 2025
 23:40:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618034328.21904-1-cuiyunhui@bytedance.com>
 <20250618034328.21904-2-cuiyunhui@bytedance.com> <c9ba6163-6703-441b-915c-d784044f862f@ghiti.fr>
 <b0583098-204a-4ad1-b173-4bd00a358d61@ghiti.fr>
In-Reply-To: <b0583098-204a-4ad1-b173-4bd00a358d61@ghiti.fr>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Fri, 18 Jul 2025 14:40:47 +0800
X-Gm-Features: Ac12FXwmaPFHuBEP0HhRKKK58IY4j11d1En-lve2np4vZlMrzO0q73zQBQvU45s
Message-ID: <CAEEQ3w=uz-kTe05-fnPa_BfkZ6ZocQHg-G001yBtLqRM2zEr+g@mail.gmail.com>
Subject: Re: [External] Re: [PATCH RFC 2/2] riscv: introduce percpu.h into include/asm
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: yury.norov@gmail.com, linux@rasmusvillemoes.dk, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, dennis@kernel.org, tj@kernel.org, cl@gentwo.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alex,

On Thu, Jul 17, 2025 at 9:06=E2=80=AFPM Alexandre Ghiti <alex@ghiti.fr> wro=
te:
>
> On 7/17/25 15:04, Alexandre Ghiti wrote:
> > Hi Yunhui,
> >
> > On 6/18/25 05:43, Yunhui Cui wrote:
> >> Current percpu operations rely on generic implementations, where
> >> raw_local_irq_save() introduces substantial overhead. Optimization
> >> is achieved through atomic operations and preemption disabling.
> >>
> >> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> >> ---
> >>   arch/riscv/include/asm/percpu.h | 138 ++++++++++++++++++++++++++++++=
++
> >>   1 file changed, 138 insertions(+)
> >>   create mode 100644 arch/riscv/include/asm/percpu.h
> >>
> >> diff --git a/arch/riscv/include/asm/percpu.h
> >> b/arch/riscv/include/asm/percpu.h
> >> new file mode 100644
> >> index 0000000000000..423c0d01f874c
> >> --- /dev/null
> >> +++ b/arch/riscv/include/asm/percpu.h
> >> @@ -0,0 +1,138 @@
> >> +/* SPDX-License-Identifier: GPL-2.0-only */
> >> +
> >> +#ifndef __ASM_PERCPU_H
> >> +#define __ASM_PERCPU_H
> >> +
> >> +#include <linux/preempt.h>
> >> +
> >> +#define PERCPU_RW_OPS(sz)                        \
> >> +static inline unsigned long __percpu_read_##sz(void *ptr)        \
> >> +{                                    \
> >> +    return READ_ONCE(*(u##sz *)ptr);                \
> >> +}                                    \
> >> +                                    \
> >> +static inline void __percpu_write_##sz(void *ptr, unsigned long
> >> val)    \
> >> +{                                    \
> >> +    WRITE_ONCE(*(u##sz *)ptr, (u##sz)val);                \
> >> +}
> >> +
> >> +#define __PERCPU_AMO_OP_CASE(sfx, name, sz, amo_insn)            \
> >> +static inline void                            \
> >> +__percpu_##name##_amo_case_##sz(void *ptr, unsigned long val)        =
\
> >> +{                                    \
> >> +    asm volatile (                            \
> >> +    "amo" #amo_insn #sfx " zero, %[val], %[ptr]"            \
> >> +    : [ptr] "+A" (*(u##sz *)ptr)                    \
> >> +    : [val] "r" ((u##sz)(val))                    \
> >> +    : "memory");                            \
> >> +}
> >> +
> >> +#define __PERCPU_AMO_RET_OP_CASE(sfx, name, sz, amo_insn)        \
> >> +static inline u##sz                            \
> >> +__percpu_##name##_return_amo_case_##sz(void *ptr, unsigned long
> >> val)    \
> >> +{                                    \
> >> +    register u##sz ret;                        \
> >> +                                    \
> >> +    asm volatile (                            \
> >> +    "amo" #amo_insn #sfx " %[ret], %[val], %[ptr]"            \
> >> +    : [ptr] "+A" (*(u##sz *)ptr), [ret] "=3Dr" (ret)            \
> >> +    : [val] "r" ((u##sz)(val))                    \
> >> +    : "memory");                            \
> >> +                                    \
> >> +    return ret + val;                        \
> >> +}
> >> +
> >> +#define PERCPU_OP(name, amo_insn)                    \
> >> +    __PERCPU_AMO_OP_CASE(.b, name, 8, amo_insn)            \
> >> +    __PERCPU_AMO_OP_CASE(.h, name, 16, amo_insn)            \
> >> +    __PERCPU_AMO_OP_CASE(.w, name, 32, amo_insn)            \
> >> +    __PERCPU_AMO_OP_CASE(.d, name, 64, amo_insn)            \
> >> +
> >> +#define PERCPU_RET_OP(name, amo_insn)                    \
> >> +    __PERCPU_AMO_RET_OP_CASE(.b, name, 8, amo_insn) \
> >> +    __PERCPU_AMO_RET_OP_CASE(.h, name, 16, amo_insn)        \
> >> +    __PERCPU_AMO_RET_OP_CASE(.w, name, 32, amo_insn)        \
> >> +    __PERCPU_AMO_RET_OP_CASE(.d, name, 64, amo_insn)
> >> +
> >> +PERCPU_RW_OPS(8)
> >> +PERCPU_RW_OPS(16)
> >> +PERCPU_RW_OPS(32)
> >> +PERCPU_RW_OPS(64)
> >> +
> >> +PERCPU_OP(add, add)
> >> +PERCPU_OP(andnot, and)
> >> +PERCPU_OP(or, or)
> >> +PERCPU_RET_OP(add, add)
> >> +
> >> +#undef PERCPU_RW_OPS
> >> +#undef __PERCPU_AMO_OP_CASE
> >> +#undef __PERCPU_AMO_RET_OP_CASE
> >> +#undef PERCPU_OP
> >> +#undef PERCPU_RET_OP
> >> +
> >> +#define _pcp_protect(op, pcp, ...)                    \
> >> +({                                    \
> >> +    preempt_disable_notrace();                    \
> >> +    op(raw_cpu_ptr(&(pcp)), __VA_ARGS__);                \
> >> +    preempt_enable_notrace();                    \
> >> +})
> >> +
> >> +#define _pcp_protect_return(op, pcp, args...)                \
> >> +({                                    \
> >> +    typeof(pcp) __retval;                        \
> >> +    preempt_disable_notrace();                    \
> >> +    __retval =3D (typeof(pcp))op(raw_cpu_ptr(&(pcp)), ##args);    \
> >> +    preempt_enable_notrace();                    \
> >> +    __retval;                            \
> >> +})
> >> +
> >> +#define this_cpu_read_1(pcp) _pcp_protect_return(__percpu_read_8, pcp=
)
> >> +#define this_cpu_read_2(pcp) _pcp_protect_return(__percpu_read_16, pc=
p)
> >> +#define this_cpu_read_4(pcp) _pcp_protect_return(__percpu_read_32, pc=
p)
> >> +#define this_cpu_read_8(pcp) _pcp_protect_return(__percpu_read_64, pc=
p)
> >> +
> >> +#define this_cpu_write_1(pcp, val) _pcp_protect(__percpu_write_8,
> >> pcp, (unsigned long)val)
> >> +#define this_cpu_write_2(pcp, val) _pcp_protect(__percpu_write_16,
> >> pcp, (unsigned long)val)
> >> +#define this_cpu_write_4(pcp, val) _pcp_protect(__percpu_write_32,
> >> pcp, (unsigned long)val)
> >> +#define this_cpu_write_8(pcp, val) _pcp_protect(__percpu_write_64,
> >> pcp, (unsigned long)val)
> >> +
> >> +#define this_cpu_add_1(pcp, val)
> >> _pcp_protect(__percpu_add_amo_case_8, pcp, val)
> >> +#define this_cpu_add_2(pcp, val)
> >> _pcp_protect(__percpu_add_amo_case_16, pcp, val)
> >> +#define this_cpu_add_4(pcp, val)
> >> _pcp_protect(__percpu_add_amo_case_32, pcp, val)
> >> +#define this_cpu_add_8(pcp, val)
> >> _pcp_protect(__percpu_add_amo_case_64, pcp, val)
> >> +
> >> +#define this_cpu_add_return_1(pcp, val)        \
> >> +_pcp_protect_return(__percpu_add_return_amo_case_8, pcp, val)
> >> +
> >> +#define this_cpu_add_return_2(pcp, val)        \
> >> +_pcp_protect_return(__percpu_add_return_amo_case_16, pcp, val)
> >> +
> >> +#define this_cpu_add_return_4(pcp, val)        \
> >> +_pcp_protect_return(__percpu_add_return_amo_case_32, pcp, val)
> >> +
> >> +#define this_cpu_add_return_8(pcp, val)        \
> >> +_pcp_protect_return(__percpu_add_return_amo_case_64, pcp, val)
> >> +
> >> +#define this_cpu_and_1(pcp, val)
> >> _pcp_protect(__percpu_andnot_amo_case_8, pcp, ~val)
> >> +#define this_cpu_and_2(pcp, val)
> >> _pcp_protect(__percpu_andnot_amo_case_16, pcp, ~val)
> >> +#define this_cpu_and_4(pcp, val)
> >> _pcp_protect(__percpu_andnot_amo_case_32, pcp, ~val)
> >> +#define this_cpu_and_8(pcp, val)
> >> _pcp_protect(__percpu_andnot_amo_case_64, pcp, ~val)
> >
> >
> > Why do we define __percpu_andnot based on amoand, and use
> > __percpu_andnot with ~val here? Can't we just define __percpu_and?
> >
> >
> >> +
> >> +#define this_cpu_or_1(pcp, val) _pcp_protect(__percpu_or_amo_case_8,
> >> pcp, val)
> >> +#define this_cpu_or_2(pcp, val)
> >> _pcp_protect(__percpu_or_amo_case_16, pcp, val)
> >> +#define this_cpu_or_4(pcp, val)
> >> _pcp_protect(__percpu_or_amo_case_32, pcp, val)
> >> +#define this_cpu_or_8(pcp, val)
> >> _pcp_protect(__percpu_or_amo_case_64, pcp, val)
> >> +
> >> +#define this_cpu_xchg_1(pcp, val) _pcp_protect_return(xchg_relaxed,
> >> pcp, val)
> >> +#define this_cpu_xchg_2(pcp, val) _pcp_protect_return(xchg_relaxed,
> >> pcp, val)
> >> +#define this_cpu_xchg_4(pcp, val) _pcp_protect_return(xchg_relaxed,
> >> pcp, val)
> >> +#define this_cpu_xchg_8(pcp, val) _pcp_protect_return(xchg_relaxed,
> >> pcp, val)
> >> +
> >> +#define this_cpu_cmpxchg_1(pcp, o, n)
> >> _pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
> >> +#define this_cpu_cmpxchg_2(pcp, o, n)
> >> _pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
> >> +#define this_cpu_cmpxchg_4(pcp, o, n)
> >> _pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
> >> +#define this_cpu_cmpxchg_8(pcp, o, n)
> >> _pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
> >> +
> >> +#include <asm-generic/percpu.h>
> >> +
> >> +#endif /* __ASM_PERCPU_H */
> >
> >
> > It all looks good to me, just one thing, can you also implement
> > this_cpu_cmpxchg64/128()?
> >
>
> One last thing sorry, can you add a cover letter too?

Okay.

>
> Thanks!
>
> Alex
>
>
> > And since this is almost a copy/paste from arm64, either mention it at
> > the top of the file or (better) merge both implementations somewhere
> > to avoid redefining existing code :) But up to you.

Actually, there's a concern here. We should account for scenarios
where ZABHA isn't supported. Given that xxx_8() and xxx_16() are
rarely used in practice, could we initially support only xxx_32() and
xxx_64()? For xxx_8() and xxx_16(), we could default to the generic
implementation.


> >
> > Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> >
> > Thanks,
> >
> > Alex
> >
> >
> >

Thanks,
Yunhui

