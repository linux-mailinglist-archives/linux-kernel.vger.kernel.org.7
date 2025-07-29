Return-Path: <linux-kernel+bounces-749573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED255B15032
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 17:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4748718A121E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 15:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79A8292936;
	Tue, 29 Jul 2025 15:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l4lHSp/K"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295A41A00E7
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 15:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753803158; cv=none; b=Apl0E5On/FW/nmRyUM+p+sECXNUpgb2Oxb4FGzXtx7B+HQsgXyJ6DCNqw33RdmaD+puK+u0y+yJrhUa+6czbbeCnxWo84nzAVz9vq3xxA6bf7Zyxn3up8GB2EGFI7xsA/CEL2O67zjFlShob82gev1cpKz7isD2vRfc2pDt/5aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753803158; c=relaxed/simple;
	bh=HWU8yO0NS7630BaYWOPXICFtNRntaPz4NMUJ9knONhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D2OB+pmvsScl9gGZ9v2FgZiBtoNNG51cahmOguqyQSAr0C1eOri5pe+4O0K8wlZ9CbOJzR/zmYahSdod1REK7KUaChx/eq28n8Xj9zy15q9pWEhXlzm/d7hkMkCbGlrWY3UK6dnHp8KN2pBAZmYdDyjqFUqpbsO1Th1WfbvXhxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l4lHSp/K; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753803156; x=1785339156;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HWU8yO0NS7630BaYWOPXICFtNRntaPz4NMUJ9knONhQ=;
  b=l4lHSp/KJfCZ4HVQ1BVBMonuOApuPPk4gdpMM/fOOA6SyAH896/Glo/Z
   FEuLhENMFY41bVaQXVL/zX2tm6QvhZnPjTvgaey/2i1goXk6K/JCOFY+O
   2IUkWiia5a/WFfJjnxAWXNEuxGYlbGxAKeZDj9MFf6yqcjkrucPzi7hPC
   TvobbN3T9LB1Xn1KXDCceXAbvbEnq6RrvQCARCrdwX3qXCm8gAgoh7Dmh
   O9BSFzkTbsuqbuQ4IC5FZrcSYrbb5jj73Wmr1FJctsj37zR4DD2SDjZKg
   9hEWK99omP1riYfys72W0vKBDDSP6XDJ3CdzyW/5gvHMIwhg3u+8gLdXP
   Q==;
X-CSE-ConnectionGUID: j63/T/ceRhu+oIREbyIUIQ==
X-CSE-MsgGUID: 3q9IEtY5Rymp/vrbZ1G0dQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11506"; a="73530635"
X-IronPort-AV: E=Sophos;i="6.16,349,1744095600"; 
   d="scan'208";a="73530635"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2025 08:32:36 -0700
X-CSE-ConnectionGUID: T/AEkhXGRWGLYA0vRlFh7A==
X-CSE-MsgGUID: DrGPGc0TS7WB6NQ94h6Utw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,349,1744095600"; 
   d="scan'208";a="199899382"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 29 Jul 2025 08:32:35 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ugmJb-0001Pj-29;
	Tue, 29 Jul 2025 15:32:31 +0000
Date: Tue, 29 Jul 2025 23:31:42 +0800
From: kernel test robot <lkp@intel.com>
To: Dishank Jogi <jogidishank503@gmail.com>, geert@linux-m68k.org
Cc: oe-kbuild-all@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org, darshanrathod475@gmail.com,
	Dishank Jogi <jogidishank503@gmail.com>
Subject: Re: [PATCH] zorro: fix checkpatch error by avoiding assignment in
 if-statement.
Message-ID: <202507292343.vsRhsbLu-lkp@intel.com>
References: <20250728093412.48065-1-jogidishank503@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728093412.48065-1-jogidishank503@gmail.com>

Hi Dishank,

kernel test robot noticed the following build errors:

[auto build test ERROR on geert-m68k/for-next]
[also build test ERROR on gerg-m68knommu/for-next geert-m68k/for-linus linus/master v6.16 next-20250729]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dishank-Jogi/zorro-fix-checkpatch-error-by-avoiding-assignment-in-if-statement/20250728-173702
base:   https://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git for-next
patch link:    https://lore.kernel.org/r/20250728093412.48065-1-jogidishank503%40gmail.com
patch subject: [PATCH] zorro: fix checkpatch error by avoiding assignment in if-statement.
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20250729/202507292343.vsRhsbLu-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250729/202507292343.vsRhsbLu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507292343.vsRhsbLu-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/zorro/gen-devlist.c: In function 'main':
>> drivers/zorro/gen-devlist.c:47:39: error: expected ';' before 'if'
      47 |                 c = strchr(line, '\n')
         |                                       ^
         |                                       ;
      48 |                 if (c)
         |                 ~~                     


vim +47 drivers/zorro/gen-devlist.c

    28	
    29	int
    30	main(void)
    31	{
    32		char line[1024], *c, *bra, manuf[8];
    33		int manufs = 0;
    34		int mode = 0;
    35		int lino = 0;
    36		int manuf_len = 0;
    37		FILE *devf;
    38	
    39		devf = fopen("devlist.h", "w");
    40		if (!devf) {
    41			fprintf(stderr, "Cannot create output file!\n");
    42			return 1;
    43		}
    44	
    45		while (fgets(line, sizeof(line)-1, stdin)) {
    46			lino++;
  > 47			c = strchr(line, '\n')

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

