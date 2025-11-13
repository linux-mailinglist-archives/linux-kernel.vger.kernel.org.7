Return-Path: <linux-kernel+bounces-898569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BED66C558A3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 04:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EC30A3446E0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 03:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650CD2BEC2E;
	Thu, 13 Nov 2025 03:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="08GM/qBd"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6491030FF08
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 03:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763004099; cv=none; b=HlG1OVYRwt9OyjDOKW2Jz0pP8sTrh84opIkMhA2l676I2I9l5iyUkhbqc2s5Epm55/79HPKIWgA22yHyCeYK0XanPcumtBJHYzMf+AOMKn4kMUa5yKdaqoPwW97IPsLpmE19MXavFkLo1hLGNP6dRqGTw2lLNk5Qjg5PoOEfsI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763004099; c=relaxed/simple;
	bh=aDJn+LTiM/YgdbHZHL1Ft9cRSezjfKlAKOa73srLeAs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=a1EcE8omqezWYcwG/2IsNEdHnQSpdIZ7mx50o1yDZ1/JjxeauDOwTn6uNO1ZmOqJ7ZeFKs99Y+rHRjHbAHLV0vp5pF9GUQULJcTbn5kKtdLYRNVzbOTp+4X57NnFo5S5qVyv7IDyprW3rwhbo9cV5WumZ5rPhymelt2inzoEpnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=08GM/qBd; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-29845b18d1aso4341465ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 19:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763004098; x=1763608898; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IEiWipmsRatrVKikhSYvmz9kdeyKo1FjFHI4OKnBoxI=;
        b=08GM/qBdV8Ts3rx2opARd8rYcE+0J9A+lXNh5wMQEKcZ2myK6XFK7ZPIntkxyarxcU
         e/447xm368DM9ucrHv3Kc2b80Q8SgYXOGR8L/N28khcd+Y/QtF4tBo+/SLgzOyWHJmtd
         gxJMshyLJDEbYkl3EG6uSZv0hJkGa3IqaNepQn74+07OkXNAA9iOs4aRNt/nR3jVjQKL
         VyACEChyjLdyKIwaXPvQjjkFqN2ivkQRiTeePRPXvb4B1oWOaf2+TplVSFQDStuom7Rt
         lPr8xkY9jZenp7yo4qBb1VT5PBXcNOBVGB00YdrA9mQOzcjtF3++xRMFRtTuoSFkCO7+
         7j9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763004098; x=1763608898;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IEiWipmsRatrVKikhSYvmz9kdeyKo1FjFHI4OKnBoxI=;
        b=nbfT60WTKaynWNjQFx9vYxegmxBIQwRHXwThIIQX31XgjFB7o40f2jsIw09qYNoEjb
         UQjvSzYIjzB/JXiv+CiOP+qCcpBH8An86CUgXA6af3onxFD8+zV8zqulWtw28XWdFWO6
         DYcAtOR8m1fJdhBZMz2bILwamf7q9t8xvaj6YnGayLXIwRQalPesytdGXB07efsl+IP3
         zGyC9ZfF9+vtTtsav+bDzDVqJ69NFSdGCL3sIrmjyohBqtGr2azqVuZvAAynQcsn2ATg
         UvdCI4pQo1ov3sqszO1harhzzDNCe8eKITehkyGSygCRbmAEII6f5/BotyxW9loy3P3j
         tLTg==
X-Forwarded-Encrypted: i=1; AJvYcCUf+X2Ark/JxwVxsDsD8uTbkEZ6isfsHqnCDLsI/bCnFheExxnRBTl0iQo6Y3KEsqg7y1vPqC5YwMmsusM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaQiZt2vuJ/K1U3cERmSZ8QNCmRlFm/B/CWhpUZI1/tCUNZb1/
	3ua1zeNl9kSSQ/7Fdf3Aqxogy/+Rkb1lLrVGtzRqXhhTQxwVo/Sc6pk7iYXBVvbxqvYdLNpxSFh
	bAwJzq6Y9pw==
X-Google-Smtp-Source: AGHT+IH2DMevccyCiQ/HJCM5gtbxsXuQ+aGSiyEHjIehf0KYnZ1y3roqGFRGSXsTFZ0emzyi5/2YQa0gtFay
X-Received: from dycpg3.prod.google.com ([2002:a05:7300:dd03:b0:2a4:64c9:8bc8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:da2d:b0:295:5116:6a7d
 with SMTP id d9443c01a7336-2984ed2b8c5mr63472395ad.4.1763004097576; Wed, 12
 Nov 2025 19:21:37 -0800 (PST)
Date: Wed, 12 Nov 2025 19:20:11 -0800
In-Reply-To: <20251113032040.1994090-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113032040.1994090-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251113032040.1994090-24-irogers@google.com>
Subject: [PATCH v8 23/52] perf jevents: Add uncore l3 metric group for AMD
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

Metrics use the amd_l3 PMU for access/miss/hit information.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 1592d7db2ac7..d748b5c1d791 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -479,6 +479,24 @@ def Rapl() -> MetricGroup:
                        description="Processor socket power consumption estimates")
 
 
+def UncoreL3():
+    acc = Event("l3_lookup_state.all_coherent_accesses_to_l3",
+                "l3_lookup_state.all_l3_req_typs")
+    miss = Event("l3_lookup_state.l3_miss",
+                 "l3_comb_clstr_state.request_miss")
+    acc = max(acc, miss)
+    hits = acc - miss
+
+    return MetricGroup("lpm_l3", [
+        Metric("lpm_l3_accesses", "L3 victim cache accesses",
+               d_ratio(acc, interval_sec), "accesses/sec"),
+        Metric("lpm_l3_hits", "L3 victim cache hit rate",
+               d_ratio(hits, acc), "100%"),
+        Metric("lpm_l3_miss", "L3 victim cache miss rate", d_ratio(miss, acc),
+               "100%"),
+    ], description="L3 cache breakdown per CCX")
+
+
 def main() -> None:
     global _args
     global _zen_model
@@ -515,6 +533,7 @@ def main() -> None:
         AmdUpc(),
         Idle(),
         Rapl(),
+        UncoreL3(),
     ])
 
     if _args.metricgroups:
-- 
2.51.2.1041.gc1ab5b90ca-goog


