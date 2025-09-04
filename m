Return-Path: <linux-kernel+bounces-801396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45247B44493
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 19:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B8D67BF6F4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333613126D2;
	Thu,  4 Sep 2025 17:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="edEYk+u/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8540B27511C;
	Thu,  4 Sep 2025 17:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757007573; cv=none; b=nswBYiDyCTORHD6hTYz1aKaB3aQ4GTI7Fc94NjBXhSWyw9Dx0XMIlU8sSSEWbaBMwxzf2piOgF7v1XaVnPfgdI7QC6BmPJvMKgxejiPe4ownQ0De73X4x1aKwyW8NHpq3/D9TvI0zet2g/C4eKKWOuGWY3U5Db6McsNdCTe2LbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757007573; c=relaxed/simple;
	bh=Xbvz6qKnaBnWjDty07oXkI1QOz/gH22+Af4nDw/yES0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l7ctd8OcaWYXvZlosbK5VZleLwLLJsYK+comEC7BKcI1Am2Boc6o34zr8yUgMw9h26b/MaV6XE8NS8437vMvnPEkhy5iA8+sb80mYzzXQFT63yRIv6YsW5xq3seQ1o4AQgia5hS49PswCCiRj/jyV2EhjzeZlL4KTI6cp3+Dl7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=edEYk+u/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E811C4CEF0;
	Thu,  4 Sep 2025 17:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757007573;
	bh=Xbvz6qKnaBnWjDty07oXkI1QOz/gH22+Af4nDw/yES0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=edEYk+u//CE5kp4AcfLqO+W2yncL4Or78zA4tBKXCkJ78caqFnnvgzVkDFLLcKh5R
	 AP1BtIQCjrkYFVq1HOD0aQuLiGxB0bzBG5L+Vt5RYywOa/N7vj94cCw2cM5Porjk6G
	 9eLFYE7W8OgsfqJeclDt/znvHo743bcVpXjjmMIX+J/VoreDiDmcvmLQ8UItIDZ1C5
	 I7CFCmNBTXQdGKuYVAKPXsC3NYUeRljlkhfrBrxvz5LvYqhcKQB+y5NmxdbvJICGHG
	 pBJxPOykZOuv7WoWR31BHxlvnSGSb52nUVa9Zow4A5qpPDMWrNYk5FvZspMCFTDYQd
	 h3tB+2/ZmaGaQ==
Date: Thu, 4 Sep 2025 10:39:30 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Peter Zijlstra <peterz@infradead.org>, Nathan Chancellor <nathan@kernel.org>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] objtool/LoongArch: Fix unreachable instruction
 warnings about EFISTUB
Message-ID: <ybv2ndrzbqztkctzwhfphpdqrqbxlougs75glm22rcuzdmnrfp@lqwcms3j2d55>
References: <20250901072156.31361-1-yangtiezhu@loongson.cn>
 <20250901072156.31361-3-yangtiezhu@loongson.cn>
 <20250901081904.GB4067720@noisy.programming.kicks-ass.net>
 <82c913b9-4403-cde9-0542-5bd6e04415f5@loongson.cn>
 <wt4qpgi5isj5m6wq33pomvm6borvafuzktekc7lgtoitscar5q@brixzj3lccbw>
 <ccbb40c1-5f2d-77e9-e8d2-52f2fdbad645@loongson.cn>
 <CAAhV-H5qhKepa-8sz3_AC=_RCChbVeEmnHKESMqpiJ0phMORbg@mail.gmail.com>
 <52056c29-4f21-83c9-db1f-ebd1875a3675@loongson.cn>
 <CAAhV-H47VKERJCKRi7uAS7OmCWaE4yxZ07Hwz_si2DMVRDrsag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H47VKERJCKRi7uAS7OmCWaE4yxZ07Hwz_si2DMVRDrsag@mail.gmail.com>

