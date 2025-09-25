Return-Path: <linux-kernel+bounces-831916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C34CB9DDE0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B6501B2303B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 07:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480572DE6FF;
	Thu, 25 Sep 2025 07:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GfhMZ1qL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3502512FF
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 07:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758785807; cv=none; b=cpu3XrI8lPQlPGPcHeocxblbe1xgUIWTEpoPJISWqxy6pQRNRv4q83Jp5Awy8Jp2Njm13EWcRpBDehtDyXylXaEBq5L8MsnflhNl9ehfAKQuaQBgBPCDitKMiJaX3/Hj/OoAebHIYscSMhSDraPfMN3vTySdBp/CLzmwJcB8J90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758785807; c=relaxed/simple;
	bh=KyhoKHqp0G/+8CJx/lsSlezjV3fmH9xGWx9gJKIn7Tc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e6qokQ2Rf5RtcKx9u3/QFPbpqwn7deWfOKwzSxg/QAuVBskBPpwzu77wAXGOw0uzxQ94Uu7Nkbos59a3B5muGyJCyntCYjMivkqDEfmB0O+F4/eQgRXsoeqZxBkyLXOYe2fcnFEPTPaBjwXz9XUEMBFz2ks8bodNOAXJ7iz+j5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GfhMZ1qL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758785804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=V4NmZHUoJps7Yrk11w5SBou2tcMbfSFRbEHR6+6/r24=;
	b=GfhMZ1qLCQ7BMoLrXaCdMPwC9fxssb2dZl4CnDrEBckEbbmY3LEI2tH+xFrnaVcgGfbFcU
	JF5RiL1jXQCdDJECtIKviAFsXlJEmpsc/ncZ+TTFkQoDOe+ykdduow7MoMwY4HvV1YZ8M3
	hL96A1Kih5BLSK9TnpSeEDNzxSRweIs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-H9pZOT25NPmCa7FRSQACtg-1; Thu, 25 Sep 2025 03:36:43 -0400
X-MC-Unique: H9pZOT25NPmCa7FRSQACtg-1
X-Mimecast-MFC-AGG-ID: H9pZOT25NPmCa7FRSQACtg_1758785802
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45de07b831dso3878645e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:36:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758785802; x=1759390602;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V4NmZHUoJps7Yrk11w5SBou2tcMbfSFRbEHR6+6/r24=;
        b=nHq1YeQuwhfh2AuGYLDWtQxV6XV9cAgiQ9queOlhohd/Zrqz9TGOqNic2Cxsga/i4h
         GB6SroAziW/cmyN/i6XPbVcpYxFVCMUqWiMTvp2Xh+wlRXLGBbbeldVn7W5AtEhC0wUS
         NstnxjUR2jVI4yiYjBIKnzTLtKneDkvTXoWNJGB49DKOTuJxdI+E8TiL+o837rxBuilB
         KYG1PV4RVRtDiai5LPopXtDF5Pmw4wzBn0AX/zuf1cGZZs9nHcQ4hZyLssSAHGreadyd
         AhtRiYe7rLnCWoEs0YN3l85QI7fhK8jRKVHGekBzvAEQX/eCb8N9RISCoshl/UDgFvy8
         GJcw==
X-Forwarded-Encrypted: i=1; AJvYcCWZY+1AnbXLVP0VZjMh0+ExksPUChOLXBDw7970OHQJfdlgASPGSUEzpmv60zCGd2ur5zIDWyqV7Egib2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzscbCR0SwluT7B0NH+6JIbXECGgmQk3DSkuGlO8ixDyIqpcnKo
	nJcDLqG1LvVaL33ClrPwV+2q9g4wDX1YynIcMfLGiNaSd+IyvwqSY6hCXYIw+1GbRG4HuaQ+8Kl
	w1zNzELyXppHvCYew8EKpwoAvuwF42U0oTsYnhtz/bQBCxijO0a3NNk8N9leCcwk3dg==
