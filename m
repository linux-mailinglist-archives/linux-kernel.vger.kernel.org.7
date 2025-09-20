Return-Path: <linux-kernel+bounces-825541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 593F7B8C14E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 09:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A00B1666D7
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 07:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF672C325B;
	Sat, 20 Sep 2025 07:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YwqQPaL6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1430D5CDF1
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 07:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758352287; cv=none; b=B1/PSHE2RBF50pHkgJx7FeGrgQg/bncc71ur6YZMgEfq+YLwQSHIjFOIDwrNyMX8ZzhyGL8nyvOeGbv3nmSFnFWJXD/l7V7ITHGFUkqthVE58FW3JCYG/d9HPyU0cRIr6XXOBAHMBUIlB5V8DTBMkSa42o6IoL2fEHssnwjnILM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758352287; c=relaxed/simple;
	bh=+CvDYUIf6DoiHBHQudz1UmnBeXF1ljxWnEr6IuBAn0I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OoXlOE+zDrTJH3g/bJf1scN9IcTEG0TP/JQ8NVYAn1HkTeXCfpENeFsKJUaGvcRnXDZQkbyppm/sqZhYC1udRC3HQ0sU/q8EPx9mhxXgpTN/xJGyYEoOBSyOSL4Ym7GlSVUAMh3wyWT0qb+KuY00hHFQLVSSCcrqIdRx8w1aQIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YwqQPaL6; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758352285; x=1789888285;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+CvDYUIf6DoiHBHQudz1UmnBeXF1ljxWnEr6IuBAn0I=;
  b=YwqQPaL6VOhXtFaQJmaaQ0/VpKdupXxF7qBQgpK3ze5WUr/r4c7vFaxB
   Pmra6Rv1cd4l+kVuG7/D85L4SFsJKw2ackcAnUqRHcACEnh7VRIjG9IQm
   ZWaEqTFzpNtsxkDiMvNm4MQ8PddbdcMJ5WqEnJ++ZItyTQI61bNtvEryy
   Ri/4e/F/AxOqZu66/FvHvh+cS32sqWF6G6AG4fktrsadGMNMKtn8NQuWc
   q/0e+YZHuTYDq0Oz1qYvZyDA10munhghQkQurq1SW7mH1JM6IYuV1ZJCY
   XoG0+T0+QafmvoJcrGJCOqNz27aNkOcpJPe9IE571T1rwoMxN4jyANMsy
   A==;
X-CSE-ConnectionGUID: 6kzkwoDoQA6z1ln3S3dP4g==
X-CSE-MsgGUID: szAu0hLNTA2RPe0lOvbVug==
X-IronPort-AV: E=McAfee;i="6800,10657,11558"; a="71797662"
X-IronPort-AV: E=Sophos;i="6.18,280,1751266800"; 
   d="scan'208";a="71797662"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2025 00:11:24 -0700
X-CSE-ConnectionGUID: KjwNkg3mS72R7Pu/ByA5hA==
X-CSE-MsgGUID: tb6IWqUHRh+III3DiErk9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,280,1751266800"; 
   d="scan'208";a="213173397"
Received: from lkp-server01.sh.intel.com (HELO 84a20bd60769) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 20 Sep 2025 00:11:23 -0700
Received: from kbuild by 84a20bd60769 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uzrkf-00057X-0B;
	Sat, 20 Sep 2025 07:11:21 +0000
Date: Sat, 20 Sep 2025 15:10:55 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2025.09.15a 45/45] ERROR: modpost:
 "init_srcu_struct_fast" [kernel/rcu/rcutorture.ko] undefined!
Message-ID: <202509201519.udl3bu3X-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2025.09.15a
head:   f81c21ec3fca688bfcb6fa0abaf70404655765dc
commit: f81c21ec3fca688bfcb6fa0abaf70404655765dc [45/45] rcutorture: Exercise DEFINE_STATIC_SRCU_FAST() and init_srcu_struct_fast()
config: arm-randconfig-003-20250920 (https://download.01.org/0day-ci/archive/20250920/202509201519.udl3bu3X-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 7c861bcedf61607b6c087380ac711eb7ff918ca6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250920/202509201519.udl3bu3X-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509201519.udl3bu3X-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "init_srcu_struct_fast" [kernel/rcu/rcutorture.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

