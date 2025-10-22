Return-Path: <linux-kernel+bounces-864348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CDDBFA93F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A67964F6AF6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 07:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABC92F90DE;
	Wed, 22 Oct 2025 07:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IV5jXqOe"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B182ECEA9
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761118388; cv=none; b=bh7eS8iE8l+0MPp54nU91uZnu6YR0A13yatbv7m7AIfweQW6/BM695gIzmhWm33dctTpCJuFWD/4hClnDxtNE4W0/OFq8nZ6EZMXyYoZDrv8C5IDV0DUNAS6u8EDJeBcvdnuASGQwuwgNOS2yafFyt9ACUblfJ5KWG1y21rHUDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761118388; c=relaxed/simple;
	bh=5jGyijFXBd+kWlPS7szMVtwgQqfkd/aGB/wsypPrASk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mrl0RKOcQIY6LiTNVEXNQ/RMF4NeT9csvWZ0qUwnG3smaFG+GjdspOdYueIzUJAYzW4pcv4EqasR/d3fJfRwYwz6ZYOdIqOBR6ZBz0TNMNff4jJXc9Gnig4uCB7jU5nmHwpQfCDbqCj3qypzcI9tpr8INanVR8TlcS1W83Jb2Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IV5jXqOe; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761118387; x=1792654387;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5jGyijFXBd+kWlPS7szMVtwgQqfkd/aGB/wsypPrASk=;
  b=IV5jXqOevnFzoKXN4dwS1PxMyIlb6sM8JJsUquj8XAovL+N2oVkd8NU1
   y28BWFv2TbwBNw1FuBvf+cA0mpKJF98l3ysTwbJ/6ZfCuscsN44yqTfoX
   Ds3i2X+UTLmZlFoYolMpol8FfdagCK5dcy5xYV9S0lPjKK3XT4H9R1K86
   IEIlHl1so3TFkuUcRHVCktr55GUy0PLgV2z1MDDvjYErVXcxvTDHF/zQb
   Ms7DyT7enBCvXVjC2XUEqt38KejblOTk/UWd/5I/Pjzbwrh4oBD8V7lCU
   ti+vSfElO2ojoC10+4+/S8WZ0fmcr7x/RaBxVZWFeHQJmIjT5LgQ6PO1t
   A==;
X-CSE-ConnectionGUID: bkzAk4C2RViOn0EKm7AJCw==
X-CSE-MsgGUID: ojwIKFJVRU6DBvA8VMmFgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="80881146"
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="80881146"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 00:33:06 -0700
X-CSE-ConnectionGUID: fov/Oc3RRLiiWkuh5b5zYg==
X-CSE-MsgGUID: RHrFOH6rSy2zXBLfuY46JA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="187840887"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 22 Oct 2025 00:33:04 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vBTJr-000C6D-0U;
	Wed, 22 Oct 2025 07:32:03 +0000
Date: Wed, 22 Oct 2025 15:31:07 +0800
From: kernel test robot <lkp@intel.com>
To: Biancaa Ramesh <biancaa2210329@ssn.edu.in>,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Biancaa Ramesh <biancaa2210329@ssn.edu.in>
Subject: Re: [PATCH] Kconfig:Uses glibc so strscpy has to be manually- added
Message-ID: <202510221519.nzy5mUJ3-lkp@intel.com>
References: <20251021171446.46942-1-biancaa2210329@ssn.edu.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021171446.46942-1-biancaa2210329@ssn.edu.in>

