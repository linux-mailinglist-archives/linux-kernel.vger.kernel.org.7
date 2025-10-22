Return-Path: <linux-kernel+bounces-864374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 52AB5BFAA57
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BB8394EB7FC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 07:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B125C2FD667;
	Wed, 22 Oct 2025 07:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gLke6GCr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78612FB988
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761118929; cv=none; b=FWEaQ8+04E26CWFLYke4/kPknBPKsl64o6ijTggiCJm1dpvdugVnxi6bOuL6b6/KSeH2aLZdmD465CDDSJn3W2tEURvsmWB2uh1gqE7d0GnxMx/6rnW3FQrun2NGR0KuSTPG99AaSvj7p9JBy4KvSRm6ju9YwO2emV83G2HZBFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761118929; c=relaxed/simple;
	bh=4yTC+36exgdGZ8D10H669LXRniU7gmAH/RHHNfluhAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H07w7iaXwnKmVqw/2sjgFDMfF+R35ZsaRX4RBS1NxyJr2AQIOFBeAZMcylyR57TicJMRrQAm5IDBMjBtFllObN5isiNwOXFQFlwnSZkXjfhl9vevp8Ia5jhrNrZQ4P7WqTrK+Pd/MkZrKwWPdaxMhA0ZQNqEj6/yGLRy88aho6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gLke6GCr; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761118927; x=1792654927;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4yTC+36exgdGZ8D10H669LXRniU7gmAH/RHHNfluhAE=;
  b=gLke6GCrcGGIdgWg1UPvpoMLJADX3hNhjXOGoQGqJCJzFNLo5xRGP/zD
   na+XW3qc6fnHcWQvukU+MCrLYc4kOlDK1F/DeEuX5BWZxeM9rPuhFy6cb
   jRqdckh9oEHcY3VHdTJniwMfh7ftRcwZKDsXaYu+NNzZbjOoIO+VBRS7x
   hJq+49zI4lcXqYvqAuLUHCYNtjDGbDP+aCfwW3k6OtCPAJtz4lDdLYbPw
   meOuXgYRaIshs3Yhc9D5QkMePqUIFcDoHsv+hNOiq6M2VsNuDzJa5Jged
   ToNBwSdYVh4NxbnEK3xlpPFUaW367vCYthC4vR/dQjqFNz+yhBOfof/06
   A==;
X-CSE-ConnectionGUID: 8+tbEi8RQQyxwDZD/SQj5w==
X-CSE-MsgGUID: MbZ4QkAQRl6U9cv/JpHe6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63180773"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63180773"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 00:42:07 -0700
X-CSE-ConnectionGUID: t5l9xfT1RYuO2cn/qNwqFg==
X-CSE-MsgGUID: UwCivyQtSte3Yzbfbg/fxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="183690997"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 22 Oct 2025 00:42:05 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vBTTu-000C6v-2m;
	Wed, 22 Oct 2025 07:42:02 +0000
Date: Wed, 22 Oct 2025 15:41:29 +0800
From: kernel test robot <lkp@intel.com>
To: Biancaa Ramesh <biancaa2210329@ssn.edu.in>,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Biancaa Ramesh <biancaa2210329@ssn.edu.in>
Subject: Re: [PATCH] Kconfig:Uses glibc so strscpy has to be manually- added
Message-ID: <202510221515.tlpfL3lX-lkp@intel.com>
References: <20251021171446.46942-1-biancaa2210329@ssn.edu.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021171446.46942-1-biancaa2210329@ssn.edu.in>

Hi Biancaa,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.18-rc2 next-20251022]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Biancaa-Ramesh/Kconfig-Uses-glibc-so-strscpy-has-to-be-manually-added/20251022-011608
base:   linus/master
patch link:    https://lore.kernel.org/r/20251021171446.46942-1-biancaa2210329%40ssn.edu.in
patch subject: [PATCH] Kconfig:Uses glibc so strscpy has to be manually- added
config: x86_64-randconfig-002-20251022 (attached as .config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251022/202510221515.tlpfL3lX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510221515.tlpfL3lX-lkp@intel.com/

All errors (new ones prefixed by >>):

>> scripts/kconfig/confdata.c:157:2: error: call to undeclared function 'strscpy'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     157 |         strscpy(depfile_path + depfile_prefix_len, name);
         |         ^
>> scripts/kconfig/util.c:70:2: error: call to undeclared function 'strscpy'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      70 |         strscpy(gs.s, "\0");
         |         ^
   scripts/kconfig/symbol.c1 error generated.
   :812:2: error: call to undeclared function 'strscpy'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     812 |         strscpy(val, newval);
         |         ^
   make[3]: *** [scripts/Makefile.host:131: scripts/kconfig/util.o] Error 1 shuffle=3058352405
   1 error generated.
   make[3]: *** [scripts/Makefile.host:131: scripts/kconfig/confdata.o] Error 1 shuffle=3058352405
   1 error generated.
   make[3]: *** [scripts/Makefile.host:131: scripts/kconfig/symbol.o] Error 1 shuffle=3058352405
   make[3]: Target 'oldconfig' not remade because of errors.
   make[2]: *** [Makefile:742: oldconfig] Error 2 shuffle=3058352405
   make[1]: *** [Makefile:248: __sub-make] Error 2 shuffle=3058352405
   make[1]: Target 'oldconfig' not remade because of errors.
   make: *** [Makefile:248: __sub-make] Error 2 shuffle=3058352405
   make: Target 'oldconfig' not remade because of errors.
--
>> scripts/kconfig/symbol.c:812:2: error: call to undeclared function 'strscpy'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     812 |         strscpy(val, newval);
         |         ^
>> scripts/kconfig/confdata.c:157:2: error: call to undeclared function 'strscpy'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     157 |         strscpy(depfile_path + depfile_prefix_len, name);
         |         ^
>> scripts/kconfig/util.c:70:2: error: call to undeclared function 'strscpy'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      70 |         strscpy(gs.s, "\0");
         |         ^
   1 error generated.
   1 error generated.
   make[3]: *** [scripts/Makefile.host:131: scripts/kconfig/confdata.o] Error 1 shuffle=3058352405
   make[3]: *** [scripts/Makefile.host:131: scripts/kconfig/util.o] Error 1 shuffle=3058352405
   1 error generated.
   make[3]: *** [scripts/Makefile.host:131: scripts/kconfig/symbol.o] Error 1 shuffle=3058352405
   make[3]: Target 'olddefconfig' not remade because of errors.
   make[2]: *** [Makefile:742: olddefconfig] Error 2 shuffle=3058352405
   make[1]: *** [Makefile:248: __sub-make] Error 2 shuffle=3058352405
   make[1]: Target 'olddefconfig' not remade because of errors.
   make: *** [Makefile:248: __sub-make] Error 2 shuffle=3058352405
   make: Target 'olddefconfig' not remade because of errors.


vim +/strscpy +157 scripts/kconfig/confdata.c

   147	
   148	/* touch depfile for symbol 'name' */
   149	static int conf_touch_dep(const char *name)
   150	{
   151		int fd;
   152	
   153		/* check overflow: prefix + name + '\0' must fit in buffer. */
   154		if (depfile_prefix_len + strlen(name) + 1 > sizeof(depfile_path))
   155			return -1;
   156	
 > 157		strscpy(depfile_path + depfile_prefix_len, name);
   158	
   159		fd = open(depfile_path, O_WRONLY | O_CREAT | O_TRUNC, 0644);
   160		if (fd == -1)
   161			return -1;
   162		close(fd);
   163	
   164		return 0;
   165	}
   166	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

