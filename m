Return-Path: <linux-kernel+bounces-735500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45809B09034
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 17:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A2297B8116
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581FF2F0C43;
	Thu, 17 Jul 2025 15:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VNLDk0r9"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6426910A1E
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 15:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752764948; cv=none; b=Lr6fpZBbKgX8o57SaaTJOX3PtEpbq7zz4RdEc2YpzUifhe6wh+qJ4GrNLtNjxSOjT1Sy4uUDuOyCnbsYk0doSEoWqBRFBtE3CK0d8doja0jPsMFdLoRIqlEfa1MIN21R7LfhQvv0XjX7dt1+XJDYCtItPj6AJkbxIujsz2Clww4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752764948; c=relaxed/simple;
	bh=EiDVBW76tvLcvcxgrKHMClTLXcXHYkd8R9wEyzxQqCE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=tcpVRso7hKHzuwrU/bezj0WeK72FY/AcHYZ58wF9PNwdZ10NiMR0uoAW/2ZdiM19yI3R1WcFAOzC5QUQLUybyRtzZ/l24fsYGUy4RsFhKsD8D9rujJN4Qz7xgIdOa+GOOUkSjlHSJqn9t4ZWDn9YMOJhXI/RI+wIX+XK0miVQSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VNLDk0r9; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3141a9a6888so1060296a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 08:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752764947; x=1753369747; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MIXUDuq7ovshxxSYABdfkB3392ffxtbOzDMl2+dJvEY=;
        b=VNLDk0r9FCqWv9fvO3zXgcTQhP8UOyAhz9oNz0xd6mBw6f2MhRUoEcyh9oXkvlG/ff
         K/ASBXBCZN6+LilCOZupZ3jnjfGR+tbEDt1EhSX8ZMgiCnZqB4hDWIwWDn0mQRgigT0L
         MgNbfp6aLtqyWb2+a2Dk0tVxEE8A5ZKqik7FpMIRqzPpwWvQc97Vcbb0Fw0u2Onx0cJz
         RULcBx3TYCCFWSfWMNZTOX6slsG7D+OuLhsnnKhowuqY+iBROjOezSyD8T8yhm961Qri
         q1NKfAVyU6qmhKqIUDy4xMhqL8Epv2nMDPdEMqR1Qz0EDJGfc2jplPiWwoM6HcsQyTOZ
         yfYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752764947; x=1753369747;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MIXUDuq7ovshxxSYABdfkB3392ffxtbOzDMl2+dJvEY=;
        b=nAx05jOVL/OsHIdlqHJVviTzPlQtw8KvDm/F0UtR2jNicSrPNlVyZxTZp/YANbp6Gf
         PSovE9FevnvanPhGzQN+oA7IbPOvTTJ4Wqd9jYNuHNre1bK5cAyfgw+ls36hM0Nl4Rjs
         ouK0a/vsCQPUHeqT4tHnSI+YbN0oHaXeMGzK6qzX339/4V+tQ32Bxl23V6jT1Fs7b36T
         M+bs+6ZLaFztSx51gbz3BuqZni4BuxtdgtizSd1E2ONzhtoOv2VfUgMvE0y/Yi+Klpv6
         u85TXfnwZPSwKqNhB/7XyGURQUtH1xbA9KVrgp3NBGbNzR7wDYjM6Ck1Hdqh9pFf3bvi
         p9DA==
X-Forwarded-Encrypted: i=1; AJvYcCUT4yKd4SJtKktx69cVXTwUhXFVUkhK5Gx6ki/KGMLFOwcTg8fHP5ObQVih6hUWK/AJSU6cad+q9tvvMg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsfrR5xclZ14Pq3eZklUbHq91Sat08qYlUaplkL2XVrqgweoUQ
	WD0qMiL13wO+CSoFFCZ8ZBSbDxyg6NBa4iMVl0ivGuNS4Dw7dMzIchMRmSZFPd4SobP5jZbx2l/
	7TXtCkpROcw==
X-Google-Smtp-Source: AGHT+IFL73neqb2Qi4RrByaNIFT61LP8vi6nbcp4FuivM0fh4JTn/cRc9MN7woer2IIWixLA8PMuIsJuPgsE
X-Received: from pjbsp7.prod.google.com ([2002:a17:90b:52c7:b0:311:c197:70a4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5307:b0:311:b3e7:fb38
 with SMTP id 98e67ed59e1d1-31c9e76371bmr11205278a91.19.1752764946725; Thu, 17
 Jul 2025 08:09:06 -0700 (PDT)
Date: Thu, 17 Jul 2025 08:08:53 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250717150855.1032526-1-irogers@google.com>
Subject: [PATCH v2 1/3] tools subcmd: Tighten the filename size in check_if_command_finished
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
v2: Fix precedence issue reported by the kernel test robot.
---
 tools/lib/subcmd/run-command.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/lib/subcmd/run-command.c b/tools/lib/subcmd/run-command.c
index 0a764c25c384..b7510f83209a 100644
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
+#define MAX_STRLEN_TYPE(type) (sizeof(type) * 8 / 3 + (is_signed_type(type) ? 1 : 0))
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


