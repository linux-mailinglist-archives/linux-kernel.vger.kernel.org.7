Return-Path: <linux-kernel+bounces-834477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EED0CBA4C55
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 19:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACBB61B2344D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 17:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEAFB30C622;
	Fri, 26 Sep 2025 17:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F4Bwvd1m"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642691397;
	Fri, 26 Sep 2025 17:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758907692; cv=none; b=jfl23gGrMsXs02opgMImvfXqw+CIBkmxGx9xi2xah5zQENfjcjB9CBRYC8gfDazXNIGPInRQNsJP1HGR0m+XG3ChFP2yQFPvIVmkxFJwsYiIbtZrWRH1+7U1UPjLAlgkxAgRdUh1+ljtAw4g+SO1/IbPmhe76Q6yIwbJK0qloRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758907692; c=relaxed/simple;
	bh=Cc8vOeATU7r0/LRujy1Fny/ilH2+65UFxx1mG6kv6U8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i0jTQ7NWzGLjKSXyUWN/dJAXFNOvoWk0U56ipnFnMToCJjOO8HAwvXBwRnghEAj/DEMy1g2W67998mVp9iRO+6tEsF6JtZ1K+nbBcZpf+5W0rkkAWZG6Iwu651modMk3Z4AGwdi8gJ3ssdG0X3NWcReREi2RlnxDlIKlKezEP2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F4Bwvd1m; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758907690; x=1790443690;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Cc8vOeATU7r0/LRujy1Fny/ilH2+65UFxx1mG6kv6U8=;
  b=F4Bwvd1mOX113KWBRNiNG1vEI0jQ6y4OnwnD95oPYs4iSKVFg3s/bBYh
   ms7Oze1DUX0mX5ivPxygaClHyaUsz6uljSAn3X8+lQTOMIvNXoyro77AU
   0kKGaFszev4z5r23cl9xawGpM5qwM52mAUiKkhzZgfFrPWt7opFQ076IN
   qgjr1s0UDxc36aAP4wHCeTkg/8DaErEvrFXIGh6Oxna7Z1eAKaS5sk6+I
   TyIIsVlulSB7nYln6x4jNvX/iWIzuWK0dinq25zI+afda24bsgaCBylOF
   o1RBcQk1bKGs1OaRMUm7oTGX69VX3cKMdj1t0csCMfaB9n+mJ81RrvQOH
   A==;
X-CSE-ConnectionGUID: TYqV8g3vSRSwk5haKzHoBQ==
X-CSE-MsgGUID: MvwNGbitTqqZrSM1xj65YA==
X-IronPort-AV: E=McAfee;i="6800,10657,11565"; a="61293797"
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; 
   d="scan'208";a="61293797"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 10:28:08 -0700
X-CSE-ConnectionGUID: IbLUfKHlReGmnLP3zfHZRw==
X-CSE-MsgGUID: dKC46V5LSFCVdWJaBWKD6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; 
   d="scan'208";a="176793785"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 26 Sep 2025 10:28:04 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v2CEj-0006TL-0u;
	Fri, 26 Sep 2025 17:28:01 +0000
Date: Sat, 27 Sep 2025 01:27:44 +0800
From: kernel test robot <lkp@intel.com>
To: Cristian Marussi <cristian.marussi@arm.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, sudeep.holla@arm.com,
	james.quinlan@broadcom.com, f.fainelli@gmail.com,
	vincent.guittot@linaro.org, etienne.carriere@st.com,
	peng.fan@oss.nxp.com, michal.simek@amd.com, quic_sibis@quicinc.com,
	dan.carpenter@linaro.org, d-gole@ti.com, souvik.chakravarty@arm.com,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: Re: [PATCH 05/10] firmware: arm_scmi: Add Telemetry protocol support
Message-ID: <202509270119.Kb7lc7u3-lkp@intel.com>
References: <20250925203554.482371-6-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925203554.482371-6-cristian.marussi@arm.com>

