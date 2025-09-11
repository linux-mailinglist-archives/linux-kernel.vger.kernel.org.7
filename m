Return-Path: <linux-kernel+bounces-811810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD57B52E25
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 12:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC1FF488121
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 10:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBDC30F93E;
	Thu, 11 Sep 2025 10:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="stSh6XzC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B8C2E2667
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 10:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757585812; cv=none; b=WKul/W6I0YmWBibg499fJ9ePP7PFzNMnpk4Ykt4hhVy4Kr2Diss/X7MN1lxb/ZbDTHui0XnUEb3rYNgCGp+sEITq5iSFDE1OnGX4X4BDoHpXORWN7L9SGCufIZqxVzYUekWoE6IEO36wzhTxc5CqR85AtwXtVTIztoLBIrSjhYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757585812; c=relaxed/simple;
	bh=a6S+Br/fgUd7z4S7dml4+BHYmTTSmyMv5FUVs6TOF2c=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=qlD4WwZKEiIYPMLAfZgXY0jchVz/EzVbSSt852Z37KSA8gtWMo1hSrL8rMkcjwSlHhXvyXJaUGYzCPdbf228gcAuP59nQl3MEOYyGW64Hni5WZjVDJiwTMGkM8Ge50B4G0C9hD5Sn7jlokS1Gqs2rE6UDNXYaGGPbDUdD7Jsm0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=stSh6XzC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49406C4CEF0;
	Thu, 11 Sep 2025 10:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757585811;
	bh=a6S+Br/fgUd7z4S7dml4+BHYmTTSmyMv5FUVs6TOF2c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=stSh6XzCji8MH0VayzZOlbTsv95KDPP0j2xAJdFDMqQLndbFfmRmZIp0gN0akhwWp
	 COInAjRAwtDZMbz0AL1sIvVVocJ+Q7nm1PK1ZKJZ4oNHYdndofVTc161zxtOLvqqZO
	 vwRTY4LvHouhX5DI5tRL4PW1NKd2TlX2hUvjG5rYyXNmHURgc06v40bJrCfXXI8nsk
	 UDl/9DMABOZZvT0G6BcGFKMh1C/p4HCcOoArb1fZDYVN8kxIuyuUCmqpp7tZ0ICvNC
	 DXQFQXT89ygg177i0UK1GeAXzfKRERhwfr2w8qScnl7ZXlvkWUkzUAdoQPxMmNuTWq
	 ZxEhC4Omgbq4Q==
Date: Thu, 11 Sep 2025 19:16:48 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jinchao Wang <wangjinchao600@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/hw_breakpoint: Add arch_reinstall_hw_breakpoint
Message-Id: <20250911191648.f1e9f0fbb6856416e3865b9c@kernel.org>
In-Reply-To: <20250910093951.1330637-2-wangjinchao600@gmail.com>
References: <20250910093951.1330637-1-wangjinchao600@gmail.com>
	<20250910093951.1330637-2-wangjinchao600@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Sep 2025 17:39:35 +0800
Jinchao Wang <wangjinchao600@gmail.com> wrote:

> The new `arch_reinstall_hw_breakpoint` function can be used in an
> atomic context, unlike the more expensive free and re-allocation path.
> 
> This patch adds `BP_SLOT_ACTION_REINSTALL` to the `enum` and updates the
> `manage_bp_slot` helper to correctly handle the action. This allows
> callers to efficiently re-establish an existing breakpoint.
> 

Ah, this also looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
> ---
>  arch/x86/include/asm/hw_breakpoint.h |  2 ++
>  arch/x86/kernel/hw_breakpoint.c      | 21 +++++++++++++++++++++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/arch/x86/include/asm/hw_breakpoint.h b/arch/x86/include/asm/hw_breakpoint.h
> index bd437a30dbf2..d1cc6db8a59f 100644
> --- a/arch/x86/include/asm/hw_breakpoint.h
> +++ b/arch/x86/include/asm/hw_breakpoint.h
> @@ -20,6 +20,7 @@ struct arch_hw_breakpoint {
>  
>  enum bp_slot_action {
>  	BP_SLOT_ACTION_INSTALL,
> +	BP_SLOT_ACTION_REINSTALL,
>  	BP_SLOT_ACTION_UNINSTALL,
>  };
>  
> @@ -64,6 +65,7 @@ extern int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
>  
>  
>  int arch_install_hw_breakpoint(struct perf_event *bp);
> +int arch_reinstall_hw_breakpoint(struct perf_event *bp);
>  void arch_uninstall_hw_breakpoint(struct perf_event *bp);
>  void hw_breakpoint_pmu_read(struct perf_event *bp);
>  void hw_breakpoint_pmu_unthrottle(struct perf_event *bp);
> diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
> index 1736063a82b7..99223695cee8 100644
> --- a/arch/x86/kernel/hw_breakpoint.c
> +++ b/arch/x86/kernel/hw_breakpoint.c
> @@ -94,6 +94,10 @@ static int manage_bp_slot(struct perf_event *bp, enum bp_slot_action action)
>  		old_bp = NULL;
>  		new_bp = bp;
>  		break;
> +	case BP_SLOT_ACTION_REINSTALL:
> +		old_bp = bp;
> +		new_bp = bp;
> +		break;
>  	case BP_SLOT_ACTION_UNINSTALL:
>  		old_bp = bp;
>  		new_bp = NULL;
> @@ -192,6 +196,23 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
>  	return arch_manage_bp(bp, BP_SLOT_ACTION_INSTALL);
>  }
>  
> +/*
> + * Reinstall a hardware breakpoint on the current CPU.
> + *
> + * This function is used to re-establish a perf counter hardware breakpoint.
> + * It finds the debug address register slot previously allocated for the
> + * breakpoint and re-enables it by writing the address to the debug register
> + * and setting the corresponding bits in the debug control register (DR7).
> + *
> + * It is expected that the breakpoint's event context lock is already held
> + * and interrupts are disabled, ensuring atomicity and safety from other
> + * event handlers.
> + */
> +int arch_reinstall_hw_breakpoint(struct perf_event *bp)
> +{
> +	return arch_manage_bp(bp, BP_SLOT_ACTION_REINSTALL);
> +}
> +
>  /*
>   * Uninstall the breakpoint contained in the given counter.
>   *
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

