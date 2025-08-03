Return-Path: <linux-kernel+bounces-754351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FB5B19322
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 10:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B5921896088
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 08:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC6B258CDF;
	Sun,  3 Aug 2025 08:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AIQ5NCpa"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F402E8F58
	for <linux-kernel@vger.kernel.org>; Sun,  3 Aug 2025 08:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754210781; cv=none; b=jKqAd4S8BjpRqn7cmGU41TlwbtcrcMphkUIDLADiTCWqm5ehSORbQmHHBJ4SwObMCn1wkCiXGq/68KbAl+GCZwDl5cjIdQU+/hvY0QYDKoAG7ZGI0ILGtcSO4EY07h6KiwhwM7Hnw+w8bf2YygTlU/eoo9HR96iP3mrwl/k4RHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754210781; c=relaxed/simple;
	bh=Wbh5Q01rGwR3RM2DtWdaOqR5ZPNjSpjw6cjpU5hX594=;
	h=Date:From:To:Cc:Subject:Message-ID; b=g2h44aLAjZkSGglqBoSLXyrIj/IJAvwvSz+bh3fZxJ7H3xjrPnXizfUm+z6vIYU2g82T5GnQz7rnLioboTQHEGVPHFrcljM3h9kcZIpsj23ThGZxnWdIZxpfQqRIhyGGyp0pb4hwZIV2oWJhrVHA3ehHUZqLxiLHjcqen90DGQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AIQ5NCpa; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754210780; x=1785746780;
  h=date:from:to:cc:subject:message-id;
  bh=Wbh5Q01rGwR3RM2DtWdaOqR5ZPNjSpjw6cjpU5hX594=;
  b=AIQ5NCpaRvlK/kNf54R9WhvyQEeEIxNTWj64MDQw+mRel7vn0brAqz9u
   PaKbngpEZAqQ+2iXNMruiXny1ztp8pYN8P8bOX/Z//UhRSa+20lXzDxlj
   yAECN27QFLj6QllrhwnlpbtHJglmiSgbPRd5j50+XboAsjcmBDt0ED+XZ
   jruV4sji5era9mAmztnR0iMKD1D73zQEzIcJxSMSo4IuU/GwRDys5ZMEJ
   NpHa1XOJEMfy0fxq2a73R6PgqBpFxq/q1yaWl0DK0hbqrelfhnpfjlzJL
   7QawxVRwKipQl78dcvndGjmtS3XwTQPaVZQrduhIBYkWp6lPrGi31yVqu
   w==;
X-CSE-ConnectionGUID: Dvv4z7pCRGWKWUkTflZNZA==
X-CSE-MsgGUID: /K+g9dn1STGADJuELZ13DA==
X-IronPort-AV: E=McAfee;i="6800,10657,11510"; a="56582825"
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="56582825"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2025 01:46:19 -0700
X-CSE-ConnectionGUID: mB8FGWQJRdinx/MxWgLefQ==
X-CSE-MsgGUID: 6AXrjNJ5QMCKXX+EmLBGKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="168175587"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 03 Aug 2025 01:46:18 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uiUMC-0006KX-29;
	Sun, 03 Aug 2025 08:46:16 +0000
Date: Sun, 03 Aug 2025 16:45:49 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 e3079ac6cf4213dd46a7a292150b2ba7e6e85bac
Message-ID: <202508031640.iYVigzeh-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: e3079ac6cf4213dd46a7a292150b2ba7e6e85bac  x86/irq: Plug vector setup race

elapsed time: 722m

configs tested: 20
configs skipped: 118

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                         allmodconfig    gcc-12
i386                          allnoconfig    gcc-12
i386                         allyesconfig    gcc-12
i386    buildonly-randconfig-001-20250803    gcc-12
i386    buildonly-randconfig-002-20250803    clang-20
i386    buildonly-randconfig-003-20250803    gcc-12
i386    buildonly-randconfig-004-20250803    gcc-12
i386    buildonly-randconfig-005-20250803    clang-20
i386    buildonly-randconfig-006-20250803    gcc-12
i386                            defconfig    clang-20
x86_64                        allnoconfig    clang-20
x86_64                       allyesconfig    clang-20
x86_64  buildonly-randconfig-001-20250803    gcc-12
x86_64  buildonly-randconfig-002-20250803    clang-20
x86_64  buildonly-randconfig-003-20250803    gcc-12
x86_64  buildonly-randconfig-004-20250803    gcc-12
x86_64  buildonly-randconfig-005-20250803    gcc-12
x86_64  buildonly-randconfig-006-20250803    clang-20
x86_64                          defconfig    gcc-11
x86_64                      rhel-9.4-rust    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

