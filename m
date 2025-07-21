Return-Path: <linux-kernel+bounces-739860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C25B0CC30
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 22:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD73B7AB339
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 20:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CFC23C4FA;
	Mon, 21 Jul 2025 20:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPrKGkoL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D9123C4EC
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 20:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753131585; cv=none; b=hXFu6m4dapNSlxXUGAB+FXql2jcGqg8efTLRKOV6j8ppclKB5qlDwhlmXF0oSBiPYTD4Szj4zV41fCz7Fqc/DbKTc91fyv7s/C6f/+IvyokVLTbTeOQuBbVAbxO1aD0zr9/5WF+lipnfg6mLxjq+0zab8jan3IFGQg7iB60Aj+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753131585; c=relaxed/simple;
	bh=PCXzX9mRr03P4nIeOBJHP6i8R1DCS2Xu1AeHEIn4Lik=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DKC2M9HiQIQO0u1s6utVi7+/Pqv0pIBiUsG3S875Ix7K0SD07o6mydTb54wlRFkYzCZyTyM7FDx0cPI9jCVudy6LGFsmAYs+BDVBE633y8bJjwTh3EHBm9M9JrruBDKu1+ScgRf9vGmpI4YFFH0iJMKqjTqBF64iGem+tQsjn9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gPrKGkoL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 800FCC4CEED;
	Mon, 21 Jul 2025 20:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753131583;
	bh=PCXzX9mRr03P4nIeOBJHP6i8R1DCS2Xu1AeHEIn4Lik=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=gPrKGkoLjrzV0Hxl9NUKSMbgI16pVII/ZZ/B4DsELC02ucKg8XXqMJaGBfe57GfJP
	 wRfF1DUI+sgnQRxePGpQTIXFStocXxNHL/BKmYVJloyBc9BZESGTEhCcVahbrwupPf
	 p5IYJbI+09t6WcT4dqJS85eYFUiIa0QjGNv/yFp2rIfIDmn4Y4nPbqShGP/cjZ5LL/
	 7keD2GBRn3KCBvdi3Ad/K9THHcICLxAjjF5Ge571sm2osd1Za6RMZxP4n5wWszyq5G
	 S/yGwelZCef9ROmrOPz6lXXMeD1jrzC6eaIGff/RFRDTB8YTefkfA7Fl2fKTm00sJW
	 QPN681c9YJchQ==
Date: Mon, 21 Jul 2025 13:59:39 -0700
From: Drew Fustini <fustini@kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Drew Fustini <dfustini@tenstorrent.com>,
	Andy Chiu <andybnac@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: Add sysctl to control discard of vstate during
 syscall
Message-ID: <aH6qO3c39gmybwEc@x1>
References: <20250719033912.1313955-1-fustini@kernel.org>
 <aH4u_OHqZHZtXjn3@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aH4u_OHqZHZtXjn3@localhost.localdomain>

On Mon, Jul 21, 2025 at 08:13:48AM -0400, Darius Rad wrote:
> On Fri, Jul 18, 2025 at 08:39:13PM -0700, Drew Fustini wrote:
> > From: Drew Fustini <dfustini@tenstorrent.com>
> > 
> > Clobbering the vector registers can significantly increase system call
> > latency for some implementations. To mitigate this performance impact, a
> > policy mechanism is provided to administrators, distro maintainers, and
> > developers to control vector state discard in the form of a sysctl knob:
> > 
> > /proc/sys/abi/riscv_v_vstate_discard
> > 
> > Valid values are:
> > 
> > 0: Do not discard vector state during syscall
> > 1: Discard vector state during syscall
> > 
> 
> Is the intention for this this mean "don't guarantee vector state is
> clobbered" or "preserve vector state"?  I suspect it is the former, but the
> wording seems unclear.  Additionally, if that's indeed the case, maybe the
> documentation should more clearly articulate the tradeoff (performance vs.
> security/robustness).

Thanks for your comment. I agree it could be worded better and the trade
off should be explained. I believe the motivation behind clobbering in
all syscalls was to make sure that userspace does not rely on the vector
being preserved through a syscall. The goal of this strictness was to
catch any programs that were misbehaving.

Thus, it might be better if I described it as:

0: Vector state is not strictly clobbered in all syscalls
1: Mandatory clobbering of vector state in all syscalls

Thanks,
Drew

