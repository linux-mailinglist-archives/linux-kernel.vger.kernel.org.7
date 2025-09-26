Return-Path: <linux-kernel+bounces-834070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C45BA3C11
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 15:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26AF33B0F0F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 13:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC8F2F5A20;
	Fri, 26 Sep 2025 13:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BFKUHGgq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB40627AC59;
	Fri, 26 Sep 2025 13:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758891949; cv=none; b=JODeuyWh6mtCkcHPWgYqv85uG9RxA2XlDS6W40bvrfEfJbS1aob4zUJwv28JV4vZfXihY/darK1bJoHM0wv1ZFSLO7W0UjIDU7uPIr/w39F48NQCXR9VCwUTL9aJL6SMPBCG55I9phFOLDzS7rSDr0SktuQZckVCdSuXVC+i5js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758891949; c=relaxed/simple;
	bh=5EckeHvLXOfXBu+wiRZ3U0nu3PJn69N0Omj53rP0XeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KwZbWCdI+7ZgosarIQ7Ld5Qeisk/W65+DPs/g1uLxWYnOr8zM6xd1XurvX/8x4paDNzwxqYtfRZ4CFXvcZrFT8lOBqxuY3Z1m4HbrbRNbQ+cRMtRnwiB2qzgAN6FWYp54OQ+JD9+6XsUINCY/PUWJys0hP+G9fOt6ngL7uVh6tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BFKUHGgq; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758891948; x=1790427948;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5EckeHvLXOfXBu+wiRZ3U0nu3PJn69N0Omj53rP0XeY=;
  b=BFKUHGgqY28TRaEAC02bnfhx/Wu+efTzlRhFIU3rFiDO6OOzsbpXU5lD
   zFxplLjiez0RGauc75sxeGYb/GmgP/h/GKtuRBGCdxMV5umNpenhoygX4
   GxxZ3meefeDUCNmSaw1SJnl56WrPPkDDrYyi0JvI7L/Tv6zkdBFcqvIyk
   bZuI/32e3DT5r/DWyMXY7ek+oFBVJ9V5PVpre/Ai13ZT6QM58sSTmtJ4q
   lFnjW8OfYiaBFHDKPjYK9x/GJcgrp7rOIjwHjbZisoY+77FfIVoRgJY0f
   nLaaDO/tXVyERIg8wGIs6KR1P9GlKGuuGfrLm7AJoYiukbFCJy9yScJBN
   A==;
X-CSE-ConnectionGUID: Xtdx+KjGSFmXeitp4r0ynw==
X-CSE-MsgGUID: gPmjcBWvS0CbVb8DvuKUrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="78656092"
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; 
   d="scan'208";a="78656092"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 06:05:48 -0700
X-CSE-ConnectionGUID: bpvbqfG6SXy3K8p9KFjrog==
X-CSE-MsgGUID: rGbEM9WqQCOK7rxoIgHIkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; 
   d="scan'208";a="182777895"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 26 Sep 2025 06:05:43 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v288q-0006F7-0z;
	Fri, 26 Sep 2025 13:05:40 +0000
Date: Fri, 26 Sep 2025 21:05:31 +0800
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
Subject: Re: [PATCH 10/10] firmware: arm_scmi: Use new Telemetry traces
Message-ID: <202509262034.xwphcmtO-lkp@intel.com>
References: <20250925203554.482371-11-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925203554.482371-11-cristian.marussi@arm.com>

Hi Cristian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on soc/for-next]
[also build test WARNING on trace/for-next linus/master v6.17-rc7 next-20250925]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Cristian-Marussi/firmware-arm_scmi-Define-a-common-SCMI_MAX_PROTOCOLS-value/20250926-044350
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
patch link:    https://lore.kernel.org/r/20250925203554.482371-11-cristian.marussi%40arm.com
patch subject: [PATCH 10/10] firmware: arm_scmi: Use new Telemetry traces
config: nios2-randconfig-001-20250926 (https://download.01.org/0day-ci/archive/20250926/202509262034.xwphcmtO-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250926/202509262034.xwphcmtO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509262034.xwphcmtO-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/firmware/arm_scmi/telemetry.c: In function 'scmi_telemetry_tdcf_blkts_parse':
>> drivers/firmware/arm_scmi/telemetry.c:1039:46: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    1039 |         trace_scmi_tlm_collect(bts->last_ts, (u64)payld,
         |                                              ^


vim +1039 drivers/firmware/arm_scmi/telemetry.c

  1017	
  1018	static void scmi_telemetry_tdcf_blkts_parse(struct telemetry_info *ti,
  1019						    struct payload __iomem *payld,
  1020						    struct telemetry_shmti *shmti)
  1021	{
  1022		struct telemetry_block_ts *bts;
  1023	
  1024		/* Check for spec compliance */
  1025		if (USE_LINE_TS(payld) || USE_BLK_TS(payld) ||
  1026		    DATA_INVALID(payld) || (PAYLD_ID(payld) != 0)) {
  1027			trace_scmi_tlm_access(0, "BLK_TS_INVALID", 0, 0);
  1028			return;
  1029		}
  1030	
  1031		/* A BLK_TS descriptor MUST be returned: it is found or it is crated */
  1032		bts = scmi_telemetry_blkts_lookup(ti->dev, &ti->xa_bts, payld);
  1033		if (WARN_ON(!bts))
  1034			return;
  1035	
  1036		/* Update the descriptor with the lastest TS*/
  1037		scmi_telemetry_blkts_update(shmti->last_magic, bts);
  1038	
> 1039		trace_scmi_tlm_collect(bts->last_ts, (u64)payld,
  1040				       bts->last_magic, "SHMTI_BLK_TS");
  1041	}
  1042	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

