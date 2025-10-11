Return-Path: <linux-kernel+bounces-849309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3482BCFC9F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 22:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DEBC1895AC1
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 20:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308C922A4E5;
	Sat, 11 Oct 2025 20:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kbOZzLGx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1489613A86C
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 20:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760213014; cv=none; b=VLu+wCQL7JAlh0OW0RMr2tduTOM2s+dGeB+V8HOlkTuZbnJ9+mWD9FFihxsQnqhF5k+v7z7b2ch2bA6cmrtuAo8jfI2vD/YM0RiebBMrx+2hBimO5iZKwNirt44u/zYup/4SczCefoZzxKg27Umn39Yi3sS9/+xM2oWKM7hDfzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760213014; c=relaxed/simple;
	bh=sXduRfgN8QZmJb/jAmwsjJjU3f1IeTvflTj6WHXOhwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iT0/1YlEWNHY8HE5KGxM02vdUgjZfljKq60z8wKeYeO1aanrpPLfsGh5mK6hV+tjdL3w61RCwPIflNLByLmZwbToEpjuh+TN7QhRpHFuAJ77nLbWN3I68sFXCpDINzNVN+ahqR7J2NxRtUKehn2KgrHSKYVTnCRIW0UJ/jSkMF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kbOZzLGx; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760213012; x=1791749012;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sXduRfgN8QZmJb/jAmwsjJjU3f1IeTvflTj6WHXOhwQ=;
  b=kbOZzLGx1aZz1y0mVHTzFEgXpRdWnUKuQkey9doxi4EU4vVNBh218U+D
   GVz13WA45h0MsVXawLx3NS7Z55mKmCELXELFhHOiYBEhbBJvGlYvb15OH
   tCKtolJoR8OvlLEwX1+nbN8VuOmS7iYqlpZ3gLBftb0cyxzvrG/Y3U7l5
   cjVbCiwV2I83n97nUKqLFrjqjGgF+5Mw/kXEZ8h4BsMCERT4rpFiJAEQj
   kaCxIKef4VXJZdEA8DZ9uK4q8EGkDtlbWdpJ5OepfxsZ2xC5CIjNC0v1c
   dyOvLUF93A3xeReLwN9WqDq1zo96ZtGFnjbtwJlaVSnBRH+RHCwSKlQxm
   A==;
X-CSE-ConnectionGUID: 8wUTEJUiQcyUM7V+YXhc2w==
X-CSE-MsgGUID: uluAPPzWS06br5YjCvz2Xw==
X-IronPort-AV: E=McAfee;i="6800,10657,11579"; a="62283134"
X-IronPort-AV: E=Sophos;i="6.19,221,1754982000"; 
   d="scan'208";a="62283134"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2025 13:03:32 -0700
X-CSE-ConnectionGUID: E0auJUmHRtKjkKJAS1drpQ==
X-CSE-MsgGUID: 5leZJdpdQdGk8tquT9KLog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,221,1754982000"; 
   d="scan'208";a="218347965"
Received: from lkp-server01.sh.intel.com (HELO 6a630e8620ab) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 11 Oct 2025 13:03:29 -0700
Received: from kbuild by 6a630e8620ab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v7foN-0003xb-0M;
	Sat, 11 Oct 2025 20:03:27 +0000
Date: Sun, 12 Oct 2025 04:03:15 +0800
From: kernel test robot <lkp@intel.com>
To: jayxu1990@gmail.com, Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
	avnerkhan@utexas.edu, rdlee.upstream@gmail.com,
	Jay Xu <jayxu1990@gmail.com>
Subject: Re: [PATCH] mtd: core: Add nand_id sysfs attribute for NAND devices
Message-ID: <202510120356.STGKDkA5-lkp@intel.com>
References: <20251007224049.2798233-1-jayxu1990@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007224049.2798233-1-jayxu1990@gmail.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on mtd/mtd/next]
[also build test ERROR on mtd/mtd/fixes linus/master v6.17 next-20251010]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/jayxu1990-gmail-com/mtd-core-Add-nand_id-sysfs-attribute-for-NAND-devices/20251010-092101
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next
patch link:    https://lore.kernel.org/r/20251007224049.2798233-1-jayxu1990%40gmail.com
patch subject: [PATCH] mtd: core: Add nand_id sysfs attribute for NAND devices
config: i386-buildonly-randconfig-002-20251011 (https://download.01.org/0day-ci/archive/20251012/202510120356.STGKDkA5-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251012/202510120356.STGKDkA5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510120356.STGKDkA5-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: nand_readid_op
   >>> referenced by mtdcore.c:359 (drivers/mtd/mtdcore.c:359)
   >>>               drivers/mtd/mtdcore.o:(mtd_nand_id_show) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

