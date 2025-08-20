Return-Path: <linux-kernel+bounces-776779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F42B2D16D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 03:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0419D724819
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 01:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F934146593;
	Wed, 20 Aug 2025 01:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MVVYvzfV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37942367C0
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 01:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755653504; cv=none; b=PChji5pH3XNRtPDMvmT/Z1+Zf0Iq58/IXFETaXEIbYq3PJt4qy9cyTDixSFD1/Td189vWm7HgXJdI2PR3Ue5j8a6MtE5JNpLPzXSC4ePS9jo7s21jfunZBbDhmiXIyaI9qL9u6vUuJ7xSXlq+ajQe8AVIhEAyqoWDG1r2c6ITVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755653504; c=relaxed/simple;
	bh=bDraBxH4NicgEf6kVukT6KH9Et8ZUGYmcruJwbCxmCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hNgS3xwsGQnzu2UqxIfI6fD0eVKsO7Se5hs1ucVesxuuRv8kko9hW5S9LSo/0/PJM/h4sdoxeOmplcMDrOP2btotmADMiqU8rP2HLLv1GDB78+iIUe2Cj2cBGBlVRe4UokY00pbGtigmj8S3fW6e9k2UspTecjIXp0YZqSZ/fUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MVVYvzfV; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755653503; x=1787189503;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bDraBxH4NicgEf6kVukT6KH9Et8ZUGYmcruJwbCxmCU=;
  b=MVVYvzfVnb4RxHPhsUqWL+gjnub65ZtNObZa1dqFTeFhkicEJYsHUqUl
   sNFGaYED2eRwE//bctbhvngBf4P+8o+MgeVFsNLDYuuBatnWKZkKM0da8
   35LKyXKJdBADdTUYcZO1BwpwZhnghMbi4SWvmsYcoykhghWvOl2UR/c7I
   QD4bInb+rXVWbQ2s2i10BwoURgJkWom2T0RKOP1m4DxnSRcrc1LCJto7V
   rISwfjcRbASbZm3MUbuGLrhFca6GekHc9qz/Kf0f4OWEuhV0xGmxBKerV
   3clC++7ITBvTAxog/wNXiq+EpZI45+dQxdVnhm2EAJ6NLxoPQPF0sOF2z
   A==;
X-CSE-ConnectionGUID: hSmHKugtQxGnxtyj5AsbYQ==
X-CSE-MsgGUID: iPeYarmJSMyJ/c+HnALJZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="56939097"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="56939097"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 18:31:42 -0700
X-CSE-ConnectionGUID: xSEaJLclRUqA9AJspn/PjA==
X-CSE-MsgGUID: LZytxw7tSqeSLdstNlMJ8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="168338351"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 19 Aug 2025 18:31:39 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uoXft-000Hvn-1G;
	Wed, 20 Aug 2025 01:31:37 +0000
Date: Wed, 20 Aug 2025 09:31:05 +0800
From: kernel test robot <lkp@intel.com>
To: Petr Mladek <pmladek@suse.com>, Feng Tang <feng.tang@linux.alibaba.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lance Yang <lance.yang@linux.dev>, Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org, paulmck@kernel.org,
	john.ogness@linutronix.de
Subject: Re: [PATCH] panic: Clean up message about deprecated 'panic_print'
 parameter
Message-ID: <202508200907.PsZ3geub-lkp@intel.com>
References: <aKRJKZHgcxyNF3y7@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKRJKZHgcxyNF3y7@pathway.suse.cz>

Hi Petr,

kernel test robot noticed the following build errors:



url:    https://github.com/intel-lab-lkp/linux/commits/UPDATE-20250819-180717/Feng-Tang/lib-sys_info-handle-sys_info_mask-0-case/20250815-152131
base:   the 3th patch of https://lore.kernel.org/r/20250815071428.98041-4-feng.tang%40linux.alibaba.com
patch link:    https://lore.kernel.org/r/aKRJKZHgcxyNF3y7%40pathway.suse.cz
patch subject: [PATCH] panic: Clean up message about deprecated 'panic_print' parameter
config: i386-buildonly-randconfig-004-20250820 (https://download.01.org/0day-ci/archive/20250820/202508200907.PsZ3geub-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250820/202508200907.PsZ3geub-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508200907.PsZ3geub-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/panic.c:952:2: error: call to undeclared function 'panic_print_deprecated'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     952 |         panic_print_deprecated();
         |         ^
   kernel/panic.c:958:2: error: call to undeclared function 'panic_print_deprecated'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     958 |         panic_print_deprecated();
         |         ^
   2 errors generated.


vim +/panic_print_deprecated +952 kernel/panic.c

   949	
   950	static int panic_print_set(const char *val, const struct kernel_param *kp)
   951	{
 > 952		panic_print_deprecated();
   953		return  param_set_ulong(val, kp);
   954	}
   955	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

