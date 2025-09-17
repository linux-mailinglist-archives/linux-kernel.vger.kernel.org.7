Return-Path: <linux-kernel+bounces-821755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED86BB8229B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 00:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5AE14A2F9A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 22:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04A13019C0;
	Wed, 17 Sep 2025 22:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ah9kQTxe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E4520D51C;
	Wed, 17 Sep 2025 22:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758148347; cv=none; b=utKKbJ1aNgM06bvre5neHKSyCMsXh9ZG/R1SthRbFRFBAW6LOq85vfDynbAxh2L7yf/tOvY+QQrIbqJQ7ax3CZgUGUzG51eBRqNqrA/sq+odno7UajtIh96IgwG1KgU67hJQ5TiG2HZ79V2htnasu+sd3+/s545xuttNokQEkjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758148347; c=relaxed/simple;
	bh=eqj+1kpCBqFilRkjYIFtlpw1vDrGyjP2k2RZfwrKZfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WC0zih2gJVLNaokwRCK5YuDRdWiOz/FgS+i1FR6qvIXUHDZli6Vum9IyYm98T14ItKj08JXv8nb7oap/93CzqWaCjrTPXnLpesiYOSlxK0BsfAAGR2NuFuMZyxmqizvkbznkMtYa2/YRMsD6+jX1kHVnW9mLtYbwupro2Qy6YPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ah9kQTxe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01B2CC4CEE7;
	Wed, 17 Sep 2025 22:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758148346;
	bh=eqj+1kpCBqFilRkjYIFtlpw1vDrGyjP2k2RZfwrKZfk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ah9kQTxe3ntAwz8PSzy+vP8XJTixqiYXFz6bfZIKBkKpO4nuMjk8RWfK6jM6ek7Yb
	 XPI/DUNOzi17L+23/Ffn48w9xnrKqqJKfYOXS4yzr0V1m+x6m6Eq1JoHVnoLq7g25o
	 Zg1WyPgijPtf4d81RooTMB0+p5kqJisvIFtNwhc8+/QnyHWn3tkwm+MbbWoW7SmM5h
	 2ow2TAz0ZLJN1vvGRilRxkhEs6iJABfjK4XnbiohHfoeFTH84X4+jXOJDTsFXQ449v
	 4nlUlXn9RRtkNBfKW0rVebN4XxV3c46hUU0LqippzXHIXf5932creF1E+42SbZ2U0i
	 HClFkeFUVdLDg==
Date: Wed, 17 Sep 2025 15:32:24 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Peter Zijlstra <peterz@infradead.org>, 
	Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] objtool/LoongArch: Fix fall through warning about
 efistub
Message-ID: <ym3yf3rkxfq3sukfqbemmbpamjfsx4jjushqh3f54ah5ugamse@qqwabon64umq>
References: <20250917112716.24415-1-yangtiezhu@loongson.cn>
 <20250917112716.24415-2-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250917112716.24415-2-yangtiezhu@loongson.cn>

On Wed, Sep 17, 2025 at 07:27:14PM +0800, Tiezhu Yang wrote:
> When compiling with LLVM and CONFIG_LTO_CLANG is set, there exists
> the following objtool warning:
> 
>   vmlinux.o: warning: objtool: __efistub_efi_boot_kernel()
>   falls through to next function __efistub_exit_boot_func()
> 
> This is because efi_boot_kernel() doesn't end with a return instruction
> or an unconditional jump, then objtool has determined that the function
> can fall through into the next function.
> 
> At the beginning, try to do something to make efi_boot_kernel() ends with
> an unconditional jump instruction, but this modification seems not proper
> and makes LoongArch different to other architectures.
> 
> Furthermore, it is not proper to link efistub separately for LoongArch,
> ARM64 and RISC-V too due to there is technical reason why vmlinux.o needs
> efistub linked in.
> 
> For example, there are two ways of populating the core kernel's struct
> screen_info via the stub, the latter is preferred because it makes the
> EFIFB earlycon available very early, but it only works if the EFI stub
> is part of the core kernel image itself. For more information, please
> see the comments in drivers/firmware/efi/libstub/screen_info.c.

Hm?  Of course libstub needs to be linked into *vmlinux*.  But that
doesn't mean it needs to be in vmlinux.o.

Why not build libstub.a separately, and then link it with vmlinux.o
during the final vmlinux link, as x86 does?

-- 
Josh

