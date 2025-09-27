Return-Path: <linux-kernel+bounces-834896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A5DBA5CA1
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 11:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 741C44A4065
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 09:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9552F2D6E67;
	Sat, 27 Sep 2025 09:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vs8XHR6y"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B95224B09;
	Sat, 27 Sep 2025 09:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758966055; cv=none; b=s4IATU7hAKhmI2/nddOqRX0lk9XaqLUg2zzYNyVw2Gljwre+n1TWftpgogAKaQi4q5Btc7TcjRBKODA99UBNMTGhX1VzKV+x8lFnvrSf4G8cx+BjJPj5aG0lK8p63ZUGHe9fBJJnq84BFxit3YxUDEXZnuGivT8zOc7C+rLZsig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758966055; c=relaxed/simple;
	bh=1ZT7hcbLJ7/3FcSvxmAcSuqVf7EJe6EAn7aQ9zZBPVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MtTRBaOWFD9Zt7IaDZQzaPLFStnRJaYVwW0LJl0b4k1c/mVCYXfCoW/WVGaktdG4VpEjLc4NneP88UEnM4Y2FKsaO/ht6uBC7KUgSX/eMKEEgiIfKuNxUisJLr2bVDFuwo5rjqtQm0/vTfADlM/LRS+VZHXM0z+yGn6IcDAldSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vs8XHR6y; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758966053; x=1790502053;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1ZT7hcbLJ7/3FcSvxmAcSuqVf7EJe6EAn7aQ9zZBPVY=;
  b=Vs8XHR6y0qvKYz0kyAiG54mjaGSsqrY7NL4bX/VsPJe7Q6vGJvvFfl0K
   BwdfOTpxgw3QY03dygu/leExvdp8YjiZcVi5T7piE2qd0QZCVzg9qJ3vW
   ktHgVG0YLcVqJCc0uds2YgY13QgjhM+nReS1x2NAGc8BsyQVgfgn/HTLV
   NVdPUa0ayMBlqS4mcKIgncOZnLT8mgvFFJFkzX39A/xN6RtpJTd3Q3Mua
   BHWA+1bKnysIpDOVrCke2E/q/FmogMuwqrL6LVIFNJ8Ln5CS9z7w2KygG
   wRhlUFR7odAqzyYGt4UTSaGlg3PwPgqj6HH4VNoxurZMV4o6DzM2P9c3l
   A==;
X-CSE-ConnectionGUID: GlbnH3wXRUqPQKLfL/5X6g==
X-CSE-MsgGUID: +uGtC+iaT++/BCh/j791vg==
X-IronPort-AV: E=McAfee;i="6800,10657,11565"; a="60496466"
X-IronPort-AV: E=Sophos;i="6.18,297,1751266800"; 
   d="scan'208";a="60496466"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2025 02:40:52 -0700
X-CSE-ConnectionGUID: gRWa5G5lTyGTI0dAlvnRxQ==
X-CSE-MsgGUID: yus7upZQTSOGSwJvWOAMUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,297,1751266800"; 
   d="scan'208";a="177363610"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 27 Sep 2025 02:40:47 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v2RQ4-0006x1-2g;
	Sat, 27 Sep 2025 09:40:44 +0000
Date: Sat, 27 Sep 2025 17:40:16 +0800
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
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH V1 2/7] ASoC: codecs: Rework the aw88395 driver
Message-ID: <202509271749.upX9Qa9f-lkp@intel.com>
References: <20250926102037.27697-3-wangweidong.a@awinic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926102037.27697-3-wangweidong.a@awinic.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 4ff71af020ae59ae2d83b174646fc2ad9fcd4dc4]

url:    https://github.com/intel-lab-lkp/linux/commits/wangweidong-a-awinic-com/ASoC-codecs-Rework-the-awinic-driver-lib/20250926-183836
base:   4ff71af020ae59ae2d83b174646fc2ad9fcd4dc4
patch link:    https://lore.kernel.org/r/20250926102037.27697-3-wangweidong.a%40awinic.com
patch subject: [PATCH V1 2/7] ASoC: codecs: Rework the aw88395 driver
config: csky-randconfig-001-20250927 (https://download.01.org/0day-ci/archive/20250927/202509271749.upX9Qa9f-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250927/202509271749.upX9Qa9f-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509271749.upX9Qa9f-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from sound/soc/codecs/aw88395.c:16:
>> sound/soc/codecs/aw88395.h:10: warning: header guard '__AW88395_H__' followed by '#define' of a different macro [-Wheader-guard]
      10 | #ifndef __AW88395_H__
   sound/soc/codecs/aw88395.h:11: note: '__AW88395_H___' is defined here; did you mean '__AW88395_H__'?
      11 | #define __AW88395_H___


vim +10 sound/soc/codecs/aw88395.h

     9	
  > 10	#ifndef __AW88395_H__
    11	#define __AW88395_H___
    12	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

