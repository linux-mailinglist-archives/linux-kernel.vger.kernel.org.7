Return-Path: <linux-kernel+bounces-743521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E97B0FFB4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 06:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BDE47B77C2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 04:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B5D1FC0ED;
	Thu, 24 Jul 2025 04:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JEpW5TgA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B092E3706
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 04:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753332499; cv=none; b=OmVvkDdFmXLYv9hbm7eXs4qgHWMrIYqnfcDUVRlQWmtYl7a0/rjpjR94yahPTJ9B12r8CyJ6vsRLu5nYfsCj9P2Slq1Pa15nk9qCv2XP7ymQvDND/GpmaqEJWEj154DPuiYfQpk9+sCZ2007XjaTaB27ZvEY29GsAO11jw0s2xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753332499; c=relaxed/simple;
	bh=Ki5Hy2E8sloJery7GvJLGY/v5APDUehTnCCyUoyL19k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ayP1HtMZJI419m/It+zrmXZYO7ar/B36+Qx28dM2aoKHYYCXrty2Whl/ai4aM1pTyOnfjTmsKpzYtS9Np+3H75pOiXBAl26pj8yxNaOySrf20Kpok4Id1WU3W3fY5LxdmI50PMk4TSgMaTi1r7Uz+0DorEs4XYUTbHiGfqwbzC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JEpW5TgA; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753332498; x=1784868498;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ki5Hy2E8sloJery7GvJLGY/v5APDUehTnCCyUoyL19k=;
  b=JEpW5TgAyJV0We0J+fBLNRQ+foqgxJMZ24TOaPS2RkoZAdAvrjoxoINH
   uZ+PTbzQ2GECacaYTlS0X/ZPgsZ+wNPB97oq9tj2Ms4b73HGkeVHqpxM3
   n0Z1DWFd0NgyiFs15w/ZQdsqwOUhOzRiy6V37OI2mwPE92kpQymWKMPin
   kACpZyLqXA/QguOmo2mP/dcR9tiOgzuYdNdrkBPUkSNV8aN6fsJ98UlGJ
   yLvtozzZxRHAy+wmbgo8DA02eAaTj0Y/cikHck4LtKGsoxhFnzaZYIN0Q
   4nLFsoyE3Mh0Muj+ZN2OPpnWH+ehfLW/6I/88mI0FGSezDSe11+49lOz2
   g==;
X-CSE-ConnectionGUID: aNdJnbQURfKQf28Oq4OojA==
X-CSE-MsgGUID: Mi8OVWIAR+m2znMhG9d/5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="65892157"
X-IronPort-AV: E=Sophos;i="6.16,336,1744095600"; 
   d="scan'208";a="65892157"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 21:48:18 -0700
X-CSE-ConnectionGUID: LRmuDzvLRcyyDVDMHCWXOQ==
X-CSE-MsgGUID: wJR39IAHQ/aeo3OuCzV2Cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,336,1744095600"; 
   d="scan'208";a="159242002"
Received: from igk-lkp-server01.igk.intel.com (HELO 8b57277650df) ([10.91.175.65])
  by orviesa006.jf.intel.com with ESMTP; 23 Jul 2025 21:48:17 -0700
Received: from kbuild by 8b57277650df with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uensM-0000F9-0t;
	Thu, 24 Jul 2025 04:48:14 +0000
Date: Thu, 24 Jul 2025 06:47:48 +0200
From: kernel test robot <lkp@intel.com>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: /usr/bin/ld: warning: .tmp_vmlinux1 has a LOAD segment with RWX
 permissions
Message-ID: <202507240631.WFG1QqKl-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Masahiro,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   25fae0b93d1d7ddb25958bcb90c3c0e5e0e202bd
commit: b1a9a5e04767e2a78783e19c9e55c25812ceccc3 kbuild: merge temporary vmlinux for BTF and kallsyms
date:   1 year ago
config: um-randconfig-2004-20250724 (https://download.01.org/0day-ci/archive/20250724/202507240631.WFG1QqKl-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 6193dd55535460c347f8c0b794df7d7d52fa78c9)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250724/202507240631.WFG1QqKl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507240631.WFG1QqKl-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> /usr/bin/ld: warning: .tmp_vmlinux1 has a LOAD segment with RWX permissions
>> /usr/bin/ld: warning: .tmp_vmlinux2 has a LOAD segment with RWX permissions
   /usr/bin/ld: warning: vmlinux has a LOAD segment with RWX permissions

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

