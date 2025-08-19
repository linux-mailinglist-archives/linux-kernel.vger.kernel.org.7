Return-Path: <linux-kernel+bounces-776102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F10F5B2C89B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 17:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FBC17AD8DA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C9E246782;
	Tue, 19 Aug 2025 15:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="azggA/8z"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751A224503B
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 15:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755618006; cv=none; b=rabvlGGXfGtrga8YN5bgoxYjor1+2hJ5AbXyWZ3YCfjFhoLeSV6fSi6aIMxySBxpQ4u/3mmIpGDbI8nL4Z5grsi5JunRDolHLO0SUe7rEgK9hC/ALlFMPUNr41uXVAzq1dco9rLoUkSdw+65MQ+QyBF3LSG57PTgXYfJt93odzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755618006; c=relaxed/simple;
	bh=/CJ0ug9oHBwhNXsynWG5neEMiGIVAml0VWRpYVhhYDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RLkpX4y3RlX8XSRwqZ2UIhDlrKhYeGZ2CExHQ6/Oqz0nklVUZTGNkOOi6McYNgxyhzJBpCgKLd6KmqRqQDtR6LGHeyEEE09vo9gOYOXO3TLJSTGaY85LWX6P5DWK+smEhQtyj/8u9Y7vCgmhNtsf+mpQRj/4zMwRatBd9sWkc5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=azggA/8z; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755618005; x=1787154005;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/CJ0ug9oHBwhNXsynWG5neEMiGIVAml0VWRpYVhhYDI=;
  b=azggA/8zeJf//pRA+aHLORvcRKK2dmjDmxGxpZ/B9pD8ePGtFGmys0pX
   25CuerA5GATYeu2iGhL4rx3b6LMabVZs8KXJw5xKeK9Br5FEVLsmbPXvk
   1oMR7vSgkSpLGDNNhNGiPPWMgu7B0n0i7qE21DpBFhX9/1CkIBishhaDQ
   kEs663R4vlOPQkvS0X/eh2IEdc96ObMYTM33wojnSphYvC5xB7oy3ulky
   Hbrh84UvHhkG6Vl3M1hZ7HWN2Bm+zeJfb8jOUFsj7XjSRTABjRMIBQ6zM
   vO2svVQqZ+c6fAKvLcHzcKj/kphIuYQ41ni9QVXqo9zW7dPynQGkUKmBE
   w==;
X-CSE-ConnectionGUID: dMimBpMlTHCLeUQYcCXVWg==
X-CSE-MsgGUID: A4u3SzydSiKyVIVachceOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="57792179"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="57792179"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 08:40:04 -0700
X-CSE-ConnectionGUID: 9k0W7MGIS3G85O+9jphhGw==
X-CSE-MsgGUID: WNSp3JQsQ9C45o1KDg8vxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="168675856"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 19 Aug 2025 08:40:00 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uoORJ-000H4V-24;
	Tue, 19 Aug 2025 15:39:57 +0000
Date: Tue, 19 Aug 2025 23:39:16 +0800
From: kernel test robot <lkp@intel.com>
To: Xiang Gao <gxxa03070307@gmail.com>, akpm@linux-foundation.org,
	david@redhat.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	gaoxiang17 <gaoxiang17@xiaomi.com>
Subject: Re: [PATCH] mm/cma: add available_count and total count in
 trace_cma_alloc_start
Message-ID: <202508192304.gauRFPJE-lkp@intel.com>
References: <20250819032654.4345-1-gxxa03070307@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819032654.4345-1-gxxa03070307@gmail.com>