X-Gm-Gg: ASbGncsVWaAQYPUX+1xNctwQmBKxFWkmCzp08trcSU8rhePIsvGYt/CBROP46H2UIpB
	B1r4EHXg2bNwIQPIFiV8ZIGfISosTeHynxKgC3sP4OeM9x/ovDQAj/Jz9FROrLNreeGPPUUsIOS
	MggnVcezG4v1yKuc2y6OpQ5dO+E+mDjh+ZJ1egJyzHorBCjhUPA5G86twNcgKnLv8tLkkKlWWmt
	azriQtAmiSQZmgiZ97boGuMUsuraz/W7LzMKSL7nKvwTucGDN5rMti7yWNs4JstEwkPj/p59wD4
	l4bbNkJPZg/c2nI1D/c2wLVDuGL+dOX4g945HqwtcS/kYv6Ztua5VIBfq/ucyazMmdfG7ATYT5X
	r44F4IudhXuNMOA==
X-Received: by 2002:a05:600c:8010:b0:45c:b5eb:b0c6 with SMTP id 5b1f17b1804b1-46e329a805amr24229645e9.5.1758785801754;
        Thu, 25 Sep 2025 00:36:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHigtd7Rlw0EkwZsZ6TnPLHr+fIfHQKJS55XMc7sCab7310hvvOcbsSwYh9WPs1s1S/Xj6xjA==