Hi Cristian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on soc/for-next]
[also build test WARNING on trace/for-next linus/master v6.17-rc7 next-20250926]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Cristian-Marussi/firmware-arm_scmi-Define-a-common-SCMI_MAX_PROTOCOLS-value/20250926-044350
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
patch link:    https://lore.kernel.org/r/20250925203554.482371-6-cristian.marussi%40arm.com
patch subject: [PATCH 05/10] firmware: arm_scmi: Add Telemetry protocol support
config: m68k-randconfig-r131-20250926 (https://download.01.org/0day-ci/archive/20250927/202509270119.Kb7lc7u3-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250927/202509270119.Kb7lc7u3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509270119.Kb7lc7u3-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/firmware/arm_scmi/telemetry.c:378:48: sparse: sparse: restricted __le32 degrades to integer
   drivers/firmware/arm_scmi/telemetry.c:379:53: sparse: sparse: restricted __le32 degrades to integer
   drivers/firmware/arm_scmi/telemetry.c:380:53: sparse: sparse: restricted __le32 degrades to integer
   drivers/firmware/arm_scmi/telemetry.c:381:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/firmware/arm_scmi/telemetry.c:382:39: sparse: sparse: restricted __le32 degrades to integer
>> drivers/firmware/arm_scmi/telemetry.c:480:36: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:480:36: sparse: sparse: restricted __le32 degrades to integer
   drivers/firmware/arm_scmi/telemetry.c:480:36: sparse: sparse: restricted __le32 degrades to integer
   drivers/firmware/arm_scmi/telemetry.c:484:36: sparse: sparse: restricted __le32 degrades to integer
   drivers/firmware/arm_scmi/telemetry.c:485:34: sparse: sparse: restricted __le32 degrades to integer
   drivers/firmware/arm_scmi/telemetry.c:486:30: sparse: sparse: restricted __le32 degrades to integer
   drivers/firmware/arm_scmi/telemetry.c:487:32: sparse: sparse: restricted __le32 degrades to integer
>> drivers/firmware/arm_scmi/telemetry.c:672:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] flags @@     got unsigned long @@
   drivers/firmware/arm_scmi/telemetry.c:672:20: sparse:     expected restricted __le32 [usertype] flags
   drivers/firmware/arm_scmi/telemetry.c:672:20: sparse:     got unsigned long
   drivers/firmware/arm_scmi/telemetry.c:699:36: sparse: sparse: restricted __le32 degrades to integer
>> drivers/firmware/arm_scmi/telemetry.c:724:56: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int @@     got restricted __le32 const @@
   drivers/firmware/arm_scmi/telemetry.c:724:56: sparse:     expected unsigned int
   drivers/firmware/arm_scmi/telemetry.c:724:56: sparse:     got restricted __le32 const
   drivers/firmware/arm_scmi/telemetry.c:905:24: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:905:24: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:905:24: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:905:24: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:905:24: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:905:24: sparse: sparse: cast to restricted __le32
>> drivers/firmware/arm_scmi/telemetry.c:905:24: sparse: sparse: dereference of noderef expression
   drivers/firmware/arm_scmi/telemetry.c:905:24: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:905:24: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:905:24: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:905:24: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:905:24: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:905:24: sparse: sparse: cast to restricted __le32
>> drivers/firmware/arm_scmi/telemetry.c:905:24: sparse: sparse: dereference of noderef expression
   drivers/firmware/arm_scmi/telemetry.c:917:32: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:917:32: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:917:32: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:917:32: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:917:32: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:917:32: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:917:32: sparse: sparse: dereference of noderef expression
   drivers/firmware/arm_scmi/telemetry.c:917:32: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:917:32: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:917:32: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:917:32: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:917:32: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:917:32: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:917:32: sparse: sparse: dereference of noderef expression
>> drivers/firmware/arm_scmi/telemetry.c:955:18: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/firmware/arm_scmi/telemetry.c:984:28: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct payload [noderef] __iomem *payld @@     got struct payload *payld @@
   drivers/firmware/arm_scmi/telemetry.c:984:28: sparse:     expected struct payload [noderef] __iomem *payld
   drivers/firmware/arm_scmi/telemetry.c:984:28: sparse:     got struct payload *payld
   drivers/firmware/arm_scmi/telemetry.c:1024:37: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/firmware/arm_scmi/telemetry.c:1024:37: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1024:37: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/firmware/arm_scmi/telemetry.c:1024:37: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1024:37: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/firmware/arm_scmi/telemetry.c:1024:37: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1024:37: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/firmware/arm_scmi/telemetry.c:1024:37: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1024:37: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/firmware/arm_scmi/telemetry.c:1024:37: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1024:37: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/firmware/arm_scmi/telemetry.c:1024:37: sparse: sparse: cast to restricted __le32
