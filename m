Return-Path: <linux-kernel+bounces-799917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2F2B43151
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 770147B47BD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8C6259CBD;
	Thu,  4 Sep 2025 04:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cbqsjezq"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE119238C10
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 04:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756961233; cv=none; b=qAtCn0xZj5FoojyV+FmhgCy80rUjBRVjIA3ngGkefn2VVBzAxCPW2ZITYUhiMU2IxiUnmPBWSiPUNabNGwmxpw3CEk74yMq2j8AYdswT6BED3Uqw99/JadgzXgwyjO/CRZqEE3ufJtzHrM2/LXVAU2xypmZhLCSKSsAG0GNsweE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756961233; c=relaxed/simple;
	bh=hKncWC1+jOuJpYM18phIZ2V0cd6uiJueX7lFB7eDbNI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=QlOHx1ldkgAs4A2oYztI6dvvLmXP/BPeMBAT8VFBq8ttRz7+N5YOvHy2OT444KBxss+mzI+a4D4FbEn08sgFOHXfIrTd4Gm1fi0Jf0DCa6LIuZJTScyLTPXKh/SMOzjhEU5Yl5RlS8hR48TEjZ0Yz+/MrunI/FNveNHthzdxJUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cbqsjezq; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7724688833bso664110b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 21:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756961231; x=1757566031; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bpXSfxqJuF7aaOwysDVqZNPh4NQdI3HR21+/0eUXRKQ=;
        b=cbqsjezqxz5pxZcOWk9gpoPI5X6Ggu3qe5NBAVVl/EWvhlYb58h4iQjr2ruwwREzM9
         m98z0WTSVSVZ92YiBPXyhf4+3DnSaSVuROk5TyhF0HT0DHUvlqAj9NSzZu/JgY8CskuU
         GuG51gnwiFJp/jMXZkfo/VtuGI9iH0/gZEw6rIn6h1v5lY0wPvDUO6TPD4zbYZYXuVFE
         fAw2ylxg38sFG44Pw+hq3L0tsq9lEjBBnYtUcOff7VimIsnHS0y4PK9V3LKzKcg5TKPs
         l1LDvIUdGwCWGDJNhSWCid3J2ATOI9gQcdW83f0DAuIfgyF4yehmSNRNRbcJSz9bbbzS
         G1FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756961231; x=1757566031;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bpXSfxqJuF7aaOwysDVqZNPh4NQdI3HR21+/0eUXRKQ=;
        b=QesL6VJ2p3KBTTi2iXGmSNg3V7YBF984CcD5prhl3uOvTxxPRtcm9bGzNxkrX2D0o1
         /aooY1bQayrypIH6K8a1sZ2qf6tt2zLs8NlZPb4rh32vg+uRw3/yNVpud4ydw2Ss0LIn
         fTuApMFlIyiFV6MKygcyTcPVPSDrzMP5+PX6pZP2NXBfsVOFrFpzirrcpYb7wSTgwuys
         xkUoJsLKpcZ7640qxoSVgnGN4KB4ejvvyH2fRk5y74ozEI9isoLVwJnJ5gYL8QOYtYSN
         Tv8tUw+iSCbuRpLEg0WlgFn5k6wMAlZFddG+o62EeyQocscKkWvEvVYvfD4gfu0OeyfI
         o1bQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYSzdaVDloiQlTeMOUjvU/DiYXojb17Cw6AlV93KMvd/n2qply298+fl/SP8NUUptrdQNmn1CvkS4ahgg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdgmhtocc+5FWAEK0tco8T0Q8tnBDqv+0nJJgaFGcz//LVkmNT
	902zMJNbv8pSV6Uz37KGyaMsWmUQsjMZ8lZWQ4DjklXoWgll8aSBIiM/xdN3eKmoA2gy6kCHqT+
	RlwEvTAQ94Q==
X-Google-Smtp-Source: AGHT+IE3WF8uKyH/i78+XWYnMrtoROSsHBvKnIJOoUSzDL3290slXmHj3n1sXU953SKxKOItieAgnNlY7Mfe
X-Received: from pjbpq12.prod.google.com ([2002:a17:90b:3d8c:b0:327:be52:966d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:734a:b0:243:afbb:c9ee
 with SMTP id adf61e73a8af0-243d6dce669mr27385305637.7.1756961230725; Wed, 03
 Sep 2025 21:47:10 -0700 (PDT)
Date: Wed,  3 Sep 2025 21:46:38 -0700
In-Reply-To: <20250904044653.1002362-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904044653.1002362-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904044653.1002362-8-irogers@google.com>
Subject: [PATCH v6 07/22] perf jevents: Add br metric group for branch
 statistics on Intel
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

The br metric group for branches itself comprises metric groups for
total, taken, conditional, fused and far metric groups using json
events. Conditional taken and not taken metrics are specific to
Icelake and later generations, so the presence of the event is used to
determine whether the metric should exist.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 138 +++++++++++++++++++++++++
 1 file changed, 138 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 6d29d9ff0a48..dfee782596e8 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -124,6 +124,143 @@ def Tsx() -> Optional[MetricGroup]:
   ], description="Breakdown of transactional memory statistics")
 
 
