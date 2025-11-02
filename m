Return-Path: <linux-kernel+bounces-881626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50265C28966
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 03:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD2013B34A0
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 02:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9560A23AE87;
	Sun,  2 Nov 2025 02:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P1y8FAiD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780B9233D9E
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 02:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762051144; cv=none; b=JHvfvfLSb+C9gM9WA0fVNbZgEO8i6tsYqUyEAv1Q7NBB/johcgTqVh0HPy8kk1FjG04uTsK542yP+B+ZX6Y9hGLR8XJToGEXifTDBbCZgpE4OpI07m9qdTymdgfHtVAhi3dDG48a/SC5y5OAXnw8Yu/bKhnAgW0jWMymfJQ/lzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762051144; c=relaxed/simple;
	bh=pkglFaBSwaNsLHyOTZC+8c9cH+H9AT1LDkH1WVDCnHE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=O1MLfgsSBym57pudprzz3I5r/vaHh8lGdp09VZ2ZyeeAB/9xgXW/Xk2dKetfhd1lzSYrudTVZpTGUGxceA/e7PaVFcsfwDr3FV0ayAD6W0U+kFunYxt62W6H2MI0NNds19jiqJObmS4reblCw6Sjvb51MOo0Mrnh/n2n+bOEgoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P1y8FAiD; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762051142; x=1793587142;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pkglFaBSwaNsLHyOTZC+8c9cH+H9AT1LDkH1WVDCnHE=;
  b=P1y8FAiDm5vrnKlJU7I9qjAzopnSsXsMMPw5Z3jB/978J7Tqfvtxyl/1
   KZZ3vV6+99IocLY2c8cvDAZLQD9zE9gkQHtDKEMqhh1XRwRKOlAPun52Q
   bxuDXhpTr92Q0Hx69cvPM/4zQ7Ta8cEuiiA2mAV3CGLG3ib9mjTb/yONw
   OXgf+aPCi0TPIBPa9hSRwPyhORWwYqGHBg9XGGHYd3b3rzExfITAOSyKK
   peZNBHM/TP3o3pJsYp/vr8DDoZC58SYd8KEUIJY030aVH10Bw/pnLMdjI
   IPhVrrFBaaiCMEOoDh6e0P/it/VfOnGhOxEyaqdNdkyKBrVGTFDQCo/o1
   g==;
X-CSE-ConnectionGUID: 5lxpfLBJQyGy9gt03qeKfg==
X-CSE-MsgGUID: GxIrWpcUSvS/VK1bMDcLxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11600"; a="68029625"
X-IronPort-AV: E=Sophos;i="6.19,273,1754982000"; 
   d="scan'208";a="68029625"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2025 19:39:02 -0700
X-CSE-ConnectionGUID: +J9ZLlfBQIWavtB04RUAkw==
X-CSE-MsgGUID: 5Wqq98irT0mE7Mv04zBVvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,273,1754982000"; 
   d="scan'208";a="186702714"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 01 Nov 2025 19:39:00 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vFNze-000OvQ-1I;
	Sun, 02 Nov 2025 02:38:58 +0000
Date: Sun, 2 Nov 2025 10:38:35 +0800
From: kernel test robot <lkp@intel.com>
To: chenmiao <chenmiao.ku@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Stafford Horne <shorne@gmail.com>
Subject: WARNING: modpost: vmlinux: section mismatch in reference:
 __set_fixmap+0x5c (section: .text) -> map_page.isra.0 (section: .init.text)
Message-ID: <202511021055.bpftGsDj-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   691d401c7e0e5ea34ac6f8151bc0696db1b2500a
commit: 4735037b5d9b0f809c51976c87d737fa2c48fdea openrisc: Add text patching API support
date:   7 weeks ago
config: openrisc-randconfig-r133-20251102 (https://download.01.org/0day-ci/archive/20251102/202511021055.bpftGsDj-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251102/202511021055.bpftGsDj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511021055.bpftGsDj-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux: section mismatch in reference: __set_fixmap+0x5c (section: .text) -> map_page.isra.0 (section: .init.text)
ERROR: modpost: "__mulsi3" [kernel/locking/locktorture.ko] undefined!
ERROR: modpost: "__mulsi3" [kernel/rcu/refscale.ko] undefined!
ERROR: modpost: "__mulsi3" [kernel/time/test_udelay.ko] undefined!
ERROR: modpost: "__mulsi3" [kernel/trace/ring_buffer_benchmark.ko] undefined!
ERROR: modpost: "__mulsi3" [kernel/trace/preemptirq_delay_test.ko] undefined!
ERROR: modpost: "__mulsi3" [fs/fat/vfat.ko] undefined!
ERROR: modpost: "__mulsi3" [fs/mbcache.ko] undefined!
ERROR: modpost: "__mulsi3" [fs/ext4/ext4.ko] undefined!
ERROR: modpost: "__mulsi3" [fs/jbd2/jbd2.ko] undefined!
ERROR: modpost: "__mulsi3" [fs/ntfs3/ntfs3.ko] undefined!
WARNING: modpost: suppressed 402 unresolved symbol warnings because there were too many)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

