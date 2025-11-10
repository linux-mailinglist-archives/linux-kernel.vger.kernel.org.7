Return-Path: <linux-kernel+bounces-894254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82255C4996B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 23:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6DB2188A0EF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 22:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98CF3446B7;
	Mon, 10 Nov 2025 22:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lhFdUAV3"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492973431E7
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 22:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762813795; cv=none; b=lDvx5RICEH8kXbIS2r0s9/461s/AEFkMGzH0Wag7QmKrrZlrxT8/7pg5eY3nfW1gEJqsPOTkeIGgEfRhzL5Y5L1hdbh0e8rS1c9tutvc/69qn4Il08jqOllaRnulCDGIo6kUclmjYoGhOK3xqCj5lyP885dTNylIMtyaIEY+ZGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762813795; c=relaxed/simple;
	bh=fcfJAhC0bSNR2EqZQjCe0wy4DatCoPlugnmlIkUKaYY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VI4KDWTzX3MjHFAz7nuyq1sZeRbkFr42UUl7lYmdWLtI1Jcp30xadb1AIhti/hpoI/dBdMsuFrWB2Bco7j2TyipGzlBcM5Hn8pp9C3bB8v7BMIQgnJejVP2kicGPsOrpJi97aFZW+tCEeH9+2yhqi+NFrmTBQURhNWIAMLaAaXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lhFdUAV3; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762813781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MelwhQ0SbtKAHXhQcEPQR8CxbS/9o9ufKupEDzxQS8w=;
	b=lhFdUAV3QrVmMrFE68gfIXqprOZl5seQXaijPGL8XjSrUOGXE1a/boZzNx+DlZlqjTalx2
	SxXJ+td7+eN5xAmxTNciJRsiK0mrFRtKQ4NQjz+3aq6AWFtQABt6CwKwKF9Wmpm7npdiYd
	mrZ4SHa/ocb4gck3BqBtIJOwXWiVH+Y=
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry.ahmed@linux.dev>
Subject: [PATCH v2 00/13] Nested SVM fixes, cleanups, and hardening
Date: Mon, 10 Nov 2025 22:29:09 +0000
Message-ID: <20251110222922.613224-1-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

A group of semi-related fixes, cleanups, and hardening patches for nSVM.
This series is based on kvm/master.

Patches 1-3 here are v2 of the last 3 patches in in the LBRV fixes
series [1]. The first 3 patches of [1] are already in kvm/master. The
rest of this series is v2 of [2].

Patches 4-6 fix or add missing consistency checks.

Patches 7-8 are renames to clarify some VMCB fields.

Patches 9-12 add hardening to reading the VMCB12, caching all used
fields in the save area to prevent theoritical TOC-TOU bugs, sanitizing
used fields in the control area, and restricting accesses to the VMCB12
through guest memory.

Patch 13 further restricts fields copied from VMCB01 to VMCB12.

v1 -> v2:
- Prepended some patches from the LBRV series.
- Used nested_npt_enabled() to guard consistency checks in patch 4.
- Best effort attempt to dynamically determine supported exception
  vectors in patch 6.
- Commit logs massaging and minor nits.

[1]https://lore.kernel.org/kvm/20251108004524.1600006-1-yosry.ahmed@linux.dev/
[2]https://lore.kernel.org/kvm/20251104195949.3528411-1-yosry.ahmed@linux.dev/

Yosry Ahmed (13):
  KVM: SVM: Switch svm_copy_lbrs() to a macro
  KVM: SVM: Add missing save/restore handling of LBR MSRs
  KVM: selftests: Add a test for LBR save/restore (ft. nested)
  KVM: nSVM: Fix consistency checks for NP_ENABLE
  KVM: nSVM: Add missing consistency check for EFER, CR0, CR4, and CS
  KVM: nSVM: Add missing consistency check for event_inj
  KVM: SVM: Rename vmcb->nested_ctl to vmcb->misc_ctl
  KVM: SVM: Rename vmcb->virt_ext to vmcb->misc_ctl2
  KVM: nSVM: Cache all used fields from VMCB12
  KVM: nSVM: Restrict mapping VMCB12 on nested VMRUN
  KVM: nSVM: Simplify nested_svm_vmrun()
  KVM: nSVM: Sanitize control fields copied from VMCB12
  KVM: nSVM: Only copy NP_ENABLE from VMCB01's misc_ctl

 arch/x86/include/asm/svm.h                    |  26 +-
 arch/x86/kvm/svm/nested.c                     | 349 ++++++++++++------
 arch/x86/kvm/svm/sev.c                        |   4 +-
 arch/x86/kvm/svm/svm.c                        |  57 +--
 arch/x86/kvm/svm/svm.h                        |  46 ++-
 arch/x86/kvm/x86.c                            |   3 +
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/include/x86/processor.h     |   5 +
 tools/testing/selftests/kvm/include/x86/svm.h |  14 +-
 .../selftests/kvm/x86/svm_lbr_nested_state.c  | 155 ++++++++
 10 files changed, 490 insertions(+), 170 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/svm_lbr_nested_state.c

-- 
2.51.2.1041.gc1ab5b90ca-goog


