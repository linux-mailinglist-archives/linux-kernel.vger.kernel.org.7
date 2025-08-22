Return-Path: <linux-kernel+bounces-781676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 608A0B31562
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B71A51CE7CC2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 10:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5F82E92DF;
	Fri, 22 Aug 2025 10:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X4mYBJrn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D942E9ED0
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755858420; cv=none; b=cu3p1HtsqpiqxVWLU4GqbJOUL0gA6nvwM+XoEDtrBg4wIJVWsAIL1mhn9nQELKl/oUAdg8H4/wX6laueZfvG0XzL1ExfCN7YQQ5i/2uhoLfn1nOT/J8U8KRDkyJ/c3oI/0dEjeK270mby6hz/A1dsPAv4l+KCv0HMKpajVyoqk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755858420; c=relaxed/simple;
	bh=3sn3980IVXfFLfphdS3EBqJPJpq1/RlVKRKQ+S0oe/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cgr3dOBmd2xru1AlMYJ2cNX+FA25ndXsgRaV4DBMc9xeoHEeAUzqw9HGdRTrzuYzMv6ogsPjHwT5zdxA539EPFP+N3SzbDzDk+KIygnYzUz+za5SORLRZjxVf6A2LNxc0ZbFSafnhmsStGtwdzxnlW7bApeXAveg4kQzJvZG8cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X4mYBJrn; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755858418; x=1787394418;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3sn3980IVXfFLfphdS3EBqJPJpq1/RlVKRKQ+S0oe/Y=;
  b=X4mYBJrnl+cpHRJKFtZQkd3z0pfZko+mgqH1l9OQvPJEFWX7K96ReNtc
   +Qddt5Kf8WnR1+kmr7VJd7ROW4f7lwb1s03SrdYcFcMj1/g3EgyuxNHqt
   MI68F3Hc5zkMjgU5GMKSrlTLK2E7sm7sNRHXaubtnlqD5uI+sLjatYMFH
   X8WsSvx2Wcd6OILU6+uB3O+fmJ3Ry54N/LSz5MTy9DIm5lG8sO/1NATbh
   rIuCXHoKer8u7Eayyln6CSgSvorXYUuBP7MBB3OlASCryh/IecUbpjWzb
   MbNAbfV+kvBODa2nlL/RO3WyzxaVLVOl/IfBw0RRMD16ZWzlQKEGiwGEA
   w==;
X-CSE-ConnectionGUID: 6wix8cVLTre26FCJs5thUQ==
X-CSE-MsgGUID: b/+OfF26Rw2E6IkdJR6EtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="68764116"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="68764116"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 03:26:57 -0700
X-CSE-ConnectionGUID: a4JQPw8NQkCI7GVaJ55pFw==
X-CSE-MsgGUID: yRtNSGt+THu19a+22QgNKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="169039958"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 22 Aug 2025 03:26:38 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1upOyi-000L9v-13;
	Fri, 22 Aug 2025 10:26:36 +0000
Date: Fri, 22 Aug 2025 18:26:31 +0800
From: kernel test robot <lkp@intel.com>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: include/trace/events/dma_fence.h:12:1: sparse: sparse: incorrect
 type in assignment (different address spaces)