On Thu, Sep 04, 2025 at 11:59:30AM +0800, Huacai Chen wrote:
> On Thu, Sep 4, 2025 at 11:50 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
> >
> > On 2025/9/4 上午10:21, Huacai Chen wrote:
> > > On Thu, Sep 4, 2025 at 10:18 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
> > >>
> > >> On 2025/9/4 上午3:19, Josh Poimboeuf wrote:
> > >>> On Mon, Sep 01, 2025 at 04:39:29PM +0800, Tiezhu Yang wrote:
> > >>>> On 2025/9/1 下午4:19, Peter Zijlstra wrote:
> > >>>>> On Mon, Sep 01, 2025 at 03:21:55PM +0800, Tiezhu Yang wrote:
> > >>>>>> When compiling with LLVM and CONFIG_LTO_CLANG is set, there exist the
> > >>>>>> following objtool warnings:
> > >>
> > >> ...
> > >>
> > >>>> Josh suggested to do something to put these instructions in the data
> > >>>> section, but as said in the previous reply, it needs to modify the link
> > >>>> process and seems too complicated and expensive for this warning to some
> > >>>> extent.
> > >>>>
> > >>>> So I did this change for objtool.
> > >>>
> > >>> I don't like this workaround either, how exactly is it complicated and
> > >>> expensive to put the data in a data section?
> > >>
> > >> I can put them in a data section in the next version, this is
> > >> reasonable.
> > > No, from the ARM64 and RISC-V design, we can put jump instructions in
> > > the HEAD section, and this is what Jiaxun wants to do. Changing to a
> > > data section is not reasonable.
> >
> > ARM64, RISC-V and LoongArch share the same logic in efistub:
> >
> > $ grep -r "libstub/lib.a" arch/*/Makefile
> > arch/arm64/Makefile:libs-$(CONFIG_EFI_STUB) +=
> > $(objtree)/drivers/firmware/efi/libstub/lib.a
> > arch/loongarch/Makefile:libs-$(CONFIG_EFI_STUB) +=
> > $(objtree)/drivers/firmware/efi/libstub/lib.a
> > arch/riscv/Makefile:libs-$(CONFIG_EFI_STUB) +=
> > $(objtree)/drivers/firmware/efi/libstub/lib.a
> >
> > If we can not put the these data to a data section, then we can not
> > link efistub separately, because if remove the following code in
> > arch/loongarch/Makefile:
> >
> > libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
> >
> > there exists the following build error:
> >
> >     LD      vmlinux.o
> >    OBJCOPY modules.builtin.modinfo
> >    GEN     modules.builtin
> >    GEN     .vmlinux.objs
> >    MODPOST Module.symvers
> >    UPD     include/generated/utsversion.h
> >    CC      init/version-timestamp.o
> >    KSYMS   .tmp_vmlinux0.kallsyms.S
> >    AS      .tmp_vmlinux0.kallsyms.o
> >    LD      .tmp_vmlinux1
> > ld: arch/loongarch/kernel/head.o: in function `pe_header':
> > (.head.text+0x68): undefined reference to `__efistub_efi_pe_entry'
> >
> > What should to do in the next step? I am looking forward to your
> > final conclusion.
> 
> This is from RISC-V code.
> 
> __HEAD
> SYM_CODE_START(_start)
>         /*
>          * Image header expected by Linux boot-loaders. The image header data
>          * structure is described in asm/image.h.
>          * Do not modify it without modifying the structure and all bootloaders
>          * that expects this header format!!
>          */
> #ifdef CONFIG_EFI
>         /*
>          * This instruction decodes to "MZ" ASCII required by UEFI.
>          */
>         c.li s4,-13
>         j _start_kernel
> #else
>         /* jump to start kernel */
>         j _start_kernel
>         /* reserved */
>         .word 0
> #endif
> 
> The HEAD section has instructions, if you change it into a data
> section then it loses the "x" attribute.
> 
> So my conclusion is this series is the correct solution for all
> non-x86 archs. We don't need to treat it as "workarounds".

Ok.  In that case please put the full justifications for these changes
in the patch descriptions.

-- 
Josh

