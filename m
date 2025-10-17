Return-Path: <linux-kernel+bounces-858359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A414EBEA9F5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A58745A8502
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD9033290A;
	Fri, 17 Oct 2025 15:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="lO8crCvJ"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BE2335092
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 15:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760716789; cv=none; b=TzbQ3QVBShVc8J8WnZV+BhiBr17eDt7mBfqn2M7MRKdgd+j3NrnIaAN6W0IBLoID7jlQa6BpOl4mXwiIKM7CRkU1FYHv6S3ndJPNCAZ6VIxMZmSPJKPcISoGnuQ9PhIfLtMqvyI8C9qL2PGzTwjJByftP3ezmGqvNUMM2bzmCNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760716789; c=relaxed/simple;
	bh=VauSt0uAycrcY3nlPmUv8mw69nRyhNX8TjKVsezUOqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZzXvNWnZKyIlV9E1BCgWq4wPIExHRCq9iY08ND8eBD2G+gPQvRZ2Q6xhr+EeTttWMXHKK4iVL2SBR/cebkcOn8+LeXHPt9yq17vGq+RGqXd6QJgN315FFyWvsBb73nkrhNUGbLAn527FHt4pUbSr5rAZKRzPZt8J5X+L9bUf9f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=lO8crCvJ; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7a213c3c3f5so2885744b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1760716786; x=1761321586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7YO6UzdALBp15BcoYG5LkyhqHChXHZ3HPbY8ifkU6tw=;
        b=lO8crCvJHc5SFcjB9LV6QuFXfvQinJ4Winjo0UIFHGqWLW79rJ+P0PLjpmqNBzpAJX
         94AcQPXfKWztOM7DueEeQ7uwUysZqhhu1ZPYePSTeZWD74P5pqGTz4sMUEwFEC8tTyO8
         ZJbJRsuodrXOd/d8GCkzZbB2dQzdhnI80Xqmt4Ml2/uQwMqjmZmc+xl3/cU88h7/rN9o
         1VcNVFqt1l2k85uUtog1VZnE7QuyjvYDml5lWqoWCLPJncljEvvQO+DnOzUW/n4vClVZ
         DXtDOcJtPrdvn5MOIAbEmIEHQ6gyLmozHKea9K8CYDa7NbnpB4syjBmYFShogeDbPpus
         ZIMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760716786; x=1761321586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7YO6UzdALBp15BcoYG5LkyhqHChXHZ3HPbY8ifkU6tw=;
        b=Lq3jlD2M6EMZ8WsYK53jzJsOKIvot2yrXnLtTE3vKsfcpheJUI2PF3F9xxTMfo7oDX
         rGIsl/D5QIAN4OnP5EiXc28jEFRHcYXZK3UZaTQMRw8NfUwW7Y/WTaym7L0qWRhXpDgv
         YiwTcRLUbhGIPE7telfzmEqp0HPbDn16/94VhT1IF8SnKiHmgt8TAswBn5JeQ9mCX1nH
         P8XcU4PBoDSsPAY+LKWo5qf7OA2pUO0pmEWDx8IQuBu8Orqq3AUPBeW8x+6hQPw4RTMc
         gq1NPDyEJcHKWOgySNoSym9BTFYxtBh346FllY8pVu3vsjnzAjL8kK4KIq+V/e58Wl/d
         3oYw==
X-Forwarded-Encrypted: i=1; AJvYcCUpHWCIVwb+z4hgvQ5Qh3gJd5FSfo1PsOdM4tTTk/9tRwVoaeqbNKIppX40dQEF2tPR7ssXDro0rxlhV68=@vger.kernel.org
X-Gm-Message-State: AOJu0YxasD1gF1G17lMWAHnICdbV0W9ajZUdnOAL1fBO/6DFVyARthd5
	xuLnJRhcaQ5vqEAxsazkOjg8zttzrNZWHcO3yg8TBp7jV4phuuCdJFzuUnO4nSQODlCVMS8+1oy
	KDZFJxAw=
X-Gm-Gg: ASbGncuJgUsmdMGILHWooH0zw1HkWRgkza715ZuCjfVZ8wPJc6o7laiqScKaGhXGEpr
	+vwUpNseCbGcs3UcZpLAkw5BE6iHO1a9sE17v/BHezn8IFL89YHbziW9X8pyTwAc/KBNlgdq7KH
	3P5Iq5BbapbdlAomLwHLb1hffn1aIcr/StAVRU14X/eCDBsV/M98xmpiHPitZmDL5CxV45TVyJR
	lRcCNT/1Jad/t7gQN2qiCYMsPKjsghyHTYaBKsRzMEft3gZPWA0Ta2J1efqdoUFxoF0W8aTjUtK
	mvHUjya3CvQQmd9cBfij0OXHXrWpdDv27SzNu1uKfC6rdntWv9wUiX297JxpZ0lT2Uq+WDExpT+
	RNY/HV1nv6cw7jceENkIK+PfU0nEsu2Tac6g+ee5GzvQp781E2Ky3u0HE4WO2yH55Igj0E11Hik
	YbeHh3opzPiBE4KYKCjs3/4swBhdyODtnOXnhmw64vSNFqkZxP9Izepg==
