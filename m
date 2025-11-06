Return-Path: <linux-kernel+bounces-887913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 399FEC395BB
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 08:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6F6074FADCB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 07:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29012DF138;
	Thu,  6 Nov 2025 07:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tm1g0zS3"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817E02DD60F
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 07:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762413169; cv=none; b=p8mjOgEqJPIKBH7RcgltdtTWqlvHlLFd5I+KB0li/oNBX+GNpc0ihbmgCwJjeEB7tpJ4q0T2kHm3+VF5WBGy6A9WUwf7NO7Q0qYPfHqYtsA2a5yGA7wcFZSTgV54UXLntiWit/u3mLZRgkBx1xCJ5tzkmJptiGisC7PRrLMpOVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762413169; c=relaxed/simple;
	bh=0G/j/xJj1qsweoCKMUXKGFzeFo7TvQZ/7fH1qwVBjpI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=XYXvXiQQTnlaTpq7P6ELlvpATDWGLJap+RebkdzVaLDRsElDb+OkpFl7bjjkq76EjIFpZHe6b6SLv+Xqo6lj2SB51P4giMKbVu0KZXknRHOWzBxczmXd4xX4rHJL2ezwRrW8xbWzg+PkpBH57ZVJx/or/F5PIVw17oK3VvNPGik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tm1g0zS3; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-77f610f7325so641887b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 23:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762413168; x=1763017968; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BwL0flbR67e6mq7ibhkhVdiS0tjPyP1QzI5zBDpL9cA=;
        b=Tm1g0zS3kyL9KV4nrXb9qiUakT+Exbff+YXf6KWQMCKxHDu3nzVQwt3CVW5U8ux7EQ
         PlQM9nfZaR7Ljrga0Dj0fC/Y6ISV5HOkjJKrvsuc+etoBT2g4g7c/SvfJKrP5/fDOnJ6
         7DR69nguqOtWzF3LxLDvFBOMUX7TKFg20zt3aRVrp0hd3Ar9soP58FPVqj+urRYdnPxQ
         1oszwmJzKg+KS7NCLlap4niMQZf4QM9LjRD/UUrlfW+AJKzUX0STfO1P649Z5y5WMGJm
         T8+MS7Dv1RpV5QRCalZjReNxNYsrD+yZnTs/72cplJG/qYdxq8oDT4AnzWW/Z3jUZ/7Z
         Orew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762413168; x=1763017968;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BwL0flbR67e6mq7ibhkhVdiS0tjPyP1QzI5zBDpL9cA=;
        b=guiMgX5ZTTCJJXC1AGDfeCAFmwRzZMx+j2A4ItUr8oHTqEE1yrqQwwm7F2GQ+8xE0K
         oUVlag4q64UPVXCBIuRyWdq0tbhR9PiqKzEozVsRxy5JbOmWhu6t9q0phRAWiXikYIYQ
         TFKLG7xIahcvHUzI2uVxGJaBq4y04cdJbJTZZ4Z5Q4Hvmi2riuPEyjL1F9gtuYp5LpmR
         EFHstL8q5G7+puG8ynxNjDDP2G9FIoyAqKjMPGAFtSUkbKmcH/F661hzSOMc17DY+U4w
         Mvt+o/+t+f4r+AhuCDlolrWfftorRdUydjXS6uOO0joZWetnUN0RIfbjCjL25oyhPFDb
         DAww==
X-Forwarded-Encrypted: i=1; AJvYcCXVmmdwWtT6jOxrFluFKZhOBc3EoEV5RHcnWX8LaRpkYBZOP5KqK6gH8kcQ+mTx9yIdKE8AhPuR5XbmYuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEG9eg7oMnVUO2RQkJXm9V+tkMmx4+NyU4fP6YpcuraKPRexpo
	KVYb4D2UtnUyucnF1a7SNzDFhGa7+FkTV/hGJyoZGom7xt6ajpx6l629qh5T4ityOeE/NrLYIy8
	6RmvVJudlog==
