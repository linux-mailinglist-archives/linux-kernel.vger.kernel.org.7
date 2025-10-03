Return-Path: <linux-kernel+bounces-840900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA3FBB5AE0
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 02:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2F0504E62E5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 00:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E9213E41A;
	Fri,  3 Oct 2025 00:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g8xHhWC8"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC62175BF
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 00:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759452083; cv=none; b=izXIMwk8F3zhSNzpOy+PRC5aJIrCgqQ2eA+emYXZDmZrlDuTDV50DYVs6TjWxkxkST8ICvMjPQ4pt6iVHWMut5EaE5RBuRfg2I46WuogHI2LGqu5jKGHhTv6R0hpEAvZT5wuIPWntq41+VG2E7HlGWLT2ICQ2/Zco28t5XMYBoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759452083; c=relaxed/simple;
	bh=3mDe7fpgcruxbDrX0bc5+oJ9/rO2+0AXTXV6A3h/n+k=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=Kgz5AogWtyYGqjhUQmfeHQU/JhYoFf7naamagTeeLe4I7bIazpyB5PiSdktYipupl2HXy6K7DUmT8++rK8JPuSUzpWqxD+e5yA8jKJoyfTx1yJMyasqyaR/11dWFZHOhyHBjLLk3NRwgJ/PG8ZtqStobQv0rm37WwmExf4AJYyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g8xHhWC8; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-780f914b5a4so1601070b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 17:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759452077; x=1760056877; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XlVgG+qUcqt1ti4IWrjfI9WXkl1dtzgX2VnAjDGGGKQ=;
        b=g8xHhWC8cEKyL4LnDYPCCu+BiMTD120cbHvrH3KqLnx40F67t01wY7YMbaHBtixl4o
         WcQj4jCD2JzBzoHzJtO+Y6xoUry3k61ywbyF5kj6Hv+Qv2z23YZvsq6C4s4Ziwn76qXj
         CpXUrY7WfLnejabVpOu/+174tTQGw+F1mcrs3vmS/7EGDZid+CSqJ+ry5nRPbcD/Jf0q
         FXh7ewHk23Y435/ya11+9TpK2KmhG0A4tdhLdDD/IDGrA5iB29KJduEkUCJ8X7LvCugH
         SlOhxQTcZDkncUChqo5adRhmtmx2pwcUFdhgulvcMU0KKMYF/WeXU9slt3m0UOAsJSi7
         b1Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759452077; x=1760056877;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XlVgG+qUcqt1ti4IWrjfI9WXkl1dtzgX2VnAjDGGGKQ=;
        b=RwG0NQEn0xUgEzw/VzE2M2Qih7W/5xNqkdy0sMHQBKbYmTcBvG4Bne2wpA3D3m7JRr
         Y9BkTBV+HEcgTUKFD9RuSkSAbTqvj7rGOQKmw4SzNjUSFYcAx5PrUu00a0fdJhabDOyf
         omOtOcUPsH6MR8QSym/cYH7vKSwKUVs/BvfyCSsunNzvFeoQc9LjB9652kKDKtOT06nN
         7ek31ylt94a7y4aXQrJE6ZcBrorr8EAFayag5+WVkv+v4yAwpDU08SF3vKpBK2BCHx8A
         LbnfOshnhXJW4hafpJrhktDV7u/mvaUVRHQTmUl1Af3XDRBT4ZMgC5Q8QK9uS0Icsi8d
         vszg==
X-Forwarded-Encrypted: i=1; AJvYcCVn3Sykya8xwYsTjJZv5yM1P9DdCrJHgd6erSIvVO4arq7UYahRNIECn3lVzk56+2WWW0NEg3m+GpceM20=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOCfJ4cabCirhwkR2OYTDSrtCtY7sUvV1/QlVq+2A5Be//33NN
	jVbf4hTxSjBdTzbrd/9ya4epPJz14UQu6NxZtb0vcHMqtZgKjJNvRD5bDMtUzC8kSOhrIAjz0tf
	GcYYfh8opIA==
