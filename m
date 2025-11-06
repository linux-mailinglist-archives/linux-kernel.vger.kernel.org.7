Return-Path: <linux-kernel+bounces-888080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EB7C39CC2
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 10:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7DAE189A50F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 09:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BD0309EE0;
	Thu,  6 Nov 2025 09:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ialsc/hr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6F83090E4
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 09:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762420968; cv=none; b=p9GdgFxgvVqQcK/uCAfN5llEdCF121CVbGtpk6+itIkCN3ZVCB2RQ+bhC7uT50fWxQKYC2BA0GWbgWB7se1A/ZNDzd7h9JeZkG71nM9XHsYgtZSbWYWgACkA+/UvNVIzLFaIbT6Ev1O0FfPG/HpxVqH8sbPxgZAwQIZnKzS15rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762420968; c=relaxed/simple;
	bh=Fqovht90W1pi0WDgjTbBepARHZBzWQIugsEfLWx3N8E=;
	h=Date:From:To:Cc:Subject:Message-ID; b=RfNqDH+ekIMk2Th3ZgKsqxuYNN4pqCDUafaLJ5XHrP4xVjllbqSDUqzIXAUbQFN9AALeJ8dYl7UumleDn+kh33s0VUshIGxhG6WWqnpnqwPzTnCqtLGYWeLXfMGhMMV3RD1o+IyWkdE6mLcK7zK7qxEDymprS+PZ34BaD3aJ+uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ialsc/hr; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762420967; x=1793956967;
  h=date:from:to:cc:subject:message-id;
  bh=Fqovht90W1pi0WDgjTbBepARHZBzWQIugsEfLWx3N8E=;
  b=ialsc/hr4Av02ZxPD7B7lAM5AKOVCGtWtWh4VWZzAdPZe69fopigwekU
   xbpsNHwZC+9LI/ElWZ3BVWI0i5P/HRddW/VW43WQDkch/hR/ygB0hp1+8
   2IRN2dKfTr6GbyS5I75YKOGOw9SRavS/NRudXvUov9wVt4DH1jb6SLN6C
   lerd/zJSvwnvqE6leX6/Yxarnl+AEPgLi9PXIm9frD95Gc1KrN5jqZNca
   6+xvkZdKz7fuQVgV//w52zYEStrIRdXgLt0FzujP5gjSK0zU7FzBDAC5Y
   Iyc/bQrlGu9JVOMqH5nMKCGpf9VxlSy5mBM72Kco8Ma6Kelct2U0qH2RD
   w==;
X-CSE-ConnectionGUID: Y0JFcMJaSuCm6ulIgteIwA==
X-CSE-MsgGUID: qBD8xoy3QQSfsk7HzTho0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="64590742"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="64590742"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 01:22:46 -0800
X-CSE-ConnectionGUID: LxWlXg3LT7OvQ4b53sg2kg==
X-CSE-MsgGUID: AnW9DGKtTU+iTCP6YoZqOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="187654044"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 06 Nov 2025 01:22:46 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vGwCZ-000TiI-0Z;
	Thu, 06 Nov 2025 09:22:43 +0000
Date: Thu, 06 Nov 2025 17:22:01 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/misc] BUILD SUCCESS
 41f4767000667f402be2f1ccd70cd215bfc41ec3
Message-ID: <202511061756.ejiAjiNq-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/misc
branch HEAD: 41f4767000667f402be2f1ccd70cd215bfc41ec3  x86/msr: Add CPU_OUT_OF_SPEC taint name to "unrecognized" pr_warn(msg)

elapsed time: 1206m

configs tested: 26
configs skipped: 118

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386               allmodconfig    clang-20
i386                allnoconfig    gcc-14
i386               allyesconfig    clang-20
loongarch          allmodconfig    clang-19
m68k               allmodconfig    clang-19
m68k               allyesconfig    clang-19
microblaze         allmodconfig    clang-19
microblaze         allyesconfig    clang-19
nios2              allmodconfig    clang-22
nios2              allyesconfig    clang-22
openrisc           allmodconfig    clang-22
sparc              allyesconfig    clang-22
sparc64            allmodconfig    clang-22
sparc64            allyesconfig    clang-22
x86_64             allmodconfig    clang-20
x86_64              allnoconfig    clang-20
x86_64             allyesconfig    clang-20
x86_64                    kexec    clang-20
x86_64                 rhel-9.4    clang-20
x86_64             rhel-9.4-bpf    gcc-14
x86_64            rhel-9.4-func    clang-20
x86_64      rhel-9.4-kselftests    clang-20
x86_64           rhel-9.4-kunit    gcc-14
x86_64             rhel-9.4-ltp    gcc-14
x86_64            rhel-9.4-rust    clang-20
xtensa             allyesconfig    clang-22

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

