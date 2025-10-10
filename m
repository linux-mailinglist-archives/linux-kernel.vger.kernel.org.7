Return-Path: <linux-kernel+bounces-847854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CD3BCBE42
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 09:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0681C1893352
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 07:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED086239E9E;
	Fri, 10 Oct 2025 07:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WVeXlcHQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36592156677
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 07:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760080625; cv=none; b=mDMATcwU0NMfjf+fjAXI0XEN8Bedc71io69rh5mrtTazJ3+LjKmzVvMaKeofvW8M3ITFt3Az412zpNZFRW6n3/CavtJWZw2Y0SdKUPDz52JdlPUTcgH9sku520yLg0fOSka7E7T4OtDq51ZfmeDj44xeF2kB+GH01D3YesqrZ+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760080625; c=relaxed/simple;
	bh=kMCdg78unni+7HzIbVy9+0aknso49OR9nKnSAKRuI2w=;
	h=Date:From:To:Cc:Subject:Message-ID; b=UDBeRfVQ6zq55xqeDTiNT4sr1dMRJssyhlWficjv4q1XNp03ofpkSNdcg2iE1w0HL5tyqepVdQlFUrqCC6mat3PVpJ2x5Oc3GO4ergszyhXY0F7czi15nmckDjL+N+vV6CA/J156pxogGD005Nu6fKaDzaNm0TH7sQ9EuGYYDwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WVeXlcHQ; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760080623; x=1791616623;
  h=date:from:to:cc:subject:message-id;
  bh=kMCdg78unni+7HzIbVy9+0aknso49OR9nKnSAKRuI2w=;
  b=WVeXlcHQ9cpc0DTj4dgU2JCjBQMPFv8/I106KBuRUbX38KxYg50LfvWB
   V+yilam+RewZwa3axjNpG9Is51XAQ0orgBMXn/ScI8m0rgG6Q3KSIV2C8
   pDu++sKJQVcPU97x1uPYwXHeQU2dzzG6n0lHcfkuHDy7gIsAEChQE0M2B
   hSA27j0xd5PnYNDFgdL7UGegIZGTxX6XDpL9jpALQTEpjkv2iQC9mc8Yh
   /D1Hmsjf9BXCSDNjgJeuPQ+4iGfscLbHGtEM1enMvmClUnzYEqPXfrUPM
   +SPeioOME5imIZwmD3PJAPLgYV9oDIi92kqI+ErBBzCJtVXsevd8U7t1W
   g==;
X-CSE-ConnectionGUID: Fe8h0TbhRECJYziSoXOrnQ==
X-CSE-MsgGUID: LadZ05ozSryDaWkSXN/Ffw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62239156"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62239156"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 00:17:03 -0700
X-CSE-ConnectionGUID: oDvs5cqQRM+/PXqVBbEcLA==
X-CSE-MsgGUID: 5hv0DlecQtKXLw0kUlHY1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,218,1754982000"; 
   d="scan'208";a="186034869"
Received: from lkp-server01.sh.intel.com (HELO 6a630e8620ab) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 10 Oct 2025 00:17:01 -0700
Received: from kbuild by 6a630e8620ab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v77N5-0002Oh-04;
	Fri, 10 Oct 2025 07:16:59 +0000
Date: Fri, 10 Oct 2025 15:16:01 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20251002] BUILD REGRESSION
 7bcbc6fbcc6816b0e3307e1ebab74b01797d0fb6
Message-ID: <202510101552.sFbmBrfQ-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20251002
branch HEAD: 7bcbc6fbcc6816b0e3307e1ebab74b01797d0fb6  scsi: libsas/aci94xx: Avoid multiple -Wflex-array-member-not-at-end warnings

Error/Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202510100232.BV1e8PYX-lkp@intel.com

    drivers/scsi/aic94xx/aic94xx_hwi.c:344:40: error: no member named 'escb' in 'struct scb'
    drivers/scsi/aic94xx/aic94xx_sas.h:323:28: error: field has incomplete type 'struct ssp_command_iu_hdr'
    drivers/scsi/aic94xx/aic94xx_sas.h:323:35: error: field 'ssp_cmd' has incomplete type
    drivers/scsi/aic94xx/aic94xx_scb.c:369:39: error: no member named 'escb' in 'struct scb'
    drivers/scsi/aic94xx/aic94xx_scb.c:631:42: error: no member named 'control_phy' in 'struct scb'
    drivers/scsi/aic94xx/aic94xx_task.c:129:33: error: no member named 'ssp_task' in 'struct scb'
    drivers/scsi/aic94xx/aic94xx_task.c:365:7: error: no member named 'ata_task' in 'struct scb'
    drivers/scsi/aic94xx/aic94xx_tmf.c:120:7: error: no member named 'clear_nexus' in 'struct scb'
    drivers/scsi/hisi_sas/hisi_sas.h:617:26: error: field has incomplete type 'struct ssp_command_iu'
    drivers/scsi/hisi_sas/hisi_sas.h:617:47: error: field 'task' has incomplete type
    drivers/scsi/hisi_sas/hisi_sas_v1_hw.c:1002:11: error: invalid application of 'sizeof' to an incomplete type 'struct ssp_command_iu'
    drivers/scsi/hisi_sas/hisi_sas_v1_hw.c:1002:32: error: invalid application of 'sizeof' to incomplete type 'struct ssp_command_iu'
    drivers/scsi/hisi_sas/hisi_sas_v2_hw.c:1779:11: error: invalid application of 'sizeof' to an incomplete type 'struct ssp_command_iu'
    drivers/scsi/hisi_sas/hisi_sas_v2_hw.c:1779:25: error: invalid application of 'sizeof' to incomplete type 'struct ssp_command_iu'

