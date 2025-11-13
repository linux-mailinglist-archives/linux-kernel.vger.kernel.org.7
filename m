Return-Path: <linux-kernel+bounces-898595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 474CBC55909
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 04:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0FB4B4EBEFC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 03:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438D131E0F7;
	Thu, 13 Nov 2025 03:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z4R/pcSW"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CBC31D749
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 03:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763004147; cv=none; b=AO6DyePmTGd0ffcJOiQx2+iY2fscliR8mjreBlsaILUcQ4IbTjvTm0NWoDH5axwNwSU35uKe+LtSbETTUNt9uDveU7tvUXSgiExmxj7hboaIugBFbDMafV835l+vnufulzLDdc4acAeuhcNfPkCHro9iJAthlDIqtlX+7g8BGTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763004147; c=relaxed/simple;
	bh=Cgrn5s9K+hOhdC3Kkof0GurfCoyskQbob4D8Z7OGfPI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=uJiorZIE32WK2ddgL+v+Moa6T811Ye6jdAFlpu9gA6lEWcoB/mpdDZyY5mWcGCsX8BHumGzExZ39yomhOfnJCG1kcymwe3awOaQbD2ajYnM8969vQy75bBNvBLIRq9c5G1jTWqoSSVvE9PT+FySLQ5NGbHZyZ5LtmE9zSxOoYZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z4R/pcSW; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-297f587dc2eso4397205ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 19:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763004146; x=1763608946; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IHh9aOjep5ch3f1bENK/wIAmZh80xO2AoWISVhbZGbs=;
        b=z4R/pcSWzswSLaP0yycA6hkLdo6Ml5KsnjXKQdyGWn2Hfb68o52sGnWNIG4awEIg56
         J2WSWHU/3xTAyiVdOZRA6WYsV92w7ED57U10/POT+Q8/tOPozs2XmAoCOzSqth+Yao/B
         nwzCsVn74EEWYrLA2JbL2bUmricMzyemF3BNIfhFmMfphy/+E49QtQenxsjvcnfIqn2U
         HIEVVVifFS83MJqp3/hMjxuvenHy+2d+jHIdTd5agGQduArB+f9PxggDC47P3lxSIalW
         HtEw5JnMqmWraV8LC4+KQoRPZl2zH2D0dfyiUH5d9QcNT0JN5+Onm+OAuy8ngngV/aW0
         u5pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763004146; x=1763608946;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IHh9aOjep5ch3f1bENK/wIAmZh80xO2AoWISVhbZGbs=;
        b=jZLBmAuYB1FHTNLgPsRMzjjD9rE791x2NdyjNF6rhTMwIs6GvVZSFzbrv7XOh1080Q
         TUlNbcm/A+YRD6sdspQHzUPDS8pjx++OOkGiM5c0lhw81orgY2L8wOUOPg6ACK2Bky4o
         TjFY+LtXIk1kvgLmp0CrN7cfoczhPvRafIJNj1LF7OxAeo17D3zHYnuUr3lO6EzdLTmo
         w82JqTAl/v+vqWf1RTo7q2V7KbKC9l4CQ3WSDToo8wO/sLRMR2C82QAUgPek4ZWRRu2G
         FZTfDFITHl/AJL9Mobo3IuAuyuhHZYX3medv/aBx0nSdDMzlkv5SAXqHwhZ81jyXVP/B
         aZoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZYi2QTD86C2KX5zLakoRcDz7w0xREUaFZZRl+8V0r7jdqSWnb6QD0pUKYY9VheddAsSBlArq8G3/TZbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSWy4VMd7RGmFDW3rYFZcD5PVvbixoh0AEQVMgssqLaP3sa/NH
	YVWZPxa/6524mnYkgQo+ZIFEVwhdOYnmG2SdNxviR40b3roZgbhCmSCUv3tm17zz+UnEwNSZX3M
	PbLZaKT9UVQ==
X-Google-Smtp-Source: AGHT+IEteJFe2wj6/twulKdAFdi8lqJ8Hyr8xL8nUMpnOp47DYZOzTaZS9eX1v7Kg+BqzewYZ3Xj2icn6/1s
X-Received: from dlbvv8.prod.google.com ([2002:a05:7022:5f08:b0:11a:29e5:12df])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f712:b0:297:c0f0:42d7
 with SMTP id d9443c01a7336-2984edcb752mr71037525ad.41.1763004145593; Wed, 12
 Nov 2025 19:22:25 -0800 (PST)
Date: Wed, 12 Nov 2025 19:20:36 -0800
In-Reply-To: <20251113032040.1994090-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113032040.1994090-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251113032040.1994090-49-irogers@google.com>
Subject: [PATCH v8 48/52] perf jevents: Add upi_bw metric for Intel
From: Ian Rogers <irogers@google.com>
To: Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Benjamin Gray <bgray@linux.ibm.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>, 
	James Clark <james.clark@linaro.org>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	Jiri Olsa <jolsa@kernel.org>, John Garry <john.g.garry@oracle.com>, Leo Yan <leo.yan@arm.com>, 
	Namhyung Kim <namhyung@kernel.org>, Perry Taylor <perry.taylor@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Samantha Alt <samantha.alt@intel.com>, 
	Sandipan Das <sandipan.das@amd.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Break down UPI read and write bandwidth using uncore_upi counters.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 037f9b2ea1b6..f6bb691dc5bb 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -1033,6 +1033,27 @@ def UncoreMemBw() -> Optional[MetricGroup]:
     ], description="Memory Bandwidth")
 
 
+def UncoreUpiBw() -> Optional[MetricGroup]:
+    try:
+        upi_rds = Event("UNC_UPI_RxL_FLITS.ALL_DATA")
+        upi_wrs = Event("UNC_UPI_TxL_FLITS.ALL_DATA")
+    except:
+        return None
+
+    upi_total = upi_rds + upi_wrs
+
+    # From "Uncore Performance Monitoring": When measuring the amount of
+    # bandwidth consumed by transmission of the data (i.e. NOT including
+    # the header), it should be .ALL_DATA / 9 * 64B.
+    scale = (64 / 9) / 1_000_000
+    return MetricGroup("lpm_upi_bw", [
+        Metric("lpm_upi_bw_read", "UPI read bandwidth",
+               d_ratio(upi_rds, interval_sec), f"{scale}MB/s"),
+        Metric("lpm_upi_bw_write", "DDR memory write bandwidth",
+               d_ratio(upi_wrs, interval_sec), f"{scale}MB/s"),
+    ], description="UPI Bandwidth")
+
+
 def main() -> None:
     global _args
 
@@ -1076,6 +1097,7 @@ def main() -> None:
         UncoreDir(),
         UncoreMem(),
         UncoreMemBw(),
+        UncoreUpiBw(),
     ])
 
     if _args.metricgroups:
-- 
2.51.2.1041.gc1ab5b90ca-goog


