Return-Path: <linux-kernel+bounces-791111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8F5B3B213
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 06:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5203B56114E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 04:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B6A235C1E;
	Fri, 29 Aug 2025 04:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i9GSKTtM"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C526225D546
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 04:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756440730; cv=none; b=sD4LZvJtwxf4IfxejFFw8XuRZja7sq0hf3txVj6UvyenBXeyuApv5brRp8tWLFFEW2UtZfDz91cQ9ZNvYfQ/O8Rac0IfnXOeXzhhxEnQ9CgMx5xzmJ44t1xOByhMrbVkpd3zJMTO3tI9GpPMDBWlSfIsH4dDacVdoh7Og2rkCmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756440730; c=relaxed/simple;
	bh=xIhJxu1okP+jiRU9C+WmdMmdDqHNc9R7YxUxYrfj3SM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=TmtnmLX27YZu3Bz+jsVP2FqpC++RR+9SnbqLpQr97NOH+ziOGUKx/8McRXYTTFnZkun4FnZmqSMaE2TCqBHvIA6kSPnB3kkqy4gjxRKkaCJ1/I/nkeqryMyKkfEmyyAwtKq9E7gJRGESVDVWGdAJTwolixUKjjW1irIIRL27ClI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i9GSKTtM; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-327ceb05e9dso909192a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 21:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756440728; x=1757045528; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1A7jpEsvPE0kUPbvgwyciQy7SJ0zGAJFAhGVF7g/pGo=;
        b=i9GSKTtMBEjeZKqVarxWBZCawiQOvx+4KAnLxJbZYQj1Igcyg0ZwEoeiLsgCygSxDy
         UsWcvIq1SwBdo1WAp40TYFQHBbiBqaUzJT2cdcneGpyuy7UIf5cjzWkQd6oSV70HJ7Qd
         UGQbyMlCEMWGPVkQg5lDUDCQhf7CFH5JLZeGmbAJxC1u/27KaFqxMJWsUwhm2kdknA8q
         lQLL+oFlqF8IQ+8pwiRXqJW8ARzck+Jdsi+gibKKKItJA6gW7QsC7ATlb7eGVGscntTl
         //YALD5rR50Q1Q1IdGd5S4MXd1cWU8KpUR361aNlgyCG/F5j/vZMysOGAKlqiOiL15bQ
         3uCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756440728; x=1757045528;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1A7jpEsvPE0kUPbvgwyciQy7SJ0zGAJFAhGVF7g/pGo=;
        b=I6le9F9uaAy4TbWqUc1f6vDl/i75kNxaD/F0lLR5uZ3q9U2XVNjbFcCVHHkzI6Q5qr
         GMhOl2X1ZZZEOuGiU1NxgGQcf5beDp2PKewz0/HpP/sfpDfVOm1WHVMvaoIaXT+a7UZB
         sP3HwBcKU/JSGMv56wUxlspkfJSeCpUxCbdQuVJllsq/FhHRogkWEEZn66enSaMOgjtP
         kOwH61ElHx5VbAOFpvo82CMShjssDQ/spb+p8YS2XEuy43XvW2pEESYCYf/CDcq2ni6d
         6cefurkJwPYzeemwAUVA9N1/PkAUwKYglaOX9lp5vPZrfmY2KsGzrlCWk9l8Gy0cBTv+
         g+cw==
X-Forwarded-Encrypted: i=1; AJvYcCU/o0nZIxP+1yYIVuKCn/euiJGQxmqwRnwrqXyF5mlE+hj8jfgm0bVeNf+ecAKmy/N1KXCj7bnLA/SmSCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDIB//7rhImbfDVcXtSjQ9jJw4RVB0pT/hGM0jK2KC3GwCdhIJ
	JbZ4fm80kY049CKCfBe89AvwmhLw/GCyUzBz+COSBY+6yJ7WFHTkVQqnGnn9Rw6aK1XeBzB4fM+
	4PoqFS7YFFg==
X-Google-Smtp-Source: AGHT+IEzLLnWtYKPlJDbm1c/YIWiALK7KVZJf/m9NNUyDV1q+iWH89NyCUe7GtxofPmfCB1d/dyAXN7CEpXm
X-Received: from pjh15.prod.google.com ([2002:a17:90b:3f8f:b0:327:d54a:8c93])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3848:b0:327:e21c:dd6
 with SMTP id 98e67ed59e1d1-327e21c0e50mr2232836a91.23.1756440728087; Thu, 28
 Aug 2025 21:12:08 -0700 (PDT)
Date: Thu, 28 Aug 2025 21:11:02 -0700
In-Reply-To: <20250829041104.4186320-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829041104.4186320-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829041104.4186320-22-irogers@google.com>
Subject: [PATCH v5 21/22] perf jevents: Add upi_bw metric for Intel
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, John Garry <john.g.garry@oracle.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Sandipan Das <sandipan.das@amd.com>, 
	Benjamin Gray <bgray@linux.ibm.com>, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>
Content-Type: text/plain; charset="UTF-8"

Break down UPI read and write bandwidth using uncore_upi counters.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index ea7749d34081..19c7357c496a 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -1009,6 +1009,27 @@ def UncoreMemBw() -> Optional[MetricGroup]:
   ], description = "Memory Bandwidth")
 
 
+def UncoreUpiBw() -> Optional[MetricGroup]:
+  try:
+    upi_rds = Event("UNC_UPI_RxL_FLITS.ALL_DATA")
+    upi_wrs = Event("UNC_UPI_TxL_FLITS.ALL_DATA")
+  except:
+    return None
+
+  upi_total = upi_rds + upi_wrs
+
+  # From "Uncore Performance Monitoring": When measuring the amount of
+  # bandwidth consumed by transmission of the data (i.e. NOT including
+  # the header), it should be .ALL_DATA / 9 * 64B.
+  scale = (64 / 9) / 1_000_000
+  return MetricGroup("lpm_upi_bw", [
+      Metric("lpm_upi_bw_read", "UPI read bandwidth",
+             d_ratio(upi_rds, interval_sec), f"{scale}MB/s"),
+      Metric("lpm_upi_bw_write", "DDR memory write bandwidth",
+             d_ratio(upi_wrs, interval_sec), f"{scale}MB/s"),
+  ], description = "UPI Bandwidth")
+
+
 def main() -> None:
   global _args
 
@@ -1050,6 +1071,7 @@ def main() -> None:
       UncoreDir(),
       UncoreMem(),
       UncoreMemBw(),
+      UncoreUpiBw(),
   ])
 
 
-- 
2.51.0.318.gd7df087d1a-goog


