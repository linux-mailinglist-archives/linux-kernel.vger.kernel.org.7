Return-Path: <linux-kernel+bounces-838362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CC6BAF07A
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 04:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05D831942BB7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 02:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E17C27B331;
	Wed,  1 Oct 2025 02:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L9clbC1w"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B7535940
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 02:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759287291; cv=none; b=ddlBhxPILC7XWNNm74BbaEnU+VcynxLqNBmcmnhqcV1+eHWVpwOyNPLh2hH5fQycBgZKI14AmqgV3CqiTWupgeagvoAQqQK8ZRlN94XiyhfmezwsnJznGRdXb1P24inE0Pk14k3A0drPUxFxTDorW7FOLBineWBHGsFzQMhGxNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759287291; c=relaxed/simple;
	bh=ZXvNacePo2uhV3YhgeRSCE5SzX4uGN2BkfO6/jA8LE0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JJyfDqKDcbTGm0B7KkBQuJWTwn0X32yvupurDrouxMXSCQ7UR+D3vWq7zA9Z5kC/AUue1M8869HZke0mfsBrYHMjPNGcmX09G/XGleULjbKtteCUqLEjWHC/PgW0j468SzN9MzzE3XvalqcZ5huiCWQ+mRIQA/tj+A70CMfyYp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L9clbC1w; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759287289; x=1790823289;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZXvNacePo2uhV3YhgeRSCE5SzX4uGN2BkfO6/jA8LE0=;
  b=L9clbC1wPWjr31aLkw5yufeCwBLn3V9f8Wi+rPUyqW7Y9Qm7CCbPd268
   ac7WIF6pmUUcfu1zo2V64Hi7IbPz3Zu6SayNjs784rZ75+vS7pk1AvhLc
   1DiRk8Rv6XYxj9WQU/J5UIAVvo6sut6l2l/PvePRUlCP+U+0zdo9ImKZ/
   0Ti2enC2bIDOJ9C4O3u2/0q4WBYKo91KhLqJaVUsCSE11EocVkzgLqOvf
   eaTMSenW6debAyZlviArnUOuN8ZzmjM7nSnHi7tM0gJeGmqjvlIEiSgbr
   9IrqMB8LAjmivS9fgHZyFX4Ckqx3PZaqVx6IeYtfsTnK8Oop8IzO3ei6a
   A==;
X-CSE-ConnectionGUID: s8nNzfnmS2eod22Sj2d3gA==
X-CSE-MsgGUID: ogeKfHSQRB64zIqmYp4mvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="61662192"
X-IronPort-AV: E=Sophos;i="6.18,305,1751266800"; 
   d="scan'208";a="61662192"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 19:54:49 -0700
X-CSE-ConnectionGUID: UBsv2qKcQX+PhX7DygZBIA==
X-CSE-MsgGUID: aLkBtbgwR5yOjOxFA/qZ+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,305,1751266800"; 
   d="scan'208";a="178629018"
Received: from 984fee019967.jf.intel.com ([10.165.54.94])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 19:54:48 -0700
From: Chao Gao <chao.gao@intel.com>
To: linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	reinette.chatre@intel.com,
	ira.weiny@intel.com,
	kai.huang@intel.com,
	dan.j.williams@intel.com,
	yilun.xu@linux.intel.com,
	sagis@google.com,
	vannapurve@google.com,
	paulmck@kernel.org,
	nik.borisov@suse.com
Cc: Chao Gao <chao.gao@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	"Kirill A. Shutemov" <kas@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 00/21] Runtime TDX Module update support
Date: Tue, 30 Sep 2025 19:52:44 -0700
Message-ID: <20251001025442.427697-1-chao.gao@intel.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changelog:
v1->v2:
 - Replace tdx subsystem with a "tdx-host" device implementation
 - Reorder patches to reduce reviewer's mental "list of things to look out for"
 - Replace "TD-Preserving update" with "runtime TDX Module Update"
 - Drop the temporary "td_preserving_ready" flag
 - Move low-level SEAMCALL helpers to its own header file
 - Don't create a new, inferior framework to save/restore VMCS
 - Minor cleanups and changelog improvements for clarity and consistency
 - Collect review tags
 - I didn't add Sagi Shahar's Tested-by due to various changes/reorder etc.
 - v1: https://lore.kernel.org/kvm/20250523095322.88774-1-chao.gao@intel.com/

