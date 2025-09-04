Return-Path: <linux-kernel+bounces-799902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B02BB4313E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 023CF1C20909
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B1323ABA8;
	Thu,  4 Sep 2025 04:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U6h6HtC9"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408772580F0
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 04:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756960870; cv=none; b=Lp9RA5aJ4wv6CcfweN6z2t3333NwlRuHfcmmt/q5+NyVD6Xk+EJnTOqs/k5K0asJGiYDvz8nbwMQe4Op2vYup7hL7rHI1Ub2BvMRmV/vtPplybrCw0RcoGPO6R5UaBzqUurWH9TqX7Ikfg+1YhZHeG3LHKMGkf89z189H/4EJ8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756960870; c=relaxed/simple;
	bh=EoT3DnS8xk0FTU0lUCJn0qCeTndblUw8A3qC7rrZwlk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=NTBv5zg800AhHcAw2r3NuI8I4sy7fAMYWzaS4/1Ja9C0715/rVwFu55PKstCeWqVZhiIuD0vJ569RzdJISNxCC6VZBnJU9BgACJzIpqHqCB3VEgvoXAXU4BzPeFeLeicBI7Ef/Y+UiHmNc3JXaBtFJ3s+UHXGSH8P+cOuNqZkhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U6h6HtC9; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76e2eb787f2so642438b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 21:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756960868; x=1757565668; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tz+VhCX6fUm7hjcLcGzVXEbYIcfKNGtlnzpXylk1Bus=;
        b=U6h6HtC9iLG7wdM1Lm2G9eReOj7WS3v+KvZPknsznfFycWeqUezigcT9I7LyX0h1uN
         hk6x6efzENI2A80drpYXpVlN6Sjw9PNHDMRKZPxZ5kjuWUGtRVdqT3RkMPDnfYHl3+Ah
         1EhtX9KyOKZyuVlxVfs3okfSMGsM6j4htBE7zyk34/aSzFtF0cxtV1rvCW9B9VxkFfg8
         ihJZ5EV14QRS5I2Ztosg03hVifOlBA7wFHlRiQYUS7t+grpC16WVLKhk9wWMHXBTV4VE
         6/KXljNmwf1NAg/yfJ1oq3Wi7LmhU/C4ggvcN2rbW1KBVG7oWhForsWirzOkEExU2l1k
         CMzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756960868; x=1757565668;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tz+VhCX6fUm7hjcLcGzVXEbYIcfKNGtlnzpXylk1Bus=;
        b=L0qBkfAJ1FP2bvIwNh8qMtczcyAcyQ4mX3mAHa1AB4E7XTGivs3FU+loMsez+vh5YA
         tR7HGHvk8IFZgvixUfdqopRGsq0y7JP2e9Rh7165ZL6QqUluWJLLHY8iMaz8qcnuEfGm
         xn1vggyyJN0EeEUTehBv8sqN6Y50ihtWgr9vH0bT7r7LLF40SvX3zLQSwKJ9Db+x3pNB
         W1NKR++r2NdK9X2sfXKWPIFJ7lewQoZpTifhzzIXBIcb2/fS3lTr5miKex+v2CkzwAY9
         hB4gWQUm4SEJBx8dSNrPAkhFoiY8zM40YylGUopSj3Z2G73m0ODu93htB0C3dM5HLBiX
         KYjA==
X-Forwarded-Encrypted: i=1; AJvYcCV3lW/lL2xcsflM+8v1RkCQrjHnQUwNfBZofsgrTQ3AACLqiCflqXDobwTPP9cu4wF6g1vesRxC3TgnH5w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmv2KAH3MMgWS674q+R9wMXfUj+N5ynfJOYA8WRn2FfQkHESqg
	bMO6ObfaWhXWABX3sZ+XPkm4TBHCp8NPAsZUIKzofSJNRZm2w1tMQ6glSmoShakK4BZbP0/08eB
	zEtK76m7BvA==
