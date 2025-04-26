Return-Path: <linux-kernel+bounces-621603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E124A9DBD6
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Apr 2025 17:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AABAA1BA69CF
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Apr 2025 15:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C075825D1E7;
	Sat, 26 Apr 2025 15:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CPOeXVjE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF64825CC52
	for <linux-kernel@vger.kernel.org>; Sat, 26 Apr 2025 15:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745681239; cv=none; b=sE3tcUiYjoekWmTEGZsnihEAqVYLz7yBrdNxD0Vuo3nqYUo0iT2s/9zALPZ+S35bcUv7ncBL8NJlXLeZHxK7Kg+kmpYVh+/u4hVxM8DmQUFLDGfDB6dnEhJC+xUpDCqw3NDEWYH9RA3f+WUhanC/UpL1Qgfm6vHyht03hqxUoPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745681239; c=relaxed/simple;
	bh=Qtd0dyIZfJKj7+m+rfi4DTy1I/LCHUZ/AplD+F81XpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YfM44oRiDWEwhqRPtjDntaQLr9cLqRQQdeoAvRQgBTcMEyp93rnQp32qgqgwG9crilZH4YKZKG3dCjcFrNVbDot5xLFpxUfHhe9Cgef47VBPk78ANS4lkZ4ws0SlRTytcCWgseMhoQat7rkzX3bzlof54oFcfWStk8gpMmJ9Ars=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CPOeXVjE; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745681237; x=1777217237;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Qtd0dyIZfJKj7+m+rfi4DTy1I/LCHUZ/AplD+F81XpA=;
  b=CPOeXVjEsWwnpJKp4bmyAWwk2a0131tyKdfCoE9v9Uyt14821gpCZ/vu
   7ZgaUkynTiLkDOD8DWD01eM1ltNdRjXIaih3pfwX6tWrx6NBiJkFGwTEO
   b9rEldouE9pTFd+JT3YCNobxQrxgjx+txlBpCB5jqbweeTlogbePXbIs3
   yDXXshESN3FwkBJsueH/DC+ssqskLBc1IWcYaUexhb83KFjrdNNT05hoK
   W+q3nJDLfwiK3POUMiEoMhm9gCPGQuMWBLlVowXJgu2FtomPRUbres/5W
   3EQGaZ+ojtzalEqf6o379/wyqtdQXbMH2lxhEEuD32PlgQj9dmfh5aEbh
   w==;
X-CSE-ConnectionGUID: 8RJTKPquRYuoLXXEyrf7Jw==
X-CSE-MsgGUID: Rjk5946/R/24ZYQeDWxNEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11415"; a="51140956"
X-IronPort-AV: E=Sophos;i="6.15,241,1739865600"; 
   d="scan'208";a="51140956"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2025 08:27:15 -0700
X-CSE-ConnectionGUID: vIOf90g1TqmfwU94/Brdog==
X-CSE-MsgGUID: yT0Jv8AjQ/asx7LR1shiGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,241,1739865600"; 
   d="scan'208";a="133449003"
Received: from lkp-server01.sh.intel.com (HELO 050dd05385d1) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 26 Apr 2025 08:27:14 -0700
Received: from kbuild by 050dd05385d1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u8hQt-0005sb-1z;
	Sat, 26 Apr 2025 15:27:11 +0000
Date: Sat, 26 Apr 2025 23:26:54 +0800
From: kernel test robot <lkp@intel.com>
To: Darshan Rathod <darshanrathod475@gmail.com>, abbotti@mev.co.uk0
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	hsweeten@visionengravers.com, linux-kernel@vger.kernel.org,
	Darshan Rathod <darshanrathod475@gmail.com>
Subject: Re: [PATCH] Staging: comedi: das16: Fixed a stucture warning in code
Message-ID: <202504262332.cRQb8NpG-lkp@intel.com>
References: <20250426113627.36525-1-darshanrathod475@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250426113627.36525-1-darshanrathod475@gmail.com>

Hi Darshan,

kernel test robot noticed the following build errors:

[auto build test ERROR on staging/staging-testing]

