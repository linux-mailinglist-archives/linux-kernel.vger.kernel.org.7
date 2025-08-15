Return-Path: <linux-kernel+bounces-770236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A406B278C9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 08:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3CE71CE761D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 06:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BA8233722;
	Fri, 15 Aug 2025 06:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XQlNVCvS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E1F25522B
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 06:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755237958; cv=none; b=Qe3cAFs6O0H6UNBRNyC1mtbpoeALMJbSnf60Ph9ZZjIkhnuiibkdafmOHgC7WJCbTPsJUtuyOAnt07n4EUo/9BK0UkPP2yWO+jfznfOXJYs/vOVJRXe1L0gqqlGIpN4So3QIkSf+hJI/svDuvKA2Uzz/UuDIx3SGDuQRLo9lZKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755237958; c=relaxed/simple;
	bh=LBiAoKn0CwXipnStHcCoT1au5162yaJtR8KzRfSKBtU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nSxYLaIy2bWUcx5cAJ5hbR6j0wUn+6UuTlGTH2JQgHnUESQXaIit2MrGG2FPs7slL4l9kncyjqvh8K0leFXB5Z+NYwgcUD7YlSLo952JLmXB83FBvw9sDMmGXDOB+s7z+6Xfi7B6IA8DzoRMEVtRRDJo6kqzt/mJE4H0MNGYp6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XQlNVCvS; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755237957; x=1786773957;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LBiAoKn0CwXipnStHcCoT1au5162yaJtR8KzRfSKBtU=;
  b=XQlNVCvS/l4v5UI3t1+nX4moobBJ34DsfrAK9KM1zZM7TxMI0rgaBsUf
   JvCa50m4NQk0liLmRAqLhnutP5P6sONifXa4H0RzzqscbIlpk9ikZXRS/
   BVDFhXkS+H4y3KhOuC6nP3wj/EAdHU3GadepjK+bppVX99c2dpHEWSG6x
   iH0wRBl+KkrZMb7tqG3GIwia2FNfxNXD0o2i6KKcIk2/BOBKM02tkBGkW
   +C0bnTGXFsjsaNh21TsFoYKEYPmAibpysEfc9wUbDk1On+vmywBnZz0mb
   VEbvUfJ00NWQBF3UvE/+qFV7yf8bdYnHUf3uma2ynk87Mtje6lz/32e27
   A==;
X-CSE-ConnectionGUID: XNQULLHuSWmzEkvsRGPHpg==
X-CSE-MsgGUID: IUIiV6clTkGDO0AqUPjW+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="60189523"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="60189523"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 23:05:56 -0700
X-CSE-ConnectionGUID: gGmisOQxQ3OVdmevx3Y7Tw==
X-CSE-MsgGUID: siKOLZb4RdyRltKwM5Hsdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="167754944"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 14 Aug 2025 23:05:55 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1umnZZ-000Bd2-0A;
	Fri, 15 Aug 2025 06:05:53 +0000
Date: Fri, 15 Aug 2025 14:05:03 +0800
From: kernel test robot <lkp@intel.com>
To: "Lucien.Jheng" <lucienzx159@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>
Subject: ERROR: modpost: "clk_restore_context"
 [drivers/net/phy/air_en8811h.ko] undefined!
Message-ID: <202508151334.H4LiEA89-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d7ee5bdce7892643409dea7266c34977e651b479
commit: 6b9c9def95cb402374730d51a1f44927f467b774 net: phy: air_en8811h: Introduce resume/suspend and clk_restore_context to ensure correct CKO settings after network interface reinitialization.
date:   6 weeks ago
config: m68k-randconfig-r052-20250815 (https://download.01.org/0day-ci/archive/20250815/202508151334.H4LiEA89-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250815/202508151334.H4LiEA89-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508151334.H4LiEA89-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "clk_restore_context" [drivers/net/phy/air_en8811h.ko] undefined!
>> ERROR: modpost: "clk_save_context" [drivers/net/phy/air_en8811h.ko] undefined!
ERROR: modpost: "devm_clk_hw_register" [drivers/media/i2c/tc358746.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