X-Google-Smtp-Source: AGHT+IEc4a701ch6Mft+tNj4eq3v9cdY8rNLHi6NM6YlHs2+eTkQEeZV+busl0FKoYiYaBQtw5Ir/feC2F6W
X-Received: from pjuj5.prod.google.com ([2002:a17:90a:d005:b0:325:a8d:a485])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9183:b0:243:d209:cf86
 with SMTP id adf61e73a8af0-243d6f42004mr23416382637.42.1756960868523; Wed, 03
 Sep 2025 21:41:08 -0700 (PDT)
Date: Wed,  3 Sep 2025 21:40:42 -0700
In-Reply-To: <20250904044047.999031-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904044047.999031-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904044047.999031-9-irogers@google.com>
Subject: [PATCH v6 08/13] perf jevents: Add dtlb metric group for AMD
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
	Benjamin Gray <bgray@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

Add metrics that give an overview and details of the dtlb (zen1, zen2,
zen3).

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 109 +++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 40128903eb7d..c3f0f1439c01 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -120,6 +120,114 @@ def AmdBr():
                      description="breakdown of retired branch instructions")
 
 
+def AmdDtlb() -> Optional[MetricGroup]:
+  global _zen_model
+  if _zen_model >= 4:
+      return None
+
+  d_dat = Event("ls_dc_accesses") if _zen_model <= 3 else None
+  d_h4k = Event("ls_l1_d_tlb_miss.tlb_reload_4k_l2_hit")
+  d_hcoal = Event("ls_l1_d_tlb_miss.tlb_reload_coalesced_page_hit") if _zen_model >= 2 else 0
+  d_h2m = Event("ls_l1_d_tlb_miss.tlb_reload_2m_l2_hit")
+  d_h1g = Event("ls_l1_d_tlb_miss.tlb_reload_1g_l2_hit")
+
+  d_m4k = Event("ls_l1_d_tlb_miss.tlb_reload_4k_l2_miss")
+  d_mcoal = Event("ls_l1_d_tlb_miss.tlb_reload_coalesced_page_miss") if _zen_model >= 2 else 0
+  d_m2m = Event("ls_l1_d_tlb_miss.tlb_reload_2m_l2_miss")
+  d_m1g = Event("ls_l1_d_tlb_miss.tlb_reload_1g_l2_miss")
+
+  d_w0 = Event("ls_tablewalker.dc_type0") if _zen_model <= 3 else None
+  d_w1 = Event("ls_tablewalker.dc_type1") if _zen_model <= 3 else None
+  walks = d_w0 + d_w1
+  walks_r = d_ratio(walks, interval_sec)
+  ins_w = d_ratio(ins, walks)
+  l1 = d_dat
+  l1_r = d_ratio(l1, interval_sec)
+  l2_hits = d_h4k + d_hcoal + d_h2m + d_h1g
+  l2_miss = d_m4k + d_mcoal + d_m2m + d_m1g
+  l2_r = d_ratio(l2_hits + l2_miss, interval_sec)
+  l1_miss = l2_hits + l2_miss + walks
+  l1_hits = max(l1 - l1_miss, 0)
+  ins_l = d_ratio(ins, l1_miss)
+
+  return MetricGroup("lpm_dtlb", [
+      MetricGroup("lpm_dtlb_ov", [
+          Metric("lpm_dtlb_ov_insn_bt_l1_miss",
+                 "DTLB overview: instructions between l1 misses.", ins_l,
+                 "insns"),
+          Metric("lpm_dtlb_ov_insn_bt_walks",
+                 "DTLB overview: instructions between dtlb page table walks.",
+                 ins_w, "insns"),
+      ]),
+      MetricGroup("lpm_dtlb_l1", [
+          Metric("lpm_dtlb_l1_hits",
+                 "DTLB L1 hits as percentage of all DTLB L1 accesses.",
+                 d_ratio(l1_hits, l1), "100%"),
+          Metric("lpm_dtlb_l1_miss",
+                 "DTLB L1 misses as percentage of all DTLB L1 accesses.",
+                 d_ratio(l1_miss, l1), "100%"),
+          Metric("lpm_dtlb_l1_reqs", "DTLB L1 accesses per second.", l1_r,
+                 "insns/s"),
+      ]),
+      MetricGroup("lpm_dtlb_l2", [
+          Metric("lpm_dtlb_l2_hits",
+                 "DTLB L2 hits as percentage of all DTLB L2 accesses.",
+                 d_ratio(l2_hits, l2_hits + l2_miss), "100%"),
+          Metric("lpm_dtlb_l2_miss",
+                 "DTLB L2 misses as percentage of all DTLB L2 accesses.",
+                 d_ratio(l2_miss, l2_hits + l2_miss), "100%"),
+          Metric("lpm_dtlb_l2_reqs", "DTLB L2 accesses per second.", l2_r,
+                 "insns/s"),
+          MetricGroup("lpm_dtlb_l2_4kb", [
+              Metric(
+                  "lpm_dtlb_l2_4kb_hits",
+                  "DTLB L2 4kb page size hits as percentage of all DTLB L2 4kb "
+                  "accesses.", d_ratio(d_h4k, d_h4k + d_m4k), "100%"),
+              Metric(
+                  "lpm_dtlb_l2_4kb_miss",
+                  "DTLB L2 4kb page size misses as percentage of all DTLB L2 4kb"
+                  "accesses.", d_ratio(d_m4k, d_h4k + d_m4k), "100%")
+          ]),
+          MetricGroup("lpm_dtlb_l2_coalesced", [
+              Metric(
+                  "lpm_dtlb_l2_coal_hits",
+                  "DTLB L2 coalesced page (16kb) hits as percentage of all DTLB "
+                  "L2 coalesced accesses.", d_ratio(d_hcoal,
+                                                    d_hcoal + d_mcoal), "100%"),
+              Metric(
+                  "lpm_dtlb_l2_coal_miss",
+                  "DTLB L2 coalesced page (16kb) misses as percentage of all "
+                  "DTLB L2 coalesced accesses.",
+                  d_ratio(d_mcoal, d_hcoal + d_mcoal), "100%")
+          ]),
+          MetricGroup("lpm_dtlb_l2_2mb", [
+              Metric(
+                  "lpm_dtlb_l2_2mb_hits",
+                  "DTLB L2 2mb page size hits as percentage of all DTLB L2 2mb "
+                  "accesses.", d_ratio(d_h2m, d_h2m + d_m2m), "100%"),
+              Metric(
+                  "lpm_dtlb_l2_2mb_miss",
+                  "DTLB L2 2mb page size misses as percentage of all DTLB L2 "
+                  "accesses.", d_ratio(d_m2m, d_h2m + d_m2m), "100%")
+          ]),
+          MetricGroup("lpm_dtlb_l2_1g", [
+              Metric(
+                  "lpm_dtlb_l2_1g_hits",
+                  "DTLB L2 1gb page size hits as percentage of all DTLB L2 1gb "
+                  "accesses.", d_ratio(d_h1g, d_h1g + d_m1g), "100%"),
+              Metric(
+                  "lpm_dtlb_l2_1g_miss",
+                  "DTLB L2 1gb page size misses as percentage of all DTLB L2 "
+                  "1gb accesses.", d_ratio(d_m1g, d_h1g + d_m1g), "100%")
+          ]),
+      ]),
+      MetricGroup("lpm_dtlb_walks", [
+          Metric("lpm_dtlb_walks_reqs", "DTLB page table walks per second.",
+                 walks_r, "walks/s"),
+      ]),
+  ], description="Data TLB metrics")
+
+
 def AmdItlb():
   global _zen_model
   l2h = Event("bp_l1_tlb_miss_l2_tlb_hit", "bp_l1_tlb_miss_l2_hit")
@@ -386,6 +494,7 @@ def main() -> None:
 
   all_metrics = MetricGroup("", [
       AmdBr(),
+      AmdDtlb(),
       AmdItlb(),
       AmdHwpf(),
       AmdSwpf(),
-- 
2.51.0.338.gd7d06c2dae-goog


