Return-Path: <linux-kernel+bounces-804509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F7BB4786A
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 03:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FC9D2840F8
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 01:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B00E1494C2;
	Sun,  7 Sep 2025 01:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G12UZSWm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2773C315D54
	for <linux-kernel@vger.kernel.org>; Sun,  7 Sep 2025 01:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757207637; cv=none; b=hawlN7F3ZBrgnI+0ZMPELh78OXVykiuDqqjxw1TD7jXsqBCNuuNppcdTJ0kF1LaitaSnDr2SgpY+i/WGZofbqy3iJvXVezg506cRKru8ksJHPtk38OJ70/9uwfqS8hzijMO66m1Da9+XO/aYih/SYRtXp++CI/Vd0vcXPUoz3/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757207637; c=relaxed/simple;
	bh=bIxIsBjRzrx3OsZFI5g+Y7WVp95B8KxVYWYepFc5AnM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gFqczXhH+QL91Z1/KtiHBQdiQl6cngm6aJ7qeKreycaN/gwbEiSzMC0m/FLXAi7Kx0hAUje/J9jQ45hhdNZA05Emn5MzlAGe+svg7hDNkkHu0jQHtTakWo70LRyc+JS2HZQNenXCof9MKf/VcUV8WzxTfjWmteiem/qGyPhxZNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G12UZSWm; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757207635; x=1788743635;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bIxIsBjRzrx3OsZFI5g+Y7WVp95B8KxVYWYepFc5AnM=;
  b=G12UZSWm32JHf+++M5vwhyq8Im3EZiN0k0hlJWD1xBPQj4AxzM1Tj35Z
   bVw6x+F8NQJ9qVvK8fyywTDhjxv3/fYnPbSKxxsWQ85VMahDFu72qcFut
   YOKDZLxHTw7a8pcfAGIjvQA010VFAkKnB/njFUXJjPr0M5uqA/TB0Qgai
   R7OhhtAq3AIzPtnhtSqgO2Pu3/QftRKczm/8o6lv3pW+84N/HGHa7nf9P
   IG0xHyEzDxtfOeI3FD2nEGieCXCVPF5YZyqCGrRnGwqcgnRaE5Obb/O9z
   OOzOIo3BZLvidzZNSPLg1iRE4V0Ppm/JTcsb0X7mTSgs3G3s4e/5eQHGc
   A==;
X-CSE-ConnectionGUID: naTbbHFjR4aLKPv5DbFcSA==
X-CSE-MsgGUID: /CEERihVQBujwXrp3Le0+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11545"; a="63147818"
X-IronPort-AV: E=Sophos;i="6.18,245,1751266800"; 
   d="scan'208";a="63147818"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2025 18:13:55 -0700
X-CSE-ConnectionGUID: 7lXCHk9TS4mEDM0+d8sEVw==
X-CSE-MsgGUID: CSuwy8jKQC6Nmj7lGbLtzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,245,1751266800"; 
   d="scan'208";a="176796357"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 06 Sep 2025 18:13:54 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uv3yZ-0001uV-1o;
	Sun, 07 Sep 2025 01:13:51 +0000
Date: Sun, 7 Sep 2025 09:12:57 +0800
From: kernel test robot <lkp@intel.com>
To: Nick Terrell <terrelln@meta.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: ERROR: modpost: "__st_r13_to_r15" [lib/zstd/zstd_decompress.ko]
 undefined!
Message-ID: <202509070910.KE0ht4fu-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Nick,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b236920731dd90c3fba8c227aa0c4dee5351a639
commit: 65d1f5507ed2c78c64fce40e44e5574a9419eb09 zstd: Import upstream v1.5.7
date:   6 months ago
config: arc-randconfig-r111-20250907 (https://download.01.org/0day-ci/archive/20250907/202509070910.KE0ht4fu-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 10.5.0
reproduce: (https://download.01.org/0day-ci/archive/20250907/202509070910.KE0ht4fu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509070910.KE0ht4fu-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

ERROR: modpost: "__ld_r13_to_r23_ret" [lib/zstd/zstd_decompress.ko] undefined!
ERROR: modpost: "__ld_r13_to_r19_ret" [lib/zstd/zstd_decompress.ko] undefined!
>> ERROR: modpost: "__st_r13_to_r15" [lib/zstd/zstd_decompress.ko] undefined!
ERROR: modpost: "__st_r13_to_r24" [lib/zstd/zstd_decompress.ko] undefined!
ERROR: modpost: "__st_r13_to_r19" [lib/zstd/zstd_decompress.ko] undefined!
>> ERROR: modpost: "__st_r13_to_r23" [lib/zstd/zstd_decompress.ko] undefined!
>> ERROR: modpost: "__ld_r13_to_r24_ret" [lib/zstd/zstd_decompress.ko] undefined!
>> ERROR: modpost: "__ld_r13_to_r18_ret" [lib/zstd/zstd_decompress.ko] undefined!
>> ERROR: modpost: "__ld_r13_to_r20_ret" [lib/zstd/zstd_decompress.ko] undefined!
>> ERROR: modpost: "__ld_r13_to_r15_ret" [lib/zstd/zstd_decompress.ko] undefined!
WARNING: modpost: suppressed 2 unresolved symbol warnings because there were too many)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

