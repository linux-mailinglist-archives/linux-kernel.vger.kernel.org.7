Return-Path: <linux-kernel+bounces-898592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4F4C55950
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 04:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 458073B0AB3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 03:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5F431C59F;
	Thu, 13 Nov 2025 03:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EShfdruy"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C8131B825
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 03:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763004142; cv=none; b=GC3D7GdL0DnSNfECNaA2cOzPvltJ/5l+iQO5rrnDVhMkWAH+m+lPy65I4h+WEYEsXcUAM+xuNVPJwA4Jtbk33mgiCT/EepugnexVTx1EZBOea92Ui6G7xejWqpoliU1bxGuNHpH3C9V2mkus0yvONh9Yy6YCWhUalNA73h9LsK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763004142; c=relaxed/simple;
	bh=cJ+BPl3FaDItsU7YGTrU6qOMUqTf6c8cSliMMmt1mbI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=pHDnxOWsl4LNJ5PeZKT+1QmO3/n+hzWF8ufogJaNFNkHcm2VcDPPfeQKMsDxB41TGPKraD4MYnh5HNnabi6Nwt5+nq318dBbLtVglMb6Y49amFnamYP6N+ayKfXzBSFB+duOaX+RiHtevEgYtCqydlE+LurABKpKws6Q5CBA04w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EShfdruy; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-295952a4dd6so19094045ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 19:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763004140; x=1763608940; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ypdzgSTwEWd6G+LcFtKTyJXYeIL/SBVyTJRI0e2/Re4=;
        b=EShfdruyF8SfhjxgMIORirkjBxNY9BibTfXJKTLiU2WHMRd4IFRTibvWHhJRzURruJ
         blMIDfxO5kWCg+ZVH7mm97EPJuKsa+YMRoFKgNkaz7CVht0nJQv0FIJCyJPvNYRT918/
         KjovjVqX6+t0zGKp29w2vehE3I3Y5qUSmtUKZwrFUmbxChb5/u9SfT/SCd00DJ42dOl8
         689NDO3R0FonolaUJHioqx146AYhuWjLf2K2gshAzAYJRoU2rmcON1fGng2Xxe/KwjoY
         XaQZVsBgUCDl7MsfWybo5cnkwU0qBC3JZDDc0Ggj8pHibpUZ+xp4XwUPJ/OMA0J9Opjw
         CGDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763004140; x=1763608940;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ypdzgSTwEWd6G+LcFtKTyJXYeIL/SBVyTJRI0e2/Re4=;
        b=dXmHkTYvIQ3aN5e2gUteNAB2+LjDHNjjmw+ATlJqoeZjTZwFS+ven+Nnjqqs7VzwI1
         fjkiUfcZ6bPuVZ1UliRHmhVpeYYsVkNAKQUEivOcQIQ2OPkjdt0C4EO0b++K6mPENP3E
         93qk8skztTriRVP2ETgTo3q1J2nIUiSusBLkY7XiLOJt+JKkBfsSE+vqveUUeHz5vxTK
         0gkkcewBPA5rw+WcR3tuoShw2lLWEkUKdNUrvvIwiaR/5OcA3qdgHUkKr8rUzlq/AKWb
         D0/hOXIRv1Qt3kkmA3LjUL1FN3beuyv27Zg8vOvwLXLfm85hCUSIh4QX/ArrjbnA6Vda
         hAaA==
X-Forwarded-Encrypted: i=1; AJvYcCUN2FosldW6iqiwroISRPCQnE+jYsWrg5H36vqtz+uMoYLDp9lg2d+dhvefezDD+980z96b27NW6DdfT4U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1uQoG3XlWoiGEB1L8NhCUS6TgHIZHkqq5EwK/NIP6BMtViL+s
	Diy7IjV5rEXvm4Su7DD9GXoFycFy1QgTE7EXI5YVzl3tWX4dMGWuy3SfZMIjFk2H84lFJCEVwOF
	6++ClKUEHTw==
