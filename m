Return-Path: <linux-kernel+bounces-789334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 150CEB39405
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 08:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C34B8461108
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 06:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3702C08A1;
	Thu, 28 Aug 2025 06:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oHIUQy8T"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B27E2BD5AE
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 06:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756363376; cv=none; b=qTSOd7jiFVNPY2CAw5LiGKjXCahk8P6MuAlzUIhpJVhBDVt1Pm2v9oZmjgvBSHjcIMSV5pfVNmTnhN/EzkQ0yeSck/fFBW77/nvdf2nv/p9XOSd31efVpHF/nKwP7hklZAmGnFyNThv8M+kAzjtUv7RpDeOF5UTBj2rq1r04XdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756363376; c=relaxed/simple;
	bh=NFE01fpXLaNL5C3t9388FhBoliub7qbZTZQG3FrpAeY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=rSjJkdrqJk6LkWyfBgf7hGwMEvjxTvE3z/e4770PS6w0UqkW/u52zYnvrqONwWqgNF/eWKw7PY0UPh4MP8BcE4QM9jvitwyvuQrvQVSzjrCL6ZDQFsT4mbnPLIf/pqMUt9xbZ6QjvXOJs1LhLmrJQF8fkUelzzASAwikFEjXK28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oHIUQy8T; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-248981c02cfso7280965ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 23:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756363374; x=1756968174; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rficAehwGh98xuTiVQIp2DmDqGnnE/hHRNAZIZ86ZEA=;
        b=oHIUQy8Tg8XY/SZ5I0MufCpoXZVfxn7edLNTyasAPXDecjcJEXILyeNi4WIXqLhRQE
         JJBfJU9JzXEGjiz9btAYI+Fbg9EgU2fk28u/7wYUOxn+Fb79n1aV6XRw8gznE0F2my1P
         yDXhLcvIpM5R6GiHtKsefHJHnY9BJTZmfgsI99KhPRRpSCpmWq1FkTxkmD741/xgDeL8
         a7MAkSxCpR5MBBu+EYoMykp5IoPaN3G8KzQoBe6u5LQvSKkLE8O1jCQCccGCofy6JRyr
         4xZTj7O/dRrwAY+rv/FBT30qIdIzBaeI7+TNjvSka3YbRQTLbdHOl16BUSW0ssm6U3t1
         Gi9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756363374; x=1756968174;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rficAehwGh98xuTiVQIp2DmDqGnnE/hHRNAZIZ86ZEA=;
        b=hMMPDlYH1YDQJ1qJsQy8N6pTgxnRrj2AXazEUS0GJs5JPZpRLIiTQdEa/RPi0GE+FR
         uDLHH6Do8ltSfTpBPYnR9Cd3YEP5OoN0emikyRdeMKkBZ5S/YN+CDjONmXPSKEyYVTH1
         CpP4ySrLVify2YCBKqM8dkVfxIBjRSPtr5GiaHUyMhuPxEFiaJhv4B64e1DdIc6HNQNN
         liKLp8Z4nqzKHlm8AMb/KGWE/zaQUFdAL2GG8bztQH88vbSSxb3Cr0/04JyUBGQlFKA1
         IDKvUhgRUrhO4pyFZHRDFuWeISR/70y3swWvN9qsFekUf1AnCc8eSGutTaPqnBcVlUdk
         4gaA==
X-Forwarded-Encrypted: i=1; AJvYcCVEonParGi+STpVz0ZQwD5i+S4Zs+fHnocDOIQO/KWfYEaM3qEDh0lHpDj+7dsdKR8ND+UZdIFOG4celN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxElcNE8bxjnXnnh0L6nb2lfq8ptCZ7WZ9GpzbwAdiprWkHFnDk
	wml0NiKnBuJenqU7X5nySknTb0Noqj0u+aTVTEbuaUE0GRom63rrGJpnfYAmUOjO27p9j6W2Pz+
	FlygsiYGBEg==
