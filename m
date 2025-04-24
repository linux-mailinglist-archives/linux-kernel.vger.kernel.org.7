Return-Path: <linux-kernel+bounces-617513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12608A9A181
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 08:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E035460304
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 06:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307961EA7E1;
	Thu, 24 Apr 2025 06:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iHGhxVGe"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF6C1E5219
	for <linux-kernel@vger.kernel.org>; Thu, 24 Apr 2025 06:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745475601; cv=none; b=HJwPX/Tdzog7va/7Swh0dRrchaXVA+/pWfmOp2sgFqNEAWt+mRNILDVa3e28qIwhpHbx2yW4zm6dS5ThDJc/zHXLy9P4F/5e6bueXINWdW0bAqmn7BrkVrDyC6SFZehLSlELTaQyrT5MAtjvOPnaOP6pCD1Aw2iJDi7DV0Zc0PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745475601; c=relaxed/simple;
	bh=VjhS7VCFOqWVfgeLMqRg0ytlAgh+s1lFKazBgPQnvOU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=AU+PJX0VlWpAP8CMuW/ePGhT9SaqIlSpIGFv8f1YePPJm1BO9D6bZKhB8QV+off10mye9yhsZOrXyGmYFToWiZGx2obxRr4sF7305sqNlESRRJ+Ouur/VxH+G94v/fmRGIuAMYbf6TRe8NUXpauk8E6U5WXNo9B5InV5nJTpyRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iHGhxVGe; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-73c09e99069so667164b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Apr 2025 23:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745475599; x=1746080399; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pAjOHRlu1QEgEyf5N8TQGn8FUb6v2BnRRVjyLaPWAHg=;
        b=iHGhxVGeLeoYupMpmk7T5uxZiKdTWE7MAZfN/a6txcM7Mj36fDiGo9EE4zMHCNvUb2
         2H4EPs4NtwMjR/gjgdTY1hp0HWdj0BhrA5mkPMQ6f72E1c/WGBg890Ywo9aUw1tIRl+S
         zkv0rS9wkEEGWayiNH7miOqOzXDn1M9oKUNjk70N+/f9mE2dkaok2H66wId5XKtkrS06
         55cLiqeHtasFuEjUFFkiREEh0cD231wL6+n6WGYzmdr7/Rqjc7hmkXc4qMd+d+9FkzRG
         gxzVNCEwCxffbgXt1k1x3kgp2PsmddmLf4BWRwq+U4/2cofk4vnpNgR/g6LYN8rVNAQz
         pEFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745475599; x=1746080399;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pAjOHRlu1QEgEyf5N8TQGn8FUb6v2BnRRVjyLaPWAHg=;
        b=bqDractmQHqK8jzpRJTvX5Ndoyqn1QRB1Nlpy23qqZnie2Xf+DIGZbUt2TetHO7Imu
         941p2IjCGRST5Y/gFSrv51ZCsF9J6mk7ZyO1uqxMrkQdDPyCcmdC5/qrQ0JRUUEPvinz
         JZFyt/1j6JlyA40Ij/zVoQOv4TP/zHzCUmOW24VG1/SBPXDLCAwgm7E2ZVInGf4kTYr7
         B7g/zogpG2Hxnhc4L4MJ+neHGKM7fF1InY/IGZBriYSwWBNZE522w8ABBdqWdFMrNQ/s
         V3NyQidbaC28/7mj1OQdCfWJnlDaYdg4/b/FptAnquKKrdby82Ab2MU6v4Dh4wnb8yA4
         ykYw==
X-Forwarded-Encrypted: i=1; AJvYcCUM5YWILxJL/QtMUiSsLVbYagq64ZpPoXoodNf6wWku1SuEMmGxk1LnwWPABJCxeNF8AkPJ4R3u6jII83w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo5Cuu6eC6PD1m1AW+6xG+PhoO+s5vSUaWGx3ZACv+cdKqJkyv
	jJuyq3KUdYTF/ej/L5SkEGTZlh5ohWhMdRCgWz+KbPHvks/rLHDeGeLE+ULSLRTyyxzXqS+LUj9
	Pt+IjAg==
