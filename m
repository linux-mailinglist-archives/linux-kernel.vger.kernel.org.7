Return-Path: <linux-kernel+bounces-815778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 128FEB56B0A
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 20:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56EE77A951D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 18:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688732E11BC;
	Sun, 14 Sep 2025 18:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XqyYrMxy"
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093E62E092A
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 18:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757873502; cv=none; b=Ok9vOtJKbeD5XFDjsthC38psZqwP2hVqGoxozWXLEKh31piiiBVCdwB8LgX7ZEOAyKv5ILKTah1qAAD/O62Zy733s4uoNkG/1DSJwO1cxi03hByVR6XhmQ3kW2AuPVDsgvDhgzyyI3YKtKokU7k3o2MU15rSO++uSc0EEEWAUwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757873502; c=relaxed/simple;
	bh=0M7aW9rM47C2xbliRkt1WBQcuZbGSqN6pmVDVEqndoU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t0QHMFKS8xMitdNIYnNqHj7FuDkTatWmnTzO4Mymnxh0k/VgD7bwmLhfYXq2GXfm915aFuTV1yqFzMhGDMuyYcEpalz7yW9/9f/70TIrs3i6JclC+WFv2QW0FTqlfBwoaVP3dq3pcuQFfaavz921M97HwnTB8CAfVgcJlXWrOZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XqyYrMxy; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-81312a26ea3so945656985a.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 11:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757873500; x=1758478300; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ThdZBfrv8r4vr3+Q/T08HR89wWumtwD0SICjKhnd2P4=;
        b=XqyYrMxyhuK9yBUO/mNfHNF/TIta3GGbCil3QmAR6Ceb6PqbXT86PAOUvLww6KGKso
         Bp5iGeT2t/FEzZlvmM8ijGg0VDhj2olB2QAsogrVb02g4XnzKT5UiFoiTpAq+qtijWMd
         bnb4yBoBXqQ+cPzUhwmlF1OjExbF8SzDTF/QpdpZ4H+vVuOK4GfX8PinC4076kqgM+if
         ePr+oeHXOIUeaKwBLMVIG+gHb9JP3Sf7X795S6zffEyNl+UuECRz6QqTFPNBXwWTeVfy
         78a5e6VG2meKRDymJmVg48qOM29BR1Sp+LE5mjusWeDZoIJmbIfqveTQYlkdglwf6dKB
         /EjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757873500; x=1758478300;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ThdZBfrv8r4vr3+Q/T08HR89wWumtwD0SICjKhnd2P4=;
        b=L9ksGuBOTqHXfi+tsOTnKF/eTRh5LRC1/VKqByPDWU/p49QLK/vHOMfCq5aE0nq3w7
         yRqiGDlulRTbW6TSpDszdYeo4LS6aB/Aeal1JX1rUJ/onYU6EMr9Zy6NnFJHTGK3wc7Q
         mpYhHtMwINuNEXr0Ox1zRnKT8eMKwtYf30CkXB6wAfv5bcJqnLH2NkF3WJ74aYC/aRL9
         roKqJ66pu4vwlv3bN8l0hNZ8I7FwxKL5S8qwXQMklb8Afnk7zdDe0489t5aTOA0jFiUq
         jGVvG8EbKUGkLpzVwAcVTCjKoToHaQZQaCm6Km59JB5jXVo3mQk5E8YQuyKfNOJis0eA
         g42Q==
X-Forwarded-Encrypted: i=1; AJvYcCUEhtt19mPPBvCJK9JwmFCrQ4VGQIRzFMRRpBYMjLmqkHctcMHa8HTQOjEDS2dlKQlY8Q9BYWP/wPxlCcU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymh+Jxi108uaKNrPNdshM5AcrxI/fJq+TOHMqbLcmYSIjNTWa4
	icNlL4EI6PnQnilRYVSQXyZI9CxTAAXBLqpTXZKu5TDM3NauikVGGCZkRvNO4pxRhA+NWSuZLye
	GxEVyYCRQMw==
