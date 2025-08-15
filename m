Return-Path: <linux-kernel+bounces-771457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4B9B28784
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 23:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1F45AE1474
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 21:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98EB23C4EA;
	Fri, 15 Aug 2025 21:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jskxi09S"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FABD1A2C06
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 21:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755292011; cv=none; b=YfA5bLnln8lB9ZiEn7zHjIWGErX14DsQnyIyRoHF7FMT7y4JbEOtsiSjdA5PDDdC/bczgzdUUde92HX5sDM6ivBYSiSzod9STAtZ40uzFHyANwxi22LONPjvpB9zVcLOtPy0byy1gU/+P3Zi23WI9QfSOSZsSkfpWgLpKjB+Y7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755292011; c=relaxed/simple;
	bh=WqPBWhuU/tBcTzErmqvKOG8XsKcPwWCji6qB98coAsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J921l59bP/y4ACHIWKac/25813AxEDzFZqYRtV/mum5YdvIGl6NNbXHJvIQem2FQVvw4jNuZQR2A55sUKWIYm7La4Cq5DzdDQWUpMftK3SL/rppX8eot+31CXi419VE6BnqGaeygSpv2+ArEDegM36Z+i4iDaM0VKsODSl2sOYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jskxi09S; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755292008; x=1786828008;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WqPBWhuU/tBcTzErmqvKOG8XsKcPwWCji6qB98coAsM=;
  b=Jskxi09SwJc5GIbMuJuFq+WE7TlRKBg+nnWwVmFKjEJwYe1FbWGOkRm+
   g9/6o+zv4S6KTQh5f6OUhT3owt2qxS3riTtLEVeJk9J6lrcNOtLPbfrcP
   69mZddZlxAg3KCSl9BSJ7H66xcXBvI0sZnVsTV7OQaViI5rm0y8mRY7Vb
   YciyNE2jfv/T0IXqaM36RoDchK0vxTk3sdgOHj7mP9ZFmlVOvYmlH0pEZ
   /ldTdIF6/yfBPhqWG6SHzdbkjMj8srCfVi3T4WmFjjlna7cHvnoLxeVJi
   FvhuGp1OPG57AABftPL00nOnC9vX6yJVVLXmjgk1V4rpBLBbjdfQOMbjB
   g==;
X-CSE-ConnectionGUID: Oy6Lw8TpRk+VatDO8ySnhA==
X-CSE-MsgGUID: 5FIXzRXlQvyQeunMwpzAIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11523"; a="80194091"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="80194091"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 14:06:48 -0700
X-CSE-ConnectionGUID: Z/CfkqUrR66CbZADLtXfyA==
X-CSE-MsgGUID: 7Q/mgfKgSfqjKuU99B0/3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="190811519"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 15 Aug 2025 14:06:46 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1un1dL-000CLM-2H;
	Fri, 15 Aug 2025 21:06:43 +0000
Date: Sat, 16 Aug 2025 05:06:27 +0800
From: kernel test robot <lkp@intel.com>
To: Tzung-Bi Shih <tzungbi@kernel.org>, bleung@chromium.org
Cc: oe-kbuild-all@lists.linux.dev, tzungbi@kernel.org, dawidn@google.com,
	chrome-platform@lists.linux.dev, akpm@linux-foundation.org,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] platform/chrome: cros_ec_chardev: Consume
 cros_ec_device via ref_proxy
Message-ID: <202508160456.eajfX7vH-lkp@intel.com>
References: <20250814091020.1302888-4-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814091020.1302888-4-tzungbi@kernel.org>

Hi Tzung-Bi,

kernel test robot noticed the following build errors:

[auto build test ERROR on chrome-platform/for-next]
[also build test ERROR on next-20250815]
[cannot apply to chrome-platform/for-firmware-next akpm-mm/mm-nonmm-unstable akpm-mm/mm-everything linus/master v6.17-rc1]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tzung-Bi-Shih/lib-Add-ref_proxy-module/20250814-172126
base:   https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git for-next
patch link:    https://lore.kernel.org/r/20250814091020.1302888-4-tzungbi%40kernel.org
patch subject: [PATCH 3/3] platform/chrome: cros_ec_chardev: Consume cros_ec_device via ref_proxy
config: hexagon-randconfig-r072-20250815 (https://download.01.org/0day-ci/archive/20250816/202508160456.eajfX7vH-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 93d24b6b7b148c47a2fa228a4ef31524fa1d9f3f)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250816/202508160456.eajfX7vH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508160456.eajfX7vH-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "ref_proxy_get" [drivers/platform/chrome/cros_ec_chardev.ko] undefined!
>> ERROR: modpost: "ref_proxy_put" [drivers/platform/chrome/cros_ec_chardev.ko] undefined!
>> ERROR: modpost: "ref_proxy_alloc" [drivers/platform/chrome/cros_ec_chardev.ko] undefined!
>> ERROR: modpost: "ref_proxy_free" [drivers/platform/chrome/cros_ec_chardev.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

