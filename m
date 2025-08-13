Return-Path: <linux-kernel+bounces-767310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 830F8B252B0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 20:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 968A6170A65
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 17:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7046429BD9A;
	Wed, 13 Aug 2025 17:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cB3zKZOY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29E929B8CC
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 17:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755107948; cv=none; b=J0hHXEPEIugqYbfiBYzkRIN2GRrhqciSSoIu9ce/8XHRIDW3fTCd2b9lkykXzh7+YB5VtU7HO6+0oGz0Fd56UHG74yQ3tsIH7yRnVQA1NucqfdSpW56FRqGR1F12S1BWz3eYrbCsJ2oFMwagTD4mMn31HQ8sdusfSHNUlCy/wiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755107948; c=relaxed/simple;
	bh=vOeA+IRs2WkICsEroFKXn3XPbpj/6Pk8zU4tiVJa5iU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gX3CPy+xnc+HfQxW7uQgURnJXLZPUFzFRa6T2CLO79DwLVyFDicX3zYJBe6Ivi4La5EyE3NtPE5wDJ73NrbMZNpttyyGxZ/YXq3ltIlU1aDIOnxy+vuEZtHi2Z5zMIxliH9pRdlQM2pRS8vs8+2tKgqYq/xmWysfuyFn1P9NKWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cB3zKZOY; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755107947; x=1786643947;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vOeA+IRs2WkICsEroFKXn3XPbpj/6Pk8zU4tiVJa5iU=;
  b=cB3zKZOYSHvFE1VG7kEwO2FybY/POFdNuUfbAhXfv2rq2uEwCH4oQfaO
   SQEyj63L3pe2AWHBdOdN2mDeJgLr6Iysd18WPkGsiOnenDf1J90yu14Ri
   Tt4dFDzCt7+aOgoN+gdaUF/SWvwJTahfZGXBNv9PRHBStebEDKynquHd+
   YEp7aLruZWw7UjPm+QB8EMi7NmCArKHMf1St7cvdU2i6o6kBGbJkybbEV
   beagO1jNZYAJeCr78fsvtKY9OOwTfE9BIVGOKQJV3mQT1RwWQgs+YsO+e
   wW8v9LvoOVUkj/2fkEYQ1ubjRtlf+tRh3nN7YYRvbKS61IBb5jzhxbG1L
   w==;
X-CSE-ConnectionGUID: 45MriYx0SxeonWtNVumsGw==
X-CSE-MsgGUID: +28IR4bUS/u1qtN9xJeKRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="68793437"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="68793437"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 10:59:06 -0700
X-CSE-ConnectionGUID: j7xmGq33RKipnwWnaM0fLA==
X-CSE-MsgGUID: Pc5yatR4SMKg9zBTxgi/Ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="166033963"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 13 Aug 2025 10:59:04 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1umFkc-000ABW-1V;
	Wed, 13 Aug 2025 17:59:02 +0000
Date: Thu, 14 Aug 2025 01:57:39 +0800
From: kernel test robot <lkp@intel.com>
To: Kees Cook <kees@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: arch/arm/include/asm/stacktrace.h:48:21: error: call to undeclared
 function 'in_entry_text'; ISO C99 and later do not support implicit function
 declarations
