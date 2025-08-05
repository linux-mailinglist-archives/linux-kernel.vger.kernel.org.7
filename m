Return-Path: <linux-kernel+bounces-756839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DC8B1BA0D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 20:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C317A184A8E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 18:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523F129826A;
	Tue,  5 Aug 2025 18:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EKRDaszx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317552980AC
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 18:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754418486; cv=none; b=tZFYiys0byaOgVvMPg48bV3EIqkDangc9R2J/zhSbn5K3rgjIwv43rSlScg4P4qa1ML/E6okIa757oK8s1s6J5XPV/s/cxf9Ebq7kEbLcTw43YH9vtmG9ybLo8HtBf31epSmz2oIme9GHCQNBc8TxKPXszK7WrQzyaPjtiwRy20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754418486; c=relaxed/simple;
	bh=FOQvbQRSUGjE8iHkF54qWCgx7Osq1+scC09ZUtIWw/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J5aKR0KIwgcNyN0WintRz/OLwO/lGqB6nPOE38zqJmGg+7I5dSM88BXtwRdDbzUrlStBzYebTbr97mPqdovjLzhrgSnk4oL3a2tOkgT0KoukvmPWy+wLgLjaj/xq0bA+8ChJQOTUx62TMLN30rZVWTaLdjOOfgT2LM+uJBq5ixM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EKRDaszx; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754418485; x=1785954485;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FOQvbQRSUGjE8iHkF54qWCgx7Osq1+scC09ZUtIWw/A=;
  b=EKRDaszxqSbEJEJlH44dvAPsVYT6ed4IHLZPLEotD2kh6bmu8vVRQLvs
   G+rQKgQomcqZNvBTTzqb74+WWd6KIUWYt4B4Oh2C00xppIXBvhcIotb6s
   LNNJRUlG4Z9UuIc//LlpjaDlEHOACXCAtCE/u4ONn8k1hNM5vIyfYYI6F
   gj5+5qhcwSdCHpApVBRTUUvOv/2VDAdZtVR3CGKWWLUX0v5ROWWRuDKs+
   gUz/uiaiamkEwdr/Qbu6QZfiq1f+GyD5akVBZcWN4RA94gvnFBLxZxWYr
   USl5JXlCvIae07HQojiATVXyNJS6W/TciAlZL5nelwcdjrwZ6Zdc86/HT
   A==;
X-CSE-ConnectionGUID: 8WEPM9yvTQ+nqdIrRxnK8g==
X-CSE-MsgGUID: tFcrQYX7SdSUuU9Uff6s7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11513"; a="66992615"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="66992615"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 11:28:05 -0700
X-CSE-ConnectionGUID: HJk/SMxGQamMDyloygqm8Q==
X-CSE-MsgGUID: r7PwQAe7Q5qDQVfpgsDeTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="164929326"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 05 Aug 2025 11:28:02 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ujMOF-0000kI-2i;
	Tue, 05 Aug 2025 18:27:59 +0000
Date: Wed, 6 Aug 2025 02:27:15 +0800
From: kernel test robot <lkp@intel.com>
To: Pranav Tyagi <pranav.tyagi03@gmail.com>, tglx@linutronix.de,
	mingo@redhat.com, peterz@infradead.org, dvhart@infradead.org,
	dave@stgolabs.net, andrealmeid@igalia.com,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, jann@thejh.net, keescook@chromium.org,
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev,
	Pranav Tyagi <pranav.tyagi03@gmail.com>
Subject: Re: [PATCH v2] futex: don't leak robust_list pointer on exec race
Message-ID: <202508060225.urZa7B2V-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/locking/core]
[also build test WARNING on linus/master v6.16 next-20250805]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pranav-Tyagi/futex-don-t-leak-robust_list-pointer-on-exec-race/20250804-195739
base:   tip/locking/core
patch link:    https://lore.kernel.org/r/20250804115533.14186-1-pranav.tyagi03%40gmail.com
patch subject: [PATCH v2] futex: don't leak robust_list pointer on exec race
config: x86_64-randconfig-r132-20250805 (https://download.01.org/0day-ci/archive/20250806/202508060225.urZa7B2V-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250806/202508060225.urZa7B2V-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508060225.urZa7B2V-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> kernel/futex/syscalls.c:64:39: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __user * @@     got void * @@
   kernel/futex/syscalls.c:64:39: sparse:     expected void [noderef] __user *
   kernel/futex/syscalls.c:64:39: sparse:     got void *
   kernel/futex/syscalls.c:94:23: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __user * @@     got void * @@
   kernel/futex/syscalls.c:94:23: sparse:     expected void [noderef] __user *
   kernel/futex/syscalls.c:94:23: sparse:     got void *

vim +64 kernel/futex/syscalls.c

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
  > 64				return ERR_PTR(-ESRCH);
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
    81			head = p->compat_robust_list;
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

