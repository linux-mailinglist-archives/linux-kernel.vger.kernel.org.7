Return-Path: <linux-kernel+bounces-844093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D221BC0FCF
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 12:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAC28188EAD1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 10:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7664C2D7DF6;
	Tue,  7 Oct 2025 10:16:08 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1489525A324
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 10:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759832168; cv=none; b=ek66rf/oRVSSeGM+knoSkWLCsci6ILC/JxZmqtll2JIcFs1xTvjPyaKrIoLbnH2Q5CtNKZvkMUzvkmAM8CVFqbi9fHO9tetaGxqlw34H0NgGl+99jWlaHXYga5J+VF+cVp50qSBxv1VF5ui1ThHZfdlJyHnRimQxUU5yBPqiAIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759832168; c=relaxed/simple;
	bh=EVYc896DRIPSIudKMi9q1kUcyR3baEWsSFshUnToE0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hgho9aoDMCLwZWD/eCgyDSlH9fK7ekRHTvC3TBNcq8SdaH3bhVvlShKMi64+TWbjW+W000XLTTVzu472Hr3Np7jHgi6wexrOJ/sqvvB5CFTdGLYuH1Gp9f4QX9RTiZhwOMv+v83N+pzgt3SoK0cYvkcE1V4cLzLA+dUSkMxHvaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DCDDC4CEF1;
	Tue,  7 Oct 2025 10:16:05 +0000 (UTC)
Date: Tue, 7 Oct 2025 11:16:03 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] irqchip/gic-v5: Fix GIC CDEOI instruction encoding
Message-ID: <aOToY8dF07zPe9Bt@arm.com>
References: <20251006100758.624934-1-lpieralisi@kernel.org>
 <aOPEXEx-QRv7v9A5@arm.com>
 <aOPZqM2xGIrPJH/d@lpieralisi>
 <aOPfIgrxZaqzu-7s@arm.com>
 <aOTWJBETJDY4xFUh@lpieralisi>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOTWJBETJDY4xFUh@lpieralisi>

On Tue, Oct 07, 2025 at 10:58:12AM +0200, Lorenzo Pieralisi wrote:
> On Mon, Oct 06, 2025 at 04:24:18PM +0100, Catalin Marinas wrote:
> > On Mon, Oct 06, 2025 at 05:00:56PM +0200, Lorenzo Pieralisi wrote:
> > > My only remark there is that even as the code in mainline stands with
> > > GCC, it is not very clear that we rely on implicit XZR generation to
> > > make sure the instruction encoding generated is correct - it looks
> > > like a bit of a stretch to reuse a sysreg write with immediate value == 0
> > > to generate a system instruction write with Rt == 0b11111, it works
> > > but it is a bit opaque or at least not straighforward to grok.
> > > 
> > > Obviously the patch below improves LLVM code generation too in the process.
> > > 
> > > I don't know what's best - I admit I am on the fence on this one.
> > 
> > My concern is other cases where we may rely on this, so we might as well
> > go with a generic approach than fixing each case individually. If that's
> > the only case, I'll leave it to you and Marc do decide whichever you
> > prefer.
> 
> I will take your patch - added comments and rewrote the log for v2, with
> your Suggested-by (did not give you authorship let me know if that's OK
> please).

That's absolutely fine.

> One thing to mention, I added a Fixes: tag that goes back to the initial
> GICv5 commit, I don't know whether it is fixing more than that, it does
> not look like by a quick grep through kernel code but I am not sure.

This would do. If we find other problems, we'll backport it.

-- 
Catalin

