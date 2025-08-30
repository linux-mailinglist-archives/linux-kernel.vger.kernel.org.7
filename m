Return-Path: <linux-kernel+bounces-792950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61AE7B3CACE
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 14:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10B5B7B9FB7
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 12:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7CD255E53;
	Sat, 30 Aug 2025 12:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jHMilFvB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F40C2561C2
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 12:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756557471; cv=none; b=N7k0pRyc4TCdI3ZrkfpFbErWN0KHVXNFn+A6I4CKneW9tL0YYMAdZP8YgW8CVeXCTVVZ23EXoVfgMknuJkIHO27o33NuJNYReFIH2NW+gnTqrTT+mZv2QBaKFONu6ZC6kOq5krnhCXE4W7soQ1lTuiWqwRsPGMbXkjVEyJbORpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756557471; c=relaxed/simple;
	bh=eIiTLYyTepUtJ8Ga9QkkTrEphPPsolfP6YqoM/lbn5w=;
	h=Date:From:To:Cc:Subject:Message-ID; b=AgT+GEKdtDss7CWyyu4t93W2/7XKQjStGq4NlYe83p5AwOGN9kDDOf+Ks3byx+w9s+TcgkAYUQwMWzstaFpiAkNrVCrJXf9tf6VWjbeb5nXImrAsWJIlqGizbzAcVrh1sVHqe1vTmIb4YOKl1XmBxt2QKQW93aaeci3SDL0hnnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jHMilFvB; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756557469; x=1788093469;
  h=date:from:to:cc:subject:message-id;
  bh=eIiTLYyTepUtJ8Ga9QkkTrEphPPsolfP6YqoM/lbn5w=;
  b=jHMilFvBFxad1Ub6I2BLlwYRKrG+8X4664M+3d6jJVJSqzOprPoMlz24
   tS58lunFlVz+57ZT4KIIROgsUdPPh7kRKd7VaqunFMqwyxwI4J/5jkJR4
   eYxxFtCmF9MOiwAYN4gmo7ghYBNSHuGuIRN1lfIqPZLQt5jddHI9gnWmF
   gpdmUMkDnfF1ksm/MvU9tDHkJmtibv9oFa+67/3jXTKZtWDpwzmmPbh4y
   Xb5QzJ29xPmSmMEszFGm66i7GN6q0tc27rmOoWP31egc5GtjjE15t5fGH
   AVGtE/g4ptS4KoVegSoCSi3hne/OmcJziJEPuI6rcTVUNyhnWwk6z5hyV
   w==;
X-CSE-ConnectionGUID: YpwQewE5TyCBkKws9BBzKw==
X-CSE-MsgGUID: 9FUsgPZ1TMe6ueSnZuFagw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="58896399"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="58896399"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2025 05:37:47 -0700
X-CSE-ConnectionGUID: fK1ukTa/SAOpxZmQsu+L5A==
X-CSE-MsgGUID: tCsAvwUmTOySlE5br+K6Lw==
X-ExtLoop1: 1
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 30 Aug 2025 05:37:45 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1usKpz-000VN5-12;
	Sat, 30 Aug 2025 12:37:43 +0000
Date: Sat, 30 Aug 2025 20:37:32 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20250814] BUILD REGRESSION
 4774a38f9cf278ece929331bdef17ab5db24684c
Message-ID: <202508302040.Y9GoA4SE-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20250814
branch HEAD: 4774a38f9cf278ece929331bdef17ab5db24684c  hyperv: Avoid a hundred -Wflex-array-member-at-end warnings

