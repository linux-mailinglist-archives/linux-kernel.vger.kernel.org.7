Return-Path: <linux-kernel+bounces-834227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFA4BA4392
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7211B1C06FCF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 14:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67231F4168;
	Fri, 26 Sep 2025 14:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TLwizgF6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEED114B953;
	Fri, 26 Sep 2025 14:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758897094; cv=none; b=dfcJv7ONvDf/lQ1mNZ1pwq7Zt2cTDxoqCOi3jKLzkM6izqINJ4w96WsmWq8UyXC70a+rEK1oNFnG6e8cANZrPW9fns29RhiZDM6HM1semXe1ANgGL2Cb+moLBa4KonzbJ5RBzG0W5XzTzVC16Ul+WUNTlRNZAoak6shnYPL0Rlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758897094; c=relaxed/simple;
	bh=NVDGDPSRfBOg+IYM2GGQj9xeTSDqNKFZs6gh3u8/io4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HidF207S12/L74YfAt7qwDQQml9faDRBn6fE98kaMVr0/E6hGCOcRiVmzkJG4yvUDVzYLKQOfssPX9n6W2BSP4ZafCLVNIjk02xcYxHblrLqDI87/4//SzVxdmQHIX4pv6+lVapw6imhzbfA7bzrulgLBv+fgErgtm5aaI+Zr8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TLwizgF6; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758897093; x=1790433093;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NVDGDPSRfBOg+IYM2GGQj9xeTSDqNKFZs6gh3u8/io4=;
  b=TLwizgF6nRWQuJrBJSGjiub0gOrIT5lPjFwDQcdEbaWO5UrPdUCJuUxc
   rCQZneAXZ8Jue/zP5GceQAR3qEgORRdWnse1slsEz/foL+Thq3vAf1MxH
   Z8A0KNilSEDe31QpFw4kNVDfdWXHFmgk4Tn5qDDMo1qYMSeR19+8nFPvF
   bsCXTh0JHIF3VHhVG7Rhz6VhYV6L+rDJLsS9Vu6XANeLiyrs5LPgk9FRj
   0cAWgAvn3j0F7JlZiOAfZgX+sRBgQKxUF0itnzo/SRPIryrs9foiqezub
   FTsBuHlqF2AZaL+JecDWVIulEdTrOmkTTrYY+IJioU8jVr4fxQ8kBRL/g
   Q==;
X-CSE-ConnectionGUID: T2on8A+XS7WzoyDdd7T59A==
X-CSE-MsgGUID: vxdXDQH1SvWSN02WlQl1rw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="61183954"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="61183954"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 07:31:33 -0700
X-CSE-ConnectionGUID: 5AKesJxsQhWElaZ1Al31ag==
X-CSE-MsgGUID: U1ZXK4swSF2PMznGtDjUgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; 
   d="scan'208";a="208377174"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 26 Sep 2025 07:31:29 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v29Tc-0006JR-30;
	Fri, 26 Sep 2025 14:31:18 +0000
Date: Fri, 26 Sep 2025 22:30:25 +0800
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
Subject: Re: [PATCH 04/10] uapi: Add ARM SCMI definitions
Message-ID: <202509262227.VZVSICFi-lkp@intel.com>
References: <20250925203554.482371-5-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925203554.482371-5-cristian.marussi@arm.com>

Hi Cristian,

kernel test robot noticed the following build errors:

[auto build test ERROR on soc/for-next]
[also build test ERROR on trace/for-next linus/master v6.17-rc7 next-20250925]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Cristian-Marussi/firmware-arm_scmi-Define-a-common-SCMI_MAX_PROTOCOLS-value/20250926-044350
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
patch link:    https://lore.kernel.org/r/20250925203554.482371-5-cristian.marussi%40arm.com
patch subject: [PATCH 04/10] uapi: Add ARM SCMI definitions
config: x86_64-buildonly-randconfig-005-20250926 (https://download.01.org/0day-ci/archive/20250926/202509262227.VZVSICFi-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250926/202509262227.VZVSICFi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509262227.VZVSICFi-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
>> ./usr/include/linux/scmi.h:43:1: error: C++ style comments are not allowed in ISO C90
      43 | ///TODO more flags
         | ^
   ./usr/include/linux/scmi.h:43:1: note: (this will be reported only once per input file)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