Hi Xiang,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Xiang-Gao/mm-cma-add-available_count-and-total-count-in-trace_cma_alloc_start/20250819-112831
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20250819032654.4345-1-gxxa03070307%40gmail.com
patch subject: [PATCH] mm/cma: add available_count and total count in trace_cma_alloc_start
config: x86_64-buildonly-randconfig-002-20250819 (https://download.01.org/0day-ci/archive/20250819/202508192304.gauRFPJE-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250819/202508192304.gauRFPJE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508192304.gauRFPJE-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from mm/cma.c:31:
   In file included from include/trace/events/cma.h:138:
   In file included from include/trace/define_trace.h:132:
   In file included from include/trace/trace_events.h:256:
>> include/trace/events/cma.h:65:5: warning: format specifies type 'unsigned int' but the argument has type 'unsigned long' [-Wformat]
      39 | 
      40 |         TP_fast_assign(
         |         ~~~~~~~~~~~~~~~
      41 |                 __assign_str(name);
         |                 ~~~~~~~~~~~~~~~~~~~
      42 |                 __entry->count = request_count;
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      43 |                 __entry->available_count = available_count;
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      44 |                 __entry->total_count = total_count;
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      45 |                 __entry->align = align;
         |                 ~~~~~~~~~~~~~~~~~~~~~~~
      46 |         ),
         |         ~~
      47 | 
      48 |         TP_printk("name=%s count=%lu align=%u",
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                            %lu
      49 |                   __get_str(name),
         |                   ~~~~~~~~~~~~~~~~
      50 |                   __entry->request_count,
         |                   ~~~~~~~~~~~~~~~~~~~~~~~
      51 |                   __entry->available_count,
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~
      52 |                   __entry->total_count,
         |                   ~~~~~~~~~~~~~~~~~~~~~
      53 |                   __entry->align)
         |                   ~~~~~~~~~~~~~~~
      54 | );
         | ~
   include/trace/stages/stage3_trace_output.h:6:17: note: expanded from macro '__entry'
       6 | #define __entry field
         |                 ^
   include/trace/stages/stage3_trace_output.h:9:43: note: expanded from macro 'TP_printk'
       9 | #define TP_printk(fmt, args...) fmt "\n", args
         |                                 ~~~       ^
   include/trace/trace_events.h:45:16: note: expanded from macro 'TRACE_EVENT'
      40 |         DECLARE_EVENT_CLASS(name,                              \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      41 |                              PARAMS(proto),                    \
         |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      42 |                              PARAMS(args),                     \
         |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      43 |                              PARAMS(tstruct),                  \
         |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      44 |                              PARAMS(assign),                   \
         |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      45 |                              PARAMS(print));                   \
         |                              ~~~~~~~^~~~~~~
   include/linux/tracepoint.h:139:25: note: expanded from macro 'PARAMS'
     139 | #define PARAMS(args...) args
         |                         ^~~~
   include/trace/trace_events.h:219:27: note: expanded from macro 'DECLARE_EVENT_CLASS'
     219 |         trace_event_printf(iter, print);                                \
         |                                  ^~~~~
   In file included from mm/cma.c:31:
   In file included from include/trace/events/cma.h:138:
   In file included from include/trace/define_trace.h:132:
   In file included from include/trace/trace_events.h:256:
>> include/trace/events/cma.h:66:5: warning: data argument not used by format string [-Wformat-extra-args]
      39 | 
      40 |         TP_fast_assign(
         |         ~~~~~~~~~~~~~~~
      41 |                 __assign_str(name);
         |                 ~~~~~~~~~~~~~~~~~~~
      42 |                 __entry->count = request_count;
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      43 |                 __entry->available_count = available_count;
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      44 |                 __entry->total_count = total_count;
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      45 |                 __entry->align = align;
         |                 ~~~~~~~~~~~~~~~~~~~~~~~
      46 |         ),
         |         ~~
      47 | 
      48 |         TP_printk("name=%s count=%lu align=%u",
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      49 |                   __get_str(name),
         |                   ~~~~~~~~~~~~~~~~
      50 |                   __entry->request_count,
         |                   ~~~~~~~~~~~~~~~~~~~~~~~
      51 |                   __entry->available_count,
         |                   ~~~~~~~~~~~~~~~~~~~~~~~~~
      52 |                   __entry->total_count,
         |                   ^~~~~~~~~~~~~~~~~~~~~
      53 |                   __entry->align)
         |                   ~~~~~~~~~~~~~~~
      54 | );
         | ~
   include/trace/stages/stage3_trace_output.h:6:17: note: expanded from macro '__entry'
       6 | #define __entry field
         |                 ^
   include/trace/stages/stage3_trace_output.h:9:43: note: expanded from macro 'TP_printk'
       9 | #define TP_printk(fmt, args...) fmt "\n", args
         |                                           ^
   include/trace/trace_events.h:45:16: note: expanded from macro 'TRACE_EVENT'
      40 |         DECLARE_EVENT_CLASS(name,                              \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      41 |                              PARAMS(proto),                    \
         |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      42 |                              PARAMS(args),                     \
         |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      43 |                              PARAMS(tstruct),                  \
         |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      44 |                              PARAMS(assign),                   \
         |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      45 |                              PARAMS(print));                   \
         |                              ~~~~~~~^~~~~~~
   include/linux/tracepoint.h:139:25: note: expanded from macro 'PARAMS'
     139 | #define PARAMS(args...) args
         |                         ^
   include/trace/trace_events.h:219:27: note: expanded from macro 'DECLARE_EVENT_CLASS'
     219 |         trace_event_printf(iter, print);                                \
         |                                  ^~~~~
   In file included from mm/cma.c:31:
   In file included from include/trace/events/cma.h:138:
   In file included from include/trace/define_trace.h:132:
   In file included from include/trace/trace_events.h:468:
   include/trace/events/cma.h:56:12: error: no member named 'count' in 'struct trace_event_raw_cma_alloc_start'
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
   include/trace/events/cma.h:56:12: error: no member named 'count' in 'struct trace_event_raw_cma_alloc_start'
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


