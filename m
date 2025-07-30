Return-Path: <linux-kernel+bounces-750143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B117B157DA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 05:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C8AD18A581D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 03:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CDC1DDC15;
	Wed, 30 Jul 2025 03:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dT0qXdHD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CC916DEB1
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 03:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753846647; cv=none; b=KlWvNxzo3Va3YJADuNdBRRsgF7cy1bjUrAaefX/PXFDx9sxsSFaUdEaWaPI6jX3QYbA76L5t+dmucKXv2CvAStCf+1Y8n+MLyq6zQX+KzstZ2IUXv6hHWDKmSgXQo9x/AgqMzcU1J4Oe8+DCbkf+9OgAEJEuPIRmZhy0pEahRco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753846647; c=relaxed/simple;
	bh=tErcFQmELNFkZAm+D7dIZT/EMgu6fqy/433QwaB7TmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yl2KtDzLsMErYN37vOIcO6yn1yiW5lJ6Azp2ZJvDYIQCQJWopCFhqhawa3g5mBJHJBXmCOAX5Aqu+Ga5EcYlhVRBS1Swb7rz7HvFVRTVldcGSTjx0lxDbVj0VS/s5jHmfsTIzHXYKpT7N6xyEyPhLIaEC0V6nUMd3yX6R2/w/aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dT0qXdHD; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753846645; x=1785382645;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tErcFQmELNFkZAm+D7dIZT/EMgu6fqy/433QwaB7TmE=;
  b=dT0qXdHDWno7IMifKCXmMF0GWtg2JpuCIAsPmUiuz6YZsmmEy1oToc+Z
   RYaWv9NnB4s2p5eYtRM/0zz8s61s5xedSOpBuroW+/KPqjrMZpvbFJNwu
   BMvxffGGA/vDz7nlqRyAMS2e8xN9Mcwb0Thgnl4rdykiaRvUapA0VfaFe
   ahoFfBuraEtYtMsyQPXiKjrYY2cjlI0aD8ZmHxUSowKxSbUt8tb0nTrwd
   D84PV5aY3YkSGMaMONjgm7eBoaqOIEzEeGGjzIp+8K8nB+azQy5FYQ2HE
   /Z/ie/tBWijiKWqxCbiY6BJGHHC/Q5N0DW5NGHbfT5gR18EehMBq3yskq
   g==;
X-CSE-ConnectionGUID: yq5iY9jgRNa1w4262XxczA==
X-CSE-MsgGUID: 01qxMqv6Q9GRFuYSYvP64g==
X-IronPort-AV: E=McAfee;i="6800,10657,11506"; a="59962345"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="59962345"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2025 20:37:23 -0700
X-CSE-ConnectionGUID: O4ZFxuSxRRmvq+dwbILU7Q==
X-CSE-MsgGUID: bvmVB8HMQx6T0R2kOy7R4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="167051793"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 29 Jul 2025 20:37:22 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ugxd1-0001xw-0J;
	Wed, 30 Jul 2025 03:37:19 +0000
Date: Wed, 30 Jul 2025 11:36:22 +0800
From: kernel test robot <lkp@intel.com>
To: Zhang Qilong <zhangqilong3@huawei.com>, arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, wangkefeng.wang@huawei.com,
	zhangqilong3@huawei.com, sunnanyong@huawei.com
Subject: Re: [PATCH] /dev/zero: try to align PMD_SIZE for private mapping
Message-ID: <202507301149.ILLCBOyz-lkp@intel.com>
References: <20250729134942.900517-1-zhangqilong3@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729134942.900517-1-zhangqilong3@huawei.com>

Hi Zhang,

kernel test robot noticed the following build errors:

[auto build test ERROR on char-misc/char-misc-testing]
[also build test ERROR on char-misc/char-misc-next char-misc/char-misc-linus soc/for-next linus/master v6.16 next-20250729]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zhang-Qilong/dev-zero-try-to-align-PMD_SIZE-for-private-mapping/20250729-215253
base:   char-misc/char-misc-testing
patch link:    https://lore.kernel.org/r/20250729134942.900517-1-zhangqilong3%40huawei.com
patch subject: [PATCH] /dev/zero: try to align PMD_SIZE for private mapping
config: alpha-allnoconfig (https://download.01.org/0day-ci/archive/20250730/202507301149.ILLCBOyz-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250730/202507301149.ILLCBOyz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507301149.ILLCBOyz-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/uapi/linux/posix_types.h:5,
                    from include/uapi/linux/types.h:14,
                    from include/linux/types.h:6,
                    from include/linux/kasan-checks.h:5,
                    from include/asm-generic/rwonce.h:26,
                    from arch/alpha/include/asm/rwonce.h:33,
                    from include/linux/compiler.h:390,
                    from include/linux/export.h:5,
                    from include/linux/linkage.h:7,
                    from arch/alpha/include/asm/bug.h:5,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/mm.h:6,
                    from drivers/char/mem.c:12:
   drivers/char/mem.c: In function 'get_unmapped_area_zero':
>> include/linux/stddef.h:8:14: error: called object is not a function or function pointer
       8 | #define NULL ((void *)0)
         |              ^
   include/linux/huge_mm.h:536:33: note: in expansion of macro 'NULL'
     536 | #define thp_get_unmapped_area   NULL
         |                                 ^~~~
   drivers/char/mem.c:533:15: note: in expansion of macro 'thp_get_unmapped_area'
     533 |         ret = thp_get_unmapped_area(file, addr, len, pgoff, flags);
         |               ^~~~~~~~~~~~~~~~~~~~~


vim +8 include/linux/stddef.h

^1da177e4c3f41 Linus Torvalds   2005-04-16  6  
^1da177e4c3f41 Linus Torvalds   2005-04-16  7  #undef NULL
^1da177e4c3f41 Linus Torvalds   2005-04-16 @8  #define NULL ((void *)0)
6e218287432472 Richard Knutsson 2006-09-30  9  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

