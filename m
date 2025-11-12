Return-Path: <linux-kernel+bounces-896511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3592C508C9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 05:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73EEF3B260E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 04:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8139F2D3231;
	Wed, 12 Nov 2025 04:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DBWnBuvF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D262D77F6
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 04:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762922406; cv=none; b=qB+oa1rA9zYA1/Mj5mZkuU3ig0efjl5grcYeRCJpSfIBZLEoZjnRcLq5L5SNULMXlkp8yjK/EA6nF0ITrMX6PVQp2srDOx4Ux6jqYWJ0o1rHG8fEB9SRkpdPV97yLDv4PIU1ZUD2wD0N3eV2jWl52H/Ni7c825FtEATSC33QSx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762922406; c=relaxed/simple;
	bh=xzToIIp55hU2mNO52Zr9stfCSg2l608ZVtlIKKe4c3g=;
	h=Date:From:To:Cc:Subject:Message-ID; b=MM89Cw5qtl4+QBfVlSMl2ky33jxEHpuZhV/2zpaKNwUoDbMDQATyg+5y7qilpHxOoqmC+P0YEUDkIA3HL0Odrw83n2PY+UWj+G5CkxyBA5z+RscHRF9CottLf8kJV5rk9zaSChkFqANlUqEz3+WjVDeDFhOXSXqhHIfHMhkrVKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DBWnBuvF; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762922405; x=1794458405;
  h=date:from:to:cc:subject:message-id;
  bh=xzToIIp55hU2mNO52Zr9stfCSg2l608ZVtlIKKe4c3g=;
  b=DBWnBuvFI09JB0mhte7WRtyTZdvvTPtEf7G990nrKlNXPuEn99POSwqr
   k7zK2W09TfT6PLUmXCR+Qe8NYNXuM8lR983AhjEE1zmz0ofWk/dEkM6fe
   VY6Pg1/EcRLv5SoB64z+yGKM6NxDVyFt1iD9qsMghWTrUPt12H6+Ki77i
   xrPymlAyWpzxcSmaYMkL8GfUGFkBKffP8LzUflTWnHXq1h4OhvOzoWr6z
   nkvOWrzM5EgGf2YO95jtua3bY34QkV/FvAFVgM+vJfY6i7etrYgMffjZH
   GpQjCgQuYAPvBhhAEhyITmiWcrk9uDl1BWb6j4BTBHWhK3MHNJn6N+JII
   A==;
X-CSE-ConnectionGUID: MOfIVhkfQf66xHnfhpFTug==
X-CSE-MsgGUID: 4RD8D3OtQAKTatXazRCGXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11610"; a="90452782"
X-IronPort-AV: E=Sophos;i="6.19,298,1754982000"; 
   d="scan'208";a="90452782"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 20:40:04 -0800
X-CSE-ConnectionGUID: QXldvjDnRRerMU0VaWSzFQ==
X-CSE-MsgGUID: TiZ9aa/QS1G8Fkb7QZng6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,298,1754982000"; 
   d="scan'208";a="188886527"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 11 Nov 2025 20:40:03 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vJ2eG-0003pj-1h;
	Wed, 12 Nov 2025 04:40:00 +0000
Date: Wed, 12 Nov 2025 12:39:27 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20251110] BUILD REGRESSION
 be928bdef109364ada67e15d004067a1770a36f0
Message-ID: <202511121220.RJfA4kDQ-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20251110
branch HEAD: be928bdef109364ada67e15d004067a1770a36f0  RDMA/rxe: Avoid -Wflex-array-member-not-at-end warnings

Error/Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202511111408.FUkLQsGp-lkp@intel.com
    https://lore.kernel.org/oe-kbuild-all/202511111702.50G2mceU-lkp@intel.com

    drivers/scsi/aic94xx/aic94xx_sas.h:323:35: error: field 'ssp_cmd' has incomplete type
    drivers/scsi/hisi_sas/hisi_sas.h:617:26: error: field has incomplete type 'struct ssp_command_iu'
    drivers/scsi/hisi_sas/hisi_sas.h:617:47: error: field 'task' has incomplete type
    drivers/scsi/hisi_sas/hisi_sas_v1_hw.c:1002:11: error: invalid application of 'sizeof' to an incomplete type 'struct ssp_command_iu'
    drivers/scsi/hisi_sas/hisi_sas_v1_hw.c:1002:32: error: invalid application of 'sizeof' to incomplete type 'struct ssp_command_iu'
    drivers/scsi/hisi_sas/hisi_sas_v2_hw.c:1779:11: error: invalid application of 'sizeof' to an incomplete type 'struct ssp_command_iu'
    drivers/scsi/hisi_sas/hisi_sas_v2_hw.c:1779:25: error: invalid application of 'sizeof' to incomplete type 'struct ssp_command_iu'

