Return-Path: <linux-kernel+bounces-782909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B59B326B5
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 05:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02F491B6868E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 03:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D0B1CBEB9;
	Sat, 23 Aug 2025 03:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z54Yyu2C"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A63446B5
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 03:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755920844; cv=none; b=iTRPo6v4XWX5r1nfEJ6uDaZXeTTS1cmAjPY5zAbcbNgZebUwmKWqLMf/slZ96FlTdZ05g5YcXjgslgtp0JVUtpQe9f7DDiHyGsE4LKcNRLqpdtqJVLchtcC+QjC7GPZT+HefJAf/gKPV6vF5nJvNTSSKE1z9yDAUXNvthlK8irs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755920844; c=relaxed/simple;
	bh=0nyhD8ODgHUuuwUd8vt/pjP54jo3/9XkG4PLtD+l3Dw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SIJc18L59mJyJ5CnO9c7Rjk2QHaFrVGBepn0kNx+ZRTgm3ni+uQh/QN3zEdmDc3ZEydL0feAIbtaiDBnsIthXgTSwZCIfb6df4OFxbHBe8StHCMDhvwiBWEjkXp2x275FdnSYdPtwKW5rgIK44CNrK35hmVWlq8y0ceRqz6pAkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z54Yyu2C; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755920842; x=1787456842;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0nyhD8ODgHUuuwUd8vt/pjP54jo3/9XkG4PLtD+l3Dw=;
  b=Z54Yyu2CAJNLZ2PIU3KXfGhz6vHcZ8j3a7RMvyN/4wV18TrBIpFT6nOL
   82VLUuU678QdWXdH1Aa51XW+g4D2zdtSGYz0MX4Z9Bi5jYCIbEFE+7VJq
   7nmX5akC29V3SPiNbYXHU5IV5koUswqDecoiUim3/3YeWeLqtOeN4S8QW
   zDCZCiu1Nzvz8bCPNaCdtRSFMfPP5TGsE+q7WLHAWNBycwB/yidFhC/jI
   6u0z173CG/7SOFRhdsTxoDrwnIhhzbPaWI5nhroYVMDpSiYIj/wZOAVI+
   evNlHfuxWXLt1sKqRVMOgOfUyaXVb6/bk0dThrxww/Q3GtUJciFDNMxWQ
   g==;
X-CSE-ConnectionGUID: z1Lm4wevToS+TeoMdiGB0g==
X-CSE-MsgGUID: mssIbnLVRjqXsSXM6b94BA==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="62057511"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62057511"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 20:47:22 -0700
X-CSE-ConnectionGUID: iSesEWHbSKGS4dMOd7EYww==
X-CSE-MsgGUID: 509+ki/1QTWfXQdPung9wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="169208577"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 22 Aug 2025 20:47:20 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1upfDN-000M3y-1O;
	Sat, 23 Aug 2025 03:47:01 +0000
Date: Sat, 23 Aug 2025 11:45:01 +0800
From: kernel test robot <lkp@intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Mark Brown <broonie@kernel.org>
Subject: kismet: WARNING: unmet direct dependencies detected for
 SND_SOC_WM9712 when selected by SND_MPC52xx_SOC_PCM030
Message-ID: <202508231140.J9SEP853-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6debb69041724bae8a8a4d0ac60502754c1cd945
commit: 5a309875787db47d69610e45f00a727ef9e62aa0 ASoC: Fix SND_SOC_ALL_CODECS imply ac97 fallout
date:   6 years ago
config: powerpc-kismet-CONFIG_SND_SOC_WM9712-CONFIG_SND_MPC52xx_SOC_PCM030-0-0 (https://download.01.org/0day-ci/archive/20250823/202508231140.J9SEP853-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20250823/202508231140.J9SEP853-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508231140.J9SEP853-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for SND_SOC_WM9712 when selected by SND_MPC52xx_SOC_PCM030
   WARNING: unmet direct dependencies detected for SND_SOC_MPC5200_AC97
     Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_POWERPC_SOC [=y] && PPC_MPC52xx [=y] && PPC_BESTCOMM [=n]
     Selected by [y]:
     - SND_MPC52xx_SOC_PCM030 [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_POWERPC_SOC [=y] && PPC_MPC5200_SIMPLE [=y]
   
   WARNING: unmet direct dependencies detected for SND_SOC_WM9712
     Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_AC97_BUS [=n]
     Selected by [y]:
     - SND_MPC52xx_SOC_PCM030 [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_POWERPC_SOC [=y] && PPC_MPC5200_SIMPLE [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

