Return-Path: <linux-kernel+bounces-739113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FE4B0C203
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 12:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AECEF3AB162
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 10:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B3D29345A;
	Mon, 21 Jul 2025 10:56:56 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6847292B21
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 10:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753095415; cv=none; b=GMMvZXuYwffoihy7FBIDw+QHwAM8bxNfNBg6/mkTioy/2geG/dIyrJuhKZZi8b20XOdTQYrHvoYFFwY0q8I7hyscQWQyq9D99hR5e0g3mvuOgb6GEKBbbjuyW6smD5tzQQRrPnAoF7RfSdmMa9+eGvBbX/NVXU9vSyy+IQIDhzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753095415; c=relaxed/simple;
	bh=JYQRJb3F5+CXgEj6BN6zEtJPz874HkzbXOjLnA/DN10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rl6nPY+jVqo4iVxqlmvwzrIEVy5WE5Do+WgMdid3hLEGdockJwh9j2pGoUU30Vfo6c/isWJfbXlrm8YyJ/dhiXQ4PRM2sX+1Bg6xyvFlcCtxdFCCinFw8I3JE8YVrbP+K3WpdXrxCHwAo5QnmBNCReNnr4lp33BHcPrLQOa8IPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F9A3153B;
	Mon, 21 Jul 2025 03:56:47 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 48F6D3F6A8;
	Mon, 21 Jul 2025 03:56:51 -0700 (PDT)
Date: Mon, 21 Jul 2025 11:56:48 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, broonie@kernel.org,
	oliver.upton@linux.dev, ardb@kernel.org, frederic@kernel.org,
	james.morse@arm.com, joey.gouly@arm.com,
	scott@os.amperecomputing.com, maz@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/7] arm64/futex: move futex atomic logic with
 clearing PAN bit
Message-ID: <aH4c8J3-qp9guE__@J2N7QTR9R3>
References: <20250721083618.2743569-1-yeoreum.yun@arm.com>
 <20250721083618.2743569-5-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721083618.2743569-5-yeoreum.yun@arm.com>

On Mon, Jul 21, 2025 at 09:36:15AM +0100, Yeoreum Yun wrote:
> Move current futex atomic logics which uses ll/sc method with cleraing
> PSTATE.PAN to separate file (futex_ll_sc_u.h) so that
> former method will be used only when FEAT_LSUI isn't supported.

This isn't moving logic, this is *duplicating* the existing logic. As of
this patch, this logic in the <asm/futex_ll_sc_u.h> header is unused,
and the existing logic in <asm/futex.h> is still used as-is.

Please refactor the existing logic first. The deletion of the existing
code should happen at the same time as this addition. That way it's
possible to see that the deleted logic corresponds to what is being
added in the header, and it's generally nicer for bisection.

Mark.

