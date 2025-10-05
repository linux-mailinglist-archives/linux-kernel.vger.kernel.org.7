Return-Path: <linux-kernel+bounces-842406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77957BB9AF0
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 20:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CBA23A8BF6
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 18:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705931DE2D7;
	Sun,  5 Oct 2025 18:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mwkqoLju"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605D61DE2DC
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 18:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759688703; cv=none; b=fxCQ1cFgQQqYR5mBomXqYUg5OCL04ahjEb7+NKTrTgHmKUzeGxGARduaGfzGwG+leQwXKndSEhXMnrmRe4lEzxdUH/XqSo6NfzwZc9U0HGOHOE5iRw6wSH84wlnStNxz2DggdvccEeWmwt+8KLOVn5EdUf7ASLu6t2b0dvglGZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759688703; c=relaxed/simple;
	bh=HdVGMdUZJ7sQw0wCpKNfX0a9lPS97C04R9RXylKiaXA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FJII5X4Be/YpRLk2nKf5WN3gO8XlPobcfqoIr66KeOiCG2YmUOHtisYVROfuxpke9W1+mq5iMijfwYGYPiKlsqdqHbX/U9G2FGrP+ZiyaiKYv2Npvfy6i+v4hC6y+TiDwlHkwejsdi1J0QhQsrDDDURNH468REWaSRYVgUa2Ge8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mwkqoLju; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2711a55da20so24422365ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 11:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759688701; x=1760293501; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0o00XL7qipP4mPs0tHYqXDOdnOe1rP6Nx9a3z+JzO6E=;
        b=mwkqoLjuz9qCmxpJdiBE3yOYG989r0cRELzbSb5PCApVMnZ35SrF3ybTcYKNMw2QY7
         LzLUecT0s5pQZ/axO8LRTSfuGByUvOZzWJBjLKAjZHVeu/DTuJYcIodmfooZjdMX0Mef
         UquoLxwd8lrsgrKuTFVC2z56zS9hljVf88+L95XG8sM4E875SEI2prSyxsZs3WqFCX1G
         b2fCRxGWOBF454AvIIqHplb881VugTqGh24Y72GLlOMPzD8CpoH6rB5asPNkKl+s6QSR
         7xe7YKOcXEC0/iZysCoFTbsD++GgsvTCBb/1tS9Zp3BXhI/op4HHAkRCQc0sth42IgIN
         9f/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759688701; x=1760293501;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0o00XL7qipP4mPs0tHYqXDOdnOe1rP6Nx9a3z+JzO6E=;
        b=n4jckgi51rHw2Ibgvmy4PpbMRM/ZPFQFdGywM3rPpnSgirFUlanj/sCTibmqvmFF7z
         0NYFUTos/3qsjmOKYnAFYuu0k3vKSbb98OBaBmmqEy1MBLFYjddrtKDEbSvNw/pcFoG2
         UVnH3BOLy+pNxKxDDDV7YsJByaURZSJ+ztidC3fctkzaVGp9RDwcBVi40jotP2PSavO5
         AUfndDKSuK+wpnsh5hg5nKG6yMZNAJF8Cb8iEt20aw44GQMamEEf78pMzR7FusUAgfY3
         rLk9zWnRprXpi0rbsz7yLfa2xu8osnoeEcN8lRGj5OBFQioC8/zlhKRbsC3Ec5GpZKtJ
         bxbw==
X-Forwarded-Encrypted: i=1; AJvYcCWUMFNB0d7oJdGl22FQeFyA8aIQEg3weMHCuzFP1W9uGwBQt28fkENfKMEpNKmc5JOTp44HZyKl6v4PvRI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj0LUdzBfHQ0HFy9HXrKAr/ELBhjvCfhb/CT7zU/1jgqojT9ca
	MojdL/tBfraN0lZXiX84j1F256kBGQb20i9VWg3xooYEzwMEP47pLpWQBV1wvVebW9oCbNLP+km
	cRZkGBPab4A==
