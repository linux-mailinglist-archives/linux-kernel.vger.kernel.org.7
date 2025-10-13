Return-Path: <linux-kernel+bounces-849865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C38BD120F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 03:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01A693BEDE3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 01:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2A3271473;
	Mon, 13 Oct 2025 01:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WNfIEyxo"
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF1F274643
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 01:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760320344; cv=none; b=TOAjgCfOAPQ6yZouvEGWMCSjUqZlZi4J0Nwq7w4Snxj5Sfjv2fNd7xZzvyUbXZORzRRgm5bq0KI6N6BBS33OiWyadDjuta3bbHtsbsYytgFu7Kl36A+FnT4XsDDz0Ky137aNbSjIK9Uq/8ZgcO+EbWs4+8CUl7H1RL9pP7xfcac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760320344; c=relaxed/simple;
	bh=KXynVc/l4z0I/0afxLQ1qgxkhnxUen6TcUANd7bwj6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dkio4NXfT6CntixHrPMvhBAok8k7/MH37I57nDnl9ssQj4zK4WGC+cDjfJqFAqYS4LBWvDiUIgJUw8vpnvRN4Hwrgkhvpb3YIGVIOiirn9eQJx/8iY2ozcXCV2m4FaxEb5IWk9eT/frzhw7q1MmbdH0qSeke26/qN0md9LR1+UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WNfIEyxo; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-27ee41e0798so60179985ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 18:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760320341; x=1760925141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aBZqKJ/asg/RWAeGZDfmIrxp30oaYR/dgJdIlWzmC0w=;
        b=WNfIEyxoTVjddxmDF1nJhO6yQBze65YXAKa1DvD+wUVKLocTNvYRyURkb5OOOW0rW/
         MkfF1OqN1KAdgrRZH5VlbwKjxdR8mNugH/UMZ2Z3BesKMzqYAlE7Yau2Mub8VMnJklKH
         M15C31YoEmKFDlzn2WaioAcJI240RY0oLRrI+/eJ3s+GkcdAgXzUX1W1dKtEBsyQjmjg
         jXInxY1rxNzOZbpbm1B9adg/m89kh2Gk0lU9VRWVvStNosRPqKF6VCjv3cKOCToThnaV
         TQNxOmwggW/Hm67nrvhIDXjy9tahEhCyB/XVpV9uUQofvF1b35qkXiwiuHKX/op7ktdj
         3N+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760320341; x=1760925141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aBZqKJ/asg/RWAeGZDfmIrxp30oaYR/dgJdIlWzmC0w=;
        b=ANLlrW1HpAjGAvtZZh4Yj9b/Lb0ZRMkkdwgPbQEyiZxtb5TeIOBxgRNEM+gGt9HHlj
         nIJcrbwkHMA8pjVmpiUUytD94tu60fDQnmlpuno0qRNAOgPLZvUcNgYuH7LfyR0iCLkW
         44KoZgQpFkkUT9YloCcMdl/D49FzBp6lhD9t0wTiNLuY/XO5iqgE4/MGkN0yvrNkuzCH
         1Ghdo//IM0sUwwwMK52f0TbrdkW/GOuSUuQZrhe7rFyM1zTQIhemHY6cQ17Qq3d1HiVc
         eIsUvPkS6Nl34N5gpYm7XW/od7RK65Yco1soxV6DnlzoW0+wrH8Xm4V+E3Fxw92pgH6x
         i5BQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwlwadUIg1v98Oa28HooQVYqxlw6JrMCJOGejciTbM6xW2SnV1HNv5wqMrMnSfyhzS7jLAGqG7CihHtsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL5vGRryvOFZ3Rj/TOPsxzSohXdAbEXW0GPgyTHqEHrF+XrvNn
	m65Wryk9lrPQhAoT9VcRx58QVu1aFTWOnDhBiIKPOP0Ffg26+OGUK/LT
X-Gm-Gg: ASbGncuxllvbVyhPJAxib7C05BBRjTXlHQ05zzgTs8DHcoymXOFCUUjfE5N6uwkyw0t
	D+CTr7uueNALHnmj5UtYkJpVdQRxncKUJ4K9S+lUDHnKIfL6JSJK3WetaOCawlqr4uddtlnrsNI
	LmmzzFUjk9RUzmRLmjuisrcAO8qEf6PVSP0tw1yuZLPUsQCgfueh+nwFKm8tOvMyHozweXU9sgM
	Mta8YnZQj5lsnmUxbFOskKXM7b2C8ttBrn3t9cNQnrsXzbNsKI3INyXaH2YsmpM6PK2XeiP4/C3
	Y4aiHeQDJeCKiAR3N/YTPwfZ005gQgjzmBRjeFK2azyHbB6+tyT6WS+w0pYy3AOARDQxXWqi9Ws
	xJIMDpyIUzUnbit5aynTtpkOEWZ6gmIVL3QHt/GXDHA==
X-Google-Smtp-Source: AGHT+IG0OBHQAlbS9opbTzuG1IHDgaFt3docgqywj3nlM2f/kPmiwXzx6GvTMtpNFzMpjE2za6EI/g==
X-Received: by 2002:a17:903:1b2e:b0:27b:472e:3a22 with SMTP id d9443c01a7336-2902741cd22mr257155465ad.56.1760320340728;
        Sun, 12 Oct 2025 18:52:20 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034deaa54sm117224925ad.5.2025.10.12.18.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 18:52:20 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiang.biao@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] lib/test_fprobe: add testcase for mixed fprobe
