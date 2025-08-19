Return-Path: <linux-kernel+bounces-775724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9589B2C413
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 14:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC839188EBC5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235A42773C9;
	Tue, 19 Aug 2025 12:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="SdlpfX4G"
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9533221FB4
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 12:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755607523; cv=none; b=nXH487sa+NPdDzZBZMc4gaVshGpGgAvDHz5XotLIBiT5wbDe6gKUFVs+S3k4KJxWd/dCMCgu5+YC6fnnO+USc+96NI+poIZkGT9INMK6zj7aGqEzO63OtoaUTQrdUSIKrPqpW/hJkfJ7m7WlauY4FYLvZTrSFpInQPkLB+/Tea8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755607523; c=relaxed/simple;
	bh=eC+7jGhi8xVb5K+wAB+kDlAPOJzipHGmyJmQwoEycVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RxpLyCtNrfdiMaUxts6u5Nj389ZuMg77jl9uzJIczhk5mJPeQYKAlnCfwAnF6AE57RhFKkBSUzR6xLcwWHun9RoVpbT0faNDstNwDHbfS/polmQNy29gjUiWy8ES+Gu874X6Krf4ocFLmsLyVRJEJw2TXt4jGXo9w2Dy8xQn9l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=SdlpfX4G; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-61bd4e002afso1400209eaf.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 05:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1755607520; x=1756212320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FUojvKeMBqfwF4oHIlHpGQRStzsw4ZB/bPNyhGSltUU=;
        b=SdlpfX4GcHisDfryNl6UqAvJr2SwRI+ZI5KLt4Lb9RfBfMYooUU0DWlIdoEROKlV0z
         QSQ5wIgwrlOVtpufNBE8fWKAOpYD6FJ/jsV2c7+xF/HparMzmOM4MTzLdCbVxn/YyPi1
         IXf2CeKO4ue1ISaskwOzr03Hw8mnYGoc82ocHc4PfJi9o0eA5QjEo9rYmNzHi9yFqr3g
         1cpw2s2allNCTyDdo186aRcCCAMPWcpU6rlhlDGQky237G5Wa+1Y1WtgttkYs/qLxgIy
         X+iyZfILA0UomslyP/DtrfIbqMihXE3frfyr0jrrqlvsdFHRdtmndh1hGYIij8Sc8jnL
         ukgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755607520; x=1756212320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FUojvKeMBqfwF4oHIlHpGQRStzsw4ZB/bPNyhGSltUU=;
        b=kriCdzLGQRIjdxXaTPhro9SktuGU3URNToqCednio0OnbZXhy50CB15H9qs6RMLwHh
         fmYbbl5M2kxt4UlPJ1X2itT6mzsRKG42oOO2O3TkLiZG7Spuh+HcStkC3UEJIKBLPJu5
         FerCm5UIgU3YXgM70eFZvxi8S+8/E2YI7gNDHAshOC0egPMpQomNYQ3OWroSdkmh7qPc
         4O7tJtG5hkH2LAtJAQUwoGzVsHD4RVbwrQrlMEcY/dSWgHafhgHd2nPGN02d/z+SFCAy
         eJfjSX3v8WEkofT3figoIyindlCkDpF6xxBqiQxcvi7zGKCC3mc9jJOT8ZyqBUzQbRbX
         b31Q==
X-Forwarded-Encrypted: i=1; AJvYcCWN7H1FZtNEBTzCmRt6srVfJx808/XKTleSYmgd+GTygWACMEm7N0t8Hc+PXJxQbfiDMnzmzSAIId3N7KM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwUiI1wXWJQ898KVLjeNUEa3yM4Vm0ot4OCWmlz7n7NNbi75xn
	ATgRASE5WcX/+QxIYG53ImgjBdxYXD4B51bi6G4pjIoDInxzOdxeNWnze91oaCstYpQpVFYmLAr
	aJFPt/ekoFvSoNQBbiUlXEhrDL2IATwueccAZ9BBsXA==
X-Gm-Gg: ASbGncs7/Eje0xVbkr2LaQ6kspeX9LLEJ0D4stgHPU/HqkR8Aye36aWqttB2qKN678Q
	yB7vFVncvphghQuTeShpObu39IdUEKJmll8zLJoZ3SQPtJKEaQYso5WafAOdH+xD8+UUjZqC3CX
	VlYzRrlmMCJnh9OEb5SAkRINL4LCiDCZM2aZ1zJdjuOrVOJ9JKJCDXD7JzZ/FSHpbys0qFk8A1r
	1z488s1q82YZEhW9qSgUGH/1Xd5
