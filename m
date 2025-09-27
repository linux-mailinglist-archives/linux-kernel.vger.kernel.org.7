Return-Path: <linux-kernel+bounces-834978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06621BA5F38
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 14:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF86C323615
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 12:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54D42E0412;
	Sat, 27 Sep 2025 12:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MU6qwF2+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8721E4BE;
	Sat, 27 Sep 2025 12:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758977326; cv=none; b=C8FzD+9UR2oCcE0Wr95/q1RKFZupb9aT6HmBDTPiVDvzy++s1pIMmjlTa4QZulbBOzTsfVgHQAqUMazvP7+wufBHbhGMwWWhvJLN9URUXPUYKwKt1j/o0Gk+ZBZvKV0sqIkUMEX76rpqikecM1B3akI6oX3viU7d5BMm8BntOiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758977326; c=relaxed/simple;
	bh=4NrMBVPpQGxwqRlFYgottQtpkjozBNCD9C8CESyhSTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H8q+N/WlYVrkb4/ALoZQdSCd6YwN7L99ncO2nBNqJmut+kkGw/uF5kUlDq40/9kyZmVYtVObJMztDieO+v5Mmb6om2RDoN3JnIFN4AQ4BqsQ2yq8yHk3849ubUQEDFDV245mQ9rdXD4AnfkKM68TvTI+5WLPRpwuB2bG/pz9wa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MU6qwF2+; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758977325; x=1790513325;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4NrMBVPpQGxwqRlFYgottQtpkjozBNCD9C8CESyhSTA=;
  b=MU6qwF2+8BLNO5ynbNMtTXRkmy2B4S35OT/AZHz5T9j5Xf3XFxEi2j5K
   2ugdMsWfojsx9iNadgfsCXkOUCZN5Kgu7LbdmpG8uFWtmKG8WcEgjnrAA
   +20oGmkL0r0PQcS2yRFI9ZbvcQwe6wJbOp12fGp76FrS6Hxs7CEibvOgv
   d7Nl8x+1Q5jpyTLOhV0Vf/tmMy8z/6YvJtj+tqR8loIYXketidZDuFpnZ
   HBsLERcfjV9Azwol4dXVcecjCaV0NJ6sjUKLtGSJExNvBSRl6HLntiy/2
   bUmJXWna3VqC3hwahd1a/hXnuxGMNNuJuOMS3XXA74clWU8arlIB2PfFW
   g==;
X-CSE-ConnectionGUID: Fa88hXz5SiuAZgVkLl+dOA==
X-CSE-MsgGUID: vq2c0ukRSSamnbvTdAK0YA==
X-IronPort-AV: E=McAfee;i="6800,10657,11565"; a="86734706"
X-IronPort-AV: E=Sophos;i="6.18,297,1751266800"; 
   d="scan'208";a="86734706"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2025 05:48:44 -0700
X-CSE-ConnectionGUID: ieoZQzMnTjqoQ61NE5uhsg==
X-CSE-MsgGUID: m/Esm2S8Tui3YAfCE/nawA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,297,1751266800"; 
   d="scan'208";a="208568699"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 27 Sep 2025 05:48:38 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v2ULr-00073Z-2f;
	Sat, 27 Sep 2025 12:48:35 +0000
Date: Sat, 27 Sep 2025 20:47:47 +0800
From: kernel test robot <lkp@intel.com>
To: wangweidong.a@awinic.com, lgirdwood@gmail.com, broonie@kernel.org,
	perex@perex.cz, tiwai@suse.com, cy_huang@richtek.com,
	ivprusov@salutedevices.com, zhoubinbin@loongson.cn,
	zhangyi@everest-semi.com, jack.yu@realtek.com, shenghao-ding@ti.com,
	rf@opensource.cirrus.com, git@apitzsch.eu, nuno.sa@analog.com,
	colin.i.king@gmail.com, thorsten.blum@linux.dev,
	yesanishhere@gmail.com, ebiggers@google.com, ardb@kernel.org,
	zhujun2@cmss.chinamobile.com, linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH V1 7/7] ASoC: codecs: Rework the aw88399 driver
Message-ID: <202509271902.lDJPhs8Z-lkp@intel.com>
References: <20250926102037.27697-8-wangweidong.a@awinic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926102037.27697-8-wangweidong.a@awinic.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 4ff71af020ae59ae2d83b174646fc2ad9fcd4dc4]

url:    https://github.com/intel-lab-lkp/linux/commits/wangweidong-a-awinic-com/ASoC-codecs-Rework-the-awinic-driver-lib/20250926-183836
base:   4ff71af020ae59ae2d83b174646fc2ad9fcd4dc4
patch link:    https://lore.kernel.org/r/20250926102037.27697-8-wangweidong.a%40awinic.com
patch subject: [PATCH V1 7/7] ASoC: codecs: Rework the aw88399 driver
config: i386-randconfig-017-20250927 (https://download.01.org/0day-ci/archive/20250927/202509271902.lDJPhs8Z-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250927/202509271902.lDJPhs8Z-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509271902.lDJPhs8Z-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> sound/soc/codecs/aw88399.c:1728:36: warning: unused variable 'aw88399_acpi_match' [-Wunused-const-variable]
    1728 | static const struct acpi_device_id aw88399_acpi_match[] = {
         |                                    ^~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +/aw88399_acpi_match +1728 sound/soc/codecs/aw88399.c

8ade6cc7e26175 Weidong Wang 2023-10-25  1726  
e95122a32e7773 Weidong Wang 2025-07-25  1727  #ifdef CONFIG_ACPI
e95122a32e7773 Weidong Wang 2025-07-25 @1728  static const struct acpi_device_id aw88399_acpi_match[] = {
e95122a32e7773 Weidong Wang 2025-07-25  1729  	{ "AWDZ8399", 0 },
e95122a32e7773 Weidong Wang 2025-07-25  1730  	{ },
e95122a32e7773 Weidong Wang 2025-07-25  1731  };
e95122a32e7773 Weidong Wang 2025-07-25  1732  MODULE_DEVICE_TABLE(acpi, aw88399_acpi_match);
e95122a32e7773 Weidong Wang 2025-07-25  1733  #endif
e95122a32e7773 Weidong Wang 2025-07-25  1734  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

