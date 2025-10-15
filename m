Return-Path: <linux-kernel+bounces-853529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC77BDBE7A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 02:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6789518A4569
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 00:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3EA1B040B;
	Wed, 15 Oct 2025 00:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uoEDLvVM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B282C17DFE7;
	Wed, 15 Oct 2025 00:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760487718; cv=none; b=tsrKmj/o0CuiTgnR/p+dyJqqLez+lg2nnLX5kyyeLLAdem+W5frfhXSjuS4tkyxMeinJVLK37xnShO/u3xxdbpZRLQruQIPx1XTyLW0Jf7GoyK/i88Us81IzDLYhJ8uRucjjex6FqhqlFs+pFUVL/8dKALQq/qP2uliG9lYOTbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760487718; c=relaxed/simple;
	bh=oLFIibXnPFOJz0MzV3NAkJL/mBUsPSV9HGDX9rhCWkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ub9+91PACcPO5M9I1YOx5uFk0Wu13S6ERqe9OOKaiNX2UquGPuRA7fbsNu/kV019PhXzj1SJTqViESpeK5oGqUwhdLe/G7iCbdEd1YwpQJIPqYuN0xRCwayB/ebc9xyMAPMHpJDVrBda4irGogbkJn4a5uaH381nEf/YKx4XUEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uoEDLvVM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A30DC4CEE7;
	Wed, 15 Oct 2025 00:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760487718;
	bh=oLFIibXnPFOJz0MzV3NAkJL/mBUsPSV9HGDX9rhCWkM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uoEDLvVMBYvbxbaqRExO4mBuOXW8xK+xBsM3YpN8BU1lvBX4p3ZAdfzt2L3+iF0GN
	 WG1/B5BcjO6G5oQtvfsi/xChcW18K/a54r1fdPVQsmPwbbPFnAXEa4+7w5bzq4flhf
	 6VHS/tdoIl0wngQjxhoS3nTFA8kCFfDp3DcveH/+FyeZcZo2KjS0k+8Ypk97Xtmuun
	 8K2iC6fX/3DXfiRfPJuvJbT3N1ZJXjBgUU19rx60Zsxgh/AO9zi2sWjzPrju9lComF
	 gSaIX68xorVOyC+xLeGk3YYnNWC6eRkJurprqsPEMD5vPVxi8cCVp0VHEmEfLgQjp+
	 O1BtSRYMnbkCg==
Date: Tue, 14 Oct 2025 17:21:54 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Vishal Chourasia <vishalc@linux.ibm.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, maddy@linux.ibm.com,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	clang-built-linux@googlegroups.com,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: Re: [PATCH] arch/powerpc: Remove .interp section in vmlinux
Message-ID: <20251015002154.GA2300901@ax162>
References: <eeaf8fd6628a75d19872ab31cf7e7179e2baef5e.1751366959.git.christophe.leroy@csgroup.eu>
 <20251013040148.560439-1-vishalc@linux.ibm.com>
 <2b4a3215-1620-40c9-a00c-ca833ebbb7b6@csgroup.eu>
 <aOypxKMzsLR5tAtv@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aOypxKMzsLR5tAtv@linux.ibm.com>

Hi Vishal,

On Mon, Oct 13, 2025 at 12:57:00PM +0530, Vishal Chourasia wrote:
> On Mon, Oct 13, 2025 at 08:46:48AM +0200, Christophe Leroy wrote:
> > +CLANG ppl
> > 
> > Hi,
> > 
> > Le 13/10/2025 à 06:01, Vishal Chourasia a écrit :
> > > While debugging a ppc64le QEMU guest on an x86_64 host, I observed GDB crashes
> > > when attempting to attach to the remote target:
> > > 
> > > (gdb) target remote :1234
> > > 
> > > Investigation revealed that cross-compiling the Linux kernel for ppc64le on an
> > > x86_64 host using Clang produces a vmlinux binary containing an empty .interp
> > > section. This empty .interp section is responsible for the GDB crashes.
> > 
> > Which version of CLANG is it ?
> (i) ❯ clang --version
> clang version 21.0.0git (https://github.com/llvm/llvm-project.git a80bccc6847be104948f46d313f03ac6b9ccb292)
> 
> > 
> > > 
> > > This issue does not occur when:
> > > - Building for ppc64le target using GCC on x86_64 host
> > > - Building for ppc64le target using Clang on ppc64le host
> > 
> > Is it the same CLANG version ?
> # clang --version
> clang version 22.0.0git (https://github.com/llvm/llvm-project.git 2f755c543ab357bd83235592fcee37fa391cdd9d)
> 
> > 
> > > - Building for ppc64le target using GCC on ppc64le host
> > > 
> > > For details refer [1]
> > > 
> > > [1] https://sourceware.org/bugzilla/show_bug.cgi?id=33481

In this bug report, you mention using LLVM=1. Does the issue happen if
you use GNU ld (ld.bfd) via LD (i.e., LD=powerpc64le-linux-gnu-ld or
equivalent) over ld.lld from LLVM=1? This sounds more likely to be a
linker difference rather than a compiler difference.

Cheers,
Nathan