Error/Warning ids grouped by kconfigs:

recent_errors
|-- arc-allmodconfig
|   |-- drivers-scsi-hisi_sas-hisi_sas.h:error:field-task-has-incomplete-type
|   |-- drivers-scsi-hisi_sas-hisi_sas_v1_hw.c:error:invalid-application-of-sizeof-to-incomplete-type-struct-ssp_command_iu
|   `-- drivers-scsi-hisi_sas-hisi_sas_v2_hw.c:error:invalid-application-of-sizeof-to-incomplete-type-struct-ssp_command_iu
|-- arc-allyesconfig
|   |-- drivers-scsi-hisi_sas-hisi_sas.h:error:field-task-has-incomplete-type
|   |-- drivers-scsi-hisi_sas-hisi_sas_v1_hw.c:error:invalid-application-of-sizeof-to-incomplete-type-struct-ssp_command_iu
|   `-- drivers-scsi-hisi_sas-hisi_sas_v2_hw.c:error:invalid-application-of-sizeof-to-incomplete-type-struct-ssp_command_iu
|-- m68k-allmodconfig
|   |-- drivers-scsi-hisi_sas-hisi_sas.h:error:field-task-has-incomplete-type
|   |-- drivers-scsi-hisi_sas-hisi_sas_v1_hw.c:error:invalid-application-of-sizeof-to-incomplete-type-struct-ssp_command_iu
|   `-- drivers-scsi-hisi_sas-hisi_sas_v2_hw.c:error:invalid-application-of-sizeof-to-incomplete-type-struct-ssp_command_iu
|-- m68k-allyesconfig
|   |-- drivers-scsi-hisi_sas-hisi_sas.h:error:field-task-has-incomplete-type
|   |-- drivers-scsi-hisi_sas-hisi_sas_v1_hw.c:error:invalid-application-of-sizeof-to-incomplete-type-struct-ssp_command_iu
|   `-- drivers-scsi-hisi_sas-hisi_sas_v2_hw.c:error:invalid-application-of-sizeof-to-incomplete-type-struct-ssp_command_iu
|-- mips-allyesconfig
|   |-- drivers-scsi-aic94xx-aic94xx_sas.h:error:field-ssp_cmd-has-incomplete-type
|   |-- drivers-scsi-hisi_sas-hisi_sas.h:error:field-task-has-incomplete-type
|   |-- drivers-scsi-hisi_sas-hisi_sas_v1_hw.c:error:invalid-application-of-sizeof-to-incomplete-type-struct-ssp_command_iu
|   `-- drivers-scsi-hisi_sas-hisi_sas_v2_hw.c:error:invalid-application-of-sizeof-to-incomplete-type-struct-ssp_command_iu
|-- powerpc-randconfig-001-20251010
|   |-- drivers-scsi-hisi_sas-hisi_sas.h:error:field-has-incomplete-type-struct-ssp_command_iu
|   |-- drivers-scsi-hisi_sas-hisi_sas_v1_hw.c:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-ssp_command_iu
|   `-- drivers-scsi-hisi_sas-hisi_sas_v2_hw.c:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-ssp_command_iu
|-- s390-allmodconfig
|   |-- drivers-scsi-hisi_sas-hisi_sas.h:error:field-has-incomplete-type-struct-ssp_command_iu
|   |-- drivers-scsi-hisi_sas-hisi_sas_v1_hw.c:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-ssp_command_iu
|   `-- drivers-scsi-hisi_sas-hisi_sas_v2_hw.c:error:invalid-application-of-sizeof-to-an-incomplete-type-struct-ssp_command_iu
|-- s390-allyesconfig
|   |-- drivers-scsi-hisi_sas-hisi_sas.h:error:field-task-has-incomplete-type
|   |-- drivers-scsi-hisi_sas-hisi_sas_v1_hw.c:error:invalid-application-of-sizeof-to-incomplete-type-struct-ssp_command_iu
|   `-- drivers-scsi-hisi_sas-hisi_sas_v2_hw.c:error:invalid-application-of-sizeof-to-incomplete-type-struct-ssp_command_iu
|-- sparc-allmodconfig
|   |-- drivers-scsi-aic94xx-aic94xx_sas.h:error:field-ssp_cmd-has-incomplete-type
|   |-- drivers-scsi-hisi_sas-hisi_sas.h:error:field-task-has-incomplete-type
|   |-- drivers-scsi-hisi_sas-hisi_sas_v1_hw.c:error:invalid-application-of-sizeof-to-incomplete-type-struct-ssp_command_iu
|   `-- drivers-scsi-hisi_sas-hisi_sas_v2_hw.c:error:invalid-application-of-sizeof-to-incomplete-type-struct-ssp_command_iu
|-- sparc64-randconfig-002-20251009
|   |-- drivers-scsi-aic94xx-aic94xx_hwi.c:error:no-member-named-escb-in-struct-scb
|   |-- drivers-scsi-aic94xx-aic94xx_sas.h:error:field-has-incomplete-type-struct-ssp_command_iu_hdr
|   |-- drivers-scsi-aic94xx-aic94xx_scb.c:error:no-member-named-control_phy-in-struct-scb
|   |-- drivers-scsi-aic94xx-aic94xx_scb.c:error:no-member-named-escb-in-struct-scb
|   |-- drivers-scsi-aic94xx-aic94xx_task.c:error:no-member-named-ata_task-in-struct-scb
|   |-- drivers-scsi-aic94xx-aic94xx_task.c:error:no-member-named-ssp_task-in-struct-scb
|   `-- drivers-scsi-aic94xx-aic94xx_tmf.c:error:no-member-named-clear_nexus-in-struct-scb
`-- xtensa-allyesconfig
    |-- drivers-scsi-hisi_sas-hisi_sas.h:error:field-task-has-incomplete-type
    |-- drivers-scsi-hisi_sas-hisi_sas_v1_hw.c:error:invalid-application-of-sizeof-to-incomplete-type-struct-ssp_command_iu
    `-- drivers-scsi-hisi_sas-hisi_sas_v2_hw.c:error:invalid-application-of-sizeof-to-incomplete-type-struct-ssp_command_iu