Message-ID: <202508140127.RW2381Lq-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   91325f31afc1026de28665cf1a7b6e157fa4d39d
commit: a8f0b1f8ef628bd1003eed650862836e97b89fdd kstack_erase: Support Clang stack depth tracking
date:   3 weeks ago
config: arm-randconfig-002-20250814 (https://download.01.org/0day-ci/archive/20250814/202508140127.RW2381Lq-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 3769ce013be2879bf0b329c14a16f5cb766f26ce)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250814/202508140127.RW2381Lq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508140127.RW2381Lq-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/kstack_erase.c:13:
   In file included from include/linux/kstack_erase.h:16:
>> arch/arm/include/asm/stacktrace.h:48:21: error: call to undeclared function 'in_entry_text'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      48 |                 frame->ex_frame = in_entry_text(frame->pc);
         |                                   ^
   In file included from kernel/kstack_erase.c:14:
   In file included from include/linux/kprobes.h:28:
   In file included from include/linux/ftrace.h:10:
   In file included from include/linux/trace_recursion.h:5:
   In file included from include/linux/interrupt.h:22:
>> arch/arm/include/asm/sections.h:14:20: error: static declaration of 'in_entry_text' follows non-static declaration
      14 | static inline bool in_entry_text(unsigned long addr)
         |                    ^
   arch/arm/include/asm/stacktrace.h:48:21: note: previous implicit declaration is here
      48 |                 frame->ex_frame = in_entry_text(frame->pc);
         |                                   ^
   In file included from kernel/kstack_erase.c:14:
   In file included from include/linux/kprobes.h:28:
   In file included from include/linux/ftrace.h:13:
   In file included from include/linux/kallsyms.h:13:
   In file included from include/linux/mm.h:36:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:98:11: warning: array index 3 is past the end of the array (that has type 'unsigned long[2]') [-Warray-bounds]
      98 |                 return (set->sig[3] | set->sig[2] |
         |                         ^        ~
   arch/arm/include/asm/signal.h:17:2: note: array 'sig' declared here
      17 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from kernel/kstack_erase.c:14:
   In file included from include/linux/kprobes.h:28:
   In file included from include/linux/ftrace.h:13:
   In file included from include/linux/kallsyms.h:13:
   In file included from include/linux/mm.h:36:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:98:25: warning: array index 2 is past the end of the array (that has type 'unsigned long[2]') [-Warray-bounds]
      98 |                 return (set->sig[3] | set->sig[2] |
         |                                       ^        ~
   arch/arm/include/asm/signal.h:17:2: note: array 'sig' declared here
      17 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from kernel/kstack_erase.c:14:
   In file included from include/linux/kprobes.h:28:
   In file included from include/linux/ftrace.h:13:
   In file included from include/linux/kallsyms.h:13:
   In file included from include/linux/mm.h:36:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:114:11: warning: array index 3 is past the end of the array (that has type 'const unsigned long[2]') [-Warray-bounds]
     114 |                 return  (set1->sig[3] == set2->sig[3]) &&
         |                          ^         ~
   arch/arm/include/asm/signal.h:17:2: note: array 'sig' declared here
      17 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from kernel/kstack_erase.c:14:
   In file included from include/linux/kprobes.h:28:
   In file included from include/linux/ftrace.h:13:
   In file included from include/linux/kallsyms.h:13:
   In file included from include/linux/mm.h:36:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:114:27: warning: array index 3 is past the end of the array (that has type 'const unsigned long[2]') [-Warray-bounds]
     114 |                 return  (set1->sig[3] == set2->sig[3]) &&
         |                                          ^         ~
   arch/arm/include/asm/signal.h:17:2: note: array 'sig' declared here
      17 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from kernel/kstack_erase.c:14:
   In file included from include/linux/kprobes.h:28:
   In file included from include/linux/ftrace.h:13:
   In file included from include/linux/kallsyms.h:13:
   In file included from include/linux/mm.h:36:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:115:5: warning: array index 2 is past the end of the array (that has type 'const unsigned long[2]') [-Warray-bounds]
     115 |                         (set1->sig[2] == set2->sig[2]) &&
         |                          ^         ~
   arch/arm/include/asm/signal.h:17:2: note: array 'sig' declared here
      17 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from kernel/kstack_erase.c:14:
   In file included from include/linux/kprobes.h:28:
   In file included from include/linux/ftrace.h:13:
   In file included from include/linux/kallsyms.h:13:
   In file included from include/linux/mm.h:36:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:115:21: warning: array index 2 is past the end of the array (that has type 'const unsigned long[2]') [-Warray-bounds]
     115 |                         (set1->sig[2] == set2->sig[2]) &&
         |                                          ^         ~
   arch/arm/include/asm/signal.h:17:2: note: array 'sig' declared here
      17 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from kernel/kstack_erase.c:14:
   In file included from include/linux/kprobes.h:28:
   In file included from include/linux/ftrace.h:13:
   In file included from include/linux/kallsyms.h:13:
   In file included from include/linux/mm.h:36:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:157:1: warning: array index 3 is past the end of the array (that has type 'const unsigned long[2]') [-Warray-bounds]
     157 | _SIG_SET_BINOP(sigorsets, _sig_or)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/signal.h:138:8: note: expanded from macro '_SIG_SET_BINOP'
     138 |                 a3 = a->sig[3]; a2 = a->sig[2];                         \
         |                      ^      ~
   arch/arm/include/asm/signal.h:17:2: note: array 'sig' declared here
      17 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from kernel/kstack_erase.c:14:


vim +/in_entry_text +48 arch/arm/include/asm/stacktrace.h

2335c9cb831faba Jinjie Ruan      2024-06-27  35  
9865f1d46a68a5f Nikolay Borisov  2014-06-03  36  static __always_inline
9865f1d46a68a5f Nikolay Borisov  2014-06-03  37  void arm_get_current_stackframe(struct pt_regs *regs, struct stackframe *frame)
9865f1d46a68a5f Nikolay Borisov  2014-06-03  38  {
9865f1d46a68a5f Nikolay Borisov  2014-06-03  39  		frame->fp = frame_pointer(regs);
9865f1d46a68a5f Nikolay Borisov  2014-06-03  40  		frame->sp = regs->ARM_sp;
9865f1d46a68a5f Nikolay Borisov  2014-06-03  41  		frame->lr = regs->ARM_lr;
9865f1d46a68a5f Nikolay Borisov  2014-06-03  42  		frame->pc = regs->ARM_pc;
fed240d9c974381 Masami Hiramatsu 2021-10-21  43  #ifdef CONFIG_KRETPROBES
fed240d9c974381 Masami Hiramatsu 2021-10-21  44  		frame->kr_cur = NULL;
fed240d9c974381 Masami Hiramatsu 2021-10-21  45  		frame->tsk = current;
fed240d9c974381 Masami Hiramatsu 2021-10-21  46  #endif
752ec621ef5c307 Li Huafei        2022-08-26  47  #ifdef CONFIG_UNWINDER_FRAME_POINTER
752ec621ef5c307 Li Huafei        2022-08-26 @48  		frame->ex_frame = in_entry_text(frame->pc);
752ec621ef5c307 Li Huafei        2022-08-26  49  #endif
9865f1d46a68a5f Nikolay Borisov  2014-06-03  50  }
9865f1d46a68a5f Nikolay Borisov  2014-06-03  51  

:::::: The code at line 48 was first introduced by commit
:::::: 752ec621ef5c30777958cc5eb5f1cf394f7733f4 ARM: 9234/1: stacktrace: Avoid duplicate saving of exception PC value

:::::: TO: Li Huafei <lihuafei1@huawei.com>
:::::: CC: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