Hi Reviewers,

This series adds support for runtime TDX Module updates that preserve
running TDX guests.

== Background ==

Intel TDX isolates Trusted Domains (TDs), or confidential guests, from the
host. A key component of Intel TDX is the TDX Module, which enforces
security policies to protect the memory and CPU states of TDs from the
host. However, the TDX Module is software that require updates.

== Problems ==

Currently, the TDX Module is loaded by the BIOS at boot time, and the only
way to update it is through a reboot, which results in significant system
downtime. Users expect the TDX Module to be updatable at runtime without
disrupting TDX guests.

== Solution ==

On TDX platforms, P-SEAMLDR[1] is a component within the protected SEAM
range. It is loaded by the BIOS and provides the host with functions to
install a TDX Module at runtime.

Implement a TDX Module update facility via the fw_upload mechanism. Given
that there is variability in which module update to load based on features,
fix levels, and potentially reloading the same version for error recovery
scenarios, the explicit userspace chosen payload flexibility of fw_upload
is attractive.

This design allows the kernel to accept a bitstream instead of loading a
named file from the filesystem, as the module selection and policy
enforcement for TDX Modules are quite complex (see more in patch 8). By
doing so, much of this complexity is shifted out of the kernel. The kernel
need to expose information, such as the TDX Module version, to userspace.
Userspace must understand the TDX Module versioning scheme and update
policy to select the appropriate TDX Module (see "TDX Module Versioning"
below).

In the unlikely event the update fails, for example userspace picks an
incompatible update image, or the image is otherwise corrupted, all TDs
will experience SEAMCALL failures and be killed. The recovery of TD
operation from that event requires a reboot.

Given there is no mechanism to quiesce SEAMCALLs, the TDs themselves must
pause execution over an update. The most straightforward way to meet the
'pause TDs while update executes' constraint is to run the update in
stop_machine() context. All other evaluated solutions export more
complexity to KVM, or exports more fragility to userspace.

== How to test this series ==

This series can be tested using the userspace tool that is able to
select the appropriate TDX module and install it via the interfaces
exposed by this series:

 # git clone https://github.com/intel/tdx-module-binaries
 # cd tdx-module-binaries
 # python version_select_and_load.py --update

== Base commit ==

This series is based on:
https://git.kernel.org/pub/scm/linux/kernel/git/devsec/tsm.git/commit/?h=tdx&id=9332e088937f

and the TDX Module version series at:
https://lore.kernel.org/linux-coco/20251001022309.277238-1-chao.gao@intel.com


== Other information relevant to Runtime TDX Module updates == 

=== TDX Module versioning ===

Each TDX Module is assigned a version number x.y.z, where x represents the
"major" version, y the "minor" version, and z the "update" version.

Runtime TDX Module updates are restricted to Z-stream releases.

Note that Z-stream releases do not necessarily guarantee compatibility. A
new release may not be compatible with all previous versions. To address this,
Intel provides a separate file containing compatibility information, which
specifies the minimum module version required for a particular update. This
information is referenced by the tool to determine if two modules are
compatible.

=== TCB Stability ===

Updates change the TCB as viewed by attestation reports. In TDX there is
a distinction between launch-time version and current version where
runtime TDX Module updates cause that latter version number to change,
subject to Z-stream constraints.

The concern that a malicious host may attack confidential VMs by loading
insecure updates was addressed by Alex in [3]. Similarly, the scenario
where some "theoretical paranoid tenant" in the cloud wants to audit
updates and stop trusting the host after updates until audit completion
was also addressed in [4]. Users not in the cloud control the host machine
and can manage updates themselves, so they don't have these concerns.

