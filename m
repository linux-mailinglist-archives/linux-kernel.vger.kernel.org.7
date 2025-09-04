Return-Path: <linux-kernel+bounces-799932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 450B1B43161
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A5765E19ED
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EE427FB1F;
	Thu,  4 Sep 2025 04:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p+DOnwEq"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7521527E076
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 04:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756961262; cv=none; b=b+KdkUEV2R2kwaUXWna1fqU85MehdcRKVQjZNoHOW9bpokMERWalynXvTIC21bMOVOsOyAESdLR0q+pXcSYMSvgBBtpqC2ebB1SXklShyEd5JOwH1Q/hOyxzWxmwF1ci38TTokDpDXPbqxSEPyB77irExBgm/YxI4/MnBVTpSXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756961262; c=relaxed/simple;
	bh=RistnuAgHd4NCL4l0yE6lEPBFwvSNadT93kj/NUVg6M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=TgvKDO76E1OGhgbELCA7Bxz0TbsSVaV1fnsxpTwsssjfF8SaFvQwc6J67D/AaHQzsYFV0iAHMPba8tWlVLenNhHm6FEc0DtUw9OcB7GNkD2mg+71Gspt7WukYfWxBC55fhO5ANInOgwiK0jvep7juA/XW1jF6wVdnrU5LnZXHTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p+DOnwEq; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-24cc4458e89so7475215ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 21:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756961260; x=1757566060; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VgqEItY9A2DTGkflolDC2RygmVecc1iPe1xmOKI5+pQ=;
        b=p+DOnwEqjd3OMbeS4uKh98kWBw3mEHnKD5ZV/irmAvW2uLtDkahIHubQEU0zKIwx8J
         PuWw5P6dfpyz7goXYgN9A8KbuwHEWAT2H8i/cZDQm8MZR+9nNM+HPcTKElkVEU9Unrck
         IQ7F89IiC77r8HFhs58liJ9LUUQRe3LEpu6BEY1ulhfsSsKCO5ZoPBuhvLT3cOQXXmm+
         JUQNdy30pDZ3h8MsBlZrVYkhQmIRnHZDmj13DPtCPunJRCHx7tKGeQGxXCtnUkJC/3YU
         m5Nsiy7+Xalyzi8MzwI5h6IF7g1+Jt9/Apmpa3+wqigeH0qh37sBU4UZS5z3yazy8j9c
         aZbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756961260; x=1757566060;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VgqEItY9A2DTGkflolDC2RygmVecc1iPe1xmOKI5+pQ=;
        b=FXTxw7i7PGV/eQ/JasweELQzRatI9Xf9SFLgQsNCw8rEOm2nMcKtmciJbxvXin+C5J
         +7q1tS274nx4xs60p+4DCP7NhHDVxx08/t2qs80IYBdyNTrjQFRYQp6l/mZeSGenWKRD
         r7e+XL7p8zXgO5RO36Mi9RBamjfOluOtVVW3vjmWqO8DsGQwh0WFij3RbM2b4pDPGlNs
         tf4ibfmWLuv/q+cPUQwkDNTj+u4/s92Sql5zDBFylcc2CA5crTs9NvfHJjEimbUKOZ72
         6Xp8Qnn3fyfSgfgI54XARO+6au28y1oXFpns1xU/1ku2p0JWCx/DnTjwO4VC7r8skIBB
         hXsw==
X-Forwarded-Encrypted: i=1; AJvYcCV5rSd+4t9LXV4oYPutQdpFNGoZ5WWlbWo4R/EcI9y4XdBn/GPoegij333DtOpksSfLwtRIyVo8zLy5iRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXcIyR5ORZ9igBcPc3XxdDUha86dkRG/EetmTrLQM0/BK/8ceC
	SK6MAdLfODh86tZ4BSnUBYA36PvVqMsrP9sZFzOd5VGHw2HqQSa711jJC82cY6jVwb38R2VP6RI
	kIeUc1Iy5/A==
X-Google-Smtp-Source: AGHT+IF0wYPqg7zlSl1qx2A5P6s9Rtb4ovc11SlDLv1+Ceku358dlTNxKQe5YNKmsHdiFgykM9R6GbvmqjAn
X-Received: from plbkz7.prod.google.com ([2002:a17:902:f9c7:b0:248:7327:44b8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2f0d:b0:249:f16:f080
 with SMTP id d9443c01a7336-24944afb3ccmr226252725ad.52.1756961259744; Wed, 03
 Sep 2025 21:47:39 -0700 (PDT)
Date: Wed,  3 Sep 2025 21:46:53 -0700
In-Reply-To: <20250904044653.1002362-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904044653.1002362-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904044653.1002362-23-irogers@google.com>
Subject: [PATCH v6 22/22] perf jevents: Add mesh bandwidth saturation metric
 for Intel
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

Memory bandwidth saturation from CBOX/CHA events present in
broadwellde, broadwellx, cascadelakex, haswellx, icelakex, skylakex
and snowridgex.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index e639e8998d87..36b6c4704522 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -1009,6 +1009,22 @@ def UncoreMemBw() -> Optional[MetricGroup]:
   ], description = "Memory Bandwidth")
 
 
+def UncoreMemSat() -> Optional[Metric]:
+  try:
+    clocks = Event("UNC_CHA_CLOCKTICKS", "UNC_C_CLOCKTICKS")
+    sat = Event("UNC_CHA_DISTRESS_ASSERTED.VERT", "UNC_CHA_FAST_ASSERTED.VERT",
+                "UNC_C_FAST_ASSERTED")
+  except:
+    return None
+
+  desc = ("Mesh Bandwidth saturation (% CBOX cycles with FAST signal asserted, "
+          "include QPI bandwidth saturation), lower is better")
+  if "UNC_CHA_" in sat.name:
+    desc = ("Mesh Bandwidth saturation (% CHA cycles with FAST signal asserted, "
+            "include UPI bandwidth saturation), lower is better")
+  return Metric("lpm_mem_sat", desc, d_ratio(sat, clocks), "100%")
+
+
 def UncoreUpiBw() -> Optional[MetricGroup]:
   try:
     upi_rds = Event("UNC_UPI_RxL_FLITS.ALL_DATA")
@@ -1071,6 +1087,7 @@ def main() -> None:
       UncoreDir(),
       UncoreMem(),
       UncoreMemBw(),
+      UncoreMemSat(),
       UncoreUpiBw(),
   ])
 
-- 
2.51.0.338.gd7d06c2dae-goog


