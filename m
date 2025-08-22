Return-Path: <linux-kernel+bounces-781816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DB6B31716
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 298A77BF80E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79EB82FD1A2;
	Fri, 22 Aug 2025 12:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hRmMoedk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865B12FAC09
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 12:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755864448; cv=none; b=EX5aqdM8zMZQjn2nytLw5lGiKPWmt3bg8nfe/lqcLn1okWHLMXAYtQvZG0bFz8dRPev46wGtLx0piNVBhrjGEzl/WAyKlAtnYSKcTHGjKO2/3CSEiP8bEUwtkEOjjYpwSKOSA87TvM3o64ghbc6iVknY7nBY7GAIUG4UnJALMO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755864448; c=relaxed/simple;
	bh=WQiqjvLi5dQUrym9drEPqy9hqT19tYPDN2U5c3gA+rc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tni6oA5CFaHw3F/P3LIa7mJq8tbQZn+vNxDIIZGwpsY0IzrFC5CiID10eQKmNvt5LMrYVcXjT1muCt8Q7aErhmjLqC77OptZa5odiphqX8WGNrzZlw0Ln1yijWqgxX8zpv/o5Yq99GgqX1raaEh8Gl/yuR9qkC6FYHz87NefUno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hRmMoedk; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755864446; x=1787400446;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WQiqjvLi5dQUrym9drEPqy9hqT19tYPDN2U5c3gA+rc=;
  b=hRmMoedkyzoEyMPcLT7QQVMUEUHi2o479GX9Z89M5i/X+doP+Np7yEPq
   jVgO8bPCE9TnVTIDg1xg0YPkJDxVG+1kXVml2LdExlVKujfGNa4rtzkzo
   uspHvav5G2R7KpMKnlXUarCegj+Rlnei74OhPNyDgsPDS8Wfr5XnnS1mk
   PC6jpLSfSekNeBQBapB4XuN6ECKpi9Z0GHhlniFCjmf7ZPZLcA2xkt0kM
   UjOz/PUYjLA9i+izZLzDeI8KqH+9RfGZ19dOeHKdTFLRAessNuQd/Y6rM
   TR2TT1ooxxR1O3F1o0FXe3GgxSneDJzPsxBmfSeRG/KZH/3fPzu4+fGw9
   w==;
X-CSE-ConnectionGUID: WaFNn/ThS5mC12aW81cyGQ==
X-CSE-MsgGUID: SMjHqJC+R8yIp33cNW4GkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="68769042"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="68769042"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 05:07:25 -0700
X-CSE-ConnectionGUID: GiMn3YLTTD6hVTxOD490OA==
X-CSE-MsgGUID: zf2We+8TRYOxHMDkkrmyyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="168199261"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 22 Aug 2025 05:07:23 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1upQYD-000LEI-0n;
	Fri, 22 Aug 2025 12:07:21 +0000
Date: Fri, 22 Aug 2025 20:07:06 +0800
From: kernel test robot <lkp@intel.com>
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>
Subject: kismet: WARNING: unmet direct dependencies detected for HUGETLBFS
 when selected by PPC_8xx
Message-ID: <202508222032.bwJsQPZ1-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3957a5720157264dcc41415fbec7c51c4000fc2d
commit: f8142cf94d4737ea0c3baffb3b9bad8addcb9b6b hugetlb: make hugetlb depends on SYSFS or SYSCTL
date:   2 years, 11 months ago
config: powerpc-kismet-CONFIG_HUGETLBFS-CONFIG_PPC_8xx-0-0 (https://download.01.org/0day-ci/archive/20250822/202508222032.bwJsQPZ1-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20250822/202508222032.bwJsQPZ1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508222032.bwJsQPZ1-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for HUGETLBFS when selected by PPC_8xx
   WARNING: unmet direct dependencies detected for HUGETLBFS
     Depends on [n]: (X86 || IA64 || SPARC64 || ARCH_SUPPORTS_HUGETLBFS [=y] || BROKEN [=n]) && (SYSFS [=n] || SYSCTL [=n])
     Selected by [y]:
     - PPC_8xx [=y] && <choice>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

