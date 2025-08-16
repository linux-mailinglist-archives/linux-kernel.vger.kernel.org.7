Return-Path: <linux-kernel+bounces-771616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61509B2897F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 02:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39E8B5E32E0
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 00:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88ED78F3A;
	Sat, 16 Aug 2025 00:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yx9mH3Mr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A09F134AB
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 00:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755305869; cv=none; b=AIGbXlMNG0w307nBxZSMQVOFOVJXWyJDJbrdUmLSQHzB/xlOIiR58GWTwdAchLvNvcHiFVN87CC0UfOWY0JnzuWyCNZdnsOm5FPRqmBSkz7tIyI2FKKKSliKkCuez4WSvNG9wAUA5L8ag68zCvfHdXVl41/AS7E3i1qCMC3xD3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755305869; c=relaxed/simple;
	bh=ukMsMQdY1esdd5Vpb3YVrIGo9PLgslhipI1hpV6tqTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jjPc0S11N1vf99W9x9m3R7VwFZx16YDWABCQIClCfrnwrcEVHQFL2l1RviFZmnQB8e7DpYYLHVMVCzvWi8leCpyHhAQk1kTv7QVYe9eMrrB9m91n2KRdbOSzUPOAdPLUc8XzeLpM07sgB/F0eXKXFqPdynqXActfhn98IEN+x+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yx9mH3Mr; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755305867; x=1786841867;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ukMsMQdY1esdd5Vpb3YVrIGo9PLgslhipI1hpV6tqTI=;
  b=Yx9mH3MrfMaHZ6vv4stvIEBPqJ1vQ0dRkWrAOcIxV1Gh7DqhNJKIq3LO
   IYRIbYd/foZGIROPWT9qafYJ52s2orWeQRc5Y6buZkAI5G+3+f0nuXK8C
   UL/hvG4ysvj1+NRQ4WI1iQ0MY7pnATd3AtT8pXZJtYr/+A/UHj6mWCfVp
   BfBiF4jlsAfHHW5YrkAMJH6j36+PnJVHuIerGx063jYPz1FhQ31U168VG
   k94x5mt61fogdFPDmQigc+GGDie2YFFMnLhZ6BPaQUmSbaCMMDgKwv2la
   KkPqKkRlk5YU1zBqu/sXA8Nlmuezeq4kh8j41MtJLZCP40l0Fdea/c8aN
   g==;
X-CSE-ConnectionGUID: JsIxTQFxTliBw8wqtj7oZw==
X-CSE-MsgGUID: vFod4LgjSC2QUhxKPJCnTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11523"; a="57536994"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="57536994"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 17:57:47 -0700
X-CSE-ConnectionGUID: vZYKcPdgTbm2DrN25iXXQA==
X-CSE-MsgGUID: lD6nAVcHT767qK3gjbyk/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="166750340"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 15 Aug 2025 17:57:44 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1un5Er-000CSm-1S;
	Sat, 16 Aug 2025 00:57:41 +0000
Date: Sat, 16 Aug 2025 08:57:28 +0800
From: kernel test robot <lkp@intel.com>
To: 2564278112@qq.com, alex.williamson@redhat.com
Cc: oe-kbuild-all@lists.linux.dev, christian.koenig@amd.com,
	airlied@gmail.com, simona@ffwll.ch, sunil.khatri@amd.com,
	alexandre.f.demers@gmail.com, boyuan.zhang@amd.com,
	jiangwang@kylinos.cn, amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/amdgpu: Fixed an issue where audio did not turn off
 properly after unplugging HDMI
