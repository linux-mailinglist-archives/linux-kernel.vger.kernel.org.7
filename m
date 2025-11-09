Return-Path: <linux-kernel+bounces-891808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C1FC438B5
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 06:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A6DE188C81E
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 05:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9204D2135AD;
	Sun,  9 Nov 2025 05:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CjKFxYr8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0B919CD1D;
	Sun,  9 Nov 2025 05:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762664744; cv=none; b=prvo6TlpPr4W6v6yPVBji6E6HoAsjqhf0VeSpN8YccAOZmZzWCvEaH61IaXd6n4pWhDXIzBhIyem/zKuOPb4ureTsE5hqfzJI6+9g8G6Y302/qphszDkpQ8AhRNQd9dXhcJ+0kW7GmftxyH+U9pJzOSJOLoPEWPA4AYnEcR/b+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762664744; c=relaxed/simple;
	bh=ZV9BoH74mReBv49JBFNCwYi5BkQK+mmMZsBxMTs1p+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aNWVcY0zyHtL+rPZF2bb8rj3tT3h2bP9O4iuRLB3yNOOP5PNQkBAsk9IrjCC7L44Y6J7lAEr7y2l7DZkO6uWX2WXhzH1EQc6I+ZqNNMlbOeCFuRhKZJStIwwdHkK2ePpssL7LB9docDusSxI/YW/w8UxTc0kHT/006x5z9qGlP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CjKFxYr8; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762664742; x=1794200742;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZV9BoH74mReBv49JBFNCwYi5BkQK+mmMZsBxMTs1p+g=;
  b=CjKFxYr8CB9g7/qr/4FmWGeLYJf3CSRgpkSkViytriuIBEM6iJpkc3Fh
   6TnXZMMMzpdwnIH6YDHm9wgY1iN234jJbXNGD3R+KgYS9l0tEL+0zx7UV
   TwiyLRJ0tnYGCL6sfg49Ugt0Re03julelS2np7I9+PHCsrvPwv3cnzLb+
   3T0fTVSn2/5VCueVH/DB/geKNdYtFl0MehEEdlhHXgy49HimRW/HAejwn
   8Kw0h9/qSMRV/r6NGH0VgspImyleklvXNwkeEh2lDvKfu67mg0Cftw2U1
   kbvTPSbB5WULQm0NZM4KEoe1S0xMSzzo9umqbh4dzs9RsJ5wBu/gSNowx
   w==;
X-CSE-ConnectionGUID: gjR34JmwSDmLfCNiWITxig==
X-CSE-MsgGUID: K7+2hzOKRTambZFZYnmT1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11607"; a="75050062"
X-IronPort-AV: E=Sophos;i="6.19,291,1754982000"; 
   d="scan'208";a="75050062"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2025 21:05:42 -0800
X-CSE-ConnectionGUID: tfmRiFbtTsmEFp5uVbgV2Q==
X-CSE-MsgGUID: 5e89+h57RXiGDU9wxyxXYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,291,1754982000"; 
   d="scan'208";a="193572600"
Received: from lkp-server01.sh.intel.com (HELO 6ef82f2de774) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 08 Nov 2025 21:05:40 -0800
Received: from kbuild by 6ef82f2de774 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vHxcP-0001mp-1I;
	Sun, 09 Nov 2025 05:05:37 +0000
Date: Sun, 9 Nov 2025 13:05:25 +0800
From: kernel test robot <lkp@intel.com>
To: ccc194101@163.com, stern@rowland.harvard.edu,
	gregkh@linuxfoundation.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
	linux-kernel@vger.kernel.org,
	Chen Changcheng <chenchangcheng@kylinos.cn>
Subject: Re: [PATCH] usb: usb-storage: No additional quirks need to be added
 to the ECD819-SU3 optical drive.
Message-ID: <202511091255.ohMJwQcj-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on 284922f4c563aa3a8558a00f2a05722133237fe8]

url:    https://github.com/intel-lab-lkp/linux/commits/ccc194101-163-com/usb-usb-storage-No-additional-quirks-need-to-be-added-to-the-ECD819-SU3-optical-drive/20251107-141330
base:   284922f4c563aa3a8558a00f2a05722133237fe8
patch link:    https://lore.kernel.org/r/20251107061046.32339-1-ccc194101%40163.com
patch subject: [PATCH] usb: usb-storage: No additional quirks need to be added to the ECD819-SU3 optical drive.
config: loongarch-randconfig-001-20251109 (https://download.01.org/0day-ci/archive/20251109/202511091255.ohMJwQcj-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project b9ea93cd5c37fb6d606502fd01208dd48330549d)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251109/202511091255.ohMJwQcj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511091255.ohMJwQcj-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/usb/storage/uas.c:931:
>> drivers/usb/storage/unusual_uas.h:100:1: error: incompatible pointer to integer conversion initializing 'kernel_ulong_t' (aka 'unsigned long') with an expression of type 'void *' [-Wint-conversion]
     100 | UNUSUAL_DEV(0x13fd, 0x3940, 0x0310, 0x0310,
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     101 |                 "Initio Corporation",
         |                 ~~~~~~~~~~~~~~~~~~~~~
     102 |                 "external DVD burner ECD819-SU3",
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     103 |                 USB_SC_DEVICE, USB_PR_DEVICE, NULL,
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     104 |                 NULL),
         |                 ~~~~~
   drivers/usb/storage/uas.c:928:17: note: expanded from macro 'UNUSUAL_DEV'
     928 |         .driver_info = (flags) }
         |                        ^~~~~~~
   1 error generated.


vim +100 drivers/usb/storage/unusual_uas.h

 > 100	UNUSUAL_DEV(0x13fd, 0x3940, 0x0310, 0x0310,
   101			"Initio Corporation",
   102			"external DVD burner ECD819-SU3",
   103			USB_SC_DEVICE, USB_PR_DEVICE, NULL,
   104			NULL),
   105	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

