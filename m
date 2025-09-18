Return-Path: <linux-kernel+bounces-751499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2968B16A57
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 04:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF44C18C5946
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 02:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8892622330F;
	Thu, 31 Jul 2025 02:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lwDUocjQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B958444C94;
	Thu, 31 Jul 2025 02:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753928270; cv=none; b=ZUzR9ZlYUI+sNSS4kWh+e94fa9A1zjSg4L8BPZf8dn6dWLamF2RL547Y+xztb268M41zTVDegEV0AdKME3OtULQMhvrhws1WBjdQ5p6oD3HZIWmEyxSH6OsAPjm8FG4He6MNYeFTdZAnCD5/5tqikvjt2VK61wbGBXHWGhrYgpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753928270; c=relaxed/simple;
	bh=vnsmv7tQNXaWSWWP/6OdzOgjtQ6fSmz6QBABH81KmAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GT/EE5EZrKAm/6UdqOGwLkpzOv6Lv+gLxNwbEg4JhlEhHGTZSbdrkZSIcksnMPdyeSRYPLT0lTBOaXvhZ4DdiMYEx3apYceAFNqLK0wIL8jBNELKoW1CVjT5PGAfs7AqK7Pt6lIJyP+bPhhbUDIDzwgtCtCEP4L6/3KckbbMlAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lwDUocjQ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753928267; x=1785464267;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vnsmv7tQNXaWSWWP/6OdzOgjtQ6fSmz6QBABH81KmAM=;
  b=lwDUocjQhr1L+mdJJwJpMH0HhdWmSiG9L8+lL1iIzfOoIPYA8NrWVuP6
   hTl95U8RbxSyCwIdJsoFfmqweEroYUmf4Tz9qSCarzuD+Vbb54iqAHx9N
   X1gjQ8lLZA0o5OGX3TNItleE44YHh8XRxm9cdl4+oSA2D2VJ5VZC4VU9E
   qAX94UVorIoityKBKGYBjCjCXrOeXxR46/jxjS7VxxqKpDJzl2cicT2uw
   +Do5OP5NF8uPTYn/3tNmLEcp3IzGW4MEQQPeJ2/n+qpi1ezuHhAlCS18s
   8C05A4oIFA91WVKc5Et0f5nS+9b2mhQrHpYzkFMORywbL3yzFsaE2FKtn
   g==;
X-CSE-ConnectionGUID: 4TqHoKTeSqiUSicRKak3jg==
X-CSE-MsgGUID: kmhF/BLlSwqJ8yyDkRTe1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="59887949"
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; 
   d="scan'208";a="59887949"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 19:17:47 -0700
X-CSE-ConnectionGUID: 7AwyyvrUR0uccKqLvoLehA==
X-CSE-MsgGUID: YiHMoHhUQDGtjlup+hfZNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; 
   d="scan'208";a="163924185"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 30 Jul 2025 19:17:43 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uhIrV-0003LE-2K;
	Thu, 31 Jul 2025 02:17:41 +0000
Date: Thu, 31 Jul 2025 10:17:28 +0800
From: kernel test robot <lkp@intel.com>
To: Neeraj Kumar <s.neeraj@samsung.com>, linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
	gost.dev@samsung.com
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev, a.manzanares@samsung.com,
	vishak.g@samsung.com, neeraj.kernel@gmail.com,
	Neeraj Kumar <s.neeraj@samsung.com>
Subject: Re: [PATCH V2 19/20] cxl/pmem_region: Prep patch to accommodate
 pmem_region attributes
Message-ID: <202507311017.7ApKmtQc-lkp@intel.com>
References: <20250730121209.303202-20-s.neeraj@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730121209.303202-20-s.neeraj@samsung.com>

Hi Neeraj,

kernel test robot noticed the following build warnings:

[auto build test WARNING on f11a5f89910a7ae970fbce4fdc02d86a8ba8570f]

url:    https://github.com/intel-lab-lkp/linux/commits/Neeraj-Kumar/nvdimm-label-Introduce-NDD_CXL_LABEL-flag-to-set-cxl-label-format/20250730-202209
base:   f11a5f89910a7ae970fbce4fdc02d86a8ba8570f
patch link:    https://lore.kernel.org/r/20250730121209.303202-20-s.neeraj%40samsung.com
patch subject: [PATCH V2 19/20] cxl/pmem_region: Prep patch to accommodate pmem_region attributes
config: x86_64-kismet-CONFIG_LIBNVDIMM-CONFIG_CXL_PMEM_REGION-0-0 (https://download.01.org/0day-ci/archive/20250731/202507311017.7ApKmtQc-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20250731/202507311017.7ApKmtQc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507311017.7ApKmtQc-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for LIBNVDIMM when selected by CXL_PMEM_REGION
   WARNING: unmet direct dependencies detected for LIBNVDIMM
     Depends on [n]: PHYS_ADDR_T_64BIT [=y] && HAS_IOMEM [=y] && BLK_DEV [=n]
     Selected by [y]:
     - CXL_PMEM_REGION [=y] && CXL_BUS [=y] && CXL_REGION [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

