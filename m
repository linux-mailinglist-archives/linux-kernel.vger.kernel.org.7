Return-Path: <linux-kernel+bounces-804061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F01E3B46961
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 08:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A15061BC4F05
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 06:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4992929BDBA;
	Sat,  6 Sep 2025 06:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AQ4J5sa2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7A7212545
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 06:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757138645; cv=none; b=JPtk91epIQWMc+KrA5ssrpkS750vCl3yCdr8Q6NsER/3jBsA5NYjAM3jkY7YeV5os716rJS4Aiss8WK62VzdDdi4thqj9BCjcEe3FEcJgMfjUAIupXtPeLkiJAnjpx67e0vM72UkAX5zinVkOVAqk+cmonv8RaoAvrtlNsWTb7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757138645; c=relaxed/simple;
	bh=J8gtbUbycvbyLctGoOBt9Iu4ac+pExb2owTdA8T+Qj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dhHE9skh6f5e5eooQhAIPWhuPb8COgrkAni0+BrNdOfgSjztN07eS3aNNcmotKaiR4tFt2YwGLb2F6nYNIHo++wpXL0UkXUtNzFj1JjRX2ETV5lB4ye7Y7h+X6bWFgXthBpmw1SRlK+Q+B3EIVgkEbPB4yAl5NDVnKBFIKGDh8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AQ4J5sa2; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757138643; x=1788674643;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J8gtbUbycvbyLctGoOBt9Iu4ac+pExb2owTdA8T+Qj4=;
  b=AQ4J5sa2vr+yGF5S0ZEPX2C8b3SvKaugDAeDUwhiadsXuGh41/+XwbYi
   YZ/tBanAuupbYp19A0jlhMyBCG59ah9tsfYHlz35IjGP1QZcBUOGG0V++
   IJWgPETPAAd9Z4DDkFDrtJkNYUJaZQjdA91MvJVok9RseRFEmIx+xoU+2
   u3Ve7ZQXDBtZ6sPeq0QI+MK9aKtmJ5NeAAwuvXzYy36DuIbHfI37Y9qaX
   Kyipm9y9XxaVgpOKWslG7+qqRg9AnRgcNIEUWCdC0Ge/dqRo4BYkkPkFO
   ZXRGG4lLqvZNrWfApb2QGqyen6mC0HiD3UuSgpV75qaCoH/Kd5ZSmaSki
   w==;
X-CSE-ConnectionGUID: UeDg/FyaSderLoR8+w6nRQ==
X-CSE-MsgGUID: oCUbCv7zSVSwKmQf9wh89w==
X-IronPort-AV: E=McAfee;i="6800,10657,11544"; a="59179407"
X-IronPort-AV: E=Sophos;i="6.18,243,1751266800"; 
   d="scan'208";a="59179407"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 23:04:02 -0700
X-CSE-ConnectionGUID: AOKNTyKGSfuPQw8MlpFyRQ==
X-CSE-MsgGUID: pOdMhe0eTHCBOwt09PDnYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,243,1751266800"; 
   d="scan'208";a="172213082"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 05 Sep 2025 23:04:01 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uum1m-0001FT-1i;
	Sat, 06 Sep 2025 06:03:58 +0000
Date: Sat, 6 Sep 2025 14:03:43 +0800
From: kernel test robot <lkp@intel.com>
To: Joey Pabalinas <joeypabalinas@gmail.com>,
	Phillip Potter <phil@philpotter.co.uk>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cdrom: add parentheses around macro arguments
Message-ID: <202509061338.yRYn1te8-lkp@intel.com>
References: <13378f5c9cafc29425b6e420cad8b513f4a9f1e1.1757095005.git.joeypabalinas@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13378f5c9cafc29425b6e420cad8b513f4a9f1e1.1757095005.git.joeypabalinas@gmail.com>

