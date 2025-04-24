Return-Path: <linux-kernel+bounces-619169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB32EA9B8A3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 22:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEDEA1BA331E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 20:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC38296147;
	Thu, 24 Apr 2025 19:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WfSmb60a"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931742951C2
	for <linux-kernel@vger.kernel.org>; Thu, 24 Apr 2025 19:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745524733; cv=none; b=LA45J1byzA6Uq1cObkUmk34uolRP7bYhfnvofC78qs3N1lqEo6v4H5InE7y4nmdYerm8QuXoRC+KQbvdvfnlSYb6yVh4/jy46+Y06XjrKhNDheTonYn2uXg1YfmrNJGRgZLhVR7jVT++w0gu8/x8n4aFzlrvPWBC6xZcE7aRaZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745524733; c=relaxed/simple;
	bh=FUxkNSBQwPvwI3DK+3JFd2kvbAYE2XqIDCvtAGCpUBs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=cv4VS4L9hX1PWPOrLl2Vrq5G2LTkp7jbd25pabx53w1lwE03pSMYKxvtAQ9PifIrSCgeiKnLlzE7AM0AE7djh4sVrypgWOp72/3B2SYRcCJRHU/r7DBjBhE/RvS2ZkTWDyQhyHW6z+fkLek+KeUD/weHqGbUdcrD7qFIsXE9nV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WfSmb60a; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-af534e796baso768731a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Apr 2025 12:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745524729; x=1746129529; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iN0z0PcQkJmC5+SkQ0XkHWi4VMzjfgAlXTq02Q2bWcY=;
        b=WfSmb60aKnRzbMO5EBTdHGTGlCjFnMo6QmJUPO2BeTRFTPzCk/D4f3wEiLtTsy04Rj
         oDxzko761YK1nTLSLjV7evAGZW7kxIYkxW2VgksmrTw2jzYnzV/EOnl356+p/6eN6ZYj
         uiMumBX0dulmGZTJyqqe6xMsqmbRFl63UgAohYEpRRbpBoebXF5bFuFe6Tv8+0ViRWQu
         CuKI+0NrAWeEyKLp9lrGwRnRuG5fwqGBwvSQ54iwY2mOUzuehC5+o0FervKpecqgPB3T
         pcMqBre4uKldBABpRpf6RZM0w4ZvMhKyeUlK7U+YDgX2fBFOxq2CAKgGjIa6nD/91qvl
         8MTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745524729; x=1746129529;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iN0z0PcQkJmC5+SkQ0XkHWi4VMzjfgAlXTq02Q2bWcY=;
        b=S8AVKG3LHu18A6qR1BkIyNF4uS+m2tZpOfE+zIGSn7y1Ip+9FEKTI55jvNFvrmHhmX
         CLpSgWnhouTQpDKj7u33UhwzA1pwqSs6NQCcq0AtC61yogrymnarlNlKLo1Didg8nF1n
         FGpEzm8Ho72aG6eTcwsGYq0H7OqVHyRYChQshyqmqSXT2ulkltZ/LsqK3ZHYzwF1KNeu
         z0df84VDd8wUP7khBXKbHIxgZh5N+1xxySUKPsROAeJSb3DgewAqIJw5RcEsD9W3+0Qv
         8luGlqAQis3n+J5Zu8kGPHeuByDAbHtv8uRzfFB5jOMu1RvA5KU0le0KhxvOuCBZ2pN6
         uGog==
X-Forwarded-Encrypted: i=1; AJvYcCV3vZQJtwRPsDmnSQrvVp2zFarrBERfORTQo5OLWcYgLZhDrwQ7dMgub0eU3J5dedvnZRyVMonEx6haiqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcNZijZ/Z2cVZtLAO3EB7krdgptg3u30ul6PO2JkwJwNKGadB2
	msS1/N76aRBa6qf5Tx4Gwbx7QoaKHLyaGzPXG7TkUQz9/SuoZotuCkWNnfQtBjbgGk0Dqg/RaGG
	JWTVRWQ==
X-Google-Smtp-Source: AGHT+IEGmSHlwze/Im0v9HLZ859wIfp5l3hnjrdOh0YqXLcxxflTH6jxVLnmJQnhuv8OVuZ7B2cr/42DpYHr
X-Received: from pfbff10.prod.google.com ([2002:a05:6a00:2f4a:b0:730:8e17:ed13])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d8e:b0:1f5:8da5:ffe9
 with SMTP id adf61e73a8af0-204565e6a5emr822092637.12.1745524728696; Thu, 24
 Apr 2025 12:58:48 -0700 (PDT)
Date: Thu, 24 Apr 2025 12:58:30 -0700
In-Reply-To: <20250424195831.1767457-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250424195831.1767457-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.850.g28803427d3-goog
Message-ID: <20250424195831.1767457-8-irogers@google.com>
Subject: [PATCH v2 7/8] perf dso: Move build_id to dso_id
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Li Huafei <lihuafei1@huawei.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, James Clark <james.clark@linaro.org>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Andi Kleen <ak@linux.intel.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Zixian Cai <fzczx123@gmail.com>, 
	Steve Clevenger <scclevenger@os.amperecomputing.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Martin Liska <martin.liska@hey.com>, 
	"=?UTF-8?q?Martin=20Li=C5=A1ka?=" <m.liska@foxlink.cz>, Song Liu <song@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The dso_id previously contained the major, minor, inode and inode