vim +65 include/trace/events/cma.h

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
    56			__entry->count = request_count;
    57			__entry->available_count = available_count;
    58			__entry->total_count = total_count;
    59			__entry->align = align;
    60		),
    61	
    62		TP_printk("name=%s count=%lu align=%u",
    63			  __get_str(name),
    64			  __entry->request_count,
  > 65			  __entry->available_count,
  > 66			  __entry->total_count,
    67			  __entry->align)
    68	);
    69	
    70	TRACE_EVENT(cma_alloc_finish,
    71	
    72		TP_PROTO(const char *name, unsigned long pfn, const struct page *page,
    73			 unsigned long count, unsigned int align, int errorno),
    74	
    75		TP_ARGS(name, pfn, page, count, align, errorno),
    76	
    77		TP_STRUCT__entry(
    78			__string(name, name)
    79			__field(unsigned long, pfn)
    80			__field(const struct page *, page)
    81			__field(unsigned long, count)
    82			__field(unsigned int, align)
    83			__field(int, errorno)
    84		),
    85	
    86		TP_fast_assign(
    87			__assign_str(name);
    88			__entry->pfn = pfn;
    89			__entry->page = page;
    90			__entry->count = count;
    91			__entry->align = align;
    92			__entry->errorno = errorno;
    93		),
    94	
    95		TP_printk("name=%s pfn=0x%lx page=%p count=%lu align=%u errorno=%d",
    96			  __get_str(name),
    97			  __entry->pfn,
    98			  __entry->page,
    99			  __entry->count,
   100			  __entry->align,
   101			  __entry->errorno)
   102	);
   103	
   104	TRACE_EVENT(cma_alloc_busy_retry,
   105	
   106		TP_PROTO(const char *name, unsigned long pfn, const struct page *page,
   107			 unsigned long count, unsigned int align),
   108	
   109		TP_ARGS(name, pfn, page, count, align),
   110	
   111		TP_STRUCT__entry(
   112			__string(name, name)
   113			__field(unsigned long, pfn)
   114			__field(const struct page *, page)
   115			__field(unsigned long, count)
   116			__field(unsigned int, align)
   117		),
   118	
   119		TP_fast_assign(
   120			__assign_str(name);
   121			__entry->pfn = pfn;
   122			__entry->page = page;
   123			__entry->count = count;
   124			__entry->align = align;
   125		),
   126	
   127		TP_printk("name=%s pfn=0x%lx page=%p count=%lu align=%u",
   128			  __get_str(name),
   129			  __entry->pfn,
   130			  __entry->page,
   131			  __entry->count,
   132			  __entry->align)
   133	);
   134	
   135	#endif /* _TRACE_CMA_H */
   136	
   137	/* This part must be outside protection */
 > 138	#include <trace/define_trace.h>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

