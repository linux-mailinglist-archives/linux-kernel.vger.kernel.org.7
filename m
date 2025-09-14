Return-Path: <linux-kernel+bounces-815891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA8EB56C57
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 23:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4358F174834
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 21:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8642DA776;
	Sun, 14 Sep 2025 21:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I9nlDhik"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EAB287269
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 21:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757884052; cv=none; b=flqiS21zgSb2Oi6KjlVdtETlUH9zFjj/LPDOhFQ72P2Kw/4PR8BzLKL/bMNIFE58NKPoubqQIR5GJsL9i7NTPmUmbhx8B8FcYyL5bdOHpdOT6ctuK+qKHYX5XKWEFe0Bgfov5P0BIorWW+6QJz397krWSjzG9u1cIr1X/Ily2D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757884052; c=relaxed/simple;
	bh=CTA0zU2Fw1bDr6/jDNo7Mxn6da3bvMm78B04XaTzUk8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=imtwqOd2fT5N0KOHZ6tSUjhSskpKdFKVPjUVa9X1uYaUEoPPJAXht23h+3DAOaS2TXPzlwXcekmM9PhOJpFZVYjuXUlA7hopDJNyEDmGJlAUvf/wPsxApy954avWSNDuyNpeQx4G4LiCivBKSqBi4YpUmpLlo474RjurznoOyeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I9nlDhik; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757884050; x=1789420050;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CTA0zU2Fw1bDr6/jDNo7Mxn6da3bvMm78B04XaTzUk8=;
  b=I9nlDhikuu7WRg44O19b7kVbasAzbYyD/X8rwBLjdb0GZ6fe/5iTbsDU
   TdQ/YTHZYMykloHU/Rw8A3jbwmVDeej2/N2NG8bqkGa8PjEhrqfce0gc5
   UsDxVweCam24n9rEV2467XgBZVBJ3kQ++ZV7IXjqpp9fFgjeGMpl+QfK7
   9GXmHyL4CCoIyCGhz0wSFiNZ+ymk7YnnVpSoOXG1/hZVCbWEPkOCOBaQx
   LtrK3rNGEpk3S/D1Ijver3K+nj/xcdRvrj7y5uxby5rXATEB01E4b08zj
   n+uv8hYnBvn7h4lOZaC6I1lO9EQaCZe2xOV5pDzVPk4twkeh58+usLQ/1
   g==;
X-CSE-ConnectionGUID: x2rOUIHBSO2C2dhsuzVg5Q==
X-CSE-MsgGUID: pHOgO2c1TXCZfP2MO+bcjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11553"; a="71566566"
X-IronPort-AV: E=Sophos;i="6.18,264,1751266800"; 
   d="scan'208";a="71566566"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2025 14:07:30 -0700
X-CSE-ConnectionGUID: fmnHGu58TkCCRb50svxacQ==
X-CSE-MsgGUID: HVQodUEDRoKkwFrwi7wfhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,264,1751266800"; 
   d="scan'208";a="174529729"
Received: from lkp-server02.sh.intel.com (HELO eb5fdfb2a9b7) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 14 Sep 2025 14:07:29 -0700
Received: from kbuild by eb5fdfb2a9b7 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uxtwU-0002hm-0p;
	Sun, 14 Sep 2025 21:07:26 +0000
Date: Mon, 15 Sep 2025 05:06:36 +0800
From: kernel test robot <lkp@intel.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: crypto/hmac.c:251:12: warning: stack frame size (1152) exceeds limit
 (1024) in 'hmac_setkey_ahash'
Message-ID: <202509150449.4cUQ2KGX-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Herbert,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1519fc7cd3e129f6a95143cdc92f01ba21a3c266
commit: c3103416d5217655d707d9417aaf66f184e3d72f crypto: hmac - Add ahash support
date:   4 months ago
config: mips-eyeq6_defconfig (https://download.01.org/0day-ci/archive/20250915/202509150449.4cUQ2KGX-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 21857ae337e0892a5522b6e7337899caa61de2a6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250915/202509150449.4cUQ2KGX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509150449.4cUQ2KGX-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> crypto/hmac.c:251:12: warning: stack frame size (1152) exceeds limit (1024) in 'hmac_setkey_ahash' [-Wframe-larger-than]
     251 | static int hmac_setkey_ahash(struct crypto_ahash *parent,
         |            ^
   1 warning generated.


vim +/hmac_setkey_ahash +251 crypto/hmac.c

   250	
 > 251	static int hmac_setkey_ahash(struct crypto_ahash *parent,
   252				     const u8 *inkey, unsigned int keylen)
   253	{
   254		struct ahash_hmac_ctx *tctx = crypto_ahash_ctx(parent);
   255		struct crypto_ahash *fb = crypto_ahash_fb(tctx->hash);
   256		int ds = crypto_ahash_digestsize(parent);
   257		int bs = crypto_ahash_blocksize(parent);
   258		int ss = crypto_ahash_statesize(parent);
   259		HASH_REQUEST_ON_STACK(req, fb);
   260		u8 *opad = &tctx->pads[ss];
   261		u8 *ipad = &tctx->pads[0];
   262		int err, i;
   263	
   264		if (fips_enabled && (keylen < 112 / 8))
   265			return -EINVAL;
   266	
   267		ahash_request_set_callback(req, 0, NULL, NULL);
   268	
   269		if (keylen > bs) {
   270			ahash_request_set_virt(req, inkey, ipad, keylen);
   271			err = crypto_ahash_digest(req);
   272			if (err)
   273				goto out_zero_req;
   274	
   275			keylen = ds;
   276		} else
   277			memcpy(ipad, inkey, keylen);
   278	
   279		memset(ipad + keylen, 0, bs - keylen);
   280		memcpy(opad, ipad, bs);
   281	
   282		for (i = 0; i < bs; i++) {
   283			ipad[i] ^= HMAC_IPAD_VALUE;
   284			opad[i] ^= HMAC_OPAD_VALUE;
   285		}
   286	
   287		ahash_request_set_virt(req, ipad, NULL, bs);
   288		err = crypto_ahash_init(req) ?:
   289		      crypto_ahash_update(req) ?:
   290		      crypto_ahash_export(req, ipad);
   291	
   292		ahash_request_set_virt(req, opad, NULL, bs);
   293		err = err ?:
   294		      crypto_ahash_init(req) ?:
   295		      crypto_ahash_update(req) ?:
   296		      crypto_ahash_export(req, opad);
   297	
   298	out_zero_req:
   299		HASH_REQUEST_ZERO(req);
   300		return err;
   301	}
   302	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

