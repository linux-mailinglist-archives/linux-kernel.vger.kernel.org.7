Return-Path: <linux-kernel+bounces-888390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B34C3AB08
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 12:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 153D4465FF3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 11:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ADF430F80F;
	Thu,  6 Nov 2025 11:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LcadO1Y9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F6F30FC3A
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 11:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762429408; cv=none; b=XrW5mPecNsAjmn4acsC3MyNfN8QCRKE/X+YShc9VIjUBU6sodEKSZVWRMbe6bdF5OhPF7CpoFk9GW3gx3jzLGSu9ap5zhfIqATiz19KG7ysacvrra4RlF9WJf8kpYzCB2iIRyennrCKf863u8VgPJtvLeSKRZglznIMaYSTd+to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762429408; c=relaxed/simple;
	bh=2fO5UPau4YJyc5zqI1DyRj+HZr37DRwtWiKrbCxKpSc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Q4EMZ96aQFHlImozKt+/rnxZ/JHbom5DMaA46OBTinsEcJTxUJI/Q+Stc9fuRajh4TrgsowgysHD1cGB+qVhReq6L/sio7a//B+V3LYpjkWo3phjSHBVX7XSFEwz5Y+Zu66dSMFCLZOKnAlVAbZqhn/+B+osRqZ71n7V2tyQNk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LcadO1Y9; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762429404; x=1793965404;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2fO5UPau4YJyc5zqI1DyRj+HZr37DRwtWiKrbCxKpSc=;
  b=LcadO1Y92y+vla+qs83lpOCgGG8CwMl1K307LY87IP5XNdQdtmxVPZ1N
   uU4asvGYvBKRdzqWV3dmXr+/sS/Mjczc+uVzedwIEXRmaXZryZCXXY7br
   I/V0goJ8pqIrGpBVdCKX4//iC/6q7xs72VcAs0tt25ZMtXl5aTgcrvCVo
   5WyFWM97Kyn+SGIPmoS+j7vqkeekMfK0xfYq/6DiME+EVJm8GyRPpWKAT
   2VxRPzwHNPtOvXlubgieo6GaHUhQYL/KRboYSZyHANLAIArfKVN6qELG+
   R2bcNudzRtUurNWgTOmhexdCZp3UL9Nkk12SnZjiwiCaq374f3xHzrOm4
   w==;
X-CSE-ConnectionGUID: 9c4he8lBSqG6nF7yIRq0iQ==
X-CSE-MsgGUID: a/JEZrJrSQ25d9F1aJKJ3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64489371"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64489371"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 03:43:23 -0800
X-CSE-ConnectionGUID: VdKWBAEgR+if/mttaIjRvw==
X-CSE-MsgGUID: bmygLwPPSDGdBt+pbSBCJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="191832217"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 06 Nov 2025 03:43:23 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vGyOe-000Ts6-0A;
	Thu, 06 Nov 2025 11:43:20 +0000
Date: Thu, 6 Nov 2025 19:42:28 +0800
From: kernel test robot <lkp@intel.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [tip:master 11/25] vmlinux.o: warning: objtool:
 user_exc_vmm_communication+0x1ba: call to __kasan_check_read() leaves
 .noinstr.text section
Message-ID: <202511061929.VZHgI3kd-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
head:   8411fdb92360d0b4d3337492a25ee2de7fb6c425
commit: f3f05eccd188355ee9ffcf3f120328c604daffb8 [11/25] Merge branch into tip/master: 'perf/core'
config: x86_64-allmodconfig (https://download.01.org/0day-ci/archive/20251106/202511061929.VZHgI3kd-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251106/202511061929.VZHgI3kd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511061929.VZHgI3kd-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> vmlinux.o: warning: objtool: user_exc_vmm_communication+0x1ba: call to __kasan_check_read() leaves .noinstr.text section
   vmlinux.o: warning: objtool: exc_int3+0x1e4: call to __kasan_check_read() leaves .noinstr.text section
   vmlinux.o: warning: objtool: exc_debug_user+0x22f: call to __kasan_check_read() leaves .noinstr.text section
   vmlinux.o: warning: objtool: noist_exc_machine_check+0x1d5: call to __kasan_check_read() leaves .noinstr.text section
   vmlinux.o: warning: objtool: fred_exc_machine_check+0x225: call to __kasan_check_read() leaves .noinstr.text section

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

