Return-Path: <linux-kernel+bounces-891954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F642C43E77
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 14:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 887AD188BEE0
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 13:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391F72F693A;
	Sun,  9 Nov 2025 13:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UbzObxx/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452EA2D63E5
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 13:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762694152; cv=none; b=QmtqRXvXb5oMaTS7yR2bwK3bOVQFYJHG1w8oGDZ6Zld7xpyh6yHIPGqJz4uOY+oD2mnIfKDG2fw2OPrhJc/uuxGkh1osq1GAQJA/nlUPV1mvs92/uHnj5hE20nnm8wYJlybPJ7SHwerWjyy/rro52v+PnCAUyNrnYpcQjtkq544=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762694152; c=relaxed/simple;
	bh=/v/wzx6TVHA6w4gVVmVw44uU7KClaZZTDL0IVwpYqbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=npNCwX7GYL63j2cvfbYZE5KTY14QWn62hg1x4E/EMeZ8fWSsDZzujwb2LOra1V+wMC/rsaBcFyxYZNHEBnXXWR3jVTU9fSJAnarKxazLEXVZfl/EMwxGz2dinbjY1mXxNSIzQSbxPBTSd5clDkLE8j7ZHIoFMF2FvD3l7JIbC+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UbzObxx/; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762694150; x=1794230150;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/v/wzx6TVHA6w4gVVmVw44uU7KClaZZTDL0IVwpYqbY=;
  b=UbzObxx/qkApQGGO0UGRQfOGP3mVPHJPcgrajz5VqbnkL+fGtWsaK2Cx
   iSU0/kzqKnutsGJRbFrXIw+e9qZt7LqqM96GEk7MhMX0iaPy+A0qFGgBq
   NPyZ/g7WOzEwisyOUH8uEEplUXAI9dtAMHdKQykyjQDXwogM3GVOuBng2
   b0ksdGG9hq/41IHTpOhXRIupuNxDUKvAdStoRcAi4PGIpCNLEjNcULvtu
   HG5EwLYQykm5r4x9Ki0IVSbtzpPqyuS3ZmuVJsHiywHdwGO4Iw96au/h0
   ch+yyUXK/tJHm4/pK4LW8+qREsOTsXHkhnCWGlC4n35lk5QCRUij525Hk
   A==;
X-CSE-ConnectionGUID: OnsPns/uSP2ztkIMGOwwXA==
X-CSE-MsgGUID: KpWulK0/Qu2v/rWNQWAykA==
X-IronPort-AV: E=McAfee;i="6800,10657,11607"; a="64681443"
X-IronPort-AV: E=Sophos;i="6.19,291,1754982000"; 
   d="scan'208";a="64681443"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2025 05:15:50 -0800
X-CSE-ConnectionGUID: 9Q7luGKBQKmQSeKqcR7S9w==
X-CSE-MsgGUID: ZBoNrpD3Q6aOPPg9WvDM8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,291,1754982000"; 
   d="scan'208";a="188195706"
Received: from lkp-server01.sh.intel.com (HELO 6ef82f2de774) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 09 Nov 2025 05:15:47 -0800
Received: from kbuild by 6ef82f2de774 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vI5Gi-00020p-0m;
	Sun, 09 Nov 2025 13:15:44 +0000
Date: Sun, 9 Nov 2025 21:14:59 +0800
From: kernel test robot <lkp@intel.com>
To: Alejandro Colomar <alx@kernel.org>, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Alejandro Colomar <alx@kernel.org>, Kees Cook <kees@kernel.org>,
	Christopher Bazley <chris.bazley.wg14@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Marco Elver <elver@google.com>, Michal Hocko <mhocko@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>, Jann Horn <jannh@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH v2 1/4] array_size.h: Add ARRAY_END()
Message-ID: <202511092053.40sHnHlA-lkp@intel.com>
References: <35255c1ceb54518779a45351dcd79a3c1910818a.1762637046.git.alx@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35255c1ceb54518779a45351dcd79a3c1910818a.1762637046.git.alx@kernel.org>

Hi Alejandro,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 6146a0f1dfae5d37442a9ddcba012add260bceb0]

url:    https://github.com/intel-lab-lkp/linux/commits/Alejandro-Colomar/array_size-h-Add-ARRAY_END/20251109-062234
base:   6146a0f1dfae5d37442a9ddcba012add260bceb0
patch link:    https://lore.kernel.org/r/35255c1ceb54518779a45351dcd79a3c1910818a.1762637046.git.alx%40kernel.org
patch subject: [PATCH v2 1/4] array_size.h: Add ARRAY_END()
config: x86_64-randconfig-001-20251109 (https://download.01.org/0day-ci/archive/20251109/202511092053.40sHnHlA-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251109/202511092053.40sHnHlA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511092053.40sHnHlA-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/block/floppy.c:4805:9: warning: 'ARRAY_END' macro redefined [-Wmacro-redefined]
    4805 | #define ARRAY_END(X) (&((X)[ARRAY_SIZE(X)]))
         |         ^
   include/linux/array_size.h:17:9: note: previous definition is here
      17 | #define ARRAY_END(a)  (a + ARRAY_SIZE(a))
         |         ^
   1 warning generated.


vim +/ARRAY_END +4805 drivers/block/floppy.c

5a74db06cc8d36 Philippe De Muyter 2009-02-18  4804  
5a74db06cc8d36 Philippe De Muyter 2009-02-18 @4805  #define ARRAY_END(X) (&((X)[ARRAY_SIZE(X)]))
5a74db06cc8d36 Philippe De Muyter 2009-02-18  4806  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

