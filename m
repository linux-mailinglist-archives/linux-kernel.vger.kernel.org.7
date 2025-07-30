Return-Path: <linux-kernel+bounces-750423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDEBDB15B22
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 11:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C0C23B504B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 09:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8AB8259CBB;
	Wed, 30 Jul 2025 09:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B2N73Rwe"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3251824BBE1
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 09:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753866038; cv=none; b=S46XVFYa/XDNy+sWcUQY9DVtd4GT5OxgIcQqOqwbM6KdxO46qfOytiPwnz2sP5a4vXZCGJW+oR/dtk4D5EuMamPKAY6bUYZjD/T0WaaD2qisY+S5Vtc4e5d1b16WeC9xZBgVsCooVoTrxnGi8S1mXQYmOYTgdBUYWkNaq4x/uTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753866038; c=relaxed/simple;
	bh=PX2aMQu5ojJ+aZgD2xm/DKVhnSsFX2hl6uxgS/GWr1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RqN/g8WVnQopQGuAKtZTNBhvIKYB/J1EkoEDLBIw0YGbu32y2svng+Ciyesd4RhEdVnzxfkxpPdQlp2pMWfhqWpy81SQSpaKPztYJ8P3L1HmaLhsNf75C9u8jNG9k+mniIDCnG5HdidxLIYDoBLTM+SiJaD+8mAo9YrvuOoO/3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B2N73Rwe; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753866036; x=1785402036;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PX2aMQu5ojJ+aZgD2xm/DKVhnSsFX2hl6uxgS/GWr1Y=;
  b=B2N73RwexxP1UXDh0Mm92dnzVhw/rtzOGTPjLn9kdjt+4i3SwS8ezDDv
   /hUw29RJcTkDdfBE89jx+rq8XZy0ZOJuhPkOPKhFtuIzOJsyvLXVLjKtz
   e5ZRb1iyCwp+S21Osi7WbbKnakI7pTenpouBKyCmm47GOy2pXOgd6vyaZ
   aNi6LSsMDFDvFxVHbsHq6c9M+KKwYYwexhZJh1yZ1aawH/h5aYwjHKIPz
   ENnwIjCBUg6MOeUR2o69AA/XeRbWDOExSKnTNudJbfpTOknbqVRBC4iRe
   igQ84Mo5ED3lt13zGe5cKSFY1ZK+3NLmdENPdaOOGxZHqw+yqC0ZxKgv/
   A==;
X-CSE-ConnectionGUID: CsIhPISpQtqBNRm9hVJOrw==
X-CSE-MsgGUID: 7AnAty/1QRC4LYC8ZCPwcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11506"; a="66857594"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="66857594"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 02:00:36 -0700
X-CSE-ConnectionGUID: ZLh92j3kRMqgox29HBVNiw==
X-CSE-MsgGUID: K8gB3J+RTs+shOmxegH/Dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="162204512"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 30 Jul 2025 02:00:33 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uh2fn-0002Ee-1z;
	Wed, 30 Jul 2025 09:00:31 +0000
Date: Wed, 30 Jul 2025 16:59:37 +0800
From: kernel test robot <lkp@intel.com>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: include/math-emu/double.h:59:21: warning: '__BIG_ENDIAN' is not
 defined, evaluates to 0
Message-ID: <202507301656.7FEX6J5W-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4b290aae788e06561754b28c6842e4080957d3f7
commit: aca95fb6bb572a77f39d42d83ab72a965026577d powerpc/microwatt: Add SMP support
date:   5 months ago
config: powerpc64-randconfig-r064-20250730 (https://download.01.org/0day-ci/archive/20250730/202507301656.7FEX6J5W-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 8f09b03aebb71c154f3bbe725c29e3f47d37c26e)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250730/202507301656.7FEX6J5W-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507301656.7FEX6J5W-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/powerpc/math-emu/math.c:14:
>> include/math-emu/double.h:59:21: warning: '__BIG_ENDIAN' is not defined, evaluates to 0 [-Wundef]
      59 | #if __BYTE_ORDER == __BIG_ENDIAN
         |                     ^
   1 warning generated.
--
   In file included from arch/powerpc/math-emu/fsqrts.c:8:
>> include/math-emu/double.h:59:21: warning: '__BIG_ENDIAN' is not defined, evaluates to 0 [-Wundef]
      59 | #if __BYTE_ORDER == __BIG_ENDIAN
         |                     ^
   In file included from arch/powerpc/math-emu/fsqrts.c:9:
>> include/math-emu/single.h:50:21: warning: '__BIG_ENDIAN' is not defined, evaluates to 0 [-Wundef]
      50 | #if __BYTE_ORDER == __BIG_ENDIAN
         |                     ^
   2 warnings generated.


vim +/__BIG_ENDIAN +59 include/math-emu/double.h

^1da177e4c3f41 Linus Torvalds 2005-04-16  54  
^1da177e4c3f41 Linus Torvalds 2005-04-16  55  union _FP_UNION_D
^1da177e4c3f41 Linus Torvalds 2005-04-16  56  {
^1da177e4c3f41 Linus Torvalds 2005-04-16  57    double flt;
^1da177e4c3f41 Linus Torvalds 2005-04-16  58    struct {
^1da177e4c3f41 Linus Torvalds 2005-04-16 @59  #if __BYTE_ORDER == __BIG_ENDIAN
^1da177e4c3f41 Linus Torvalds 2005-04-16  60      unsigned sign  : 1;
^1da177e4c3f41 Linus Torvalds 2005-04-16  61      unsigned exp   : _FP_EXPBITS_D;
^1da177e4c3f41 Linus Torvalds 2005-04-16  62      unsigned frac1 : _FP_FRACBITS_D - (_FP_IMPLBIT_D != 0) - _FP_W_TYPE_SIZE;
^1da177e4c3f41 Linus Torvalds 2005-04-16  63      unsigned frac0 : _FP_W_TYPE_SIZE;
^1da177e4c3f41 Linus Torvalds 2005-04-16  64  #else
^1da177e4c3f41 Linus Torvalds 2005-04-16  65      unsigned frac0 : _FP_W_TYPE_SIZE;
^1da177e4c3f41 Linus Torvalds 2005-04-16  66      unsigned frac1 : _FP_FRACBITS_D - (_FP_IMPLBIT_D != 0) - _FP_W_TYPE_SIZE;
^1da177e4c3f41 Linus Torvalds 2005-04-16  67      unsigned exp   : _FP_EXPBITS_D;
^1da177e4c3f41 Linus Torvalds 2005-04-16  68      unsigned sign  : 1;
^1da177e4c3f41 Linus Torvalds 2005-04-16  69  #endif
^1da177e4c3f41 Linus Torvalds 2005-04-16  70    } bits __attribute__((packed));
^1da177e4c3f41 Linus Torvalds 2005-04-16  71  };
^1da177e4c3f41 Linus Torvalds 2005-04-16  72  

:::::: The code at line 59 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

