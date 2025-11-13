Return-Path: <linux-kernel+bounces-899844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF4AC58F7D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 72070360C77
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A867335F8D9;
	Thu, 13 Nov 2025 16:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bOjceUm7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808EC35BDAE
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051863; cv=none; b=mkHJDAHR7hnLGadg8Wvs/r+N/fUvvlRANY3DTC1f1yZZPV6IQPpM92wWRP0wam9bVeyKucxtTBkgILRkf88ZE98FIJw9nKfcJIp4+ancRsUrAfkZF4JL2usa8wI+HoGFhOn6836YjMM3OalQZRNb8DihgbOhHvhIm7K/Y0gYSOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051863; c=relaxed/simple;
	bh=Mmqn1Kyfev0y06jqAaqtR8wdEE/IcmPcYenfXFTbKkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MYbZyea6yGzp+P+svw/T8YaI1v6PVVKfPOEs9zHpHfHvzju44BpaRhZaLdrhuMiPqyB7e7wSV7nj97pXv+czd16dpMXZGNiaI5WzCrNeYGBHt0eC0UtHB6Q05QswHVeFuehBFAPc/fVHN3RePjwj23i1zofdnZytgIZAmWHlsp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bOjceUm7; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763051861; x=1794587861;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Mmqn1Kyfev0y06jqAaqtR8wdEE/IcmPcYenfXFTbKkE=;
  b=bOjceUm7yUjT5OJov8MnKRefti0g2QQ6QbEaHUsBGTLIeU2i84rKg6z1
   AedaxQm5D4lJniZevoFDpR7p5vUzIr2OZkuVrK8oe2Ffr8k/+5X58hVo7
   0j8JZ0mva4Zwy6dvr3lmnQ54d+T+tEC+6oTJj9iuIOEFOxJREoxAcmmhf
   bHQCy6cmeEQIXzsjyQDCBrxTqL3hxS37NyDkoUMVYzEWrvrV3kL6ygQrC
   O55lJ52pG5QlxwTQMsngJgyrw4udVMJBivgkxHHQUy4ORPzVPhCkD7F4B
   mYh+n6FVku4g+Q1kitUNMoEBpcWRda2Y8ZbglTzwplx69Uhs9Cn2kI72i
   A==;
X-CSE-ConnectionGUID: GnAd3A7SReyncquW/WJWqg==
X-CSE-MsgGUID: zXZDluryQLOiEJ51Q35zhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="65045388"
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="65045388"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 08:37:41 -0800
X-CSE-ConnectionGUID: 7RiY0OdzT9aFiYWmhk1nDQ==
X-CSE-MsgGUID: fJiTG3P2Q+KgY/WZ3m7agw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="220358821"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 13 Nov 2025 08:37:36 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vJaKE-0005Zf-1n;
	Thu, 13 Nov 2025 16:37:34 +0000
Date: Fri, 14 Nov 2025 00:37:27 +0800
From: kernel test robot <lkp@intel.com>
To: Srikar Dronamraju <srikar@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Srikar Dronamraju <srikar@linux.ibm.com>
Subject: Re: [PATCH 2/2] pseries/dtl: Remove locks held warning.
Message-ID: <202511140025.2eZn4KhO-lkp@intel.com>
References: <20251112111051.826922-2-srikar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112111051.826922-2-srikar@linux.ibm.com>

Hi Srikar,

kernel test robot noticed the following build errors:

[auto build test ERROR on powerpc/next]
[also build test ERROR on powerpc/fixes linus/master v6.18-rc5 next-20251113]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Srikar-Dronamraju/pseries-dtl-Remove-locks-held-warning/20251112-191217
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
patch link:    https://lore.kernel.org/r/20251112111051.826922-2-srikar%40linux.ibm.com
patch subject: [PATCH 2/2] pseries/dtl: Remove locks held warning.
config: powerpc64-randconfig-001-20251113 (https://download.01.org/0day-ci/archive/20251114/202511140025.2eZn4KhO-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 0bba1e76581bad04e7d7f09f5115ae5e2989e0d9)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251114/202511140025.2eZn4KhO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511140025.2eZn4KhO-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: dtl_count
   >>> referenced by lpar.c
   >>>               arch/powerpc/platforms/pseries/lpar.o:(.toc+0x88) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

