Return-Path: <linux-kernel+bounces-882389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 926C1C2A509
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 08:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BE60188E5D7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 07:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55A02505A5;
	Mon,  3 Nov 2025 07:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jLJGRpsV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B30A1E8836
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 07:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762154850; cv=none; b=OzbDPiTwUNfvmHLr/lT/AJLfmmHxhtFF1gXQ7suuAOLarAFop0UMKxlxumt07so3N34nLi1rHlMJVNos/FuofwQfZ9zfGNxXo+UkhHiq7R68Y/aCmMaQn06xSTI4R7Jt0oQWhsZm/kTz3b2crL1HuT+1P8WcLIu+7w9zDTeeftw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762154850; c=relaxed/simple;
	bh=nzaQiu5g5btPzsTSXEz5VWTAr43hXLYuV1koD2fqJ0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pPQ890cGuiO4aLcUsuWGGsqX1RsYEjU6z9AwHkPj9csqObltUMOANq8PxloLVIETCTJrhelgIuSyVZLd8/FPTfkrfR5vnB7M5JXqkySG2GlDx0U3stAbvpWZaM60DhE1o1/v/SuNSJ/qHT9Mx1GGr+AG3O53jq9u+sGCvYt/7KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jLJGRpsV; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762154849; x=1793690849;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nzaQiu5g5btPzsTSXEz5VWTAr43hXLYuV1koD2fqJ0Q=;
  b=jLJGRpsV/0D9HYWkRD2KVQPFTKGHIPxVEtg6zHbNp++/o8RRZqAhvx8z
   uj2HVqtUBMUlJVwM533uKg7owDxIRKrmhenU7v3hw5F/wE0QHNFW6Si8+
   G7cQ7FLMLTvOlg92PE6+W1DTKmm65BnkkZRfxaVW+MaNhenbZPCC2l3DS
   6ybAsfsNOdN8Nv/llxLl61ghe2B0KMFxaK/M2fBj64KVu44D3QfNl0cjz
   722yZwHOEz66vIRp1xlw18kZIcm/+ij+qy8Rt/4C+3Ir9Jr5KE5qj3Uj+
   ZBCSTHdpy6IOgtJ/++Xd8UUXGhDyqkRmLhmX2vgePK4NJZI84vxt1bZm2
   w==;
X-CSE-ConnectionGUID: rJGt4qplQDKmysixVzjJHA==
X-CSE-MsgGUID: 6/syA9lKTui3i6F6ZMvrMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11601"; a="63920997"
X-IronPort-AV: E=Sophos;i="6.19,275,1754982000"; 
   d="scan'208";a="63920997"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2025 23:27:28 -0800
X-CSE-ConnectionGUID: T/UWRU6iRqW85XXHZCFzxg==
X-CSE-MsgGUID: kh48bj4OTBW8CFF3Q6SJrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,275,1754982000"; 
   d="scan'208";a="217431536"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 02 Nov 2025 23:27:27 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vFoyK-000Puh-1Y;
	Mon, 03 Nov 2025 07:27:24 +0000
Date: Mon, 3 Nov 2025 15:26:57 +0800
From: kernel test robot <lkp@intel.com>
To: Eric Dumazet <edumazet@google.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>
Subject: include/net/sock.h:2098:16: sparse: sparse: cast to non-scalar
Message-ID: <202511031542.oqD6ABwP-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6146a0f1dfae5d37442a9ddcba012add260bceb0
commit: c51da3f7a161c6822232be832abdffe47eb55b4c net: remove sock_i_uid()
date:   4 months ago
config: alpha-randconfig-r131-20251103 (https://download.01.org/0day-ci/archive/20251103/202511031542.oqD6ABwP-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251103/202511031542.oqD6ABwP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511031542.oqD6ABwP-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   net/bluetooth/af_bluetooth.c:248:25: sparse: sparse: context imbalance in 'bt_accept_enqueue' - different lock contexts for basic block
   net/bluetooth/af_bluetooth.c: note: in included file (through include/net/bluetooth/bluetooth.h):
>> include/net/sock.h:2098:16: sparse: sparse: cast to non-scalar
   include/net/sock.h:2098:16: sparse: sparse: cast from non-scalar

vim +2098 include/net/sock.h

^1da177e4c3f41 Linus Torvalds 2005-04-16  2094  
e84a4927a404f3 Eric Dumazet   2025-06-20  2095  static inline kuid_t sk_uid(const struct sock *sk)
e84a4927a404f3 Eric Dumazet   2025-06-20  2096  {
e84a4927a404f3 Eric Dumazet   2025-06-20  2097  	/* Paired with WRITE_ONCE() in sockfs_setattr() */
e84a4927a404f3 Eric Dumazet   2025-06-20 @2098  	return READ_ONCE(sk->sk_uid);
e84a4927a404f3 Eric Dumazet   2025-06-20  2099  }
e84a4927a404f3 Eric Dumazet   2025-06-20  2100  

:::::: The code at line 2098 was first introduced by commit
:::::: e84a4927a404f369c842c19de93b216627fcc690 net: annotate races around sk->sk_uid

:::::: TO: Eric Dumazet <edumazet@google.com>
:::::: CC: Jakub Kicinski <kuba@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