>> drivers/firmware/arm_scmi/telemetry.c:1028:65: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected struct payload *payld @@     got struct payload [noderef] __iomem *payld @@
   drivers/firmware/arm_scmi/telemetry.c:1028:65: sparse:     expected struct payload *payld
   drivers/firmware/arm_scmi/telemetry.c:1028:65: sparse:     got struct payload [noderef] __iomem *payld
   drivers/firmware/arm_scmi/telemetry.c:1047:14: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/firmware/arm_scmi/telemetry.c:1047:14: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1047:14: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/firmware/arm_scmi/telemetry.c:1047:14: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1047:14: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/firmware/arm_scmi/telemetry.c:1047:14: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1047:14: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/firmware/arm_scmi/telemetry.c:1047:14: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1047:14: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/firmware/arm_scmi/telemetry.c:1047:14: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1047:14: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/firmware/arm_scmi/telemetry.c:1047:14: sparse: sparse: cast to restricted __le32
>> drivers/firmware/arm_scmi/telemetry.c:1056:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *_eplg @@     got void [noderef] __iomem * @@
   drivers/firmware/arm_scmi/telemetry.c:1056:29: sparse:     expected void *_eplg
   drivers/firmware/arm_scmi/telemetry.c:1056:29: sparse:     got void [noderef] __iomem *
>> drivers/firmware/arm_scmi/telemetry.c:1056:27: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem *eplg @@     got void *_eplg @@
   drivers/firmware/arm_scmi/telemetry.c:1056:27: sparse:     expected void [noderef] __iomem *eplg
   drivers/firmware/arm_scmi/telemetry.c:1056:27: sparse:     got void *_eplg
   drivers/firmware/arm_scmi/telemetry.c:1057:32: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/firmware/arm_scmi/telemetry.c:1057:48: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/firmware/arm_scmi/telemetry.c:1066:15: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1066:15: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1066:15: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1066:15: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1066:15: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1066:15: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1066:15: sparse: sparse: dereference of noderef expression
   drivers/firmware/arm_scmi/telemetry.c:1066:15: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1066:15: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1066:15: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1066:15: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1066:15: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1066:15: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1066:15: sparse: sparse: dereference of noderef expression
   drivers/firmware/arm_scmi/telemetry.c:1070:34: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1070:34: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1070:34: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1070:34: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1070:34: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1070:34: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1070:34: sparse: sparse: dereference of noderef expression
   drivers/firmware/arm_scmi/telemetry.c:1070:34: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1070:34: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1070:34: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1070:34: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1070:34: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1070:34: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1070:34: sparse: sparse: dereference of noderef expression
   drivers/firmware/arm_scmi/telemetry.c:1079:77: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected struct payload *payld @@     got struct payload [noderef] __iomem *payld @@
   drivers/firmware/arm_scmi/telemetry.c:1079:77: sparse:     expected struct payload *payld
   drivers/firmware/arm_scmi/telemetry.c:1079:77: sparse:     got struct payload [noderef] __iomem *payld
   drivers/firmware/arm_scmi/telemetry.c:1129:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *_eplg @@     got void [noderef] __iomem * @@
   drivers/firmware/arm_scmi/telemetry.c:1129:22: sparse:     expected void *_eplg
   drivers/firmware/arm_scmi/telemetry.c:1129:22: sparse:     got void [noderef] __iomem *
>> drivers/firmware/arm_scmi/telemetry.c:1141:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct prlg *_p @@     got struct prlg [noderef] __iomem * @@
   drivers/firmware/arm_scmi/telemetry.c:1141:26: sparse:     expected struct prlg *_p
   drivers/firmware/arm_scmi/telemetry.c:1141:26: sparse:     got struct prlg [noderef] __iomem *
   drivers/firmware/arm_scmi/telemetry.c:1141:26: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1141:26: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1141:26: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1141:26: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1141:26: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1141:26: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1141:26: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1141:26: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1141:26: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1141:26: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1141:26: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1141:26: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1162:24: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1162:24: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1162:24: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1162:24: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1162:24: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1162:24: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1162:24: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1162:24: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1162:24: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1162:24: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1162:24: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1162:24: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1219:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *_eplg @@     got void [noderef] __iomem * @@
   drivers/firmware/arm_scmi/telemetry.c:1219:37: sparse:     expected void *_eplg
   drivers/firmware/arm_scmi/telemetry.c:1219:37: sparse:     got void [noderef] __iomem *
   drivers/firmware/arm_scmi/telemetry.c:1219:35: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem *eplg @@     got void *_eplg @@
   drivers/firmware/arm_scmi/telemetry.c:1219:35: sparse:     expected void [noderef] __iomem *eplg
   drivers/firmware/arm_scmi/telemetry.c:1219:35: sparse:     got void *_eplg
>> drivers/firmware/arm_scmi/telemetry.c:1221:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct payload *payld @@     got void [noderef] __iomem * @@
   drivers/firmware/arm_scmi/telemetry.c:1221:31: sparse:     expected struct payload *payld
   drivers/firmware/arm_scmi/telemetry.c:1221:31: sparse:     got void [noderef] __iomem *
