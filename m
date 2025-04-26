Return-Path: <linux-kernel+bounces-621226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FEF1A9D665
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Apr 2025 01:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1DDE16ED9A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 23:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35032973D3;
	Fri, 25 Apr 2025 23:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PdqtSkEp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759FE22617F
	for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 23:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745625015; cv=none; b=u2XTKc+jxwY/7DkxbWiNo3UavKABfh+wI5Mmh6nhFOlwBTIiURz2ejFGboU9RV54rz6tyqJzwLeBRwCLQI4md2lfRjRJSYvfDWlT6bJIEs2zsjwgqCNlc5ifNljzk2O5dH5jBeNXewft3LO+a0xZznIT7NbZxDDI7dqDZ2II0FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745625015; c=relaxed/simple;
	bh=99MPNBAU+Q8nRZJMtKpolbCkBPKnjP8ebs2gio4xOIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UUAtzBUzEY7YtyBXbUFu4HPZ2QrsLaDkjpWqUwmEi2eSVtDIWJCa62bEwnFwnTv3zd8mEn5KHqaGg57CfVllGFHNaK85boJY5x+bkecDrW7ZGcea26Y6lhizzTcolO2hS0vqOT4RYZo8oEZc9n9wn38BMd8rzVSn3/qmJZTUmCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PdqtSkEp; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745625014; x=1777161014;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=99MPNBAU+Q8nRZJMtKpolbCkBPKnjP8ebs2gio4xOIE=;
  b=PdqtSkEpZncRNBjbKyww2z5IRuk81bHFARO5y1VIISqFvSwgCHwkCHIk
   aeOWbZGym1BumeveEI+mO32hqmvp02y4QY8AC9sqYYkzg6sHGzrqF7LDo
   n9jMsL8nx1EeQ4VcI5v+hZZA+0GXJsyE1DGrlQQ8htvMCF6S5TxTfntZa
   dA0tFVkTrGnL/bgBLMZeHLF3BSSCUkgslfm82l3pQZI1mPaaOfITCHTLz
   lFMyoDcOdkZZq7Kweh8IoXSbRlG/FtHy+anMUR1ud7g3lZ5ZLmAzPuCYj
   IKV/bvfca7sfSttzEY+u4tki7wXCJc+o1iZvDzVmGR5z6Jt6TmoZlKmIa
   A==;
X-CSE-ConnectionGUID: aGWQVeKdTQax6c8dimopYA==
X-CSE-MsgGUID: 8fsqvM6TScmBceq3ZRoLzA==
X-IronPort-AV: E=McAfee;i="6700,10204,11414"; a="46531367"
X-IronPort-AV: E=Sophos;i="6.15,240,1739865600"; 
   d="scan'208";a="46531367"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 16:50:12 -0700
X-CSE-ConnectionGUID: RVlvXgcNSqW233vr22kDLQ==
X-CSE-MsgGUID: c2TPif0rS8OTdo7Ua0rCFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,240,1739865600"; 
   d="scan'208";a="133522789"
Received: from lkp-server01.sh.intel.com (HELO 050dd05385d1) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 25 Apr 2025 16:50:09 -0700
Received: from kbuild by 050dd05385d1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u8So3-0005av-0H;
	Fri, 25 Apr 2025 23:50:07 +0000
Date: Sat, 26 Apr 2025 07:49:22 +0800
From: kernel test robot <lkp@intel.com>
To: Shenghao Ding <shenghao-ding@ti.com>, tiwai@suse.de
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev, broonie@kernel.org,
	andriy.shevchenko@linux.intel.com, 13564923607@139.com,
	13916275206@139.com, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org, baojun.xu@ti.com, Baojun.Xu@fpt.com,
	robinchen@ti.com, Shenghao Ding <shenghao-ding@ti.com>
Subject: Re: [PATCH v1] ALSA: hda/tas2781: Remove tas2781_spi_fwlib.c and
 leverage SND_SOC_TAS2781_FMWLIB
Message-ID: <202504260724.ryu83bm2-lkp@intel.com>
References: <20250424133814.216-1-shenghao-ding@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424133814.216-1-shenghao-ding@ti.com>

Hi Shenghao,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tiwai-sound/for-next]
[also build test WARNING on next-20250424]
[cannot apply to tiwai-sound/for-linus broonie-sound/for-next linus/master v6.15-rc3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shenghao-Ding/ALSA-hda-tas2781-Remove-tas2781_spi_fwlib-c-and-leverage-SND_SOC_TAS2781_FMWLIB/20250424-214314
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git for-next
patch link:    https://lore.kernel.org/r/20250424133814.216-1-shenghao-ding%40ti.com
patch subject: [PATCH v1] ALSA: hda/tas2781: Remove tas2781_spi_fwlib.c and leverage SND_SOC_TAS2781_FMWLIB
config: x86_64-kismet-CONFIG_SND_SOC_TAS2781_COMLIB-CONFIG_SND_HDA_SCODEC_TAS2781_SPI-0-0 (https://download.01.org/0day-ci/archive/20250426/202504260724.ryu83bm2-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20250426/202504260724.ryu83bm2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504260724.ryu83bm2-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for SND_SOC_TAS2781_COMLIB when selected by SND_HDA_SCODEC_TAS2781_SPI
   WARNING: unmet direct dependencies detected for SND_SOC_TAS2781_COMLIB
     Depends on [n]: SOUND [=y] && SND [=y] && SND_SOC [=y] && I2C [=n]
     Selected by [y]:
     - SND_HDA_SCODEC_TAS2781_SPI [=y] && SOUND [=y] && SND [=y] && SND_HDA [=y] && SPI_MASTER [=y] && ACPI [=y] && EFI [=y] && SND_SOC [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