Message-ID: <202508221834.hekYlJqU-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3957a5720157264dcc41415fbec7c51c4000fc2d
commit: 506aa8b02a8d6898c64cc095d233fbae1cef8b8a dma-fence: Add safe access helpers and document the rules
date:   2 months ago
config: sh-randconfig-r132-20250822 (https://download.01.org/0day-ci/archive/20250822/202508221834.hekYlJqU-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 15.1.0
reproduce: (https://download.01.org/0day-ci/archive/20250822/202508221834.hekYlJqU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508221834.hekYlJqU-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/dma-buf/dma-fence.c:1112:51: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected char const [noderef] __rcu * @@     got char const * @@
   drivers/dma-buf/dma-fence.c:1112:51: sparse:     expected char const [noderef] __rcu *
   drivers/dma-buf/dma-fence.c:1112:51: sparse:     got char const *
   drivers/dma-buf/dma-fence.c:1114:24: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected char const [noderef] __rcu * @@     got char * @@
   drivers/dma-buf/dma-fence.c:1114:24: sparse:     expected char const [noderef] __rcu *
   drivers/dma-buf/dma-fence.c:1114:24: sparse:     got char *
   drivers/dma-buf/dma-fence.c:1144:51: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected char const [noderef] __rcu * @@     got char const * @@
   drivers/dma-buf/dma-fence.c:1144:51: sparse:     expected char const [noderef] __rcu *
   drivers/dma-buf/dma-fence.c:1144:51: sparse:     got char const *
   drivers/dma-buf/dma-fence.c:1146:24: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected char const [noderef] __rcu * @@     got char * @@
   drivers/dma-buf/dma-fence.c:1146:24: sparse:     expected char const [noderef] __rcu *
   drivers/dma-buf/dma-fence.c:1146:24: sparse:     got char *
   drivers/dma-buf/dma-fence.c: note: in included file (through include/trace/trace_events.h, include/trace/define_trace.h, include/trace/events/dma_fence.h):
   include/trace/events/dma_fence.h:12:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected char const *str @@     got char const [noderef] __rcu * @@
   include/trace/events/dma_fence.h:12:1: sparse:     expected char const *str
   include/trace/events/dma_fence.h:12:1: sparse:     got char const [noderef] __rcu *
   include/trace/events/dma_fence.h:12:1: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void const *driver_ptr_ @@     got char const [noderef] __rcu * @@
   include/trace/events/dma_fence.h:12:1: sparse:     expected void const *driver_ptr_
   include/trace/events/dma_fence.h:12:1: sparse:     got char const [noderef] __rcu *
   include/trace/events/dma_fence.h:12:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected char const *str @@     got char const [noderef] __rcu * @@
   include/trace/events/dma_fence.h:12:1: sparse:     expected char const *str
   include/trace/events/dma_fence.h:12:1: sparse:     got char const [noderef] __rcu *
>> include/trace/events/dma_fence.h:12:1: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void const *timeline_ptr_ @@     got char const [noderef] __rcu * @@
   include/trace/events/dma_fence.h:12:1: sparse:     expected void const *timeline_ptr_
   include/trace/events/dma_fence.h:12:1: sparse:     got char const [noderef] __rcu *
   include/trace/events/dma_fence.h:12:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected char const *str @@     got char const [noderef] __rcu * @@
   include/trace/events/dma_fence.h:12:1: sparse:     expected char const *str
   include/trace/events/dma_fence.h:12:1: sparse:     got char const [noderef] __rcu *
   include/trace/events/dma_fence.h:12:1: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void const *driver_ptr_ @@     got char const [noderef] __rcu * @@
   include/trace/events/dma_fence.h:12:1: sparse:     expected void const *driver_ptr_
   include/trace/events/dma_fence.h:12:1: sparse:     got char const [noderef] __rcu *
   include/trace/events/dma_fence.h:12:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected char const *str @@     got char const [noderef] __rcu * @@
   include/trace/events/dma_fence.h:12:1: sparse:     expected char const *str
   include/trace/events/dma_fence.h:12:1: sparse:     got char const [noderef] __rcu *
>> include/trace/events/dma_fence.h:12:1: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void const *timeline_ptr_ @@     got char const [noderef] __rcu * @@
   include/trace/events/dma_fence.h:12:1: sparse:     expected void const *timeline_ptr_
   include/trace/events/dma_fence.h:12:1: sparse:     got char const [noderef] __rcu *

vim +12 include/trace/events/dma_fence.h

e941759c74a44d include/trace/events/fence.h     Maarten Lankhorst       2014-07-01  11  
f54d1867005c33 include/trace/events/dma_fence.h Chris Wilson            2016-10-25 @12  DECLARE_EVENT_CLASS(dma_fence,
e941759c74a44d include/trace/events/fence.h     Maarten Lankhorst       2014-07-01  13  
f54d1867005c33 include/trace/events/dma_fence.h Chris Wilson            2016-10-25  14  	TP_PROTO(struct dma_fence *fence),
e941759c74a44d include/trace/events/fence.h     Maarten Lankhorst       2014-07-01  15  
e941759c74a44d include/trace/events/fence.h     Maarten Lankhorst       2014-07-01  16  	TP_ARGS(fence),
e941759c74a44d include/trace/events/fence.h     Maarten Lankhorst       2014-07-01  17  
e941759c74a44d include/trace/events/fence.h     Maarten Lankhorst       2014-07-01  18  	TP_STRUCT__entry(
ecec875a6c3379 include/trace/events/dma_fence.h Tvrtko Ursulin          2025-05-15  19  		__string(driver, dma_fence_driver_name(fence))
ecec875a6c3379 include/trace/events/dma_fence.h Tvrtko Ursulin          2025-05-15  20  		__string(timeline, dma_fence_timeline_name(fence))
e941759c74a44d include/trace/events/fence.h     Maarten Lankhorst       2014-07-01  21  		__field(unsigned int, context)
e941759c74a44d include/trace/events/fence.h     Maarten Lankhorst       2014-07-01  22  		__field(unsigned int, seqno)
e941759c74a44d include/trace/events/fence.h     Maarten Lankhorst       2014-07-01  23  	),
e941759c74a44d include/trace/events/fence.h     Maarten Lankhorst       2014-07-01  24  
e941759c74a44d include/trace/events/fence.h     Maarten Lankhorst       2014-07-01  25  	TP_fast_assign(
2c92ca849fcc6e include/trace/events/dma_fence.h Steven Rostedt (Google  2024-05-16  26) 		__assign_str(driver);
2c92ca849fcc6e include/trace/events/dma_fence.h Steven Rostedt (Google  2024-05-16  27) 		__assign_str(timeline);
e941759c74a44d include/trace/events/fence.h     Maarten Lankhorst       2014-07-01  28  		__entry->context = fence->context;
e941759c74a44d include/trace/events/fence.h     Maarten Lankhorst       2014-07-01  29  		__entry->seqno = fence->seqno;
e941759c74a44d include/trace/events/fence.h     Maarten Lankhorst       2014-07-01  30  	),
e941759c74a44d include/trace/events/fence.h     Maarten Lankhorst       2014-07-01  31  
e941759c74a44d include/trace/events/fence.h     Maarten Lankhorst       2014-07-01  32  	TP_printk("driver=%s timeline=%s context=%u seqno=%u",
e941759c74a44d include/trace/events/fence.h     Maarten Lankhorst       2014-07-01  33  		  __get_str(driver), __get_str(timeline), __entry->context,
e941759c74a44d include/trace/events/fence.h     Maarten Lankhorst       2014-07-01  34  		  __entry->seqno)
e941759c74a44d include/trace/events/fence.h     Maarten Lankhorst       2014-07-01  35  );
e941759c74a44d include/trace/events/fence.h     Maarten Lankhorst       2014-07-01  36  

:::::: The code at line 12 was first introduced by commit
:::::: f54d1867005c3323f5d8ad83eed823e84226c429 dma-buf: Rename struct fence to dma_fence

:::::: TO: Chris Wilson <chris@chris-wilson.co.uk>
:::::: CC: Daniel Vetter <daniel.vetter@ffwll.ch>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

