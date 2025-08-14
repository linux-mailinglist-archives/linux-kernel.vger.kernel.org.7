Return-Path: <linux-kernel+bounces-769085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A76B8B26A06
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6175D563C9A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E021E1DEC;
	Thu, 14 Aug 2025 14:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qw8Aj+sv"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9674D1DE3B5
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 14:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755182558; cv=none; b=o6x/qCUebU5EkkAUAY/D2UgU3PLRzgj/ZoLkdrOea5HgDO+ZDY9F+xno5n09GMk+qV1JVsDigWjM6wlPiYq6NTF2GJUVAOHKYD8kRnD1yHVJkL9KugkneHZ/Vjs2qYfqlUxKNUuBfM3oyf4T3jdV4eeebSTy5HmbCrN8lRWpuHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755182558; c=relaxed/simple;
	bh=uYHe/HzCXFfJbiQWNsJ0rFiCB/7FEZwg5ucfrCWgZ5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gx+zhu5Nat3zsV5pI/qbfA/Ln+YXiolfT7QL/AxuwTppV1wyNc5PTJLmj9hsb2KjrghfWFl30Zf33jXeXVXsO9UFIjlaagxTg7nvdnBeiL6Mvsn/V1QK+VyGmkRsAVVV7ZTOVghZ75h4rKI6qZfD1tNk60wk2fagzeq5gVALT1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qw8Aj+sv; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iLDnNN9Pm70ZNkeOhyVb33TdGWb4EGdlyorRGGW6X9g=; b=qw8Aj+svrydCbs9XnL1D7nn7ok
	dEENQWfnbmGsmRx5UktinjSJ/eZ35h1nJBT2xHclbsVGSvUNf6B1E1fYbvi9KwsBM3VeOdMb660Qn
	8UsBvKl+0jQ+TW/B3c7XO9AfucR0UcYLavDHJYO/Lq3MHSjtidk1l7NdjBIKrd4jRMx2YnlcHKKtH
	eiolLTAPqufQabsGus2BeQR5ywjRWt/tBN0JQNBfAOrcAb8oTdLYyb/U6xd3BvCMPLENcd0siMgbG
	BFo5a3Rmfwt+vGO4NngjuxR5JCYFm4EK/wBf3LHp/7zmRyad05JYH5RJ0cM2dxqNEV4ezHOdCXRV6
	V0oIrTiQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umZ9r-00000001Sjj-1qjP;
	Thu, 14 Aug 2025 14:42:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CDF953002C5; Thu, 14 Aug 2025 16:42:17 +0200 (CEST)
Date: Thu, 14 Aug 2025 16:42:17 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Dan Snyder <dansnyder@google.com>
Subject: Re: [PATCH 1/3] x86/umip: Check that the instruction opcode is at
 least two bytes
Message-ID: <20250814144217.GZ4067720@noisy.programming.kicks-ass.net>
References: <20250808172358.1938974-1-seanjc@google.com>
 <20250808172358.1938974-2-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808172358.1938974-2-seanjc@google.com>

On Fri, Aug 08, 2025 at 10:23:56AM -0700, Sean Christopherson wrote:
> When checking for a potential UMIP violation on #GP, verify the decoder
> found at least two opcode bytes to avoid false positives when the kernel
> encounters an unknown instruction that starts with 0f.  Because the array
> of opcode.bytes is zero-initialized by insn_init(), peeking at bytes[1]
> will misinterpret garbage as a potential SLDT or STR instruction, and can
> incorrectly trigger emulation.
> 
> E.g. if a vpalignr instruction
> 
>    62 83 c5 05 0f 08 ff     vpalignr xmm17{k5},xmm23,XMMWORD PTR [r8],0xff
> 
> hits a #GP, the kernel emulates it as STR and squashes the #GP (and
> corrupts the userspace code stream).
> 
> Arguably the check should look for exactly two bytes, but no three byte
> opcodes use '0f 00 xx' or '0f 01 xx' as an escape, i.e. it should be
> impossible to get a false positive if the first two opcode bytes match
> '0f 00' or '0f 01'.  Go with a more conservative check with respect to the
> existing code to minimize the chances of breaking userspace, e.g. due to
> decoder weirdness.
> 
> Fixes: 1e5db223696a ("x86/umip: Add emulation code for UMIP instructions")
> Reported-by: Dan Snyder <dansnyder@google.com>
> Analyzed-by; Nick Bray <ncbray@google.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
>  arch/x86/kernel/umip.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/umip.c b/arch/x86/kernel/umip.c
> index 5a4b21389b1d..406ac01ce16d 100644
> --- a/arch/x86/kernel/umip.c
> +++ b/arch/x86/kernel/umip.c
> @@ -156,8 +156,8 @@ static int identify_insn(struct insn *insn)
>  	if (!insn->modrm.nbytes)
>  		return -EINVAL;
>  
> -	/* All the instructions of interest start with 0x0f. */
> -	if (insn->opcode.bytes[0] != 0xf)
> +	/* The instructions of interest have 2-byte opcodes: 0F 00 or 0F 01. */
> +	if (insn->opcode.nbytes < 2 || insn->opcode.bytes[0] != 0xf)
>  		return -EINVAL;
>  
>  	if (insn->opcode.bytes[1] == 0x1) {
> -- 
> 2.50.1.703.g449372360f-goog
> 

