Return-Path: <linux-kernel+bounces-837334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E76BAC0F1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 10:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40F863208BC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 08:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D5C22DA1C;
	Tue, 30 Sep 2025 08:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T/SqDC6U"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F4A19004A;
	Tue, 30 Sep 2025 08:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759221106; cv=none; b=K94JdqyP5UJh9LY2Hze5AQiPfQmhoC8L2ldIk9RlciVNoeIoE6Uoptrc3thPg1Nxc3p8vgFeRyMzMnHJL1xSEJKewSaLHBCrZqHq+OYOHHRGLNY0U9SOpsz45wpGfNXoMgyvGE5LmVey5sny8aa08Radjj2/Y0+Bv7DJ9HSA5hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759221106; c=relaxed/simple;
	bh=OPs02tlUZssDRtfeF27pWqs/jJmi0Fqd/VBI8qnlRo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LCLYAl7XW9iWjt3B7V3t3ILakaUW5+yf9/nIWgOMYYFSuKCp7FqkDBHHTxPoh6BKFQtXb/uRJGgY7XnZ7ddUjyxyBdNNOu2dxEtHTMPQqWmR39rMz2XJWIBiNMkINxrdjqnqWOeKSNf4N8o2zmDj4MsZvkDGMgaiBp3iNfKGh4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=T/SqDC6U; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uEONBuTGx3rYWk9WaSqJyiVS3WbPByshmCr0l8SQhBs=; b=T/SqDC6UpxrJF+wAXLvvoSFHbr
	uRjBNDUG+QKs/2BDP6yw3zC5ukSw3QjNRmUDV+VglmqD8dARzs+Z2S61hzXCFFc9kSktl38t8xcyU
	/KaUxzFK0hJzOjzUkfDy+dZt8QvpazlT/BmpEvftg49oH6KgXIM7qtB9JwXgZScDfSti3iCfOM8cD
	ytgsYs2L7lgQ27YgD1uD6IVVq2m9fv7J7woV54Aq5VZEfvFiFg1UaP9R9pNvoOiRoT1E39Nuu1uRA
	lKdvDzz31ppC24YxJXecjWdXjusoFyYiGQmXwloTy6UV5ydcqixQaMvcvGQ95EbluxWN8XY0kFInK
	P7TDnhLA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3Vlq-0000000ChYy-11hN;
	Tue, 30 Sep 2025 08:31:38 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B36DA300328; Tue, 30 Sep 2025 10:31:37 +0200 (CEST)
Date: Tue, 30 Sep 2025 10:31:37 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, llvm@lists.linux.dev,
	xin@zytor.com, "H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH v2 09/12] x86/msr: Use the alternatives mechanism for
 WRMSR
Message-ID: <20250930083137.GH3245006@noisy.programming.kicks-ass.net>
References: <20250930070356.30695-1-jgross@suse.com>
 <20250930070356.30695-10-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930070356.30695-10-jgross@suse.com>

On Tue, Sep 30, 2025 at 09:03:53AM +0200, Juergen Gross wrote:

> +static __always_inline bool __wrmsrq_constant(u32 msr, u64 val, int type)
> +{
> +	BUILD_BUG_ON(!__builtin_constant_p(msr));
> +
> +	asm_inline volatile goto(
> +		"1:\n"
> +		ALTERNATIVE_2(PREPARE_RCX_RDX_FOR_WRMSR
> +			      "2: ds wrmsr",
> +			      PREPARE_RCX_RDX_FOR_WRMSR
> +			      ASM_WRMSRNS,
> +			      X86_FEATURE_WRMSRNS,
> +			      ASM_WRMSRNS_IMM,
> +			      X86_FEATURE_MSR_IMM)
> +		_ASM_EXTABLE_TYPE(1b, %l[badmsr], %c[type])	/* For WRMSRNS immediate */
> +		_ASM_EXTABLE_TYPE(2b, %l[badmsr], %c[type])	/* For WRMSR(NS) */
> +
> +		:
> +		: [val] "a" (val), [msr] "i" (msr), [type] "i" (type)
> +		: "memory", "ecx", "rdx"
> +		: badmsr);
> +
> +	return false;
> +
> +badmsr:
> +	return true;
> +}

Just wondering, would something this work?

	asm_inline volatile goto(
		"1:\n"
		ALTERNATIVE(PREPARE_RCX_RDX_FOR_WRMSR
			    "2:\n"
			    ALTERNATIVE("ds wrmsr",
			                ASM_WRMSRNS, X86_FEATURE_WRMSRNS),
			    ASM_WRMSRNS_IMM, X86_FEATURE_MSR_IMM);
		_ASM_EXTABLE_TYPE(1b, %l[badmsr], %c[type])	/* For WRMSRNS immediate */
		_ASM_EXTABLE_TYPE(2b, %l[badmsr], %c[type])	/* For WRMSR(NS) */

		:
		: [val] "a" (val), [msr] "i" (msr), [type] "i" (type)
		: "memory", "ecx", "rdx"
		: badmsr);

Its a bit weird because the nested alternative isn't for the exact same
position I suppose. But I find it a more readable form.

