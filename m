Return-Path: <linux-kernel+bounces-898554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 920B3C55873
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 04:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ECB193444CB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 03:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB4D30216D;
	Thu, 13 Nov 2025 03:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UGt3fbxu"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F63301717
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 03:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763004074; cv=none; b=NM10/hkCpcMuM21i5CWuXtUBQ8xGgGbpKPSPObsBeMtHk6VbaP02wP8cB4dw78P3IOqPvCqX5D4fq7Df4sjasATmCa+pdokOOmQ5tgPoDLuisne0C2Qem2vhM2Qtv0LezWABX7TOJKkWjT7qIs0eMBoZxxphwGswzMRBckNkSY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763004074; c=relaxed/simple;
	bh=d0Ep0VIIIs9k/3jv4T0ZT3I0MIVW8QcIX/tWtlgIghI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=R7ZvHmej9L1XsGk6xkOBISW+EUwVl9wogP6o1mr/dws8/yInnaLoc/lm3kMBnFVLRiYZtuag8MrDC4nZdwPHwDJqcZx99ufMbgO8x1cg7hZEA4FO6L4l18ZbeZIliJzSu73Y1hHGWE8HBVv18+sla3cnPEmzbAvi73XgToSq204=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UGt3fbxu; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-29555415c09so4333025ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 19:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763004072; x=1763608872; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2z0t93p1I7hhdevKfjgdZ8asRVsm/YfKaf+NS7xqbWw=;
        b=UGt3fbxu89gb54sGORtH8nqHFQn8XaQ6dg4TFIVOCp9gSUxu3QnxrxLiF/clKr75ew
         2p4DKiJXGVshQJkSp1Yb0Gj9WiQv+37DB3+9FvoTP0Obo78qUVzy9f+IgTngY7Vns9Ji
         0CI64jGyVfc/Rag+m7yKtG/NuvqXUXdgqdu9OEDMIyzY0ZxZQTgicf1hPpWLVV4voeLz
         2ogEile8I2c9DCCBWqgU3WPn2qIyVoM44YYCHXlwbp3/bh/r62ELzkiBuv0G0IwLIo8+
         LMpKhexeBx7QFV5DlQvIycpuwGbpCSiG+eTu6quiPaKph6/3EP/EQv/l31Lqic88pywd
         aqYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763004072; x=1763608872;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2z0t93p1I7hhdevKfjgdZ8asRVsm/YfKaf+NS7xqbWw=;
        b=rmNctGl1+Mh3hgorvXYYnpu41ypvpkWGAog/VpnVKz1Iu3lwbotKZkCacqBdePv1/x
         svMZSVM9MoVZXPxAdnpaY2ZHZdW7M9U0h5cztzpH8vARiKUdIarN5dXo2FsVOhy3HBxe
         PQbuZWtMMVypv/iMFCFCr66+DZ1pmV6tdWug2BRUOyc3Uld/ngg9VwJTQrRs2Bbf+RTh
         5TukHBKs/RS70F+2LLtDSh9cBkEY4A45Qbg0V062Th3Vgr4Y2RBjzuoa5DIfFNApkduF
         PDJGLWgx4WVw07pvhGZ02JwJaefypga2WRBKTkz5fqm0BixUuJAMEUcWUoOQTJxuGgU2
         S0Gw==
X-Forwarded-Encrypted: i=1; AJvYcCUsjn0L1gFpFYljUu4vNnAYES3bjvIkS4evC6qi311qK5/fx3wiG2ObgiP4SJJz3DpO19bt+G66Cz2Ao7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyABkvhHPZ06EWxdTKJJI2TERlK5wnKvqlnoAa46dPWJumVYk19
	Zh0u/2+vVLPrPxouyZRkrVjNnE2IcqA3vVoPQq4Hci4aVYK71trq8bA4SyEL/KDTZvU0axSZtqQ
	qxOAnJeLXdw==
X-Google-Smtp-Source: AGHT+IHGXwP8nxSNqOZtGTpxELzvSp9/lGNgnf9Laege7IXTYMU1vrjNxTAmdYNaC59qJtJcrvWyZ+7XLRc4
X-Received: from dlbdx18.prod.google.com ([2002:a05:7022:e12:b0:119:49ca:6b96])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cccf:b0:297:f8d9:aad7
 with SMTP id d9443c01a7336-2984ede5755mr65012275ad.50.1763004071922; Wed, 12
 Nov 2025 19:21:11 -0800 (PST)
Date: Wed, 12 Nov 2025 19:19:57 -0800
In-Reply-To: <20251113032040.1994090-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113032040.1994090-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251113032040.1994090-10-irogers@google.com>
Subject: [PATCH v8 09/52] perf jevents: Add threshold expressions to Metric
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

Allow threshold expressions for metrics to be generated.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/metric.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index 0f4e67e5cfea..e81fed2e29b5 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -430,13 +430,15 @@ class Metric:
   expr: Expression
   scale_unit: str
   constraint: MetricConstraint
+  threshold: Optional[Expression]
 
   def __init__(self,
                name: str,
                description: str,
                expr: Expression,
                scale_unit: str,
-               constraint: MetricConstraint = MetricConstraint.GROUPED_EVENTS):
+               constraint: MetricConstraint = MetricConstraint.GROUPED_EVENTS,
+               threshold: Optional[Expression] = None):
     self.name = name
     self.description = description
     self.expr = expr.Simplify()
@@ -447,6 +449,7 @@ class Metric:
     else:
       self.scale_unit = f'1{scale_unit}'
     self.constraint = constraint
+    self.threshold = threshold
     self.groups = set()
 
   def __lt__(self, other):
@@ -473,6 +476,8 @@ class Metric:
     }
     if self.constraint != MetricConstraint.GROUPED_EVENTS:
       result['MetricConstraint'] = self.constraint.name
+    if self.threshold:
+      result['MetricThreshold'] = self.threshold.ToPerfJson()
 
     return result
 
-- 
2.51.2.1041.gc1ab5b90ca-goog


