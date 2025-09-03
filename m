Return-Path: <linux-kernel+bounces-799294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CABB429AA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 21:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D02F7580D3D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 19:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12CC2D8DB0;
	Wed,  3 Sep 2025 19:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7IEtb7a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486A72D374A;
	Wed,  3 Sep 2025 19:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756927162; cv=none; b=b93l0dumyk4n01ny/fX0FxhUUiiI88NaCFz3043M+cWEqnc1wUuyuJn3TG1YodrGCJAjj4Hba8zQAG7jjluGMbcV1v0fnc+os/DVDhwQf53RwbKLLsEG1TElMErwMP8HCzPCs5JSydW97q2KuVlpG5SxhrMC47z9ZFplux4tSWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756927162; c=relaxed/simple;
	bh=/LA7irvtDdO2Ija0SsJ3D69faFD9Z6qw+QqTwYs3bjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jooQMRIV2D16qZKcj47F7sP6yMZtJ1hEU2NOnpxb7Out3Vo2OBPRPC/d+265e+6spc52Vuer7eKhQS83kpsPlCRcQ2x/VACD8SpkYs4mvOtzfSVMem5kroY/EoIVAApAxn1K3hEwyI5sn30w3ILLxY6qJaLnGQyf+0hTymxdAAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g7IEtb7a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 861BFC4CEE7;
	Wed,  3 Sep 2025 19:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756927161;
	bh=/LA7irvtDdO2Ija0SsJ3D69faFD9Z6qw+QqTwYs3bjM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g7IEtb7ashvJ2IvdPnTuSOEnKXAxbmLTmhMzzvJeDQjIIQnHU+FCd+XFh5f8e/7Ea
	 h6obXV3PZOlpzQiSuXzzV3JCBnmePdcqSoQuYrx0EDE5T2UxBtwlEdo2nMpjYV2cV+
	 4Q/bxklsH4aoFEBb0Gywd4JJ5WstW7GMPefHrt47p+JL0NCuDwdR4bFg08fMxf3EvH
	 XCzyGMttmUi0WTvfozhXjPdlJyItLp0oMZpOUJn2MMm3hrHmm5VBKBzhJaMIluPE83
	 uLFDXtt7qPjH8mPzUSDvRCD4Hiu7UNqxEkxXDj/NiM26A7Ky2b8hsYmNKR+eOtS0Dx
	 zwRGL6hqi373A==
Date: Wed, 3 Sep 2025 12:19:18 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Peter Zijlstra <peterz@infradead.org>, 
	Huacai Chen <chenhuacai@kernel.org>, Nathan Chancellor <nathan@kernel.org>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] objtool/LoongArch: Fix unreachable instruction
 warnings about EFISTUB
Message-ID: <wt4qpgi5isj5m6wq33pomvm6borvafuzktekc7lgtoitscar5q@brixzj3lccbw>
References: <20250901072156.31361-1-yangtiezhu@loongson.cn>
 <20250901072156.31361-3-yangtiezhu@loongson.cn>
 <20250901081904.GB4067720@noisy.programming.kicks-ass.net>
 <82c913b9-4403-cde9-0542-5bd6e04415f5@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <82c913b9-4403-cde9-0542-5bd6e04415f5@loongson.cn>

On Mon, Sep 01, 2025 at 04:39:29PM +0800, Tiezhu Yang wrote:
> On 2025/9/1 下午4:19, Peter Zijlstra wrote:
> > On Mon, Sep 01, 2025 at 03:21:55PM +0800, Tiezhu Yang wrote:
> > > When compiling with LLVM and CONFIG_LTO_CLANG is set, there exist the
> > > following objtool warnings:
> > > 
> > >    vmlinux.o: warning: objtool: .head.text+0x0: unreachable instruction
> > >    vmlinux.o: warning: objtool: .head.text+0x18: unreachable instruction
> > >    vmlinux.o: warning: objtool: .head.text+0x38: unreachable instruction
> > >    vmlinux.o: warning: objtool: .head.text+0x3c: unreachable instruction
> > >    vmlinux.o: warning: objtool: .head.text+0x40: unreachable instruction
> > >    vmlinux.o: warning: objtool: .head.text+0x44: unreachable instruction
> > >    vmlinux.o: warning: objtool: .head.text+0x54: unreachable instruction
> > >    vmlinux.o: warning: objtool: .head.text+0x58: unreachable instruction
> > >    vmlinux.o: warning: objtool: .head.text+0x6c: unreachable instruction
> > >    vmlinux.o: warning: objtool: .head.text+0x84: unreachable instruction
> > >    vmlinux.o: warning: objtool: .head.text+0x94: unreachable instruction
> > >    vmlinux.o: warning: objtool: .head.text+0x9c: unreachable instruction
> > >    vmlinux.o: warning: objtool: .head.text+0xc4: unreachable instruction
> > >    vmlinux.o: warning: objtool: .head.text+0xf8: unreachable instruction
> > >    vmlinux.o: warning: objtool: .head.text+0xfc: unreachable instruction
> > >    vmlinux.o: warning: objtool: .head.text+0x104: unreachable instruction
> > >    vmlinux.o: warning: objtool: .head.text+0x10c: unreachable instruction
> > >    vmlinux.o: warning: objtool: .head.text+0x11c: unreachable instruction
> > >    vmlinux.o: warning: objtool: .head.text+0x120: unreachable instruction
> > >    vmlinux.o: warning: objtool: .head.text+0x124: unreachable instruction
> > >    vmlinux.o: warning: objtool: .head.text+0x144: unreachable instruction
> > > 
> > > The instructions in the .head.text section are related with EFISTUB,
> > > they are image header and can be ignored by objtool, so just check the
> > > section name in ignore_unreachable_insn() to ignore it.
> > 
> > I am confused; why do the efi/libstub functions generate this error?
> > 
> > Is this zboot-header.S perhaps? Why can't we properly annotate that
> > file?
> 
> This is arch/loongarch/kernel/head.S.
> 
> There is "OBJECT_FILES_NON_STANDARD_head.o := y" in Makefile
> to skip objtool checking for head.o, but OBJECT_FILES_NON_STANDARD
> does not work for link time validation of vmlinux.o.
> 
> At the beginning, give UNWIND_HINT_UNDEFINED for these instructions,
> but there is an argument in the previous RFC [1]:
> 
> "The efi header is completely not code, the annotations are very strange."
> 
> Josh suggested to do something to put these instructions in the data
> section, but as said in the previous reply, it needs to modify the link
> process and seems too complicated and expensive for this warning to some
> extent.
> 
> So I did this change for objtool.

I don't like this workaround either, how exactly is it complicated and
expensive to put the data in a data section?

-- 
Josh

