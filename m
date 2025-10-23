Return-Path: <linux-kernel+bounces-866222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F49BFF36A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 07:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3706134FAF1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 05:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC0F261B9E;
	Thu, 23 Oct 2025 05:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="dCdhxMLK"
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FD218FDDE
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 05:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761195840; cv=none; b=nlYEiVz7IvkEtwXrcAOotlCFzy3kyfXatIGwRfK/xgsufZOfmWrg8Z+D4mYkt8eIHb8e2AY+gDvgg9KMz4Ffw0tIBLKtwnBuIejPcGnacKY/Ye2+k5/G61qcEpV3DGAKOO/ZJSwngNXAI0kgumPUdUjljU3GiFomUN7DNg7ZZo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761195840; c=relaxed/simple;
	bh=oNlKIBS24VqVSjl5MOV4qcUC67XjWxB93AyLU5N3D3E=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=kBfsTtHceBusOo1SuNY1gIf++PMTe+xsG/86fTQ7LeYO6axivo2cGgO00c22eY6laEJPh0oRRzkyiGK8QNmf0hivFfqRs+OAsc8YiKVZIp5A/pvs1KYYxb63Ms4iw1/uehTsKScSogJNZHQ46C4cp0nRQtDc0P2itR5IHsucYac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=dCdhxMLK; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=R+VWjAe6xaqPWQpev4m4QDyG6R7acsvDc/fzb6ubZYA=;
  b=dCdhxMLKhyum0kKcpPyI2z3XCbQ6iPINtbqbQGCB3mvu0NmgHQ64QLEs
   p4HBajLFWNgEyBto1dzCcqan8U+zBzeean9ty0USaXuCdH6L6HT8Z3vGK
   zA9K2t5L36b6I4uzY3AvHsLgnRc09TxF+19keA3xUFdkF5d7kZreV0suS
   8=;
X-CSE-ConnectionGUID: klvy0VtVTsOeptM6O4RINg==
X-CSE-MsgGUID: ZHC8UKZ7QQK2kT1RYdD0dw==
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.19,248,1754949600"; 
   d="scan'208";a="128920397"
Received: from unknown (HELO hadrien) ([202.51.247.22])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 07:03:46 +0200
Date: Thu, 23 Oct 2025 13:03:38 +0800 (+08)
From: Julia Lawall <julia.lawall@inria.fr>
To: Harsh Jain <h.jain@amd.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
    Mounika Botcha <mounika.botcha@amd.com>
cc: linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: drivers/crypto/xilinx/xilinx-trng.c:336:54-61: WARNING: Consider
 using %pe to print PTR_ERR() (fwd)
Message-ID: <c78d7370-85c-2651-c4be-9b9880ec2b15@inria.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



---------- Forwarded message ----------
Date: Thu, 23 Oct 2025 12:35:11 +0800
From: kernel test robot <lkp@intel.com>
To: oe-kbuild@lists.linux.dev
Cc: lkp@intel.com, Julia Lawall <julia.lawall@inria.fr>
Subject: drivers/crypto/xilinx/xilinx-trng.c:336:54-61: WARNING: Consider using
    %pe to print PTR_ERR()

