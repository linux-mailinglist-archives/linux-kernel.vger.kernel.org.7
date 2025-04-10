Return-Path: <linux-kernel+bounces-599053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4090A84E7E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 22:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD3317AA1FC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 20:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFE9293B69;
	Thu, 10 Apr 2025 20:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B9sZWNZo"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABFB293461;
	Thu, 10 Apr 2025 20:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744318067; cv=none; b=ivBKvosUN1igC1/FiH2B3sdaep7SNV9dWulTSzsKCAOMaQVphRTu56iaiuG5Ir26512ngq2rj6Wgkw0gIIhh2ASytIdPvUCpTYWt/6WbxV/OFRCAKG+7BFU4rXZGeHgTF0ycqnpvo+iZbUWV0Y+XORoEZmseAgKUvfe7GrlwYow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744318067; c=relaxed/simple;
	bh=hadlZG08stAm2IOinw94FWjmUMBI8PnAs8MCqz+re2M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SIwAXtdMvrqiSiot1cThR/C1OMAJ6JAJru9c4QFFKczISZmDARnCu/G0NHegAW6GCa7tqPnbV3lQlwbuJbj8OciPwEZrfybh7JYnCRcnjOvqHTeQJCXsEWps3ZgpuiK/BTiAVepWtZCGR5gZWTVjWi6TK2uXTaxQFqmPA0NwY5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=B9sZWNZo; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53AKMcmU002934;
	Thu, 10 Apr 2025 20:46:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=Utklchi5K8L0Mzkc8My/ypqkwS0tN
	FQoXor7tKUKR6Q=; b=B9sZWNZoWDurMUiDVFlgMqTbkk5eoqOBq0yRDp/0X6q1O
	+UNhWKMiZPDmhKu79bgcbLNCP7dBg1n5Fw2ue/GKrnv2S7fdGCUTXfg3VIEXlteg
	N/mwHV5PO22ZR9FbAJLY2jAow5zdKk1MLqqZaKXHj5VLnOBV761WHKB1e8REFJrw
	XIx15fqZIqjwFo1xn9LVOf6obqz5Mk7UyoyB/XDWtHfD/LlkHP+XKDpSTXlXuCol
	hM0OQfztTmXDG5BUqE8akSreT6W1cX5sV0IXdbNm/weshwW/Q5scLeYroyfJZMZF
	9ks+vBhpYzL1CCok9FtVH6nFPOv39NnULUS1qbE6g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45xmy6824j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Apr 2025 20:46:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53AIwi9T023934;
	Thu, 10 Apr 2025 20:46:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45ttyk4qrx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 10 Apr 2025 20:46:47 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 53AKjlxF012865;
	Thu, 10 Apr 2025 20:46:46 GMT
