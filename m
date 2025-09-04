Return-Path: <linux-kernel+bounces-801359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88802B4442B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 19:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4904A1C838C5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F04430DD09;
	Thu,  4 Sep 2025 17:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IkxFS2Ik"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C071F75A6;
	Thu,  4 Sep 2025 17:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757006164; cv=none; b=UM9pd2Q4ZXyMR4uMUuyJKPtNsMaBut11sqtdbsggGPneL2ljCFHzQQU+G2WmpuuVU7VrezUNk6scjJ1ddASqQERhyzqUH04IY3aK6ndG88ftmi5pPu5aZQW8IGRIZh6Tt5nyikWzDRKJKpahEph/23y9QeWsUayoNq4ump/+jig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757006164; c=relaxed/simple;
	bh=RLDNaMvtTcDFLBRI8CRbBMtmCXNq09oCo1x8DhLKx1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cg/XpvfUE7R6PpMvLdKL1tZal2v5xR6SC+Q+6liqBZxqqSK8OVc+9pJG9zbN0IF9ZX5PFIpKDdIpLlWaNTGJCyUPA5v9hpT9vhNFxikylw8m6Ix9pHRgUd+SWwrCndwYW5gbGsd54zbXL/smpzp/3D5ubyOUa+964QJXwyvWSEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IkxFS2Ik; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E563C4CEF0;
	Thu,  4 Sep 2025 17:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757006162;
	bh=RLDNaMvtTcDFLBRI8CRbBMtmCXNq09oCo1x8DhLKx1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IkxFS2IkdAtwB3Vh43Sjl55zEKa6+/w0Sx5c7pthtfcoAXDLknCNY2tzNpHe0s9BC
	 /3Ub8kxvCHyb9NXPwBLME8V1kk0IOK6cB9fhjGbi3zsCCAR/2p+CCmFtAl2ekW/0dQ
	 Zkfzn7Vu9SxEL0ZubGSvnCTr2PrKq4+L2T1Rr7g0/Sy9Qh1r8F7xShzd+U0OSIQhuI
	 uESS+8YbK/EaO6jSHzHdy2z5qwsdtly65It5Xdhuy9no0BqLUmjOYCKL5IcP1IeSg1
	 y9lU4eH4PICyqKBJ/RQyzg5YEcyGANlf81qiomNJX+MJzXM0FqXbmZrBqVLNqbQBNg
	 yOnPNg/iU3eKA==
Date: Thu, 4 Sep 2025 10:16:00 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Nathan Chancellor <nathan@kernel.org>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] LoongArch: Fix unreachable instruction warnings
 about entry functions
Message-ID: <kjiyla6qj3l7ezspitulrdoc5laj2e6hoecvd254hssnpddczm@g6nkaombh6va>
References: <20250901072156.31361-1-yangtiezhu@loongson.cn>
 <20250901072156.31361-4-yangtiezhu@loongson.cn>
 <ots6w2ntyudj5ucs5eowncta2vmfssatpcqwzpar3ekk577hxi@j45dd4dmwx6x>
 <3da2092b-e6ca-a7a1-9459-c2754adf19aa@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3da2092b-e6ca-a7a1-9459-c2754adf19aa@loongson.cn>

On Thu, Sep 04, 2025 at 11:18:28AM +0800, Tiezhu Yang wrote:
> On 2025/9/4 上午3:22, Josh Poimboeuf wrote:
> > On Mon, Sep 01, 2025 at 03:21:56PM +0800, Tiezhu Yang wrote:
> > > +++ b/arch/loongarch/kernel/Makefile
> > > @@ -3,8 +3,6 @@
> > >   # Makefile for the Linux/LoongArch kernel.
> > >   #
> > > -OBJECT_FILES_NON_STANDARD_head.o := y
> > > -
> > >   always-$(KBUILD_BUILTIN)	:= vmlinux.lds
> > >   obj-y		+= head.o cpu-probe.o cacheinfo.o env.o setup.o entry.o genex.o \
> > > diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
> > > index e3865e92a917..a11880f3a7e1 100644
> > > --- a/arch/loongarch/kernel/head.S
> > > +++ b/arch/loongarch/kernel/head.S
> > > @@ -42,6 +42,7 @@ SYM_DATA(kernel_fsize, .long _kernel_fsize);
> > >   	.align 12
> > >   SYM_CODE_START(kernel_entry)			# kernel entry point
> > > +	UNWIND_HINT_UNDEFINED
> > 
> > Should this not be UNWIND_HINT_END_OF_STACK?
> 
> Yes, makes sense, will do it in the next version.
> 
> > I notice Loongarch doesn't seem to use that anywhere.  How does any ORC
> > unwind succeed?  UNWIND_HINT_UNDEFINED sets an error condition which
> > should cause a livepatch transition to stall.
> 
> Actually, kernel_entry() or smpboot_entry() is recognized as the last
> frame, because at this point is_entry_func() is true and
> state->stack_info.type = STACK_TYPE_UNKNOWN in unwind_next_frame() of
> arch/loongarch/kernel/unwind_orc.c.

I think you can get rid of is_entry_func() in favor of just using
UNWIND_HINT_END_OF_STACK at all the entry points.

-- 
Josh

