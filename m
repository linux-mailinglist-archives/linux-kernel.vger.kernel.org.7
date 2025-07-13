Return-Path: <linux-kernel+bounces-729209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 674C3B03354
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 00:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E7AD7A8A23
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 22:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2791F91F6;
	Sun, 13 Jul 2025 22:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZTjTzON5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC8219D07A
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 22:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752446772; cv=none; b=AczNLq+fmG73IcFZa90sbEpX5i1K6AtToMaimwMlFRKfG+S9dBiEU1XxjzBFGcMNS4yAECSfe6HoxTiVmRiKMhMtN1HhEG2PjjNSEMMlQFAz+z+YdtxP1eLp2LrBOCMCgsHEgTODxhnjWQnvlJOd/rYjYdsGOzju9M/YBrkhKNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752446772; c=relaxed/simple;
	bh=JnUp2yg/CJKtlP4jODU9pih+4FgginRFGssMqlN1RLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VsO4J7l69Cf8+1SaF2tUQOi0rWjVijruoT0e7+Zrp+uJA+B+TGwirXNSuxBqlMF4FnpmIe8nW2jgVUyg3G1mGJFopeaQbHRYImfaYJ+celjFtFlAJrpIvTFkedwNIKYCQM1ZcAUjNhHWNtXs4aG+QIwbm2RAe4c70TGos6BoJYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZTjTzON5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F4AEC4CEE3;
	Sun, 13 Jul 2025 22:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752446771;
	bh=JnUp2yg/CJKtlP4jODU9pih+4FgginRFGssMqlN1RLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZTjTzON5a4Tk1uNO38cGBNO//z0NCoHFguYe+iRgTbJZhV8go8vunUI2GS5ATblfY
	 bfMH+BQkV5BlKFjDOnZ8niG8WlxWAyAjhqc4ZargukHFamFu4a5tBV0qLoBrpLNAfo
	 0YIPpfjZ8RanOter/N9CbDVA1O743qZM49h8qkHWtJnGDvgvkPQ9Ir2DCJVRSQemq+
	 mrwdMfYdfL40qVdrufLTdLJxZcgBvuXzkejEm7b/is0mmYyQDIim5pa8uAtgTIuIXB
	 Q1v7ibj91unzhLXdEGjOGRhaXYELUFL1gi1dYfN6YjDA7M9VXdVLiy9I2L95+8Vlxx
	 VRU7kKQ+S97QQ==
Date: Sun, 13 Jul 2025 23:46:06 +0100
From: Will Deacon <will@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, osandov@fb.com, leo.yan@arm.com,
	rmikey@meta.com
Subject: Re: [PATCH] arm64: traps: Mark kernel as tainted on SError panic
Message-ID: <aHQ3Lu27_mLfR8Ke@willie-the-truck>
References: <20250710-arm_serror-v1-1-2a3def3740d7@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710-arm_serror-v1-1-2a3def3740d7@debian.org>

On Thu, Jul 10, 2025 at 03:46:35AM -0700, Breno Leitao wrote:
> Set TAINT_MACHINE_CHECK when SError interrupts trigger a panic to
> flag potential hardware faults. This tainting mechanism aids in
> debugging and enables correlation of hardware-related crashes in
> large-scale deployments.
> 
> This change aligns with similar patches[1] that mark machine check
> events when the system crashes due to hardware errors.
> 
> Link: https://lore.kernel.org/all/20250702-add_tain-v1-1-9187b10914b9@debian.org/ [1]
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  arch/arm64/kernel/traps.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index 9bfa5c944379d..7468b22585cef 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -931,6 +931,7 @@ void __noreturn panic_bad_stack(struct pt_regs *regs, unsigned long esr, unsigne
>  
>  void __noreturn arm64_serror_panic(struct pt_regs *regs, unsigned long esr)
>  {
> +	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_STILL_OK);
>  	console_verbose();
>  
>  	pr_crit("SError Interrupt on CPU%d, code 0x%016lx -- %s\n",

If we're going to taint for SError, shouldn't we also taint for an
unclaimed SEA?

Will

