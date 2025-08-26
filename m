Return-Path: <linux-kernel+bounces-787390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0064CB3759D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 01:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C64A917F736
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 23:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54093090F7;
	Tue, 26 Aug 2025 23:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EzzmgLoy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B35127F171;
	Tue, 26 Aug 2025 23:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756251577; cv=none; b=cTH0Qfrfk4eL26kiZFO7Lr+hagfzk6UDXoAAqbOmR4G4Qj3+8xAm6xAnMAECmxN8HI77qbitaBekNsL04OrLhwnXdC9Ru7szXZjM6k8fMPCQPBbu3EDdGT1fsP9svmu96NxAtWiGSp4S4DpYGgGZRm8ssny+NB7g/mhKnOw7JXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756251577; c=relaxed/simple;
	bh=8lYyDoqHXEgL2IWQCJY3sD0pn+bTDHWBlah2U7LKa/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LpZKW8XkO+LaqzOz3cBgKSgz8j9g2vbacjZkIR+Ip5ymUK/6IkTz0Gpup8NxORB6T+0jnHgVrC+gujV4zmyjd9vBBXCqR+ISGgDOfNT98adywkApogflQbfycuLnDjlMblpJFu/OyJLQvh4V2u6rXKpWwgBNq/qsyDv4Lj+78kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EzzmgLoy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11964C4CEF1;
	Tue, 26 Aug 2025 23:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756251576;
	bh=8lYyDoqHXEgL2IWQCJY3sD0pn+bTDHWBlah2U7LKa/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EzzmgLoySMhUUrvU4/QhXCdzYach1P/ODyrkxWGigaI283ealyRLPSA/jn+HY4WaP
	 g4KRPRK2SjKAnFp+r/BO1T7T4fF1ufa4NKiF0nPuJkqRTc1OMf8zu6qD4iqEndFE+b
	 RuuNJHsLXB32a4lK4o6jCPHTeZPMijTOPTHISSOV0AEqyqFm2ef4134mIjB5EXmoyX
	 68i4jZ3UMB5q4gdmLNq0Izj91ZyUQX4qu38H+DOIN6Ti1tM7cFwWdjWRfG6RDquun5
	 laMFC/QRJdizne3DStFLLiDo9BC1TnrRz54yL6RM3fLJj3YUx68lTOvaRNhUusf7v2
	 VVPGxaPul0vdg==
Date: Tue, 26 Aug 2025 16:39:34 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Peter Zijlstra <peterz@infradead.org>, Nathan Chancellor <nathan@kernel.org>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] objtool/LoongArch: Fix fall through warning
 about efi_boot_kernel()
Message-ID: <xyrcgkl7ud5pgh4h5yjyejz646bc22fnnwxahaoafqvnqintf3@mdhtfaybai67>
References: <20250826064631.9617-1-yangtiezhu@loongson.cn>
 <20250826064631.9617-2-yangtiezhu@loongson.cn>
 <CAAhV-H5wW_04NHQ7z+SCPb6-T5Hc__n+x=ykg-u9vn4b4GXuww@mail.gmail.com>
 <487a8149-6cbe-46a7-6771-66aef0045f07@loongson.cn>
 <CAAhV-H7m-BSqajDiDNMNEq4FY9uoCd9LZySOe0VQ+2Sv1wZZVg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H7m-BSqajDiDNMNEq4FY9uoCd9LZySOe0VQ+2Sv1wZZVg@mail.gmail.com>

On Tue, Aug 26, 2025 at 09:03:34PM +0800, Huacai Chen wrote:
> On Tue, Aug 26, 2025 at 8:33 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
> >
> > On 2025/8/26 下午4:32, Huacai Chen wrote:
> > > On Tue, Aug 26, 2025 at 2:46 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
> > >>
> > >> When compiling with LLVM and CONFIG_LTO_CLANG is set, there exists
> > >> the following objtool warning:
> > >>
> > >>    vmlinux.o: warning: objtool: __efistub_efi_boot_kernel()
> > >>    falls through to next function __efistub_exit_boot_func()
> >
> > ...
> >
> > >> -typedef void __noreturn (*kernel_entry_t)(bool efi, unsigned long cmdline,
> > >> +typedef void (*kernel_entry_t)(bool efi, unsigned long cmdline,
> > >>                                            unsigned long systab);
> > >  From my point of view this is incorrect, this function is indeed a
> > > noreturn function, and this modification makes LoongArch different to
> > > other architectures.
> > >
> > > Maybe it is better to let objtool ignore the whole
> > > drivers/firmware/efi/libstub directory. Because efistub is discarded
> > > at runtime so it is useless for stack unwinder.
> >
> > I tested the following change but there is no effect, the objtool
> > warning still exists, this is because OBJECT_FILES_NON_STANDARD
> > does not work for link time validation of vmlinux.o according to
> > tools/objtool/Documentation/objtool.txt.
> Then I think objtool needs to be improved to handle this case, this
> problem is not arch specific.

Yeah, objtool should really be ignoring this code altogether.  On x86,
that's not a problem because the EFI stub code isn't linked into
vmlinux.o.  It gets linked in separately:

  $ git grep vmlinux-libs
  arch/x86/boot/compressed/Makefile:vmlinux-libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
  arch/x86/boot/compressed/Makefile:vmlinux-libs-$(CONFIG_X86_64) += $(objtree)/arch/x86/boot/startup/lib.a
  arch/x86/boot/compressed/Makefile:$(obj)/vmlinux: $(vmlinux-objs-y) $(vmlinux-libs-y) FORCE

IMO, the proper fix is to change the loongarch build to do the same.
vmlinux.o is intended to be proper kernel code.

-- 
Josh

