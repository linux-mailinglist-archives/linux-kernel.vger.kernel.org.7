Return-Path: <linux-kernel+bounces-845219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0084ABC400E
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 10:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9FFE435288E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 08:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8097E2F49F4;
	Wed,  8 Oct 2025 08:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IfZztZSN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7302E22B4
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 08:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759913710; cv=none; b=iOtxLH7GToa8XXARvTEh6p7xokMUeCcZwZX1AHkNKuQuZAcU2E1YJSgG1BlIhUkI5u+SEV24VlY3QknIxb50ipPBEzw+BUJjYIL2t/ZkSl7dsSBtWmUNw2GqU73hiD7ed0gWdv6N20uiQgFMTZBU24HuuW48euB8Fpbvnr2qDoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759913710; c=relaxed/simple;
	bh=eyr6gDi37Ru8nuj21CkAi6nqiQrd/Us5xWlLiGHLy2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QtuKZ2XCsD9HG6+vuvNQMRyJSKL7n5UaP9ippBOGMVTjy7K6f1BMcKoWq4zIuEtWQHb3GzXk3K4mmU7nTcYX7dz5Hpj7zqCYTh+6evEr9OfP4dFa6q/BBWj+2uZRuv8r5s1jOZJquFTarjMeUMl1MQQKMLn+vaZ99AqYZDjqcTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IfZztZSN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3B61C4CEF4;
	Wed,  8 Oct 2025 08:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759913710;
	bh=eyr6gDi37Ru8nuj21CkAi6nqiQrd/Us5xWlLiGHLy2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IfZztZSNbIcLHWEXxmGMy7WBI7I5FnPLuHesKunLdfxwEVd7YFIJ/4HujdZFo74+m
	 mQArzKq0O8VkfyQ0NaHGmQIAg1rAaJj4yCyGnsJCsPWR/PgLeD8/uSeetV6EMkClQ0
	 /Ih7G0bIn9npYMYVfLHHazcjL9kB9XlFPX2029pGTi7NNohqpQ9FZoxWznon7ATN+Q
	 plbj5FBms3j8zXWeUlMn9TK7+eZ4fdgKRyZLrqqTmes2csL8h7o8BbZhJU166YF95S
	 4NoCKzuHrq+ijolrj7C/xeIQu4mfXyBCf9DOn0ZKJrZEdLiXNpFvJcX8k0ZRBKjypN
	 V5fwjJIW3Uv2g==
Date: Wed, 8 Oct 2025 09:55:05 +0100
From: Will Deacon <will@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v2] arm64/sysreg: Fix GIC CDEOI instruction encoding
Message-ID: <aOYm6SUnPo1VEvdM@willie-the-truck>
References: <20251007102600.879337-1-lpieralisi@kernel.org>
 <aOUsjRkq4DTcLujW@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOUsjRkq4DTcLujW@arm.com>

On Tue, Oct 07, 2025 at 04:06:53PM +0100, Catalin Marinas wrote:
> On Tue, Oct 07, 2025 at 12:26:00PM +0200, Lorenzo Pieralisi wrote:
> > The GIC CDEOI system instruction requires the Rt field to be set to 0b11111
> > otherwise the instruction behaviour becomes CONSTRAINED UNPREDICTABLE.
> > 
> > Currenly, its usage is encoded as a system register write, with a constant
> > 0 value:
> > 
> > write_sysreg_s(0, GICV5_OP_GIC_CDEOI)
> > 
> > While compiling with GCC, the 0 constant value, through these asm
> > constraints and modifiers ('x' modifier and 'Z' constraint combo):
> > 
> > asm volatile(__msr_s(r, "%x0") : : "rZ" (__val));
> > 
> > forces the compiler to issue the XZR register for the MSR operation (ie
> > that corresponds to Rt == 0b11111) issuing the right instruction encoding.
> > 
> > Unfortunately LLVM does not yet understand that modifier/constraint
> > combo so it ends up issuing a different register from XZR for the MSR
> > source, which in turns means that it encodes the GIC CDEOI instruction
> > wrongly and the instruction behaviour becomes CONSTRAINED UNPREDICTABLE
> > that we must prevent.
> > 
> > Add a conditional to write_sysreg_s() macro that detects whether it
> > is passed a constant 0 value and issues an MSR write with XZR as source
> > register - explicitly doing what the asm modifier/constraint is meant to
> > achieve through constraints/modifiers, fixing the LLVM compilation issue.
> > 
> > Fixes: 7ec80fb3f025 ("irqchip/gic-v5: Add GICv5 PPI support")
> > Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
> > Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> > Acked-by: Marc Zyngier <maz@kernel.org>
> > Cc: stable@vger.kernel.org
> > Cc: Sascha Bischoff <sascha.bischoff@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Marc Zyngier <maz@kernel.org>
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> 
> (unless Will sends another pull request before -rc1, I'll pick this
> patch shortly after)

I'm not planning to send anything until the -rc3 timeframe now as I'm
going fishing for a couple of weeks :)

Will

