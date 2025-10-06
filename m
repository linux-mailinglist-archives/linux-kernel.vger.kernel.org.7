Return-Path: <linux-kernel+bounces-843007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CC1BBE304
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 15:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34AE7189047D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 13:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AFB2D12F5;
	Mon,  6 Oct 2025 13:30:09 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD19F2D0C98
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 13:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759757408; cv=none; b=t4dSrGMbj/7sHL+D2F2nEBboSvE9AHN3jN++WsjIb7bOGArY17XngqaRZqZd+xYPzyhDQxQDcHatZPQgQpLLTZjPhMmeRrlCmUj4Iyw92/r5SZPUodCE/gE4o9f36Ke6pGDR7JP4/gAnEkh5s33RsgoMR2db81A0+1z2KAhF9AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759757408; c=relaxed/simple;
	bh=CYDtMCsbCpzHsL6Lx5UWPFq9nclTnytRCO80msi+Fu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CUEa2Awnt9eSHG+NrMbYmg8b+xyA3L1TkapkdFq2D09MdHbkPdKxtob912hwGKKFOgsnfZKyJyLmXWBzQ8c4eJlLAvCIZ/Tm02Tm0XSiW5d3eIVTgMvXbeJyhFEGUhZgZXVLMkLP6wDk0uxnZu1OGRaeXy/7Oa46d8QDIlDECwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4568C4CEF5;
	Mon,  6 Oct 2025 13:30:06 +0000 (UTC)
Date: Mon, 6 Oct 2025 14:30:04 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] irqchip/gic-v5: Fix GIC CDEOI instruction encoding
Message-ID: <aOPEXEx-QRv7v9A5@arm.com>
References: <20251006100758.624934-1-lpieralisi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006100758.624934-1-lpieralisi@kernel.org>

On Mon, Oct 06, 2025 at 12:07:58PM +0200, Lorenzo Pieralisi wrote:
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index 6455db1b54fd..6cf8c46ddde5 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -113,14 +113,14 @@
>  /* Register-based PAN access, for save/restore purposes */
>  #define SYS_PSTATE_PAN			sys_reg(3, 0, 4, 2, 3)
>  
> -#define __SYS_BARRIER_INSN(op0, op1, CRn, CRm, op2, Rt)			\
> +#define __SYS_INSN(op0, op1, CRn, CRm, op2, Rt)				\
>  	__emit_inst(0xd5000000					|	\
>  		    sys_insn((op0), (op1), (CRn), (CRm), (op2))	|	\
>  		    ((Rt) & 0x1f))
>  
> -#define SB_BARRIER_INSN			__SYS_BARRIER_INSN(0, 3, 3, 0, 7, 31)
> -#define GSB_SYS_BARRIER_INSN		__SYS_BARRIER_INSN(1, 0, 12, 0, 0, 31)
> -#define GSB_ACK_BARRIER_INSN		__SYS_BARRIER_INSN(1, 0, 12, 0, 1, 31)
> +#define SB_BARRIER_INSN			__SYS_INSN(0, 3, 3, 0, 7, 31)
> +#define GSB_SYS_BARRIER_INSN		__SYS_INSN(1, 0, 12, 0, 0, 31)
> +#define GSB_ACK_BARRIER_INSN		__SYS_INSN(1, 0, 12, 0, 1, 31)
>  
>  /* Data cache zero operations */
>  #define SYS_DC_ISW			sys_insn(1, 0, 7, 6, 2)
> @@ -1075,7 +1075,6 @@
>  #define GICV5_OP_GIC_CDDIS		sys_insn(1, 0, 12, 1, 0)
>  #define GICV5_OP_GIC_CDHM		sys_insn(1, 0, 12, 2, 1)
>  #define GICV5_OP_GIC_CDEN		sys_insn(1, 0, 12, 1, 1)
> -#define GICV5_OP_GIC_CDEOI		sys_insn(1, 0, 12, 1, 7)
>  #define GICV5_OP_GIC_CDPEND		sys_insn(1, 0, 12, 1, 4)
>  #define GICV5_OP_GIC_CDPRI		sys_insn(1, 0, 12, 1, 2)
>  #define GICV5_OP_GIC_CDRCFG		sys_insn(1, 0, 12, 1, 5)
> @@ -1129,6 +1128,17 @@
>  #define gicr_insn(insn)			read_sysreg_s(GICV5_OP_GICR_##insn)
>  #define gic_insn(v, insn)		write_sysreg_s(v, GICV5_OP_GIC_##insn)
>  
> +/*
> + * GIC CDEOI encoding requires Rt to be 0b11111.
> + * gic_insn() with an immediate value of 0 cannot be used to encode it
> + * because some compilers do not follow asm inline constraints in
> + * write_sysreg_s() to turn an immediate 0 value into an XZR as
> + * MSR source register.
> + * Use __SYS_INSN to specify its precise encoding explicitly.
> + */
> +#define GICV5_CDEOI_INSN		__SYS_INSN(1, 0, 12, 1, 7, 31)
> +#define gic_cdeoi()			asm volatile(GICV5_CDEOI_INSN)

Would something like this work? Completely untested (and build still
going):

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 6604fd6f33f4..7aa962f7bdd6 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -1234,7 +1234,10 @@
 #define write_sysreg_s(v, r) do {					\
 	u64 __val = (u64)(v);						\
 	u32 __maybe_unused __check_r = (u32)(r);			\
-	asm volatile(__msr_s(r, "%x0") : : "rZ" (__val));		\
+	if (__builtin_constant_p(__val) && __val == 0)			\
+		asm volatile(__msr_s(r, "xzr"));			\
+	else								\
+		asm volatile(__msr_s(r, "%x0") : : "r" (__val));	\
 } while (0)
 
 /*

-- 
Catalin

