Return-Path: <linux-kernel+bounces-772667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4B6B295D0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 02:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F9BF7A6BB5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 00:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C561D7E26;
	Mon, 18 Aug 2025 00:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bx018vEm"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA28A18E377;
	Mon, 18 Aug 2025 00:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755476077; cv=none; b=rl7IewlV4q8zUyWo/kjGlTZierXzJ0DMQrRDspSe7EpxZ9WWgzChz5x1HGa8CJAr7bGCcG1s3jguAEc/w+YNWs8THOD3tPFq6bPpO0R1TVnam5qinnA5N4jkd5kLa3R92d8BbjNY4sDfYmbAlJcbqKJArmJ1vxG/5JaUbXwQfmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755476077; c=relaxed/simple;
	bh=cXw8V/2WdskHtmRrZ40s0eLq9HPcJIsdXKFvs+zG3Fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oyui+V/3hLelixBkBqXYp+w8sC/AddAu333QEB0tUof5JdFSS3JXi+77HEONSdr3VagW/KC5PKEb/m1z16wQyNXOPsXL5fyhtQSTab6AtRORAMJgwkJUeRjFMQUzv21P5v9uF1gt/VdzGpnE9EofSujsz8fRDIzBNpbpCNPgPQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bx018vEm; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755476075; x=1787012075;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cXw8V/2WdskHtmRrZ40s0eLq9HPcJIsdXKFvs+zG3Fs=;
  b=bx018vEmHl50ZXFMeQgVNbXwm+4v72Ab3CKyaZ8E36rp2LyfVXcNJ7//
   PeJGNwQPMQaVW7jaPrvyzEwvHAI41WgQd+UuqrQu+r88jNyPWI7QBNa1s
   GZHPS8rshW6o4wVf03C1UIw1LV37NWBFFp/x06OlcP3lhUvFZ0krduTME
   Am3zS3kskAqgy+x0GChKgptqrQ0O5/SAQHBG+VZoYYr++IOJYQIlL3yXy
   GNnWpQFQh+/loIRdd4G3/MdyM0X75pnoaP05HUn/haBkXJMCDBS01zuGY
   KFagaoi4XLGKsiGWheMzAhu38X7Y7uSOl2uUXEjfQnDoIPMOhESkRT8sa
   A==;
X-CSE-ConnectionGUID: Uy/F0MUKRjCa0zusQ+jr1g==
X-CSE-MsgGUID: 2JN/8ObeQfG/CaMIpKw0jA==
X-IronPort-AV: E=McAfee;i="6800,10657,11524"; a="68409212"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="68409212"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2025 17:14:34 -0700
X-CSE-ConnectionGUID: rPkKLnjSQ5CNumytd/zTcA==
X-CSE-MsgGUID: Yli3IW/hTpGQPtHWPRWhLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="168250450"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 17 Aug 2025 17:14:28 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1unnW6-000DnH-1M;
	Mon, 18 Aug 2025 00:14:26 +0000
Date: Mon, 18 Aug 2025 08:13:56 +0800
From: kernel test robot <lkp@intel.com>
To: Yeoreum Yun <yeoreum.yun@arm.com>, ryabinin.a.a@gmail.com,
	glider@google.com, andreyknvl@gmail.com, dvyukov@google.com,
	vincenzo.frascino@arm.com, corbet@lwn.net, catalin.marinas@arm.com,
	will@kernel.org, akpm@linux-foundation.org,
	scott@os.amperecomputing.com, jhubbard@nvidia.com,
	pankaj.gupta@amd.com, leitao@debian.org, kaleshsingh@google.com,
	maz@kernel.org, broonie@kernel.org, oliver.upton@linux.dev,
	james.morse@arm.com, ardb@kernel.org,
	hardevsinh.palaniya@siliconsignals.io, david@redhat.com,
	yang@os.amperecomputing.com
Cc: oe-kbuild-all@lists.linux.dev, kasan-dev@googlegroups.com,
	workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org, Yeoreum Yun <yeoreum.yun@arm.com>
Subject: Re: [PATCH v3 1/2] kasan/hw-tags: introduce kasan.write_only option
Message-ID: <202508180747.PxkbPnyA-lkp@intel.com>
References: <20250816110018.4055617-2-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250816110018.4055617-2-yeoreum.yun@arm.com>

Hi Yeoreum,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 8f5ae30d69d7543eee0d70083daf4de8fe15d585]

url:    https://github.com/intel-lab-lkp/linux/commits/Yeoreum-Yun/kasan-hw-tags-introduce-kasan-write_only-option/20250816-190300
base:   8f5ae30d69d7543eee0d70083daf4de8fe15d585
patch link:    https://lore.kernel.org/r/20250816110018.4055617-2-yeoreum.yun%40arm.com
patch subject: [PATCH v3 1/2] kasan/hw-tags: introduce kasan.write_only option
config: arm64-randconfig-r053-20250818 (https://download.01.org/0day-ci/archive/20250818/202508180747.PxkbPnyA-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250818/202508180747.PxkbPnyA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508180747.PxkbPnyA-lkp@intel.com/

All warnings (new ones prefixed by >>):

   mm/kasan/hw_tags.c: In function 'kasan_enable_hw_tags':
>> mm/kasan/hw_tags.c:433:21: warning: comparison between 'enum kasan_arg_mode' and 'enum kasan_arg_write_only' [-Wenum-compare]
     433 |  if (kasan_arg_mode == KASAN_ARG_WRITE_ONLY_ON &&
         |                     ^~
   mm/kasan/hw_tags.c:435:18: warning: comparison between 'enum kasan_arg_mode' and 'enum kasan_arg_write_only' [-Wenum-compare]
     435 |   kasan_arg_mode == KASAN_ARG_WRITE_ONLY_OFF;
         |                  ^~
>> mm/kasan/hw_tags.c:435:18: warning: statement with no effect [-Wunused-value]
     435 |   kasan_arg_mode == KASAN_ARG_WRITE_ONLY_OFF;
         |   ~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +433 mm/kasan/hw_tags.c

   423	
   424	void kasan_enable_hw_tags(void)
   425	{
   426		if (kasan_arg_mode == KASAN_ARG_MODE_ASYNC)
   427			hw_enable_tag_checks_async();
   428		else if (kasan_arg_mode == KASAN_ARG_MODE_ASYMM)
   429			hw_enable_tag_checks_asymm();
   430		else
   431			hw_enable_tag_checks_sync();
   432	
 > 433		if (kasan_arg_mode == KASAN_ARG_WRITE_ONLY_ON &&
   434		    hw_enable_tag_checks_write_only()) {
 > 435			kasan_arg_mode == KASAN_ARG_WRITE_ONLY_OFF;
   436			kasan_flag_write_only = false;
   437			pr_warn_once("System doesn't support write-only option. Disable it\n");
   438		}
   439	}
   440	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