X-Google-Smtp-Source: AGHT+IErjzeMZ0CpLQrtjbB12N0a2utLSGH68cn6axS8x1nyJuTDRPAMrl301bsXHutEZMIVu/qLjuuB+8Bz
X-Received: from pfhm6.prod.google.com ([2002:a62:f206:0:b0:736:b315:f15e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1947:b0:736:5b85:a911
 with SMTP id d2e1a72fcca58-73e2462bc85mr2418195b3a.8.1745475598724; Wed, 23
 Apr 2025 23:19:58 -0700 (PDT)
Date: Wed, 23 Apr 2025 23:19:43 -0700
In-Reply-To: <20250424061943.1321025-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250424061943.1321025-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250424061943.1321025-6-irogers@google.com>
Subject: [PATCH v1 5/5] perf record: Make --buildid-mmap the default
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Li Huafei <lihuafei1@huawei.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	James Clark <james.clark@linaro.org>, Andi Kleen <ak@linux.intel.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Michael Petlan <mpetlan@redhat.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Leo Yan <leo.yan@arm.com>, 
	Steve Clevenger <scclevenger@os.amperecomputing.com>, Zixian Cai <fzczx123@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Martin Liska <martin.liska@hey.com>, 
	"=?UTF-8?q?Martin=20Li=C5=A1ka?=" <m.liska@foxlink.cz>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Support for build IDs in mmap2 perf events has been present since
Linux v5.12:
https://lore.kernel.org/lkml/20210219194619.1780437-1-acme@kernel.org/
Build ID mmap events avoid the need to inject build IDs for DSO
touched by samples when perf record completes and can avoid some cases
of symbol mis-resolution.

Unlike the --buildid-mmap option, this doesn't disable the build ID
cache but it does disable the processing of samples looking for DSOs
to inject build IDs for. To disable the build ID cache the -N
(--no-buildid-cache) option is necessary.

Making this option the default was raised on the list in:
https://lore.kernel.org/linux-perf-users/CAP-5=fXP7jN_QrGUcd55_QH5J-Y-FCaJ6=NaHVtyx0oyNh8_-Q@mail.gmail.com/

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-record.c        | 35 +++++++++++++++++++-----------
 tools/perf/util/symbol_conf.h      |  2 +-
 tools/perf/util/synthetic-events.c | 16 +++++++-------
 3 files changed, 31 insertions(+), 22 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index ba20bf7c011d..0fcb0f469488 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -169,6 +169,7 @@ struct record {
 	bool			no_buildid_cache_set;
 	bool			buildid_all;
 	bool			buildid_mmap;
+	bool			buildid_mmap_set;
 	bool			timestamp_filename;
 	bool			timestamp_boundary;
 	bool			off_cpu;
@@ -1795,7 +1796,8 @@ record__finish_output(struct record *rec)
 			data->dir.files[i].size = lseek(data->dir.files[i].fd, 0, SEEK_CUR);
 	}
 
-	if (!rec->no_buildid) {
+	/* Buildid scanning disabled or build ID in kernel and synthesized map events. */
+	if (!rec->no_buildid && !rec->buildid_mmap) {
 		process_buildids(rec);
 
 		if (rec->buildid_all)
@@ -2966,6 +2968,8 @@ static int perf_record_config(const char *var, const char *value, void *cb)
 			rec->no_buildid = true;
 		else if (!strcmp(value, "mmap"))
 			rec->buildid_mmap = true;
+		else if (!strcmp(value, "no-mmap"))
+			rec->buildid_mmap = false;
 		else
 			return -1;
 		return 0;
@@ -3349,6 +3353,7 @@ static struct record record = {
 		.ctl_fd_ack          = -1,
 		.synth               = PERF_SYNTH_ALL,
 	},
+	.buildid_mmap = true,
 };
 
 const char record_callchain_help[] = CALLCHAIN_RECORD_HELP
@@ -3514,8 +3519,8 @@ static struct option __record_options[] = {
 		   "file", "vmlinux pathname"),
 	OPT_BOOLEAN(0, "buildid-all", &record.buildid_all,
 		    "Record build-id of all DSOs regardless of hits"),
-	OPT_BOOLEAN(0, "buildid-mmap", &record.buildid_mmap,
-		    "Record build-id in map events"),
+	OPT_BOOLEAN_SET(0, "buildid-mmap", &record.buildid_mmap, &record.buildid_mmap_set,
+			"Legacy record build-id in map events option which is now the default. Behaves indentically to --no-buildid. Disable with --no-buildid-mmap"),
 	OPT_BOOLEAN(0, "timestamp-filename", &record.timestamp_filename,
 		    "append timestamp to output filename"),
 	OPT_BOOLEAN(0, "timestamp-boundary", &record.timestamp_boundary,
@@ -4042,19 +4047,23 @@ int cmd_record(int argc, const char **argv)
 		record.opts.record_switch_events = true;
 	}
 
+	if (!rec->buildid_mmap) {
+		pr_debug("Disabling build id in synthesized mmap2 events.\n");
+		symbol_conf.no_buildid_mmap2 = true;
+	} else if (rec->buildid_mmap_set) {
+		/*
+		 * Explicitly passing --buildid-mmap disables buildid processing
+		 * and cache generation.
+		 */
+		rec->no_buildid = true;
+	}
+	if (rec->buildid_mmap && !perf_can_record_build_id()) {
+		pr_warning("Missing support for build id in kernel mmap events. Disable this warning with --no-buildid-mmap\n");
+		rec->buildid_mmap = false;
+	}
 	if (rec->buildid_mmap) {
-		if (!perf_can_record_build_id()) {
-			pr_err("Failed: no support to record build id in mmap events, update your kernel.\n");
-			err = -EINVAL;
-			goto out_opts;
-		}
-		pr_debug("Enabling build id in mmap2 events.\n");
-		/* Enable mmap build id synthesizing. */
-		symbol_conf.buildid_mmap2 = true;
 		/* Enable perf_event_attr::build_id bit. */
 		rec->opts.build_id = true;
-		/* Disable build id cache. */
-		rec->no_buildid = true;
 	}
 
 	if (rec->opts.record_cgroup && !perf_can_record_cgroup()) {
diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
index cd9aa82c7d5a..7a80d2c14d9b 100644
--- a/tools/perf/util/symbol_conf.h
+++ b/tools/perf/util/symbol_conf.h
@@ -43,7 +43,7 @@ struct symbol_conf {
 			report_individual_block,
 			inline_name,
 			disable_add2line_warn,
-			buildid_mmap2,
+			no_buildid_mmap2,
 			guest_code,
 			lazy_load_kernel_maps,
 			keep_exited_threads,
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 8fb2ea544d3a..f48109c14235 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -532,7 +532,7 @@ int perf_event__synthesize_mmap_events(const struct perf_tool *tool,
 		event->mmap2.pid = tgid;
 		event->mmap2.tid = pid;
 
-		if (symbol_conf.buildid_mmap2)
+		if (!symbol_conf.no_buildid_mmap2)
 			perf_record_mmap2__read_build_id(&event->mmap2, machine, false);
 
 		if (perf_tool__process_synth_event(tool, event, machine, process) != 0) {
@@ -690,7 +690,7 @@ static int perf_event__synthesize_modules_maps_cb(struct map *map, void *data)
 		return 0;
 
 	dso = map__dso(map);
-	if (symbol_conf.buildid_mmap2) {
+	if (!symbol_conf.no_buildid_mmap2) {
 		size = PERF_ALIGN(dso__long_name_len(dso) + 1, sizeof(u64));
 		event->mmap2.header.type = PERF_RECORD_MMAP2;
 		event->mmap2.header.size = (sizeof(event->mmap2) -
@@ -734,9 +734,9 @@ int perf_event__synthesize_modules(const struct perf_tool *tool, perf_event__han
 		.process = process,
 		.machine = machine,
 	};
-	size_t size = symbol_conf.buildid_mmap2
-		? sizeof(args.event->mmap2)
-		: sizeof(args.event->mmap);
+	size_t size = symbol_conf.no_buildid_mmap2
+		? sizeof(args.event->mmap)
+		: sizeof(args.event->mmap2);
 
 	args.event = zalloc(size + machine->id_hdr_size);
 	if (args.event == NULL) {
@@ -1124,8 +1124,8 @@ static int __perf_event__synthesize_kernel_mmap(const struct perf_tool *tool,
 						struct machine *machine)
 {
 	union perf_event *event;
-	size_t size = symbol_conf.buildid_mmap2 ?
-			sizeof(event->mmap2) : sizeof(event->mmap);
+	size_t size = symbol_conf.no_buildid_mmap2 ?
+			sizeof(event->mmap) : sizeof(event->mmap2);
 	struct map *map = machine__kernel_map(machine);
 	struct kmap *kmap;
 	int err;
@@ -1159,7 +1159,7 @@ static int __perf_event__synthesize_kernel_mmap(const struct perf_tool *tool,
 		event->header.misc = PERF_RECORD_MISC_GUEST_KERNEL;
 	}
 
-	if (symbol_conf.buildid_mmap2) {
+	if (!symbol_conf.no_buildid_mmap2) {
 		size = snprintf(event->mmap2.filename, sizeof(event->mmap2.filename),
 				"%s%s", machine->mmap_name, kmap->ref_reloc_sym->name) + 1;
 		size = PERF_ALIGN(size, sizeof(u64));
-- 
2.49.0.805.g082f7c87e0-goog


