Return-Path: <linux-kernel+bounces-799290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE808B4299D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 21:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A7203B5E3C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 19:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6282D8382;
	Wed,  3 Sep 2025 19:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3KayKP3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29862D374A;
	Wed,  3 Sep 2025 19:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756927052; cv=none; b=a76N/ycj+u2u7c3oYJU8O8jF19ikJvMZUjVrMTBbjDCRCUum4+uo4UePmW9HgNKYqZcUyPcO0e4vDa7uI3XQnDT3b+qXrC67yfGW2ZVRuopXLJWvBXvIYzhW4Y/tz7wOqyN3dl/PjTw5N+bR3ucHT/Ucd0Q7T0JDA2DrMpSIvtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756927052; c=relaxed/simple;
	bh=jcliH/w/a10uidu32SOmf201Z4fKoKFtR+/ALkAVbNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AqR2c3Uiht0mBgOCZ6fuBoEGxxDXHle8jCGrfsiNQC4/zjn6tDnUOpJL/v9HsjBWW3Ap7zJ024x9KnSRytg1MOvYBI9FsUPi5xgBnYtT01c06S8GGrGISLUSxwvkpZKcGgYG0G765sqOz0TUfevM7IKMm0eOouKxOgFN3nPnfvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3KayKP3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CE7FC4CEE7;
	Wed,  3 Sep 2025 19:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756927052;
	bh=jcliH/w/a10uidu32SOmf201Z4fKoKFtR+/ALkAVbNI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l3KayKP30VUp7HMTIBpFTDJv8yCdTfL63G+LkNamStVNqKqk7VoxJ78g91myKiup9
	 IkZFtT333agNfrHIME6AXI9FbVsN3ocZevToMV692qqZ3ECLKEVytskR4NoB8eSpvF
	 33mD/Rx9MtdKl9myd9ZwNn6geHeV7cDZPqJYG+3/NDM9l/wtZZQXFpyQ5ryejIyXqr
	 xJT4XAG0garx1ubNQoplWpozn2AHaHnOn/OMq09e9kVFskLVPAyvukO4vLZOKEjkrw
	 5aVqo+VLMvYpTBxfG/51hnu3QnamaII91wSQUn1gBCjeP8sxoNVMTfs11dituVLQaJ
	 6WV/I2kmqX8pg==
Date: Wed, 3 Sep 2025 12:17:29 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Peter Zijlstra <peterz@infradead.org>, 
	Huacai Chen <chenhuacai@kernel.org>, Nathan Chancellor <nathan@kernel.org>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] objtool/LoongArch: Fix fall through warning about
 efi_boot_kernel()
Message-ID: <qvatvh7rixtdtaflqtgphlva7kkr47drijklkvmae3xh54vn6y@y5v75lwgjdyu>
References: <20250901072156.31361-1-yangtiezhu@loongson.cn>
 <20250901072156.31361-2-yangtiezhu@loongson.cn>
 <20250901081616.GA4067720@noisy.programming.kicks-ass.net>
 <a59b3eaa-133d-88bf-f1f3-41328d023c4a@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a59b3eaa-133d-88bf-f1f3-41328d023c4a@loongson.cn>

On Mon, Sep 01, 2025 at 04:31:36PM +0800, Tiezhu Yang wrote:
> On 2025/9/1 下午4:16, Peter Zijlstra wrote:
> > On Mon, Sep 01, 2025 at 03:21:54PM +0800, Tiezhu Yang wrote:
> > > When compiling with LLVM and CONFIG_LTO_CLANG is set, there exists
> > > the following objtool warning:
> > > 
> > >    vmlinux.o: warning: objtool: __efistub_efi_boot_kernel()
> > >    falls through to next function __efistub_exit_boot_func()
> > > 
> > > This is because efi_boot_kernel() doesn't end with a return instruction
> > > or an unconditional jump, then objtool has determined that the function
> > > can fall through into the next function.
> > > 
> > > At the beginning, try to do something to make efi_boot_kernel() ends with
> > > an unconditional jump instruction, but it is not a proper way.
> > > 
> > > After more analysis, one simple way is to ignore these EFISTUB functions
> > > in validate_branch() of objtool since they are useless for stack unwinder.
> > > 
> > 
> > This is drivers/firmware/efi/libstub/loongarch.c:efi_boot_kernel(),
> > right?
> > 
> > Why not simply do something like:
> > 
> > diff --git a/drivers/firmware/efi/libstub/loongarch.c b/drivers/firmware/efi/libstub/loongarch.c
> > index 3782d0a187d1..082611a5f1f0 100644
> > --- a/drivers/firmware/efi/libstub/loongarch.c
> > +++ b/drivers/firmware/efi/libstub/loongarch.c
> > @@ -81,4 +81,5 @@ efi_status_t efi_boot_kernel(void *handle, efi_loaded_image_t *image,
> >   	real_kernel_entry(true, (unsigned long)cmdline_ptr,
> >   			  (unsigned long)efi_system_table);
> > +	BUG();
> >   }
> 
> At the beginning, I did the above change, but no effect.
> 
> The first thing is to remove the attribute __noreturn for
> real_kernel_entry(), otherwise the compiler can not generate
> instructions after that.
> 
> But there is an argument in the previous RFC [1]:
> 
> "From my point of view this is incorrect, this function is indeed a
> noreturn function, and this modification makes LoongArch different to
> other architectures."
> 
> Josh suggested to do something so that the EFI stub code isn't linked into
> vmlinux.o [2], it needs to modify the link process and seems too
> complicated and expensive for this warning to some extent.
> 
> So I did this change for objtool.

I don't like adding these workarounds to objtool.  Is it really that
complicated to link efistub separately?  That seems like the proper
design.  vmlinux.o should only have real kernel code.

-- 
Josh