Received: from bur-virt-x6-2-100.us.oracle.com (bur-virt-x6-2-100.us.oracle.com [10.153.92.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45ttyk4qqh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 10 Apr 2025 20:46:46 +0000
From: Ross Philipson <ross.philipson@oracle.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
        linux-efi@vger.kernel.org, iommu@lists.linux.dev
Cc: ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
        nivedita@alum.mit.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, corbet@lwn.net, ebiederm@xmission.com,
        dwmw2@infradead.org, baolu.lu@linux.intel.com,
        kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com,
        trenchboot-devel@googlegroups.com
Subject: [PATCH v13 00/19] x86: Trenchboot secure dynamic launch Linux kernel support
Date: Thu, 10 Apr 2025 13:41:30 -0700
Message-Id: <20250410204149.2576104-1-ross.philipson@oracle.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_06,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504100150
X-Proofpoint-GUID: FuCcubW1kDj4MLdjbkpiX5ofRlyfOo4F
X-Proofpoint-ORIG-GUID: FuCcubW1kDj4MLdjbkpiX5ofRlyfOo4F

This is a reposting of the recently posted Secure Launch v13 patch set.
This version contains a summary of what is already reviewed in the patch
set and what patches need reviews:

 - Patches 1/8/14/15/16/17/19 already have reviews done for them.
 - Patches 2/3/4/7/9/10/11/12/13/18 need to be reviewed by one of the x86 folks.
 - Patches 5/6 need a review from a lib/crypto maintainer.

The larger focus of the TrenchBoot project (https://github.com/TrenchBoot) is to
enhance the boot security and integrity in a unified manner. The first area of
focus has been on the Trusted Computing Group's Dynamic Launch for establishing
a hardware Root of Trust for Measurement, also know as DRTM (Dynamic Root of
Trust for Measurement). The project has been and continues to work on providing
a unified means to Dynamic Launch that is a cross-platform (Intel and AMD) and
cross-architecture (x86 and Arm), with our recent involvment in the upcoming
Arm DRTM specification. The order of introducing DRTM to the Linux kernel
follows the maturity of DRTM in the architectures. Intel's Trusted eXecution
Technology (TXT) is present today and only requires a preamble loader, e.g. a
boot loader, and an OS kernel that is TXT-aware. AMD DRTM implementation has
been present since the introduction of AMD-V but requires an additional
component that is AMD specific and referred to in the specification as the
Secure Loader, which the TrenchBoot project has an active prototype in
development. Finally Arm's implementation is in specification development stage
and the project is looking to support it when it becomes available.

This patchset provides detailed documentation of DRTM, the approach used for
adding the capbility, and relevant API/ABI documentation. In addition to the
documentation the patch set introduces Intel TXT support as the first platform
for Linux Secure Launch.

A quick note on terminology. The larger open source project itself is called
TrenchBoot, which is hosted on Github (links below). The kernel feature enabling
the use of Dynamic Launch technology is referred to as "Secure Launch" within
the kernel code. As such the prefixes sl_/SL_ or slaunch/SLAUNCH will be seen
in the code. The stub code discussed above is referred to as the SL stub.

Links:

The TrenchBoot project including documentation:

https://trenchboot.org

The TrenchBoot project on Github:

https://github.com/trenchboot

Intel TXT is documented in its own specification and in the SDM Instruction Set volume:

https://www.intel.com/content/dam/www/public/us/en/documents/guides/intel-txt-software-development-guide.pdf
https://software.intel.com/en-us/articles/intel-sdm

The TrenchBoot project provides a quick start guide to help get a system
up and running with Secure Launch for Linux:

https://github.com/TrenchBoot/documentation/blob/master/QUICKSTART.md

Patch set based on commit:

torvalds/master/3a90a72aca0a98125f0c7350ffb7cc63665f8047

Finally we would like to thank everyone for their input and assistance. It has
all been very helpful in improving the quality of our solution and in
reviewing/strengthening our security posture.

Thanks
Ross Philipson and Daniel P. Smith

Changes in v2:

 - Modified 32b entry code to prevent causing relocations in the compressed
   kernel.
 - Dropped patches for compressed kernel TPM PCR extender.
 - Modified event log code to insert log delimiter events and not rely
   on TPM access.
 - Stop extending PCRs in the early Secure Launch stub code.
 - Removed Kconfig options for hash algorithms and use the algorithms the
   ACM used.
 - Match Secure Launch measurement algorithm use to those reported in the
   TPM 2.0 event log.
 - Read the TPM events out of the TPM and extend them into the PCRs using
   the mainline TPM driver. This is done in the late initcall module.
 - Allow use of alternate PCR 19 and 20 for post ACM measurements.
 - Add Kconfig constraints needed by Secure Launch (disable KASLR
   and add x2apic dependency).
 - Fix testing of SL_FLAGS when determining if Secure Launch is active
   and the architecture is TXT.
 - Use SYM_DATA_START_LOCAL macros in early entry point code.
 - Security audit changes:
   - Validate buffers passed to MLE do not overlap the MLE and are
     properly laid out.
   - Validate buffers and memory regions used by the MLE are
     protected by IOMMU PMRs.
 - Force IOMMU to not use passthrough mode during a Secure Launch.
 - Prevent KASLR use during a Secure Launch.

Changes in v3:

 - Introduce x86 documentation patch to provide background, overview
   and configuration/ABI information for the Secure Launch kernel
   feature.
 - Remove the IOMMU patch with special cases for disabling IOMMU
   passthrough. Configuring the IOMMU is now a documentation matter
   in the previously mentioned new patch.
 - Remove special case KASLR disabling code. Configuring KASLR is now
   a documentation matter in the previously mentioned new patch.
 - Fix incorrect panic on TXT public register read.
 - Properly handle and measure setup_indirect bootparams in the early
   launch code.
 - Use correct compressed kernel image base address when testing buffers
   in the early launch stub code. This bug was introduced by the changes
   to avoid relocation in the compressed kernel.
 - Use CPUID feature bits instead of CPUID vendor strings to determine
   if SMX mode is supported and the system is Intel.
 - Remove early NMI re-enable on the BSP. This can be safely done later
   on the BSP after an IDT is setup.

Changes in v4:
 - Expand the cover letter to provide more context to the order that DRTM
   support will be added.
 - Removed debug tracing in TPM request locality funciton and fixed
   local variable declarations.
 - Fixed missing break in default case in slmodule.c.
 - Reworded commit messages in patches 1 and 2 per suggestions.

Changes in v5:
 - Comprehensive documentation rewrite.
 - Use boot param loadflags to communicate Secure Launch status to
   kernel proper.
 - Fix incorrect check of X86_FEATURE_BIT_SMX bit.
 - Rename the alternate details and authorities PCR support.
 - Refactor the securityfs directory and file setup in slmodule.c.
 - Misc. cleanup from internal code reviews.
 - Use reverse fir tree format for variables.

Changes in v6:
 - Support for the new Secure Launch Resourse Table that standardizes
   the information passed and forms the ABI between the pre and post
   launch code.
 - Support for booting Linux through the EFI stub entry point and
   then being able to do a Secure Launch once EFI stub is done and EBS
   is called.
 - Updates to the documentation to reflect the previous two items listed.

Changes in v7:
 - Switch to using MONITOR/MWAIT instead of NMIs to park the APs for
   later bringup by the SMP code.
 - Use static inline dummy functions instead of macros when the Secure
   Launch feature is disabled.
 - Move early SHA1 code to lib/crypto and pull it in from there.
 - Numerous formatting fixes from comments on LKML.
 - Remove efi-stub/DL stub patch temporarily for redesign/rework.

Changes in v8:
 - Reintroduce efi-stub Linux kernel booting through the dynamic launch
   stub (DL stub).
 - Add new approach to setting localities > 0 through kernel and sysfs
   interfaces in the TPM mainline driver.
 - General code cleanup from v7 post comments.

Changes in v9:
 - Updated DL stub support for recent changes to EFI stub in the kernel.
 - Added patches to fix locality changing support in the TPM driver
   (these patches originally were posted as a separate set).
 - Enhanced Secure Launch TPM locality 2 setting in the TPM driver.
 - Added locality setting support through sysfs for user land to access.
 - Split up SHA1 and SHA256 changes into separate patches and updated
   the commit messages to be more clear (per request from upstream
   review).
 - Fix Clang compile issues detected by kernel test robot.
 - Modifications to the Secure Launch Resource Table ABI:
   . Use flex arrays in table structures.
   . Update and move fields in tables to make everything 8b aligned.
   . Add 2 new DLME fields and a txt_heap address field.
   . Remove platform specific tables that are not defined yet (AMD/ARM).
 - Update Kconfig dependencies for Secure Launch with SHA1/SHA256/TPM.
 - Remove push/pop of rsi since boot params is now stored in r15.
 - Update outdated kernel documentation.
 - Misc. comment fixes for type-os and mispellings.

Changes in v10:
 - Removed patch #1 from previous set that forced the kernel_info
   section at a fixed offset.
 - Add changes from Ard Biesheuvel to use the link step to generate the
   proper relative offsets for the MLE header in the kernel_info
   section.
 - Fix sizes and alignment slightly in the SLR table. Add comments to
   the SLR header to indicate it is defined by the TrenchBoot project.
 - Remove incorrect extra pop instruction noted in the head_64.S
   changes.
 - Use the prefix tpm/tpm2 to distinguish between TPM versions as is
   done in the rest of the TPM related code.
 - Rework the TPM locality setting/reporting changes to use "default"
   locality as opposed to "preferred". Remove uneeded extra locality
   function in the TPM interface (call the chip function directly).
 - Adopt comment/documentation changes to code and commit message per
   requests from the community.
 - Use u64 for the boot params physical address to avoid truncating
   pointers during casts.
 - Split adding of new MSR registers into its own patch.
 - Attempt to further address justification for using SHA-1 algorithm.
   Pick up some code suggestions for the SHA-1 patch.
 - Introduct slaunch_is_txt_launch() function per Jarkko Sakkinen's
   suggestion.
 - Implement minor changes to the EFI stub code per suggestions.

Changes in v11:
 - Add section to user documents about SHA-1 usage with Secure
   Launch as requested.
 - General cleanup and grammar fixes to the Linux user documentation.
 - Fix use of CONFIG_SECURE_LAUNCH in the EFI stub code to prevent
   32b build failures.
 - Cleanup of early event log handling code.

Changes in v12:
 - Modify the event processing and PCR extending code to cap all unknown
   algorithm bank PCRs and extend the cap digest into those banks/PCRs.
 - Fix documentation to have the correct NIST terminology and document
   links.
 - Switch custom SL vendor specific TPM event types used as markers
   back to type NO_ACTION to allow proper event log parsing.
 - Move boot_params_addr from the TXT heap into the SLRT Intel
   information table to make SLRT architecture specific table usage
   more consistent.
 - Change SL Kconfig dependencies from TCG_TPM to TCG_TIS && TCG_CRB
   to more accurately depend of the underlying TPM driver components.
 - Remove unwanted Unicode characters from documentation and comments
   plus minor documentation fix.

Changes in v13:
 - Documentation rework:
   * Make the documentation for Secure Launch (patch 1) more concise
     and readable.
   * Fix and add comments to code.
   * Update some commit messages to be clearer.


Daniel P. Smith (6):
  Documentation/x86: Secure Launch kernel documentation
  x86: Add early SHA-1 support for Secure Launch early measurements
  x86: Add early SHA-256 support for Secure Launch early measurements
  tpm, tpm_tis: Close all localities
  tpm, tpm_tis: Address positive localities in
    tpm_tis_request_locality()
  x86: Secure Launch late initcall platform module

Ross Philipson (13):
  x86: Secure Launch Kconfig
  x86: Secure Launch Resource Table header file
  x86: Secure Launch main header file
  x86/msr: Add variable MTRR base/mask and x2apic ID registers
  x86/boot: Place TXT MLE header in the kernel_info section
  x86: Secure Launch kernel early boot stub
  x86: Secure Launch kernel late boot stub
  x86: Secure Launch SMP bringup support
  kexec: Secure Launch kexec SEXIT support
  x86/reboot: Secure Launch SEXIT support on reboot paths
  tpm, tpm_tis: Allow locality to be set to a different value
  tpm, sysfs: Show locality used by kernel
  x86/efi: EFI stub DRTM launch support for Secure Launch

 Documentation/arch/x86/boot.rst               |  21 +
 Documentation/security/index.rst              |   1 +
 .../security/launch-integrity/index.rst       |  11 +
 .../security/launch-integrity/principles.rst  | 308 ++++++++
 .../secure_launch_details.rst                 | 587 ++++++++++++++
 .../secure_launch_overview.rst                | 240 ++++++
 arch/x86/Kconfig                              |  11 +
 arch/x86/boot/compressed/Makefile             |   3 +
 arch/x86/boot/compressed/head_64.S            |  29 +
 arch/x86/boot/compressed/kernel_info.S        |  50 +-
 arch/x86/boot/compressed/sha1.c               |   6 +
 arch/x86/boot/compressed/sha256.c             |   6 +
 arch/x86/boot/compressed/sl_main.c            | 597 ++++++++++++++
 arch/x86/boot/compressed/sl_stub.S            | 726 ++++++++++++++++++
 arch/x86/boot/compressed/vmlinux.lds.S        |   7 +
 arch/x86/include/asm/msr-index.h              |   5 +
 arch/x86/include/asm/realmode.h               |   3 +
 arch/x86/include/uapi/asm/bootparam.h         |   1 +
 arch/x86/kernel/Makefile                      |   2 +
 arch/x86/kernel/asm-offsets.c                 |  20 +
 arch/x86/kernel/reboot.c                      |  10 +
 arch/x86/kernel/setup.c                       |   3 +
 arch/x86/kernel/slaunch.c                     | 596 ++++++++++++++
 arch/x86/kernel/slmodule.c                    | 508 ++++++++++++
 arch/x86/kernel/smpboot.c                     |  43 +-
 arch/x86/realmode/init.c                      |   3 +
 arch/x86/realmode/rm/header.S                 |   3 +
 arch/x86/realmode/rm/trampoline_64.S          |  32 +
 drivers/char/tpm/tpm-chip.c                   |  33 +-
 drivers/char/tpm/tpm-sysfs.c                  |  10 +
 drivers/char/tpm/tpm_tis_core.c               |  21 +-
 drivers/firmware/efi/libstub/efistub.h        |   8 +
 drivers/firmware/efi/libstub/x86-stub.c       |  94 +++
 drivers/iommu/intel/dmar.c                    |   4 +
 include/crypto/sha1.h                         |   1 +
 include/linux/slaunch.h                       | 562 ++++++++++++++
 include/linux/slr_table.h                     | 308 ++++++++
 include/linux/tpm.h                           |  10 +
 kernel/kexec_core.c                           |   4 +
 lib/crypto/sha1.c                             |  81 ++
 40 files changed, 4959 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/security/launch-integrity/index.rst
 create mode 100644 Documentation/security/launch-integrity/principles.rst
 create mode 100644 Documentation/security/launch-integrity/secure_launch_details.rst
 create mode 100644 Documentation/security/launch-integrity/secure_launch_overview.rst
 create mode 100644 arch/x86/boot/compressed/sha1.c
 create mode 100644 arch/x86/boot/compressed/sha256.c
 create mode 100644 arch/x86/boot/compressed/sl_main.c
 create mode 100644 arch/x86/boot/compressed/sl_stub.S
 create mode 100644 arch/x86/kernel/slaunch.c
 create mode 100644 arch/x86/kernel/slmodule.c
 create mode 100644 include/linux/slaunch.h
 create mode 100644 include/linux/slr_table.h

Range-diff v12 -> v13:
-----------------------------------------------

 1:  c21b641482ba !  1:  06e0394c0802 Documentation/x86: Secure Launch kernel documentation
    @@ Documentation/security/launch-integrity/index.rst (new)
      ## Documentation/security/launch-integrity/principles.rst (new) ##
     @@
     +.. SPDX-License-Identifier: GPL-2.0
    -+.. Copyright (c) 2019-2024 Daniel P. Smith <dpsmith@apertussolutions.com>
    ++.. Copyright (c) 2019-2025 Daniel P. Smith <dpsmith@apertussolutions.com>
     +
     +=======================
     +System Launch Integrity
     +=======================
     +
     +:Author: Daniel P. Smith
    -+:Date: August 2024
    ++:Date: March 2025
     +
     +This document serves to establish a common understanding of what a system
     +launch is, the integrity concern for system launch, and why using a Root of Trust
     +(RoT) from a Dynamic Launch may be desirable. Throughout this document,
     +terminology from the Trusted Computing Group (TCG) and National Institute for
    -+Standards and Technology (NIST) is used to ensure that vendor natural language is
    -+used to describe and reference security-related concepts.
    ++Standards and Technology (NIST) is used to ensure that a vendor natural language
    ++describes and references security-related concepts.
     +
     +System Launch
     +=============
     +
    -+There is a tendency to only consider the classical power-on boot as the only
    -+means to launch an Operating System (OS) on a computer system. In fact, most
    -+modern processors support two system launch methods. To provide clarity,
    -+it is important to establish a common definition of a system launch: during
    -+a single power life cycle of a system, a system launch consists of an initialization
    -+event, typically in hardware, that is followed by an executing software payload
    -+that takes the system from the initialized state to a running state. Driven by
    -+the Trusted Computing Group (TCG) architecture, modern processors are able to
    -+support two methods of system launch. These two methods of system launch are known
    -+as Static Launch and Dynamic Launch.
    ++There is a tendency to consider the classical power-on boot as the only means to
    ++launch an Operating System (OS) on a computer. In fact, driven by the
    ++Trusted Computing Group (TCG) architecture, modern processors are able to support
    ++two methods of system launch: Static Launch and Dynamic Launch.
     +
     +Static Launch
     +-------------
    @@ Documentation/security/launch-integrity/principles.rst (new)
     +Dynamic Launch
     +--------------
     +
    -+Modern CPUs architectures provides a mechanism to re-initialize the system to a
    -+"known good" state without requiring a power event. This re-initialization
    -+event is the event for a dynamic launch and is referred to as the Dynamic
    -+Launch Event (DLE). The DLE functions by accepting a software payload, referred
    ++Modern CPU architectures provide a mechanism to re-initialize the system to a
    ++"known good" state without requiring a power event. This re-initialization is the
    ++starting point for a dynamic launch and is referred to as The Dynamic Launch Event
    ++(DLE). The DLE functions by accepting a software payload, referred
     +to as the Dynamic Configuration Environment (DCE), that execution is handed to
     +after the DLE is invoked. The DCE is responsible for bringing the system back
    -+to a running state. Since the dynamic launch is not tied to a power event like
    -+the static launch, this enables a dynamic launch to be initiated at any time
    ++to a running state. Since the dynamic launch is not tied to a power event like the
    ++static launch is, this enables a dynamic launch to be initiated at any time
     +and multiple times during a single power life cycle. This dynamism is the
     +reasoning behind referring to this system launch as "dynamic".
     +
     +Because a dynamic launch can be conducted at any time during a single power
    -+life cycle, they are classified into one of two types: an early launch or a
    ++life cycle, it is classified as either one of two types: an early launch or a
     +late launch.
     +
    -+:Early Launch: When a dynamic launch is used as a transition from a static
    ++:Early Launch: A dynamic launch that is used as a transition from a static
     +   launch chain to the final Operating System.
     +
    -+:Late Launch: The usage of a dynamic launch by an executing Operating System to
    ++:Late Launch: A dynamic launch by an executing Operating System to
     +   transition to a "known good" state to perform one or more operations, e.g. to
     +   launch into a new Operating System.
     +
     +System Integrity
     +================
     +
    -+A computer system can be considered a collection of mechanisms that work
    -+together to produce a result. The assurance that the mechanisms are functioning
    -+correctly and producing the expected result is the integrity of the system. To
    -+ensure a system's integrity, there is a subset of these mechanisms, commonly
    -+referred to as security mechanisms, that is present to help ensure the system
    -+produces the expected result or at least detects the potential of an unexpected
    -+result. Since the security mechanisms are relied upon to ensue the integrity of
    -+the system, these mechanisms are trusted. Upon inspection, these security
    -+mechanisms each have a set of properties and these properties can be evaluated
    -+to determine how susceptible a mechanism might be to failure. This assessment is
    -+referred to as the Strength of Mechanism, which allows the trustworthiness of
    -+that mechanism to be quantified.
    -+
    -+For software systems, there are two system states for which the integrity is
    -+critical: when the software is loaded into memory and when the software is
    -+executing on the hardware. Ensuring that the expected software is loaded into
    -+memory is referred to as load-time integrity while ensuring that the software
    -+executing is the expected software is the runtime integrity of that software.
    ++For software systems, there are two system states for which the integrity of the
    ++software is critical: when it is loaded into memory and when it is executing on the
    ++hardware. Ensuring that the expected software is loaded into memory is referred to
    ++as load-time integrity. Ensuring that the software executing is the expected
    ++payload is the runtime integrity of that software.
     +
     +Load-time Integrity
     +-------------------
     +
    -+It is critical to understand what load-time integrity establishes about a
    -+system and what is assumed, i.e. what is being trusted. Load-time integrity is
    -+when a trusted entity, i.e. an entity with an assumed integrity, takes an
    -+action to assess an entity being loaded into memory before it is used. A
    -+variety of mechanisms may be used to conduct the assessment, each with
    -+different properties. A particular property is whether the mechanism creates an
    -+evidence of the assessment. Often either cryptographic signature checking or
    ++Load-time integrity is when a trusted entity, i.e. an entity with an assumed
    ++integrity, takes an action to assess an entity being loaded into memory before
    ++it is used. A variety of mechanisms may be used to conduct the assessment, each
    ++with different properties. A particular property is whether the mechanism creates
    ++an evidence of the assessment. Often either cryptographic signature checking or
     +hashing are the common assessment operations used.
     +
     +A signature checking assessment functions by requiring a representation of the
     +accepted authorities and uses those representations to assess if the entity has
    -+been signed by an accepted authority. The benefit to this process is that
    -+assessment process includes an adjudication of the assessment. The drawbacks
    -+are that 1) the adjudication is susceptible to tampering by the Trusted
    -+Computing Base (TCB), 2) there is no evidence to assert that an untampered
    -+adjudication was completed, and 3) the system must be an active participant in
    -+the key management infrastructure.
    -+
    -+A cryptographic hashing assessment does not adjudicate the assessment, but
    ++been signed by an accepted authority. The benefit of this process is that it
    ++includes an adjudication of the assessment. The drawbacks are that 1) the adjudication
    ++is susceptible to tampering by the Trusted Computing Base (TCB), 2) there is no
    ++evidence to assert that an untampered adjudication was completed, and 3) the system
    ++must be an active participant in the key management infrastructure.
    ++
    ++A cryptographic measurement does not adjudicate the assessment, but
     +instead generates evidence of the assessment to be adjudicated independently.
    -+The benefits to this approach is that the assessment may be simple such that it
    -+may be implemented in an immutable mechanism, e.g. in hardware.  Additionally,
    ++The benefit to this approach is that the assessment may be simplified such that it
    ++can be implemented in an immutable mechanism, e.g. in hardware.  Additionally,
     +it is possible for the adjudication to be conducted where it cannot be tampered
     +with by the TCB. The drawback is that a compromised environment will be allowed
     +to execute until an adjudication can be completed.
    @@ Documentation/security/launch-integrity/principles.rst (new)
     +Runtime Integrity
     +-----------------
     +
    -+Runtime integrity in the general sense is when a trusted entity makes an
    -+assessment of an entity at any point in time during the assessed entity's
    ++Runtime integrity, in the general sense, is when a trusted entity makes an
    ++assessment of another entity at any point in time during the assessed entity's
     +execution. A more concrete explanation is the taking of an integrity assessment
     +of an active process executing on the system at any point during the process'
     +execution. Often the load-time integrity of an operating system's user-space,
    @@ Documentation/security/launch-integrity/principles.rst (new)
     +
     +Building upon the understanding of security mechanisms to establish load-time
     +integrity of an entity, it is possible to chain together load-time integrity
    -+assessments to establish the integrity of the whole system. This process is
    -+known as transitive trust and provides the concept of building a chain of
    -+load-time integrity assessments, commonly referred to as a trust chain. These
    -+assessments may be used to adjudicate the load-time integrity of the whole
    -+system. This trust chain is started by a trusted entity that does the first
    -+assessment. This first entity is referred to as the Root of Trust(RoT) with the
    -+entities name being derived from the mechanism used for the assessment, i.e.
    -+RoT for Verification (RTV) and RoT for Measurement (RTM).
    ++assessments to establish the integrity of the whole system. The process of
    ++creating this chain involves using a series of transitive trust assertions to
    ++establish confidence in the load-time integrity of each component loaded.
    ++
    ++This process is known as transitive trust and provides the concept of building
    ++a chain of load-time integrity assessments, commonly referred to as a trust
    ++chain. These assessments may be used to adjudicate the load-time integrity of
    ++the whole system. This trust chain is started by a trusted entity that does the
    ++first assessment. This first entity is referred to as the Root of Trust (RoT)
    ++with the entity's name being derived from the mechanism used for the assessment,
    ++i.e. RoT for Verification (RTV) and RoT for Measurement (RTM).
     +
     +A trust chain is itself a mechanism, specifically a mechanism of mechanisms,
     +and therefore it also has a Strength of Mechanism. The factors that contribute
    @@ Documentation/security/launch-integrity/principles.rst (new)
     +
     +  - The strength of the chain's RoT
     +  - The strength of each member of the trust chain
    -+  - The length, i.e. the number of members, of the chain
    ++  - The length (i.e. the number of members) of the chain
     +
    -+Therefore, the strongest trust chains should start with a strong RoT and should
    -+consist of members being of low complexity and minimize the number of members
    ++Therefore, the strongest trust chains should start with a strong RoT,
    ++consist of members being of low complexity, and minimize the number of members
     +participating. In a more colloquial sense, a trust chain is only as strong as its
    -+weakest link, thus more links increase the probability of a weak link.
    ++weakest link, therefore more links increase the probability of a weak link.
     +
     +Dynamic Launch Components
     +=========================
     +
     +The TCG architecture for dynamic launch is composed of a component series
     +used to set up and then carry out the launch. These components work together to
    -+construct an RTM trust chain that is rooted in the dynamic launch and thus commonly
    ++construct an RTM trust chain rooted in the dynamic launch, commonly
     +referred to as the Dynamic Root of Trust for Measurement (DRTM) chain.
     +
    ++.. note::
    ++    Intel TXT pre-dates the TCG Dynamic Launch specification. In the Intel TXT
    ++    documentation, Dynamic Root of Trust for Measurement was abbreviated as DRTM.
    ++    When Dynamic Launch was codified in the TCG specification, it was given
    ++    the acronym D-RTM. There is a similar situation with Static Root of Trust for
    ++    Measuremnt. In TCG documentation it will be given the acronym S-RTM but it is not
    ++    uncommon to see it as SRTM. For the purposes of the launch integrity documents,
    ++    DRTM and SRTM will be the preferred acronym.
    ++
     +What follows is a brief explanation of each component in execution order. A
    -+subset of these components are what establishes the dynamic launch's trust
    ++subset of these components is what establishes the dynamic launch's trust
     +chain.
     +
     +Dynamic Configuration Environment Preamble
    @@ Documentation/security/launch-integrity/principles.rst (new)
     +final/target operating system, or it may be a bootloader that will load the
     +final/target operating system.
     +
    -+Why DRTM
    -+========
    ++Why DRTM?
    ++=========
     +
    -+It is a fact that DRTM increases the load-time integrity of the system by
    -+providing a trust chain that has an immutable hardware RoT, uses a limited
    ++A DRTM solution increases the load-time integrity of the system by
    ++providing a trust chain that has an immutable hardware RoT and uses a limited
     +number of small, special purpose code to establish the trust chain that starts
     +the target operating system. As mentioned in the Trust Chain section, these are
    -+the main three factors in driving up the strength of a trust chain. As has been
    -+seen with the BootHole exploit, which in fact did not affect the integrity of
    -+DRTM solutions, the sophistication of attacks targeting system launch is at an
    ++three main factors in driving up the strength of a trust chain. As has been
    ++seen with the BootHole exploit (which in fact did not affect the integrity of
    ++DRTM solutions), the sophistication of attacks targeting system launch is at an
     +all-time high. There is no reason a system should not employ every available
     +hardware integrity measure. This is the crux of a defense-in-depth
    -+approach to system security. In the past, the now closed SMI gap was often
    -+pointed to as invalidating DRTM, which in fact was nothing but a straw man
    -+argument. As has continued to be demonstrated, if/when SMM is corrupted, it can
    ++approach to system security.
    ++
    ++In the past, the now closed SMI gap was often pointed to as invalidating DRTM.
    ++As has continued to be demonstrated, if/when SMM is corrupted, it can
     +always circumvent all load-time integrity (SRTM and DRTM) because it is a
     +run-time integrity problem. Regardless, Intel and AMD have both deployed
     +runtime integrity for SMI and SMM which is tied directly to DRTM such that this
    -+perceived deficiency is now non-existent and the world is moving forward with
    ++perceived deficiency is now non-existent. The world is moving forward with
     +an expectation that DRTM must be present.
     +
     +Glossary
    @@ Documentation/security/launch-integrity/principles.rst (new)
      ## Documentation/security/launch-integrity/secure_launch_details.rst (new) ##
     @@
     +.. SPDX-License-Identifier: GPL-2.0
    -+.. Copyright (c) 2019-2024 Daniel P. Smith <dpsmith@apertussolutions.com>
    ++.. Copyright (c) 2019-2025 Daniel P. Smith <dpsmith@apertussolutions.com>
     +
     +===================================
     +Secure Launch Config and Interfaces
     +===================================
     +
     +:Author: Daniel P. Smith
    -+:Date: August 2024
    ++:Date: March 2025
     +
     +Configuration
     +=============
    @@ Documentation/security/launch-integrity/secure_launch_details.rst (new)
     +
     +Description:
     +
    -+During early validation, a buffer or region was found to straddle the 4GB
    ++During early validation, a buffer or region was found to straddle the 4Gb
     +boundary. Because of the way TXT provides DMA memory protection, this is an unsafe
     +configuration and is flagged as an error. This is most likely a configuration
     +issue in the pre-launch environment. It could also be the sign of an attempted
    @@ Documentation/security/launch-integrity/secure_launch_details.rst (new)
     +
     +Description:
     +
    -+A memory region used by the MLE is above 4GB. In general this is not a problem
    ++A memory region used by the MLE is above 4Gb. In general this is not a problem
     +because memory > 4Gb can be protected from DMA. There are certain buffers that
     +should never be above 4Gb, and one of these caused the violation. This is most
     +likely a configuration issue in the pre-launch environment. It could also be
    @@ Documentation/security/launch-integrity/secure_launch_details.rst (new)
     +
     +Description:
     +
    -+On a system with more than 4G of RAM, the high PMR [2]_ base address should be
    -+set to 4G. This error is due to that not being the case. This PMR value is set
    ++On a system with more than 4Gb of RAM, the high PMR [2]_ base address should be
    ++set to 4Gb. This error is due to that not being the case. This PMR value is set
     +by the pre-launch environment, so the issue most likely originates there. It
     +could also be the sign of an attempted attack.
     +
    @@ Documentation/security/launch-integrity/secure_launch_details.rst (new)
     +
     +Description:
     +
    -+On a system with more than 4G of RAM, the high PMR [2]_ size should be set to
    -+cover all RAM > 4G. This error is due to that not being the case. This PMR
    ++On a system with more than 4Gb of RAM, the high PMR [2]_ size should be set to
    ++cover all RAM > 4Gb. This error is due to that not being the case. This PMR
     +value is set by the pre-launch environment, so the issue most likely originates
     +there. It could also be the sign of an attempted attack.
     +
    @@ Documentation/security/launch-integrity/secure_launch_details.rst (new)
      ## Documentation/security/launch-integrity/secure_launch_overview.rst (new) ##
     @@
     +.. SPDX-License-Identifier: GPL-2.0
    -+.. Copyright (c) 2019-2024 Daniel P. Smith <dpsmith@apertussolutions.com>
    ++.. Copyright (c) 2019-2025 Daniel P. Smith <dpsmith@apertussolutions.com>
     +
     +======================
     +Secure Launch Overview
     +======================
     +
     +:Author: Daniel P. Smith
    -+:Date: August 2024
    ++:Date: March 2025
     +
     +Overview
     +========
     +
    -+Prior to the start of the TrenchBoot project, the only active Open Source
    -+project supporting dynamic launch was Intel's tboot project to support their
    -+implementation of dynamic launch known as Intel Trusted eXecution Technology
    -+(TXT). The approach taken by tboot was to provide an exokernel that could
    -+handle the launch protocol implemented by the Intel provided loader, the SINIT
    -+Authenticated Code Module (ACM [2]_), and remained in memory to manage the SMX
    -+CPU mode that a dynamic launch would put a system. While it is not precluded
    -+from being used for a late launch, tboot's primary use case was to be
    -+used as an early launch solution. As a result, the TrenchBoot project started
    -+the development of Secure Launch kernel feature to provide a more generalized
    -+approach. The focus of the effort is twofold: first, to make the Linux
    -+kernel directly aware of the launch protocol used by Intel, AMD/Hygon, Arm, and
    -+potentially OpenPOWER; second, to make the Linux kernel able to
    -+initiate a dynamic launch. It is through this approach that the Secure Launch
    -+kernel feature creates a basis for the Linux kernel to be used in a variety of
    -+dynamic launch use cases.
    ++The TrenchBoot project started the development of the Secure Launch kernel feature
    ++to provide a more generalized approach. The focus of the effort is twofold: first,
    ++to make the Linux kernel directly aware of the launch protocol used by platforms
    ++such as Intel, AMD/Hygon, Arm, and potentially OpenPOWER; second, to make the
    ++Linux kernel able to initiate a dynamic launch. It is through this approach that
    ++the Secure Launch kernel feature creates a basis for the Linux kernel to be used
    ++in a variety of dynamic launch use cases.
     +
     +.. note::
     +    A quick note on terminology. The larger open source project itself is
    @@ Documentation/security/launch-integrity/secure_launch_overview.rst (new)
     +The first use case that the TrenchBoot project focused on was the ability for
     +the Linux kernel to be started by a dynamic launch, in particular as part of an
     +early launch sequence. In this case, the dynamic launch will be initiated by
    -+any bootloader with associated support added to it. For example, the first
    -+targeted bootloader in this case was GRUB2. An integral part of establishing a
    -+measurement-based launch integrity involves measuring everything that is
    -+intended to be executed (kernel image, initrd, etc.) and everything that will
    -+configure that kernel to execute (command line, boot params, etc.), then
    -+storing those measurements in a protected manner. Both the Intel and AMD
    -+dynamic launch implementations leverage the Trusted Platform Module (TPM) to
    -+store those measurements. The TPM itself has been designed such that a dynamic
    -+launch unlocks a specific set of Platform Configuration Registers (PCR) for
    -+holding measurement taken during the dynamic launch. These are referred to as
    -+the DRTM PCRs, PCRs 17-22. Further details on this process can be found in the
    -+documentation for the GETSEC instruction provided by Intel's TXT and the SKINIT
    -+instruction provided by AMD's AMD-V. The documentation on these technologies
    -+can be readily found online; see the `Resources`_ section below for references.
    ++any bootloader with associated support added to it. The first targeted bootloader
    ++in this case was GRUB2. An integral part of establishing a measurement-based
    ++launch integrity involves measuring everything that is intended to be executed
    ++(kernel image, initrd, etc.) and everything that will configure that kernel to
    ++execute (command line, boot params, etc.), then storing those measurements in a
    ++protected manner. Both the Intel and AMD dynamic launch implementations leverage
    ++the Trusted Platform Module (TPM) to store those measurements. The TPM itself
    ++has been designed such that a dynamic launch unlocks a specific set of Platform
    ++Configuration Registers (PCR) for holding measurement taken during the dynamic
    ++launch. These are referred to as the DRTM PCRs, PCRs 17-22. Further details on this
    ++process can be found respectively in the documentation for the GETSEC instruction
    ++provided by Intel's TXT and the SKINIT instruction provided by AMD's AMD-V. The
    ++documentation on these technologies can be readily found online; see
    ++the `Resources`_ section below for references.
     +
     +.. note::
     +    Currently, only Intel TXT is supported in this first release of the Secure
     +    Launch feature. AMD/Hygon SKINIT and Arm support will be added in a
     +    subsequent release.
     +
    -+To enable the kernel to be launched by GETSEC a stub, the Secure Launch stub
    ++To enable the kernel to be launched by GETSEC, the Secure Launch stub
     +must be built into the setup section of the compressed kernel to handle the
     +specific state that the dynamic launch process leaves the BSP. Also, the Secure
     +Launch stub must measure everything that is going to be used as early as
     +possible. This stub code and subsequent code must also deal with the specific
    -+state that the dynamic launch leaves the APs as well.
    ++state that the dynamic launch leaves the APs in.
     +
     +Design Decisions
     +================
    @@ Documentation/security/launch-integrity/secure_launch_overview.rst (new)
     +   needed DRTM measurements.
     + - After the call to sl_main(), the main kernel is decompressed and boots as
     +   it normally would.
    ++ - Support is introduced in the SMP boot code to properly wake the APs. This
    ++   is required due to the unique state the dynamic launch leaves the APs in
    ++   (i.e. they cannot be woken with the standard INIT-SIPI sequence).
     + - Final setup for the Secure Launch kernel is done in a separate Secure
     +   Launch module that is loaded via a late initcall. This code is responsible
     +   for extending the measurements taken earlier into the TPM DRTM PCRs and
    @@ Documentation/security/launch-integrity/secure_launch_overview.rst (new)
     + - On the reboot and kexec paths, calls are made to a function to finalize the
     +   state of the Secure Launch kernel.
     +
    -+The one place where Secure Launch code is mixed directly in with kernel code is
    -+in the SMP boot code. This is due to the unique state that the dynamic launch
    -+leaves the APs in. On Intel, this involves using a method other than the
    -+standard INIT-SIPI sequence.
    -+
    -+A final note is that originally the extending of the PCRs was completed in the
    -+Secure Launch stub when the measurements were taken. An alternative solution
    -+had to be implemented due to the TPM maintainers objecting to the PCR
    -+extensions being done with a minimal interface to the TPM that was an
    -+independent implementation of the mainline kernel driver. Since the mainline
    -+driver relies heavily on kernel interfaces not available in the compressed
    -+kernel, it was not possible to reuse the mainline TPM driver. This resulted in
    -+the decision to move the extension operations to the Secure Launch module in
    -+the mainline kernel, where the TPM driver would be available.
    ++A final note is that the original concept was to extend the DRTM PCRs in the
    ++Secure Launch stub when the measurements were taken. This requires access to the
    ++TPM early during boot time. Since the mainline kernel TPM driver relies heavily
    ++on kernel interfaces not available in the compressed kernel, it was not possible
    ++to reuse the mainline TPM driver. An alternate solution that has been implemented,
    ++moves the extension operations to the Secure Launch module in the mainline
    ++kernel, where the TPM driver would be available.
     +
     +Basic Boot Flow
     +===============
     +
     +Outlined here is a summary of the boot flow for Secure Launch. A more detailed
    -+review of Secure Launch process can be found in the Secure Launch
    ++review of the Secure Launch process can be found in the Secure Launch
     +Specification (a link is located in the `Resources`_ section).
     +
     +Pre-launch: *Phase where the environment is prepared and configured to initiate
    @@ Documentation/security/launch-integrity/secure_launch_overview.rst (new)
     + - Set up the TXT heap and page tables describing the MLE [1]_ per the
     +   specification.
     + - If non-UEFI platform, dl_stub is called.
    -+ - If UEFI platforms, SLRT registered with UEFI and efi-stub called.
    ++ - If UEFI platform, SLRT registered with UEFI and efi-stub called.
     + - Upon completion, efi-stub will call EBS followed by dl_stub.
     + - The dl_stub will prepare the CPU and the TPM for the launch.
     + - The secure launch is then initiated with the GETSET[SENTER] instruction.
    @@ Documentation/security/launch-integrity/secure_launch_overview.rst (new)
     +   and setup tasks.
     + - The SMP bring up code is modified to wake the waiting APs via the monitor
     +   address.
    -+ - APs vector to rmpiggy and start up normally from that point.
    ++ - APs jump to rmpiggy and start up normally from that point.
     + - SL platform module is registered as a late initcall module. It reads
     +   the TPM event log and extends the measurements taken into the TPM PCRs.
     + - SL platform module initializes the securityfs interface to allow
    @@ Documentation/security/launch-integrity/secure_launch_overview.rst (new)
     +PCR Usage
     +=========
     +
    -+The TCG DRTM architecture there are three PCRs defined for usage, PCR.Details
    ++In the TCG DRTM architecture there are three PCRs defined for usage: PCR.Details
     +(PCR17), PCR.Authorities (PCR18), and PCR.DLME_Authority (PCR19). For a deeper
    -+understanding of Detail and Authorities it is recommended to review the TCG
    -+DRTM architecture.
    ++understanding of Details and Authorities, review the TCG DRTM architecture
    ++documentation.
     +
     +To determine PCR usage, Linux Secure Launch follows the TrenchBoot Secure
    -+Launch Specification of using a measurement policy stored in the SLRT. The
    -+policy details what should be measured and the PCR in which to store the
    ++Launch Specification of using a measurement policy stored in the Secure Launch
    ++Resource Table (SLRT), which is defined in the Secure Launch Specification.
    ++This policy details what should be measured and the PCR in which to store the
     +measurement. The measurement policy provides the ability to select the
     +PCR.DLME_Detail (PCR20) PCR as the location for the DRTM components measured by
    -+the kernel, e.g. external initrd image. This can then be combined with storing
    ++the kernel, e.g. external initrd image. This can be combined with storing
     +the user authority in the PCR.DLME_Authority PCR to seal/attest to different
     +variations of platform details/authorities and user details/authorities. An
     +example of how this can be achieved was presented in the FOSDEM - 2021 talk
    @@ Documentation/security/launch-integrity/secure_launch_overview.rst (new)
     +
     +Secure Launch is written to be compliant with the Intel TXT Measured Launch
     +Developer's Guide. The MLE Guide dictates that the system can be configured to
    -+use both the SHA-1 and SHA-2 hashing algorithms. The choice is dictated by what
    ++use both the SHA-1 and SHA-2 hashing algorithms. The choice is dictated by the
     +hash algorithm banks firmware enabled at system start time.
     +
     +Regardless of the preference towards SHA-2, if the firmware elected to start
    @@ Documentation/security/launch-integrity/secure_launch_overview.rst (new)
     +the firmware setup, then TXT and Secure Launch will only use the SHA-2 banks
     +while establishing the launch environment.
     +
    -+Ultimately, the security of an RTM solution is how and what measurements are
    ++Ultimately, the security of a RTM solution relies on how and what measurements are
     +used to assess the health of a system. If SHA-1 measurements are made but not
    -+used, i.e. the attestation enforcement only uses SHA-2, then it has zero impact
    ++used, i.e. the attestation enforcement only uses SHA-2, then it has no impact
     +on the security of the system.
     +
     +Finally, there are older systems with TPM 1.2 chips that only support SHA-1. If
     +the system integrator (whether that be the OEM, employer, distro maintainer,
     +system administrator, or end user) chooses to use older hardware that only has
    -+a TPM 1.2 chip, then they are accepting the risk it creates in their solution.
    ++a TPM 1.2 chip, then they accept the risk it creates in their solution.
     +
     +Resources
     +=========
 2:  d3fe72680064 =  2:  46a88f15fda0 x86: Secure Launch Kconfig
 3:  c9f6c26d2b1e !  3:  ae37bd4578d8 x86: Secure Launch Resource Table header file
    @@ Metadata
      ## Commit message ##
         x86: Secure Launch Resource Table header file
     
    -    Introduce the Secure Launch Resource Table which forms the formal
    -    interface between the pre and post launch code.
    +    The Secure Launch Specification is an architectural agnostic, software neutral
    +    API/ABI maintainted by the TrenchBoot project. It's function is to allow any
    +    compliant boot loader to communicate the pre-launch configuration to any
    +    compliant post-launch kernel. This API/ABI is referred to as the Secure Launch
    +    Resource Table by the specification.
     
         Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
     
    @@ include/linux/slr_table.h (new)
     +/*
     + * TrenchBoot Secure Launch Resource Table
     + *
    -+ * The Secure Launch Resource Table is TrenchBoot project defined
    -+ * specfication to provide cross-architecture compatibility. See
    -+ * TrenchBoot Secure Launch kernel documentation for details.
    ++ * The Secure Launch Resource Table (SLRT) is a TrenchBoot project defined
    ++ * specification to provide a cross-platform interface/ABI between
    ++ * the Secure Launch components. While most of the table is platform
    ++ * agnostic, platform or architecture specific entries can be added.
     + *
    -+ * Copyright (c) 2024 Apertus Solutions, LLC
    -+ * Copyright (c) 2024, Oracle and/or its affiliates.
    ++ * See TrenchBoot Secure Launch kernel documentation for details.
    ++ *
    ++ * Copyright (c) 2025 Apertus Solutions, LLC
    ++ * Copyright (c) 2025, Oracle and/or its affiliates.
     + */
     +
     +#ifndef _LINUX_SLR_TABLE_H
     +#define _LINUX_SLR_TABLE_H
     +
    -+/* Put this in efi.h if it becomes a standard */
    ++/* SLR table GUID for registering as an EFI Configuration Table (put this in efi.h if it becomes a standard) */
     +#define SLR_TABLE_GUID				EFI_GUID(0x877a9b2a, 0x0385, 0x45d1, 0xa0, 0x34, 0x9d, 0xac, 0x9c, 0x9e, 0x56, 0x5f)
     +
     +/* SLR table header values */
    @@ include/linux/slr_table.h (new)
     +	struct slr_uefi_cfg_entry uefi_cfg_entries[];
     +} __packed;
     +
    ++/*
    ++ * The SLRT is laid out as a Tag-Length-Value (TLV) data structure
    ++ * allowing a flexible number of entries in the table. An instance
    ++ * of the slr_table structure is present as a header at the beginning.
    ++ *
    ++ * The following functions help to manipulate the SLRT structure
    ++ * and contents.
    ++ */
    ++
    ++/*
    ++ * Return the address of the end of the SLRT past the final entry.
    ++ */
     +static inline void *slr_end_of_entries(struct slr_table *table)
     +{
     +	return (void *)table + table->size;
     +}
     +
    ++/*
    ++ * Return the next entry in the SLRT given the current entry passed
    ++ * to the function. NULL is returned if there are no entries to return.
    ++ */
     +static inline void *
     +slr_next_entry(struct slr_table *table,
     +	       struct slr_entry_hdr *curr)
    @@ include/linux/slr_table.h (new)
     +	return next;
     +}
     +
    ++/*
    ++ * Return the next entry with the given tag in the SLRT starting at the
    ++ * currenty entry. If entry is NULL, the search begins at the beginning of
    ++ * table.
    ++ */
     +static inline void *
     +slr_next_entry_by_tag(struct slr_table *table,
     +		      struct slr_entry_hdr *entry,
    @@ include/linux/slr_table.h (new)
     +	return NULL;
     +}
     +
    ++/*
    ++ * Add an entry to the SLRT. Entries are placed at the end.
    ++ */
     +static inline int
     +slr_add_entry(struct slr_table *table,
     +	      struct slr_entry_hdr *entry)
    @@ include/linux/slr_table.h (new)
     +	return 0;
     +}
     +
    ++/*
    ++ * Initialize the SLRT for use. This prepares the meta-data in the SLRT
    ++ * header section and the table end marker entry.
    ++ */
     +static inline void
     +slr_init_table(struct slr_table *slrt, u16 architecture, u32 max_size)
     +{
 4:  7d8585845365 !  4:  f4b61a95d4c4 x86: Secure Launch main header file
    @@ Commit message
         Introduce the main Secure Launch header file used in the early SL stub
         and the early setup code.
     
    +    This header file contains the following categories:
    +     - Secure Launch implementation specific structures and definitions.
    +     - Intel TXT architecture specific DRTM structures, definitions and functions
    +    used by Secure Launch.
    +     - DRTM TPM event logging definitions and helper functions.
    +
         Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
     
      ## include/linux/slaunch.h (new) ##
    @@ include/linux/slaunch.h (new)
     +/*
     + * Main Secure Launch header file.
     + *
    -+ * Copyright (c) 2024 Apertus Solutions, LLC
    -+ * Copyright (c) 2024, Oracle and/or its affiliates.
    ++ * Copyright (c) 2025 Apertus Solutions, LLC
    ++ * Copyright (c) 2025, Oracle and/or its affiliates.
     + */
     +
     +#ifndef _LINUX_SLAUNCH_H
    @@ include/linux/slaunch.h (new)
     +/*
     + * TPM event logging functions.
     + */
    ++
    ++/*
    ++ * Find the TPM v2 event log element in the TXT heap. This element contains
    ++ * the information about the size and location of the DRTM event log. Note
    ++ * this is a TXT specific structure.
    ++ *
    ++ * See:
    ++ *   Intel Trusted Execution Technology - Measured Launch Environment Developer's Guide - Appendix C.
    ++ */
     +static inline struct txt_heap_event_log_pointer2_1_element*
     +tpm2_find_log2_1_element(struct txt_os_sinit_data *os_sinit_data)
     +{
    @@ include/linux/slaunch.h (new)
     +	return NULL;
     +}
     +
    ++/*
    ++ * Log a TPM v1 formatted event to the given DRTM event log.
    ++ */
     +static inline int tpm_log_event(void *evtlog_base, u32 evtlog_size,
     +				u32 event_size, void *event)
     +{
    @@ include/linux/slaunch.h (new)
     +	return 0;
     +}
     +
    ++/*
    ++ * Log a TPM v2 formatted event to the given DRTM event log.
    ++ */
     +static inline int tpm2_log_event(struct txt_heap_event_log_pointer2_1_element *elem,
     +				 void *evtlog_base, u32 evtlog_size,
     +				 u32 event_size, void *event)
 5:  1c3e03777864 !  5:  df284dc6df89 x86: Add early SHA-1 support for Secure Launch early measurements
    @@ Commit message
     
         The SHA-1 code here has its origins in the code from the main kernel:
     
    -    commit c4d5b9f ("crypto: sha1 - implement base layer for SHA-1")
    +    commit c4d5b9ffa31f ("crypto: sha1 - implement base layer for SHA-1")
     
         A modified version of this code was introduced to the lib/crypto/sha1.c to bring
         it in line with the SHA-256 code and allow it to be pulled into the setup kernel
    @@ arch/x86/boot/compressed/sha1.c (new)
     @@
     +// SPDX-License-Identifier: GPL-2.0
     +/*
    -+ * Copyright (c) 2024 Apertus Solutions, LLC.
    ++ * Copyright (c) 2025 Apertus Solutions, LLC.
     + */
     +
     +#include "../../../../lib/crypto/sha1.c"
 6:  a0f34a29290d !  6:  4ecaf17a1139 x86: Add early SHA-256 support for Secure Launch early measurements
    @@ arch/x86/boot/compressed/sha256.c (new)
     @@
     +// SPDX-License-Identifier: GPL-2.0
     +/*
    -+ * Copyright (c) 2024 Apertus Solutions, LLC
    ++ * Copyright (c) 2025 Apertus Solutions, LLC
     + */
     +
     +#include "../../../../lib/crypto/sha256.c"
 7:  b6d784c0d28b !  7:  3f47465e56c8 x86/msr: Add variable MTRR base/mask and x2apic ID registers
    @@ Metadata
      ## Commit message ##
         x86/msr: Add variable MTRR base/mask and x2apic ID registers
     
    -    These values are needed by Secure Launch to locate particular CPUs
    -    during AP startup and to restore the MTRR state after a TXT launch.
    +    Add the MSR values required by Secure Launch to locate particular CPU cores
    +    during application processor (AP) startup, and restore the MTRR state after
    +    an Intel TXT launch.
     
         Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
     
 8:  bcad31b804ce !  8:  7778624b27e0 x86/boot: Place TXT MLE header in the kernel_info section
    @@ Metadata
      ## Commit message ##
         x86/boot: Place TXT MLE header in the kernel_info section
     
    -    The MLE (measured launch environment) header must be locatable by the
    -    boot loader and TXT must be setup to do a launch with this header's
    +    The Measured Launch Environment (MLE) header must be locatable by the
    +    boot loader and Intel TXT must be setup to do a launch with this header's
         location. While the offset to the kernel_info structure does not need
         to be at a fixed offset, the offsets in the header must be relative
    -    offsets from the start of the setup kernel. The support in the linker
    -    file achieves this.
    +    offsets from the start of the setup kernel. Note that from the viewpoint
    +    of the prelaunch phase and TXT, the setup kernel image as loaded into
    +    memory is the MLE image.
    +
    +    The changes to the linker file achieve this by making available the
    +    offset values which are updated in the MLE header structure. The following
    +    are the needed offsets from the beginning of the setup kernel image:
    +
    +    - kernel_info_offset: Offset of the main kernel_info structure.
    +    - mle_header_offset: Offset of the MLE header structure.
    +    - sl_stub_entry_offset: Offset of the Secure Launch initial entry point.
    +    - _edata_offset: Offset of the _edata label used as the end of the MLE image.
     
         Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
         Suggested-by: Ard Biesheuvel <ardb@kernel.org>
    @@ arch/x86/boot/compressed/kernel_info.S: kernel_info:
     +	 * bit 9: Supported format of TPM 2.0 event log - TCG compliant
     +	 */
     +SYM_DATA_START(mle_header)
    -+	.long	0x9082ac5a  /* UUID0 */
    -+	.long	0x74a7476f  /* UUID1 */
    -+	.long	0xa2555c0f  /* UUID2 */
    -+	.long	0x42b651cb  /* UUID3 */
    -+	.long	0x00000034  /* MLE header size */
    -+	.long	0x00020002  /* MLE version 2.2 */
    -+	.long	roffset(sl_stub_entry_offset) /* Linear entry point of MLE (virt. address) */
    -+	.long	0x00000000  /* First valid page of MLE */
    -+	.long	0x00000000  /* Offset within binary of first byte of MLE */
    -+	.long	roffset(_edata_offset) /* Offset within binary of last byte + 1 of MLE */
    -+	.long	0x00000227  /* Bit vector of MLE-supported capabilities */
    -+	.long	0x00000000  /* Starting linear address of command line (unused) */
    -+	.long	0x00000000  /* Ending linear address of command line (unused) */
    ++	.long	0x9082ac5a			/* UUID0 */
    ++	.long	0x74a7476f			/* UUID1 */
    ++	.long	0xa2555c0f			/* UUID2 */
    ++	.long	0x42b651cb			/* UUID3 */
    ++	.long	0x00000034			/* MLE header size */
    ++	.long	0x00020002			/* MLE version 2.2 */
    ++	.long	roffset(sl_stub_entry_offset)	/* Linear entry point of MLE (virt. address) */
    ++	.long	0x00000000			/* First valid page of MLE */
    ++	.long	0x00000000			/* Offset within binary of first byte of MLE */
    ++	.long	roffset(_edata_offset)		/* Offset within binary of last byte + 1 of MLE */
    ++	.long	0x00000227			/* Bit vector of MLE-supported capabilities */
    ++	.long	0x00000000			/* Starting linear address of command line (unused) */
    ++	.long	0x00000000			/* Ending linear address of command line (unused) */
     +SYM_DATA_END(mle_header)
     +#endif
     
 9:  506bb834e7bd !  9:  1b64a89e4e92 x86: Secure Launch kernel early boot stub
    @@ Metadata
      ## Commit message ##
         x86: Secure Launch kernel early boot stub
     
    -    The Secure Launch (SL) stub provides the entry point for Intel TXT (and
    -    later AMD SKINIT) to vector to during the late launch. The symbol
    -    sl_stub_entry is that entry point and its offset into the kernel is
    -    conveyed to the launching code using the MLE (Measured Launch
    -    Environment) header in the structure named mle_header. The offset of the
    -    MLE header is set in the kernel_info. The routine sl_stub contains the
    -    very early late launch setup code responsible for setting up the basic
    -    environment to allow the normal kernel startup_32 code to proceed. It is
    -    also responsible for properly waking and handling the APs on Intel
    -    platforms. The routine sl_main which runs after entering 64b mode is
    -    responsible for measuring configuration and module information before
    -    it is used like the boot params, the kernel command line, the TXT heap,
    -    an external initramfs, etc.
    +    The Secure Launch (SL) stub provides the entry point for Intel TXT to
    +    jump to during the dynamic launch. The symbol sl_stub_entry is that entry
    +    point and its offset into the kernel is conveyed to the launching code using
    +    the Measured Launch Environment (MLE) header in the structure named mle_header.
    +    The offset of the MLE header is set in the kernel_info.
    +
    +    The routine sl_stub contains the very early dynamic launch setup code
    +    responsible for setting up the basic operating environment to allow the normal
    +    kernel startup_32 code to proceed. It is also responsible for properly waking
    +    and handling the APs on Intel platforms.
    +
    +    The routine sl_main which runs after entering 64b mode in the setup kernel. It
    +    is responsible for measuring configuration and module information before
    +    it is used. An example of entities measured on Intel x86 are the boot params,
    +    the kernel command line, the TXT heap, any external initramfs, etc. In addition
    +    this routine does some early setup and validation of the environment like
    +    locating the TPM event log and validating the location of various buffers to
    +    ensure they are protected and not overlapping.
     
         Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
     
    @@ Documentation/arch/x86/boot.rst: Protocol:	2.00+
     +  Bit 2 (kernel internal): SLAUNCH_FLAG
     +
     +	- Used internally by the setup kernel to communicate
    -+	  Secure Launch status to kernel proper.
    ++	  Secure Launch status to the kernel proper.
     +
     +	    - If 1, Secure Launch enabled.
     +	    - If 0, Secure Launch disabled.
    @@ Documentation/arch/x86/boot.rst: Offset/size:	0x000c/4
     +  https://www.intel.com/content/dam/www/public/us/en/documents/guides/intel-txt-software-development-guide.pdf
     +
      
    - The Image Checksum
    - ==================
    + The Kernel Command Line
    + =======================
     
      ## arch/x86/boot/compressed/Makefile ##
     @@ arch/x86/boot/compressed/Makefile: vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
    @@ arch/x86/boot/compressed/sl_main.c (new)
     +/*
     + * Secure Launch early measurement and validation routines.
     + *
    -+ * Copyright (c) 2024, Oracle and/or its affiliates.
    ++ * Copyright (c) 2025, Oracle and/or its affiliates.
     + */
     +
     +#include <linux/init.h>
    @@ arch/x86/boot/compressed/sl_stub.S (new)
     +/*
     + * Secure Launch protected mode entry point.
     + *
    -+ * Copyright (c) 2024, Oracle and/or its affiliates.
    ++ * Copyright (c) 2025, Oracle and/or its affiliates.
     + */
     +	.code32
     +	.text
    @@ arch/x86/boot/compressed/sl_stub.S (new)
     +	incl	rva(sl_txt_cpu_count)(%ebx)
     +
     +	/*
    -+	 * Enable SMI with GETSEC[SMCTRL] which were disabled by SENTER.
    ++	 * On the BSP, enable SMI with GETSEC[SMCTRL] which were disabled by SENTER.
     +	 * NMIs were also disabled by SENTER. Since there is no IDT for the BSP,
    -+	 * allow the mainline kernel re-enable them in the normal course of
    ++	 * allow the mainline kernel to re-enable them in the normal course of
     +	 * booting.
     +	 */
     +	GETSEC	$(SMX_X86_GETSEC_SMCTRL)
10:  adf97523eef7 ! 10:  76521086be4d x86: Secure Launch kernel late boot stub
    @@ Metadata
      ## Commit message ##
         x86: Secure Launch kernel late boot stub
     
    -    The routine slaunch_setup is called out of the x86 specific setup_arch()
    +    The routine slaunch_setup() is called out of the x86 specific setup_arch()
         routine during early kernel boot. After determining what platform is
         present, various operations specific to that platform occur. This
         includes finalizing setting for the platform late launch and verifying
    @@ Commit message
         See the Intel Trusted Execution Technology - Measured Launch Environment
         Developer's Guide for more details.
     
    -    For TXT, this code also reserves the original compressed kernel setup
    -    area where the APs were left looping so that this memory cannot be used.
    +    In addition this routine reserves key memory regions used by Secure Launch
    +    (e.g. the TXT heap, AP startup block etc) as well as fetching values needed
    +    later from the TXT heap and SLRT.
     
         Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
     
    @@ arch/x86/kernel/slaunch.c (new)
     +/*
     + * Secure Launch late validation/setup and finalization support.
     + *
    -+ * Copyright (c) 2024, Oracle and/or its affiliates.
    ++ * Copyright (c) 2025, Oracle and/or its affiliates.
     + */
     +
     +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
11:  00625a3db74f = 11:  ddcd40c272cf x86: Secure Launch SMP bringup support
12:  f3b926ea6881 = 12:  dd0cbb3a2beb kexec: Secure Launch kexec SEXIT support
13:  309f73b37d82 = 13:  132c9b109460 x86/reboot: Secure Launch SEXIT support on reboot paths
14:  59dd2c48d085 ! 14:  1597c2f5a685 tpm, tpm_tis: Close all localities
    @@ drivers/char/tpm/tpm_tis_core.c: int tpm_tis_core_init(struct device *dev, struc
      	}
      
     +	/*
    -+	 * There are environments, for example, those that comply with the TCG D-RTM
    -+	 * specification that requires the TPM to be left in Locality 2.
    ++	 * In order to comply with the TCG D-RTM specification, relinquish all
    ++	 * the localities.
     +	 */
     +	for (i = 0; i <= TPM_MAX_LOCALITY; i++) {
     +		if (check_locality(chip, i))
15:  fd1eaa6970ce ! 15:  8b293cda5c6a tpm, tpm_tis: Address positive localities in tpm_tis_request_locality()
    @@ drivers/char/tpm/tpm_tis_core.c: static int tpm_tis_request_locality(struct tpm_
      	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
      	int ret = 0;
      
    -+	if (l < 0 || l > TPM_MAX_LOCALITY)
    ++	if (l < 0 || l > TPM_MAX_LOCALITY) {
    ++		dev_warn(&chip->dev, "%s: failed to request unknown locality: %d\n",
    ++			 __func__, l);
     +		return -EINVAL;
    ++	}
     +
      	mutex_lock(&priv->locality_count_mutex);
      	if (priv->locality_count == 0)
16:  ed163188e807 = 16:  3412ebf14614 tpm, tpm_tis: Allow locality to be set to a different value
17:  563c8f0ceac5 = 17:  84592ef2de33 tpm, sysfs: Show locality used by kernel
18:  341cb25e4cd0 ! 18:  942d40ea22f5 x86: Secure Launch late initcall platform module
    @@ arch/x86/kernel/slmodule.c (new)
     +/*
     + * Secure Launch late validation/setup, securityfs exposure and finalization.
     + *
    -+ * Copyright (c) 2024 Apertus Solutions, LLC
    -+ * Copyright (c) 2024 Assured Information Security, Inc.
    -+ * Copyright (c) 2024, Oracle and/or its affiliates.
    ++ * Copyright (c) 2025 Apertus Solutions, LLC
    ++ * Copyright (c) 2025 Assured Information Security, Inc.
    ++ * Copyright (c) 2025, Oracle and/or its affiliates.
     + */
     +
     +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
19:  78ad72b83303 = 19:  fe557361a387 x86/efi: EFI stub DRTM launch support for Secure Launch

-- 
2.39.3


