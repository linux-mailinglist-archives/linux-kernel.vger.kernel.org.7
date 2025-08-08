Return-Path: <linux-kernel+bounces-760655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7F3B1EE43
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 20:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11811188BF95
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 18:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60D3215191;
	Fri,  8 Aug 2025 18:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eO1yzf70"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48F81DA3D
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 18:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754676879; cv=none; b=Vdb7vgohPcHCGtl+cYdnFr8Gnzj+KMpOabYMUEzIzxKvG8wgFje55/cYd5OeI8607rilv7i+LrTbVYBHR5N7nBOlUWMBV6S9nC7Dtq+eO7HhlttDDP9vn6nAioAKQTW68XNZSZuijoKZ+ilqj/+R8YrZfUogHpUJmM7TJA+Zc1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754676879; c=relaxed/simple;
	bh=jasLUExJ47MKUq1i0giM8qJ7AngHU2ackEGzfY43fco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iDa357hgVTlnDL8vNCa67ZP9ynWidlN5qUOuLzr28QrW2SX1/nS72DSrxBU0HrXsAJU3/Je9ut17wiAQQLE7MwQgKvMOYL7uQwjoAnvy5x5UYBxN+ZcI5uJ+43/r9Ur0CyfBCw6OeEAoirF+L6RTn4KDTBLwSU/Pm7QtAZrSLro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eO1yzf70; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754676878; x=1786212878;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jasLUExJ47MKUq1i0giM8qJ7AngHU2ackEGzfY43fco=;
  b=eO1yzf70CI11P+gvsIM61TMKIiyhMBpBST7ZFTzDRoIP3haKM6GTIlrO
   juS7Hh63oRyGsAT4oXdOpubDb1j8O2zHwIho+kUWs1lYCrMrIH7/tYfw/
   /cwsnNs0MTpj2GPGu7/fvvOkdDDcCzq2eaqhW2M6VwoA/uoMrgQEiGMQU
   9t/4AGqB/fuGINJeLvnjLQj2uobrDw1yw5E4fBmO6lQMeoEoVgWQFFyPA
   4dk69ICwbVrQKbRTn62Jx3MHFYf/bzFWdpAKmWaYwVaHryMgvtdizXTuf
   lD+qYjVlPbQuPbhpHYOSClqycYIdS5ShNtOm3fk7Chwq31swqRFLGFUQp
   Q==;
X-CSE-ConnectionGUID: Ck6m0yKARAyciSunR3oYHg==
X-CSE-MsgGUID: rLgxnVc8RkK5pPUuWmjScg==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="57108930"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="57108930"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 11:14:37 -0700
X-CSE-ConnectionGUID: tGs8YgAcSvikbWwLjq0/wQ==
X-CSE-MsgGUID: t5/iCW9mReaTpoT5KUD0zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="165797520"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 08 Aug 2025 11:14:34 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ukRbl-0004Bo-2x;
	Fri, 08 Aug 2025 18:14:28 +0000
Date: Sat, 9 Aug 2025 02:14:11 +0800
From: kernel test robot <lkp@intel.com>
To: Pranav Tyagi <pranav.tyagi03@gmail.com>, tglx@linutronix.de,
	mingo@redhat.com, peterz@infradead.org, dvhart@infradead.org,
	dave@stgolabs.net, andrealmeid@igalia.com,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, jann@thejh.net, keescook@chromium.org,
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev,
	Pranav Tyagi <pranav.tyagi03@gmail.com>
Subject: Re: [PATCH v3] futex: don't leak robust_list pointer on exec race
Message-ID: <202508090125.VIm8fAXD-lkp@intel.com>
References: <20250805154725.22031-1-pranav.tyagi03@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805154725.22031-1-pranav.tyagi03@gmail.com>

Hi Pranav,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/locking/core]
[also build test ERROR on linus/master v6.16 next-20250808]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pranav-Tyagi/futex-don-t-leak-robust_list-pointer-on-exec-race/20250806-121303
base:   tip/locking/core
patch link:    https://lore.kernel.org/r/20250805154725.22031-1-pranav.tyagi03%40gmail.com
patch subject: [PATCH v3] futex: don't leak robust_list pointer on exec race
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20250809/202508090125.VIm8fAXD-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 7b8dea265e72c3037b6b1e54d5ab51b7e14f328b)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250809/202508090125.VIm8fAXD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508090125.VIm8fAXD-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/futex/syscalls.c:72:13: error: no member named 'compat_robust_list' in 'struct task_struct'
      72 |                 head = p->compat_robust_list;
         |                        ~  ^
   1 error generated.


vim +72 kernel/futex/syscalls.c

    41	
    42	static void __user *get_robust_list_common(int pid, bool compat)
    43	{
    44		struct task_struct *p;
    45		void __user *head;
    46		unsigned long ret;
    47	
    48		p = current;
    49	
    50		scoped_guard(rcu) {
    51			if (pid) {
    52				p = find_task_by_vpid(pid);
    53				if (!p)
    54					return (void __user *)ERR_PTR(-ESRCH);
    55			}
    56			get_task_struct(p);
    57		}
    58	
    59		/*
    60		 * Hold exec_update_lock to serialize with concurrent exec()
    61		 * so ptrace_may_access() is checked against stable credentials
    62		 */
    63		ret = down_read_killable(&p->signal->exec_update_lock);
    64		if (ret)
    65			goto err_put;
    66	
    67		ret = -EPERM;
    68		if (!ptrace_may_access(p, PTRACE_MODE_READ_REALCREDS))
    69			goto err_unlock;
    70	
    71		if (IS_ENABLED(CONFIG_COMPAT) && compat)
  > 72			head = p->compat_robust_list;
    73		else
    74			head = p->robust_list;
    75	
    76		up_read(&p->signal->exec_update_lock);
    77		put_task_struct(p);
    78	
    79		return head;
    80	
    81	err_unlock:
    82		up_read(&p->signal->exec_update_lock);
    83	err_put:
    84		put_task_struct(p);
    85		return (void __user *)ERR_PTR(ret);
    86	}
    87	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

