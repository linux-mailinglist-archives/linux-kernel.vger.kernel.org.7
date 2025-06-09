Return-Path: <linux-kernel+bounces-678281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE27AD26A5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jun 2025 21:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6E2B7A9106
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jun 2025 19:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1908F21E08A;
	Mon,  9 Jun 2025 19:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DdLuWxr9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9DF21B9CE;
	Mon,  9 Jun 2025 19:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749496921; cv=none; b=eDeuTDuiQlD3BDERpzOOmSdkiHraYMKqg7F09zg+NCFRMJSk7JvMM2EW5n+ZVpwBkr9D92FiwcrPAjNhq+7mbmgQ/bTUy1L3Fdo2bX62LF6OAcZGDTYTG0rhkyF2VzDccqsogwWN4azfKnAZ/Hkp8D1icaE5/GabV0pdtXN5duk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749496921; c=relaxed/simple;
	bh=avDs50SYN/fcBfGKJ/LZzkZDnFCgRrOy6PXJSnNT1Tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IvOjLoyemViI7N0JKlcNDyjDlQy2qRaCmncuwRHI5i3iZWF2tsa6mOXv7BEkiYJwT2sZe3OZBpG9Hd91GBXRwPM2B2rlbi9jH0vQQV0CEn/7K4G8z+Y6vjBknTJcJFt1ULt5CoopARKj7S4iUDr38M+5KIZBJFl+izj9O4T7jFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DdLuWxr9; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749496920; x=1781032920;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=avDs50SYN/fcBfGKJ/LZzkZDnFCgRrOy6PXJSnNT1Tk=;
  b=DdLuWxr9hHBAKwsI/5Stu/zAjV1cFH/X6JBhxbKPjGm5N8ET/zHYZOZB
   phkOJW4h51kxqIU++SeuxFgo3H/we99tfZHTfoDi6rE0+2QAKCEn392E9
   eLXtPtOEM5Rc3mAs6y7hYxwKYzcPSIQ0jfgMDfDIPEdokfh8EY1FoHPm4
   PMnFTaJBpLG/xPgYkTS0eHllCQOXNe44+tEKMHxZyJ/v3cwVxCwprfXjL
   QQh+BMWvlNAyzKZt/WRK/c7+L6ZRR+Ng6p52/XvZZzZ94fH0K5zfaFI7k
   oOXjXYqrN/iXkguoEIWns1dQdfC6TfYn+R3rwsVX6H1CXzHx+9f+soOTp
   g==;
X-CSE-ConnectionGUID: GAVUkoV3ShahKKemyRLh0w==
X-CSE-MsgGUID: T9ROe0tCRkadaommnYsiMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="51498038"
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="51498038"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 12:21:59 -0700
X-CSE-ConnectionGUID: IdAq2zzKTtu+KujlTCwsIg==
X-CSE-MsgGUID: EN0HJMZxTW+bGxfUiXYFTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="183784726"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 09 Jun 2025 12:21:53 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uOi46-0007LR-28;
	Mon, 09 Jun 2025 19:21:50 +0000
Date: Tue, 10 Jun 2025 03:21:00 +0800
From: kernel test robot <lkp@intel.com>
To: Markus Elfring <Markus.Elfring@web.de>, amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Alex Deucher <alexander.deucher@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
	Dominik Kaszewski <dominik.kaszewski@amd.com>,
	Fangzhi Zuo <Jerry.Zuo@amd.com>,
	Hamza Mahfooz <hamza.mahfooz@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Hersen Wu <hersenxs.wu@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Roman Li <roman.li@amd.com>, Simona Vetter <simona@ffwll.ch>,
	Stylon Wang <stylon.wang@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>, Wayne Lin <Wayne.Lin@amd.com>,
	Xinhui Pan <Xinhui.Pan@amd.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>,
	kernel-janitors@vger.kernel.org, cocci@inria.fr,
	Melissa Wen <mwen@igalia.com>
Subject: Re: [PATCH v2] drm/amd/display: Fix exception handling in
 dm_validate_stream_and_context()
Message-ID: <202506100312.Ms4XgAzW-lkp@intel.com>
References: <da489521-7786-4716-8fb8-d79b3c08d93c@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da489521-7786-4716-8fb8-d79b3c08d93c@web.de>

