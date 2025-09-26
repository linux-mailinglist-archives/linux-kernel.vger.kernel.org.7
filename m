Return-Path: <linux-kernel+bounces-833836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF14BA32F9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 11:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E088B7BA767
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 09:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A7D2C21E1;
	Fri, 26 Sep 2025 09:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AeGIC4dX"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2342BE620
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 09:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758879319; cv=none; b=NsIc6CaqQanyZ7n56xVwZflNAnJMCg0OXUGnQTV1DNCKJYCPu9CzrXtQYPAELjBruYfwi2Trv3E2lfqk/sxYKtX67Kr7p/y3lvPPuhLkHm6/Fe4o68dDrnRH5xso2ZPwfy8U9qSw3qPmD7KYh2zxUhzrMX21XR8SjmFCf3S2HHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758879319; c=relaxed/simple;
	bh=aHAHaqsBoprnxz9EY70FLRuOd/jhpKeP2yAc03cB17I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N5Liy23oY6aW5aytFFYgPZd5zUlYWE+oF3AuUyn3WM9iyb0tRXBAhUU904rujWV2FBklpzm0C/BIU6s9UAiQZQdoOh/x1+YoxrYmtrqy2kVOxIYGrOyhvXhgQJTJL2z5Sv4kYPKLXxZep846TOf+cWZz3ilEsZLIVuxqsv/cNNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AeGIC4dX; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2570bf6058aso28217175ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 02:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758879317; x=1759484117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GjEsZ2zZ0gswTTfZGuAqtKyUugB4UMlIc5tO04MQRtQ=;
        b=AeGIC4dXsbF8f+pw/D7Qxws7M/v3fplxR7zs5QfeS6hEfwwmkBeu68kQkHSuJCHTuo
         jOwsk7UtFOS1WiIGBXkAM5vKsVvxo4ERoyboFTqtH95hfl7WDWhrC7juwfAOLNRQPDOA
         sq4KT49lfjxBkG/7xan6SYOnxABt0vpXOx4sA5srEPnMG5zgABzPuyXZoabqIhFWJc9s
         +DvL4c5tlPiIhrMjcyzY9poC5/Ce7Fo98Ufa1kQRTz+Rz9VZFjjY9ORFw2JJIdu0YGXZ
         VOlV6gL+pQ09Qh7WoUYbXKz8pZmDIprhSmuSdSjVesM6BGfy4RK8lpd8EjxHoO4JavDm
         TzRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758879317; x=1759484117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GjEsZ2zZ0gswTTfZGuAqtKyUugB4UMlIc5tO04MQRtQ=;
        b=loCmqbL8hnHWwdpSZeBGBcrcfBgb9Pwh5M7iTH68EY3OS3uftT4Gq2QIspMK1vjTzP
         a3rRTy1mXhmh8cnyU1pkWyT7J8eKWDmuYoEBjxKIdFJAk9E/Jpi82k1km/ics73V+/Ll
         lVZU5kPLU+CZ1zo7/g9f/Y8XW3rH7GF6KC3pmyWcizdRnH0dY7M1ftlc/mrXG3iv5IFZ
         qoHvP8FTyO0AUK2t/SU7zB4Dxd8heEhqvqLVCgFChAHBKXtug+DMBVQv5bZhdH2CrvA0
         BJuA/CEpreOO1qiEYFBiZ1Gjdmt4y1HupNBeb/Z6sbCRCW7BRlDWF6oQ5l/aKpd9gz4H
         htrA==
X-Forwarded-Encrypted: i=1; AJvYcCUIyuAaELbJJv72mIU8kaqnbtpqe1p8n072cxsy//XveuoD2p10sqWD10CYQfQJS9Ef8fnP8iv1Ef23IdM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBxmaZ45YKHn1ilLBRRuJKYY4ByGGKbNgUzWfln6a8UUAa5Hq7
	M7vbWkLY6iCJ0OdNCcH+m8pTZy1hYE8OZjHyNxhhT2HXhTuzzaGLlGVt
X-Gm-Gg: ASbGncscv3mFAeDOdG+foo2iZwAH/o7emkL7vlV83cYjCcUOXzkzSwD8/3KDflFRBhM
	sxJ9WrtOr9P3WyFSjLcOXRAWnqQ4Q6d0ZuXF9apToJfdTHPfgcbDHv1YadVroGS7foTdB8lSjO+
	B6R6g57SomJOfr4pV+cTrFhFffOQ0d10CAQQbh7z7RFWhyt4yr8diNjmhFP64SpwGjaVzDm4j/Z
	6+aWuATh8+/m/y/WZYZqpnqwABr6Z0XAUJ/PRpl+TUx5FCCLWhRxYNt66UOKvHCU4xqJYuI87YP
	WyD0/ifESskLj00MlDncnLghL1VfSI8ST7MR6VonQOcNxOQwrs2IkYe20kGWvw8yPiRIE0pkumq
	ltxBvgsQlQ65bQZ9NAxal+3/OP+hBTuZw3O82Khu8rPFiN4XNsKQ3fAwGa+5LZdnZpQQf6a62cV
	GQRMhXzUBZm7RB
X-Google-Smtp-Source: AGHT+IGyv8obkrIygTqJyqvVbel1FZKkyg7zW+CRqiZxE8ebTcWIuicJPPFReDEq4JzQ2A2SZCWUTg==
X-Received: by 2002:a17:903:2847:b0:269:4741:6d33 with SMTP id d9443c01a7336-27ed49d2c35mr46947235ad.23.1758879317548;
        Fri, 26 Sep 2025 02:35:17 -0700 (PDT)
