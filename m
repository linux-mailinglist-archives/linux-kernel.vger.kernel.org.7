Return-Path: <linux-kernel+bounces-747200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CFDB130EA
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 19:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85D9E1893E73
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 17:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2686E21CC49;
	Sun, 27 Jul 2025 17:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dtJPnzaR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8788C21A420
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 17:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753637358; cv=none; b=V1e+N2LQjoc6X98wnXFqW67zrILlD6URILA+lnPE+24dyVzWsjWSFewf1g/UDWSz7CayHUstA7BXA0MBEpSsIcIC2IkUEcWdZe5oTz+bfUALG6JmpzVApz2OLmx1RmPtA0FJhcGMboYEjHJfJDbOG6ZdI13AjVwFL3sVyrgjmls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753637358; c=relaxed/simple;
	bh=HTN6gl7pu5z8HFDM4isKWxC87ZsrT/bAEDgw4cKncOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rjdkdv96aUSmZO1iYQQVdW2FEerSLCuZ6Z8MbPXY/O33XSxn/V90Vcjbsqe5dcc34Fo5pdB5R6hFcLiqia6TUdrGkZdVTMpEsznbhANhWzCIK0KJ/Wq6wEK9ssVJqiT0M5PphlgR1GHVQ3C+QQ05IAvBETUiDSE8QfUFq1go5x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dtJPnzaR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02571C4CEEB;
	Sun, 27 Jul 2025 17:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753637358;
	bh=HTN6gl7pu5z8HFDM4isKWxC87ZsrT/bAEDgw4cKncOw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dtJPnzaRHbvYrc+gyxZK0TrUxbhegr7FGGnZSqYgDtIjln7QeN7TiBPWFBJvDLpid
	 +monMCu6pmVhQK3lwpcSArNn6KpOFUGz2HqwUUkHZYWZ8H8C3AIsZ2SMwtue9KNSp/
	 +L6yiTBElJH9s+NytqeP1Xw4CTGSEclh4mXZ7vjegqw++ZO9ySi0lgQ+Z2p/fAJkku
	 NqHhM/ijyeccxFKg91dYYtWzyZ3dcA11FUL7zoLj6lBsC8ad2tAEcVNmq7yQXKCLID
	 FELKPBBgpsvWo8UJJM38HJFi5kk0SfYrF9s4e9tNRTo8sRrL49Qr2R5iFt6vxTVTOI
	 Vra/TrkcVyt6A==
Date: Sun, 27 Jul 2025 10:29:16 -0700
From: Drew Fustini <fustini@kernel.org>
To: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Drew Fustini <dfustini@tenstorrent.com>,
	Andy Chiu <andybnac@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-riscv <linux-riscv-bounces@lists.infradead.org>
Subject: Re: [PATCH] riscv: Add sysctl to control discard of vstate during
 syscall
Message-ID: <aIZh7F+jY8CxpuCz@x1>
References: <20250719033912.1313955-1-fustini@kernel.org>
 <DBHQK4W9CL9F.1WM8JFVDQZ44F@ventanamicro.com>
 <aH6uPi+UOP6GzNjv@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aH6uPi+UOP6GzNjv@x1>

On Mon, Jul 21, 2025 at 02:16:46PM -0700, Drew Fustini wrote:
> On Mon, Jul 21, 2025 at 02:35:38PM +0200, Radim Krčmář wrote:
> > 2025-07-18T20:39:13-07:00, Drew Fustini <fustini@kernel.org>:
> > > From: Drew Fustini <dfustini@tenstorrent.com>
> > >
> > > Clobbering the vector registers can significantly increase system call
> > > latency for some implementations. To mitigate this performance impact, a
> > > policy mechanism is provided to administrators, distro maintainers, and
> > > developers to control vector state discard in the form of a sysctl knob:
> > >
> > > /proc/sys/abi/riscv_v_vstate_discard
> > >
> > > Valid values are:
> > >
> > > 0: Do not discard vector state during syscall
> > > 1: Discard vector state during syscall
> > >
> > > The initial state is controlled by CONFIG_RISCV_ISA_V_VSTATE_DISCARD.
> > 
> > I think it is a bit more complicated to do this nicely...
> > Programs don't have to save/restore vector registers around syscalls
> > when compiled for riscv_v_vstate_discard=0, so running under
> > riscv_v_vstate_discard=1 would break them.
> 
> Thanks for your comments. You raise a good point that this sysctl can
> lead to the case where a program might be compiled to not save/restore
> vector registers around syscalls. That same program would not work
> correctly if the sysadmin changes riscv_v_vstate_discard to 1.
> 
> > Shouldn't we have a way to prevent riscv_v_vstate_discard=0 executable
> > from running with riscv_v_vstate_discard=1?
> 
> Yes, this does make me concerned that a program could crash as a result
> of this sysctl which would be confusing for the user as they may not
> even be aware of this sysctl. I'll have to think more about how such a
> protection could work.

After further consideration, I think that it would be appropriate for
programs that don't save/restore vector registers around syscalls to
break when riscv_v_vstate_discard=1. I believe the primary motivation
of the original change 2 years ago was to catch programs that rely on
the vector state being retained across syscalls. Thus, I think that this
behavior would be consistent with that.

Bjorn told me he is away at the moment but hopefully he can provide his
perspective when he is back.

Thanks,
Drew

