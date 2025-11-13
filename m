Return-Path: <linux-kernel+bounces-899254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 519EDC57363
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 12:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6F219352A52
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 11:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300572ECEA5;
	Thu, 13 Nov 2025 11:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CsIoJnic"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26EA2D9792
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 11:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763033471; cv=none; b=IgwRd85Za1x0NEB8R+cmHhvwU5JQNGog4rPz6KmqUh9Kc0PHf1mMgrq85dpCCIpG3uBDQA8pEot07Dm8IOgNdo7Ii0rPnkt0TAhn3UEz7vqubRGMk+GTEJW0/XkSTlzsnqC11EgV11nuPbjZ2TxtjTCHV36cqbD9M1i/CM0Tiq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763033471; c=relaxed/simple;
	bh=VO0D4qtFDnnqDUnf4u1aGwJJ/e/ChUkUSuVmhopuyUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DVI/ShfZhZp7l1YCCB+IbAn2HBAdhbsrd/59neGHb5hQJRrHChH8dKuikPSdxeNOVMmCSN5BQPqMn9sG5r+TkXZZH+kIqjCIkXSzXhobgXW0Yri2b5/xPBSC2PEeJzauZDsnCZqZ8xLkgDnf9NQ23bGSws1YX8Cwt83LcYbOMdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CsIoJnic; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763033468; x=1794569468;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VO0D4qtFDnnqDUnf4u1aGwJJ/e/ChUkUSuVmhopuyUE=;
  b=CsIoJnicPHf0Kad+fF4876F8/e0q7arQuAR7YdQgkl0qHNu7qBkPAObd
   nOmISMECjfx0auRISryL1WoKAH2axzvw1ypVrGzzghzSPfuhHXZFcVY+x
   RkxI98TPBF1fSiU6VveaMnhbGVPc1T6/b5p0rZXBPDg1z/FJUk44MOJwq
   RO2hz6qDmCzz+DIdfN/ZQA9SPSChv8sCBrSgurEGQi57StOEDllINNFkU
   K/TJMKn8v6rSN11qdx/63xzutI1Dfr1ptm/Q/ICTNEOSOU0DkVcj87gs5
   Ys+Y83nyEzcOqYujwXm7XZNda2i5WIzrifxs7Seu+QXl/2Kh7iy4HNwCQ
   Q==;
X-CSE-ConnectionGUID: rSYKA7F6Qbu19m+YCI0siQ==
X-CSE-MsgGUID: cbuZiTV+Rom6Rl/OSRLCIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="68960604"
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; 
   d="scan'208";a="68960604"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 03:31:07 -0800
X-CSE-ConnectionGUID: qv+Wec9pSSqs4nivXwDvhQ==
X-CSE-MsgGUID: Sn3jbVsASbKvR2WO6KQvFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; 
   d="scan'208";a="220132438"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 13 Nov 2025 03:31:05 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vJVXa-0005FV-26;
	Thu, 13 Nov 2025 11:31:02 +0000
Date: Thu, 13 Nov 2025 19:30:06 +0800
From: kernel test robot <lkp@intel.com>
To: Rosen Penev <rosenp@gmail.com>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Dinh Nguyen <dinguyen@kernel.org>
Subject: Re: [PATCHv2 2/2] firmware: stratix10-rsu: add COMPILE_TEST support
Message-ID: <202511131954.IdQx9gfF-lkp@intel.com>
References: <20251112063033.176276-3-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112063033.176276-3-rosenp@gmail.com>

Hi Rosen,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.18-rc5 next-20251113]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Rosen-Penev/firmware-stratix10-rsu-fix-32-bit-compilation/20251112-143202
base:   linus/master
patch link:    https://lore.kernel.org/r/20251112063033.176276-3-rosenp%40gmail.com
patch subject: [PATCHv2 2/2] firmware: stratix10-rsu: add COMPILE_TEST support
config: s390-randconfig-r111-20251113 (https://download.01.org/0day-ci/archive/20251113/202511131954.IdQx9gfF-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251113/202511131954.IdQx9gfF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511131954.IdQx9gfF-lkp@intel.com/

All errors (new ones prefixed by >>):

   s390-linux-ld: drivers/firmware/stratix10-svc.o: in function `svc_smccc_hvc':
>> drivers/firmware/stratix10-svc.c:845:(.text+0x5ba): undefined reference to `__arm_smccc_hvc'


vim +845 drivers/firmware/stratix10-svc.c

7ca5ce896524f5 Richard Gong 2018-11-13  826  
7ca5ce896524f5 Richard Gong 2018-11-13  827  /**
7ca5ce896524f5 Richard Gong 2018-11-13  828   * svc_smccc_hvc() - hypervisor call between normal and secure world
7ca5ce896524f5 Richard Gong 2018-11-13  829   * @a0: argument passed in registers 0
7ca5ce896524f5 Richard Gong 2018-11-13  830   * @a1: argument passed in registers 1
7ca5ce896524f5 Richard Gong 2018-11-13  831   * @a2: argument passed in registers 2
7ca5ce896524f5 Richard Gong 2018-11-13  832   * @a3: argument passed in registers 3
7ca5ce896524f5 Richard Gong 2018-11-13  833   * @a4: argument passed in registers 4
7ca5ce896524f5 Richard Gong 2018-11-13  834   * @a5: argument passed in registers 5
7ca5ce896524f5 Richard Gong 2018-11-13  835   * @a6: argument passed in registers 6
7ca5ce896524f5 Richard Gong 2018-11-13  836   * @a7: argument passed in registers 7
7ca5ce896524f5 Richard Gong 2018-11-13  837   * @res: result values from register 0 to 3
7ca5ce896524f5 Richard Gong 2018-11-13  838   */
7ca5ce896524f5 Richard Gong 2018-11-13  839  static void svc_smccc_hvc(unsigned long a0, unsigned long a1,
7ca5ce896524f5 Richard Gong 2018-11-13  840  			  unsigned long a2, unsigned long a3,
7ca5ce896524f5 Richard Gong 2018-11-13  841  			  unsigned long a4, unsigned long a5,
7ca5ce896524f5 Richard Gong 2018-11-13  842  			  unsigned long a6, unsigned long a7,
7ca5ce896524f5 Richard Gong 2018-11-13  843  			  struct arm_smccc_res *res)
7ca5ce896524f5 Richard Gong 2018-11-13  844  {
7ca5ce896524f5 Richard Gong 2018-11-13 @845  	arm_smccc_hvc(a0, a1, a2, a3, a4, a5, a6, a7, res);
7ca5ce896524f5 Richard Gong 2018-11-13  846  }
7ca5ce896524f5 Richard Gong 2018-11-13  847  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