Message-ID: <202508160829.jfFPh4YJ-lkp@intel.com>
References: <tencent_E5B1CAABB0320691EB730CDB19E55EA85E05@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_E5B1CAABB0320691EB730CDB19E55EA85E05@qq.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-exynos/exynos-drm-next]
[also build test ERROR on linus/master v6.17-rc1 next-20250815]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/2564278112-qq-com/drm-amdgpu-Fixed-an-issue-where-audio-did-not-turn-off-properly-after-unplugging-HDMI/20250815-164929
base:   https://git.kernel.org/pub/scm/linux/kernel/git/daeinki/drm-exynos.git exynos-drm-next
patch link:    https://lore.kernel.org/r/tencent_E5B1CAABB0320691EB730CDB19E55EA85E05%40qq.com
patch subject: [PATCH] drm/amdgpu: Fixed an issue where audio did not turn off properly after unplugging HDMI
config: x86_64-buildonly-randconfig-002-20250816 (https://download.01.org/0day-ci/archive/20250816/202508160829.jfFPh4YJ-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250816/202508160829.jfFPh4YJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508160829.jfFPh4YJ-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/gpu/drm/amd/amdgpu/dce_v6_0.c: In function 'dce_v6_0_encoder_mode_set':
>> drivers/gpu/drm/amd/amdgpu/dce_v6_0.c:3271:38: error: implicit declaration of function 'amdgpu_connector_edid'; did you mean 'amdgpu_connector_add'? [-Werror=implicit-function-declaration]
    3271 |         if (drm_detect_monitor_audio(amdgpu_connector_edid(connector))) {
         |                                      ^~~~~~~~~~~~~~~~~~~~~
         |                                      amdgpu_connector_add
>> drivers/gpu/drm/amd/amdgpu/dce_v6_0.c:3271:38: warning: passing argument 1 of 'drm_detect_monitor_audio' makes pointer from integer without a cast [-Wint-conversion]
    3271 |         if (drm_detect_monitor_audio(amdgpu_connector_edid(connector))) {
         |                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                      |
         |                                      int
   In file included from drivers/gpu/drm/amd/amdgpu/dce_v6_0.c:26:
   include/drm/drm_edid.h:443:50: note: expected 'const struct edid *' but argument is of type 'int'
     443 | bool drm_detect_monitor_audio(const struct edid *edid);
         |                               ~~~~~~~~~~~~~~~~~~~^~~~
   drivers/gpu/drm/amd/amdgpu/dce_v6_0.c: In function 'dce_v6_0_encoder_disable':
   drivers/gpu/drm/amd/amdgpu/dce_v6_0.c:3341:46: warning: passing argument 1 of 'drm_detect_monitor_audio' makes pointer from integer without a cast [-Wint-conversion]
    3341 |                 if (drm_detect_monitor_audio(amdgpu_connector_edid(connector)))
         |                                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                              |
         |                                              int
   include/drm/drm_edid.h:443:50: note: expected 'const struct edid *' but argument is of type 'int'
     443 | bool drm_detect_monitor_audio(const struct edid *edid);
         |                               ~~~~~~~~~~~~~~~~~~~^~~~
   cc1: some warnings being treated as errors


vim +3271 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c

  3250	
  3251	static void dce_v6_0_encoder_mode_set(struct drm_encoder *encoder,
  3252				  struct drm_display_mode *mode,
  3253				  struct drm_display_mode *adjusted_mode)
  3254	{
  3255		struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
  3256		struct drm_connector *connector;
  3257		struct amdgpu_connector *amdgpu_connector = NULL;
  3258		amdgpu_encoder->pixel_clock = adjusted_mode->clock;
  3259	
  3260		/* need to call this here rather than in prepare() since we need some crtc info */
  3261		amdgpu_atombios_encoder_dpms(encoder, DRM_MODE_DPMS_OFF);
  3262		connector = amdgpu_get_connector_for_encoder_init(encoder);
  3263		amdgpu_connector = to_amdgpu_connector(connector);
  3264		if (!amdgpu_connector) {
  3265			DRM_ERROR("Couldn't find encoder's connector\n");
  3266		}
  3267	
  3268		/* set scaler clears this on some chips */
  3269		dce_v6_0_set_interleave(encoder->crtc, mode);
  3270	
> 3271		if (drm_detect_monitor_audio(amdgpu_connector_edid(connector))) {
  3272			dce_v6_0_afmt_enable(encoder, true);
  3273			dce_v6_0_afmt_setmode(encoder, adjusted_mode);
  3274		}
  3275	}
  3276	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

