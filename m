Return-Path: <linux-kernel+bounces-898581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5685C558A6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 04:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DCEF3A6102
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 03:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F233161A7;
	Thu, 13 Nov 2025 03:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xn2uJ1xW"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B00315D46
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 03:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763004121; cv=none; b=V/iTi2XAwKBHe3JXCyBgoWcoZjb3ZgtJZKBkCCgZ62LDRRhQwBhC+VcL1s3ciudw+Jzb9CYFKycO1fJXo2FiUaXclh2qNHLbg5r7IXE5ZS9KOFJvISyZKYeVV4Qnrk3ZULa8rmTYQrNZfn5uQfjcs2rPDJxw6J7tf+GFLEUDfEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763004121; c=relaxed/simple;
	bh=oxIzzYTLoJauQ3Xfy3u0Yfn2TVadLlHIWXTHB0uMPH8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=GR7PkVn0gPqWLyk1Wf7L+0ycjdQLHIGN/HCqTGtuZS9dJ13xCVW2z/dv8ijcYlRBLp1Jd9Qx5Tjsr2MScGQtrdG5Nm/6mtXDWNoIBeLtnwLNLKM1h68b3e2e1KbtcAX5zEMCtJOyv+ZScCgu2dAwJms8P+s7a2TWr8vm6xVBkHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xn2uJ1xW; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b57cf8dba28so373654a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 19:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763004119; x=1763608919; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TNA1vFEiDV2r0dzVcpCQuiLoeBw9oTVXKzmfAq51nag=;
        b=xn2uJ1xWPZwW9yPtPcigDyJUOIcRDcsGMbfFTXV+rEVVnJlN9A1u2D5nx2hHYOTBFt
         shvTr8XTbw3IDp4NwqwPK9mVDWrhY0B+C5zw03rqgNEyBE/QhbDtcIAGsQwra6ccpgWN
         FTBfI7DzRFXbGdYm/gs87UOZZ/Gv4jBxN67K3/wtQfbmgNO+JmSh5ZgoHe6WEpWAAZli
         zt7Js48rxmoHs9empSrZcbY1Q4tdZJl3CSUwFjdvGBu0BghHGVXzrMRBS+3AksEDIKLa
         Q1O6eWLtdae1NfQpDyhBcTxv+n3MUjVVycwxRWO0UAGGSq/EKj/Y1FK5cCI5AQhVKkwt
         EE0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763004119; x=1763608919;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TNA1vFEiDV2r0dzVcpCQuiLoeBw9oTVXKzmfAq51nag=;
        b=CeF9389XBw/GZ3LRmJnJ2pzNdR0L0TDgqI+lxfO9rx4B2AbY1fx0rnklPF4KEw0sOg
         QaRcFCkJNuprUZd1YCDr+9M0D1eY08FCPUF+4BZqmckEMNa17bi17ZVSwpi8xPH+hCZ8
         b/K7ZeSeB8D1onIX8kpsGsnlp0ypoJGI77cOHIFB5NrOnH9YSb9ONthAaksrJqdpP1a7
         V/H2Uc0tsfGftB3cIt+7Q0jHJEzkZv+KOFV7DQEHHQEsMcpRLsXP9K9Ke35EnN/WAT0J
         UxhkD2CwUsVwhjoq7pX6fhRJ3p5kmOyZspOTj6n7gzf7Fdmk75tmUtJ3XLBp8F1Vf6ng
         Nbqg==
X-Forwarded-Encrypted: i=1; AJvYcCX88GjRfpw9BQUOpmbOCqcMpHHfXVJxIpCtxw3l+siP7acKncseQI40OI4mlXZCqv2R92kGBXdvOs3dSFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOQ4ry/ZXl6KYJYa3AntlYRYjqemQK/rxXmEGDkVDDHs2CGMbC
	U6SZPDpUEWLL16P1BxUThLi99ixSILp7Vc62/xWlQ9AShOo1klmANYYzPzrzRQNSUOEsj33mOPk
	WxkphYyU/hw==
X-Google-Smtp-Source: AGHT+IFItK+UMqSWwk08n2wB4bbD3Yy9Whvf44yRIG3rO6c84NBNTJJrCvl8to5qym/IguSvlWizqtGKchKl
X-Received: from pgbbm20.prod.google.com ([2002:a65:6e94:0:b0:ba6:5f4d:31b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7d8b:b0:350:31b3:218c
 with SMTP id adf61e73a8af0-359096951cfmr7194085637.19.1763004119265; Wed, 12
 Nov 2025 19:21:59 -0800 (PST)
Date: Wed, 12 Nov 2025 19:20:22 -0800
In-Reply-To: <20251113032040.1994090-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113032040.1994090-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251113032040.1994090-35-irogers@google.com>
Subject: [PATCH v8 34/52] perf jevents: Add br metric group for branch
 statistics on Intel
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
index 05f3d94ec5d5..e1944d821248 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -124,6 +124,143 @@ def Tsx() -> Optional[MetricGroup]:
     ], description="Breakdown of transactional memory statistics")
 
 