Received: from localhost.localdomain ([2409:891f:1c21:566:e1d1:c082:790c:7be6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66cda43sm49247475ad.25.2025.09.26.02.35.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 26 Sep 2025 02:35:17 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	hannes@cmpxchg.org,
	usamaarif642@gmail.com,
	gutierrez.asier@huawei-partners.com,
	willy@infradead.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	ameryhung@gmail.com,
	rientjes@google.com,
	corbet@lwn.net,
	21cnbao@gmail.com,
	shakeel.butt@linux.dev,
	tj@kernel.org,
	lance.yang@linux.dev
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v8 mm-new 11/12] selftests/bpf: add test cases for invalid thp_adjust usage
Date: Fri, 26 Sep 2025 17:33:42 +0800
Message-Id: <20250926093343.1000-12-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20250926093343.1000-1-laoar.shao@gmail.com>
References: <20250926093343.1000-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

1. The trusted vma->vm_mm pointer can be null and must be checked before
   dereferencing.
2. The trusted mm->owner pointer can be null and must be checked before
   dereferencing.
3. Sleepable programs are prohibited because the call site operates under
   RCU protection.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 .../selftests/bpf/prog_tests/thp_adjust.c     |  7 +++++
 .../bpf/progs/test_thp_adjust_sleepable.c     | 22 ++++++++++++++
 .../bpf/progs/test_thp_adjust_trusted_owner.c | 30 +++++++++++++++++++
 .../bpf/progs/test_thp_adjust_trusted_vma.c   | 27 +++++++++++++++++
 4 files changed, 86 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/test_thp_adjust_sleepable.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_thp_adjust_trusted_owner.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_thp_adjust_trusted_vma.c

diff --git a/tools/testing/selftests/bpf/prog_tests/thp_adjust.c b/tools/testing/selftests/bpf/prog_tests/thp_adjust.c
index 72b2ec31025a..2e9864732c11 100644
--- a/tools/testing/selftests/bpf/prog_tests/thp_adjust.c
+++ b/tools/testing/selftests/bpf/prog_tests/thp_adjust.c
@@ -4,6 +4,9 @@
 #include <sys/mman.h>
 #include <test_progs.h>
 #include "test_thp_adjust.skel.h"
+#include "test_thp_adjust_sleepable.skel.h"
+#include "test_thp_adjust_trusted_vma.skel.h"
+#include "test_thp_adjust_trusted_owner.skel.h"
 
 #define LEN (16 * 1024 * 1024) /* 16MB */
 #define THP_ENABLED_FILE "/sys/kernel/mm/transparent_hugepage/enabled"
@@ -278,4 +281,8 @@ void test_thp_adjust(void)
 		subtest_thp_policy_update();
 
 	thp_adjust_destroy();
+
+	RUN_TESTS(test_thp_adjust_trusted_vma);
+	RUN_TESTS(test_thp_adjust_trusted_owner);
+	RUN_TESTS(test_thp_adjust_sleepable);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_thp_adjust_sleepable.c b/tools/testing/selftests/bpf/progs/test_thp_adjust_sleepable.c
new file mode 100644
index 000000000000..4db78f2f0b2d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_thp_adjust_sleepable.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+SEC("struct_ops.s/thp_get_order")
+__failure __msg("attach to unsupported member thp_get_order of struct bpf_thp_ops")
+int BPF_PROG(thp_sleepable, struct vm_area_struct *vma, enum tva_type tva_type,
+	     unsigned long orders)
+{
+	return -1;
+}
+
+SEC(".struct_ops.link")
+struct bpf_thp_ops vma_ops = {
+	.thp_get_order = (void *)thp_sleepable,
+};
diff --git a/tools/testing/selftests/bpf/progs/test_thp_adjust_trusted_owner.c b/tools/testing/selftests/bpf/progs/test_thp_adjust_trusted_owner.c
new file mode 100644
index 000000000000..88bb09cb7cc2
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_thp_adjust_trusted_owner.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+SEC("struct_ops/thp_get_order")
+__failure __msg("R3 pointer arithmetic on rcu_ptr_or_null_ prohibited, null-check it first")
+int BPF_PROG(thp_trusted_owner, struct vm_area_struct *vma, enum tva_type tva_type,
+	     unsigned long orders)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	struct task_struct *p;
+
+	if (!mm)
+		return 0;
+
+	p = mm->owner;
+	bpf_printk("The task name is %s\n", p->comm);
+	return -1;
+}
+
+SEC(".struct_ops.link")
+struct bpf_thp_ops vma_ops = {
+	.thp_get_order = (void *)thp_trusted_owner,
+};
diff --git a/tools/testing/selftests/bpf/progs/test_thp_adjust_trusted_vma.c b/tools/testing/selftests/bpf/progs/test_thp_adjust_trusted_vma.c
new file mode 100644
index 000000000000..df7b0c160153
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_thp_adjust_trusted_vma.c
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+SEC("struct_ops/thp_get_order")
+__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
+int BPF_PROG(thp_trusted_vma, struct vm_area_struct *vma, enum tva_type tva_type,
+	     unsigned long orders)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	struct task_struct *p = mm->owner;
+
+	if (!p)
+		return 0;
+	return -1;
+}
+
+SEC(".struct_ops.link")
+struct bpf_thp_ops vma_ops = {
+	.thp_get_order = (void *)thp_trusted_vma,
+};
-- 
2.47.3