Hi Joey,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.17-rc4 next-20250905]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Joey-Pabalinas/cdrom-add-parentheses-around-macro-arguments/20250906-020047
base:   linus/master
patch link:    https://lore.kernel.org/r/13378f5c9cafc29425b6e420cad8b513f4a9f1e1.1757095005.git.joeypabalinas%40gmail.com
patch subject: [PATCH] cdrom: add parentheses around macro arguments
config: sh-randconfig-r071-20250906 (https://download.01.org/0day-ci/archive/20250906/202509061338.yRYn1te8-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250906/202509061338.yRYn1te8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509061338.yRYn1te8-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/cdrom/cdrom.c: In function 'register_cdrom':
>> drivers/cdrom/cdrom.c:413:13: error: expected identifier before '(' token
     413 |  if ((cdo)->(call) == NULL)    \
         |             ^
   drivers/cdrom/cdrom.c:604:2: note: in expansion of macro 'ENSURE'
     604 |  ENSURE(cdo, drive_status, CDC_DRIVE_STATUS);
         |  ^~~~~~
>> drivers/cdrom/cdrom.c:413:13: error: expected identifier before '(' token
     413 |  if ((cdo)->(call) == NULL)    \
         |             ^
   drivers/cdrom/cdrom.c:607:2: note: in expansion of macro 'ENSURE'
     607 |  ENSURE(cdo, tray_move, CDC_CLOSE_TRAY | CDC_OPEN_TRAY);
         |  ^~~~~~
>> drivers/cdrom/cdrom.c:413:13: error: expected identifier before '(' token
     413 |  if ((cdo)->(call) == NULL)    \
         |             ^
   drivers/cdrom/cdrom.c:608:2: note: in expansion of macro 'ENSURE'
     608 |  ENSURE(cdo, lock_door, CDC_LOCK);
         |  ^~~~~~
>> drivers/cdrom/cdrom.c:413:13: error: expected identifier before '(' token
     413 |  if ((cdo)->(call) == NULL)    \
         |             ^
   drivers/cdrom/cdrom.c:609:2: note: in expansion of macro 'ENSURE'
     609 |  ENSURE(cdo, select_speed, CDC_SELECT_SPEED);
         |  ^~~~~~
>> drivers/cdrom/cdrom.c:413:13: error: expected identifier before '(' token
     413 |  if ((cdo)->(call) == NULL)    \
         |             ^
   drivers/cdrom/cdrom.c:610:2: note: in expansion of macro 'ENSURE'
     610 |  ENSURE(cdo, get_last_session, CDC_MULTI_SESSION);
         |  ^~~~~~
>> drivers/cdrom/cdrom.c:413:13: error: expected identifier before '(' token
     413 |  if ((cdo)->(call) == NULL)    \
         |             ^
   drivers/cdrom/cdrom.c:611:2: note: in expansion of macro 'ENSURE'
     611 |  ENSURE(cdo, get_mcn, CDC_MCN);
         |  ^~~~~~
>> drivers/cdrom/cdrom.c:413:13: error: expected identifier before '(' token
     413 |  if ((cdo)->(call) == NULL)    \
         |             ^
   drivers/cdrom/cdrom.c:612:2: note: in expansion of macro 'ENSURE'
     612 |  ENSURE(cdo, reset, CDC_RESET);
         |  ^~~~~~
>> drivers/cdrom/cdrom.c:413:13: error: expected identifier before '(' token
     413 |  if ((cdo)->(call) == NULL)    \
         |             ^
   drivers/cdrom/cdrom.c:613:2: note: in expansion of macro 'ENSURE'
     613 |  ENSURE(cdo, generic_packet, CDC_GENERIC_PACKET);
         |  ^~~~~~


vim +413 drivers/cdrom/cdrom.c

   405	
   406	/* This macro makes sure we don't have to check on cdrom_device_ops
   407	 * existence in the run-time routines below. Change_capability is a
   408	 * hack to have the capability flags defined const, while we can still
   409	 * change it here without gcc complaining at every line.
   410	 */
   411	#define ENSURE(cdo, call, bits)					\
   412	do {								\
 > 413		if ((cdo)->(call) == NULL)				\
   414			WARN_ON_ONCE((cdo)->capability & (bits));	\
   415	} while (0)
   416	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

