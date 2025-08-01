Return-Path: <linux-kernel+bounces-753848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFF7B188E2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 23:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED6D57B5F57
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 21:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A32B28DF12;
	Fri,  1 Aug 2025 21:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NDxdDNhj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C547819F121
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 21:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754084513; cv=none; b=trN2i8KEDYdcZOMzLIji/VdUk8pf2gyN8c19TGtgfRGBG8MU9O8WOKh01jXfR1EudRcfkQWPRqkykYG/OckKvnT02dMZ8RdXVgMNQqhcnRnM44BDdP/tjGl1siW9Hj5pOEuscUQdeSzwIU2qmSH2HV4OB4OnMYv1Oq+CwN/mwVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754084513; c=relaxed/simple;
	bh=i625gcnny+wSz3HQOlwjTnzLTAmeo9OEca0WJzZ3RE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sikbx7bJdNa5DPgnRX7miuqs7Oui2KqHG3zjbFM4mmtokQ1gtzkwo8tCizrWdiClj8jIFAC3r5i8ljheLHaf9h8hd7KcjWXzrjhBfjER7Av4EGB/SX7Encpp/uJOmWdgxP0QciyTE+YdfS8Z9gWPalqJAxmNcLYsvGsseoFHWBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NDxdDNhj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30201C4CEE7;
	Fri,  1 Aug 2025 21:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754084513;
	bh=i625gcnny+wSz3HQOlwjTnzLTAmeo9OEca0WJzZ3RE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NDxdDNhjmTyerZebxCxtEP3yEL5CswFVc7TqX3DCv0J1EugdAqUxff1lQ9CLWBVLm
	 Spv5eniCRCnkjqZ4pPq8ERtfBnlNctbuqucOYNZzhtp5BMCE9+5NKMwR17wfLyLhpK
	 l0vVybyjEwweTDjzyDT5S3TJFAKKROBibRT3avqYrCWpE8NHaIUfL/uU9f/VjYoyL/
	 bq8gZNgZzF47H+1W4GYIMW5+ohw760kJ5R8zZmryzFU2QZKaVYEGG30H+f6ZbRhlfG
	 s9iFcrr+YZlkkfAjLE8b62Tc2z1jlCLk8ftvzFw3zktVtC2hG+Yb00X5cjnCmkv3tM
	 kOSmsPB3+gIQA==
Date: Fri, 1 Aug 2025 14:41:51 -0700
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
Message-ID: <aI00nzzma4gXrmh/@x1>
References: <DBHTIDY0HRM0.2B8L1WG7IBCXM@ventanamicro.com>
 <mhng-E49DDC7D-A330-4626-A122-4146AADDBB33@Palmers-Mini.rwc.dabbelt.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-E49DDC7D-A330-4626-A122-4146AADDBB33@Palmers-Mini.rwc.dabbelt.com>

On Wed, Jul 30, 2025 at 06:05:59PM -0700, Palmer Dabbelt wrote:
> My first guess here would be that trashing the V register state is still
> faster on the machines that triggered this patch, it's just that the way
> we're trashing it is slow.  We're doing some wacky things in there (VILL,
> LMUL, clearing to -1), so it's not surprising that some implementations are
> slow on these routines.
> 
> This came up during the original patch and we decided to just go with this
> way (which is recommended by the ISA) until someone could demonstrate it's
> slow, so sounds like it's time to go revisit those.
> 
> So I'd start with something like
> 
>    diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm/vector.h
>    index b61786d43c20..1fba33e62d2b 100644
>    --- a/arch/riscv/include/asm/vector.h
>    +++ b/arch/riscv/include/asm/vector.h
>    @@ -287,7 +287,6 @@ static inline void __riscv_v_vstate_discard(void)
>                    "vmv.v.i        v8, -1\n\t"
>                    "vmv.v.i        v16, -1\n\t"
>                    "vmv.v.i        v24, -1\n\t"
>    -               "vsetvl         %0, x0, %1\n\t"
>                    ".option pop\n\t"
>                    : "=&r" (vl) : "r" (vtype_inval));
> 
> to try and see if we're tripping over bad implementation behavior, in which
> case we can just hide this all in the kernel.  Then we can split out these
> performance issues from other things like lazy save/restore and a
> V-preserving uABI, as it stands this is all sort of getting mixed up.

Thank you for your insights and the suggestion of removing vsetvl.

Using our v6.16-rc1 branch [1], the avg duration of getppid() is 198 ns
with the existing upstream behavior in __riscv_v_vstate_discard():

debian@tt-blackhole:~$ ./null_syscall --vsetvli
vsetvli complete
 iterations: 1000000000
   duration: 198 seconds
avg latency: 198.10 ns

I removed 'vsetvl' as you suggested but the average duration only
decreased a very small amount to 197.5 ns, so it seems that the other
instructions are what is taking a lot of time on the X280 cores:

debian@tt-blackhole:~$ ./null_syscall --vsetvli
vsetvli complete
 iterations: 1000000000
   duration: 197 seconds
avg latency: 197.53 ns

This is compared to a duration of 150 ns when using this patch with
abi.riscv_v_vstate_discard=0 which skips all the clobbering assembly.

Do you have any other suggestions for the __riscv_v_vstate_discard()
inline assembly that might be worth me testing on the X280 cores?

Thanks,
Drew

[1] https://github.com/tenstorrent/linux/tree/tt-blackhole-v6.16-rc1

