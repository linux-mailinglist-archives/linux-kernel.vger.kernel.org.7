Return-Path: <linux-kernel+bounces-819980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 884D3B7C9F8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEB202A4924
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 04:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D43F274B48;
	Wed, 17 Sep 2025 04:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EHEZplXR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28382367AC;
	Wed, 17 Sep 2025 04:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758085052; cv=none; b=pHYiBJtB0FqqCCkdhxbyH7v80Fapm7nDBDBUD5+StAbsWQhOjY5RKT2Y6iKtoycW6amd2lqFzPQKBdiFViC53liDYgDM7YL5bLiTld0yrCLRdHCRxHWveukwXfknGJOYaIPDFsLOB5V5Q3hBj4fRX8Aq4CRG7viz/LDNo/PzXxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758085052; c=relaxed/simple;
	bh=EHm3TBvGDlP6rBdT5MZHECo49MHawrb0YmSg4xy3b/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TdAMiRWLK/UEjeI6kcWxKaIpw8C9sLf08eCMuCE0LyTazIeU3LUWJz4Zvtl2fnkyh9fvkSOY3ScnVzE+gS7wzFkyC24TQuJ4qTWoNhKELeuNwJGDl+YLer9hIyzuuVgrKnCGY9vcDJ83jvRlp2uCAd+KBQDpTherKjnmsmY9exE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EHEZplXR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E9A3C4CEF0;
	Wed, 17 Sep 2025 04:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758085052;
	bh=EHm3TBvGDlP6rBdT5MZHECo49MHawrb0YmSg4xy3b/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EHEZplXROnPxQHvXs/QlMP8GK+3dz9+zPqkRp7SK9hP48rt0rHXZPxeh81BdXxPGK
	 9jf/iDFSeCIOThAmqOdGPzWPY5qMl6EJifYvQC5jCvkMtfjgPgazzSZWU3HRBfIT3i
	 Y3XlCYxs2pjMxFgLUTLF1kEeHVuF+yQLBymZ1MoYxdJfYZad7fC1wYfYK0uL/cFdcu
	 MCMZfihBLnudY5N6Er2JcG5x023ICaClz/prv2i0rrOxBvsN2g5nFW/glt1gWXa3d0
	 JZguoEXIGWJE5qUwcqQrbwS35cGlSaoyFdG9k2HpGU8tx3UZ1VL2E7s0WMHGjKIb5C
	 cyV5ahsyrUUQg==
Date: Wed, 17 Sep 2025 00:57:21 -0400
From: Guo Ren <guoren@kernel.org>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Xu Lu <luxu.kernel@bytedance.com>, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, ajones@ventanamicro.com,
	brs@rivosinc.com, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	apw@canonical.com, joe@perches.com
Subject: Re: [PATCH v2 0/4] riscv: Add Zalasr ISA extension support
Message-ID: <aMo/sQR80i7GbpAF@gmail.com>
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
> 
> asm volatile(ALTERNATIVE("fence rw, w;\t\nsb %0, 0(%1)\t\n",	\
> -			  SB_RL(%0, %1) "\t\nnop\t\n",		\
> +			  SB_RL(%0, %1) "\t\n fence.tso;\t\n",	\
			   "fence rw, rw;\t\nsb %0, 0(%1)\t\n",	\
How about enhance fence rw, rw? It's a bit more stronger than .tso.

 			  0, RISCV_ISA_EXT_ZALASR, 1)		\
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

