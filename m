Return-Path: <linux-kernel+bounces-792089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD66CB3C00B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 17:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 034EC3AD055
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 15:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B196334703;
	Fri, 29 Aug 2025 15:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hHfCCbCM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E485832C32C
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 15:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756482793; cv=none; b=TMU+rrf9NW2BAFKqCnrWL3+xW62CGKpCy+54bJdd5KrrHDomhJPjhquOZbDscKq+wvhk7ZgEuB6VWuOnKI2rDCwSYSmVh4mqFwesVGrIbPkb+Wp5XD4rLIrzArm3l7t/OxJTmgI7Xy81tTHkF9N/rKi3bDuuuV0A992XzQADIQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756482793; c=relaxed/simple;
	bh=r6o6tZrAu3+w3lcyJAMYfuRXyaYgtSBycjjyO1n469Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FnyZ4xhlYA43526HD1cg3egHgPNwb2KrgMlEjPqQO54eLDajtcb33RF5T13IFHLqcphd+us7PEa2mBfSFRvlpBOXOxnzaKSehxROTPzmna812UamxBSYuM07+ZNyXBwjCC4uDuT8xkmn9Wy/hCU/kLlfjdP5hMZC5U7tWbd4MQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hHfCCbCM; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756482792; x=1788018792;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=r6o6tZrAu3+w3lcyJAMYfuRXyaYgtSBycjjyO1n469Y=;
  b=hHfCCbCMmGrKUh+N7qwc5+ZM1CGKc5ibwAtUK36p9ftZ0hAhlvkFHJR/
   WzF1WOv4pQUV50LMSpLOnnzlBJF8jLbDSNwT2+z9Yzm4g8MnalpLGTbfe
   Yl+p4fPHG1Q3S+2i51wIntfXxRiQBj/n+hSNjb6qWB52603568jh2Zg9P
   mDPCff9f9SbWQlkdtekOYiatNo9+sbcNLgbVx7v+mOfvaVTvaT2uAKMoM
   BpdizoP4C7VFxngNodaAYOvncYqbBgaqGhNNoNO/r4jNXsLEzZu6/LiAc
   n7ylbkUs45yV9Znb3/oS9iFEuZJvfmB1SvMBAg6VQXG6o8nrPG5pRSYqY
   w==;
X-CSE-ConnectionGUID: OSGLrUzQTWSboDJqzdS3mQ==
X-CSE-MsgGUID: 7CTJVCIxSTKLTSdQJtBvng==
X-IronPort-AV: E=McAfee;i="6800,10657,11537"; a="69479396"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="69479396"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 08:53:11 -0700
X-CSE-ConnectionGUID: QImWmryqRbOtWb01gAjz0A==
X-CSE-MsgGUID: opv4oweYSoisGenrwSOezA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="174582244"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 29 Aug 2025 08:53:10 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1us1PX-000UjF-0y;
	Fri, 29 Aug 2025 15:53:07 +0000
Date: Fri, 29 Aug 2025 23:52:12 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20250814 2/8]
 security/integrity/integrity.h:37:67: error: invalid application of 'sizeof'
 to incomplete type 'struct evm_ima_xattr_data_hdr'