X-Google-Smtp-Source: AGHT+IEz64sDja4OyVOtnjAlvWZmvSmjq/FZJVcysiZTqacQ6mURxQa9cpHygE/XMAsY93LQ8KkShfUWqh45
X-Received: from dlbay38.prod.google.com ([2002:a05:7022:6626:b0:119:49ca:6ba6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f60c:b0:297:ec44:56f
 with SMTP id d9443c01a7336-2985a52b15amr20520485ad.14.1763004139855; Wed, 12
 Nov 2025 19:22:19 -0800 (PST)
Date: Wed, 12 Nov 2025 19:20:33 -0800
In-Reply-To: <20251113032040.1994090-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113032040.1994090-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251113032040.1994090-46-irogers@google.com>
Subject: [PATCH v8 45/52] perf jevents: Add dir breakdown metrics for Intel
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

Breakdown directory hit, misses and requests. The implementation uses
the M2M and CHA PMUs present in server models broadwellde, broadwellx
cascadelakex, emeraldrapids, icelakex, sapphirerapids and skylakex.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 36 ++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 983e5021f3d3..24ceb7f8719b 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -815,6 +815,41 @@ def IntelLdSt() -> Optional[MetricGroup]:
     ], description="Breakdown of load/store instructions")
 
 
+def UncoreDir() -> Optional[MetricGroup]:
+    try:
+        m2m_upd = Event("UNC_M2M_DIRECTORY_UPDATE.ANY")
+        m2m_hits = Event("UNC_M2M_DIRECTORY_HIT.DIRTY_I")
+        # Turn the umask into a ANY rather than DIRTY_I filter.
+        m2m_hits.name += "/umask=0xFF,name=UNC_M2M_DIRECTORY_HIT.ANY/"
+        m2m_miss = Event("UNC_M2M_DIRECTORY_MISS.DIRTY_I")
+        # Turn the umask into a ANY rather than DIRTY_I filter.
+        m2m_miss.name += "/umask=0xFF,name=UNC_M2M_DIRECTORY_MISS.ANY/"
+        cha_upd = Event("UNC_CHA_DIR_UPDATE.HA")
+        # Turn the umask into a ANY rather than HA filter.
+        cha_upd.name += "/umask=3,name=UNC_CHA_DIR_UPDATE.ANY/"
+    except:
+        return None
+
+    m2m_total = m2m_hits + m2m_miss
+    upd = m2m_upd + cha_upd  # in cache lines
+    upd_r = upd / interval_sec
+    look_r = m2m_total / interval_sec
+
+    scale = 64 / 1_000_000  # Cache lines to MB
+    return MetricGroup("lpm_dir", [
+        Metric("lpm_dir_lookup_rate", "",
+               d_ratio(m2m_total, interval_sec), "requests/s"),
+        Metric("lpm_dir_lookup_hits", "",
+               d_ratio(m2m_hits, m2m_total), "100%"),
+        Metric("lpm_dir_lookup_misses", "",
+               d_ratio(m2m_miss, m2m_total), "100%"),
+        Metric("lpm_dir_update_requests", "",
+               d_ratio(m2m_upd + cha_upd, interval_sec), "requests/s"),
+        Metric("lpm_dir_update_bw", "",
+               d_ratio(m2m_upd + cha_upd, interval_sec), f"{scale}MB/s"),
+    ])
+
+
 def UncoreMem() -> Optional[MetricGroup]:
     try:
         loc_rds = Event("UNC_CHA_REQUESTS.READS_LOCAL",
@@ -944,6 +979,7 @@ def main() -> None:
         IntelMlp(),
         IntelPorts(),
         IntelSwpf(),
+        UncoreDir(),
         UncoreMem(),
         UncoreMemBw(),
     ])
-- 
2.51.2.1041.gc1ab5b90ca-goog