X-Received: by 2002:a05:600c:8010:b0:45c:b5eb:b0c6 with SMTP id 5b1f17b1804b1-46e329a805amr24229265e9.5.1758785801231;
        Thu, 25 Sep 2025 00:36:41 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen12.rmtde.csb ([2a02:810d:7e01:ef00:1622:5a48:afdc:799f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc560338csm1755120f8f.41.2025.09.25.00.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 00:36:40 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Cc: linux-snps-arc@lists.infradead.org,
	linux-parisc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-um@lists.infradead.org,
	linux-openrisc@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] Documentation/features: Update feature lists for 6.17-rc7
Date: Thu, 25 Sep 2025 09:36:34 +0200
Message-ID: <20250925073634.112142-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

It seems that ./Documentation/features/scripts/features-refresh.sh was most
recently used in December 2022, with the latest kernel release v6.1-rc7 at
that time (see commit 7f2e60ff51ca ("Documentation/features: Update feature
lists for 6.1") to update the feature lists in this subdirectory. All
further changes to Documentation/features/ since then have probably been
done manually, without checking for changes in other architectures and
features, that missed to update this part of the documentation.

Running ./Documentation/features/scripts/features-refresh.sh now showed
seven changes of supported features in various architectures (one in arc,
two in parisc, one in riscv, one in openrisc, and two in um), which were
not reflected yet in the current documentation.

To confirm the sanity of this script's suggested changes, I checked if the
commit messages confirm that the features have in fact been added in the
following commits:

  - commit f122668ddcce ("ARC: Add eBPF JIT support")
  - commit 4800a6215e33 ("parisc: Wire up eBPF JIT compiler")
  - commit a869b8c29f86 ("riscv: enable mseal sysmap for RV64")
  - commit 2f681ba4b352 ("um: move thread info into task")
  - commit 3f17fed21491 ("um: switch to regset API and depend on XSTATE")
  - commit 7ce8716e2769 ("openrisc: Add HAVE_REGS_AND_STACK_ACCESS_API support")
  - commit b5ff52be8913 ("parisc: Convert to generic clockevents")

So, update all documents to the current state with features-refresh.sh.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 Documentation/features/core/eBPF-JIT/arch-support.txt         | 4 ++--
 .../features/core/mseal_sys_mappings/arch-support.txt         | 2 +-
 .../features/core/thread-info-in-task/arch-support.txt        | 2 +-
 Documentation/features/core/tracehook/arch-support.txt        | 2 +-
 Documentation/features/perf/kprobes-event/arch-support.txt    | 2 +-
 Documentation/features/time/clockevents/arch-support.txt      | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/features/core/eBPF-JIT/arch-support.txt b/Documentation/features/core/eBPF-JIT/arch-support.txt
index 7434b43c2ff8..83f77f55fc87 100644
--- a/Documentation/features/core/eBPF-JIT/arch-support.txt
+++ b/Documentation/features/core/eBPF-JIT/arch-support.txt
@@ -7,7 +7,7 @@
     |         arch |status|
     -----------------------
     |       alpha: | TODO |
-    |         arc: | TODO |
+    |         arc: |  ok  |
     |         arm: |  ok  |
     |       arm64: |  ok  |
     |        csky: | TODO |
@@ -18,7 +18,7 @@
     |        mips: |  ok  |
     |       nios2: | TODO |
     |    openrisc: | TODO |
-    |      parisc: | TODO |
+    |      parisc: |  ok  |
     |     powerpc: |  ok  |
     |       riscv: |  ok  |
     |        s390: |  ok  |
diff --git a/Documentation/features/core/mseal_sys_mappings/arch-support.txt b/Documentation/features/core/mseal_sys_mappings/arch-support.txt
index a3c24233eb9b..fa85381acc43 100644
--- a/Documentation/features/core/mseal_sys_mappings/arch-support.txt
+++ b/Documentation/features/core/mseal_sys_mappings/arch-support.txt
@@ -20,7 +20,7 @@
     |    openrisc: |  N/A |
     |      parisc: | TODO |
     |     powerpc: | TODO |
-    |       riscv: | TODO |
+    |       riscv: |  ok  |
     |        s390: |  ok  |
     |          sh: |  N/A |
     |       sparc: | TODO |
diff --git a/Documentation/features/core/thread-info-in-task/arch-support.txt b/Documentation/features/core/thread-info-in-task/arch-support.txt
index 2afeb6bf6e64..f3d744c76061 100644
--- a/Documentation/features/core/thread-info-in-task/arch-support.txt
+++ b/Documentation/features/core/thread-info-in-task/arch-support.txt
@@ -24,7 +24,7 @@
     |        s390: |  ok  |
     |          sh: | TODO |
     |       sparc: | TODO |
-    |          um: | TODO |
+    |          um: |  ok  |
     |         x86: |  ok  |
     |      xtensa: | TODO |
     -----------------------
diff --git a/Documentation/features/core/tracehook/arch-support.txt b/Documentation/features/core/tracehook/arch-support.txt
index a72330e25542..4f36fcbfb6d5 100644
--- a/Documentation/features/core/tracehook/arch-support.txt
+++ b/Documentation/features/core/tracehook/arch-support.txt
@@ -24,7 +24,7 @@
     |        s390: |  ok  |
     |          sh: |  ok  |
     |       sparc: |  ok  |
-    |          um: | TODO |
+    |          um: |  ok  |
     |         x86: |  ok  |
     |      xtensa: |  ok  |
     -----------------------
diff --git a/Documentation/features/perf/kprobes-event/arch-support.txt b/Documentation/features/perf/kprobes-event/arch-support.txt
index 713a69fcd697..75c05d348c01 100644
--- a/Documentation/features/perf/kprobes-event/arch-support.txt
+++ b/Documentation/features/perf/kprobes-event/arch-support.txt
@@ -17,7 +17,7 @@
     |  microblaze: | TODO |
     |        mips: |  ok  |
     |       nios2: | TODO |
-    |    openrisc: | TODO |
+    |    openrisc: |  ok  |
     |      parisc: |  ok  |
     |     powerpc: |  ok  |
     |       riscv: |  ok  |
diff --git a/Documentation/features/time/clockevents/arch-support.txt b/Documentation/features/time/clockevents/arch-support.txt
index 4d4bfac52970..d6100b226de5 100644
--- a/Documentation/features/time/clockevents/arch-support.txt
+++ b/Documentation/features/time/clockevents/arch-support.txt
@@ -18,7 +18,7 @@
     |        mips: |  ok  |
     |       nios2: |  ok  |
     |    openrisc: |  ok  |
-    |      parisc: | TODO |
+    |      parisc: |  ok  |
     |     powerpc: |  ok  |
     |       riscv: |  ok  |
     |        s390: |  ok  |
-- 
2.51.0


