Return-Path: <linux-kernel+bounces-881149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D3952C2790F
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 08:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 54F3D4E30C5
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 07:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1AE29992A;
	Sat,  1 Nov 2025 07:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="csEYfitd"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5089634D389
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 07:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761982573; cv=none; b=qCWD4TrePTlH1LMKV8C9E7ur8TUM0TNWdemI36NAVeRSbfhXePLXYwX6immnzpQqgeV984y3luGmH6bkBanCYGNyoepsEUJtqbd15yKnD7qCHEpnTrVomjq0EAn7ZuIPnxMI+7CNKylyy/czwPJETCyrhtRzkjCXsvAcCNgZJmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761982573; c=relaxed/simple;
	bh=2VdscPC7pHDwv0/PiRnBKewiLHLlkoj22vBUnc0cpXs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Y7V4LchfpOQbDSa9pcAMJP+r7MrwtdN/YEjjG1cFMDxrjzAw9cyPEEKJgY+k2wwZsvuFUWm3HRirtJHuS/qYIc2fKZ8VG+v7w0FxocGkB0NTV7gVJFFmztOkOtgn4xUpHYll9BIUWuIrXy3cVZa+twgpopatNAj8XREWL6pprwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=csEYfitd; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761982571; x=1793518571;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2VdscPC7pHDwv0/PiRnBKewiLHLlkoj22vBUnc0cpXs=;
  b=csEYfitddaLqZbDc7y+pQ2sDVHXO5IPww/mC15rcEVv6Cdz2n+Z6/Ul8
   pnyP0KzFqez6Y6GcnvkLWWADOzaDaRW6Kxuy3s4OYSxFlg0qmIz4eHAp1
   TApmDtww5oVebIkfnL6LdtNoy0DUd9Q2WWr5hL7TE+yXb3+qoSeLtD6tS
   9X0C1E7ECO90tTypNHE/16d8oA1qsNzLqbfBy93noV97GbjVf19/M+mq0
   qWeSNXosKa3c8FCx3B9HjO8QyTThh5XlsBdLcxYRbl9IN48MQQEucIcVr
   36MvybdVdf/XVOhZ8RWFaJIDFl0hidfdaNW4EXvqDuFqyFl2cI6wyIIJk
   g==;
X-CSE-ConnectionGUID: p9frkROzQPCWxzhBj0JjEw==
X-CSE-MsgGUID: kPaPgla9T2aWgz+bop7R0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64042575"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64042575"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2025 00:36:09 -0700
X-CSE-ConnectionGUID: 2wZYMgcDTG6ACTMrPwVJ8A==
X-CSE-MsgGUID: b5y0npAAQJmutDCAcYhFlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,271,1754982000"; 
   d="scan'208";a="190761705"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 01 Nov 2025 00:36:08 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vF69d-000O00-27;
	Sat, 01 Nov 2025 07:36:05 +0000
Date: Sat, 1 Nov 2025 15:35:47 +0800
From: kernel test robot <lkp@intel.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Simon Horman <horms@kernel.org>
Subject: drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c:3938:28: error: no
 member named 'ixgbe_dbg_adapter' in 'struct ixgbe_adapter'
Message-ID: <202511011546.mIG3y3Pt-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Michal,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ba36dd5ee6fd4643ebbf6ee6eefcecf0b07e35c7
commit: 641585bc978e0a1170ca8f12fbb1468b3874a2db ixgbe: fwlog support for e610
date:   7 weeks ago
config: powerpc-skiroot_defconfig (https://download.01.org/0day-ci/archive/20251101/202511011546.mIG3y3Pt-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project cc271437553452ede002d871d32abc02084341a8)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251101/202511011546.mIG3y3Pt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511011546.mIG3y3Pt-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c:3938:28: error: no member named 'ixgbe_dbg_adapter' in 'struct ixgbe_adapter'
    3938 |                 .debugfs_root = adapter->ixgbe_dbg_adapter,
         |                                 ~~~~~~~  ^
   1 error generated.


vim +3938 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c

  3931	
  3932	int ixgbe_fwlog_init(struct ixgbe_hw *hw)
  3933	{
  3934		struct ixgbe_adapter *adapter = hw->back;
  3935		struct libie_fwlog_api api = {
  3936			.pdev = adapter->pdev,
  3937			.send_cmd = __fwlog_send_cmd,
> 3938			.debugfs_root = adapter->ixgbe_dbg_adapter,
  3939			.priv = hw,
  3940		};
  3941	
  3942		if (hw->mac.type != ixgbe_mac_e610)
  3943			return -EOPNOTSUPP;
  3944	
  3945		return libie_fwlog_init(&hw->fwlog, &api);
  3946	}
  3947	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