+def IntelBr():
+    ins = Event("instructions")
+
+    def Total() -> MetricGroup:
+        br_all = Event("BR_INST_RETIRED.ALL_BRANCHES", "BR_INST_RETIRED.ANY")
+        br_m_all = Event("BR_MISP_RETIRED.ALL_BRANCHES",
+                         "BR_INST_RETIRED.MISPRED",
+                         "BR_MISP_EXEC.ANY")
+        br_clr = None
+        try:
+            br_clr = Event("BACLEARS.ANY", "BACLEARS.ALL")
+        except:
+            pass
+
+        br_r = d_ratio(br_all, interval_sec)
+        ins_r = d_ratio(ins, br_all)
+        misp_r = d_ratio(br_m_all, br_all)
+        clr_r = d_ratio(br_clr, interval_sec) if br_clr else None
+
+        return MetricGroup("lpm_br_total", [
+            Metric("lpm_br_total_retired",
+                   "The number of branch instructions retired per second.", br_r,
+                   "insn/s"),
+            Metric(
+                "lpm_br_total_mispred",
+                "The number of branch instructions retired, of any type, that were "
+                "not correctly predicted as a percentage of all branch instrucions.",
+                misp_r, "100%"),
+            Metric("lpm_br_total_insn_between_branches",
+                   "The number of instructions divided by the number of branches.",
+                   ins_r, "insn"),
+            Metric("lpm_br_total_insn_fe_resteers",
+                   "The number of resync branches per second.", clr_r, "req/s"
+                   ) if clr_r else None
+        ])
+
+    def Taken() -> MetricGroup:
+        br_all = Event("BR_INST_RETIRED.ALL_BRANCHES", "BR_INST_RETIRED.ANY")
+        br_m_tk = None
+        try:
+            br_m_tk = Event("BR_MISP_RETIRED.NEAR_TAKEN",
+                            "BR_MISP_RETIRED.TAKEN_JCC",
+                            "BR_INST_RETIRED.MISPRED_TAKEN")
+        except:
+            pass
+        br_r = d_ratio(br_all, interval_sec)
+        ins_r = d_ratio(ins, br_all)
+        misp_r = d_ratio(br_m_tk, br_all) if br_m_tk else None
+        return MetricGroup("lpm_br_taken", [
+            Metric("lpm_br_taken_retired",
+                   "The number of taken branches that were retired per second.",
+                   br_r, "insn/s"),
+            Metric(
+                "lpm_br_taken_mispred",
+                "The number of retired taken branch instructions that were "
+                "mispredicted as a percentage of all taken branches.", misp_r,
+                "100%") if misp_r else None,
+            Metric(
+                "lpm_br_taken_insn_between_branches",
+                "The number of instructions divided by the number of taken branches.",
+                ins_r, "insn"),
+        ])
+
+    def Conditional() -> Optional[MetricGroup]:
+        try:
+            br_cond = Event("BR_INST_RETIRED.COND",
+                            "BR_INST_RETIRED.CONDITIONAL",
+                            "BR_INST_RETIRED.TAKEN_JCC")
+            br_m_cond = Event("BR_MISP_RETIRED.COND",
+                              "BR_MISP_RETIRED.CONDITIONAL",
+                              "BR_MISP_RETIRED.TAKEN_JCC")
+        except:
+            return None
+
+        br_cond_nt = None
+        br_m_cond_nt = None
+        try:
+            br_cond_nt = Event("BR_INST_RETIRED.COND_NTAKEN")
+            br_m_cond_nt = Event("BR_MISP_RETIRED.COND_NTAKEN")
+        except:
+            pass
+        br_r = d_ratio(br_cond, interval_sec)
+        ins_r = d_ratio(ins, br_cond)
+        misp_r = d_ratio(br_m_cond, br_cond)
+        taken_metrics = [
+            Metric("lpm_br_cond_retired", "Retired conditional branch instructions.",
+                   br_r, "insn/s"),
+            Metric("lpm_br_cond_insn_between_branches",
+                   "The number of instructions divided by the number of conditional "
+                   "branches.", ins_r, "insn"),
+            Metric("lpm_br_cond_mispred",
+                   "Retired conditional branch instructions mispredicted as a "
+                   "percentage of all conditional branches.", misp_r, "100%"),
+        ]
+        if not br_m_cond_nt:
+            return MetricGroup("lpm_br_cond", taken_metrics)
+
+        br_r = d_ratio(br_cond_nt, interval_sec)
+        ins_r = d_ratio(ins, br_cond_nt)
+        misp_r = d_ratio(br_m_cond_nt, br_cond_nt)
+
+        not_taken_metrics = [
+            Metric("lpm_br_cond_retired", "Retired conditional not taken branch instructions.",
+                   br_r, "insn/s"),
+            Metric("lpm_br_cond_insn_between_branches",
+                   "The number of instructions divided by the number of not taken conditional "
+                   "branches.", ins_r, "insn"),
+            Metric("lpm_br_cond_mispred",
+                   "Retired not taken conditional branch instructions mispredicted as a "
+                   "percentage of all not taken conditional branches.", misp_r, "100%"),
+        ]
+        return MetricGroup("lpm_br_cond", [
+            MetricGroup("lpm_br_cond_nt", not_taken_metrics),
+            MetricGroup("lpm_br_cond_tkn", taken_metrics),
+        ])
+
+    def Far() -> Optional[MetricGroup]:
+        try:
+            br_far = Event("BR_INST_RETIRED.FAR_BRANCH")
+        except:
+            return None
+
+        br_r = d_ratio(br_far, interval_sec)
+        ins_r = d_ratio(ins, br_far)
+        return MetricGroup("lpm_br_far", [
+            Metric("lpm_br_far_retired", "Retired far control transfers per second.",
+                   br_r, "insn/s"),
+            Metric(
+                "lpm_br_far_insn_between_branches",
+                "The number of instructions divided by the number of far branches.",
+                ins_r, "insn"),
+        ])
+
+    return MetricGroup("lpm_br", [Total(), Taken(), Conditional(), Far()],
+                       description="breakdown of retired branch instructions")
+
+
 def main() -> None:
     global _args
 
@@ -153,6 +290,7 @@ def main() -> None:
         Rapl(),
         Smi(),
         Tsx(),
+        IntelBr(),
     ])
 
     if _args.metricgroups:
-- 
2.51.2.1041.gc1ab5b90ca-goog


