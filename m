Return-Path: <linux-kernel+bounces-803314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D070B45D66
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 18:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D0E73A06E1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C616B2FB082;
	Fri,  5 Sep 2025 16:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VkCTmRFP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C50131D749;
	Fri,  5 Sep 2025 16:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757088294; cv=none; b=nsWx6Sfji7JbEUGQthoJ78Lf3iSsLAE5ljOJgiFqIMwmi7DG12fMAd2BlTIeKYeGkt1fZx8T1VDSpfpELN4E9fE8hO1wdd+qYR1Ae4sQIPeEqAUB6MzmRNaChyl2yqEyl/i/C+azlWaoCcNcl0U9YsbHI02CrFBzsf3xmNW5gzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757088294; c=relaxed/simple;
	bh=MFaxVUP2WR8mgDvfrBhcM+Tfjo4mL8eAwZ6FVGDLWjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bI6IVtvTlJ8yZXRocvU9BUHXiPbM8pw2xNoog2M1H90ghJ9oJ7axHPvLdLsanY5xxrTl5wrEtgEAXIVtYGN/pnJ3+xfulU9vY/FVJ7JVSAmaoo+tGlY4u4a4PuJS5A0lhOuLAOGj6FUCUpHRDwJc3W2vAJtEWSfrAwNIT4PZ8Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VkCTmRFP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8320C4CEF1;
	Fri,  5 Sep 2025 16:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757088293;
	bh=MFaxVUP2WR8mgDvfrBhcM+Tfjo4mL8eAwZ6FVGDLWjc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VkCTmRFPvNIoW2SRR9UQ+m3Bgmsw3U8XoktISJCNWRsHPG+sm07bN4kNxkCfT10si
	 A/igHYxPZ82zdvfzQrO6RLksqI8tJ4jDxNCz45/+U8Fmud8MkDFbOngF6ttRlS11lo
	 EOW8GSe9xnEOyQ3GtDQmNezgCiKxx3sTnjQpe3G5ro6I9OQjCILR5kmyP62kxy0QpI
	 7MG3Q1Z2YYKQrPIqnbDNdf9nAuN/hcOcfZcam9/POvGyDYO8WWZzRbAJ3n4tbivQV/
	 kYGKv1VbF2B/3LqOpv03Mtpf8392yqlxj/Cpm+cB7fxJ2gH/zGRfI+uxlMi51BZOA1
	 cS6d7lz0gUGuw==
Date: Fri, 5 Sep 2025 09:04:50 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Peter Zijlstra <peterz@infradead.org>, Nathan Chancellor <nathan@kernel.org>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] objtool/LoongArch: Fix unreachable instruction
 warnings about EFISTUB
Message-ID: <itoqfhz4pxaf7aclzajkxcdsxe5akxhgahzj4dp24leh7w334k@epnvcxdga75p>
References: <20250901081904.GB4067720@noisy.programming.kicks-ass.net>
 <82c913b9-4403-cde9-0542-5bd6e04415f5@loongson.cn>
 <wt4qpgi5isj5m6wq33pomvm6borvafuzktekc7lgtoitscar5q@brixzj3lccbw>
 <ccbb40c1-5f2d-77e9-e8d2-52f2fdbad645@loongson.cn>
 <CAAhV-H5qhKepa-8sz3_AC=_RCChbVeEmnHKESMqpiJ0phMORbg@mail.gmail.com>
 <52056c29-4f21-83c9-db1f-ebd1875a3675@loongson.cn>
 <CAAhV-H47VKERJCKRi7uAS7OmCWaE4yxZ07Hwz_si2DMVRDrsag@mail.gmail.com>
 <ybv2ndrzbqztkctzwhfphpdqrqbxlougs75glm22rcuzdmnrfp@lqwcms3j2d55>
 <4thrzifl6ntk7kdf65egt4srzkbrxqoqf7yzmasblwvaq3qwmt@vigfgpbxzjkq>
 <CAAhV-H53DkR6oK1chXQtoczqxYBCU-FMKrD99bjEvfXapND1Vw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H53DkR6oK1chXQtoczqxYBCU-FMKrD99bjEvfXapND1Vw@mail.gmail.com>

On Fri, Sep 05, 2025 at 12:36:16PM +0800, Huacai Chen wrote:
> Hi, Josh,
> 
> On Fri, Sep 5, 2025 at 5:46 AM Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> >
> > On Thu, Sep 04, 2025 at 10:39:30AM -0700, Josh Poimboeuf wrote:
> > > On Thu, Sep 04, 2025 at 11:59:30AM +0800, Huacai Chen wrote:
> > > > This is from RISC-V code.
> > > >
> > > > __HEAD
> > > > SYM_CODE_START(_start)
> > > >         /*
> > > >          * Image header expected by Linux boot-loaders. The image header data
> > > >          * structure is described in asm/image.h.
> > > >          * Do not modify it without modifying the structure and all bootloaders
> > > >          * that expects this header format!!
> > > >          */
> > > > #ifdef CONFIG_EFI
> > > >         /*
> > > >          * This instruction decodes to "MZ" ASCII required by UEFI.
> > > >          */
> > > >         c.li s4,-13
> > > >         j _start_kernel
> > > > #else
> > > >         /* jump to start kernel */
> > > >         j _start_kernel
> > > >         /* reserved */
> > > >         .word 0
> > > > #endif
> > > >
> > > > The HEAD section has instructions, if you change it into a data
> > > > section then it loses the "x" attribute.
> >
> > Actually, the "x" attribute isn't needed for vmlinux.  The vmlinux
> > linker script places it in the text region regardless.
> >
> > Moving the data to a data section should be really simple, something
> > like the below.
> >
> > And yes, even the above RISC-V code can be in a data section.  Those
> > instructions are part of the 'struct riscv_image_header' data structure.
> This may work but also look strange (code in data section), it is more
> like a "workaround". :)

The "strange" part of the code is the intermixing of code and data.  If
they can't be separated, then they are part of a data structure and
belong in a data section.

-- 
Josh

