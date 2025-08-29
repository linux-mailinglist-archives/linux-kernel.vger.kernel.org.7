Return-Path: <linux-kernel+bounces-791897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D933B3BD8B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 16:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CEE11CC1C9C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 14:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C073203A4;
	Fri, 29 Aug 2025 14:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="kni6OxFB"
Received: from pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.1.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46CD29E110
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 14:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.1.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756477577; cv=none; b=ZCHtcUyeF3vL23r6hQCjRy/b8vs7d6AS7kOOSMajfCOVv1nitPMJvPL4dcUfsuBDDby3zYpQnZY43hjhT2ldwH3fgPzSF7GKi9/jMxIaaK/FRdP2nP5HWJNGM4isW+ZLh1Q+JtWdQRwakCJlEFcXvpS4ZDS+OFcxrDJai9/v/WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756477577; c=relaxed/simple;
	bh=1jr34Oo+zDX+vHRejSlQwUttPRdt87rXKaKVB7jrpkQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Oybxnbl9qkxn7O9/+UNPZ6JZExmBtPDLk2VT1N/wrIMBHiIfcYLxSLImbUotg3GuJ3+F6V8ebc0r+lDbALF9OuaCEO32s/EBzGAC/ISaGOJQIUkILDSD2D2m2/j+jZWDHDrorjMHF+Z+9+TQfSOpusS6b2WoDMB3E35wiyW3dXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=kni6OxFB; arc=none smtp.client-ip=44.246.1.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1756477575; x=1788013575;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hJts0WnwqOshd4RBFfD/CIKc+hf9Q7OUFPCZW0u1Y10=;
  b=kni6OxFBqnovLiQVcVAf3klx8uj058v8s3Qc6AbrhWLlwJFy+QIMlWKf
   nWVvRYav07K518ToJYfkm23OnBy7e2cxyzB4KRGelljPHQnB2FZDqo9Mo
   gLt5+oEV7ruUHHxJCyyNE6Ly3tu6uAa8bDmEIjaJFRYCKrPH5CMIXaPL5
   W8cIotu1fcx8jnn0mDdp+AV8MdmtE6QurNSp/KIQLMIf63ujvv88knpkZ
   Ym5PRuNpmrkLVW5m4muDo90W46M5+c7a6NBZkYTi9SuQPXRBySsXUPsyz
   PM9pf8h0AK9u+uxkW+GNG0f5Bj/tXNuXeWPs2fwLQ2AQ/GgNnew3ZRFmG
   A==;
X-CSE-ConnectionGUID: jyyqa62ITvmEznyXDIMMrQ==
X-CSE-MsgGUID: wJtbx3WaSCePb/NRNckxNw==
X-IronPort-AV: E=Sophos;i="6.16,202,1744070400"; 
   d="scan'208";a="2044950"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 14:26:10 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:15057]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.51.7:2525] with esmtp (Farcaster)
 id 9d2891e3-be29-4525-b5a8-0486e0af605f; Fri, 29 Aug 2025 14:26:10 +0000 (UTC)
X-Farcaster-Flow-ID: 9d2891e3-be29-4525-b5a8-0486e0af605f
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Fri, 29 Aug 2025 14:26:10 +0000
Received: from dev-dsk-aqibaf-1b-17060f52.eu-west-1.amazon.com (10.253.72.42)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Fri, 29 Aug 2025 14:26:08 +0000
From: Aqib Faruqui <aqibaf@amazon.com>
To: Christian Brauner <brauner@kernel.org>, <linux-kernel@vger.kernel.org>
CC: <nh-open-source@amazon.com>, <aqibaf@amazon.com>
Subject: [PATCH 0/9] Add compatibility fixes for KVM selftests with non-glibc C libraries
Date: Fri, 29 Aug 2025 14:25:44 +0000
Message-ID: <20250829142556.72577-1-aqibaf@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWC002.ant.amazon.com (10.13.139.238) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

This patch series adds compatibility fixes for building and running KVM selftests with musl 
and other non-glibc implementations. The changes address missing function definitions, syscall 
numbers, macros, type definitions, and runtime compatibility issues that are otherwise handled 
by glibc.

The series includes both build-time compatibility fixes (missing definitions, type mismatches) 
and runtime fixes (stdbuf compatibility in mixed libc environments) to ensure KVM selftests 
work correctly across different C library implementations.

Aqib Faruqui (9):
  KVM: selftests: Add pidfd_open syscall number fallback
  KVM: selftests: Add __packed attribute fallback
  KVM: selftests: Add pthread_attr_setaffinity_np fallback
  selftests: kselftest: Add memfd_create syscall compatibility
  KVM: selftests: Prevent PAGE_SIZE redefinition on x86
  KVM: selftests: Add backtrace fallback
  rseq: selftests: Add non-glibc compatibility fixes
  selftests: Fix stdbuf compatibility in mixed libc environments
  selftests: kselftest: Add ulong typedef for non-glibc compatibility

 tools/testing/selftests/kselftest.h                    | 24 ++++++++++++++++++++++++
 tools/testing/selftests/kselftest/runner.sh            |  2 +-
 tools/testing/selftests/kselftest_harness.h            |  1 +
 tools/testing/selftests/kvm/include/kvm_util.h         |  8 ++++++++
 tools/testing/selftests/kvm/include/x86/processor.h    |  2 ++
 tools/testing/selftests/kvm/lib/assert.c               | 10 +++++++++-
 tools/testing/selftests/kvm/lib/kvm_util.c             | 12 ++++++++++++
 tools/testing/selftests/pidfd/pidfd.h                  |  4 ++++
 tools/testing/selftests/rseq/rseq-x86-thread-pointer.h | 14 ++++++++++++++
 tools/testing/selftests/rseq/rseq.c                    |  8 ++++++++
 10 files changed, 83 insertions(+), 2 deletions(-)

-- 
2.47.3