Hi Markus,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20250606]
[also build test ERROR on v6.16-rc1]
[cannot apply to drm-exynos/exynos-drm-next linus/master drm-intel/for-linux-next drm-intel/for-linux-next-fixes drm/drm-next drm-misc/drm-misc-next v6.16-rc1 v6.15 v6.15-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Markus-Elfring/drm-amd-display-Fix-exception-handling-in-dm_validate_stream_and_context/20250609-151039
base:   next-20250606
patch link:    https://lore.kernel.org/r/da489521-7786-4716-8fb8-d79b3c08d93c%40web.de
patch subject: [PATCH v2] drm/amd/display: Fix exception handling in dm_validate_stream_and_context()
config: x86_64-buildonly-randconfig-005-20250609 (https://download.01.org/0day-ci/archive/20250610/202506100312.Ms4XgAzW-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250610/202506100312.Ms4XgAzW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506100312.Ms4XgAzW-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:7525:2: error: call to undeclared function 'dc_release_state'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    7525 |         dc_release_state(dc_state);
         |         ^
   1 error generated.


vim +/dc_release_state +7525 drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c

  7471	
  7472	static enum dc_status dm_validate_stream_and_context(struct dc *dc,
  7473							struct dc_stream_state *stream)
  7474	{
  7475		enum dc_status dc_result = DC_ERROR_UNEXPECTED;
  7476		struct dc_plane_state *dc_plane_state;
  7477		struct dc_state *dc_state;
  7478	
  7479		if (!stream)
  7480			return dc_result;
  7481	
  7482		dc_plane_state = dc_create_plane_state(dc);
  7483		if (!dc_plane_state)
  7484			return dc_result;
  7485	
  7486		dc_state = dc_state_create(dc, NULL);
  7487		if (!dc_state)
  7488			goto release_plane_state;
  7489	
  7490		/* populate stream to plane */
  7491		dc_plane_state->src_rect.height  = stream->src.height;
  7492		dc_plane_state->src_rect.width   = stream->src.width;
  7493		dc_plane_state->dst_rect.height  = stream->src.height;
  7494		dc_plane_state->dst_rect.width   = stream->src.width;
  7495		dc_plane_state->clip_rect.height = stream->src.height;
  7496		dc_plane_state->clip_rect.width  = stream->src.width;
  7497		dc_plane_state->plane_size.surface_pitch = ((stream->src.width + 255) / 256) * 256;
  7498		dc_plane_state->plane_size.surface_size.height = stream->src.height;
  7499		dc_plane_state->plane_size.surface_size.width  = stream->src.width;
  7500		dc_plane_state->plane_size.chroma_size.height  = stream->src.height;
  7501		dc_plane_state->plane_size.chroma_size.width   = stream->src.width;
  7502		dc_plane_state->format = SURFACE_PIXEL_FORMAT_GRPH_ARGB8888;
  7503		dc_plane_state->tiling_info.gfx9.swizzle = DC_SW_UNKNOWN;
  7504		dc_plane_state->rotation = ROTATION_ANGLE_0;
  7505		dc_plane_state->is_tiling_rotated = false;
  7506		dc_plane_state->tiling_info.gfx8.array_mode = DC_ARRAY_LINEAR_GENERAL;
  7507	
  7508		dc_result = dc_validate_stream(dc, stream);
  7509		if (dc_result == DC_OK)
  7510			dc_result = dc_validate_plane(dc, dc_plane_state);
  7511	
  7512		if (dc_result == DC_OK)
  7513			dc_result = dc_state_add_stream(dc, dc_state, stream);
  7514	
  7515		if (dc_result == DC_OK && !dc_state_add_plane(
  7516							dc,
  7517							stream,
  7518							dc_plane_state,
  7519							dc_state))
  7520			dc_result = DC_FAIL_ATTACH_SURFACES;
  7521	
  7522		if (dc_result == DC_OK)
  7523			dc_result = dc_validate_global_state(dc, dc_state, DC_VALIDATE_MODE_ONLY);
  7524	
> 7525		dc_release_state(dc_state);
  7526	release_plane_state:
  7527		dc_plane_state_release(dc_plane_state);
  7528		return dc_result;
  7529	}
  7530	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