>> drivers/firmware/arm_scmi/telemetry.c:1305:20: sparse: sparse: invalid assignment: |=
   drivers/firmware/arm_scmi/telemetry.c:1305:20: sparse:    left side has type restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1305:20: sparse:    right side has type unsigned long
   drivers/firmware/arm_scmi/telemetry.c:1312:36: sparse: sparse: invalid assignment: |=
   drivers/firmware/arm_scmi/telemetry.c:1312:36: sparse:    left side has type restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1312:36: sparse:    right side has type unsigned long
   drivers/firmware/arm_scmi/telemetry.c:1315:36: sparse: sparse: invalid assignment: |=
   drivers/firmware/arm_scmi/telemetry.c:1315:36: sparse:    left side has type restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1315:36: sparse:    right side has type unsigned long
   drivers/firmware/arm_scmi/telemetry.c:1409:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] flags @@     got unsigned long @@
   drivers/firmware/arm_scmi/telemetry.c:1409:20: sparse:     expected restricted __le32 [usertype] flags
   drivers/firmware/arm_scmi/telemetry.c:1409:20: sparse:     got unsigned long
   drivers/firmware/arm_scmi/telemetry.c:1411:28: sparse: sparse: invalid assignment: |=
   drivers/firmware/arm_scmi/telemetry.c:1411:28: sparse:    left side has type restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1411:28: sparse:    right side has type unsigned long
>> drivers/firmware/arm_scmi/telemetry.c:1471:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] interval @@     got restricted __le32 [usertype] @@
   drivers/firmware/arm_scmi/telemetry.c:1471:26: sparse:     expected unsigned int [usertype] interval
   drivers/firmware/arm_scmi/telemetry.c:1471:26: sparse:     got restricted __le32 [usertype]
>> drivers/firmware/arm_scmi/telemetry.c:1479:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] grp_id @@     got unsigned int res_id @@
   drivers/firmware/arm_scmi/telemetry.c:1479:21: sparse:     expected restricted __le32 [usertype] grp_id
   drivers/firmware/arm_scmi/telemetry.c:1479:21: sparse:     got unsigned int res_id
>> drivers/firmware/arm_scmi/telemetry.c:1480:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] control @@     got unsigned long @@
   drivers/firmware/arm_scmi/telemetry.c:1480:22: sparse:     expected restricted __le32 [usertype] control
   drivers/firmware/arm_scmi/telemetry.c:1480:22: sparse:     got unsigned long
   drivers/firmware/arm_scmi/telemetry.c:1481:22: sparse: sparse: invalid assignment: |=
   drivers/firmware/arm_scmi/telemetry.c:1481:22: sparse:    left side has type restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1481:22: sparse:    right side has type unsigned long
   drivers/firmware/arm_scmi/telemetry.c:1483:22: sparse: sparse: invalid assignment: |=
   drivers/firmware/arm_scmi/telemetry.c:1483:22: sparse:    left side has type restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1483:22: sparse:    right side has type unsigned long
>> drivers/firmware/arm_scmi/telemetry.c:1484:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] sampling_rate @@     got unsigned int [assigned] [usertype] interval @@
   drivers/firmware/arm_scmi/telemetry.c:1484:28: sparse:     expected restricted __le32 [usertype] sampling_rate
   drivers/firmware/arm_scmi/telemetry.c:1484:28: sparse:     got unsigned int [assigned] [usertype] interval
   drivers/firmware/arm_scmi/telemetry.c:1504:16: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1504:16: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1504:16: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1504:16: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1504:16: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1504:16: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1504:16: sparse: sparse: dereference of noderef expression
   drivers/firmware/arm_scmi/telemetry.c:1504:16: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1504:16: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1504:16: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1504:16: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1504:16: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1504:16: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1504:16: sparse: sparse: dereference of noderef expression
   drivers/firmware/arm_scmi/telemetry.c:1507:35: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1507:35: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1507:35: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1507:35: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1507:35: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1507:35: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1507:35: sparse: sparse: dereference of noderef expression
   drivers/firmware/arm_scmi/telemetry.c:1507:35: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1507:35: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1507:35: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1507:35: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1507:35: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1507:35: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1507:35: sparse: sparse: dereference of noderef expression
   drivers/firmware/arm_scmi/telemetry.c:1624:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct prlg *_p @@     got struct prlg [noderef] __iomem * @@
   drivers/firmware/arm_scmi/telemetry.c:1624:26: sparse:     expected struct prlg *_p
   drivers/firmware/arm_scmi/telemetry.c:1624:26: sparse:     got struct prlg [noderef] __iomem *
   drivers/firmware/arm_scmi/telemetry.c:1624:26: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1624:26: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1624:26: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1624:26: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1624:26: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1624:26: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1624:26: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1624:26: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1624:26: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1624:26: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1624:26: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1624:26: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1645:21: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1645:21: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1645:21: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1645:21: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1645:21: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1645:21: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1645:21: sparse: sparse: dereference of noderef expression
   drivers/firmware/arm_scmi/telemetry.c:1649:24: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1649:24: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1649:24: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1649:24: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1649:24: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1649:24: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1649:24: sparse: sparse: dereference of noderef expression
   drivers/firmware/arm_scmi/telemetry.c:1649:24: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1649:24: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1649:24: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1649:24: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1649:24: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1649:24: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1649:24: sparse: sparse: dereference of noderef expression
   drivers/firmware/arm_scmi/telemetry.c:1655:43: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1655:43: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1655:43: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1655:43: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1655:43: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1655:43: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1655:43: sparse: sparse: dereference of noderef expression
   drivers/firmware/arm_scmi/telemetry.c:1655:43: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1655:43: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1655:43: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1655:43: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1655:43: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1655:43: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1655:43: sparse: sparse: dereference of noderef expression
