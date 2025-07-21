Return-Path: <linux-kernel+bounces-739870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B25DB0CC51
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 23:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AA611AA243B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 21:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB88123C8CE;
	Mon, 21 Jul 2025 21:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NUv/rGm+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21517213E9F
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 21:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753132608; cv=none; b=VoS5QpVIyhSdqDxLHC3GaaDScpTFmA/R5ubL8Z56WDHPuPcdlhH25IeZuDPU07g7s3mOqsKsHUNDRizlahTD5GKIuWxcDFuK+CAs0DiNTUwKspwmqAPidIl8xuL043SBV42py/YbUK7Ka1S3GxGO3O5uetj0nr299vFPY49M93s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753132608; c=relaxed/simple;
	bh=Arrd2Tnr6hB2VAwXYdZrPeTOnej/n8BAOWb1ZZMsJ68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JK3/Iv/eXdv7wVBiHaQoAv7842e48Lp5KB2JRZf7rUXo9Mt/wgJx2fjpwp+PYil8oq0jOeNdTdogO+m4jT5gdYqIYiTTpfLlvi65Cjg++cV5uKMp2qvo+fUkKczhYIaCaVBFoIcIHRxEgCSi66nYiBANvHZ3ImdrJX4bFh8fAGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NUv/rGm+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CA8CC4CEED;
	Mon, 21 Jul 2025 21:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753132607;
	bh=Arrd2Tnr6hB2VAwXYdZrPeTOnej/n8BAOWb1ZZMsJ68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NUv/rGm+/M5vJqzvp9P+qrlsQqpx1UCVsPkqrduq4ZD2MKd+nPnwB7/BMnxye15Ko
	 hosP/QO3bLXB1b3wFSRvDNAO5zGYbhufFY6lI77OLrvyA+Et5SF94dVQoOP40VpJJP
	 wg5AI6RHzsh8McaSVQBkWKCRyun/ojkNU+xLeUskmeAKt+gFkq9q2wm275eYEW/Muw
	 M08LoPxDvWOfVi1Wm2I/uWk0JUFrtjP+SKQJrIxLGLuunlh8RiEi0LIulJwqEyhb4a
	 yBKEq/UKjYt5LG00zrzpeW+i+bfq3AAl12XQ9XIzJMbRRFI4DkDC2PfKJyAvQEjwcT
	 Jl7Kwk2WjJp2A==
Date: Mon, 21 Jul 2025 14:16:46 -0700
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
Message-ID: <aH6uPi+UOP6GzNjv@x1>
References: <20250719033912.1313955-1-fustini@kernel.org>
 <DBHQK4W9CL9F.1WM8JFVDQZ44F@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DBHQK4W9CL9F.1WM8JFVDQZ44F@ventanamicro.com>

On Mon, Jul 21, 2025 at 02:35:38PM +0200, Radim Krčmář wrote:
> 2025-07-18T20:39:13-07:00, Drew Fustini <fustini@kernel.org>:
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
> > The initial state is controlled by CONFIG_RISCV_ISA_V_VSTATE_DISCARD.
> 
> I think it is a bit more complicated to do this nicely...
> Programs don't have to save/restore vector registers around syscalls
> when compiled for riscv_v_vstate_discard=0, so running under
> riscv_v_vstate_discard=1 would break them.

Thanks for your comments. You raise a good point that this sysctl can
lead to the case where a program might be compiled to not save/restore
vector registers around syscalls. That same program would not work
correctly if the sysadmin changes riscv_v_vstate_discard to 1.

> Shouldn't we have a way to prevent riscv_v_vstate_discard=0 executable
> from running with riscv_v_vstate_discard=1?

Yes, this does make me concerned that a program could crash as a result
of this sysctl which would be confusing for the user as they may not
even be aware of this sysctl. I'll have to think more about how such a
protection could work.

> 
> > Fixes: 9657e9b7d253 ("riscv: Discard vector state on syscalls")
> 
> Programs compiled for riscv_v_vstate_discard=1 are compatible with 0, so
> I think it would be simplest to revert that patch, and pretended it
> never happened... (The issues will eventually go away.)

I agree that reverting the existing discard behavior would be the
simplest solution to the peformance issue observed on some
implementations. However, I believe there is also the desire to have a
way to enforce strict clobbering across syscalls to catch any incorrect
behavior while testing. I was hoping a syscall could allow both use
cases to be handled, but you raise good points about compatibility.

> Shouldn't the RISC-V Linux syscall ABI be defined somewhere?
> How come we could have broken it with 9657e9b7d253?

I may have been wrong to use a Fixes tag for 9657e9b7d253. I was trying
to highlight the original discussion that I was trying to address with
this sysctl patch.

> 
> Thanks.
> 
> ---
> I don't think it makes much sense to clobber vector registers on a
> syscall -- a kernel might not even touch vector registers, so they are
> efforlessly preserved in that case.
> If kernel needs to use vector registers in the syscall, then the kernel
> needs to prevent any register leaks to userspace anyway by restoring
> some state into them -- and why not restore the original one?
> 
> I think that main point of clobbering would be to optimize
> context-switches after the userspace is not using vector registers
> anymore, but it's terribly inefficient if the ratio of syscalls to
> context switches is high.
> Linux can also try to detect the situation, and turn to lazy vector
> context-switch, with sstatus.VS=off, instead of eagerly restoring
> clobbered state.
> (A good indicator might be that the userspace hasn't dirtied the vectors
>  since the last context-switch -- kernel didn't need to save the state,
>  so it will restore lazily.)

I think this is an interesting discussion to have. I was hoping this
patch would get people discussing if mandatory vector state cloberring
is really something that should be do in syscalls.

Thanks,
Drew

