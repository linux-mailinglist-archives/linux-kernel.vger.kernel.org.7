Return-Path: <linux-kernel+bounces-771351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEC1B285E5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 20:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9031DB02DF5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 18:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CAF219A67;
	Fri, 15 Aug 2025 18:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FDXeCbRv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7045231771D
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 18:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755283087; cv=none; b=OJQEgMRv3LI+TUizYrAW1K0gXRI2TAebgCNh5dl5zVV5chiEXy32pmhVUP329H6hVM7vMzSjAiwatYyxTJaH/zzaNYm28bYAofhWr90bYV/keUCISemcpLqnZJgz+sGaD7STK8Vz9grhpw+TIe8m/+oH7uLB/Dks8ReU+RAWhso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755283087; c=relaxed/simple;
	bh=Leypm+Tknhwv/kaeDpfu8Apx8uFxLjFWE6TcMiEHC3U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Dk0xf3efQiOuHteE4imyWyAuv6AsQCGyKkW+gmC3BTSeotqMkyejD3jfft0h37C5JYk17pXlEkC+R1WAK+TlNadxrJYYPOpwKG2EsSrAbRYbl3qs4vMmLxTwiq4oRp3VXPteyq5e8qfo1zGNa+mcg2x9zW/cem6vlnN/VU2pH70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FDXeCbRv; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755283086; x=1786819086;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Leypm+Tknhwv/kaeDpfu8Apx8uFxLjFWE6TcMiEHC3U=;
  b=FDXeCbRvyNtf6hm+Ol4tjANE8+N6CjLlJdAmplc218P0xTqj8hNdf3aG
   klsAX/YuCEin17BZixFe86m4X3BThsdiq91Bnu6wkqLvTyqdkRlNj/uZ1
   BYvpredl5+8dAMD/j1lCLLjHlkgkCAHTS6QX4OfDCMewxlz5X/g15s64l
   CAbhl/mjTd+vnzjTrAYU6w6bOeZPtCHGAGDiqHQZvGb1OyJKFR7nKx1FI
   X0rFr/eJ9hlQAp/He+CQDh4gXFA5X9ovM2n6OZN3b7XhGxhA98NTg37Vm
   WnKxJO/Go5ho781a/9cDQudK+rFz5WC0QS8ytGJW5UebabBnqcTYakfpF
   g==;
X-CSE-ConnectionGUID: SHuPLrbKQHOCJ4WDfBR55g==
X-CSE-MsgGUID: t4cBYR0sSJSRSQtsW/uL/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11523"; a="80185239"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="80185239"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 11:38:05 -0700
X-CSE-ConnectionGUID: lhfJvQqnRWKG6gPk/oD7aA==
X-CSE-MsgGUID: aWiHSCjGQFWEI+pdipoPaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="166986659"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 15 Aug 2025 11:38:03 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1umzJR-000CF8-00;
	Fri, 15 Aug 2025 18:38:01 +0000
Date: Sat, 16 Aug 2025 02:37:59 +0800
From: kernel test robot <lkp@intel.com>
To: Nam Cao <namcao@linutronix.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>
Subject: kernel/trace/rv/monitors/sleep/sleep.c:130:7: error: use of
 undeclared identifier '__NR_clock_nanosleep'
