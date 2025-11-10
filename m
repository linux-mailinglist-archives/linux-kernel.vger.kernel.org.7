Return-Path: <linux-kernel+bounces-894097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D28C1C49470
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 21:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 956A14EEE63
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 20:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540102F12AF;
	Mon, 10 Nov 2025 20:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BSaSLsrL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946652EC55D
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 20:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762807298; cv=none; b=q83x7nbBi962VtEQ980QrDpPduYW8wXFu9xWb72PXIsGQKJvROeYUp8E8OUNc/HRGtFZSwwry+NhhPQJNm4E9Y/eZjZVnR3YUobM+N6ZYYvoIrdPy1y2gKfKgDQ5mFLWr3O8FIpV5AuS7aKAafLDFJmonW9kYHzT07q18DAua/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762807298; c=relaxed/simple;
	bh=W2NlGSaN/DO6Yj79YN5GVEnS2mME/PCSM9o39rbQi1g=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=EnRhDBnXHp/cIqsB5c8XHYlsqP26IYGu/uLlGn3RtUggYKS9blfkKIFW7ZG15Oul5Jb5AQyA7txSUogYXx4PzaLkCmxI7yQEeQJjLdcslBzKG8DyUOUYvsTb0xMgpZik7BWtFMDflMCzkExO5G9XDAbylt7IPeMZLYOCstbEAI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BSaSLsrL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBF22C4CEFB;
	Mon, 10 Nov 2025 20:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762807298;
	bh=W2NlGSaN/DO6Yj79YN5GVEnS2mME/PCSM9o39rbQi1g=;
	h=Date:From:To:cc:Subject:From;
	b=BSaSLsrLmr8NwXa28hPOAXE0zfYmiVMc3mAF7XO8kbQQemm9evXDGdERfrDAoJmwz
	 KqVI5M0ZJvpzosPdJlhMKRDcTMqcwnOKhS6kv1CUwEyDaKijhiyWTi5/ShQ0DBCSm7
	 eN9hmGrI7hrI3XfK6POZK0xMw1npSCuzatUkRQ63IFRlT4UbHKQ87o1IjHbSeTVOIc
	 wB/cZKbRR4XDd27H4DxLzj8oNDclgRNAq9SBtmlQ3zGLmRaF3qGvXL1gI6dj5Dl/bI
	 KPr/6JUKtOKAbzd9bzIQac7XVbIbXfmt3+VUqTU94mAB5nnjM30RpntN49MSvbSVvr
	 LGRLjkv/ud+fA==
Date: Mon, 10 Nov 2025 13:41:32 -0700 (MST)
From: Paul Walmsley <pjw@kernel.org>
To: torvalds@linux-foundation.org
cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] RISC-V updates for v6.18-rc6
Message-ID: <a7d159e4-8e75-e4be-4405-f10fee270664@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Linus,

The following changes since commit 225a97d6d45456a7627633da09cb842a43ef1b85:

  Merge tag 'riscv-for-linus-6.18-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux (2025-11-06 15:44:18 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux tags/riscv-for-linus-6.18-rc6

for you to fetch changes up to dc20452e6caf962f04ede7f364267b0c37784ab4:

  riscv: Fix CONFIG_AS_HAS_INSN for new .insn usage (2025-11-07 17:39:07 -0700)


- Paul
----------------------------------------------------------------
RISC-V updates for v6.18-rc6

RISC-V updates for v6.18-rc6, including:

- A fix for a commit in v6.18-rc5 that broke the build on clang
  versions earlier than 19 and binutils versions earlier than 2.38.
  (This exposed that we're not properly testing earlier toolchain
  versions in our linux-next builds and PR submissions.  This was
  fixed for this PR, and is being addressed more generally for -next
  builds.)

- A fix to remove some redundant Makefile code

- A fix to avoid building Canaan Kendryte K210-specific code on targets
  that don't build for the K210

----------------------------------------------------------------
Feng Jiang (2):
      riscv: Build loader.bin exclusively for Canaan K210
      riscv: Remove redundant judgment for the default build target

Nathan Chancellor (1):
      riscv: Fix CONFIG_AS_HAS_INSN for new .insn usage

 arch/riscv/Kconfig  |  2 +-
 arch/riscv/Makefile | 17 +----------------
 2 files changed, 2 insertions(+), 17 deletions(-)