X-Google-Smtp-Source: AGHT+IG1P73YNABywoBqFugfnLVsaKoash1sBuVSd1ClslQnR6v+KIcsSELoKISWQ8BcxeVjtLvfgi6rGdRvY1EJbps=
X-Received: by 2002:a05:6808:4497:b0:435:8506:1b40 with SMTP id
 5614622812f47-436c12bdc8emr1500322b6e.0.1755607520124; Tue, 19 Aug 2025
 05:45:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618034328.21904-1-cuiyunhui@bytedance.com>
 <20250618034328.21904-2-cuiyunhui@bytedance.com> <c9ba6163-6703-441b-915c-d784044f862f@ghiti.fr>
 <b0583098-204a-4ad1-b173-4bd00a358d61@ghiti.fr> <CAEEQ3w=uz-kTe05-fnPa_BfkZ6ZocQHg-G001yBtLqRM2zEr+g@mail.gmail.com>
 <404d38d7-f21b-4c97-b851-8b331deb3f8a@ghiti.fr> <CAEEQ3wknpn0Y6H8A-MEk-9hkvUwv0VapbtBR97Qhz9ipCk2Jew@mail.gmail.com>
 <416b8286-7c78-4c56-8328-5e1b99bf15d4@ghiti.fr>
In-Reply-To: <416b8286-7c78-4c56-8328-5e1b99bf15d4@ghiti.fr>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Tue, 19 Aug 2025 20:45:08 +0800
X-Gm-Features: Ac12FXzdvyJ1fET3KfuvaYRhHbOu4YJdVzd-_7iXNtQL0eIHLkP87MM3NeJ87Bk
Message-ID: <CAEEQ3wkoNFmL1h2CXu9jfmVZfBmAC9ZiTo1vLQ8Xcohc9g9J2A@mail.gmail.com>
Subject: Re: [External] Re: [PATCH RFC 2/2] riscv: introduce percpu.h into include/asm
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: yury.norov@gmail.com, linux@rasmusvillemoes.dk, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, dennis@kernel.org, tj@kernel.org, cl@gentwo.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alex,

