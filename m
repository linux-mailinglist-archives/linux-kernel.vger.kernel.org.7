Return-Path: <linux-kernel+bounces-847534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FAABBCB202
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 00:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4B71D4E5A29
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 22:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E27A286D45;
	Thu,  9 Oct 2025 22:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nTG94R/B"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838C9286883
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 22:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760049545; cv=none; b=pMxC/wv4osIvQJsF+epJcabFgn6ixakbh177VwKOhgP9pgfncgVTkMPKpjyfUlxKTkYpgIOwh0j5zIVCezR3etgkweHzEu0o4b4YJbQ8eakmM8xSb/8YmEu4p9te4d+QiCj9bYR4qfdGpzopsqzFUrD3wu/P3MeWD/aeyLV0o8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760049545; c=relaxed/simple;
	bh=tjuWJC0yrFiqy88M5fh1ypslPt1a2+8jIXYY6rI0YfM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Lck/0cjQTuYQlri+1zUgcUFifJEgLpdkwLglqcK01+QBcsAbeK7togbER05j1lPdA6zY+oosr5UbKcm5x4RqIia8RXhs/vfTIAPqLxvL1NEByQnqrYKIuTXCUhkoESRdTYPF+Aog+fYtLrTtX/a/kOTwH96ekLh6ZbwGyMuceZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nTG94R/B; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760049543; x=1791585543;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tjuWJC0yrFiqy88M5fh1ypslPt1a2+8jIXYY6rI0YfM=;
  b=nTG94R/BCeGcPPrcCPswlfofmSlWSF9LnUWQXoC6Sauo7JD7jZT+A8Vv
   0t6LddtYXUQqprEI8IjGDmdn10r72YSyIIJot5MYTcDEOF6YQV62DrORS
   0ba7mvr/6fN3DE3Fp3pbpXulYp38InW2N7NSd40iEPYj+NSZiY6CVwByS
   5mwuyU+AZhBWxzVe/xlDHaOiAR0VFdlVC7I72xBpiWfcAFn1H+jjAeayp
   V3c/NZfpEolUCpfhWnv04H5TEaM/TP2VZ/TLQ9/EqCyzLUdW9UGRLrbHO
   5s1NEdbZwnsVikcibzOVNHOw7dPKegbHIWOz4ZIfGqjmiGraAOFT3DxSF
   Q==;
X-CSE-ConnectionGUID: C28zoKMIRhuNnUeXa9NQBQ==
X-CSE-MsgGUID: ougNt3rXQS2fZSwe+5TQNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11577"; a="62427694"
X-IronPort-AV: E=Sophos;i="6.19,217,1754982000"; 
   d="scan'208";a="62427694"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 15:39:02 -0700
X-CSE-ConnectionGUID: V/spqdrbQZiY+ar5bHHv9Q==
X-CSE-MsgGUID: 32aj+9Z9SQSIE1bG+Y58Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,217,1754982000"; 
   d="scan'208";a="186093230"
Received: from lkp-server01.sh.intel.com (HELO 6a630e8620ab) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 09 Oct 2025 15:39:00 -0700
Received: from kbuild by 6a630e8620ab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v6zHm-0001ZQ-1P;
	Thu, 09 Oct 2025 22:38:58 +0000
Date: Fri, 10 Oct 2025 06:38:42 +0800
From: kernel test robot <lkp@intel.com>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Chia-I Wu <olvaffe@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: drivers/mailbox/mtk-gpueb-mailbox.c:203:28: sparse: sparse: symbol
 'mtk_gpueb_mbox_ops' was not declared. Should it be static?
Message-ID: <202510100629.3nGvrhEU-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5472d60c129f75282d94ae5ad072ee6dfb7c7246
commit: dbca0eabb821a6278925712a7bb263d0997e9c8f mailbox: add MediaTek GPUEB IPI mailbox
date:   3 days ago
config: arc-randconfig-r112-20251010 (https://download.01.org/0day-ci/archive/20251010/202510100629.3nGvrhEU-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 12.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251010/202510100629.3nGvrhEU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510100629.3nGvrhEU-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/mailbox/mtk-gpueb-mailbox.c:203:28: sparse: sparse: symbol 'mtk_gpueb_mbox_ops' was not declared. Should it be static?

vim +/mtk_gpueb_mbox_ops +203 drivers/mailbox/mtk-gpueb-mailbox.c

   202	
 > 203	const struct mbox_chan_ops mtk_gpueb_mbox_ops = {
   204		.send_data = mtk_gpueb_mbox_send_data,
   205		.startup = mtk_gpueb_mbox_startup,
   206		.shutdown = mtk_gpueb_mbox_shutdown,
   207		.last_tx_done = mtk_gpueb_mbox_last_tx_done,
   208	};
   209	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

