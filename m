Return-Path: <linux-kernel+bounces-854925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D582BDFC45
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 18:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B1F73C23FE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EB532E74F;
	Wed, 15 Oct 2025 16:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sRXFDcyh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA2D33A027;
	Wed, 15 Oct 2025 16:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760547035; cv=none; b=LV6yDcDh6trazWKMSsrGBm0JA7xoeg4fkUcDbHUg768gdNBI6UR8IyDbew93gXeWeg5wVw7gEXi3Lynd0wIsTilv/5V9gjbUE74WjfghmSnm/O9v2n1fBaVi9wz30AzNUkgLhEDmMjQrOys11XmPxbf25Ak7l6G9EvstBAS3PVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760547035; c=relaxed/simple;
	bh=nvQqfRcL8pdS2FlTrtIHWykQKgr4h1ePS5qdoIB8BKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bobZO6nqeTwzfaqnjjpiZ7GboVzFi42k0JS0o3/sUWY2aM4en/sEp8yYTXkGVRLG/Tqr1SZnoV6WAb+f2a02qOD+jAANwhbWF5R72N5ctYBJOozoc5fNjAghmppSVv/UtTgpVEJDDuKqiseMR9h18cgfq0v/NjrDyJs0ltJyK3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sRXFDcyh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FF4FC4CEF8;
	Wed, 15 Oct 2025 16:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760547035;
	bh=nvQqfRcL8pdS2FlTrtIHWykQKgr4h1ePS5qdoIB8BKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sRXFDcyhMdvYZG8WoV7wCp4CXdcPAvLUZkf+8gO1Yv9kvxN07ngfHSyaKSYM32Atu
	 8lZbhK8bUVzKVobBXF/qLqFQvgGGLuat8YRsfDja0c8qGC3eK/PINuOEm2esFOPxJb
	 sWQP/YFM+4B8J1t8ae1kVm8NLOtHgHy1QmDTX9nRCuz+ZR0Ic6la1L2kYEVIcI39fp
	 tktnkHxlzue64vwOtVg+TAJZzi8Efdnym+WYEQeb1UVKJTlEUV+HTsmgsdUGRBqi2V
	 QeZzTWjauIBUsxht3vTUVu/37d8ISaMqk7AMi7RqQt9muJC6qeEoNocdcHm4xmSFxA
	 eOv/18V/+Ku2w==
Date: Wed, 15 Oct 2025 09:50:31 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
	llvm@lists.linux.dev
Subject: Re: clang 15 build error
Message-ID: <20251015165031.GA1465138@ax162>
References: <20251015143312.GBaO-wqLdOtyEQkd1U@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015143312.GBaO-wqLdOtyEQkd1U@fat_crate.local>

Hey Boris,

On Wed, Oct 15, 2025 at 04:33:12PM +0200, Borislav Petkov wrote:
> before I go dig into this, any ideas? The likelyhood that you know what the
> issue is, is high: :-P
> 
> That's 32-bit allnoconfig of latest Linus master with Ubuntu clang version
> 15.0.7:
> 
> mm/maccess.c:41:3: error: invalid output size for constraint '=a'
>                 copy_from_kernel_nofault_loop(dst, src, size, u64, Efault);
>                 ^
> mm/maccess.c:22:3: note: expanded from macro 'copy_from_kernel_nofault_loop'
>                 __get_kernel_nofault(dst, src, type, err_label);        \
>                 ^
> ./arch/x86/include/asm/uaccess.h:629:18: note: expanded from macro '__get_kernel_nofault'
>         __get_user_size(*((type *)(dst)), (__force type __user *)(src), \
>                         ^
> mm/maccess.c:41:3: error: invalid output size for constraint '=a'
> mm/maccess.c:22:3: note: expanded from macro 'copy_from_kernel_nofault_loop'
>                 __get_kernel_nofault(dst, src, type, err_label);        \
>                 ^
> ./arch/x86/include/asm/uaccess.h:629:18: note: expanded from macro '__get_kernel_nofault'
>         __get_user_size(*((type *)(dst)), (__force type __user *)(src), \
>                         ^
> 2 errors generated.

Heh, I am aware of it but I have not had a chance to actually dig into
see what is going wrong here :/

https://github.com/ClangBuiltLinux/linux/issues/2121

I guess that LLVM is unhappy about a 64-bit variable being passed into
the constraint for eax on 32-bit?

https://github.com/llvm/llvm-project/blob/ce60a03573a4d9f28dd6de42f61f0a3c4b0f2be9/clang/test/CodeGen/X86/x86_32-inline-asm.c#L50
https://github.com/llvm/llvm-project/commit/974131ea8825041673a8c8dda7c42f9a9376eb17

Cheers,
Nathan

