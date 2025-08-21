Return-Path: <linux-kernel+bounces-779202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4EEB2F060
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87FAAA0033C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 08:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1172EA463;
	Thu, 21 Aug 2025 08:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="depHaB0+"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2FF284682
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 08:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755763285; cv=none; b=PdaVaVjCQs1evbs+VBTu++jlNho+2KeSfbydiEodJuEpq597kZ8NDM2UMuZb3FpSAcyCx+GzhulqaakIbbCmPqO2LqhD0VwSJAAfAz0iLTaPBUed3LLNJGNHnx9Fd/1aHwcy1KZ/cLOs8Dfpf2xB1/tE8ZItdhBYz0PXxXgBEBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755763285; c=relaxed/simple;
	bh=jvkOLdZKZr5olKwFsRHATvSPLUv4tAJnWsvZ0GtpMh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n5j/x/nV8jmJtmBeegfhM6N4jNevzZOkYVJYvBpiJBgEbis3vMHYyD8Oe85UzEEMfHDn58zOAFXoqqAkhIrvGzdmxhDS5NUjaCQpSHby0YMl76nMCSEkgSX6Ak04OXRHbYluHgFhcgMUZbyjtgSqU3ZWPs99crPWYH3Jy/s0xjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=depHaB0+; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-4360056a2adso407477b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 01:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1755763283; x=1756368083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X0l+hqGahEDr13/VVOMr1/ba48aJ1pl6KG+1VNry8aA=;
        b=depHaB0+LCDgBAKKfFEPLn3Luk1y/KEN8gAE/dfODF6uN5y4rRwV6SIyeE5ddcnIhO
         gwTqfXFpOe1Hjzuz/X5cLJNdDknbey4enYbq2EKtooJs+8CgWayrUARpblxmWP5bVovw
         oAuNGCSV98IJJ7x87akbZK3YssWrH9eIytNAsgUntqfHN5Q3Q4400tUZcNx5JpQn8rh3
         qW9x43NsfwM1XTjaq9zaAXKhYqajbQN/dL7rbrOK0Os0lNtN4kgWBCvx5kCspHDX4Wju
         0AfSEcxeYYmgnGNWMhIrRCMySqPbHmfnDyROUMYPe+WYQLEHxB1vwweTS1Mq24H+SnzO
         anLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755763283; x=1756368083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X0l+hqGahEDr13/VVOMr1/ba48aJ1pl6KG+1VNry8aA=;
        b=aOH5hLwrkDeg3JVOlJDvqSbyL3vCY96S41cv2gBVT5q2srQ3p2zsuEM6kB6vg3W856
         pk1C2m5OI0+mvJiJh4uOWzOW5jjkZlWZEtyRVOe0STiHm0mtCYt3/IT/GEWcrvKQkM3o
         R/n1cDrzRUdXmjRI6aqQEvvFHZkc80O1eD320pwlr/hwEqxahlaI0ClYj7ZQXMkWebZu
         kvsI5KZfgDnT/ZY9qUAYP40WICQgq6XR4NqclvbxbqrOmV/8p/UFnHEee3/akxIhHg1j
         PvO7JBGGJ3+s718XKTIWxwFXn4fJgfY4gM7gBbROMx2FdyI97tAtSadbIvqqOjAe9TOb
         DfqA==
X-Forwarded-Encrypted: i=1; AJvYcCVP0N/2gxjHkw9OhAw5InUrehFe8o8uL6HnKZwzLUDie41dZYyCnVP8fnf493bJ0VohebH5YkjqUelo7hc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi+VqgmZN90GP+3UC8zUm/Mqs8/WZroWWHNoEOX36EQpblYCkf
	fozgsnTyJL68UvbEYWMhgxg8WfyG/FhfJ3RzxvziDT2Kio0Q9zjFQ8OdXVRwioMbBK5uN/u2lJy
	LRXXxRCcNwYlEm/CBKWKnSzatkruePJVjWVeq1AWn7Q==
X-Gm-Gg: ASbGncsaohVmKRIhb8OEo8OFvOxzVj+In1ImnZOx7ogBGAAYvWoNpZ0AAIKVJfRjtXN
	+0PcGkvLZSS0mY2368WA1NNdyZSmGyQ5eO2O0jvekqNrYHvo7HajqrT+szAhwmrvLql5lv9kda5
	KkfcfLgqXd205byqegZW2TxX9i8BUKFX6iauKSP/PpYkf+9vV+86sv45KtKkyigSzU3P5+or/7y
	28EHqKGrlJv+sCwLmlmyDXo