X-Google-Smtp-Source: AGHT+IHBw9KDApkRxNKNSSYbt0DxZex8yR8CkX8/EVYPoFywpOURlzyyxkxht7ZP44EnoM+9po/KDk//aDb0
X-Received: from dlbrl28.prod.google.com ([2002:a05:7022:f51c:b0:119:78ff:fe15])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:5491:b0:340:cc06:94ee
 with SMTP id adf61e73a8af0-34f86e13de7mr7541851637.60.1762413167626; Wed, 05
 Nov 2025 23:12:47 -0800 (PST)
Date: Wed,  5 Nov 2025 23:12:32 -0800
In-Reply-To: <20251106071241.141234-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251106071241.141234-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251106071241.141234-2-irogers@google.com>
Subject: [PATCH v3 1/9] libperf cpumap: Reduce allocations and sorting in intersect
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

On hybrid platforms the CPU maps are often disjoint. Rather than copy
CPUs and trim, compute the number of common CPUs, if none early exit,
otherwise copy in an sorted order. This avoids memory allocation in
the disjoint case and avoids a second malloc and useless sort in the
previous trim cases.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/cpumap.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
index b20a5280f2b3..7e88417ba84d 100644
--- a/tools/lib/perf/cpumap.c
+++ b/tools/lib/perf/cpumap.c
@@ -453,21 +453,33 @@ int perf_cpu_map__merge(struct perf_cpu_map **orig, struct perf_cpu_map *other)
 struct perf_cpu_map *perf_cpu_map__intersect(struct perf_cpu_map *orig,
 					     struct perf_cpu_map *other)
 {
-	struct perf_cpu *tmp_cpus;
-	int tmp_len;
 	int i, j, k;
-	struct perf_cpu_map *merged = NULL;
+	struct perf_cpu_map *merged;
 
 	if (perf_cpu_map__is_subset(other, orig))
 		return perf_cpu_map__get(orig);
 	if (perf_cpu_map__is_subset(orig, other))
 		return perf_cpu_map__get(other);
 
-	tmp_len = max(__perf_cpu_map__nr(orig), __perf_cpu_map__nr(other));
-	tmp_cpus = malloc(tmp_len * sizeof(struct perf_cpu));
-	if (!tmp_cpus)
+	i = j = k = 0;
+	while (i < __perf_cpu_map__nr(orig) && j < __perf_cpu_map__nr(other)) {
+		if (__perf_cpu_map__cpu(orig, i).cpu < __perf_cpu_map__cpu(other, j).cpu)
+			i++;
+		else if (__perf_cpu_map__cpu(orig, i).cpu > __perf_cpu_map__cpu(other, j).cpu)
+			j++;
+		else { /* CPUs match. */
+			i++;
+			j++;
+			k++;
+		}
+	}
+	if (k == 0) /* Maps are completely disjoint. */
 		return NULL;
 
+	merged = perf_cpu_map__alloc(k);
+	if (!merged)
+		return NULL;
+	/* Entries are added to merged in sorted order, so no need to sort again. */
 	i = j = k = 0;
 	while (i < __perf_cpu_map__nr(orig) && j < __perf_cpu_map__nr(other)) {
 		if (__perf_cpu_map__cpu(orig, i).cpu < __perf_cpu_map__cpu(other, j).cpu)
@@ -476,11 +488,8 @@ struct perf_cpu_map *perf_cpu_map__intersect(struct perf_cpu_map *orig,
 			j++;
 		else {
 			j++;
-			tmp_cpus[k++] = __perf_cpu_map__cpu(orig, i++);
+			RC_CHK_ACCESS(merged)->map[k++] = __perf_cpu_map__cpu(orig, i++);
 		}
 	}
-	if (k)
-		merged = cpu_map__trim_new(k, tmp_cpus);
-	free(tmp_cpus);
 	return merged;
 }
-- 
2.51.2.1041.gc1ab5b90ca-goog


