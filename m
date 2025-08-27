Return-Path: <linux-kernel+bounces-788979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CF6B38EFA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 01:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC8781BA15E6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 23:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63625310784;
	Wed, 27 Aug 2025 23:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iUChDWJQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A4F2F3C01
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 23:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756336295; cv=none; b=Hm0IYT7bPVnuQLVEc+XV49sGAGB0QV+/nA5XeBvebGwv44uxEQgJJYk9R6D27VH+H5BpdSgTo5qlpi+JrxCDcL2NuBaxsgecmFfo6YMV6x7RfWO27r9hsrFU8zDFHKm+TQYArG+a9TauahE7hSzVmfjwGupuiL7VTUfwWi9KB2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756336295; c=relaxed/simple;
	bh=KSTf5ACDaEu8XiZUEUb67WXvAmOsRXQ+B4q0Gst0mbo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=E9IGuPrrMN91zZLNzLnupa+P/vhjPf9T3P7c4/c/hjhQ6iBj1WTTPGiz2lX1Tl6Ke7mdnY5pTeQcXunH75pNX8nExT4WhIGTlb2gRJedYwARJpnlT/iKab47FLFWPf/ozyHV5ZgPcTaEyFq6ULGuz3PQWGZ/CGqPKneaRI1eXSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iUChDWJQ; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756336293; x=1787872293;
  h=date:from:to:cc:subject:message-id;
  bh=KSTf5ACDaEu8XiZUEUb67WXvAmOsRXQ+B4q0Gst0mbo=;
  b=iUChDWJQoknTsBdfLUK9TByQ0Yem5OLVzKGyTATTypv+XmBgude7D3y1
   4kmq0f9ZqtHoxJA8SHdOm/UQ5AgOpN6U73FnRH8uYlVZTBv1NE7o1DbDA
   wPK0/8Pna2cjfuzxk4c1RPZMu4D7FChdYvP7rEiM1pURXBPMKbim7yXBO
   lFXzS23iNztn9GM+jGf2GggriUga54ZNWFwQOm4fYrHOd3bd2z52S/owU
   tzywW4rbqU1IlhiqqFxMNXCsPwD3YJLET4j9wWP76ep5voB6X/w/cDqeY
   w7oY9uGA9iTffoNhCMBdXDYrsZBGKpNxnWQtrzcSgPRPnFf5atgXAYgxb
   A==;
X-CSE-ConnectionGUID: 274trMS4S4Wcf7Q4XpbBfg==
X-CSE-MsgGUID: H66QeMVDSiCKpvGTC4ms0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="57798170"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="57798170"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 16:11:32 -0700
X-CSE-ConnectionGUID: Gqyy2wWdRv6BSOvGWq0ELA==
X-CSE-MsgGUID: XvPH4VuESauFipnZaZKl5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="174342355"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 27 Aug 2025 16:11:32 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1urPIf-000TGh-27;
	Wed, 27 Aug 2025 23:11:29 +0000
Date: Thu, 28 Aug 2025 07:11:13 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 c2415c407a2cde01290d52ce2a1f81b0616379a3
Message-ID: <202508280703.YsTk5P3x-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: c2415c407a2cde01290d52ce2a1f81b0616379a3  x86/cpu/topology: Use initial APIC ID from XTOPOLOGY leaf on AMD/HYGON

elapsed time: 730m

configs tested: 20
configs skipped: 119

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                         allmodconfig    gcc-12
i386                          allnoconfig    gcc-12
i386                         allyesconfig    gcc-12
i386    buildonly-randconfig-001-20250827    clang-20
i386    buildonly-randconfig-002-20250827    clang-20
i386    buildonly-randconfig-003-20250827    clang-20
i386    buildonly-randconfig-004-20250827    clang-20
i386    buildonly-randconfig-005-20250827    clang-20
i386    buildonly-randconfig-006-20250827    gcc-12
i386                            defconfig    clang-20
x86_64                        allnoconfig    clang-20
x86_64                       allyesconfig    clang-20
x86_64  buildonly-randconfig-001-20250827    clang-20
x86_64  buildonly-randconfig-002-20250827    clang-20
x86_64  buildonly-randconfig-003-20250827    gcc-12
x86_64  buildonly-randconfig-004-20250827    gcc-12
x86_64  buildonly-randconfig-005-20250827    clang-20
x86_64  buildonly-randconfig-006-20250827    clang-20
x86_64                          defconfig    gcc-11
x86_64                      rhel-9.4-rust    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

