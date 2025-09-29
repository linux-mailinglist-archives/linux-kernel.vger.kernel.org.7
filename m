Return-Path: <linux-kernel+bounces-835756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EEBEBA7FC6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 07:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 108441899858
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 05:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1897427E05B;
	Mon, 29 Sep 2025 05:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BrCqA0fI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C45E239072
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 05:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759123133; cv=none; b=T1fIsj1/b1CNp/dBdQ8eXCv78OS1f3VlCJJ8b9nOp7z0CZUeoWzaILB6JYQKof9/kzJ/+eX+UYEgIR60Evx7ddNa1y0qi4M2KZ5JeGoLVIf8Z6ECsMc/Y1iBBDZBBexg8MPHA6L4f1X6O4GX9DF/datOegIcQoUUUAWHhkpbiXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759123133; c=relaxed/simple;
	bh=9n7zJ2kn9d6m0EFKYn91rhEZExMvcoSIgLTKIGmh3BA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RMOM82Ng9SLWryXxFVFbwALyQCMcwK4gRbXOe4+v4Cn9P9UQXwufxXZVmA+bKL99u0Vg7qne9f0hs/j5dkRrx29qA1Pz6lxcILmzJPpgdPmESTXZuLmalgVqJNW+yNHS8uoqp6mIaAoe/kJPGiKq6ggUGcagr7V/BTn0LAHYoOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BrCqA0fI; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759123131; x=1790659131;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9n7zJ2kn9d6m0EFKYn91rhEZExMvcoSIgLTKIGmh3BA=;
  b=BrCqA0fISvKjCHXFMMHNAll/nQh53siuiRgKCnOree8ha1E+K7KUORrt
   mKBw5JFayKtl4ziR/zogYHVj5KQJ+JZpr0ERuSZzN2VOT4uHdLK5C2BDY
   eG2iOHlETCdZXB/75e7LYaPddwGCyZ0tuTogCCEdsmEvcsBlAj/Lix+gF
   VJdT0GmZJdfEonA7X5f8EBqy12ucBnsBOaO6gOS8uXqF1olTjQ9BgH517
   juE80+LpGJsqeZdIZOHei1VONIRBdDp+AOepXVNZrlnPt1FTORl4LHuF6
   /UG+jQiSabWlEHFDnU4YpD8BdIQMGCZoDnyQW64bvv+8SaZhl+wJxk0ZY
   A==;
X-CSE-ConnectionGUID: CfckwdOdQn2NDt3pZ3x3Cg==
X-CSE-MsgGUID: fpyLVDl5RoqT643foyaG7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11567"; a="72722164"
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; 
   d="scan'208";a="72722164"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2025 22:18:50 -0700
X-CSE-ConnectionGUID: k7hu50N2SZmiEuAGLhZgpQ==
X-CSE-MsgGUID: jpmWnsG8QzCa9NhRuDQ2fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; 
   d="scan'208";a="177265556"
Received: from lkp-server01.sh.intel.com (HELO a2c9da549b7f) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 28 Sep 2025 22:18:48 -0700
Received: from kbuild by a2c9da549b7f with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v36Hd-00003T-2b;
	Mon, 29 Sep 2025 05:18:45 +0000
Date: Mon, 29 Sep 2025 13:18:28 +0800
From: kernel test robot <lkp@intel.com>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: include/trace/events/dma_fence.h:12:1: sparse: sparse: incorrect
 type in argument 1 (different address spaces)
