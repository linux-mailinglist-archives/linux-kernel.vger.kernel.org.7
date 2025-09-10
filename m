Return-Path: <linux-kernel+bounces-809417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6285EB50D77
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 07:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F6E546280A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 05:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124DC2BDC0E;
	Wed, 10 Sep 2025 05:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qjrq4DI3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBC22248BD
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 05:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757482658; cv=none; b=YW3VFLPug239qFLjPRD9DjvcH8ckUTzrQ74M+xMXAtxmuiZX6rx6h77+/QWxl0ZLGupWonJxucIXVmeK1VhYWm9wh7ceqRyKb3OftIgjf1dQfyfJJsYQGjqwMLgY1rtgVTlPg24Fj31lcjh712fmFu0fcvFFMKoTHDYX0axg0GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757482658; c=relaxed/simple;
	bh=iHHgcPaCsFLf8MyTZq941AN7FvV+U2MejTzrTRhAuCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r4mCXb88a2wayBuxe9UTKQ/gLJa6mn3CW1887SGehxnLvauEFybCNClowXFy9N57+Qv2KFi/pqpS70mEAuM2SOuqC3lKkSaiOK3nlvxhNRih4juguU7HwI0iatJDRnrF5yuRJpT/fiXBnsCYnOsajEqJX1EuUfYShqaNvj8YxwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qjrq4DI3; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757482657; x=1789018657;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iHHgcPaCsFLf8MyTZq941AN7FvV+U2MejTzrTRhAuCs=;
  b=Qjrq4DI30hEy4EXb9QfcodaGaGQd7zItXwzHJV9rI6Ss3J/7YJBb3Kub
   NMGD7BIPRANzXiXSpiAVIR7b8TcGADzomU1x0mNhoI3op1AyjBhCHHRYz
   IBULW5TDouMayEmgS0LSDE+haiY69QU86/ci5MC0nkyLQqSCH48x+q38M
   UAfQgbw1u34VTNt0Gb3sx6L0utnRFW/Ek/B3E6FJGhEgl8bpc5UbZSoGn
   Z/ZJqbwQlmwW3CG+V89bbu/148kai8HQeKCw5SQM/7Hh+dnySYw9AhrmS
   k8Z+elQ3XoBPv/bkRg4D27oLuLHlqHOvqw3nqZqVU0bTje7LQBPex5Vp+
   g==;
X-CSE-ConnectionGUID: B5KSHp7uReSdGIM6jxsSRw==
X-CSE-MsgGUID: fXCmQyDdQe6VAlk/x0TjJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11548"; a="59926028"
X-IronPort-AV: E=Sophos;i="6.18,253,1751266800"; 
   d="scan'208";a="59926028"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 22:37:36 -0700
X-CSE-ConnectionGUID: 7HL6zpH3ToKbH420jadKEw==
X-CSE-MsgGUID: cRjqMZyxSg2zhulDnKc0qA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,253,1751266800"; 
   d="scan'208";a="173677850"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 09 Sep 2025 22:37:32 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uwDWM-0005Yx-27;
	Wed, 10 Sep 2025 05:37:30 +0000
Date: Wed, 10 Sep 2025 13:36:34 +0800
From: kernel test robot <lkp@intel.com>
To: Lei Liu <liulei.rjpt@vivo.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>,
	Chris Li <chrisl@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	open list <linux-kernel@vger.kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Lei Liu <liulei.rjpt@vivo.com>
Subject: Re: [PATCH v0 2/2] mm: swap: Forced swap entries release under
 memory pressure
Message-ID: <202509101302.pptHT8X8-lkp@intel.com>
References: <20250909065349.574894-3-liulei.rjpt@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909065349.574894-3-liulei.rjpt@vivo.com>

Hi Lei,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Lei-Liu/mm-swap-Gather-swap-entries-and-batch-async-release-core/20250909-145620
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20250909065349.574894-3-liulei.rjpt%40vivo.com
patch subject: [PATCH v0 2/2] mm: swap: Forced swap entries release under memory pressure
config: sparc-randconfig-002-20250910 (https://download.01.org/0day-ci/archive/20250910/202509101302.pptHT8X8-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250910/202509101302.pptHT8X8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509101302.pptHT8X8-lkp@intel.com/

All errors (new ones prefixed by >>):

   sparc64-linux-ld: kernel/exit.o: in function `do_exit':
   exit.c:(.text+0x19f0): undefined reference to `exiting_task_count'
   sparc64-linux-ld: exit.c:(.text+0x1a14): undefined reference to `exiting_task_count'
   sparc64-linux-ld: exit.c:(.text+0x2124): undefined reference to `exiting_task_count'
   sparc64-linux-ld: mm/memory.o: in function `unmap_page_range':
   memory.c:(.text+0x46a4): undefined reference to `add_to_swap_gather_cache'
   sparc64-linux-ld: mm/page_alloc.o: in function `__alloc_pages_slowpath.constprop.124':
>> page_alloc.c:(.text+0xb44c): undefined reference to `flush_cache_if_needed'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

