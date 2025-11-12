Return-Path: <linux-kernel+bounces-896687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A835DC50FFE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 08:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCD4E3A3A61
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 07:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998682DBF7C;
	Wed, 12 Nov 2025 07:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e/39kuo1"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5552C11FE
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 07:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762933397; cv=none; b=MhHOh8es7V9sDvRAudxgJvT8EiAEZ+Y2EDs3ETpeiu+SAVQFnDURq43EsgCZiVkNFuRgrWPIgXN03yAzruo4qgNnHeheT5imXYWDS736d691Dz9Cu7Zc+t1h71HN9FHuTUIpnjhZs6kxIkSBGrI2SInZtVrH5bw0mcX/4s3fkWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762933397; c=relaxed/simple;
	bh=QZumcc+aGuEyWSU11cBF1Lm2JEA58vA2/+jRiRWwFsM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=mNtMuXXDaHRGE45kMTH5WkIXC17rj1cERnrVjn04CF5cCA4XRt53UbvdeXs4pVKfQAAXxwg0jDiBw91yeH3NcosnHuDWd2WQELWqgPncd0429ij5PghF6noy9i2EOj5n39lpFo3tp0CF4KgYG4Tqd+6CJIB2b7r8P8lksVFkm6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e/39kuo1; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-ba265ee0e34so479830a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 23:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762933396; x=1763538196; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iDxlg3rjq7IUfgkqdF3QzT2vSrqjrpZ2K7ERAvuReQE=;
        b=e/39kuo1C1lGdvfxoN0gl8F6uTFSZt4e7U9TS2Vd2sELFIfULh2ZIq+VzwP+xe0s55
         SQgY/4068kWD/yakY0b5ZQL6g/cLnkY21QMaH46M0SWv/czamM7z2j/+ygi0FVS2zHMk
         nG/skQ/NgXFKKgEWxaZIuZvo0bhQnDH0a0fblDHB7ZRLFToe54D3/5t8USDeNd+Xbjci
         pxvVd1V4FYEDgcSMJ4yeEezC6lK+6UOdNK8NjbphiSIDYsNWXZjSflNYABXq+uoC0/vC
         l7R3U3TFIRr/X8qAMVsqyWg4HAX3bWradXz+JeLfAPa0VJ6qci/9b1g3kSt4ktkWP3xS
         kZbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762933396; x=1763538196;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iDxlg3rjq7IUfgkqdF3QzT2vSrqjrpZ2K7ERAvuReQE=;
        b=gUoIwwqvA3X7/aOywfgEwB+78u5lV6MlO/pqedb9waLhb8V+y+9nLaulnYlBVsWZ9x
         iHDBA5+gl3sXlrmJxzvRQA5Hft/qwF0KiiE6ioCl9O80SATzDNU+NHwWaEhAsAUGH5XJ
         2G8c18CLTxQ6wrkOreEL8BRRCz3NXinrrc1AphrEegdg4V5gLVJQwmmxa1+p2o7ZqdT1
         VEflHRvOEsCg0aOe6pU5f9soslRbb/dTS77zJCLWyq7taNhmZgzTm2zx2VK1YTwjknZ1
         lp8ZybkaYWggjuzGvHn4i9QkDoFTBZmflIW7cWdfKIn3HZV4OGj/J5UClBZkWwxaSeje
         xxVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXshd85c5Vflp6J+/Jek7eLc22urpdCHSn0F771XNxh8n+17t1GwnJJoxnAFtcOkxgM+9P4beYgDj5k414=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya28ae7vaBb+1lXL2nhmSLoK28QnUHe73Xg7GfIc8fElzKGJ5Z
	L35ap2aEyqbyXbjfhkOJPooU4bf8uDWGU0w2zfJpGOIkcnHpHbSu6Cy2Eky1C2mkfUq2yzeDs+L
	sf1UHFjnVjA==
X-Google-Smtp-Source: AGHT+IFlCJoHl4U0qhCyKZm/cv+eMqTRrwx9eTjHB4ufjp5u24z+RJZmtmB6/nLtuNj70VwaJ52q87cSYoOs
X-Received: from dlbdx18.prod.google.com ([2002:a05:7022:e12:b0:119:49ca:6b96])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3c8d:b0:34e:cc0a:40b2
 with SMTP id adf61e73a8af0-3590b02ad56mr2632422637.30.1762933395749; Tue, 11
 Nov 2025 23:43:15 -0800 (PST)
Date: Tue, 11 Nov 2025 23:43:11 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251112074311.1440101-1-irogers@google.com>
Subject: [PATCH v2] perf libbfd: Ensure libbfd is initialized prior to use
From: Ian Rogers <irogers@google.com>
To: Guilherme Amadio <amadio@gentoo.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Multiple threads may be creating and destroying BFD objects in
situations like `perf top`. Without appropriate initialization crashes
may occur during libbfd's cache management. BFD's locks require
recursive mutexes, add support for these.

Reported-by: Guilherme Amadio <amadio@gentoo.org>
Closes: https://lore.kernel.org/lkml/aQt66zhfxSA80xwt@gentoo.org/
Fixes: 95931d9a594d ("perf libbfd: Move libbfd functionality to its own file")
Signed-off-by: Ian Rogers <irogers@google.com>
---
v2: Remove unneeded unistd.h include.
---
 tools/perf/util/libbfd.c | 38 ++++++++++++++++++++++++++++++++++++++
 tools/perf/util/mutex.c  | 14 ++++++++++----
 tools/perf/util/mutex.h  |  2 ++
 3 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/libbfd.c b/tools/perf/util/libbfd.c
