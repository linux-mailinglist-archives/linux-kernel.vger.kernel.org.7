Return-Path: <linux-kernel+bounces-881204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE53C27B6C
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 10:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ED0F84E6860
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 09:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C20F2C2363;
	Sat,  1 Nov 2025 09:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PUykRZz/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213A328689F
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 09:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761990976; cv=none; b=M8ZY19ugwzxB7wYbv+a2dzfjaMLuXHviN7eg4eKfgUglZgtffo+Vo4AZ3yRvh2/7dusIBg7IIQFUkmdUoK7G9qhOxZghueo4sn6Knj+FBgKeRrTBGlSBcX1UVTzk90o7iWs38aA0fbxkfTqBEHAaTn8H6jCOyFdLyD8O8f32wXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761990976; c=relaxed/simple;
	bh=CfutuVK1wzmbDwh21rNys0bmr6xMd9exGWoLnWBdWbI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IismVZFV1cNy9gcTOzwNl80ruxh9umwc43FkXGVtufZOTPpjAl9mpRQYyzmPlHC7I89HrNMhzIz16CZcOP/d0EQD2bwtgm0Typn1bQ4X7whgZZlwjhTpq/oHRGuk8jNJ9iD6wE4/tG5pQnyBnomBMEZZGtgLvFltr7hkLTKYmmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PUykRZz/; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761990975; x=1793526975;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CfutuVK1wzmbDwh21rNys0bmr6xMd9exGWoLnWBdWbI=;
  b=PUykRZz/R/ylst6w3KgHmiwMhW3ChmuS82LypI2+EVJHsybP2PmfneVV
   YybrPkW1IMs8n415whLrML2aQRsjv5bgjhnzgablboYtGCS9pLMhQH4r/
   fWFlHVK0xAe/K5hZgO/UL+WqJrmVBbbEZfRRMSvPlHzvj7Biz25jqRups
   dbgFZG+d7o5nFBUQsg/XZD67HtnwTRAuJ/dJKXvjNFsB2XDa1MuVJlvWb
   gP3KjtdRjyAczBCVPuc98mA9B/+9XIihJgi1q3qVOhQXjNLT+mtq/rW6q
   HgNWVoORfbxtD7hJeN/WbEpGeHhul57urCiPhoadDg+oqVD24vlWP6err
   Q==;
X-CSE-ConnectionGUID: bT84SBDlTtuEF5I2SqV9nw==
X-CSE-MsgGUID: gWNkaXSVRq24sfdF8IVJ9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11599"; a="64059810"
X-IronPort-AV: E=Sophos;i="6.19,271,1754982000"; 
   d="scan'208";a="64059810"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2025 02:56:14 -0700
X-CSE-ConnectionGUID: 9yStbpcqTLSd4YvyV8ykGg==
X-CSE-MsgGUID: UF1ChgspSZORzdocnrv4Ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,271,1754982000"; 
   d="scan'208";a="209992855"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 01 Nov 2025 02:56:13 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vF8LC-000O6A-2R;
	Sat, 01 Nov 2025 09:56:10 +0000
Date: Sat, 1 Nov 2025 17:53:53 +0800
From: kernel test robot <lkp@intel.com>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Matt Coster <matt.coster@imgtec.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: drivers/gpu/drm/imagination/pvr_power.c:341:undefined reference to
 `pwrseq_power_off'
Message-ID: <202511011739.SONHjSfR-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ba36dd5ee6fd4643ebbf6ee6eefcecf0b07e35c7
commit: e38e8391f30b41c5a24bb46dc6ef4161921e782d drm/imagination: Use pwrseq for TH1520 GPU power management
date:   9 weeks ago
config: arm64-randconfig-r121-20251101 (https://download.01.org/0day-ci/archive/20251101/202511011739.SONHjSfR-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251101/202511011739.SONHjSfR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511011739.SONHjSfR-lkp@intel.com/

All errors (new ones prefixed by >>):

   aarch64-linux-ld: Unexpected GOT/PLT entries detected!
   aarch64-linux-ld: Unexpected run-time procedure linkages detected!
   aarch64-linux-ld: drivers/gpu/drm/imagination/pvr_power.o: in function `pvr_power_off_sequence_pwrseq':
>> drivers/gpu/drm/imagination/pvr_power.c:341:(.text+0x150): undefined reference to `pwrseq_power_off'
   aarch64-linux-ld: drivers/gpu/drm/imagination/pvr_power.o: in function `pvr_power_on_sequence_pwrseq':
>> drivers/gpu/drm/imagination/pvr_power.c:336:(.text+0x188): undefined reference to `pwrseq_power_on'
   aarch64-linux-ld: drivers/gpu/drm/imagination/pvr_power.o: in function `pvr_power_init_pwrseq':
>> drivers/gpu/drm/imagination/pvr_power.c:320:(.text+0x1cc): undefined reference to `devm_pwrseq_get'


vim +341 drivers/gpu/drm/imagination/pvr_power.c

   315	
   316	static int pvr_power_init_pwrseq(struct pvr_device *pvr_dev)
   317	{
   318		struct device *dev = from_pvr_device(pvr_dev)->dev;
   319	
 > 320		pvr_dev->pwrseq = devm_pwrseq_get(dev, "gpu-power");
   321		if (IS_ERR(pvr_dev->pwrseq)) {
   322			/*
   323			 * This platform requires a sequencer. If we can't get it, we
   324			 * must return the error (including -EPROBE_DEFER to wait for
   325			 * the provider to appear)
   326			 */
   327			return dev_err_probe(dev, PTR_ERR(pvr_dev->pwrseq),
   328					     "Failed to get required power sequencer\n");
   329		}
   330	
   331		return 0;
   332	}
   333	
   334	static int pvr_power_on_sequence_pwrseq(struct pvr_device *pvr_dev)
   335	{
 > 336		return pwrseq_power_on(pvr_dev->pwrseq);
   337	}
   338	
   339	static int pvr_power_off_sequence_pwrseq(struct pvr_device *pvr_dev)
   340	{
 > 341		return pwrseq_power_off(pvr_dev->pwrseq);
   342	}
   343	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

