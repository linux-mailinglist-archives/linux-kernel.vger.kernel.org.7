Return-Path: <linux-kernel+bounces-761009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE22B1F2F5
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 09:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36BE21894413
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 07:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C94923C39A;
	Sat,  9 Aug 2025 07:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TFGCq9lp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA128221294
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 07:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754726084; cv=none; b=ZNjHofR/Uiql7YydPPaszL8YkWaTu6z2Mit/74U92bIrtcguzTtTF5y1ELg2jZWokEd7xjqTR7yUlXdNNFIXAYLJdfK6DZLkvzoMPhaIlhKnbS4dc8zH8Sbrp4kBJMX0OD7uBeG+/IVTKQwTy00Wn1ZwylzFAGYaIFrOdHB2wgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754726084; c=relaxed/simple;
	bh=ValNLmZusOxhT9SC9cHGaPGBaNGfyZ45nyV1qAZuHoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hJhVoLN71GoglSTtAL9r2IC6No5AvVpn91PhIGBUJaEEBpZI233I3eR+2py5Gsfv5464A77kxJaCQ8HzYz9LRaVIzkvtxOOBWEwA7uBFRG6hW9dW3zT9qPEhC4Pq4o45Vx6ZOf+A+10xGUNRrff4S214cDMThCcAovQUZCk4Tcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TFGCq9lp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FF2AC4CEE7;
	Sat,  9 Aug 2025 07:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754726084;
	bh=ValNLmZusOxhT9SC9cHGaPGBaNGfyZ45nyV1qAZuHoQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TFGCq9lpPzmYcokrtnFb4SDfhoam7yqSDZpDnVrfjeOvLFiOFdd5iwRW0K51UVrY7
	 z5XMw1WrlAagABfuwjF/l7PlZ3ihgR5x4pH6GIyHHeIY5mkDy40D8sKbDD6EM/d7TK
	 OMbCPu9TA+Jh6kUvaIW/w5U45kuyCLYpt1tKTSeLOnXgz/WoZKd3OsBtNlFseGZNCp
	 5CW5U9NP9Nd1jbiWxEHhjC8JvgBbnpvj3+IZjNQXJ11CMMK/JvtvynKS8xm2Y/pRKo
	 j+F78OpKYhH1FKyhX/DI42w/b9063mX66kpzMXudu7nnLcLiAG1g1etatwP0hcSC+k
	 oPFBn2AgoNo1g==
Date: Sat, 9 Aug 2025 00:54:42 -0700
From: Drew Fustini <fustini@kernel.org>
To: Vivian Wang <wangruikang@iscas.ac.cn>, Darius Rad <darius@bluespec.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Samuel Holland <samuel.holland@sifive.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Andy Chiu <andybnac@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Drew Fustini <dfustini@tenstorrent.com>
Subject: Re: [PATCH v2] riscv: Add sysctl to control discard of vstate during
 syscall
Message-ID: <aJb+wifbIAsit+me@x1>
References: <20250806-riscv_v_vstate_discard-v2-1-6bfd61b2c23b@kernel.org>
 <aJXvWuPKIc2lCSX3@localhost.localdomain>
 <e4d21516-23b5-404b-a7da-cf6ebfd02dbc@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4d21516-23b5-404b-a7da-cf6ebfd02dbc@iscas.ac.cn>

On Sat, Aug 09, 2025 at 11:58:24AM +0800, Vivian Wang wrote:
> My previous comment on v1 on prefering clobbering with VS = Initial
> handling aside...

I found that in the discard vector state patch discussion 2 years ago
that Andy and Bjorn discussed how Initial could cause a problem [1]:

  It's not a racy, but you're correct that setting the state to Initial,
  will cause issues. When get/set_regs is called, the tracee will be
  stopped, and a schedule() has been done.

In the v3 series, Bjorn notes [2]:

  Set state to Dirty after discard, for proper ptrace() handling (Andy)

Also, I would like the ability to have the ability to switch off
__riscv_v_vstate_discard() and not loose any cycles to it, so I think
this sysctl is a good fit for that.

