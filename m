Return-Path: <linux-kernel+bounces-792212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0912B3C17E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 19:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25CDB1C8044D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 17:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF543375BE;
	Fri, 29 Aug 2025 17:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dHrfNDtn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7450D3314DE
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 17:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756487239; cv=none; b=g0CQfpFBPIrOEi8YHcOzwJI1yyPzeYSqQ91ox2mOlDnkJEXRQgG76Cf+0rj29K0M2dIIFGIHA1Bi9ZObvU12j4DwRibQXKtInzsa5xAkZvxzuFw0mqVOEjMaVRMkayRDd1FJ8Y8eynXR6KfM7dYm38Jje9NvwlV0g9FUcU4zsFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756487239; c=relaxed/simple;
	bh=vvB0XdAmc0HHNfLRI6IcfixnnZHkhX9rORsftyqfEpk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QjmtXXDPjALTlQJsduZqAFKo2hgk2a1Op7g7syCjU0hJJtFs7nH/fXYoi/YQFHxF4lWi+4iQkdVrZZ8KtstN1MZ7OnqmsnTH0LJHF0dcegkQnASwE4noC/BppLcJErJhbf85od8qoenrLbUiHpcVxIZo799FQFHojSPDylwjW0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dHrfNDtn; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756487238; x=1788023238;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vvB0XdAmc0HHNfLRI6IcfixnnZHkhX9rORsftyqfEpk=;
  b=dHrfNDtnS5IO/KnoE4ZmR7BNKt8waGzewOWHEWsb7WreEDQNHpwLeG+A
   CqVMmiPMX0WbM+UKx/0F3qYSdCGFH+3bLWTiHnqsE4VN4Gs31n3DtGjXH
   +3BroL3GPkYFkD/LEf5zU0qU5Gs0gX9H9f6yF0QGB38KFkN7H3AlkHB+V
   gT/IGj8kCh6PSQX60Y7LkYdX+4NxZLmaD9z8smvDBqpXMf1QF6aTPOLkV
   OB+cWvlZjkWZYS8COu7uT+gzLkDHu9zIVO0z2VFISt7vjJVEo66SuF0GX
   slHe/SAC3M4PTkMSnacMhOf5canozODwFvh/8Dn6fPBKt4XGE9xTf6Wgh
   A==;
X-CSE-ConnectionGUID: EruEFRpPTr28pTOMZ6LcsA==
X-CSE-MsgGUID: UvlV4CeITKalKzAg9To0/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11537"; a="57802787"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="57802787"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 10:07:13 -0700
X-CSE-ConnectionGUID: GKgErMDHSHCAXXTyedOfUg==
X-CSE-MsgGUID: N5B9qCaJSXKOHDsZOmmPMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="174794056"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 29 Aug 2025 10:07:11 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1us2ZB-000UnU-1j;
	Fri, 29 Aug 2025 17:07:09 +0000
Date: Sat, 30 Aug 2025 01:06:30 +0800
From: kernel test robot <lkp@intel.com>
To: Caleb James DeLisle <cjd@cjdns.fr>
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: kismet: WARNING: unmet direct dependencies detected for
 SERIAL_OF_PLATFORM when selected by ECONET
Message-ID: <202508300117.hLJEnpOl-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   07d9df80082b8d1f37e05658371b087cb6738770
commit: 35fb26f94dfa1b291086b84b2421f957214824d1 mips: Add EcoNet MIPS platform support
date:   3 months ago
config: mips-kismet-CONFIG_SERIAL_OF_PLATFORM-CONFIG_ECONET-0-0 (https://download.01.org/0day-ci/archive/20250830/202508300117.hLJEnpOl-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20250830/202508300117.hLJEnpOl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508300117.hLJEnpOl-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for SERIAL_OF_PLATFORM when selected by ECONET
   WARNING: unmet direct dependencies detected for SERIAL_OF_PLATFORM
     Depends on [n]: TTY [=n] && HAS_IOMEM [=y] && SERIAL_8250 [=n] && OF [=y]
     Selected by [y]:
     - ECONET [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

