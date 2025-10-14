Return-Path: <linux-kernel+bounces-852540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 314F6BD9491
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A9403352BAE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E9231196B;
	Tue, 14 Oct 2025 12:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="np5ANdGT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F022874ED
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 12:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760443997; cv=none; b=M0aiUK+F3H1Efxd2XudhzZp01sEe01LoU/66YI7dghSMBtYtQl17fn3EVFPTfIQq47sEmlQfQtel9hRCTf+YFiJ1wsO5y4irqMTiaurMufTMfau3IeP/gydQKrzednVppJWtUsdtwjZQpWzuYWncWdZrCsyYqrXK3pklKHSzAr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760443997; c=relaxed/simple;
	bh=lSKptZauH/pfaAXe6bjq0/3e6ib2AOPx9muCnN5qP20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0YVC6kGBveAZlXCF9rwPLvqqS85/2XrCepeYfdcp7eoyehZEyw3ZW4GX0zJs6yGISxz9j5IdWL+NxFwS8LIuF2vAdr0e/JxjdfuNXPe+VnfG45zSURopdk2HgjW/sfDyaaZgC7lHFG8GZydE2mUKMqYmR4F8mB6oj/KWwoCMFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=np5ANdGT; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760443994; x=1791979994;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lSKptZauH/pfaAXe6bjq0/3e6ib2AOPx9muCnN5qP20=;
  b=np5ANdGTLwQWqztWNVtD0Uea+s2ggAavbQ8z9GOq/6weFQTsayeeHYpf
   BYzf8ACC7+rmGFlUUd/yZA1mOtMpCAh42a+E+0X2qcxItA8Mq2+b9hOoB
   lZ3l+IiMoFin03xn3m8e6aoLFp2MlYu2nZz9zXDzqIApbowH5GvTq7XAf
   zpp4y01WX8MwlxtrCWtsNPWiNz4nmW3IgbN/X3BC0iIGqMdZVUh2gUZA4
   FStDgX2D9GWKeCHKdrikKdJvxOwknXYdR3wVGs/mx8YcVMisSI/PbkHoS
   O0nrWlMcSCbtY2JWXo0Hm03EPLb3VirF8wR7Bx7j5ufPYmqxADj2Ht/u6
   A==;
X-CSE-ConnectionGUID: uOgS8kKCTeyJElG1uHJD2A==
X-CSE-MsgGUID: rzyKfjxiTOSf4f9ieJK3UQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62511391"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62511391"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 05:13:13 -0700
X-CSE-ConnectionGUID: +7QYm7AaSqW62lE4vNTskA==
X-CSE-MsgGUID: HSzK1kEqQfSbZrFa4poH2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; 
   d="scan'208";a="181416891"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 14 Oct 2025 05:13:11 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v8dts-0002ml-1J;
	Tue, 14 Oct 2025 12:13:08 +0000
Date: Tue, 14 Oct 2025 20:12:23 +0800
From: kernel test robot <lkp@intel.com>
To: Aditya Gollamudi <adigollamudi@gmail.com>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, adigollamudi@gmail.com,
	mark.rutland@arm.com, peterz@infradead.org, kees@kernel.org,
	mingo@kernel.org, ubizjak@gmail.com
Subject: Re: [PATCH] include/linux/atomic: fix typos in atomic-arch-fallback.h
Message-ID: <202510141934.WzOkEFX6-lkp@intel.com>
References: <20251014011351.88032-1-adigollamudi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014011351.88032-1-adigollamudi@gmail.com>

Hi Aditya,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.18-rc1 next-20251013]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Aditya-Gollamudi/include-linux-atomic-fix-typos-in-atomic-arch-fallback-h/20251014-092236
base:   linus/master
patch link:    https://lore.kernel.org/r/20251014011351.88032-1-adigollamudi%40gmail.com
patch subject: [PATCH] include/linux/atomic: fix typos in atomic-arch-fallback.h
config: m68k-allnoconfig (https://download.01.org/0day-ci/archive/20251014/202510141934.WzOkEFX6-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251014/202510141934.WzOkEFX6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510141934.WzOkEFX6-lkp@intel.com/

All errors (new ones prefixed by >>):

>> error: include/linux/atomic/atomic-arch-fallback.h has been modified.
   make[3]: *** [./Kbuild:79: .checked-atomic-arch-fallback.h] Error 1
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1280: prepare0] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:248: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:248: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

