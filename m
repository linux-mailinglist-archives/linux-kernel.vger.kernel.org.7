Return-Path: <linux-kernel+bounces-792627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 650A4B3C6D6
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 02:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34D761724F8
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 00:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4412921D3DF;
	Sat, 30 Aug 2025 00:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WGlaXiux"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72EC217F35
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 00:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756515338; cv=none; b=PAPd187D72O3Hhh3t2jnIQ1P4Mkz3/oayfRXbqW9RbhFSzDd64YGGPJCHvNnuyWMyaojoJ3A6RTB9KdN1GJbPJiKjiNUctBmYlwurNxvtbxBrOHt8unNnKfqSahEJnupsYb4SF9dj5RlELTzIb8JaK0cuj9kU4u7QjjXjLXTm5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756515338; c=relaxed/simple;
	bh=3cXPLvc0eRnag8MvjjaPsBwTWB6C31b46T8IqAhUCpk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=da9vFl57dpw47TbStpI29NhPSAhjfPSdop2t1dB39xpGu8m/DIEt05qqSUUmwc31qt0h4240FD+Dm446WGrep4/fWh4IkXNfCOtO3GmrKj0G/Rh4uUE9IehIoUHHO2/ql0P25bEqqQE4ueH9RHiBgCdtWFexLDiuLULJavoREbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WGlaXiux; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756515336; x=1788051336;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3cXPLvc0eRnag8MvjjaPsBwTWB6C31b46T8IqAhUCpk=;
  b=WGlaXiuxRjownSrj1653Go1Kgn04FSG3BgxelLItlrf/CsjUVnZ7BzLq
   dn9gu0v7eOwfd79DjretkqNjU4W2d8oFdxmqjU9joroMQoWuS0V+Ad4zJ
   S725r9w0uWNWgsd4KMD8xtfi8hxNt8hTuRNO7p3jRs8z2oqOADgtKpP6a
   9eMGPfgTUGUMrvE61KDPltRizLSrGDUBWp8wyCqJL02oxWlFO7t5z8D+9
   qUZvGGrlWD5OywpZ+WFhD8kheyKA0N9F8UyaicqM0r7JY7n7UQ1eltneJ
   qHzHxxVfW8gnvnI8Y52rUuPYG4DopLfYxbIOQtQB5vfKw2PyA6aTSBZ7s
   A==;
X-CSE-ConnectionGUID: E7b9l8Z9TpG/X2a5kTpe6A==
X-CSE-MsgGUID: Ct7BY5MuTzKaflNNHF5rIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11537"; a="58515442"
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="58515442"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 17:55:36 -0700
X-CSE-ConnectionGUID: VnTE/QKiTPqHqm1mreM+9A==
X-CSE-MsgGUID: Se3CU3L7S/uAgHT3UWLRSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="201442141"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 29 Aug 2025 17:55:34 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1us9sJ-000V5n-1Z;
	Sat, 30 Aug 2025 00:55:26 +0000
Date: Sat, 30 Aug 2025 08:54:57 +0800
From: kernel test robot <lkp@intel.com>
To: Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Daniel Thompson <daniel.thompson@linaro.org>
Subject: kismet: WARNING: unmet direct dependencies detected for
 LEDS_EXPRESSWIRE when selected by BACKLIGHT_KTD2801
Message-ID: <202508300808.CQS9RqHF-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   11e7861d680c3757eab18ec0a474ff680e007dc4
commit: a5554f1b5bc3be5d01f41b7550aa5b05b7c88c09 backlight: Add Kinetic KTD2801 Backlight support
date:   1 year, 6 months ago
config: x86_64-kismet-CONFIG_LEDS_EXPRESSWIRE-CONFIG_BACKLIGHT_KTD2801-0-0 (https://download.01.org/0day-ci/archive/20250830/202508300808.CQS9RqHF-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20250830/202508300808.CQS9RqHF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508300808.CQS9RqHF-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for LEDS_EXPRESSWIRE when selected by BACKLIGHT_KTD2801
   WARNING: unmet direct dependencies detected for LEDS_EXPRESSWIRE
     Depends on [n]: NEW_LEDS [=n] && GPIOLIB [=n]
     Selected by [y]:
     - BACKLIGHT_KTD2801 [=y] && HAS_IOMEM [=y] && BACKLIGHT_CLASS_DEVICE [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

