Return-Path: <linux-kernel+bounces-771658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C85FBB28A21
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 05:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61CB9AC1FDB
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 03:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FF9199931;
	Sat, 16 Aug 2025 03:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eIJrHw4F"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33EB42AA1
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 03:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755313439; cv=none; b=Tw2mXgH7rp/v6rWrrNbOa4uYPNJrzy7UUXTzf5rgwxBtdvt858vUMUZQ+l2xEBZkfUED9JU2tuUQ29xfEpTSsv4rWi0mKRaLtoVbFnmCl6INg8iTeAVoL8vFCkDG4wDym1xLYN1GYQQc2/WeTYbi1CIDO8huMNsDKPdn1Itam48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755313439; c=relaxed/simple;
	bh=fNqSDaRVocB5RlcNtWo+wuUcmCWPT4lkhysov/vkiUE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZDLFRvbfPjJNDltDfgXwLwfWCJh2zCl2lC8kBXpeouKGYf1tjQVqvR25gWI8NL7PubGyv8ZlV5+qT2T728qv6MBxR2CUjranWlMXSoDPz/e6ALPedNUTICpF9BRwTPdwUU41TE+nrGTgp3RdT7RCfjeEQx3OKSZdstaxNgE3gaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eIJrHw4F; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755313437; x=1786849437;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fNqSDaRVocB5RlcNtWo+wuUcmCWPT4lkhysov/vkiUE=;
  b=eIJrHw4Ft3FQZpBdJXoa8idnmr7eXvY4CfMb7kqkQpFdGsRCY6uK/9fr
   cTg64cOuslwDqQjTEDyYQ3fH+HWdBweDuk5gnjjeBMl+USgDBuZgL8YYO
   VUw3OfeOSjV56Hql2r7jjVvkbOkrHPK5RnlsGGvb7sYrCRaplDz2fzvag
   i2aHxxbwN9WMEDv8OwsxmZL/BWarUPJJNHcrRbtrGuChsiA7Fo4CUu3Jf
   ZrgjGCGgzRZq72uDn2vFaljp/s0CG6iXkX5gs3GbYpDKf80PJMLC/ATaG
   bKQlUdeMdDVUWYg/RaJ9U3XD1dB5rE4WJUZwjGwEgW9NX3D45eV1TIROS
   Q==;
X-CSE-ConnectionGUID: hezuoe40TyymYtDgtX4V9w==
X-CSE-MsgGUID: bEz1BBD8SqODMOCu6ChOcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11523"; a="57557768"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="57557768"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 20:03:56 -0700
X-CSE-ConnectionGUID: 00KgoiPsTbuYFnk5mlTh+g==
X-CSE-MsgGUID: t0twjbp9RhiSH7UJnyfUYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="172360186"
Received: from igk-lkp-server01.igk.intel.com (HELO ca260db0ef79) ([10.91.175.65])
  by fmviesa004.fm.intel.com with ESMTP; 15 Aug 2025 20:03:55 -0700
Received: from kbuild by ca260db0ef79 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1un7Cz-0000et-0S;
	Sat, 16 Aug 2025 03:03:53 +0000
Date: Sat, 16 Aug 2025 05:03:50 +0200
From: kernel test robot <lkp@intel.com>
To: Nick Terrell <terrelln@meta.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: ERROR: modpost: "__st_r13_to_r15" [lib/zstd/zstd_decompress.ko]
 undefined!
Message-ID: <202508160533.gJesbe9d-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Nick,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dfd4b508c8c6106083698a0dd5e35aecc7c48725
commit: 65d1f5507ed2c78c64fce40e44e5574a9419eb09 zstd: Import upstream v1.5.7
date:   5 months ago
config: arc-randconfig-2006-20250816 (https://download.01.org/0day-ci/archive/20250816/202508160533.gJesbe9d-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 12.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250816/202508160533.gJesbe9d-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508160533.gJesbe9d-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

ERROR: modpost: "__ld_r13_to_r23_ret" [lib/zstd/zstd_decompress.ko] undefined!
ERROR: modpost: "__st_r13_to_r22" [lib/zstd/zstd_decompress.ko] undefined!
ERROR: modpost: "__ld_r13_to_r16_ret" [lib/zstd/zstd_decompress.ko] undefined!
ERROR: modpost: "__ld_r13_to_r19_ret" [lib/zstd/zstd_decompress.ko] undefined!
ERROR: modpost: "__ld_r13_to_r22_ret" [lib/zstd/zstd_decompress.ko] undefined!
>> ERROR: modpost: "__st_r13_to_r15" [lib/zstd/zstd_decompress.ko] undefined!
ERROR: modpost: "__st_r13_to_r16" [lib/zstd/zstd_decompress.ko] undefined!
ERROR: modpost: "__st_r13_to_r24" [lib/zstd/zstd_decompress.ko] undefined!
ERROR: modpost: "__st_r13_to_r19" [lib/zstd/zstd_decompress.ko] undefined!
>> ERROR: modpost: "__st_r13_to_r23" [lib/zstd/zstd_decompress.ko] undefined!
WARNING: modpost: suppressed 7 unresolved symbol warnings because there were too many)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