Message-ID: <202508292352.Q9sA9NNG-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20250814
head:   4774a38f9cf278ece929331bdef17ab5db24684c
commit: c2ca48406d8d7e98ac35251db90286b3b86f01c1 [2/8] Revert "integrity: Avoid -Wflex-array-member-not-at-end warnings"
config: csky-randconfig-001-20250829 (https://download.01.org/0day-ci/archive/20250829/202508292352.Q9sA9NNG-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 9.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250829/202508292352.Q9sA9NNG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508292352.Q9sA9NNG-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/key.h:14,
                    from include/linux/security.h:27,
                    from security/integrity/iint.c:12:
>> security/integrity/integrity.h:37:67: error: invalid application of 'sizeof' to incomplete type 'struct evm_ima_xattr_data_hdr'
      37 | static_assert(offsetof(struct evm_ima_xattr_data, data) == sizeof(struct evm_ima_xattr_data_hdr),
         |                                                                   ^~~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   security/integrity/integrity.h:37:1: note: in expansion of macro 'static_assert'
      37 | static_assert(offsetof(struct evm_ima_xattr_data, data) == sizeof(struct evm_ima_xattr_data_hdr),
         | ^~~~~~~~~~~~~
>> include/linux/stddef.h:16:32: error: expression in static assertion is not an integer
      16 | #define offsetof(TYPE, MEMBER) __builtin_offsetof(TYPE, MEMBER)
         |                                ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   security/integrity/integrity.h:37:1: note: in expansion of macro 'static_assert'
      37 | static_assert(offsetof(struct evm_ima_xattr_data, data) == sizeof(struct evm_ima_xattr_data_hdr),
         | ^~~~~~~~~~~~~
   security/integrity/integrity.h:37:15: note: in expansion of macro 'offsetof'
      37 | static_assert(offsetof(struct evm_ima_xattr_data, data) == sizeof(struct evm_ima_xattr_data_hdr),
         |               ^~~~~~~~
>> security/integrity/integrity.h:64:66: error: invalid application of 'sizeof' to incomplete type 'struct ima_digest_data_hdr'
      64 | static_assert(offsetof(struct ima_digest_data, digest) == sizeof(struct ima_digest_data_hdr),
         |                                                                  ^~~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   security/integrity/integrity.h:64:1: note: in expansion of macro 'static_assert'
      64 | static_assert(offsetof(struct ima_digest_data, digest) == sizeof(struct ima_digest_data_hdr),
         | ^~~~~~~~~~~~~
>> include/linux/stddef.h:16:32: error: expression in static assertion is not an integer
      16 | #define offsetof(TYPE, MEMBER) __builtin_offsetof(TYPE, MEMBER)
         |                                ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   security/integrity/integrity.h:64:1: note: in expansion of macro 'static_assert'
      64 | static_assert(offsetof(struct ima_digest_data, digest) == sizeof(struct ima_digest_data_hdr),
         | ^~~~~~~~~~~~~
   security/integrity/integrity.h:64:15: note: in expansion of macro 'offsetof'
      64 | static_assert(offsetof(struct ima_digest_data, digest) == sizeof(struct ima_digest_data_hdr),
         |               ^~~~~~~~


vim +37 security/integrity/integrity.h

6be5cc5246f807f Dmitry Kasatkin       2011-03-09  32  
6be5cc5246f807f Dmitry Kasatkin       2011-03-09  33  struct evm_ima_xattr_data {
6be5cc5246f807f Dmitry Kasatkin       2011-03-09  34  	u8 type;
650b29dbdf2caf7 Thiago Jung Bauermann 2019-06-11  35  	u8 data[];
650b29dbdf2caf7 Thiago Jung Bauermann 2019-06-11  36  } __packed;
08ae3e5f5fc8edb Gustavo A. R. Silva   2024-08-08 @37  static_assert(offsetof(struct evm_ima_xattr_data, data) == sizeof(struct evm_ima_xattr_data_hdr),
08ae3e5f5fc8edb Gustavo A. R. Silva   2024-08-08  38  	      "struct member likely outside of __struct_group()");
650b29dbdf2caf7 Thiago Jung Bauermann 2019-06-11  39  
650b29dbdf2caf7 Thiago Jung Bauermann 2019-06-11  40  /* Only used in the EVM HMAC code. */
650b29dbdf2caf7 Thiago Jung Bauermann 2019-06-11  41  struct evm_xattr {
c2ca48406d8d7e9 Gustavo A. R. Silva   2025-08-22  42  	struct evm_ima_xattr_data data;
6be5cc5246f807f Dmitry Kasatkin       2011-03-09  43  	u8 digest[SHA1_DIGEST_SIZE];
c7c8bb237fdbff9 Dmitry Kasatkin       2013-04-25  44  } __packed;
c7c8bb237fdbff9 Dmitry Kasatkin       2013-04-25  45  
398c42e2c46c88b Mimi Zohar            2021-11-24  46  #define IMA_MAX_DIGEST_SIZE	HASH_MAX_DIGESTSIZE
c7c8bb237fdbff9 Dmitry Kasatkin       2013-04-25  47  
c7c8bb237fdbff9 Dmitry Kasatkin       2013-04-25  48  struct ima_digest_data {
c7c8bb237fdbff9 Dmitry Kasatkin       2013-04-25  49  	u8 algo;
c7c8bb237fdbff9 Dmitry Kasatkin       2013-04-25  50  	u8 length;
3ea7a56067e6632 Dmitry Kasatkin       2013-08-12  51  	union {
3ea7a56067e6632 Dmitry Kasatkin       2013-08-12  52  		struct {
3ea7a56067e6632 Dmitry Kasatkin       2013-08-12  53  			u8 unused;
c7c8bb237fdbff9 Dmitry Kasatkin       2013-04-25  54  			u8 type;
3ea7a56067e6632 Dmitry Kasatkin       2013-08-12  55  		} sha1;
3ea7a56067e6632 Dmitry Kasatkin       2013-08-12  56  		struct {
3ea7a56067e6632 Dmitry Kasatkin       2013-08-12  57  			u8 type;
3ea7a56067e6632 Dmitry Kasatkin       2013-08-12  58  			u8 algo;
3ea7a56067e6632 Dmitry Kasatkin       2013-08-12  59  		} ng;
3ea7a56067e6632 Dmitry Kasatkin       2013-08-12  60  		u8 data[2];
3ea7a56067e6632 Dmitry Kasatkin       2013-08-12  61  	} xattr;
eb492c627a61b56 Gustavo A. R. Silva   2020-05-28  62  	u8 digest[];
c7c8bb237fdbff9 Dmitry Kasatkin       2013-04-25  63  } __packed;
08ae3e5f5fc8edb Gustavo A. R. Silva   2024-08-08 @64  static_assert(offsetof(struct ima_digest_data, digest) == sizeof(struct ima_digest_data_hdr),
08ae3e5f5fc8edb Gustavo A. R. Silva   2024-08-08  65  	      "struct member likely outside of __struct_group()");
6be5cc5246f807f Dmitry Kasatkin       2011-03-09  66  

:::::: The code at line 37 was first introduced by commit
:::::: 08ae3e5f5fc8edb9bd0c7ef9696ff29ef18b26ef integrity: Use static_assert() to check struct sizes

:::::: TO: Gustavo A. R. Silva <gustavoars@kernel.org>
:::::: CC: Mimi Zohar <zohar@linux.ibm.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

