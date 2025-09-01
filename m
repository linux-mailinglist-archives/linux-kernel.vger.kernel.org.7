Return-Path: <linux-kernel+bounces-794048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7DCAB3DC23
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 10:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 636503B55C0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 08:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB5921CFF6;
	Mon,  1 Sep 2025 08:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y/2SYkgQ"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3886C1AF0A7;
	Mon,  1 Sep 2025 08:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756714749; cv=none; b=CXw2bRFfJg2/1rzupCTI1xFRy+y6KCVOCGn/oFca4jbMPLiFrfdbPRbFZUSkUqJ6mUXE+DjdtSDCgBGHjoyzcwU77LbpSrSDY+hYPzk65b44YEuQ+MyjzeKUbOCLl6kd9WTwKr4W6t3A4oLFJi8+epMgKDsijh+YGLe3b0DDmzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756714749; c=relaxed/simple;
	bh=YYjBZUUDNsc6nNAi25nbVFIIcUbf2Q05sfbmm8lTWzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJTJgM6Zy/q9tjfUliaGUk+B80gXwPvGCYqC3B8udFSHKXPc1lmF7nrRXj2uIicsjvPIN71o3Ax+peVClJ4RaaWtS979dEsdUNhmwHnJVeuEut50GbjIpEk1w5RJ3wI1/G5hiBhnZdf+0kUAGdctKOAAheWcvdWW5Dew+FSDZ4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Y/2SYkgQ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YBad+3asEmhIktHo2zCSwxvqbX5Fg2WkzNrUPiI5jB8=; b=Y/2SYkgQOCvf0WVr88elwI3Cm0
	qISON5pLmS/ZkfVN4hTdFITxPrZE516Kmbjt9MVNBsN95QCXNw2nCon26U3OXc3CAyOsvgAaY8DVh
	3qoqMU6XZREJvqGT51NWKQh1GYVYPls8GxCyuI9WUfhPqhorkND5VAXrbmese8/00AZ67VatDhEWQ
	jLgO3X0cLyzwyXq/DxqrtXHY3uBeAp0Z5cJ54yPWE0ECyCPxPHIK8N90OwEahpV4RudvNQudWCIPV
	8alxE6tOtsubPPYDteQCIfJUHthyIJ+hh4yJWmAGvyB5QPrRK4wHQtPyiQJcK80aVZkVzypEJF7XT
	7ZBjE9Dg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uszkm-000000057g9-2yAT;
	Mon, 01 Sep 2025 08:19:05 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id DFA4D300342; Mon, 01 Sep 2025 10:19:04 +0200 (CEST)
Date: Mon, 1 Sep 2025 10:19:04 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] objtool/LoongArch: Fix unreachable instruction
 warnings about EFISTUB
Message-ID: <20250901081904.GB4067720@noisy.programming.kicks-ass.net>
References: <20250901072156.31361-1-yangtiezhu@loongson.cn>
 <20250901072156.31361-3-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901072156.31361-3-yangtiezhu@loongson.cn>

On Mon, Sep 01, 2025 at 03:21:55PM +0800, Tiezhu Yang wrote:
> When compiling with LLVM and CONFIG_LTO_CLANG is set, there exist the
> following objtool warnings:
> 
>   vmlinux.o: warning: objtool: .head.text+0x0: unreachable instruction
>   vmlinux.o: warning: objtool: .head.text+0x18: unreachable instruction
>   vmlinux.o: warning: objtool: .head.text+0x38: unreachable instruction
>   vmlinux.o: warning: objtool: .head.text+0x3c: unreachable instruction
>   vmlinux.o: warning: objtool: .head.text+0x40: unreachable instruction
>   vmlinux.o: warning: objtool: .head.text+0x44: unreachable instruction
>   vmlinux.o: warning: objtool: .head.text+0x54: unreachable instruction
>   vmlinux.o: warning: objtool: .head.text+0x58: unreachable instruction
>   vmlinux.o: warning: objtool: .head.text+0x6c: unreachable instruction
>   vmlinux.o: warning: objtool: .head.text+0x84: unreachable instruction
>   vmlinux.o: warning: objtool: .head.text+0x94: unreachable instruction
>   vmlinux.o: warning: objtool: .head.text+0x9c: unreachable instruction
>   vmlinux.o: warning: objtool: .head.text+0xc4: unreachable instruction
>   vmlinux.o: warning: objtool: .head.text+0xf8: unreachable instruction
>   vmlinux.o: warning: objtool: .head.text+0xfc: unreachable instruction
>   vmlinux.o: warning: objtool: .head.text+0x104: unreachable instruction
>   vmlinux.o: warning: objtool: .head.text+0x10c: unreachable instruction
>   vmlinux.o: warning: objtool: .head.text+0x11c: unreachable instruction
>   vmlinux.o: warning: objtool: .head.text+0x120: unreachable instruction
>   vmlinux.o: warning: objtool: .head.text+0x124: unreachable instruction
>   vmlinux.o: warning: objtool: .head.text+0x144: unreachable instruction
> 
> The instructions in the .head.text section are related with EFISTUB,
> they are image header and can be ignored by objtool, so just check the
> section name in ignore_unreachable_insn() to ignore it.

I am confused; why do the efi/libstub functions generate this error?

Is this zboot-header.S perhaps? Why can't we properly annotate that
file?

