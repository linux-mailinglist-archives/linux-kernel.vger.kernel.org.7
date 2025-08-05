Return-Path: <linux-kernel+bounces-756932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E55B1BB2B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 21:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED0D07A18DC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 19:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9351426CE12;
	Tue,  5 Aug 2025 19:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I0Walifb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A738486359
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 19:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754423423; cv=none; b=OejccEqyryScHfUORdP4x1/Xdlvx+i8FVBkfQfzzV0ORAQyWpExS2hX+pWSVEcKN89RH5IitJjcFglFsDGKzltMyCfe4kocCMhFXL7OmRjHO+i8/mUj5F+EGdgxex2XpkEfEkcpTmHlrFyUQsDaccsKd6GTxqgyMeWXTdTDVg4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754423423; c=relaxed/simple;
	bh=sq+TsBlokvj2nW5GBy+xlnJIXewATZWVZsqJKTacnf8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hKYfGgfpV+oiH6rszgXdPkt/UiEKPmQWanjH/b6GKck9RkF7sVkkmDThmxKWyVHm+0cQ5oNaxhPwcMkp0dsMH8PXN1qCS0xlkgkDnD3D1bju6GrxHW5Qft2jj2ak8jPI9ZuL3pw2G94/9WukdD2zJb3TSYQa74caLMImUdv635M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I0Walifb; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754423421; x=1785959421;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sq+TsBlokvj2nW5GBy+xlnJIXewATZWVZsqJKTacnf8=;
  b=I0Walifb0rrPE1xAD3dv6fDwwdNP4wDxitLewfEo4oxDMv0DFmU+5qHi
   jsWIxyRr8oLa1aE45Ue7vzWZCuqeV/jjmiHzoF3CxCltZum0EVdecyxSo
   6Jw2J7wfsojXjkauUprDX3oNM9pmSEar/4niqvicJq2Qic93tFBunOe/u
   dgWBxCqS86DbuMBo+ygkETmpkeJQps+lHV6g0wtAX11/Zku5GcrAkAYeG
   Tezs6qFQRu/lXPCy4GW810Pt6oCSzW22zTWDbGUVTTPmiGPvl4JssHKU5
   Z1WT2fbnz30CPe/X2B8hcL1YtyzVV7dF7QTZl6VZEGJisjmlzZC7qkzyD
   w==;
X-CSE-ConnectionGUID: Kkwk7IHxS9iEldiNwljrfA==
X-CSE-MsgGUID: xlpqOMC5StGAWjTqzgrFwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11513"; a="56625718"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="56625718"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 12:50:21 -0700
X-CSE-ConnectionGUID: drbTNnOZRwGL08M5Q8H75g==
X-CSE-MsgGUID: nkPVE99SQ0KhNGkj3pzpzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="169848691"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 05 Aug 2025 12:50:19 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ujNfs-0000ly-31;
	Tue, 05 Aug 2025 19:50:16 +0000
Date: Wed, 6 Aug 2025 03:49:28 +0800
From: kernel test robot <lkp@intel.com>
To: Kees Cook <kees@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: include/linux/ucopysize.h:45:4: error: call to '__bad_copy_from'
 declared with 'error' attribute: copy source size is too small
Message-ID: <202508060351.OMeX2wGa-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6bcdbd62bd56e6d7383f9e06d9d148935b3c9b73
commit: 808aac63e2bdf9bae08485e072bf3d317a18acbf uaccess: Introduce ucopysize.h
date:   5 months ago
config: um-randconfig-001-20250806 (https://download.01.org/0day-ci/archive/20250806/202508060351.OMeX2wGa-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250806/202508060351.OMeX2wGa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508060351.OMeX2wGa-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from net/sctp/socket.c:45:
   In file included from include/linux/sched/signal.h:9:
   In file included from include/linux/sched/task.h:13:
   In file included from include/linux/uaccess.h:10:
>> include/linux/ucopysize.h:45:4: error: call to '__bad_copy_from' declared with 'error' attribute: copy source size is too small
                           __bad_copy_from();
                           ^
   1 error generated.


vim +45 include/linux/ucopysize.h

    36	
    37	static __always_inline __must_check bool
    38	check_copy_size(const void *addr, size_t bytes, bool is_source)
    39	{
    40		int sz = __builtin_object_size(addr, 0);
    41		if (unlikely(sz >= 0 && sz < bytes)) {
    42			if (!__builtin_constant_p(bytes))
    43				copy_overflow(sz, bytes);
    44			else if (is_source)
  > 45				__bad_copy_from();
    46			else
    47				__bad_copy_to();
    48			return false;
    49		}
    50		if (WARN_ON_ONCE(bytes > INT_MAX))
    51			return false;
    52		check_object_size(addr, bytes, is_source);
    53		return true;
    54	}
    55	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

