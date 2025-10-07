Return-Path: <linux-kernel+bounces-844420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F072BC1DCF
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 17:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A790334FC6B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 15:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063FF1FBE9E;
	Tue,  7 Oct 2025 15:06:58 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5F21F3B9E
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 15:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759849617; cv=none; b=L4cifZL9LffHCVFC1lkqQRB8C+xJdkH2GIELYm6oBy6HARDWHLp7oTg7av7NLtE3vseB8QYnbQykDfDCr8h8bi6JB0aos1keuZJkR0n7sfaQ4U9Yh5cbi9/qFpbvT5Sym7hYQloGrktKBLx+ku3xtezbhh5rRPqELEO8q+vwkiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759849617; c=relaxed/simple;
	bh=++vkDdKri2G/84Xuas4kaollScSVkT7SOgMcHmvpzwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rGDFIR1M/OoLhoZnh2S3CYmpVCAdBA8Jp0Un9BxNcN08mUPDaLhk4ZruR4HFBxt5Kz8JYl/klgP20g7DJUiqpOcrZlDplf2PhtVU26K1ucPZZXaTG79Nh1UEVD5/9WF99rDJ0vuPJNfd3DPq4/VicaSub1ynZUcxVom2xxQF308=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAFC5C4CEF1;
	Tue,  7 Oct 2025 15:06:55 +0000 (UTC)
Date: Tue, 7 Oct 2025 16:06:53 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v2] arm64/sysreg: Fix GIC CDEOI instruction encoding
Message-ID: <aOUsjRkq4DTcLujW@arm.com>
References: <20251007102600.879337-1-lpieralisi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007102600.879337-1-lpieralisi@kernel.org>

On Tue, Oct 07, 2025 at 12:26:00PM +0200, Lorenzo Pieralisi wrote:
> The GIC CDEOI system instruction requires the Rt field to be set to 0b11111
> otherwise the instruction behaviour becomes CONSTRAINED UNPREDICTABLE.
> 
> Currenly, its usage is encoded as a system register write, with a constant
> 0 value:
> 
> write_sysreg_s(0, GICV5_OP_GIC_CDEOI)
> 
> While compiling with GCC, the 0 constant value, through these asm
> constraints and modifiers ('x' modifier and 'Z' constraint combo):
> 
> asm volatile(__msr_s(r, "%x0") : : "rZ" (__val));
> 
> forces the compiler to issue the XZR register for the MSR operation (ie
> that corresponds to Rt == 0b11111) issuing the right instruction encoding.
> 
> Unfortunately LLVM does not yet understand that modifier/constraint
> combo so it ends up issuing a different register from XZR for the MSR
> source, which in turns means that it encodes the GIC CDEOI instruction
> wrongly and the instruction behaviour becomes CONSTRAINED UNPREDICTABLE
> that we must prevent.
> 
> Add a conditional to write_sysreg_s() macro that detects whether it
> is passed a constant 0 value and issues an MSR write with XZR as source
> register - explicitly doing what the asm modifier/constraint is meant to
> achieve through constraints/modifiers, fixing the LLVM compilation issue.
> 
> Fixes: 7ec80fb3f025 ("irqchip/gic-v5: Add GICv5 PPI support")
> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Acked-by: Marc Zyngier <maz@kernel.org>
> Cc: stable@vger.kernel.org
> Cc: Sascha Bischoff <sascha.bischoff@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

(unless Will sends another pull request before -rc1, I'll pick this
patch shortly after)