X-Google-Smtp-Source: AGHT+IE1OeafrLylfvLmrdDojnOroAp8hDYwluDFKL9kS6j+UuoaPTREpF8UcR7eJdteZMLpeZ1xWt+LGXG2u0Pv6TQ=
X-Received: by 2002:a05:6808:50a5:b0:435:27b4:3fcb with SMTP id
 5614622812f47-4377d6b1ed9mr504349b6e.3.1755763282540; Thu, 21 Aug 2025
 01:01:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819135007.85646-1-cuiyunhui@bytedance.com>
 <20250819135007.85646-3-cuiyunhui@bytedance.com> <e7653089-5c57-ee61-ed01-0b3245e10d82@gentwo.org>
In-Reply-To: <e7653089-5c57-ee61-ed01-0b3245e10d82@gentwo.org>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Thu, 21 Aug 2025 16:01:11 +0800
X-Gm-Features: Ac12FXwUWi_BUfDOcCWj-9DhtNJYZaytAFdS1lP3UQLaq51ftYyrJTGQtLfjgb4
Message-ID: <CAEEQ3w=KrysBJrkYA6mUKCjC=fz23R7u81a2p8EipaN9oVHs_Q@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 2/2] riscv: introduce percpu.h into include/asm
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: yury.norov@gmail.com, linux@rasmusvillemoes.dk, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	dennis@kernel.org, tj@kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

On Thu, Aug 21, 2025 at 7:39=E2=80=AFAM Christoph Lameter (Ampere)
<cl@gentwo.org> wrote:
>
> On Tue, 19 Aug 2025, Yunhui Cui wrote:
>
> > +#define __PERCPU_AMO_OP_CASE(sfx, name, sz, amo_insn)                 =
       \
> > +static inline void                                                   \
> > +__percpu_##name##_amo_case_##sz(void *ptr, unsigned long val)         =
       \
> > +{                                                                    \
> > +     asm volatile (                                                  \
> > +             "amo" #amo_insn #sfx " zero, %[val], %[ptr]"            \
> > +             : [ptr] "+A" (*(u##sz *)ptr)                            \
> > +             : [val] "r" ((u##sz)(val))                              \
> > +             : "memory");                                            \
> > +}
>
> AMO creates a single instruction that performs the operation?
>
> > +#define _pcp_protect(op, pcp, ...)                                   \
> > +({                                                                   \
> > +     preempt_disable_notrace();                                      \
> > +     op(raw_cpu_ptr(&(pcp)), __VA_ARGS__);                           \
> > +     preempt_enable_notrace();                                       \
> > +})
>
> Is "op" a single instruction? If so then preempt disable / endable would
> not be needed if there is no other instruction created.
>
> But raw_cpu_ptr performs a SHIFT_PERCPU_PTR which performs an addition.
> So you need the disabling of preemption to protect the add.
>
> Is there a way on RISC V to embedd the pointer arithmetic in the "AMO"
> instruction? Or can you use relative addressing to a register that
> contains the cpu offset. I believe RISC V has a thread pointer?
>
> If you can do this then a lot of preempt_enable/disable points can be
> removed from the core kernel and the instruction may be as scalable as x8=
6
> which can do the per cpu operations with a single instruction.

Yes, thank you. While it=E2=80=99s certainly good to remove preemption
disabling, currently RISC-V=E2=80=99s amoadd.w/d instructions can take the
address of a variable rather than a register.

I previously submitted an attempt to use gp to store the percpu
offset, and we are also trying to push for an extension that uses a
register to store the percpu offset.
https://lore.kernel.org/all/CAEEQ3w=3DPsM5T+yMrEGdWZ2nm7m7SX3vzscLtWpOPVu1z=
pfm3YQ@mail.gmail.com/
https://lists.riscv.org/g/tech-privileged/topic/risc_v_tech_arch_review/113=
437553?page=3D2

>
> > +
> > +#define _pcp_protect_return(op, pcp, args...)                         =
       \
> > +({                                                                   \
> > +     typeof(pcp) __retval;                                           \
> > +     preempt_disable_notrace();                                      \
> > +     __retval =3D (typeof(pcp))op(raw_cpu_ptr(&(pcp)), ##args);       =
 \
> > +     preempt_enable_notrace();                                       \
> > +     __retval;                                                       \
> > +})
>
> Same here.
>
>

Thanks,
Yunhui