vmlinux size differences in bytes (from 225a97d6d454):
     text     data     bss       dec      hex filename                             
        .        .       .         .        . vmlinux.defconfig.gcc-15             
        .        .       .         .        . vmlinux.nosmp_defconfig.gcc-15       
        .        .       .         .        . vmlinux.rv32_defconfig.gcc-15        
        .        .       .         .        . vmlinux.rv32_nosmp_defconfig.gcc-15  
        .        .       .         .        . vmlinux.nommu_virt_defconfig.gcc-15  
        .        .       .         .        . vmlinux.defconfig.clang-20           
        .        .       .         .        . vmlinux.nosmp_defconfig.clang-20     
        .        .       .         .        . vmlinux.rv32_defconfig.clang-20      
        .        .       .         .        . vmlinux.rv32_nosmp_defconfig.clang-20
        .        .       .         .        . vmlinux.nommu_virt_defconfig.clang-20
        .        .       .         .        . vmlinux.defconfig.gcc-14             
        .        .       .         .        . vmlinux.nosmp_defconfig.gcc-14       
        .      -32       .       -32      -20 vmlinux.rv32_defconfig.gcc-14        
        .        .       .         .        . vmlinux.rv32_nosmp_defconfig.gcc-14  
        .        .       .         .        . vmlinux.nommu_virt_defconfig.gcc-14  
        .        .       .         .        . vmlinux.defconfig.clang-19           
        .        .       .         .        . vmlinux.nosmp_defconfig.clang-19     
        .        .       .         .        . vmlinux.rv32_defconfig.clang-19      
        .        .       .         .        . vmlinux.rv32_nosmp_defconfig.clang-19
        .        .       .         .        . vmlinux.nommu_virt_defconfig.clang-19
        .        .       .         .        . vmlinux.defconfig.gcc-13             
        .        .       .         .        . vmlinux.nosmp_defconfig.gcc-13       
        .        .       .         .        . vmlinux.rv32_defconfig.gcc-13        
        .        .       .         .        . vmlinux.rv32_nosmp_defconfig.gcc-13  
        .        .       .         .        . vmlinux.nommu_virt_defconfig.gcc-13  
+13049482 +6347237 +424189 +19820908 +12e716c vmlinux.defconfig.clang-18 [*]          
+12001864 +6160481 +409589 +18571934 +11b629e vmlinux.nosmp_defconfig.clang-18 [*]    
+12120907 +4807041 +312865 +17240813 +10712ed vmlinux.rv32_defconfig.clang-18 [*]     
+11098066 +4628736 +300841 +16027643  +f48ffb vmlinux.rv32_nosmp_defconfig.clang-18 [*]
 +2775790  +760720 +123053  +3659563  +37d72b vmlinux.nommu_virt_defconfig.clang-18 [*]
        .        .       .         .        . vmlinux.defconfig.gcc-12             
        .        .       .         .        . vmlinux.nosmp_defconfig.gcc-12       
        .        .       .         .        . vmlinux.rv32_defconfig.gcc-12        
        .        .       .         .        . vmlinux.rv32_nosmp_defconfig.gcc-12  
        .        .       .         .        . vmlinux.nommu_virt_defconfig.gcc-12  
+13213594 +6340137 +424189 +19977920 +130d6c0 vmlinux.defconfig.clang-17 [*]          
+12131260 +6153709 +409589 +18694558 +11d419e vmlinux.nosmp_defconfig.clang-17 [*]     
+12252639 +4800965 +312865 +17366469 +108fdc5 vmlinux.rv32_defconfig.clang-17 [*]     
+11211650 +4621836 +300841 +16134327  +f630b7 vmlinux.rv32_nosmp_defconfig.clang-17 [*]
 +2797158  +770580 +123053  +3690791  +385127 vmlinux.nommu_virt_defconfig.clang-17 [*]
        .        .       .         .        . vmlinux.defconfig.gcc-11             
        .        .       .         .        . vmlinux.nosmp_defconfig.gcc-11       
        .      -32       .       -32      -20 vmlinux.rv32_defconfig.gcc-11        
        .      -32       .       -32      -20 vmlinux.rv32_nosmp_defconfig.gcc-11  
        .        .       .         .        . vmlinux.nommu_virt_defconfig.gcc-11  
        .        .       .         .        . vmlinux.allnoconfig.gcc-14           
        .        .       .         .        . vmlinux.allmodconfig.gcc-14          
        .        .       .         .        . vmlinux.allnoconfig.clang-19         
        .        .       .         .        . vmlinux.allmodconfig.clang-19

[*] Build was broken before this patch series