X-Google-Smtp-Source: AGHT+IGyl9gTUlhqKvf7bWFyXToKYsATj7SdvLFGZ0eSD3zQLgSjQNxd1CMPXeNXJkwX2bLubLMF4Q==
X-Received: by 2002:a05:6a21:9997:b0:334:9e5e:c2c2 with SMTP id adf61e73a8af0-334a84c81famr5765358637.13.1760716785208;
        Fri, 17 Oct 2025 08:59:45 -0700 (PDT)
Received: from localhost.localdomain ([122.171.18.129])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a7669392csm151067a12.18.2025.10.17.08.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 08:59:44 -0700 (PDT)
From: Anup Patel <apatel@ventanamicro.com>
To: Atish Patra <atish.patra@linux.dev>,
	Andrew Jones <ajones@ventanamicro.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Anup Patel <anup@brainfault.org>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 2/4] RISC-V: KVM: Add separate source for forwarded SBI extensions
Date: Fri, 17 Oct 2025 21:29:23 +0530
Message-ID: <20251017155925.361560-3-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251017155925.361560-1-apatel@ventanamicro.com>
References: <20251017155925.361560-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a separate source vcpu_sbi_forward.c for SBI extensions
which are entirely forwarded to KVM user-space.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/kvm/Makefile           |  1 +
 arch/riscv/kvm/vcpu_sbi_base.c    | 12 ------------
 arch/riscv/kvm/vcpu_sbi_forward.c | 27 +++++++++++++++++++++++++++
 arch/riscv/kvm/vcpu_sbi_replace.c |  7 -------
 4 files changed, 28 insertions(+), 19 deletions(-)
 create mode 100644 arch/riscv/kvm/vcpu_sbi_forward.c

diff --git a/arch/riscv/kvm/Makefile b/arch/riscv/kvm/Makefile
index 07197395750e..3b8afb038b35 100644
--- a/arch/riscv/kvm/Makefile
+++ b/arch/riscv/kvm/Makefile
@@ -27,6 +27,7 @@ kvm-y += vcpu_onereg.o
 kvm-$(CONFIG_RISCV_PMU_SBI) += vcpu_pmu.o
 kvm-y += vcpu_sbi.o
 kvm-y += vcpu_sbi_base.o
+kvm-y += vcpu_sbi_forward.o
 kvm-y += vcpu_sbi_fwft.o
 kvm-y += vcpu_sbi_hsm.o
 kvm-$(CONFIG_RISCV_PMU_SBI) += vcpu_sbi_pmu.o
diff --git a/arch/riscv/kvm/vcpu_sbi_base.c b/arch/riscv/kvm/vcpu_sbi_base.c
index ca489f2dfbdf..06fdd5f69364 100644
--- a/arch/riscv/kvm/vcpu_sbi_base.c
+++ b/arch/riscv/kvm/vcpu_sbi_base.c
@@ -70,15 +70,3 @@ const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_base = {
 	.extid_end = SBI_EXT_BASE,
 	.handler = kvm_sbi_ext_base_handler,
 };
-
-const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_experimental = {
-	.extid_start = SBI_EXT_EXPERIMENTAL_START,
-	.extid_end = SBI_EXT_EXPERIMENTAL_END,
-	.handler = kvm_riscv_vcpu_sbi_forward_handler,
-};
-
-const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_vendor = {
-	.extid_start = SBI_EXT_VENDOR_START,
-	.extid_end = SBI_EXT_VENDOR_END,
-	.handler = kvm_riscv_vcpu_sbi_forward_handler,
-};
diff --git a/arch/riscv/kvm/vcpu_sbi_forward.c b/arch/riscv/kvm/vcpu_sbi_forward.c
new file mode 100644
index 000000000000..dbfa70c2c775
--- /dev/null
+++ b/arch/riscv/kvm/vcpu_sbi_forward.c
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Ventana Micro Systems Inc.
+ */
+
+#include <linux/kvm_host.h>
+#include <asm/kvm_vcpu_sbi.h>
+#include <asm/sbi.h>
+
+const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_experimental = {
+	.extid_start = SBI_EXT_EXPERIMENTAL_START,
+	.extid_end = SBI_EXT_EXPERIMENTAL_END,
+	.handler = kvm_riscv_vcpu_sbi_forward_handler,
+};
+
+const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_vendor = {
+	.extid_start = SBI_EXT_VENDOR_START,
+	.extid_end = SBI_EXT_VENDOR_END,
+	.handler = kvm_riscv_vcpu_sbi_forward_handler,
+};
+
+const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_dbcn = {
+	.extid_start = SBI_EXT_DBCN,
+	.extid_end = SBI_EXT_DBCN,
+	.default_disabled = true,
+	.handler = kvm_riscv_vcpu_sbi_forward_handler,
+};
diff --git a/arch/riscv/kvm/vcpu_sbi_replace.c b/arch/riscv/kvm/vcpu_sbi_replace.c
index 2c456e26f6ca..506a510b6bff 100644
--- a/arch/riscv/kvm/vcpu_sbi_replace.c
+++ b/arch/riscv/kvm/vcpu_sbi_replace.c
@@ -185,10 +185,3 @@ const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_srst = {
 	.extid_end = SBI_EXT_SRST,
 	.handler = kvm_sbi_ext_srst_handler,
 };
-
-const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_dbcn = {
-	.extid_start = SBI_EXT_DBCN,
-	.extid_end = SBI_EXT_DBCN,
-	.default_disabled = true,
-	.handler = kvm_riscv_vcpu_sbi_forward_handler,
-};
-- 
2.43.0


