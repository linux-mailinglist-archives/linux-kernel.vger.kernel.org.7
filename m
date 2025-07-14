Return-Path: <linux-kernel+bounces-730704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D236B04860
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 22:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6105F3AC212
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 20:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E652367C9;
	Mon, 14 Jul 2025 20:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c0iVl2jX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E639222A7E4
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 20:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752524647; cv=none; b=Mx59dhv6KJyadorCDgeRQnqCTQ+gsgiUhqQkF3cBCF4vn/2v7pjqxw4+BghLSWoJBEGpTp7LFNxFk9GL4ymvqdUrIvTVsEy6OjnrR8I5CoxN3zc39U2AcmrNY+JKLqjwYUjvMpr0OLuedXYXC/wxV44kIKzy+l1wLl8WFZMTtS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752524647; c=relaxed/simple;
	bh=sMj3IX4r96WyHCc61qyK3UBb5qXNt4RxuJx5rtiDh7M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iyJ31PwUiWk43m2RutTmRjKCjpMJLwDjFoMyx3PoGH0tfDw6deJ1JNSBEfo3fyyX6w0xwp3wuGYRf+KB7zYhmUw2Oy6fqGJySXbXTDlDiLK44uubCEXM3VXq0k6mOcm+JNXgAgS6FeA5+y2qQgCKUa9J1UdLuVLS2zjqrvT5+BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c0iVl2jX; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752524646; x=1784060646;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sMj3IX4r96WyHCc61qyK3UBb5qXNt4RxuJx5rtiDh7M=;
  b=c0iVl2jX+oFZvYUVvYhfx7/f9ElOKZGJE6ocqdfF0JnTjCd2D4/cJtmr
   J/lj14JcI1oq+cA6oLNzwI90FvQux1OKSifIc+1jQp6kstcSSlqkiCosi
   h8BNbkUuArCbT7RryFUOYzeC8+T5zDSNIkLtZPslT1gb47XYUjHT3ukEC
   JrfH1+qzKJBIwZimn432LL/7tMTAmenquAFh/5E2BWX3eZLai4g/8INYR
   wcjQY/LgZKWfmykjlIOyxzsbvbWiFJxHPwJS1xH/VcbgK0IBACXznGTYS
   cCvrYHEJ6CrdybgO0O2ISwdovGKprsFBaf8U3biw16w+medThEI4MpI4f
   Q==;
X-CSE-ConnectionGUID: ZEnJkCtNSWiXplE6aqHp+g==
X-CSE-MsgGUID: nZhDYUPrSoGNnou3ehfDjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="53838355"
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; 
   d="scan'208";a="53838355"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 13:24:05 -0700
X-CSE-ConnectionGUID: dVXYUD6ETFWa0xpk4dlKvA==
X-CSE-MsgGUID: rf87MI/BTX6FruPu8wTM6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; 
   d="scan'208";a="161334826"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 14 Jul 2025 13:24:04 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ubPiU-0009IU-0F;
	Mon, 14 Jul 2025 20:24:02 +0000
Date: Tue, 15 Jul 2025 04:24:01 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Baryshkov <lumag@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c:1087:5-49: duplicated
 argument to && or ||
Message-ID: <202507150432.U0cALR6W-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   347e9f5043c89695b01e66b3ed111755afcf1911
commit: 8c62a31607f6589545ef1c0a85f2924dee39430b drm/msm/dpu: allow using two SSPP blocks for a single plane
date:   7 months ago
config: arm-randconfig-r064-20250714 (https://download.01.org/0day-ci/archive/20250715/202507150432.U0cALR6W-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project 01c97b4953e87ae455bd4c41e3de3f0f0f29c61c)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507150432.U0cALR6W-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c:1087:5-49: duplicated argument to && or ||

vim +1087 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c

  1050	
  1051	static int dpu_plane_virtual_atomic_check(struct drm_plane *plane,
  1052						  struct drm_atomic_state *state)
  1053	{
  1054		struct drm_plane_state *plane_state =
  1055			drm_atomic_get_plane_state(state, plane);
  1056		struct drm_plane_state *old_plane_state =
  1057			drm_atomic_get_old_plane_state(state, plane);
  1058		struct dpu_plane_state *pstate = to_dpu_plane_state(plane_state);
  1059		struct drm_crtc_state *crtc_state;
  1060		int ret;
  1061	
  1062		if (plane_state->crtc)
  1063			crtc_state = drm_atomic_get_new_crtc_state(state,
  1064								   plane_state->crtc);
  1065	
  1066		ret = dpu_plane_atomic_check_nosspp(plane, plane_state, crtc_state);
  1067		if (ret)
  1068			return ret;
  1069	
  1070		if (!plane_state->visible) {
  1071			/*
  1072			 * resources are freed by dpu_crtc_assign_plane_resources(),
  1073			 * but clean them here.
  1074			 */
  1075			pstate->pipe.sspp = NULL;
  1076			pstate->r_pipe.sspp = NULL;
  1077	
  1078			return 0;
  1079		}
  1080	
  1081		/*
  1082		 * Force resource reallocation if the format of FB or src/dst have
  1083		 * changed. We might need to allocate different SSPP or SSPPs for this
  1084		 * plane than the one used previously.
  1085		 */
  1086		if (!old_plane_state || !old_plane_state->fb ||
> 1087		    old_plane_state->src_w != plane_state->src_w ||
  1088		    old_plane_state->src_h != plane_state->src_h ||
  1089		    old_plane_state->src_w != plane_state->src_w ||
  1090		    old_plane_state->crtc_h != plane_state->crtc_h ||
  1091		    msm_framebuffer_format(old_plane_state->fb) !=
  1092		    msm_framebuffer_format(plane_state->fb))
  1093			crtc_state->planes_changed = true;
  1094	
  1095		return 0;
  1096	}
  1097	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

