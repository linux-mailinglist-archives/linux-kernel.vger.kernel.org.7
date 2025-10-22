Return-Path: <linux-kernel+bounces-864436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3ECDBFACBA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 235EC1A02468
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192E9304BB4;
	Wed, 22 Oct 2025 08:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="StaWj+dM"
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D86303A20
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761120396; cv=none; b=upiD150jSiSASonELFIQQNp0nI96W7iSfwnO+d40p/k+OgtxJK3m6s8MJJurU9LlIrFP9z2LjAB/Tii9RUQ7nbsH8AfygA7abFYu0QRkJBVq5f5IeIWiK7v+e/CZCrLybq/NJ0TdMEB7eS2Vxl/QxJwfpxxJYlCTEpHRZtS5lLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761120396; c=relaxed/simple;
	bh=sNkqvWFZREdMBLQ3AIWEE/1KJDAUFoNwSeleCzyx3rY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PpXG6xSxPPNZcH+bL0bTdOh8Rl89VO2AyFoLymUO5NSsqhmnEgB04MvbqXpVApUIj09Pf8H17mwKdD83LzbJ+HLeGXGXk/aIEsUuTO+kQP0ta/NrWkjuWxOMLzEAE1diHVa2HZsNBvADWiIcSToYmsV7BjpLkLZr0IkH50KoskQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=StaWj+dM; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-b550a522a49so5377041a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 01:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761120394; x=1761725194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pj3PqdoyeYD41VexbkIcBOe8O/AiBTjuvETCCqlLiZw=;
        b=StaWj+dMNPuQIXort2DrGNecAmkAqYMLydl6wHVDJ6N1JRelnE0pcwWwNKSsCz5mSr
         2COawpS/QlkpXclRqMvROOY4yRw/WMOIj7UmkCncgM3aOknWYq8dhpsZkTtrJHS6GRDi
         bLak/cg5Kdyzxip6rMgbajU1ffcLv4NEiER/Jk4Y/DC4r9mRLdaZ5f6d0n79gahUl0+X
         hCA6tKT09AdeyhAB6K7fE7jO7N/7MWtXJw3H3Z704dN1fTjm15eeV107RFQ4D/7821Gt
         7LaiQ2y5DKGD5lCle8yX3fw2cvnuzUlMPlyzNENOnfn49r720cPGh4bL7xJcdDeIm0ff
         AMPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761120394; x=1761725194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pj3PqdoyeYD41VexbkIcBOe8O/AiBTjuvETCCqlLiZw=;
        b=ZHO60fYJhcAtPB4FEzMxSOh49py1OX5tX3dwVJWOIeuKYfg2B2lQ91nXa9ypobtjNn
         RwSruFi5cCSpziANSuv4nii3P+/54fV3Cjp3gngY008+UZDrHz99x/9IbTuARVyXSiWd
         S8aJwEIDxOQmf5VshclB9pzDLa6bPlCAxaJ0kjaVCBg6ANcSMQGC25fw1b8/rl2J2mB4
         5Na5EJ50nxgRh4P24tNMKH+EaTaMqcyYqzxPjA46No8O3t8GWb2IneJU6HW5DrQGwh1f
         fJN2ny3TF3xMYcBsLMtAmvNQx7KJyQ3ahShpb5QuZV+BhLG9cMY+srnMlhYYFijrMUmi
         Ob/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUOxTFoI4K7uIjVlsXYIvki9ne109MULiAlHc2jWdF1el8P/pFWYNvkAX98BT0qcgrt4EBXTqJMnxvquvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuSPGIgm9qhheZZmIy5EZ+jhjgv9VH6XbjmiJxUgKxiAZ8B/Bh
	9rwVYxwBPQoO5R5fbW6sLAdwqi/AZsnw8juqtuDsCTZJvTxr3IQpIZKD
X-Gm-Gg: ASbGnctS7WHrvv09TgPL/7AebbEK5w1CBe8q08iB5NGQgY3PBk+lUaohPijAQlxFGTd
	rfSDjbPaCxFhUE2t1SvB3GBF80cHqoC8NnW4EeyX8vDhMMQB2BAbe2ziBg0HB7qM1N288Enrt1W
	9MFo0eAQzRzMvucyzYl2J1rR6k7G1F09+65MeI8s+pcbVGvqsQKdXZYiVQlh0/fuwkUtWf9tb/J
	HttSRqA7qkQriJN97GBAoSSPns9KmZBLDdPBQt2hUMFdZKV3QN2pUL4au54jEOkwVK7ZkOvMKyJ
	u2ToCd+A4dHFyr96JZUslId1clzSOV06HlI60tzIkD55/OqYkMP1ErNekpqFBB+SsGPlcGH/nRa
	4b5cXKQjcaHghmrXTqV1wqTHplvjtI1Hk9p7En8iJAmtxhBeK2v9d9z3v/cGDh6cDFqBuw540Dt
	hzxeCdTzUp2vfPQM+GLg==
