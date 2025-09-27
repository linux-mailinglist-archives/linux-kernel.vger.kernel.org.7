Return-Path: <linux-kernel+bounces-835014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE7ABA60A3
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 16:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AC6E4A5EFF
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 14:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49DA2E2F1A;
	Sat, 27 Sep 2025 14:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dji8bOqD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629212D73AE
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 14:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758983659; cv=none; b=h1t618jeXgKYBYQ0LBxpyVyrkyTUfxyAvYtYWuP+yK0jF0sMRcBa9QFLZWrkwjMb3eUfH8eTfPUiqcbhJNbItVgBhQbaYO3RXUgrDxMclrIIplz7IO8P1wZqVrZByVpEWdtNMAZWdxByyTCfsjRAmcOvrQqSjSBNnPI+2E9ueCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758983659; c=relaxed/simple;
	bh=ZmKQpEB08Mxzlcmb0UaDyY/0gQnGSP21LOGV/UEWZ8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FBpQjmwujy+oiUpnMY+7JuKLzgkrEdEt7NPDrk8a+PXJn9dtEl7dWeufxAy+yHLTlkJWzxZko3zV4vx4vgNL+3PI240v7DHMQXrR7+uCag6P23MWn3ANzMXrCB8ohBfdhp6uxxe5DusiIPPulu2gBgKNpGTalFGssmu2VhXN2YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dji8bOqD; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758983658; x=1790519658;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZmKQpEB08Mxzlcmb0UaDyY/0gQnGSP21LOGV/UEWZ8I=;
  b=dji8bOqDvX2N79ycO0gxgskB3Ym0k+M1ggqC6Ul3Jr3q5gBSdvb8qRKy
   TPl1hU4F44oK1O+lc2jPADkthuonaw2LR32cYtAhbVbelhlkwrxbcLy0j
   hrnBcJ/QvOExPomL+geE8Etz104WA0aloeGHkDuD3O1LPCVAk6G0HqqUJ
   qOkQLZzpmmbveRuBijgtVy6gzql+aYosIhBtkNlULZqgtlrc6k2QrfCsQ
   mQ+XpPZN2nda5ePqq3kUePsWsy0Ot+kBTffcVb0bpsgi+AfoD0hCK6d6W
   1izqO8HTrMe24UHEg7CebRgLiUCZqB7FDjy/RrrNToesysb8I40qwgD0U
   Q==;
X-CSE-ConnectionGUID: xkpOsI4LS1KRpVdY2wlqSw==
X-CSE-MsgGUID: O8ShtojwTQWIQ1V/fDxMPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11566"; a="61182365"
X-IronPort-AV: E=Sophos;i="6.18,297,1751266800"; 
   d="scan'208";a="61182365"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2025 07:34:17 -0700
X-CSE-ConnectionGUID: Cvp2keUjRg+pO+hAJsp4+Q==
X-CSE-MsgGUID: dcU+WiugSa+1tNRKTyxyZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,297,1751266800"; 
   d="scan'208";a="176972103"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 27 Sep 2025 07:34:16 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v2W04-00077H-2g;
	Sat, 27 Sep 2025 14:34:12 +0000
Date: Sat, 27 Sep 2025 22:33:42 +0800
From: kernel test robot <lkp@intel.com>
To: adriana <adriana@arista.com>, jdelvare@suse.com,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Adriana Nicolae <adriana@arista.com>
Subject: Re: [PATCH 1/1] DMI: Scan for DMI tbale from DTS info
Message-ID: <202509272216.c9WBgv6U-lkp@intel.com>
References: <20250926155612.2737443-1-adriana@arista.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926155612.2737443-1-adriana@arista.com>

Hi adriana,

kernel test robot noticed the following build warnings:

