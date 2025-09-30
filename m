Return-Path: <linux-kernel+bounces-837177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB83BABA06
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 08:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C493D7A8E25
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 05:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928D12853F9;
	Tue, 30 Sep 2025 06:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hAb3/aFp"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC9228C869
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 06:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759212032; cv=none; b=RCgVOnE855NF9ktzxvEtM2WO/nbnuMyTqucTwn3bzWcFBUTI2Hk4dyl2pmEQi7VsBLhHl5/9qjKcRX1K1xm3eqqNrjmfNhRhFQ9KLyU3dHoOhwEBICuX7tR9zpM8nkcSy5x9YanIBQDO9orZn0PgofQnuVEOcQV1JarxeSec1Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759212032; c=relaxed/simple;
	bh=megoui3FrcgMHtvlQs49ApxPOBMbnJrOEUpVHigRQTk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BJIROqTxjmm1EFmS9ydYx3Uyqz6qYXkDfVBL0ct771rVM7+UE73tKT5uHv0JEYoMwGriJR/GdPsC1tYf5Kz+eRXaJl6YPuNoPPk8AXP4KFNYweT3MlmuA+thXTLOrHvPtOWJCUea3Dg+Veuly5HtY1uhMMp+u9dkx1n8nAu865w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hAb3/aFp; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b550a522a49so4922567a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 23:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759212030; x=1759816830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+baDWNJ3e+prJbakC2u9YwdVipZEa6rsDQvMsjkRx4g=;
        b=hAb3/aFpORT/46qcoQWs5kuerB9oeCvhla6UvwCaSVxVPFIep5JHTBm9129Uc3yY2e
         0gO0WCQ1pibTjPSwTnf+XtC0C0B94gWQ/lzAI3lklHFWGDGHcQq6rFVr4sb+yn9lxbLu
         Cdrfp527Bv3+CBXWX5pj5L4NY/h9Jq4lP+GeRozDkvwfcfZt7LD7VllvxsIb47ncBnrO
         WsfxTQ+lrDh1RlzkUjpEHOz1pd2DMXguwzHNA5ToDtbSKlnRGQkOW4O9uA0yXBY/mxlR
         ko3vnrYlhzvgghpw5dFrPCBw4/O1qtbK+XyxGhTxod7+k/93QI4nOIOzAPLOgfhoC+bK
         R0lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759212030; x=1759816830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+baDWNJ3e+prJbakC2u9YwdVipZEa6rsDQvMsjkRx4g=;
        b=hTOuBgkQwnlI5LLPpTZPM6QUJ0eb0rOh/Upnv4z/HS0wSsNsBVTLNnSDAqUm5VVav0
         U54t4O9lSgKJN8wTRTNZxzOuCzegFQ3/tJitKce4XCV4Tawyw0QOCF1Rji/hNCAS5u+3
         OrQnQx5QvINiNzFWnzOVVDPxQjjqm9ZODCuPaTiYMY5kWFUFSLEg/ZOOers8p80y1kXD
         EKP0ngzm3NjljRgt5pYNac1Kyl/OSUK2/AmDiezDcUeaPTdaPmSaahzfSHS5bqmOkbFs
         1gSpgRoOaTg0ebbq4t3CT565wrSTGouslDUBxuk6z6UsT9UHK+6rcVNXhk7kJRzQdbvO
         1ybw==
X-Forwarded-Encrypted: i=1; AJvYcCUrTU4YfUzSaZxsyXC4hFmfTr6j7sHTcNoqHo8HjT57cUl2wTAAwcfnEKaEWQDWEpKudfrEMzRe2N1mbDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXRPr0W461hqcBUosEe+JqsX9GEMJkPwpdjgEbd/i5Jn3nhCEH
	K2omzd9hXs7NrhEJ1i9ExC7EbYhDFJ3kudIsAvEuCL7K/j7XCeG1dIuE
X-Gm-Gg: ASbGncsCcVVfXVbT19BGolPDQAJ2GUSOP1vq6Zt+cDw8lwsWR3bFoGwd8106y01g/+u
	OTHFY8YsBgimRjypdWnl45DEEpHiTtT1nknIfT07Ai9rwdfDdtGdephDJklXI2U4Ii+9frBNfPF
	rgsqvC2ca7iG8QtQIjzUV8I5wZTvnf1bQb3p62qDjp4bv5/i+5lmwpcdwFSdb0HecutbUGxAj/n
	LdXKwjeFNmFQ80kP/Ewa1axXYNKd2MmVtvNQm0naEiWty8t3G7e6DMn7GtnyTV6WP5Sr+KROrdK
	5czPE4D08lYQvBt7SYOHwrTKAy0k2o9nA7L+jcwPfhG1fERkskmPheFdX7r3u0H9q6huGrGVdfn
	ulPBn6OskULZYhBCSuIW1dsjEPlxCNGE7WOuOn5+Tl8wl17+ViW2oW34XxsvXyESfneohN4HgNH
	kP0KLPDnJKVZpjZICVJliEGr5hpzU=
X-Google-Smtp-Source: AGHT+IF3u3CwEhxn4obFOsd5k7ipKHjSB6CIP+P0m/CZ4RrSdU6mgZTJEKlhFteu0bsxBMQFdSQa/A==
X-Received: by 2002:a17:902:db04:b0:265:9878:4852 with SMTP id d9443c01a7336-27ed49ddab3mr250832865ad.15.1759212030159;
        Mon, 29 Sep 2025 23:00:30 -0700 (PDT)
Received: from localhost.localdomain ([61.171.228.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66d43b8sm148834065ad.9.2025.09.29.23.00.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Sep 2025 23:00:29 -0700 (PDT)
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
	lance.yang@linux.dev,
	rdunlap@infradead.org
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v9 mm-new 10/11] selftests/bpf: add test cases for invalid thp_adjust usage
Date: Tue, 30 Sep 2025 13:58:25 +0800
Message-Id: <20250930055826.9810-11-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20250930055826.9810-1-laoar.shao@gmail.com>
References: <20250930055826.9810-1-laoar.shao@gmail.com>
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
index 409ffe9e18f2..90af0322f775 100644
--- a/tools/testing/selftests/bpf/prog_tests/thp_adjust.c
+++ b/tools/testing/selftests/bpf/prog_tests/thp_adjust.c
@@ -3,6 +3,9 @@
 #include <sys/mman.h>
 #include <test_progs.h>
 #include "test_thp_adjust.skel.h"
+#include "test_thp_adjust_sleepable.skel.h"
+#include "test_thp_adjust_trusted_vma.skel.h"
+#include "test_thp_adjust_trusted_owner.skel.h"
 
 #define LEN (16 * 1024 * 1024) /* 16MB */
 #define THP_ENABLED_FILE "/sys/kernel/mm/transparent_hugepage/enabled"
@@ -277,4 +280,8 @@ void test_thp_adjust(void)
 		subtest_thp_policy_update();
 
 	thp_adjust_destroy();
+
+	RUN_TESTS(test_thp_adjust_trusted_vma);
+	RUN_TESTS(test_thp_adjust_trusted_owner);
+	RUN_TESTS(test_thp_adjust_sleepable);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_thp_adjust_sleepable.c b/tools/testing/selftests/bpf/progs/test_thp_adjust_sleepable.c
new file mode 100644
index 000000000000..e3d70f258d84
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
+int BPF_PROG(thp_sleepable, struct vm_area_struct *vma, enum tva_type type,
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