>> drivers/firmware/arm_scmi/telemetry.c:1669:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct eplg *_e @@     got void [noderef] __iomem *eplg @@
   drivers/firmware/arm_scmi/telemetry.c:1669:24: sparse:     expected struct eplg *_e
   drivers/firmware/arm_scmi/telemetry.c:1669:24: sparse:     got void [noderef] __iomem *eplg
   drivers/firmware/arm_scmi/telemetry.c:1669:24: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1669:24: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1669:24: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1669:24: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1669:24: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1669:24: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1669:24: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1669:24: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1669:24: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1669:24: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1669:24: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1669:24: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1825:25: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1825:25: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1825:25: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1825:25: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1825:25: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1825:25: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1837:33: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1837:33: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1837:33: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1837:33: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1837:33: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1837:33: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1837:33: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1837:33: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1837:33: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1837:33: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1837:33: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1837:33: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1840:40: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1840:40: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1840:40: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1840:40: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1840:40: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1840:40: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1840:40: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1840:40: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1840:40: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1840:40: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1840:40: sparse: sparse: cast to restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1840:40: sparse: sparse: cast to restricted __le32
>> drivers/firmware/arm_scmi/telemetry.c:1869:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] grp_id @@     got int grp_id @@
   drivers/firmware/arm_scmi/telemetry.c:1869:21: sparse:     expected restricted __le32 [usertype] grp_id
   drivers/firmware/arm_scmi/telemetry.c:1869:21: sparse:     got int grp_id
   drivers/firmware/arm_scmi/telemetry.c:1870:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] control @@     got unsigned long @@
   drivers/firmware/arm_scmi/telemetry.c:1870:22: sparse:     expected restricted __le32 [usertype] control
   drivers/firmware/arm_scmi/telemetry.c:1870:22: sparse:     got unsigned long
   drivers/firmware/arm_scmi/telemetry.c:1871:22: sparse: sparse: invalid assignment: |=
   drivers/firmware/arm_scmi/telemetry.c:1871:22: sparse:    left side has type restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1871:22: sparse:    right side has type unsigned long
   drivers/firmware/arm_scmi/telemetry.c:1873:22: sparse: sparse: invalid assignment: |=
   drivers/firmware/arm_scmi/telemetry.c:1873:22: sparse:    left side has type restricted __le32
   drivers/firmware/arm_scmi/telemetry.c:1873:22: sparse:    right side has type unsigned long
>> drivers/firmware/arm_scmi/telemetry.c:1882:63: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned int num_dwords @@     got restricted __le32 [usertype] num_dwords @@
   drivers/firmware/arm_scmi/telemetry.c:1882:63: sparse:     expected unsigned int num_dwords
   drivers/firmware/arm_scmi/telemetry.c:1882:63: sparse:     got restricted __le32 [usertype] num_dwords
>> drivers/firmware/arm_scmi/telemetry.c:1883:58: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned int *dwords @@     got restricted __le32 * @@
   drivers/firmware/arm_scmi/telemetry.c:1883:58: sparse:     expected unsigned int *dwords
   drivers/firmware/arm_scmi/telemetry.c:1883:58: sparse:     got restricted __le32 *
