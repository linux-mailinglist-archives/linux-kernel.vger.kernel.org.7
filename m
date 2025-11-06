Return-Path: <linux-kernel+bounces-888336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2881BC3A81A
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 12:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 861A13512C2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 11:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6BA30F530;
	Thu,  6 Nov 2025 11:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S9iDV2rN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A5E30F533
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 11:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762427826; cv=none; b=PNvKMCtb3c118Lk9bpt3eUkVeJ6+/p1ANzWKQr7SyTMVWebkYVc7q5TqFXZITEGCzSAWVHT59EKAeW+qGll+PIZjdjhaQr/E3tzFr4/zk/BeE8VRLEg2ibvbR+zuMfAmZVY525Dr8L4Gwq1QGzPvlmICZ3uA6rnZjIRX4vzPTC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762427826; c=relaxed/simple;
	bh=G7mvza/+U8jigr33p24orzL7kcRYPAiApFm8ADW29Ss=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lzmVCFPS8HZoDgdHOBt8zwFbsi/sNh6xOUoYJ9IqNH8r/vLJL7z0MtVnTbftn1BVpWxBQWD4oKVqdsLD7QfydUPO2mnNzBQfrL0z5Vg2/G/gKDhNjvhl4Pjk2+mA8tN4F40B+H3pDyXPBFdjQjWKPP9HNE0GRF3mT4HyOrvhq2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S9iDV2rN; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762427825; x=1793963825;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=G7mvza/+U8jigr33p24orzL7kcRYPAiApFm8ADW29Ss=;
  b=S9iDV2rN55/rKiFQ3yng4/kvsD2arsL2REJYt1++78fyHXVzw050OSoF
   qwxpsDx2RvWkEZtIifNlSUa1cmnU6jtursBFgYXn/4M7Sc+mQXWK9t+Yf
   ruElnPIRbrox+HpZpPrn70jl+ypBa2u0nKi8jj2KT8MD3+lqKMEhrahda
   HJ3IMmXJi11cxqL+qEtfbBPKNxik/oRW8UrQV6M3slfbUFOInB2ZUQq1q
   YVM2DEqOmSpBbEr9J0O+BHjXHwoylSqF7ifkf3OAgXRVhfeM1qj6mdhTm
   +l3farXjh9JTsH+YABb9B7V6FtG4bFg4Zy1e3F6Im88GnbqhdNRRy4Wvx
   g==;
X-CSE-ConnectionGUID: 6oP+BwY8R8yL3Y1IajjdXg==
X-CSE-MsgGUID: Zab9WkRUS9SoyrC/2Ey5Ow==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="64596483"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="64596483"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 03:17:04 -0800
X-CSE-ConnectionGUID: J0zHqY3sSDCZvtL9OMIa+Q==
X-CSE-MsgGUID: eQAoLds4SXmdDrXEI3KsXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="187677205"
Received: from igk-lkp-server01.igk.intel.com (HELO c2fcd27ee2f4) ([10.211.93.152])
  by orviesa007.jf.intel.com with ESMTP; 06 Nov 2025 03:17:03 -0800
Received: from kbuild by c2fcd27ee2f4 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vGxzA-000000002wW-3Vv4;
	Thu, 06 Nov 2025 11:17:00 +0000
Date: Thu, 6 Nov 2025 12:16:10 +0100
From: kernel test robot <lkp@intel.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: [tip:master 11/25] vmlinux.o: warning: objtool:
 fred_exc_machine_check+0x185: call to __kasan_check_read() leaves
 .noinstr.text section
Message-ID: <202511061245.gdMzEtVA-lkp@intel.com>
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
commit: 8375dadb8d4c6de0dc916ea50b376d9d946ce544 [11/25] Merge branch into tip/master: 'perf/core'
config: x86_64-randconfig-2005-20250721 (https://download.01.org/0day-ci/archive/20251106/202511061245.gdMzEtVA-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251106/202511061245.gdMzEtVA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511061245.gdMzEtVA-lkp@intel.com/

All warnings (new ones prefixed by >>):

   vmlinux.o: warning: objtool: exc_debug_user+0x1c9: call to __kasan_check_read() leaves .noinstr.text section
   vmlinux.o: warning: objtool: exc_int3+0x15e: call to __kasan_check_read() leaves .noinstr.text section
   vmlinux.o: warning: objtool: noist_exc_machine_check+0x179: call to __kasan_check_read() leaves .noinstr.text section
>> vmlinux.o: warning: objtool: fred_exc_machine_check+0x185: call to __kasan_check_read() leaves .noinstr.text section

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

