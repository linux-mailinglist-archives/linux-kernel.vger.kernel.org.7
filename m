Return-Path: <linux-kernel+bounces-891806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 65870C438A5
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 05:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 107434E13CC
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 04:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDDB1F12E9;
	Sun,  9 Nov 2025 04:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T37iSCDK"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F8C42AA9;
	Sun,  9 Nov 2025 04:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762664024; cv=none; b=RHRIzoWVao48r2NUP7hmFTo+dCrPebNdTqCXOGzG22+sR+KA/tr9vEBZtorG1O8ijEvCSdB1zM1W06XR9bck7unBQOH0GvPd/QQtyrk0IBK433s1H/7feTFM9my3OpYWR/TO+496nHUhPAsFdYOtYz0j122u7iAePFNCFFcGQns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762664024; c=relaxed/simple;
	bh=T6L7mDfV+M7uBHz72EwdgW2d+D+/M0d9PPUT1B0HJKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OHGAT0TJhiLqIaYEDFMDGCMcDmQv8RW0tOK1PGO9d0m8ogdVyL0qdVK0C2QwSnD0ckF4ylGOpWdFVJMMZSZ8f7TUf3ZZuv87k1+qahkG+Rz/Fh8XMKBPXcvwZMyLwTI5gD2mucTfz7KncpDUCIItkOgit9C5pA+BzTs/c6x5wLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T37iSCDK; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762664021; x=1794200021;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T6L7mDfV+M7uBHz72EwdgW2d+D+/M0d9PPUT1B0HJKw=;
  b=T37iSCDKxaN7u6RwNW4+RqlOqau+WLdG/UPuTtEpMw/3bjV3O4b4FMo2
   agQCzKed1+JAD2s4PUE80lNSkD+wKYcSKLEQGgEcD1DUk47lBgHqECWUZ
   Qp3pCOCA6dI9fwLZ1nMsTHBknzP54QJlsROTfcagpEF0czFN+Q9ouRD7v
   zRBd1f+rnluuMWwO4wJ68sXzCiJDj/XTX2x8l7Hfz8pcGcacCE2Ldx4Q8
   IP157yFdgjj/fWpDO8vJnn0I8EYN5QV+Vi854k3ibrSX1HGSysyekmlf0
   XxULTFblMMNYkhC+Lk/GQ5mDJCIhTN2IyRMiSBjAMARx+xPsBWkVC2aNM
   g==;
X-CSE-ConnectionGUID: jLVN1ziBTFesC8c5qxS49Q==
X-CSE-MsgGUID: 1FGlVVz0Sp2WQirCgaXzvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11607"; a="64847204"
X-IronPort-AV: E=Sophos;i="6.19,291,1754982000"; 
   d="scan'208";a="64847204"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2025 20:53:41 -0800
X-CSE-ConnectionGUID: h5x42WdvTqu1BX/UaJUSBw==
X-CSE-MsgGUID: Tj0BVNGOSm68/3cRdyBYDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,291,1754982000"; 
   d="scan'208";a="188227193"
Received: from lkp-server01.sh.intel.com (HELO 6ef82f2de774) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 08 Nov 2025 20:53:38 -0800
Received: from kbuild by 6ef82f2de774 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vHxQm-0001mV-1n;
	Sun, 09 Nov 2025 04:53:36 +0000
Date: Sun, 9 Nov 2025 12:53:32 +0800
From: kernel test robot <lkp@intel.com>
To: ccc194101@163.com, stern@rowland.harvard.edu,
	gregkh@linuxfoundation.org
Cc: oe-kbuild-all@lists.linux.dev, linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org,
	Chen Changcheng <chenchangcheng@kylinos.cn>
Subject: Re: [PATCH] usb: usb-storage: No additional quirks need to be added
 to the ECD819-SU3 optical drive.
Message-ID: <202511091243.dnLsy9w5-lkp@intel.com>
References: <20251107061046.32339-1-ccc194101@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107061046.32339-1-ccc194101@163.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 284922f4c563aa3a8558a00f2a05722133237fe8]

url:    https://github.com/intel-lab-lkp/linux/commits/ccc194101-163-com/usb-usb-storage-No-additional-quirks-need-to-be-added-to-the-ECD819-SU3-optical-drive/20251107-141330
base:   284922f4c563aa3a8558a00f2a05722133237fe8
patch link:    https://lore.kernel.org/r/20251107061046.32339-1-ccc194101%40163.com
patch subject: [PATCH] usb: usb-storage: No additional quirks need to be added to the ECD819-SU3 optical drive.
config: nios2-randconfig-001-20251109 (https://download.01.org/0day-ci/archive/20251109/202511091243.dnLsy9w5-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251109/202511091243.dnLsy9w5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511091243.dnLsy9w5-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/usb/storage/uas.c:928:24: warning: initialization of 'long unsigned int' from 'void *' makes integer from pointer without a cast [-Wint-conversion]
     928 |         .driver_info = (flags) }
         |                        ^
   drivers/usb/storage/unusual_uas.h:100:1: note: in expansion of macro 'UNUSUAL_DEV'
     100 | UNUSUAL_DEV(0x13fd, 0x3940, 0x0310, 0x0310,
         | ^~~~~~~~~~~
   drivers/usb/storage/uas.c:928:24: note: (near initialization for 'uas_usb_ids[9].driver_info')
     928 |         .driver_info = (flags) }
         |                        ^
   drivers/usb/storage/unusual_uas.h:100:1: note: in expansion of macro 'UNUSUAL_DEV'
     100 | UNUSUAL_DEV(0x13fd, 0x3940, 0x0310, 0x0310,
         | ^~~~~~~~~~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for LEDS_EXPRESSWIRE
   Depends on [n]: GPIOLIB [=n] || NEW_LEDS [=y] && GPIOLIB [=n]
   Selected by [m]:
   - BACKLIGHT_KTD2801 [=m] && HAS_IOMEM [=y] && BACKLIGHT_CLASS_DEVICE [=y]


vim +928 drivers/usb/storage/uas.c

115bb1ffa54c39 Matthew Wilcox 2010-10-07  923  
79b4c06112f12c Hans de Goede  2013-10-25  924  #define UNUSUAL_DEV(id_vendor, id_product, bcdDeviceMin, bcdDeviceMax, \
79b4c06112f12c Hans de Goede  2013-10-25  925  		    vendorName, productName, useProtocol, useTransport, \
79b4c06112f12c Hans de Goede  2013-10-25  926  		    initFunction, flags) \
79b4c06112f12c Hans de Goede  2013-10-25  927  { USB_DEVICE_VER(id_vendor, id_product, bcdDeviceMin, bcdDeviceMax), \
79b4c06112f12c Hans de Goede  2013-10-25 @928  	.driver_info = (flags) }
79b4c06112f12c Hans de Goede  2013-10-25  929  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

