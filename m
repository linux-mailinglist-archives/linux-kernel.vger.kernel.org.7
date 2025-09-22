Return-Path: <linux-kernel+bounces-826799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B635DB8F5F2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 09:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C92DD18863E6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 07:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477372F83A2;
	Mon, 22 Sep 2025 07:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TjgRs4rm"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F152EE268;
	Mon, 22 Sep 2025 07:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758527853; cv=none; b=NBgrvqIrIUVtOlhXo1+u2TCEPMVuhWCmhLmvU3cHFpOg8TYsZLr4FXua8oRwS7Viy0iBVQB/GPoeotbP6mB+k2mNRMTozdzWnKgmlvGHw+JLmcXju0BmY3MMUKcykZ0V/xn+fRhA7gwd1y763doDQ0n8cN+Oadv7nno4Qn7kFNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758527853; c=relaxed/simple;
	bh=8yVDHTkeERDKqGU8/+5de0a01zz7l/9JjTsXpfwJEqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lGZq0r6MZwc+DnOgKwP8SFu77JgdrngjkQ7vMq67vrYnCHrnk2sohbeAGT0t+v49l68z1SxTKu6eTNd31CbWfSuMRHJRKxvSLXruhDTeEBONgxGAykEJXE+UVyKChcvj23RE8TcSgBqkVmU/NCm4jHhk4VCssGqNSi5oa+sGB6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TjgRs4rm; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758527852; x=1790063852;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8yVDHTkeERDKqGU8/+5de0a01zz7l/9JjTsXpfwJEqU=;
  b=TjgRs4rmwW5v0yZCOlqNcAg96oG0h+dKEFCADumPcty2zoLHrdeo6sKT
   WuserhXt7PZcBUf5EaAxVgofXYDrJR/rph1rQ5kgjUGHSvZiijmeMIYcj
   CglOwfekxfEwvG9kGFZQChV4afgRy1IxhhhyoMAsYvmahfk1SBfoUMDI3
   lS/R+WfsfdpsqlSmPF/0Qe3ILqgDOP4IERldduL7Bcq8aHd8pQkM799uy
   nQOITsAM6VJE8OQoaHSu8GcoLxGpad4v9ZdZD3EL3mVEC0wd1gKPAt1mp
   2rUaKk1vQnscjhtKcrI4lM7uS/8XCd06xDrRa5RwCv7ZlHtpZkOaSTpHo
   g==;
X-CSE-ConnectionGUID: ctd+v4wfT4CNyOdT4fbQyg==
X-CSE-MsgGUID: 1CHTgxUUSuyxc6eyAcl1AA==
X-IronPort-AV: E=McAfee;i="6800,10657,11560"; a="60901903"
X-IronPort-AV: E=Sophos;i="6.18,284,1751266800"; 
   d="scan'208";a="60901903"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 00:57:31 -0700
X-CSE-ConnectionGUID: A37dvFYzS3yKNurn/d60PA==
X-CSE-MsgGUID: JVijE6a3RaepPTic1nShNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,284,1751266800"; 
   d="scan'208";a="180675538"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 22 Sep 2025 00:57:24 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v0bQH-0001R3-1T;
	Mon, 22 Sep 2025 07:57:21 +0000
Date: Mon, 22 Sep 2025 15:56:35 +0800
From: kernel test robot <lkp@intel.com>
To: Chaoyi Chen <kernel@airkyi.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Yubing Zhang <yubing.zhang@rock-chips.com>,
	Frank Wang <frank.wang@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Amit Sunil Dhamne <amitsd@google.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Chaoyi Chen <chaoyi.chen@rock-chips.com>,
	Dragan Simic <dsimic@manjaro.org>, Johan Jonker <jbx6244@gmail.com>,
	Diederik de Haas <didi.debian@cknow.org>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Peter Robinson <pbrobinson@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v4 1/7] usb: typec: Add default HPD device when register
 DisplayPort altmode
Message-ID: <202509221516.1umvcXG6-lkp@intel.com>
References: <20250922012039.323-2-kernel@airkyi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922012039.323-2-kernel@airkyi.com>

Hi Chaoyi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on usb/usb-testing]
[also build test WARNING on usb/usb-next usb/usb-linus robh/for-next linus/master v6.17-rc7 next-20250919]
[cannot apply to rockchip/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chaoyi-Chen/usb-typec-Add-default-HPD-device-when-register-DisplayPort-altmode/20250922-092549
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20250922012039.323-2-kernel%40airkyi.com
patch subject: [PATCH v4 1/7] usb: typec: Add default HPD device when register DisplayPort altmode
config: i386-buildonly-randconfig-003-20250922 (https://download.01.org/0day-ci/archive/20250922/202509221516.1umvcXG6-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250922/202509221516.1umvcXG6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509221516.1umvcXG6-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/usb/typec/class.c:18:
>> drivers/usb/typec/altmodes/displayport.h:7:5: warning: no previous prototype for 'dp_altmode_probe' [-Wmissing-prototypes]
       7 | int dp_altmode_probe(struct typec_altmode *alt) { return -ENOTSUPP; }
         |     ^~~~~~~~~~~~~~~~
>> drivers/usb/typec/altmodes/displayport.h:8:6: warning: no previous prototype for 'dp_altmode_remove' [-Wmissing-prototypes]
       8 | void dp_altmode_remove(struct typec_altmode *alt) { }
         |      ^~~~~~~~~~~~~~~~~
>> drivers/usb/typec/altmodes/displayport.h:9:6: warning: no previous prototype for 'dp_altmode_hpd_device_register' [-Wmissing-prototypes]
       9 | void dp_altmode_hpd_device_register(struct typec_altmode *alt) { }
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/dp_altmode_probe +7 drivers/usb/typec/altmodes/displayport.h

d266e96820cc36 Ajay Gupta  2019-04-23 @7  int dp_altmode_probe(struct typec_altmode *alt) { return -ENOTSUPP; }
d266e96820cc36 Ajay Gupta  2019-04-23 @8  void dp_altmode_remove(struct typec_altmode *alt) { }
50d2edccce6bf3 Chaoyi Chen 2025-09-22 @9  void dp_altmode_hpd_device_register(struct typec_altmode *alt) { }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

