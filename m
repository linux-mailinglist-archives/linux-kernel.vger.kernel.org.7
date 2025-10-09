Return-Path: <linux-kernel+bounces-847320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CBEBCA859
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 20:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6611F4FCB06
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 18:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D9C258EE0;
	Thu,  9 Oct 2025 18:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JGBc2bxO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A567257839;
	Thu,  9 Oct 2025 18:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760033064; cv=none; b=ELCkHtXdNkaw9G81XXru32dusmhF2jSsnFoMFixSJWtW73u29lYOPUf8Uj4SabJrVop5HZCneJoCEXjltg+h/Y/+e9NtK4hWry+Je70MY3JOWqRVT96qUVHy5MO06+gExC3UwBTSy3fDTXuxNTefT9LMK5DNzN9meQ1p+QZQUlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760033064; c=relaxed/simple;
	bh=3KgeFNDYe74xdOqob4chupVcc+/7QUgmTQnHcfE6VMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MS3fO+atWfy3BaASjEetOTpm5IpE9HoESAEM6P/Ldvl2LfELM7E3nBUmw6PtAe2eoL8VOfgt4han443TZ0gcCJxkW+BUVKEBk3Fc0/Te82wLF0MB/7rfV8WbuyOYfpyHoe8aDJIuyyX+BRqEkBccZ83Ofzd0aWRqd6QpO9j02TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JGBc2bxO; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760033063; x=1791569063;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3KgeFNDYe74xdOqob4chupVcc+/7QUgmTQnHcfE6VMk=;
  b=JGBc2bxOcJvlYesMLaCHme3Es2kEasGynjRk0RHhgWn+Am1PB/g4XU/Z
   e6FIXddrAVhLca+LDZlCK3NsDRrH+mihzMU18I9aZTy3vaYmTwuhcLO2K
   99wp/j0dk7F0u1+BLlNQcP6wCDDhcUXG8Sr9jG8KkxgPountFV3X4NGaP
   e6e1W86SeTQN01Yh0dYNu1ga9aMBE0BWNf1n0fETQLTJv8rD3UmDS1k+O
   agjcRI4mLavzYUFut4rHM8vNMnM+EWsKom+rpyv3Zmb4f9QCiuK58mPeX
   biD7s25ap/ipZAWV5UTdJBhSHHZqXTjyXaUkZfrL0SMDFiOHVydbmpZH6
   w==;
X-CSE-ConnectionGUID: 4XFzhjIPRzSUGqzUF9vUAQ==
X-CSE-MsgGUID: kqHqsIM6Tv+v8u2RXWLv0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11577"; a="73597059"
X-IronPort-AV: E=Sophos;i="6.19,217,1754982000"; 
   d="scan'208";a="73597059"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 11:04:22 -0700
X-CSE-ConnectionGUID: fjHqzhrCRKS1RXXl8zss4w==
X-CSE-MsgGUID: xQLsRIYRROqFnPRdr5cTPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,217,1754982000"; 
   d="scan'208";a="217871654"
Received: from lkp-server01.sh.intel.com (HELO 6a630e8620ab) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 09 Oct 2025 11:04:18 -0700
Received: from kbuild by 6a630e8620ab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v6uzt-0001At-2i;
	Thu, 09 Oct 2025 18:04:13 +0000
Date: Fri, 10 Oct 2025 02:03:40 +0800
From: kernel test robot <lkp@intel.com>
To: Cosmo Chou <chou.cosmo@gmail.com>, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux@roeck-us.net, corbet@lwn.net
Cc: oe-kbuild-all@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org, cosmo.chou@quantatw.com,
	Cosmo Chou <chou.cosmo@gmail.com>
Subject: Re: [PATCH 2/2] hwmon: (pmbus) add driver for MPS MP9945
Message-ID: <202510100100.uGBElhsf-lkp@intel.com>
References: <20251005204855.190270-2-chou.cosmo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251005204855.190270-2-chou.cosmo@gmail.com>

Hi Cosmo,

kernel test robot noticed the following build errors:

[auto build test ERROR on groeck-staging/hwmon-next]
[also build test ERROR on robh/for-next linus/master v6.17 next-20251009]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Cosmo-Chou/hwmon-pmbus-add-driver-for-MPS-MP9945/20251009-153602
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
patch link:    https://lore.kernel.org/r/20251005204855.190270-2-chou.cosmo%40gmail.com
patch subject: [PATCH 2/2] hwmon: (pmbus) add driver for MPS MP9945
config: x86_64-randconfig-r072-20251009 (https://download.01.org/0day-ci/archive/20251010/202510100100.uGBElhsf-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251010/202510100100.uGBElhsf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510100100.uGBElhsf-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/hwmon/pmbus/mp9945.c:243:18: error: expected ';' after top level declarator
     243 | MODULE_IMPORT_NS(PMBUS);
         |                  ^
   1 error generated.


vim +243 drivers/hwmon/pmbus/mp9945.c

   239	
   240	MODULE_AUTHOR("Cosmo Chou <chou.cosmo@gmail.com>");
   241	MODULE_DESCRIPTION("PMBus driver for MPS MP9945");
   242	MODULE_LICENSE("GPL");
 > 243	MODULE_IMPORT_NS(PMBUS);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

