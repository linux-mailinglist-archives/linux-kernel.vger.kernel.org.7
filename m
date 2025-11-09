Return-Path: <linux-kernel+bounces-892048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FCBC4430A
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 18:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6E443A3355
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 17:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029D03002DB;
	Sun,  9 Nov 2025 17:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="brXGgoWp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CD1883F;
	Sun,  9 Nov 2025 17:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762707799; cv=none; b=DDsXBIq+KkKxpRWxF16fEKLehzCB95NWckqSitthF3x1tCF5qH++QWeFqxaGDGZ4JbjnkaJ/i6lAoSueiz4zHHqo+iHYsR0xueOOCKeImzDReoiX9rOsYbTmM9MKdyB00wMcODls73yiPJikl3HzI2LgQ8H+RskkGH7b5/orWwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762707799; c=relaxed/simple;
	bh=axbmF0SGDsmvQ9zcHfVj/xPuDxY4tpgaCZ5J8pxJ64I=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=EWslLnhZAnAgc4e9CRlyFCJg/6zJTJNFt2YWEIxDvdLr/GMLLAwxt8bf9ODOzJomNHjjsmrL1/gC6XltACPES69bRXgjxOlyXkE5RTTMGIh6I2CaDDZgr3X523B8rXiBFEjGcNvUmX/6a0oxkqiW4dhfZLeb0xrj+vh38vjk2lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=brXGgoWp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B21FC4CEF8;
	Sun,  9 Nov 2025 17:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1762707798;
	bh=axbmF0SGDsmvQ9zcHfVj/xPuDxY4tpgaCZ5J8pxJ64I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=brXGgoWp4ZPbPVMQIXKKEvXI4EuQKlHge5IpgfKiGzNHzQkgDsih4YT/ZVPCU1KYH
	 FGmvIJo3UNizCUEdTUove8nCxruE5bcpo/uvdZKGyBqONmBEKSLIfFV8mhmEUjVL3h
	 jhm+MclN+8RSJGUrxjraUwiIMrHEGRay0H4mj7jI=
Date: Sun, 9 Nov 2025 09:03:17 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Xie Yuanbin <qq570070308@gmail.com>
Cc: nathan@kernel.org, nick.desaulniers+lkml@gmail.com, morbo@google.com,
 justinstitt@google.com, masahiroy@kernel.org, jack@suse.cz,
 maninder1.s@samsung.com, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, will@kernel.org
Subject: Re: [PATCH] Fix redundant judgment in WARN_ONCE with clang
Message-Id: <20251109090317.4261cff25a497bcc8a358a7d@linux-foundation.org>
In-Reply-To: <20251109083715.24495-1-qq570070308@gmail.com>
References: <20251109083715.24495-1-qq570070308@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  9 Nov 2025 16:37:15 +0800 Xie Yuanbin <qq570070308@gmail.com> wrote:

> For c code:
> ```c
> extern int xx;
> void test(void)
> {
> 	if (WARN_ONCE(xx, "x"))
> 		__asm__ volatile ("nop":::);
> }
> ```
> 
> Clang will generate the following assembly code:
> ```assemble
> test:
> 	movl	xx(%rip), %eax // Assume xx == 0 (likely case)
> 	testl	%eax, %eax // judge once
> 	je	.LBB0_3    // jump to .LBB0_3
> 	testb	$1, test.__already_done(%rip)
> 	je	.LBB0_2
> .LBB0_3:
> 	testl	%eax, %eax // judge again
> 	je	.LBB0_5    // jump to .LBB0_5
> .LBB0_4:
> 	nop
> .LBB0_5:
> 	retq
> 	// omit
> ```
> 
> In the above code, `xx == 0` should be a likely case, but in this case,
> xx has been judged twice.
>
> ...
>
> --- a/include/linux/once_lite.h
> +++ b/include/linux/once_lite.h
> @@ -10,17 +10,17 @@
>  #define DO_ONCE_LITE(func, ...)						\
>  	DO_ONCE_LITE_IF(true, func, ##__VA_ARGS__)
>  
> -#define __ONCE_LITE_IF(condition)					\
> -	({								\
> -		static bool __section(".data..once") __already_done;	\
> -		bool __ret_cond = !!(condition);			\
> -		bool __ret_once = false;				\
> -									\
> -		if (unlikely(__ret_cond && !__already_done)) {		\
> -			__already_done = true;				\
> -			__ret_once = true;				\
> -		}							\
> -		unlikely(__ret_once);					\
> +#define __ONCE_LITE_IF(condition)						\
> +	({									\
> +		static bool __section(".data..once") __already_done;		\
> +		bool __ret_cond = !!(condition);				\
> +		bool __ret_once = false;					\
> +										\
> +		if (unlikely(__ret_cond) && unlikely(!__already_done)) {	\

Sure, !__already_done is unlikely here.

> +			__already_done = true;					\
> +			__ret_once = true;					\
> +		}								\
> +		unlikely(__ret_once);						\

It's a shame you messed with the whitespace.  And I don't think it was
necessary anyway.  Here's what it would have looked like:

--- a/include/linux/once_lite.h~fix-redundant-judgment-in-warn_once-with-clang
+++ a/include/linux/once_lite.h
@@ -16,7 +16,7 @@
 		bool __ret_cond = !!(condition);			\
 		bool __ret_once = false;				\
 									\
-		if (unlikely(__ret_cond && !__already_done)) {		\
+		if (unlikely(__ret_cond) && unlikely(!__already_done)) {\
 			__already_done = true;				\
 			__ret_once = true;				\
 		}							\
_


