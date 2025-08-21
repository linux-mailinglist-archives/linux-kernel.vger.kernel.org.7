Return-Path: <linux-kernel+bounces-780152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE434B2FE2F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 17:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5251F7B9C59
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E03275B1C;
	Thu, 21 Aug 2025 15:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GC/CiuOv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2FB274FF1
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 15:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755789674; cv=none; b=E7ds8asf3J2V7UFrqPyGX3OgZ2arNazEWNWJWseJL3rTmwZAFTdZGvkJ/6N7xCxBXhYUjRCtrDc8YB6j87m32gl+uME57HgrreXu5D0CT3amnsyKLpoQPl04Ykf1gnElbXlT+jN/0fui+PH9JN0fjFoEdJRgNauU+fYAMmYPvak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755789674; c=relaxed/simple;
	bh=8SEb4wkjQdTMVzzMIlhoKDexPBWVmtCAXkNcPzK1ofY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iby/DYqnr/F96TcbZfG8Gf9w0ZllLngl1DQwn8PWXRnxsNYDUXVX4JvbueCDm0Utmp9GnanPEg4QXnQqtlqQI7qM99owJSRI7DMhpzupKp4bPm6ERvMKofHdOFUq37jTgt6EEc9i02nJfxMAA77HC4xPb/CrLhvguVXOI6qQEK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GC/CiuOv; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755789672; x=1787325672;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8SEb4wkjQdTMVzzMIlhoKDexPBWVmtCAXkNcPzK1ofY=;
  b=GC/CiuOviq+d4qOGb/90yP7EjJc4w/aumpxj5OrDwxLuTAQ7YGHRiGUz
   /wEAPMCD9LJwccPTR8rZkNMYbMOyUNcCOOOeC+p8gnkYIn2jg6pdc+GY7
   VV7N60OXVpIeYe0a90RiqaJQblY806nzYr42o2hKHwTwi7Hxwwpq2bgW6
   sNWIOru/edhU9QbuKuOOirJJPZcL4/AoE1gH52sXs3pWhPES/ROz1+ET3
   XGJJNz2tt7QgFTHCWrWd9MFGXNTgUctvT7blhHem3TfuEqp2rdwllTi+u
   UwEHrsxdBFqyy9qVmD0QmjRSbWaMSXLaxK27FOxmNayu078JtEu5VLSl9
   Q==;
X-CSE-ConnectionGUID: 145wKggyQpG3qr7tI9yppw==
X-CSE-MsgGUID: 3pYr7DURStWflqrVQSZ9pA==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="68354746"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="68354746"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 08:21:12 -0700
X-CSE-ConnectionGUID: eKaor9GbTsaPHbDKG1137A==
X-CSE-MsgGUID: pxA8/nlrSFqyC8cp5eW+BA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="168858187"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 21 Aug 2025 08:21:09 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1up762-000KQb-26;
	Thu, 21 Aug 2025 15:21:00 +0000
Date: Thu, 21 Aug 2025 23:19:57 +0800
From: kernel test robot <lkp@intel.com>
To: Maxime Ripard <mripard@kernel.org>,
	Jyri Sarha <jyri.sarha@linux.intel.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: oe-kbuild-all@lists.linux.dev, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH v2 06/14] drm/tidss: dispc: Get rid of FLD_MOD
Message-ID: <202508212351.neQpMO5p-lkp@intel.com>
References: <20250820-drm-tidss-field-api-v2-6-43cab671c648@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820-drm-tidss-field-api-v2-6-43cab671c648@kernel.org>

Hi Maxime,

kernel test robot noticed the following build errors:

[auto build test ERROR on fbb0210d25fde20027f86a6ca9eee75630b5ac2b]

