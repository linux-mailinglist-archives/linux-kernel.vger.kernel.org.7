Return-Path: <linux-kernel+bounces-739787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F79AB0CAEE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 21:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F16154345A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 19:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9A622B5A5;
	Mon, 21 Jul 2025 19:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mDWcs8/F"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D82222585
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 19:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753125616; cv=none; b=iDxJ1B47zFHzdboP2bymWVKjTqeGP8FzpTydbpw8o6q2hEye953gACIiGb+tSMylsIeROyZ1B/NYALLbKFuRphZc0kE3UAdC5A1cvuHjMhQ4skKc/ktsfdU6JZD69F3D776NRj4rjouPZdmdyfovsd1EMB0vajfKoRuYJJos4Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753125616; c=relaxed/simple;
	bh=xhtisyzoBwlNkJmQTCOxXemXyPJVKO0cr138G02nRhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oERhk1uorxrZ3EcPzTdFxyeHjiE52pp2/1K06SJxg+BC8vQad2Me2A0FmPQBzpxmpGzQB2J/UDKyOvUkP/n25GjaBmJISVPeyY9AfAwPUIGWEptnoJ30lEvx5me3+BJLpnogTTLf5BV9NmJLawteFwD4X4LWTEz4UqkGfBpXbVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mDWcs8/F; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753125615; x=1784661615;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xhtisyzoBwlNkJmQTCOxXemXyPJVKO0cr138G02nRhs=;
  b=mDWcs8/FkL8N1dbVPMqGcU56H+Yumi756YkiM0Ybq0Gz9/jEKOt6HsIM
   UIqZ5Ng3Pmz3Tt40+A5+5jLssHi33E+0UclucUnX+QIhadpCyEFHfTSOW
   y2gI5+6YYKkxa97M8U9NjKcUPIIVqGddlkbX9O+XGhkEvWPEv3W40p1Kg
   qHpIuSXrLBdROiuAeV5k69D+NIXTteBFIXlc5bTXEcG+a2f2dGiqTBicZ
   N60E5XLhlVYBNEm5ts1V22ZagciZepVFJr4JdQeXGXs1fVHQSD5LPG0Je
   /McRwItST08HDJEVcQRy6ZXeMibYKCtBg5DipAHStj193b+xEBOKyZvso
   A==;
X-CSE-ConnectionGUID: GC8i0BeUSWSe4pPl9GI5TA==
X-CSE-MsgGUID: Do5Kg7W5TeiNezUufunDnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="59011199"
X-IronPort-AV: E=Sophos;i="6.16,329,1744095600"; 
   d="scan'208";a="59011199"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 12:20:11 -0700
X-CSE-ConnectionGUID: hO1DNSXTSjCb4IeSVxltNg==
X-CSE-MsgGUID: xMZ/FCWPSF+/+cH+xkHUgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,329,1744095600"; 
   d="scan'208";a="189905963"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 21 Jul 2025 12:20:09 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1udw3S-000H6H-12;
	Mon, 21 Jul 2025 19:20:06 +0000
Date: Tue, 22 Jul 2025 03:19:36 +0800
From: kernel test robot <lkp@intel.com>
To: Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	WANG Xuerui <kernel@xen0n.name>, Xi Ruoyao <xry111@xry111.site>,
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] LoongArch: Implement physical address with ELF
 program header
Message-ID: <202507220309.mDl9W32Y-lkp@intel.com>
References: <20250721091248.3896152-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721091248.3896152-1-maobibo@loongson.cn>

Hi Bibo,

kernel test robot noticed the following build errors:

[auto build test ERROR on 89be9a83ccf1f88522317ce02f854f30d6115c41]

url:    https://github.com/intel-lab-lkp/linux/commits/Bibo-Mao/LoongArch-Implement-physical-address-with-ELF-program-header/20250721-171418
base:   89be9a83ccf1f88522317ce02f854f30d6115c41
patch link:    https://lore.kernel.org/r/20250721091248.3896152-1-maobibo%40loongson.cn
patch subject: [PATCH v2] LoongArch: Implement physical address with ELF program header
config: loongarch-allnoconfig (https://download.01.org/0day-ci/archive/20250722/202507220309.mDl9W32Y-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 853c343b45b3e83cc5eeef5a52fc8cc9d8a09252)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250722/202507220309.mDl9W32Y-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507220309.mDl9W32Y-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:15: symbol not found: PHYS_OFFSET
   ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:18: symbol not found: PHYS_OFFSET
   ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:33: symbol not found: PHYS_OFFSET
   ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:34: symbol not found: PHYS_OFFSET
   ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:41: symbol not found: PHYS_OFFSET
   ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:46: symbol not found: PHYS_OFFSET
   ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:47: symbol not found: PHYS_OFFSET
   ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:50: symbol not found: PHYS_OFFSET
   ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:57: symbol not found: PHYS_OFFSET
   ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:57: symbol not found: PHYS_OFFSET
   ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:57: symbol not found: PHYS_OFFSET
   ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:57: symbol not found: PHYS_OFFSET
   ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:57: symbol not found: PHYS_OFFSET
   ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:57: symbol not found: PHYS_OFFSET
   ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:57: symbol not found: PHYS_OFFSET
   ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:57: symbol not found: PHYS_OFFSET
   ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:57: symbol not found: PHYS_OFFSET
   ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:57: symbol not found: PHYS_OFFSET
   ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:57: symbol not found: PHYS_OFFSET
   ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:57: symbol not found: PHYS_OFFSET
   ld.lld: error: too many errors emitted, stopping now (use --error-limit=0 to see all errors)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

