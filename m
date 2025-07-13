Return-Path: <linux-kernel+bounces-728915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2879DB02EF9
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 08:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BB17189AFA0
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 06:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000131B87E9;
	Sun, 13 Jul 2025 06:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ioVaZ02o"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE881804A
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 06:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752389055; cv=none; b=kGSuzA3HOnLpWJRkur+ADoEV+gtWXG212mrwRTzzZtQzI5iVQHk/7LBTKQTP9swooagqu5yqFxqLCHFbJgpcW2g8FOuwVCCJGuy7J0NEgzFuA1wcbgeNgZJkvFTNVIZVPgRNla/jDB1cwSAip106fO+lRYlnedivboWIl+lwecQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752389055; c=relaxed/simple;
	bh=V7drxRajC6ozX9k3goWA4uOuO9/Qm6hwvlFiPiFyt1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WZ+jst2q65Ldg2Og0YcZLxdhrOKU4DO863Me+ThHmNg0BDbd+ZgE02TNafLc0o/j+4iI6mv6dgtOgTeUvhsEWvJ+2CO3xtye2N5+OfeI/FE6sR2xN4UcFGq4nEJpTJZiS/vP5XtTUohD+8m4k2MUf6CPT3JOARBBFRTmBytuUvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ioVaZ02o; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752389054; x=1783925054;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V7drxRajC6ozX9k3goWA4uOuO9/Qm6hwvlFiPiFyt1A=;
  b=ioVaZ02orW/PlRM7AJQ5rxntB0KBbdfsgiFyZkA44PSx+c5NzOKTvTaS
   msm6Mjz9cJQkPCqjnYIfI32/eFEEPifuSLrx1UFORFo5zk0eMiLqPWI31
   owFIGL7GSy4N8zmnW8txYpoq33XJVQGkM66crqkbfItdN3z3FdmIzXjcc
   /h3EwGhKdX/7jMo7bMhuAPCTcOV1OOA9A4xq19aMXWI/FKE+wSO6Uxvy6
   L6B5GEFj3Bz0iDh0krrd8ErjTM0AzlWVUTz8qQwC/O1amwl0zvUzmUa8G
   zbTh6gFRba+cPoiV27S7nV+yzGhkvhh6HdJEeJBhZjEkDRNCioN/VCh/O
   w==;
X-CSE-ConnectionGUID: 2tFw9xq1TbCXeD2AfDduyg==
X-CSE-MsgGUID: bg5r49NWRcCCtw/uOVF1FQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="65682779"
X-IronPort-AV: E=Sophos;i="6.16,308,1744095600"; 
   d="scan'208";a="65682779"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2025 23:44:13 -0700
X-CSE-ConnectionGUID: Q5qA7GjMTlyJWaItVFLZQQ==
X-CSE-MsgGUID: vgPnHmhcRDCs3fcgIVIAfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,308,1744095600"; 
   d="scan'208";a="162353828"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 12 Jul 2025 23:44:10 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uaqRT-0007wt-2L;
	Sun, 13 Jul 2025 06:44:07 +0000
Date: Sun, 13 Jul 2025 14:43:13 +0800
From: kernel test robot <lkp@intel.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
	Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: Re: [PATCH 1/2] printk: nbcon: Export console_is_usage and other
 nbcon symbols
Message-ID: <202507131443.p6jEjXFw-lkp@intel.com>
References: <20250713-nbcon-kgdboc-v1-1-51eccd9247a8@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250713-nbcon-kgdboc-v1-1-51eccd9247a8@suse.com>

Hi Marcos,

kernel test robot noticed the following build warnings:

[auto build test WARNING on d0b3b7b22dfa1f4b515fd3a295b3fd958f9e81af]

url:    https://github.com/intel-lab-lkp/linux/commits/Marcos-Paulo-de-Souza/printk-nbcon-Export-console_is_usage-and-other-nbcon-symbols/20250713-131106
base:   d0b3b7b22dfa1f4b515fd3a295b3fd958f9e81af
patch link:    https://lore.kernel.org/r/20250713-nbcon-kgdboc-v1-1-51eccd9247a8%40suse.com
patch subject: [PATCH 1/2] printk: nbcon: Export console_is_usage and other nbcon symbols
config: x86_64-buildonly-randconfig-001-20250713 (https://download.01.org/0day-ci/archive/20250713/202507131443.p6jEjXFw-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250713/202507131443.p6jEjXFw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507131443.p6jEjXFw-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/char/tpm/tpm_tis.c:21:
   In file included from include/linux/pnp.h:16:
>> include/linux/console.h:653:76: warning: non-void function does not return a value [-Wreturn-type]
     653 | static inline bool nbcon_context_try_acquire(struct nbcon_context *ctxt) { }
         |                                                                            ^
   In file included from drivers/char/tpm/tpm_tis.c:29:
   In file included from drivers/char/tpm/tpm.h:28:
   include/linux/tpm_eventlog.h:167:6: warning: variable 'mapping_size' set but not used [-Wunused-but-set-variable]
     167 |         int mapping_size;
         |             ^
   2 warnings generated.


vim +653 include/linux/console.h

   651	
   652	#else
 > 653	static inline bool nbcon_context_try_acquire(struct nbcon_context *ctxt) { }
   654	static inline void nbcon_context_release(struct nbcon_context *ctxt) { }
   655	static inline void nbcon_cpu_emergency_enter(void) { }
   656	static inline void nbcon_cpu_emergency_exit(void) { }
   657	static inline bool nbcon_can_proceed(struct nbcon_write_context *wctxt) { return false; }
   658	static inline bool nbcon_enter_unsafe(struct nbcon_write_context *wctxt) { return false; }
   659	static inline bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt) { return false; }
   660	static inline void nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt) { }
   661	static inline bool console_is_usable(struct console *con, short flags,
   662					     bool use_atomic) { return false; }
   663	#endif
   664	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

