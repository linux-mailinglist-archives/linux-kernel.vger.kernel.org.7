Return-Path: <linux-kernel+bounces-746742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B255B12AB3
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 15:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B6DB1C2521D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 13:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183572673A9;
	Sat, 26 Jul 2025 13:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YiWJHegF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EF7253B59;
	Sat, 26 Jul 2025 13:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753536047; cv=none; b=N0gGBW0ZEIm7WxMdP/W9i7QhOBEjUUgDeo3EmFgEP433SniPqNHwDz733waA6UB3DMfJE09yG54IgXQQQW7dCSsRMU3Si+SG+kEs6P9DPJP7AKPfcG8jcpsmvbVg8Jf0XBl8L2L7yeo7pRoyblWHQ6KiWN8xVFKGUlcZv4qSMiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753536047; c=relaxed/simple;
	bh=GmThC21ppdrdoIWw0WEasNW6C6BBEaR5rJkmV3cn50A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ufrhmm0iMkyoV6QYk7TLPQy/SfMNgzlUoSndXH+3acn8QryI4OD5Lqkfsh6o3vXfZJB5CxJylNoF9cYpiEBQX+gunB7gR4WJT8RRJ6IXBvZS/8+V15SZbOfvSPiAEtYtunsIliuOeYouvj9BkWXG1fsgIICHKPWAVFrFhb1HacI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YiWJHegF; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753536046; x=1785072046;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GmThC21ppdrdoIWw0WEasNW6C6BBEaR5rJkmV3cn50A=;
  b=YiWJHegFb2XmvH4kA8J7QpCWYbzrrtm9/Is8RAg0R9h9vnKue4OZVryf
   X4AC9zNRQSzgpUfKjmgjQtMKjxDJLJDCcBJycK+C1I0Q96kKyTt6KtYVM
   ontrtRFInPWGvlebBMEPGCgpOZIWYIganhSY5Yat6T/axIQUZ3i1oHgB5
   YJXaaAP8In6eZrgoWrn+m/ns8L9F7D4k2SLl/L1cnirSNPPlRFt0bFd5E
   35hF4w4x+kEidQbrNTITyRu4Zd/5SowiaoMvTPRuGJ9funKQy1YLKAjZq
   rArAlawEO8Mw3f52e2djJoR4a9BJJI14Mr6YP3xoW4ZXeqcIFOLqBNe1s
   w==;
X-CSE-ConnectionGUID: pdEsYijdQsaViLnouBFSvQ==
X-CSE-MsgGUID: a7KzUPpqQbOVXDkRMU4FOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11503"; a="55788356"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="55788356"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2025 06:20:45 -0700
X-CSE-ConnectionGUID: AE3f24nhQQqUNEZVbWtQgQ==
X-CSE-MsgGUID: 8LdDo6X8RUKxSGcYkMWLJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="192469065"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 26 Jul 2025 06:20:43 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ufepM-000Lzr-2w;
	Sat, 26 Jul 2025 13:20:40 +0000
Date: Sat, 26 Jul 2025 21:20:24 +0800
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
Message-ID: <202507262131.od1xuoCj-lkp@intel.com>
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
config: i386-kismet-CONFIG_LEDS_CLASS_MULTICOLOR-CONFIG_AYN_EC-0-0 (https://download.01.org/0day-ci/archive/20250726/202507262131.od1xuoCj-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20250726/202507262131.od1xuoCj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507262131.od1xuoCj-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for LEDS_CLASS_MULTICOLOR when selected by AYN_EC
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
     - BT_LEDS [=y] && NET [=y] && BT [=y] && LEDS_CLASS [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

