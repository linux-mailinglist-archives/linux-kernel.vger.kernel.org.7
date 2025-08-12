Return-Path: <linux-kernel+bounces-763962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D89B21C1A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 06:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB9CC1A260D2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 04:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253B22D97B8;
	Tue, 12 Aug 2025 04:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pfg0XciA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AB81F09B3
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 04:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754972711; cv=none; b=Z0aZUhiaGh+eQ+IvzGxAX8jSePaMF7Onj1UWIQqSj7KC2CMEQUD4XstJdEZJUUV/iswRBjxuXqS2+dUuPqozeS9diamXT+YSRlf4R7HOZjE2mrV+RRsjk/KVpSm4RUop/n6U/biBY3mkf3whS5Qr6T+IqC57GIbTbcRXD47hHkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754972711; c=relaxed/simple;
	bh=GcaymzhezF8G36GX0K3K1sbeQTw49v8aWQ5b4GeUkOk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jaPDhSTXDG2l+sB3fLuUOK57wULe2VMG8C58wvo8fw1FfiwHbHDzIVd71mmjcQs0zXs35vAiDZUfpMuGYsd5gmfOR3nmWN/Xr8FUDNabIebBgz9UQ2ppHGuYV1R5B5GEJAhLLCuyXDsu+fjKHRiHUGRU8xqu+wX1U3eKOXRGvMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pfg0XciA; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754972710; x=1786508710;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GcaymzhezF8G36GX0K3K1sbeQTw49v8aWQ5b4GeUkOk=;
  b=Pfg0XciABq5gnHHN+idAC2LfDBPAATtB71gAu2UbypJaE9gAqNkRsCTQ
   Fcd2H5lA2L5yS9ajRRRRGPmrL+n+IiOgGs3gG0Ya+XAhPL2D50YrYALJD
   lEDqOr/HrvM/4A5rq8jk3a3k4S6W7+3sotuopSCVZaytcBKup7cr8HHwH
   3ptx1WAUKZMjC4Z8ljSdztDEYSdEyeSma8z7uGCwGd+oy8q5AjP9/IsxH
   aI0iilpb3ov9pD85ypm/qVJAnBKawH9ARSn/44s0nSLKyLq3JxXopZhdn
   dJvZEPHUkdX2tKXh3H6iYDo0bPJVo1e+iDCXJOJNtwAi6q7EfKH5+rwSO
   Q==;
X-CSE-ConnectionGUID: vD8QGVnPTGq9E+k+FWHFAQ==
X-CSE-MsgGUID: B9MsdZmMRh625qSlLWGqfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="44819412"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="44819412"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 21:25:09 -0700
X-CSE-ConnectionGUID: Yyt8/yAMQFOWGQD8On8uQA==
X-CSE-MsgGUID: yddPVtKtSmSF4BID+O0O7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="166444111"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 11 Aug 2025 21:25:08 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ulgZO-0006Pg-05;
	Tue, 12 Aug 2025 04:25:06 +0000
Date: Tue, 12 Aug 2025 12:24:47 +0800
From: kernel test robot <lkp@intel.com>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: aarch64-linux-ld:
 drivers/media/platform/qcom/iris/iris_firmware.c:59: undefined reference to
 `qcom_mdt_load'
Message-ID: <202508121206.uUCMMLad-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8f5ae30d69d7543eee0d70083daf4de8fe15d585
commit: 9ceba431a31544f4f8feb0df58287a58644dc5f5 Merge tag 'ath-next-20250418' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath into wireless-next
date:   4 months ago
config: arm64-randconfig-004-20250812 (https://download.01.org/0day-ci/archive/20250812/202508121206.uUCMMLad-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250812/202508121206.uUCMMLad-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508121206.uUCMMLad-lkp@intel.com/

All errors (new ones prefixed by >>):

   aarch64-linux-ld: drivers/media/platform/qcom/iris/iris_firmware.o: in function `iris_load_fw_to_memory':
>> drivers/media/platform/qcom/iris/iris_firmware.c:49: undefined reference to `qcom_mdt_get_size'
>> drivers/media/platform/qcom/iris/iris_firmware.c:49:(.text+0x2a0): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `qcom_mdt_get_size'
>> aarch64-linux-ld: drivers/media/platform/qcom/iris/iris_firmware.c:59: undefined reference to `qcom_mdt_load'
>> drivers/media/platform/qcom/iris/iris_firmware.c:59:(.text+0x2ec): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `qcom_mdt_load'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

