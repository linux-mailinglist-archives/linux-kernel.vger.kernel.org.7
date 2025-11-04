Return-Path: <linux-kernel+bounces-885422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80FF2C32D9A
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 21:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28A6018C1B4D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 20:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D1A2E03F0;
	Tue,  4 Nov 2025 20:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kDt1VJTf"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B6B28D836
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 20:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762286412; cv=none; b=DI8EqdGOg7gOeCLWFNXV26hmzn5SLij6erNQkDohhvhVqh5NACM0Htofb1MpzU2kRlKwVse2HVfbqBYvmnnO03XeMLN4ZzeACe8W4tkLWua3OCMxB7l9nXkkiQAL6TMhDVE8IAHciQHejNdFrMgmyBBnGC35a/8zGUh4wjiTPGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762286412; c=relaxed/simple;
	bh=2OhcAUdB0tHmscZz9a/V7gpElutoP/FD8ca9U+0iMrI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Lx03PjUhWiUbZM6fNoB1KQk6ULe1vm8YAyx1nDvjK2kaJnjURrZL3zU9lX//tMKPNPCagxpry2ga2zQ3u5Xy4eAykwHW4pF65R9HKR6lRpeqlrr0QNaA5odjvpBDCP8UVN6Lgn1xaGUh8nuy8wbVfear14MU9tuN0/8I8z/Ezt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kDt1VJTf; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762286405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Lm03zTugh5/LobL3mDR9QgjFS+gdjZMCrMtSX6UIEmA=;
	b=kDt1VJTfvo8GlrWFY8BAGnUc0yJ9QD3F5qz6lBNdBgVdzIuojeBDOu5Wpo1wc2v0fq5hFD
	PgnsMJBD7Zj2EzGLt9wWebi+svqZWtS1ogb7i4JI4FP/dazkSZGMqtIlC08Hx9H4N9WgFC
	FU8MsMJr2cqGaajC6whMl/MgTzlZHj0=
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry.ahmed@linux.dev>
Subject: [PATCH 00/11] Nested SVM fixes, cleanups, and hardening
Date: Tue,  4 Nov 2025 19:59:38 +0000
Message-ID: <20251104195949.3528411-1-yosry.ahmed@linux.dev>
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

Patches 1-3 fix or add missing consistency checks.

Patches 4-5 are renames to clarify some VMCB fields.

Patches 6-10 add hardening to reading the VMCB12, caching all used
fields in the save area to prevent theoritical TOC-TOU bugs, sanitizing
used fields in the control area, and restricting accesses to the VMCB12
through guest memory.

Patch 11 further restricts fields copied from VMCB01 to VMCB12.

Yosry Ahmed (11):
  KVM: nSVM: Fix consistency checks for NP_ENABLE
  KVM: nSVM: Add missing consistency check for EFER, CR0, CR4, and CS
  KVM: nSVM: Add missing consistency check for event_inj
  KVM: SVM: Rename vmcb->nested_ctl to vmcb->misc_ctl
  KVM: SVM: Rename vmcb->virt_ext to vmcb->misc_ctl2
  KVM: SVM: switch svm_copy_lbrs() to a macro
  KVM: nSVM: Cache all used fields from VMCB12
  KVM: nSVM: Restrict mapping VMCB12 on nested VMRUN
  KVM: nSVM: Simplify nested_svm_vmrun()
  KVM: nSVM: Sanitize control fields copied from VMCB12
  KVM: nSVM: Only copy NP_ENABLE from VMCB01's nested_ctl

 arch/x86/include/asm/svm.h                    |  31 +-
 arch/x86/kvm/svm/nested.c                     | 335 +++++++++++-------
 arch/x86/kvm/svm/sev.c                        |   4 +-
 arch/x86/kvm/svm/svm.c                        |  51 ++-
 arch/x86/kvm/svm/svm.h                        |  46 ++-
 tools/testing/selftests/kvm/include/x86/svm.h |  14 +-
 6 files changed, 302 insertions(+), 179 deletions(-)

-- 
2.51.2.1026.g39e6a42477-goog


