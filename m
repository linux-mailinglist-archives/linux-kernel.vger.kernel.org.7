Return-Path: <linux-kernel+bounces-763559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E48F3B21699
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 22:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 680D33B56B2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 20:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6121D2E2DE3;
	Mon, 11 Aug 2025 20:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AAf/o18Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68AA2DBF5E
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 20:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754944605; cv=none; b=Ps5RbGODgDRI10JqryQ3qPgdr7tai0qlB8+Mu5P9joe2/j2j+CE7YwMKwjaB2geVyZaLti2KKr3ERCW83HnirTp92SIKZ9wPLzJv/7UZ0pe64YS9RAZ8d9p54q5FmxY16Ic7scOWf9fAk+XjQ83cbEFgSHp/MGcmeM/V578Vsjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754944605; c=relaxed/simple;
	bh=ANNBkkYI6TT0Omdxh17jItclatemB8sLwNiNbq4exXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aJWPteEKakEDo3nd1KILfeeXF4XQqNtOA018eBGqd60zJCswI4mXzd78GNpL+MuIe6Xz7XNTRit/HJ+VuFVg0t826iFyaWNkRt4J4jUnUyXrLL4IgrJ/o4o8jzO0fM2ea544fW9O8UihKP8YgUDHcaidJM/CrZAhC1iFel7U+Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AAf/o18Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14339C4CEED;
	Mon, 11 Aug 2025 20:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754944605;
	bh=ANNBkkYI6TT0Omdxh17jItclatemB8sLwNiNbq4exXE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AAf/o18YcMfvfiWpgenxbCd6N5M/0xSY91v0f/FH65nR50nuaFRoRWXq84uGEnbAw
	 Y8AXhP9OMJ7jcEd8EJZA7zH3+uafAemxVJV1D1Vhq05KR49Qi7bUWgbOwKmmNkS5NS
	 hVokol/W0r3PRECkzODjYRRYAUjzCRwDTF79ZjbVkDEoLsYCDxLjl1NgoWJwdgbCYQ
	 RQLXzOxh7GwZ793VflwAvOb5WA+2IY8/TBS64733SnWpwkUZFtMBLLz2ow34LuQPow
	 xiYB7SLn7JMcMMAgtCj9CC9g42BYqTroltfs5pKqX3Ra1dQmCWcCK4iUCItlWuNwWE
	 6x2W+BTN5VQ8g==
Date: Mon, 11 Aug 2025 13:36:42 -0700
From: Drew Fustini <fustini@kernel.org>
To: Florian Weimer <fweimer@redhat.com>
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
Message-ID: <aJpUWnYEL18dk4aC@x1>
References: <20250806-riscv_v_vstate_discard-v2-1-6bfd61b2c23b@kernel.org>
 <lhuo6so7ur5.fsf@oldenburg.str.redhat.com>
 <aJe8ZW5LEtBK7Jmj@x1>
 <lhuqzxjy5zq.fsf@oldenburg.str.redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lhuqzxjy5zq.fsf@oldenburg.str.redhat.com>

On Sun, Aug 10, 2025 at 09:45:45AM +0200, Florian Weimer wrote:
> * Drew Fustini:
> 
> > On Sat, Aug 09, 2025 at 10:40:46AM +0200, Florian Weimer wrote:
> >> * Drew Fustini:
> >> 
> >> > From: Drew Fustini <dfustini@tenstorrent.com>
> >> >
> >> > Clobbering the vector registers can significantly increase system call
> >> > latency for some implementations. To mitigate this performance impact, a
> >> > sysctl knob is provided that controls whether the vector state is
> >> > discarded in the syscall path:
> >> >
> >> > /proc/sys/abi/riscv_v_vstate_discard
> >> >
> >> > Valid values are:
> >> >
> >> > 0: Vector state is not always clobbered in all syscalls
> >> > 1: Mandatory clobbering of vector state in all syscalls
> >> >
> >> > The initial state is controlled by CONFIG_RISCV_ISA_V_VSTATE_DISCARD.
> >> 
> >> Can this be put into the system call number instead, or make it specific
> >> to some system calls in other ways?
> >
> > Do you mean the control the initial state of the sysctl, or not having a
> > sysctl for discard behavior at all?
> 
> It's seems rather strange to have a sysctl for such an ABI change
> because it really has to be a per-process property.

The reason for sysctl is that I want a means to let a system to opt out 
of clobbering vector state on the syscall entry path. This is because it
adds significant overhead for some implementations. For example, it
results in a 25% longer syscall duration on the X280 core.

I would be in favor of reverting the mandatory clobbering behavior, but
Palmer says that it is useful for test suites. Since revert isn't an
option, I want a system wide policy control like this sysctl. It does
seem like there could be some advantages to per-process control but I
think that delves into ABI changes which I feel is a separate issue from
a system wide knob for "always clobber"/"do not always clobber".

> 
> >> I think C libraries can use this optimization for their system calls
> >> (after adjusting the assembler clobbers) because the vector state is
> >> caller-saved in the standard calling convention.  But there is backwards
> >> compatibility impact for turning this on for the entire process.
> >
> > The focus I have right now is allowing users to avoid the delay in
> > syscall entry on implementations where clobbering is slow. Palmer had
> > mentioned in my v1 [1] that he has 'a patch out for GCC that enables a
> > system-wide vector ABI, but I don't have time to test/benchmark it so 
> > it's kind of hard to justify'. It seems like creating a new ABI where
> > the vector registers are preserved across syscalls could be useful, but
> > I think it would be best to handle that possiblity later on.
> 
> I'm confused.  Current glibc assumes that vector registers are preserved
> across system calls because the assembler clobbers do not mention them.
> Similar inline assembly probably has ended up in other projects, too.
> It works by accident if glibc is compiled for a non-vector target, or if
> it so happens that GCC never keeps vector registers alive across system
> calls.

I wasn't trying to make any ABI changes with this sysctl patch. The
riscv kernel documentation states vector state is not preserved across
syscalls. I am not trying to change that policy.

Around the same time that Palmer added that statement to the vector
documentation, Bjorn added the code that always clobbers the vector
registers on syscall entry. This was done in order to ensure programs
were not relying on vector state being preserved. 

At the time 2 years ago, Palmer and Bjorn talked about how this could
be revisted if it turns out the clobbering process ended up being slow
on real hardware. This patch is my attempt to allow platforms with slow
vstate clobbering to opt out this strict mandatory clobbering on syscall
entry.

Thanks,
Drew

