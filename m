Return-Path: <linux-kernel+bounces-828119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC96B93FB9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 04:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB6CB2E1450
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 02:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568B5269AEE;
	Tue, 23 Sep 2025 02:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OIQT6xWu"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA111D5178
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 02:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758594048; cv=none; b=S7K+T9dyWL7BcLTHH/8NA+XdcN92BBADaaKy9PgwgS8YocEJAQNnG2uM9b4rJFgknTSxqjNuzcXgRZMeKFfm2ckMwGjiI242ZKGeIxggLhAg+CDFofqnSG8Yb5dkBPAeQexAVquO0mklIGGJsZL7IqSo8nnNo8BI6+aVp+ajTBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758594048; c=relaxed/simple;
	bh=ppX3DTmVDiyyr1YGHONK8vTnmyN+WSZqP4NnFiZKc+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XRvKgGK7SOfPc18sF6rfiUxUz/gtfbsroTPTcLMMamImwm8NUN5eQ5BOIFBFxtZCV49RA6V/ktv7JbYvoOcrjhFUmfCwFkwBsy9qevvJXgyui7XnKgLt2T+R5KnLY0uagMfszFfkZoAULhFtfeMALgX4t0QXqSCbKfa5920/rUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OIQT6xWu; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758594046; x=1790130046;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ppX3DTmVDiyyr1YGHONK8vTnmyN+WSZqP4NnFiZKc+M=;
  b=OIQT6xWu1GBuDRabzmABFvTQ5xXzB/OtBE9Dw7cDTKea3Y3SvzCVvKpe
   044hFWAEscZQyqEQIoADrYZOweA/LoP6B/k1g05V7sm1xCaciSB04tmKm
   Gfnd95Ls8CpCBKuTH3h3AzDIee9lmBKMYpCuBOWYbtcMG0HkBjPMKzQ+d
   xPrddE/m4RYgrLx/vmxbhvUN5zPjYh+w/1PhdkopnbMT533NvzemzNrsw
   4q8rC8OGODZ1sn6OPRUO5Sgq6zt08o6r/6m16jFefTXKtb2nia1QyGxBx
   ioiCd+ZQIgM99kIJ9gdQvxyQGJ15+wwVL9HBrpXWTa0BR9RsEN4YiF20q
   w==;
X-CSE-ConnectionGUID: t7HlnoORRiKARbiU79NlDg==
X-CSE-MsgGUID: yleuoSw/SNiabNZUn4IEBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="71972500"
X-IronPort-AV: E=Sophos;i="6.18,286,1751266800"; 
   d="scan'208";a="71972500"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 19:20:45 -0700
X-CSE-ConnectionGUID: ynn7v8pBR7moPg6dTZZ77g==
X-CSE-MsgGUID: lIbWXvhuQTKl85MlpyWPAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,286,1751266800"; 
   d="scan'208";a="177080456"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 22 Sep 2025 19:20:42 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v0se0-0002fR-0x;
	Tue, 23 Sep 2025 02:20:40 +0000
Date: Tue, 23 Sep 2025 10:20:22 +0800
From: kernel test robot <lkp@intel.com>
To: Chunhai Guo <guochunhai@vivo.com>, xiang@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, chao@kernel.org,
	zbestahu@gmail.com, jefflexu@linux.alibaba.com, dhavale@google.com,
	lihongbo22@huawei.com, linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, Chunhai Guo <guochunhai@vivo.com>
Subject: Re: [PATCH] erofs: add direct I/O support for compressed data
Message-ID: <202509231034.jXPbkvNB-lkp@intel.com>
References: <20250922124304.489419-1-guochunhai@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922124304.489419-1-guochunhai@vivo.com>

Hi Chunhai,

kernel test robot noticed the following build errors:

[auto build test ERROR on xiang-erofs/dev-test]
[also build test ERROR on xiang-erofs/dev xiang-erofs/fixes linus/master v6.17-rc7 next-20250922]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chunhai-Guo/erofs-add-direct-I-O-support-for-compressed-data/20250922-204843
base:   https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
patch link:    https://lore.kernel.org/r/20250922124304.489419-1-guochunhai%40vivo.com
patch subject: [PATCH] erofs: add direct I/O support for compressed data
config: i386-buildonly-randconfig-003-20250923 (https://download.01.org/0day-ci/archive/20250923/202509231034.jXPbkvNB-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250923/202509231034.jXPbkvNB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509231034.jXPbkvNB-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "z_erofs_file_fops" [fs/erofs/erofs.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

