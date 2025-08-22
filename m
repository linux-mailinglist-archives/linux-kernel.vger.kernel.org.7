Return-Path: <linux-kernel+bounces-781746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B77D7B31631
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 667617A5FFA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7875D2C029E;
	Fri, 22 Aug 2025 11:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VbEodHGY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA18393DE1
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 11:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755861530; cv=none; b=P+6HuOVHVM+MY2bwCInF/lNIECAdc8cxnd4OM8mPMgL0M+hSxnDKpqCjdiacEUaKLuV4vkYXLC8z8sUgSjt0FAlEBTdIn9Jp1PUMqTMfyOGwMBpWlApjoE9zAVqTEF6F1xXqPNNOKlZ50A69rSVSHqphvUL3RbY9TzVP3R1SxNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755861530; c=relaxed/simple;
	bh=Lei63idtbQzSVhoaceBZUKk4ZP6vJsdXd3QWrmH5MmM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SRFA5KGVD9IvPiOImT+U9lEhH6mmDPugV1WAx0sN+sdxYZ641edzkF0HKi2/U+u6q/II/AUZ3qtgbK01VH0CdDXHYX1BFyBJij7Dj0FZFvSOvdB96bz5t0QTeNz7+0cUpHcubJs069cQFVLRXBdL+4p7PRQVqXzY7wFDRmR8yaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VbEodHGY; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755861528; x=1787397528;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Lei63idtbQzSVhoaceBZUKk4ZP6vJsdXd3QWrmH5MmM=;
  b=VbEodHGY0qAjkwbX1ga4ECwivG+V3ow6KF0OHsykK52sMzykrjr/NAfu
   jg1dqjz2mcuEvB2xQgW+TT6CQClkvl41edbRRXEP0C7VlpwZVvTOAO2wF
   Pi8MTeAZxjbYIjRNniyQbGMQo+jl/94TcjyvXisH7nLp4hep7XMAm/kpZ
   EKUZufwDwTG7Ig5MUFP0Jt6wHvt+dduBR9+waC2Y2IbdYs1PptKPrbwdJ
   RkyWSyFip77Bnc9cu5ZYbJ44W3i1NbO/y1GQrc426jYi5I8uVkKZRPds0
   ATGBEzVVPwlkeh/vvOSAqCkuc9pzJXrixLgJxHVpfvivUoN4OF3wkzKUy
   A==;
X-CSE-ConnectionGUID: ssgQITyNRx6ZynQqf5pUTQ==
X-CSE-MsgGUID: 8l0C6zRJT2W8y81E0WfGoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="58091230"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="58091230"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 04:18:47 -0700
X-CSE-ConnectionGUID: fnnEoCiMTQSop2hhxzLJeQ==
X-CSE-MsgGUID: wjKkp3DkT1ObmgtWs4FnkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="168588062"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 22 Aug 2025 04:18:45 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1upPn8-000LCN-2t;
	Fri, 22 Aug 2025 11:18:42 +0000
Date: Fri, 22 Aug 2025 19:18:16 +0800
From: kernel test robot <lkp@intel.com>
To: Taniya Das <quic_tdas@quicinc.com>
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Dmitry Baryshkov <lumag@kernel.org>
Subject: kismet: WARNING: unmet direct dependencies detected for QCS_GCC_615
 when selected by QCS_VIDEOCC_615
Message-ID: <202508221956.n9r5Ef2J-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3957a5720157264dcc41415fbec7c51c4000fc2d
commit: f6a8abe0cc16c44eda30712a8922261363d6d3ac clk: qcom: videocc-qcs615: Add QCS615 video clock controller driver
date:   5 weeks ago
config: arm-kismet-CONFIG_QCS_GCC_615-CONFIG_QCS_VIDEOCC_615-0-0 (https://download.01.org/0day-ci/archive/20250822/202508221956.n9r5Ef2J-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20250822/202508221956.n9r5Ef2J-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508221956.n9r5Ef2J-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for QCS_GCC_615 when selected by QCS_VIDEOCC_615
   WARNING: unmet direct dependencies detected for SM_GCC_6350
     Depends on [n]: COMMON_CLK [=y] && COMMON_CLK_QCOM [=y] && (ARM64 || COMPILE_TEST [=n])
     Selected by [y]:
     - SM_VIDEOCC_6350 [=y] && COMMON_CLK [=y] && COMMON_CLK_QCOM [=y]
   
   WARNING: unmet direct dependencies detected for QCS_GCC_615
     Depends on [n]: COMMON_CLK [=y] && COMMON_CLK_QCOM [=y] && (ARM64 || COMPILE_TEST [=n])
     Selected by [y]:
     - QCS_VIDEOCC_615 [=y] && COMMON_CLK [=y] && COMMON_CLK_QCOM [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

