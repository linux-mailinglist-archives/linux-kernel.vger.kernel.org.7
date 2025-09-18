Return-Path: <linux-kernel+bounces-823312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4CEB86189
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 18:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AED6F16BA80
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 16:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA128246798;
	Thu, 18 Sep 2025 16:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vJbjFpDb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7521C4A2D;
	Thu, 18 Sep 2025 16:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758214128; cv=none; b=aRytjIjgFC6NNlZqwAOMVRWawoS28DPM3wxenBNlnc4k/dKNRFHdhYj+iOKW0pEgrukCIzAyo1vQjN1OredF+IppjpRvpVD0umBjxkPX58sWt8RYUpfHh3bjOE/svJD7NFMq2VCKVicUbumibVhpgqXDQhPA3L3F08oMMfFYwgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758214128; c=relaxed/simple;
	bh=lcnXAdz6eIiS2i4gNCDuvBwy6QESdH9dXmWvZ7PR3PY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dlHH6nrTHGKbwRXPVNNlY5k93eWsDJuXDBF6r8vF8GtrVnGk4kSRcoKBKJhngZCC0ytxR8VdYHdQWVFXzM8gePDU2Hb7HS7vKO4j6pGreIXT4IMHFeEhLlVLJB3cfft5JVmV9Ajz8y0SMCwtyGNaj6zqHXqAXGZ1xbpR9cUdvuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vJbjFpDb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDCD4C4CEF1;
	Thu, 18 Sep 2025 16:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758214127;
	bh=lcnXAdz6eIiS2i4gNCDuvBwy6QESdH9dXmWvZ7PR3PY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vJbjFpDbUGXmzxI/0WVwntr23iz5TXsd0ZLzSTe8ZzeO2OXU+LJT/eDbko3nnKBIn
	 4JxfRG1JYEaMBlOo/N7kfP8S2J4W1hK3JRgIBaE/xSARC+DIGIrrziu07F5IO0uKuI
	 rFeK8ELZSO7ukd1mALvEPQjzVQO2fyL1B+qilvsHwz65cPf2+I/He3fFG+iJhg+Cxu
	 Kgq2i2J20NbZ/rjmQDn1O1w6vvdLcGEyzJxkOmLITqqmPUprA20lRSUzCht9MRPu9m
	 qgmYUjS166LupcRcdeN1thxaY4T4pHcHyNWYV1GHbfMwk6qQq20S+UqAIOL35iKRTo
	 2XIWrBRslE7WA==
Date: Thu, 18 Sep 2025 12:48:39 -0400
From: Guo Ren <guoren@kernel.org>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Xu Lu <luxu.kernel@bytedance.com>, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, ajones@ventanamicro.com,
	brs@rivosinc.com, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	apw@canonical.com, joe@perches.com
Subject: Re: [PATCH v2 0/4] riscv: Add Zalasr ISA extension support
Message-ID: <aMw3504EwlnDOJI0@gmail.com>
References: <20250902042432.78960-1-luxu.kernel@bytedance.com>
 <aLciY2putG8g2P9F@andrea>
 <aMoyntAydNMtcl+3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMoyntAydNMtcl+3@gmail.com>

On Wed, Sep 17, 2025 at 12:01:34AM -0400, Guo Ren wrote:
> On Tue, Sep 02, 2025 at 06:59:15PM +0200, Andrea Parri wrote:
> > > Xu Lu (4):
> > >   riscv: add ISA extension parsing for Zalasr
> > >   dt-bindings: riscv: Add Zalasr ISA extension description
> > >   riscv: Instroduce Zalasr instructions
> > >   riscv: Use Zalasr for smp_load_acquire/smp_store_release
> > 
> > Informally put, our (Linux) memory consistency model specifies that any
> > sequence
> > 
> >   spin_unlock(s);
> >   spin_lock(t);
> > 
> > behaves "as it provides at least FENCE.TSO ordering between operations
> > which precede the UNLOCK+LOCK sequence and operations which follow the
> > sequence".  Unless I missing something, the patch set in question breaks
> > such ordering property (on RISC-V): for example, a "release" annotation,
> > .RL (as in spin_unlock() -> smp_store_release(), after patch #4) paired
> > with an "acquire" fence, FENCE R,RW (as could be found in spin_lock() ->
> > atomic_try_cmpxchg_acquire()) do not provide the specified property.
> > 
> > I _think some solutions to the issue above include:
> > 
> >  a) make sure an .RL annotation is always paired with an .AQ annotation
> >     and viceversa an .AQ annotation is paired with an .RL annotation
> >     (this approach matches the current arm64 approach/implementation);
> > 
> >  b) on the opposite direction, always pair FENCE R,RW (or occasionally
> >     FENCE R,R) with FENCE RW,W (this matches the current approach/the
> >     current implementation within riscv);
> > 
> >  c) mix the previous two solutions (resp., annotations and fences), but
> >     make sure to "upgrade" any releases to provide (insert) a FENCE.TSO.
> I prefer option c) at first, it has fewer modification and influence.
Another reason is that store-release-to-load-acquire would give out a
FENCE rw, rw according to RVWMO PPO 7th rule instead of FENCE.TSO, which
is stricter than the Linux requirement you've mentioned.

> 
> asm volatile(ALTERNATIVE("fence rw, w;\t\nsb %0, 0(%1)\t\n",	\
> -			  SB_RL(%0, %1) "\t\nnop\t\n",		\
> +			  SB_RL(%0, %1) "\t\n fence.tso;\t\n",	\
> 			  0, RISCV_ISA_EXT_ZALASR, 1)		\
> 			  : : "r" (v), "r" (p) : "memory");	\
> 
> I didn't object option a), and I think it could be done in the future.
> Acquire Zalasr extension step by step.
> 
> > 
> > (a) would align RISC-V and ARM64 (which is a good thing IMO), though it
> > is probably the most invasive approach among the three approaches above
> > (requiring certain changes to arch/riscv/include/asm/{cmpxchg,atomic}.h,
> > which are already relatively messy due to the various ZABHA plus ZACAS
> > switches).  Overall, I'm not too exited at the idea of reviewing any of
> > those changes, but if the community opts for it, I'll almost definitely
> > take a closer look with due calm.  ;-)
> > 
> >   Andrea
> > 
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
> > 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 

