Return-Path: <linux-kernel+bounces-787392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE8AB375A2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 01:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B1C23B7CA2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 23:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DE63093A5;
	Tue, 26 Aug 2025 23:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kGjAYZVI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0DF2797B8;
	Tue, 26 Aug 2025 23:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756251832; cv=none; b=Q1E2gMdSCL9WpAsVRKNzz+r0cAVrP8QSa5epKeWlcXXUr/rZ5jZZk8OgLId8xFVWzWM4b8evnyU7me35LP+73TkEU28o44wlOLey8v5l8PVde8WrMM7cDkGWLbAOmMMHLXrFdHavuS63UBqmDiX2HowxoMA/5TScFOcqvhxeeLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756251832; c=relaxed/simple;
	bh=Ibing0HBKI761ifUXKx+K7k21qXVK36s0zvCn0VfQV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Itcvi6immf07vUtd+p1wxwkrPUczdpmNIUriU7bMm0gRBa1E/KCLhrwSA4IyfUXqFQYQP9KiVK/59wXF4xix9hjNhy/E/keC24YMY+KRf41gJHLMbnlIVsDPiwemx9BD0jFgaXVF7F4PPxBOjtPh5z4LpIqIQ1PoRxPggSZKpZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kGjAYZVI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65EA9C4CEF1;
	Tue, 26 Aug 2025 23:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756251832;
	bh=Ibing0HBKI761ifUXKx+K7k21qXVK36s0zvCn0VfQV0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kGjAYZVIW8/OouXM4YZ9YfgQLyzCCl5b24LCOvQitsvIIchYTXL9U3bK56556s+yL
	 /2mCCw0cxg97pbdYC++e2m3K+f0TscVHN1aACS6+6XE9f7rmS+pY8D74jNa3kprcec
	 HFZ1P4pYL30QsSskzaiTeSOeXJGOWmF/ClmADpW+8FiQ3YeGKA7B+S99QVq32HOJiY
	 jC487/FGE+q/UV7U8KLPFRYyk8lUkYlY1zbjMgsQdQoSith6UY8dkzybtg55i0ENUT
	 XeXjuoMG+pYEUICE40ZY2cUubzH52H3VHMrktIMmS0TOgDCMjgDnQU6k5DdDWPFD73
	 HPhz8wnYWgMtA==
Date: Tue, 26 Aug 2025 16:43:49 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Nathan Chancellor <nathan@kernel.org>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] objtool/LoongArch: Fix unreachable instruction
 warnings about head.S
Message-ID: <l7l2ik5b2inhwbxmlae7ozrlxi7hbdjbrhjsrykjgotlhflah6@jebephhvtxki>
References: <20250826064631.9617-1-yangtiezhu@loongson.cn>
 <20250826064631.9617-3-yangtiezhu@loongson.cn>
 <CAAhV-H7NNtH-oaqMsN5=2c+EdF0-dy5mxcsO=_KFGWqb-FZj_w@mail.gmail.com>
 <b7551efd-cb5b-7503-c455-b8f22fac81bd@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b7551efd-cb5b-7503-c455-b8f22fac81bd@loongson.cn>

On Tue, Aug 26, 2025 at 08:30:23PM +0800, Tiezhu Yang wrote:
> On 2025/8/26 下午4:26, Huacai Chen wrote:
> > On Tue, Aug 26, 2025 at 2:46 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
> > > 
> > > When compiling with LLVM and CONFIG_LTO_CLANG is set, there exist the
> > > following objtool warnings after silencing all of the other warnings:
> 
> ...
> 
> > >   arch/loongarch/kernel/head.S | 8 ++++----
> > >   1 file changed, 4 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
> > > index e3865e92a917..566a1dbf5fa0 100644
> > > --- a/arch/loongarch/kernel/head.S
> > > +++ b/arch/loongarch/kernel/head.S
> > > @@ -20,6 +20,7 @@
> > >          __HEAD
> > > 
> > >   _head:
> > > +       UNWIND_HINT_UNDEFINED
> > >          .word   IMAGE_DOS_SIGNATURE     /* "MZ", MS-DOS header */
> > >          .org    0x8
> > >          .dword  _kernel_entry           /* Kernel entry point (physical address) */
> > > @@ -30,6 +31,7 @@ _head:
> > >          .long   pe_header - _head       /* Offset to the PE header */
> > > 
> > >   pe_header:
> > > +       UNWIND_HINT_UNDEFINED
> > >          __EFI_PE_HEADER
> > The efi header is completely not code, the annotations are very strange.
> 
> Yes, I think so too, but the aim is only to not checking for objtool,
> it seems no other better way.

Objtool is only getting confused because there's data in a text section.
Why not put that in a data section?

-- 
Josh

