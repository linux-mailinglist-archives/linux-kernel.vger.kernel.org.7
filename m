Return-Path: <linux-kernel+bounces-897394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FB7C53061
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 823DA506E94
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BC7338582;
	Wed, 12 Nov 2025 14:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PGBM3+xV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E89D2951B3
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 14:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762957625; cv=none; b=koNl+VxqimCQ5pgff9nuwqU92gtZfXVutztYKlOsJAYyp9EA75los2/kT3sYLAJc2IB5MyW8JufFcvmMD1XrMf7VIsc2S1pNen5si8pyH4jgkWUoGHlkiBLBVng44RY5jLGAXsZSv2TJAm0EfAo0mGcADfbyTUVKcO1yDVyrTBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762957625; c=relaxed/simple;
	bh=e8VRq/DIuTaAFK+PAjWukPOxyi+GTgvNF2eT8ihj3Gg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=QD2v+r7HHGmLo865hsQkKNqrrszG6Rt9sliQmwhhUWN1MIJI0kgqHfLafm0hvZ/fJBHN6T7LmE0hYtJ+ahRKw9A8xD6uaGhPDHB4Afqxo7+h10HOo/zcF/aPBCcMREjOKUoscdkeI7gb9kLj3biNcAMK3YLdiBZflzZ5ULc9xNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PGBM3+xV; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762957623; x=1794493623;
  h=date:from:to:cc:subject:message-id;
  bh=e8VRq/DIuTaAFK+PAjWukPOxyi+GTgvNF2eT8ihj3Gg=;
  b=PGBM3+xVVA5tw79e9t2WjWCMUhIfFo+g7RS/TJ7xbCSwG5NzAAj//b90
   3iosmNPuGYy7vkqnKwdBWxyl8U7efZot30hvYLh7IYY3Wddm3OuDXqs70
   oayfucR5wzjk/sVXRKwSltizpdzfJi9zJh7tjdUEgqtR5LT2WKGosi3AC
   pM6Cnk59Dd2ybbT0lVZSXIb7XOaZ8d5EFxU0uNdYYwXhFu7H4wTfuDGnm
   PRT0TdnbUffttPdYGlYi75Odatk8Xxt1N2bLPoFWVhHRWqB+cuS67c+1P
   DQtVzKR6BZ9Bh94WNEwx1EUE8ayfl4zZOrXxIILr2BqRDUCLB5LjHmXIf
   A==;
X-CSE-ConnectionGUID: PK78jiBaRY21Y71xu7en/A==
X-CSE-MsgGUID: 0VBbNNGmRtuX69L8lzA7+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="75700705"
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; 
   d="scan'208";a="75700705"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 06:27:02 -0800
X-CSE-ConnectionGUID: B8oz1KZlTea0mHhGtb594Q==
X-CSE-MsgGUID: t78i4AHfTsST9/y/3RSNfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; 
   d="scan'208";a="189495106"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 12 Nov 2025 06:27:01 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vJBoJ-0004Hb-0Y;
	Wed, 12 Nov 2025 14:26:59 +0000
Date: Wed, 12 Nov 2025 22:26:38 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:objtool/core] BUILD SUCCESS WITH WARNING
 249092174caa3fe9fb8f7914991a8c0de484bcf8
Message-ID: <202511122231.5tb1PCJg-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool/core
branch HEAD: 249092174caa3fe9fb8f7914991a8c0de484bcf8  tools/objtool: Copy the __cleanup unused variable fix for older clang

Warning (recently discovered and may have been fixed):

    riscv64-linux-ld: warning: orphan section `.text.start.constprop.0' from `drivers/usb/host/sl811-hcd.o' being placed in section `.text.start.constprop.0'

Warning ids grouped by kconfigs:

recent_errors
`-- riscv-randconfig-001-20251112
    `-- riscv64-linux-ld:warning:orphan-section-text.start-from-drivers-usb-host-sl811-hcd.o-being-placed-in-section-.text.start.constprop.

elapsed time: 2955m

configs tested: 40
configs skipped: 1

tested configs:
alpha                   allnoconfig    gcc-15.1.0
arc                     allnoconfig    gcc-15.1.0
arm                     allnoconfig    clang-22
arm64                   allnoconfig    gcc-15.1.0
csky                    allnoconfig    gcc-15.1.0
hexagon                 allnoconfig    clang-22
hexagon     randconfig-001-20251111    clang-22
hexagon     randconfig-002-20251111    clang-16
i386                    allnoconfig    gcc-14
loongarch               allnoconfig    clang-22
loongarch   randconfig-001-20251111    gcc-15.1.0
loongarch   randconfig-002-20251111    gcc-15.1.0
m68k                    allnoconfig    gcc-15.1.0
microblaze              allnoconfig    gcc-15.1.0
mips                    allnoconfig    gcc-15.1.0
nios2                   allnoconfig    gcc-11.5.0
nios2       randconfig-001-20251111    gcc-8.5.0
nios2       randconfig-002-20251111    gcc-11.5.0
openrisc                allnoconfig    gcc-15.1.0
parisc                  allnoconfig    gcc-15.1.0
powerpc                 allnoconfig    gcc-15.1.0
riscv                   allnoconfig    gcc-15.1.0
riscv       randconfig-001-20251111    clang-22
riscv       randconfig-002-20251111    gcc-8.5.0
s390                    allnoconfig    clang-22
s390        randconfig-001-20251111    clang-18
sh                      allnoconfig    gcc-15.1.0
sh          randconfig-001-20251111    gcc-14.3.0
sh          randconfig-002-20251111    gcc-15.1.0
sparc                   allnoconfig    gcc-15.1.0
um                      allnoconfig    clang-22
x86_64                  allnoconfig    clang-20
x86_64                        kexec    clang-20
x86_64                     rhel-9.4    clang-20
x86_64                 rhel-9.4-bpf    gcc-14
x86_64                rhel-9.4-func    clang-20
x86_64          rhel-9.4-kselftests    clang-20
x86_64               rhel-9.4-kunit    gcc-14
x86_64                 rhel-9.4-ltp    gcc-14
xtensa                  allnoconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