url:    https://github.com/intel-lab-lkp/linux/commits/Darshan-Rathod/Staging-comedi-das16-Fixed-a-stucture-warning-in-code/20250426-193741
base:   staging/staging-testing
patch link:    https://lore.kernel.org/r/20250426113627.36525-1-darshanrathod475%40gmail.com
patch subject: [PATCH] Staging: comedi: das16: Fixed a stucture warning in code
config: arm64-randconfig-003-20250426 (https://download.01.org/0day-ci/archive/20250426/202504262332.cRQb8NpG-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250426/202504262332.cRQb8NpG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504262332.cRQb8NpG-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/comedi/drivers/das16.c:969:18: error: cannot assign to variable 'lrange' with const-qualified type 'const struct comedi_lrange *'
     969 |                 lrange->length = 1;
         |                 ~~~~~~~~~~~~~~ ^
   drivers/comedi/drivers/das16.c:959:31: note: variable 'lrange' declared const here
     959 |                 const struct comedi_lrange *lrange;
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
>> drivers/comedi/drivers/das16.c:971:15: error: cannot assign to variable 'krange' with const-qualified type 'const struct comedi_krange *'
     971 |                 krange->min = min;
         |                 ~~~~~~~~~~~ ^
   drivers/comedi/drivers/das16.c:960:31: note: variable 'krange' declared const here
     960 |                 const struct comedi_krange *krange;
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
   drivers/comedi/drivers/das16.c:972:15: error: cannot assign to variable 'krange' with const-qualified type 'const struct comedi_krange *'
     972 |                 krange->max = max;
         |                 ~~~~~~~~~~~ ^
   drivers/comedi/drivers/das16.c:960:31: note: variable 'krange' declared const here
     960 |                 const struct comedi_krange *krange;
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
   drivers/comedi/drivers/das16.c:973:17: error: cannot assign to variable 'krange' with const-qualified type 'const struct comedi_krange *'
     973 |                 krange->flags = UNIT_volt;
         |                 ~~~~~~~~~~~~~ ^
   drivers/comedi/drivers/das16.c:960:31: note: variable 'krange' declared const here
     960 |                 const struct comedi_krange *krange;
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
   drivers/comedi/drivers/das16.c:1003:18: error: cannot assign to variable 'lrange' with const-qualified type 'const struct comedi_lrange *'
    1003 |                 lrange->length = 1;
         |                 ~~~~~~~~~~~~~~ ^
   drivers/comedi/drivers/das16.c:993:31: note: variable 'lrange' declared const here
     993 |                 const struct comedi_lrange *lrange;
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
   drivers/comedi/drivers/das16.c:1005:15: error: cannot assign to variable 'krange' with const-qualified type 'const struct comedi_krange *'
    1005 |                 krange->min = min;
         |                 ~~~~~~~~~~~ ^
   drivers/comedi/drivers/das16.c:994:31: note: variable 'krange' declared const here
     994 |                 const struct comedi_krange *krange;
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
   drivers/comedi/drivers/das16.c:1006:15: error: cannot assign to variable 'krange' with const-qualified type 'const struct comedi_krange *'
    1006 |                 krange->max = max;
         |                 ~~~~~~~~~~~ ^
   drivers/comedi/drivers/das16.c:994:31: note: variable 'krange' declared const here
     994 |                 const struct comedi_krange *krange;
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
   drivers/comedi/drivers/das16.c:1007:17: error: cannot assign to variable 'krange' with const-qualified type 'const struct comedi_krange *'
    1007 |                 krange->flags = UNIT_volt;
         |                 ~~~~~~~~~~~~~ ^
   drivers/comedi/drivers/das16.c:994:31: note: variable 'krange' declared const here
     994 |                 const struct comedi_krange *krange;
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
   8 errors generated.


vim +969 drivers/comedi/drivers/das16.c

742c4a095973f69 drivers/staging/comedi/drivers/das16.c H Hartley Sweeten   2015-01-12  947  
0ce8280e2876091 drivers/staging/comedi/drivers/das16.c H Hartley Sweeten   2015-01-26  948  static const struct comedi_lrange *das16_ai_range(struct comedi_device *dev,
0ce8280e2876091 drivers/staging/comedi/drivers/das16.c H Hartley Sweeten   2015-01-26  949  						  struct comedi_subdevice *s,
0ce8280e2876091 drivers/staging/comedi/drivers/das16.c H Hartley Sweeten   2015-01-26  950  						  struct comedi_devconfig *it,
0ce8280e2876091 drivers/staging/comedi/drivers/das16.c H Hartley Sweeten   2015-01-26  951  						  unsigned int pg_type,
0ce8280e2876091 drivers/staging/comedi/drivers/das16.c H Hartley Sweeten   2015-01-26  952  						  unsigned int status)
0ce8280e2876091 drivers/staging/comedi/drivers/das16.c H Hartley Sweeten   2015-01-26  953  {
0ce8280e2876091 drivers/staging/comedi/drivers/das16.c H Hartley Sweeten   2015-01-26  954  	unsigned int min = it->options[4];
0ce8280e2876091 drivers/staging/comedi/drivers/das16.c H Hartley Sweeten   2015-01-26  955  	unsigned int max = it->options[5];
0ce8280e2876091 drivers/staging/comedi/drivers/das16.c H Hartley Sweeten   2015-01-26  956  
0ce8280e2876091 drivers/staging/comedi/drivers/das16.c H Hartley Sweeten   2015-01-26  957  	/* get any user-defined input range */
0ce8280e2876091 drivers/staging/comedi/drivers/das16.c H Hartley Sweeten   2015-01-26  958  	if (pg_type == das16_pg_none && (min || max)) {
5c47473ec0f437f drivers/comedi/drivers/das16.c         Darshan Rathod      2025-04-26  959  		const struct comedi_lrange *lrange;
5c47473ec0f437f drivers/comedi/drivers/das16.c         Darshan Rathod      2025-04-26  960  		const struct comedi_krange *krange;
0ce8280e2876091 drivers/staging/comedi/drivers/das16.c H Hartley Sweeten   2015-01-26  961  
0ce8280e2876091 drivers/staging/comedi/drivers/das16.c H Hartley Sweeten   2015-01-26  962  		/* allocate single-range range table */
0ce8280e2876091 drivers/staging/comedi/drivers/das16.c H Hartley Sweeten   2015-01-26  963  		lrange = comedi_alloc_spriv(s,
ee8ed0141d532d6 drivers/comedi/drivers/das16.c         Gustavo A. R. Silva 2022-01-25  964  					    struct_size(lrange, range, 1));
0ce8280e2876091 drivers/staging/comedi/drivers/das16.c H Hartley Sweeten   2015-01-26  965  		if (!lrange)
0ce8280e2876091 drivers/staging/comedi/drivers/das16.c H Hartley Sweeten   2015-01-26  966  			return &range_unknown;
0ce8280e2876091 drivers/staging/comedi/drivers/das16.c H Hartley Sweeten   2015-01-26  967  
0ce8280e2876091 drivers/staging/comedi/drivers/das16.c H Hartley Sweeten   2015-01-26  968  		/* initialize ai range */
0ce8280e2876091 drivers/staging/comedi/drivers/das16.c H Hartley Sweeten   2015-01-26 @969  		lrange->length = 1;
0ce8280e2876091 drivers/staging/comedi/drivers/das16.c H Hartley Sweeten   2015-01-26  970  		krange = lrange->range;
0ce8280e2876091 drivers/staging/comedi/drivers/das16.c H Hartley Sweeten   2015-01-26 @971  		krange->min = min;
0ce8280e2876091 drivers/staging/comedi/drivers/das16.c H Hartley Sweeten   2015-01-26  972  		krange->max = max;
0ce8280e2876091 drivers/staging/comedi/drivers/das16.c H Hartley Sweeten   2015-01-26  973  		krange->flags = UNIT_volt;
0ce8280e2876091 drivers/staging/comedi/drivers/das16.c H Hartley Sweeten   2015-01-26  974  
0ce8280e2876091 drivers/staging/comedi/drivers/das16.c H Hartley Sweeten   2015-01-26  975  		return lrange;
0ce8280e2876091 drivers/staging/comedi/drivers/das16.c H Hartley Sweeten   2015-01-26  976  	}
0ce8280e2876091 drivers/staging/comedi/drivers/das16.c H Hartley Sweeten   2015-01-26  977  
0ce8280e2876091 drivers/staging/comedi/drivers/das16.c H Hartley Sweeten   2015-01-26  978  	/* use software programmable range */
0ce8280e2876091 drivers/staging/comedi/drivers/das16.c H Hartley Sweeten   2015-01-26  979  	if (status & DAS16_STATUS_UNIPOLAR)
0ce8280e2876091 drivers/staging/comedi/drivers/das16.c H Hartley Sweeten   2015-01-26  980  		return das16_ai_uni_lranges[pg_type];
0ce8280e2876091 drivers/staging/comedi/drivers/das16.c H Hartley Sweeten   2015-01-26  981  	return das16_ai_bip_lranges[pg_type];
0ce8280e2876091 drivers/staging/comedi/drivers/das16.c H Hartley Sweeten   2015-01-26  982  }
0ce8280e2876091 drivers/staging/comedi/drivers/das16.c H Hartley Sweeten   2015-01-26  983  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