>> drivers/firmware/arm_scmi/telemetry.c:905:24: sparse: sparse: dereference of noderef expression
>> drivers/firmware/arm_scmi/telemetry.c:905:24: sparse: sparse: dereference of noderef expression
>> drivers/firmware/arm_scmi/telemetry.c:905:24: sparse: sparse: dereference of noderef expression
>> drivers/firmware/arm_scmi/telemetry.c:905:24: sparse: sparse: dereference of noderef expression
   drivers/firmware/arm_scmi/telemetry.c:917:32: sparse: sparse: dereference of noderef expression
   drivers/firmware/arm_scmi/telemetry.c:917:32: sparse: sparse: dereference of noderef expression
   drivers/firmware/arm_scmi/telemetry.c:917:32: sparse: sparse: dereference of noderef expression
   drivers/firmware/arm_scmi/telemetry.c:917:32: sparse: sparse: dereference of noderef expression
   drivers/firmware/arm_scmi/telemetry.c:1023:13: sparse: sparse: dereference of noderef expression
   drivers/firmware/arm_scmi/telemetry.c:1023:35: sparse: sparse: dereference of noderef expression
   drivers/firmware/arm_scmi/telemetry.c:1024:13: sparse: sparse: dereference of noderef expression
   drivers/firmware/arm_scmi/telemetry.c:1041:25: sparse: sparse: dereference of noderef expression
   drivers/firmware/arm_scmi/telemetry.c:1066:15: sparse: sparse: dereference of noderef expression
   drivers/firmware/arm_scmi/telemetry.c:1066:15: sparse: sparse: dereference of noderef expression
   drivers/firmware/arm_scmi/telemetry.c:1066:15: sparse: sparse: dereference of noderef expression
   drivers/firmware/arm_scmi/telemetry.c:1066:15: sparse: sparse: dereference of noderef expression
   drivers/firmware/arm_scmi/telemetry.c:1069:21: sparse: sparse: dereference of noderef expression
   drivers/firmware/arm_scmi/telemetry.c:1070:34: sparse: sparse: dereference of noderef expression
   drivers/firmware/arm_scmi/telemetry.c:1070:34: sparse: sparse: dereference of noderef expression
   drivers/firmware/arm_scmi/telemetry.c:1070:34: sparse: sparse: dereference of noderef expression
   drivers/firmware/arm_scmi/telemetry.c:1070:34: sparse: sparse: dereference of noderef expression
   drivers/firmware/arm_scmi/telemetry.c:1071:28: sparse: sparse: dereference of noderef expression
   drivers/firmware/arm_scmi/telemetry.c:1106:24: sparse: sparse: dereference of noderef expression
   drivers/firmware/arm_scmi/telemetry.c:1106:46: sparse: sparse: dereference of noderef expression
   drivers/firmware/arm_scmi/telemetry.c:1110:13: sparse: sparse: dereference of noderef expression
   drivers/firmware/arm_scmi/telemetry.c:1113:14: sparse: sparse: dereference of noderef expression
   drivers/firmware/arm_scmi/telemetry.c:1148:26: sparse: sparse: dereference of noderef expression
   drivers/firmware/arm_scmi/telemetry.c:1504:16: sparse: sparse: dereference of noderef expression
   drivers/firmware/arm_scmi/telemetry.c:1504:16: sparse: sparse: dereference of noderef expression
   drivers/firmware/arm_scmi/telemetry.c:1504:16: sparse: sparse: dereference of noderef expression
   drivers/firmware/arm_scmi/telemetry.c:1504:16: sparse: sparse: dereference of noderef expression
   drivers/firmware/arm_scmi/telemetry.c:1507:35: sparse: sparse: dereference of noderef expression
   drivers/firmware/arm_scmi/telemetry.c:1507:35: sparse: sparse: dereference of noderef expression
   drivers/firmware/arm_scmi/telemetry.c:1507:35: sparse: sparse: dereference of noderef expression
   drivers/firmware/arm_scmi/telemetry.c:1507:35: sparse: sparse: dereference of noderef expression
   drivers/firmware/arm_scmi/telemetry.c:1639:21: sparse: sparse: dereference of noderef expression
   drivers/firmware/arm_scmi/telemetry.c:1642:21: sparse: sparse: dereference of noderef expression
   drivers/firmware/arm_scmi/telemetry.c:1645:21: sparse: sparse: dereference of noderef expression
   drivers/firmware/arm_scmi/telemetry.c:1645:21: sparse: sparse: dereference of noderef expression
   drivers/firmware/arm_scmi/telemetry.c:1649:24: sparse: sparse: dereference of noderef expression
   drivers/firmware/arm_scmi/telemetry.c:1649:24: sparse: sparse: dereference of noderef expression
   drivers/firmware/arm_scmi/telemetry.c:1649:24: sparse: sparse: dereference of noderef expression
   drivers/firmware/arm_scmi/telemetry.c:1649:24: sparse: sparse: dereference of noderef expression
   drivers/firmware/arm_scmi/telemetry.c:1652:30: sparse: sparse: dereference of noderef expression
   drivers/firmware/arm_scmi/telemetry.c:1654:36: sparse: sparse: dereference of noderef expression
   drivers/firmware/arm_scmi/telemetry.c:1655:43: sparse: sparse: dereference of noderef expression
   drivers/firmware/arm_scmi/telemetry.c:1655:43: sparse: sparse: dereference of noderef expression
   drivers/firmware/arm_scmi/telemetry.c:1655:43: sparse: sparse: dereference of noderef expression
   drivers/firmware/arm_scmi/telemetry.c:1655:43: sparse: sparse: dereference of noderef expression
   drivers/firmware/arm_scmi/telemetry.c:1656:36: sparse: sparse: dereference of noderef expression