On Thu, Aug 7, 2025 at 10:55=E2=80=AFPM Alexandre Ghiti <alex@ghiti.fr> wro=
te:
>
> Hi Yunhui,
>
> On 7/18/25 16:33, yunhui cui wrote:
> > Hi Alex=EF=BC=8C
> >
> > On Fri, Jul 18, 2025 at 10:23=E2=80=AFPM Alexandre Ghiti <alex@ghiti.fr=
> wrote:
> >> Hi Yunhui,
> >>
> >> On 7/18/25 08:40, yunhui cui wrote:
> >>> Hi Alex,
> >>>
> >>> On Thu, Jul 17, 2025 at 9:06=E2=80=AFPM Alexandre Ghiti <alex@ghiti.f=
r> wrote:
> >>>> On 7/17/25 15:04, Alexandre Ghiti wrote:
> >>>>> Hi Yunhui,
> >>>>>
> >>>>> On 6/18/25 05:43, Yunhui Cui wrote:
> >>>>>> Current percpu operations rely on generic implementations, where
> >>>>>> raw_local_irq_save() introduces substantial overhead. Optimization
> >>>>>> is achieved through atomic operations and preemption disabling.
> >>>>>>
> >>>>>> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> >>>>>> ---
> >>>>>>     arch/riscv/include/asm/percpu.h | 138 ++++++++++++++++++++++++=
++++++++
> >>>>>>     1 file changed, 138 insertions(+)
> >>>>>>     create mode 100644 arch/riscv/include/asm/percpu.h
> >>>>>>
> >>>>>> diff --git a/arch/riscv/include/asm/percpu.h
> >>>>>> b/arch/riscv/include/asm/percpu.h
> >>>>>> new file mode 100644
> >>>>>> index 0000000000000..423c0d01f874c
> >>>>>> --- /dev/null
> >>>>>> +++ b/arch/riscv/include/asm/percpu.h
> >>>>>> @@ -0,0 +1,138 @@
> >>>>>> +/* SPDX-License-Identifier: GPL-2.0-only */
> >>>>>> +
> >>>>>> +#ifndef __ASM_PERCPU_H
> >>>>>> +#define __ASM_PERCPU_H
> >>>>>> +
> >>>>>> +#include <linux/preempt.h>
> >>>>>> +
> >>>>>> +#define PERCPU_RW_OPS(sz)                        \
> >>>>>> +static inline unsigned long __percpu_read_##sz(void *ptr)        =
\
> >>>>>> +{                                    \
> >>>>>> +    return READ_ONCE(*(u##sz *)ptr);                \
> >>>>>> +}                                    \
> >>>>>> +                                    \
> >>>>>> +static inline void __percpu_write_##sz(void *ptr, unsigned long
> >>>>>> val)    \
> >>>>>> +{                                    \
> >>>>>> +    WRITE_ONCE(*(u##sz *)ptr, (u##sz)val);                \
> >>>>>> +}
> >>>>>> +
> >>>>>> +#define __PERCPU_AMO_OP_CASE(sfx, name, sz, amo_insn)            =
\
> >>>>>> +static inline void                            \
> >>>>>> +__percpu_##name##_amo_case_##sz(void *ptr, unsigned long val)    =
    \
> >>>>>> +{                                    \
> >>>>>> +    asm volatile (                            \
> >>>>>> +    "amo" #amo_insn #sfx " zero, %[val], %[ptr]"            \
> >>>>>> +    : [ptr] "+A" (*(u##sz *)ptr)                    \
> >>>>>> +    : [val] "r" ((u##sz)(val))                    \
> >>>>>> +    : "memory");                            \
> >>>>>> +}
> >>>>>> +
> >>>>>> +#define __PERCPU_AMO_RET_OP_CASE(sfx, name, sz, amo_insn)        =
\
> >>>>>> +static inline u##sz                            \
> >>>>>> +__percpu_##name##_return_amo_case_##sz(void *ptr, unsigned long
> >>>>>> val)    \
> >>>>>> +{                                    \
> >>>>>> +    register u##sz ret;                        \
> >>>>>> +                                    \
> >>>>>> +    asm volatile (                            \
> >>>>>> +    "amo" #amo_insn #sfx " %[ret], %[val], %[ptr]"            \
> >>>>>> +    : [ptr] "+A" (*(u##sz *)ptr), [ret] "=3Dr" (ret)            \
> >>>>>> +    : [val] "r" ((u##sz)(val))                    \
> >>>>>> +    : "memory");                            \
> >>>>>> +                                    \
> >>>>>> +    return ret + val;                        \
> >>>>>> +}
> >>>>>> +
> >>>>>> +#define PERCPU_OP(name, amo_insn)                    \
> >>>>>> +    __PERCPU_AMO_OP_CASE(.b, name, 8, amo_insn)            \
> >>>>>> +    __PERCPU_AMO_OP_CASE(.h, name, 16, amo_insn)            \
> >>>>>> +    __PERCPU_AMO_OP_CASE(.w, name, 32, amo_insn)            \
> >>>>>> +    __PERCPU_AMO_OP_CASE(.d, name, 64, amo_insn)            \
> >>>>>> +
> >>>>>> +#define PERCPU_RET_OP(name, amo_insn)                    \
> >>>>>> +    __PERCPU_AMO_RET_OP_CASE(.b, name, 8, amo_insn) \
> >>>>>> +    __PERCPU_AMO_RET_OP_CASE(.h, name, 16, amo_insn)        \
> >>>>>> +    __PERCPU_AMO_RET_OP_CASE(.w, name, 32, amo_insn)        \
> >>>>>> +    __PERCPU_AMO_RET_OP_CASE(.d, name, 64, amo_insn)
> >>>>>> +
> >>>>>> +PERCPU_RW_OPS(8)
> >>>>>> +PERCPU_RW_OPS(16)
> >>>>>> +PERCPU_RW_OPS(32)
> >>>>>> +PERCPU_RW_OPS(64)
> >>>>>> +
> >>>>>> +PERCPU_OP(add, add)
> >>>>>> +PERCPU_OP(andnot, and)
> >>>>>> +PERCPU_OP(or, or)
> >>>>>> +PERCPU_RET_OP(add, add)
> >>>>>> +
> >>>>>> +#undef PERCPU_RW_OPS
> >>>>>> +#undef __PERCPU_AMO_OP_CASE
> >>>>>> +#undef __PERCPU_AMO_RET_OP_CASE
> >>>>>> +#undef PERCPU_OP
> >>>>>> +#undef PERCPU_RET_OP
> >>>>>> +
> >>>>>> +#define _pcp_protect(op, pcp, ...)                    \
> >>>>>> +({                                    \
> >>>>>> +    preempt_disable_notrace();                    \
> >>>>>> +    op(raw_cpu_ptr(&(pcp)), __VA_ARGS__);                \
> >>>>>> +    preempt_enable_notrace();                    \
> >>>>>> +})
> >>>>>> +
> >>>>>> +#define _pcp_protect_return(op, pcp, args...)                \
> >>>>>> +({                                    \
> >>>>>> +    typeof(pcp) __retval;                        \
> >>>>>> +    preempt_disable_notrace();                    \
> >>>>>> +    __retval =3D (typeof(pcp))op(raw_cpu_ptr(&(pcp)), ##args);   =
 \
> >>>>>> +    preempt_enable_notrace();                    \
> >>>>>> +    __retval;                            \
> >>>>>> +})
> >>>>>> +
> >>>>>> +#define this_cpu_read_1(pcp) _pcp_protect_return(__percpu_read_8,=
 pcp)
> >>>>>> +#define this_cpu_read_2(pcp) _pcp_protect_return(__percpu_read_16=
, pcp)
> >>>>>> +#define this_cpu_read_4(pcp) _pcp_protect_return(__percpu_read_32=
, pcp)
> >>>>>> +#define this_cpu_read_8(pcp) _pcp_protect_return(__percpu_read_64=
, pcp)
> >>>>>> +
> >>>>>> +#define this_cpu_write_1(pcp, val) _pcp_protect(__percpu_write_8,
> >>>>>> pcp, (unsigned long)val)
> >>>>>> +#define this_cpu_write_2(pcp, val) _pcp_protect(__percpu_write_16=
,
> >>>>>> pcp, (unsigned long)val)
> >>>>>> +#define this_cpu_write_4(pcp, val) _pcp_protect(__percpu_write_32=
,
> >>>>>> pcp, (unsigned long)val)
> >>>>>> +#define this_cpu_write_8(pcp, val) _pcp_protect(__percpu_write_64=
,
> >>>>>> pcp, (unsigned long)val)
> >>>>>> +
> >>>>>> +#define this_cpu_add_1(pcp, val)
> >>>>>> _pcp_protect(__percpu_add_amo_case_8, pcp, val)
> >>>>>> +#define this_cpu_add_2(pcp, val)
> >>>>>> _pcp_protect(__percpu_add_amo_case_16, pcp, val)
> >>>>>> +#define this_cpu_add_4(pcp, val)
> >>>>>> _pcp_protect(__percpu_add_amo_case_32, pcp, val)
> >>>>>> +#define this_cpu_add_8(pcp, val)
> >>>>>> _pcp_protect(__percpu_add_amo_case_64, pcp, val)
> >>>>>> +
> >>>>>> +#define this_cpu_add_return_1(pcp, val)        \
> >>>>>> +_pcp_protect_return(__percpu_add_return_amo_case_8, pcp, val)
> >>>>>> +
> >>>>>> +#define this_cpu_add_return_2(pcp, val)        \
> >>>>>> +_pcp_protect_return(__percpu_add_return_amo_case_16, pcp, val)
> >>>>>> +
> >>>>>> +#define this_cpu_add_return_4(pcp, val)        \
> >>>>>> +_pcp_protect_return(__percpu_add_return_amo_case_32, pcp, val)
> >>>>>> +
> >>>>>> +#define this_cpu_add_return_8(pcp, val)        \
> >>>>>> +_pcp_protect_return(__percpu_add_return_amo_case_64, pcp, val)
> >>>>>> +
> >>>>>> +#define this_cpu_and_1(pcp, val)
> >>>>>> _pcp_protect(__percpu_andnot_amo_case_8, pcp, ~val)
> >>>>>> +#define this_cpu_and_2(pcp, val)
> >>>>>> _pcp_protect(__percpu_andnot_amo_case_16, pcp, ~val)
> >>>>>> +#define this_cpu_and_4(pcp, val)
> >>>>>> _pcp_protect(__percpu_andnot_amo_case_32, pcp, ~val)
> >>>>>> +#define this_cpu_and_8(pcp, val)
> >>>>>> _pcp_protect(__percpu_andnot_amo_case_64, pcp, ~val)
> >>>>> Why do we define __percpu_andnot based on amoand, and use
> >>>>> __percpu_andnot with ~val here? Can't we just define __percpu_and?
> >>
> >> What about that ^?
> >>
> >>
> >>>>>> +
> >>>>>> +#define this_cpu_or_1(pcp, val) _pcp_protect(__percpu_or_amo_case=
_8,
> >>>>>> pcp, val)
> >>>>>> +#define this_cpu_or_2(pcp, val)
> >>>>>> _pcp_protect(__percpu_or_amo_case_16, pcp, val)
> >>>>>> +#define this_cpu_or_4(pcp, val)
> >>>>>> _pcp_protect(__percpu_or_amo_case_32, pcp, val)
> >>>>>> +#define this_cpu_or_8(pcp, val)
> >>>>>> _pcp_protect(__percpu_or_amo_case_64, pcp, val)
> >>>>>> +
> >>>>>> +#define this_cpu_xchg_1(pcp, val) _pcp_protect_return(xchg_relaxe=
d,
> >>>>>> pcp, val)
> >>>>>> +#define this_cpu_xchg_2(pcp, val) _pcp_protect_return(xchg_relaxe=
d,
> >>>>>> pcp, val)
> >>>>>> +#define this_cpu_xchg_4(pcp, val) _pcp_protect_return(xchg_relaxe=
d,
> >>>>>> pcp, val)
> >>>>>> +#define this_cpu_xchg_8(pcp, val) _pcp_protect_return(xchg_relaxe=
d,
> >>>>>> pcp, val)
> >>>>>> +
> >>>>>> +#define this_cpu_cmpxchg_1(pcp, o, n)
> >>>>>> _pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
> >>>>>> +#define this_cpu_cmpxchg_2(pcp, o, n)
> >>>>>> _pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
> >>>>>> +#define this_cpu_cmpxchg_4(pcp, o, n)
> >>>>>> _pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
> >>>>>> +#define this_cpu_cmpxchg_8(pcp, o, n)
> >>>>>> _pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
> >>>>>> +
> >>>>>> +#include <asm-generic/percpu.h>
> >>>>>> +
> >>>>>> +#endif /* __ASM_PERCPU_H */
> >>>>> It all looks good to me, just one thing, can you also implement
> >>>>> this_cpu_cmpxchg64/128()?
> >>>>>
> >>>> One last thing sorry, can you add a cover letter too?
> >>> Okay.
> >>>
> >>>> Thanks!
> >>>>
> >>>> Alex
> >>>>
> >>>>
> >>>>> And since this is almost a copy/paste from arm64, either mention it=
 at
