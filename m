Return-Path: <linux-kernel+bounces-835661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFADFBA7BEC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 03:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50CD77AF8DA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 01:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522782C08B2;
	Mon, 29 Sep 2025 01:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Hc5vqpyT"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C9C2BE636
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 01:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759107896; cv=none; b=B5yunIJGFZx89nZHe58byynQcI6+4fUAXtIV/BwNdg+gYQy4CqdsmkDbyfQGlqXqXUhyG2HtULNAyRod4H1JZlYQ2GqagdTIlXlo2coArTVwPklA9Y3l4F+WtBW1E1RTXAIHIhAilsWqUfJ0OpxxfJJ7RYIjWBHhOJvmDMJ0kVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759107896; c=relaxed/simple;
	bh=dTUrXfOK43UjtKGaHxGoUkNGqZ39TsswRbP9ug41gpk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eY6Fxew7KO9Seslp04fi/9e/J0d8Cq/FO/16MQ9C9lv0XJIuwVP7qVmBBVUNJYf8EtWqh84BIZCDxJUtbfA6XYioOqP8iIflDCd49Ky7m0vDnO7gSXJrW6dQ2fFrGfD9sh4tU/7I9oGNnFITiqvRKPxDog1WOmllqTw8m1YisaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=Hc5vqpyT; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4ddf60466d4so29543991cf.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 18:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759107892; x=1759712692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ydKBwOyRTlAOFM+HzD45Tc0PX6eZlXsguWH3WK3DRQ=;
        b=Hc5vqpyTaVJWJgc0sufkfuF8aRKS9dgNMrFLH2zFRYUn8imtbNjW4C+G00JQursGrE
         CNVUZTkpy7CincjdSHs8Za6FcXmehoRqWjLCUVpbTPiSbMqM9BEosb9NeNk4ontVTdhM
         1jeklbo90i6NSN4cK5v86thmGEOyuPOjGbWpz5fV2bebmVwS8khvHi6tDVlAId4zJqZ7
         Q3omhDO5NEXKFOgjDJmj62ZzulJngt7oyfoiZJ2cSIXsIhQzyIA5I1BCnv/4wy1QyJGx
         X5I3uDjxbIkErTPyEMQOuddhjvFE2k5nBgCrfbHMfXvJAwdNZHPpTgEbPkerl39761UW
         Jy1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759107892; x=1759712692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ydKBwOyRTlAOFM+HzD45Tc0PX6eZlXsguWH3WK3DRQ=;
        b=f8N7J5RCOS35sCMN1Q8qBNd7rq1eXFrlxdDgupoye95w8194iSBQasfJYTQUDHoZRN
         Uw5GTmd9oorxe+yVrHROKoQvbb4inzHrqxhd4S5aHXRm0kvSFzaZ5VeN9jz/tcN5hokp
         Vd1KKxgS0ucj1VJdb8pjv6cqA0wjehd1e0Px1ZL19DfYi8hpvCluOpmJYz0O4iYe2nvH
         AixlHDltlr26pKt331N78x0IWBccuWWxi89150uJu4BuUHl/15X18txZkv+dB0oL7NOg
         +B2skaukj1hNg/iwwM+mJrchONoNpCaCKIHia1+VFwat0vfk8I+0jirU1S0jvCtX+cgm
         FWoA==
X-Forwarded-Encrypted: i=1; AJvYcCWrUWl+ZCZJuIDTABQj+3DifdaXh149PBNh6tiOziD0z6famWfioUXpbvaBKc5RSwtAlixdvQIxHbix7a4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLxcPYk6CWPnl4eJlxljb4oCp8cOoEKdZPLQlnpy2+Gxp+f12r
	/VUFJo+zdF++yqy30VjavxELI86E6ZccxT+YhonJlStV1UxO81kEBEcr7EbRGjToE/M=
X-Gm-Gg: ASbGnctPDLyzheKOEe5D75BvfPxuJhwcEp2ElAkXIn1bWZxS/PvIzREDw+2mWEGpC37
	PN0b1EnQPZM8HdGYVQX1g26nfRXCtkEyRDCM0ObQ148Qf/Q6K8pNVA1JA7W4n4XfYaP2UPm9Txc
	+dMRdRd1KFRSIApodSzHtasJi9qbYNUub+gG8ks+rCDFKDt0+Gc2Kethm2YaV1CSOWJOKM7jQ/5
	LG36MzijusDL21coZW0kLJQVJkHKFrdzmtB+m0TMjptZZOhvyWOTkntaMQz08YBstFO4rhnVaQ8
	j0G75JnC7zDr74xQm7xffV3nt7pHOvB3npbz7dsUPTa0lzy/Lt7WtGOdNMRG1pwjQnBjh6Z/SY7
	ERerTSPwGJMuJez8Am3yVf7dMNroHoO8BiVOGt3pygnNxM9qqKMP/EvyBUacBN1vVlWYo3Tn+7G
	8gb8hVyCQ=
