Return-Path: <linux-kernel+bounces-748581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED7FB14344
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 22:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FD0B163FA5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 20:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4652B239099;
	Mon, 28 Jul 2025 20:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sz/caJwq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AABA2264B3
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 20:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753734762; cv=none; b=j8IeOjjv17XpCHWXJ1/YvaTxuZmyKUJ9z7EBY4B9sCNDEGeoxPQhAe5R/4v6UQXglPKwiyPgUqJPVkK1eg7WXfHb9x4HTLClcjwVp2iW2J49Iv4jqEn5K3HzwG5cvJX26/KclHdU0Ilme6MqXgCNMVqUR74RPgSaqdt/YDSuFh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753734762; c=relaxed/simple;
	bh=r3hiuspETZ83i7Z2LNZvR++4lWJDgVmnkLxlaJUVT3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=in1P2sDeslrZnIJJnTyHpdzAFMTrL+ZbF6xx/kXPJkxZ2BxkAb/senubck0ekXyyJV5LkALZhdM4cmxk+qjIELtBHLHT+w0jcuebznaXQsvswxHsQxGquB9YAqHd6jrbdNnQ6DSx1DDh3pgVrvBRopItyqUZTvhwrgCIa9mpwBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sz/caJwq; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753734760; x=1785270760;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=r3hiuspETZ83i7Z2LNZvR++4lWJDgVmnkLxlaJUVT3A=;
  b=Sz/caJwqzriJerhb5tyH44YAaedbfLnCSVrjMZaaV+WhRM/cO+5BFj61
   Lg3irsodx9Jgzsum8vEVYvYTT+QXxmywpgKPRKeotQ0jqkTt059bP1ClX
   0V7Noqh8C0QfR9QH+eJ0rUEG0u9pN/tCJ86d1KY396rrSOEKrPT8TMvmr
   b8UVp69FzLke2hbeLhuTkbLetfmiQpuaZRZvyqyfekWsHFvOXARzh0MAW
   c0RKQRQhboSdiAcAVsmmLOb+p49zk6qwY6lE7g3fpDaRldsUrzAC+691x
   oF9wAJ7lzDTRe3+K6tqvDl+mZd2JTlz7PusndehtS9/58FkSigI8RTT+O
   g==;
X-CSE-ConnectionGUID: LGNF9glUReSEjLzQcV5+dw==
X-CSE-MsgGUID: qKDLonJYSsW4GP5z2iashQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11505"; a="59641835"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="59641835"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 13:32:40 -0700
X-CSE-ConnectionGUID: 2wrIv/C9QFOOd4BCJV51UA==
X-CSE-MsgGUID: ied5mmcvQVqXnE540yZa8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="162221192"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 28 Jul 2025 13:32:36 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ugUWQ-0000kB-1E;
	Mon, 28 Jul 2025 20:32:34 +0000
Date: Tue, 29 Jul 2025 04:31:52 +0800
From: kernel test robot <lkp@intel.com>
To: Dishank Jogi <jogidishank503@gmail.com>, elver@google.com
Cc: oe-kbuild-all@lists.linux.dev, dvyukov@google.com,
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
	rathod.darshan.0896@gmail.com,
	Dishank Jogi <jogidishank503@gmail.com>
Subject: Re: [PATCH] kcsan: clean up redundant empty macro arguments in
 atomic ops.
Message-ID: <202507290412.DayPyZpH-lkp@intel.com>
References: <20250728104327.48469-1-jogidishank503@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728104327.48469-1-jogidishank503@gmail.com>

