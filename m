Return-Path: <linux-kernel+bounces-761265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBAFCB1F6C9
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 23:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40BBD7A12EA
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 21:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625EC27BF95;
	Sat,  9 Aug 2025 21:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iKELzsPL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE341F8725
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 21:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754774631; cv=none; b=t5QXw5rt9L80rFbJkdWbgNbh91zCNHEX1wr+bg/G2KpKPY2JJIMJ/n0X2A2yFh68lglRwXetbSMGZOruVpAomZ1fWq6fHr9XkG7uuFDvsVrx5uS3EbS5/hcGXInsPS+n0j5sk0kB35/eLU0s2YNm8FMB0op0hHfHqH0iCM3rOkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754774631; c=relaxed/simple;
	bh=tEOcjJ/fH84hDn8E2XVzszjzCXCoN+CRVRYBfzYq+c4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cgMowOZ4PC2O1GyW1CuFyL04KuEdSFo96Llu66d0BtTAKa+FgcM3JhFkMEH/dx8z1upIBCsOUZQUAdu1hS2UgfpICrP1ToRVwCUoYu8plvhGjsmIVVUrpYQHDtIGLDWKNquWEGWYTtv9NwLd8E80p+jRz/D5mMpcmslbaTdLu9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iKELzsPL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F353C4CEE7;
	Sat,  9 Aug 2025 21:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754774631;
	bh=tEOcjJ/fH84hDn8E2XVzszjzCXCoN+CRVRYBfzYq+c4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iKELzsPLgidJNvgkVjFRsid0NOn08Y7c3T6DfPB+VV99iGz+UZqOdDK2wU7oOuNgp
	 pUBYeUJMgK1hjSTgPH4JHmNg8zWPoe+o5S1BUzezuatSQ7hI0fiO+8PlKj+kse75vG
	 sbW1WJHb9+is5PdVu/8W+t+WQexONnTka5YVz9gRA3njBDnYJfInyx1wyaG9ClAilF
	 D4EH1X3kStninZOY9CVpjuJO7bPZFe2kGyadNBTJt6Ua+S8OQZzkJA7xVLUYLDDo7o
	 xhs6M+fPTMX8DHCBW7L8S/0gEKt5TpBUHH2S+Shv1hQgePYJ606qt834IB5mQ7tntk
	 x9A75XIn5XWFA==
Date: Sat, 9 Aug 2025 14:23:49 -0700
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
Message-ID: <aJe8ZW5LEtBK7Jmj@x1>
References: <20250806-riscv_v_vstate_discard-v2-1-6bfd61b2c23b@kernel.org>
 <lhuo6so7ur5.fsf@oldenburg.str.redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lhuo6so7ur5.fsf@oldenburg.str.redhat.com>

On Sat, Aug 09, 2025 at 10:40:46AM +0200, Florian Weimer wrote:
> * Drew Fustini:
> 
> > From: Drew Fustini <dfustini@tenstorrent.com>
> >
> > Clobbering the vector registers can significantly increase system call
> > latency for some implementations. To mitigate this performance impact, a
> > sysctl knob is provided that controls whether the vector state is
> > discarded in the syscall path:
> >
> > /proc/sys/abi/riscv_v_vstate_discard
> >
> > Valid values are:
> >
> > 0: Vector state is not always clobbered in all syscalls
> > 1: Mandatory clobbering of vector state in all syscalls
> >
> > The initial state is controlled by CONFIG_RISCV_ISA_V_VSTATE_DISCARD.
> 
> Can this be put into the system call number instead, or make it specific
> to some system calls in other ways?

Do you mean the control the initial state of the sysctl, or not having a
sysctl for discard behavior at all?

> I think C libraries can use this optimization for their system calls
> (after adjusting the assembler clobbers) because the vector state is
> caller-saved in the standard calling convention.  But there is backwards
> compatibility impact for turning this on for the entire process.

The focus I have right now is allowing users to avoid the delay in
syscall entry on implementations where clobbering is slow. Palmer had
mentioned in my v1 [1] that he has 'a patch out for GCC that enables a
system-wide vector ABI, but I don't have time to test/benchmark it so 
it's kind of hard to justify'. It seems like creating a new ABI where
the vector registers are preserved across syscalls could be useful, but
I think it would be best to handle that possiblity later on.

Thanks,
Drew

[1] https://lore.kernel.org/linux-riscv/mhng-E49DDC7D-A330-4626-A122-4146AADDBB33@Palmers-Mini.rwc.dabbelt.com/