url:    https://github.com/intel-lab-lkp/linux/commits/Maxime-Ripard/drm-tidss-dispc-Remove-unused-OVR_REG_GET/20250820-220945
base:   fbb0210d25fde20027f86a6ca9eee75630b5ac2b
patch link:    https://lore.kernel.org/r/20250820-drm-tidss-field-api-v2-6-43cab671c648%40kernel.org
patch subject: [PATCH v2 06/14] drm/tidss: dispc: Get rid of FLD_MOD
config: xtensa-randconfig-001-20250821 (https://download.01.org/0day-ci/archive/20250821/202508212351.neQpMO5p-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250821/202508212351.neQpMO5p-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508212351.neQpMO5p-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/gpu/drm/tidss/tidss_dispc.c: In function 'dispc_set_num_datalines':
>> drivers/gpu/drm/tidss/tidss_dispc.c:649:17: error: implicit declaration of function 'FIELD_MODIFY' [-Werror=implicit-function-declaration]
     649 |                 FIELD_MODIFY(GENMASK((start), (end)), &_reg, (val));    \
         |                 ^~~~~~~~~~~~
   drivers/gpu/drm/tidss/tidss_dispc.c:1134:9: note: in expansion of macro 'VP_REG_FLD_MOD'
    1134 |         VP_REG_FLD_MOD(dispc, hw_videoport, DISPC_VP_CONTROL, v, 10, 8);
         |         ^~~~~~~~~~~~~~
   drivers/gpu/drm/tidss/tidss_dispc.c: In function 'dispc_vp_enable':
   drivers/gpu/drm/tidss/tidss_dispc.c:1219:24: error: implicit declaration of function 'FIELD_PREP' [-Werror=implicit-function-declaration]
    1219 |                        FIELD_PREP(GENMASK(7, 0), hsw - 1) |
         |                        ^~~~~~~~~~
   drivers/gpu/drm/tidss/tidss_dispc.c: In function 'dispc_vp_go_busy':
   drivers/gpu/drm/tidss/tidss_dispc.c:640:15: error: implicit declaration of function 'FIELD_GET' [-Werror=implicit-function-declaration]
     640 |         ((u32)FIELD_GET(GENMASK((start), (end)),                        \
         |               ^~~~~~~~~
   drivers/gpu/drm/tidss/tidss_dispc.c:1280:16: note: in expansion of macro 'VP_REG_GET'
    1280 |         return VP_REG_GET(dispc, hw_videoport, DISPC_VP_CONTROL, 5, 5);
         |                ^~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/FIELD_MODIFY +649 drivers/gpu/drm/tidss/tidss_dispc.c

   606	
   607	/*
   608	 * TRM gives bitfields as start:end, where start is the higher bit
   609	 * number. For example 7:0
   610	 */
   611	
   612	#define REG_GET(dispc, idx, start, end)					\
   613		((u32)FIELD_GET(GENMASK((start), (end)),			\
   614				dispc_read((dispc), (idx))))
   615	
   616	#define REG_FLD_MOD(dispc, idx, val, start, end)			\
   617		({								\
   618			struct dispc_device *_dispc = (dispc);			\
   619			u32 _idx = (idx);					\
   620			u32 _reg = dispc_read(_dispc, _idx);			\
   621			FIELD_MODIFY(GENMASK((start), (end)), &_reg, (val));	\
   622			dispc_write(_dispc, _idx, _reg);			\
   623		})
   624	
   625	#define VID_REG_GET(dispc, hw_plane, idx, start, end)			\
   626		((u32)FIELD_GET(GENMASK((start), (end)),			\
   627				dispc_vid_read((dispc), (hw_plane), (idx))))
   628	
   629	#define VID_REG_FLD_MOD(dispc, hw_plane, idx, val, start, end)		\
   630		({								\
   631			struct dispc_device *_dispc = (dispc);			\
   632			u32 _hw_plane = (hw_plane);				\
   633			u32 _idx = (idx);					\
   634			u32 _reg = dispc_vid_read(_dispc, _hw_plane, _idx);	\
   635			FIELD_MODIFY(GENMASK((start), (end)), &_reg, (val));	\
   636			dispc_vid_write(_dispc, _hw_plane, _idx, _reg);		\
   637		})
   638	
   639	#define VP_REG_GET(dispc, vp, idx, start, end)				\
   640		((u32)FIELD_GET(GENMASK((start), (end)),			\
   641				dispc_vp_read((dispc), (vp), (idx))))
   642	
   643	#define VP_REG_FLD_MOD(dispc, vp, idx, val, start, end)			\
   644		({								\
   645			struct dispc_device *_dispc = (dispc);			\
   646			u32 _vp = (vp);						\
   647			u32 _idx = (idx);					\
   648			u32 _reg = dispc_vp_read(_dispc, _vp, _idx);		\
 > 649			FIELD_MODIFY(GENMASK((start), (end)), &_reg, (val));	\
   650			dispc_vp_write(_dispc, _vp, _idx, _reg);		\
   651		})
   652	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

