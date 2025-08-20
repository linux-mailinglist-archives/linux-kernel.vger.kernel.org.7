Return-Path: <linux-kernel+bounces-778673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E219B2E8BA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 01:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 086067B1C5A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 23:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669AF2E11CA;
	Wed, 20 Aug 2025 23:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="N3/pVvEw"
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C072E0B48
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 23:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755733061; cv=none; b=lAwjVGrowy7FTnWzWuwUEyvgL2f3Z342fb2o6xrBDdmm8qTfFQpqdOOHNP/8dDCNhD4DHeTwjPor674Lz7rNkF8LhXTP16JmWyKPEeC7/ZNC9m6UOvt/XJkim+78QRQUYpA/yqGe2kA/dismMCQhuq5ge2btFeh1j/xGev2CmOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755733061; c=relaxed/simple;
	bh=XCs0VqFMLGNvQBFfHYDkcYu1cR0YZLv0EaV6HUuJL2s=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=XlAcugelnlBGolo7r2ZNE027Z5NDlt3k2RGXL/Qt5ije50wpOAckPJbgsr26GduqU5p4caQIjgi5vzV2sGUHIw45RVNlj3H8vdENQRjSX6qYUr01vu5uiMs7V6sUiwEmsdDzgfeIP2DONHi9yLNoTQy9yKdPPrz9kNSJrSJ5wQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=N3/pVvEw; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1755732405;
	bh=XCs0VqFMLGNvQBFfHYDkcYu1cR0YZLv0EaV6HUuJL2s=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=N3/pVvEw5VXa8QdhAwM7HVfsSjcYmdRrJhvocdcN8UCejCGDhF62uLjAXytcrnHu6
	 5bildu1OCOXqaorSaUHO3HLKwcq6j6TDr66DrZxk3rgbrakV5SxgV4ZVa+CaSWiuvj
	 A/oSWIgOzgb/9v2BIAstrZsYZTI8wsP/Bt6eAXvo=
Received: by gentwo.org (Postfix, from userid 1003)
	id B433B40195; Wed, 20 Aug 2025 16:26:45 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id B3610400CA;
	Wed, 20 Aug 2025 16:26:45 -0700 (PDT)
Date: Wed, 20 Aug 2025 16:26:45 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Yunhui Cui <cuiyunhui@bytedance.com>
cc: yury.norov@gmail.com, linux@rasmusvillemoes.dk, paul.walmsley@sifive.com, 
    palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
    linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
    dennis@kernel.org, tj@kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/2] riscv: introduce percpu.h into include/asm
In-Reply-To: <20250819135007.85646-3-cuiyunhui@bytedance.com>
Message-ID: <e7653089-5c57-ee61-ed01-0b3245e10d82@gentwo.org>
References: <20250819135007.85646-1-cuiyunhui@bytedance.com> <20250819135007.85646-3-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 19 Aug 2025, Yunhui Cui wrote:

> +#define __PERCPU_AMO_OP_CASE(sfx, name, sz, amo_insn)			\
> +static inline void							\
> +__percpu_##name##_amo_case_##sz(void *ptr, unsigned long val)		\
> +{									\
> +	asm volatile (							\
> +		"amo" #amo_insn #sfx " zero, %[val], %[ptr]"		\
> +		: [ptr] "+A" (*(u##sz *)ptr)				\
> +		: [val] "r" ((u##sz)(val))				\
> +		: "memory");						\
> +}

AMO creates a single instruction that performs the operation?

> +#define _pcp_protect(op, pcp, ...)					\
> +({									\
> +	preempt_disable_notrace();					\
> +	op(raw_cpu_ptr(&(pcp)), __VA_ARGS__);				\
> +	preempt_enable_notrace();					\
> +})

Is "op" a single instruction? If so then preempt disable / endable would
not be needed if there is no other instruction created.

But raw_cpu_ptr performs a SHIFT_PERCPU_PTR which performs an addition.
So you need the disabling of preemption to protect the add.

Is there a way on RISC V to embedd the pointer arithmetic in the "AMO"
instruction? Or can you use relative addressing to a register that
contains the cpu offset. I believe RISC V has a thread pointer?

If you can do this then a lot of preempt_enable/disable points can be
removed from the core kernel and the instruction may be as scalable as x86
which can do the per cpu operations with a single instruction.

> +
> +#define _pcp_protect_return(op, pcp, args...)				\
> +({									\
> +	typeof(pcp) __retval;						\
> +	preempt_disable_notrace();					\
> +	__retval = (typeof(pcp))op(raw_cpu_ptr(&(pcp)), ##args);	\
> +	preempt_enable_notrace();					\
> +	__retval;							\
> +})

Same here.


