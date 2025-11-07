Return-Path: <linux-kernel+bounces-890127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3DBC3F485
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 10:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AEC414E842C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 09:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D592F747B;
	Fri,  7 Nov 2025 09:57:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADA8184
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 09:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762509469; cv=none; b=BuQWGSVmHOtQcOb3O6wNmRejxkqYhOAzDdL+JAw+M5S1Gsc1p6/nPRmNYErSeSAIgJ29JqN//aAJA71m8O5cldKVN/cha4SEbexy8K1mSgh56wesdloPZ/P8eCMBHF0U78Qv1UPNvjgEjmYYGflW6ZNU4fh4dop2Q0jdDMK2oFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762509469; c=relaxed/simple;
	bh=awxPD3ApUF3ZwCPfkAPM6D/7X0IxP8P1klLmAudkyAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e/BL48YwxgunA2dIqr9Nn8cfLlP1eq/xhU98JYdvM8kEsJEcRqcXMrGox7rOWczn9eK2agq2K6ulXuqIfYA0s2Zup9B7CNABKR1dNcxzVYLIXZgaNTWazIBq7YNAdnmSUlU+CDYzequHpGo2Y9txcZlrXapdSrX4dHRvQzSlauw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53BF714BF;
	Fri,  7 Nov 2025 01:57:39 -0800 (PST)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B3523F66E;
	Fri,  7 Nov 2025 01:57:45 -0800 (PST)
Date: Fri, 7 Nov 2025 09:57:40 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Adrian =?utf-8?Q?Barna=C5=9B?= <abarnas@google.com>,
	Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Dylan Hatch <dylanbhatch@google.com>,
	Fanqin Cui <cuifq1@chinatelecom.cn>
Subject: Re: [PATCH v2 2/2] arch: arm64: Reject modules with internal
 alternative callbacks
Message-ID: <aQ3ClNpcT-YBlvnG@J2N7QTR9R3>
References: <20250922130427.2904977-1-abarnas@google.com>
 <20250922130427.2904977-3-abarnas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250922130427.2904977-3-abarnas@google.com>

On Mon, Sep 22, 2025 at 01:04:27PM +0000, Adrian Barnaś wrote:
> During module loading, check if a callback function used by the
> alternatives specified in the '.altinstruction' ELF section (if present)
> is located in core kernel .text. If not fail module loading before
> callback is called.
> 
> Reported-by: Fanqin Cui <cuifq1@chinatelecom.cn>
> Closes: https://lore.kernel.org/all/20250807072700.348514-1-fanqincui@163.com/
> Signed-off-by: Adrian Barnaś <abarnas@google.com>
> ---
>  arch/arm64/include/asm/alternative.h |  7 +++++--
>  arch/arm64/kernel/alternative.c      | 19 ++++++++++++-------
>  arch/arm64/kernel/module.c           |  9 +++++++--
>  3 files changed, 24 insertions(+), 11 deletions(-)

[...]

> @@ -166,10 +166,13 @@ static void __apply_alternatives(const struct alt_region *region,
>  		updptr = is_module ? origptr : lm_alias(origptr);
>  		nr_inst = alt->orig_len / AARCH64_INSN_SIZE;
>  
> -		if (ALT_HAS_CB(alt))
> +		if (ALT_HAS_CB(alt)) {
>  			alt_cb  = ALT_REPL_PTR(alt);
> -		else
> +			if (!core_kernel_text((unsigned long)alt_cb))
> +				return -ENOEXEC;
> +		} else {
>  			alt_cb = patch_alternative;
> +		}

There's an existing noinstr safety issue there that this makes a bit
worse.

The core_kernel_text() function is instrumentable, and so for
(non-module) alternatives, calling that in the middle of patching isn't
safe (as it could lead to calling arbitrary C code mid-patching).

That said, __apply_alternatives() aren't marked as noinstr, and cleaning
that up properly is going to require some major rework. I don't think we
want to block this patch on that.

I think we can bodge around the worst of that for now with:

	if (is_module && !core_kernel_text((unsigned long)alt_cb))
		return -ENOEXEC;

... which'll avoid calling out to other instrumentable code during the
patching sequence, and minimize the risk of that blowing up during boot.

I'll see about prioritizing a follow-up to fix the extant issues more
thoroughly.

Will, are you happy to add the 'is module &&' part to the condition?

Mark.

