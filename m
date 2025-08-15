Return-Path: <linux-kernel+bounces-770613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6E8B27D22
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 11:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C0DA189751E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D852E1C4C;
	Fri, 15 Aug 2025 09:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V/WypXHC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A658E2D46D3
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 09:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755250034; cv=none; b=uu8Ed1X5zCsl6+OIU0SHsWhiqh6ztfoTXTpSZUOzNLAMsKZfn4rbVpJ+Cq5NOpjH/hunkqQ7EHEBsR/UY3LVSpYuEDNcZn6qK9Z3KPVh3rui/6bAl9JcPk/r2tJ13+j4U3mv6p089hRbrgTVTkdPZIb6pN3q3go+0RdbumlfBAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755250034; c=relaxed/simple;
	bh=RnraM+e4YFUNz/wGOUWNqAtFfY67b2WiV+P96NkbdYI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ljrBCl4E97LQ2eukSUs07oAO9WBxU2fybHpecqX3K2drHbTSP8X8JWvEO9m92JRL+dzaD1YGrHZ+Lt6E+1Y3IrqVrhpbGgi26wXrDqvqiUD3cjSd9bwmhHWjkI80z4zcppU1p/BgzuawgV423hg1DknxzVAJP587dwy+1yd0ZOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V/WypXHC; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755250032; x=1786786032;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RnraM+e4YFUNz/wGOUWNqAtFfY67b2WiV+P96NkbdYI=;
  b=V/WypXHCSCMNERanrySxGbn0TBfHDA17qSb5z032dABCMf8KyOTqDJpl
   4skihJAH2RwACZHJzSy+WXZ5rhQ6Lg66Dj3VjIcj1Ftqhnq8RurMp2W6Z
   f8yWv85FpR80I+Dsh6cJK5IpommM4QOaayYMhN8avK5Cgd3c90PLfGeot
   eRO0fgBYQ1uZVlI51kPjsjpb5h7Q4t4wHEtXRwZLqA/H/dTBt817if0ZS
   hctDM5F436sAHxZsbe61RSqMfznNTPsfjXNYoWC/wltCxRBZmn4t+tksM
   yx6xkK4obFrHwD9kgtdPJmcZD7W6BGtbkGe8zUKk8ilYF6tMHdg6fI5Ez
   w==;
X-CSE-ConnectionGUID: 7fFXgt70SL6wzIBhxyArfg==
X-CSE-MsgGUID: PCyyELMBTF2a5V9wWOPLGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="68175605"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="68175605"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 02:27:12 -0700
X-CSE-ConnectionGUID: CehhmC4SStSu+MG90/gMLg==
X-CSE-MsgGUID: ltWqE78qRJOS5qzmawwsdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="190689512"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 15 Aug 2025 02:27:09 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1umqi9-000Bnv-0p;
	Fri, 15 Aug 2025 09:26:59 +0000
Date: Fri, 15 Aug 2025 17:25:22 +0800
From: kernel test robot <lkp@intel.com>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Luca Weiss <luca.weiss@fairphone.com>
Subject: kismet: WARNING: unmet direct dependencies detected for SM_GCC_6350
 when selected by SM_VIDEOCC_6350
Message-ID: <202508151725.orPsYxfw-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d7ee5bdce7892643409dea7266c34977e651b479
commit: 720b1e8f20047e072b98a0931fc3e9a545fda18f clk: qcom: Add video clock controller driver for SM6350
date:   9 weeks ago
config: arm-kismet-CONFIG_SM_GCC_6350-CONFIG_SM_VIDEOCC_6350-0-0 (https://download.01.org/0day-ci/archive/20250815/202508151725.orPsYxfw-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20250815/202508151725.orPsYxfw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508151725.orPsYxfw-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for SM_GCC_6350 when selected by SM_VIDEOCC_6350
   WARNING: unmet direct dependencies detected for SM_GCC_6350
     Depends on [n]: COMMON_CLK [=y] && COMMON_CLK_QCOM [=y] && (ARM64 || COMPILE_TEST [=n])
     Selected by [y]:
     - SM_VIDEOCC_6350 [=y] && COMMON_CLK [=y] && COMMON_CLK_QCOM [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

