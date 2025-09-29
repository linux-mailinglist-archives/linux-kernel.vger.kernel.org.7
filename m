Return-Path: <linux-kernel+bounces-835976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E673FBA87C9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 10:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 961E617558C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 08:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F652C11CC;
	Mon, 29 Sep 2025 08:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MHoEB2x2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7380627A900
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 08:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759136304; cv=none; b=G2r49PGo16XiaDdLH6JaWjsUyHhnqDNUNq/JBKTw/P6VVcVMI1C70A+jooTRz+zjvt6/27Y1sa015Wmir+rApgoAlnn3ngm1xdaQlSO/EObM1EqpUX7cosSivq4Dh/xqtlaRbq2By0l4O50sGdBy3F2YGcdEDgLp3GxTwsoLqaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759136304; c=relaxed/simple;
	bh=gri6s986biB8Kh7dNTb+spkZYh/NMeucGz4PK0la17g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LxMTISYCKaUM6bgnjJq90XCHVVRBZlyM6N8XQc1Qm0+z56+F6sIDDW9H9zFyKXK+ILG0PF4Dfb2XVSxCZ+Y6FNI+lRN3mZUmAbcXj9kPYk0XQcJvwj1HBRt1mayKAJOPqnQ8sXgjEbUJIeaBJls4MfV4qs83kIA2xufrpvz6D/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MHoEB2x2; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759136303; x=1790672303;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gri6s986biB8Kh7dNTb+spkZYh/NMeucGz4PK0la17g=;
  b=MHoEB2x2lNxaMMSGT8dw8LBm7OqpJANSUq/vdbYmmhUqkACLwtUTDlUv
   wuLm2fDoIhZhuVbDOB1EJ5JF0ErzVIIJ+rUZJQpddPjrxBJ7DIR9mHMMF
   wYQGoG9LndWt+iHEb4Cccs7l2JFpUbdmxHPyVELyEbrO8Y6zwoWcUo2B0
   T2lqTcYdWtxz+kgjr/REM0eCOtUI9r4CHv0Eq5oydejEzblZIlz5nADLz
   iPBSGRpzR7F6QmI3JtZ36PI9j38cnYxk5vjKy5hYFyf5EKAOF/RbeyKV5
   NDeheJ1ZtX28h5+sZI67KWIF5KM7n+ACx/6YtZNl613JfFXMSDA5S3yFZ
   g==;
X-CSE-ConnectionGUID: aFSin5zWRK6NElEOy6RowA==
X-CSE-MsgGUID: TgiVFPFlRD6cIc1MRoabgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="61284633"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="61284633"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 01:58:22 -0700
X-CSE-ConnectionGUID: LS+k10G/S/iCbuT4y5TybQ==
X-CSE-MsgGUID: UZqgD/9ZTNqJN/exuTkwXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; 
   d="scan'208";a="177437977"
Received: from lkp-server01.sh.intel.com (HELO 2f2a1232a4e4) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 29 Sep 2025 01:58:21 -0700
Received: from kbuild by 2f2a1232a4e4 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v39i6-00005P-0v;
	Mon, 29 Sep 2025 08:58:18 +0000
Date: Mon, 29 Sep 2025 16:57:35 +0800
From: kernel test robot <lkp@intel.com>
To: Eric Dumazet <edumazet@google.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>
Subject: include/net/sock.h:2098:16: sparse: sparse: cast to non-scalar
Message-ID: <202509291645.fcBIaXMb-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e5f0a698b34ed76002dc5cff3804a61c80233a7a
commit: c51da3f7a161c6822232be832abdffe47eb55b4c net: remove sock_i_uid()
date:   3 months ago
config: alpha-randconfig-r122-20250929 (https://download.01.org/0day-ci/archive/20250929/202509291645.fcBIaXMb-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250929/202509291645.fcBIaXMb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509291645.fcBIaXMb-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   net/packet/diag.c: note: in included file (through include/linux/sock_diag.h):
>> include/net/sock.h:2098:16: sparse: sparse: cast to non-scalar
   include/net/sock.h:2098:16: sparse: sparse: cast from non-scalar
--
   net/packet/af_packet.c:1099:13: sparse: sparse: context imbalance in '__packet_lookup_frame_in_block' - different lock contexts for basic block
   net/packet/af_packet.c:2541:17: sparse: sparse: context imbalance in 'tpacket_rcv' - unexpected unlock
   net/packet/af_packet.c: note: in included file (through include/net/inet_sock.h, include/net/ip.h):
>> include/net/sock.h:2098:16: sparse: sparse: cast to non-scalar
   include/net/sock.h:2098:16: sparse: sparse: cast from non-scalar

vim +2098 include/net/sock.h

^1da177e4c3f415 Linus Torvalds 2005-04-16  2094  
e84a4927a404f36 Eric Dumazet   2025-06-20  2095  static inline kuid_t sk_uid(const struct sock *sk)
e84a4927a404f36 Eric Dumazet   2025-06-20  2096  {
e84a4927a404f36 Eric Dumazet   2025-06-20  2097  	/* Paired with WRITE_ONCE() in sockfs_setattr() */
e84a4927a404f36 Eric Dumazet   2025-06-20 @2098  	return READ_ONCE(sk->sk_uid);
e84a4927a404f36 Eric Dumazet   2025-06-20  2099  }
e84a4927a404f36 Eric Dumazet   2025-06-20  2100  

:::::: The code at line 2098 was first introduced by commit
:::::: e84a4927a404f369c842c19de93b216627fcc690 net: annotate races around sk->sk_uid

:::::: TO: Eric Dumazet <edumazet@google.com>
:::::: CC: Jakub Kicinski <kuba@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