Error/Warning ids grouped by kconfigs:

recent_errors
|-- arc-randconfig-001-20251111
|   |-- drivers-scsi-hisi_sas-hisi_sas.h:error:field-task-has-incomplete-type
|   |-- drivers-scsi-hisi_sas-hisi_sas_v1_hw.c:error:invalid-application-of-sizeof-to-incomplete-type-struct-ssp_command_iu
|   `-- drivers-scsi-hisi_sas-hisi_sas_v2_hw.c:error:invalid-application-of-sizeof-to-incomplete-type-struct-ssp_command_iu
|-- s390-allmodconfig
|   |-- drivers-scsi-hisi_sas-hisi_sas.h:error:field-has-incomplete-type-struct-ssp_command_iu
|   |-- drivers-scsi-hisi_sas-hisi_sas_v1_hw.c:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-ssp_command_iu
|   `-- drivers-scsi-hisi_sas-hisi_sas_v2_hw.c:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-ssp_command_iu
`-- sparc-allmodconfig
    `-- drivers-scsi-aic94xx-aic94xx_sas.h:error:field-ssp_cmd-has-incomplete-type

elapsed time: 1481m

configs tested: 71
configs skipped: 2

tested configs:
alpha                   allnoconfig    gcc-15.1.0
arc                     allnoconfig    gcc-15.1.0
arc         randconfig-001-20251112    gcc-8.5.0
arc         randconfig-002-20251112    gcc-9.5.0
arm                     allnoconfig    clang-22
arm                ep93xx_defconfig    clang-22
arm                gemini_defconfig    clang-20
arm            jornada720_defconfig    clang-22
arm         randconfig-001-20251112    gcc-8.5.0
arm         randconfig-002-20251112    clang-22
arm         randconfig-003-20251112    clang-22
arm         randconfig-004-20251112    gcc-14.3.0
arm64                   allnoconfig    gcc-15.1.0
arm64       randconfig-001-20251112    clang-22
arm64       randconfig-002-20251112    gcc-10.5.0
arm64       randconfig-003-20251112    gcc-8.5.0
arm64       randconfig-004-20251112    clang-22
csky                    allnoconfig    gcc-15.1.0
csky        randconfig-001-20251112    gcc-13.4.0
csky        randconfig-002-20251112    gcc-15.1.0
hexagon                 allnoconfig    clang-22
hexagon     randconfig-001-20251111    clang-22
hexagon     randconfig-002-20251111    clang-16
i386                    allnoconfig    gcc-14
i386        randconfig-011-20251112    gcc-14
i386        randconfig-012-20251112    gcc-14
i386        randconfig-013-20251112    clang-20
i386        randconfig-014-20251112    clang-20
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
openrisc                  defconfig    gcc-15.1.0
openrisc          or1ksim_defconfig    gcc-15.1.0
parisc                  allnoconfig    gcc-15.1.0
parisc      randconfig-001-20251111    gcc-9.5.0
parisc      randconfig-002-20251111    gcc-8.5.0
powerpc                 allnoconfig    gcc-15.1.0
powerpc           ppa8548_defconfig    gcc-15.1.0
powerpc             ppc64_defconfig    clang-22
powerpc           rainier_defconfig    gcc-15.1.0
powerpc     randconfig-001-20251111    gcc-8.5.0
powerpc     randconfig-002-20251111    clang-22
powerpc64   randconfig-002-20251111    gcc-12.5.0
riscv                   allnoconfig    gcc-15.1.0
s390                    allnoconfig    clang-22
sh                      allnoconfig    gcc-15.1.0
sh                        defconfig    gcc-15.1.0
sh              edosk7760_defconfig    gcc-15.1.0
sparc                   allnoconfig    gcc-15.1.0
sparc       randconfig-001-20251112    gcc-8.5.0
sparc       randconfig-002-20251112    gcc-14.3.0
sparc64                   defconfig    clang-20
sparc64     randconfig-001-20251112    gcc-8.5.0
sparc64     randconfig-002-20251112    clang-20
um                      allnoconfig    clang-22
um                        defconfig    clang-22
um                   i386_defconfig    gcc-14
um          randconfig-001-20251112    gcc-14
um          randconfig-002-20251112    gcc-14
um                 x86_64_defconfig    clang-22
x86_64                  allnoconfig    clang-20
x86_64                    defconfig    gcc-14
xtensa                  allnoconfig    gcc-15.1.0
xtensa      randconfig-002-20251112    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

