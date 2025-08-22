Return-Path: <linux-kernel+bounces-782773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A45F1B32526
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 00:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47CD2AA777E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 22:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108DD2820A3;
	Fri, 22 Aug 2025 22:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sax/C26M"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120FE22DF9E
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 22:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755902780; cv=none; b=O+zjU9HLPaoE7Xhk59T2Eh26vw7s+vjenyL1CAGjDthzWWY0VeM9smWM/gZUh5pBtuD6UisPQqOi6UMdDgsXO4+pbdZoXG50WDcnC+RdN6jRUl0lJwhrCtukz/wo39pmEI7axnIcrlDL98Uz8ScLKwuic3GcSQB2AQ05A3wv4PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755902780; c=relaxed/simple;
	bh=Jfgdih6T8OIE1+syUGCV/l+GJ/VVIgvQUO8YjspELXk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=olHTVSYdAAgiBYPt2nDiJKIpaA49wLv9TmqwvIWo1M+Q5rSpmEx8tCEh3/C5cSMr4DZVmvEfER6jQQ/q2Mq+jbgsIfQZwz+Mdvm6E3q7rOMcrKBbP32/qF6PvYD2EXCeB2tndZoOvgcF35uTDpLquOdRJe1yQIer6ZJ2rl50/9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sax/C26M; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755902779; x=1787438779;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Jfgdih6T8OIE1+syUGCV/l+GJ/VVIgvQUO8YjspELXk=;
  b=Sax/C26MCH6tHmfiSqotER5QCLdjr/y4+Lo19rS93ogy2RV78GyJMDya
   VGBoJfLHkrD/1XVEbQEt7PFgPqDwGT7XxeM3at54Md3SApqAZoICg+vZb
   wPUc6r1Crx3h0H4mJ+41Q0kAyooJHsknWHu+cpaBL85O9QYqZIk6UqsGQ
   bfy4Yfx2uU0kopWy9gEwwhfD3rPxV3JOwj/DEOabwkWAhRWfvqfDMptfv
   F6zod+fn/+0v+j0/xYztxWEL8T5M/tE72J9IarWfzJw2Ii+ECxCa5Xxqg
   lBeVXCSbX/k0eZVOiHrFaY9IGah5cryapi68Yz8VULOhJoxfaSZVXfbue
   g==;
X-CSE-ConnectionGUID: Ay5QW0/NRb2z/ZTMjtY1uw==
X-CSE-MsgGUID: xDxoIEvITne+KSU6P0ac3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="80813679"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="80813679"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 15:46:19 -0700
X-CSE-ConnectionGUID: x4PZaQ87SZmQ6q14Ofu+Ew==
X-CSE-MsgGUID: ZnkUpLA/RGKKzGJxj8XJtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="173005710"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 22 Aug 2025 15:46:17 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1upaWU-000Ltn-2a;
	Fri, 22 Aug 2025 22:46:14 +0000
Date: Sat, 23 Aug 2025 06:45:16 +0800
From: kernel test robot <lkp@intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Mark Brown <broonie@kernel.org>
Subject: kismet: WARNING: unmet direct dependencies detected for
 SND_SOC_STAC9766 when selected by SND_MPC52xx_SOC_EFIKA
Message-ID: <202508230644.vp7isopr-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   471b25a2fcbb25dccd7c9bece30313f2440a554e
commit: d8dd3f92a6ba11f9046df48765e6f12ad70a3946 ASoC: Fix SND_SOC_ALL_CODECS imply misc fallout
date:   6 years ago
config: powerpc-kismet-CONFIG_SND_SOC_STAC9766-CONFIG_SND_MPC52xx_SOC_EFIKA-0-0 (https://download.01.org/0day-ci/archive/20250823/202508230644.vp7isopr-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20250823/202508230644.vp7isopr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508230644.vp7isopr-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for SND_SOC_STAC9766 when selected by SND_MPC52xx_SOC_EFIKA
   WARNING: unmet direct dependencies detected for SND_SOC_MPC5200_AC97
     Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_POWERPC_SOC [=y] && PPC_MPC52xx [=y] && PPC_BESTCOMM [=n]
     Selected by [y]:
     - SND_MPC52xx_SOC_EFIKA [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_POWERPC_SOC [=y] && PPC_EFIKA [=y]
   
   WARNING: unmet direct dependencies detected for SND_SOC_STAC9766
     Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_AC97_BUS [=n]
     Selected by [y]:
     - SND_MPC52xx_SOC_EFIKA [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_POWERPC_SOC [=y] && PPC_EFIKA [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