See more about the implications of current TCB version changes in
attestation as summarized by Dave in [5].

=== TDX Module Distribution Model ===

At a high level, Intel publishes all TDX Modules on the github [2], along
with a mapping_file.json which documents the compatibility information
about each TDX Module and a userspace tool to install the TDX Module. OS
vendors can package these modules and distribute them. Administrators
install the package and use the tool to select the appropriate TDX Module
and install it via the interfaces exposed by this series.

[1]: https://cdrdv2.intel.com/v1/dl/getContent/733584
[2]: https://github.com/intel/tdx-module-binaries
[3]: https://lore.kernel.org/all/665c5ae0-4b7c-4852-8995-255adf7b3a2f@amazon.com/
[4]: https://lore.kernel.org/all/5d1da767-491b-4077-b472-2cc3d73246d6@amazon.com/
[5]: https://lore.kernel.org/all/94d6047e-3b7c-4bc1-819c-85c16ff85abf@intel.com/


Chao Gao (20):
  x86/virt/tdx: Print SEAMCALL leaf numbers in decimal
  x86/virt/tdx: Use %# prefix for hex values in SEAMCALL error messages
  x86/virt/tdx: Prepare to support P-SEAMLDR SEAMCALLs
  x86/virt/seamldr: Introduce a wrapper for P-SEAMLDR SEAMCALLs
  x86/virt/seamldr: Retrieve P-SEAMLDR information
  coco/tdx-host: Expose P-SEAMLDR information via sysfs
  coco/tdx-host: Implement FW_UPLOAD sysfs ABI for TDX Module updates
  x86/virt/seamldr: Block TDX Module updates if any CPU is offline
  x86/virt/seamldr: Verify availability of slots for TDX Module updates
  x86/virt/seamldr: Allocate and populate a module update request
  x86/virt/seamldr: Introduce skeleton for TDX Module updates
  x86/virt/seamldr: Abort updates if errors occurred midway
  x86/virt/seamldr: Shut down the current TDX module
  x86/virt/tdx: Reset software states after TDX module shutdown
  x86/virt/seamldr: Handle TDX Module update failures
  x86/virt/seamldr: Install a new TDX Module
  x86/virt/seamldr: Do TDX per-CPU initialization after updates
  x86/virt/tdx: Establish contexts for the new TDX Module
  x86/virt/tdx: Update tdx_sysinfo and check features post-update
  x86/virt/tdx: Enable TDX Module runtime updates

Kai Huang (1):
  x86/virt/tdx: Move low level SEAMCALL helpers out of <asm/tdx.h>

 .../ABI/testing/sysfs-devices-faux-tdx-host   |  25 ++
 arch/x86/Kconfig                              |  12 +
 arch/x86/include/asm/seamldr.h                |  29 ++
 arch/x86/include/asm/tdx.h                    |  38 +-
 arch/x86/include/asm/tdx_global_metadata.h    |   5 +
 arch/x86/virt/vmx/tdx/Makefile                |   1 +
 arch/x86/virt/vmx/tdx/seamcall.h              | 106 +++++
 arch/x86/virt/vmx/tdx/seamldr.c               | 382 ++++++++++++++++++
 arch/x86/virt/vmx/tdx/tdx.c                   | 149 ++++---
 arch/x86/virt/vmx/tdx/tdx.h                   |  12 +-
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c   |  13 +
 drivers/virt/coco/tdx-host/tdx-host.c         | 189 ++++++++-
 12 files changed, 884 insertions(+), 77 deletions(-)
 create mode 100644 arch/x86/include/asm/seamldr.h
 create mode 100644 arch/x86/virt/vmx/tdx/seamcall.h
 create mode 100644 arch/x86/virt/vmx/tdx/seamldr.c

-- 
2.47.3


