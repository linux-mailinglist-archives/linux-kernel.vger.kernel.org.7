Return-Path: <linux-kernel+bounces-835662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F32BA7BB9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 03:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB20E17EB33
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 01:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CE02C11D0;
	Mon, 29 Sep 2025 01:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="W7iENXGW"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFA82BEC2D
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 01:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759107897; cv=none; b=q4Hs3alWQT/L743tUCjEfU6T4pjEmEh3nlyj1Iv/YXJgR4oUwuvjMrCFyM/MjfgJ1MaKIsJvNRDJeVsDduhUbqGRwsiddLOdKd0iv/Fka9uJ8EW+kNr5YvzDv7H4Bam7q+vfMFupNNe0w0U7LhFNYjackBHtRNV7ptUvN0YAsxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759107897; c=relaxed/simple;
	bh=1QPlkD1SD8j2jzJsRJQTTXYN8lhxikHZkxJhprewfsI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cyvvs0FYlaammamPPIAu2litz7REhUdN3RDRNFjC7mkWPW5WtzTUpDfbnwlZzNtU2b2oD7/2AEhiX1NbJrPZWP5g6Ah4MGSX5aWJ3KBWjmSiXEI+0y7M5wsZ1UIzgJQGAxv+EEzWxhhGfNIqRHRi0NN/OEO4J/bHrpO4qlWOb64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=W7iENXGW; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4dfe74ed2e1so12568211cf.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 18:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759107894; x=1759712694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zogfiVWVPuHqZ/hymZklfdYD+7OrEbaP/ax6pqZUiEo=;
        b=W7iENXGWw2H75H+Y5Yblx+Ha0LmPjz7dqK8hG5r89qE/QxXWTblVB3qbbvvqOZAdV0
         tWhauoLSWPs1doBrbaaYr4PRdfhTJPfiHX/6R3yoZpbj9kLIGatC2eMoyp+erC4Vs5S3
         yAFr2HObIg4dHrSY1oXT8I1RsUW6memaImp4wDQJ2Tn3zdRIL5l54aVSzbSgoFaVRADP
         M8ZQdqfteazi8PseJ/1Fi2QjeALfCL06PSjMLbiS+hrGiNiNZv7UnVU95MzMmbkZCikt
         k6sYZu0e1u6+3tlEOmEK9pBH3zisAIO895VQHK4Ms+evCeRdwtpxHaInP+P4KMV1fW4/
         HQeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759107894; x=1759712694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zogfiVWVPuHqZ/hymZklfdYD+7OrEbaP/ax6pqZUiEo=;
        b=Ut6RobfT766IWRacFw3UmvjGaOijDIuTyIq8QjXS7O20ifGphyouNP9c/9hOEm+fHx
         itbVXjUgmZ7pZP7IMTg4K/6BSvTC1SOklTm+yH79D3o9gVq69mbMXxV6f4keYeneYy9B
         AqQr5g9PlfhcHIDopmKUk/IemKguFiGMFa1Qs9xpG7mwlf2+Htk7MT+xJ2glRUxp7jYU
         TbxUJQ7e26ZTtCmIhi/uvKqpEYBxvmy6ZejpMfJU3ewDha+5Yu+BThoyEpYFYxqsJUQs
         8PKZrP6B2LMvjKyd0AAVIsyS/2+2TRMcgL3JBdOKJcB0v2i5/T+Y5C6EiBU2xPrn58xE
         qloQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZJlzaVaIuctt4ibqpIeNPnN2PSgz4Giv0p/uS2TxuQwcXN1NaVXILgboHjLld8oLGCaEwoOj1AZ1bFHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdzmoBvPbBYdv91TlPPg2romvpVtkednLImhiY5nqo30ilJ+Jd
	BFPSyGLKPyKUyrhopX9mSH+bBsiyPAeannwxaomFbldYTV6jnqldGJ9Y/jqWxHjPaI4=
X-Gm-Gg: ASbGncszmpVlFWwL/H6pHBm/uXlaYrJWHFIU1+X9aeGaBzEzkRmgZ0ROlvkbZ9QTlrg
	f4m8HQ1+UJ9Qwj/KbSlgbEZ7mSc7z24nFie3GbB077IVBLelilXBK8iJiyXa34DizF4YAc908Xj
	85y3VX0z9eiIfswL4+DIqLZqYCPR1ptSRieMsEsUTyBYliR9EjWAiVLXrzgO2n31K7wJy+SCQ0J
	xmdlQay8QAAtx+9WyAdeUZff277cS3AzCQs6eooOGbjwnbTEABqHZf9Y806X08WSRlLLJRpXIO9
	aFqhfs7u3v+WzQ+6IMP7vLUFwvSjRJhqmH+ZURj5T5eIdNMrTooL6ZN5Ly3VIfiLxtLKreS4fjU
	MWV8eudMXetIu9Ky2hdMh9GvXZHxQuPP4oVob9KplrSWCctGYQBef0Fd8v298Fu2vsl7saFoaGZ
	7rBxV3ayA=