X-Google-Smtp-Source: AGHT+IEx9dln9OcfazCD+KhBAdzPTNAjHcl9Ith5YJQLotbdTFdeHDdjLcTWNqCThfFIBzRVF0YLPA==
X-Received: by 2002:a17:90a:d44c:b0:336:9dcf:ed14 with SMTP id 98e67ed59e1d1-33bcf8e3b0emr27655601a91.23.1761120393655;
        Wed, 22 Oct 2025 01:06:33 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e223c7fb5sm1805330a91.2.2025.10.22.01.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 01:06:33 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	jolsa@kernel.org
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	mattbobrowski@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	leon.hwang@linux.dev,
	jiang.biao@linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 10/10] selftests/bpf: add testcase for mixing fsession, fentry and fexit
Date: Wed, 22 Oct 2025 16:06:13 +0800
Message-ID: <20251022080613.555463-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251022080613.555463-1-dongml2@chinatelecom.cn>
References: <20251022080613.555463-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test the fsession when it is used together with fentry, fexit.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 .../selftests/bpf/prog_tests/fsession_test.c  | 32 +++++++++++++
 .../selftests/bpf/progs/fsession_mixed.c      | 45 +++++++++++++++++++
 2 files changed, 77 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/fsession_mixed.c

diff --git a/tools/testing/selftests/bpf/prog_tests/fsession_test.c b/tools/testing/selftests/bpf/prog_tests/fsession_test.c
index 549b6fdd6167..5529e4236b7c 100644
--- a/tools/testing/selftests/bpf/prog_tests/fsession_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/fsession_test.c
@@ -3,6 +3,7 @@
 #include <test_progs.h>
 #include "fsession_test.skel.h"
 #include "fsession_cookie.skel.h"
+#include "fsession_mixed.skel.h"
 
 static int check_result(struct fsession_test *skel)
 {
@@ -114,6 +115,35 @@ static void test_fsession_cookie(void)
 	fsession_cookie__destroy(skel);
 }
 
+static void test_fsession_mixed(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	struct fsession_mixed *skel = NULL;
+	int err, prog_fd;
+
+	skel = fsession_mixed__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "fsession_mixed__open_and_load"))
+		goto cleanup;
+
+	err = fsession_mixed__attach(skel);
+	if (!ASSERT_OK(err, "fsession_mixed_attach"))
+		goto cleanup;
+
+	prog_fd = bpf_program__fd(skel->progs.test1);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	if (!ASSERT_OK(err, "test_run_opts err"))
+		goto cleanup;
+	if (!ASSERT_OK(topts.retval, "test_run_opts retval"))
+		goto cleanup;
+
+	for (int i = 0; i < sizeof(*skel->bss) / sizeof(__u64); i++) {
+		if (!ASSERT_EQ(((__u64 *)skel->bss)[i], 1, "test_result"))
+			goto cleanup;
+	}
+cleanup:
+	fsession_mixed__destroy(skel);
+}
+
 void test_fsession_test(void)
 {
 #if !defined(__x86_64__)
@@ -126,4 +156,6 @@ void test_fsession_test(void)
 		test_fsession_reattach();
 	if (test__start_subtest("fsession_cookie"))
 		test_fsession_cookie();
+	if (test__start_subtest("fsession_mixed"))
+		test_fsession_mixed();
 }
diff --git a/tools/testing/selftests/bpf/progs/fsession_mixed.c b/tools/testing/selftests/bpf/progs/fsession_mixed.c
new file mode 100644
index 000000000000..226e8ca438d4
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/fsession_mixed.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 ChinaTelecom */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+__u64 test1_entry_result = 0;
+__u64 test1_exit_result = 0;
+
+SEC("fsession/bpf_fentry_test5")
+int BPF_PROG(test1, __u64 a, void *b, short c, int d, __u64 e, int ret)
+{
+	__u64 *cookie = bpf_fsession_cookie(ctx);
+
+	if (!bpf_tracing_is_exit(ctx)) {
+		test1_entry_result = a == 11 && b == (void *)12 && c == 13 && d == 14 &&
+			e == 15 && ret == 0;
+		*cookie = 0x123456ULL;
+		return 0;
+	}
+
+	test1_exit_result = a == 11 && b == (void *)12 && c == 13 && d == 14 &&
+		e == 15 && ret == 65 && *cookie == 0x123456ULL;
+	return 0;
+}
+
+__u64 test2_result = 0;
+SEC("fexit/bpf_fentry_test5")
+int BPF_PROG(test2, __u64 a, void *b, short c, int d, __u64 e, int ret)
+{
+	test2_result = a == 11 && b == (void *)12 && c == 13 && d == 14 &&
+		e == 15 && ret == 65;
+	return 0;
+}
+
+__u64 test3_result = 0;
+SEC("fentry/bpf_fentry_test5")
+int BPF_PROG(test3, __u64 a, void *b, short c, int d, __u64 e)
+{
+	test3_result = a == 11 && b == (void *)12 && c == 13 && d == 14 &&
+		e == 15;
+	return 0;
+}
-- 
2.51.1.dirty


