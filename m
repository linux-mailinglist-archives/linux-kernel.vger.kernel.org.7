Return-Path: <linux-kernel+bounces-842402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AD022BB9AE4
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 20:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ED80C346FD2
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 18:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D809D28CF77;
	Sun,  5 Oct 2025 18:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HqN8sLLn"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B4828AAE0
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 18:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759688695; cv=none; b=mLUgVWod9IrrUmmzneJApAaUDkYGJ2n/+vVJJFtT7KYvftZa+TyY/RJEhXxNpdV4Zwy4lNVsCYc0fYAipPajucC6RN7hxs8I5bht4n09vDKAzQAorKbu6jj/rs/aUW7l35jNgrPyTAO5fhuurR78zMA+JRtVUJ6obR1vyF8QzW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759688695; c=relaxed/simple;
	bh=oZnPNPyMW5ix5+T/Kd4AGKTs8ir+V+xUhPwOTmL9jbs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d3m0rgJdNE47cnfssGJVvNCqJgWz/nKvkWD1pfkN51a1xIPh6k9183phqH5owgys9X3HzGerkmuXA0frCZxg510CcyNTRD1f4UKy1tGZkB9JcZNlVMUQnHgB/YfJEvHGLWtWx99bhbQffvl69QSwIsMySxXkTDiMlkIDKiwZvV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HqN8sLLn; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-746b28ff4c5so43440677b3.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 11:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759688692; x=1760293492; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=D4arvNqKzsedVSCdkfpQZv0S1WpR+wuKFKQuvrv0EL4=;
        b=HqN8sLLnDjEymguEwvIeLLasbmcEJJnoxTUnuJxNyyVJuCXPN2Qeud+zkiPogFymn3
         8OuPVNJOWhAjaxylDJs95fv/b0mKatE4IBqhy78EJPeEQIeUl+zKM89PFOyVjJrK294N
         +wH0L5Dq0D1q3LwlwxBY+cokO7vN7poJ9ZHlyg/ur5cdflSM/8od1WEO1lPBm72FqZRf
         NhhSWMipjJMcgiEAew9RQcEyDPvPIF9LHG9WP85VZOxzpp/ORgm0zBKROSqVNHYc4fUi
         coXDCr61eF/TeU+RqtRvhgth0Wo/P5PSmzKvaUJ3kYYx/rF6sl++5+IS7FvKQ0vsGRsI
         Sw3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759688692; x=1760293492;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D4arvNqKzsedVSCdkfpQZv0S1WpR+wuKFKQuvrv0EL4=;
        b=KsgXgc9t7w7PRDUUTPpAjPiSHIvUhNXai2d+YQe6MKv3si3hNIETQOsUEjTRMKCLEn
         QF7b871ADxJEGSR5mEhK9Y2itk42xTGqoaKsz4C4Co8aXmSiRGPWst5TiSKdQ7YfJzIa
         4amLBZH/xBsAJHjcSO1JGL9lWY7RCKxOdtADehU+F/WqIZfl06jOCzGnu6f9t9ysMbP+
         pKclDpMcYZjQS59rKzIgUt1bC6dqP8j9w+Y9fu4OQl1wpEXGqO2zDzeVDH86KnlhrQU5
         lWf4JdcVicBxT+z10ciinNF1ZjT4Hxyt3XaaNwfadDxbj93unL4Obg0CHi10tjnNaP69
         oVOw==
X-Forwarded-Encrypted: i=1; AJvYcCXJBBXxjTz+GJUF+KaD39TE4Q+1X83OBNJEZHs+txylGoX0UjgQ7NnB3KfHaAQMusnBMonSpbHu2ORJ8vg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv7s9KMa7nEFUYYtqeIdYgfuWiPu4J8p278uSqdawcYHkMNMdh
	eqJiEl2y6OFitROO7q3ePJ02iZZPU1I/6dwa2iikzqG3m9Tw3nqcjNqE0v/MSz0iQIVkvTh/3ZC
	0rEPwN4CJPg==
X-Google-Smtp-Source: AGHT+IEw2/JXqLShPZMslUk0GjRr0iuxlNgoFPDvapIN0gqC4oxja82ZpFUlCEDu9ZwJOU2j/xwpivCNzl1z
X-Received: from ywbhv8.prod.google.com ([2002:a05:690c:4988:b0:729:15e7:9e4f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:690c:7341:b0:74d:4623:46d6
 with SMTP id 00721157ae682-77f9470ac39mr109550347b3.50.1759688692320; Sun, 05
 Oct 2025 11:24:52 -0700 (PDT)
Date: Sun,  5 Oct 2025 11:24:11 -0700
In-Reply-To: <20251005182430.2791371-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251005182430.2791371-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251005182430.2791371-9-irogers@google.com>
Subject: [PATCH v7 08/27] perf pmu: Use fd rather than FILE from new_alias
From: Ian Rogers <irogers@google.com>
To: James Clark <james.clark@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Cc: Ian Rogers <irogers@google.com>, Thomas Richter <tmricht@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

The FILE argument was necessary for the scanner but now that
functionality is not being used we can switch to just using
io__getline which should cut down on stdio buffer usage.

Tested-by: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 876e87708b03..7992bd923515 100644
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
2.51.0.618.g983fd99d29-goog


