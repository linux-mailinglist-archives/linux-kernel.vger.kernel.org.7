Return-Path: <linux-kernel+bounces-792088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6852EB3C019
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 17:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFB1D1C80B47
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 15:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E74732C32D;
	Fri, 29 Aug 2025 15:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JYXNw5U0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEDB32C31A
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 15:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756482793; cv=none; b=PlP0Cwoqo0j9rsBhF/O9gTUEuqBhh7H+AweTXpyCAV7NT7r2IzTC1PscWxa83SbnJ7SZjCLxwhjT/JjQJ98h3m6J+IeCiPBc5PwreYzAiCB0I5lBO+EDtmAf0pmUOkeQ5UQJuYLeNMSSTuoL6MWfwjGFY+S9wjdpeBSPrJImpKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756482793; c=relaxed/simple;
	bh=UWFY0JLHsJMUfcKlKs0YNjb9PahGef/x2LzTGoVsq6w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HGM7vCJGzph2h2NWW3tSsIr64ttOX2CdjoIYzkMNdyQfbbPce1pCAX1b8VfM4KKFUPUdFfV46zgyA9jpr4EHH+RJR6137GQA6BIQhMwcKHkcMFMuJ12dXaCjsgLgDEeVQn+TZMaaRUf5t+CPyI3LbSnDRUe+CM7wsKfDuheZ9gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JYXNw5U0; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756482792; x=1788018792;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UWFY0JLHsJMUfcKlKs0YNjb9PahGef/x2LzTGoVsq6w=;
  b=JYXNw5U0YMEa6HPSv0OmU1v+XQAVuFD8xXKLGtt7oCa/fFuLxX9gpZDt
   nwULeG0WQTgj+Z4MIJVnHF/rZ6F9ZrcgNhoCA2aiqMon5+HY7vs4gYCZl
   osG5x509l0DfKctfNBxJPdQzjTUxC7ZM8CPS8Ou5FFHypwf4gjDZ8VBIP
   1i+owE7K1hGDisPtuh9Ky+SqZ3hoo7BfhuwTtiCd3UpKCJYU9pC0YCqdU
   R/D+jpMiz3MWdaGI9IJ03QsOsmZMwhMwvXr5qQN32M230Ycgsl5ZEtVzA
   v6vRKE/bjocqUeRKTaibBs9PNLgS+PQKKVNWJpiB5aL/vqreIzc0S6fid
   A==;
X-CSE-ConnectionGUID: H0qbJQE+T2Cbfuzm+Riyiw==
X-CSE-MsgGUID: ksqSUEtsRCWDKpG66/AMkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="58696874"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="58696874"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 08:53:12 -0700
X-CSE-ConnectionGUID: ULmxDgHpRlikWVDrs0XvUA==
X-CSE-MsgGUID: a2FIUYIaTaGkW5Kd3Qh66A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="201324199"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 29 Aug 2025 08:53:09 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1us1PX-000UjI-18;
	Fri, 29 Aug 2025 15:53:07 +0000
Date: Fri, 29 Aug 2025 23:52:30 +0800
From: kernel test robot <lkp@intel.com>
To: Caleb James DeLisle <cjd@cjdns.fr>
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: kismet: WARNING: unmet direct dependencies detected for
 EARLY_PRINTK_8250 when selected by ECONET
Message-ID: <202508292318.ujIvmwAj-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   07d9df80082b8d1f37e05658371b087cb6738770
commit: 35fb26f94dfa1b291086b84b2421f957214824d1 mips: Add EcoNet MIPS platform support
date:   3 months ago
config: mips-kismet-CONFIG_EARLY_PRINTK_8250-CONFIG_ECONET-0-0 (https://download.01.org/0day-ci/archive/20250829/202508292318.ujIvmwAj-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20250829/202508292318.ujIvmwAj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508292318.ujIvmwAj-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for EARLY_PRINTK_8250 when selected by ECONET
   WARNING: unmet direct dependencies detected for EARLY_PRINTK_8250
     Depends on [n]: EARLY_PRINTK [=n] && USE_GENERIC_EARLY_PRINTK_8250 [=y]
     Selected by [y]:
     - ECONET [=y]
   
   WARNING: unmet direct dependencies detected for SERIAL_OF_PLATFORM
     Depends on [n]: TTY [=y] && HAS_IOMEM [=y] && SERIAL_8250 [=n] && OF [=y]
     Selected by [y]:
     - ECONET [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

