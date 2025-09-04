Return-Path: <linux-kernel+bounces-801686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C83B448C6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 23:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79C5D17D04E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 21:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424D92620D2;
	Thu,  4 Sep 2025 21:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFCqVeCB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8735D242D8B;
	Thu,  4 Sep 2025 21:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757022396; cv=none; b=T1TQkLZaiN7BlVFELkCHSwTKXCUTU6CuGfGlnYQxwBxINJXbLL0Ta4iRmVtqF7gku2ajzUZJJdD9b8EhGtQRs+jawsfBVyAUpxHH+GxEC1JGeRHdkufVP9nRvFQZU0SRgZdiM1CiphIpXNCQzI5JBKaNUvIm7wVatbXRCyo3opE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757022396; c=relaxed/simple;
	bh=4fJ9zZxsC1MqR01ZLfdpGSY+0DIm1cCw5C2znm5oqqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k5M7OwUvMrrM0FaZFRZv83zTmB39c+EKaNEbkBUO0pqnEBCCYlvRoH3/ZfvRt2UnQM32zI80QKbyPt+Ag6gNUhQ5Ox1pyR2wLl0O/ozhHqVtcJx54NBVanf4tyNsPRO2QDrcyHJ0DQNpm1hSrpZ462iInmE6aQ2eNi7LgS1Dd8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFCqVeCB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D175C4CEF0;
	Thu,  4 Sep 2025 21:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757022396;
	bh=4fJ9zZxsC1MqR01ZLfdpGSY+0DIm1cCw5C2znm5oqqA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UFCqVeCBJ0dLeTOx1GMqDQ+GAP0IjUfn+Zy0XxOiQzSs7ST8/8JfjnWQUmMOm8Ljz
	 cPJj4lFf67aIF3nw9IMhOY+5g4Nb6REnbujfyOk/G5x3k4Y3/5enbqYRG26dxDEJsC
	 /36kwn8F8NyBoICp2R0CyxePKdsOxJ/g8QG07fHJPnZbWQGRVzfbiLO8rnfKo4hHlN
	 0T9VaOyrPCdNOH4IgNXlov3AM/YkBE6yhiMobFwFjtinHtjgSCu+v4pfPcMtNo8TDZ
	 IMK4MKrrpsy+xrf8mJHkay/ivPb3kztgsaVmrFnz2EcFseIBllq97SCH9D5vFYvUR/
	 vj1cE/QvgOVGg==
Date: Thu, 4 Sep 2025 14:46:33 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Peter Zijlstra <peterz@infradead.org>, Nathan Chancellor <nathan@kernel.org>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] objtool/LoongArch: Fix unreachable instruction
 warnings about EFISTUB
Message-ID: <4thrzifl6ntk7kdf65egt4srzkbrxqoqf7yzmasblwvaq3qwmt@vigfgpbxzjkq>
References: <20250901072156.31361-1-yangtiezhu@loongson.cn>
 <20250901072156.31361-3-yangtiezhu@loongson.cn>
 <20250901081904.GB4067720@noisy.programming.kicks-ass.net>
 <82c913b9-4403-cde9-0542-5bd6e04415f5@loongson.cn>
 <wt4qpgi5isj5m6wq33pomvm6borvafuzktekc7lgtoitscar5q@brixzj3lccbw>
 <ccbb40c1-5f2d-77e9-e8d2-52f2fdbad645@loongson.cn>
 <CAAhV-H5qhKepa-8sz3_AC=_RCChbVeEmnHKESMqpiJ0phMORbg@mail.gmail.com>
 <52056c29-4f21-83c9-db1f-ebd1875a3675@loongson.cn>
 <CAAhV-H47VKERJCKRi7uAS7OmCWaE4yxZ07Hwz_si2DMVRDrsag@mail.gmail.com>
 <ybv2ndrzbqztkctzwhfphpdqrqbxlougs75glm22rcuzdmnrfp@lqwcms3j2d55>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ybv2ndrzbqztkctzwhfphpdqrqbxlougs75glm22rcuzdmnrfp@lqwcms3j2d55>

On Thu, Sep 04, 2025 at 10:39:30AM -0700, Josh Poimboeuf wrote:
> On Thu, Sep 04, 2025 at 11:59:30AM +0800, Huacai Chen wrote:
> > This is from RISC-V code.
> > 
> > __HEAD
> > SYM_CODE_START(_start)
> >         /*
> >          * Image header expected by Linux boot-loaders. The image header data
> >          * structure is described in asm/image.h.
> >          * Do not modify it without modifying the structure and all bootloaders
> >          * that expects this header format!!
> >          */
> > #ifdef CONFIG_EFI
> >         /*
> >          * This instruction decodes to "MZ" ASCII required by UEFI.
> >          */
> >         c.li s4,-13
> >         j _start_kernel
> > #else
> >         /* jump to start kernel */
> >         j _start_kernel
> >         /* reserved */
> >         .word 0
> > #endif
> > 
> > The HEAD section has instructions, if you change it into a data
> > section then it loses the "x" attribute.

Actually, the "x" attribute isn't needed for vmlinux.  The vmlinux
linker script places it in the text region regardless.

Moving the data to a data section should be really simple, something
like the below.

And yes, even the above RISC-V code can be in a data section.  Those
instructions are part of the 'struct riscv_image_header' data structure.

diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
index e3865e92a917a..c42500d9fad81 100644
--- a/arch/loongarch/kernel/head.S
+++ b/arch/loongarch/kernel/head.S
@@ -17,7 +17,7 @@
 
 #include "efi-header.S"
 
-	__HEAD
+	__HEADDATA
 
 _head:
 	.word	IMAGE_DOS_SIGNATURE	/* "MZ", MS-DOS header */
diff --git a/arch/loongarch/kernel/vmlinux.lds.S b/arch/loongarch/kernel/vmlinux.lds.S
index 08ea921cdec16..fc35ef349aba6 100644
--- a/arch/loongarch/kernel/vmlinux.lds.S
+++ b/arch/loongarch/kernel/vmlinux.lds.S
@@ -38,6 +38,7 @@ SECTIONS
 	. = VMLINUX_LOAD_ADDRESS;
 
 	_text = .;
+	HEAD_DATA_SECTION
 	HEAD_TEXT_SECTION
 
 	. = ALIGN(PECOFF_SEGMENT_ALIGN);
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 6b2311fa41393..c74492e1baa5a 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -629,6 +629,11 @@
 		*(.static_call.text)					\
 		__static_call_text_end = .;
 
+#define HEAD_DATA_SECTION						\
+	.head.data : AT(ADDR(.head.data) - LOAD_OFFSET) {		\
+		KEEP(*(.head.data))					\
+	}
+
 /* Section used for early init (in .S files) */
 #define HEAD_TEXT  KEEP(*(.head.text))
 
diff --git a/include/linux/init.h b/include/linux/init.h
index 331886205049e..fcb02ab3faae2 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -98,6 +98,7 @@
 
 /* For assembly routines */
 #define __HEAD		.section	".head.text","ax"
+#define __HEADDATA	.section	".head.data","aw"
 #define __INIT		.section	".init.text","ax"
 #define __FINIT		.previous
 


