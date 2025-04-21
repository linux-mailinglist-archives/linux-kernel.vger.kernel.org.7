Return-Path: <linux-kernel+bounces-612800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B768A9542C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Apr 2025 18:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AB593AA160
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Apr 2025 16:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137641D5CF2;
	Mon, 21 Apr 2025 16:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T3IbXnW/"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34201A83EE;
	Mon, 21 Apr 2025 16:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745253275; cv=none; b=Xo0kjkWbRNRFQKLWaX16F01Rdzzbjctbut3sZcyWzyec3WqKtB3iHmaG4f/wXnZMG5KetIP1eN9M1FRFUYVhA1f0N4oMQGtH61bq68KVQSfr4T/HPE4Q6I/na3jI9HYIfbraIyzF1Spu04XwEEC3ZYPeGKrOE0iYoxj2Bw4xXNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745253275; c=relaxed/simple;
	bh=6ZY8QNsfSHuyAdYAYZGwgSaOAnH3lbf+vbYh4zxhqDg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pR72T9dZDLbMw5G8HB/SNAITSmO3zEQ9Otlj/hxtj1nO3eaZ9vTJ984ljaJUCKABYY0z/5vZ5RpEOLqTdt7kuibTxBKamHnfekRwDWy+3KfN4YNK1FJdLlwQPZBExkiH6Y7k7fvCvANZgGH3QaeJ9kgPRoalW4r6QoJeGcr9EKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T3IbXnW/; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53LCApuK015875;
	Mon, 21 Apr 2025 16:33:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=tr5vgmqBr6uOAu+0KH/TYHs2IQFHM
	r1xWH1rQvYpr9Q=; b=T3IbXnW/54ayeQK18Gu4LgqR5fzRiw6r8KJ8mkEm40thF
	erjmvGNC84YiFVscwmbHCvPaVbdOcuKspr/jVSP6UvU9lnG4+uipGF81Hma7GWGy
	o/7JG0nSK6DKdzKJGJ9cIFDy2lV00MNMAOpZAYXWpcOG+OhIS0aMjGU8C6/hfwFt
	vlEn1nI82aIkRyKI731aW46k2TXwAGbIiPbY1QzDCEiDYhEXjevwoc34hVZ4pPjA
	Jq7+R2jmaIjsu3/6Nsvfbs8myoFGSA+2YsXPuH0WomFAFfT9C5rBoBepTZ/eG8Mo
	+6pW6DoO6s5BsBzXj6ajHpb5UUNtfUl16fkWB1cOQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4642e0av5q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Apr 2025 16:33:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53LGFB9K003067;
	Mon, 21 Apr 2025 16:33:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 464298816s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 21 Apr 2025 16:33:41 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 53LGXe5c029515;
	Mon, 21 Apr 2025 16:33:40 GMT