elapsed time: 1464m

configs tested: 91
configs skipped: 1

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20251010    gcc-12.5.0
arc                   randconfig-002-20251010    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                      jornada720_defconfig    clang-22
arm                            mps2_defconfig    clang-22
arm                   randconfig-001-20251010    gcc-8.5.0
arm                   randconfig-002-20251010    gcc-13.4.0
arm                   randconfig-003-20251010    gcc-8.5.0
arm                   randconfig-004-20251010    gcc-8.5.0
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20251010    gcc-14.3.0
arm64                 randconfig-002-20251010    clang-19
arm64                 randconfig-003-20251010    clang-17
arm64                 randconfig-004-20251010    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20251010    gcc-15.1.0
csky                  randconfig-002-20251010    gcc-10.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20251010    clang-22
hexagon               randconfig-002-20251010    clang-18
i386        buildonly-randconfig-001-20251010    gcc-14
i386        buildonly-randconfig-002-20251010    clang-20
i386        buildonly-randconfig-003-20251010    clang-20
i386        buildonly-randconfig-004-20251010    gcc-14
i386        buildonly-randconfig-005-20251010    gcc-14
i386        buildonly-randconfig-006-20251010    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20251010    clang-22
loongarch             randconfig-002-20251010    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                       bvme6000_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                          ath25_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                 randconfig-001-20251010    gcc-11.5.0
nios2                 randconfig-002-20251010    gcc-9.5.0
parisc                randconfig-001-20251010    gcc-8.5.0
parisc                randconfig-002-20251010    gcc-12.5.0
powerpc               randconfig-001-20251010    clang-22
powerpc               randconfig-002-20251010    gcc-15.1.0
powerpc               randconfig-003-20251010    clang-22
powerpc64             randconfig-001-20251010    clang-22
powerpc64             randconfig-002-20251010    gcc-14.3.0
powerpc64             randconfig-003-20251010    gcc-13.4.0
riscv                    nommu_k210_defconfig    clang-22
riscv                 randconfig-001-20251009    gcc-8.5.0
riscv                 randconfig-002-20251009    clang-19
s390                             allmodconfig    clang-18
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20251009    clang-22
s390                  randconfig-002-20251009    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20251009    gcc-15.1.0
sh                    randconfig-002-20251009    gcc-12.5.0
sh                           se7206_defconfig    gcc-15.1.0
sh                        sh7763rdp_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20251009    gcc-8.5.0
sparc                 randconfig-002-20251009    gcc-8.5.0
sparc64               randconfig-001-20251009    clang-22
sparc64               randconfig-002-20251009    clang-22
um                               allmodconfig    clang-19
um                               allyesconfig    gcc-14
um                    randconfig-001-20251009    clang-17
um                    randconfig-002-20251009    gcc-14
x86_64      buildonly-randconfig-001-20251010    clang-20
x86_64      buildonly-randconfig-002-20251010    clang-20
x86_64      buildonly-randconfig-003-20251010    clang-20
x86_64      buildonly-randconfig-004-20251010    clang-20
x86_64      buildonly-randconfig-005-20251010    gcc-14
x86_64      buildonly-randconfig-006-20251010    gcc-14
xtensa                           alldefconfig    gcc-15.1.0
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251009    gcc-11.5.0
xtensa                randconfig-002-20251009    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

