Return-Path: <linux-kernel+bounces-811580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D76B52B2F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 10:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 656EC7BF430
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 08:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41C62D23B7;
	Thu, 11 Sep 2025 08:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4Yjw0+k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D762D1F4A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 08:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757577829; cv=none; b=bk1N+oIIf+Vo/wY00V0ZShDcQmKw4qmvHm0c19QibLN+Ngv4+7Cx3NKdihs28bqy2E1HKuWegZmYyFV1QmjmA0uumrdigUTP4PHQEFZx9DnWId/HRyVHmmlh36qkNsj4twY0UcG86JdnLLfrhl8e1jOJhVfPl7jM8BJ142wYAzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757577829; c=relaxed/simple;
	bh=SXMc1g9RtBLqwYXa4S6GfT4dHIbrgBmTHGamdJB1gDM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=LTobTD4oupYuKnQQ64HsfEA9NWoRMe+it5ziRhPWp6l5UF/LsFNP1vzSNfrX7GXxIACSHgpSgfO7pat51T1EQLPK+fOqpemG4yxvOHPZKsu+/PLw85SuUYQuF2i2MRxRsifCQZ3/McGsMWoHgpwOi+5bjDGm3ECwU5djIdv2TpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4Yjw0+k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E7C7C4CEF1;
	Thu, 11 Sep 2025 08:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757577828;
	bh=SXMc1g9RtBLqwYXa4S6GfT4dHIbrgBmTHGamdJB1gDM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=N4Yjw0+k8OnQLcds+HWr3bDj71bAnz+DWBgCDfT6NgOj8NfX7sQGZLIgA7e2T9CJ0
	 iZ035qs249L+T5OEWjHAGVi+eJViGR3vIsCgL+x0bZkvqxtSbj+lW2ZtH6kQy/lEFu
	 0clz05e9VCKIHYNegrfdwukhFXkK4GhYXEGA8hLU+AbA5PJTdB3dPfts2unAWEKnxQ
	 Ez5v9EdoaiusOBfEwkAEGHV6rVZmzNPlaZjiVKg6ndYXCgfqzwzFSefmd5OcSmH1di
	 fleKBCllVs67EFsZmpnKAkDnpmFuAtOsaXKWf5PfOUwwlxvp2Oka4l3kJPI/XdaaMP
	 00w1xYORCthtQ==
Date: Thu, 11 Sep 2025 17:03:45 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jinchao Wang <wangjinchao600@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] x86/hw_breakpoint: Unify breakpoint
 install/uninstall
Message-Id: <20250911170345.80169f37b3964eb9c9475c41@kernel.org>
In-Reply-To: <20250910093951.1330637-1-wangjinchao600@gmail.com>
References: <20250910093951.1330637-1-wangjinchao600@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Sep 2025 17:39:34 +0800
Jinchao Wang <wangjinchao600@gmail.com> wrote:

> Consolidate breakpoint management into a single helper function to
> reduce code duplication. This introduces new static helpers for
> slot management and debug register manipulation.
> 
> Also, add `<linux/types.h>` to the header file to fix a build
> dependency.

Looks good to me. Just some nitpicks.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

> 
> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
> ---
>  arch/x86/include/asm/hw_breakpoint.h |   7 +-
>  arch/x86/kernel/hw_breakpoint.c      | 151 ++++++++++++++++-----------
>  2 files changed, 96 insertions(+), 62 deletions(-)
> 
> diff --git a/arch/x86/include/asm/hw_breakpoint.h b/arch/x86/include/asm/hw_breakpoint.h
> index 0bc931cd0698..bd437a30dbf2 100644
> --- a/arch/x86/include/asm/hw_breakpoint.h
> +++ b/arch/x86/include/asm/hw_breakpoint.h
> @@ -3,8 +3,8 @@
>  #define	_I386_HW_BREAKPOINT_H
>  
>  #include <uapi/asm/hw_breakpoint.h>
> -

nit: Why this line is removed?

>  #define	__ARCH_HW_BREAKPOINT_H
> +#include <linux/types.h>
>  
>  /*
>   * The name should probably be something dealt in
> @@ -18,6 +18,11 @@ struct arch_hw_breakpoint {
>  	u8		type;
>  };
>  
> +enum bp_slot_action {
> +	BP_SLOT_ACTION_INSTALL,
> +	BP_SLOT_ACTION_UNINSTALL,
> +};
> +
>  #include <linux/kdebug.h>
>  #include <linux/percpu.h>
>  #include <linux/list.h>
> diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
> index b01644c949b2..1736063a82b7 100644
> --- a/arch/x86/kernel/hw_breakpoint.c
> +++ b/arch/x86/kernel/hw_breakpoint.c
> @@ -48,7 +48,6 @@ static DEFINE_PER_CPU(unsigned long, cpu_debugreg[HBP_NUM]);
>   */
>  static DEFINE_PER_CPU(struct perf_event *, bp_per_reg[HBP_NUM]);
>  
> -

