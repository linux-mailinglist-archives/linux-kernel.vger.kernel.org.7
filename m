Return-Path: <linux-kernel+bounces-843368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6D6BBF093
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 20:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 28C514F07F3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 18:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3E32DECC6;
	Mon,  6 Oct 2025 18:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aNxeQASX"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD542DECB0
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 18:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759776965; cv=none; b=Iaa45pRec/+bbquTgbL0Up5CPiLXbBo+XQfCV/MUyTlvQxT+JjJ4WyL8IO74Qflb9+fZen9LMc6B8qm+zl1QrAL7iNoOg8Tp0nF2LD4M70JFOUzKiBhI8l7ECD6KRzj2Q1WrpHjXPadmDLdqzqnlUAeurQvhCAAaprDvpXDnjWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759776965; c=relaxed/simple;
	bh=t7/J7ZrCZ3jTIZo/GLHWH9EEu1lk2G8wOxFvcAvZK1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mX0LLS4b52OTdEErLXPMv9GPjWIv80ea0JNblNHkB8fkVf0Hs8keAi3+krAP1UaqOQ0BlvtNpyGUDSWGfOt7y9DwkrS9HnhmgZ+SD5vKaKgvjM7EI4zbwMUvaO6olqsJx5f503tHaKr2oMJ3suDr38mKdVF+1ucjFGlG/bnaEXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aNxeQASX; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xJnkiQBZCdwaEp7zJFwkvtRIj+U9D3ctR20ZvgQtseA=; b=aNxeQASXnfJQhH8Kt1lDapgDuO
	/nLSwzuTyZczIZWbUw/GxPxulgAKifQX/YTBEcF2PpOgcA8zbdM08XCyICg5Re1UfO7w5ymPFmCP/
	n0FD5aka8eHWY/311/pPH43sSouBte46ZOQhJDA9CGOoKAfdLpb0KN/hMATIZTM7hF0vIg3yh5fiC
	dmLK6nRTRIyNI8e2gDDqXJobztx0Cz/g9DAUtnoQOElCjZWtE3G/d7m5AT6x9NpwKOYCYg+9GzCnm
	zm+BqJMijhENmoaaVUDk57dfyPtAOpGy6Bad3brAnuT3oj2wNt8IE/OKUAQ23YxGAQWrJVAi1AaTk
	ikxHoFow==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5qNE-0000000032U-1idK;
	Mon, 06 Oct 2025 18:55:53 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 32E9B300212; Mon, 06 Oct 2025 20:55:53 +0200 (CEST)
Date: Mon, 6 Oct 2025 20:55:53 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	xen-devel@lists.xenproject.org
Subject: Re: [PATCH v3 15/21] x86/xen: Drop xen_irq_ops
Message-ID: <20251006185553.GY3245006@noisy.programming.kicks-ass.net>
References: <20251006074606.1266-1-jgross@suse.com>
 <20251006074606.1266-16-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006074606.1266-16-jgross@suse.com>

On Mon, Oct 06, 2025 at 09:46:00AM +0200, Juergen Gross wrote:
> Instead of having a pre-filled array xen_irq_ops for Xen PV paravirt
> functions, drop the array and assign each element individually.

Same comment for the next few patches; this changelog is a little light
on *why*. I mean, I don't mind the change, but supposedly we should
justify things at least a little, right? :-)

> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
> V2:
> - new patch
> ---
>  arch/x86/xen/irq.c    | 20 +++++++-------------
>  tools/objtool/check.c |  1 -
>  2 files changed, 7 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/x86/xen/irq.c b/arch/x86/xen/irq.c
> index 39982f955cfe..d8678c3d3971 100644
> --- a/arch/x86/xen/irq.c
> +++ b/arch/x86/xen/irq.c
> @@ -40,20 +40,14 @@ static void xen_halt(void)
>  		xen_safe_halt();
>  }
>  
> -static const typeof(pv_ops) xen_irq_ops __initconst = {
> -	.irq = {
> -		/* Initial interrupt flag handling only called while interrupts off. */
> -		.save_fl = __PV_IS_CALLEE_SAVE(paravirt_ret0),
> -		.irq_disable = __PV_IS_CALLEE_SAVE(paravirt_nop),
> -		.irq_enable = __PV_IS_CALLEE_SAVE(BUG_func),
> -
> -		.safe_halt = xen_safe_halt,
> -		.halt = xen_halt,
> -	},
> -};
> -
>  void __init xen_init_irq_ops(void)
>  {
> -	pv_ops.irq = xen_irq_ops.irq;
> +	/* Initial interrupt flag handling only called while interrupts off. */
> +	pv_ops.irq.save_fl = __PV_IS_CALLEE_SAVE(paravirt_ret0);
> +	pv_ops.irq.irq_disable = __PV_IS_CALLEE_SAVE(paravirt_nop);
> +	pv_ops.irq.irq_enable = __PV_IS_CALLEE_SAVE(BUG_func);
> +	pv_ops.irq.safe_halt = xen_safe_halt;
> +	pv_ops.irq.halt = xen_halt;
> +
>  	x86_init.irqs.intr_init = xen_init_IRQ;
>  }
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index a72059fcbc83..d66eb37ff294 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -593,7 +593,6 @@ static int init_pv_ops(struct objtool_file *file)
>  	static const char *pv_ops_tables[] = {
>  		"pv_ops",
>  		"xen_cpu_ops",
> -		"xen_irq_ops",
>  		"xen_mmu_ops",
>  		NULL,
>  	};
> -- 
> 2.51.0
> 

