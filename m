Return-Path: <linux-kernel+bounces-875148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F369AC184D5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 06:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04A571C62740
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 05:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BD82FA0D4;
	Wed, 29 Oct 2025 05:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="afvsTekO"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE27C302CA4
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 05:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761716076; cv=none; b=kREb8Q7KJcrFuJJRysqAMcBJY3QNQIiskqnm6tye+1EGsYZbv427/gE5tSTF95OynHC4U3s6JIz/pZNdPQoXNoudSK/GNicyLR7X5NoFeemEwispxl/UPoDBb19/auV+cuuiQldNisbDYl9Xiyj6dwCEQCXRigQJUZ5B3ldcfuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761716076; c=relaxed/simple;
	bh=74LyauEa54VSeyBugbC9rVUwrSwDFISXcFDxOO63Khs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=H6i3WaIh0RpzhJtg5UVikkGHMC2PDixcoFWtKpq2wvEC2v+E3FLbSUxsywuRfg5StUXnDZBBJuI0Zc26xHy7U7jxU+PusRB29zTxwadqgxjsnSphPxazddV55vbHm44hKtkh9Wyos4EMb3MjdelzXstLefMSXkbCl/BHN1ARTec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=afvsTekO; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-33bbbb41a84so14927661a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 22:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761716074; x=1762320874; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w2IX0DiDTomYBm5p1BWLB1HY9azDnjX1LkSLbsVS32A=;
        b=afvsTekOd8bVUWUBXV4G4PxlOsuJQ5nuTLnHsoSJZNrMSKmkVXwYzmYLV61w6yQ1Sr
         VI02ta1NP67jxQs1+HYDi2IQIFqa1KZ3NllxdZtdGjFeSLFVENt/VCOOzJTehORQZLmA
         cTH7FbgW9N1h2zQN0l1GK4ROwcsp3rqw/ZeqzpIBZ/bl8gMl4/NEZWnp3sKWdkNQnI+B
         HIDiOMneXkegIfoYG2haFw8TKp3RRZVMxrth8S8xiAmsNwWvt9rgeWzKm5CHyvZuwfqK
         kHi59AmURUpVEhIA7q1cGkMCMWvZt9QlPjJ6+4ANRuKB3E7EPUjr3bl7JScEinvOAaxE
         +1aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761716074; x=1762320874;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w2IX0DiDTomYBm5p1BWLB1HY9azDnjX1LkSLbsVS32A=;
        b=vUu/lemgkeDAyj1GnbdlC2ZVofOaf+d48XavMqz+RH2pVXFxWDxT8PVSkpsI36/8jr
         ENzaKes5bhh6dWZZEFQkYKFwIq6p2khviSlY50neG2qm359slp1HvNOdi/koBkZOuxs/
         kk/Ria4atdzYbdLwqeDXJ7HBbs3HeErUxGvL8TSfBQevkzhVCVI6jHWxImy39VKSIaXV
         FIqnFZoSNa1RrRBbjPGq6D+q0Hoq/g/anY9Pdg1/Jkz0M/m1feVowevnzbgrteo28fpF
         FVmjBpV2TcyvbvwN/cuP3Lst0Hsh+WJ1Wey8v6Qp1TBr9auZzk/Jb7hgV4sCIoDED+wZ
         5uWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNPG44U7QvURpsVZjpIaA2BKb2yN+WLZZmy/j1x+DzLwGVI8ywawHUibHlndlnRPf336mIYa2CRIZCmiE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0h+IAISbtxXU2hSrgQj80XhTzbYHLVpz8YiW+fEQJDOKxkAZY
	9HftRLOMIrmYPCx61aFpzoGTmZSI+JX0reUIP67uEHuNyLLN4HCGquhJFoa4ebF5H5NSb4Bzss7
	e8vZ5ehhGbQ==
X-Google-Smtp-Source: AGHT+IFiKkz/9OzVUG9X/jUDA0Ctos0V8/bNH6kNseIOK99SlYBiURzIzAp3RpTufC5uxH7Urtm1a+WEoomM
X-Received: from plrs15.prod.google.com ([2002:a17:902:b18f:b0:290:28e2:ce44])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d512:b0:262:9c4:5470
 with SMTP id d9443c01a7336-294dee9966emr21879795ad.28.1761716074024; Tue, 28
 Oct 2025 22:34:34 -0700 (PDT)
Date: Tue, 28 Oct 2025 22:34:07 -0700
In-Reply-To: <20251029053413.355154-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251029053413.355154-1-irogers@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251029053413.355154-10-irogers@google.com>
Subject: [RFC PATCH v1 09/15] perf data: Clean up use_stdio and structures
From: Ian Rogers <irogers@google.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	James Clark <james.clark@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Charlie Jenkins <charlie@rivosinc.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	Howard Chu <howardchu95@gmail.com>, Song Liu <song@kernel.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Blake Jones <blakejones@google.com>, 
	Anubhav Shelat <ashelat@redhat.com>, Chun-Tse Shao <ctshao@google.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Gautam Menghani <gautam@linux.ibm.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Yang Li <yang.lee@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Andi Kleen <ak@linux.intel.com>, Weilin Wang <weilin.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"