> 
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---
>  arch/arm64/include/asm/futex_ll_sc_u.h | 115 +++++++++++++++++++++++++
>  1 file changed, 115 insertions(+)
>  create mode 100644 arch/arm64/include/asm/futex_ll_sc_u.h
> 
> diff --git a/arch/arm64/include/asm/futex_ll_sc_u.h b/arch/arm64/include/asm/futex_ll_sc_u.h
> new file mode 100644
> index 000000000000..6702ba66f1b2
> --- /dev/null
> +++ b/arch/arm64/include/asm/futex_ll_sc_u.h
> @@ -0,0 +1,115 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2025 Arm Ltd.
> + */
> +#ifndef __ASM_FUTEX_LL_SC_U_H
> +#define __ASM_FUTEX_LL_SC_U_H
> +
> +#include <linux/uaccess.h>
> +#include <linux/stringify.h>
> +
> +#define FUTEX_ATOMIC_OP(op, asm_op)					\
> +static __always_inline int						\
> +__ll_sc_u_futex_atomic_##op(int oparg, u32 __user *uaddr, int *oval)	\
> +{									\
> +	unsigned int loops = LL_SC_MAX_LOOPS;				\
> +	int ret, val, tmp;						\
> +									\
> +	uaccess_enable_privileged();					\
> +	asm volatile("// __ll_sc_u_futex_atomic_" #op "\n"		\
> +	"	prfm	pstl1strm, %2\n"				\
> +	"1:	ldxr	%w1, %2\n"					\
> +	"	" #asm_op "	%w3, %w1, %w5\n"			\
> +	"2:	stlxr	%w0, %w3, %2\n"					\
> +	"	cbz	%w0, 3f\n"					\
> +	"	sub	%w4, %w4, %w0\n"				\
> +	"	cbnz	%w4, 1b\n"					\
> +	"	mov	%w0, %w6\n"					\
> +	"3:\n"								\
> +	"	dmb	ish\n"						\
> +	_ASM_EXTABLE_UACCESS_ERR(1b, 3b, %w0)				\
> +	_ASM_EXTABLE_UACCESS_ERR(2b, 3b, %w0)				\
> +	: "=&r" (ret), "=&r" (val), "+Q" (*uaddr), "=&r" (tmp),		\
> +	  "+r" (loops)							\
> +	: "r" (oparg), "Ir" (-EAGAIN)					\
> +	: "memory");							\
> +	uaccess_disable_privileged();					\
> +									\
> +	if (!ret)							\
> +		*oval = val;						\
> +									\
> +	return ret;							\
> +}
> +
> +FUTEX_ATOMIC_OP(add, add)
> +FUTEX_ATOMIC_OP(or, orr)
> +FUTEX_ATOMIC_OP(and, and)
> +FUTEX_ATOMIC_OP(eor, eor)
> +
> +#undef FUTEX_ATOMIC_OP
> +
> +static __always_inline int
> +__ll_sc_u_futex_atomic_set(int oparg, u32 __user *uaddr, int *oval)
> +{
> +	unsigned int loops = LL_SC_MAX_LOOPS;
> +	int ret, val;
> +
> +	uaccess_enable_privileged();
> +	asm volatile("//__ll_sc_u_futex_xchg\n"
> +	"	prfm	pstl1strm, %2\n"
> +	"1:	ldxr	%w1, %2\n"
> +	"2:	stlxr	%w0, %w4, %2\n"
> +	"	cbz	%w3, 3f\n"
> +	"	sub	%w3, %w3, %w0\n"
> +	"	cbnz	%w3, 1b\n"
> +	"	mov	%w0, %w5\n"
> +	"3:\n"
> +	"	dmb	ish\n"
> +	_ASM_EXTABLE_UACCESS_ERR(1b, 3b, %w0)
> +	_ASM_EXTABLE_UACCESS_ERR(2b, 3b, %w0)
> +	: "=&r" (ret), "=&r" (val), "+Q" (*uaddr), "+r" (loops)
> +	: "r" (oparg), "Ir" (-EAGAIN)
> +	: "memory");
> +	uaccess_disable_privileged();
> +
> +	if (!ret)
> +		*oval = val;
> +
> +	return ret;
> +}
> +
> +static __always_inline int
> +__ll_sc_u_futex_cmpxchg(u32 __user *uaddr, u32 oldval, u32 newval, u32 *oval)
> +{
> +	int ret = 0;
> +	unsigned int loops = LL_SC_MAX_LOOPS;
> +	u32 val, tmp;
> +
> +	uaccess_enable_privileged();
> +	asm volatile("//__ll_sc_u_futex_cmpxchg\n"
> +	"	prfm	pstl1strm, %2\n"
> +	"1:	ldxr	%w1, %2\n"
> +	"	eor	%w3, %w1, %w5\n"
> +	"	cbnz	%w3, 4f\n"
> +	"2:	stlxr	%w3, %w6, %2\n"
> +	"	cbz	%w3, 3f\n"
> +	"	sub	%w4, %w4, %w3\n"
> +	"	cbnz	%w4, 1b\n"
> +	"	mov	%w0, %w7\n"
> +	"3:\n"
> +	"	dmb	ish\n"
> +	"4:\n"
> +	_ASM_EXTABLE_UACCESS_ERR(1b, 4b, %w0)
> +	_ASM_EXTABLE_UACCESS_ERR(2b, 4b, %w0)
> +	: "+r" (ret), "=&r" (val), "+Q" (*uaddr), "=&r" (tmp), "+r" (loops)
> +	: "r" (oldval), "r" (newval), "Ir" (-EAGAIN)
> +	: "memory");
> +	uaccess_disable_privileged();
> +
> +	if (!ret)
> +		*oval = val;
> +
> +	return ret;
> +}
> +
> +#endif /* __ASM_FUTEX_LL_SC_U_H */
> -- 
> LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
> 
> 

