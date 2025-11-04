Return-Path: <linux-kernel+bounces-885570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1168DC3359C
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 00:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C40314267EF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 23:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA362D9EFC;
	Tue,  4 Nov 2025 23:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="chyyyNPj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A29AD2C;
	Tue,  4 Nov 2025 23:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762298138; cv=none; b=llggW+OQgUX1dD6QAwNadtEHAuCnLorTqcMsNujXhX6v7OVNjpZbMMjYfDN9r5rkILTl3AeoBs+X/b5DbBfeRS+0Swzyt+0inIurBw3xkbV7q1UB3nDMATtuvE3aeeH2FWrhCV7Bk8U1PaP281o8B2Vwr3eX5F+K0fsnUhhc/Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762298138; c=relaxed/simple;
	bh=AvHazApTm6rnOE07byLu9Db1odTHNc2Q5jqYLJT32sE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NyaGX/scHQa3ypLRHQR7UxKULVqqPGN+zyCfhwJ7PRiVUqy0B2I3RcfRz7c2dKFG1Wk6mgsuPNVt/G2/boL4PPo4uViRpZtZfjH3TOtNlZ1XL+OwqEB8s9biNegyxWZsJbTeanM8TcL9asBAUnlPqgV52QD/95i8eslgYnM0le8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=chyyyNPj; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762298137; x=1793834137;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AvHazApTm6rnOE07byLu9Db1odTHNc2Q5jqYLJT32sE=;
  b=chyyyNPjabDnk5gIS6FY4tkKiYlwbF4US64CbXtUfoLz9AcMHhYSwDzA
   A8Y1ZX4wqMuV1UrIown/zOeGbTGiJ1IK64FVEjVEqlqsyGXSICpFScNFG
   kfJcK448l+oakE9XS+wZ+kxfOVzX2CdPdPDsFeMW6kWeGKxPzw9FlEmhs
   8Sy+wVkEjqxtpX93l0WuauaO2mISLB/M8n4aVUDo0qph90uDgA5z6DV5g
   +efpaZ3zaWpO3DsEYTTGl6z8tdLorOI74SkTNZhHF5AspfRj8f8dceUao
   TxN5tTkcUVN1Rv5LAW4Yf74LtEx9oTCVOMV/TC3bzVA18BIqH4SXSnr1D
   g==;
X-CSE-ConnectionGUID: dyAWCKTfRReCylzip+WZ2w==
X-CSE-MsgGUID: EmWjcoRRTn6waSk4ThUGeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="68059951"
X-IronPort-AV: E=Sophos;i="6.19,280,1754982000"; 
   d="scan'208";a="68059951"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 15:15:37 -0800
X-CSE-ConnectionGUID: 3GbsULwITDGtzdlsPAC4nA==
X-CSE-MsgGUID: gvGurNZvRY6s72TM1Q0Mxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,280,1754982000"; 
   d="scan'208";a="187732482"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 04 Nov 2025 15:15:35 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vGQFR-000RvM-0A;
	Tue, 04 Nov 2025 23:15:33 +0000
Date: Wed, 5 Nov 2025 07:14:57 +0800
From: kernel test robot <lkp@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-media@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] kernel-doc: Issue warnings that were silently
 discarded
Message-ID: <202511050720.nJ9ccENC-lkp@intel.com>
References: <20251104215502.1049817-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104215502.1049817-1-andriy.shevchenko@linux.intel.com>

Hi Andy,

kernel test robot noticed the following build warnings:

[auto build test WARNING on lwn/docs-next]
[also build test WARNING on next-20251104]
[cannot apply to linus/master v6.18-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/kernel-doc-Issue-warnings-that-were-silently-discarded/20251105-055629
base:   git://git.lwn.net/linux.git docs-next
patch link:    https://lore.kernel.org/r/20251104215502.1049817-1-andriy.shevchenko%40linux.intel.com
patch subject: [PATCH v1 1/1] kernel-doc: Issue warnings that were silently discarded
config: openrisc-allnoconfig (https://download.01.org/0day-ci/archive/20251105/202511050720.nJ9ccENC-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251105/202511050720.nJ9ccENC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511050720.nJ9ccENC-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: block/blk-mq-dma.c:374 expecting prototype for blk_rq_integrity_dma_map_iter_start(). Prototype was for blk_rq_integrity_dma_map_iter_next() instead
--
>> Warning: kernel/nstree.c:215 function parameter 'ns_tree' not described in '__ns_tree_adjoined_rcu'
>> Warning: kernel/nstree.c:215 expecting prototype for ns_tree_adjoined_rcu(). Prototype was for __ns_tree_adjoined_rcu() instead
--
>> Warning: lib/hweight.c:13 function parameter 'w' not described in '__sw_hweight32'
>> Warning: lib/hweight.c:13 expecting prototype for hweightN(). Prototype was for __sw_hweight32() instead
--
>> Warning: mm/vmalloc.c:4129 expecting prototype for vrealloc_node_align_noprof(). Prototype was for vrealloc_node_align() instead

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

