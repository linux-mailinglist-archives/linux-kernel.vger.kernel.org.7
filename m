Return-Path: <linux-kernel+bounces-847511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF85BCB0E3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 00:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9519319E672D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 22:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D51F2857E9;
	Thu,  9 Oct 2025 22:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TiIh3L2o"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A062848BA
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 22:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760048345; cv=none; b=DF0parnaqiUQm3MI2UNkN/yy2FCMjcBHkME4lv7wgRxA3TjrO2pHoou6Ih5Z6IdFPqrAid4FIqjkvbxuIj0OfG2q+J8HaLlPFyi6+17erY2VJvLaEzgAhWwPQ0jxNeIRdn0OOrREv2LZczDHIW9b2B1wliexD954kMsv6cnFXGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760048345; c=relaxed/simple;
	bh=FH63L4f4agVldlvyuQWNSdonEKLJ0v2i3mUQaA7IUCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nh7iFIIImrBtoY8Jvjo9bpmtWZtCJ0ach4UvOtKk7Ftl+ggEZkqmAweIKFsgCT0EQm5C2j/SEhguDOctOLCqifZXyGXUA4fNJsSkNiAy8YJDvCcImYbiPjUYUPvqXtxoY5jgtzE5TDanbbwcsFrgMnWNrkFdR2Do3KgiNd3t4EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TiIh3L2o; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760048343; x=1791584343;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FH63L4f4agVldlvyuQWNSdonEKLJ0v2i3mUQaA7IUCg=;
  b=TiIh3L2oet/CpcmBhig5Y1p/JQFakObjEpv17IdbtvuINhQAd2m8TWGJ
   Lss570dUuip0ySDAypfuwGVfhC0FCe//1sb7Qx7U1dhCoT2/dVCA1/07E
   Fba7A3i6pVQQN+JAXeRcgushGnk3TrdhzfNJq2b9g5sL5QdZEt6XXUz3/
   7Jr1mIxdVzcuTINh30Si22xrv/4/Oipyl2HA/8aU4Egt+caBeqyIUrPyg
   NPEdS9eHeKKI7iooh63KAdIYXjgXrYT+kUo6ce+L94j4iEMimkckrRMAS
   x81zKpScve/5+8Xgh+eFMA+AjpoQpd5hFQJUfIBtt5ccDy9TgZGvJidK4
   g==;
X-CSE-ConnectionGUID: 60Du13mnQBKJOA/yA9R4mA==
X-CSE-MsgGUID: x/c7yxsCTva25m41n/UIIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11577"; a="73702918"
X-IronPort-AV: E=Sophos;i="6.19,217,1754982000"; 
   d="scan'208";a="73702918"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 15:19:02 -0700
X-CSE-ConnectionGUID: mCaT9/RIROmRg9sraUUCIQ==
X-CSE-MsgGUID: SW0EvskZSKGSF23Uh2V9TQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,217,1754982000"; 
   d="scan'208";a="185080426"
Received: from lkp-server01.sh.intel.com (HELO 6a630e8620ab) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 09 Oct 2025 15:18:59 -0700
Received: from kbuild by 6a630e8620ab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v6yyO-0001YF-1t;
	Thu, 09 Oct 2025 22:18:56 +0000
Date: Fri, 10 Oct 2025 06:18:19 +0800
From: kernel test robot <lkp@intel.com>
To: Ketil Johnsen <ketil.johnsen@arm.com>,
	Boris Brezillon <bbrezillon@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: oe-kbuild-all@lists.linux.dev, Ketil Johnsen <ketil.johnsen@arm.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panthor: Fix UAF race between device unplug and FW
 event processing
Message-ID: <202510100644.YPzFXMEb-lkp@intel.com>
References: <20251008105322.4077661-1-ketil.johnsen@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008105322.4077661-1-ketil.johnsen@arm.com>

Hi Ketil,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-misc/drm-misc-next]
[also build test WARNING on linus/master v6.17 next-20251009]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ketil-Johnsen/drm-panthor-Fix-UAF-race-between-device-unplug-and-FW-event-processing/20251009-184851
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20251008105322.4077661-1-ketil.johnsen%40arm.com
patch subject: [PATCH] drm/panthor: Fix UAF race between device unplug and FW event processing
config: i386-buildonly-randconfig-001-20251010 (https://download.01.org/0day-ci/archive/20251010/202510100644.YPzFXMEb-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251010/202510100644.YPzFXMEb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510100644.YPzFXMEb-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Warning: drivers/gpu/drm/panthor/panthor_sched.c:1788 function parameter 'ptdev' not described in 'panthor_sched_report_fw_events'
   Warning: drivers/gpu/drm/panthor/panthor_sched.c:1788 function parameter 'events' not described in 'panthor_sched_report_fw_events'
>> Warning: drivers/gpu/drm/panthor/panthor_sched.c:1800 function parameter 'ptdev' not described in 'panthor_sched_stop_fw_events'
   Warning: drivers/gpu/drm/panthor/panthor_sched.c:2693 function parameter 'ptdev' not described in 'panthor_sched_report_mmu_fault'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

