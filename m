Return-Path: <linux-kernel+bounces-778640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F80B2E85A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 00:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFD3E188B357
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 22:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2A82D979A;
	Wed, 20 Aug 2025 22:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IQnlKpaf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC6A2BE7B4
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 22:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755730390; cv=none; b=rBbY3fggk+h8/49AHl2tUgev1QQH5/RFPv6CttKIN43uE3sAXnK6ZTkdvXtgp6F5/KoYGw0kX22/IwOWJnzDGZ1zP2+CzysLcnFjpmFxzc9PnyMSkYUSBWZ7wvkxhV+SH4S+suVi2dJZSE3MH2eIfE/zhcRc6OMlo1rwRA42rB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755730390; c=relaxed/simple;
	bh=xDRP95yA4J3OJjOVL49YPRpnANZi0tgCgOIZTfJwTVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4IK3DRav2/hSdAb4/Dt8lQZ8pH26jTWpxezfahicy7jxpEB+wtIpAl+MQlj2tPT7EzMbqNCrVj/EwDlfOMiEtXxl7SdURLVWIkG9Va3K9GdGYylrZPEJwG5OCSNRHuJVggJJP1JKZYlgqJwaU+1xjbLaFz8+6ONjR2mptmLxc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IQnlKpaf; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755730388; x=1787266388;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xDRP95yA4J3OJjOVL49YPRpnANZi0tgCgOIZTfJwTVw=;
  b=IQnlKpafNTFDw9D/L1+jjTlITT0RKp8a4VizwLWR6pbw4ANgiimOObTm
   9WMMna/qQKX9OmDXt1GnEL5XvcIeG07ajAsXAKO3Aa6rFxrWYHWJHMi6t
   g7Z67o97sUfalyGmWnAbzSQRi+1JaBjILAL31UmUlCIhCDmd0o7OfJUmr
   uBkSQNORq1ey+zZ7QgrLbo/1tYlT5refklp7wz5aPYJd7RDYgXsQlHSCL
   YcCkXQ0F+rKkUjlkFCMxDoj1M7g3Toh15vF0Ktirqd12ZeRagpqkGI0Xw
   f1xZqDuCYOlx2xz5RIykmS61MePgwWJILUQxGc4tNkJx5CLROqRdb7S/s
   Q==;
X-CSE-ConnectionGUID: X+obE+4aQp6UAXhKWZMYVw==
X-CSE-MsgGUID: 3UopeFlCRJST38oCVVca0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="58079339"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="58079339"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 15:53:05 -0700
X-CSE-ConnectionGUID: xft/3dHuSQ2BVAfciI/AKw==
X-CSE-MsgGUID: mT6JVZh0TluWdr+Zal7KOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="172674938"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 20 Aug 2025 15:53:02 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uorfv-000Jip-1I;
	Wed, 20 Aug 2025 22:52:59 +0000
Date: Thu, 21 Aug 2025 06:52:26 +0800
From: kernel test robot <lkp@intel.com>
To: Xiang Gao <gxxa03070307@gmail.com>, akpm@linux-foundation.org,
	david@redhat.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	gaoxiang17 <gaoxiang17@xiaomi.com>
Subject: Re: [PATCH v2 1/1] mm/cma: add 'available count' and 'total count'
 to trace_cma_alloc_start
Message-ID: <202508210642.kUloVYxD-lkp@intel.com>
References: <d30f91137e3a296152463ea65474e1ca56f4eda3.1755654367.git.gaoxiang17@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d30f91137e3a296152463ea65474e1ca56f4eda3.1755654367.git.gaoxiang17@xiaomi.com>

Hi Xiang,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Xiang-Gao/mm-cma-add-available-count-and-total-count-to-trace_cma_alloc_start/20250820-105438
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/d30f91137e3a296152463ea65474e1ca56f4eda3.1755654367.git.gaoxiang17%40xiaomi.com
patch subject: [PATCH v2 1/1] mm/cma: add 'available count' and 'total count' to trace_cma_alloc_start
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20250821/202508210642.kUloVYxD-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250821/202508210642.kUloVYxD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508210642.kUloVYxD-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from mm/cma.c:31:
   In file included from include/trace/events/cma.h:138:
   In file included from include/trace/define_trace.h:132:
   In file included from include/trace/trace_events.h:468:
>> include/trace/events/cma.h:56:12: error: no member named 'count' in 'struct trace_event_raw_cma_alloc_start'
      56 |                 __entry->count = request_count;
         |                 ~~~~~~~  ^
   include/trace/stages/stage6_event_callback.h:133:33: note: expanded from macro 'TP_fast_assign'
     133 | #define TP_fast_assign(args...) args
         |                                 ^~~~
   include/trace/trace_events.h:44:16: note: expanded from macro 'TRACE_EVENT'
      44 |                              PARAMS(assign),                   \
         |                                     ^~~~~~
   include/linux/tracepoint.h:139:25: note: expanded from macro 'PARAMS'
     139 | #define PARAMS(args...) args
         |                         ^~~~
   include/trace/trace_events.h:435:16: note: expanded from macro 'DECLARE_EVENT_CLASS'
     435 |                       PARAMS(assign), PARAMS(print))                    \
         |                              ^~~~~~
   include/linux/tracepoint.h:139:25: note: expanded from macro 'PARAMS'
     139 | #define PARAMS(args...) args
         |                         ^~~~
   include/trace/trace_events.h:427:4: note: expanded from macro '\
   __DECLARE_EVENT_CLASS'
     427 |         { assign; }                                                     \
         |           ^~~~~~
   In file included from mm/cma.c:31:
   In file included from include/trace/events/cma.h:138:
   In file included from include/trace/define_trace.h:133:
   In file included from include/trace/perf.h:110:
>> include/trace/events/cma.h:56:12: error: no member named 'count' in 'struct trace_event_raw_cma_alloc_start'
      56 |                 __entry->count = request_count;
         |                 ~~~~~~~  ^
   include/trace/stages/stage6_event_callback.h:133:33: note: expanded from macro 'TP_fast_assign'
     133 | #define TP_fast_assign(args...) args
         |                                 ^~~~
   include/trace/trace_events.h:44:16: note: expanded from macro 'TRACE_EVENT'
      44 |                              PARAMS(assign),                   \
         |                                     ^~~~~~
   include/linux/tracepoint.h:139:25: note: expanded from macro 'PARAMS'
     139 | #define PARAMS(args...) args
         |                         ^~~~
   include/trace/perf.h:67:16: note: expanded from macro 'DECLARE_EVENT_CLASS'
      67 |                       PARAMS(assign), PARAMS(print))                    \
         |                              ^~~~~~
   include/linux/tracepoint.h:139:25: note: expanded from macro 'PARAMS'
     139 | #define PARAMS(args...) args
         |                         ^~~~
   include/trace/perf.h:51:4: note: expanded from macro '\
   __DECLARE_EVENT_CLASS'
      51 |         { assign; }                                                     \
         |           ^~~~~~
   2 errors generated.


vim +56 include/trace/events/cma.h

    40	
    41		TP_PROTO(const char *name, unsigned long request_count, unsigned long available_count,
    42			unsigned long total_count, unsigned int align),
    43	
    44		TP_ARGS(name, request_count, available_count, total_count, align),
    45	
    46		TP_STRUCT__entry(
    47			__string(name, name)
    48			__field(unsigned long, request_count)
    49			__field(unsigned long, available_count)
    50			__field(unsigned long, total_count)
    51			__field(unsigned int, align)
    52		),
    53	
    54		TP_fast_assign(
    55			__assign_str(name);
  > 56			__entry->count = request_count;
    57			__entry->available_count = available_count;
    58			__entry->total_count = total_count;
    59			__entry->align = align;
    60		),
    61	
    62		TP_printk("name=%s count=%lu request_count=%lu total_count=%lu align=%u",
    63			  __get_str(name),
    64			  __entry->request_count,
    65			  __entry->available_count,
    66			  __entry->total_count,
    67			  __entry->align)
    68	);
    69	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

