Return-Path: <linux-kernel+bounces-754666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B93B19AA2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 06:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7CE33B73D0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 04:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B696D1A5B84;
	Mon,  4 Aug 2025 04:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D2RD02zh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB6A28682
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 04:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754280221; cv=none; b=eMGnGU89thdsIKmeiQRHEqfEznCHFzLn1O9WehjZxi02kV65IWTBN2Zxt91dc/VimxyVurVTDqXH14NH0Adi44PtaFG5OQu//aN7Nx7UeUH/9JHw5NJKMcx2NEWC7dEgfcGI18WYrd96zBb5FJhZUP9kXuzRNA5A9pJnHiyfGJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754280221; c=relaxed/simple;
	bh=mnUD4pinVXTUVxuvkFkoumqCrbHqzWsnLZoK8WbFYjo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QlU5yHpFCkXkvO9eRBQQKX3TO2PIq7iBcED0nutzFKeZbflZlmtRcYsPA6ETmJtOiD+jW3Mi1TIgAnVa+biWynumBbDi9S64YvuM7ihINlau6q6LWog4HRt/a+HVuaVYwnaCRERzwCsGbIXUmISfl+Y9b2Ls8QSfDD2Zp18p3bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D2RD02zh; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754280219; x=1785816219;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mnUD4pinVXTUVxuvkFkoumqCrbHqzWsnLZoK8WbFYjo=;
  b=D2RD02zhwlEE//oq48jGN1PSyBsDPbpNrJB3eeG5LLYkxxcyFFRJ8lyR
   6CdFn1myHDdlGm2AReosKVvUz5TzPAgdz/ByxoDyaJEzkgT60jyrY40c2
   GDC+PfIv6tYHxaZo06taRKKYvNAkEYqGHytW9e+U8lWDaKY+sViTippdK
   M60YQ90KKLg8osYkHxvqN0EmstWdfOGI8bPD5VwdHOOtY3vUJ3g7WKYVy
   GK5s3GtoLj3uUskD/qJAuSxIEJ04sMWeXvoTEQo1cYmzg+LidDxlYi2tH
   Jm4yeQKL55bE/2IMpZbOZ7Ee7L7P1iEpob0Y5wHgxj+Oie3cY7eiUeAw7
   w==;
X-CSE-ConnectionGUID: Q84/5vjAS92Tmk9Lk9w4Eg==
X-CSE-MsgGUID: cKH4yoyuQhme3685I+iJtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11511"; a="56492709"
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="56492709"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2025 21:03:39 -0700
X-CSE-ConnectionGUID: r3KncWg2TXydEGgwYV6T6A==
X-CSE-MsgGUID: l3m/ehHTTvyZ+n6rB2ujEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="194989529"
Received: from igk-lkp-server01.igk.intel.com (HELO b3b7d4258b7c) ([10.91.175.65])
  by orviesa002.jf.intel.com with ESMTP; 03 Aug 2025 21:03:38 -0700
Received: from kbuild by b3b7d4258b7c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uimQB-0001j9-1C;
	Mon, 04 Aug 2025 04:03:35 +0000
Date: Mon, 4 Aug 2025 06:03:00 +0200
From: kernel test robot <lkp@intel.com>
To: "Lucien.Jheng" <lucienzx159@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>
Subject: air_en8811h.c:undefined reference to `clk_restore_context'
Message-ID: <202508040641.2jSvUzIC-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d2eedaa3909be9102d648a4a0a50ccf64f96c54f
commit: 6b9c9def95cb402374730d51a1f44927f467b774 net: phy: air_en8811h: Introduce resume/suspend and clk_restore_context to ensure correct CKO settings after network interface reinitialization.
date:   5 weeks ago
config: m68k-randconfig-2002-20250804 (https://download.01.org/0day-ci/archive/20250804/202508040641.2jSvUzIC-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250804/202508040641.2jSvUzIC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508040641.2jSvUzIC-lkp@intel.com/

All errors (new ones prefixed by >>):

   m68k-linux-ld: drivers/net/phy/air_en8811h.o: in function `en8811h_resume':
>> air_en8811h.c:(.text+0x6d0): undefined reference to `clk_restore_context'
   m68k-linux-ld: drivers/net/phy/air_en8811h.o: in function `en8811h_suspend':
>> air_en8811h.c:(.text+0x6e8): undefined reference to `clk_save_context'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

