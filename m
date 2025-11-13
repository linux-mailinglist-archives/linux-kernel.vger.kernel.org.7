Return-Path: <linux-kernel+bounces-898564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE57EC5587C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 04:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D9DC3B7026
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 03:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E779730DD1A;
	Thu, 13 Nov 2025 03:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QQMHA3kt"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4871B30BBB9
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 03:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763004092; cv=none; b=bA3DFmxbI/NCsiIKd5S7JPrsfZ5TcHHPWZpjHdM4nVqMZsUk+UwwtCGVJEb2fFYPIwNOK81xXxBgiII8CS8lQ/ttlp1vUefXgXWBIBlViP7UtXBHNFeG1ksVWcizX6nzEmjF07u5cZ5gasy/UVvegmlqVgGzbhMQ127BMoUOaxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763004092; c=relaxed/simple;
	bh=MTpvxNQIsbhE+YweGRvxHhdlQZZ2uFXAAWC1hzEIqfY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=aGCbmX9xcbEK+L/d3ApysGqfUjUB+O1YrKMVB+1zCjKbsaDWlIoB0xo/jYF/SZB0EcnW7F805b8NqdXG7pzk2UtQkm92ez4QkHGuBXgaJDOAYQnQUaJUOYg2oIa7UBwDph2kRzQvSpuWkasPSB15k8tyl/cBunMK7UQams12L/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QQMHA3kt; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b99f6516262so917763a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 19:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763004089; x=1763608889; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=46tAwbQ8f//xN3Ry13qDNDr4Q30XuGVyKpDV1Wax+Xg=;
        b=QQMHA3ktMfiU+vMrw84poHbX/5TBe1W2ZbjIbibCAx1281clSt0YOY4Hgt80bZccwW
         eZhyg7XFk0JOB3LvgFyasUqrXZa7W8Mix4Kea9zktSDg2Hha1LPRmPYsHlJp7FF5Bk2Y
         xlkt8yftD8EirW+9LiCc2oT3chhn6Z/FAp5qtoZK4opiy0X0Lcst39dIZ+QnmND6/UM6
         4EVSy84JPBuKZGd58fJM5Ro16MBwHDJfeYGjFORMYaRiUcUOvtOpt/hCnfIjVnjVdW7U
         FU2WbKt5ezx6lm8pCsH+fGgDKc2y91oQR/NgXc835V5SnHSyzRJSf964nP0eL4nel6bX
         iWxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763004089; x=1763608889;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=46tAwbQ8f//xN3Ry13qDNDr4Q30XuGVyKpDV1Wax+Xg=;
        b=ZHkZlHhkU7SIpHEf1IKHXyc/aLSGMDTwW5S44sFcthkkRfvYLJRWB2GZSWUK1x2Pm+
         KA3ksH1QVoGu4Xo5B+HEB+vr8PW+7L1OP2a0mivddWKPBIKboQpgHFJ6yfIgwXg7OhXi
         IiZjiGMhRbW+jWfYauNiM6vDzxehxp5Tq7ZNqufJ8uyPNqVz37ubLUJ+qxbRiPQ6qz/1
         uTOPcSZcnJabLU70WhTXyktUS3ZxCvf4wTSkgIAsVUCNEZpZcFyhNmQmULaWvWNGRniS
         v9O19kE54dqftvEKlAC8W7g6ftiQwXBY3WN1OuooyeQCaRfb/9ElsafujWjCUyDpN5Zw
         rDXg==
X-Forwarded-Encrypted: i=1; AJvYcCX1n6OlUUF8+YnIiltg0n6JBIZ+G1tx0SsOhc3gl+nMaxlQh6cRI9VY7vc41z4JHO+Dycky18yURny6X2s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/5RzXE9VWFjFBmKihU2kK+xQuaSpCeNcv9AahJyXrAuAkQHB9
	5j32Bb4U6QKgimq9eohpB2iFu5Elw4dhxqvwsNh+ZW/AiZYv3YHz+syT86Oe7S7T03/AZy3DNsZ
	wUSEaBWq9sg==
