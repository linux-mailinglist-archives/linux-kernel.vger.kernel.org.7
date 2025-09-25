Return-Path: <linux-kernel+bounces-833220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99838BA1735
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 23:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 552333B88C0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 21:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB0726D4F9;
	Thu, 25 Sep 2025 21:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UENh4D9q"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0B226A1B5
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 21:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758834112; cv=none; b=hJo8fl4ON2jvd+bjcJb3W/RkemjcZbD3qyi8BBzJbUFVZPDI9G0gXMYdTiXHNYdDHdSnrbS0UCynspkajd9BCMFndVkWUDF7jzX55nSwGk7juZ4fSJ2jTVuBWrVuecOM7eI2suafXzkHW7ZcVkuhcyk4YIAvGj++ILEsskDveic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758834112; c=relaxed/simple;
	bh=KqwBX1vUDG0go1bX3WoWJIu/ExUzioIYK7eC3d1cLWs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=G3ycsnLKcEk/0T986yXtD8WtYN0sAisSAtMo+3hNC/REWqQ2wn//CNE1iNEAfG4xBYGNyMvtA+aTRu7FvP5IYW0MCrW9cgpE7hgvgnutrbrn01PfIppMtl8/+5RwbArlka81Hfgm4ydPqF6z6Mbbnh5+Wg2MUDbKOmfMSJ6XR4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UENh4D9q; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758834109; x=1790370109;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KqwBX1vUDG0go1bX3WoWJIu/ExUzioIYK7eC3d1cLWs=;
  b=UENh4D9qgc3j83k9wP7hZu/Nxnbrtnvs5azeBuChbyQPNhXuhV5wVruO
   YSQlG6/6Skff1J7eS2u6Tfn7yGvcLAGlBVEUQMrGOL5pbqWgOPmUOKMPC
   viFD3qf+Pm+qjXp5t9kA8NqriHrQUZBgxxWj56los8FQbFv8lzheWmuyd
   GnurpC3THfldcbZ/akdsd2iOZDGuuD5GiERkecpfakbqCQaeOdm3q7NEy
   uOMA5UmqIZ66ghXO4vK9FiQPNpaIaaqLalbEoHTIG3m+4fesRuftdLARe
   jDphoFUJW4WvpByOvZxraIUfYwLt0IfAe1DoT03V+OVGK1GAzs9zI+4j7
   g==;
X-CSE-ConnectionGUID: 887DrMoJRFyoqYp9rFayFA==
X-CSE-MsgGUID: vqY+uCgORHWybJ+/pYdCIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="71414079"
X-IronPort-AV: E=Sophos;i="6.18,293,1751266800"; 
   d="scan'208";a="71414079"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 14:01:49 -0700
X-CSE-ConnectionGUID: LFm6jEEZQbWdO0UkNTvDyQ==
X-CSE-MsgGUID: VP8hui6mQFiaAg09SgweEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,293,1751266800"; 
   d="scan'208";a="176715197"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 25 Sep 2025 14:01:47 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v1t60-0005cd-2Z;
	Thu, 25 Sep 2025 21:01:44 +0000
Date: Fri, 26 Sep 2025 05:01:23 +0800
From: kernel test robot <lkp@intel.com>
To: Nam Cao <namcao@linutronix.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>
Subject: ld.lld: error: undefined symbol: __tracepoint_page_fault_kernel
Message-ID: <202509260455.6Z9Vkty4-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4ff71af020ae59ae2d83b174646fc2ad9fcd4dc4
commit: 9162620eb604d7461da5b02ec379bb50c3c3b604 rv: Add rtapp_pagefault monitor
date:   3 months ago
config: riscv-randconfig-002-20250926 (https://download.01.org/0day-ci/archive/20250926/202509260455.6Z9Vkty4-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project cafc064fc7a96b3979a023ddae1da2b499d6c954)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250926/202509260455.6Z9Vkty4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509260455.6Z9Vkty4-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: __tracepoint_page_fault_kernel
   >>> referenced by ltl_monitor.h:0 (include/rv/ltl_monitor.h:0)
   >>>               kernel/trace/rv/monitors/pagefault/pagefault.o:(enable_pagefault) in archive vmlinux.a
   >>> referenced by ltl_monitor.h:79 (include/rv/ltl_monitor.h:79)
   >>>               kernel/trace/rv/monitors/pagefault/pagefault.o:(disable_pagefault) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: __tracepoint_page_fault_user
   >>> referenced by ltl_monitor.h:0 (include/rv/ltl_monitor.h:0)
   >>>               kernel/trace/rv/monitors/pagefault/pagefault.o:(enable_pagefault) in archive vmlinux.a
   >>> referenced by ltl_monitor.h:79 (include/rv/ltl_monitor.h:79)
   >>>               kernel/trace/rv/monitors/pagefault/pagefault.o:(disable_pagefault) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

