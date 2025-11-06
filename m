Return-Path: <linux-kernel+bounces-887914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFDFC395B8
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 08:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F5A03BB681
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 07:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E5B2E0410;
	Thu,  6 Nov 2025 07:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ptANHQsC"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4604D2DECA5
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 07:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762413171; cv=none; b=YkpjOkhPXZzFkuLCPYChgCeRwncGvxr1u0cnWANb9o2kI5qD7eHwgj3+glR9T9JIw3SKfs2JEPivK/nHA7kI6zfCu89cej9sEXvKv43u+sFT4MW3oPaxhIRgbBlDrOnQ1XllkInx7TH2FY9MfAaq2sTXL/2ZVT+OihGLgwBZKec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762413171; c=relaxed/simple;
	bh=Kgo7sxJNHAVdmzHf5VuG0p/PQfK1697phqEp6Xwcyo0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Iu2h/SoBj+OIBDM3hU+fuTpQx21fTeOEoY3wyuKlGf2VbD4MncFwkMYI9IP9UsAXQVKvcs0v12yuAle0ZSijkbWK1ogIPzwTeTDNc68XCI95V7U52EDYVSX12ALF0JfzxfRMOM5gsJImAv8Jxk9egmd4GyWvB5dYJOmjmaP3FFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ptANHQsC; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b9d73d57328so536942a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 23:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762413170; x=1763017970; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PLwg+2AiO3F/YfbdpvnrnBijRms/bsxixJsYS/jBPB8=;
        b=ptANHQsCJRj/jgug1THZeW2g5XWFMtlnRgFv1fK1HWaSA+dd5jNA4i+bmcj7R79vko
         J8/GsCE7Elviy/ORDu0EPeNLnd8bTFyaiBba6QdeTEcVu2zpNlLDE427ee5iRVofFz1C
         AJThg1qfv0RAmXRlt2E3ONZgsat02ip63ovsIrndNviZZRyAm+n4A/nWZMSXuH7vCR6S
         sEYBB3LC6BFpyz5hadRSIXIAkCzId0lboHYazscTUoZan1ri2USfaId1+ia0aj50JHWC
         Yrm0GwFL9LRYEvKyXhUIUve+/koAIsuaHLWbGgITfJOOjHcOefqeujuscK4a/aIZQlF/
         Hn1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762413170; x=1763017970;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PLwg+2AiO3F/YfbdpvnrnBijRms/bsxixJsYS/jBPB8=;
        b=q24tpYTsdt16Tq+Xw9a0eVK8flW36Y3U0R+734WsTPZUMiOOKaJfuSZ+IklgRhzbVr
         UcS5SGLBwTpv7A+TYhFHJq/Lo5rAqg3zTLVGGp8yn/bFJulijRM9S2n6Majksxr1kG47
         ws4wMCS+yuAeU6SGoQPm9iI5nVE0l65kPJv2xDvmqVsGu4VYwB4RHs69PERpgJnWFvKI
         bZjTuvQSJ/DqxP5yjYB+0H+wdzvF0fvfpflENRrqi+xC/ezYC9OwpxZgfqnJNn0I+VvB
         DPRY/ZnxYQUammzqDFYOWG3y6VAtodi+o9hXj75Mj8fLtPJgvS9XOO4G98BuaQ5EHU4U
         jWcg==
X-Forwarded-Encrypted: i=1; AJvYcCXtVhpkWjmUTl5W3rQ6GbrJI/WmRd8kK7FmVrjmKWlVguWSJWXVgJH7o/4+uUb3g9YZPoa3uKkBgVeRRSw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrFbnAN+Uzg98b3XYbzxd6malxKJIhTNVl2nGMwk7na43VH9eI
	QmOzc6Y0gRY/AbpiJNNr6uebmfNvdZNVC/1BCsDFGYl+mStafEZXyQUyimfKJ1BaioTz7NVkPDa
	AfPaWhnhm5w==
X-Google-Smtp-Source: AGHT+IE0YX5vsYPKWDEQJBgQGJdnX5svKCKT5iKNi+LiQBs+q034F7/hs6Iv6PwLztjF2Ff/O7meufnROYpz
X-Received: from dlbsv11.prod.google.com ([2002:a05:7022:3a0b:b0:119:49ca:6b9f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:12c3:b0:2fb:2e04:eeae
 with SMTP id adf61e73a8af0-34f83d0f7d1mr7648612637.21.1762413169496; Wed, 05
 Nov 2025 23:12:49 -0800 (PST)
Date: Wed,  5 Nov 2025 23:12:33 -0800
In-Reply-To: <20251106071241.141234-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251106071241.141234-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251106071241.141234-3-irogers@google.com>
Subject: [PATCH v3 2/9] perf pmu: perf_cpu_map__new_int to avoid parsing a string
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Yang Li <yang.lee@linux.alibaba.com>, 
	James Clark <james.clark@linaro.org>, Thomas Falcon <thomas.falcon@intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Prefer perf_cpu_map__new_int(0) to perf_cpu_map__new("0") as it avoids
strings parsing.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/drm_pmu.c   | 2 +-
 tools/perf/util/hwmon_pmu.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/drm_pmu.c b/tools/perf/util/drm_pmu.c
index 98d4d2b556d4..fc864bde4cb2 100644
--- a/tools/perf/util/drm_pmu.c
+++ b/tools/perf/util/drm_pmu.c
@@ -119,7 +119,7 @@ static struct drm_pmu *add_drm_pmu(struct list_head *pmus, char *line, size_t li
 		return NULL;
 	}
 
-	drm->pmu.cpus = perf_cpu_map__new("0");
+	drm->pmu.cpus = perf_cpu_map__new_int(0);
 	if (!drm->pmu.cpus) {
 		perf_pmu__delete(&drm->pmu);
 		return NULL;
diff --git a/tools/perf/util/hwmon_pmu.c b/tools/perf/util/hwmon_pmu.c
index 5c27256a220a..279d6b1a47f0 100644
--- a/tools/perf/util/hwmon_pmu.c
+++ b/tools/perf/util/hwmon_pmu.c
@@ -376,7 +376,7 @@ struct perf_pmu *hwmon_pmu__new(struct list_head *pmus, const char *hwmon_dir,
 		perf_pmu__delete(&hwm->pmu);
 		return NULL;
 	}
-	hwm->pmu.cpus = perf_cpu_map__new("0");
+	hwm->pmu.cpus = perf_cpu_map__new_int(0);
 	if (!hwm->pmu.cpus) {
 		perf_pmu__delete(&hwm->pmu);
 		return NULL;
-- 
2.51.2.1041.gc1ab5b90ca-goog


