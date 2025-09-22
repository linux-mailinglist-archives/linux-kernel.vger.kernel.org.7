Return-Path: <linux-kernel+bounces-826922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76099B8FA69
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 10:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D63027A18CE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 08:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDAAB283CBE;
	Mon, 22 Sep 2025 08:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OYaGTk7p"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE0C23B616;
	Mon, 22 Sep 2025 08:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758531012; cv=none; b=pKdtfN/psbFFbA7Bz1YNSscBYpo8ed1+lSYx7KmuOxXfiD7MM3Naz+MH7bykz6140ZByklpw6KqQTH6P3gal4JgXtXX5wwl+UEVnVHZRpA9qAjOEAWUMe8p4vQHGvTf+8iU3ZbILl4kxqNcvmsdAKLZh1WS2+tEAh3FfjQ5XHOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758531012; c=relaxed/simple;
	bh=EIwX2Gv25NRIdufRlFKCm9KTmV1tzjcTIKEMfhqFOjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=thsbddKUPSswj9fQXf2BRdoPe+Nxshk6vU0eocKFqgqAllminjMsPIHfUcXQjw54JOOcWCA7L0OcRF45kH1VCqVKF917HdtSueZL61hq9dsv6ZSQRzocNVvMfdAc+d1p+vpEs0+GSn9Ybj6aiUJtR8Dsz8CjxY9uwovWACrZrPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OYaGTk7p; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758531011; x=1790067011;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EIwX2Gv25NRIdufRlFKCm9KTmV1tzjcTIKEMfhqFOjs=;
  b=OYaGTk7p34eIeIWimkMEL6v5bc1DCZLxjP5BP4dcpxppMbvd7IrNSv5t
   PivxNFcd7+BmlYjXFVhfnPyGhRNF1ai7eT2DvV2fEHzfzdbToPEq4g18W
   2v7ATOKSliP+nIdFgZ5sqRgtOcmXvAzw2qC4gkZ3BxbK72NRAQXSqh8Hx
   jtRFs4cjJtTDU54ld2TOBQGNM503mp1lvppCAWTKhGvxHb7HCVRxk4x28
   n2E/j9OH7oY2EoIyhYn9M8ZGM2ICaymtyQzrIJ8GcYYd1td0wIlYSUZSQ
   9fqLtPFRNWDu6DKp6YgIiTaEepZZUwnc72Beua6i/EoYGcFR0P/K8y3IX
   g==;
X-CSE-ConnectionGUID: i3XzaMxfQtKF9DGX7IxKkw==
X-CSE-MsgGUID: 8/I6CdThQ+SmBhweQH/prw==
X-IronPort-AV: E=McAfee;i="6800,10657,11560"; a="48364743"
X-IronPort-AV: E=Sophos;i="6.18,284,1751266800"; 
   d="scan'208";a="48364743"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 01:50:10 -0700
X-CSE-ConnectionGUID: H465Suv1SMms04Tugxlnaw==
X-CSE-MsgGUID: 2epaaLTjT7uCtIJLozB0OQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,284,1751266800"; 
   d="scan'208";a="176033714"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 22 Sep 2025 01:50:03 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v0cFF-0001UX-07;
	Mon, 22 Sep 2025 08:50:01 +0000
Date: Mon, 22 Sep 2025 16:49:18 +0800
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
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v4 1/7] usb: typec: Add default HPD device when register
 DisplayPort altmode
Message-ID: <202509221607.rWZ3wNqm-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on usb/usb-testing]
[also build test ERROR on usb/usb-next usb/usb-linus robh/for-next linus/master v6.17-rc7 next-20250919]
[cannot apply to rockchip/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chaoyi-Chen/usb-typec-Add-default-HPD-device-when-register-DisplayPort-altmode/20250922-092549
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20250922012039.323-2-kernel%40airkyi.com
patch subject: [PATCH v4 1/7] usb: typec: Add default HPD device when register DisplayPort altmode
config: arm-randconfig-001-20250922 (https://download.01.org/0day-ci/archive/20250922/202509221607.rWZ3wNqm-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project cafc064fc7a96b3979a023ddae1da2b499d6c954)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250922/202509221607.rWZ3wNqm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509221607.rWZ3wNqm-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: dp_altmode_hpd_device_register
   >>> referenced by class.c:609 (drivers/usb/typec/class.c:609)
   >>>               drivers/usb/typec/class.o:(typec_register_altmode) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

