Return-Path: <linux-kernel+bounces-842396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1ED8BB9AD2
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 20:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D8B43B6195
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 18:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDCA1DE2D7;
	Sun,  5 Oct 2025 18:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4rxhZe0J"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72F31DB958
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 18:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759688681; cv=none; b=mrBYmNNtD8Y1XQ++xDVF305d+iyDMOg5sEKx1gt/S8A05GlTUljjxuaiu7afxVJ/uZ3Be3FJn8lx9WyLNty7953jm5aLkDwrrY4vWNWCEyWtCDDqtP4Yi8DWj4x5uFZtntQJRRFpoW1UUzHbmrocuuFhsioSsZ7SAqEvQcDryjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759688681; c=relaxed/simple;
	bh=8p/urS87Auj0Qc/hLjlTgfByL6vRZArwY5TP2UtPovE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mFi4mUxVTuYvIVEayS0sjCiSq5rMDPRZQtx37hHj44uloSsjzGo0sj+TAfQcDkfAnbRdUCCz7V5bRVChwfN9tKVNFhC4cN8ffTzsWwFxZuS9KTrtXgvXYZtcZwiG6e5lAjJ1sWN+B5ndXpktS1DmHKbuS49MxiYosyc//4ePUqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4rxhZe0J; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-28a5b8b12bbso86887515ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 11:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759688679; x=1760293479; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pk7xh7SZJJ3XEbkvNLhoR3syBhj+u9bQNDkycPU9Lww=;
        b=4rxhZe0Jxehxdt5+zUKeJck0vKbXT3v3teIqGBuuiAnh5QbvROxilrpVEpXudiPghx
         8PArqztpGCCyCG987l2Cs/mkme+Zv5eZUDaMsqt9R75uAYguFXpqNdA6xG0E6o5VJBQo
         PNhOLptVGA9xZX/W6BVblO0DPFrMoitFQLbinwmzJwweuo53ffWBmk0LvK9tjZ9xDbrh
         E7F8ABKXS7IuIRIWLLq3z3bTUDr2HHq5JjfeD82ufdVnKKFxqMkgCbl+btuP+EtdMP6z
         7HGxQI2A4LbWSx5aiN552E5j0hsjABAkZeMw4ZozcxOs8EnpXnjri2GLiDz2k/Hux6VD
         AfAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759688679; x=1760293479;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pk7xh7SZJJ3XEbkvNLhoR3syBhj+u9bQNDkycPU9Lww=;
        b=GtlT8WWEJUAf3wdE+ktLJ7XFa5RsshqvRx45RlLbQNl5bdwrdVNUu2XjGvP5ktZ+IV
         qsrqdLgTPmkutLgoX0Jgq2BDwMSU7Ui+QKFFgFDjrDV9q0ykW6neUhqAPCizqjJOoz6V
         49Qz0HMdxDZymP9Y5PcfyKz5ZBacO+lQ2N8qYuuEtAndyCmKkcZyAqQwLwkrT8Hx99Dc
         dbiGYfjI2N7gvJD6xGCU5SBYGASVGqEw6tejqJ6C2IkZc6YNd+m4F1PtYVOILrTPBQ8L
         4CAEbcErg0D/iaAsD5JUsZXwb2FFlq9jArsAcypw7IWHdotwAeF4Fsw2rK7dh7l3Ly58
         WGfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCYLJ+qsVp5X3F1F6VnF4O0wtm5N4IPB3jVNe2/NLMFWfvCeaaC37ic0zRMboErGuPxCn7sY6jVrlpREc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsaFdbw7455DlxP0wtg+VhjXl8ypSaRX4pI3CNbfPsXRTNWjYa
	jm4TIVajsqh2PWfUqaeu4zO1SIbE2Ckn5JrLuXYI/e1qQEbBkGvB+4o+ViumzQ3pTdb9YPIBYag
	vzpEPr8rIjw==
X-Google-Smtp-Source: AGHT+IFJMaI7AAdlvvX+sCFJDsuKt1vlz+B2+hujflOrEg+1jNaUzgqjTUpEqCAvScumMuywhWYZncSVvAaZ
X-Received: from plpl16.prod.google.com ([2002:a17:903:3dd0:b0:26a:23c7:68d3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:fc86:b0:24b:182b:7144
 with SMTP id d9443c01a7336-28e9a5655f4mr112806005ad.7.1759688679065; Sun, 05
 Oct 2025 11:24:39 -0700 (PDT)
Date: Sun,  5 Oct 2025 11:24:05 -0700
In-Reply-To: <20251005182430.2791371-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251005182430.2791371-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251005182430.2791371-3-irogers@google.com>
Subject: [PATCH v7 02/27] perf perf_api_probe: Avoid scanning all PMUs, try
 software PMU first
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

Scan the software PMU first rather than last as it is the least likely
to fail the probe. Specifying the software PMU by name was enabled by
commit 9957d8c801fe ("perf jevents: Add common software event
json"). For hardware events, add core PMU names when getting events to
probe so that not all PMUs are scanned. For example, when legacy
events support wildcards and for the event "cycles:u" on x86, we want
to only scan the "cpu" PMU and not all uncore PMUs for the event too.

Tested-by: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/perf_api_probe.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/perf_api_probe.c b/tools/perf/util/perf_api_probe.c
index 1de3b69cdf4a..6ecf38314f01 100644
--- a/tools/perf/util/perf_api_probe.c
+++ b/tools/perf/util/perf_api_probe.c
@@ -59,10 +59,10 @@ static int perf_do_probe_api(setup_probe_fn_t fn, struct perf_cpu cpu, const cha
 
 static bool perf_probe_api(setup_probe_fn_t fn)
 {
-	const char *try[] = {"cycles:u", "instructions:u", "cpu-clock:u", NULL};
+	struct perf_pmu *pmu;
 	struct perf_cpu_map *cpus;
 	struct perf_cpu cpu;
-	int ret, i = 0;
+	int ret = 0;
 
 	cpus = perf_cpu_map__new_online_cpus();
 	if (!cpus)
@@ -70,12 +70,23 @@ static bool perf_probe_api(setup_probe_fn_t fn)
 	cpu = perf_cpu_map__cpu(cpus, 0);
 	perf_cpu_map__put(cpus);
 
-	do {
-		ret = perf_do_probe_api(fn, cpu, try[i++]);
-		if (!ret)
-			return true;
-	} while (ret == -EAGAIN && try[i]);
-
+	ret = perf_do_probe_api(fn, cpu, "software/cpu-clock/u");
+	if (!ret)
+		return true;
+
+	pmu = perf_pmus__scan_core(/*pmu=*/NULL);
+	if (pmu) {
+		const char *try[] = {"cycles", "instructions", NULL};
+		char buf[256];
+		int i = 0;
+
+		while (ret == -EAGAIN && try[i]) {
+			snprintf(buf, sizeof(buf), "%s/%s/u", pmu->name, try[i++]);
+			ret = perf_do_probe_api(fn, cpu, buf);
+			if (!ret)
+				return true;
+		}
+	}
 	return false;
 }
 
-- 
2.51.0.618.g983fd99d29-goog


