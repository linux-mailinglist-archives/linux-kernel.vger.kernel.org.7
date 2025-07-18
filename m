Return-Path: <linux-kernel+bounces-736994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4959AB0A668
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 16:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84C5C565E4C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 14:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DE52DAFDD;
	Fri, 18 Jul 2025 14:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="LhvIlzGO"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598473398B
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 14:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752849249; cv=none; b=L7KMbJpP2qOsjFAoTVc6zsw116OhiJueU5WqjitkM39UOA5YeLYM5wlkxeMxN7wm2ZNeSrY0lHlL6/wY9gUGkkm0PkOUzqFsbKoAb1g6UJXleHL7hOCZ17wvvPIBYmOEa2rwe0s6qHaNXGwUKkpZtWi1ATRXNxU1F9YAZcYIIEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752849249; c=relaxed/simple;
	bh=iz1GmugjNYaAjPevS3vCG9GNc21f7NJwOlozcRQg+gg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=orx6ETakyJ9EIZ0SZtzpKHP4xi/n8IrV67ITchjX+QiIZ+C0HS4PmFrYz9vzLmrz4hJtJZLe7V55vaE0jNh8I3j9+bzTq3t/2qU59SSRwxanwo9AkINoVWIcsKxiQIGPBFrx8X72HQzaZ/pIqMR1Bw3a0UppcYSlLFJk3YNprxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=LhvIlzGO; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-615913ff67fso1365971eaf.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 07:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1752849246; x=1753454046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bWzhDhdiFr0536BRqzyoEm8becCS9ZtrzmuFNx2GoNA=;
        b=LhvIlzGOzOi2aKKaxbxkILOyBYmFHvY4fLRBli6Wrz+iFpCKwBaXW43dRrAJjddudb
         hstzHT76T71geDFg4yldLg75aYxnimDl3FwpNs1tRR9kG+uuULr6F7479kbM3v7yNLD0
         vwGIX21QghcGKvJMuTR/aVL59RQzg3XypdjlnjwKbvvEYdikCsXvYROPVXEgbN34xHFx
         Iouzaq5xWTnELOI9WtMUCFIMVFU4T1Z/4c+tXY4PGA/fQM8W4T90mBS6CWkreGb+H5dk
         ZmKlPxkzdnsdtagRNcYuTphT9HIyLSk1J+wEW3KUlWXv8S5rrM3ZMsuat7yanpbb4sqY
         ZSsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752849246; x=1753454046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bWzhDhdiFr0536BRqzyoEm8becCS9ZtrzmuFNx2GoNA=;
        b=d1PUZuWL0TpIl0VyeA6xgPqRwyRdeOLa4x3AuBEoHT1Y0AwDn0oqqhu45iQuylulvL
         lkCa6Mbjx38VbBhvFGWhnEcjL8XeSp7kHRT+xeZhP+2ZPxbjr6VZIRnDilTrO0zrMFhe
         KCaWCyAbl1bj8OQSxE6vVTpvMMBDdTbq2+FEEsUMDxwIrDidxnupQ6vfWPZHbHCl9jR4
         eZcrxpN4dpnMmjRlTWjuG2NRHB/3F/EEXi9cSwyLI0wBr2ExkHQRHE6fcs//GmGFaUXX
         F9a0t5QxDWj9TKenbwjCD9sPQZ8oZAzvjLKTviFh+WBakP1Z/HWNGAtJauiImrrqCSVz
         EbbQ==
X-Forwarded-Encrypted: i=1; AJvYcCViNGVxhjIP0iAHjDy0+9Cs6vC2VIMKRVz/hFL4CF8F5Cm+JtsR+vEROqmADEE3Wg/lfizfOLBZKLL2Lqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX5iemPCZCk+pZ8IWD2+fwwen312LwbVLck32LcWY6R8Xh+fep
	+B9otrYidMBoj98unSC5hJPtxUoGnIuZmpSZXFnoLkYV9xcr2Rr+hE1E55hiLjkADJox15Q+IR7
	6I0MO0uD06aiJ/wEm4PzDD4RcLlE1d0GUA7dbRvoazQ==