X-Google-Smtp-Source: AGHT+IFJy+gdoGTPdKklQMCl/lbBiwtV/NLqoePakM8hqAPjFKr61eCoWw/x5r7bMaORajvgVwYiZg==
X-Received: by 2002:a05:622a:1e08:b0:4b5:4874:4fa5 with SMTP id d75a77b69052e-4da482d6300mr196629091cf.18.1759107893586;
        Sun, 28 Sep 2025 18:04:53 -0700 (PDT)
Received: from soleen.c.googlers.com.com (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db0c0fbe63sm64561521cf.23.2025.09.28.18.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 18:04:53 -0700 (PDT)
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
Subject: [PATCH v4 28/30] selftests/liveupdate: Add multi-session workflow and state interaction test
Date: Mon, 29 Sep 2025 01:03:19 +0000
Message-ID: <20250929010321.3462457-29-pasha.tatashin@soleen.com>
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

Introduce a new, luo_multi_session, test to validate the orchestration
of multiple LUO sessions with differing lifecycles through a full kexec
reboot.

The test validates interactions between per-session and global state
transitions:

1. Mixed State Preparation: Before the first kexec, sessions are put
into different states to test the global PREPARE event's behavior:
  - Session A & C: Are individually transitioned to PREPARED via a
    per-session ioctl. The test verifies that the subsequent global
    PREPARE correctly handles these already-prepared sessions.
  - Session B: Is transitioned to PREPARED and then immediately back to
    NORMAL via a per-session CANCEL. This validates the rollback
    mechanism and ensures the session is correctly picked up and
    prepared by the subsequent global PREPARE.
  - Session D: Is left in the NORMAL state, verifying that the global
    PREPARE correctly transitions sessions that have not been
    individually managed.

2. Unreclaimed Session Cleanup:
  - After the kexec reboot, sessions A, B, C, and D are all retrieved
    and verified to ensure they were preserved correctly, regardless of
    their pre-kexec transition path.
  - Session E: Is intentionally not retrieved. This validates that the
    global FINISH event correctly identifies and cleans up an entire
    unreclaimed session and all of its preserved file resources,
    preventing leaks.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 tools/testing/selftests/liveupdate/Makefile   |   1 +
 .../selftests/liveupdate/luo_multi_session.c  | 155 ++++++++++++++++++
 2 files changed, 156 insertions(+)
 create mode 100644 tools/testing/selftests/liveupdate/luo_multi_session.c

diff --git a/tools/testing/selftests/liveupdate/Makefile b/tools/testing/selftests/liveupdate/Makefile
index f43b7d03e017..72892942dd61 100644
--- a/tools/testing/selftests/liveupdate/Makefile
+++ b/tools/testing/selftests/liveupdate/Makefile
@@ -11,6 +11,7 @@ LUO_SHARED_HDRS += luo_test_utils.h
 
 LUO_MANUAL_TESTS += luo_multi_file
 LUO_MANUAL_TESTS += luo_multi_kexec
+LUO_MANUAL_TESTS += luo_multi_session
 
 TEST_FILES += do_kexec.sh
 
diff --git a/tools/testing/selftests/liveupdate/luo_multi_session.c b/tools/testing/selftests/liveupdate/luo_multi_session.c
new file mode 100644
index 000000000000..9ea96d7b997f
--- /dev/null
+++ b/tools/testing/selftests/liveupdate/luo_multi_session.c
@@ -0,0 +1,155 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Copyright (c) 2025, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ */
+
+#include "luo_test_utils.h"
+#include "../kselftest.h"
+
+#define KEXEC_SCRIPT "./do_kexec.sh"
+
+#define NUM_SESSIONS 5
+#define FILES_PER_SESSION 5
+
+/* Helper to manage one session and its files */
+static void setup_session(int luo_fd, struct session_info *s, int session_idx)
+{
+	int i;
+
+	snprintf(s->name, sizeof(s->name), "session-%c", 'A' + session_idx);
+
+	s->fd = luo_create_session(luo_fd, s->name);
+	if (s->fd < 0)
+		fail_exit("Failed to create session '%s'", s->name);
+
+	/* Create and preserve all files for this session */
+	for (i = 0; i < FILES_PER_SESSION; i++) {
+		s->file_tokens[i] = (session_idx * 100) + i;
+		snprintf(s->file_data[i], sizeof(s->file_data[i]),
+			 "Data for %.*s-File%d",
+			 LIVEUPDATE_SESSION_NAME_LENGTH,
+			 s->name, i);
+
+		if (create_and_preserve_memfd(s->fd, s->file_tokens[i],
+					      s->file_data[i]) < 0) {
+			fail_exit("Failed to preserve token %d in session '%s'",
+				  s->file_tokens[i], s->name);
+		}
+	}
+}
+
+/* Helper to re-initialize the expected session data post-reboot */
+static void reinit_sessions(struct session_info *sessions)
+{
+	int i, j;
+
+	for (i = 0; i < NUM_SESSIONS; i++) {
+		snprintf(sessions[i].name, sizeof(sessions[i].name),
+			 "session-%c", 'A' + i);
+		for (j = 0; j < FILES_PER_SESSION; j++) {
+			sessions[i].file_tokens[j] = (i * 100) + j;
+			snprintf(sessions[i].file_data[j],
+				 sizeof(sessions[i].file_data[j]),
+				 "Data for %.*s-File%d",
+				 LIVEUPDATE_SESSION_NAME_LENGTH,
+				 sessions[i].name, j);
+		}
+	}
+}
+
+static void run_pre_kexec(int luo_fd)
+{
+	struct session_info sessions[NUM_SESSIONS] = {0};
+	int i;
+
+	ksft_print_msg("[PRE-KEXEC] Starting workload...\n");
+
+	ksft_print_msg("[PRE-KEXEC] Setting up %d sessions with %d files each...\n",
+		       NUM_SESSIONS, FILES_PER_SESSION);
+	for (i = 0; i < NUM_SESSIONS; i++)
+		setup_session(luo_fd, &sessions[i], i);
+	ksft_print_msg("[PRE-KEXEC] Setup complete.\n");
+
+	ksft_print_msg("[PRE-KEXEC] Performing individual session state transitions...\n");
+	ksft_print_msg("  - Preparing Session A...\n");
+	if (luo_set_session_event(sessions[0].fd, LIVEUPDATE_PREPARE) < 0)
+		fail_exit("Failed to prepare Session A");
+
+	ksft_print_msg("  - Preparing and then Canceling Session B...\n");
+	if (luo_set_session_event(sessions[1].fd, LIVEUPDATE_PREPARE) < 0)
+		fail_exit("Failed to prepare Session B");
+	if (luo_set_session_event(sessions[1].fd, LIVEUPDATE_CANCEL) < 0)
+		fail_exit("Failed to cancel Session B");
+
+	ksft_print_msg("  - Preparing Session C...\n");
+	if (luo_set_session_event(sessions[2].fd, LIVEUPDATE_PREPARE) < 0)
+		fail_exit("Failed to prepare Session C");
+
+	ksft_print_msg("  - Sessions D & E remain in NORMAL state.\n");
+
+	ksft_print_msg("[PRE-KEXEC] Triggering global PREPARE event...\n");
+	if (luo_set_global_event(luo_fd, LIVEUPDATE_PREPARE) < 0)
+		fail_exit("Failed to set global PREPARE event");
+
+	ksft_print_msg("[PRE-KEXEC] System is ready. Executing kexec...\n");
+	if (system(KEXEC_SCRIPT) != 0)
+		fail_exit("kexec script failed");
+
+	sleep(10);
+	exit(EXIT_FAILURE);
+}
+
+static void run_post_kexec(int luo_fd)
+{
+	struct session_info sessions[NUM_SESSIONS] = {0};
+
+	ksft_print_msg("[POST-KEXEC] Starting workload...\n");
+
+	reinit_sessions(sessions);
+
+	ksft_print_msg("[POST-KEXEC] Verifying preserved sessions (A, B, C, D)...\n");
+	verify_session_and_get_fd(luo_fd, &sessions[0]);
+	verify_session_and_get_fd(luo_fd, &sessions[1]);
+	verify_session_and_get_fd(luo_fd, &sessions[2]);
+	verify_session_and_get_fd(luo_fd, &sessions[3]);
+
+	ksft_print_msg("[POST-KEXEC] NOT retrieving session E to test cleanup.\n");
+
+	ksft_print_msg("[POST-KEXEC] Driving global state to FINISH...\n");
+	if (luo_set_global_event(luo_fd, LIVEUPDATE_FINISH) < 0)
+		fail_exit("Failed to set global FINISH event");
+
+	ksft_print_msg("\n--- TEST PASSED ---\n");
+	ksft_print_msg("Check dmesg for cleanup log of session E.\n");
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