[auto build test WARNING on v6.17-rc7]
[also build test WARNING on linus/master next-20250926]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/adriana/DMI-Scan-for-DMI-tbale-from-DTS-info/20250926-235813
base:   v6.17-rc7
patch link:    https://lore.kernel.org/r/20250926155612.2737443-1-adriana%40arista.com
patch subject: [PATCH 1/1] DMI: Scan for DMI tbale from DTS info
config: i386-randconfig-061-20250927 (https://download.01.org/0day-ci/archive/20250927/202509272216.c9WBgv6U-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250927/202509272216.c9WBgv6U-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509272216.c9WBgv6U-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/firmware/dmi_scan.c:704:19: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem *p @@     got void * @@
   drivers/firmware/dmi_scan.c:704:19: sparse:     expected void [noderef] __iomem *p
   drivers/firmware/dmi_scan.c:704:19: sparse:     got void *
>> drivers/firmware/dmi_scan.c:709:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *addr @@     got void [noderef] __iomem *p @@
   drivers/firmware/dmi_scan.c:709:33: sparse:     expected void *addr
   drivers/firmware/dmi_scan.c:709:33: sparse:     got void [noderef] __iomem *p
   drivers/firmware/dmi_scan.c:721:19: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem *p @@     got void * @@
   drivers/firmware/dmi_scan.c:721:19: sparse:     expected void [noderef] __iomem *p
   drivers/firmware/dmi_scan.c:721:19: sparse:     got void *
   drivers/firmware/dmi_scan.c:726:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *addr @@     got void [noderef] __iomem *p @@
   drivers/firmware/dmi_scan.c:726:33: sparse:     expected void *addr
   drivers/firmware/dmi_scan.c:726:33: sparse:     got void [noderef] __iomem *p
   drivers/firmware/dmi_scan.c:760:27: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __iomem *p @@     got void * @@
   drivers/firmware/dmi_scan.c:760:27: sparse:     expected char [noderef] __iomem *p
   drivers/firmware/dmi_scan.c:760:27: sparse:     got void *
   drivers/firmware/dmi_scan.c:764:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *addr @@     got char [noderef] __iomem *p @@
   drivers/firmware/dmi_scan.c:764:41: sparse:     expected void *addr
   drivers/firmware/dmi_scan.c:764:41: sparse:     got char [noderef] __iomem *p
   drivers/firmware/dmi_scan.c:778:19: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __iomem *p @@     got void * @@
   drivers/firmware/dmi_scan.c:778:19: sparse:     expected char [noderef] __iomem *p
   drivers/firmware/dmi_scan.c:778:19: sparse:     got void *
   drivers/firmware/dmi_scan.c:782:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *addr @@     got char [noderef] __iomem *p @@
   drivers/firmware/dmi_scan.c:782:33: sparse:     expected void *addr
   drivers/firmware/dmi_scan.c:782:33: sparse:     got char [noderef] __iomem *p
   drivers/firmware/dmi_scan.c:796:19: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __iomem *p @@     got void * @@
   drivers/firmware/dmi_scan.c:796:19: sparse:     expected char [noderef] __iomem *p
   drivers/firmware/dmi_scan.c:796:19: sparse:     got void *
   drivers/firmware/dmi_scan.c:809:49: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *addr @@     got char [noderef] __iomem *p @@
   drivers/firmware/dmi_scan.c:809:49: sparse:     expected void *addr
   drivers/firmware/dmi_scan.c:809:49: sparse:     got char [noderef] __iomem *p
   drivers/firmware/dmi_scan.c:827:49: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *addr @@     got char [noderef] __iomem *p @@
   drivers/firmware/dmi_scan.c:827:49: sparse:     expected void *addr
   drivers/firmware/dmi_scan.c:827:49: sparse:     got char [noderef] __iomem *p
   drivers/firmware/dmi_scan.c:832:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *addr @@     got char [noderef] __iomem *p @@
   drivers/firmware/dmi_scan.c:832:33: sparse:     expected void *addr
   drivers/firmware/dmi_scan.c:832:33: sparse:     got char [noderef] __iomem *p

vim +704 drivers/firmware/dmi_scan.c

   675	
   676	#if IS_ENABLED(CONFIG_OF)
   677	/**
   678	 * dmi_scan_from_dt - Find and parse DMI/SMBIOS tables from the Device Tree
   679	 *
   680	 * Checks if the bootloader has passed SMBIOS table addresses via the /chosen
   681	 * node in the Device Tree. This follows the standard kernel DT bindings and
   682	 * assumes a fixed 32-byte mapping for the entry point.
   683	 * Returns true if a valid table is found and successfully parsed.
   684	 */
   685	static bool __init dmi_scan_from_dt(void)
   686	{
   687		struct device_node *chosen;
   688		const __be64 *prop;
   689		char buf[32];
   690		void __iomem *p;
   691		bool dmi_available = false;
   692		u64 addr;
   693		int len;
   694	
   695		chosen = of_find_node_by_path("/chosen");
   696		if (!chosen)
   697			return false;
   698	
   699		/* SMBIOSv3 (64-bit entry point) has priority */
   700		prop = of_get_property(chosen, "linux,smbios3-table", &len);
   701		if (prop && len >= sizeof(u64)) {
   702			addr = be64_to_cpup(prop);
   703	
 > 704			p = dmi_early_remap(addr, 32);
   705			if (p == NULL)
   706				goto out;
   707	
   708			memcpy_fromio(buf, p, sizeof(buf));
 > 709			dmi_early_unmap(p, 32);
   710	
   711			if (!dmi_smbios3_present(buf)) {
   712				dmi_available = true;
   713				goto out;
   714			}
   715		}
   716	
   717		prop = of_get_property(chosen, "linux,smbios-table", &len);
   718		if (prop && len >= sizeof(u64)) {
   719			addr = be64_to_cpup(prop);
   720	
   721			p = dmi_early_remap(addr, 32);
   722			if (p == NULL)
   723				goto out;
   724	
   725			memcpy_fromio(buf, p, sizeof(buf));
   726			dmi_early_unmap(p, 32);
   727	
   728			if (!dmi_present(buf))
   729				dmi_available = true;
   730		}
   731	
   732	out:
   733		of_node_put(chosen);
   734		return dmi_available;
   735	}
   736	#else
   737	static bool __init dmi_scan_from_dt(void) { return false; }
   738	#endif /* IS_ENABLED(CONFIG_OF) */
   739	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