X-Gm-Gg: ASbGnctM+/2msDo9XlQNnnOEuZ1XcSHMcGRHtla0JWr9G85ffp1TCcJvgIVldP/YyOv
	JOsSWmjOjsBYU9n73p7fxMl4jvy8LbStp+G/T4Xk853dWJuvLPx5Upvt6wueHwQ7dCpnlW7n7HS
	xsoRFLOrw6s5n9LOmnbSde0MyhFEnGm4MPS7tRXT2PHFq/nI/z9D/kmteiKndmuU2vHYz5R6LcL
	JEZhgl/SA==
X-Google-Smtp-Source: AGHT+IEHkurpOPtUp6OR3kn00/uY/HZ2UhpECPN3W/Tg9e2NmMIkABeCYHxhO9+UZXpYExhWb/47mYBBDH6C49i9MLg=
X-Received: by 2002:a05:6820:4de7:b0:611:adce:2cb4 with SMTP id
 006d021491bc7-615accb4d53mr4933477eaf.3.1752849246312; Fri, 18 Jul 2025
 07:34:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618034328.21904-1-cuiyunhui@bytedance.com>
 <20250618034328.21904-2-cuiyunhui@bytedance.com> <c9ba6163-6703-441b-915c-d784044f862f@ghiti.fr>
 <b0583098-204a-4ad1-b173-4bd00a358d61@ghiti.fr> <CAEEQ3w=uz-kTe05-fnPa_BfkZ6ZocQHg-G001yBtLqRM2zEr+g@mail.gmail.com>
 <404d38d7-f21b-4c97-b851-8b331deb3f8a@ghiti.fr>
In-Reply-To: <404d38d7-f21b-4c97-b851-8b331deb3f8a@ghiti.fr>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Fri, 18 Jul 2025 22:33:55 +0800
X-Gm-Features: Ac12FXxpxLAOCgYhedquCSjid6kKOf5qoRGghZ8OElxrVL9g9z3nooKBwWcqkL4
Message-ID: <CAEEQ3wknpn0Y6H8A-MEk-9hkvUwv0VapbtBR97Qhz9ipCk2Jew@mail.gmail.com>
Subject: Re: [External] Re: [PATCH RFC 2/2] riscv: introduce percpu.h into include/asm
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: yury.norov@gmail.com, linux@rasmusvillemoes.dk, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, dennis@kernel.org, tj@kernel.org, cl@gentwo.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alex=EF=BC=8C

On Fri, Jul 18, 2025 at 10:23=E2=80=AFPM Alexandre Ghiti <alex@ghiti.fr> wr=
ote:
>
> Hi Yunhui,
>
> On 7/18/25 08:40, yunhui cui wrote:
> > Hi Alex,
> >
> > On Thu, Jul 17, 2025 at 9:06=E2=80=AFPM Alexandre Ghiti <alex@ghiti.fr>=
 wrote:
> >> On 7/17/25 15:04, Alexandre Ghiti wrote:
> >>> Hi Yunhui,
> >>>
> >>> On 6/18/25 05:43, Yunhui Cui wrote:
> >>>> Current percpu operations rely on generic implementations, where
> >>>> raw_local_irq_save() introduces substantial overhead. Optimization
> >>>> is achieved through atomic operations and preemption disabling.
> >>>>
> >>>> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> >>>> ---
> >>>>    arch/riscv/include/asm/percpu.h | 138 +++++++++++++++++++++++++++=
+++++
> >>>>    1 file changed, 138 insertions(+)
> >>>>    create mode 100644 arch/riscv/include/asm/percpu.h
> >>>>
> >>>> diff --git a/arch/riscv/include/asm/percpu.h
> >>>> b/arch/riscv/include/asm/percpu.h
> >>>> new file mode 100644
> >>>> index 0000000000000..423c0d01f874c
> >>>> --- /dev/null
> >>>> +++ b/arch/riscv/include/asm/percpu.h
> >>>> @@ -0,0 +1,138 @@
> >>>> +/* SPDX-License-Identifier: GPL-2.0-only */
> >>>> +
> >>>> +#ifndef __ASM_PERCPU_H
> >>>> +#define __ASM_PERCPU_H
> >>>> +
> >>>> +#include <linux/preempt.h>
> >>>> +
> >>>> +#define PERCPU_RW_OPS(sz)                        \
> >>>> +static inline unsigned long __percpu_read_##sz(void *ptr)        \
> >>>> +{                                    \
> >>>> +    return READ_ONCE(*(u##sz *)ptr);                \
> >>>> +}                                    \
> >>>> +                                    \
> >>>> +static inline void __percpu_write_##sz(void *ptr, unsigned long
> >>>> val)    \
> >>>> +{                                    \
> >>>> +    WRITE_ONCE(*(u##sz *)ptr, (u##sz)val);                \
> >>>> +}
> >>>> +
> >>>> +#define __PERCPU_AMO_OP_CASE(sfx, name, sz, amo_insn)            \
> >>>> +static inline void                            \
> >>>> +__percpu_##name##_amo_case_##sz(void *ptr, unsigned long val)      =
  \
> >>>> +{                                    \
> >>>> +    asm volatile (                            \
> >>>> +    "amo" #amo_insn #sfx " zero, %[val], %[ptr]"            \
> >>>> +    : [ptr] "+A" (*(u##sz *)ptr)                    \
> >>>> +    : [val] "r" ((u##sz)(val))                    \
> >>>> +    : "memory");                            \
> >>>> +}
> >>>> +
> >>>> +#define __PERCPU_AMO_RET_OP_CASE(sfx, name, sz, amo_insn)        \
> >>>> +static inline u##sz                            \
> >>>> +__percpu_##name##_return_amo_case_##sz(void *ptr, unsigned long
> >>>> val)    \
> >>>> +{                                    \
> >>>> +    register u##sz ret;                        \
> >>>> +                                    \
> >>>> +    asm volatile (                            \
> >>>> +    "amo" #amo_insn #sfx " %[ret], %[val], %[ptr]"            \
> >>>> +    : [ptr] "+A" (*(u##sz *)ptr), [ret] "=3Dr" (ret)            \
> >>>> +    : [val] "r" ((u##sz)(val))                    \
> >>>> +    : "memory");                            \
> >>>> +                                    \
> >>>> +    return ret + val;                        \
> >>>> +}
> >>>> +
> >>>> +#define PERCPU_OP(name, amo_insn)                    \
> >>>> +    __PERCPU_AMO_OP_CASE(.b, name, 8, amo_insn)            \
> >>>> +    __PERCPU_AMO_OP_CASE(.h, name, 16, amo_insn)            \
> >>>> +    __PERCPU_AMO_OP_CASE(.w, name, 32, amo_insn)            \
> >>>> +    __PERCPU_AMO_OP_CASE(.d, name, 64, amo_insn)            \
> >>>> +
> >>>> +#define PERCPU_RET_OP(name, amo_insn)                    \
> >>>> +    __PERCPU_AMO_RET_OP_CASE(.b, name, 8, amo_insn) \
> >>>> +    __PERCPU_AMO_RET_OP_CASE(.h, name, 16, amo_insn)        \
> >>>> +    __PERCPU_AMO_RET_OP_CASE(.w, name, 32, amo_insn)        \
> >>>> +    __PERCPU_AMO_RET_OP_CASE(.d, name, 64, amo_insn)
> >>>> +
> >>>> +PERCPU_RW_OPS(8)
> >>>> +PERCPU_RW_OPS(16)
> >>>> +PERCPU_RW_OPS(32)
> >>>> +PERCPU_RW_OPS(64)
> >>>> +
> >>>> +PERCPU_OP(add, add)
> >>>> +PERCPU_OP(andnot, and)
> >>>> +PERCPU_OP(or, or)
> >>>> +PERCPU_RET_OP(add, add)
> >>>> +
> >>>> +#undef PERCPU_RW_OPS
> >>>> +#undef __PERCPU_AMO_OP_CASE
> >>>> +#undef __PERCPU_AMO_RET_OP_CASE
> >>>> +#undef PERCPU_OP
> >>>> +#undef PERCPU_RET_OP
> >>>> +
> >>>> +#define _pcp_protect(op, pcp, ...)                    \
> >>>> +({                                    \
> >>>> +    preempt_disable_notrace();                    \
> >>>> +    op(raw_cpu_ptr(&(pcp)), __VA_ARGS__);                \
> >>>> +    preempt_enable_notrace();                    \
> >>>> +})
> >>>> +
> >>>> +#define _pcp_protect_return(op, pcp, args...)                \
> >>>> +({                                    \
> >>>> +    typeof(pcp) __retval;                        \
> >>>> +    preempt_disable_notrace();                    \
> >>>> +    __retval =3D (typeof(pcp))op(raw_cpu_ptr(&(pcp)), ##args);    \
> >>>> +    preempt_enable_notrace();                    \
> >>>> +    __retval;                            \
> >>>> +})
> >>>> +
> >>>> +#define this_cpu_read_1(pcp) _pcp_protect_return(__percpu_read_8, p=
cp)
> >>>> +#define this_cpu_read_2(pcp) _pcp_protect_return(__percpu_read_16, =
pcp)
> >>>> +#define this_cpu_read_4(pcp) _pcp_protect_return(__percpu_read_32, =
pcp)
> >>>> +#define this_cpu_read_8(pcp) _pcp_protect_return(__percpu_read_64, =
pcp)
> >>>> +
> >>>> +#define this_cpu_write_1(pcp, val) _pcp_protect(__percpu_write_8,
> >>>> pcp, (unsigned long)val)
> >>>> +#define this_cpu_write_2(pcp, val) _pcp_protect(__percpu_write_16,
> >>>> pcp, (unsigned long)val)
> >>>> +#define this_cpu_write_4(pcp, val) _pcp_protect(__percpu_write_32,
> >>>> pcp, (unsigned long)val)
> >>>> +#define this_cpu_write_8(pcp, val) _pcp_protect(__percpu_write_64,
> >>>> pcp, (unsigned long)val)
> >>>> +
> >>>> +#define this_cpu_add_1(pcp, val)
> >>>> _pcp_protect(__percpu_add_amo_case_8, pcp, val)
> >>>> +#define this_cpu_add_2(pcp, val)
> >>>> _pcp_protect(__percpu_add_amo_case_16, pcp, val)
> >>>> +#define this_cpu_add_4(pcp, val)
> >>>> _pcp_protect(__percpu_add_amo_case_32, pcp, val)
> >>>> +#define this_cpu_add_8(pcp, val)
> >>>> _pcp_protect(__percpu_add_amo_case_64, pcp, val)
> >>>> +
> >>>> +#define this_cpu_add_return_1(pcp, val)        \
> >>>> +_pcp_protect_return(__percpu_add_return_amo_case_8, pcp, val)
> >>>> +
> >>>> +#define this_cpu_add_return_2(pcp, val)        \
> >>>> +_pcp_protect_return(__percpu_add_return_amo_case_16, pcp, val)
> >>>> +
> >>>> +#define this_cpu_add_return_4(pcp, val)        \
> >>>> +_pcp_protect_return(__percpu_add_return_amo_case_32, pcp, val)
> >>>> +
> >>>> +#define this_cpu_add_return_8(pcp, val)        \
> >>>> +_pcp_protect_return(__percpu_add_return_amo_case_64, pcp, val)
> >>>> +
> >>>> +#define this_cpu_and_1(pcp, val)
> >>>> _pcp_protect(__percpu_andnot_amo_case_8, pcp, ~val)
> >>>> +#define this_cpu_and_2(pcp, val)
> >>>> _pcp_protect(__percpu_andnot_amo_case_16, pcp, ~val)
> >>>> +#define this_cpu_and_4(pcp, val)
> >>>> _pcp_protect(__percpu_andnot_amo_case_32, pcp, ~val)
> >>>> +#define this_cpu_and_8(pcp, val)
> >>>> _pcp_protect(__percpu_andnot_amo_case_64, pcp, ~val)
> >>>
> >>> Why do we define __percpu_andnot based on amoand, and use
> >>> __percpu_andnot with ~val here? Can't we just define __percpu_and?
>
>
> What about that ^?
>
>
> >>>
> >>>> +
> >>>> +#define this_cpu_or_1(pcp, val) _pcp_protect(__percpu_or_amo_case_8=
,
> >>>> pcp, val)
> >>>> +#define this_cpu_or_2(pcp, val)
> >>>> _pcp_protect(__percpu_or_amo_case_16, pcp, val)
> >>>> +#define this_cpu_or_4(pcp, val)
> >>>> _pcp_protect(__percpu_or_amo_case_32, pcp, val)
> >>>> +#define this_cpu_or_8(pcp, val)
> >>>> _pcp_protect(__percpu_or_amo_case_64, pcp, val)
> >>>> +
> >>>> +#define this_cpu_xchg_1(pcp, val) _pcp_protect_return(xchg_relaxed,
> >>>> pcp, val)
> >>>> +#define this_cpu_xchg_2(pcp, val) _pcp_protect_return(xchg_relaxed,
> >>>> pcp, val)
> >>>> +#define this_cpu_xchg_4(pcp, val) _pcp_protect_return(xchg_relaxed,
> >>>> pcp, val)
> >>>> +#define this_cpu_xchg_8(pcp, val) _pcp_protect_return(xchg_relaxed,
> >>>> pcp, val)
> >>>> +
> >>>> +#define this_cpu_cmpxchg_1(pcp, o, n)
> >>>> _pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
> >>>> +#define this_cpu_cmpxchg_2(pcp, o, n)
> >>>> _pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
> >>>> +#define this_cpu_cmpxchg_4(pcp, o, n)
> >>>> _pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
> >>>> +#define this_cpu_cmpxchg_8(pcp, o, n)
> >>>> _pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
> >>>> +
> >>>> +#include <asm-generic/percpu.h>
> >>>> +
> >>>> +#endif /* __ASM_PERCPU_H */
> >>>
> >>> It all looks good to me, just one thing, can you also implement
> >>> this_cpu_cmpxchg64/128()?
> >>>
> >> One last thing sorry, can you add a cover letter too?
> > Okay.
> >
> >> Thanks!
> >>
> >> Alex
> >>
> >>
> >>> And since this is almost a copy/paste from arm64, either mention it a=
t
> >>> the top of the file or (better) merge both implementations somewhere
> >>> to avoid redefining existing code :) But up to you.
> > Actually, there's a concern here. We should account for scenarios
> > where ZABHA isn't supported. Given that xxx_8() and xxx_16() are
> > rarely used in practice, could we initially support only xxx_32() and
> > xxx_64()? For xxx_8() and xxx_16(), we could default to the generic
> > implementation.
>
>
> Why isn't lr/sc enough?

If I'm not mistaken, the current RISC-V does not support lr.bh/sc.bh,
is that right?

>
>
> >
> >
> >>> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> >>>
> >>> Thanks,
> >>>
> >>> Alex
> >>>
> >>>
> >>>
> > Thanks,
> > Yunhui
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv

Thanks,
Yunhui

