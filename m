Return-Path: <linux-kernel+bounces-833365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53AE8BA1C7E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 00:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DFF71C27FDC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 22:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718192E975A;
	Thu, 25 Sep 2025 22:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MPkSlNCh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA492417E6
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 22:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758839021; cv=none; b=RNqVPetxQllL2v3fBeohcETreWhLhh7LNozkllJ8N1wBfT08FnMSjA4qcxvYAxHbmIQSsHD1PbMuqdA0LdBfvuVMr5nO6Kbb3MKoTNpjgEVZohjfNI9Y0BdVKK/XTgrvkayt6cJlyva5eNT3dMYaBuxe8Whof4WAGiv66PXyP9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758839021; c=relaxed/simple;
	bh=jIe7vfmDi7K1zx02FuNXD3VGzvidWFcERk2Ws5eJ9N4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PhqPHEZM2kS1h4rDWURB56FR6xPh4O9DLhuslvrwLvJC0AfinAzPJPRkFMflfvbAFI3GaFJWeemjlR0WZW2XroAVX4BSo+Lm29Q0VLxEKupcdVazBOLBckWW3Ipm8G520Kuow6XyLet8VuBp1LJGbKdf+INgILJnGsicaKiqJSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MPkSlNCh; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758839020; x=1790375020;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jIe7vfmDi7K1zx02FuNXD3VGzvidWFcERk2Ws5eJ9N4=;
  b=MPkSlNCh7XkI+Yzu3+7/+SZILAM66RRcQn+OiQO6awF+StvzX5P2YH+a
   bcilTpux47jwwdym2gvLpToX9DzXOQjerrV3lHWlXn471p1E/xnte5Jh2
   6zAnwfRjte8liIgKXyU4fhzzuVvdAoX8A8Rp6aCETW/gadtQ0yfBxYsPt
   nDOQ+pn2k0SraTrz1EjzCEFw54qLOY/WOtdljWRAYqItJKqB8I9St5hNQ
   xxnlAZNDWyAo48uHhaBHJrsWm8vVLkfppPuTj0+lXnotMCadA/PGQ0KaE
   er2Eswce8zQJILQp/2K9InXg2t7vuphet2GXEIO1+1f8WSop+GB2oQOk5
   Q==;
X-CSE-ConnectionGUID: /TUmCqKPQJC7zHn/1NaidA==
X-CSE-MsgGUID: Fv065apAQxOuAlHI5ItiNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="65018475"
X-IronPort-AV: E=Sophos;i="6.18,293,1751266800"; 
   d="scan'208";a="65018475"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 15:23:39 -0700
X-CSE-ConnectionGUID: lrDsDJXhS8SPxjFdZriGyA==
X-CSE-MsgGUID: KL67rij4RySSLrx/7wqTCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,293,1751266800"; 
   d="scan'208";a="177386539"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 25 Sep 2025 15:23:38 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v1uNE-0005g5-0U;
	Thu, 25 Sep 2025 22:23:36 +0000
Date: Fri, 26 Sep 2025 06:23:33 +0800
From: kernel test robot <lkp@intel.com>
To: "Lucien.Jheng" <lucienzx159@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>
Subject: ERROR: modpost: "clk_save_context" [drivers/net/phy/air_en8811h.ko]
 undefined!
Message-ID: <202509260628.qI8DFQp5-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Lucien.Jheng,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4ff71af020ae59ae2d83b174646fc2ad9fcd4dc4
commit: 6b9c9def95cb402374730d51a1f44927f467b774 net: phy: air_en8811h: Introduce resume/suspend and clk_restore_context to ensure correct CKO settings after network interface reinitialization.
date:   3 months ago
config: sh-randconfig-002-20250926 (https://download.01.org/0day-ci/archive/20250926/202509260628.qI8DFQp5-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250926/202509260628.qI8DFQp5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509260628.qI8DFQp5-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "clk_save_context" [drivers/net/phy/air_en8811h.ko] undefined!
ERROR: modpost: "clk_restore_context" [drivers/net/phy/air_en8811h.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