use_stdio was associated with struct perf_data and not perf_data_file
meaning there was implicit use of fd rather than fptr that may not be
safe. For example, in perf_data_file__write. Reorganize perf_data_file
to better abstract use_stdio, add kernel-doc and more consistently use
perf_data__ accessors so that use_stdio is better respected.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-inject.c |  7 ++--
 tools/perf/builtin-record.c | 10 +++--
 tools/perf/tests/topology.c |  3 +-
 tools/perf/util/data.c      | 81 ++++++++++++++++++++++++-------------
 tools/perf/util/data.h      | 52 ++++++++++++++++++++----
 tools/perf/util/session.c   |  2 +-
 6 files changed, 109 insertions(+), 46 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index a114b3fa1bea..bc2725dcdc8c 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -269,9 +269,8 @@ static s64 perf_event__repipe_auxtrace(struct perf_session *session,
 	inject->have_auxtrace = true;
 
 	if (!inject->output.is_pipe) {
-		off_t offset;
+		off_t offset = perf_data__seek(&inject->output, 0, SEEK_CUR);
 
-		offset = lseek(inject->output.file.fd, 0, SEEK_CUR);
 		if (offset == -1)
 			return -errno;
 		ret = auxtrace_index__auxtrace_event(&session->auxtrace_index,
@@ -2364,12 +2363,12 @@ int cmd_inject(int argc, const char **argv)
 		.output = {
 			.path = "-",
 			.mode = PERF_DATA_MODE_WRITE,
-			.use_stdio = true,
+			.file.use_stdio = true,
 		},
 	};
 	struct perf_data data = {
 		.mode = PERF_DATA_MODE_READ,
-		.use_stdio = true,
+		.file.use_stdio = true,
 	};
 	int ret;
 	const char *known_build_ids = NULL;
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index cb52aea9607d..3d8cf4090a92 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -453,7 +453,7 @@ static int record__aio_pushfn(struct mmap *map, void *to, void *buf, size_t size
 static int record__aio_push(struct record *rec, struct mmap *map, off_t *off)
 {
 	int ret, idx;
-	int trace_fd = rec->session->data->file.fd;
+	int trace_fd = perf_data__fd(rec->session->data);
 	struct record_aio aio = { .rec = rec, .size = 0 };
 
 	/*
@@ -1676,7 +1676,7 @@ static int record__mmap_read_evlist(struct record *rec, struct evlist *evlist,
 	int rc = 0;
 	int nr_mmaps;
 	struct mmap **maps;
-	int trace_fd = rec->data.file.fd;
+	int trace_fd = perf_data__fd(&rec->data);
 	off_t off = 0;
 
 	if (!evlist)
@@ -1885,8 +1885,10 @@ record__finish_output(struct record *rec)
 	rec->session->header.data_size += rec->bytes_written;
 	data->file.size = lseek(perf_data__fd(data), 0, SEEK_CUR);
 	if (record__threads_enabled(rec)) {
-		for (i = 0; i < data->dir.nr; i++)
-			data->dir.files[i].size = lseek(data->dir.files[i].fd, 0, SEEK_CUR);
+		for (i = 0; i < data->dir.nr; i++) {
+			data->dir.files[i].size =
+				perf_data_file__seek(&data->dir.files[i], 0, SEEK_CUR);
+		}
 	}
 
 	/* Buildid scanning disabled or build ID in kernel and synthesized map events. */
diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
index ec01150d208d..af4618c3124a 100644
--- a/tools/perf/tests/topology.c
+++ b/tools/perf/tests/topology.c
@@ -52,7 +52,8 @@ static int session_write_header(char *path)
 	session->header.data_size += DATA_SIZE;
 
 	TEST_ASSERT_VAL("failed to write header",
-			!perf_session__write_header(session, session->evlist, data.file.fd, true));
+			!perf_session__write_header(session, session->evlist,
+						    perf_data__fd(&data), true));
 
 	evlist__delete(session->evlist);
 	perf_session__delete(session);
diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index 164eb45a0b36..0dcd4b8c51ce 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -20,18 +20,30 @@
 #include "rlimit.h"
 #include <internal/lib.h>
 
-static void close_dir(struct perf_data_file *files, int nr)
+static void perf_data_file__close(struct perf_data_file *file)
 {
-	while (--nr >= 0) {
-		close(files[nr].fd);
-		zfree(&files[nr].path);
+	if (file->use_stdio) {
+		fclose(file->fptr);
+		file->fptr = NULL;
+	} else {
+		close(file->fd);
+		file->fd = -1;
 	}
+	zfree(&file->path);
+}
+
+static void close_dir(struct perf_data_file *files, int nr)
+{
+	while (--nr >= 0)
+		perf_data_file__close(&files[nr]);
+
 	free(files);
 }
 
 void perf_data__close_dir(struct perf_data *data)
 {
 	close_dir(data->dir.files, data->dir.nr);
+	data->dir.files = NULL;
 }
 
 int perf_data__create_dir(struct perf_data *data, int nr)
@@ -174,7 +186,7 @@ static bool check_pipe(struct perf_data *data)
 	}
 
 	if (is_pipe) {
-		if (data->use_stdio) {
+		if (data->file.use_stdio) {
 			const char *mode;
 
 			mode = perf_data__is_read(data) ? "r" : "w";
@@ -182,7 +194,7 @@ static bool check_pipe(struct perf_data *data)
 
 			if (data->file.fptr == NULL) {
 				data->file.fd = fd;
-				data->use_stdio = false;
+				data->file.use_stdio = false;
 			}
 
 		/*
@@ -353,7 +365,7 @@ int perf_data__open(struct perf_data *data)
 		return 0;
 
 	/* currently it allows stdio for pipe only */
-	data->use_stdio = false;
+	data->file.use_stdio = false;
 
 	if (!data->path)
 		data->path = "perf.data";
@@ -373,41 +385,55 @@ void perf_data__close(struct perf_data *data)
 	if (perf_data__is_dir(data))
 		perf_data__close_dir(data);
 
-	zfree(&data->file.path);
-
-	if (data->use_stdio)
-		fclose(data->file.fptr);
-	else
-		close(data->file.fd);
+	perf_data_file__close(&data->file);
 }
 
-ssize_t perf_data__read(struct perf_data *data, void *buf, size_t size)
+static ssize_t perf_data_file__read(struct perf_data_file *file, void *buf, size_t size)
 {
-	if (data->use_stdio) {
-		if (fread(buf, size, 1, data->file.fptr) == 1)
+	if (file->use_stdio) {
+		if (fread(buf, size, 1, file->fptr) == 1)
 			return size;
-		return feof(data->file.fptr) ? 0 : -1;
+		return feof(file->fptr) ? 0 : -1;
 	}
-	return readn(data->file.fd, buf, size);
+	return readn(file->fd, buf, size);
+}
+
+ssize_t perf_data__read(struct perf_data *data, void *buf, size_t size)
+{
+	return perf_data_file__read(&data->file, buf, size);
 }
 
 ssize_t perf_data_file__write(struct perf_data_file *file,
 			      void *buf, size_t size)
 {
+	if (file->use_stdio) {
+		if (fwrite(buf, size, /*nmemb=*/1, file->fptr) == 1)
+			return size;
+		return -1;
+	}
 	return writen(file->fd, buf, size);
 }
 
 ssize_t perf_data__write(struct perf_data *data,
 			 void *buf, size_t size)
 {
-	if (data->use_stdio) {
-		if (fwrite(buf, size, 1, data->file.fptr) == 1)
-			return size;
-		return -1;
-	}
 	return perf_data_file__write(&data->file, buf, size);
 }
 
+off_t perf_data_file__seek(struct perf_data_file *file, off_t offset, int whence)
+{
+	if (file->use_stdio)
+		return fseek(file->fptr, offset, whence);
+
+	return lseek(file->fd, offset, whence);
+}
+
+off_t perf_data__seek(struct perf_data *data, off_t offset, int whence)
+{
+	assert(!data->is_pipe);
+	return perf_data_file__seek(&data->file, offset, whence);
+}
+
 int perf_data__switch(struct perf_data *data,
 		      const char *postfix,
 		      size_t pos, bool at_exit,
@@ -429,19 +455,18 @@ int perf_data__switch(struct perf_data *data,
 		pr_warning("Failed to rename %s to %s\n", data->path, *new_filepath);
 
 	if (!at_exit) {
-		close(data->file.fd);
+		perf_data_file__close(&data->file);
 		ret = perf_data__open(data);
 		if (ret < 0)
 			goto out;
 
-		if (lseek(data->file.fd, pos, SEEK_SET) == (off_t)-1) {
+		if (perf_data__seek(data, pos, SEEK_SET) == (off_t)-1) {
 			ret = -errno;
-			pr_debug("Failed to lseek to %zu: %s",
-				 pos, strerror(errno));
+			pr_debug("Failed to seek to %zu: %s", pos, strerror(errno));
 			goto out;
 		}
 	}
-	ret = data->file.fd;
+	ret = perf_data__fd(data);
 out:
 	return ret;
 }
diff --git a/tools/perf/util/data.h b/tools/perf/util/data.h
index 1438e32e0451..71f06df7abdb 100644
--- a/tools/perf/util/data.h
+++ b/tools/perf/util/data.h
@@ -17,32 +17,70 @@ enum perf_dir_version {
 	PERF_DIR_VERSION	= 1,
 };
 
+/**
+ * struct perf_data_file: A wrapper around a file used for perf.data reading or writing. Generally part
+ * of struct perf_data.
+ */
 struct perf_data_file {
+	/**
+	 * @path: Path of file. Generally a copy of perf_data.path but for a
+	 * directory it is the file within the directory.
+	 */
 	char		*path;
 	union {
+		/** @fd: File descriptor for read/writes. Valid if use_stdio is false. */
 		int	 fd;
+		/**
+		 * @fptr: Stdio FILE. Valid if use_stdio is true, currently just
+		 * pipes in perf inject.
+		 */
 		FILE	*fptr;
 	};
+	/** @size: Size of file when opened. */
 	unsigned long	 size;
+	/** @use_stdio: Use buffered stdio operations. */
+	bool		 use_stdio;
 };
 
+/**
+ * struct perf_data: A wrapper around a file used for perf.data reading or writing.
+ */
 struct perf_data {
+	/** @path: Path to open and of the file. NULL implies 'perf.data' will be used. */
 	const char		*path;
+	/** @file: Underlying file to be used. */
 	struct perf_data_file	 file;
+	/** @is_pipe: Underlying file is a pipe. */
 	bool			 is_pipe;
+	/** @is_dir: Underlying file is a directory. */
 	bool			 is_dir;
+	/** @force: Ignore opening a file creating created by a different user. */
 	bool			 force;
-	bool			 use_stdio;
+	/** @in_place_update: A file opened for reading but will be written to. */
 	bool			 in_place_update;
+	/** @mode: Read or write mode. */
 	enum perf_data_mode	 mode;
 
 	struct {
+		/** @version: perf_dir_version. */
 		u64			 version;
+		/** @files: perf data files for the directory. */
 		struct perf_data_file	*files;
+		/** @nr: Number of perf data files for the directory. */
 		int			 nr;
 	} dir;
 };
 
+static inline int perf_data_file__fd(struct perf_data_file *file)
+{
+	return file->use_stdio ? fileno(file->fptr) : file->fd;
+}
+
+ssize_t perf_data_file__write(struct perf_data_file *file,
+			      void *buf, size_t size);
+off_t perf_data_file__seek(struct perf_data_file *file, off_t offset, int whence);
+
+
 static inline bool perf_data__is_read(struct perf_data *data)
 {
 	return data->mode == PERF_DATA_MODE_READ;
@@ -70,10 +108,7 @@ static inline bool perf_data__is_single_file(struct perf_data *data)
 
 static inline int perf_data__fd(struct perf_data *data)
 {
-	if (data->use_stdio)
-		return fileno(data->file.fptr);
-
-	return data->file.fd;
+	return perf_data_file__fd(&data->file);
 }
 
 int perf_data__open(struct perf_data *data);
@@ -81,8 +116,7 @@ void perf_data__close(struct perf_data *data);
 ssize_t perf_data__read(struct perf_data *data, void *buf, size_t size);
 ssize_t perf_data__write(struct perf_data *data,
 			 void *buf, size_t size);
-ssize_t perf_data_file__write(struct perf_data_file *file,
-			      void *buf, size_t size);
+off_t perf_data__seek(struct perf_data *data, off_t offset, int whence);
 /*
  * If at_exit is set, only rename current perf.data to
  * perf.data.<postfix>, continue write on original data.
@@ -99,8 +133,10 @@ int perf_data__open_dir(struct perf_data *data);
 void perf_data__close_dir(struct perf_data *data);
 unsigned long perf_data__size(struct perf_data *data);
 int perf_data__make_kcore_dir(struct perf_data *data, char *buf, size_t buf_sz);
-bool has_kcore_dir(const char *path);
 char *perf_data__kallsyms_name(struct perf_data *data);
 char *perf_data__guest_kallsyms_name(struct perf_data *data, pid_t machine_pid);
+
+bool has_kcore_dir(const char *path);
 bool is_perf_data(const char *path);
+
 #endif /* __PERF_DATA_H */
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 09af486c83e4..081e68c72c30 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -2358,7 +2358,7 @@ static int __perf_session__process_dir_events(struct perf_session *session)
 		if (!data->dir.files[i].size)
 			continue;
 		rd[readers] = (struct reader) {
-			.fd		 = data->dir.files[i].fd,
+			.fd		 = perf_data_file__fd(&data->dir.files[i]),
 			.path		 = data->dir.files[i].path,
 			.data_size	 = data->dir.files[i].size,
 			.data_offset	 = 0,
-- 
2.51.1.851.g4ebd6896fd-goog


