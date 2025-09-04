Return-Path: <linux-kernel+bounces-800670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 490B7B43A51
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BB65163349
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 11:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4482C237F;
	Thu,  4 Sep 2025 11:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y2KHQ7u2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5FE199FAB
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 11:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756985766; cv=none; b=CDfu4hhNRyPQW00eafI4CXaz8TX4Cf/aSR/CeUkZvmI6iBlenzNexDAxQQGxI89U2pHQLhyo4OGT/pu7L90222Zz9LT+pTsXqK1aW0dEVLs6upsrqpDNKtTasCk6niXjof9tWxPjSTeabR9rJifxHtgjM/p6vXHbcw9RF3EG4Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756985766; c=relaxed/simple;
	bh=XooMgB/G8lNJMCdIzzBtmWjZeeaz3fKqex6i/QbgCAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FWi0Tdm1ajUtb3DCBZjHLhFsJD+y16Vmb9RzUBOrEFnC6G/gIfX6mddRFsxl8RICsSg7yMAcWYRUsHvd1Jt9I0N6zqBw82SWBqh2rDDUcbc3cbHoO8E9zfqpJiezvejD3Dv8kChw6ESUZMgSB11WUmWWNH00p7dMkyhNwLUGd70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y2KHQ7u2; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756985764; x=1788521764;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XooMgB/G8lNJMCdIzzBtmWjZeeaz3fKqex6i/QbgCAs=;
  b=Y2KHQ7u2E9vcZ9RCRV9dqiJ3UE9VG9100YxKgFRCf1cZk3Q15238UO+X
   mIvcBFOuazQ+5yVngwe5tU+Ds2yBT9bNNhF8m31+PWU3ZSoG/x3jub96N
   JsbxjGK+PZ2jFXN172affUzw37SSAfjWsJ9+ivG3Q60lllWwUlCdVoM6A
   r23XRXSAihFZAbJOWHLdFTruLRqW8ZykKsWsAzLeDF47Q4hsS/VZKLk96
   ni3mFirXtBoW+s9qNmVT0fxQsHhEHnppRkwgPf6qhZ+/ecvMPmhflc6Sx
   qvFMV+YpMmfN5RcM2ooKfri6G4Lw+3TtaratnsLUGSjogVTQL/KTQ50lS
   A==;
X-CSE-ConnectionGUID: YY5Qev33R+yBfVFLmvFPNA==
X-CSE-MsgGUID: o4knYfhVQh+06+z8mC7Gxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11542"; a="70416301"
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; 
   d="scan'208";a="70416301"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 04:36:04 -0700
X-CSE-ConnectionGUID: 2HCD2rLNSbiGPoee94Y5lg==
X-CSE-MsgGUID: Tg6EjqbvT3+7BOniHFVSmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; 
   d="scan'208";a="176228730"
Received: from lkp-server02.sh.intel.com (HELO 06ba48ef64e9) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 04 Sep 2025 04:36:02 -0700
Received: from kbuild by 06ba48ef64e9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uu8F0-0005AJ-3B;
	Thu, 04 Sep 2025 11:35:18 +0000
Date: Thu, 4 Sep 2025 19:32:53 +0800
From: kernel test robot <lkp@intel.com>
To: Fidal Palamparambil <palamparambilfidal089@gmail.com>,
	kgdb-bugreport@lists.sourceforge.net
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, daniel.thompson@linaro.org,
	dianders@chromium.org,
	Fidal Palamparambil <hellomystoryswherei@gmail.com>
Subject: Re: [PATCH] media: pci: Add core driver for Techwell TW68xx video
 capture devices
Message-ID: <202509041912.qtRHikwE-lkp@intel.com>
References: <20250903174657.1689-1-hellomystoryswherei@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903174657.1689-1-hellomystoryswherei@gmail.com>

Hi Fidal,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.17-rc4 next-20250904]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Fidal-Palamparambil/media-pci-Add-core-driver-for-Techwell-TW68xx-video-capture-devices/20250904-014821
base:   linus/master
patch link:    https://lore.kernel.org/r/20250903174657.1689-1-hellomystoryswherei%40gmail.com
patch subject: [PATCH] media: pci: Add core driver for Techwell TW68xx video capture devices
config: i386-buildonly-randconfig-006-20250904 (https://download.01.org/0day-ci/archive/20250904/202509041912.qtRHikwE-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250904/202509041912.qtRHikwE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509041912.qtRHikwE-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/media/pci/tw68/tw68-core.c:381:18: warning: unused variable 'pci_dev' [-Wunused-variable]
     381 |         struct pci_dev *pci_dev = to_pci_dev(dev_d);
         |                         ^~~~~~~
   1 warning generated.


vim +/pci_dev +381 drivers/media/pci/tw68/tw68-core.c

   378	
   379	static int __maybe_unused tw68_resume(struct device *dev_d)
   380	{
 > 381		struct pci_dev *pci_dev = to_pci_dev(dev_d);
   382		struct v4l2_device *v4l2_dev = dev_get_drvdata(dev_d);
   383		struct tw68_dev *dev = container_of(v4l2_dev, struct tw68_dev, v4l2_dev);
   384		struct tw68_buf *buf;
   385		unsigned long flags;
   386	
   387		/* Do things that are done in tw68_initdev,
   388		 * except for initializing memory structures.
   389		 */
   390		msleep(100);
   391	
   392		tw68_hw_init1(dev);
   393		tw68_set_tvnorm_hw(dev);
   394	
   395		/* Restore interrupt mask */
   396		tw_setl(TW68_INTMASK, dev->pci_irqmask);
   397	
   398		/* Resume unfinished buffer(s) */
   399		spin_lock_irqsave(&dev->slock, flags);
   400		if (!list_empty(&dev->active)) {
   401			buf = container_of(dev->active.next, struct tw68_buf, list);
   402			tw68_video_start_dma(dev, buf);
   403		}
   404		spin_unlock_irqrestore(&dev->slock, flags);
   405	
   406		return 0;
   407	}
   408	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

