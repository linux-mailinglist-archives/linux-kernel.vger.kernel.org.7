Return-Path: <linux-kernel+bounces-769087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58773B269FA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14DA8600B78
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0AA820101D;
	Thu, 14 Aug 2025 14:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="khzzYKY4"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589901DF248
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 14:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755182571; cv=none; b=he5wsmH04S2P0FFB+k0GcpZ4+9Oj6golMa/KBU2uITxyXB30J9n6AScSPEWau5KurEgFyvL+NXknAX7S8h9fWOfcaviuBD1JGflvkE/zLZsrTvZvr2bmW9vz3grf+shiQgMFncuHCGE1UkYvj8S9NESV7cvOg6lL8Vo/zV75I3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755182571; c=relaxed/simple;
	bh=afE/0gbO460nnSrOv/ajvLwpvgmqG5LJTOXuszwRD8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o1Ko+hcHlO4z9RLaoZNMNZARQx1u3yZJNMjEgfScDaX4SRpOiiV636dkTXrvK/Hl1eYpb0Ecly2/6lcFL2LtwMKMrENxk7xaXilt34oELTcmGLxXVY/a9vpJdJPg9yFO0vjuQTWZAydORVxFLB8wH/1sAXu7XTcUdD0zmanqWzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=khzzYKY4; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DYJNXiY1tgYiK8ZeZoEn3jifYQagH+kYNCTjSTl9+nE=; b=khzzYKY4iDYgy/ghol243hkDof
	wkK0eCMBXPJ4QxxeWpuq+D8bg25ebWIFnbpOv/zUY5RECkl+1V7tJtUVCnC3Gbmp7R6LdCFwhLGam
	EoF0VwWbfnVzIh3bIcgNJJY5h99/JAFX/cZuQi2hLaBbXGpiIWR6VzUXC1kvRnF12wRKsM0r2qHck
	Kj49Lwyj5wndHPGigP6taD0f6gOHFplJh2An3EZ+XNCTiCqLBGK6A+TJ5/YrrbvShEd2Gdx6V8viF
	Pd7KPGR4oEprnePeOfSFFH7dHolAFACV6AdHjs/LB3CRLdM5fieMSeSzyzVGbPqeJI3vDQN6fGQ8E
	3NvX++Ug==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umZAB-0000000GSCd-1rT1;
	Thu, 14 Aug 2025 14:42:43 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B4643302DFC; Thu, 14 Aug 2025 16:42:40 +0200 (CEST)
Date: Thu, 14 Aug 2025 16:42:40 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Dan Snyder <dansnyder@google.com>
Subject: Re: [PATCH 2/3] x86/umip: Fix decoding of register forms of 0F 01
 (SGDT and SIDT aliases)
Message-ID: <20250814144240.GA4067720@noisy.programming.kicks-ass.net>
References: <20250808172358.1938974-1-seanjc@google.com>
 <20250808172358.1938974-3-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808172358.1938974-3-seanjc@google.com>

On Fri, Aug 08, 2025 at 10:23:57AM -0700, Sean Christopherson wrote:
> Filter out the register forms of 0F 01 when determining whether or not to
> emulate in response to a potential UMIP violation #GP, as SGDT and SIDT
> only accept memory operands.  The register variants of 0F 01 are used to
> encode instructions for things like VMX and SGX, i.e. not checking the Mod
> field would cause the kernel incorrectly emulate on #GP, e.g. due to a CPL
> violation on VMLAUNCH.
> 
> Fixes: 1e5db223696a ("x86/umip: Add emulation code for UMIP instructions")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
>  arch/x86/kernel/umip.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/x86/kernel/umip.c b/arch/x86/kernel/umip.c
> index 406ac01ce16d..d432f3824f0c 100644
> --- a/arch/x86/kernel/umip.c
> +++ b/arch/x86/kernel/umip.c
> @@ -163,8 +163,19 @@ static int identify_insn(struct insn *insn)
>  	if (insn->opcode.bytes[1] == 0x1) {
>  		switch (X86_MODRM_REG(insn->modrm.value)) {
>  		case 0:
> +			/* The reg form of 0F 01 /0 encodes VMX instructions. */
> +			if (X86_MODRM_MOD(insn->modrm.value) == 3)
> +				return -EINVAL;
> +
>  			return UMIP_INST_SGDT;
>  		case 1:
> +			/*
> +			 * The reg form of 0F 01 /1 encodes MONITOR/MWAIT,
> +			 * STAC/CLAC, and ENCLS.
> +			 */
> +			if (X86_MODRM_MOD(insn->modrm.value) == 3)
> +				return -EINVAL;
> +
>  			return UMIP_INST_SIDT;
>  		case 4:
>  			return UMIP_INST_SMSW;
> -- 
> 2.50.1.703.g449372360f-goog
> 

