Return-Path: <linux-kernel+bounces-874019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C2112C1557A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 345DB4F6896
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2952F616B;
	Tue, 28 Oct 2025 15:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HPg7mpKf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A309E23EAA0
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761663909; cv=none; b=EilT2fvRzuFU2PnwIg/TfjHhLvsiqaxHxPNNXk7lCcXcts2M953+aKqDjHnoKnSSEHfk+MrPxeB8hufWcrdbgHPIhF06Hex0SX8Szj1TpvPPsM9sU5fVwkEqTwLX+qv9RcGsQdSEkHB6oTWHjWl3x9V7f+IdlDGjCVC97JuO6sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761663909; c=relaxed/simple;
	bh=OHfYSDu0Rzck6fAtpoUhjpHneN2suUToeD1/fVtFVAk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=F3HHR0glXqAoEO2UfJs7g+cUqKhFYTlYpmSILHWJKT06lQR1qHxcizBLbUVVP8yFXGn2JohtYfSilj/vbxzyZ6/DdlkW4RGS0dmYhv5zlkSEYjNOqtSDuTczOQetSv1QzVqNnGARjX5UBpBt/Fcz52sXFLcpALtudQIhXoC+CQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HPg7mpKf; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761663907; x=1793199907;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OHfYSDu0Rzck6fAtpoUhjpHneN2suUToeD1/fVtFVAk=;
  b=HPg7mpKf6PI4bVe1RqtdvMsiU5V8w1nKmj2ElqSNGAiJd3prDgooikRP
   RWk9tHC+GgA7hFTi7WIWdJAkh3tmpxEXdp0MCH2GOc4o7PbzLeAmsmFpf
   3XbF4Gfg+9yVHEFJihl+KigrLehyG5TTULaD/YgLGZrQphQa4pLT5eqqM
   4tr5ru62uSmv5cpXnzuEVj7X1Uf1+6XJLbxzIDeyNFE8orziDc1FXZurs
   TlUp0iSSFPibsEZJSssfEFWug941pmAEf9CQXzX+1/L/ewZzmPBu5p9N5
   SdjWLzJdNN2Vn0Cx7QoOy5A0ijV+eXPI6tpHkrMrAwYEREQd2WCDBIU0c
   Q==;
X-CSE-ConnectionGUID: Sckihs9KSkamTkLoRhocCw==
X-CSE-MsgGUID: 8AemSZGxTw++6tZ6vD/ozA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="75109664"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="75109664"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 08:05:07 -0700
X-CSE-ConnectionGUID: ciu9NH6hR5y4h7OD17NMww==
X-CSE-MsgGUID: gj+uVHleT/ScWNS7AENkSQ==
X-ExtLoop1: 1
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 28 Oct 2025 08:05:05 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vDlFv-000JHH-1N;
	Tue, 28 Oct 2025 15:05:03 +0000
Date: Tue, 28 Oct 2025 23:04:37 +0800
From: kernel test robot <lkp@intel.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: crypto/hmac.c:251:12: warning: stack frame size (1152) exceeds limit
 (1024) in 'hmac_setkey_ahash'
Message-ID: <202510282205.ELXg3cL3-lkp@intel.com>
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
head:   fd57572253bc356330dbe5b233c2e1d8426c66fd
commit: c3103416d5217655d707d9417aaf66f184e3d72f crypto: hmac - Add ahash support
date:   5 months ago
config: mips-eyeq6_defconfig (https://download.01.org/0day-ci/archive/20251028/202510282205.ELXg3cL3-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project d1c086e82af239b245fe8d7832f2753436634990)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251028/202510282205.ELXg3cL3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510282205.ELXg3cL3-lkp@intel.com/

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