index 01147fbf73b3..6434c2dccd4a 100644
--- a/tools/perf/util/libbfd.c
+++ b/tools/perf/util/libbfd.c
@@ -38,6 +38,39 @@ struct a2l_data {
 	asymbol **syms;
 };
 
+static bool perf_bfd_lock(void *bfd_mutex)
+{
+	mutex_lock(bfd_mutex);
+	return true;
+}
+
+static bool perf_bfd_unlock(void *bfd_mutex)
+{
+	mutex_unlock(bfd_mutex);
+	return true;
+}
+
+static void perf_bfd_init(void)
+{
+	static struct mutex bfd_mutex;
+
+	mutex_init_recursive(&bfd_mutex);
+
+	if (bfd_init() != BFD_INIT_MAGIC) {
+		pr_err("Error initializing libbfd\n");
+		return;
+	}
+	if (!bfd_thread_init(perf_bfd_lock, perf_bfd_unlock, &bfd_mutex))
+		pr_err("Error initializing libbfd threading\n");
+}
+
+static void ensure_bfd_init(void)
+{
+	static pthread_once_t bfd_init_once = PTHREAD_ONCE_INIT;
+
+	pthread_once(&bfd_init_once, perf_bfd_init);
+}
+
 static int bfd_error(const char *string)
 {
 	const char *errmsg;
@@ -132,6 +165,7 @@ static struct a2l_data *addr2line_init(const char *path)
 	bfd *abfd;
 	struct a2l_data *a2l = NULL;
 
+	ensure_bfd_init();
 	abfd = bfd_openr(path, NULL);
 	if (abfd == NULL)
 		return NULL;
@@ -288,6 +322,7 @@ int dso__load_bfd_symbols(struct dso *dso, const char *debugfile)
 	bfd *abfd;
 	u64 start, len;
 
+	ensure_bfd_init();
 	abfd = bfd_openr(debugfile, NULL);
 	if (!abfd)
 		return -1;
@@ -393,6 +428,7 @@ int libbfd__read_build_id(const char *filename, struct build_id *bid, bool block
 	if (fd < 0)
 		return -1;
 
+	ensure_bfd_init();
 	abfd = bfd_fdopenr(filename, /*target=*/NULL, fd);
 	if (!abfd)
 		return -1;
@@ -421,6 +457,7 @@ int libbfd_filename__read_debuglink(const char *filename, char *debuglink,
 	asection *section;
 	bfd *abfd;
 
+	ensure_bfd_init();
 	abfd = bfd_openr(filename, NULL);
 	if (!abfd)
 		return -1;
@@ -480,6 +517,7 @@ int symbol__disassemble_bpf_libbfd(struct symbol *sym __maybe_unused,
 	memset(tpath, 0, sizeof(tpath));
 	perf_exe(tpath, sizeof(tpath));
 
+	ensure_bfd_init();
 	bfdf = bfd_openr(tpath, NULL);
 	if (bfdf == NULL)
 		abort();
diff --git a/tools/perf/util/mutex.c b/tools/perf/util/mutex.c
index bca7f0717f35..7aa1f3f55a7d 100644
--- a/tools/perf/util/mutex.c
+++ b/tools/perf/util/mutex.c
@@ -17,7 +17,7 @@ static void check_err(const char *fn, int err)
 
 #define CHECK_ERR(err) check_err(__func__, err)
 
-static void __mutex_init(struct mutex *mtx, bool pshared)
+static void __mutex_init(struct mutex *mtx, bool pshared, bool recursive)
 {
 	pthread_mutexattr_t attr;
 
@@ -27,21 +27,27 @@ static void __mutex_init(struct mutex *mtx, bool pshared)
 	/* In normal builds enable error checking, such as recursive usage. */
 	CHECK_ERR(pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_ERRORCHECK));
 #endif
+	if (recursive)
+		CHECK_ERR(pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE));
 	if (pshared)
 		CHECK_ERR(pthread_mutexattr_setpshared(&attr, PTHREAD_PROCESS_SHARED));
-
 	CHECK_ERR(pthread_mutex_init(&mtx->lock, &attr));
 	CHECK_ERR(pthread_mutexattr_destroy(&attr));
 }
 
 void mutex_init(struct mutex *mtx)
 {
-	__mutex_init(mtx, /*pshared=*/false);
+	__mutex_init(mtx, /*pshared=*/false, /*recursive=*/false);
 }
 
 void mutex_init_pshared(struct mutex *mtx)
 {
-	__mutex_init(mtx, /*pshared=*/true);
+	__mutex_init(mtx, /*pshared=*/true, /*recursive=*/false);
+}
+
+void mutex_init_recursive(struct mutex *mtx)
+{
+	__mutex_init(mtx, /*pshared=*/false, /*recursive=*/true);
 }
 
 void mutex_destroy(struct mutex *mtx)
diff --git a/tools/perf/util/mutex.h b/tools/perf/util/mutex.h
index 38458f00846f..70232d8d094f 100644
--- a/tools/perf/util/mutex.h
+++ b/tools/perf/util/mutex.h
@@ -104,6 +104,8 @@ void mutex_init(struct mutex *mtx);
  * process-private attribute.
  */
 void mutex_init_pshared(struct mutex *mtx);
+/* Initializes a mutex that may be recursively held on the same thread. */
+void mutex_init_recursive(struct mutex *mtx);
 void mutex_destroy(struct mutex *mtx);
 
 void mutex_lock(struct mutex *mtx) EXCLUSIVE_LOCK_FUNCTION(*mtx);
-- 
2.51.2.1041.gc1ab5b90ca-goog


