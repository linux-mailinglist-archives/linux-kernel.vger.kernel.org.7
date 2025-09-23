Return-Path: <linux-kernel+bounces-828040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDFBCB93CBA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 03:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B0C144177B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 01:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654C91DF247;
	Tue, 23 Sep 2025 01:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qf21CC1V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B647917A2EB;
	Tue, 23 Sep 2025 01:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758589862; cv=none; b=MvwDah5O5a9efYrJcuVJAzcZ6CkWVoRQCIW+aHF8IIV7GoX5Ogkl0sveHgvu6Z/SJOwB1sM5TiykWp1tlP61vUy6mpK54PtHrnDUpP2+CtefcY7HnqvwSWBsQIePlsq88T0QOekrRxhVmBGLEj16MDHkbloNZTvjeTQdn+4dO3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758589862; c=relaxed/simple;
	bh=0Jda59RXsYzCBoDfESCbAp0uTTWmM63AxOyVi5h88sI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DUnMMa1Jm3ZN0qrcp0JNsskGjwJ4+fdm99jJgNSvQSzi3VWzCt5Zus3KX5UMRPJ+tzChRQoDL/0BFfekOZfdHfKOFZq6kouGPzyjz1c3I6oZxmlZcKiqua4Y7jsiVVYYJ+hVOspL1oW/aOCs8BpZIT9uHxwJijvVe3AVtMcT62s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qf21CC1V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E08FC4CEF0;
	Tue, 23 Sep 2025 01:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758589862;
	bh=0Jda59RXsYzCBoDfESCbAp0uTTWmM63AxOyVi5h88sI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qf21CC1VHuzqsFrt9dS3cC6RIWogn3VfVXv0rKXEMx6Uzh+M2zSEoX5dzyQuFpssw
	 9xFya1OK7hMe0IAmleR+5/bxwRt3C9vbrPVGmZYio0tvUFvfp6rh+O8QYYk2BtAcg/
	 81JyBVFfTdfR81M7u0HXevRPuZThLoWbSFEG6Iqx9IE/Kcd1htwcgo0VQu1ZF1lHRB
	 vgNvA+xXdrqHkzwDZ6kNA7a7bgwGylX8wbNpgS4AvjHv+yQYe3jLGR7n3WF0P7NVPV
	 zHK/v58Zl09YJMOvJg1mn6yWKsOReOSs/4owCl3Lo+BSAKfpKkRgAINkfg7jNH02fO
	 fG2bKG/QKtsgw==
Date: Mon, 22 Sep 2025 18:10:57 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	WANG Rui <wangrui@loongson.cn>, rust-for-linux@vger.kernel.org,
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v1 1/2] LoongArch: Make LTO case independent in Makefile
Message-ID: <20250923011057.GA3980504@ax162>
References: <20250909092707.3127-1-yangtiezhu@loongson.cn>
 <20250909092707.3127-2-yangtiezhu@loongson.cn>
 <20250920061536.GA1460394@ax162>
 <CAAhV-H5=w82CDx=1=PZjf4FVW_dGWe_e__QazwDTwE3kKXtPLQ@mail.gmail.com>
 <c9c4c0e6-946d-95de-9c03-a4b8e1636b81@loongson.cn>
 <7eafa4a6-55bf-2fcb-19ef-b18bd51bfd39@loongson.cn>
 <CAAhV-H4xx-C28-a8H7yJTK30+r90zL9XTSAb87Jr4zLc5ShBoA@mail.gmail.com>
 <750c907d-cc95-5116-4507-52dd48927cec@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <750c907d-cc95-5116-4507-52dd48927cec@loongson.cn>

> > > ifdef CONFIG_LTO_CLANG
> > > ifdef CONFIG_LLD_HAS_ANNOTATE_TABLEJUMP
> > > KBUILD_LDFLAGS                  += -mllvm --loongarch-annotate-tablejump
> > > else
> > > KBUILD_LDFLAGS                  += -mllvm --no-jump-tables
> > > endif

There is no '--no-jump-tables' LLVM option so this will not work.
Shouldn't -fno-jump-tables and -Zno-jump-tables take care of generating
jump tables?

> I do not know whether this is valid, you can test it with llvm 18
> and llvm 20 if you think it is a proper way.

For what it's worth, Huacai's original suggestion of

    KBUILD_LDFLAGS += $(call ld-option,-mllvm --loongarch-annotate-tablejump)

appears to work for me and I do not see any objtool warnings with LTO
enabled but I might be missing something.

> But IIRC, there is objtool warning with llvm 18, I reported to llvm
> developer Wang Lei and he fixed it as the following commit:
> 
> [LoongArch] Avoid indirect branch jumps using the ra register
> https://github.com/llvm/llvm-project/commit/21ef17c62645
> 
> Actually, the above commit solved a performance issue of llvm compiler,
> so I prefer to update the minimal llvm version to 20 for LoongArch.

I tend to let architecture maintainers make the call around minimum
supported versions of compilers, so if that is how you would like to
proceed, I am fine with that. I will say LLVM 20 is pretty new (released
on March 4th, 2025) but I expect most of your users to probably be using
bleeding edge tools for all the changes you make in the compiler and
lower level libraries?

Cheers,
Nathan

