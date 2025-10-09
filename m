Return-Path: <linux-kernel+bounces-847403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F9ABCAB80
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 21:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D31F61A65491
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 19:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE102258ED1;
	Thu,  9 Oct 2025 19:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oKeExOQ+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CCF1B423B
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 19:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760038838; cv=none; b=M6EuG4dIn+KXv7j0nUF532x9/YIKCuTA+GqiNCJEFsg6JdD1O6fviIH+ummsTRU/+7Q4EnUWUsAJowPkzyAF2omXkknAWM/TxW6fUeo6LBIKUSKuG8iR6w15IpxvW3fFinmPl0rZxhzGFzskO+HG6umhOK3tkiCrWWcZw+A7dGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760038838; c=relaxed/simple;
	bh=s9+Yrni+QqOzxGduaFuMdR1jUz13vxS1Vd6ubw1Ixhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UlpIOIujffV2P7DoQeM2zr/nXBQpJcklL0S/FxgT82d8vHpTY0TI7YQJSXhpgFWH/4zRWgtwbP9wSIW6jeAPXMwmM0QkqKBhZCMZqN+C3aRBrINBSxgjV5EarM4+3DCxP/dYCHe696FKZgzU8nvC4qhiZ4ydHSF3hSm4FOUBWCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oKeExOQ+; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760038836; x=1791574836;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=s9+Yrni+QqOzxGduaFuMdR1jUz13vxS1Vd6ubw1Ixhw=;
  b=oKeExOQ+L37BYzSJcZLt6fHBPyiPzv1g8TG2SNeTD9WfsljswLTPq9kU
   0f1McRU3en3u5izCp1hIGwpHC+D+ahtuEpBETvtxjqZGVE9t1BqPSslUy
   9s4wJxepIHh0oLdlzG5i2h+JTVefx3XKP2yjKzWfAUjVBpYF2KOauXk/O
   Zc4myaNbWMi6b30zMB9IiUEU4qLK4eGvgRIJu8i8wClKvABcCuY9fbcbw
   cOHhuZW9xAKJHJEHeaxysmt7gaGQ64CjsosojKy4ctPK7Td34dvqbVZR3
   qQzewQ2MHFrb7J6DMHy+AW9rzSselFfR0GuWW7tzd9dFNOElBbxeYUV3I
   w==;
X-CSE-ConnectionGUID: 7UJFmf7OT8W16KJJ/P96tw==
X-CSE-MsgGUID: q1ojgbM1TxGqH3RFypB+SA==
X-IronPort-AV: E=McAfee;i="6800,10657,11577"; a="66114409"
X-IronPort-AV: E=Sophos;i="6.19,217,1754982000"; 
   d="scan'208";a="66114409"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 12:40:36 -0700
X-CSE-ConnectionGUID: g7n3pGkOTR+meJ82k4WEUg==
X-CSE-MsgGUID: Ehccs8cHReuk5eO1PxwHAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,217,1754982000"; 
   d="scan'208";a="185179416"
Received: from lkp-server01.sh.intel.com (HELO 6a630e8620ab) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 09 Oct 2025 12:40:33 -0700
Received: from kbuild by 6a630e8620ab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v6wV5-0001KF-29;
	Thu, 09 Oct 2025 19:40:31 +0000
Date: Fri, 10 Oct 2025 03:40:28 +0800
From: kernel test robot <lkp@intel.com>
To: Aaron Tomlin <atomlin@atomlin.com>, gregkh@linuxfoundation.org,
	rafael@kernel.org, dakr@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, riel@surriel.com,
	frederic@kernel.org, atomlin@atomlin.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tick/nohz: avoid showing '(null)' if nohz_full= not set
Message-ID: <202510100304.IpfE7EKh-lkp@intel.com>
References: <20251006005824.76187-1-atomlin@atomlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006005824.76187-1-atomlin@atomlin.com>

Hi Aaron,

kernel test robot noticed the following build warnings:

[auto build test WARNING on driver-core/driver-core-testing]
[also build test WARNING on driver-core/driver-core-next driver-core/driver-core-linus linus/master v6.17 next-20251009]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Aaron-Tomlin/tick-nohz-avoid-showing-null-if-nohz_full-not-set/20251009-142404
base:   driver-core/driver-core-testing
patch link:    https://lore.kernel.org/r/20251006005824.76187-1-atomlin%40atomlin.com
patch subject: [PATCH] tick/nohz: avoid showing '(null)' if nohz_full= not set
config: x86_64-randconfig-078-20251009 (https://download.01.org/0day-ci/archive/20251010/202510100304.IpfE7EKh-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251010/202510100304.IpfE7EKh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510100304.IpfE7EKh-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/base/cpu.c:307:10: warning: address of array 'tick_nohz_full_mask' will always evaluate to 'true' [-Wpointer-bool-conversion]
     307 |         return !tick_nohz_full_mask ?
         |                ~^~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +307 drivers/base/cpu.c

   302	
   303	#ifdef CONFIG_NO_HZ_FULL
   304	static ssize_t print_cpus_nohz_full(struct device *dev,
   305					    struct device_attribute *attr, char *buf)
   306	{
 > 307		return !tick_nohz_full_mask ?
   308			sysfs_emit(buf, "\n") :
   309			sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(tick_nohz_full_mask));
   310	}
   311	static DEVICE_ATTR(nohz_full, 0444, print_cpus_nohz_full, NULL);
   312	#endif
   313	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

