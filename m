Return-Path: <linux-kernel+bounces-818427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC94B5919F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 11:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D482F5265EC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 09:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5722BF012;
	Tue, 16 Sep 2025 09:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U8IoFben"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E84229BD9C
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 09:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758013295; cv=none; b=a7qebWFYFf3JfHVax1fZyYsjM4rP64Qkgi1yjqznjWvtzgE2OO61IFt5r9ltRZ5xDijFuAEV2NtWNRaR6+mCTTuoRKsjE5ghi6j9Z91DdtPGOSppil+QrwerrkkWnQ6nVwahY2B5skNWbYC5KBh1Nyei5PLYp6XuBnDHUrHIntw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758013295; c=relaxed/simple;
	bh=b4STATL0Uju972ND8+fFwA9UTCoZh60N0y2XfSf6TNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mFSMQZ3oWfvbHS+7FWV0dcHpdPv1xtUogzJFbBM67VHK9fjuk0yr5UAh6xAeF4n1O+YWYrE4xSgnB6oV9E9kOfbCxxQC6y5LioXyHXVOpvEW7QG2mH0THoKmDebiojiHKwfiH5NUA1tsaq0DDEq7S9lw7/9U5XHeBWbmh1fAwdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U8IoFben; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45f2c9799a3so13442705e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 02:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758013290; x=1758618090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=54a6vrNAUJqXpuCeRFEgTKA2RP5sTalC0x0PuLBwSM4=;
        b=U8IoFbenmzVYutBdqet8d9Ceo8HAGhVzkmj3bYsgqUZbOsbCpQgR8SXa36jpm8kmcg
         vBeBRCjDmwKisWBHwVKafk58CX5FnBKWO2qggwnm5SsPoMdRWHtf8KKgyAKs53Q5HIUA
         lsLqiLezkGPLY/keh6uhm0MdYECBt3UVpFhHKmJz0FKrEXvuHK5zFOFMCPV1ZtOn96HY
         Zwu/twwxnaXEyH9gLqlKxRVLSzmACRCuNiLW7q68p9NF4lSB0fH5GHTc1I+1B+s/Mc8M
         zFDWMy9PHoMbr/zmfj9s5n3nTpDVqCU6rQQ39dLrL03cGWF1GOI5d9e2J2kEYC8qZ8o4
         PHhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758013290; x=1758618090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=54a6vrNAUJqXpuCeRFEgTKA2RP5sTalC0x0PuLBwSM4=;
        b=tVGetRKZGy5iKkGVcA3GToxamG2Npqmo7gogQFrvgvaekNOdwJhBaDMr5GFWif5s9b
         6gufPJsUYkSf0FN1zWZX9CbQ8jBNHB0p2SOaHpg/ZFosEKlH8cTABRVI7AJVk81tjVzd
         O9u8yOIFIkL678Lbr9kVWtzwR1noMYbSRA+UlNxgfw0DN+LEKyxvVzzKX7Hy6N7kq2jR
         8JQDVxb2+p+eWEzT9BP12exobxHvWxabIRMKix+5sdjB+AVRLbP8eBkaWN+2419tpXxF
         obNIZ0zZFgWi+n07lFYRjkpVQErynChmjiulwwci0e2NUV7Dc+vSPFkIy46xtl+pyclU
         NtOg==
X-Forwarded-Encrypted: i=1; AJvYcCXTTNKIsQxiheIKRGMVxASVVAI1CMLFnbyUFP7QRs0cyFiXXTQqMDmfUQTF00A+w/iJftiOHvbB+YpTOQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI6L/eW8vyKYP0CsQS+wxwpZs/jznr7x4SWtt6S5/kkxEazsuS
	SbnF4+NYZPxnsBRqv+a4QtXSw+uc1HRj3iDeapegiuhLHTyTkG8cqUaf
X-Gm-Gg: ASbGncsN27CNejiEmJK0p0450OfTs/DUvP80Jz0gDph4V7Rm2jCbOD5BWI3jOnA4N5D
	QLSOhdSVyWZVkr/LAj6cwdFo7q6i9Xg8KTISEwKk9ZsqpOO41ZopjeQtgcm5Y+tHzt+KC5UfIwj
	VB6H4bFy50COqDja7195ZgNEXrsEzqhp3KQvniVbPoA2zjps2NdBSAkSKJReTe1GGqkqh7ROc0F
	nNG16XvNaGX2dz5P8VDoU1VY2vzAMVfumBaZK787vq4OFOb8MMo4P4H1i1zMqpgdMkl4qjMVo2C
	3zt5gE44+3zZb4Qff+N4myCAChWLphlyMkUlBZSsCh2fipYNlsKoQLU+8esq4zI5Pj5qXjDYfw9
	H3e72rfE0vFMwPuF5sAauiJ/BJRHZtWoEQv23zYwPYxu4D5IX4qvZHOW3UvRr3aQ3U8eIAKblAb
	I257YbDhZ69W+X
X-Google-Smtp-Source: AGHT+IGQ/nVkVKJ3q2nqGsYpu+DG+PZAA8Y4Ac4hVZt9d7cPYhzkDVimhmHreOcxPfvEMqJ6F549CQ==
X-Received: by 2002:a05:600c:4446:b0:45d:f7e4:bf61 with SMTP id 5b1f17b1804b1-45f27ceb2f2mr101342565e9.4.1758013289608;
        Tue, 16 Sep 2025 02:01:29 -0700 (PDT)
