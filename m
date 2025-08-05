Return-Path: <linux-kernel+bounces-756859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC4AB1BA78
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 20:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C394B3AF2B0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 18:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E27629994C;
	Tue,  5 Aug 2025 18:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6jXfk9g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07B51E51EF
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 18:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754419881; cv=none; b=Fgc7Hz/AChMXjrDtTgMtmdmFK0qlKrsm4eOR2zND4ZWVVburEMyMXUE18V0nkT846IT5hFQTinqPH6xaSCzEOKltUkzeK9PeQ5WItVVvk+eYbZ7ibn23OsoraM0pJo2Rt+92EU2JWSrmkI1YCGjmBM9kmCSw1dilrTQYa0s2qcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754419881; c=relaxed/simple;
	bh=YGDoEPsUQuYfYTJDut+2PTWcm8Eh1MfbLsHsxoJoXvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GQxCR2/2Hk5bY4jf+JGebUDkCv5kDnp8OAueq+cfbnKSNIHmRHweXhh2/5UexKOIBS7tjiXSVKDg4YvPEuZqOyGH/mybSxKgajnTGsBhN9VOhqxolULksMlQGQ938KrVSpq1T5gYLJAlTrnWc0Vyo7SP0KqtUQn+wYdkOGmQMSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6jXfk9g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 658C0C4CEF0;
	Tue,  5 Aug 2025 18:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754419880;
	bh=YGDoEPsUQuYfYTJDut+2PTWcm8Eh1MfbLsHsxoJoXvQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U6jXfk9gohIp3margX7YaCB5yYVY7+j1OM/qAAYsvgsV4u5pnMHDYOFGQs3pHZWld
	 GA+sAbgna+bxDsYuZFFj3HkBdXHg+tig8MnRZeAOxhshtVIIM9FDpT0Gic1S/DT9DM
	 EeQwFKnBQUBOaww70XWxdAyE7b6DDXKmkWdPFpkcnf567wqrWVvOV37v0U+V8NgfKO
	 b/y/zGvIsrAJlNOqe009GjMkeeEE02Jy6bZS5DYKwQJj8YKZHkpRGRBycJixweBL0g
	 n9uAOed9uHxAsciMpeF9+hEMmnSfpZ5LxqErPtYm9ypxcJu2w0yW37CCDBeHRZshEs
	 TmH0dYuYKmZbA==
Date: Tue, 5 Aug 2025 11:51:18 -0700
From: Drew Fustini <fustini@kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: rkrcmar@ventanamicro.com, Bjorn Topel <bjorn@rivosinc.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Paul Walmsley <paul.walmsley@sifive.com>, samuel.holland@sifive.com,
	dfustini@tenstorrent.com, andybnac@gmail.com,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-riscv-bounces@lists.infradead.org
Subject: Re: [PATCH] riscv: Add sysctl to control discard of vstate during
 syscall
Message-ID: <aJJSpia1clSebQpy@x1>
References: <DBHTIDY0HRM0.2B8L1WG7IBCXM@ventanamicro.com>
 <mhng-E49DDC7D-A330-4626-A122-4146AADDBB33@Palmers-Mini.rwc.dabbelt.com>
 <aI00nzzma4gXrmh/@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aI00nzzma4gXrmh/@x1>

On Fri, Aug 01, 2025 at 02:41:51PM -0700, Drew Fustini wrote:
> On Wed, Jul 30, 2025 at 06:05:59PM -0700, Palmer Dabbelt wrote:
> > My first guess here would be that trashing the V register state is still
> > faster on the machines that triggered this patch, it's just that the way
> > we're trashing it is slow.  We're doing some wacky things in there (VILL,
> > LMUL, clearing to -1), so it's not surprising that some implementations are
> > slow on these routines.
> > 
> > This came up during the original patch and we decided to just go with this
> > way (which is recommended by the ISA) until someone could demonstrate it's
> > slow, so sounds like it's time to go revisit those.
> > 
> > So I'd start with something like
> > 
> >    diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm/vector.h
> >    index b61786d43c20..1fba33e62d2b 100644
> >    --- a/arch/riscv/include/asm/vector.h
> >    +++ b/arch/riscv/include/asm/vector.h
> >    @@ -287,7 +287,6 @@ static inline void __riscv_v_vstate_discard(void)
> >                    "vmv.v.i        v8, -1\n\t"
> >                    "vmv.v.i        v16, -1\n\t"
> >                    "vmv.v.i        v24, -1\n\t"
> >    -               "vsetvl         %0, x0, %1\n\t"
> >                    ".option pop\n\t"
> >                    : "=&r" (vl) : "r" (vtype_inval));
> > 
> > to try and see if we're tripping over bad implementation behavior, in which
> > case we can just hide this all in the kernel.  Then we can split out these
> > performance issues from other things like lazy save/restore and a
> > V-preserving uABI, as it stands this is all sort of getting mixed up.
> 
> Thank you for your insights and the suggestion of removing vsetvl.
> 
> Using our v6.16-rc1 branch [1], the avg duration of getppid() is 198 ns
> with the existing upstream behavior in __riscv_v_vstate_discard():
> 
> debian@tt-blackhole:~$ ./null_syscall --vsetvli
> vsetvli complete
>  iterations: 1000000000
>    duration: 198 seconds
> avg latency: 198.10 ns
> 
> I removed 'vsetvl' as you suggested but the average duration only
> decreased a very small amount to 197.5 ns, so it seems that the other
> instructions are what is taking a lot of time on the X280 cores:
> 
> debian@tt-blackhole:~$ ./null_syscall --vsetvli
> vsetvli complete
>  iterations: 1000000000
>    duration: 197 seconds
> avg latency: 197.53 ns
> 
> This is compared to a duration of 150 ns when using this patch with
> abi.riscv_v_vstate_discard=0 which skips all the clobbering assembly.
> 
> Do you have any other suggestions for the __riscv_v_vstate_discard()
> inline assembly that might be worth me testing on the X280 cores?

I have tried leaving vsetvl but removing vmv.v.i instructions instead.
This made a difference on the X280 and reduced duration from 198 ns to
161 ns. This compared to an average duration of 148 ns when doing no
clobbering at all.

However, removing the vmv.v.i from the discard assembly doesn't help
much on our own out-of-order core due to still having to update the
vector state in status. Thus I'm still keen to have some way to entirely
opt out of __riscv_v_vstate_discard() on the do_trap_ecall_u() path.

Thanks,
Drew

