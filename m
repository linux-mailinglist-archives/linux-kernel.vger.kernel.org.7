Return-Path: <linux-kernel+bounces-759207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 364F1B1DA48
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 16:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4B893AFDBD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 14:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71FB264A9D;
	Thu,  7 Aug 2025 14:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OeQSbLKb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1756262FE4
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 14:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754577890; cv=none; b=HN3IzMmP43Aek3774jOhsPYj7ojijcHezJzROihMyokR8kQ+SysOZ0BzpzzCzaaitaGlAZPgbs6lknDS0GJDV4ck0VFEyP/gx+Vlkw4a5sAX/mk+F9aVh3T1Y/rvKeztBYkCkFAhq4ZNCwzI83Jf96eRSqYR/jBTkGFy/o2eLSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754577890; c=relaxed/simple;
	bh=xHdG9bnegdsYFSda4X6vtCSBfN1sfDNUPWqToEBiZ6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HHxIPxH5n4LwPpO+kIwVnrMFojTMTHKkJU78KgV9vUybWboMpuT5dFWt1GaLMUviBpTdR1P+CCtpSaSSVrrAgL45xeoFyP+BNENvNkwRrbZxm4H4rBuVqaYE2xUP1RzJbAZjS/GasdnTYdV7x3MXYfqTL5Drw7uK0vspu9Gf+CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OeQSbLKb; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754577888; x=1786113888;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xHdG9bnegdsYFSda4X6vtCSBfN1sfDNUPWqToEBiZ6c=;
  b=OeQSbLKbch0tvmq63OefcdctNA1qMkIj2JTyXwBv28YY7L2inMIesZ/T
   n1j2Ji6AhS1U6bp06YO+ZqM4+595neRkukPFN/e4uJSMN2AyKVvTgUOc3
   5bQP6+U/WKoFe0RSuUZSCMN3CtSTPTvmsaCvDesnu70Xcl2YUZRhJlEf8
   Dz6eMLKfHLx08RWvMbn0gAmQdd/by0oHvjnB2tGvDliLGYcpxE7Yy8icQ
   yIvxV+yddoMnQrkDkXGDU2Mbi1xYgn/J0ApI108LY6Vtb9BT5KUkF39e+
   PmFoMAMfa+QhDgt4NBb91ABudegT/Wg8CPqjR1Kr4+I0z3L6NzXywg17M
   g==;
X-CSE-ConnectionGUID: YiBxWQ75QtyZ/xg9i6sKxA==
X-CSE-MsgGUID: BhFhaee7Rh2fOFiA86zCgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="74493137"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="74493137"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 07:44:47 -0700
X-CSE-ConnectionGUID: SaH2uLB5SMieo43Bc+Do+g==
X-CSE-MsgGUID: EwgTw66xQCOkmf5Ynca02A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="202242117"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 07 Aug 2025 07:44:44 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uk1rG-0002tK-0i;
	Thu, 07 Aug 2025 14:44:42 +0000
Date: Thu, 7 Aug 2025 22:44:32 +0800
From: kernel test robot <lkp@intel.com>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, richard@nod.at
Cc: oe-kbuild-all@lists.linux.dev, anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net, linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] um: Use ARRAY_SIZE for array length
Message-ID: <202508072253.pVtUjvoV-lkp@intel.com>
References: <20250807023227.2443863-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807023227.2443863-1-jiapeng.chong@linux.alibaba.com>

Hi Jiapeng,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20250806]

