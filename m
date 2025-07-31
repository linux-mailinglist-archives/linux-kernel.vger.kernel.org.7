Return-Path: <linux-kernel+bounces-752004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 392F3B17035
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 13:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FEBA582E39
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 11:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B312BE7C3;
	Thu, 31 Jul 2025 11:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pjqji8MA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B5C2BE7AA
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 11:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753960408; cv=none; b=Klsl8XaXhN6Ia968rtyNDZgshVXxnJrgdNyZ+Ujfg3O8n7B3/OgTrQrwkjI3hgUlgXjb2Co7LZJJcwjxiacTRgE84DkJneyI9YUv3UXEydjspKh861RIaGC47fEp3fw5A8F1LjRg7A65HXkTZXd+EkN+UpHdoXlaA2NAcDj1/rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753960408; c=relaxed/simple;
	bh=kx4tatmOXZadoNA7n/vqbsqBPVytJHHMhMmrz9Tv+tU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fO9jvz2lKBzTy6Z1uWICghQDRRqIYhxbfUfKqlRXT2e0N1TvDh+G81PuNW35kjj8v6OBi/keqpsZDwDSNjGkM4Zp8eGmgbEb+AcE8el93wR+dHcG/BioObrA8+rsLvlVeBXGL0NGUGj0iZGmT57t7W+TJA8zKn3NHDFB+s3PZuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pjqji8MA; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753960407; x=1785496407;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kx4tatmOXZadoNA7n/vqbsqBPVytJHHMhMmrz9Tv+tU=;
  b=Pjqji8MATPcaUUwKXYu91tW3ncsZCCsxo5JQR49KqtwzjifzcpnBAxCV
   hxTCFTKpUY1yc2tdl3M2XLeZqUKl+f3u6Kf81Zf/Br229//HadRCMFl0P
   hSOgoWoBb94p0vsCfPxnG1RiyBGZ+64Rc/aH87xd2GKXUVaixuT914atf
   4UCGmdGXXuX8kv2mzpwtPo2wLC2aJ+bUDR/emhqGST6KjE/S7ROGngo36
   nDNxEfEqTNRjD0SzFHl58vSm/BS4UOIt6YYfkfhi/panUK8rg499OJ+ZT
   WRao27DXp+QMCHJG0vCHPo8xO9wUkdXlvztgH8ARHjjy+zKOROOJcPNyV
   w==;
X-CSE-ConnectionGUID: mGFrAk6ZTv6YHH35hgyUyg==
X-CSE-MsgGUID: 9xusVRfGRcKEVCJ1rC+x7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="56425340"
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; 
   d="scan'208";a="56425340"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2025 04:13:26 -0700
X-CSE-ConnectionGUID: 0Lmg/DriSiGnbha1pNI4xg==
X-CSE-MsgGUID: oKmtCER1TD+4HGUEAPm9oA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; 
   d="scan'208";a="163682561"
Received: from igk-lkp-server01.igk.intel.com (HELO b3b7d4258b7c) ([10.91.175.65])
  by fmviesa008.fm.intel.com with ESMTP; 31 Jul 2025 04:13:24 -0700
Received: from kbuild by b3b7d4258b7c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uhRDu-00011H-0d;
	Thu, 31 Jul 2025 11:13:22 +0000
Date: Thu, 31 Jul 2025 13:12:44 +0200
From: kernel test robot <lkp@intel.com>
To: David Woodhouse <dwmw@amazon.co.uk>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
Subject: vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x13e: relocation to
 !ENDBR: machine_kexec_prepare+0x4a4
Message-ID: <202507311329.eIZjdKU0-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   260f6f4fda93c8485c8037865c941b42b9cba5d2
commit: 6a750b4c009936f352aaac0366f5f10fcf51e81b x86/kexec: Copy control page into place in machine_kexec_prepare()
date:   8 months ago
config: x86_64-buildonly-randconfig-2004-20250731 (https://download.01.org/0day-ci/archive/20250731/202507311329.eIZjdKU0-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250731/202507311329.eIZjdKU0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507311329.eIZjdKU0-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x13e: relocation to !ENDBR: machine_kexec_prepare+0x4a4

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

