Return-Path: <linux-kernel+bounces-730468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA4DB04502
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 18:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBC7B4A62AE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 16:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D70A25DAFF;
	Mon, 14 Jul 2025 16:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B891QQtA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46774234984;
	Mon, 14 Jul 2025 16:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752509074; cv=none; b=GDCjyetFBdSLhm7oclIiij5xO16MfFKBStyWbfUCQyTdMpspYyMJ3QrpdYnOdQ6M9t99v+A//ZC+54P84fQJLVjZZgnVN0gJbudD5NHB3wN8aMgdXY2xz1DzmGMkQUsAV6AzA6zIYRtAVhTBEgwXCpdfQzKhMwSysy+urPG0NTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752509074; c=relaxed/simple;
	bh=+z7pdLCd9aOU0paR7ZfIkOBpV4ViwruGm1soXm9IVC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TVC7SuVHSzIYfWeUMy7Uf5irMiejcFPVvzWQVKZI2dLtaSU+hc5XMf0ti74fPIGBHONtFBE1flWZrnV1+3rgRta48Q+VzUgH5ZdYbpRbVLuRCePHqGw5XYTT4/AdvYo0S/j0q0/BwaOmlgy+D6Mp/XcdAFIeEVkpnFEWsTm2e3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B891QQtA; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752509073; x=1784045073;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+z7pdLCd9aOU0paR7ZfIkOBpV4ViwruGm1soXm9IVC0=;
  b=B891QQtAlhzkBOqq+r1JCYUxSft5BV8pV4+PUl3dHTyohtCKz5BfcWkB
   yaSdZq6swHzLq8jxWeDhOP0bPNqVRgiSBJeSL1h4y6e4ErhkgCgtYaVy3
   UeJagVVz+smNl2xGVzd8Bjqar31ojMDcvWaPoy1nYb13JAW3Nao7RmgWO
   DiLru4cRLBTuaAD6hbJp1uf+bp46t4uVLAEjlVBBBtvWgIgb+wAp8RvPL
   0hetjhrdwcbxPkocTvjbIA0Z7dMTHjoQGs215uLhKIwbKh0PJ8T+O7kxu
   choaSyBJxZW750cHx26t/KevGVEIn1mcOyA9CSbkN9Vrq+eAE+h+RzZra
   w==;
X-CSE-ConnectionGUID: titNqBdXSkGIGw8tDczRmA==
X-CSE-MsgGUID: eLdehdthS2eGAk33vcP6/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="72284027"
X-IronPort-AV: E=Sophos;i="6.16,311,1744095600"; 
   d="scan'208";a="72284027"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 09:04:32 -0700
X-CSE-ConnectionGUID: Dnk+NbKMSeqZM9tyOQwH9w==
X-CSE-MsgGUID: 6aZPoxEmS+meo/K8kO/ycw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,311,1744095600"; 
   d="scan'208";a="156768758"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 14 Jul 2025 09:04:28 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ubLfF-000959-37;
	Mon, 14 Jul 2025 16:04:25 +0000
Date: Tue, 15 Jul 2025 00:04:22 +0800
From: kernel test robot <lkp@intel.com>
To: Kurt Borja <kuurtb@gmail.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Joshua Grisham <josh@joshuagrisham.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Armin Wolf <W_Armin@gmx.de>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Hans de Goede <hansg@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Alok Tiwari <alok.a.tiwari@oracle.com>,
	Antheas Kapenekakis <lkml@antheas.dev>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Prasanth Ksr <prasanth.ksr@dell.com>,
	Jorge Lopez <jorge.lopez2@hp.com>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dell.Client.Kernel@dell.com, Kurt Borja <kuurtb@gmail.com>
Subject: Re: [PATCH v6 3/6] platform/x86: firmware_attributes_class: Move
 header to include directory
Message-ID: <202507142344.HcDxuqCC-lkp@intel.com>
References: <20250710-fw-attrs-api-v6-3-9959ef759771@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710-fw-attrs-api-v6-3-9959ef759771@gmail.com>

Hi Kurt,

kernel test robot noticed the following build errors:

[auto build test ERROR on 428f6f3a56ac85f37a07a3fe5149b593185d5c4c]

url:    https://github.com/intel-lab-lkp/linux/commits/Kurt-Borja/platform-x86-firmware_attributes_class-Add-device-initialization-methods/20250710-110641
base:   428f6f3a56ac85f37a07a3fe5149b593185d5c4c
patch link:    https://lore.kernel.org/r/20250710-fw-attrs-api-v6-3-9959ef759771%40gmail.com
patch subject: [PATCH v6 3/6] platform/x86: firmware_attributes_class: Move header to include directory
config: i386-randconfig-002-20250714 (https://download.01.org/0day-ci/archive/20250714/202507142344.HcDxuqCC-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250714/202507142344.HcDxuqCC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507142344.HcDxuqCC-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/platform/x86/lenovo/wmi-other.c:42:10: fatal error: ../firmware_attributes_class.h: No such file or directory
      42 | #include "../firmware_attributes_class.h"
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.


vim +42 drivers/platform/x86/lenovo/wmi-other.c

edc4b183b794ba Derek J. Clark 2025-07-01  36  
edc4b183b794ba Derek J. Clark 2025-07-01  37  #include "wmi-capdata01.h"
edc4b183b794ba Derek J. Clark 2025-07-01  38  #include "wmi-events.h"
edc4b183b794ba Derek J. Clark 2025-07-01  39  #include "wmi-gamezone.h"
edc4b183b794ba Derek J. Clark 2025-07-01  40  #include "wmi-helpers.h"
edc4b183b794ba Derek J. Clark 2025-07-01  41  #include "wmi-other.h"
edc4b183b794ba Derek J. Clark 2025-07-01 @42  #include "../firmware_attributes_class.h"
edc4b183b794ba Derek J. Clark 2025-07-01  43  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