Ditto.

>  static inline unsigned long
>  __encode_dr7(int drnum, unsigned int len, unsigned int type)
>  {
> @@ -84,54 +83,115 @@ int decode_dr7(unsigned long dr7, int bpnum, unsigned *len, unsigned *type)
>  	return (dr7 >> (bpnum * DR_ENABLE_SIZE)) & 0x3;
>  }
>  
> -/*
> - * Install a perf counter breakpoint.
> - *
> - * We seek a free debug address register and use it for this
> - * breakpoint. Eventually we enable it in the debug control register.
> - *
> - * Atomic: we hold the counter->ctx->lock and we only handle variables
> - * and registers local to this cpu.
> - */
> -int arch_install_hw_breakpoint(struct perf_event *bp)
> +static int manage_bp_slot(struct perf_event *bp, enum bp_slot_action action)
>  {
> -	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
> -	unsigned long *dr7;
> -	int i;
> +	struct perf_event *old_bp;
> +	struct perf_event *new_bp;
> +	int slot;
> +
> +	switch (action) {
> +	case BP_SLOT_ACTION_INSTALL:
> +		old_bp = NULL;
> +		new_bp = bp;
> +		break;
> +	case BP_SLOT_ACTION_UNINSTALL:
> +		old_bp = bp;
> +		new_bp = NULL;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
>  
>  	lockdep_assert_irqs_disabled();
>  
> -	for (i = 0; i < HBP_NUM; i++) {
> -		struct perf_event **slot = this_cpu_ptr(&bp_per_reg[i]);
> +	for (slot = 0; slot < HBP_NUM; slot++) {
> +		struct perf_event **curr = this_cpu_ptr(&bp_per_reg[slot]);
>  
> -		if (!*slot) {
> -			*slot = bp;
> -			break;
> +		if (*curr == old_bp) {
> +			*curr = new_bp;
> +			return slot;
>  		}
>  	}
>  
> -	if (WARN_ONCE(i == HBP_NUM, "Can't find any breakpoint slot"))
> -		return -EBUSY;
> +	if (old_bp) {
> +		WARN_ONCE(1, "Can't find matching breakpoint slot");
> +		return -EINVAL;
> +	}
>  
> -	set_debugreg(info->address, i);
> -	__this_cpu_write(cpu_debugreg[i], info->address);
> +	WARN_ONCE(1, "No free breakpoint slots");
> +	return -EBUSY;
> +}
>  
> -	dr7 = this_cpu_ptr(&cpu_dr7);
> -	*dr7 |= encode_dr7(i, info->len, info->type);
> +static void setup_hwbp(struct arch_hw_breakpoint *info, int slot, bool enable)
> +{
> +	unsigned long dr7;
> +
> +	set_debugreg(info->address, slot);
> +	__this_cpu_write(cpu_debugreg[slot], info->address);
> +
> +	dr7 = this_cpu_read(cpu_dr7);
> +	if (enable)
> +		dr7 |= encode_dr7(slot, info->len, info->type);
> +	else
> +		dr7 &= ~__encode_dr7(slot, info->len, info->type);
>  
>  	/*
> -	 * Ensure we first write cpu_dr7 before we set the DR7 register.
> -	 * This ensures an NMI never see cpu_dr7 0 when DR7 is not.
> +	 * Enabling:
> +	 *   Ensure we first write cpu_dr7 before we set the DR7 register.
> +	 *   This ensures an NMI never see cpu_dr7 0 when DR7 is not.
>  	 */
> +	if (enable)
> +		this_cpu_write(cpu_dr7, dr7);
> +
>  	barrier();
>  
> -	set_debugreg(*dr7, 7);
> +	set_debugreg(dr7, 7);
> +
>  	if (info->mask)
> -		amd_set_dr_addr_mask(info->mask, i);
> +		amd_set_dr_addr_mask(enable ? info->mask : 0, slot);
> +
> +	/*
> +	 * Disabling:
> +	 *   Ensure the write to cpu_dr7 is after we've set the DR7 register.
> +	 *   This ensures an NMI never see cpu_dr7 0 when DR7 is not.
> +	 */
> +	if (!enable)
> +		this_cpu_write(cpu_dr7, dr7);
> +}
> +
> +static int arch_manage_bp(struct perf_event *bp, enum bp_slot_action action)
> +{
> +	struct arch_hw_breakpoint *info;
> +	bool install = true;
> +	int slot;
> +
> +	if (action == BP_SLOT_ACTION_UNINSTALL)
> +		install = false;

This looks a bit unnecessary. 

> +
> +	slot = manage_bp_slot(bp, action);
> +	if (slot < 0)
> +		return slot;
> +
> +	info = counter_arch_bp(bp);
> +	setup_hwbp(info, slot, install);

since you can do

	setup_hwbp(info, slot,
		   action != BP_SLOT_ACTION_UNINSTALL);

Thank you,


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