generation information from a mmap2 event - the inode generation would
be zero when reading from /proc/pid/maps. The build_id was in the
dso. With build ID mmap2 events these fields wouldn't be initialized
which would largely mean the special empty case where any dso would
match for equality. This isn't desirable as if a dso is replaced we
want the comparison to yield a difference.

To support detecting the difference between DSOs based on build_id,
move the build_id out of the DSO and into the dso_id. The dso_id is
also stored in the DSO so nothing is lost. Capture in the dso_id what
parts have been initialized and rename dso_id__inject to
dso_id__improve_id so that it is clear the dso_id is being improved
upon with additional information. With the build_id in the dso_id, use
memcmp to compare for equality.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-buildid-list.c       |   2 +-
 tools/perf/builtin-inject.c             |  32 ++++---
 tools/perf/builtin-report.c             |  11 ++-
 tools/perf/include/perf/perf_dlfilter.h |   2 +-
 tools/perf/tests/symbols.c              |   4 +-
 tools/perf/util/build-id.c              |   4 +-
 tools/perf/util/dso.c                   | 109 +++++++++++++-----------
 tools/perf/util/dso.h                   |  75 ++++++++--------
 tools/perf/util/dsos.c                  |  18 ++--
 tools/perf/util/machine.c               |  28 +++---
 tools/perf/util/map.c                   |  13 ++-
 tools/perf/util/map.h                   |   5 +-
 tools/perf/util/sort.c                  |  27 +++---
 tools/perf/util/synthetic-events.c      |  18 ++--
 14 files changed, 194 insertions(+), 154 deletions(-)

diff --git a/tools/perf/builtin-buildid-list.c b/tools/perf/builtin-buildid-list.c
index ba8ba0303920..151cd84b6dfe 100644
--- a/tools/perf/builtin-buildid-list.c
+++ b/tools/perf/builtin-buildid-list.c
@@ -31,7 +31,7 @@ static int buildid__map_cb(struct map *map, void *arg __maybe_unused)
 
 	memset(bid_buf, 0, sizeof(bid_buf));
 	if (dso__has_build_id(dso))
-		build_id__snprintf(dso__bid_const(dso), bid_buf, sizeof(bid_buf));
+		build_id__snprintf(dso__bid(dso), bid_buf, sizeof(bid_buf));
 	printf("%s %16" PRIx64 " %16" PRIx64, bid_buf, map__start(map), map__end(map));
 	if (dso_long_name != NULL)
 		printf(" %s", dso_long_name);
diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 11e49cafa3af..e74a3a70ff6f 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -587,15 +587,17 @@ static int perf_event__repipe_mmap2(const struct perf_tool *tool,
 				struct perf_sample *sample,
 				struct machine *machine)
 {
-	struct dso_id id;
-	struct dso_id *dso_id = NULL;
+	struct dso_id id = dso_id_empty;
 
-	if (!(event->header.misc & PERF_RECORD_MISC_MMAP_BUILD_ID)) {
+	if (event->header.misc & PERF_RECORD_MISC_MMAP_BUILD_ID) {
+		build_id__init(&id.build_id, event->mmap2.build_id, event->mmap2.build_id_size);
+	} else {
 		id.maj = event->mmap2.maj;
 		id.min = event->mmap2.min;
 		id.ino = event->mmap2.ino;
 		id.ino_generation = event->mmap2.ino_generation;
-		dso_id = &id;
+		id.mmap2_valid = true;
+		id.mmap2_ino_generation_valid = true;
 	}
 
 	return perf_event__repipe_common_mmap(
@@ -603,7 +605,7 @@ static int perf_event__repipe_mmap2(const struct perf_tool *tool,
 		event->mmap2.pid, event->mmap2.tid,
 		event->mmap2.start, event->mmap2.len, event->mmap2.pgoff,
 		event->mmap2.flags, event->mmap2.prot,
-		event->mmap2.filename, dso_id,
+		event->mmap2.filename, &id,
 		perf_event__process_mmap2);
 }
 
@@ -671,19 +673,20 @@ static int perf_event__repipe_tracing_data(struct perf_session *session,
 static int dso__read_build_id(struct dso *dso)
 {
 	struct nscookie nsc;
+	struct build_id bid;
 
 	if (dso__has_build_id(dso))
 		return 0;
 
 	mutex_lock(dso__lock(dso));
 	nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
-	if (filename__read_build_id(dso__long_name(dso), dso__bid(dso)) > 0)
-		dso__set_has_build_id(dso);
+	if (filename__read_build_id(dso__long_name(dso), &bid) > 0)
+		dso__set_build_id(dso, &bid);
 	else if (dso__nsinfo(dso)) {
 		char *new_name = dso__filename_with_chroot(dso, dso__long_name(dso));
 
-		if (new_name && filename__read_build_id(new_name, dso__bid(dso)) > 0)
-			dso__set_has_build_id(dso);
+		if (new_name && filename__read_build_id(new_name, &bid) > 0)
+			dso__set_build_id(dso, &bid);
 		free(new_name);
 	}
 	nsinfo__mountns_exit(&nsc);
@@ -732,10 +735,11 @@ static bool perf_inject__lookup_known_build_id(struct perf_inject *inject,
 					       struct dso *dso)
 {
 	struct str_node *pos;
-	int bid_len;
+	struct build_id bid;
 
 	strlist__for_each_entry(pos, inject->known_build_ids) {
 		const char *build_id, *dso_name;
+		int bid_len;
 
 		build_id = skip_spaces(pos->s);
 		dso_name = strchr(build_id, ' ');
@@ -744,11 +748,11 @@ static bool perf_inject__lookup_known_build_id(struct perf_inject *inject,
 		if (strcmp(dso__long_name(dso), dso_name))
 			continue;
 		for (int ix = 0; 2 * ix + 1 < bid_len; ++ix) {
-			dso__bid(dso)->data[ix] = (hex(build_id[2 * ix]) << 4 |
-						  hex(build_id[2 * ix + 1]));
+			bid.data[ix] = (hex(build_id[2 * ix]) << 4 |
+					hex(build_id[2 * ix + 1]));
 		}
-		dso__bid(dso)->size = bid_len / 2;
-		dso__set_has_build_id(dso);
+		bid.size = bid_len / 2;
+		dso__set_build_id(dso, &bid);
 		return true;
 	}
 	return false;
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index f0299c7ee025..98b1f73c28da 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -858,17 +858,24 @@ static int maps__fprintf_task_cb(struct map *map, void *data)
 	struct maps__fprintf_task_args *args = data;
 	const struct dso *dso = map__dso(map);
 	u32 prot = map__prot(map);
+	const struct dso_id *dso_id = dso__id_const(dso);
 	int ret;
+	char buf[SBUILD_ID_SIZE];
+
+	if (dso_id->mmap2_valid)
+		snprintf(buf, sizeof(buf), "%" PRIu64, dso_id->ino);
+	else
+		build_id__snprintf(&dso_id->build_id, buf, sizeof(buf));
 
 	ret = fprintf(args->fp,
-		"%*s  %" PRIx64 "-%" PRIx64 " %c%c%c%c %08" PRIx64 " %" PRIu64 " %s\n",
+		"%*s  %" PRIx64 "-%" PRIx64 " %c%c%c%c %08" PRIx64 " %s %s\n",
 		args->indent, "", map__start(map), map__end(map),
 		prot & PROT_READ ? 'r' : '-',
 		prot & PROT_WRITE ? 'w' : '-',
 		prot & PROT_EXEC ? 'x' : '-',
 		map__flags(map) ? 's' : 'p',
 		map__pgoff(map),
-		dso__id_const(dso)->ino, dso__name(dso));
+		buf, dso__name(dso));
 
 	if (ret < 0)
 		return ret;
diff --git a/tools/perf/include/perf/perf_dlfilter.h b/tools/perf/include/perf/perf_dlfilter.h
index 16fc4568ac53..2d3540ed3c58 100644
--- a/tools/perf/include/perf/perf_dlfilter.h
+++ b/tools/perf/include/perf/perf_dlfilter.h
@@ -87,7 +87,7 @@ struct perf_dlfilter_al {
 	__u8  is_64_bit; /* Only valid if dso is not NULL */
 	__u8  is_kernel_ip; /* True if in kernel space */
 	__u32 buildid_size;
-	__u8 *buildid;
+	const __u8 *buildid;
 	/* Below members are only populated by resolve_ip() */
 	__u8 filtered; /* True if this sample event will be filtered out */
 	const char *comm;
diff --git a/tools/perf/tests/symbols.c b/tools/perf/tests/symbols.c
index ee20a366f32f..b07fdf831868 100644
--- a/tools/perf/tests/symbols.c
+++ b/tools/perf/tests/symbols.c
@@ -96,8 +96,8 @@ static int create_map(struct test_info *ti, char *filename, struct map **map_p)
 	dso__put(dso);
 
 	/* Create a dummy map at 0x100000 */
-	*map_p = map__new(ti->machine, 0x100000, 0xffffffff, 0, NULL,
-			  PROT_EXEC, 0, NULL, filename, ti->thread);
+	*map_p = map__new(ti->machine, 0x100000, 0xffffffff, 0, &dso_id_empty,
+			  PROT_EXEC, /*flags=*/0, filename, ti->thread);
 	if (!*map_p) {
 		pr_debug("Failed to create map!");
 		return TEST_FAIL;
diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index 3386fa8e1e7e..b8d784120f20 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -251,7 +251,7 @@ char *__dso__build_id_filename(const struct dso *dso, char *bf, size_t size,
 	if (!dso__has_build_id(dso))
 		return NULL;
 
-	build_id__snprintf(dso__bid_const(dso), sbuild_id, sizeof(sbuild_id));
+	build_id__snprintf(dso__bid(dso), sbuild_id, sizeof(sbuild_id));
 	linkname = build_id_cache__linkname(sbuild_id, NULL, 0);
 	if (!linkname)
 		return NULL;
@@ -334,7 +334,7 @@ static int machine__write_buildid_table_cb(struct dso *dso, void *data)
 	}
 
 	in_kernel = dso__kernel(dso) || is_kernel_module(name, PERF_RECORD_MISC_CPUMODE_UNKNOWN);
-	return write_buildid(name, name_len, dso__bid(dso), args->machine->pid,
+	return write_buildid(name, name_len, &dso__id(dso)->build_id, args->machine->pid,
 			     in_kernel ? args->kmisc : args->umisc, args->fd);
 }
 
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 776506b93b8b..493750142de7 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -217,7 +217,7 @@ int dso__read_binary_type_filename(const struct dso *dso,
 			break;
 		}
 
-		build_id__snprintf(dso__bid_const(dso), build_id_hex, sizeof(build_id_hex));
+		build_id__snprintf(dso__bid(dso), build_id_hex, sizeof(build_id_hex));
 		len = __symbol__join_symfs(filename, size, "/usr/lib/debug/.build-id/");
 		snprintf(filename + len, size - len, "%.2s/%s.debug",
 			 build_id_hex, build_id_hex + 2);
@@ -1379,64 +1379,76 @@ static void dso__set_long_name_id(struct dso *dso, const char *name, bool name_a
 
 static int __dso_id__cmp(const struct dso_id *a, const struct dso_id *b)
 {
-	if (a->maj > b->maj) return -1;
-	if (a->maj < b->maj) return 1;
+	if (a->mmap2_valid && b->mmap2_valid) {
+		if (a->maj > b->maj) return -1;
+		if (a->maj < b->maj) return 1;
 
-	if (a->min > b->min) return -1;
-	if (a->min < b->min) return 1;
+		if (a->min > b->min) return -1;
+		if (a->min < b->min) return 1;
 
-	if (a->ino > b->ino) return -1;
-	if (a->ino < b->ino) return 1;
-
-	/*
-	 * Synthesized MMAP events have zero ino_generation, avoid comparing
-	 * them with MMAP events with actual ino_generation.
-	 *
-	 * I found it harmful because the mismatch resulted in a new
-	 * dso that did not have a build ID whereas the original dso did have a
-	 * build ID. The build ID was essential because the object was not found
-	 * otherwise. - Adrian
-	 */
-	if (a->ino_generation && b->ino_generation) {
+		if (a->ino > b->ino) return -1;
+		if (a->ino < b->ino) return 1;
+	}
+	if (a->mmap2_ino_generation_valid && b->mmap2_ino_generation_valid) {
 		if (a->ino_generation > b->ino_generation) return -1;
 		if (a->ino_generation < b->ino_generation) return 1;
 	}
-
+	if (build_id__is_defined(&a->build_id) && build_id__is_defined(&b->build_id)) {
+		if (a->build_id.size != b->build_id.size)
+			return a->build_id.size < b->build_id.size ? -1 : 1;
+		return memcmp(a->build_id.data, b->build_id.data, a->build_id.size);
+	}
 	return 0;
 }
 
-bool dso_id__empty(const struct dso_id *id)
-{
-	if (!id)
-		return true;
-
-	return !id->maj && !id->min && !id->ino && !id->ino_generation;
-}
+const struct dso_id dso_id_empty = {
+	{
+		.maj = 0,
+		.min = 0,
+		.ino = 0,
+		.ino_generation = 0,
+	},
+	.mmap2_valid = false,
+	.mmap2_ino_generation_valid = false,
+	{
+		.size = 0,
+	}
+};
 
-void __dso__inject_id(struct dso *dso, const struct dso_id *id)
+void __dso__improve_id(struct dso *dso, const struct dso_id *id)
 {
 	struct dsos *dsos = dso__dsos(dso);
 	struct dso_id *dso_id = dso__id(dso);
+	bool changed = false;
 
 	/* dsos write lock held by caller. */
 
-	dso_id->maj = id->maj;
-	dso_id->min = id->min;
-	dso_id->ino = id->ino;
-	dso_id->ino_generation = id->ino_generation;
-
-	if (dsos)
+	if (id->mmap2_valid && !dso_id->mmap2_valid) {
+		dso_id->maj = id->maj;
+		dso_id->min = id->min;
+		dso_id->ino = id->ino;
+		dso_id->mmap2_valid = true;
+		changed = true;
+	}
+	if (id->mmap2_ino_generation_valid && !dso_id->mmap2_ino_generation_valid) {
+		dso_id->ino_generation = id->ino_generation;
+		dso_id->mmap2_ino_generation_valid = true;
+		changed = true;
+	}
+	if (build_id__is_defined(&id->build_id) && !build_id__is_defined(&dso_id->build_id)) {
+		dso_id->build_id = id->build_id;
+		changed = true;
+	}
+	if (changed && dsos)
 		dsos->sorted = false;
 }
 
 int dso_id__cmp(const struct dso_id *a, const struct dso_id *b)
 {
-	/*
-	 * The second is always dso->id, so zeroes if not set, assume passing
-	 * NULL for a means a zeroed id
-	 */
-	if (dso_id__empty(a) || dso_id__empty(b))
+	if (a == &dso_id_empty || b == &dso_id_empty) {
+		/* There is no valid data to compare so the comparison always returns identical. */
 		return 0;
+	}
 
 	return __dso_id__cmp(a, b);
 }
@@ -1533,7 +1545,6 @@ struct dso *dso__new_id(const char *name, const struct dso_id *id)
 		dso->loaded = 0;
 		dso->rel = 0;
 		dso->sorted_by_name = 0;
-		dso->has_build_id = 0;
 		dso->has_srcline = 1;
 		dso->a2l_fails = 1;
 		dso->kernel = DSO_SPACE__USER;
@@ -1638,15 +1649,14 @@ int dso__swap_init(struct dso *dso, unsigned char eidata)
 	return 0;
 }
 
-void dso__set_build_id(struct dso *dso, struct build_id *bid)
+void dso__set_build_id(struct dso *dso, const struct build_id *bid)
 {
-	RC_CHK_ACCESS(dso)->bid = *bid;
-	RC_CHK_ACCESS(dso)->has_build_id = 1;
+	dso__id(dso)->build_id = *bid;
 }
 
-bool dso__build_id_equal(const struct dso *dso, struct build_id *bid)
+bool dso__build_id_equal(const struct dso *dso, const struct build_id *bid)
 {
-	const struct build_id *dso_bid = dso__bid_const(dso);
+	const struct build_id *dso_bid = dso__bid(dso);
 
 	if (dso_bid->size > bid->size && dso_bid->size == BUILD_ID_SIZE) {
 		/*
@@ -1665,18 +1675,20 @@ bool dso__build_id_equal(const struct dso *dso, struct build_id *bid)
 void dso__read_running_kernel_build_id(struct dso *dso, struct machine *machine)
 {
 	char path[PATH_MAX];
+	struct build_id bid;
 
 	if (machine__is_default_guest(machine))
 		return;
 	sprintf(path, "%s/sys/kernel/notes", machine->root_dir);
-	if (sysfs__read_build_id(path, dso__bid(dso)) == 0)
-		dso__set_has_build_id(dso);
+	sysfs__read_build_id(path, &bid);
+	dso__set_build_id(dso, &bid);
 }
 
 int dso__kernel_module_get_build_id(struct dso *dso,
 				    const char *root_dir)
 {
 	char filename[PATH_MAX];
+	struct build_id bid;
 	/*
 	 * kernel module short names are of the form "[module]" and
 	 * we need just "module" here.
@@ -1687,9 +1699,8 @@ int dso__kernel_module_get_build_id(struct dso *dso,
 		 "%s/sys/module/%.*s/notes/.note.gnu.build-id",
 		 root_dir, (int)strlen(name) - 1, name);
 
-	if (sysfs__read_build_id(filename, dso__bid(dso)) == 0)
-		dso__set_has_build_id(dso);
-
+	sysfs__read_build_id(filename, &bid);
+	dso__set_build_id(dso, &bid);
 	return 0;
 }
 
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index c87564471f9b..3457d713d3c5 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -185,14 +185,33 @@ enum dso_load_errno {
 #define DSO__DATA_CACHE_SIZE 4096
 #define DSO__DATA_CACHE_MASK ~(DSO__DATA_CACHE_SIZE - 1)
 
-/*
- * Data about backing storage DSO, comes from PERF_RECORD_MMAP2 meta events
+/**
+ * struct dso_id
+ *
+ * Data about backing storage DSO, comes from PERF_RECORD_MMAP2 meta events,
+ * reading from /proc/pid/maps or synthesis of build_ids from DSOs. Possibly
+ * incomplete at any particular use.
  */
 struct dso_id {
-	u32	maj;
-	u32	min;
-	u64	ino;
-	u64	ino_generation;
+	/* Data related to the mmap2 event or read from /proc/pid/maps. */
+	struct {
+		u32	maj;
+		u32	min;
+		u64	ino;
+		u64	ino_generation;
+	};
+	/** @mmap2_valid: Are the maj, min and ino fields valid? */
+	bool	mmap2_valid;
+	/**
+	 * @mmap2_ino_generation_valid: Is the ino_generation valid? Generally
+	 * false for /proc/pid/maps mmap event.
+	 */
+	bool	mmap2_ino_generation_valid;
+	/**
+	 * @build_id: A possibly populated build_id. build_id__is_defined checks
+	 * whether it is populated.
+	 */
+	struct build_id build_id;
 };
 
 struct dso_cache {
@@ -243,7 +262,6 @@ DECLARE_RC_STRUCT(dso) {
 		u64		addr;
 		struct symbol	*symbol;
 	} last_find_result;
-	struct build_id	 bid;
 	u64		 text_offset;
 	u64		 text_end;
 	const char	 *short_name;
@@ -276,7 +294,6 @@ DECLARE_RC_STRUCT(dso) {
 	enum dso_swap_type	needs_swap:2;
 	bool			is_kmod:1;
 	u8		 adjust_symbols:1;
-	u8		 has_build_id:1;
 	u8		 header_build_id:1;
 	u8		 has_srcline:1;
 	u8		 hit:1;
@@ -292,6 +309,9 @@ DECLARE_RC_STRUCT(dso) {
 };
 
 extern struct mutex _dso__data_open_lock;
+extern const struct dso_id dso_id_empty;
+
+int dso_id__cmp(const struct dso_id *a, const struct dso_id *b);
 
 /* dso__for_each_symbol - iterate over the symbols of given type
  *
@@ -362,31 +382,11 @@ static inline void dso__set_auxtrace_cache(struct dso *dso, struct auxtrace_cach
 	RC_CHK_ACCESS(dso)->auxtrace_cache = cache;
 }
 
-static inline struct build_id *dso__bid(struct dso *dso)
-{
-	return &RC_CHK_ACCESS(dso)->bid;
-}
-
-static inline const struct build_id *dso__bid_const(const struct dso *dso)
-{
-	return &RC_CHK_ACCESS(dso)->bid;
-}
-
 static inline struct dso_bpf_prog *dso__bpf_prog(struct dso *dso)
 {
 	return &RC_CHK_ACCESS(dso)->bpf_prog;
 }
 
-static inline bool dso__has_build_id(const struct dso *dso)
-{
-	return RC_CHK_ACCESS(dso)->has_build_id;
-}
-
-static inline void dso__set_has_build_id(struct dso *dso)
-{
-	RC_CHK_ACCESS(dso)->has_build_id = true;
-}
-
 static inline bool dso__has_srcline(const struct dso *dso)
 {
 	return RC_CHK_ACCESS(dso)->has_srcline;
@@ -462,6 +462,16 @@ static inline const struct dso_id *dso__id_const(const struct dso *dso)
 	return &RC_CHK_ACCESS(dso)->id;
 }
 
+static inline const struct build_id *dso__bid(const struct dso *dso)
+{
+	return &dso__id_const(dso)->build_id;
+}
+
+static inline bool dso__has_build_id(const struct dso *dso)
+{
+	return build_id__is_defined(dso__bid(dso));
+}
+
 static inline struct rb_root_cached *dso__inlined_nodes(struct dso *dso)
 {
 	return &RC_CHK_ACCESS(dso)->inlined_nodes;
@@ -699,9 +709,6 @@ static inline void dso__set_text_offset(struct dso *dso, u64 val)
 	RC_CHK_ACCESS(dso)->text_offset = val;
 }
 
-int dso_id__cmp(const struct dso_id *a, const struct dso_id *b);
-bool dso_id__empty(const struct dso_id *id);
-
 struct dso *dso__new_id(const char *name, const struct dso_id *id);
 struct dso *dso__new(const char *name);
 void dso__delete(struct dso *dso);
@@ -709,7 +716,7 @@ void dso__delete(struct dso *dso);
 int dso__cmp_id(struct dso *a, struct dso *b);
 void dso__set_short_name(struct dso *dso, const char *name, bool name_allocated);
 void dso__set_long_name(struct dso *dso, const char *name, bool name_allocated);
-void __dso__inject_id(struct dso *dso, const struct dso_id *id);
+void __dso__improve_id(struct dso *dso, const struct dso_id *id);
 
 int dso__name_len(const struct dso *dso);
 
@@ -739,8 +746,8 @@ void dso__sort_by_name(struct dso *dso);
 
 int dso__swap_init(struct dso *dso, unsigned char eidata);
 
-void dso__set_build_id(struct dso *dso, struct build_id *bid);
-bool dso__build_id_equal(const struct dso *dso, struct build_id *bid);
+void dso__set_build_id(struct dso *dso, const struct build_id *bid);
+bool dso__build_id_equal(const struct dso *dso, const struct build_id *bid);
 void dso__read_running_kernel_build_id(struct dso *dso,
 				       struct machine *machine);
 int dso__kernel_module_get_build_id(struct dso *dso, const char *root_dir);
diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index b2172632b3cd..ad919ed28ba4 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -72,6 +72,7 @@ static int dsos__read_build_ids_cb(struct dso *dso, void *data)
 {
 	struct dsos__read_build_ids_cb_args *args = data;
 	struct nscookie nsc;
+	struct build_id bid;
 
 	if (args->with_hits && !dso__hit(dso) && !dso__is_vdso(dso))
 		return 0;
@@ -80,15 +81,15 @@ static int dsos__read_build_ids_cb(struct dso *dso, void *data)
 		return 0;
 	}
 	nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
-	if (filename__read_build_id(dso__long_name(dso), dso__bid(dso)) > 0) {
+	if (filename__read_build_id(dso__long_name(dso), &bid) > 0) {
+		dso__set_build_id(dso, &bid);
 		args->have_build_id = true;
-		dso__set_has_build_id(dso);
 	} else if (errno == ENOENT && dso__nsinfo(dso)) {
 		char *new_name = dso__filename_with_chroot(dso, dso__long_name(dso));
 
-		if (new_name && filename__read_build_id(new_name, dso__bid(dso)) > 0) {
+		if (new_name && filename__read_build_id(new_name, &bid) > 0) {
+			dso__set_build_id(dso, &bid);
 			args->have_build_id = true;
-			dso__set_has_build_id(dso);
 		}
 		free(new_name);
 	}
@@ -284,7 +285,7 @@ struct dso *dsos__find(struct dsos *dsos, const char *name, bool cmp_short)
 	struct dso *res;
 
 	down_read(&dsos->lock);
-	res = __dsos__find_id(dsos, name, NULL, cmp_short, /*write_locked=*/false);
+	res = __dsos__find_id(dsos, name, &dso_id_empty, cmp_short, /*write_locked=*/false);
 	up_read(&dsos->lock);
 	return res;
 }
@@ -341,8 +342,8 @@ static struct dso *__dsos__findnew_id(struct dsos *dsos, const char *name, const
 {
 	struct dso *dso = __dsos__find_id(dsos, name, id, false, /*write_locked=*/true);
 
-	if (dso && dso_id__empty(dso__id(dso)) && !dso_id__empty(id))
-		__dso__inject_id(dso, id);
+	if (dso)
+		__dso__improve_id(dso, id);
 
 	return dso ? dso : __dsos__addnew_id(dsos, name, id);
 }
@@ -433,7 +434,8 @@ struct dso *dsos__findnew_module_dso(struct dsos *dsos,
 
 	down_write(&dsos->lock);
 
-	dso = __dsos__find_id(dsos, m->name, NULL, /*cmp_short=*/true, /*write_locked=*/true);
+	dso = __dsos__find_id(dsos, m->name, &dso_id_empty, /*cmp_short=*/true,
+			      /*write_locked=*/true);
 	if (dso) {
 		up_write(&dsos->lock);
 		return dso;
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index b048165b10c1..04062148a9ec 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1696,21 +1696,21 @@ int machine__process_mmap2_event(struct machine *machine,
 {
 	struct thread *thread;
 	struct map *map;
-	struct dso_id dso_id = {
-		.maj = event->mmap2.maj,
-		.min = event->mmap2.min,
-		.ino = event->mmap2.ino,
-		.ino_generation = event->mmap2.ino_generation,
-	};
-	struct build_id __bid, *bid = NULL;
+	struct dso_id dso_id = dso_id_empty;
 	int ret = 0;
 
 	if (dump_trace)
 		perf_event__fprintf_mmap2(event, stdout);
 
 	if (event->header.misc & PERF_RECORD_MISC_MMAP_BUILD_ID) {
-		bid = &__bid;
-		build_id__init(bid, event->mmap2.build_id, event->mmap2.build_id_size);
+		build_id__init(&dso_id.build_id, event->mmap2.build_id, event->mmap2.build_id_size);
+	} else {
+		dso_id.maj = event->mmap2.maj;
+		dso_id.min = event->mmap2.min;
+		dso_id.ino = event->mmap2.ino;
+		dso_id.ino_generation = event->mmap2.ino_generation;
+		dso_id.mmap2_valid = true;
+		dso_id.mmap2_ino_generation_valid = true;
 	}
 
 	if (sample->cpumode == PERF_RECORD_MISC_GUEST_KERNEL ||
@@ -1722,7 +1722,7 @@ int machine__process_mmap2_event(struct machine *machine,
 		};
 
 		strlcpy(xm.name, event->mmap2.filename, KMAP_NAME_LEN);
-		ret = machine__process_kernel_mmap_event(machine, &xm, bid);
+		ret = machine__process_kernel_mmap_event(machine, &xm, &dso_id.build_id);
 		if (ret < 0)
 			goto out_problem;
 		return 0;
@@ -1736,7 +1736,7 @@ int machine__process_mmap2_event(struct machine *machine,
 	map = map__new(machine, event->mmap2.start,
 			event->mmap2.len, event->mmap2.pgoff,
 			&dso_id, event->mmap2.prot,
-			event->mmap2.flags, bid,
+			event->mmap2.flags,
 			event->mmap2.filename, thread);
 
 	if (map == NULL)
@@ -1794,8 +1794,8 @@ int machine__process_mmap_event(struct machine *machine, union perf_event *event
 		prot = PROT_EXEC;
 
 	map = map__new(machine, event->mmap.start,
-			event->mmap.len, event->mmap.pgoff,
-			NULL, prot, 0, NULL, event->mmap.filename, thread);
+		       event->mmap.len, event->mmap.pgoff,
+		       &dso_id_empty, prot, /*flags=*/0, event->mmap.filename, thread);
 
 	if (map == NULL)
 		goto out_problem_map;
@@ -3157,7 +3157,7 @@ struct dso *machine__findnew_dso_id(struct machine *machine, const char *filenam
 
 struct dso *machine__findnew_dso(struct machine *machine, const char *filename)
 {
-	return machine__findnew_dso_id(machine, filename, NULL);
+	return machine__findnew_dso_id(machine, filename, &dso_id_empty);
 }
 
 char *machine__resolve_kernel_addr(void *vmachine, unsigned long long *addrp, char **modp)
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 8858520c16f4..41cdddc987ee 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -120,8 +120,8 @@ static void map__init(struct map *map, u64 start, u64 end, u64 pgoff,
 }
 
 struct map *map__new(struct machine *machine, u64 start, u64 len,
-		     u64 pgoff, struct dso_id *id,
-		     u32 prot, u32 flags, struct build_id *bid,
+		     u64 pgoff, const struct dso_id *id,
+		     u32 prot, u32 flags,
 		     char *filename, struct thread *thread)
 {
 	struct map *result;
@@ -132,7 +132,7 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
 	map = zalloc(sizeof(*map));
 	if (ADD_RC_CHK(result, map)) {
 		char newfilename[PATH_MAX];
-		struct dso *dso, *header_bid_dso;
+		struct dso *dso;
 		int anon, no_dso, vdso, android;
 
 		android = is_android_lib(filename);
@@ -189,16 +189,15 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
 		dso__set_nsinfo(dso, nsi);
 		mutex_unlock(dso__lock(dso));
 
-		if (build_id__is_defined(bid)) {
-			dso__set_build_id(dso, bid);
-		} else {
+		if (!build_id__is_defined(&id->build_id)) {
 			/*
 			 * If the mmap event had no build ID, search for an existing dso from the
 			 * build ID header by name. Otherwise only the dso loaded at the time of
 			 * reading the header will have the build ID set and all future mmaps will
 			 * have it missing.
 			 */
-			header_bid_dso = dsos__find(&machine->dsos, filename, false);
+			struct dso *header_bid_dso = dsos__find(&machine->dsos, filename, false);
+
 			if (header_bid_dso && dso__header_build_id(header_bid_dso)) {
 				dso__set_build_id(dso, dso__bid(header_bid_dso));
 				dso__set_header_build_id(dso, 1);
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index 768501eec70e..979b3e11b9bc 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -173,11 +173,10 @@ struct thread;
 	__map__for_each_symbol_by_name(map, sym_name, (pos), idx)
 
 struct dso_id;
-struct build_id;
 
 struct map *map__new(struct machine *machine, u64 start, u64 len,
-		     u64 pgoff, struct dso_id *id, u32 prot, u32 flags,
-		     struct build_id *bid, char *filename, struct thread *thread);
+		     u64 pgoff, const struct dso_id *id, u32 prot, u32 flags,
+		     char *filename, struct thread *thread);
 struct map *map__new2(u64 start, struct dso *dso);
 void map__delete(struct map *map);
 struct map *map__clone(struct map *map);
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 594b75ca95bf..d20b980d5052 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -1709,22 +1709,27 @@ sort__dcacheline_cmp(struct hist_entry *left, struct hist_entry *right)
 	if (rc)
 		return rc;
 	/*
-	 * Addresses with no major/minor numbers are assumed to be
+	 * Addresses with no major/minor numbers or build ID are assumed to be
 	 * anonymous in userspace.  Sort those on pid then address.
 	 *
 	 * The kernel and non-zero major/minor mapped areas are
 	 * assumed to be unity mapped.  Sort those on address.
 	 */
+	if (left->cpumode != PERF_RECORD_MISC_KERNEL && (map__flags(l_map) & MAP_SHARED) == 0) {
+		const struct dso_id *dso_id = dso__id_const(l_dso);
 
-	if ((left->cpumode != PERF_RECORD_MISC_KERNEL) &&
-	    (!(map__flags(l_map) & MAP_SHARED)) && !dso__id(l_dso)->maj && !dso__id(l_dso)->min &&
-	     !dso__id(l_dso)->ino && !dso__id(l_dso)->ino_generation) {
-		/* userspace anonymous */
+		if (!dso_id->mmap2_valid)
+			dso_id = dso__id_const(r_dso);
 
-		if (thread__pid(left->thread) > thread__pid(right->thread))
-			return -1;
-		if (thread__pid(left->thread) < thread__pid(right->thread))
-			return 1;
+		if (!build_id__is_defined(&dso_id->build_id) &&
+		    (!dso_id->mmap2_valid || (dso_id->maj == 0 && dso_id->min == 0))) {
+			/* userspace anonymous */
+
+			if (thread__pid(left->thread) > thread__pid(right->thread))
+				return -1;
+			if (thread__pid(left->thread) < thread__pid(right->thread))
+				return 1;
+		}
 	}
 
 addr:
@@ -1749,6 +1754,7 @@ static int hist_entry__dcacheline_snprintf(struct hist_entry *he, char *bf,
 	if (he->mem_info) {
 		struct map *map = mem_info__daddr(he->mem_info)->ms.map;
 		struct dso *dso = map ? map__dso(map) : NULL;
+		const struct dso_id *dso_id = dso ? dso__id_const(dso) : &dso_id_empty;
 
 		addr = cl_address(mem_info__daddr(he->mem_info)->al_addr, chk_double_cl);
 		ms = &mem_info__daddr(he->mem_info)->ms;
@@ -1757,8 +1763,7 @@ static int hist_entry__dcacheline_snprintf(struct hist_entry *he, char *bf,
 		if ((he->cpumode != PERF_RECORD_MISC_KERNEL) &&
 		     map && !(map__prot(map) & PROT_EXEC) &&
 		     (map__flags(map) & MAP_SHARED) &&
-		     (dso__id(dso)->maj || dso__id(dso)->min || dso__id(dso)->ino ||
-		      dso__id(dso)->ino_generation))
+		     (!dso_id->mmap2_valid || (dso_id->maj == 0 && dso_id->min == 0)))
 			level = 's';
 		else if (!map)
 			level = 'X';
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 68bb7c5fe1b1..8fb2ea544d3a 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -372,7 +372,7 @@ static void perf_record_mmap2__read_build_id(struct perf_record_mmap2 *event,
 	struct nsinfo *nsi;
 	struct nscookie nc;
 	struct dso *dso = NULL;
-	struct dso_id id;
+	struct dso_id dso_id = dso_id_empty;
 	int rc;
 
 	if (is_kernel) {
@@ -380,12 +380,18 @@ static void perf_record_mmap2__read_build_id(struct perf_record_mmap2 *event,
 		goto out;
 	}
 
-	id.maj = event->maj;
-	id.min = event->min;
-	id.ino = event->ino;
-	id.ino_generation = event->ino_generation;
+	if (event->header.misc & PERF_RECORD_MISC_MMAP_BUILD_ID) {
+		build_id__init(&dso_id.build_id, event->build_id, event->build_id_size);
+	} else {
+		dso_id.maj = event->maj;
+		dso_id.min = event->min;
+		dso_id.ino = event->ino;
+		dso_id.ino_generation = event->ino_generation;
+		dso_id.mmap2_valid = true;
+		dso_id.mmap2_ino_generation_valid = true;
+	};
 
-	dso = dsos__findnew_id(&machine->dsos, event->filename, &id);
+	dso = dsos__findnew_id(&machine->dsos, event->filename, &dso_id);
 	if (dso && dso__has_build_id(dso)) {
 		bid = *dso__bid(dso);
 		rc = 0;
-- 
2.49.0.850.g28803427d3-goog


