Return-Path: <linux-kernel+bounces-790382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF57B3A663
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 18:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14FE6986E7D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 16:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E02326D67;
	Thu, 28 Aug 2025 16:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RQzWjkVH"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1345322C8C
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 16:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756398767; cv=none; b=SPN/UfD/TMguZ9xosnNzf3ofTR3TXLl9JXe6wL8WD6qpegy6ftI30zm4/9c/IpwgEmC3UT/slRLvsizpXeOvwP6IwllU2yY9NPoYTgCCY/gB8fEe6HH7bRoxM1zB6Dbh2fUnaepuMPtOqCFOp7qG4pApeH5w+Ksxc9wmga4DclA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756398767; c=relaxed/simple;
	bh=nBsGDyfGV/YwlVsRPVyPqun5rVk7VjpidpS76C7cgSY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=DrrwT02vajlS4683d2/KzC9sSjda6yPb1M11NXORILozm/IJy19GcIdk+N9M8IBtIixxPwipp+bsQjkDmwv8l2hbOzuVGRehEphW/p/3r7Q+ai+PlX5NKsTi0+5NmoLx57q5LrfV946FASvOdJVRKYO222o9sWlUFfDPFjfEgsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RQzWjkVH; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-244581ce13aso19014625ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 09:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756398765; x=1757003565; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aOQ99xgVI8ZBcLOUqTlIwSjxWz4nfhGrBQ3qwqf0K9I=;
        b=RQzWjkVHdhBG18z0x5/cOvG9T92Zm37fTQ1LPdBi+T3tk7+hVjje/8Z48bpPAFy6kd
         awQEygx4GzL9VKx5FryZzirdUOA2DxmklMYVR8IztO2mb+d8DjcS/+v5x2d0mkyODKjW
         Y+pqPEOcu/rL8DMHRQbHJFcUyuub8vL9L0aT580dmE3WKlJpzVmPF43h9hoMprlgti1E
         w3X2T0yu7wjGaqYsonOFDtkxbjF1npSTFIw1R+1rtVqwHSYuGiWjtEXUamv2ZOHopL8f
         8NDyMW8DD1p6aCf+lPKHcRqMA2J8IejA4xeVq6OxnPlkQ87gZKhyswxL+QpmFLr2/GFp
         9bgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756398765; x=1757003565;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aOQ99xgVI8ZBcLOUqTlIwSjxWz4nfhGrBQ3qwqf0K9I=;
        b=cpgyE/BMkyjt+Tch+oxoo48A+HeQKsEdKMDCA4mTvUnbTUGLDlRn3IA7vJWI4/sE6t
         2podtJIHhJAYY9xgdXJ6DeQIUgRKnXcwiyqD43DCuPcC0nxA75xmzGmlx8xkX7+dNmFw
         rKx/Xx8ItkQpA3xVzQRUdNWSlb9likHbFxf7bM0SVAFjY9B1ZqFEfEATNjFpvYwfWy6v
         MjE4YaCIgp3vvplTJvh83y35yTxDlk+4Ayy33KncSCOKYQ5rjTKM/FO2M9kcVi4h/mR8
         fwikXA/p+UXuMJshj7Qr4GpGYjOXlAk8VVH3wMttdI3+GQvFNO7IW6GonDOFqjgSLYxv
         mWkA==
X-Forwarded-Encrypted: i=1; AJvYcCVtyJhJGaDbcfS14mOM/rcdZHFC2tjFflsYCAojBXfoVwNTEwvV0/HI0zztEvU8NQcMs1peCG6qmDgJumI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdK3bVJA8X+M09MXllat2k1yhzhVJm1nUo/XmljZFtNIhhNjnj
	N+4StNVH5I+j1OwUJZxkmlU6HydJBoBCDM3rfCv2d09N8O2odt2YyoJ8tOv2P5H7ezlN/bBsrWg
	u01yYTvKBvw==
X-Google-Smtp-Source: AGHT+IHA3vWe6uuxFHk23cIlVGCY30ONKcmjL9XnxSed4zPBlzwzdH5nz0RTrAs9zkskxHVBmZ/g8Q9trcYI
X-Received: from pjyf15.prod.google.com ([2002:a17:90a:ec8f:b0:321:c441:a0a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f64d:b0:246:ae6e:e5e5
 with SMTP id d9443c01a7336-246ae6ee83bmr186912095ad.8.1756398765046; Thu, 28
 Aug 2025 09:32:45 -0700 (PDT)
Date: Thu, 28 Aug 2025 09:32:12 -0700
In-Reply-To: <20250828163225.3839073-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828163225.3839073-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250828163225.3839073-3-irogers@google.com>
Subject: [PATCH v2 02/15] perf perf_api_probe: Avoid scanning all PMUs, try
 software PMU first
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
Content-Type: text/plain; charset="UTF-8"

Scan the software PMU first rather than last as it is the least likely
to fail the probe. Specifying the software PMU by name was enabled by
commit 9957d8c801fe ("perf jevents: Add common software event
json"). For hardware events, add core PMU names when getting events to
probe so that not all PMUs are scanned. For example, when legacy
events support wildcards and for the event "cycles:u" on x86, we want
to only scan the "cpu" PMU and not all uncore PMUs for the event too.

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
2.51.0.268.g9569e192d0-goog