Received: from xl-nested.c.googlers.com.com (42.16.79.34.bc.googleusercontent.com. [34.79.16.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e037186e5sm212975035e9.5.2025.09.16.02.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 02:01:28 -0700 (PDT)
From: Ethan Graham <ethan.w.s.graham@gmail.com>
To: ethangraham@google.com,
	glider@google.com
Cc: andreyknvl@gmail.com,
	andy@kernel.org,
	brauner@kernel.org,
	brendan.higgins@linux.dev,
	davem@davemloft.net,
	davidgow@google.com,
	dhowells@redhat.com,
	dvyukov@google.com,
	elver@google.com,
	herbert@gondor.apana.org.au,
	ignat@cloudflare.com,
	jack@suse.cz,
	jannh@google.com,
	johannes@sipsolutions.net,
	kasan-dev@googlegroups.com,
	kees@kernel.org,
	kunit-dev@googlegroups.com,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lukas@wunner.de,
	rmoar@google.com,
	shuah@kernel.org,
	tarasmadan@google.com
Subject: [PATCH v1 09/10] fs/binfmt_script: add KFuzzTest target for load_script
Date: Tue, 16 Sep 2025 09:01:08 +0000
Message-ID: <20250916090109.91132-10-ethan.w.s.graham@gmail.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
In-Reply-To: <20250916090109.91132-1-ethan.w.s.graham@gmail.com>
References: <20250916090109.91132-1-ethan.w.s.graham@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ethan Graham <ethangraham@google.com>

Add a KFuzzTest target for the load_script function to serve as a
real-world example of the framework's usage.

The load_script function is responsible for parsing the shebang line
(`#!`) of script files. This makes it an excellent candidate for
KFuzzTest, as it involves parsing user-controlled data within the
binary loading path, which is not directly exposed as a system call.

The provided fuzz target in fs/tests/binfmt_script_kfuzz.c illustrates
how to fuzz a function that requires more involved setup - here, we only
let the fuzzer generate input for the `buf` field of struct linux_bprm,
and manually set the other fields with sensible values inside of the
FUZZ_TEST body.

To demonstrate the effectiveness of the fuzz target, a buffer overflow
bug was injected in the load_script function like so:

- buf_end = bprm->buf + sizeof(bprm->buf) - 1;
+ buf_end = bprm->buf + sizeof(bprm->buf) + 1;

Which was caught in around 40 seconds by syzkaller simultaneously
fuzzing four other targets, a realistic use case where targets are
continuously fuzzed. It also requires that the fuzzer be smart enough to
generate an input starting with `#!`.

While this bug is shallow, the fact that the bug is caught quickly and
with minimal additional code can potentially be a source of confidence
when modifying existing implementations or writing new functions.

Signed-off-by: Ethan Graham <ethangraham@google.com>
---
 fs/binfmt_script.c             |  8 ++++++
 fs/tests/binfmt_script_kfuzz.c | 51 ++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)
 create mode 100644 fs/tests/binfmt_script_kfuzz.c

diff --git a/fs/binfmt_script.c b/fs/binfmt_script.c
index 637daf6e4d45..c09f224d6d7e 100644
--- a/fs/binfmt_script.c
+++ b/fs/binfmt_script.c
@@ -157,3 +157,11 @@ core_initcall(init_script_binfmt);
 module_exit(exit_script_binfmt);
 MODULE_DESCRIPTION("Kernel support for scripts starting with #!");
 MODULE_LICENSE("GPL");
+
+/*
+ * When CONFIG_KFUZZTEST is enabled, we include this _kfuzz.c file to ensure
+ * that KFuzzTest targets are built.
+ */
+#ifdef CONFIG_KFUZZTEST
+#include "tests/binfmt_script_kfuzz.c"
+#endif /* CONFIG_KFUZZTEST */
diff --git a/fs/tests/binfmt_script_kfuzz.c b/fs/tests/binfmt_script_kfuzz.c
new file mode 100644
index 000000000000..9db2fb5a7f66
--- /dev/null
+++ b/fs/tests/binfmt_script_kfuzz.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * binfmt_script loader KFuzzTest target
+ *
+ * Copyright 2025 Google LLC
+ */
+#include <linux/binfmts.h>
+#include <linux/kfuzztest.h>
+#include <linux/slab.h>
+#include <linux/sched/mm.h>
+
+struct load_script_arg {
+	char buf[BINPRM_BUF_SIZE];
+};
+
+FUZZ_TEST(test_load_script, struct load_script_arg)
+{
+	struct linux_binprm bprm = {};
+	char *arg_page;
+
+	arg_page = (char *)get_zeroed_page(GFP_KERNEL);
+	if (!arg_page)
+		return;
+
+	memcpy(bprm.buf, arg->buf, sizeof(bprm.buf));
+	/*
+	 * `load_script` calls remove_arg_zero, which expects argc != 0. A
+	 * static value of 1 is sufficient for fuzzing.
+	 */
+	bprm.argc = 1;
+	bprm.p = (unsigned long)arg_page + PAGE_SIZE;
+	bprm.filename = "fuzz_script";
+	bprm.interp = bprm.filename;
+
+	bprm.mm = mm_alloc();
+	if (!bprm.mm) {
+		free_page((unsigned long)arg_page);
+		return;
+	}
+
+	/*
+	 * Call the target function. We expect it to fail and return an error
+	 * (e.g., at open_exec), which is fine. The goal is to survive the
+	 * initial parsing logic without crashing.
+	 */
+	load_script(&bprm);
+
+	if (bprm.mm)
+		mmput(bprm.mm);
+	free_page((unsigned long)arg_page);
+}
-- 
2.51.0.384.g4c02a37b29-goog


