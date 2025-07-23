Return-Path: <linux-kernel+bounces-742240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0610B0EF0B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 12:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54B551886EBF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E886D28B519;
	Wed, 23 Jul 2025 10:00:40 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879F118C332;
	Wed, 23 Jul 2025 10:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753264840; cv=none; b=JEwexe42WKM3gwdb+lCfuij0isNMi4uljQuLb4wXlpnfMIMfe4UvC34qL99DO2eIMS1QtSreENzftU3IvRRzul1y+0Sjw20VZABaRHsZMc34iKPDHMVrUuKR9AtjFhzF7Wl+tVmq6dvgN8ma/evz8uWpqbxMXXTUBh+RpIAKjeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753264840; c=relaxed/simple;
	bh=p+fD85xjERppoC21Fiq4VVUPviTELtBzs+jCKBEDhJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OIn71mQTA2JgPs0jO13pC9ycwscEvaoDTZbARMYPcy2sOg3HNzqdLbIehgJBces3B+Pyv+mcLom8czXov5tHAdJUwqvS5dtSlg6djUTcJnYQrs/3G9Wbi5hmP/btZYCNOsS8CH+QSNpFBh5g4L47GefTgIjTDpbb7P+89M1j3ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A5A8C4CEF5;
	Wed, 23 Jul 2025 10:00:36 +0000 (UTC)
Date: Wed, 23 Jul 2025 11:00:33 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mhiramat@kernel.org, oleg@redhat.com, peterz@infradead.org,
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, thiago.bauermann@linaro.org,
	broonie@kernel.org, yury.khrustalev@arm.com,
	kristina.martsenko@arm.com, liaochang1@huawei.com, will@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/8] arm64: probes: Add GCS support to bl/blr/ret
Message-ID: <aICywZ55EKfSYSIY@arm.com>
References: <20250719043740.4548-1-jeremy.linton@arm.com>
 <20250719043740.4548-6-jeremy.linton@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250719043740.4548-6-jeremy.linton@arm.com>

On Fri, Jul 18, 2025 at 11:37:37PM -0500, Jeremy Linton wrote:
> diff --git a/arch/arm64/kernel/probes/simulate-insn.c b/arch/arm64/kernel/probes/simulate-insn.c
> index 09a0b36122d0..c75dce7bbe13 100644
> --- a/arch/arm64/kernel/probes/simulate-insn.c
> +++ b/arch/arm64/kernel/probes/simulate-insn.c
> @@ -13,6 +13,7 @@
>  #include <asm/traps.h>
>  
>  #include "simulate-insn.h"
> +#include "asm/gcs.h"
>  
>  #define bbl_displacement(insn)		\
>  	sign_extend32(((insn) & 0x3ffffff) << 2, 27)
> @@ -49,6 +50,20 @@ static inline u32 get_w_reg(struct pt_regs *regs, int reg)
>  	return lower_32_bits(pt_regs_read_reg(regs, reg));
>  }
>  
> +static inline void update_lr(struct pt_regs *regs, long addr)
> +{
> +	int err = 0;
> +
> +	if (user_mode(regs) && task_gcs_el0_enabled(current)) {
> +		push_user_gcs(addr + 4,	 &err);
> +		if (err) {
> +			force_sig(SIGSEGV);
> +			return;
> +		}
> +	}
> +	procedure_link_pointer_set(regs, addr + 4);
> +}
> +
>  static bool __kprobes check_cbz(u32 opcode, struct pt_regs *regs)
>  {
>  	int xn = opcode & 0x1f;
> @@ -107,9 +122,8 @@ simulate_b_bl(u32 opcode, long addr, struct pt_regs *regs)
>  {
>  	int disp = bbl_displacement(opcode);
>  
> -	/* Link register is x30 */
>  	if (opcode & (1 << 31))
> -		set_x_reg(regs, 30, addr + 4);
> +		update_lr(regs, addr);

Why not pass (addr + 4) here and skip the addition in update_lr()?

>  
>  	instruction_pointer_set(regs, addr + disp);
>  }
> @@ -133,17 +147,26 @@ simulate_br_blr(u32 opcode, long addr, struct pt_regs *regs)
>  	/* update pc first in case we're doing a "blr lr" */
>  	instruction_pointer_set(regs, get_x_reg(regs, xn));
>  
> -	/* Link register is x30 */
>  	if (((opcode >> 21) & 0x3) == 1)
> -		set_x_reg(regs, 30, addr + 4);
> +		update_lr(regs, addr);
>  }

I can see why this function was originally updating PC (in case of a blr
lr) but updating the LR was not supposed to fail. With GCS, I think we
should follow similar logic to simulate_b_bl() and skip updating PC/LR
if the write to the GCS failed (assuming that's what the hardware does,
I haven't checked the spec).

>  void __kprobes
>  simulate_ret(u32 opcode, long addr, struct pt_regs *regs)
>  {
> -	int xn = (opcode >> 5) & 0x1f;
> +	u64 ret_addr;
> +	int err = 0;
> +	unsigned long lr = procedure_link_pointer(regs);
>  
> -	instruction_pointer_set(regs, get_x_reg(regs, xn));
> +	if (user_mode(regs) && task_gcs_el0_enabled(current)) {
> +		ret_addr = pop_user_gcs(&err);
> +		if (err || ret_addr != lr) {
> +			force_sig(SIGSEGV);
> +			return;
> +		}
> +	}
> +
> +	instruction_pointer_set(regs, lr);
>  }

What happened to the RET Xn case?

-- 
Catalin