> >>>>> the top of the file or (better) merge both implementations somewher=
e
> >>>>> to avoid redefining existing code :) But up to you.
> >>> Actually, there's a concern here. We should account for scenarios
> >>> where ZABHA isn't supported. Given that xxx_8() and xxx_16() are
> >>> rarely used in practice, could we initially support only xxx_32() and
> >>> xxx_64()? For xxx_8() and xxx_16(), we could default to the generic
> >>> implementation.
> >>
> >> Why isn't lr/sc enough?
> > If I'm not mistaken, the current RISC-V does not support lr.bh/sc.bh,
> > is that right?
>
>
> Yes, that's right, but we have an implementation of cmpxchg[8|16]() that
> uses lr.w/sc.w which works (unless I missed something, I have just
> checked again), so I think that's alright no?

Since RISC-V does not support lr/sc.b/h, when ZABHA is not supported,
we need to use lr/sc.w instead, which requires some additional mask
operations. In fact, 8/16-bit percpu operations are very few. The
number of system startup operations is as follows:

8-bit Adds: 3, 16-bit Adds: 3, 32-bit Adds: 31858, 64-bit Adds: 7656
8-bit Add-Returns: 0, 16-bit Add-Returns: 0, 32-bit Add-Returns: 0,
64-bit Add-Returns: 2
8-bit ANDs: 0, 16-bit ANDs: 0, 32-bit ANDs: 0, 64-bit ANDs: 0
8-bit ANDNOTs: 0, 16-bit ANDNOTs: 0, 32-bit ANDNOTs: 0, 64-bit ANDNOTs: 0
8-bit ORs: 0, 16-bit ORs: 0, 32-bit ORs: 70, 64-bit ORs: 0

So, when ZABHA is not supported, can 8bit/16bit operations directly
fall back to the generic implementation?


>
> Thanks,
>
> Alex
>
>
> >
> >>
> >>>
> >>>>> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> >>>>>
> >>>>> Thanks,
> >>>>>
> >>>>> Alex
> >>>>>
> >>>>>
> >>>>>
> >>> Thanks,
> >>> Yunhui
> >>>
> >>> _______________________________________________
> >>> linux-riscv mailing list
> >>> linux-riscv@lists.infradead.org
> >>> http://lists.infradead.org/mailman/listinfo/linux-riscv
> > Thanks,
> > Yunhui
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv

Thanks,
Yunhui

