Return-Path: <linux-kernel+bounces-805770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C096B48D33
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D82A93AFBD7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 12:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C101D2FDC56;
	Mon,  8 Sep 2025 12:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MD+YBum7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF2321C167;
	Mon,  8 Sep 2025 12:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757333813; cv=none; b=PVgRJRSZseYV3U96/SL24RDuuIyQ9AZKzUQ6J+lATGnLJ1SrCfizOMIOGC2fES8JDkvmEGBxep94MoSy5QOx3yV6dLheDF0HoKR/5Bzt3Q7z6CedBPsMyHTmYkOhlj8fVui3VUZCWW3o7udNBVmZx7CSlB4Xbk7EVLL20ksnmxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757333813; c=relaxed/simple;
	bh=JeLtMr5mbqMvT4H9vUGBXZD2zJiawG8cSjyIWuyr4gU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=suOj6taf32aZWbMlvascCZwA3KUSwbo2vtRCIg6JXqX2v4WKzpjZLvHAVlHxcdPMXhj3rJxxzg/OSYjDOEAlKim6XnUeOT9QWriwFjWzC3HzB48+hSks/iSZ6Q7O/zHIs4uD6ErR1V3upz7FWYbQsxHLSZlko1sdR5+24W8eWmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MD+YBum7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8193FC4CEF1;
	Mon,  8 Sep 2025 12:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757333811;
	bh=JeLtMr5mbqMvT4H9vUGBXZD2zJiawG8cSjyIWuyr4gU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MD+YBum7Mx2eaGyAQVN3pLSwfpOjSDtqxERnPq8HaEktORlVu7mh4KhuhpdrT76ni
	 VJ7/fy6w0B7vArsp7kKuthIvVpT3ny8Vrzfjvf/nPmI5pP2b7wVLoH+JJOcDC46eT5
	 4lvew7YzSY4ZEVHbKN0bwiF9vikmw4FGzy7bZjAvyv9t7IpMvBXMiCUvT/zDnkptTk
	 83eNBoK2+Vz6D5RActWo9crw0M8NxzEqOI8/i8i0rLzezIrYqw3xGuNWtu/zZ89iAZ
	 v0OGV6WTM569w6k8xvBwhJSQMJ0moc9ggg7z1VlSF70sEXHHOnNAZxHG8D2YAaDAUT
	 sOpADMT1o+0Rg==
Date: Mon, 8 Sep 2025 13:16:45 +0100
From: Will Deacon <will@kernel.org>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, catalin.marinas@arm.com, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, qperret@google.com, keirf@google.com
Subject: Re: [PATCH 1/2] KVM: arm64: Dump instruction on hyp panic
Message-ID: <aL7JLbljvX1JATP3@willie-the-truck>
References: <20250717234744.2254371-1-smostafa@google.com>
 <20250717234744.2254371-2-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250717234744.2254371-2-smostafa@google.com>

On Thu, Jul 17, 2025 at 11:47:43PM +0000, Mostafa Saleh wrote:
> Similar to the kernel panic, where the instruction code is printed,
> we can do the same for hypervisor panics.
> 
> This patch does that only in case of “CONFIG_NVHE_EL2_DEBUG” or nvhe.
> 
> The next patch adds support for pKVM.
> 
> Also, remove the hardcoded argument dump_kernel_instr().
> 
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  arch/arm64/include/asm/traps.h |  1 +
>  arch/arm64/kernel/traps.c      | 20 +++++++++++++-------
>  arch/arm64/kvm/handle_exit.c   |  5 +++++
>  3 files changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/traps.h b/arch/arm64/include/asm/traps.h
> index 82cf1f879c61..0d7e86a95d62 100644
> --- a/arch/arm64/include/asm/traps.h
> +++ b/arch/arm64/include/asm/traps.h
> @@ -30,6 +30,7 @@ void arm64_force_sig_mceerr(int code, unsigned long far, short lsb, const char *
>  void arm64_force_sig_ptrace_errno_trap(int errno, unsigned long far, const char *str);
>  
>  int early_brk64(unsigned long addr, unsigned long esr, struct pt_regs *regs);
> +void dump_instr(unsigned long addr);
>  
>  /*
>   * Move regs->pc to next instruction and do necessary setup before it
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index 9bfa5c944379..d692c05e3686 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -149,15 +149,11 @@ pstate_check_t * const aarch32_opcode_cond_checks[16] = {
>  
>  int show_unhandled_signals = 0;
>  
> -static void dump_kernel_instr(const char *lvl, struct pt_regs *regs)
> +void dump_instr(unsigned long addr)
>  {
> -	unsigned long addr = instruction_pointer(regs);
>  	char str[sizeof("00000000 ") * 5 + 2 + 1], *p = str;
>  	int i;
>  
> -	if (user_mode(regs))
> -		return;
> -
>  	for (i = -4; i < 1; i++) {
>  		unsigned int val, bad;

I'm a little worried that this function might be used to try and dump
instructions from userspace now that it just takes an address.

Maybe we could:

  - Keep the name unchanged, e.g. void dump_kernel_instr(unsigned long kaddr)
  - Inline the user_mode(regs) and instruction_pointer(regs) calls into
    __die()
  - Check is_ttbr1_addr(kaddr) in dump_kernel_instr()

WDYT?

Will

