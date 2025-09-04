Return-Path: <linux-kernel+bounces-801372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B590CB44448
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 19:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 516D21CC1820
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663593090FE;
	Thu,  4 Sep 2025 17:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uBkQLuSb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE223EEAB;
	Thu,  4 Sep 2025 17:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757006809; cv=none; b=iE7wbDzu3xDlYMJcnIebMqAlDryI2pcY7UK2RVGv9k9lJfAuITWFPRfB9oL2OTh08BUcpZLgdALE2ZDbAW5R10n+HjeAZyL1H5N02CHMMVmstq/Sf/LFTTwJ+XeaY0e9QzYLU+kEhERZBkhGreAu3BGp3qSSSrIpIamvKy9oOsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757006809; c=relaxed/simple;
	bh=Mffg9KVeBcQXps8s2vHAGfu9z8Il5tXK3/sTqDNFHe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADtfLnvKA1TWCyVHq3Upo9/dNYKb7UzADJlOlvZkmh1ngc1pt4G/84wNmX6hewemRHYZquBPWav8Nkj5UDFQUAxoA1AoTfKQ5JbPg7KEk5gZIyRjFAKay3fNiHYOB9jkV0VDWYUiyrMCxj8ruMIgURUONqhvfYomB4nvt8GDoGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uBkQLuSb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A74F1C4CEF0;
	Thu,  4 Sep 2025 17:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757006809;
	bh=Mffg9KVeBcQXps8s2vHAGfu9z8Il5tXK3/sTqDNFHe4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uBkQLuSbuacufk5N6YlbC1tcFwo9Onv09elp7pARH6HnoErGxQsvYigSMmNrNDxoG
	 dvnd/y5yWDsPHw0iUdWIDY07hYia1CZBlElmTn42Tx/EB1EFXEXsodhXffstIB/Io6
	 4Mos5ZRWIC7G9y5weqbsEvk9AfPdW2uTC5YPoIYNDgoLLUsIvrnT2Py5wZl6VLsUHj
	 U4m0GRu45gjqtF2EnUUh6060/3KDHPpkk66/kcPt7JV2K37/ucdMRwLinU7lgj6ybH
	 +qlDhGI6hhYA6BnyFxb/RDJjbbfIjjSmGghPPVe0DtMGN+zzgCEksUCFUqo8oQCJeE
	 +zjGIHylLxdEQ==
Date: Thu, 4 Sep 2025 10:26:46 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Peter Zijlstra <peterz@infradead.org>, Nathan Chancellor <nathan@kernel.org>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] objtool/LoongArch: Fix fall through warning about
 efi_boot_kernel()
Message-ID: <mqyjt5cabahlvezowt6plurkyrrbputvg776rhgaxhpwsqnuq3@onr5svx5heuf>
References: <20250901072156.31361-1-yangtiezhu@loongson.cn>
 <20250901072156.31361-2-yangtiezhu@loongson.cn>
 <20250901081616.GA4067720@noisy.programming.kicks-ass.net>
 <a59b3eaa-133d-88bf-f1f3-41328d023c4a@loongson.cn>
 <qvatvh7rixtdtaflqtgphlva7kkr47drijklkvmae3xh54vn6y@y5v75lwgjdyu>
 <CAAhV-H5u4xHcuLhyPe+a_YqPoCX2uVoqcW94i=HvU1NooL_efg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H5u4xHcuLhyPe+a_YqPoCX2uVoqcW94i=HvU1NooL_efg@mail.gmail.com>

On Thu, Sep 04, 2025 at 10:17:11AM +0800, Huacai Chen wrote:
> Hi, Josh,
> 
> On Thu, Sep 4, 2025 at 3:17 AM Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> >
> > On Mon, Sep 01, 2025 at 04:31:36PM +0800, Tiezhu Yang wrote:
> > > On 2025/9/1 下午4:16, Peter Zijlstra wrote:
> > > > On Mon, Sep 01, 2025 at 03:21:54PM +0800, Tiezhu Yang wrote:
> > > > > When compiling with LLVM and CONFIG_LTO_CLANG is set, there exists
> > > > > the following objtool warning:
> > > > >
> > > > >    vmlinux.o: warning: objtool: __efistub_efi_boot_kernel()
> > > > >    falls through to next function __efistub_exit_boot_func()
> > > > >
> > > > > This is because efi_boot_kernel() doesn't end with a return instruction
> > > > > or an unconditional jump, then objtool has determined that the function
> > > > > can fall through into the next function.
> > > > >
> > > > > At the beginning, try to do something to make efi_boot_kernel() ends with
> > > > > an unconditional jump instruction, but it is not a proper way.
> > > > >
> > > > > After more analysis, one simple way is to ignore these EFISTUB functions
> > > > > in validate_branch() of objtool since they are useless for stack unwinder.
> > > > >
> > > >
> > > > This is drivers/firmware/efi/libstub/loongarch.c:efi_boot_kernel(),
> > > > right?
> > > >
> > > > Why not simply do something like:
> > > >
> > > > diff --git a/drivers/firmware/efi/libstub/loongarch.c b/drivers/firmware/efi/libstub/loongarch.c
> > > > index 3782d0a187d1..082611a5f1f0 100644
> > > > --- a/drivers/firmware/efi/libstub/loongarch.c
> > > > +++ b/drivers/firmware/efi/libstub/loongarch.c
> > > > @@ -81,4 +81,5 @@ efi_status_t efi_boot_kernel(void *handle, efi_loaded_image_t *image,
> > > >     real_kernel_entry(true, (unsigned long)cmdline_ptr,
> > > >                       (unsigned long)efi_system_table);
> > > > +   BUG();
> > > >   }
> > >
> > > At the beginning, I did the above change, but no effect.
> > >
> > > The first thing is to remove the attribute __noreturn for
> > > real_kernel_entry(), otherwise the compiler can not generate
> > > instructions after that.
> > >
> > > But there is an argument in the previous RFC [1]:
> > >
> > > "From my point of view this is incorrect, this function is indeed a
> > > noreturn function, and this modification makes LoongArch different to
> > > other architectures."
> > >
> > > Josh suggested to do something so that the EFI stub code isn't linked into
> > > vmlinux.o [2], it needs to modify the link process and seems too
> > > complicated and expensive for this warning to some extent.
> > >
> > > So I did this change for objtool.
> >
> > I don't like adding these workarounds to objtool.  Is it really that
> > complicated to link efistub separately?  That seems like the proper
> > design.  vmlinux.o should only have real kernel code.
> I don't think this is just a "workaround", ARM64, RISC-V and LoongArch
> share the same logic in efistub which may be different from X86. When
> ARM64 and RISC-V add objtool support, they will also need to ignore
> the __efistub_ functions.
> 
> The other patch is similar.

Objtool expects/enforces certain rules.  One of them is that vmlinux.o
is proper runtime kernel code.  efistub is not that.

Is there some technical reason why vmlinux.o needs efistub linked in?

-- 
Josh

