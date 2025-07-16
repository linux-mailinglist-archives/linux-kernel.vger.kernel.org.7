Return-Path: <linux-kernel+bounces-734230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 805D9B07EA4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 22:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3F781AA7876
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 20:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC8B2BDC34;
	Wed, 16 Jul 2025 20:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SBflYdMp"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D18813AD1C
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 20:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752696918; cv=none; b=OP9iGf4CzMLX5d7+5vYEjwks4gBdapTPlY9m4IoLqvjQRVef2t9OjkqrLi6n5nP7s/zmeQo/tj3gKDdezEureg3f/7kog2cTqNGZoxG37BhN9LI3WP/WmIZn1Hy/1uHL8R3Z+kMkNNDLn8A96D8gHpUFuwTApJD6W8+v3otnZvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752696918; c=relaxed/simple;
	bh=UBKqvvuKKVcHq5eFXwbNjMqsoj+0KdRHt7K346Izmv8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=PuF4zuE6CPx0RscYiFhTCW2ZxfuqJGcVvavLMGfBlrn/SapoFCg4+PNWelu2CnUP9Z8yst8bn+MTdocEe7Qe8Y2PXGeTkHmqgagBSPYHLZbevNEwx0VKPLzTNRygDBI4dFVZwt/PiKIrKo2I5uwr7i2PjAOOlKFqf1O6JozuMjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SBflYdMp; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b31bd4c3359so86608a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 13:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752696916; x=1753301716; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vogO00VRqH90sPiYUigUvbFFboi4tUhRyLVvWmRwAU8=;
        b=SBflYdMppVp8tCj4lBIsZySCWLyc0WG/pDJhg6Uk7OLZmXiXwdUFgjnvV+wZ3qS2le
         I4qtV5eRR2ktmJtg1yW+3MxLNICnUPFutqPEhwBgX8w4MtZYhOMTfNr8UNyWnS8gymyo
         K/Q60/Rnh0SefYXlQb0izQP4nhOP5Q/raELy5afeqmnZ8Y9egVksTmBzFMp31oaqRSo7
         Hl90He71Su/VqGqmzvb2Lk4BYh9PvhFupMY/7pDVxZUkcvonahvX3vlomZ0Pklt4nt4Q
         uKlSgPnpJ487KdBccbxTa/G/zTbo/E4Edjh856CwwetXmf4SclTeXoSD5cZqTG3wSdkp
         Sg3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752696916; x=1753301716;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vogO00VRqH90sPiYUigUvbFFboi4tUhRyLVvWmRwAU8=;
        b=nw4VKU40J4ZUdjDswwdbuIIyubiuYVM9tIWC6BwEE2JFGiy7uMm4LkqQHOn70tcZwV
         1jB4xklYuwpDAUjPLbWs5A2J/ZH2qD/MfZRGlaLxyBauilC7tb1hi6pEGIMzffksyVWC
         /dsPjR7Dw+WaB7el+OO2NnWgzl72S026OsMzWAxb6Dq2rn/8adrAud5lWbWx8MB47t0C
         Uneuig89eZ4z/UV6tSf7RmyDg6UcZ2YZI84XgrpIeJD5uXaJBVBA5WFAd/+Bu7m2+vcu
         WipZxab+DAv6YRJv4Q9DtYdVFdu+go9UlyXtI8k+k/D8ZFFRq8ZXmlgE1XjLGUY7yMgf
         zvmg==
X-Forwarded-Encrypted: i=1; AJvYcCXQoSy4nSRu/5496snkH2y9iuJY4uh1Q0+HYBQktPXpc0KX840eiya/mHHHzM8wSnPraQxRbMyXU6oqtBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFoBriOyD2ezhsgprLvPJvayDoX+jMKJ6iYQRwtPburECfzgdb
	tMjlZL61ARDy4JNaaqo5H3QcfgK0nojDw2y3IpuYA7Me9t1UfzP4qJHQ7Fv79/QIvl2i2NOILer
	ZeUPxafP5DA==
X-Google-Smtp-Source: AGHT+IGdafEcbp2fXACN7fUUTyGrJ7ZOQ8BaefgKIqHVV/scVFp26z0CwmMdagLZeaY5Tjgaec0TyZ8LJ2C1
X-Received: from pjyr14.prod.google.com ([2002:a17:90a:e18e:b0:309:f831:28e0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:5d12:b0:31c:39c5:ffbd
 with SMTP id 98e67ed59e1d1-31c9f4b4177mr5171150a91.24.1752696916509; Wed, 16
 Jul 2025 13:15:16 -0700 (PDT)
Date: Wed, 16 Jul 2025 13:15:10 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250716201512.792052-1-irogers@google.com>
Subject: [PATCH v1 1/3] tools subcmd: Tighten the filename size in check_if_command_finished
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

FILENAME_MAX is often PATH_MAX (4kb), far more than needed for the
/proc path. Make the buffer size sufficient for the maximum integer
plus "/proc/" and "/status" with a '\0' terminator.

Fixes: 5ce42b5de461 ("tools subcmd: Add non-waitpid check_if_command_finished()")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/subcmd/run-command.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/lib/subcmd/run-command.c b/tools/lib/subcmd/run-command.c
index 0a764c25c384..dda7cbd298eb 100644
--- a/tools/lib/subcmd/run-command.c
+++ b/tools/lib/subcmd/run-command.c
@@ -5,6 +5,7 @@
 #include <ctype.h>
 #include <fcntl.h>
 #include <string.h>
+#include <linux/compiler.h>
 #include <linux/string.h>
 #include <errno.h>
 #include <sys/wait.h>
@@ -216,10 +217,20 @@ static int wait_or_whine(struct child_process *cmd, bool block)
 	return result;
 }
 
+/*
+ * Conservative estimate of number of characaters needed to hold an a decoded
+ * integer, assume each 3 bits needs a character byte and plus a possible sign
+ * character.
+ */
+#ifndef is_signed_type
+#define is_signed_type(type) (((type)(-1)) < (type)1)
+#endif
+#define MAX_STRLEN_TYPE(type) (sizeof(type) * 8 / 3 + is_signed_type(type) ? 1 : 0)
+
 int check_if_command_finished(struct child_process *cmd)
 {
 #ifdef __linux__
-	char filename[FILENAME_MAX + 12];
+	char filename[6 + MAX_STRLEN_TYPE(typeof(cmd->pid)) + 7 + 1];
 	char status_line[256];
 	FILE *status_file;
 
@@ -227,7 +238,7 @@ int check_if_command_finished(struct child_process *cmd)
 	 * Check by reading /proc/<pid>/status as calling waitpid causes
 	 * stdout/stderr to be closed and data lost.
 	 */
-	sprintf(filename, "/proc/%d/status", cmd->pid);
+	sprintf(filename, "/proc/%u/status", cmd->pid);
 	status_file = fopen(filename, "r");
 	if (status_file == NULL) {
 		/* Open failed assume finish_command was called. */
-- 
2.50.0.727.gbf7dc18ff4-goog


