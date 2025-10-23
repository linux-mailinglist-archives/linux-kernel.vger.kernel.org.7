Return-Path: <linux-kernel+bounces-866211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B20BFF2F8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 06:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BC3A3A896B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 04:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472302580D7;
	Thu, 23 Oct 2025 04:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mYrzinEh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2207124DD15
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761195463; cv=none; b=Ihx6m1y/71RoaU8pbbOGGzj0WknmqjKD5ShVhrftTrRbJHOUEOZMpSfUkY/5JFvr9CZ6MeTVGuqcXRR8XUnzEEoCbyO3Lk1itVH04vPDOc7wu8cANzB+JQqfz8JH8ABorv6xncu2zLCs9KRGovBjWEcWlseK3s9eS6OJN8mkK2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761195463; c=relaxed/simple;
	bh=b8s+XvStkCZYMixU470yG8F21dWjKOXoL+3lX+DKyec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=apc2pgbeCkcGUYT/hva+XcDoj2yZTyoFtwbgRdlmdWPmQBoxT0G2vjLIyAVyArAJs5QkgoL62eR6o5CjMtRWSD85ZYGUyi85Y1yfu4oO0DDqLQbQ3n3bIWnP8zR3WAee+qmK0XfsIA818+oM3dCL4hBzA5f1Nutfylwm66lMMOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mYrzinEh; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761195462; x=1792731462;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b8s+XvStkCZYMixU470yG8F21dWjKOXoL+3lX+DKyec=;
  b=mYrzinEhaUg1NYxVQeOlr1/8CEYq7iO8iOlqHmI0rG+ZbLeBxsrzsER4
   1sijG+wHOW18MUHpyOrx5f33YJJ7t5TKt1dJqazvkJBvti9YQNsmXQfHw
   ERasNEYwrDM/1z64RsOYYtWEGS5NLrSlmzoHAGZLzf3e9ARMRJOPFLhfN
   e9wrCxN09Y3UqkGHZWzJjL72mfmCmYy+QtFz/PPvTaoMBswSWyqe1hjWp
   3ZLoBQNwdj28SZsT98qVSMWEgXTHtKkmpw/NF8028A+UnNbavRSe6GFN1
   AUCsM2A05Z32dyZaV2RW8A2ryeD+8sg8X7hyVSqG7JA3hN4BDOgA2TA7H
   Q==;
X-CSE-ConnectionGUID: 9CTlPjp/RcWjqEvRa8dRhg==
X-CSE-MsgGUID: K/HND65jTYuvuaKKCDYrHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="67220032"
X-IronPort-AV: E=Sophos;i="6.19,248,1754982000"; 
   d="scan'208";a="67220032"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 21:57:42 -0700
X-CSE-ConnectionGUID: tmOPapp5QUCBD0gRuJmzeQ==
X-CSE-MsgGUID: W+WPOnYOSc+szDZ7kmgV+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,248,1754982000"; 
   d="scan'208";a="183229950"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 22 Oct 2025 21:57:39 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vBnOD-000D2r-00;
	Thu, 23 Oct 2025 04:57:32 +0000
Date: Thu, 23 Oct 2025 12:57:03 +0800
From: kernel test robot <lkp@intel.com>
To: Ayush Singh <ayush@beagleboard.org>,
	Jason Kridner <jkridner@beagleboard.org>,
	Deepak Khatri <lorforlinux@beagleboard.org>,
	Robert Nelson <robertcnelson@beagleboard.org>,
	Dhruva Gole <d-gole@ti.com>, Viresh Kumar <vireshk@kernel.org>,
	Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: oe-kbuild-all@lists.linux.dev, greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	Ayush Singh <ayush@beagleboard.org>
Subject: Re: [PATCH] staging: greybus: fw-download: Fix find firmware req
Message-ID: <202510231209.JEFfW9s0-lkp@intel.com>
References: <20251022-gb-fw-v1-1-183b18500cd5@beagleboard.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022-gb-fw-v1-1-183b18500cd5@beagleboard.org>

Hi Ayush,

kernel test robot noticed the following build warnings:

[auto build test WARNING on aaa9c3550b60d6259d6ea8b1175ade8d1242444e]

url:    https://github.com/intel-lab-lkp/linux/commits/Ayush-Singh/staging-greybus-fw-download-Fix-find-firmware-req/20251022-153520
base:   aaa9c3550b60d6259d6ea8b1175ade8d1242444e
patch link:    https://lore.kernel.org/r/20251022-gb-fw-v1-1-183b18500cd5%40beagleboard.org
patch subject: [PATCH] staging: greybus: fw-download: Fix find firmware req
config: arm64-randconfig-002-20251023 (https://download.01.org/0day-ci/archive/20251023/202510231209.JEFfW9s0-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251023/202510231209.JEFfW9s0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510231209.JEFfW9s0-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/staging/greybus/fw-download.c:14:
   drivers/staging/greybus/fw-download.c: In function 'gb_fw_download_request_handler':
>> drivers/staging/greybus/firmware.h:14:24: warning: '%s' directive output may be truncated writing up to 9 bytes into a region of size between 6 and 15 [-Wformat-truncation=]
    #define FW_NAME_PREFIX "gmp_"
                           ^~~~~~
   drivers/staging/greybus/fw-download.c:188:5: note: in expansion of macro 'FW_NAME_PREFIX'
        FW_NAME_PREFIX "%08x_%08x_%08x_%08x_%s.%s",
        ^~~~~~~~~~~~~~
   drivers/staging/greybus/fw-download.c:188:44: note: format string is defined here
        FW_NAME_PREFIX "%08x_%08x_%08x_%08x_%s.%s",
                                               ^~
   drivers/staging/greybus/fw-download.c:187:3: note: 'snprintf' output between 42 and 60 bytes into a destination of size 56
      snprintf(fw_req->name, sizeof(fw_req->name),
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        FW_NAME_PREFIX "%08x_%08x_%08x_%08x_%s.%s",
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        intf->ddbl1_manufacturer_id, intf->ddbl1_product_id,
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        intf->vendor_id, intf->product_id, tag, format);
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +14 drivers/staging/greybus/firmware.h

cca222076738962 Viresh Kumar       2016-04-28  13  
350e3ac2ceb6964 Joel Porquet       2016-07-21 @14  #define FW_NAME_PREFIX	"gmp_"
8a704565ebda960 Greg Kroah-Hartman 2016-07-20  15  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

