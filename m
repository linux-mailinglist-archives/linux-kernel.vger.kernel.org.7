Return-Path: <linux-kernel+bounces-758468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02649B1CF8B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 01:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC60C3AD8CC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 23:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC9D277814;
	Wed,  6 Aug 2025 23:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N7lwiS3E"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C00926B2AE;
	Wed,  6 Aug 2025 23:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754524375; cv=none; b=NG0iFcdVQk6rsSr2SCBo86aKD2KDAUH75fK+OZYiMRYTCHmd3M5vfGDfe2zuj8Mhzp1AW8K9pzeHaU/YrOIZABpOjZH46FVWTxMqNR2a6I8xdt4RTwFVM7prmC0TjO99wzPvchvYlTTLTdu1y7WyddGXqW/WOgbzVyiMpIFCrWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754524375; c=relaxed/simple;
	bh=5xTtW82Mv9yRIHCO6jImfqwBSzJM//vmSGPn9K0IJ/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cB47ilV0sYMbTFDAZvd0dOci3F8a4LB75xMCHx/vcbWaAPpsxQWt+JB7bThsRCO66wHJrn5KNt2qTWdrdp7Frvum7ht9Jf+uUnQ7dDBj1jF+0421rnKRfWHEw6kXfb0PiQTTFhZDgdfvY4MTI/CGxIMzvJ4sVex3VrlXKxhMrCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N7lwiS3E; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754524373; x=1786060373;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5xTtW82Mv9yRIHCO6jImfqwBSzJM//vmSGPn9K0IJ/4=;
  b=N7lwiS3EcB8xHW1DxFyUjM0gl+SvoiP9bb+IQm/ecaOxy2kpVmWufdLH
   hSCLm7NiPhp9ernnddDR+sbavufNOPWlN3TPHVoDJ8CPT87i160CnOkf9
   Nu2qgZujeEiYhubDg704A7sHVr1oeVpVi72X6egGfp3p84ZiA1WPcE5Kf
   gZ8iV9pwrSoMTwg2iRoodOcP/0LazpYXmFxAUKm+KwmP1N6IsyLxv5ANy
   YAcF1GpIvXFE9xEr4vbaPZkLDnXm5LsHKQlmPTfgrF0fPY5Rsg2mWLtgT
   kuaHW1S2IFmEHmmocohnM3dFK1yzZuK+xevaF7IoqezMAKJNWWRsaMmEC
   g==;
X-CSE-ConnectionGUID: G8YVAX0rSaKtGJDXOHvYHg==
X-CSE-MsgGUID: 2RIa+OsrRwun8gS+khUfsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="56929197"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="56929197"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 16:52:52 -0700
X-CSE-ConnectionGUID: Uyxsy+wiRgGG7DL8BY0JDw==
X-CSE-MsgGUID: AZGfKwRzScChBlbB/MfCgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="195741040"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 06 Aug 2025 16:52:49 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ujnw6-0002Bm-1s;
	Wed, 06 Aug 2025 23:52:46 +0000
Date: Thu, 7 Aug 2025 07:52:44 +0800
From: kernel test robot <lkp@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Takaya Saeki <takayas@google.com>, Tom Zanussi <zanussi@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ian Rogers <irogers@google.com>, aahringo@redhat.com,
	Douglas Raillard <douglas.raillard@arm.com>
Subject: Re: [PATCH 6/7] tracing: Allow syscall trace events to read more
 than one user parameter
Message-ID: <202508070706.TiTQY0Ne-lkp@intel.com>
References: <20250805193235.582013098@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805193235.582013098@kernel.org>

Hi Steven,

kernel test robot noticed the following build warnings:

[auto build test WARNING on trace/for-next]
[also build test WARNING on linus/master v6.16 next-20250806]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Steven-Rostedt/tracing-Replace-syscall-RCU-pointer-assignment-with-READ-WRITE_ONCE/20250806-122312
base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
patch link:    https://lore.kernel.org/r/20250805193235.582013098%40kernel.org
patch subject: [PATCH 6/7] tracing: Allow syscall trace events to read more than one user parameter
config: x86_64-randconfig-123-20250806 (https://download.01.org/0day-ci/archive/20250807/202508070706.TiTQY0Ne-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250807/202508070706.TiTQY0Ne-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508070706.TiTQY0Ne-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> kernel/trace/trace_syscalls.c:620:53: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got char *ptr @@
   kernel/trace/trace_syscalls.c:620:53: sparse:     expected void const [noderef] __user *from
   kernel/trace/trace_syscalls.c:620:53: sparse:     got char *ptr
>> kernel/trace/trace_syscalls.c:623:54: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected char const [noderef] __user *src @@     got char *ptr @@
   kernel/trace/trace_syscalls.c:623:54: sparse:     expected char const [noderef] __user *src
   kernel/trace/trace_syscalls.c:623:54: sparse:     got char *ptr
   kernel/trace/trace_syscalls.c:707:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct trace_event_file *trace_file @@     got struct trace_event_file [noderef] __rcu * @@
   kernel/trace/trace_syscalls.c:707:20: sparse:     expected struct trace_event_file *trace_file
   kernel/trace/trace_syscalls.c:707:20: sparse:     got struct trace_event_file [noderef] __rcu *
   kernel/trace/trace_syscalls.c:824:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct trace_event_file *trace_file @@     got struct trace_event_file [noderef] __rcu * @@
   kernel/trace/trace_syscalls.c:824:20: sparse:     expected struct trace_event_file *trace_file
   kernel/trace/trace_syscalls.c:824:20: sparse:     got struct trace_event_file [noderef] __rcu *
   kernel/trace/trace_syscalls.c:871:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct trace_event_file [noderef] __rcu *volatile @@     got struct trace_event_file *file @@
   kernel/trace/trace_syscalls.c:871:9: sparse:     expected struct trace_event_file [noderef] __rcu *volatile
   kernel/trace/trace_syscalls.c:871:9: sparse:     got struct trace_event_file *file
   kernel/trace/trace_syscalls.c:909:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct trace_event_file [noderef] __rcu *volatile @@     got struct trace_event_file *file @@
   kernel/trace/trace_syscalls.c:909:17: sparse:     expected struct trace_event_file [noderef] __rcu *volatile
   kernel/trace/trace_syscalls.c:909:17: sparse:     got struct trace_event_file *file

vim +620 kernel/trace/trace_syscalls.c

6bc850d6f8f730 Steven Rostedt 2025-08-05  526  
623bd9e046f95c Steven Rostedt 2025-08-05  527  static char *sys_fault_user(struct syscall_metadata *sys_data,
623bd9e046f95c Steven Rostedt 2025-08-05  528  			    struct syscall_buf_info *sinfo,
623bd9e046f95c Steven Rostedt 2025-08-05  529  			    unsigned long *args,
623bd9e046f95c Steven Rostedt 2025-08-05  530  			    unsigned int data_size[SYSCALL_FAULT_MAX_CNT])
6bc850d6f8f730 Steven Rostedt 2025-08-05  531  {
623bd9e046f95c Steven Rostedt 2025-08-05  532  	char *buffer = per_cpu_ptr(sinfo->sbuf, smp_processor_id())->buf;
6bc850d6f8f730 Steven Rostedt 2025-08-05  533  	unsigned long mask = sys_data->user_mask;
623bd9e046f95c Steven Rostedt 2025-08-05  534  	unsigned long size = SYSCALL_FAULT_ARG_SZ - 1;
6bc850d6f8f730 Steven Rostedt 2025-08-05  535  	unsigned int cnt;
b979d33ec48bbd Steven Rostedt 2025-08-05  536  	bool array = false;
623bd9e046f95c Steven Rostedt 2025-08-05  537  	char *ptr_array[SYSCALL_FAULT_MAX_CNT];
623bd9e046f95c Steven Rostedt 2025-08-05  538  	char *buf;
623bd9e046f95c Steven Rostedt 2025-08-05  539  	int read[SYSCALL_FAULT_MAX_CNT];
6bc850d6f8f730 Steven Rostedt 2025-08-05  540  	int trys = 0;
623bd9e046f95c Steven Rostedt 2025-08-05  541  	int uargs;
6bc850d6f8f730 Steven Rostedt 2025-08-05  542  	int ret;
623bd9e046f95c Steven Rostedt 2025-08-05  543  	int i = 0;
623bd9e046f95c Steven Rostedt 2025-08-05  544  
623bd9e046f95c Steven Rostedt 2025-08-05  545  	/* The extra is appended to the user data in the buffer */
623bd9e046f95c Steven Rostedt 2025-08-05  546  	BUILD_BUG_ON(SYSCALL_FAULT_USER_MAX + sizeof(EXTRA) >=
623bd9e046f95c Steven Rostedt 2025-08-05  547  		     SYSCALL_FAULT_ARG_SZ);
623bd9e046f95c Steven Rostedt 2025-08-05  548  
623bd9e046f95c Steven Rostedt 2025-08-05  549  	/*
623bd9e046f95c Steven Rostedt 2025-08-05  550  	 * If this system call event has a size argument, use
623bd9e046f95c Steven Rostedt 2025-08-05  551  	 * it to define how much of user space memory to read,
623bd9e046f95c Steven Rostedt 2025-08-05  552  	 * and read it as an array and not a string.
623bd9e046f95c Steven Rostedt 2025-08-05  553  	 */
623bd9e046f95c Steven Rostedt 2025-08-05  554  	if (sys_data->user_arg_size >= 0) {
623bd9e046f95c Steven Rostedt 2025-08-05  555  		array = true;
623bd9e046f95c Steven Rostedt 2025-08-05  556  		size = args[sys_data->user_arg_size];
623bd9e046f95c Steven Rostedt 2025-08-05  557  		if (size > SYSCALL_FAULT_ARG_SZ - 1)
623bd9e046f95c Steven Rostedt 2025-08-05  558  			size = SYSCALL_FAULT_ARG_SZ - 1;
623bd9e046f95c Steven Rostedt 2025-08-05  559  	}
623bd9e046f95c Steven Rostedt 2025-08-05  560  
623bd9e046f95c Steven Rostedt 2025-08-05  561  	while (mask) {
623bd9e046f95c Steven Rostedt 2025-08-05  562  		int idx = ffs(mask) - 1;
623bd9e046f95c Steven Rostedt 2025-08-05  563  		mask &= ~BIT(idx);
623bd9e046f95c Steven Rostedt 2025-08-05  564  
623bd9e046f95c Steven Rostedt 2025-08-05  565  		if (WARN_ON_ONCE(i == SYSCALL_FAULT_MAX_CNT))
623bd9e046f95c Steven Rostedt 2025-08-05  566  			break;
6bc850d6f8f730 Steven Rostedt 2025-08-05  567  
6bc850d6f8f730 Steven Rostedt 2025-08-05  568  		/* Get the pointer to user space memory to read */
623bd9e046f95c Steven Rostedt 2025-08-05  569  		ptr_array[i++] = (char *)args[idx];
623bd9e046f95c Steven Rostedt 2025-08-05  570  	}
623bd9e046f95c Steven Rostedt 2025-08-05  571  
623bd9e046f95c Steven Rostedt 2025-08-05  572  	uargs = i;
623bd9e046f95c Steven Rostedt 2025-08-05  573  
623bd9e046f95c Steven Rostedt 2025-08-05  574  	/* Clear the values that are not used */
623bd9e046f95c Steven Rostedt 2025-08-05  575  	for (; i < SYSCALL_FAULT_MAX_CNT; i++) {
623bd9e046f95c Steven Rostedt 2025-08-05  576  		data_size[i] = -1; /* Denotes no pointer */
623bd9e046f95c Steven Rostedt 2025-08-05  577  	}
6bc850d6f8f730 Steven Rostedt 2025-08-05  578  
6bc850d6f8f730 Steven Rostedt 2025-08-05  579   again:
6bc850d6f8f730 Steven Rostedt 2025-08-05  580  	/*
6bc850d6f8f730 Steven Rostedt 2025-08-05  581  	 * If this task is preempted by another user space task, it
6bc850d6f8f730 Steven Rostedt 2025-08-05  582  	 * will cause this task to try again. But just in case something
6bc850d6f8f730 Steven Rostedt 2025-08-05  583  	 * changes where the copying from user space causes another task
6bc850d6f8f730 Steven Rostedt 2025-08-05  584  	 * to run, prevent this from going into an infinite loop.
6bc850d6f8f730 Steven Rostedt 2025-08-05  585  	 * 10 tries should be plenty.
6bc850d6f8f730 Steven Rostedt 2025-08-05  586  	 */
6bc850d6f8f730 Steven Rostedt 2025-08-05  587  	if (trys++ > 10) {
6bc850d6f8f730 Steven Rostedt 2025-08-05  588  		static bool once;
6bc850d6f8f730 Steven Rostedt 2025-08-05  589  		/*
6bc850d6f8f730 Steven Rostedt 2025-08-05  590  		 * Only print a message instead of a WARN_ON() as this could
6bc850d6f8f730 Steven Rostedt 2025-08-05  591  		 * theoretically trigger under real load.
6bc850d6f8f730 Steven Rostedt 2025-08-05  592  		 */
6bc850d6f8f730 Steven Rostedt 2025-08-05  593  		if (!once)
6bc850d6f8f730 Steven Rostedt 2025-08-05  594  			pr_warn("Error: Too many tries to read syscall %s\n", sys_data->name);
6bc850d6f8f730 Steven Rostedt 2025-08-05  595  		once = true;
623bd9e046f95c Steven Rostedt 2025-08-05  596  		return buffer;
6bc850d6f8f730 Steven Rostedt 2025-08-05  597  	}
6bc850d6f8f730 Steven Rostedt 2025-08-05  598  
6bc850d6f8f730 Steven Rostedt 2025-08-05  599  	/* Read the current sched switch count */
6bc850d6f8f730 Steven Rostedt 2025-08-05  600  	cnt = this_cpu_read(sched_switch_cnt);
6bc850d6f8f730 Steven Rostedt 2025-08-05  601  
6bc850d6f8f730 Steven Rostedt 2025-08-05  602  	/*
6bc850d6f8f730 Steven Rostedt 2025-08-05  603  	 * Preemption is going to be enabled, but this task must
6bc850d6f8f730 Steven Rostedt 2025-08-05  604  	 * remain on this CPU.
6bc850d6f8f730 Steven Rostedt 2025-08-05  605  	 */
6bc850d6f8f730 Steven Rostedt 2025-08-05  606  	migrate_disable();
6bc850d6f8f730 Steven Rostedt 2025-08-05  607  
6bc850d6f8f730 Steven Rostedt 2025-08-05  608  	/*
6bc850d6f8f730 Steven Rostedt 2025-08-05  609  	 * Now preemption is being enabed and another task can come in
6bc850d6f8f730 Steven Rostedt 2025-08-05  610  	 * and use the same buffer and corrupt our data.
6bc850d6f8f730 Steven Rostedt 2025-08-05  611  	 */
6bc850d6f8f730 Steven Rostedt 2025-08-05  612  	preempt_enable_notrace();
6bc850d6f8f730 Steven Rostedt 2025-08-05  613  
623bd9e046f95c Steven Rostedt 2025-08-05  614  	buf = buffer;
623bd9e046f95c Steven Rostedt 2025-08-05  615  
623bd9e046f95c Steven Rostedt 2025-08-05  616  	for (i = 0; i < uargs; i++, buf += SYSCALL_FAULT_ARG_SZ) {
623bd9e046f95c Steven Rostedt 2025-08-05  617  		char *ptr = ptr_array[i];
623bd9e046f95c Steven Rostedt 2025-08-05  618  
b979d33ec48bbd Steven Rostedt 2025-08-05  619  		if (array) {
b979d33ec48bbd Steven Rostedt 2025-08-05 @620  			ret = __copy_from_user(buf, ptr, size);
b979d33ec48bbd Steven Rostedt 2025-08-05  621  			ret = ret ? -1 : size;
b979d33ec48bbd Steven Rostedt 2025-08-05  622  		} else {
6bc850d6f8f730 Steven Rostedt 2025-08-05 @623  			ret = strncpy_from_user(buf, ptr, size);
b979d33ec48bbd Steven Rostedt 2025-08-05  624  		}
623bd9e046f95c Steven Rostedt 2025-08-05  625  		read[i] = ret;
623bd9e046f95c Steven Rostedt 2025-08-05  626  	}
6bc850d6f8f730 Steven Rostedt 2025-08-05  627  
6bc850d6f8f730 Steven Rostedt 2025-08-05  628  	preempt_disable_notrace();
6bc850d6f8f730 Steven Rostedt 2025-08-05  629  	migrate_enable();
6bc850d6f8f730 Steven Rostedt 2025-08-05  630  
6bc850d6f8f730 Steven Rostedt 2025-08-05  631  	/*
6bc850d6f8f730 Steven Rostedt 2025-08-05  632  	 * Preemption is disabled again, now check the sched_switch_cnt.
6bc850d6f8f730 Steven Rostedt 2025-08-05  633  	 * If it increased by two or more, then another user space process
6bc850d6f8f730 Steven Rostedt 2025-08-05  634  	 * may have schedule in and corrupted our buffer. In that case
6bc850d6f8f730 Steven Rostedt 2025-08-05  635  	 * the copying must be retried.
6bc850d6f8f730 Steven Rostedt 2025-08-05  636  	 *
6bc850d6f8f730 Steven Rostedt 2025-08-05  637  	 * Note, if this task was scheduled out and only kernel threads
6bc850d6f8f730 Steven Rostedt 2025-08-05  638  	 * were scheduled in (maybe to process the fault), then the
6bc850d6f8f730 Steven Rostedt 2025-08-05  639  	 * counter would increment again when this task scheduled in.
6bc850d6f8f730 Steven Rostedt 2025-08-05  640  	 * If this task scheduled out and another user task scheduled
6bc850d6f8f730 Steven Rostedt 2025-08-05  641  	 * in, this task would still need to be scheduled back in and
6bc850d6f8f730 Steven Rostedt 2025-08-05  642  	 * the counter would increment by at least two.
6bc850d6f8f730 Steven Rostedt 2025-08-05  643  	 */
6bc850d6f8f730 Steven Rostedt 2025-08-05  644  	if (this_cpu_read(sched_switch_cnt) > cnt + 1)
6bc850d6f8f730 Steven Rostedt 2025-08-05  645  		goto again;
6bc850d6f8f730 Steven Rostedt 2025-08-05  646  
623bd9e046f95c Steven Rostedt 2025-08-05  647  	buf = buffer;
623bd9e046f95c Steven Rostedt 2025-08-05  648  	for (i = 0; i < uargs; i++, buf += SYSCALL_FAULT_ARG_SZ) {
623bd9e046f95c Steven Rostedt 2025-08-05  649  
623bd9e046f95c Steven Rostedt 2025-08-05  650  		ret = read[i];
623bd9e046f95c Steven Rostedt 2025-08-05  651  		if (ret < 0)
623bd9e046f95c Steven Rostedt 2025-08-05  652  			continue;
623bd9e046f95c Steven Rostedt 2025-08-05  653  		buf[ret] = '\0';
623bd9e046f95c Steven Rostedt 2025-08-05  654  
b979d33ec48bbd Steven Rostedt 2025-08-05  655  		/* For strings, replace any non-printable characters with '.' */
b979d33ec48bbd Steven Rostedt 2025-08-05  656  		if (!array) {
623bd9e046f95c Steven Rostedt 2025-08-05  657  			for (int x = 0; x < ret; x++) {
623bd9e046f95c Steven Rostedt 2025-08-05  658  				if (!isprint(buf[x]))
623bd9e046f95c Steven Rostedt 2025-08-05  659  					buf[x] = '.';
6bc850d6f8f730 Steven Rostedt 2025-08-05  660  			}
6bc850d6f8f730 Steven Rostedt 2025-08-05  661  
6bc850d6f8f730 Steven Rostedt 2025-08-05  662  			/*
623bd9e046f95c Steven Rostedt 2025-08-05  663  			 * If the text was truncated due to our max limit,
623bd9e046f95c Steven Rostedt 2025-08-05  664  			 * add "..." to the string.
6bc850d6f8f730 Steven Rostedt 2025-08-05  665  			 */
623bd9e046f95c Steven Rostedt 2025-08-05  666  			if (ret > SYSCALL_FAULT_USER_MAX) {
623bd9e046f95c Steven Rostedt 2025-08-05  667  				strscpy(buf + SYSCALL_FAULT_USER_MAX, EXTRA,
623bd9e046f95c Steven Rostedt 2025-08-05  668  					sizeof(EXTRA));
623bd9e046f95c Steven Rostedt 2025-08-05  669  				ret = SYSCALL_FAULT_USER_MAX + sizeof(EXTRA);
6bc850d6f8f730 Steven Rostedt 2025-08-05  670  			} else {
6bc850d6f8f730 Steven Rostedt 2025-08-05  671  				buf[ret++] = '\0';
6bc850d6f8f730 Steven Rostedt 2025-08-05  672  			}
623bd9e046f95c Steven Rostedt 2025-08-05  673  		} else {
623bd9e046f95c Steven Rostedt 2025-08-05  674  			ret = min(ret, SYSCALL_FAULT_USER_MAX);
623bd9e046f95c Steven Rostedt 2025-08-05  675  		}
623bd9e046f95c Steven Rostedt 2025-08-05  676  		data_size[i] = ret;
b979d33ec48bbd Steven Rostedt 2025-08-05  677  	}
6bc850d6f8f730 Steven Rostedt 2025-08-05  678  
623bd9e046f95c Steven Rostedt 2025-08-05  679  	return buffer;
6bc850d6f8f730 Steven Rostedt 2025-08-05  680  }
6bc850d6f8f730 Steven Rostedt 2025-08-05  681  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