X-Google-Smtp-Source: AGHT+IFDwkqSbiN7IYvNr7SaniQ+/COuM/pa6CJNpLEEeITYyqBhgRXpoDtvg1D5B8WAecnwYYWjAOAkjWtQ
X-Received: from qkbdx11.prod.google.com ([2002:a05:620a:608b:b0:80b:4507:33])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:620a:7087:b0:800:c495:48ad
 with SMTP id af79cd13be357-824013d62aemr1229951685a.59.1757873499799; Sun, 14
 Sep 2025 11:11:39 -0700 (PDT)
Date: Sun, 14 Sep 2025 11:11:07 -0700
In-Reply-To: <20250914181121.1952748-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250914181121.1952748-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250914181121.1952748-8-irogers@google.com>
Subject: [PATCH v4 07/21] perf pmu: Use fd rather than FILE from new_alias
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

The FILE argument was necessary for the scanner but now that
functionality is not being used we can switch to just using
io__getline which should cut down on stdio buffer usage.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/util/pmu.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index b44dfe4c73fc..818be59db2c6 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -563,7 +563,7 @@ static int update_alias(const struct pmu_event *pe,
 }
 
 static int perf_pmu__new_alias(struct perf_pmu *pmu, const char *name,
-				const char *desc, const char *val, FILE *val_fd,
+				const char *desc, const char *val, int val_fd,
 			        const struct pmu_event *pe, enum event_source src)
 {
 	struct perf_pmu_alias *alias, *old_alias;
@@ -614,12 +614,15 @@ static int perf_pmu__new_alias(struct perf_pmu *pmu, const char *name,
 	if (ret)
 		return ret;
 
-	if (!val_fd) {
+	if (val_fd < 0) {
 		alias->terms = strdup(val);
 	} else {
+		char buf[256];
+		struct io io;
 		size_t line_len;
 
-		ret = getline(&alias->terms, &line_len, val_fd) < 0 ? -errno : 0;
+		io__init(&io, val_fd, buf, sizeof(buf));
+		ret = io__getline(&io, &alias->terms, &line_len) < 0 ? -errno : 0;
 		if (ret) {
 			pr_err("Failed to read alias %s\n", name);
 			return ret;
@@ -698,7 +701,6 @@ static int __pmu_aliases_parse(struct perf_pmu *pmu, int events_dir_fd)
 	while ((evt_ent = io_dir__readdir(&event_dir))) {
 		char *name = evt_ent->d_name;
 		int fd;
-		FILE *file;
 
 		if (!strcmp(name, ".") || !strcmp(name, ".."))
 			continue;
@@ -714,17 +716,12 @@ static int __pmu_aliases_parse(struct perf_pmu *pmu, int events_dir_fd)
 			pr_debug("Cannot open %s\n", name);
 			continue;
 		}
-		file = fdopen(fd, "r");
-		if (!file) {
-			close(fd);
-			continue;
-		}
 
 		if (perf_pmu__new_alias(pmu, name, /*desc=*/ NULL,
-					/*val=*/ NULL, file, /*pe=*/ NULL,
+					/*val=*/ NULL, fd, /*pe=*/ NULL,
 					EVENT_SRC_SYSFS) < 0)
 			pr_debug("Cannot set up %s\n", name);
-		fclose(file);
+		close(fd);
 	}
 
 	pmu->sysfs_aliases_loaded = true;
@@ -1041,7 +1038,7 @@ static int pmu_add_cpu_aliases_map_callback(const struct pmu_event *pe,
 {
 	struct perf_pmu *pmu = vdata;
 
-	perf_pmu__new_alias(pmu, pe->name, pe->desc, pe->event, /*val_fd=*/ NULL,
+	perf_pmu__new_alias(pmu, pe->name, pe->desc, pe->event, /*val_fd=*/ -1,
 			    pe, EVENT_SRC_CPU_JSON);
 	return 0;
 }
@@ -1090,7 +1087,7 @@ static int pmu_add_sys_aliases_iter_fn(const struct pmu_event *pe,
 				pe->name,
 				pe->desc,
 				pe->event,
-				/*val_fd=*/ NULL,
+				/*val_fd=*/ -1,
 				pe,
 				EVENT_SRC_SYS_JSON);
 	}
-- 
2.51.0.384.g4c02a37b29-goog