X-Google-Smtp-Source: AGHT+IFhkdnRh1DHOibgodoGZwdmDBnO5I6y1BIqxNg7zc7aDTESFAa2l8oR/gJ4qmqIXhc3k4GcXet6QLC1
X-Received: from plcc20.prod.google.com ([2002:a17:902:c1d4:b0:234:c104:43f1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:198c:b0:26a:ac66:ef3f
 with SMTP id d9443c01a7336-28e9a54630fmr107474415ad.8.1759688700665; Sun, 05
 Oct 2025 11:25:00 -0700 (PDT)
Date: Sun,  5 Oct 2025 11:24:15 -0700
In-Reply-To: <20251005182430.2791371-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251005182430.2791371-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251005182430.2791371-13-irogers@google.com>
Subject: [PATCH v7 12/27] perf pmu: Add and use legacy_terms in alias information
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

Add support to finding/adding events from the default_core event
table. If an event already exists from sysfs/json then the
default_core configuration is saved in the legacy_terms string. Lazily
use the legacy_terms string to set a legacy hardware or cache event as
deprecated if the core PMU doesn't support it. Use the legacy terms
string to set the alternate_hw_config, avoiding the value needing to
be passed from the parse_events parser.

Tested-by: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 137 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 117 insertions(+), 20 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index e25a4201f9ad..667be41abcd7 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -69,6 +69,11 @@ struct perf_pmu_alias {
 	char *topic;
 	/** @terms: Owned copy of the event terms. */
 	char *terms;
+	/**
+	 * @legacy_terms: If the event aliases a legacy event, holds a copy
+	 * ofthe legacy event string.
+	 */
+	char *legacy_terms;
 	/**
 	 * @pmu_name: The name copied from the json struct pmu_event. This can
 	 * differ from the PMU name as it won't have suffixes.
@@ -101,6 +106,12 @@ struct perf_pmu_alias {
 	 * default.
 	 */
 	bool deprecated;
+	/**
+	 * @legacy_deprecated_checked: Legacy events may not be supported by the
+	 * PMU need to be checked. If they aren't supported they are marked
+	 * deprecated.
+	 */
+	bool legacy_deprecated_checked;
 	/** @from_sysfs: Was the alias from sysfs or a json event? */
 	bool from_sysfs;
 	/** @info_loaded: Have the scale, unit and other values been read from disk? */
@@ -430,6 +441,7 @@ static void perf_pmu_free_alias(struct perf_pmu_alias *alias)
 	zfree(&alias->topic);
 	zfree(&alias->pmu_name);
 	zfree(&alias->terms);
+	zfree(&alias->legacy_terms);
 	free(alias);
 }
 
@@ -522,6 +534,7 @@ static void read_alias_info(struct perf_pmu *pmu, struct perf_pmu_alias *alias)
 struct update_alias_data {
 	struct perf_pmu *pmu;
 	struct perf_pmu_alias *alias;
+	bool legacy;
 };
 
 static int update_alias(const struct pmu_event *pe,
@@ -537,8 +550,13 @@ static int update_alias(const struct pmu_event *pe,
 	assign_str(pe->name, "topic", &data->alias->topic, pe->topic);
 	data->alias->per_pkg = pe->perpkg;
 	if (pe->event) {
-		zfree(&data->alias->terms);
-		data->alias->terms = strdup(pe->event);
+		if (data->legacy) {
+			zfree(&data->alias->legacy_terms);
+			data->alias->legacy_terms = strdup(pe->event);
+		} else {
+			zfree(&data->alias->terms);
+			data->alias->terms = strdup(pe->event);
+		}
 	}
 	if (!ret && pe->unit) {
 		char *unit;
@@ -628,7 +646,6 @@ static int perf_pmu__new_alias(struct perf_pmu *pmu, const char *name,
 			return ret;
 		}
 	}
-
 	alias->name = strdup(name);
 	alias->desc = desc ? strdup(desc) : NULL;
 	alias->long_desc = long_desc ? strdup(long_desc) : NULL;
@@ -645,15 +662,29 @@ static int perf_pmu__new_alias(struct perf_pmu *pmu, const char *name,
 	default:
 	case EVENT_SRC_SYSFS:
 		alias->from_sysfs = true;
-		if (pmu->events_table) {
+		if (pmu->events_table || pmu->is_core) {
 			/* Update an event from sysfs with json data. */
 			struct update_alias_data data = {
 				.pmu = pmu,
 				.alias = alias,
+				.legacy = false,
 			};
-			if (pmu_events_table__find_event(pmu->events_table, pmu, name,
-							 update_alias, &data) == 0)
+			if ((pmu_events_table__find_event(pmu->events_table, pmu, name,
+							  update_alias, &data) == 0)) {
+				/*
+				 * Override sysfs encodings with json encodings
+				 * specific to the cpuid.
+				 */
 				pmu->cpu_common_json_aliases++;
+			}
+			if (pmu->is_core) {
+				/* Add in legacy encodings. */
+				data.legacy = true;
+				if (pmu_events_table__find_event(
+						perf_pmu__default_core_events_table(),
+						pmu, name, update_alias, &data) == 0)
+					pmu->cpu_common_json_aliases++;
+			}
 		}
 		pmu->sysfs_aliases++;
 		break;
@@ -1054,13 +1085,16 @@ void pmu_add_cpu_aliases_table(struct perf_pmu *pmu, const struct pmu_events_tab
 
 static void pmu_add_cpu_aliases(struct perf_pmu *pmu)
 {
-	if (!pmu->events_table)
+	if (!pmu->events_table && !pmu->is_core)
 		return;
 
 	if (pmu->cpu_aliases_added)
 		return;
 
 	pmu_add_cpu_aliases_table(pmu, pmu->events_table);
+	if (pmu->is_core)
+		pmu_add_cpu_aliases_table(pmu, perf_pmu__default_core_events_table());
+
 	pmu->cpu_aliases_added = true;
 }
 
@@ -1738,10 +1772,14 @@ static struct perf_pmu_alias *pmu_find_alias(struct perf_pmu *pmu,
 		return alias;
 
 	/* Alias doesn't exist, try to get it from the json events. */
-	if (pmu->events_table &&
-	    pmu_events_table__find_event(pmu->events_table, pmu, name,
-				         pmu_add_cpu_aliases_map_callback,
-				         pmu) == 0) {
+	if ((pmu_events_table__find_event(pmu->events_table, pmu, name,
+					  pmu_add_cpu_aliases_map_callback,
+					  pmu) == 0) ||
+	    (pmu->is_core &&
+	     pmu_events_table__find_event(perf_pmu__default_core_events_table(),
+					  pmu, name,
+					  pmu_add_cpu_aliases_map_callback,
+					  pmu) == 0)) {
 		alias = perf_pmu__find_alias(pmu, name, /*load=*/ false);
 	}
 	return alias;
@@ -1865,6 +1903,20 @@ int perf_pmu__check_alias(struct perf_pmu *pmu, struct parse_events_terms *head_
 		if (ret)
 			return ret;
 
+		if (alias->legacy_terms) {
+			struct perf_event_attr attr = {.config = 0,};
+
+			ret = perf_pmu__parse_terms_to_attr(pmu, alias->legacy_terms, &attr);
+			if (ret) {
+				parse_events_error__handle(err, term->err_term,
+							strdup("Error evaluating legacy terms"),
+							NULL);
+				return ret;
+			}
+			if (attr.type == PERF_TYPE_HARDWARE)
+				*alternate_hw_config = attr.config & PERF_HW_EVENT_MASK;
+		}
+
 		if (alias->per_pkg)
 			info->per_pkg = true;
 
@@ -2034,9 +2086,13 @@ bool perf_pmu__have_event(struct perf_pmu *pmu, const char *name)
 		return drm_pmu__have_event(pmu, name);
 	if (perf_pmu__find_alias(pmu, name, /*load=*/ true) != NULL)
 		return true;
-	if (pmu->cpu_aliases_added || !pmu->events_table)
+	if (pmu->cpu_aliases_added || (!pmu->events_table && !pmu->is_core))
 		return false;
-	return pmu_events_table__find_event(pmu->events_table, pmu, name, NULL, NULL) == 0;
+	if (pmu_events_table__find_event(pmu->events_table, pmu, name, NULL, NULL) == 0)
+		return true;
+	return pmu->is_core &&
+		pmu_events_table__find_event(perf_pmu__default_core_events_table(),
+					     pmu, name, NULL, NULL) == 0;
 }
 
 size_t perf_pmu__num_events(struct perf_pmu *pmu)
@@ -2053,13 +2109,18 @@ size_t perf_pmu__num_events(struct perf_pmu *pmu)
 	pmu_aliases_parse(pmu);
 	nr = pmu->sysfs_aliases + pmu->sys_json_aliases;
 
-	if (pmu->cpu_aliases_added)
-		 nr += pmu->cpu_json_aliases;
-	else if (pmu->events_table)
-		nr += pmu_events_table__num_events(pmu->events_table, pmu) -
-			pmu->cpu_common_json_aliases;
-	else
+	if (pmu->cpu_aliases_added) {
+		nr += pmu->cpu_json_aliases;
+	} else if (pmu->events_table || pmu->is_core) {
+		nr += pmu_events_table__num_events(pmu->events_table, pmu);
+		if (pmu->is_core) {
+			nr += pmu_events_table__num_events(
+				perf_pmu__default_core_events_table(), pmu);
+		}
+		nr -= pmu->cpu_common_json_aliases;
+	} else {
 		assert(pmu->cpu_json_aliases == 0 && pmu->cpu_common_json_aliases == 0);
+	}
 
 	if (perf_pmu__is_tool(pmu))
 		nr -= tool_pmu__num_skip_events();
@@ -2121,6 +2182,42 @@ static char *format_alias(char *buf, int len, const struct perf_pmu *pmu,
 	return buf;
 }
 
+static bool perf_pmu_alias__check_deprecated(struct perf_pmu *pmu, struct perf_pmu_alias *alias)
+{
+	struct perf_event_attr attr = {.config = 0,};
+	const char *check_terms;
+	bool has_legacy_config;
+
+	if (alias->legacy_deprecated_checked)
+		return alias->deprecated;
+
+	alias->legacy_deprecated_checked = true;
+	if (alias->deprecated)
+		return true;
+
+	check_terms = alias->terms;
+	has_legacy_config =
+		strstr(check_terms, "legacy-hardware-config=") != NULL ||
+		strstr(check_terms, "legacy-cache-config=") != NULL;
+	if (!has_legacy_config && alias->legacy_terms) {
+		check_terms = alias->legacy_terms;
+		has_legacy_config =
+			strstr(check_terms, "legacy-hardware-config=") != NULL ||
+			strstr(check_terms, "legacy-cache-config=") != NULL;
+	}
+	if (!has_legacy_config)
+		return false;
+
+	if (perf_pmu__parse_terms_to_attr(pmu, check_terms, &attr) != 0) {
+		/* Parsing failed, set as deprecated. */
+		alias->deprecated = true;
+	} else if (attr.type < PERF_TYPE_MAX) {
+		/* Flag unsupported legacy events as deprecated. */
+		alias->deprecated = !is_event_supported(attr.type, attr.config);
+	}
+	return alias->deprecated;
+}
+
 int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate_pmus,
 			     void *state, pmu_event_callback cb)
 {
@@ -2178,7 +2275,7 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate_pmus,
 				"%.*s/%s/", (int)pmu_name_len, info.pmu_name, event->terms) + 1;
 		info.str = event->terms;
 		info.topic = event->topic;
-		info.deprecated = event->deprecated;
+		info.deprecated = perf_pmu_alias__check_deprecated(pmu, event);
 		ret = cb(state, &info);
 		if (ret)
 			goto out;
-- 
2.51.0.618.g983fd99d29-goog