Message-ID: <202509291311.TJCt59RH-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e5f0a698b34ed76002dc5cff3804a61c80233a7a
commit: 506aa8b02a8d6898c64cc095d233fbae1cef8b8a dma-fence: Add safe access helpers and document the rules
date:   4 months ago
config: x86_64-randconfig-121-20250929 (https://download.01.org/0day-ci/archive/20250929/202509291311.TJCt59RH-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250929/202509291311.TJCt59RH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509291311.TJCt59RH-lkp@intel.com/

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
>> include/trace/events/dma_fence.h:12:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected char const *str @@     got char const [noderef] __rcu * @@
   include/trace/events/dma_fence.h:12:1: sparse:     expected char const *str
   include/trace/events/dma_fence.h:12:1: sparse:     got char const [noderef] __rcu *
>> include/trace/events/dma_fence.h:12:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected char const *str @@     got char const [noderef] __rcu * @@
   include/trace/events/dma_fence.h:12:1: sparse:     expected char const *str
   include/trace/events/dma_fence.h:12:1: sparse:     got char const [noderef] __rcu *
>> include/trace/events/dma_fence.h:12:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected char const *str @@     got char const [noderef] __rcu * @@
   include/trace/events/dma_fence.h:12:1: sparse:     expected char const *str
   include/trace/events/dma_fence.h:12:1: sparse:     got char const [noderef] __rcu *
   include/trace/events/dma_fence.h:12:1: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void const *driver_ptr_ @@     got char const [noderef] __rcu * @@
   include/trace/events/dma_fence.h:12:1: sparse:     expected void const *driver_ptr_
   include/trace/events/dma_fence.h:12:1: sparse:     got char const [noderef] __rcu *
>> include/trace/events/dma_fence.h:12:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected char const *str @@     got char const [noderef] __rcu * @@
   include/trace/events/dma_fence.h:12:1: sparse:     expected char const *str
   include/trace/events/dma_fence.h:12:1: sparse:     got char const [noderef] __rcu *
>> include/trace/events/dma_fence.h:12:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected char const *str @@     got char const [noderef] __rcu * @@
   include/trace/events/dma_fence.h:12:1: sparse:     expected char const *str
   include/trace/events/dma_fence.h:12:1: sparse:     got char const [noderef] __rcu *
>> include/trace/events/dma_fence.h:12:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected char const *str @@     got char const [noderef] __rcu * @@
   include/trace/events/dma_fence.h:12:1: sparse:     expected char const *str
   include/trace/events/dma_fence.h:12:1: sparse:     got char const [noderef] __rcu *
>> include/trace/events/dma_fence.h:12:1: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void const *timeline_ptr_ @@     got char const [noderef] __rcu * @@
   include/trace/events/dma_fence.h:12:1: sparse:     expected void const *timeline_ptr_
   include/trace/events/dma_fence.h:12:1: sparse:     got char const [noderef] __rcu *
>> include/trace/events/dma_fence.h:12:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected char const *str @@     got char const [noderef] __rcu * @@
   include/trace/events/dma_fence.h:12:1: sparse:     expected char const *str
   include/trace/events/dma_fence.h:12:1: sparse:     got char const [noderef] __rcu *
>> include/trace/events/dma_fence.h:12:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected char const *str @@     got char const [noderef] __rcu * @@
   include/trace/events/dma_fence.h:12:1: sparse:     expected char const *str
   include/trace/events/dma_fence.h:12:1: sparse:     got char const [noderef] __rcu *
>> include/trace/events/dma_fence.h:12:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected char const *str @@     got char const [noderef] __rcu * @@
   include/trace/events/dma_fence.h:12:1: sparse:     expected char const *str
   include/trace/events/dma_fence.h:12:1: sparse:     got char const [noderef] __rcu *
   include/trace/events/dma_fence.h:12:1: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void const *driver_ptr_ @@     got char const [noderef] __rcu * @@
   include/trace/events/dma_fence.h:12:1: sparse:     expected void const *driver_ptr_
   include/trace/events/dma_fence.h:12:1: sparse:     got char const [noderef] __rcu *
>> include/trace/events/dma_fence.h:12:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected char const *str @@     got char const [noderef] __rcu * @@
   include/trace/events/dma_fence.h:12:1: sparse:     expected char const *str
   include/trace/events/dma_fence.h:12:1: sparse:     got char const [noderef] __rcu *
>> include/trace/events/dma_fence.h:12:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected char const *str @@     got char const [noderef] __rcu * @@
   include/trace/events/dma_fence.h:12:1: sparse:     expected char const *str
   include/trace/events/dma_fence.h:12:1: sparse:     got char const [noderef] __rcu *
>> include/trace/events/dma_fence.h:12:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected char const *str @@     got char const [noderef] __rcu * @@
   include/trace/events/dma_fence.h:12:1: sparse:     expected char const *str
   include/trace/events/dma_fence.h:12:1: sparse:     got char const [noderef] __rcu *
>> include/trace/events/dma_fence.h:12:1: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void const *timeline_ptr_ @@     got char const [noderef] __rcu * @@
   include/trace/events/dma_fence.h:12:1: sparse:     expected void const *timeline_ptr_
   include/trace/events/dma_fence.h:12:1: sparse:     got char const [noderef] __rcu *

vim +12 include/trace/events/dma_fence.h

e941759c74a44d6 include/trace/events/fence.h     Maarten Lankhorst       2014-07-01  11  
f54d1867005c332 include/trace/events/dma_fence.h Chris Wilson            2016-10-25 @12  DECLARE_EVENT_CLASS(dma_fence,
e941759c74a44d6 include/trace/events/fence.h     Maarten Lankhorst       2014-07-01  13  
f54d1867005c332 include/trace/events/dma_fence.h Chris Wilson            2016-10-25  14  	TP_PROTO(struct dma_fence *fence),
e941759c74a44d6 include/trace/events/fence.h     Maarten Lankhorst       2014-07-01  15  
e941759c74a44d6 include/trace/events/fence.h     Maarten Lankhorst       2014-07-01  16  	TP_ARGS(fence),
e941759c74a44d6 include/trace/events/fence.h     Maarten Lankhorst       2014-07-01  17  
e941759c74a44d6 include/trace/events/fence.h     Maarten Lankhorst       2014-07-01  18  	TP_STRUCT__entry(
ecec875a6c33790 include/trace/events/dma_fence.h Tvrtko Ursulin          2025-05-15  19  		__string(driver, dma_fence_driver_name(fence))
ecec875a6c33790 include/trace/events/dma_fence.h Tvrtko Ursulin          2025-05-15  20  		__string(timeline, dma_fence_timeline_name(fence))
e941759c74a44d6 include/trace/events/fence.h     Maarten Lankhorst       2014-07-01  21  		__field(unsigned int, context)
e941759c74a44d6 include/trace/events/fence.h     Maarten Lankhorst       2014-07-01  22  		__field(unsigned int, seqno)
e941759c74a44d6 include/trace/events/fence.h     Maarten Lankhorst       2014-07-01  23  	),
e941759c74a44d6 include/trace/events/fence.h     Maarten Lankhorst       2014-07-01  24  
e941759c74a44d6 include/trace/events/fence.h     Maarten Lankhorst       2014-07-01  25  	TP_fast_assign(
2c92ca849fcc6ee include/trace/events/dma_fence.h Steven Rostedt (Google  2024-05-16  26) 		__assign_str(driver);
2c92ca849fcc6ee include/trace/events/dma_fence.h Steven Rostedt (Google  2024-05-16  27) 		__assign_str(timeline);
e941759c74a44d6 include/trace/events/fence.h     Maarten Lankhorst       2014-07-01  28  		__entry->context = fence->context;
e941759c74a44d6 include/trace/events/fence.h     Maarten Lankhorst       2014-07-01  29  		__entry->seqno = fence->seqno;
e941759c74a44d6 include/trace/events/fence.h     Maarten Lankhorst       2014-07-01  30  	),
e941759c74a44d6 include/trace/events/fence.h     Maarten Lankhorst       2014-07-01  31  
e941759c74a44d6 include/trace/events/fence.h     Maarten Lankhorst       2014-07-01  32  	TP_printk("driver=%s timeline=%s context=%u seqno=%u",
e941759c74a44d6 include/trace/events/fence.h     Maarten Lankhorst       2014-07-01  33  		  __get_str(driver), __get_str(timeline), __entry->context,
e941759c74a44d6 include/trace/events/fence.h     Maarten Lankhorst       2014-07-01  34  		  __entry->seqno)
e941759c74a44d6 include/trace/events/fence.h     Maarten Lankhorst       2014-07-01  35  );
e941759c74a44d6 include/trace/events/fence.h     Maarten Lankhorst       2014-07-01  36  

:::::: The code at line 12 was first introduced by commit
:::::: f54d1867005c3323f5d8ad83eed823e84226c429 dma-buf: Rename struct fence to dma_fence

:::::: TO: Chris Wilson <chris@chris-wilson.co.uk>
:::::: CC: Daniel Vetter <daniel.vetter@ffwll.ch>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

