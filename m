Return-Path: <linux-kernel+bounces-826212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB55B8DDB3
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 17:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A451D3BBA72
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 15:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDDD1DB122;
	Sun, 21 Sep 2025 15:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="diSXTECO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137B42AEE4
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 15:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758470089; cv=none; b=ucKyYEjzYVTnCWsUxqJfjmFIHdYo1jZRKj5VFlPsnWaLN5dwAEUegYwe5gInU7aYNQW9g9ZGGuvEKQ5Baf+zh1J3kwFUksUZDZMkcsl1PKKCkNqmtrl018/ji7ekPr3d/w2BewyytNG3+eZrMkcP7dvFcTO4xUHRt7DOjT51Su8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758470089; c=relaxed/simple;
	bh=jfuMiHmboCrOqDP7JGlB7KaW9m7bQ0D5k7FDKcHDsuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TVgYeEWAVu1bW7Q/wDXhRvOMKECXa3grWyqMpfitFmKO48cevVoQ4Tbzgz9KJl1fwdfQvZHOuEjX3rblj+pcxDK/XU9BcPNBAb8/7zgvNHUwHJYPYramrdYWgdf2h8X0/KtOJHOFR2i4opwygq0VelhjrTO8H+jHN5NknpZ9rvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=diSXTECO; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758470087; x=1790006087;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jfuMiHmboCrOqDP7JGlB7KaW9m7bQ0D5k7FDKcHDsuQ=;
  b=diSXTECOJyZaPNt2oPdUOp6MGLa7zmvQ/0oYgPT/XEeq2xgod5R4XgX/
   tg6ur+8Py+MyuKvkHEvimZTySZSpvlLqQQr5ma3JfVMj5cB+4nGaVWn2C
   HuttXWNX+pvZtmYCx3ZvEKxrhSw9yNhfYcUFSQzoCDc0JXbnO4t5Dy3RA
   97bjRpDZdaEoC30mRZ38SsHZZhxUQCrOoJhuJCXD9pQuKexnHjwMcZQAh
   DxYlyNV6h/0R6cqCikRZA5kVrJKRWyyuGDc0iGsOXXltFCvBmm4LZXZZl
   Ly+t00Zsm/UKcH8uz94AyHNQZqQ5UYeoAIwle/6UadHH2dpz1CV4JqX2Z
   g==;
X-CSE-ConnectionGUID: gleORSMaQ7WoXmtQKuNf9w==
X-CSE-MsgGUID: YSSf3ihbRkC7BrWdyOlK5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11560"; a="60675652"
X-IronPort-AV: E=Sophos;i="6.18,283,1751266800"; 
   d="scan'208";a="60675652"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2025 08:54:46 -0700
X-CSE-ConnectionGUID: C10qjqvVQ2yvFH/HcWH85g==
X-CSE-MsgGUID: hLOZiHqmSlGDPSfpSHHnXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,283,1751266800"; 
   d="scan'208";a="177084494"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 21 Sep 2025 08:54:45 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v0MOg-0000q5-3B;
	Sun, 21 Sep 2025 15:54:42 +0000
Date: Sun, 21 Sep 2025 23:54:33 +0800
From: kernel test robot <lkp@intel.com>
To: Joshua Jayasingh <joshuajayasingh08@gmail.com>, groeck@chromium.org
Cc: oe-kbuild-all@lists.linux.dev, gregkh@linuxfoundation.org,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
	Joshua Jayasingh <joshuajayasingh08@gmail.com>
Subject: Re: [PATCH] Subject: [PATCH] firmware: google: Add comments to
 coreboot_table.c
Message-ID: <202509212310.x4AI3ECo-lkp@intel.com>
References: <20250921132446.1974-1-joshuajayasingh08@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250921132446.1974-1-joshuajayasingh08@gmail.com>

Hi Joshua,

kernel test robot noticed the following build warnings:

[auto build test WARNING on chrome-platform/for-next]
[also build test WARNING on chrome-platform/for-firmware-next linus/master v6.17-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Joshua-Jayasingh/Subject-PATCH-firmware-google-Add-comments-to-coreboot_table-c/20250921-212952
base:   https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git for-next
patch link:    https://lore.kernel.org/r/20250921132446.1974-1-joshuajayasingh08%40gmail.com
patch subject: [PATCH] Subject: [PATCH] firmware: google: Add comments to coreboot_table.c
config: riscv-randconfig-002-20250921 (https://download.01.org/0day-ci/archive/20250921/202509212310.x4AI3ECo-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250921/202509212310.x4AI3ECo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509212310.x4AI3ECo-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/firmware/google/coreboot_table.c:140 bad line: _ to free the memory allocated for the coreboot_device.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

