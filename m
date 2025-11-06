Return-Path: <linux-kernel+bounces-889105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EBFC3CBD8
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 18:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9D7E7500349
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 17:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B462334EF1F;
	Thu,  6 Nov 2025 17:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LybdHwwx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AB634DB5E;
	Thu,  6 Nov 2025 17:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762448782; cv=none; b=JIXO7sJ7tUeTX3Oztd7zr841oGi/nZboP2AyN4Xf06hgSMCIW68Ih1QJU1IIrCxXsiYpsiuYfPbFJcv15M3Sn8nnyRRdriubVuZGGdXZ6QNORGNjCYpjvQ7AiQ8eBYlUmrxaKkEB7SC3fEwqUoBY7qY9DhkwmQafHLZTBgvnJgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762448782; c=relaxed/simple;
	bh=M5iJ6lx/8m827cdMGhhwDPZo7FFr9kpXeoQ4kuM2gIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gUZbQYvcA3T7h7bjYCZrodKtaGPw0+FkQJx5z/B4192k7kZRFxYYRGhUoGXsrb5pMtRIzqgDG7tDjPzQfWhJoNnrHuRonNFfDP4MIHl3u6y46hWXWEtVGfqvUlMOzLk8lrGswkcZeZFhsHLJHjJFK4JvOYYFysXm/k2569+jQj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LybdHwwx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 920D4C116B1;
	Thu,  6 Nov 2025 17:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762448781;
	bh=M5iJ6lx/8m827cdMGhhwDPZo7FFr9kpXeoQ4kuM2gIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LybdHwwxPpiZZtLGZX2x0S9gwJYvev6hDsFDkbOuH85HNilpZaogdapBllq4bjQmk
	 3BA1JPNV7Ohs1DEMiBwX0F0ImAkYub/XfYcVb6qYvwGw+VdddMvcTTl8sxfTIKOG53
	 qYhS5BJwGcA+OSaITq7YcZbafeNWRq94576FU4w5wj05VB3BIQxoUYsulItZcl+XEZ
	 KTQjs/BuZXOU7hEzJgSIL9uYFE1AK22V2Tc6Sym6I9rxj2WoG6TFObf8xmpi7A92ew
	 CSyuj6fnnURHI/uP0vDuB0mVqBHBp6qpHC8fFOFSQQTc02UZ8QMj+nfGWt38Mhmvrr
	 crTPU1WeWu/YQ==
Date: Thu, 6 Nov 2025 10:06:16 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v1 1/1] compiler_types: Warn about unused static inline
 functions on second
Message-ID: <20251106170616.GB1693433@ax162>
References: <20251106105000.2103276-1-andriy.shevchenko@linux.intel.com>
 <20251106151649.GA1693433@ax162>
 <aQzGP8Z-mvSS9w7C@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQzGP8Z-mvSS9w7C@smile.fi.intel.com>

On Thu, Nov 06, 2025 at 06:01:03PM +0200, Andy Shevchenko wrote:
> On Thu, Nov 06, 2025 at 08:16:49AM -0700, Nathan Chancellor wrote:
> > and we should
> > probably drop the sentence about removing __inline_maybe_unused entirely
> > since people such as Peter will never want this behavior by default. I
> > do not mind doing it myself if I take it.
> 
> But future is uncertain, it might be that GCC also gains this and it won't
> confuse anyway as it might become a truth (no more such warnings in the code)
> at some point.

The reality of the situation is that moving this warning to W=2 is
basically the same as just turning it off entirely since building with
W=2 is not a common endeavor for the majority of folks actually writing
kernel code, so the number of warnings will just continue to grow. At
that point, there is very little reason to believe that we would be able
to go from W=2 to enabled by default at some point in the future since
people already do not like it enabled at W=1 where it is not as
impactful as enabled by default. As a result, I feel like the comment
genuinely serves no purpose. If GCC were to change its behavior to
match clang, I feel like kernel folks would still want the current GCC
behavior.

Cheers,
Nathan