> 
> On 8/8/25 20:36, Darius Rad wrote:
> > On Wed, Aug 06, 2025 at 07:03:28AM -0700, Drew Fustini wrote:
> > [...]
> >> diff --git a/Documentation/arch/riscv/vector.rst b/Documentation/arch/riscv/vector.rst
> >> index 3987f5f76a9deb0824e53a72df4c3bf90ac2bee1..b702c00351617165a4d8897c7df68eadcd2d562e 100644
> >> --- a/Documentation/arch/riscv/vector.rst
> >> +++ b/Documentation/arch/riscv/vector.rst
> >> @@ -134,7 +134,25 @@ processes in form of sysctl knob:
> >>  3.  Vector Register State Across System Calls
> >>  ---------------------------------------------
> >>  
> >> -As indicated by version 1.0 of the V extension [1], vector registers are
> >> -clobbered by system calls.
> >> +Linux adopts the syscall ABI proposed by version 1.0 of the V extension [1],
> >> +where vector registers are clobbered by system calls. Specifically:
> >> +
> >> +    Executing a system call causes all caller-saved vector registers
> >> +    (v0-v31, vl, vtype) and vstart to become unspecied.
> >> +
> > Perhaps:
> >
> > Clobbering the vector registers may prevent leaking information to user
> 
> No... Not clobbering does not "leak" anything. If you find that it leaks
> information, please report - that's a bug.

Thanks Darius and Vivian for your comments. I think it is a good idea
for me to write about the possible advantages of mandatory clobbering on
syscall entry. However, I am also uncertain how clobbering on syscall
entry helps prevent leaking information.

> > space and aid in debugging, but can significantly increase system call
> > latency for some implementations.  [...]

I think that is a good idea for me to call out that this is can be
useful for debugging and testing.

> >
> >> +However, clobbering the vector registers can significantly increase system call
> >> +latency for some implementations. To mitigate this performance impact, a sysctl
> >> +knob is provided that controls whether vector state is always discarded in the
> >> +syscall path:
> >> +
> >> +* /proc/sys/abi/riscv_v_vstate_discard
> >> +
> >> +    Valid values are:
> >> +
> >> +    * 0: Vector state is not always clobbered in all syscalls
> >> +    * 1: Mandatory clobbering of vector state in all syscalls
> >> +
> >> +    Reading this file returns the current discard behavior. The initial state is
> >> +    controlled by CONFIG_RISCV_ISA_V_VSTATE_DISCARD.
> >>  
> >>  1: https://github.com/riscv/riscv-v-spec/blob/master/calling-convention.adoc
> >> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> >> index 36061f4732b7496a9c68a9a10f9959849dc2a95c..7bb8a8513135cbc105bd94d273012486a886f724 100644
> >> --- a/arch/riscv/Kconfig
> >> +++ b/arch/riscv/Kconfig
> >> @@ -656,6 +656,16 @@ config RISCV_ISA_V_DEFAULT_ENABLE
> >>  
> >>  	  If you don't know what to do here, say Y.
> >>  
> >> +config RISCV_ISA_V_VSTATE_DISCARD
> >> +	bool "Enable Vector state discard by default"
> >> +	depends on RISCV_ISA_V
> >> +	default n
> >> +	help
> > Perhaps add the following paragraph:
> >
> > Discarding vector state is more robust, but has negative performance
> > implications in certain implementations.
> 
> "Robust" is too vague... I don't think this word is helpful for anyone
> trying to understand what this does.

I agree that I should add more description to the Kconfig option as I
think what I wrote assumes too much prior knowledge of the code. Maybe
something like this:

  Discarding vector state on syscall entry can help identify userpace
  programs that are mistakenly relying on vector state being preserved
  across syscalls. This can be useful for debugging and test suites.
  However, this behavior can negatively impact performance on some
  RISC-V implementations.

  Say Y here if you want mandatory clobbering of vector state before
  entering all syscalls. If you select N, then userspace can still
  eanble it via the abi.riscv_v_vstate_discard sysctl knob.

  If you don't know what to do here, then select N.

Thanks,
Drew


[1] https://lore.kernel.org/linux-riscv/87r0pug6hb.fsf@all.your.base.are.belong.to.us/
[2] https://lore.kernel.org/linux-riscv/20230629062730.985184-1-bjorn@kernel.org/

