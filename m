Return-Path: <linux-kernel+bounces-788886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0889B38BBF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 23:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DB3A3B17CC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 21:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3B830F920;
	Wed, 27 Aug 2025 21:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OEgEOQgj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28F32D0601
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 21:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756331926; cv=none; b=jwIhZwiTPrRnZdeOFOUMr6BRF0r3cPvmD13yeRMZYafTkUOUds5TtCxPs2rN6gIFthY6sSB5qAMSl0pp4es3j3WxLJ+WmQafOdf/z0jLoTVwbdUNobv/WjsULi6wTdms23hqnEelSpJ4h1uaNWA2ztH3XRltDwSbW9jD3MNobm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756331926; c=relaxed/simple;
	bh=YS6ot1jmwQhlh433tsFpYy/7s7M2yewP96Xw9GjQ0qM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jLM9+d189yhxCySEaVYqdAzeQGGbBGFRuu02Z8sGJfwDAVUNTT5BnypaAH3SFRXeTv0wknzOzjUCJ3S/fZzjY1OTXuAe1+tYZSZVwwORL6ZBxA6NWZkC/MyFeh2EOZhAKzFDI4c+PYFzbNklj3qrDTTbAQZCUifiaGwfSPb9i7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OEgEOQgj; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756331924; x=1787867924;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YS6ot1jmwQhlh433tsFpYy/7s7M2yewP96Xw9GjQ0qM=;
  b=OEgEOQgjPTrRQwFelWWTXyF7o3+7ZymCUcMSBc/CIEgMwOPE7Wf+xQLs
   HK7t+pM+QgTY2u6vZKuOd8LdAtkRwcazGW9SmfJ2G4brwh4EgaNJWntbq
   0geQsWBmE49HWhmZdoGf/34bg5oL53oZShxRCIDsMoQCa0Ghq9Y2LzE3k
   kLXieJZKUhKwV088CK/u/30WwlqqUohnDy4CJYwaKwp02kEcs1fL8YKbV
   h5HE7YbO+FQstVw3x3dzR1RIdiAUyTTlQfTOtRHjNjkBueg2HGQfT/8H5
   YO8KMCcPfkLgUN1NuVqhYqa/tCWRhFQDI/hdfb4Gt+yk5sLFQAX9w02mL
   Q==;
X-CSE-ConnectionGUID: kYh0ytZ6Ti+X9Lq6Jqvs1A==
X-CSE-MsgGUID: B5Ie6JSoTAmkRESqMuuqug==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62430999"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62430999"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 14:58:43 -0700
X-CSE-ConnectionGUID: 2mgufOTfRc6+uresMxp6sQ==
X-CSE-MsgGUID: 4RbBMExbRs6R2xyPE5Dk8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="169463537"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 27 Aug 2025 14:58:41 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1urOAB-000TFT-1e;
	Wed, 27 Aug 2025 21:58:39 +0000
Date: Thu, 28 Aug 2025 05:58:37 +0800
From: kernel test robot <lkp@intel.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Daniel Gomez <da.gomez@samsung.com>
Subject: ld.lld: error: Function Import: link error: linking module flags
 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at
 1395198), and 'i32 1' from vmlinux.a(ring_buffer.o at 1404378)
Message-ID: <202508280535.yj6qjEKj-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   39f90c1967215375f7d87b81d14b0f3ed6b40c29
commit: 818783c804bc051f7faf0ac226b5597f8259c6f8 module: make structure definitions always visible
date:   4 weeks ago
config: riscv-randconfig-r062-20250827 (https://download.01.org/0day-ci/archive/20250828/202508280535.yj6qjEKj-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project d26ea02060b1c9db751d188b2edb0059a9eb273d)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250828/202508280535.yj6qjEKj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508280535.yj6qjEKj-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 1395198), and 'i32 1' from vmlinux.a(skbuff.o at 1672878)
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 1395198), and 'i32 1' from vmlinux.a(trace.o at 1404438)
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 1395198), and 'i32 1' from vmlinux.a(mballoc.o at 1420038)
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 1395198), and 'i32 1' from vmlinux.a(filter.o at 1673958)
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 1395198), and 'i32 1' from vmlinux.a(core.o at 1405698)
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 1395198), and 'i32 1' from vmlinux.a(volumes.o at 1437858)
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 1395198), and 'i32 1' from vmlinux.a(segment.o at 1441758)
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 1395198), and 'i32 1' from vmlinux.a(file.o at 1441158)
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 1395198), and 'i32 1' from vmlinux.a(core.o at 1583358)
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 1395198), and 'i32 1' from vmlinux.a(memcontrol.o at 1410018)
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 1395198), and 'i32 1' from vmlinux.a(inode.o at 1419918)
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 1395198), and 'i32 1' from vmlinux.a(vmscan.o at 1406958)
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 1395198), and 'i32 1' from vmlinux.a(super.o at 1436718)
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 1395198), and 'i32 1' from vmlinux.a(data.o at 1441638)
>> ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 1395198), and 'i32 1' from vmlinux.a(ring_buffer.o at 1404378)
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 1395198), and 'i32 1' from vmlinux.a(super.o at 1441398)
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 1395198), and 'i32 1' from vmlinux.a(spi.o at 1591578)
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 1395198), and 'i32 1' from vmlinux.a(inode.o at 1437318)
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 1395198), and 'i32 1' from vmlinux.a(af_packet.o at 1677078)
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 1395198), and 'i32 1' from vmlinux.a(send.o at 1438998)
   ld.lld: error: too many errors emitted, stopping now (use --error-limit=0 to see all errors)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