X-Google-Smtp-Source: AGHT+IHXZyZ9yOoHgw4Uh+/XWLh8/W9nyDJIE40jG2ciN9kf/+hpatZnpUq86kqbXT1Efd6P4S4HNpW6kIim
X-Received: from plgx8.prod.google.com ([2002:a17:902:ec88:b0:240:4fbf:cd20])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c405:b0:240:99e6:6bc3
 with SMTP id d9443c01a7336-2462ee48b16mr290536085ad.20.1756363374326; Wed, 27
 Aug 2025 23:42:54 -0700 (PDT)
Date: Wed, 27 Aug 2025 23:42:27 -0700
In-Reply-To: <20250828064231.1762997-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828064231.1762997-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250828064231.1762997-10-irogers@google.com>
Subject: [PATCH v1 09/13] perf pmu: Add and use legacy_terms in alias information
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
	Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>
Content-Type: text/plain; charset="UTF-8"

Add support to finding/adding events from the default_core event
table. If an event already exists from sysfs/json then the
default_core configuration is saved in the legacy_terms string. Lazily
use the legacy_terms string to set a legacy hardware or cache event as
deprecated if the core PMU doesn't support it. Use the legacy terms
string to set the alternate_hw_config, avoiding the value needing to
be passed from the parse_events parser.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 133 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 115 insertions(+), 18 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 4f5e09a21a82..8581d88a11f4 100644
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
@@ -625,7 +643,6 @@ static int perf_pmu__new_alias(struct perf_pmu *pmu, const char *name,
 			return ret;
 		}
 	}
-
 	alias->name = strdup(name);
 	alias->desc = desc ? strdup(desc) : NULL;
 	alias->long_desc = long_desc ? strdup(long_desc) : NULL;
@@ -647,10 +664,24 @@ static int perf_pmu__new_alias(struct perf_pmu *pmu, const char *name,
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
@@ -1057,13 +1088,16 @@ void pmu_add_cpu_aliases_table(struct perf_pmu *pmu, const struct pmu_events_tab
 
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
 
@@ -1740,10 +1774,14 @@ static struct perf_pmu_alias *pmu_find_alias(struct perf_pmu *pmu,
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
@@ -1867,6 +1905,20 @@ int perf_pmu__check_alias(struct perf_pmu *pmu, struct parse_events_terms *head_
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
+				*alternate_hw_config = attr.config;
+		}
+
 		if (alias->per_pkg)
 			info->per_pkg = true;
 
@@ -2037,7 +2089,11 @@ bool perf_pmu__have_event(struct perf_pmu *pmu, const char *name)
 		return true;
 	if (pmu->cpu_aliases_added || !pmu->events_table)
 		return false;
-	return pmu_events_table__find_event(pmu->events_table, pmu, name, NULL, NULL) == 0;
+	if (pmu_events_table__find_event(pmu->events_table, pmu, name, NULL, NULL) == 0)
+		return true;
+	return pmu->is_core &&
+		pmu_events_table__find_event(perf_pmu__default_core_events_table(),
+					     pmu, name, NULL, NULL) == 0;
 }
 
 size_t perf_pmu__num_events(struct perf_pmu *pmu)
@@ -2054,13 +2110,18 @@ size_t perf_pmu__num_events(struct perf_pmu *pmu)
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
@@ -2122,6 +2183,42 @@ static char *format_alias(char *buf, int len, const struct perf_pmu *pmu,
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
@@ -2179,7 +2276,7 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate_pmus,
 				"%.*s/%s/", (int)pmu_name_len, info.pmu_name, event->terms) + 1;
 		info.str = event->terms;
 		info.topic = event->topic;
-		info.deprecated = event->deprecated;
+		info.deprecated = perf_pmu_alias__check_deprecated(pmu, event);
 		ret = cb(state, &info);
 		if (ret)
 			goto out;
-- 
2.51.0.268.g9569e192d0-goog