Message-ID: <202508160204.SsFyNfo6-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ee94b00c1a648530333d9734200be7a45e6e00cd
commit: f74f8bb246cf22f27752977da62079cb615f55b2 rv: Add rtapp_sleep monitor
date:   5 weeks ago
config: riscv-randconfig-001-20250816 (https://download.01.org/0day-ci/archive/20250816/202508160204.SsFyNfo6-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 93d24b6b7b148c47a2fa228a4ef31524fa1d9f3f)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250816/202508160204.SsFyNfo6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508160204.SsFyNfo6-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:804:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     804 |         insb(addr, buffer, count);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:104:53: note: expanded from macro 'insb'
     104 | #define insb(addr, buffer, count) __insb(PCI_IOBASE + (addr), buffer, count)
         |                                          ~~~~~~~~~~ ^
   In file included from kernel/trace/rv/monitors/sleep/sleep.c:2:
   In file included from include/linux/ftrace.h:10:
   In file included from include/linux/trace_recursion.h:5:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:12:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:812:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     812 |         insw(addr, buffer, count);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:105:53: note: expanded from macro 'insw'
     105 | #define insw(addr, buffer, count) __insw(PCI_IOBASE + (addr), buffer, count)
         |                                          ~~~~~~~~~~ ^
   In file included from kernel/trace/rv/monitors/sleep/sleep.c:2:
   In file included from include/linux/ftrace.h:10:
   In file included from include/linux/trace_recursion.h:5:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:12:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:820:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     820 |         insl(addr, buffer, count);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:106:53: note: expanded from macro 'insl'
     106 | #define insl(addr, buffer, count) __insl(PCI_IOBASE + (addr), buffer, count)
         |                                          ~~~~~~~~~~ ^
   In file included from kernel/trace/rv/monitors/sleep/sleep.c:2:
   In file included from include/linux/ftrace.h:10:
   In file included from include/linux/trace_recursion.h:5:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:12:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:829:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     829 |         outsb(addr, buffer, count);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:118:55: note: expanded from macro 'outsb'
     118 | #define outsb(addr, buffer, count) __outsb(PCI_IOBASE + (addr), buffer, count)
         |                                            ~~~~~~~~~~ ^
   In file included from kernel/trace/rv/monitors/sleep/sleep.c:2:
   In file included from include/linux/ftrace.h:10:
   In file included from include/linux/trace_recursion.h:5:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:12:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:838:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     838 |         outsw(addr, buffer, count);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:119:55: note: expanded from macro 'outsw'
     119 | #define outsw(addr, buffer, count) __outsw(PCI_IOBASE + (addr), buffer, count)
         |                                            ~~~~~~~~~~ ^
   In file included from kernel/trace/rv/monitors/sleep/sleep.c:2:
   In file included from include/linux/ftrace.h:10:
   In file included from include/linux/trace_recursion.h:5:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:12:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:847:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     847 |         outsl(addr, buffer, count);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:120:55: note: expanded from macro 'outsl'
     120 | #define outsl(addr, buffer, count) __outsl(PCI_IOBASE + (addr), buffer, count)
         |                                            ~~~~~~~~~~ ^
   In file included from kernel/trace/rv/monitors/sleep/sleep.c:2:
   In file included from include/linux/ftrace.h:10:
   In file included from include/linux/trace_recursion.h:5:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:12:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:1175:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
    1175 |         return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
         |                                                   ~~~~~~~~~~ ^
>> kernel/trace/rv/monitors/sleep/sleep.c:130:7: error: use of undeclared identifier '__NR_clock_nanosleep'
     130 |         case __NR_clock_nanosleep:
         |              ^~~~~~~~~~~~~~~~~~~~
>> kernel/trace/rv/monitors/sleep/sleep.c:141:7: error: use of undeclared identifier '__NR_futex'
     141 |         case __NR_futex:
         |              ^~~~~~~~~~
   7 warnings and 2 errors generated.


vim +/__NR_clock_nanosleep +130 kernel/trace/rv/monitors/sleep/sleep.c

   120	
   121	static void handle_sys_enter(void *data, struct pt_regs *regs, long id)
   122	{
   123		struct ltl_monitor *mon;
   124		unsigned long args[6];
   125		int op, cmd;
   126	
   127		mon = ltl_get_monitor(current);
   128	
   129		switch (id) {
 > 130		case __NR_clock_nanosleep:
   131	#ifdef __NR_clock_nanosleep_time64
   132		case __NR_clock_nanosleep_time64:
   133	#endif
   134			syscall_get_arguments(current, regs, args);
   135			ltl_atom_set(mon, LTL_NANOSLEEP_CLOCK_MONOTONIC, args[0] == CLOCK_MONOTONIC);
   136			ltl_atom_set(mon, LTL_NANOSLEEP_CLOCK_TAI, args[0] == CLOCK_TAI);
   137			ltl_atom_set(mon, LTL_NANOSLEEP_TIMER_ABSTIME, args[1] == TIMER_ABSTIME);
   138			ltl_atom_update(current, LTL_CLOCK_NANOSLEEP, true);
   139			break;
   140	
 > 141		case __NR_futex:
   142	#ifdef __NR_futex_time64
   143		case __NR_futex_time64:
   144	#endif
   145			syscall_get_arguments(current, regs, args);
   146			op = args[1];
   147			cmd = op & FUTEX_CMD_MASK;
   148	
   149			switch (cmd) {
   150			case FUTEX_LOCK_PI:
   151			case FUTEX_LOCK_PI2:
   152				ltl_atom_update(current, LTL_FUTEX_LOCK_PI, true);
   153				break;
   154			case FUTEX_WAIT:
   155			case FUTEX_WAIT_BITSET:
   156			case FUTEX_WAIT_REQUEUE_PI:
   157				ltl_atom_update(current, LTL_FUTEX_WAIT, true);
   158				break;
   159			}
   160			break;
   161		}
   162	}
   163	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

