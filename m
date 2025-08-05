Return-Path: <linux-kernel+bounces-756155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A5DB1B09A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 11:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FAF63A535F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 09:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE79E259C92;
	Tue,  5 Aug 2025 09:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GoK87ADp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897DA1D63DF
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 09:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754384507; cv=none; b=JbGQi3tPQ/67vLl7egFKX0+yjH5U7TPrJHoX6dslQeAV1odsgmUksNELKh0APW4Iek9KvUEr8gE+8ZN9R6SJUavBCq8Tqk28uyeP+uUCeXfUR8uJuzY9D8ySuJg7Y7dCxVdXnmXEaX+wT6a4nyoIuhbxNT+kMKJfAWKu93rbAlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754384507; c=relaxed/simple;
	bh=RDyUgR2PQ1GVGOThtsglLFcL8GrDSPC0hME5I1Gf3Ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8F8VTdrBF+yyVEMqL/z0F8hHDP0MtgtRRbV4R3xlLguaYg3gD/ls/463BaBljNqht5p0OqywYtu7WxcNDT4sjBHWXzwXQmq/97DvbIH3yvGl0FxWPxXF1x8bDeavR5fEvBw6fn8CxFnm/k69rt5tEEE/1g4rwxKLy8jFniBEXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GoK87ADp; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754384506; x=1785920506;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RDyUgR2PQ1GVGOThtsglLFcL8GrDSPC0hME5I1Gf3Ss=;
  b=GoK87ADpCaNYjmWhh/YiWyGSlGsd31+KGeHjGzj1qtUOtOknMQoJojyp
   +5QwaiheMaSYJAfetKZ98lqCuNW6KhzM40zh89TSAGS0hAZkRzjynGoel
   Bpyvu2/rDbAuSc92zJYLHv+ElDfTlOiQYO9QDK4PxrXUtY0DW6sZ5DtRz
   rtJma7vJT2a06SErI6MPqK5sPkJ4ViG/bN0oq3Bm4AF0RRgcrjXF+kzWM
   WPQM5b3vNh1Qw1P2EzwY4EvulLNdKeIHQh7+6kqH0/t9ka8xjuPrfXDem
   V2MaKOWj+1YU8HWq6X6tng/WB36BqHGFsax8rmdGI3kSOz+fMHL3baUIe
   w==;
X-CSE-ConnectionGUID: O58GPA1nTTyq2/XTfdJidw==
X-CSE-MsgGUID: x5C7vjXFS0m544cQc31pQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11512"; a="68120313"
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; 
   d="scan'208";a="68120313"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 02:01:43 -0700
X-CSE-ConnectionGUID: HPiZt80WRHmf5Ze8zQ44Jw==
X-CSE-MsgGUID: Gzy1SfDaRceL5UHtY83ftA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; 
   d="scan'208";a="168862744"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 05 Aug 2025 02:01:39 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ujDY8-0000Ue-2g;
	Tue, 05 Aug 2025 09:01:36 +0000
Date: Tue, 5 Aug 2025 17:01:34 +0800
From: kernel test robot <lkp@intel.com>
To: Pranav Tyagi <pranav.tyagi03@gmail.com>, tglx@linutronix.de,
	mingo@redhat.com, peterz@infradead.org, dvhart@infradead.org,
	dave@stgolabs.net, andrealmeid@igalia.com,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, jann@thejh.net,
	keescook@chromium.org, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	Pranav Tyagi <pranav.tyagi03@gmail.com>
Subject: Re: [PATCH v2] futex: don't leak robust_list pointer on exec race
Message-ID: <202508051607.VJkmdtGV-lkp@intel.com>
References: <20250804115533.14186-1-pranav.tyagi03@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804115533.14186-1-pranav.tyagi03@gmail.com>

Hi Pranav,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/locking/core]
[also build test ERROR on linus/master v6.16 next-20250805]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pranav-Tyagi/futex-don-t-leak-robust_list-pointer-on-exec-race/20250804-195739
base:   tip/locking/core
patch link:    https://lore.kernel.org/r/20250804115533.14186-1-pranav.tyagi03%40gmail.com
patch subject: [PATCH v2] futex: don't leak robust_list pointer on exec race
config: riscv-randconfig-001-20250805 (https://download.01.org/0day-ci/archive/20250805/202508051607.VJkmdtGV-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250805/202508051607.VJkmdtGV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508051607.VJkmdtGV-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/futex/syscalls.c:81:13: error: no member named 'compat_robust_list' in 'struct task_struct'
      81 |                 head = p->compat_robust_list;
         |                        ~  ^
   1 error generated.


vim +81 kernel/futex/syscalls.c

    41	
    42	static void __user *get_robust_list_common(int pid,
    43			bool compat)
    44	{
    45		void __user *head;
    46		unsigned long ret;
    47	
    48		struct task_struct *p;
    49	
    50		if (!pid) {
    51			p = current;
    52			get_task_struct(p);
    53		} else {
    54			rcu_read_lock();
    55			p = find_task_by_vpid(pid);
    56			/*
    57			 * pin the task to permit dropping the RCU read lock before
    58			 * acquiring the semaphore
    59			 */
    60			if (p)
    61				get_task_struct(p);
    62			rcu_read_unlock();
    63			if (!p)
    64				return ERR_PTR(-ESRCH);
    65		}
    66	
    67		/*
    68		 * Hold exec_update_lock to serialize with concurrent exec()
    69		 * so ptrace_may_access() is checked against stable credentials
    70		 */
    71	
    72		ret = down_read_killable(&p->signal->exec_update_lock);
    73		if (ret)
    74			goto err_put;
    75	
    76		ret = -EPERM;
    77		if (!ptrace_may_access(p, PTRACE_MODE_READ_REALCREDS))
    78			goto err_unlock;
    79	
    80		if (compat)
  > 81			head = p->compat_robust_list;
    82		else
    83			head = p->robust_list;
    84	
    85		up_read(&p->signal->exec_update_lock);
    86		put_task_struct(p);
    87	
    88		return head;
    89	
    90	err_unlock:
    91		up_read(&p->signal->exec_update_lock);
    92	err_put:
    93		put_task_struct(p);
    94		return ERR_PTR(ret);
    95	}
    96	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

