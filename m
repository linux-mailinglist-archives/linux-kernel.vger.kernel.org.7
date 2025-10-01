Return-Path: <linux-kernel+bounces-839310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F1BBB151F
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 19:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DB431C72EF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 17:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1234B2D29A9;
	Wed,  1 Oct 2025 17:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YatD9C2v"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0062A208961
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 17:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759338678; cv=none; b=W1NicamEx7JHFUjIpzczitSmRZz9VoD2esImud5EeA24bNsZtztijXmeTLM/XHEglmjQZcOpMAwChXxsVHcQw4YcFRNhtRZiDrqDVEZdfYFufurxkdGjqm4MDBHu9uQvRtdDMr3a1RACel/hWyDXSsRWedB6fvqwbmHRND1D0w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759338678; c=relaxed/simple;
	bh=VHx30WZRchPyziimM+Gj9xo1eekImQY39zuc8+br/Ng=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qzfI6vtaKl2Sby5YUN9wr02saFfKmM7WB9DO0uuOjeKCoPElMTnhpVyLA33b7BM//Hk6et/t3VB/qt/Ys3Ds11BSGhb+jPnQuGUXeExjCBLetayLWSk+FWnCYsV/EDBg9yp7+kaw7U3aLKYspYDJZzLVltyVACHeIAF2pgv81WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YatD9C2v; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759338676; x=1790874676;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VHx30WZRchPyziimM+Gj9xo1eekImQY39zuc8+br/Ng=;
  b=YatD9C2vdEwGc2e1lO02Vsx4dpU3UId5Wf0un8o6myNKKECrcZuXUo+K
   FCjN9ofvSUT2UMaOYus5ZI288rLacE4NYlEMZpe1EU+JNuNN8hFBWswiv
   Fzo49ZRErar3bypE7XprfXZhbR6gfs9iGMM3MWGQYqlvz6jymZsbnDHCk
   TNS+0oBXQlgMH9rShv9xEgz2aP6NqyXLxtX4FUehqEmdMoOrGVKLbuDJ2
   wj0TWkXMMq3Ndr4txvUQ85m7xeMpYKxENcF99I9wySToDaZWuEYqpS5z0
   LvVV3s6CYk9MrFgSsTAl0WKSvlyJ8PikCvA900KcE1Us+M1zBYyZ+zlPH
   w==;
X-CSE-ConnectionGUID: ajgSmBG3ScaMqUWBjB9sXw==
X-CSE-MsgGUID: toq3TzRLSBKer098g/8c4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="65471691"
X-IronPort-AV: E=Sophos;i="6.18,307,1751266800"; 
   d="scan'208";a="65471691"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2025 10:11:15 -0700
X-CSE-ConnectionGUID: JXSDjwEcSEi2MIqdARJNSA==
X-CSE-MsgGUID: PU6wiEraRbG/5F04FQ2haw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,307,1751266800"; 
   d="scan'208";a="177954812"
Received: from davehans-spike.ostc.intel.com (HELO ray2.sr71.net) ([10.165.164.11])
  by orviesa006.jf.intel.com with ESMTP; 01 Oct 2025 10:11:14 -0700
From: Dave Hansen <dave.hansen@linux.intel.com>
To: torvalds@linux-foundation.org
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: [GIT PULL] x86/tdx for 6.18-rc1
Date: Wed,  1 Oct 2025 10:11:12 -0700
Message-Id: <20251001171112.899791-1-dave.hansen@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull some x86/tdx changes for 6.18-rc1. The biggest change here
is making TDX and kexec play nicely together. Before this, the memory
encryption hardware (which doesn't respect cache coherency) could
write back old cachelines on top of data in the new kernel, so kexec
and TDX were made mutually exclusive. This removes the limitation.

There is also some work to tighten up a hardware bug workaround and
some MAINTAINERS updates.

--

The following changes since commit c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9:

  Linux 6.17-rc2 (2025-08-17 15:22:10 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_tdx_for_6.18-rc1

for you to fetch changes up to e414b1005891d74bb0c3d27684c58dfbfbd1754b:

  x86/virt/tdx: Use precalculated TDVPR page physical address (2025-09-11 11:38:28 -0700)

----------------------------------------------------------------
 - Make TDX and kexec work together
 - Skip TDX bug workaround when the bug is not present
 - Update maintainers entries

----------------------------------------------------------------
Adrian Hunter (3):
      x86/tdx: Eliminate duplicate code in tdx_clear_page()
      x86/tdx: Tidy reset_pamt functions
      x86/tdx: Skip clearing reclaimed pages unless X86_BUG_TDX_PW_MCE is present

Kai Huang (8):
      x86/kexec: Consolidate relocate_kernel() function parameters
      x86/sme: Use percpu boolean to control WBINVD during kexec
      x86/virt/tdx: Mark memory cache state incoherent when making SEAMCALL
      x86/kexec: Disable kexec/kdump on platforms with TDX partial write erratum
      x86/virt/tdx: Remove the !KEXEC_CORE dependency
      x86/virt/tdx: Update the kexec section in the TDX documentation
      KVM/TDX: Explicitly do WBINVD when no more TDX SEAMCALLs
      x86/virt/tdx: Use precalculated TDVPR page physical address

Kirill A. Shutemov (2):
      MAINTAINERS: Update the file list in the TDX entry.
      MAINTAINERS: Add Rick Edgecombe as a TDX reviewer

Xiaoyao Li (1):
      MAINTAINERS: Add KVM mail list to the TDX entry

 Documentation/arch/x86/tdx.rst       | 14 +++----
 MAINTAINERS                          | 11 ++---
 arch/x86/Kconfig                     |  1 -
 arch/x86/include/asm/kexec.h         | 12 +++++-
 arch/x86/include/asm/processor.h     |  2 +
 arch/x86/include/asm/tdx.h           | 35 +++++++++++++++-
 arch/x86/kernel/cpu/amd.c            | 17 ++++++++
 arch/x86/kernel/machine_kexec_64.c   | 44 ++++++++++++++++----
 arch/x86/kernel/process.c            | 24 +++++------
 arch/x86/kernel/relocate_kernel_64.S | 36 ++++++++++------
 arch/x86/kvm/vmx/tdx.c               | 44 ++++++++++----------
 arch/x86/virt/vmx/tdx/tdx.c          | 80 +++++++++++++++++++++---------------
 12 files changed, 214 insertions(+), 106 deletions(-)

