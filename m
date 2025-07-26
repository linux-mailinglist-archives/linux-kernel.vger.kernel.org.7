Return-Path: <linux-kernel+bounces-746605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 239D2B128E9
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 06:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4A7FAC4055
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 04:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3121EE02F;
	Sat, 26 Jul 2025 04:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A+CyyZTE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED78717DFE7
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 04:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753502588; cv=none; b=kR2U5SLS+o85f3Z9HFEGOAE8h5y3K1p4Y7pdU3rNsmuh3x+wF3ZViMFBUgxnVNUmesKTvUY+EkRXxTfbMdG4QTXmTPZBmDnPRf73w/ApNPVKafb0wBz5jIpLlHgjIXTn0vacFJCEW40ZgibRC0FghvkeNRevcKSXXiFXW5o+zhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753502588; c=relaxed/simple;
	bh=8g9wBziPTXpobyegEW+LeGkkwHu3p3rZSG4ABGAja8w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RZ1MOwCtzSytB5+6JYzywwTcAGtegb5LxuhAal1h2JdxDPQh1NuNQKa2DpsGdq4Ih0c2LFj6PG0/yU/bXkaUPEv8/NCurtNJ37NBgN1qZET+DL2HoceFjSa2Wmo6z0KsL1VwzZgG5iNgBXuIrHI8zpIXi1WpeRt+jFZoMXIZ9ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A+CyyZTE; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753502587; x=1785038587;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8g9wBziPTXpobyegEW+LeGkkwHu3p3rZSG4ABGAja8w=;
  b=A+CyyZTEosnEUBC3Vn1ouFoU9L6PttYg9L2D0NizVflTBegXYANCECM8
   nMv3So5rM2fUVaClQ8F6ngGgXmJGq3Ji2IJhLnGh7jnRwvULtkzazX2u5
   QuQiVTz54+A5zroD0dY3KBg8glcS8xvxShJVK+RmJRWyAyIkZ+1v8Cjms
   vIOEj71Sy16KhhME3tCGjYqEA2Y+zd7RxMc3injIfZgr613A/ienCWflU
   NEWHdbDPiB5t8GxhymG1osTebSbqZcoYOGCmlCknetBwVCpKkZXPbd1fB
   ezlEAoTQ0HwsoS+GarW+TRnfrJIcChIqk8+/AvO1kgVTKCWQ7PyAoEuBa
   g==;
X-CSE-ConnectionGUID: VS6OFrQSSbS9IwYIMBgK6g==
X-CSE-MsgGUID: FiDh0XPbT1GB7BMcVsM6vw==
X-IronPort-AV: E=McAfee;i="6800,10657,11503"; a="54918185"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="54918185"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2025 21:03:06 -0700
X-CSE-ConnectionGUID: o8nxA3hnTdKFvNJ/4V72eg==
X-CSE-MsgGUID: ZQtdXkKgTPO1oOlQBNUPJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="192281319"
Received: from igk-lkp-server01.igk.intel.com (HELO b3b7d4258b7c) ([10.91.175.65])
  by fmviesa001.fm.intel.com with ESMTP; 25 Jul 2025 21:03:05 -0700
Received: from kbuild by b3b7d4258b7c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ufW7i-0000Dr-1i;
	Sat, 26 Jul 2025 04:03:02 +0000
Date: Sat, 26 Jul 2025 06:02:04 +0200
From: kernel test robot <lkp@intel.com>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>
Subject: lib/bch.o: warning: objtool: find_poly_roots+0x5ac: sibling call
 from callable instruction with modified stack frame
Message-ID: <202507260646.q8oawNxL-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5f33ebd2018ced2600b3fad2f8e2052498eb4072
commit: e20ab7d454ee8d1e0e8b9ff73a7c87e84c666b2f LoongArch: Enable jump table for objtool
date:   5 months ago
config: loongarch-randconfig-2004-20250726 (https://download.01.org/0day-ci/archive/20250726/202507260646.q8oawNxL-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project b4edd827e4f71c2a0fcb13f79de7eae4545f0aea)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250726/202507260646.q8oawNxL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507260646.q8oawNxL-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> lib/bch.o: warning: objtool: find_poly_roots+0x5ac: sibling call from callable instruction with modified stack frame
--
   drivers/input/touchscreen/mms114.c:507:15: warning: cast to smaller integer type 'enum mms_type' from 'const void *' [-Wvoid-pointer-to-enum-cast]
     507 |         data->type = (enum mms_type)match_data;
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.
>> drivers/input/touchscreen/mms114.o: warning: objtool: mms114_start+0xb4: sibling call from callable instruction with modified stack frame
--
   drivers/char/applicom.c:130:25: warning: variable 'byte_reset_it' set but not used [-Wunused-but-set-variable]
     130 |         volatile unsigned char byte_reset_it;
         |                                ^
   drivers/char/applicom.c:542:6: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
     542 |         int ret = 0;
         |             ^
   drivers/char/applicom.c:705:25: warning: variable 'byte_reset_it' set but not used [-Wunused-but-set-variable]
     705 |         volatile unsigned char byte_reset_it;
         |                                ^
   3 warnings generated.
>> drivers/char/applicom.o: warning: objtool: ac_ioctl+0x104: sibling call from callable instruction with modified stack frame
--
   drivers/video/fbdev/matrox/g450_pll.c:410:18: warning: variable 'mnp' set but not used [-Wunused-but-set-variable]
     410 |                                 unsigned int mnp;
         |                                              ^
   1 warning generated.
>> drivers/video/fbdev/matrox/g450_pll.o: warning: objtool: matroxfb_g450_setpll_cond+0x58: sibling call from callable instruction with modified stack frame
>> drivers/video/fbdev/matrox/g450_pll.o: warning: objtool: matroxfb_g450_setclk+0x98: sibling call from callable instruction with modified stack frame
>> drivers/video/fbdev/matrox/g450_pll.o: warning: objtool: g450_testpll+0x48: sibling call from callable instruction with modified stack frame
--
   drivers/media/i2c/adv7604.c:432:19: warning: unused function 'cec_write_clr_set' [-Wunused-function]
     432 | static inline int cec_write_clr_set(struct v4l2_subdev *sd, u8 reg, u8 mask,
         |                   ^~~~~~~~~~~~~~~~~
   1 warning generated.
>> drivers/media/i2c/adv7604.o: warning: objtool: read_stdi+0x3e4: sibling call from callable instruction with modified stack frame
>> drivers/media/i2c/adv7604.o: warning: objtool: adv76xx_set_edid+0x260: sibling call from callable instruction with modified stack frame
>> drivers/media/i2c/adv7604.o: warning: objtool: adv76xx_debugfs_if_read+0xc0: sibling call from callable instruction with modified stack frame
>> drivers/media/i2c/adv7604.o: warning: objtool: adv76xx_s_ctrl+0x64: sibling call from callable instruction with modified stack frame

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

