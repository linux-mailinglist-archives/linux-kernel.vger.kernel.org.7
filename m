Return-Path: <linux-kernel+bounces-829744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E40B6B97BAF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 00:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8F3E1AE2D33
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 22:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBAB31C591;
	Tue, 23 Sep 2025 22:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S/hV4K0n"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0BD31B127
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 22:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758666841; cv=none; b=QZghDy47qKZ1T5AIrr/37YCG3ZTfRpVnTuZLyISYjxwUZnKKE6wNla1T036TgEn//Gfdl6Rl9lEFh0QjDnsfaiWhBOnSXqJ4i+BqnD7Rlr/N8anLqlCAJzltC4LW+uBVvf2RHO5CpX4ylOemvDRqUEFUZV+VdulWrY0Wm7YNOhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758666841; c=relaxed/simple;
	bh=lv+orrYEZfCCmS3CajyfSe+YtFwMzynEb1XCScLZ0M4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=UKEILwpk1JHNysRgMwVJ4phQ3CYJEtniTA28Kg5gUyVoyItZ5A7xq8wTqmncFpT+skl10YGeuePpuh82snF043PtfILeXgIVrWzOYAcsaSOQhHo0MM6QiYiY44luiOy0QqMPZ/y4fdhG8iYNtr6V7bfGPOeDjflUd3/l+UNdDgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S/hV4K0n; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3307af9b55eso4949524a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 15:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758666839; x=1759271639; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0IRX7WpoC8G1Z7bNmqvaEWKqeWN2XUOf87Rof+WADfg=;
        b=S/hV4K0n7sM6LYxghHC4DXNTmM3HsI1Pqx0VOCYvuRHidEhS6gTRtJldqNvmsWpukT
         0V/nIL8yHuip5bB6ztSFuCaIoFY7oYawo0K/k0yVWpa2q8hIH3qSwgMZ9NSOQQfnLqUE
         yz/wSgw3iwmtASAuGm3G0YdR3oU/8XllDmUzvMZai7aF+g2HXHz0np8hafwLpkKUXQlm
         gdqxh1htOdr/OXLK+bD2jt0aVmPQmmsw9XdPl0E9ULPWC8KvYS+mYjSgrJMx7NfyXySE
         03B0i9v127ndS0Seveqi6QCpcO4W/gb32cmJi1z80cNyTsMDffx5OHoGQYcqoB52s43I
         SLGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758666839; x=1759271639;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0IRX7WpoC8G1Z7bNmqvaEWKqeWN2XUOf87Rof+WADfg=;
        b=Ye/xcFl4z3ca5e3oQE4ZtZfe9OTZrIORJxwS0ftUMdyKdNfH5LhPp2AjLPF/jWeVQO
         xzKSwcgUKx/lO0yz7eGYUfGnHk0dkXHISgXw/lKxfOsK//2BRyn9pMRMj9txEHy0ZINX
         WwKNkKjcgQ91jBDe4/TrARGguPkAB6ln7HhzLVHHxk47P4aEI+ViF8QK3LaTMBX6ymSa
         c9xyqfiEvHJz1Fv+L3Mmd9HjCN2z93sKYSfVCzPpgfQ+0RKxcOByKt9f7zdqOw99jjt6
         cL57Staw9BNC88ek7nm0AQLZjHR0+A5QUmf83AfVunDo5WuleBtsOsPBGFNQzEYMzk2F
         C3RQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkW2y1WegH6jxZVF9b9+hxO5AGUzGizMUSdc/fhVIJZRqhI851VlWx7IfdYYI7j+kxUNNuUG6lp2Xfllo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1XBVp9gDYDLzQISyo395RxtyD5g81zV7F1EOGcbxNp+gcogUN
	Xynv1Dqs4YkSahF0/Ot/wunUs7onsbc5MBlq0QUnAwwCRQbdNY+m0o/BSDro6UCC4COLIv50Sfj
	wazO1Zl4sWg==
X-Google-Smtp-Source: AGHT+IFYItRqxTLqJ6zVJ0IyAoYR9T6X4UNxYzg5FOVMLrHtT1npSOxhldI3Jzp/xirB70IPx44qshtRCo/a
X-Received: from pjbsn16.prod.google.com ([2002:a17:90b:2e90:b0:32b:50cb:b92f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:53c8:b0:32b:df0e:928f
 with SMTP id 98e67ed59e1d1-332a9c1bb8emr4732879a91.37.1758666838868; Tue, 23
 Sep 2025 15:33:58 -0700 (PDT)
Date: Tue, 23 Sep 2025 15:33:05 -0700
In-Reply-To: <20250923223312.238185-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250923223312.238185-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250923223312.238185-22-irogers@google.com>
Subject: [PATCH v6 21/28] perf evsel: Improvements to __evsel__match
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Atish Patra <atishp@rivosinc.com>, 
	Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Content-Type: text/plain; charset="UTF-8"

Ensure both the perf_event_attr and alternate_hw_config are checked in
the match. Don't mask the config if the perf_event_attr isn't a
HARDWARE or HW_CACHE event. Add common early exit cases.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 6a31f9699b49..8c60f79a76ca 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1863,16 +1863,19 @@ bool __evsel__match(const struct evsel *evsel, u32 type, u64 config)
 	u32 e_type = evsel->core.attr.type;
 	u64 e_config = evsel->core.attr.config;
 
-	if (e_type != type) {
-		return type == PERF_TYPE_HARDWARE && evsel->pmu && evsel->pmu->is_core &&
-			evsel->alternate_hw_config == config;
-	}
-
-	if ((type == PERF_TYPE_HARDWARE || type == PERF_TYPE_HW_CACHE) &&
-	    perf_pmus__supports_extended_type())
+	if (e_type == type && e_config == config)
+		return true;
+	if (type != PERF_TYPE_HARDWARE && type != PERF_TYPE_HW_CACHE)
+		return false;
+	if ((e_type == PERF_TYPE_HARDWARE || e_type == PERF_TYPE_HW_CACHE) &&
+		perf_pmus__supports_extended_type())
 		e_config &= PERF_HW_EVENT_MASK;
-
-	return e_config == config;
+	if (e_type == type && e_config == config)
+		return true;
+	if (type == PERF_TYPE_HARDWARE && evsel->pmu && evsel->pmu->is_core &&
+	    evsel->alternate_hw_config == config)
+		return true;
+	return false;
 }
 
 int evsel__read_counter(struct evsel *evsel, int cpu_map_idx, int thread)
-- 
2.51.0.534.gc79095c0ca-goog


