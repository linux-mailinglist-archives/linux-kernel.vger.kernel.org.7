Return-Path: <linux-kernel+bounces-758753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8E4B1D37A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 09:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5AB93B0E59
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 07:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D05220D4F9;
	Thu,  7 Aug 2025 07:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GtK/px3t"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDA91A8F97
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 07:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754552378; cv=none; b=T8i5/KpVmbeoZudLkJDb3VYA0EpARz3Lpzov1jeKiZ7t4SDA1b4vO1z9lMTNTTzC8qPkBsKt532F9ZYnZu+OyvPo0yP8HAz8vqSUMnEw1HXsIAN8vDulAlqpGLTufVLv6oFwQQoVxOgMzeSHVaJ/QnImu4EZHFj31AcOfSshSV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754552378; c=relaxed/simple;
	bh=CVW6dhHGoaX37jD4MwW6k2ibzzrwhaNAGUotggSnULE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZ3uMttWGzqfiPNi2LsHsOptxjGM1C1HM/gDzHmIVAgu6eYKZQJQOVkk/LLVWCNAbUi0IZKoeozDYJqYxQbrIWltBvLOBMfm0vLwG5CvWSMW9m1Ilen8+Ks+CesZC4CWnJJ8EC5ZfNGh9NeW9ngIJ3SMAyXsGlemEFHViO0iSok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GtK/px3t; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754552378; x=1786088378;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CVW6dhHGoaX37jD4MwW6k2ibzzrwhaNAGUotggSnULE=;
  b=GtK/px3th+femJptGVyyAXpUlu+qCxU4/xmPGme6W6xBY5kqpA+RsWkB
   GbqlG1iDt5NhkWNskec0l3FFdbcLkffW8ai8jlzgVvpxzcxyhsR3cFDhc
   /rbD+YfOuZOiGOoIgPtqsalcZsWn8rHIMZo6SD+JOs4deoVRvfY5OR74h
   EkgTHWs5Z6b/ThTlcHyx7GiTNbcMSS2aau/VLulJOAtgLPVoZ/RiOI04r
   8IoeUgAQy8+fvOazna1/1SEkCcBVxExNbEOTOXObwSOKqZWQrZDA8rSDV
   rW1yKBDU36N9N6Y/omQ5fDMJ6BEI3A7qx5TlYXWDJjwH3bASSuXi4F5bR
   Q==;
X-CSE-ConnectionGUID: T1F1tfHaS329g4+VJKxO2g==
X-CSE-MsgGUID: nEeMin3qTkW52WtlHIbuVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="56843504"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="56843504"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 00:39:37 -0700
X-CSE-ConnectionGUID: ke5D6zy4RFSRq1Cft0ciRg==
X-CSE-MsgGUID: I6QIuU94RwinFZepWPMwkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="195826329"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 07 Aug 2025 00:39:35 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ujvDN-0002Wc-03;
	Thu, 07 Aug 2025 07:39:16 +0000
Date: Thu, 7 Aug 2025 15:37:35 +0800
From: kernel test robot <lkp@intel.com>
To: Wake Liu <wakel@google.com>, Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	wakel@google.com
Subject: Re: [PATCH] vdso: Define NSEC_PER_SEC as 64-bit to prevent overflow
Message-ID: <202508071518.qaTdbvoM-lkp@intel.com>
References: <20250805162153.952693-1-wakel@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805162153.952693-1-wakel@google.com>

Hi Wake,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/timers/vdso]
[also build test ERROR on linus/master v6.16 next-20250806]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wake-Liu/vdso-Define-NSEC_PER_SEC-as-64-bit-to-prevent-overflow/20250806-125650
base:   tip/timers/vdso
patch link:    https://lore.kernel.org/r/20250805162153.952693-1-wakel%40google.com
patch subject: [PATCH] vdso: Define NSEC_PER_SEC as 64-bit to prevent overflow
config: m68k-randconfig-r064-20250807 (https://download.01.org/0day-ci/archive/20250807/202508071518.qaTdbvoM-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 9.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250807/202508071518.qaTdbvoM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508071518.qaTdbvoM-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "__udivdi3" [drivers/leds/leds-sun50i-a100.ko] undefined!
>> ERROR: modpost: "__divdi3" [drivers/leds/leds-sun50i-a100.ko] undefined!
>> ERROR: modpost: "__divdi3" [drivers/clk/qcom/clk-spmi-pmic-div.ko] undefined!
>> ERROR: modpost: "__udivdi3" [drivers/tty/serial/8250/8250_bcm7271.ko] undefined!
>> ERROR: modpost: "__divdi3" [drivers/tty/serial/8250/8250_bcm7271.ko] undefined!
>> ERROR: modpost: "__udivdi3" [drivers/spi/spi-axi-spi-engine.ko] undefined!
>> ERROR: modpost: "__divdi3" [drivers/spi/spi-axi-spi-engine.ko] undefined!
>> ERROR: modpost: "__divdi3" [drivers/spi/spi-dw.ko] undefined!
>> ERROR: modpost: "__udivdi3" [drivers/spi/spi-dw.ko] undefined!
>> ERROR: modpost: "__udivdi3" [drivers/input/touchscreen/ads7846.ko] undefined!
WARNING: modpost: suppressed 3 unresolved symbol warnings because there were too many)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

