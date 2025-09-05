Return-Path: <linux-kernel+bounces-801925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A100BB44BB2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 04:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B95CA41615
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 02:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2F1223DE5;
	Fri,  5 Sep 2025 02:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nKG3bc5C"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24621F4177
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 02:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757040286; cv=none; b=gGeyb4YW6tbj09ORzVEW5g75stxYQwcbB0ojr0pHxn3dEM0+x7R7WhqQWF7yYIrhrNgkm5/9TyZn1WYpHSXo6Z7LrK6mpE7drZtxF61KVFxTHMogyGtFgB7m5Ce2HbnON9optQJGsOgt5rNbQNdSLVrpUc00mV1UrkSY/HYqq1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757040286; c=relaxed/simple;
	bh=S7np+C9VMJWn+bcoWCgkhTBHAoVmM12mkBfUGqXesNo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=L8R+pfSESzSgiA9cXHqanR9ImSrWDWOubrTRr3nbN1i2rvm/Qp/8j0rNMwg4gQHHsPCIlJRbB84iDaEEL3CXfPvNsoDby2f3QbjmKxxM/hFM40vwCua9IbntjqiiUSPaA3o0Kp22057OdtHdswGxhA9i6X5NLO8NlP5ZHPjP/TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nKG3bc5C; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757040285; x=1788576285;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=S7np+C9VMJWn+bcoWCgkhTBHAoVmM12mkBfUGqXesNo=;
  b=nKG3bc5CawZhuepOVkGn1xtjxIaQsNpD1e9JRWXfmkf1ac0vpPbRSf5r
   ZI4GG3Y4YKsL+cmoYnEectAsttFGaFuSiFfjSOE2xwDPvGHT+L44q6TIj
   4/8R/B2yZimjgTOmqDJq5KlcDH2QMcx7wZzE9eBM/snsnSnzc+oYVOnze
   fEbWeItyjhyn5Y6eFqka5T/Rk0UCJ/pQrSWabGk2+n3lArbGzBTrJDO+A
   3atlSrIuLRzVru0bhwrHhFyQLpHqaKV4TlF9lWBiJEJ+8lpPAIIBBpjjH
   s72qN/rSV0x/Iz7Fjwapvc0ka/39YJDsZGKEZZc2NSe3YSsl7kJsE/9PE
   Q==;
X-CSE-ConnectionGUID: KzltWk2GSzSo67x+pj8rNw==
X-CSE-MsgGUID: mg1WBeMgTcekwqqP1ZyF8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11543"; a="76999539"
X-IronPort-AV: E=Sophos;i="6.18,240,1751266800"; 
   d="scan'208";a="76999539"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 19:44:44 -0700
X-CSE-ConnectionGUID: Ck01XruKRZmHwGjwLiz+Ng==
X-CSE-MsgGUID: oUxE6mM2SPm11H74/yHcdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,240,1751266800"; 
   d="scan'208";a="171275574"
Received: from lkp-server02.sh.intel.com (HELO 06ba48ef64e9) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 04 Sep 2025 19:44:42 -0700
Received: from kbuild by 06ba48ef64e9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uuMRL-00068W-1L;
	Fri, 05 Sep 2025 02:44:39 +0000
Date: Fri, 5 Sep 2025 10:43:00 +0800
From: kernel test robot <lkp@intel.com>
To: Ian Rogers <irogers@google.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: [tip:timers/vdso 12/15] include/vdso/unaligned.h:23:9: warning:
 '__builtin_memcpy' reading 4 bytes from a region of size 1
Message-ID: <202509051042.7KOze0fZ-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/vdso
head:   e994a4197086cd5df809277b3b96c88f75e1e860
commit: 34a1cbf21227f1327ead30dcf2a52aac79bf4f15 [12/15] vdso: Switch get/put_unaligned() from packed struct to memcpy()
config: parisc-allnoconfig (https://download.01.org/0day-ci/archive/20250905/202509051042.7KOze0fZ-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250905/202509051042.7KOze0fZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509051042.7KOze0fZ-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/swab.h:5,
                    from include/uapi/linux/byteorder/big_endian.h:14,
                    from include/linux/byteorder/big_endian.h:5,
                    from arch/parisc/include/uapi/asm/byteorder.h:5,
                    from arch/parisc/include/asm/bitops.h:11,
                    from include/linux/bitops.h:67,
                    from include/linux/kernel.h:23,
                    from arch/parisc/include/asm/bug.h:5,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/linux/sched.h:14,
                    from include/linux/uaccess.h:9,
                    from arch/parisc/boot/compressed/misc.c:7:
   In function 'get_unaligned_le32',
       inlined from 'decompress_kernel' at arch/parisc/boot/compressed/misc.c:312:16:
>> include/vdso/unaligned.h:23:9: warning: '__builtin_memcpy' reading 4 bytes from a region of size 1 [-Wstringop-overread]
      23 |         __builtin_memcpy(&__get_unaligned_val, (void *)(ptr),           \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      24 |                          sizeof(__get_unaligned_val));                  \
         |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/uapi/linux/swab.h:120:19: note: in definition of macro '__swab32'
     120 |         __fswab32(x))
         |                   ^
   include/linux/byteorder/generic.h:89:21: note: in expansion of macro '__le32_to_cpu'
      89 | #define le32_to_cpu __le32_to_cpu
         |                     ^~~~~~~~~~~~~
   include/linux/unaligned.h:23:28: note: in expansion of macro '__get_unaligned_t'
      23 |         return le32_to_cpu(__get_unaligned_t(__le32, p));
         |                            ^~~~~~~~~~~~~~~~~
   arch/parisc/boot/compressed/misc.c: In function 'decompress_kernel':
   arch/parisc/boot/compressed/misc.c:29:13: note: source object 'output_len' of size 1
      29 | extern char output_len;
         |             ^~~~~~~~~~


vim +/__builtin_memcpy +23 include/vdso/unaligned.h

     6	
     7	/**
     8	 * __get_unaligned_t - read an unaligned value from memory.
     9	 * @type:	the type to load from the pointer.
    10	 * @ptr:	the pointer to load from.
    11	 *
    12	 * Use memcpy to affect an unaligned type sized load avoiding undefined behavior
    13	 * from approaches like type punning that require -fno-strict-aliasing in order
    14	 * to be correct. As type may be const, use __unqual_scalar_typeof to map to a
    15	 * non-const type - you can't memcpy into a const type. The
    16	 * __get_unaligned_ctrl_type gives __unqual_scalar_typeof its required
    17	 * expression rather than type, a pointer is used to avoid warnings about mixing
    18	 * the use of 0 and NULL. The void* cast silences ubsan warnings.
    19	 */
    20	#define __get_unaligned_t(type, ptr) ({					\
    21		type *__get_unaligned_ctrl_type __always_unused = NULL;		\
    22		__unqual_scalar_typeof(*__get_unaligned_ctrl_type) __get_unaligned_val; \
  > 23		__builtin_memcpy(&__get_unaligned_val, (void *)(ptr),		\
    24				 sizeof(__get_unaligned_val));			\
    25		__get_unaligned_val;						\
    26	})
    27	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

