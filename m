Return-Path: <linux-kernel+bounces-751835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60291B16E11
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 11:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E5C9169609
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 09:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20ED727BF95;
	Thu, 31 Jul 2025 09:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PeigEeDB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B85242907
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 09:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753952552; cv=none; b=ZS/GV5X2lbNmeynRXkIqy/b5LoCwjLqW/Oj9kNolVz8mvBFq6DAI31jX1om2NOAN/HVWi4i3/I+lzC8T2nx505VXPbso1dRWMhYrPaSxP8NcH39BIgRoBOHQqosPpYiqqLQt4tocNAAzPfhGfYIe1pbmPxD7yG9nvwYjmueAKRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753952552; c=relaxed/simple;
	bh=uFsQd9tWRsTC53EduxApCoO/j0XKUO4CqqQovD9KN9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aj7lhICsmvwMem5oJR+q6TVq91ay9LWlkktVLZEWYIsgb3/uvqGt0x5kafLBKkmfPkockcQt6BCvXU1i91f3/oLyjYO2o05B0IXuZJp5XwFltZcE1hWJT0E5oJ4g8yfT1ZARw7sZHJwUtBIpx/24X9w/QDzjWBKnLWDcY/jpATs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PeigEeDB; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753952551; x=1785488551;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uFsQd9tWRsTC53EduxApCoO/j0XKUO4CqqQovD9KN9A=;
  b=PeigEeDBPUb0CxjhBQxsYYeAoR1WCdr4SPCUY7l+cMlLa5vGVRcz2Jjf
   lNjmFz59R1dfFdX3RDdBjqzRtZUgWj4uA6lgY+hAVF8sU0xqRzmCA/Y6y
   NDVQ6gjaJtmmfz8A5i4vesjjn3CKIagjioEbV1yrKyRyRmoeV/Yc2A5gp
   bDoxI9MDn3wrGwGEYFBghcSaWAxqU4bRvCOBnLugLfA+MH8aJG1EBewXC
   S0lQ/LfRKOgKH1Cce7H+Mew5ZOVlhNADB6fIeetnAxHCAgw3UqxoKok8T
   clZ0GpzzK5NjY/uy5NSBzY7XDci2Q5dD0YSU/m+A7/yxum8EhjKXbVi/m
   A==;
X-CSE-ConnectionGUID: T7FwgbzHS+KMAEdG1Vu+iA==
X-CSE-MsgGUID: EXYcgY2uTf+/sPaznSsNJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="56135985"
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; 
   d="scan'208";a="56135985"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2025 02:02:28 -0700
X-CSE-ConnectionGUID: DtsfQiyYQXGcnZWzH3LvXQ==
X-CSE-MsgGUID: H0KL/C3VSd2btc5ZdeoFVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; 
   d="scan'208";a="163658036"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 31 Jul 2025 02:02:23 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uhPB7-0003aG-10;
	Thu, 31 Jul 2025 09:02:21 +0000
Date: Thu, 31 Jul 2025 17:01:35 +0800
From: kernel test robot <lkp@intel.com>
To: Dimitri Sivanich <sivanich@hpe.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	Jonathan Corbet <corbet@lwn.net>, Steve Wahl <steve.wahl@hpe.com>,
	Justin Ernst <justin.ernst@hpe.com>,
	Kyle Meyer <kyle.meyer@hpe.com>,
	Russ Anderson <russ.anderson@hpe.com>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86/tsc: Disable clocksource watchdog for TSC on recent
 UV
Message-ID: <202507311627.rt0PViwZ-lkp@intel.com>
References: <aIqKYdvlKlBlSoQK@hpe.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIqKYdvlKlBlSoQK@hpe.com>

Hi Dimitri,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/x86/core]
[also build test ERROR on tip/master linus/master v6.16 next-20250731]
[cannot apply to tip/auto-latest]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dimitri-Sivanich/x86-tsc-Disable-clocksource-watchdog-for-TSC-on-recent-UV/20250731-053059
base:   tip/x86/core
patch link:    https://lore.kernel.org/r/aIqKYdvlKlBlSoQK%40hpe.com
patch subject: [PATCH] x86/tsc: Disable clocksource watchdog for TSC on recent UV
config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/20250731/202507311627.rt0PViwZ-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250731/202507311627.rt0PViwZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507311627.rt0PViwZ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: __uv_cpu_info
   >>> referenced by tsc.c
   >>>               arch/x86/kernel/tsc.o:(check_system_tsc_reliable) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