Hi Biancaa,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.18-rc2 next-20251022]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Biancaa-Ramesh/Kconfig-Uses-glibc-so-strscpy-has-to-be-manually-added/20251022-011608
base:   linus/master
patch link:    https://lore.kernel.org/r/20251021171446.46942-1-biancaa2210329%40ssn.edu.in
patch subject: [PATCH] Kconfig:Uses glibc so strscpy has to be manually- added
config: arm-randconfig-r071-20251022 (attached as .config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251022/202510221519.nzy5mUJ3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510221519.nzy5mUJ3-lkp@intel.com/

All errors (new ones prefixed by >>):

   scripts/kconfig/util.c: In function 'str_new':
>> scripts/kconfig/util.c:70:9: error: implicit declaration of function 'strscpy'; did you mean 'strlcpy'? [-Wimplicit-function-declaration]
      70 |         strscpy(gs.s, "\0");
         |         ^~~~~~~
         |         strlcpy
   scripts/kconfig/symbol.c: In function 'sym_set_string_value':
>> scripts/kconfig/symbol.c:812:9: error: implicit declaration of function 'strscpy'; did you mean 'strlcpy'? [-Wimplicit-function-declaration]
     812 |         strscpy(val, newval);
         |         ^~~~~~~
         |         strlcpy
   make[3]: *** [scripts/Makefile.host:131: scripts/kconfig/util.o] Error 1
   scripts/kconfig/confdata.c: In function 'conf_touch_dep':
>> scripts/kconfig/confdata.c:157:9: error: implicit declaration of function 'strscpy'; did you mean 'strlcpy'? [-Wimplicit-function-declaration]
     157 |         strscpy(depfile_path + depfile_prefix_len, name);
         |         ^~~~~~~
         |         strlcpy
   make[3]: *** [scripts/Makefile.host:131: scripts/kconfig/confdata.o] Error 1
   make[3]: *** [scripts/Makefile.host:131: scripts/kconfig/symbol.o] Error 1
   make[3]: Target 'oldconfig' not remade because of errors.
   make[2]: *** [Makefile:742: oldconfig] Error 2
   make[1]: *** [Makefile:248: __sub-make] Error 2
   make[1]: Target 'oldconfig' not remade because of errors.
   make: *** [Makefile:248: __sub-make] Error 2
   make: Target 'oldconfig' not remade because of errors.
--
   scripts/kconfig/util.c: In function 'str_new':
>> scripts/kconfig/util.c:70:9: error: implicit declaration of function 'strscpy'; did you mean 'strlcpy'? [-Wimplicit-function-declaration]
      70 |         strscpy(gs.s, "\0");
         |         ^~~~~~~
         |         strlcpy
   make[3]: *** [scripts/Makefile.host:131: scripts/kconfig/util.o] Error 1
   scripts/kconfig/confdata.c: In function 'conf_touch_dep':
>> scripts/kconfig/confdata.c:157:9: error: implicit declaration of function 'strscpy'; did you mean 'strlcpy'? [-Wimplicit-function-declaration]
     157 |         strscpy(depfile_path + depfile_prefix_len, name);
         |         ^~~~~~~
         |         strlcpy
   scripts/kconfig/symbol.c: In function 'sym_set_string_value':
>> scripts/kconfig/symbol.c:812:9: error: implicit declaration of function 'strscpy'; did you mean 'strlcpy'? [-Wimplicit-function-declaration]
     812 |         strscpy(val, newval);
         |         ^~~~~~~
         |         strlcpy
   make[3]: *** [scripts/Makefile.host:131: scripts/kconfig/confdata.o] Error 1
   make[3]: *** [scripts/Makefile.host:131: scripts/kconfig/symbol.o] Error 1
   make[3]: Target 'olddefconfig' not remade because of errors.
   make[2]: *** [Makefile:742: olddefconfig] Error 2
   make[1]: *** [Makefile:248: __sub-make] Error 2
   make[1]: Target 'olddefconfig' not remade because of errors.
   make: *** [Makefile:248: __sub-make] Error 2
   make: Target 'olddefconfig' not remade because of errors.


vim +70 scripts/kconfig/util.c

    62	
    63	/* Allocate initial growable string */
    64	struct gstr str_new(void)
    65	{
    66		struct gstr gs;
    67		gs.s = xmalloc(sizeof(char) * 64);
    68		gs.len = 64;
    69		gs.max_width = 0;
  > 70		strscpy(gs.s, "\0");
    71		return gs;
    72	}
    73	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

