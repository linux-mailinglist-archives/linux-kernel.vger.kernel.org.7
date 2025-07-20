Return-Path: <linux-kernel+bounces-738021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C2BB0B346
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 05:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 201C7189C6D3
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 03:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767CA189BB0;
	Sun, 20 Jul 2025 03:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KMya0OaE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D155F22EF5
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 03:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752981514; cv=none; b=BMtW8MeX7nm0tvEN7yd0xospzZ7PJu+Hua+cwBzs5agHfRwHIz2JEJKPug3dq/cJ8tu8DiFfCYIcpXNVfreF0e8hkWnH3AxtR44xw4VUIMjhV9VbFAtwDYikY1mwKi1bSHosOpwhLeU1Ot6UOqoW9q2xVJ50953/e/2p3Tfq2Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752981514; c=relaxed/simple;
	bh=TUvZuE8bTZNxpG+iqKbzshW25PKJjhnIz0SY9mthZZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F9Rlsg5AeiNNAAOJCpjJMgabM75qkkjmAdkgCR/m1MGX0F6oT8RNm5a0k8vwRlmqBeJ3QJ7wiSAoDTLagPnKsz5m9wUsdthrUYOhRDBRQiMEFw4kcfbdpRd/YLdzrK9G2/omNYeZEw1dn4SDISXtk8FsOM7IwhqDcGWAV7rm0jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KMya0OaE; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752981512; x=1784517512;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TUvZuE8bTZNxpG+iqKbzshW25PKJjhnIz0SY9mthZZk=;
  b=KMya0OaEKQLhqZLjRjLOg6VNR+Zgv8c/zNmhjrgelgQV/rpmG54P56YA
   Wu4q7ILtX8wo43BMvG6MTuXRCvqiF38cI0cU9+PVmJiREXIcAzYLY5YbL
   KDfx/Hh9aV1LkrM6L1zWKMmb/FlxthN3uELINXXPWuPNcRdeiLQb/imsr
   TWCe+3BMflF4hMhv6eApyIuzDgxuGad+voTCjT9I+g4BmakuiLUXA/tvz
   t0Efk8DOJqXp6BBr8oIA/6WBZrrCAEwkKtB3ge4CpI6BKBpgPAt0OO0yo
   o+lEglsKSCx833/wcwKdMzZnCMYEeN6ag9nUfZS4KhPrQC73G9rlDycPJ
   w==;
X-CSE-ConnectionGUID: S7OUgykeSemqyYls8P3aGw==
X-CSE-MsgGUID: mjhtWz19TzSm7o5/AVLxrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11497"; a="55082553"
X-IronPort-AV: E=Sophos;i="6.16,325,1744095600"; 
   d="scan'208";a="55082553"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2025 20:18:31 -0700
X-CSE-ConnectionGUID: Bt5LR81QTSefsOMuWfqlAw==
X-CSE-MsgGUID: 2Hvx8RZzRvSJfkzRt797DQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,325,1744095600"; 
   d="scan'208";a="163087321"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 19 Jul 2025 20:18:28 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1udKZG-000FuL-17;
	Sun, 20 Jul 2025 03:18:26 +0000
Date: Sun, 20 Jul 2025 11:17:33 +0800
From: kernel test robot <lkp@intel.com>
To: Chia-I Wu <olvaffe@gmail.com>, Boris Brezillon <bbrezillon@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 1/9] drm/panthor: add devcoredump support
Message-ID: <202507201010.Tou41l73-lkp@intel.com>
References: <20250720000146.1405060-2-olvaffe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250720000146.1405060-2-olvaffe@gmail.com>

Hi Chia-I,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-misc/drm-misc-next]
[also build test WARNING on v6.16-rc6 next-20250718]
[cannot apply to linus/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chia-I-Wu/drm-panthor-add-devcoredump-support/20250720-080312
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20250720000146.1405060-2-olvaffe%40gmail.com
patch subject: [PATCH 1/9] drm/panthor: add devcoredump support
config: x86_64-buildonly-randconfig-004-20250720 (https://download.01.org/0day-ci/archive/20250720/202507201010.Tou41l73-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250720/202507201010.Tou41l73-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507201010.Tou41l73-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/gpu/drm/panthor/panthor_coredump.c:21 Enum value 'PANTHOR_COREDUMP_GROUP' not described in enum 'panthor_coredump_mask'
>> Warning: drivers/gpu/drm/panthor/panthor_coredump.c:29 struct member 'reason' not described in 'panthor_coredump_header'
>> Warning: drivers/gpu/drm/panthor/panthor_coredump.c:29 struct member 'timestamp' not described in 'panthor_coredump_header'
>> Warning: drivers/gpu/drm/panthor/panthor_coredump.c:54 struct member 'group' not described in 'panthor_coredump'
>> Warning: drivers/gpu/drm/panthor/panthor_coredump.c:54 struct member 'data' not described in 'panthor_coredump'
>> Warning: drivers/gpu/drm/panthor/panthor_coredump.c:54 struct member 'size' not described in 'panthor_coredump'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

