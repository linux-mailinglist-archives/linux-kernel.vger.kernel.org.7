Return-Path: <linux-kernel+bounces-746822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E299BB12BA1
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 19:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3978189934D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 17:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16451288534;
	Sat, 26 Jul 2025 17:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m4I15Lb2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC08F8635D;
	Sat, 26 Jul 2025 17:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753550471; cv=none; b=RG+YtLgcbojwjfs/1C8Y+km/aTG6Rx/C1qQ+32ixo2hmmLG8bMnHvaNjvxM2Uj0hhQhnejxhpdYf15sqfiUz5bOnTLdJHYusP3j4RXK2JKU/xm81jesPO35tLh2SBFN9kswX2kFOTFIO5AE1MIxoY4PVJMtsBhHNG6/9XksI+40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753550471; c=relaxed/simple;
	bh=FYGrziCeFzNuZvhSRlcgFhj9eG/pzlrsTbVj34x+dbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NpzVHH2ROLkk133O1HMPmmHtfnLCFRE1KyFA14YtIasVZy8oZ4rsX5xA49N/N9P9+3m/P2GsK+lHyIbFZ+CZEFj6oquUn8+1Ueu1nx+gxc3Au1o05YZcn0AxKEcrPKMTIK8GI2pOuW51wgQii72q8BeSZn0ZI7fktepCO+DB508=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m4I15Lb2; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753550469; x=1785086469;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FYGrziCeFzNuZvhSRlcgFhj9eG/pzlrsTbVj34x+dbA=;
  b=m4I15Lb2PzOkGq7Fh6j54jdnv8u2OmYQF7OExDDZHth06Zoz6pXfmr3f
   cuRE3N0gKXoKohnG0HbA0IqWdYwzV7vCcnnCA6unE6elItupnufIwwXn1
   YRiMIID2H5MYWAuebuhXdbH3L//y2cO+EeoWzmk76REAEgeGwq08EVXbK
   q6sxUWysvp0UCfvfnuW6leKzAu9tHYq6cEc52b3divuGtapzOkV/GtwhO
   T/gn7lASCQZlNhkOrxTvhFXOARsLNGlo12WfmTU/M6KwjKEzxPjPbGvUt
   S4YHoU1tcJI+NtlV4dGrV7oV92KLhtHQiHtKd81S9ZG4iYENWRTdVykAB
   Q==;
X-CSE-ConnectionGUID: Y+9QoYeRR52o7jVQA0Su5A==
X-CSE-MsgGUID: eHaUnqpqREetq5HP4qQ1bA==
X-IronPort-AV: E=McAfee;i="6800,10657,11504"; a="55822562"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="55822562"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2025 10:21:08 -0700
X-CSE-ConnectionGUID: aORf0ttfRyS2t+7wKEuHIQ==
X-CSE-MsgGUID: y+Pk7nMORK2wa7WBA7tGig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="167114307"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 26 Jul 2025 10:21:05 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ufiZz-000M9r-1f;
	Sat, 26 Jul 2025 17:21:03 +0000
Date: Sun, 27 Jul 2025 01:21:01 +0800
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
Message-ID: <202507270148.ZrFnYWlb-lkp@intel.com>
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
config: i386-kismet-CONFIG_LEDS_TRIGGERS-CONFIG_IWLEGACY-0-0 (https://download.01.org/0day-ci/archive/20250727/202507270148.ZrFnYWlb-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20250727/202507270148.ZrFnYWlb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507270148.ZrFnYWlb-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for LEDS_TRIGGERS when selected by IWLEGACY
   WARNING: unmet direct dependencies detected for LEDS_CLASS
     Depends on [n]: NEW_LEDS [=n]
     Selected by [y]:
     - AYN_EC [=y] && X86_PLATFORM_DEVICES [=y] && ACPI [=y] && HWMON [=y]
   
   WARNING: unmet direct dependencies detected for LEDS_CLASS_MULTICOLOR
     Depends on [n]: NEW_LEDS [=n] && LEDS_CLASS [=y]
     Selected by [y]:
     - AYN_EC [=y] && X86_PLATFORM_DEVICES [=y] && ACPI [=y] && HWMON [=y]
   
   WARNING: unmet direct dependencies detected for LEDS_TRIGGERS
     Depends on [n]: NEW_LEDS [=n] && LEDS_CLASS [=y]
     Selected by [y]:
     - MAC80211_LEDS [=y] && NET [=y] && WIRELESS [=y] && MAC80211 [=y] && (LEDS_CLASS [=y]=y [=y] || LEDS_CLASS [=y]=MAC80211 [=y])
     - IWLEGACY [=y] && NETDEVICES [=y] && WLAN [=y] && WLAN_VENDOR_INTEL [=y]
     - IWLWIFI_LEDS [=y] && NETDEVICES [=y] && WLAN [=y] && WLAN_VENDOR_INTEL [=y] && IWLWIFI [=y] && (LEDS_CLASS [=y]=y [=y] || LEDS_CLASS [=y]=MAC80211 [=y]) && (IWLMVM [=n] || IWLDVM [=y])

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