BCC: lkp@intel.com
CC: oe-kbuild-all@lists.linux.dev
CC: linux-kernel@vger.kernel.org
TO: Harsh Jain <h.jain@amd.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>
CC: Mounika Botcha <mounika.botcha@amd.com>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   43e9ad0c55a369ecc84a4788d06a8a6bfa634f1c
commit: 8979744aca8096ee5072798dfc1181606919b35d crypto: xilinx - Add TRNG driver for Versal
date:   7 weeks ago
:::::: branch date: 3 hours ago
:::::: commit date: 7 weeks ago
config: powerpc64-randconfig-r064-20251023 (https://download.01.org/0day-ci/archive/20251023/202510231229.Z6TduqZy-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 754ebc6ebb9fb9fbee7aef33478c74ea74949853)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Julia Lawall <julia.lawall@inria.fr>
| Closes: https://lore.kernel.org/r/202510231229.Z6TduqZy-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/crypto/xilinx/xilinx-trng.c:336:54-61: WARNING: Consider using %pe to print PTR_ERR()

vim +336 drivers/crypto/xilinx/xilinx-trng.c

8979744aca8096 Harsh Jain 2025-08-25  323
8979744aca8096 Harsh Jain 2025-08-25  324  static int xtrng_probe(struct platform_device *pdev)
8979744aca8096 Harsh Jain 2025-08-25  325  {
8979744aca8096 Harsh Jain 2025-08-25  326  	struct xilinx_rng *rng;
8979744aca8096 Harsh Jain 2025-08-25  327  	int ret;
8979744aca8096 Harsh Jain 2025-08-25  328
8979744aca8096 Harsh Jain 2025-08-25  329  	rng = devm_kzalloc(&pdev->dev, sizeof(*rng), GFP_KERNEL);
8979744aca8096 Harsh Jain 2025-08-25  330  	if (!rng)
8979744aca8096 Harsh Jain 2025-08-25  331  		return -ENOMEM;
8979744aca8096 Harsh Jain 2025-08-25  332
8979744aca8096 Harsh Jain 2025-08-25  333  	rng->dev = &pdev->dev;
8979744aca8096 Harsh Jain 2025-08-25  334  	rng->rng_base = devm_platform_ioremap_resource(pdev, 0);
8979744aca8096 Harsh Jain 2025-08-25  335  	if (IS_ERR(rng->rng_base)) {
8979744aca8096 Harsh Jain 2025-08-25 @336  		dev_err(&pdev->dev, "Failed to map resource %ld\n", PTR_ERR(rng->rng_base));
8979744aca8096 Harsh Jain 2025-08-25  337  		return PTR_ERR(rng->rng_base);
8979744aca8096 Harsh Jain 2025-08-25  338  	}
8979744aca8096 Harsh Jain 2025-08-25  339
8979744aca8096 Harsh Jain 2025-08-25  340  	xtrng_trng_reset(rng->rng_base);
8979744aca8096 Harsh Jain 2025-08-25  341  	ret = xtrng_reseed_internal(rng);
8979744aca8096 Harsh Jain 2025-08-25  342  	if (ret) {
8979744aca8096 Harsh Jain 2025-08-25  343  		dev_err(&pdev->dev, "TRNG Seed fail\n");
8979744aca8096 Harsh Jain 2025-08-25  344  		return ret;
8979744aca8096 Harsh Jain 2025-08-25  345  	}
8979744aca8096 Harsh Jain 2025-08-25  346
8979744aca8096 Harsh Jain 2025-08-25  347  	xilinx_rng_dev = rng;
8979744aca8096 Harsh Jain 2025-08-25  348  	mutex_init(&rng->lock);
8979744aca8096 Harsh Jain 2025-08-25  349  	ret = crypto_register_rng(&xtrng_trng_alg);
8979744aca8096 Harsh Jain 2025-08-25  350  	if (ret) {
8979744aca8096 Harsh Jain 2025-08-25  351  		dev_err(&pdev->dev, "Crypto Random device registration failed: %d\n", ret);
8979744aca8096 Harsh Jain 2025-08-25  352  		return ret;
8979744aca8096 Harsh Jain 2025-08-25  353  	}
8979744aca8096 Harsh Jain 2025-08-25  354  	ret = xtrng_hwrng_register(&rng->trng);
8979744aca8096 Harsh Jain 2025-08-25  355  	if (ret) {
8979744aca8096 Harsh Jain 2025-08-25  356  		dev_err(&pdev->dev, "HWRNG device registration failed: %d\n", ret);
8979744aca8096 Harsh Jain 2025-08-25  357  		goto crypto_rng_free;
8979744aca8096 Harsh Jain 2025-08-25  358  	}
8979744aca8096 Harsh Jain 2025-08-25  359  	platform_set_drvdata(pdev, rng);
8979744aca8096 Harsh Jain 2025-08-25  360
8979744aca8096 Harsh Jain 2025-08-25  361  	return 0;
8979744aca8096 Harsh Jain 2025-08-25  362
8979744aca8096 Harsh Jain 2025-08-25  363  crypto_rng_free:
8979744aca8096 Harsh Jain 2025-08-25  364  	crypto_unregister_rng(&xtrng_trng_alg);
8979744aca8096 Harsh Jain 2025-08-25  365
8979744aca8096 Harsh Jain 2025-08-25  366  	return ret;
8979744aca8096 Harsh Jain 2025-08-25  367  }
8979744aca8096 Harsh Jain 2025-08-25  368

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