X-Google-Smtp-Source: AGHT+IFl5jf3mdJXfLDVCYuyr7wgE9yCTlaWZAFW+PFDbEgMjgXl4J4uX5xR5SoXPcaZ54yBI+aaQw==
X-Received: by 2002:a05:622a:1ccb:b0:4df:8368:4ae1 with SMTP id d75a77b69052e-4df836851b5mr75011421cf.33.1759107892153;
        Sun, 28 Sep 2025 18:04:52 -0700 (PDT)
Received: from soleen.c.googlers.com.com (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db0c0fbe63sm64561521cf.23.2025.09.28.18.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 18:04:51 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: pratyush@kernel.org,
	jasonmiu@google.com,
	graf@amazon.com,
	changyuanl@google.com,
	pasha.tatashin@soleen.com,
	rppt@kernel.org,
	dmatlack@google.com,
	rientjes@google.com,
	corbet@lwn.net,
	rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com,
	kanie@linux.alibaba.com,
	ojeda@kernel.org,
	aliceryhl@google.com,
	masahiroy@kernel.org,
	akpm@linux-foundation.org,
	tj@kernel.org,
	yoann.congal@smile.fr,
	mmaurer@google.com,
	roman.gushchin@linux.dev,
	chenridong@huawei.com,
	axboe@kernel.dk,
	mark.rutland@arm.com,
	jannh@google.com,
	vincent.guittot@linaro.org,
	hannes@cmpxchg.org,
	dan.j.williams@intel.com,
	david@redhat.com,
	joel.granados@kernel.org,
	rostedt@goodmis.org,
	anna.schumaker@oracle.com,
	song@kernel.org,
	zhangguopeng@kylinos.cn,
	linux@weissschuh.net,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	rafael@kernel.org,
	dakr@kernel.org,
	bartosz.golaszewski@linaro.org,
	cw00.choi@samsung.com,
	myungjoo.ham@samsung.com,
	yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com,
	quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com,
	ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com,
	leon@kernel.org,
	lukas@wunner.de,
	bhelgaas@google.com,
	wagi@kernel.org,
	djeffery@redhat.com,
	stuart.w.hayes@gmail.com,
	ptyadav@amazon.de,
	lennart@poettering.net,
	brauner@kernel.org,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	saeedm@nvidia.com,
	ajayachandra@nvidia.com,
	jgg@nvidia.com,
	parav@nvidia.com,
	leonro@nvidia.com,
	witu@nvidia.com,
	hughd@google.com,
	skhawaja@google.com,
	chrisl@kernel.org,
	steven.sistare@oracle.com
Subject: [PATCH v4 27/30] selftests/liveupdate: Add multi-file and unreclaimed file test
Date: Mon, 29 Sep 2025 01:03:18 +0000
Message-ID: <20250929010321.3462457-28-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
In-Reply-To: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
References: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new selftest, luo_multi_file, to validate two key aspects of
the Live Update Orchestrator file preservation mechanism: the ability to
handle multiple files within a single session, and the correct cleanup
of unreclaimed files.

The test implements a full kexec cycle with the following flow:
1. Pre-kexec:
  - A single session is created.
  - Three distinct memfd files (A, B, and C) are created, populated with
    unique data, and preserved within this session.
  - The global LIVEUPDATE_PREPARE event is triggered, and the system
    reboots via kexec.
2. Post-kexec:
  - The preserved session is retrieved.
  - Files A and C are restored and their contents are verified to ensure
    that multiple files can be successfully restored from a single
    session.
  - File B is intentionally not restored.
  - The global LIVEUPDATE_FINISH event is triggered.
3. Verification:
  - The test is considered successful if files A and C are verified
    correctly.
  - The user is prompted to check the kernel log (dmesg) for a message
    confirming that the unreclaimed file (B) was identified and cleaned
    up by the LUO core, thus validating the cleanup path.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 tools/testing/selftests/liveupdate/Makefile   |   1 +
 .../selftests/liveupdate/luo_multi_file.c     | 119 ++++++++++++++++++
 2 files changed, 120 insertions(+)
 create mode 100644 tools/testing/selftests/liveupdate/luo_multi_file.c

diff --git a/tools/testing/selftests/liveupdate/Makefile b/tools/testing/selftests/liveupdate/Makefile
index 1cbc816ed5c5..f43b7d03e017 100644
--- a/tools/testing/selftests/liveupdate/Makefile
+++ b/tools/testing/selftests/liveupdate/Makefile
@@ -9,6 +9,7 @@ LDFLAGS += -static
 LUO_SHARED_SRCS := luo_test_utils.c
 LUO_SHARED_HDRS += luo_test_utils.h
 
+LUO_MANUAL_TESTS += luo_multi_file
 LUO_MANUAL_TESTS += luo_multi_kexec
 
 TEST_FILES += do_kexec.sh
diff --git a/tools/testing/selftests/liveupdate/luo_multi_file.c b/tools/testing/selftests/liveupdate/luo_multi_file.c
new file mode 100644
index 000000000000..ae38fe8aba4c
--- /dev/null
+++ b/tools/testing/selftests/liveupdate/luo_multi_file.c
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Copyright (c) 2025, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ */
+
+#include "luo_test_utils.h"
+
+#define KEXEC_SCRIPT "./do_kexec.sh"
+
+#define SESSION_NAME "multi_file_session"
+#define TOKEN_A 101
+#define TOKEN_B 102
+#define TOKEN_C 103
+
+#define DATA_A "Alpha file data"
+#define DATA_B "Bravo file data which will be unreclaimed"
+#define DATA_C "Charlie file data"
+
+static void run_pre_kexec(int luo_fd)
+{
+	int session_fd;
+
+	ksft_print_msg("[PRE-KEXEC] Starting workload...\n");
+
+	session_fd = luo_create_session(luo_fd, SESSION_NAME);
+	if (session_fd < 0)
+		fail_exit("Failed to create session '%s'", SESSION_NAME);
+
+	ksft_print_msg("[PRE-KEXEC] Preserving 3 memfds (A, B, C)...\n");
+	if (create_and_preserve_memfd(session_fd, TOKEN_A, DATA_A) < 0)
+		fail_exit("Failed to preserve memfd A");
+	if (create_and_preserve_memfd(session_fd, TOKEN_B, DATA_B) < 0)
+		fail_exit("Failed to preserve memfd B");
+	if (create_and_preserve_memfd(session_fd, TOKEN_C, DATA_C) < 0)
+		fail_exit("Failed to preserve memfd C");
+	ksft_print_msg("[PRE-KEXEC] All memfds preserved.\n");
+
+	if (luo_set_global_event(luo_fd, LIVEUPDATE_PREPARE) < 0)
+		fail_exit("Failed to set global PREPARE event");
+
+	ksft_print_msg("[PRE-KEXEC] System is ready. Executing kexec...\n");
+	if (system(KEXEC_SCRIPT) != 0)
+		fail_exit("kexec script failed");
+
+	sleep(10); /* Should not be reached */
+	exit(EXIT_FAILURE);
+}
+
+static void run_post_kexec(int luo_fd)
+{
+	int session_fd, mfd_a, mfd_c;
+
+	ksft_print_msg("[POST-KEXEC] Starting workload...\n");
+
+	session_fd = luo_retrieve_session(luo_fd, SESSION_NAME);
+	if (session_fd < 0)
+		fail_exit("Failed to retrieve session '%s'", SESSION_NAME);
+
+	/* 1. VERIFY SUCCESS: Restore and verify memfd A. */
+	ksft_print_msg("[POST-KEXEC] Restoring and verifying memfd A (token %d)...\n",
+		       TOKEN_A);
+	mfd_a = restore_and_verify_memfd(session_fd, TOKEN_A, DATA_A);
+	if (mfd_a < 0)
+		fail_exit("Failed to restore or verify memfd A");
+	close(mfd_a);
+	ksft_print_msg("  Success.\n");
+
+	/* 2. VERIFY SUCCESS: Restore and verify memfd C. */
+	ksft_print_msg("[POST-KEXEC] Restoring and verifying memfd C (token %d)...\n",
+		       TOKEN_C);
+	mfd_c = restore_and_verify_memfd(session_fd, TOKEN_C, DATA_C);
+	if (mfd_c < 0)
+		fail_exit("Failed to restore or verify memfd C");
+	close(mfd_c);
+	ksft_print_msg("  Success.\n");
+
+	ksft_print_msg("[POST-KEXEC] NOT restoring memfd B (token %d) to test cleanup.\n",
+		       TOKEN_B);
+
+	if (luo_set_global_event(luo_fd, LIVEUPDATE_FINISH) < 0)
+		fail_exit("Failed to set global FINISH event");
+
+	close(session_fd);
+
+	ksft_print_msg("\n--- TEST PASSED ---\n");
+	ksft_print_msg("Check dmesg for cleanup log of token %d in session '%s'.\n",
+		       TOKEN_B, SESSION_NAME);
+}
+
+int main(int argc, char *argv[])
+{
+	enum liveupdate_state state;
+	int luo_fd;
+
+	luo_fd = luo_open_device();
+	if (luo_fd < 0) {
+		ksft_exit_skip("Failed to open %s. Is the luo module loaded?\n",
+			       LUO_DEVICE);
+	}
+
+	if (luo_get_global_state(luo_fd, &state) < 0)
+		fail_exit("Failed to get LUO state");
+
+	switch (state) {
+	case LIVEUPDATE_STATE_NORMAL:
+		run_pre_kexec(luo_fd);
+		break;
+	case LIVEUPDATE_STATE_UPDATED:
+		run_post_kexec(luo_fd);
+		break;
+	default:
+		fail_exit("Test started in an unexpected state: %d", state);
+	}
+
+	close(luo_fd);
+	ksft_exit_pass();
+}
-- 
2.51.0.536.g15c5d4f767-goog


