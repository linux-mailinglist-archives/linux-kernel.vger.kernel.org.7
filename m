Return-Path: <linux-kernel+bounces-806162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCAB6B492A9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 17:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E67F51889739
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB9E30BB80;
	Mon,  8 Sep 2025 15:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kW16PQqP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700BF12B73
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 15:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757344472; cv=none; b=SEZe0ru205hHSkZRKwhioatZEBggIgg6mHVAzrSfDOcCC2GX0iZ0XrkWOWx95Pv2M+OYxhjjWU0cinXG+lcmA9hcZUVMM3g2cjQndljkFKai8gx7VLSDk0ZwRG9sdYnPP9akB8gWwEGJYC2GXaFq0TglWhesdcylM8NHxGMKAws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757344472; c=relaxed/simple;
	bh=IzhdzQ/XwzF74jZ9kNMkQ6PFCLa7d0zl6A132VmFmLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bwERddnuHDCegSklX9/Y8RNSvnKn6hiWaTv/3e+WBoPNjJeVTN8bxW150fKxgBveXa6vUe7jl7VftN4D7FgLPc0EFACvMpBespbzqFDDiwumqvV9sup2SGenl3SCJ2f7VjutfY2FCtMA4Z/9Mopa/Eql2EX7UPSGSaslGHCLs2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kW16PQqP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A432EC4CEF1;
	Mon,  8 Sep 2025 15:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757344471;
	bh=IzhdzQ/XwzF74jZ9kNMkQ6PFCLa7d0zl6A132VmFmLA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kW16PQqPNLyeSsik9rz7Lz5XylRtF9Pasf6tMiW4lT/OoVb+cnP9hpWJUrr8k9gEd
	 Mk0ycQhVq4Srph58ehHMQzi3fj72zo7CBZQG0D5OV/Yi9972uIcSAzky1ObAc7MCn5
	 tj9bfr8r8EoMnzaAnKY4Rc4vNXequurLx+h5uqzrpSIpOnfddYY2y5Ty49RhMDmsl3
	 nPnjzh6fWpEHE1mZLAsjSZiQlMB0gj8PkzUduYRuip4A2F1bhwmDRDia1udpviRXqD
	 O5qjFHdN7VQwLZ0sC4V2p3L2cIhU5Vek9tRpnn4YZqzOURQgrBisvbtJVNc/dkQAVe
	 s5vLSgIvt+UDQ==
Date: Mon, 8 Sep 2025 16:14:27 +0100
From: Will Deacon <will@kernel.org>
To: Bill Tsui <b10902118@ntu.edu.tw>
Cc: oleg@redhat.com, linux@armlinux.org.uk, catalin.marinas@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] arm64: ptrace: fix hw_break_set() by setting addr
 and ctrl together
Message-ID: <aL7y00ggniiCTpZS@willie-the-truck>
References: <20250824124317.390795-1-b10902118@ntu.edu.tw>
 <20250827014113.5852-1-b10902118@ntu.edu.tw>
 <20250827014113.5852-2-b10902118@ntu.edu.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827014113.5852-2-b10902118@ntu.edu.tw>

On Wed, Aug 27, 2025 at 09:41:11AM +0800, Bill Tsui wrote:
> PTRACE_SETREGSET fails when setting a hardware breakpoint on a
> non-4-byte aligned address with a valid length to a 32-bit tracee. The
> length should be valid as long as the range started from the address
> is within one aligned 4 bytes.
> 
> The cause is that hw_break_set() modifies a breakpoint's addr
> first and then ctrl. This calls modify_user_hw_breakpoint() twice,
> although once registering both suffices. The first modification causes
> errors because new addr and old ctrl can be an invalid combination at
> hw_breakpoint_arch_parse(). For example, when a user sets a hardware
> breakpoint with addr=0x2 and ctrl.len=1, hw_breakpoint_arch_parse()
> will first see addr=0x2 and ctrl.len=4 (the default) and return
> -EINVAL. On the other hand, if a user sets the same value to
> a breakpoint whose ctrl.len has previously been set to 1 or 2,
> it succeeds.
> 
> The fix is to set addr and ctrl in one modify_user_hw_breakpoint(),
> effectively eliminating the discrepancy in validation.
> 
> Signed-off-by: Bill Tsui <b10902118@ntu.edu.tw>
> ---
>  arch/arm64/kernel/ptrace.c | 34 +++++++++++++++++++++++++++++-----
>  1 file changed, 29 insertions(+), 5 deletions(-)

Given that:

  (a) This is a pretty niche interface (primarily/exclusively (?) used
      by GDB)
  (b) It's been like this for a long time
  (c) Userspace can work around the problem

I'm not sure I see the benefit of trying to handle this differently
in the kernel.

If somebody _does_ have the time and energy for significant surgery
on this code, then the best thing to do would be to remove the
indirection through 'perf_events' altogether. I did make a start on
that once but it's a thankless job and I got preempted by other stuff.

Will

