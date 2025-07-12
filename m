Return-Path: <linux-kernel+bounces-728514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D495B0292E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 05:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A67A81BC4482
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 03:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D091EFFB4;
	Sat, 12 Jul 2025 03:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P1YT4k87"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FEF1B95B
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 03:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752291715; cv=none; b=A2R6cVNTdrNALrU2IgSCNSlR6n8D6AkWT4FYiPvBQcf5SBwv9761J5lknFGkhSjY2MdKdauqw153n5JH/q4YWnN76OP9daBIO38OanvG0x3dBXUtAwCKXaJ1FHVguZG8n5K4gc5GGIrUiivX2UGF3yBA6bbj1LLgBn7Wxh3sbG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752291715; c=relaxed/simple;
	bh=PYtHK6HHk2+ipZs1WMi3j98IKI4SUeUEw+9/OUCS3Ms=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Z1Pe7uCUsXlZTPqDLWzvMKMKeyiGPxhubFyzfggeETijbyKh5OweqyXtbB7rfqpp6GZK3lmALS47DYdgthqeZ1ZeDy35BTvUT+/Zw5mJIL5pQhsAxhFN9JfvUlFvJhfdWHg87hi1XbCG2llL5EmU4NfgDvzznhl0R8iI9kQdlz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P1YT4k87; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752291714; x=1783827714;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PYtHK6HHk2+ipZs1WMi3j98IKI4SUeUEw+9/OUCS3Ms=;
  b=P1YT4k87QhkQXuLu8+tmAz44uW9PZ3i2OxwKyrOajS1mG5rUcWSXLIHt
   BNZa1JCNgtzSXfvEj6vr/l6creTKnU0VaWrzXqr2tqntT4ikpFAsdOs45
   0HFF4LYvWJ3bL8sIDtJ9GvRAh3QThDzesNGk85ZW1TYZCKcbaARJG05YE
   JLwtC+18NEa6mvqu0ttyhHN6ijFSb9Jk6oy65wRWeLalil+jIrEWID++p
   i94XRwiWtPl0LTRps7tpKKYkieWNpdp2d/1cHhEvz5sRQQ+iqsT0Mis+a
   +s0Er5dy2vs7BFC+tyJCSlcEwiXYLBOBGOclJbEiXpEx6ZH/TvdEedrhU
   A==;
X-CSE-ConnectionGUID: QkspaomjQcuDHnFL7QCkEA==
X-CSE-MsgGUID: RBRyJHiJRqmdRJ4d7SaTvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="65161948"
X-IronPort-AV: E=Sophos;i="6.16,305,1744095600"; 
   d="scan'208";a="65161948"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 20:41:53 -0700
X-CSE-ConnectionGUID: zav6BZglReamJs4W24KpAw==
X-CSE-MsgGUID: tquxEl8gTpqbwyqZLNgl5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,305,1744095600"; 
   d="scan'208";a="162075301"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 11 Jul 2025 20:41:52 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uaR7V-00071z-2C;
	Sat, 12 Jul 2025 03:41:49 +0000
Date: Sat, 12 Jul 2025 11:41:27 +0800
From: kernel test robot <lkp@intel.com>
To: Petr Machata <petrm@nvidia.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	David Ahern <dsahern@kernel.org>
Subject: include/net/ip_fib.h:539:19: sparse: sparse: cast to non-scalar
Message-ID: <202507121128.3JqKpsLP-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   379f604cc3dc2c865dc2b13d81faa166b6df59ec
commit: 4ee2a8cace3fb9a34aea6a56426f89d26dd514f3 net: ipv4: Add a sysctl to set multipath hash seed
date:   1 year, 1 month ago
config: alpha-randconfig-r132-20250712 (https://download.01.org/0day-ci/archive/20250712/202507121128.3JqKpsLP-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.4.0
reproduce: (https://download.01.org/0day-ci/archive/20250712/202507121128.3JqKpsLP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507121128.3JqKpsLP-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   net/ipv6/route.c:2342:39: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] flow_label @@     got restricted __be32 @@
   net/ipv6/route.c:2342:39: sparse:     expected unsigned int [usertype] flow_label
   net/ipv6/route.c:2342:39: sparse:     got restricted __be32
   net/ipv6/route.c: note: in included file (through include/linux/mroute_base.h, include/linux/mroute6.h):
>> include/net/ip_fib.h:539:19: sparse: sparse: cast to non-scalar
>> include/net/ip_fib.h:539:19: sparse: sparse: cast from non-scalar
>> include/net/ip_fib.h:539:19: sparse: sparse: cast to non-scalar
>> include/net/ip_fib.h:539:19: sparse: sparse: cast from non-scalar
>> include/net/ip_fib.h:539:19: sparse: sparse: cast to non-scalar
>> include/net/ip_fib.h:539:19: sparse: sparse: cast from non-scalar
>> include/net/ip_fib.h:539:19: sparse: sparse: cast to non-scalar
>> include/net/ip_fib.h:539:19: sparse: sparse: cast from non-scalar
>> include/net/ip_fib.h:539:19: sparse: sparse: cast to non-scalar
>> include/net/ip_fib.h:539:19: sparse: sparse: cast from non-scalar
>> include/net/ip_fib.h:539:19: sparse: sparse: cast to non-scalar
>> include/net/ip_fib.h:539:19: sparse: sparse: cast from non-scalar

vim +539 include/net/ip_fib.h

   532	
   533	static inline u32 fib_multipath_hash_from_keys(const struct net *net,
   534						       struct flow_keys *keys)
   535	{
   536		siphash_aligned_key_t hash_key;
   537		u32 mp_seed;
   538	
 > 539		mp_seed = READ_ONCE(net->ipv4.sysctl_fib_multipath_hash_seed).mp_seed;
   540		fib_multipath_hash_construct_key(&hash_key, mp_seed);
   541	
   542		return flow_hash_from_keys_seed(keys, &hash_key);
   543	}
   544	#else
   545	static inline u32 fib_multipath_hash_from_keys(const struct net *net,
   546						       struct flow_keys *keys)
   547	{
   548		return flow_hash_from_keys(keys);
   549	}
   550	#endif
   551	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