X-Google-Smtp-Source: AGHT+IFxjDiSEA9vnZn0vC4yoKImGg7+gOZ9Xm6w4b9Ab+vLCsp/wcSbIBstaW7u8IZXDNuQ5mIrUqa4yYk2
X-Received: from dybmw23.prod.google.com ([2002:a05:7300:cd97:b0:2a4:4bd0:6ed8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:8906:b0:32b:7220:8536
 with SMTP id adf61e73a8af0-35909399efemr6057032637.16.1763004088709; Wed, 12
 Nov 2025 19:21:28 -0800 (PST)
Date: Wed, 12 Nov 2025 19:20:06 -0800
In-Reply-To: <20251113032040.1994090-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113032040.1994090-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251113032040.1994090-19-irogers@google.com>
Subject: [PATCH v8 18/52] perf jevents: Add br metric group for branch
 statistics on AMD
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
events. The lack of conditional events on anything but zen2 means this
category is lacking on zen1, zen3 and zen4.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 104 +++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 42e46b33334d..1880ccf9c6fc 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -18,6 +18,109 @@ cycles = Event("cycles")
 smt_cycles = Select(cycles / 2, Literal("#smt_on"), cycles)
 
 
+def AmdBr():
+    def Total() -> MetricGroup:
+        br = Event("ex_ret_brn")
+        br_m_all = Event("ex_ret_brn_misp")
+        br_clr = Event("ex_ret_msprd_brnch_instr_dir_msmtch",
+                       "ex_ret_brn_resync")
+
+        br_r = d_ratio(br, interval_sec)
+        ins_r = d_ratio(ins, br)
+        misp_r = d_ratio(br_m_all, br)
+        clr_r = d_ratio(br_clr, interval_sec)
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
+                   "The number of resync branches per second.", clr_r, "req/s")
+        ])
+
+    def Taken() -> MetricGroup:
+        br = Event("ex_ret_brn_tkn")
+        br_m_tk = Event("ex_ret_brn_tkn_misp")
+        br_r = d_ratio(br, interval_sec)
+        ins_r = d_ratio(ins, br)
+        misp_r = d_ratio(br_m_tk, br)
+        return MetricGroup("lpm_br_taken", [
+            Metric("lpm_br_taken_retired",
+                   "The number of taken branches that were retired per second.",
+                   br_r, "insn/s"),
+            Metric(
+                "lpm_br_taken_mispred",
+                "The number of retired taken branch instructions that were "
+                "mispredicted as a percentage of all taken branches.", misp_r,
+                "100%"),
+            Metric(
+                "lpm_br_taken_insn_between_branches",
+                "The number of instructions divided by the number of taken branches.",
+                ins_r, "insn"),
+        ])
+
+    def Conditional() -> Optional[MetricGroup]:
+        global _zen_model
+        br = Event("ex_ret_cond")
+        br_r = d_ratio(br, interval_sec)
+        ins_r = d_ratio(ins, br)
+
+        metrics = [
+            Metric("lpm_br_cond_retired", "Retired conditional branch instructions.",
+                   br_r, "insn/s"),
+            Metric("lpm_br_cond_insn_between_branches",
+                   "The number of instructions divided by the number of conditional "
+                   "branches.", ins_r, "insn"),
+        ]
+        if _zen_model == 2:
+            br_m_cond = Event("ex_ret_cond_misp")
+            misp_r = d_ratio(br_m_cond, br)
+            metrics += [
+                Metric("lpm_br_cond_mispred",
+                       "Retired conditional branch instructions mispredicted as a "
+                       "percentage of all conditional branches.", misp_r, "100%"),
+            ]
+
+        return MetricGroup("lpm_br_cond", metrics)
+
+    def Fused() -> MetricGroup:
+        br = Event("ex_ret_fused_instr", "ex_ret_fus_brnch_inst")
+        br_r = d_ratio(br, interval_sec)
+        ins_r = d_ratio(ins, br)
+        return MetricGroup("lpm_br_cond", [
+            Metric("lpm_br_fused_retired",
+                   "Retired fused branch instructions per second.", br_r, "insn/s"),
+            Metric(
+                "lpm_br_fused_insn_between_branches",
+                "The number of instructions divided by the number of fused "
+                "branches.", ins_r, "insn"),
+        ])
+
+    def Far() -> MetricGroup:
+        br = Event("ex_ret_brn_far")
+        br_r = d_ratio(br, interval_sec)
+        ins_r = d_ratio(ins, br)
+        return MetricGroup("lpm_br_far", [
+            Metric("lpm_br_far_retired", "Retired far control transfers per second.",
+                   br_r, "insn/s"),
+            Metric(
+                "lpm_br_far_insn_between_branches",
+                "The number of instructions divided by the number of far branches.",
+                ins_r, "insn"),
+        ])
+
+    return MetricGroup("lpm_br", [Total(), Taken(), Conditional(), Fused(), Far()],
+                       description="breakdown of retired branch instructions")
+
+
 def AmdUpc() -> Metric:
     ops = Event("ex_ret_ops", "ex_ret_cops")
     upc = d_ratio(ops, smt_cycles)
@@ -83,6 +186,7 @@ def main() -> None:
     _zen_model = int(_args.model[6:])
 
     all_metrics = MetricGroup("", [
+        AmdBr(),
         AmdUpc(),
         Idle(),
         Rapl(),
-- 
2.51.2.1041.gc1ab5b90ca-goog


