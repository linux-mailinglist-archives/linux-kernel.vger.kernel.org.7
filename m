Return-Path: <linux-kernel+bounces-847715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A04BCB7F5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 05:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B4CF14E3273
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 03:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198B5224B0E;
	Fri, 10 Oct 2025 03:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jg+iax1x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7B514F9FB;
	Fri, 10 Oct 2025 03:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760066406; cv=none; b=aHkAkFMY76GzE5rgWX5rnYxwMEM0SwqyZCOi/Pqnbci2XnQF9xSJlRNy7nXvB7fzYOLd+zt6CC7ENEl6f1OyMeNjaxZbPqRCfdKi8zgEGerRa/iCbnGb51ZHptlXzNv1t6eBqLuCII+QmMrIYsjxmd+6BLNsKTb+3Uprw7vM+ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760066406; c=relaxed/simple;
	bh=K+F1pLnxoBoyIplVOpQMk5c4heAtuuz9g32a2ybP/r4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TPN44humllVxiw/aIn7zcnfgnuNC3F/bdVoFGJH6gpJFEd6ceH0Uyq27bDNem7dZuhw3NJ18bae03fihtlGrtxH3cw38dYCwK33rdnk6bckVN+reuNx/2o/S+UUoyrHqDPg3oxKGMTZiNsSeeCs7V/PY6CrLTnfseC3SbWRiXuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jg+iax1x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15E25C4CEE7;
	Fri, 10 Oct 2025 03:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760066406;
	bh=K+F1pLnxoBoyIplVOpQMk5c4heAtuuz9g32a2ybP/r4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jg+iax1xUhqENho73khMqgAvOGP8V2aFjuHXWu4X7C/raqwrP6V6qFwCTZQgohpjN
	 L7VEwphYuSW2a/XcJAILIzwXXvknVzvGRWG3AuMqutC0ZgzdBaALAMQhGrYApyl1qz
	 MCEsSAS2QV2VcjxkdoMeQnGheM456k3HEmGo7cNfKPmv8PB4/1TjE3eaDbffEAMkVy
	 Bkz8TRE9WDR98tdHOPdspixz+CufjXss1C8BLfbc8ujqejo+ggU6OlKbVauU+8HVLh
	 QSnKKif/WaKOJgzGLrUNLFo1BAcmyrNY5pBwooRHOJEyVr5jEBIXTOKkD/LNQXAvdl
	 n/Y6DM+pWOFFw==
Date: Thu, 9 Oct 2025 20:20:01 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>,
	kernel test robot <lkp@intel.com>
Subject: Re: [tip:x86/core 1/1] vmlinux.o: warning: objtool:
 rcar_pcie_probe+0x13e: no-cfi indirect call!
Message-ID: <20251010032001.GA3741500@ax162>
References: <202510092124.O2IX0Jek-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202510092124.O2IX0Jek-lkp@intel.com>

Hi Peter,

On Thu, Oct 09, 2025 at 09:07:02PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
> head:   6c6e6a5416471498d8aafc050110bec9467e4da7
> commit: 6c6e6a5416471498d8aafc050110bec9467e4da7 [1/1] Merge branch 'linus' into x86/core, to resolve conflicts

It appears that this got bisected to the merge because the configuration
has CONFIG_CFI=y, which needs the rename that is in Linus's tree. This
is reproducible with just commit 894af4a1cde6 ("objtool: Validate kCFI
calls") cherry-picked onto 6.17 and CONFIG_CFI_CLANG=y in the config
provided at the link below.

> config: x86_64-buildonly-randconfig-001-20251009 (https://download.01.org/0day-ci/archive/20251009/202510092124.O2IX0Jek-lkp@intel.com/config)
> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251009/202510092124.O2IX0Jek-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202510092124.O2IX0Jek-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> vmlinux.o: warning: objtool: rcar_pcie_probe+0x13e: no-cfi indirect call!

I do see an indirect call in rcar_pcie_probe() with ->host_init_fn() but
rcar_pcie_probe() is not __nocfi... +0x13e is 0x8d9d7e in this build.

    8d9d6f: 31 c0                         xorl    %eax, %eax
    8d9d71: 49 89 86 58 06 00 00          movq    %rax, 0x658(%r14)
    8d9d78: 4c 89 ff                      movq    %r15, %rdi
    8d9d7b: 45 31 db                      xorl    %r11d, %r11d
    8d9d7e: 2e e8 00 00 00 00             callq   0x8d9d84 <rcar_pcie_probe+0x144>
                  00000000008d9d80:  R_X86_64_PLT32       __x86_indirect_thunk_r11-0x4

Is this an issue with the objtool check or is clang not generating the
right code?

Cheers,
Nathan