+def IntelBr():
+  ins = Event("instructions")
+
+  def Total() -> MetricGroup:
+    br_all = Event ("BR_INST_RETIRED.ALL_BRANCHES", "BR_INST_RETIRED.ANY")
+    br_m_all = Event("BR_MISP_RETIRED.ALL_BRANCHES",
+                     "BR_INST_RETIRED.MISPRED",
+                     "BR_MISP_EXEC.ANY")
+    br_clr = None
+    try:
+      br_clr = Event("BACLEARS.ANY", "BACLEARS.ALL")
+    except:
+      pass
+
+    br_r = d_ratio(br_all, interval_sec)
+    ins_r = d_ratio(ins, br_all)
+    misp_r = d_ratio(br_m_all, br_all)
+    clr_r = d_ratio(br_clr, interval_sec) if br_clr else None
+
+    return MetricGroup("lpm_br_total", [
+        Metric("lpm_br_total_retired",
+               "The number of branch instructions retired per second.", br_r,
+               "insn/s"),
+        Metric(
+            "lpm_br_total_mispred",
+            "The number of branch instructions retired, of any type, that were "
+            "not correctly predicted as a percentage of all branch instrucions.",
+            misp_r, "100%"),
+        Metric("lpm_br_total_insn_between_branches",
+               "The number of instructions divided by the number of branches.",
+               ins_r, "insn"),
+        Metric("lpm_br_total_insn_fe_resteers",
+               "The number of resync branches per second.", clr_r, "req/s"
+               ) if clr_r else None
+    ])
+
+  def Taken() -> MetricGroup:
+    br_all = Event("BR_INST_RETIRED.ALL_BRANCHES", "BR_INST_RETIRED.ANY")
+    br_m_tk = None
+    try:
+      br_m_tk = Event("BR_MISP_RETIRED.NEAR_TAKEN",
+                      "BR_MISP_RETIRED.TAKEN_JCC",
+                      "BR_INST_RETIRED.MISPRED_TAKEN")
+    except:
+      pass
+    br_r = d_ratio(br_all, interval_sec)
+    ins_r = d_ratio(ins, br_all)
+    misp_r = d_ratio(br_m_tk, br_all) if br_m_tk else None
+    return MetricGroup("lpm_br_taken", [
+        Metric("lpm_br_taken_retired",
+               "The number of taken branches that were retired per second.",
+               br_r, "insn/s"),
+        Metric(
+            "lpm_br_taken_mispred",
+            "The number of retired taken branch instructions that were "
+            "mispredicted as a percentage of all taken branches.", misp_r,
+            "100%") if misp_r else None,
+        Metric(
+            "lpm_br_taken_insn_between_branches",
+            "The number of instructions divided by the number of taken branches.",
+            ins_r, "insn"),
+    ])
+
+  def Conditional() -> Optional[MetricGroup]:
+    try:
+      br_cond = Event("BR_INST_RETIRED.COND",
+                      "BR_INST_RETIRED.CONDITIONAL",
+                      "BR_INST_RETIRED.TAKEN_JCC")
+      br_m_cond = Event("BR_MISP_RETIRED.COND",
+                        "BR_MISP_RETIRED.CONDITIONAL",
+                        "BR_MISP_RETIRED.TAKEN_JCC")
+    except:
+      return None
+
+    br_cond_nt = None
+    br_m_cond_nt = None
+    try:
+      br_cond_nt = Event("BR_INST_RETIRED.COND_NTAKEN")
+      br_m_cond_nt = Event("BR_MISP_RETIRED.COND_NTAKEN")
+    except:
+      pass
+    br_r = d_ratio(br_cond, interval_sec)
+    ins_r = d_ratio(ins, br_cond)
+    misp_r = d_ratio(br_m_cond, br_cond)
+    taken_metrics = [
+        Metric("lpm_br_cond_retired", "Retired conditional branch instructions.",
+               br_r, "insn/s"),
+        Metric("lpm_br_cond_insn_between_branches",
+               "The number of instructions divided by the number of conditional "
+               "branches.", ins_r, "insn"),
+        Metric("lpm_br_cond_mispred",
+               "Retired conditional branch instructions mispredicted as a "
+               "percentage of all conditional branches.", misp_r, "100%"),
+    ]
+    if not br_m_cond_nt:
+      return MetricGroup("lpm_br_cond", taken_metrics)
+
+    br_r = d_ratio(br_cond_nt, interval_sec)
+    ins_r = d_ratio(ins, br_cond_nt)
+    misp_r = d_ratio(br_m_cond_nt, br_cond_nt)
+
+    not_taken_metrics = [
+        Metric("lpm_br_cond_retired", "Retired conditional not taken branch instructions.",
+               br_r, "insn/s"),
+        Metric("lpm_br_cond_insn_between_branches",
+               "The number of instructions divided by the number of not taken conditional "
+               "branches.", ins_r, "insn"),
+        Metric("lpm_br_cond_mispred",
+               "Retired not taken conditional branch instructions mispredicted as a "
+               "percentage of all not taken conditional branches.", misp_r, "100%"),
+    ]
+    return MetricGroup("lpm_br_cond", [
+        MetricGroup("lpm_br_cond_nt", not_taken_metrics),
+        MetricGroup("lpm_br_cond_tkn", taken_metrics),
+    ])
+
+  def Far() -> Optional[MetricGroup]:
+    try:
+      br_far = Event("BR_INST_RETIRED.FAR_BRANCH")
+    except:
+      return None
+
+    br_r = d_ratio(br_far, interval_sec)
+    ins_r = d_ratio(ins, br_far)
+    return MetricGroup("lpm_br_far", [
+        Metric("lpm_br_far_retired", "Retired far control transfers per second.",
+               br_r, "insn/s"),
+        Metric(
+            "lpm_br_far_insn_between_branches",
+            "The number of instructions divided by the number of far branches.",
+            ins_r, "insn"),
+    ])
+
+  return MetricGroup("lpm_br", [Total(), Taken(), Conditional(), Far()],
+                     description="breakdown of retired branch instructions")
+
+
 def main() -> None:
   global _args
 
@@ -151,6 +288,7 @@ def main() -> None:
       Rapl(),
       Smi(),
       Tsx(),
+      IntelBr(),
   ])
 
 
-- 
2.51.0.338.gd7d06c2dae-goog


