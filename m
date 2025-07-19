Return-Path: <linux-kernel+bounces-737830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED04B0B109
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 19:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA57C1890F7E
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 17:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4EE223DCB;
	Sat, 19 Jul 2025 17:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DSce1eaX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4DB126BF7
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 17:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752945287; cv=none; b=sLsjgbmwLHdOLssYMA+26AaVdReInFBKs31PX3VojT3gdsmk5QWiGorkeBbqdK3fdpMvbgkrU4rDTnGeFkyqZ4+9kh5RyJyDvTpEUuKMXKfbGZcaq2D3hkRZyAFqjgrYjE/BZPgG+NOshpaSE86ApxI18m48VK4Fxk2CUCsQY2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752945287; c=relaxed/simple;
	bh=UfQcBFSWP95PUs/nVA/Kz8WApUEFDeSsM8pAew/vHMc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lDuDOYYaXfSSi/Rxj/bHCG01T8zy4O5NUUKaMlwQ548heRycaNeg9pohfFhsZg2DJRCGjoanGSHTnfowyxQnIS+hSvQ5odS2GjGobxnx9u01K8XiO6xtEVFhCtx0nwP7/w0my56Oc9f3b6kW+7xIjiuC7hoQPr7r2OiyK211VlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DSce1eaX; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752945284; x=1784481284;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UfQcBFSWP95PUs/nVA/Kz8WApUEFDeSsM8pAew/vHMc=;
  b=DSce1eaXD24tjOMrySohNU2KpQ/80rcq3pEnidURyuHN02S8YAhvtF4l
   /ZCz/a0JnX6MGgJBiW1LvFku6oNUFN/xzTqhBwJHfhknoNxuIQRcr3a58
   KhIBkN/5tHov2saWDh6zZOCAHK7ylZIgLcb5P/mqNsi2gdyqPgZ+gvKQx
   5xGQiGAoLhpS7/a8MGJajc8EjZJzVdI5Z/8nTipEhCg7LcVCuZH+zc8Ej
   sEBCXyqSrLiPWnBuEeqc6+Qlt06hgDi1JxQit40przVesqu/FefAXDRkl
   nbw/uI/1YzttwvCWtbxFnsJONHWiWzfNaNXnLckpVrroXI7ijlcAdLuPP
   Q==;
X-CSE-ConnectionGUID: CGvw9BtSRca14eoqzTbZzA==
X-CSE-MsgGUID: /5YGExpfSiGv7kQQJ2Rfug==
X-IronPort-AV: E=McAfee;i="6800,10657,11497"; a="54422119"
X-IronPort-AV: E=Sophos;i="6.16,324,1744095600"; 
   d="scan'208";a="54422119"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2025 10:14:43 -0700
X-CSE-ConnectionGUID: yYzlwDheQ+68C/u8J98ekA==
X-CSE-MsgGUID: XLqkc5uSTQylYxA8XzX4Jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,324,1744095600"; 
   d="scan'208";a="195547031"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 19 Jul 2025 10:14:42 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1udB8x-000Ff9-2y;
	Sat, 19 Jul 2025 17:14:39 +0000
Date: Sun, 20 Jul 2025 01:14:03 +0800
From: kernel test robot <lkp@intel.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: ld.lld: warning: src/consumer/drivers/iio/accel/sca3000.c:1448:0:
 stack frame size (8312) exceeds limit (8192) in function 'sca3000_probe'
Message-ID: <202507200127.fScR1DwJ-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4871b7cb27f480f6ecce804f81d4b9ee27281dd2
commit: 020d7f14489b8bc38c6bd4c5b3c25262e8b6de63 Revert "kbuild: make all file references relative to source root"
date:   10 weeks ago
config: x86_64-randconfig-075-20250719 (https://download.01.org/0day-ci/archive/20250720/202507200127.fScR1DwJ-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250720/202507200127.fScR1DwJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507200127.fScR1DwJ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> ld.lld: warning: src/consumer/drivers/iio/accel/sca3000.c:1448:0: stack frame size (8312) exceeds limit (8192) in function 'sca3000_probe'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

