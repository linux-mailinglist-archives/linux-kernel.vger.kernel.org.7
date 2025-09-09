Return-Path: <linux-kernel+bounces-808598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E7CB50214
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 18:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1208E1C605E7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880F132CF71;
	Tue,  9 Sep 2025 16:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tJlauKOP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E295121B9C0;
	Tue,  9 Sep 2025 16:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757433945; cv=none; b=rpLiSePRsCUizyA1OOABt04WffAIg8BWPM1EM6+1w+vx6cg7+ciZiKAdZ8NKtj4ghY9sMKCLnhCl4vMMNHnC+MwFNOPM0sbxDpcNcER8NJ3+CJbFOBfeD2OZsxzkZdP2tKXjAW8QEjat0Kwp7mYGXdbP6+NQ0Tvcl7Kg5eqiwQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757433945; c=relaxed/simple;
	bh=knogLe+uZIeoGxILF9gC9izXX3E+9SsuaakElZpKIug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pfCUo8kdlviOHG1uhob47mMEuiCrxSy0nvVupV48Lpz6a9q31M1DHZBKukSgBsrin9ol90P0YiY/TNUrkMgzJ2CJKalOQDZ5BC84cfgAsrUrH5zzfp4ZGHIBFqSIJ8ELs9Elqi5ut1YTU+se0n3DLKc9dn6UPC4XZgJHHK10fmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tJlauKOP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEDAAC4CEF4;
	Tue,  9 Sep 2025 16:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757433944;
	bh=knogLe+uZIeoGxILF9gC9izXX3E+9SsuaakElZpKIug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tJlauKOPjhbG1fxATmBDJz12hCxfkjlYA8hHHKD7+SrAZJtuu1O7PJY2JjVScaBDm
	 gm2GmuK2A1TbocAuTpK7+Gs8mbxm6PI3Mp6/B08FxsAr4FkQpVgvCGuRRXYOXNSh/r
	 EaEr9RbbBQXs6SHwZX4tma/OXH6zaSBhYSu95O39NrfCGznd7O3zkvIP8/FXEbEXyg
	 81Y7x5BHRyGJR8KDNO6Xb2tJLKU+sV+uPv4DzsIAO1Qa4BlUYF07cuLYUPpO/Dq83+
	 mM3ijhBh8oV5elA0Gvs89ZaYV3LP1Yf7fGBG0vk7tlZkZnsDRBiNZoYJzdNrfYuKeV
	 Q8lt926uBCj4w==
Date: Tue, 9 Sep 2025 09:05:40 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Peter Zijlstra <peterz@infradead.org>, Nathan Chancellor <nathan@kernel.org>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] objtool/LoongArch: Fix unreachable instruction
 warnings about EFISTUB
Message-ID: <domy5iwmaasksrm7srdmus5vifcxrzvozwpnc3ht43qtxvkjhd@gkyxt3qaeyqu>
References: <ccbb40c1-5f2d-77e9-e8d2-52f2fdbad645@loongson.cn>
 <CAAhV-H5qhKepa-8sz3_AC=_RCChbVeEmnHKESMqpiJ0phMORbg@mail.gmail.com>
 <52056c29-4f21-83c9-db1f-ebd1875a3675@loongson.cn>
 <CAAhV-H47VKERJCKRi7uAS7OmCWaE4yxZ07Hwz_si2DMVRDrsag@mail.gmail.com>
 <ybv2ndrzbqztkctzwhfphpdqrqbxlougs75glm22rcuzdmnrfp@lqwcms3j2d55>
 <4thrzifl6ntk7kdf65egt4srzkbrxqoqf7yzmasblwvaq3qwmt@vigfgpbxzjkq>
 <CAAhV-H53DkR6oK1chXQtoczqxYBCU-FMKrD99bjEvfXapND1Vw@mail.gmail.com>
 <itoqfhz4pxaf7aclzajkxcdsxe5akxhgahzj4dp24leh7w334k@epnvcxdga75p>
 <49ceb19c-6107-d026-3ae6-ae897d1fcae4@loongson.cn>
 <CAAhV-H7U+-WM_cmehAEyKZrGteosZZ3GUsO3yy7wjUNK-v=qjw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H7U+-WM_cmehAEyKZrGteosZZ3GUsO3yy7wjUNK-v=qjw@mail.gmail.com>

On Tue, Sep 09, 2025 at 12:10:29PM +0800, Huacai Chen wrote:
> On Tue, Sep 9, 2025 at 12:00 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
> >
> > On 2025/9/6 上午12:04, Josh Poimboeuf wrote:
> > > On Fri, Sep 05, 2025 at 12:36:16PM +0800, Huacai Chen wrote:
> > >> Hi, Josh,
> > >>
> > >> On Fri, Sep 5, 2025 at 5:46 AM Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> > >>>
> > >>> On Thu, Sep 04, 2025 at 10:39:30AM -0700, Josh Poimboeuf wrote:
> > >>>> On Thu, Sep 04, 2025 at 11:59:30AM +0800, Huacai Chen wrote:
> > >>>>> This is from RISC-V code.
> > >>>>>
> > >>>>> __HEAD
> > >>>>> SYM_CODE_START(_start)
> > >>>>>          /*
> > >>>>>           * Image header expected by Linux boot-loaders. The image header data
> > >>>>>           * structure is described in asm/image.h.
> > >>>>>           * Do not modify it without modifying the structure and all bootloaders
> > >>>>>           * that expects this header format!!
> > >>>>>           */
> > >>>>> #ifdef CONFIG_EFI
> > >>>>>          /*
> > >>>>>           * This instruction decodes to "MZ" ASCII required by UEFI.
> > >>>>>           */
> > >>>>>          c.li s4,-13
> > >>>>>          j _start_kernel
> > >>>>> #else
> > >>>>>          /* jump to start kernel */
> > >>>>>          j _start_kernel
> > >>>>>          /* reserved */
> > >>>>>          .word 0
> > >>>>> #endif
> > >>>>>
> > >>>>> The HEAD section has instructions, if you change it into a data
> > >>>>> section then it loses the "x" attribute.
> > >>>
> > >>> Actually, the "x" attribute isn't needed for vmlinux.  The vmlinux
> > >>> linker script places it in the text region regardless.
> > >>>
> > >>> Moving the data to a data section should be really simple, something
> > >>> like the below.
> > >>>
> > >>> And yes, even the above RISC-V code can be in a data section.  Those
> > >>> instructions are part of the 'struct riscv_image_header' data structure.
> > >> This may work but also look strange (code in data section), it is more
> > >> like a "workaround". :)
> > >
> > > The "strange" part of the code is the intermixing of code and data.  If
> > > they can't be separated, then they are part of a data structure and
> > > belong in a data section.
> >
> > I tried the following minimal changes, put the image header into
> > the section .head.data, do not link efistub lib.a into vmlinux.o,
> > just link efistub lib.a into vmlinux, no other changes, they have
> > same effect with patch #1 and #2, what do you think?
> I still don't think we have to put the HEAD into a data section. Yes,
> it is a mix of code and data, but the data is read-only so it doesn't
> need the "w" attribute (and code needs "x", at least in theory).

Then it can be __HEAD_RODATA, with the "w" removed:

#define __HEAD_RODATA	.section	".head.rodata","a"

> From my point of view, the text section is still the best for HEAD.

It belongs in a data section for two reasons:

  1) It's an image header data structure.

  2) We don't want objtool (or any other tooling) to try to validate it
     or otherwise treat it as text during the build.

-- 
Josh