Date: Mon, 13 Oct 2025 09:52:09 +0800
Message-ID: <20251013015209.30949-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013015209.30949-1-dongml2@chinatelecom.cn>
References: <20251013015209.30949-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the testcase for the fprobe, which will hook the same target with two
fprobe: entry, entry+exit. And the two fprobes will be registered with
different order.

fgraph and ftrace are both used for the fprobe, and this testcase is for
the mixed situation.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 lib/tests/test_fprobe.c | 99 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 98 insertions(+), 1 deletion(-)

diff --git a/lib/tests/test_fprobe.c b/lib/tests/test_fprobe.c
index cf92111b5c79..108c7aa33cb4 100644
--- a/lib/tests/test_fprobe.c
+++ b/lib/tests/test_fprobe.c
@@ -12,7 +12,8 @@
 
 static struct kunit *current_test;
 
-static u32 rand1, entry_val, exit_val;
+static u32 rand1, entry_only_val, entry_val, exit_val;
+static u32 entry_only_count, entry_count, exit_count;
 
 /* Use indirect calls to avoid inlining the target functions */
 static u32 (*target)(u32 value);
@@ -190,6 +191,101 @@ static void test_fprobe_skip(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, 0, unregister_fprobe(&fp));
 }
 
+/* Handler for fprobe entry only case */
+static notrace int entry_only_handler(struct fprobe *fp, unsigned long ip,
+				      unsigned long ret_ip,
+				      struct ftrace_regs *fregs, void *data)
+{
+	KUNIT_EXPECT_FALSE(current_test, preemptible());
+	KUNIT_EXPECT_EQ(current_test, ip, target_ip);
+
+	entry_only_count++;
+	entry_only_val = (rand1 / div_factor);
+
+	return 0;
+}
+
+static notrace int fprobe_entry_multi_handler(struct fprobe *fp, unsigned long ip,
+					      unsigned long ret_ip,
+					      struct ftrace_regs *fregs,
+					      void *data)
+{
+	KUNIT_EXPECT_FALSE(current_test, preemptible());
+	KUNIT_EXPECT_EQ(current_test, ip, target_ip);
+
+	entry_count++;
+	entry_val = (rand1 / div_factor);
+
+	return 0;
+}
+
+static notrace void fprobe_exit_multi_handler(struct fprobe *fp, unsigned long ip,
+					      unsigned long ret_ip,
+					      struct ftrace_regs *fregs,
+					      void *data)
+{
+	unsigned long ret = ftrace_regs_get_return_value(fregs);
+
+	KUNIT_EXPECT_FALSE(current_test, preemptible());
+	KUNIT_EXPECT_EQ(current_test, ip, target_ip);
+	KUNIT_EXPECT_EQ(current_test, ret, (rand1 / div_factor));
+
+	exit_count++;
+	exit_val = ret;
+}
+
+static void check_fprobe_multi(struct kunit *test)
+{
+	entry_only_count = entry_count = exit_count = 0;
+	entry_only_val = entry_val = exit_val = 0;
+
+	target(rand1);
+
+	/* Verify all handlers were called */
+	KUNIT_EXPECT_EQ(test, 1, entry_only_count);
+	KUNIT_EXPECT_EQ(test, 1, entry_count);
+	KUNIT_EXPECT_EQ(test, 1, exit_count);
+
+	/* Verify values are correct */
+	KUNIT_EXPECT_EQ(test, (rand1 / div_factor), entry_only_val);
+	KUNIT_EXPECT_EQ(test, (rand1 / div_factor), entry_val);
+	KUNIT_EXPECT_EQ(test, (rand1 / div_factor), exit_val);
+}
+
+/* Test multiple fprobes hooking the same target function */
+static void test_fprobe_multi(struct kunit *test)
+{
+	struct fprobe fp1 = {
+		.entry_handler = fprobe_entry_multi_handler,
+		.exit_handler = fprobe_exit_multi_handler,
+	};
+	struct fprobe fp2 = {
+		.entry_handler = entry_only_handler,
+	};
+
+	current_test = test;
+
+	/* Test Case 1: Register in order 1 -> 2 */
+	KUNIT_EXPECT_EQ(test, 0, register_fprobe(&fp1, "fprobe_selftest_target", NULL));
+	KUNIT_EXPECT_EQ(test, 0, register_fprobe(&fp2, "fprobe_selftest_target", NULL));
+
+	check_fprobe_multi(test);
+
+	/* Unregister all */
+	KUNIT_EXPECT_EQ(test, 0, unregister_fprobe(&fp1));
+	KUNIT_EXPECT_EQ(test, 0, unregister_fprobe(&fp2));
+
+	/* Test Case 2: Register in order 2 -> 1 */
+	KUNIT_EXPECT_EQ(test, 0, register_fprobe(&fp2, "fprobe_selftest_target", NULL));
+	KUNIT_EXPECT_EQ(test, 0, register_fprobe(&fp1, "fprobe_selftest_target", NULL));
+
+	check_fprobe_multi(test);
+
+	/* Unregister all */
+	KUNIT_EXPECT_EQ(test, 0, unregister_fprobe(&fp1));
+	KUNIT_EXPECT_EQ(test, 0, unregister_fprobe(&fp2));
+}
+
 static unsigned long get_ftrace_location(void *func)
 {
 	unsigned long size, addr = (unsigned long)func;
@@ -217,6 +313,7 @@ static struct kunit_case fprobe_testcases[] = {
 	KUNIT_CASE(test_fprobe_syms),
 	KUNIT_CASE(test_fprobe_data),
 	KUNIT_CASE(test_fprobe_skip),
+	KUNIT_CASE(test_fprobe_multi),
 	{}
 };
 
-- 
2.51.0


