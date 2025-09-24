Return-Path: <linux-kernel+bounces-830899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A666AB9AD33
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 18:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66A5D2E844D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 16:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CBB30FF0D;
	Wed, 24 Sep 2025 16:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d5c4IkFp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAEB1D8E01
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758730540; cv=none; b=tWXjzOt9+eHsRZcWElk7TmnbzltE3viGUMqqjQX0hhmVomzIA8dUwNocXiaXgrY+w3A6OxTfkQDNLYSpjas5TN1MhKyVTrZCqA5lf01sJOkroQz3u8QtMImMVXstEestHQ8Px0f8UY7RT+FAxGmacz+QMXKohid9mjqeBch8NXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758730540; c=relaxed/simple;
	bh=bi4gRLMOEYQ2h/l3rwr1csS9TI2KAc73OlB0ZPRYjfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aS+vNnVIBYFTfUAwdzqA2rfcrShsrCC9nd6eaGckqpcQhQ5jLTwjYOhWmJHuamJs7TMdbwbLPXsccdwkQ86plarYRRq7y1Y0ybxRTc7mMHNpIL2/M987UuDubzY9Nh41QGbMckHsW3h14BPXG4+7/N3Lg9YI5UWtusIqs96bfCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d5c4IkFp; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758730538; x=1790266538;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=bi4gRLMOEYQ2h/l3rwr1csS9TI2KAc73OlB0ZPRYjfM=;
  b=d5c4IkFpPHNaQH/WtNETNUn0Yd/EQ7xE1n5ZEJj//NgQUmegisgn+/tr
   Pbu1vYI44nYDKVXkf0GkuWaXzWu9KbfIhk/85DqlWZPIh1z9XKV4umoF+
   tQoGgmvqjpwB93kL2RjTnEQAwdusfbxMcgwAXgZSyqTfX1hQdXPUaO8ML
   fJ+ehMftwHDNz4cxSX6U/JzEUsrIJUuoOs0xs8CZ3ewosXANTa/Y/Duig
   a7VbB0lyH1xG9QzijWxqTfRkk94VW/kaBqYs8kPMROKUX9HU0Ned+pqtf
   41uC7gsYOJy4PG0du6BN/reDVV7tpnd2oGSUsF8Ox3fMrE/rgwZqHsgPr
   w==;
X-CSE-ConnectionGUID: UnBPFwYBTgSPC4R5WZeP7g==
X-CSE-MsgGUID: n4HYZstkRxCI3sfj+haa9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="78669724"
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="78669724"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 09:15:37 -0700
X-CSE-ConnectionGUID: 7oSlFp+vQROTlisSCNkmHw==
X-CSE-MsgGUID: YSOfpJeeS32pzCuJ+OKt6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="176918617"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 24 Sep 2025 09:15:36 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v1S9V-0004Jx-0A;
	Wed, 24 Sep 2025 16:15:33 +0000
Date: Thu, 25 Sep 2025 00:15:17 +0800
From: kernel test robot <lkp@intel.com>
To: buckzhang1212@yeah.net, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, buckzhang1212@yeah.net
Subject: Re: [PATCH] locking/mutex:add MUTEX_CHCEK_INIT to detect
 uninitialized mutex lock
Message-ID: <202509242322.VggjpcD5-lkp@intel.com>
References: <20250924022500.2577-1-buckzhang1212@yeah.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250924022500.2577-1-buckzhang1212@yeah.net>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/locking/core]
[also build test WARNING on linus/master v6.17-rc7 next-20250923]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/buckzhang1212-yeah-net/locking-mutex-add-MUTEX_CHCEK_INIT-to-detect-uninitialized-mutex-lock/20250924-103805
base:   tip/locking/core
patch link:    https://lore.kernel.org/r/20250924022500.2577-1-buckzhang1212%40yeah.net
patch subject: [PATCH] locking/mutex:add MUTEX_CHCEK_INIT to detect uninitialized mutex lock
config: i386-randconfig-014-20250924 (https://download.01.org/0day-ci/archive/20250924/202509242322.VggjpcD5-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250924/202509242322.VggjpcD5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509242322.VggjpcD5-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/locking/mutex.c:46:13: warning: 'mutex_check_waitlist' defined but not used [-Wunused-function]
      46 | static void mutex_check_waitlist(struct mutex *lock)
         |             ^~~~~~~~~~~~~~~~~~~~


vim +/mutex_check_waitlist +46 kernel/locking/mutex.c

    39	
    40	#ifdef CONFIG_DEBUG_MUTEXES
    41	# define MUTEX_WARN_ON(cond) DEBUG_LOCKS_WARN_ON(cond)
    42	#else
    43	# define MUTEX_WARN_ON(cond)
    44	#endif
    45	#define MUTEX_CHCEK_INIT(lock)  mutex_check_waitlist(lock)
  > 46	static void mutex_check_waitlist(struct mutex *lock)
    47	{
    48		struct list_head *list = &lock->wait_list;
    49	
    50		if ((unsigned long)list->next < PAGE_OFFSET) {
    51			pr_err("BUG: mutex lock is uninitialized，wait_list is Error\n");
    52			MUTEX_WARN_ON("mutex lock is uninitialized");
    53		}
    54	}
    55	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