Error/Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202508292352.Q9sA9NNG-lkp@intel.com

    include/linux/stddef.h:16:32: error: expression in static assertion is not an integer
    include/linux/stddef.h:16:33: error: expression in static assertion is not an integer
    security/integrity/evm/../integrity.h:37:60: error: invalid application of 'sizeof' to an incomplete type 'struct evm_ima_xattr_data_hdr'
    security/integrity/evm/../integrity.h:37:67: error: invalid application of 'sizeof' to incomplete type 'struct evm_ima_xattr_data_hdr'
    security/integrity/evm/../integrity.h:64:59: error: invalid application of 'sizeof' to an incomplete type 'struct ima_digest_data_hdr'
    security/integrity/evm/../integrity.h:64:66: error: invalid application of 'sizeof' to incomplete type 'struct ima_digest_data_hdr'
    security/integrity/ima/../integrity.h:37:60: error: invalid application of 'sizeof' to an incomplete type 'struct evm_ima_xattr_data_hdr'
    security/integrity/ima/../integrity.h:37:67: error: invalid application of 'sizeof' to incomplete type 'struct evm_ima_xattr_data_hdr'
    security/integrity/ima/../integrity.h:64:59: error: invalid application of 'sizeof' to an incomplete type 'struct ima_digest_data_hdr'
    security/integrity/ima/../integrity.h:64:66: error: invalid application of 'sizeof' to incomplete type 'struct ima_digest_data_hdr'
    security/integrity/integrity.h:37:60: error: invalid application of 'sizeof' to an incomplete type 'struct evm_ima_xattr_data_hdr'
    security/integrity/integrity.h:37:67: error: invalid application of 'sizeof' to incomplete type 'struct evm_ima_xattr_data_hdr'
    security/integrity/integrity.h:64:59: error: invalid application of 'sizeof' to an incomplete type 'struct ima_digest_data_hdr'
    security/integrity/integrity.h:64:66: error: invalid application of 'sizeof' to incomplete type 'struct ima_digest_data_hdr'
    security/integrity/platform_certs/../integrity.h:37:60: error: invalid application of 'sizeof' to an incomplete type 'struct evm_ima_xattr_data_hdr'
    security/integrity/platform_certs/../integrity.h:37:67: error: invalid application of 'sizeof' to incomplete type 'struct evm_ima_xattr_data_hdr'
    security/integrity/platform_certs/../integrity.h:64:59: error: invalid application of 'sizeof' to an incomplete type 'struct ima_digest_data_hdr'
    security/integrity/platform_certs/../integrity.h:64:66: error: invalid application of 'sizeof' to incomplete type 'struct ima_digest_data_hdr'

Error/Warning ids grouped by kconfigs:

recent_errors
|-- alpha-allmodconfig
|   |-- include-linux-stddef.h:error:expression-in-static-assertion-is-not-an-integer
|   |-- security-integrity-ima-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   `-- security-integrity-ima-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|-- alpha-allyesconfig
|   |-- include-linux-stddef.h:error:expression-in-static-assertion-is-not-an-integer
|   |-- security-integrity-evm-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-evm-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-ima-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-ima-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   `-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|-- arc-allmodconfig
|   |-- include-linux-stddef.h:error:expression-in-static-assertion-is-not-an-integer
|   |-- security-integrity-evm-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-evm-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-ima-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-ima-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-platform_certs-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   `-- security-integrity-platform_certs-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|-- arc-allyesconfig
|   |-- include-linux-stddef.h:error:expression-in-static-assertion-is-not-an-integer
|   |-- security-integrity-evm-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-evm-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-ima-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-ima-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-platform_certs-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   `-- security-integrity-platform_certs-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|-- arm-allmodconfig
|   |-- include-linux-stddef.h:error:expression-in-static-assertion-is-not-an-integer
|   |-- security-integrity-evm-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-evm-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-ima-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-ima-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-platform_certs-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   `-- security-integrity-platform_certs-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|-- arm-allyesconfig
|   |-- include-linux-stddef.h:error:expression-in-static-assertion-is-not-an-integer
|   |-- security-integrity-evm-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-evm-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-ima-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-ima-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-platform_certs-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   `-- security-integrity-platform_certs-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|-- arm64-allmodconfig
|   |-- security-integrity-evm-..-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-evm-..-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-ima-..-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-ima-..-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-platform_certs-..-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-evm_ima_xattr_data_hdr
|   `-- security-integrity-platform_certs-..-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-ima_digest_data_hdr
|-- arm64-randconfig-004-20250829
|   |-- include-linux-stddef.h:error:expression-in-static-assertion-is-not-an-integer
|   |-- security-integrity-evm-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-evm-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   `-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|-- csky-randconfig-001-20250829
|   |-- include-linux-stddef.h:error:expression-in-static-assertion-is-not-an-integer
|   |-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   `-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|-- hexagon-allmodconfig
|   |-- security-integrity-evm-..-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-evm-..-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-ima-..-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-ima-..-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-platform_certs-..-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-evm_ima_xattr_data_hdr
|   `-- security-integrity-platform_certs-..-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-ima_digest_data_hdr
|-- hexagon-allyesconfig
|   |-- security-integrity-evm-..-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-evm-..-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-ima-..-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-ima-..-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-platform_certs-..-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-evm_ima_xattr_data_hdr
|   `-- security-integrity-platform_certs-..-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-ima_digest_data_hdr
|-- i386-allmodconfig
|   |-- include-linux-stddef.h:error:expression-in-static-assertion-is-not-an-integer
|   |-- security-integrity-evm-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-evm-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-ima-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-ima-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-platform_certs-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   `-- security-integrity-platform_certs-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|-- i386-allyesconfig
|   |-- include-linux-stddef.h:error:expression-in-static-assertion-is-not-an-integer
|   |-- security-integrity-evm-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-evm-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-ima-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-ima-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-platform_certs-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   `-- security-integrity-platform_certs-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|-- i386-defconfig
|   |-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-evm_ima_xattr_data_hdr
|   `-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-ima_digest_data_hdr
|-- i386-randconfig-141-20250830
|   |-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-evm_ima_xattr_data_hdr
|   `-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-ima_digest_data_hdr
|-- loongarch-allmodconfig
|   |-- security-integrity-evm-..-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-evm-..-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-ima-..-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-ima-..-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-platform_certs-..-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-evm_ima_xattr_data_hdr
|   `-- security-integrity-platform_certs-..-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-ima_digest_data_hdr
|-- loongarch-allyesconfig
|   |-- security-integrity-evm-..-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-evm-..-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-ima-..-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-ima-..-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-platform_certs-..-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-evm_ima_xattr_data_hdr
|   `-- security-integrity-platform_certs-..-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-ima_digest_data_hdr
|-- loongarch-randconfig-001-20250829
|   |-- security-integrity-evm-..-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-evm-..-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-evm_ima_xattr_data_hdr
|   `-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-ima_digest_data_hdr
|-- m68k-allmodconfig
|   |-- include-linux-stddef.h:error:expression-in-static-assertion-is-not-an-integer
|   |-- security-integrity-evm-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-evm-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-ima-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-ima-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-platform_certs-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   `-- security-integrity-platform_certs-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|-- m68k-allyesconfig
|   |-- include-linux-stddef.h:error:expression-in-static-assertion-is-not-an-integer
|   |-- security-integrity-evm-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-evm-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-ima-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-ima-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-platform_certs-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   `-- security-integrity-platform_certs-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|-- microblaze-allmodconfig
|   |-- include-linux-stddef.h:error:expression-in-static-assertion-is-not-an-integer
|   |-- security-integrity-evm-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-evm-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-ima-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-ima-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-platform_certs-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   `-- security-integrity-platform_certs-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|-- microblaze-allyesconfig
|   |-- include-linux-stddef.h:error:expression-in-static-assertion-is-not-an-integer
|   |-- security-integrity-evm-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-evm-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-ima-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-ima-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-platform_certs-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   `-- security-integrity-platform_certs-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|-- mips-allmodconfig
|   |-- include-linux-stddef.h:error:expression-in-static-assertion-is-not-an-integer
|   |-- security-integrity-ima-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   `-- security-integrity-ima-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|-- mips-allyesconfig
|   |-- include-linux-stddef.h:error:expression-in-static-assertion-is-not-an-integer
|   |-- security-integrity-evm-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-evm-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-ima-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-ima-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-platform_certs-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   `-- security-integrity-platform_certs-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|-- openrisc-allyesconfig
|   |-- include-linux-stddef.h:error:expression-in-static-assertion-is-not-an-integer
|   |-- security-integrity-evm-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-evm-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-ima-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-ima-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-platform_certs-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   `-- security-integrity-platform_certs-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|-- parisc-allmodconfig
|   |-- include-linux-stddef.h:error:expression-in-static-assertion-is-not-an-integer
|   |-- security-integrity-evm-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-evm-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-ima-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-ima-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-platform_certs-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   `-- security-integrity-platform_certs-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|-- parisc-allyesconfig
|   |-- include-linux-stddef.h:error:expression-in-static-assertion-is-not-an-integer
|   |-- security-integrity-evm-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-evm-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-ima-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-ima-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-platform_certs-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   `-- security-integrity-platform_certs-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|-- powerpc-allmodconfig
|   |-- include-linux-stddef.h:error:expression-in-static-assertion-is-not-an-integer
|   |-- security-integrity-evm-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-evm-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-ima-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-ima-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-platform_certs-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   `-- security-integrity-platform_certs-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|-- powerpc-allyesconfig
|   |-- security-integrity-evm-..-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-evm-..-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-ima-..-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-ima-..-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-platform_certs-..-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-evm_ima_xattr_data_hdr
|   `-- security-integrity-platform_certs-..-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-ima_digest_data_hdr
|-- powerpc-randconfig-002-20250829
|   |-- security-integrity-ima-..-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-evm_ima_xattr_data_hdr
|   `-- security-integrity-ima-..-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-ima_digest_data_hdr
|-- riscv-allmodconfig
|   |-- security-integrity-evm-..-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-evm-..-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-ima-..-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-ima-..-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-platform_certs-..-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-evm_ima_xattr_data_hdr
|   `-- security-integrity-platform_certs-..-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-ima_digest_data_hdr
|-- riscv-allyesconfig
|   |-- security-integrity-ima-..-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-evm_ima_xattr_data_hdr
|   `-- security-integrity-ima-..-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-ima_digest_data_hdr
|-- riscv-defconfig
|   |-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-evm_ima_xattr_data_hdr
|   `-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-ima_digest_data_hdr
|-- s390-allmodconfig
|   |-- security-integrity-evm-..-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-evm-..-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-ima-..-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-ima-..-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-platform_certs-..-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-evm_ima_xattr_data_hdr
|   `-- security-integrity-platform_certs-..-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-ima_digest_data_hdr
|-- s390-allyesconfig
|   |-- include-linux-stddef.h:error:expression-in-static-assertion-is-not-an-integer
|   |-- security-integrity-evm-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-evm-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-ima-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-ima-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   `-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|-- s390-defconfig
|   |-- security-integrity-ima-..-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-ima-..-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-platform_certs-..-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-evm_ima_xattr_data_hdr
|   `-- security-integrity-platform_certs-..-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-ima_digest_data_hdr
|-- sh-allmodconfig
|   |-- include-linux-stddef.h:error:expression-in-static-assertion-is-not-an-integer
|   |-- security-integrity-evm-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-evm-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-ima-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-ima-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-platform_certs-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   `-- security-integrity-platform_certs-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|-- sh-allyesconfig
|   |-- include-linux-stddef.h:error:expression-in-static-assertion-is-not-an-integer
|   |-- security-integrity-evm-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-evm-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-ima-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-ima-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-platform_certs-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   `-- security-integrity-platform_certs-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|-- sparc-allmodconfig
|   |-- include-linux-stddef.h:error:expression-in-static-assertion-is-not-an-integer
|   |-- security-integrity-evm-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-evm-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   `-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|-- sparc-allyesconfig
|   |-- include-linux-stddef.h:error:expression-in-static-assertion-is-not-an-integer
|   |-- security-integrity-ima-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   `-- security-integrity-ima-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|-- um-allmodconfig
|   |-- security-integrity-evm-..-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-evm-..-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-ima-..-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-ima-..-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-platform_certs-..-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-evm_ima_xattr_data_hdr
|   `-- security-integrity-platform_certs-..-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-ima_digest_data_hdr
|-- um-allyesconfig
|   |-- include-linux-stddef.h:error:expression-in-static-assertion-is-not-an-integer
|   |-- security-integrity-evm-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-evm-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-ima-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-ima-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-platform_certs-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   `-- security-integrity-platform_certs-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|-- x86_64-allmodconfig
|   |-- security-integrity-ima-..-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-evm_ima_xattr_data_hdr
|   `-- security-integrity-ima-..-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-ima_digest_data_hdr
|-- x86_64-allyesconfig
|   |-- security-integrity-evm-..-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-evm-..-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-ima-..-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-ima-..-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-platform_certs-..-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-evm_ima_xattr_data_hdr
|   `-- security-integrity-platform_certs-..-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-ima_digest_data_hdr
|-- x86_64-defconfig
|   |-- include-linux-stddef.h:error:expression-in-static-assertion-is-not-an-integer
|   |-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
|   `-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
|-- x86_64-rhel-9.4-rust
|   |-- security-integrity-evm-..-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-evm-..-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-ima-..-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-ima-..-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-evm_ima_xattr_data_hdr
|   |-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-ima_digest_data_hdr
|   |-- security-integrity-platform_certs-..-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-evm_ima_xattr_data_hdr
|   `-- security-integrity-platform_certs-..-integrity.h:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-ima_digest_data_hdr
`-- xtensa-allyesconfig
    |-- include-linux-stddef.h:error:expression-in-static-assertion-is-not-an-integer
    |-- security-integrity-evm-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
    |-- security-integrity-evm-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
    |-- security-integrity-ima-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
    |-- security-integrity-ima-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
    |-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
    |-- security-integrity-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr
    |-- security-integrity-platform_certs-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-evm_ima_xattr_data_hdr
    `-- security-integrity-platform_certs-..-integrity.h:error:invalid-application-of-sizeof-to-incomplete-type-struct-ima_digest_data_hdr

