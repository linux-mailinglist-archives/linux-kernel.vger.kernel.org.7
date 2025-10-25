Return-Path: <linux-kernel+bounces-869688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5F9C08826
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 03:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43FCF1889B8A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 01:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8A2221DAE;
	Sat, 25 Oct 2025 01:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TvLi/4NF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDA8220F38
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 01:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761356699; cv=none; b=kO9gyk12GgN+o8TSR0SyvKKW8Ry8300Ck6bsN0nv8LOMPbrkHSQHzL/CKAJJzMtIV40ELvfRvT1s52ASP00QNPn3mkedbf2+KBmclydmxycHYj9bsYRqZ2FzryJd36tog3i4EF50IDSs9bubMI5GfWVQeuirhCZpQ+Gj3JPh6Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761356699; c=relaxed/simple;
	bh=+Fu5OgTDIZIRAtIoJ7xpHPgfs7GVRyqQ9fmPndTdNj8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bjHC4lXwlaKoEvORKKe9ZdRqjr1RnlP3ONE2EFS66aSR7y7H41GsoKXmU8FaNampZyYPrR9emdjyukcEYlSdtCyJHLu8M6fyCtq6iFo5FnRUxHRMur2tbbL9BnxwLOS3i6LjlD9Uy6yqSNFykJmehSBSJGzSc0jvbkXyFW4QjV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TvLi/4NF; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761356698; x=1792892698;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+Fu5OgTDIZIRAtIoJ7xpHPgfs7GVRyqQ9fmPndTdNj8=;
  b=TvLi/4NF2XUo2QEiNJiSW04zQoQnXl3zIBgvTwTgCxVCgwlXLl6LY0Cz
   VBVEE010GoMqtRlESCbh9dMDw5U1l0boneERSjuHVW3epKAMlKHRcj8Su
   ZEKjhObprEauSqjIv3K7JtGz4HDEefO1IduMEmYzCgKBER4jqwW5B0z+1
   14jiNhEbbzgak0vLf9oMFyQGcVHz2vYb/1VVFVTYnYWHB4QxQEmz9+SbX
   YQd8rKkuzRrBeEmtv/KspYV3o7d8H+bT+wwJ6LvY/QBAmi/iAGCN8F3eq
   7rnesGFf7L/x9g5Aqru8KNp98UZhIivwKsfdiK914IAVz0/SewkaP4vj0
   A==;
X-CSE-ConnectionGUID: MGdv5fK3Q0aKjIJfsaEh1A==
X-CSE-MsgGUID: L9Nm262xT02ztUwmEbLeAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63571350"
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="scan'208";a="63571350"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 18:44:57 -0700
X-CSE-ConnectionGUID: 0P5/ws5BQEeC/C8es36vTw==
X-CSE-MsgGUID: ENSWOxcpQT2WmA5yBuWBZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="scan'208";a="184466788"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 24 Oct 2025 18:44:55 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vCTKv-000F37-0E;
	Sat, 25 Oct 2025 01:44:53 +0000
Date: Sat, 25 Oct 2025 09:44:43 +0800
From: kernel test robot <lkp@intel.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	x86@kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: [tip:locking/core 8/11] build_policy.c:undefined reference to
 `__scoped_seqlock_bug'
Message-ID: <202510250928.YLPmMRoX-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
head:   37d0472c8ac441af8bc10fc4959ad9d62dd5fa4c
commit: 488f48b32654dc6be04d9cc12f75ce030c9cb21b [8/11] seqlock: Change thread_group_cputime() to use scoped_seqlock_read()
config: x86_64-buildonly-randconfig-002-20251025 (https://download.01.org/0day-ci/archive/20251025/202510250928.YLPmMRoX-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251025/202510250928.YLPmMRoX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510250928.YLPmMRoX-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: vmlinux.o: in function `__scoped_seqlock_next.constprop.0':
>> build_policy.c:(.text+0x23f6d3): undefined reference to `__scoped_seqlock_bug'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

