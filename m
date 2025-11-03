Return-Path: <linux-kernel+bounces-883230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F9AC2CD0B
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 16:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8342463D4D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 15:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A6B314D1A;
	Mon,  3 Nov 2025 15:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u8Ixw7Qz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F95285CA9;
	Mon,  3 Nov 2025 15:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762183407; cv=none; b=GNHbwgyKjQ57c0Z6wsRaEBSoqeLKwRr3TUJmICv7Vd8//1KaSaDPpiBLT8Caqag7pgCd00iOeavBOibrTHcHgt33fOTIfqsWj8weDhp4JwQJJCt+gwI7FXf4NlaBmWvPZQKviQ+UncGvMbpBziDyX0dMJJremT1WlN0rP1Kqds4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762183407; c=relaxed/simple;
	bh=kIWzAKGdirbiXBghviLQ5LnqCOau6rBjIUixRYcumKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XuUSpufZTuZ2bjemVBkx/cN7EJttJ3gVWJxzf2/sSJ2MeEK8wXTpyRPHdQXcXq5JZ4C217bZpppiCNh9h/hEQkzUKwaOCaPN/EXQ8gcAhdhjp4zCtqSlBYJcK/ade0fhp8rI9als++fyRJf9ijZ/vEFRV/+j4iwpS+1xnrBToT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u8Ixw7Qz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39D42C4CEE7;
	Mon,  3 Nov 2025 15:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762183406;
	bh=kIWzAKGdirbiXBghviLQ5LnqCOau6rBjIUixRYcumKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u8Ixw7Qznx8hyu6aaY6i1Lrihh8RXxMDbgiTbtZMPTnZ1UL58P+ngvVHC+wlAo0eS
	 Et9yoTK2GKlEZzH20wAE8M8MQX9ky6t/O65NUNv6T4W9/o7aNQ4DMU0qkjXO1wMJ3M
	 3rlVM5liPNm/B+IlxxAeMQJSlSrUK4RMhYM1YrPcR9Gni/oP+jhzC0e51RmO/9hmzJ
	 NgN6X6UPyvpqAVtY++oVicB+dsDcCFzfQqpKg45lJ/g244w/69z6T79lElCGZUnCaZ
	 GfdkHB7TJ3nK9ZbzeG4OCRZSY+mZ/m2fplX5EdA58jCV0EGZnXoorQD59x98ObpfID
	 bmwsVoP5r8IvQ==
Date: Mon, 3 Nov 2025 15:23:21 +0000
From: Lee Jones <lee@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Lukas Bulwahn <lbulwahn@redhat.com>,
	Samuel Kayode <samuel.kayode@savoirfairelinux.com>,
	imx@lists.linux.dev, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, Frank Li <Frank.Li@nxp.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Sean Nyekjaer <sean@geanix.com>, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: adjust file entry in NXP PF1550 PMIC MFD
 DRIVER
Message-ID: <20251103152321.GA8064@google.com>
References: <20251029104228.95498-1-lukas.bulwahn@redhat.com>
 <202511011641.mVLMVN8V-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202511011641.mVLMVN8V-lkp@intel.com>

On Sat, 01 Nov 2025, kernel test robot wrote:

> Hi Lukas,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on next-20251029]
> [cannot apply to lee-leds/for-leds-next linus/master v6.18-rc3 v6.18-rc2 v6.18-rc1 v6.18-rc3]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Lukas-Bulwahn/MAINTAINERS-adjust-file-entry-in-NXP-PF1550-PMIC-MFD-DRIVER/20251029-184717
> base:   next-20251029
> patch link:    https://lore.kernel.org/r/20251029104228.95498-1-lukas.bulwahn%40redhat.com
> patch subject: [PATCH] MAINTAINERS: adjust file entry in NXP PF1550 PMIC MFD DRIVER
> config: powerpc-randconfig-002-20251101 (https://download.01.org/0day-ci/archive/20251101/202511011641.mVLMVN8V-lkp@intel.com/config)
> compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project d1c086e82af239b245fe8d7832f2753436634990)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251101/202511011641.mVLMVN8V-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202511011641.mVLMVN8V-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
> >> ld.lld: error: relocation R_PPC_ADDR16_HI cannot be used against symbol 'init_task'; recompile with -fPIC
>    >>> defined in vmlinux.a(init/init_task.o)
>    >>> referenced by head_85xx.S:222 (arch/powerpc/kernel/head_85xx.S:222)
>    >>>               arch/powerpc/kernel/head_85xx.o:(.head.text+0x41a) in archive vmlinux.a
> --
> >> ld.lld: error: relocation R_PPC_ADDR16_LO cannot be used against symbol 'init_task'; recompile with -fPIC
>    >>> defined in vmlinux.a(init/init_task.o)
>    >>> referenced by head_85xx.S:223 (arch/powerpc/kernel/head_85xx.S:223)
>    >>>               arch/powerpc/kernel/head_85xx.o:(.head.text+0x41e) in archive vmlinux.a
> --
> >> ld.lld: error: relocation R_PPC_ADDR16_HI cannot be used against symbol 'init_thread_union'; recompile with -fPIC
>    >>> defined in ./arch/powerpc/kernel/vmlinux.lds:146
>    >>> referenced by head_85xx.S:230 (arch/powerpc/kernel/head_85xx.S:230)
>    >>>               arch/powerpc/kernel/head_85xx.o:(.head.text+0x42a) in archive vmlinux.a

What is all of this nonsense?

> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

-- 
Lee Jones [李琼斯]