X-Google-Smtp-Source: AGHT+IGP0IJMW4X14mDo3SaF2DPNVjoOEPADwz8Mfq/a+u3M5w2WZyZ+g37te5WSjbUe5DeFJ/v/n2gwtua5
X-Received: from pgct8.prod.google.com ([2002:a05:6a02:5288:b0:b55:117c:84a3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:2450:b0:2e2:3e68:6e45
 with SMTP id adf61e73a8af0-32b6211891dmr1662801637.51.1759452077454; Thu, 02
 Oct 2025 17:41:17 -0700 (PDT)
Date: Thu,  2 Oct 2025 17:41:01 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251003004102.2369463-1-irogers@google.com>
Subject: [PATCH v1 1/2] perf namespaces: Avoid get_current_dir_name dependency
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

get_current_dir_name is a GNU extension not supported on, for example,
Android. There is only one use of it so let's just switch to getcwd to
avoid build and other complexity.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config             |  4 ----
 tools/perf/util/Build                  |  1 -
 tools/perf/util/get_current_dir_name.c | 18 ------------------
 tools/perf/util/get_current_dir_name.h |  8 --------
 tools/perf/util/namespaces.c           | 14 +++++---------
 5 files changed, 5 insertions(+), 40 deletions(-)
 delete mode 100644 tools/perf/util/get_current_dir_name.c
 delete mode 100644 tools/perf/util/get_current_dir_name.h

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 0f4b297fbacc..6cdb96576cb8 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -417,10 +417,6 @@ ifeq ($(feature-eventfd), 1)
   CFLAGS += -DHAVE_EVENTFD_SUPPORT
 endif
 
-ifeq ($(feature-get_current_dir_name), 1)
-  CFLAGS += -DHAVE_GET_CURRENT_DIR_NAME
-endif
-
 ifeq ($(feature-gettid), 1)
   CFLAGS += -DHAVE_GETTID
 endif
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 5ead46dc98e7..9464eceb764b 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -23,7 +23,6 @@ perf-util-y += evsel_fprintf.o
 perf-util-y += perf_event_attr_fprintf.o
 perf-util-y += evswitch.o
 perf-util-y += find_bit.o
-perf-util-y += get_current_dir_name.o
 perf-util-y += levenshtein.o
 perf-util-y += mmap.o
 perf-util-y += memswap.o
diff --git a/tools/perf/util/get_current_dir_name.c b/tools/perf/util/get_current_dir_name.c
deleted file mode 100644
index e68935e9ac8c..000000000000
--- a/tools/perf/util/get_current_dir_name.c
+++ /dev/null
@@ -1,18 +0,0 @@
-// SPDX-License-Identifier: LGPL-2.1
-// Copyright (C) 2018, 2019 Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
-//
-#ifndef HAVE_GET_CURRENT_DIR_NAME
-#include "get_current_dir_name.h"
-#include <limits.h>
-#include <string.h>
-#include <unistd.h>
-
-/* Android's 'bionic' library, for one, doesn't have this */
-
-char *get_current_dir_name(void)
-{
-	char pwd[PATH_MAX];
-
-	return getcwd(pwd, sizeof(pwd)) == NULL ? NULL : strdup(pwd);
-}
-#endif // HAVE_GET_CURRENT_DIR_NAME
diff --git a/tools/perf/util/get_current_dir_name.h b/tools/perf/util/get_current_dir_name.h
deleted file mode 100644
index 69f7d5537d32..000000000000
--- a/tools/perf/util/get_current_dir_name.h
+++ /dev/null
@@ -1,8 +0,0 @@
-// SPDX-License-Identifier: LGPL-2.1
-// Copyright (C) 2018, 2019 Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
-//
-#ifndef __PERF_GET_CURRENT_DIR_NAME_H
-#ifndef HAVE_GET_CURRENT_DIR_NAME
-char *get_current_dir_name(void);
-#endif // HAVE_GET_CURRENT_DIR_NAME
-#endif // __PERF_GET_CURRENT_DIR_NAME_H
diff --git a/tools/perf/util/namespaces.c b/tools/perf/util/namespaces.c
index 68f5de2d79c7..d1475b79a4a7 100644
--- a/tools/perf/util/namespaces.c
+++ b/tools/perf/util/namespaces.c
@@ -6,7 +6,6 @@
 
 #include "namespaces.h"
 #include "event.h"
-#include "get_current_dir_name.h"
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
@@ -279,10 +278,9 @@ void nsinfo__set_in_pidns(struct nsinfo *nsi)
 void nsinfo__mountns_enter(struct nsinfo *nsi,
 				  struct nscookie *nc)
 {
-	char curpath[PATH_MAX];
+	char oldcwd[PATH_MAX];
 	int oldns = -1;
 	int newns = -1;
-	char *oldcwd = NULL;
 
 	if (nc == NULL)
 		return;
@@ -293,14 +291,14 @@ void nsinfo__mountns_enter(struct nsinfo *nsi,
 	if (!nsi || !nsinfo__need_setns(nsi))
 		return;
 
-	if (snprintf(curpath, PATH_MAX, "/proc/self/ns/mnt") >= PATH_MAX)
+	if (!getcwd(oldcwd, sizeof(oldcwd)))
 		return;
 
-	oldcwd = get_current_dir_name();
-	if (!oldcwd)
+	nc->oldcwd = strdup(oldcwd);
+	if (!nc->oldcwd)
 		return;
 
-	oldns = open(curpath, O_RDONLY);
+	oldns = open("/proc/self/ns/mnt", O_RDONLY);
 	if (oldns < 0)
 		goto errout;
 
@@ -311,13 +309,11 @@ void nsinfo__mountns_enter(struct nsinfo *nsi,
 	if (setns(newns, CLONE_NEWNS) < 0)
 		goto errout;
 
-	nc->oldcwd = oldcwd;
 	nc->oldns = oldns;
 	nc->newns = newns;
 	return;
 
 errout:
-	free(oldcwd);
 	if (oldns > -1)
 		close(oldns);
 	if (newns > -1)
-- 
2.51.0.618.g983fd99d29-goog


