Return-Path: <linux-kernel+bounces-862683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD70BF5E5F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 742F91887010
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA25B32ABC3;
	Tue, 21 Oct 2025 10:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VFuRWM7i"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AAD2F2603
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 10:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761044032; cv=none; b=uDIElN1tmJ/wKgMfEFiuF26kxqgB1go/VM+Kp+rFhWF7tgpIxTqH4bFDqBRLXBAcNhS+BJAzqh/y14f+wBclA14dyjBbRagfoEoxKqvRhfv+25twuZLGrP+628O5D/8eAWi7P8wp/ssP6KP9GcTkW/6QGmonxraWqbobIPxpTqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761044032; c=relaxed/simple;
	bh=z9W08tFakR4rntFVt2C/QolkYErlrqGUGVDVL7R2suo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fUhvF7xVKZjE5J3xpAyl6JVNaIhsujVeI5Egn9VCZm3L96TlD1UCBEkYYuLTRywOfhpZOFO4HIEAf4byZkd1l034hvYNGgMOT4C/sCnIXWygx+rXnH4qblYNFU7q9XKp0s40mgdMMxjmaTKq5+JSylZXGio0L37492mUUDezEEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VFuRWM7i; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761044031; x=1792580031;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z9W08tFakR4rntFVt2C/QolkYErlrqGUGVDVL7R2suo=;
  b=VFuRWM7inN9EWwGoiZgTG54YR6q8Bb41//DpK1yiRJgINOgpy/j6F0dA
   QjRIkPGSBbs4HWe/z3op/gDK2FVeIk3eCJsHugY5YZx57ETgzdx1dlsy1
   EMSUeNhlQbZ8rR+is7dMjYxSmMuGwXYi21VKovf0pBUqROWfoKrlQkVp/
   WCwG/7/yhHzYuqA7jiTle2ULdHCw95IrfKIPER6Q+qZFAyIE9vjTzBM4Q
   lEQ6LtX8ZGX1fTeiJag6SOXDkXgVEdR6cS1cZQpgTMWhpMzgOiyMUjSaX
   +ih/7ZRkXjITl34ja1ziwwuI34fcI8+qv2K9NjnyiNM8qQbVIqt7feE7R
   A==;
X-CSE-ConnectionGUID: rZRy6c0lSPKvvq2yKyMfqw==
X-CSE-MsgGUID: iYAvuaamQMazCsbXFp8NjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62198271"
X-IronPort-AV: E=Sophos;i="6.19,244,1754982000"; 
   d="scan'208";a="62198271"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 03:53:49 -0700
X-CSE-ConnectionGUID: FuZJDGqQRaWI+/fMpYk8RA==
X-CSE-MsgGUID: srHAXlx1TWm6LrffBOZKlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,244,1754982000"; 
   d="scan'208";a="214194137"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 21 Oct 2025 03:53:47 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vB9zS-000AkP-09;
	Tue, 21 Oct 2025 10:53:26 +0000
Date: Tue, 21 Oct 2025 18:52:17 +0800
From: kernel test robot <lkp@intel.com>
To: zhoumin <teczm@foxmail.com>, mingo@redhat.com
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	zhoumin <teczm@foxmail.com>
Subject: Re: [PATCH] cputime:make function static
Message-ID: <202510211821.9NudzdNn-lkp@intel.com>
References: <tencent_C04F39CA166C38A5502D7CF206688E191307@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_C04F39CA166C38A5502D7CF206688E191307@qq.com>

Hi zhoumin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/sched/core]
[also build test WARNING on linus/master v6.18-rc2 next-20251021]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/zhoumin/cputime-make-function-static/20251020-235256
base:   tip/sched/core
patch link:    https://lore.kernel.org/r/tencent_C04F39CA166C38A5502D7CF206688E191307%40qq.com
patch subject: [PATCH] cputime:make function static
config: s390-randconfig-002-20251021 (https://download.01.org/0day-ci/archive/20251021/202510211821.9NudzdNn-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251021/202510211821.9NudzdNn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510211821.9NudzdNn-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from kernel/sched/build_policy.c:57:
>> kernel/sched/cputime.c:189:13: warning: 'account_system_time' defined but not used [-Wunused-function]
     189 | static void account_system_time(struct task_struct *p, int hardirq_offset, u64 cputime)
         |             ^~~~~~~~~~~~~~~~~~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for I2C_K1
   Depends on [n]: I2C [=y] && HAS_IOMEM [=y] && (ARCH_SPACEMIT || COMPILE_TEST [=y]) && OF [=n]
   Selected by [y]:
   - MFD_SPACEMIT_P1 [=y] && HAS_IOMEM [=y] && (ARCH_SPACEMIT || COMPILE_TEST [=y]) && I2C [=y]


vim +/account_system_time +189 kernel/sched/cputime.c

   182	
   183	/*
   184	 * Account system CPU time to a process.
   185	 * @p: the process that the CPU time gets accounted to
   186	 * @hardirq_offset: the offset to subtract from hardirq_count()
   187	 * @cputime: the CPU time spent in kernel space since the last update
   188	 */
 > 189	static void account_system_time(struct task_struct *p, int hardirq_offset, u64 cputime)
   190	{
   191		int index;
   192	
   193		if ((p->flags & PF_VCPU) && (irq_count() - hardirq_offset == 0)) {
   194			account_guest_time(p, cputime);
   195			return;
   196		}
   197	
   198		if (hardirq_count() - hardirq_offset)
   199			index = CPUTIME_IRQ;
   200		else if (in_serving_softirq())
   201			index = CPUTIME_SOFTIRQ;
   202		else
   203			index = CPUTIME_SYSTEM;
   204	
   205		account_system_index_time(p, cputime, index);
   206	}
   207	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

