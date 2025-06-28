Return-Path: <linux-kernel+bounces-707395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 829AEAEC36D
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jun 2025 02:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0D6056497F
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jun 2025 00:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AD01D63F0;
	Sat, 28 Jun 2025 00:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gKNjDDMQ"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC9B17A305
	for <linux-kernel@vger.kernel.org>; Sat, 28 Jun 2025 00:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751069397; cv=none; b=agFS+YTsA5AurecAGWKv5fRL8YqHe78SKakg+1eYdZ7sEHFbYhjrliigbdjFLhosTtzjp9Ae6wT374PLdSFJE25qD0wlfGj3ZlXTd0szy/lPq5YXna+HrOVkhw+D0oY0OBMoIcioETiJAHcMPD9bJvkTebMNGBHjsCUR8+vyUBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751069397; c=relaxed/simple;
	bh=J4OzpKjzAQvz4+NOOvDQC2wN1+kdU2op3Xo8SV5ZLbk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=GH0cAmcWQKwJHo7ZpEZn0Gt/07amsLOzl6vfwpKLnSlqPRK7640RGK4hiBk/YyQffaigB0J0Myx7KO0Wl7y6wgoUe2FsrTDMXhXZzeDCnB3f3mnzwzrltJOfNztEs2ZCW9mkX7CD+8GgWAK3B3w8pRVNskZbfHUslVigqx6016Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gKNjDDMQ; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-747ddba7c90so385294b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jun 2025 17:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751069395; x=1751674195; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/8RYnoHHKYJ1Y4zKmI9S+F9LPJ5D9yBDipkEOnTdUXE=;
        b=gKNjDDMQG8hwZMGcr08TyYY1vF4eUguP7PK+E4b2Xx0Lf+eDzfiSu5lMieNiAuKfmD
         XLhSlygy6RDWI7X5RxnExaoUEpBtkKkzlQNMyElUyr3fBDKRjP7H1fKr0wLFo5JWtURv
         MgbzWE+oUYSfEmUA8AcIU+rw5Tq/NaG+uTWgmsQp25389TjJJqSQedRvSccync9iP5WB
         YH9Ez8Y7r5YoqlJiGjnoM4Pl2P24Swz+1fEA91VI4ubIpaVEAUsQbDNJm3qZnXExifaY
         7ukYRAXcPlqHp4YSmSDJHAEMQJxmz6O1a5suj3/9xSoBUnWnrX8CYuJlzoAprgPOcls0
         41+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751069395; x=1751674195;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/8RYnoHHKYJ1Y4zKmI9S+F9LPJ5D9yBDipkEOnTdUXE=;
        b=v1otm6FL9FUIUgjz2CTNppGQm0jw53A98NNcPSyb0wIbhrbm0zFmjlcynX3bPE0An+
         VJ5QRB2rP90I4SZ+EmBBCQfKzy0zH47lCrsn0ubdS+Mg0QX/0/XUFMKtirrtgZt8dgE4
         iNUzTP5MSsF4HGXYTk4d2wk1VaBArjcPh2OegTKwT4jLF65cVurmSJBhMkYeIYIshkAC
         sU2hWGCHbQAxXS3ehZw7PaR4egbxrcjrFUwha4W/tmtj0PgnMvaAIMn2dmxlW5HrNT4i
         v5l6Tv6IU1DY04H6Lx3i6K/efJwCjIXtqW8Z69rBiCRiUDQJhqprwKwx0HIS2V9zaPg7
         6vhw==
X-Forwarded-Encrypted: i=1; AJvYcCVegexE/yVEKtzniNMqsIv/I/B+WVYR/Js1K00jJnwBdu8+vbA0h/uqpByKL61zlyxUvJkhBf6PNkKuIZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMrWVEaNTVbdz4zE3O2fPfGuD4V+Ku41ZLVeuqyKBXxcGgN6lA
	Fy1nO+3B5PDdSnH9gQS9LKqYP38R+/MfvHKJsjHEfdXcYr+m3Ibnx+si9XB6K58GiqrawUebiFN
	d71CPRlIgRA==
X-Google-Smtp-Source: AGHT+IHI9yoH6ryjs/0r4lN1uoc1sVLOFEewvIRG3rwL1A72VaGHVS4LqMyQeJlSUs10Na5kPFr5nyABWMCu
X-Received: from pfay37.prod.google.com ([2002:a05:6a00:1825:b0:748:f16c:14c5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:648d:b0:1f5:769a:a4be
 with SMTP id adf61e73a8af0-220a181ba61mr9052587637.36.1751069395119; Fri, 27
 Jun 2025 17:09:55 -0700 (PDT)
Date: Fri, 27 Jun 2025 17:09:24 -0700
In-Reply-To: <20250628000929.230406-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250628000929.230406-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250628000929.230406-11-irogers@google.com>
Subject: [PATCH v4 10/15] perf pmu: Tolerate failure to read the type for
 wellknown PMUs
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, John Garry <john.g.garry@oracle.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Andi Kleen <ak@linux.intel.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Gautam Menghani <gautam@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

If sysfs isn't mounted then we may fail to read a PMU's type. In this
situation resort to lookup of wellknown types. Only applies to
software, tracepoint and breakpoint PMUs.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 687288991eb4..b09b2ea2407a 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1181,6 +1181,32 @@ int perf_pmu__init(struct perf_pmu *pmu, __u32 type, const char *name)
 	return 0;
 }
 
+static __u32 wellknown_pmu_type(const char *pmu_name)
+{
+	struct {
+		const char *pmu_name;
+		__u32 type;
+	} wellknown_pmus[] = {
+		{
+			"software",
+			PERF_TYPE_SOFTWARE
+		},
+		{
+			"tracepoint",
+			PERF_TYPE_TRACEPOINT
+		},
+		{
+			"breakpoint",
+			PERF_TYPE_BREAKPOINT
+		},
+	};
+	for (size_t i = 0; i < ARRAY_SIZE(wellknown_pmus); i++) {
+		if (!strcmp(wellknown_pmus[i].pmu_name, pmu_name))
+			return wellknown_pmus[i].type;
+	}
+	return PERF_TYPE_MAX;
+}
+
 struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char *name,
 				  bool eager_load)
 {
@@ -1200,8 +1226,12 @@ struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char
 	 * that type value is successfully assigned (return 1).
 	 */
 	if (perf_pmu__scan_file_at(pmu, dirfd, "type", "%u", &pmu->type) != 1) {
-		perf_pmu__delete(pmu);
-		return NULL;
+		/* Double check the PMU's name isn't wellknown. */
+		pmu->type = wellknown_pmu_type(name);
+		if (pmu->type == PERF_TYPE_MAX) {
+			perf_pmu__delete(pmu);
+			return NULL;
+		}
 	}
 
 	/*
-- 
2.50.0.727.gbf7dc18ff4-goog