vim +378 drivers/firmware/arm_scmi/telemetry.c

   354	
   355	static int
   356	scmi_telemetry_protocol_attributes_get(const struct scmi_protocol_handle *ph,
   357					       struct telemetry_info *ti)
   358	{
   359		int ret;
   360		struct scmi_xfer *t;
   361		struct scmi_msg_resp_telemetry_protocol_attributes *resp;
   362	
   363		ret = ph->xops->xfer_get_init(ph, PROTOCOL_ATTRIBUTES,
   364					      0, sizeof(*resp), &t);
   365		if (ret)
   366			return ret;
   367	
   368		resp = t->rx.buf;
   369		ret = ph->xops->do_xfer(ph, t);
   370		if (!ret) {
   371			__le32 attr = resp->attributes;
   372	
   373			ti->info.base.num_des = le32_to_cpu(resp->de_num);
   374			ti->info.base.num_groups = le32_to_cpu(resp->groups_num);
   375			for (int i = 0; i < SCMI_TLM_DE_IMPL_MAX_DWORDS; i++)
   376				ti->info.base.de_impl_version[i] =
   377					le32_to_cpu(resp->de_implementation_rev_dword[i]);
 > 378			ti->info.single_read_support = SUPPORTS_SINGLE_READ(attr);
   379			ti->info.continuos_update_support = SUPPORTS_CONTINUOS_UPDATE(attr);
   380			ti->info.per_group_config_support = SUPPORTS_PER_GROUP_CONFIG(attr);
   381			ti->info.reset_support = SUPPORTS_RESET(attr);
   382			ti->info.fc_support = SUPPORTS_FC(attr);
   383			ti->num_shmti = le32_get_bits(attr, GENMASK(15, 0));
   384			/* Allocate DEs descriptors */
   385			ti->info.des = devm_kcalloc(ph->dev, ti->info.base.num_des,
   386						    sizeof(*ti->info.des), GFP_KERNEL);
   387			if (!ti->info.des) {
   388				ret = -ENOMEM;
   389				goto out;
   390			}
   391	
   392			/* Allocate a set of contiguous DE info descriptors. */
   393			ti->info.des_store = devm_kcalloc(ph->dev, ti->info.base.num_des,
   394							  sizeof(*ti->info.des_store),
   395							  GFP_KERNEL);
   396			if (!ti->info.des_store) {
   397				ret = -ENOMEM;
   398				goto out;
   399			}
   400	
   401			/* Allocate DE GROUPS descriptors */
   402			ti->info.groups = devm_kcalloc(ph->dev, ti->info.base.num_groups,
   403						       sizeof(*ti->info.groups), GFP_KERNEL);
   404			if (!ti->info.groups) {
   405				ret = -ENOMEM;
   406				goto out;
   407			}
   408	
   409			/* Allocate a set of contiguous Group info descriptors. */
   410			ti->info.grps_store = devm_kcalloc(ph->dev, ti->info.base.num_groups,
   411							   sizeof(*ti->info.grps_store),
   412							   GFP_KERNEL);
   413			if (!ti->info.grps_store) {
   414				ret = -ENOMEM;
   415				goto out;
   416			}
   417	
   418			for (int i = 0; i < ti->info.base.num_groups; i++) {
   419				ti->info.grps_store[i].id = i;
   420				/* Bind contiguous Group info struct */
   421				ti->info.groups[i].info = &ti->info.grps_store[i];
   422			}
   423		}
   424	
   425	out:
   426		ph->xops->xfer_put(ph, t);
   427	
   428		return ret;
   429	}
   430	
   431	static void iter_tlm_prepare_message(void *message,
   432					     unsigned int desc_index, const void *priv)
   433	{
   434		put_unaligned_le32(desc_index, message);
   435	}
   436	
   437	static int iter_de_descr_update_state(struct scmi_iterator_state *st,
   438					      const void *response, void *priv)
   439	{
   440		const struct scmi_msg_resp_telemetry_de_description *r = response;
   441		struct scmi_tlm_de_priv *p = priv;
   442	
   443		st->num_returned = le32_get_bits(r->num_desc, GENMASK(15, 0));
   444		st->num_remaining = le32_get_bits(r->num_desc, GENMASK(31, 16));
   445	
   446		/* Initialized to first descriptor */
   447		p->next = (void *)r->desc;
   448	
   449		return 0;
   450	}
   451	
   452	static int iter_de_descr_process_response(const struct scmi_protocol_handle *ph,
   453						  const void *response,
   454						  struct scmi_iterator_state *st,
   455						  void *priv)
   456	{
   457		struct telemetry_de *tde;
   458		struct scmi_tlm_de_priv *p = priv;
   459		const struct scmi_de_desc *desc = p->next;
   460		unsigned int grp_id;
   461		int ret;
   462	
   463		tde = to_tde(p->ti->info.des[st->desc_index + st->loop_idx]);
   464	
   465		tde->de.info->id = le32_to_cpu(desc->id);
   466		grp_id = le32_to_cpu(desc->grp_id);
   467		if (grp_id != SCMI_TLM_GRP_INVALID) {
   468			/* Group descriptors are empty but allocated at this point */
   469			if (grp_id >= p->ti->info.base.num_groups)
   470				return -EINVAL;
   471	
   472			/* Link to parent group */
   473			tde->de.info->grp_id = grp_id;
   474			tde->de.grp = &p->ti->info.groups[grp_id];
   475		}
   476		tde->de.info->data_sz = le32_to_cpu(desc->data_sz);
   477		tde->de.info->type = GET_DE_TYPE(desc);
   478		tde->de.info->unit = GET_DE_UNIT(desc);
   479		tde->de.info->unit_exp = GET_DE_UNIT_EXP(desc);
 > 480		tde->de.info->tstamp_exp = GET_DE_TSTAMP_EXP(desc);
   481		tde->de.info->instance_id = GET_DE_INSTA_ID(desc);
   482		tde->de.info->compo_instance_id = GET_COMPO_INSTA_ID(desc);
   483		tde->de.info->compo_type = GET_COMPO_TYPE(desc);
   484		tde->de.info->persistent = IS_PERSISTENT(desc);
   485		tde->de.tstamp_support = IS_TSTAMP_SUPPORTED(desc);
   486		tde->de.fc_support = IS_FC_SUPPORTED(desc);
   487		tde->de.name_support = IS_NAME_SUPPORTED(desc);
   488		p->next += sizeof(*desc);
   489		if (tde->de.fc_support) {
   490			u32 size;
   491			u64 phys_addr;
   492			void __iomem *addr;
   493			struct de_desc_fc *dfc;
   494	
   495			dfc = p->next;
   496			phys_addr = le32_to_cpu(dfc->addr_low);
   497			phys_addr |= (u64)le32_to_cpu(dfc->addr_high) << 32;
   498	
   499			size = le32_to_cpu(dfc->size);
   500			addr = devm_ioremap(ph->dev, phys_addr, size);
   501			if (!addr)
   502				return -EADDRNOTAVAIL;
   503	
   504			tde->base = addr;
   505			tde->offset = 0;
   506			tde->fc_size = size;
   507	
   508			/* Variably sized depending on FC support */
   509			p->next += sizeof(*dfc);
   510		}
   511	
   512		if (tde->de.name_support) {
   513			const char *de_name = p->next;
   514	
   515			strscpy(tde->de.info->name, de_name, SCMI_SHORT_NAME_MAX_SIZE);
   516			//tde->de.name = tde->name;
   517	
   518			/* Variably sized depending on name support */
   519			p->next += SCMI_SHORT_NAME_MAX_SIZE;
   520		}
   521	
   522		/* Store DE pointer by de_id */
   523		ret = xa_insert(&p->ti->xa_des, tde->de.info->id, &tde->de, GFP_KERNEL);
   524		if (ret)
   525			return ret;
   526	
   527		/* Account for this DE in group num_de counter */
   528		if (tde->de.grp)
   529			tde->de.grp->info->num_des++;
   530	
   531		return 0;
   532	}
   533	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

