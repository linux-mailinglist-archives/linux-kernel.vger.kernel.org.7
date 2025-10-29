Return-Path: <linux-kernel+bounces-876505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DCFC1BF54
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 25512586D0D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C622F6912;
	Wed, 29 Oct 2025 15:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FsjDb1Tb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6972FBDEF
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 15:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761751424; cv=none; b=CNd/P72Sucz6fEwBY3Nl1IIuB+mr5vs7BW77LFdcvRgljZLEyujPM+lx94Ffa4Xj0bojG/48JXTArlmJpCsrMR3hlz8em/YqD8RjS2yJ9hTzFtnl3EKOm3MrSKCKj1wj8cDx2PvDkvzHgUlN7uk6kC51VTBbe1n000xJ0r2ouzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761751424; c=relaxed/simple;
	bh=vKOJZf/S7dqO673amrjHfdy/NkdL0LUfynAjbpfwbtk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CO+M6xEfzX3W5j4CjKhbNHuiBRxUZtb0j2ouw/xN/ePQ7akb3cU0CVYNbBHdu24p765c1lrU6vEpFoGhjFixgxCpntB6uH9ImyEwQxlnDZi2FmWK592G7LngJ47Y0Fcl5LT1k4ZYCUDSeh8sEmIzz+e3KO4/BjKelXasguv4Kg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FsjDb1Tb; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761751423; x=1793287423;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vKOJZf/S7dqO673amrjHfdy/NkdL0LUfynAjbpfwbtk=;
  b=FsjDb1TbdIGh8fgqvtof5EvrVseQ9Es8nbbfGugcJ8S5KZWI4bDaeyil
   tRF72P4uN5SM5w9yByNbS9bgvkTGsmXP6M77WlLf62qrZVIjUuxQUGsuX
   /mJhaZArClnu+l3D1B4W13kDJF2h/BDplzTxq+q+2XuM0c6AVo4smgGic
   28tjm7HF+VXfYGYX4nsUempbwHnKbDLhX/9V2g7jz7/W8YMbQGtKhhNWQ
   kkku+M12LXQZt9AENJZCytMUcW5kdU+CtOHYrdJszQ7Zp+URSnifVh4qO
   gLfcdlYFZwy8iim2oYPtKGTLAG9aFT9DPpMymXvw/XGxrJXzzTxCWBgsr
   Q==;
X-CSE-ConnectionGUID: ZiYYtZ4eQpyKPL0+0PLSxg==
X-CSE-MsgGUID: xe12UDtZRiyttS7XEaQ1AA==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="74475559"
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="74475559"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 08:23:41 -0700
X-CSE-ConnectionGUID: ISDTi55YQaGJ2tWvaebh/A==
X-CSE-MsgGUID: YcykwXw7TGG5dVEmM4990Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="190827803"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 29 Oct 2025 08:23:39 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vE81C-000Kie-1n;
	Wed, 29 Oct 2025 15:23:36 +0000
Date: Wed, 29 Oct 2025 23:22:46 +0800
From: kernel test robot <lkp@intel.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [tip:perf/core 18/20] arch/x86/include/asm/unwind_user.h:16:17:
 error: 'struct pt_regs' has no member named 'flags'
Message-ID: <202510292357.orDRPo4p-lkp@intel.com>
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
config: um-randconfig-r071-20251029 (https://download.01.org/0day-ci/archive/20251029/202510292357.orDRPo4p-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251029/202510292357.orDRPo4p-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510292357.orDRPo4p-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/unwind_user.h:6,
                    from include/linux/unwind_deferred.h:6,
                    from kernel/fork.c:108:
   arch/x86/include/asm/unwind_user.h: In function 'unwind_user_word_size':
>> arch/x86/include/asm/unwind_user.h:16:17: error: 'struct pt_regs' has no member named 'flags'
      16 |         if (regs->flags & X86_VM_MASK)
         |                 ^~
>> arch/x86/include/asm/unwind_user.h:16:27: error: 'X86_VM_MASK' undeclared (first use in this function)
      16 |         if (regs->flags & X86_VM_MASK)
         |                           ^~~~~~~~~~~
   arch/x86/include/asm/unwind_user.h:16:27: note: each undeclared identifier is reported only once for each function it appears in


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

