Return-Path: <linux-kernel+bounces-736534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8479B09E39
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 10:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D0A518987EF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 08:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20450293C71;
	Fri, 18 Jul 2025 08:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="de4dGKTH"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C528C293C5D
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 08:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752828043; cv=none; b=uwc3GLUteu8xng/cP2EyElhTNWxs71O2rlOZNRd7UM7wMfLp05IqfLpqG6qmMySSjtoLsxDq+s9kBcs703eOPGRHV2am/pJTToGRuvOu/dSULtoiTd5luVFawMnapz8IeoU58vx6Bp89jdT8nybVimhG/HDWbFSVk4H6yf0bwXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752828043; c=relaxed/simple;
	bh=hZEUOPxDrJ5pML/LvqPzM0Oo2LC3Htt9b3ERuN4CWk0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Y8TVch7YG+aFLgK/fTQP7aq81CkYyGQWbr9ricltPb5NWYvOIE6KcgRB5fFdcpPHsL0WHOlY8T516xyzE0HoXO8fi7cIjz0FmiASt0X0oqeDA3fk7xoLLALHDEtST8dbDH6wr5UBTeoMM67wPlwDcLe6DEHk00SJ4yPFLBpqPt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=de4dGKTH; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752828042; x=1784364042;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hZEUOPxDrJ5pML/LvqPzM0Oo2LC3Htt9b3ERuN4CWk0=;
  b=de4dGKTH5LHH+HxkirE5vYRxS59AyeV7tYuY3bHupH7LPpmYaFPGDdHJ
   t869oJK6hCnbvtbehcYeIwrUjks+Syh7cLHinj5U10zobi6sh4EJRLUZs
   6lnpnVQhycU7GPYJ0b+zgCtfSgy0uTWE8M0nSjSVPM346/hijMAsXpJcb
   B1kaV8a5VmQfVIUItRMnWnOt/N4idiHTgF0HVXA7cRu1LZzCRIVmoZriS
   QxVenx6UPK+4KcS5U9PzFvx4ZyQYaNX7NBzM8sMTYniwx4TfHS+6lgj11
   AlQ1yCU9bv6fv6y72/+tOhcaRGL0FjhWWnavrK0PSJXvHRxbHLZ+KVkDb
   A==;
X-CSE-ConnectionGUID: xaeMFSnaRoa+8cJB6HThtQ==
X-CSE-MsgGUID: xWOuEgTJRb2+Wr3RNDm2+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="58897299"
X-IronPort-AV: E=Sophos;i="6.16,321,1744095600"; 
   d="scan'208";a="58897299"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2025 01:40:41 -0700
X-CSE-ConnectionGUID: 5pMkjjMlR5e43c/c/0N5Ww==
X-CSE-MsgGUID: JlzBoWGySAyIAmkK6B8UfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,321,1744095600"; 
   d="scan'208";a="195138538"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 18 Jul 2025 01:40:39 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ucgdx-000ESN-0v;
	Fri, 18 Jul 2025 08:40:37 +0000
Date: Fri, 18 Jul 2025 16:39:59 +0800
From: kernel test robot <lkp@intel.com>
To: Xiu Jianfeng <xiujianfeng@huawei.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>
Subject: mm/hugetlb_cgroup.c:829:44: warning: '%s' directive output may be
 truncated writing up to 1623 bytes into a region of size between 32 and 63
Message-ID: <202507181808.mpbc1F0r-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6832a9317eee280117cd695fa885b2b7a7a38daf
commit: 47179fe03588caa13a9bae642b058901709ddc55 mm/hugetlb_cgroup: prepare cftypes based on template
date:   1 year ago
config: s390-randconfig-r132-20250718 (https://download.01.org/0day-ci/archive/20250718/202507181808.mpbc1F0r-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 10.5.0
reproduce: (https://download.01.org/0day-ci/archive/20250718/202507181808.mpbc1F0r-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507181808.mpbc1F0r-lkp@intel.com/

All warnings (new ones prefixed by >>):

   mm/hugetlb_cgroup.c: In function 'hugetlb_cgroup_file_init':
>> mm/hugetlb_cgroup.c:829:44: warning: '%s' directive output may be truncated writing up to 1623 bytes into a region of size between 32 and 63 [-Wformat-truncation=]
     829 |   snprintf(cft->name, MAX_CFTYPE_NAME, "%s.%s", buf, tmpl->name);
         |                                            ^~
   mm/hugetlb_cgroup.c:829:3: note: 'snprintf' output between 2 and 1656 bytes into a destination of size 64
     829 |   snprintf(cft->name, MAX_CFTYPE_NAME, "%s.%s", buf, tmpl->name);
         |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   mm/hugetlb_cgroup.c:829:44: warning: '%s' directive output may be truncated writing up to 2087 bytes into a region of size between 32 and 63 [-Wformat-truncation=]
     829 |   snprintf(cft->name, MAX_CFTYPE_NAME, "%s.%s", buf, tmpl->name);
         |                                            ^~
   mm/hugetlb_cgroup.c:829:3: note: 'snprintf' output between 2 and 2120 bytes into a destination of size 64
     829 |   snprintf(cft->name, MAX_CFTYPE_NAME, "%s.%s", buf, tmpl->name);
         |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +829 mm/hugetlb_cgroup.c

   815	
   816	static void __init
   817	hugetlb_cgroup_cfttypes_init(struct hstate *h, struct cftype *cft,
   818				     struct cftype *tmpl, int tmpl_size)
   819	{
   820		char buf[32];
   821		int i, idx = hstate_index(h);
   822	
   823		/* format the size */
   824		mem_fmt(buf, sizeof(buf), huge_page_size(h));
   825	
   826		for (i = 0; i < tmpl_size; cft++, tmpl++, i++) {
   827			*cft = *tmpl;
   828			/* rebuild the name */
 > 829			snprintf(cft->name, MAX_CFTYPE_NAME, "%s.%s", buf, tmpl->name);
   830			/* rebuild the private */
   831			cft->private = MEMFILE_PRIVATE(idx, tmpl->private);
   832			/* rebuild the file_offset */
   833			if (tmpl->file_offset) {
   834				unsigned int offset = tmpl->file_offset;
   835	
   836				cft->file_offset = MEMFILE_OFFSET0(offset) +
   837						   MEMFILE_FIELD_SIZE(offset) * idx;
   838			}
   839	
   840			lockdep_register_key(&cft->lockdep_key);
   841		}
   842	}
   843	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

