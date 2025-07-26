Return-Path: <linux-kernel+bounces-746711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6586B12A4A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 13:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 500B64E5638
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 11:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAB7243946;
	Sat, 26 Jul 2025 11:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kBZhEtxS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5969233722;
	Sat, 26 Jul 2025 11:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753530280; cv=none; b=Uh58uJOvyvc+6G8o2eCsLIO+WRvytZyvCMdj88Y59yMJ/+2i6nRsMsWDCD8oXE4f3vbBAEhGY/02mRj4FljRGfscwCvBGp5uNRA7RVkNWJTFHIJ54ehOdK6w+ghZkFiL0aWoYt+TZuNVgH6otUBHIa5U6PXcgnXXLUHE2389CNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753530280; c=relaxed/simple;
	bh=uyQ3hvel8FiTzLIIOnoyXPtaBzDUCYEs67gUItksXts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hf5Qa0HfGoj0Y7i+BYCSF2fYQUdkNu6GRYk0lAgUUsnfVe2EWkoZ0PjQ4YV8hP2B0igtOVN6PmoOv+yOYAW+BBAirgQzZlOsNlkfkRt4NyVtQr6BikAKrzMZhlfl6nBprbezWUJb8OZ61Vp3Dxzd94ybhuprKK6D+QFjBZyfPro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kBZhEtxS; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753530279; x=1785066279;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uyQ3hvel8FiTzLIIOnoyXPtaBzDUCYEs67gUItksXts=;
  b=kBZhEtxSkMRfXaAH+T1el1OOdiud3Weam1imflrU7K5Z0poPWuCY9GU0
   3UpOWOT+663zQv+H6IKzJLh3LHxXsidbudqS2yaNVrWJf1V/9P9EZA2Ej
   T5iCHJLkP1QpM82vmDxXMEAzfhNrH2rB24fAtRRJ07USBdaoJAtf5uRX1
   a3/PS5MYebTNz0PigjBevMq15yNEpKbSYm5UgMtbkxK0YQ0xsGJB8BVlG
   uV1/d1Ym3zqhMEQTNQ7xVjeraX2sYRfpCf2m32PQjUrDA++syC0iPMXrh
   +nUbQfGmZ3pzSKexTcYsjh0MLBzD1LtDKdloJtWgV4sOAoiSm2aBLM5yN
   w==;
X-CSE-ConnectionGUID: vdB8sn9ZSuGUqA+g4CgAkg==
X-CSE-MsgGUID: C6PnVaASQx+Y3UL3IptYxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11503"; a="78399363"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="78399363"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2025 04:44:38 -0700
X-CSE-ConnectionGUID: ZRS6btumTZONS6dS3GNfJQ==
X-CSE-MsgGUID: tO90XUDlTnipKFCUTloRGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="161854318"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 26 Jul 2025 04:44:35 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ufdKK-000LwN-1g;
	Sat, 26 Jul 2025 11:44:32 +0000
Date: Sat, 26 Jul 2025 19:43:57 +0800
From: kernel test robot <lkp@intel.com>
To: "Derek J. Clark" <derekjohn.clark@gmail.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hansg@kernel.org>
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev, Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 1/4] platform/x86: (ayn-ec) Add PWM Fan HWMON Interface
Message-ID: <202507261959.HASYxpK8-lkp@intel.com>
References: <20250725004533.63537-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725004533.63537-1-derekjohn.clark@gmail.com>

Hi Derek,

kernel test robot noticed the following build warnings:

[auto build test WARNING on groeck-staging/hwmon-next]
[also build test WARNING on linus/master v6.16-rc7 next-20250725]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Derek-J-Clark/platform-x86-ayn-ec-Add-Temperature-Sensors/20250725-084850
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
patch link:    https://lore.kernel.org/r/20250725004533.63537-1-derekjohn.clark%40gmail.com
patch subject: [PATCH 1/4] platform/x86: (ayn-ec) Add PWM Fan HWMON Interface
config: i386-kismet-CONFIG_LEDS_CLASS-CONFIG_AYN_EC-0-0 (https://download.01.org/0day-ci/archive/20250726/202507261959.HASYxpK8-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20250726/202507261959.HASYxpK8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507261959.HASYxpK8-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for LEDS_CLASS when selected by AYN_EC
   WARNING: unmet direct dependencies detected for LEDS_CLASS
     Depends on [n]: NEW_LEDS [=n]
     Selected by [y]:
     - AYN_EC [=y] && X86_PLATFORM_DEVICES [=y] && ACPI [=y] && HWMON [=y]
   
   WARNING: unmet direct dependencies detected for LEDS_CLASS_MULTICOLOR
     Depends on [n]: NEW_LEDS [=n] && LEDS_CLASS [=y]
     Selected by [y]:
     - AYN_EC [=y] && X86_PLATFORM_DEVICES [=y] && ACPI [=y] && HWMON [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

