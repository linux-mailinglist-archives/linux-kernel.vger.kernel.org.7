Return-Path: <linux-kernel+bounces-875875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AB2C1A007
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 99F3E357DE7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C002D8785;
	Wed, 29 Oct 2025 11:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DNfYUMYC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CAA19995E
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 11:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761737195; cv=none; b=eB7lFKq6r6SVKH/VB03qzHmuP75pJt0mkgVJ6M7RuS4UeNUrhvVfWK44ckuqFdV+Emgs9CsP3SV1Fnh/G3Poh9GwYy2/wvupkGH0e/OdXW4llfeQcuDcEk7Z2xgaQ2+ye3aA/6/HwcAdVrTCXUDt2eQHdt9A8djR9Mc+haXFURY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761737195; c=relaxed/simple;
	bh=mZTyVJUiMvkTq4TfSpRLwzS9CdopbfzeUc0c4VuMUnI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=trOekXZMO087baFZbhpuvFKA81wPtnfybhpue+HD1wSQkKO3tWhDSo108f4U9AmeigwKOkAN0c7Jlj99OVHz7s2cYjJea6D1YkCXup3MRmt477j3Kck7AWi1OCIsZdLpaqEUhCblsgPBpX/oWstGHYWt3eK8T1PaBu+LM5u/z8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DNfYUMYC; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761737193; x=1793273193;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mZTyVJUiMvkTq4TfSpRLwzS9CdopbfzeUc0c4VuMUnI=;
  b=DNfYUMYCO059hC5k1MQOoOo2xk18hIkDTmPZhbiSEmQ9Xc51hHVVSiGU
   MTv6jiJyYH57tdi0bN4RQzuu8Tax6dc5BVNUZRSYwX1MKGbNBJfrNu2yX
   5onvki3Y1OanoVS4U1iZowkJYuoLeMFltcvsIQwVyCzG+wo0kZLF9Xb8v
   H9Qj4OV19RpTsGVfmid/a8sseCWtsOgJgvxXYL2XBCqKXlECsCS86dW7B
   QmqeYLQgLpoSzxH86gb53XekgbGxvRs9J01zpOrs8eMrkH6Izh2It+Pfl
   nNHzlr0IeLNNIMuOAwT2pWtJbU5c/77rnow/5xxEJiAwUtsd286hKWMhy
   w==;
X-CSE-ConnectionGUID: J4jMR6AzR1+rwJWY80vMAw==
X-CSE-MsgGUID: c8zRBtgXTpC7tnHyyloz7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11596"; a="63890638"
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="63890638"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 04:26:33 -0700
X-CSE-ConnectionGUID: Rs7aoKhzTmiWrby1j9QXrA==
X-CSE-MsgGUID: Nt+gUwiLRvKxQSyQzi0vVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="216493123"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 29 Oct 2025 04:26:30 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vE4Jn-000KYT-2H;
	Wed, 29 Oct 2025 11:26:22 +0000
Date: Wed, 29 Oct 2025 19:25:39 +0800
From: kernel test robot <lkp@intel.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [tip:perf/core 18/20] arch/x86/include/asm/unwind_user.h:16:12:
 error: no member named 'flags' in 'struct pt_regs'
Message-ID: <202510291919.FFGyU7nq-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
head:   c69993ecdd4dfde2b7da08b022052a33b203da07
commit: 49cf34c0815f93fb2ea3ab5cfbac1124bd9b45d0 [18/20] unwind_user/x86: Enable frame pointer unwinding on x86
config: um-allnoconfig (https://download.01.org/0day-ci/archive/20251029/202510291919.FFGyU7nq-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project d1c086e82af239b245fe8d7832f2753436634990)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251029/202510291919.FFGyU7nq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510291919.FFGyU7nq-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/fork.c:108:
   In file included from include/linux/unwind_deferred.h:6:
   In file included from include/linux/unwind_user.h:6:
>> arch/x86/include/asm/unwind_user.h:16:12: error: no member named 'flags' in 'struct pt_regs'
      16 |         if (regs->flags & X86_VM_MASK)
         |             ~~~~  ^
>> arch/x86/include/asm/unwind_user.h:16:20: error: use of undeclared identifier 'X86_VM_MASK'
      16 |         if (regs->flags & X86_VM_MASK)
         |                           ^~~~~~~~~~~
   2 errors generated.


vim +16 arch/x86/include/asm/unwind_user.h

     6	
     7	#define ARCH_INIT_USER_FP_FRAME(ws)			\
     8		.cfa_off	=  2*(ws),			\
     9		.ra_off		= -1*(ws),			\
    10		.fp_off		= -2*(ws),			\
    11		.use_fp		= true,
    12	
    13	static inline int unwind_user_word_size(struct pt_regs *regs)
    14	{
    15		/* We can't unwind VM86 stacks */
  > 16		if (regs->flags & X86_VM_MASK)
    17			return 0;
    18	#ifdef CONFIG_X86_64
    19		if (!user_64bit_mode(regs))
    20			return sizeof(int);
    21	#endif
    22		return sizeof(long);
    23	}
    24	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