Hi Dishank,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.16 next-20250728]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dishank-Jogi/kcsan-clean-up-redundant-empty-macro-arguments-in-atomic-ops/20250728-184659
base:   linus/master
patch link:    https://lore.kernel.org/r/20250728104327.48469-1-jogidishank503%40gmail.com
patch subject: [PATCH] kcsan: clean up redundant empty macro arguments in atomic ops.
config: x86_64-buildonly-randconfig-002-20250729 (https://download.01.org/0day-ci/archive/20250729/202507290412.DayPyZpH-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250729/202507290412.DayPyZpH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507290412.DayPyZpH-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/kcsan/core.c:1270:1: error: macro "DEFINE_TSAN_ATOMIC_RMW" requires 3 arguments, but only 2 given
    1270 | DEFINE_TSAN_ATOMIC_OPS(8);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~             
   kernel/kcsan/core.c:1193: note: macro "DEFINE_TSAN_ATOMIC_RMW" defined here
    1193 | #define DEFINE_TSAN_ATOMIC_RMW(op, bits, suffix)                                                   \
         | 
>> kernel/kcsan/core.c:1260:9: warning: data definition has no type or storage class
    1260 |         DEFINE_TSAN_ATOMIC_RMW(fetch_add, bits);                                                 \
         |         ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1270:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
    1270 | DEFINE_TSAN_ATOMIC_OPS(8);
         | ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1260:9: error: type defaults to 'int' in declaration of 'DEFINE_TSAN_ATOMIC_RMW' [-Werror=implicit-int]
    1260 |         DEFINE_TSAN_ATOMIC_RMW(fetch_add, bits);                                                 \
         |         ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1270:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
    1270 | DEFINE_TSAN_ATOMIC_OPS(8);
         | ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1270:1: error: macro "DEFINE_TSAN_ATOMIC_RMW" requires 3 arguments, but only 2 given
    1270 | DEFINE_TSAN_ATOMIC_OPS(8);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~             
   kernel/kcsan/core.c:1193: note: macro "DEFINE_TSAN_ATOMIC_RMW" defined here
    1193 | #define DEFINE_TSAN_ATOMIC_RMW(op, bits, suffix)                                                   \
         | 
   kernel/kcsan/core.c:1261:9: warning: data definition has no type or storage class
    1261 |         DEFINE_TSAN_ATOMIC_RMW(fetch_sub, bits);                                                 \
         |         ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1270:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
    1270 | DEFINE_TSAN_ATOMIC_OPS(8);
         | ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1261:9: error: type defaults to 'int' in declaration of 'DEFINE_TSAN_ATOMIC_RMW' [-Werror=implicit-int]
    1261 |         DEFINE_TSAN_ATOMIC_RMW(fetch_sub, bits);                                                 \
         |         ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1270:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
    1270 | DEFINE_TSAN_ATOMIC_OPS(8);
         | ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1270:1: error: macro "DEFINE_TSAN_ATOMIC_RMW" requires 3 arguments, but only 2 given
    1270 | DEFINE_TSAN_ATOMIC_OPS(8);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~             
   kernel/kcsan/core.c:1193: note: macro "DEFINE_TSAN_ATOMIC_RMW" defined here
    1193 | #define DEFINE_TSAN_ATOMIC_RMW(op, bits, suffix)                                                   \
         | 
   kernel/kcsan/core.c:1262:9: warning: data definition has no type or storage class
    1262 |         DEFINE_TSAN_ATOMIC_RMW(fetch_and, bits);                                                 \
         |         ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1270:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
    1270 | DEFINE_TSAN_ATOMIC_OPS(8);
         | ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1262:9: error: type defaults to 'int' in declaration of 'DEFINE_TSAN_ATOMIC_RMW' [-Werror=implicit-int]
    1262 |         DEFINE_TSAN_ATOMIC_RMW(fetch_and, bits);                                                 \
         |         ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1270:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
    1270 | DEFINE_TSAN_ATOMIC_OPS(8);
         | ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1270:1: error: macro "DEFINE_TSAN_ATOMIC_RMW" requires 3 arguments, but only 2 given
    1270 | DEFINE_TSAN_ATOMIC_OPS(8);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~             
   kernel/kcsan/core.c:1193: note: macro "DEFINE_TSAN_ATOMIC_RMW" defined here
    1193 | #define DEFINE_TSAN_ATOMIC_RMW(op, bits, suffix)                                                   \
         | 
   kernel/kcsan/core.c:1263:9: warning: data definition has no type or storage class
    1263 |         DEFINE_TSAN_ATOMIC_RMW(fetch_or, bits);                                                  \
         |         ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1270:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
    1270 | DEFINE_TSAN_ATOMIC_OPS(8);
         | ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1263:9: error: type defaults to 'int' in declaration of 'DEFINE_TSAN_ATOMIC_RMW' [-Werror=implicit-int]
    1263 |         DEFINE_TSAN_ATOMIC_RMW(fetch_or, bits);                                                  \
         |         ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1270:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
    1270 | DEFINE_TSAN_ATOMIC_OPS(8);
         | ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1270:1: error: macro "DEFINE_TSAN_ATOMIC_RMW" requires 3 arguments, but only 2 given
    1270 | DEFINE_TSAN_ATOMIC_OPS(8);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~             
   kernel/kcsan/core.c:1193: note: macro "DEFINE_TSAN_ATOMIC_RMW" defined here
    1193 | #define DEFINE_TSAN_ATOMIC_RMW(op, bits, suffix)                                                   \
         | 
   kernel/kcsan/core.c:1264:9: warning: data definition has no type or storage class
    1264 |         DEFINE_TSAN_ATOMIC_RMW(fetch_xor, bits);                                                 \
         |         ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1270:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
    1270 | DEFINE_TSAN_ATOMIC_OPS(8);
         | ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1264:9: error: type defaults to 'int' in declaration of 'DEFINE_TSAN_ATOMIC_RMW' [-Werror=implicit-int]
    1264 |         DEFINE_TSAN_ATOMIC_RMW(fetch_xor, bits);                                                 \
         |         ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1270:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
    1270 | DEFINE_TSAN_ATOMIC_OPS(8);
         | ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1270:1: error: macro "DEFINE_TSAN_ATOMIC_RMW" requires 3 arguments, but only 2 given
    1270 | DEFINE_TSAN_ATOMIC_OPS(8);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~             
   kernel/kcsan/core.c:1193: note: macro "DEFINE_TSAN_ATOMIC_RMW" defined here
    1193 | #define DEFINE_TSAN_ATOMIC_RMW(op, bits, suffix)                                                   \
         | 
   kernel/kcsan/core.c:1265:9: warning: data definition has no type or storage class
    1265 |         DEFINE_TSAN_ATOMIC_RMW(fetch_nand, bits);                                                \
         |         ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1270:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
    1270 | DEFINE_TSAN_ATOMIC_OPS(8);
         | ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1265:9: error: type defaults to 'int' in declaration of 'DEFINE_TSAN_ATOMIC_RMW' [-Werror=implicit-int]
    1265 |         DEFINE_TSAN_ATOMIC_RMW(fetch_nand, bits);                                                \
         |         ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1270:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
    1270 | DEFINE_TSAN_ATOMIC_OPS(8);
         | ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1271:1: error: macro "DEFINE_TSAN_ATOMIC_RMW" requires 3 arguments, but only 2 given
    1271 | DEFINE_TSAN_ATOMIC_OPS(16);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~             
   kernel/kcsan/core.c:1193: note: macro "DEFINE_TSAN_ATOMIC_RMW" defined here
    1193 | #define DEFINE_TSAN_ATOMIC_RMW(op, bits, suffix)                                                   \
         | 
>> kernel/kcsan/core.c:1260:9: warning: data definition has no type or storage class
    1260 |         DEFINE_TSAN_ATOMIC_RMW(fetch_add, bits);                                                 \
         |         ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1271:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
    1271 | DEFINE_TSAN_ATOMIC_OPS(16);
         | ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1260:9: error: type defaults to 'int' in declaration of 'DEFINE_TSAN_ATOMIC_RMW' [-Werror=implicit-int]
    1260 |         DEFINE_TSAN_ATOMIC_RMW(fetch_add, bits);                                                 \
         |         ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1271:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
    1271 | DEFINE_TSAN_ATOMIC_OPS(16);
         | ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1271:1: error: macro "DEFINE_TSAN_ATOMIC_RMW" requires 3 arguments, but only 2 given
    1271 | DEFINE_TSAN_ATOMIC_OPS(16);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~             
   kernel/kcsan/core.c:1193: note: macro "DEFINE_TSAN_ATOMIC_RMW" defined here
    1193 | #define DEFINE_TSAN_ATOMIC_RMW(op, bits, suffix)                                                   \
         | 
   kernel/kcsan/core.c:1261:9: warning: data definition has no type or storage class
    1261 |         DEFINE_TSAN_ATOMIC_RMW(fetch_sub, bits);                                                 \
         |         ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1271:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
    1271 | DEFINE_TSAN_ATOMIC_OPS(16);
         | ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1261:9: error: type defaults to 'int' in declaration of 'DEFINE_TSAN_ATOMIC_RMW' [-Werror=implicit-int]
    1261 |         DEFINE_TSAN_ATOMIC_RMW(fetch_sub, bits);                                                 \
         |         ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1271:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
    1271 | DEFINE_TSAN_ATOMIC_OPS(16);
         | ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1271:1: error: macro "DEFINE_TSAN_ATOMIC_RMW" requires 3 arguments, but only 2 given
    1271 | DEFINE_TSAN_ATOMIC_OPS(16);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~             
   kernel/kcsan/core.c:1193: note: macro "DEFINE_TSAN_ATOMIC_RMW" defined here
    1193 | #define DEFINE_TSAN_ATOMIC_RMW(op, bits, suffix)                                                   \
         | 
   kernel/kcsan/core.c:1262:9: warning: data definition has no type or storage class
    1262 |         DEFINE_TSAN_ATOMIC_RMW(fetch_and, bits);                                                 \
         |         ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1271:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
    1271 | DEFINE_TSAN_ATOMIC_OPS(16);
         | ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1262:9: error: type defaults to 'int' in declaration of 'DEFINE_TSAN_ATOMIC_RMW' [-Werror=implicit-int]
    1262 |         DEFINE_TSAN_ATOMIC_RMW(fetch_and, bits);                                                 \
         |         ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1271:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
    1271 | DEFINE_TSAN_ATOMIC_OPS(16);
         | ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1271:1: error: macro "DEFINE_TSAN_ATOMIC_RMW" requires 3 arguments, but only 2 given
    1271 | DEFINE_TSAN_ATOMIC_OPS(16);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~             
   kernel/kcsan/core.c:1193: note: macro "DEFINE_TSAN_ATOMIC_RMW" defined here
    1193 | #define DEFINE_TSAN_ATOMIC_RMW(op, bits, suffix)                                                   \
         | 
   kernel/kcsan/core.c:1263:9: warning: data definition has no type or storage class
    1263 |         DEFINE_TSAN_ATOMIC_RMW(fetch_or, bits);                                                  \
         |         ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1271:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
    1271 | DEFINE_TSAN_ATOMIC_OPS(16);
         | ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1263:9: error: type defaults to 'int' in declaration of 'DEFINE_TSAN_ATOMIC_RMW' [-Werror=implicit-int]
    1263 |         DEFINE_TSAN_ATOMIC_RMW(fetch_or, bits);                                                  \
         |         ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1271:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
    1271 | DEFINE_TSAN_ATOMIC_OPS(16);
         | ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1271:1: error: macro "DEFINE_TSAN_ATOMIC_RMW" requires 3 arguments, but only 2 given
    1271 | DEFINE_TSAN_ATOMIC_OPS(16);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~             
   kernel/kcsan/core.c:1193: note: macro "DEFINE_TSAN_ATOMIC_RMW" defined here
    1193 | #define DEFINE_TSAN_ATOMIC_RMW(op, bits, suffix)                                                   \
         | 
   kernel/kcsan/core.c:1264:9: warning: data definition has no type or storage class
    1264 |         DEFINE_TSAN_ATOMIC_RMW(fetch_xor, bits);                                                 \
         |         ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1271:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
    1271 | DEFINE_TSAN_ATOMIC_OPS(16);
         | ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1264:9: error: type defaults to 'int' in declaration of 'DEFINE_TSAN_ATOMIC_RMW' [-Werror=implicit-int]
    1264 |         DEFINE_TSAN_ATOMIC_RMW(fetch_xor, bits);                                                 \
         |         ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1271:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
    1271 | DEFINE_TSAN_ATOMIC_OPS(16);
         | ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1271:1: error: macro "DEFINE_TSAN_ATOMIC_RMW" requires 3 arguments, but only 2 given
    1271 | DEFINE_TSAN_ATOMIC_OPS(16);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~             
   kernel/kcsan/core.c:1193: note: macro "DEFINE_TSAN_ATOMIC_RMW" defined here
    1193 | #define DEFINE_TSAN_ATOMIC_RMW(op, bits, suffix)                                                   \
         | 
   kernel/kcsan/core.c:1265:9: warning: data definition has no type or storage class
    1265 |         DEFINE_TSAN_ATOMIC_RMW(fetch_nand, bits);                                                \
         |         ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1271:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
    1271 | DEFINE_TSAN_ATOMIC_OPS(16);
         | ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1265:9: error: type defaults to 'int' in declaration of 'DEFINE_TSAN_ATOMIC_RMW' [-Werror=implicit-int]
    1265 |         DEFINE_TSAN_ATOMIC_RMW(fetch_nand, bits);                                                \
         |         ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1271:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
    1271 | DEFINE_TSAN_ATOMIC_OPS(16);
         | ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1272:1: error: macro "DEFINE_TSAN_ATOMIC_RMW" requires 3 arguments, but only 2 given
    1272 | DEFINE_TSAN_ATOMIC_OPS(32);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~             
   kernel/kcsan/core.c:1193: note: macro "DEFINE_TSAN_ATOMIC_RMW" defined here
    1193 | #define DEFINE_TSAN_ATOMIC_RMW(op, bits, suffix)                                                   \
         | 
>> kernel/kcsan/core.c:1260:9: warning: data definition has no type or storage class
    1260 |         DEFINE_TSAN_ATOMIC_RMW(fetch_add, bits);                                                 \
         |         ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1272:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
    1272 | DEFINE_TSAN_ATOMIC_OPS(32);
         | ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1260:9: error: type defaults to 'int' in declaration of 'DEFINE_TSAN_ATOMIC_RMW' [-Werror=implicit-int]
    1260 |         DEFINE_TSAN_ATOMIC_RMW(fetch_add, bits);                                                 \
         |         ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1272:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
    1272 | DEFINE_TSAN_ATOMIC_OPS(32);
         | ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1272:1: error: macro "DEFINE_TSAN_ATOMIC_RMW" requires 3 arguments, but only 2 given
    1272 | DEFINE_TSAN_ATOMIC_OPS(32);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~             
   kernel/kcsan/core.c:1193: note: macro "DEFINE_TSAN_ATOMIC_RMW" defined here
    1193 | #define DEFINE_TSAN_ATOMIC_RMW(op, bits, suffix)                                                   \
         | 
   kernel/kcsan/core.c:1261:9: warning: data definition has no type or storage class
    1261 |         DEFINE_TSAN_ATOMIC_RMW(fetch_sub, bits);                                                 \
         |         ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1272:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
    1272 | DEFINE_TSAN_ATOMIC_OPS(32);
         | ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1261:9: error: type defaults to 'int' in declaration of 'DEFINE_TSAN_ATOMIC_RMW' [-Werror=implicit-int]
    1261 |         DEFINE_TSAN_ATOMIC_RMW(fetch_sub, bits);                                                 \
         |         ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1272:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
    1272 | DEFINE_TSAN_ATOMIC_OPS(32);
         | ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1272:1: error: macro "DEFINE_TSAN_ATOMIC_RMW" requires 3 arguments, but only 2 given
    1272 | DEFINE_TSAN_ATOMIC_OPS(32);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~             
   kernel/kcsan/core.c:1193: note: macro "DEFINE_TSAN_ATOMIC_RMW" defined here
    1193 | #define DEFINE_TSAN_ATOMIC_RMW(op, bits, suffix)                                                   \
         | 
   kernel/kcsan/core.c:1262:9: warning: data definition has no type or storage class
    1262 |         DEFINE_TSAN_ATOMIC_RMW(fetch_and, bits);                                                 \
         |         ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1272:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
    1272 | DEFINE_TSAN_ATOMIC_OPS(32);
         | ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1262:9: error: type defaults to 'int' in declaration of 'DEFINE_TSAN_ATOMIC_RMW' [-Werror=implicit-int]
    1262 |         DEFINE_TSAN_ATOMIC_RMW(fetch_and, bits);                                                 \
         |         ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1272:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
    1272 | DEFINE_TSAN_ATOMIC_OPS(32);
         | ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1272:1: error: macro "DEFINE_TSAN_ATOMIC_RMW" requires 3 arguments, but only 2 given
    1272 | DEFINE_TSAN_ATOMIC_OPS(32);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~             
   kernel/kcsan/core.c:1193: note: macro "DEFINE_TSAN_ATOMIC_RMW" defined here
    1193 | #define DEFINE_TSAN_ATOMIC_RMW(op, bits, suffix)                                                   \
         | 
   kernel/kcsan/core.c:1263:9: warning: data definition has no type or storage class
    1263 |         DEFINE_TSAN_ATOMIC_RMW(fetch_or, bits);                                                  \
         |         ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1272:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
    1272 | DEFINE_TSAN_ATOMIC_OPS(32);
         | ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1263:9: error: type defaults to 'int' in declaration of 'DEFINE_TSAN_ATOMIC_RMW' [-Werror=implicit-int]
    1263 |         DEFINE_TSAN_ATOMIC_RMW(fetch_or, bits);                                                  \
         |         ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1272:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
    1272 | DEFINE_TSAN_ATOMIC_OPS(32);
         | ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1272:1: error: macro "DEFINE_TSAN_ATOMIC_RMW" requires 3 arguments, but only 2 given
    1272 | DEFINE_TSAN_ATOMIC_OPS(32);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~             
   kernel/kcsan/core.c:1193: note: macro "DEFINE_TSAN_ATOMIC_RMW" defined here
    1193 | #define DEFINE_TSAN_ATOMIC_RMW(op, bits, suffix)                                                   \
         | 
   kernel/kcsan/core.c:1264:9: warning: data definition has no type or storage class
    1264 |         DEFINE_TSAN_ATOMIC_RMW(fetch_xor, bits);                                                 \
         |         ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1272:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
    1272 | DEFINE_TSAN_ATOMIC_OPS(32);
         | ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1264:9: error: type defaults to 'int' in declaration of 'DEFINE_TSAN_ATOMIC_RMW' [-Werror=implicit-int]
    1264 |         DEFINE_TSAN_ATOMIC_RMW(fetch_xor, bits);                                                 \
         |         ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1272:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
    1272 | DEFINE_TSAN_ATOMIC_OPS(32);
         | ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1272:1: error: macro "DEFINE_TSAN_ATOMIC_RMW" requires 3 arguments, but only 2 given
    1272 | DEFINE_TSAN_ATOMIC_OPS(32);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~             
   kernel/kcsan/core.c:1193: note: macro "DEFINE_TSAN_ATOMIC_RMW" defined here
    1193 | #define DEFINE_TSAN_ATOMIC_RMW(op, bits, suffix)                                                   \
         | 
   kernel/kcsan/core.c:1265:9: warning: data definition has no type or storage class
    1265 |         DEFINE_TSAN_ATOMIC_RMW(fetch_nand, bits);                                                \
         |         ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1272:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
    1272 | DEFINE_TSAN_ATOMIC_OPS(32);
         | ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1265:9: error: type defaults to 'int' in declaration of 'DEFINE_TSAN_ATOMIC_RMW' [-Werror=implicit-int]
    1265 |         DEFINE_TSAN_ATOMIC_RMW(fetch_nand, bits);                                                \
         |         ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1272:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
    1272 | DEFINE_TSAN_ATOMIC_OPS(32);
         | ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1274:1: error: macro "DEFINE_TSAN_ATOMIC_RMW" requires 3 arguments, but only 2 given
    1274 | DEFINE_TSAN_ATOMIC_OPS(64);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~             
   kernel/kcsan/core.c:1193: note: macro "DEFINE_TSAN_ATOMIC_RMW" defined here
    1193 | #define DEFINE_TSAN_ATOMIC_RMW(op, bits, suffix)                                                   \
         | 
>> kernel/kcsan/core.c:1260:9: warning: data definition has no type or storage class
    1260 |         DEFINE_TSAN_ATOMIC_RMW(fetch_add, bits);                                                 \
         |         ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1274:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
    1274 | DEFINE_TSAN_ATOMIC_OPS(64);
         | ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1260:9: error: type defaults to 'int' in declaration of 'DEFINE_TSAN_ATOMIC_RMW' [-Werror=implicit-int]
    1260 |         DEFINE_TSAN_ATOMIC_RMW(fetch_add, bits);                                                 \
         |         ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1274:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
    1274 | DEFINE_TSAN_ATOMIC_OPS(64);
         | ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1274:1: error: macro "DEFINE_TSAN_ATOMIC_RMW" requires 3 arguments, but only 2 given
    1274 | DEFINE_TSAN_ATOMIC_OPS(64);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~             
   kernel/kcsan/core.c:1193: note: macro "DEFINE_TSAN_ATOMIC_RMW" defined here
    1193 | #define DEFINE_TSAN_ATOMIC_RMW(op, bits, suffix)                                                   \
         | 
   kernel/kcsan/core.c:1261:9: warning: data definition has no type or storage class
    1261 |         DEFINE_TSAN_ATOMIC_RMW(fetch_sub, bits);                                                 \
         |         ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1274:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
    1274 | DEFINE_TSAN_ATOMIC_OPS(64);
         | ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1261:9: error: type defaults to 'int' in declaration of 'DEFINE_TSAN_ATOMIC_RMW' [-Werror=implicit-int]
    1261 |         DEFINE_TSAN_ATOMIC_RMW(fetch_sub, bits);                                                 \
         |         ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1274:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
    1274 | DEFINE_TSAN_ATOMIC_OPS(64);
         | ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1274:1: error: macro "DEFINE_TSAN_ATOMIC_RMW" requires 3 arguments, but only 2 given
    1274 | DEFINE_TSAN_ATOMIC_OPS(64);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~             
   kernel/kcsan/core.c:1193: note: macro "DEFINE_TSAN_ATOMIC_RMW" defined here
    1193 | #define DEFINE_TSAN_ATOMIC_RMW(op, bits, suffix)                                                   \
         | 
   kernel/kcsan/core.c:1262:9: warning: data definition has no type or storage class
    1262 |         DEFINE_TSAN_ATOMIC_RMW(fetch_and, bits);                                                 \
         |         ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1274:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
    1274 | DEFINE_TSAN_ATOMIC_OPS(64);
         | ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1262:9: error: type defaults to 'int' in declaration of 'DEFINE_TSAN_ATOMIC_RMW' [-Werror=implicit-int]
    1262 |         DEFINE_TSAN_ATOMIC_RMW(fetch_and, bits);                                                 \
         |         ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1274:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
    1274 | DEFINE_TSAN_ATOMIC_OPS(64);
         | ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1274:1: error: macro "DEFINE_TSAN_ATOMIC_RMW" requires 3 arguments, but only 2 given
    1274 | DEFINE_TSAN_ATOMIC_OPS(64);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~             
   kernel/kcsan/core.c:1193: note: macro "DEFINE_TSAN_ATOMIC_RMW" defined here
    1193 | #define DEFINE_TSAN_ATOMIC_RMW(op, bits, suffix)                                                   \
         | 
   kernel/kcsan/core.c:1263:9: warning: data definition has no type or storage class
    1263 |         DEFINE_TSAN_ATOMIC_RMW(fetch_or, bits);                                                  \
         |         ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1274:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
    1274 | DEFINE_TSAN_ATOMIC_OPS(64);
         | ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1263:9: error: type defaults to 'int' in declaration of 'DEFINE_TSAN_ATOMIC_RMW' [-Werror=implicit-int]
    1263 |         DEFINE_TSAN_ATOMIC_RMW(fetch_or, bits);                                                  \
         |         ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1274:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
    1274 | DEFINE_TSAN_ATOMIC_OPS(64);
         | ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1274:1: error: macro "DEFINE_TSAN_ATOMIC_RMW" requires 3 arguments, but only 2 given
    1274 | DEFINE_TSAN_ATOMIC_OPS(64);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~             
   kernel/kcsan/core.c:1193: note: macro "DEFINE_TSAN_ATOMIC_RMW" defined here
    1193 | #define DEFINE_TSAN_ATOMIC_RMW(op, bits, suffix)                                                   \
         | 
   kernel/kcsan/core.c:1264:9: warning: data definition has no type or storage class
    1264 |         DEFINE_TSAN_ATOMIC_RMW(fetch_xor, bits);                                                 \
         |         ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1274:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
    1274 | DEFINE_TSAN_ATOMIC_OPS(64);
         | ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1264:9: error: type defaults to 'int' in declaration of 'DEFINE_TSAN_ATOMIC_RMW' [-Werror=implicit-int]
    1264 |         DEFINE_TSAN_ATOMIC_RMW(fetch_xor, bits);                                                 \
         |         ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1274:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
    1274 | DEFINE_TSAN_ATOMIC_OPS(64);
         | ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1274:1: error: macro "DEFINE_TSAN_ATOMIC_RMW" requires 3 arguments, but only 2 given
    1274 | DEFINE_TSAN_ATOMIC_OPS(64);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~             
   kernel/kcsan/core.c:1193: note: macro "DEFINE_TSAN_ATOMIC_RMW" defined here
    1193 | #define DEFINE_TSAN_ATOMIC_RMW(op, bits, suffix)                                                   \
         | 
   kernel/kcsan/core.c:1265:9: warning: data definition has no type or storage class
    1265 |         DEFINE_TSAN_ATOMIC_RMW(fetch_nand, bits);                                                \
         |         ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1274:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
    1274 | DEFINE_TSAN_ATOMIC_OPS(64);
         | ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1265:9: error: type defaults to 'int' in declaration of 'DEFINE_TSAN_ATOMIC_RMW' [-Werror=implicit-int]
    1265 |         DEFINE_TSAN_ATOMIC_RMW(fetch_nand, bits);                                                \
         |         ^~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/core.c:1274:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
    1274 | DEFINE_TSAN_ATOMIC_OPS(64);


vim +1260 kernel/kcsan/core.c

  1169	
  1170	#define DEFINE_TSAN_ATOMIC_LOAD_STORE(bits)                                                        \
  1171		u##bits __tsan_atomic##bits##_load(const u##bits *ptr, int memorder);                      \
  1172		u##bits __tsan_atomic##bits##_load(const u##bits *ptr, int memorder)                       \
  1173		{                                                                                          \
  1174			kcsan_atomic_builtin_memorder(memorder);                                           \
  1175			if (!IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS)) {                                    \
  1176				check_access(ptr, bits / BITS_PER_BYTE, KCSAN_ACCESS_ATOMIC, _RET_IP_);    \
  1177			}                                                                                  \
  1178			return __atomic_load_n(ptr, memorder);                                             \
  1179		}                                                                                          \
  1180		EXPORT_SYMBOL(__tsan_atomic##bits##_load);                                                 \
  1181		void __tsan_atomic##bits##_store(u##bits *ptr, u##bits v, int memorder);                   \
  1182		void __tsan_atomic##bits##_store(u##bits *ptr, u##bits v, int memorder)                    \
  1183		{                                                                                          \
  1184			kcsan_atomic_builtin_memorder(memorder);                                           \
  1185			if (!IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS)) {                                    \
  1186				check_access(ptr, bits / BITS_PER_BYTE,                                    \
  1187					     KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC, _RET_IP_);          \
  1188			}                                                                                  \
  1189			__atomic_store_n(ptr, v, memorder);                                                \
  1190		}                                                                                          \
  1191		EXPORT_SYMBOL(__tsan_atomic##bits##_store)
  1192	
  1193	#define DEFINE_TSAN_ATOMIC_RMW(op, bits, suffix)                                                   \
  1194		u##bits __tsan_atomic##bits##_##op(u##bits *ptr, u##bits v, int memorder);                 \
  1195		u##bits __tsan_atomic##bits##_##op(u##bits *ptr, u##bits v, int memorder)                  \
  1196		{                                                                                          \
  1197			kcsan_atomic_builtin_memorder(memorder);                                           \
  1198			if (!IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS)) {                                    \
  1199				check_access(ptr, bits / BITS_PER_BYTE,                                    \
  1200					     KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE |                  \
  1201						     KCSAN_ACCESS_ATOMIC, _RET_IP_);                       \
  1202			}                                                                                  \
  1203			return __atomic_##op##suffix(ptr, v, memorder);                                    \
  1204		}                                                                                          \
  1205		EXPORT_SYMBOL(__tsan_atomic##bits##_##op)
  1206	
  1207	/*
  1208	 * Note: CAS operations are always classified as write, even in case they
  1209	 * fail. We cannot perform check_access() after a write, as it might lead to
  1210	 * false positives, in cases such as:
  1211	 *
  1212	 *	T0: __atomic_compare_exchange_n(&p->flag, &old, 1, ...)
  1213	 *
  1214	 *	T1: if (__atomic_load_n(&p->flag, ...)) {
  1215	 *		modify *p;
  1216	 *		p->flag = 0;
  1217	 *	    }
  1218	 *
  1219	 * The only downside is that, if there are 3 threads, with one CAS that
  1220	 * succeeds, another CAS that fails, and an unmarked racing operation, we may
  1221	 * point at the wrong CAS as the source of the race. However, if we assume that
  1222	 * all CAS can succeed in some other execution, the data race is still valid.
  1223	 */
  1224	#define DEFINE_TSAN_ATOMIC_CMPXCHG(bits, strength, weak)                                           \
  1225		int __tsan_atomic##bits##_compare_exchange_##strength(u##bits *ptr, u##bits *exp,          \
  1226								      u##bits val, int mo, int fail_mo);   \
  1227		int __tsan_atomic##bits##_compare_exchange_##strength(u##bits *ptr, u##bits *exp,          \
  1228								      u##bits val, int mo, int fail_mo)    \
  1229		{                                                                                          \
  1230			kcsan_atomic_builtin_memorder(mo);                                                 \
  1231			if (!IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS)) {                                    \
  1232				check_access(ptr, bits / BITS_PER_BYTE,                                    \
  1233					     KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE |                  \
  1234						     KCSAN_ACCESS_ATOMIC, _RET_IP_);                       \
  1235			}                                                                                  \
  1236			return __atomic_compare_exchange_n(ptr, exp, val, weak, mo, fail_mo);              \
  1237		}                                                                                          \
  1238		EXPORT_SYMBOL(__tsan_atomic##bits##_compare_exchange_##strength)
  1239	
  1240	#define DEFINE_TSAN_ATOMIC_CMPXCHG_VAL(bits)                                                       \
  1241		u##bits __tsan_atomic##bits##_compare_exchange_val(u##bits *ptr, u##bits exp, u##bits val, \
  1242								   int mo, int fail_mo);                   \
  1243		u##bits __tsan_atomic##bits##_compare_exchange_val(u##bits *ptr, u##bits exp, u##bits val, \
  1244								   int mo, int fail_mo)                    \
  1245		{                                                                                          \
  1246			kcsan_atomic_builtin_memorder(mo);                                                 \
  1247			if (!IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS)) {                                    \
  1248				check_access(ptr, bits / BITS_PER_BYTE,                                    \
  1249					     KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE |                  \
  1250						     KCSAN_ACCESS_ATOMIC, _RET_IP_);                       \
  1251			}                                                                                  \
  1252			__atomic_compare_exchange_n(ptr, &exp, val, 0, mo, fail_mo);                       \
  1253			return exp;                                                                        \
  1254		}                                                                                          \
  1255		EXPORT_SYMBOL(__tsan_atomic##bits##_compare_exchange_val)
  1256	
  1257	#define DEFINE_TSAN_ATOMIC_OPS(bits)                                                               \
  1258		DEFINE_TSAN_ATOMIC_LOAD_STORE(bits);                                                       \
  1259		DEFINE_TSAN_ATOMIC_RMW(exchange, bits, _n);                                                \
> 1260		DEFINE_TSAN_ATOMIC_RMW(fetch_add, bits);                                                 \
  1261		DEFINE_TSAN_ATOMIC_RMW(fetch_sub, bits);                                                 \
  1262		DEFINE_TSAN_ATOMIC_RMW(fetch_and, bits);                                                 \
  1263		DEFINE_TSAN_ATOMIC_RMW(fetch_or, bits);                                                  \
  1264		DEFINE_TSAN_ATOMIC_RMW(fetch_xor, bits);                                                 \
  1265		DEFINE_TSAN_ATOMIC_RMW(fetch_nand, bits);                                                \
  1266		DEFINE_TSAN_ATOMIC_CMPXCHG(bits, strong, 0);                                               \
  1267		DEFINE_TSAN_ATOMIC_CMPXCHG(bits, weak, 1);                                                 \
  1268		DEFINE_TSAN_ATOMIC_CMPXCHG_VAL(bits)
  1269	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