url:    https://github.com/intel-lab-lkp/linux/commits/Jiapeng-Chong/um-Use-ARRAY_SIZE-for-array-length/20250807-103534
base:   next-20250806
patch link:    https://lore.kernel.org/r/20250807023227.2443863-1-jiapeng.chong%40linux.alibaba.com
patch subject: [PATCH -next] um: Use ARRAY_SIZE for array length
config: um-randconfig-001-20250807 (https://download.01.org/0day-ci/archive/20250807/202508072253.pVtUjvoV-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250807/202508072253.pVtUjvoV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508072253.pVtUjvoV-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/um/kernel/skas/stub_exe.c: In function 'real_init':
>> arch/um/kernel/skas/stub_exe.c:196:32: error: implicit declaration of function 'ARRAY_SIZE' [-Werror=implicit-function-declaration]
     196 |                         .len = ARRAY_SIZE(filter),
         |                                ^~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/ARRAY_SIZE +196 arch/um/kernel/skas/stub_exe.c

    12	
    13	noinline static void real_init(void)
    14	{
    15		struct stub_init_data init_data;
    16		unsigned long res;
    17		struct {
    18			void  *ss_sp;
    19			int    ss_flags;
    20			size_t ss_size;
    21		} stack = {
    22			.ss_size = STUB_DATA_PAGES * UM_KERN_PAGE_SIZE,
    23		};
    24		struct {
    25			void *sa_handler_;
    26			unsigned long sa_flags;
    27			void *sa_restorer;
    28			unsigned long long sa_mask;
    29		} sa = {
    30			/* Need to set SA_RESTORER (but the handler never returns) */
    31			.sa_flags = SA_ONSTACK | SA_NODEFER | SA_SIGINFO | 0x04000000,
    32		};
    33	
    34		/* set a nice name */
    35		stub_syscall2(__NR_prctl, PR_SET_NAME, (unsigned long)"uml-userspace");
    36	
    37		/* Make sure this process dies if the kernel dies */
    38		stub_syscall2(__NR_prctl, PR_SET_PDEATHSIG, SIGKILL);
    39	
    40		/* Needed in SECCOMP mode (and safe to do anyway) */
    41		stub_syscall5(__NR_prctl, PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
    42	
    43		/* read information from STDIN and close it */
    44		res = stub_syscall3(__NR_read, 0,
    45				    (unsigned long)&init_data, sizeof(init_data));
    46		if (res != sizeof(init_data))
    47			stub_syscall1(__NR_exit, 10);
    48	
    49		/* In SECCOMP mode, FD 0 is a socket and is later used for FD passing */
    50		if (!init_data.seccomp)
    51			stub_syscall1(__NR_close, 0);
    52		else
    53			stub_syscall3(__NR_fcntl, 0, F_SETFL, O_NONBLOCK);
    54	
    55		/* map stub code + data */
    56		res = stub_syscall6(STUB_MMAP_NR,
    57				    init_data.stub_start, UM_KERN_PAGE_SIZE,
    58				    PROT_READ | PROT_EXEC, MAP_FIXED | MAP_SHARED,
    59				    init_data.stub_code_fd, init_data.stub_code_offset);
    60		if (res != init_data.stub_start)
    61			stub_syscall1(__NR_exit, 11);
    62	
    63		res = stub_syscall6(STUB_MMAP_NR,
    64				    init_data.stub_start + UM_KERN_PAGE_SIZE,
    65				    STUB_DATA_PAGES * UM_KERN_PAGE_SIZE,
    66				    PROT_READ | PROT_WRITE, MAP_FIXED | MAP_SHARED,
    67				    init_data.stub_data_fd, init_data.stub_data_offset);
    68		if (res != init_data.stub_start + UM_KERN_PAGE_SIZE)
    69			stub_syscall1(__NR_exit, 12);
    70	
    71		/* In SECCOMP mode, we only need the signalling FD from now on */
    72		if (init_data.seccomp) {
    73			res = stub_syscall3(__NR_close_range, 1, ~0U, 0);
    74			if (res != 0)
    75				stub_syscall1(__NR_exit, 13);
    76		}
    77	
    78		/* setup signal stack inside stub data */
    79		stack.ss_sp = (void *)init_data.stub_start + UM_KERN_PAGE_SIZE;
    80		stub_syscall2(__NR_sigaltstack, (unsigned long)&stack, 0);
    81	
    82		/* register signal handlers */
    83		sa.sa_handler_ = (void *) init_data.signal_handler;
    84		sa.sa_restorer = (void *) init_data.signal_restorer;
    85		if (!init_data.seccomp) {
    86			/* In ptrace mode, the SIGSEGV handler never returns */
    87			sa.sa_mask = 0;
    88	
    89			res = stub_syscall4(__NR_rt_sigaction, SIGSEGV,
    90					    (unsigned long)&sa, 0, sizeof(sa.sa_mask));
    91			if (res != 0)
    92				stub_syscall1(__NR_exit, 14);
    93		} else {
    94			/* SECCOMP mode uses rt_sigreturn, need to mask all signals */
    95			sa.sa_mask = ~0ULL;
    96	
    97			res = stub_syscall4(__NR_rt_sigaction, SIGSEGV,
    98					    (unsigned long)&sa, 0, sizeof(sa.sa_mask));
    99			if (res != 0)
   100				stub_syscall1(__NR_exit, 15);
   101	
   102			res = stub_syscall4(__NR_rt_sigaction, SIGSYS,
   103					    (unsigned long)&sa, 0, sizeof(sa.sa_mask));
   104			if (res != 0)
   105				stub_syscall1(__NR_exit, 16);
   106	
   107			res = stub_syscall4(__NR_rt_sigaction, SIGALRM,
   108					    (unsigned long)&sa, 0, sizeof(sa.sa_mask));
   109			if (res != 0)
   110				stub_syscall1(__NR_exit, 17);
   111	
   112			res = stub_syscall4(__NR_rt_sigaction, SIGTRAP,
   113					    (unsigned long)&sa, 0, sizeof(sa.sa_mask));
   114			if (res != 0)
   115				stub_syscall1(__NR_exit, 18);
   116	
   117			res = stub_syscall4(__NR_rt_sigaction, SIGILL,
   118					    (unsigned long)&sa, 0, sizeof(sa.sa_mask));
   119			if (res != 0)
   120				stub_syscall1(__NR_exit, 19);
   121	
   122			res = stub_syscall4(__NR_rt_sigaction, SIGFPE,
   123					    (unsigned long)&sa, 0, sizeof(sa.sa_mask));
   124			if (res != 0)
   125				stub_syscall1(__NR_exit, 20);
   126		}
   127	
   128		/*
   129		 * If in seccomp mode, install the SECCOMP filter and trigger a syscall.
   130		 * Otherwise set PTRACE_TRACEME and do a SIGSTOP.
   131		 */
   132		if (init_data.seccomp) {
   133			struct sock_filter filter[] = {
   134	#if __BITS_PER_LONG > 32
   135				/* [0] Load upper 32bit of instruction pointer from seccomp_data */
   136				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
   137					 (offsetof(struct seccomp_data, instruction_pointer) + 4)),
   138	
   139				/* [1] Jump forward 3 instructions if the upper address is not identical */
   140				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, (init_data.stub_start) >> 32, 0, 3),
   141	#endif
   142				/* [2] Load lower 32bit of instruction pointer from seccomp_data */
   143				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
   144					 (offsetof(struct seccomp_data, instruction_pointer))),
   145	
   146				/* [3] Mask out lower bits */
   147				BPF_STMT(BPF_ALU | BPF_AND | BPF_K, 0xfffff000),
   148	
   149				/* [4] Jump to [6] if the lower bits are not on the expected page */
   150				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, (init_data.stub_start) & 0xfffff000, 1, 0),
   151	
   152				/* [5] Trap call, allow */
   153				BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_TRAP),
   154	
   155				/* [6,7] Check architecture */
   156				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
   157					 offsetof(struct seccomp_data, arch)),
   158				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K,
   159					 UM_SECCOMP_ARCH_NATIVE, 1, 0),
   160	
   161				/* [8] Kill (for architecture check) */
   162				BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_KILL_PROCESS),
   163	
   164				/* [9] Load syscall number */
   165				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
   166					 offsetof(struct seccomp_data, nr)),
   167	
   168				/* [10-16] Check against permitted syscalls */
   169				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, __NR_futex,
   170					 7, 0),
   171				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K,__NR_recvmsg,
   172					 6, 0),
   173				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K,__NR_close,
   174					 5, 0),
   175				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, STUB_MMAP_NR,
   176					 4, 0),
   177				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, __NR_munmap,
   178					 3, 0),
   179	#ifdef __i386__
   180				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, __NR_set_thread_area,
   181					 2, 0),
   182	#else
   183				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, __NR_arch_prctl,
   184					 2, 0),
   185	#endif
   186				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, __NR_rt_sigreturn,
   187					 1, 0),
   188	
   189				/* [17] Not one of the permitted syscalls */
   190				BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_KILL_PROCESS),
   191	
   192				/* [18] Permitted call for the stub */
   193				BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_ALLOW),
   194			};
   195			struct sock_fprog prog = {
 > 196				.len = ARRAY_SIZE(filter),
   197				.filter = filter,
   198			};
   199	
   200			if (stub_syscall3(__NR_seccomp, SECCOMP_SET_MODE_FILTER,
   201					  SECCOMP_FILTER_FLAG_TSYNC,
   202					  (unsigned long)&prog) != 0)
   203				stub_syscall1(__NR_exit, 21);
   204	
   205			/* Fall through, the exit syscall will cause SIGSYS */
   206		} else {
   207			stub_syscall4(__NR_ptrace, PTRACE_TRACEME, 0, 0, 0);
   208	
   209			stub_syscall2(__NR_kill, stub_syscall0(__NR_getpid), SIGSTOP);
   210		}
   211	
   212		stub_syscall1(__NR_exit, 30);
   213	
   214		__builtin_unreachable();
   215	}
   216	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