Received: from bur-virt-x6-2-100.us.oracle.com (bur-virt-x6-2-100.us.oracle.com [10.153.92.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 464298813n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 21 Apr 2025 16:33:40 +0000
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
Subject: [PATCH v14 00/19] x86: Trenchboot secure dynamic launch Linux kernel support
Date: Mon, 21 Apr 2025 09:26:53 -0700
Message-Id: <20250421162712.77452-1-ross.philipson@oracle.com>
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
 definitions=2025-04-21_08,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504210129
X-Proofpoint-GUID: 90G2TTQzzPdIdzgHMRFjr9l2l69mXB34
X-Proofpoint-ORIG-GUID: 90G2TTQzzPdIdzgHMRFjr9l2l69mXB34

Quick intro, this is a summary of what is already reviewed in the patch
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

torvalds/master/7e74f756f5f643148ca5537bf2fee6767e4b0ed9

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

Changes in v14:
 - Fix issue found in monitor/mwait loop used to park the APs until
   they are started by the mainline kernel.
 - Fix spelling and grammar issues found in documentation and comments.
 - Fix some minor formatting issues.

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
 arch/x86/boot/compressed/sl_stub.S            | 731 ++++++++++++++++++
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
 drivers/char/tpm/tpm-chip.c                   |  34 +-
 drivers/char/tpm/tpm-sysfs.c                  |  10 +
 drivers/char/tpm/tpm_tis_core.c               |  21 +-
 drivers/firmware/efi/libstub/efistub.h        |   8 +
 drivers/firmware/efi/libstub/x86-stub.c       |  94 +++
 drivers/iommu/intel/dmar.c                    |   4 +
 include/crypto/sha1.h                         |   1 +
 include/linux/slaunch.h                       | 559 ++++++++++++++
 include/linux/slr_table.h                     | 308 ++++++++
 include/linux/tpm.h                           |  10 +
 kernel/kexec_core.c                           |   4 +
 lib/crypto/sha1.c                             |  81 ++
 40 files changed, 4962 insertions(+), 9 deletions(-)
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

Range-diff v13 -> v14:
-----------------------------------------------

 1:  06e0394c0802 !  1:  6fd07ad107c4 Documentation/x86: Secure Launch kernel documentation
    @@ Documentation/security/launch-integrity/principles.rst (new)
     +
     +There is a tendency to consider the classical power-on boot as the only means to
     +launch an Operating System (OS) on a computer. In fact, driven by the
    -+Trusted Computing Group (TCG) architecture, modern processors are able to support
    ++Trusted Computing Group (TCG) architecture, modern processors can support
     +two methods of system launch: Static Launch and Dynamic Launch.
     +
     +Static Launch
    @@ Documentation/security/launch-integrity/principles.rst (new)
     +(DLE). The DLE functions by accepting a software payload, referred
     +to as the Dynamic Configuration Environment (DCE), that execution is handed to
     +after the DLE is invoked. The DCE is responsible for bringing the system back
    -+to a running state. Since the dynamic launch is not tied to a power event like the
    -+static launch is, this enables a dynamic launch to be initiated at any time
    ++to a running state. Since the dynamic launch is not tied to a power event like
    ++static launch, this enables a dynamic launch to be initiated at any time
     +and multiple times during a single power life cycle. This dynamism is the
     +reasoning behind referring to this system launch as "dynamic".
     +
    @@ Documentation/security/launch-integrity/principles.rst (new)
     +integrity, takes an action to assess an entity being loaded into memory before
     +it is used. A variety of mechanisms may be used to conduct the assessment, each
     +with different properties. A particular property is whether the mechanism creates
    -+an evidence of the assessment. Often either cryptographic signature checking or
    ++evidence of the assessment. Often either cryptographic signature checking or
     +hashing are the common assessment operations used.
     +
     +A signature checking assessment functions by requiring a representation of the
    @@ Documentation/security/launch-integrity/principles.rst (new)
     +i.e. RoT for Verification (RTV) and RoT for Measurement (RTM).
     +
     +A trust chain is itself a mechanism, specifically a mechanism of mechanisms,
    -+and therefore it also has a Strength of Mechanism. The factors that contribute
    ++and therefore, it also has a Strength of Mechanism. The factors that contribute
     +to the strength of a trust chain are:
     +
     +  - The strength of the chain's RoT
    @@ Documentation/security/launch-integrity/principles.rst (new)
     +    documentation, Dynamic Root of Trust for Measurement was abbreviated as DRTM.
     +    When Dynamic Launch was codified in the TCG specification, it was given
     +    the acronym D-RTM. There is a similar situation with Static Root of Trust for
    -+    Measuremnt. In TCG documentation it will be given the acronym S-RTM but it is not
    ++    Measurement. In TCG documentation it will be given the acronym S-RTM but it is not
     +    uncommon to see it as SRTM. For the purposes of the launch integrity documents,
     +    DRTM and SRTM will be the preferred acronym.
     +
    @@ Documentation/security/launch-integrity/principles.rst (new)
     +    functions. In this case, the process can be iterated. The second group of
     +    functions can give a trustworthy description of the third group of
     +    functions, etc. Transitive trust is used to provide a trustworthy
    -+    description of platform characteristics, and also to prove that
    -+    non-migratable keys are in fact non-migratable.
    ++    description of platform characteristics and to prove that non-migratable
    ++    keys are in fact non-migratable.
     +
     +    - TCG Glossary - https://trustedcomputinggroup.org/wp-content/uploads/TCG-Glossary-V1.1-Rev-1.0.pdf
     +
    @@ Documentation/security/launch-integrity/secure_launch_details.rst (new)
     +-------------------
     +
     +Due to Secure Launch hardware implementation details and how KASLR functions,
    -+Secure Launch is not able to interoperate with KASLR at this time. Attempts to
    ++Secure Launch is not able to interoperate with KASLR currently. Attempts to
     +enable KASLR in a kernel started using Secure Launch may result in crashes and
     +other instabilities at boot. Even in cases where Secure Launch and KASLR work
     +together, it is still recommended that KASLR be disabled to avoid introducing
    @@ Documentation/security/launch-integrity/secure_launch_details.rst (new)
     +loaded. However, IOMMU passthrough mode should never be used. This leaves the
     +MLE completely exposed to DMA after the PMRs [2]_ are disabled. The current
     +default mode is to use IOMMU in lazy translated mode, but strict translated
    -+mode is the preferred IOMMU mode and this should be selected in the build
    ++mode, is the preferred IOMMU mode and this should be selected in the build
     +configuration::
     +
     +  "Device Drivers" -->
    @@ Documentation/security/launch-integrity/secure_launch_details.rst (new)
     +Description:
     +
     +During early Secure Launch validation, an invalid variable MTRR count was
    -+found. The pre-launch environment passes a number of MSR values to the MLE to
    ++found. The pre-launch environment passes several MSR values to the MLE to
     +restore including the MTRRs. The values are restored by the Secure Launch early
     +entry point code. After measuring the values supplied by the pre-launch
     +environment, a discrepancy was found, validating the values. It could be the
    @@ Documentation/security/launch-integrity/secure_launch_details.rst (new)
     +
     +Description:
     +
    -+A memory region used by the MLE is above 4Gb. In general this is not a problem
    ++A memory region used by the MLE is above 4Gb. In general, this is not a problem
     +because memory > 4Gb can be protected from DMA. There are certain buffers that
     +should never be above 4Gb, and one of these caused the violation. This is most
     +likely a configuration issue in the pre-launch environment. It could also be
    @@ Documentation/security/launch-integrity/secure_launch_details.rst (new)
     +
     +Description:
     +
    -+The backup copy of the ACPI DMAR table which is supposed to be located in the
    -+TXT heap could not be found. This is due to a bug in the platform's ACM module
    ++The backup copy of the ACPI DMAR table, which is expected to be in the
    ++TXT heap, could not be found. This is due to a bug in the platform's ACM module
     +or in firmware.
     +
     +======  =======================
    @@ Documentation/security/launch-integrity/secure_launch_details.rst (new)
     +
     +Description:
     +
    -+The backup copy of the ACPI DMAR table in the TXT heap is to large to be stored
    ++The backup copy of the ACPI DMAR table in the TXT heap is too large to be stored
     +for later usage. This error is very unlikely to occur since the area reserved
     +for the copy is far larger than the DMAR should be.
     +
    @@ Documentation/security/launch-integrity/secure_launch_details.rst (new)
     +Description:
     +
     +The external initrd provided is larger than 4Gb. This is not a valid
    -+configuration for a Secure Launch due to managing DMA protection.
    ++configuration for Secure Launch due to managing DMA protection.
     +
     +======  =========================
     +Name:   SL_ERROR_HEAP_ZERO_OFFSET
    @@ Documentation/security/launch-integrity/secure_launch_overview.rst (new)
     +=====
     +
     +The first use case that the TrenchBoot project focused on was the ability for
    -+the Linux kernel to be started by a dynamic launch, in particular as part of an
    -+early launch sequence. In this case, the dynamic launch will be initiated by
    ++the Linux kernel to be started by a dynamic launch as part of an early
    ++launch sequence. In this case, the dynamic launch will be initiated by
     +any bootloader with associated support added to it. The first targeted bootloader
     +in this case was GRUB2. An integral part of establishing a measurement-based
     +launch integrity involves measuring everything that is intended to be executed
    @@ Documentation/security/launch-integrity/secure_launch_overview.rst (new)
     +Design Decisions
     +================
     +
    -+A number of design decisions were made during the development of the Secure
    ++Several design decisions were made during the development of the Secure
     +Launch feature. The two primary guiding decisions were:
     +
     + - Keeping the Secure Launch code as separate from the rest of the kernel
    @@ Documentation/security/launch-integrity/secure_launch_overview.rst (new)
     +
     +Outlined here is a summary of the boot flow for Secure Launch. A more detailed
     +review of the Secure Launch process can be found in the Secure Launch
    -+Specification (a link is located in the `Resources`_ section).
    ++Specification (a link is in the `Resources`_ section).
     +
     +Pre-launch: *Phase where the environment is prepared and configured to initiate
     +the secure launch by the boot chain.*
     +
    -+ - The SLRT is initialized and dl_stub is placed in memory.
    ++ - The SLRT is initialized, and dl_stub is placed in memory.
     + - Load the kernel, initrd and ACM [2]_ into memory.
     + - Set up the TXT heap and page tables describing the MLE [1]_ per the
     +   specification.
    @@ Documentation/security/launch-integrity/secure_launch_overview.rst (new)
     + - Entry from the dynamic launch jumps to the SL stub.
     + - SL stub fixes up the world on the BSP.
     + - For TXT, SL stub wakes the APs, fixes up their worlds.
    -+ - For TXT, APs are left halted using MONITOR/MWAIT intructions.
    ++ - For TXT, APs are left in an optimized (MONITOR/MWAIT) wait state.
     + - SL stub jumps to startup_32.
     + - SL main does validation of buffers and memory locations. It sets
     +   the boot parameter loadflag value SLAUNCH_FLAG to inform the main
    @@ Documentation/security/launch-integrity/secure_launch_overview.rst (new)
     +the firmware setup, then TXT and Secure Launch will only use the SHA-2 banks
     +while establishing the launch environment.
     +
    -+Ultimately, the security of a RTM solution relies on how and what measurements are
    ++Ultimately, the security of an RTM solution relies on how and what measurements are
     +used to assess the health of a system. If SHA-1 measurements are made but not
     +used, i.e. the attestation enforcement only uses SHA-2, then it has no impact
     +on the security of the system.
 2:  46a88f15fda0 =  2:  1c7e32213383 x86: Secure Launch Kconfig
 3:  ae37bd4578d8 =  3:  401ab594d42a x86: Secure Launch Resource Table header file
 4:  f4b61a95d4c4 !  4:  5d13ccbac1b6 x86: Secure Launch main header file
    @@ include/linux/slaunch.h (new)
     +		((u8 *)os_sinit_data + sizeof(struct txt_os_sinit_data));
     +
     +	while (ext_elem->type != TXT_HEAP_EXTDATA_TYPE_END) {
    -+		if (ext_elem->type ==
    -+		    TXT_HEAP_EXTDATA_TYPE_EVENT_LOG_POINTER2_1) {
    ++		if (ext_elem->type == TXT_HEAP_EXTDATA_TYPE_EVENT_LOG_POINTER2_1) {
     +			return (struct txt_heap_event_log_pointer2_1_element *)
    -+				((u8 *)ext_elem +
    -+					sizeof(struct txt_heap_ext_data_element));
    ++				((u8 *)ext_elem + sizeof(struct txt_heap_ext_data_element));
     +		}
    -+		ext_elem =
    -+			(struct txt_heap_ext_data_element *)
    -+			((u8 *)ext_elem + ext_elem->size);
    ++		ext_elem = (struct txt_heap_ext_data_element *)
    ++			    ((u8 *)ext_elem + ext_elem->size);
     +	}
     +
     +	return NULL;
    @@ include/linux/slaunch.h (new)
     +}
     +
     +/*
    -+ * External functions avalailable in mainline kernel.
    ++ * External functions available in mainline kernel.
     + */
     +void slaunch_setup_txt(void);
     +void slaunch_fixup_jump_vector(void);
    @@ include/linux/slaunch.h (new)
     +
     +static inline bool slaunch_is_txt_launch(void)
     +{
    -+	u32 mask =  SL_FLAG_ACTIVE | SL_FLAG_ARCH_TXT;
    ++	u32 mask = SL_FLAG_ACTIVE | SL_FLAG_ARCH_TXT;
     +
     +	return (slaunch_get_flags() & mask) == mask;
     +}
 5:  df284dc6df89 !  5:  c392cd875d53 x86: Add early SHA-1 support for Secure Launch early measurements
    @@ Commit message
         Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
     
      ## arch/x86/boot/compressed/Makefile ##
    -@@ arch/x86/boot/compressed/Makefile: vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
    - vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_mixed.o
    +@@ arch/x86/boot/compressed/Makefile: vmlinux-objs-$(CONFIG_UNACCEPTED_MEMORY) += $(obj)/mem.o
    + vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
      vmlinux-libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
      
     +vmlinux-objs-$(CONFIG_SECURE_LAUNCH) += $(obj)/sha1.o
 6:  4ecaf17a1139 !  6:  b28a1c1eb3a8 x86: Add early SHA-256 support for Secure Launch early measurements
    @@ Commit message
         Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
     
      ## arch/x86/boot/compressed/Makefile ##
    -@@ arch/x86/boot/compressed/Makefile: vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
    - vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_mixed.o
    +@@ arch/x86/boot/compressed/Makefile: vmlinux-objs-$(CONFIG_UNACCEPTED_MEMORY) += $(obj)/mem.o
    + vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
      vmlinux-libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
      
     -vmlinux-objs-$(CONFIG_SECURE_LAUNCH) += $(obj)/sha1.o
 7:  3f47465e56c8 =  7:  f69e9cf10b45 x86/msr: Add variable MTRR base/mask and x2apic ID registers
 8:  7778624b27e0 =  8:  1c057ac85fde x86/boot: Place TXT MLE header in the kernel_info section
 9:  1b64a89e4e92 !  9:  422d73884aaf x86: Secure Launch kernel early boot stub
    @@ Documentation/arch/x86/boot.rst: Offset/size:	0x000c/4
      =======================
     
      ## arch/x86/boot/compressed/Makefile ##
    -@@ arch/x86/boot/compressed/Makefile: vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
    - vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_mixed.o
    +@@ arch/x86/boot/compressed/Makefile: vmlinux-objs-$(CONFIG_UNACCEPTED_MEMORY) += $(obj)/mem.o
    + vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
      vmlinux-libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
      
     -vmlinux-objs-$(CONFIG_SECURE_LAUNCH) += $(obj)/sha1.o $(obj)/sha256.o
    @@ arch/x86/boot/compressed/sl_stub.S (new)
     +	 * after mwait returns. Currently %esp points to just past the pushed APIC
     +	 * ID value.
     +	 */
    -+	movl	%esp, %eax
    -+	subl	$(TXT_BOOT_STACK_SIZE - 4), %eax
    -+	movl	$0, (%eax)
    ++	movl	%esp, %edi
    ++	subl	$(TXT_BOOT_STACK_SIZE - 4), %edi
    ++	movl	$0, (%edi)
     +
    -+	/* Clear ecx/edx so no invalid extensions or hints are passed to monitor */
    ++1:
    ++	/* Load eax and clear ecx/edx so no invalid extensions or hints are passed to monitor */
    ++	movl	%edi, %eax
     +	xorl	%ecx, %ecx
     +	xorl	%edx, %edx
     +
     +	/*
    -+	 * Arm the monitor and wait for it to be poked by he SMP bringup code. The mwait
    ++	 * Arm the monitor and wait for it to be triggered by the SMP bringup code. The mwait
     +	 * instruction can return for a number of reasons. Test to see if it returned
     +	 * because the monitor was written to.
     +	 */
     +	monitor
     +
    -+1:
    -+	mfence
    ++	cmpl	$0, (%eax)
    ++	jnz	2f
    ++
    ++	/* Clear eax since there are no hints sent to mwait */
    ++	xorl	%eax, %eax
    ++
     +	mwait
    -+	movl	(%eax), %edx
    -+	testl	%edx, %edx
    -+	jz	1b
    ++	jmp	1b
     +
    ++2:
     +	/*
     +	 * This is the long absolute jump to the 32b Secure Launch protected mode stub
     +	 * code in sl_trampoline_start32() in the rmpiggy. The jump address will be
10:  76521086be4d = 10:  9191a4d8f4df x86: Secure Launch kernel late boot stub
11:  ddcd40c272cf = 11:  30a06e627874 x86: Secure Launch SMP bringup support
12:  dd0cbb3a2beb = 12:  9efb6f323e72 kexec: Secure Launch kexec SEXIT support
13:  132c9b109460 = 13:  0b8a7ec5615a x86/reboot: Secure Launch SEXIT support on reboot paths
14:  1597c2f5a685 = 14:  33dad604b418 tpm, tpm_tis: Close all localities
15:  8b293cda5c6a = 15:  366a92941dc5 tpm, tpm_tis: Address positive localities in tpm_tis_request_locality()
16:  3412ebf14614 ! 16:  01b015d06fea tpm, tpm_tis: Allow locality to be set to a different value
    @@ drivers/char/tpm/tpm-chip.c: void tpm_chip_unregister(struct tpm_chip *chip)
     +	chip->kernel_locality = locality;
     +	chip->flags &= ~TPM_CHIP_FLAG_SET_LOCALITY_ENABLED;
     +	tpm_put_ops(chip);
    ++
     +	return 0;
     +}
     +EXPORT_SYMBOL_GPL(tpm_chip_set_locality);
17:  84592ef2de33 = 17:  018713a8afb7 tpm, sysfs: Show locality used by kernel
18:  942d40ea22f5 = 18:  5a9faa5c6e82 x86: Secure Launch late initcall platform module
19:  fe557361a387 ! 19:  616c6ae2fa0b x86/efi: EFI stub DRTM launch support for Secure Launch
    @@ drivers/firmware/efi/libstub/x86-stub.c
      
      #include <asm/efi.h>
      #include <asm/e820/types.h>
    -@@ drivers/firmware/efi/libstub/x86-stub.c: static efi_status_t efi_decompress_kernel(unsigned long *kernel_entry)
    +@@ drivers/firmware/efi/libstub/x86-stub.c: static efi_status_t efi_decompress_kernel(unsigned long *kernel_entry,
      	return efi_adjust_memory_range_protection(addr, kernel_text_size);
      }
      
-- 
2.39.3