elapsed time: 1448m

configs tested: 129
configs skipped: 3

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20250829    gcc-8.5.0
arc                   randconfig-002-20250829    gcc-10.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                         orion5x_defconfig    clang-22
arm                   randconfig-001-20250829    gcc-10.5.0
arm                   randconfig-002-20250829    clang-22
arm                   randconfig-003-20250829    clang-22
arm                   randconfig-004-20250829    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250829    clang-22
arm64                 randconfig-002-20250829    gcc-12.5.0
arm64                 randconfig-003-20250829    clang-22
arm64                 randconfig-004-20250829    gcc-9.5.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250829    gcc-9.5.0
csky                  randconfig-002-20250829    gcc-10.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250829    clang-22
hexagon               randconfig-002-20250829    clang-22
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250829    gcc-12
i386        buildonly-randconfig-002-20250829    clang-20
i386        buildonly-randconfig-003-20250829    clang-20
i386        buildonly-randconfig-004-20250829    clang-20
i386        buildonly-randconfig-005-20250829    gcc-12
i386        buildonly-randconfig-006-20250829    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250829    clang-22
loongarch             randconfig-002-20250829    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                        m5272c3_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                          ath25_defconfig    clang-22
mips                       bmips_be_defconfig    gcc-15.1.0
mips                           ip28_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250829    gcc-11.5.0
nios2                 randconfig-002-20250829    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250829    gcc-14.3.0
parisc                randconfig-002-20250829    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                      katmai_defconfig    clang-22
powerpc               randconfig-001-20250829    gcc-13.4.0
powerpc               randconfig-002-20250829    clang-22
powerpc               randconfig-003-20250829    gcc-12.5.0
powerpc                     tqm8548_defconfig    clang-22
powerpc64             randconfig-001-20250829    clang-22
powerpc64             randconfig-002-20250829    clang-22
powerpc64             randconfig-003-20250829    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    clang-22
riscv             nommu_k210_sdcard_defconfig    gcc-15.1.0
riscv                 randconfig-001-20250830    gcc-8.5.0
riscv                 randconfig-002-20250830    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20250830    clang-22
s390                  randconfig-002-20250830    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20250830    gcc-11.5.0
sh                    randconfig-002-20250830    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250830    gcc-13.4.0
sparc                 randconfig-002-20250830    gcc-8.5.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250830    gcc-11.5.0
sparc64               randconfig-002-20250830    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250830    gcc-12
um                    randconfig-002-20250830    gcc-12
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250829    gcc-11
x86_64      buildonly-randconfig-002-20250829    gcc-11
x86_64      buildonly-randconfig-003-20250829    gcc-12
x86_64      buildonly-randconfig-004-20250829    clang-20
x86_64      buildonly-randconfig-005-20250829    clang-20
x86_64      buildonly-randconfig-006-20250829    clang-20
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250830    gcc-12.5.0
xtensa                randconfig-002-20250830    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

