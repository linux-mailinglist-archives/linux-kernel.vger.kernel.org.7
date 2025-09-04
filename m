Return-Path: <linux-kernel+bounces-799905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB75B43142
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51A05179CC3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC54123C4FD;
	Thu,  4 Sep 2025 04:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="25JZSYgM"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71852690D9
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 04:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756960876; cv=none; b=CixgH+BTzkX920vFJJ3TOaG81QYB4Fi8Ryp5+h00VGmRBUFYD7alTfa9GgQxuCNYebYFBm3+W88KO89PCdS3nA3htXJ1JUFz6t4XMWCFM6WZsfZ/q2MwDesntnWfWjw6lpB6PgJcjqA9gHn4AlW+aBIMnmXtTVlWMhFrgVyJYjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756960876; c=relaxed/simple;
	bh=2/LK9ZrCC0lbWUecVqpdlRthcL+qAUPy1OjDmgPte7E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=k8nEHYmJIrSbxDqG3QCXJV0NOlZ60Bml0GZoaXQ8cDI9t/19AcmoHE4LtQYNGKuIP4JHlGPe4q69ltmuBpddYGflzDIjrzzq0BERngSsri9y3K75hXhusG/EO2x8StHXZnI/UjWnr8aEefbZyrwdhdVYNLei76PyJ8iIPDXxONU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=25JZSYgM; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2445806b18aso7787005ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 21:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756960874; x=1757565674; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M+tHIMSliIE1X01UkweQN30Nr+4SQPxJb3LwFTkW9p8=;
        b=25JZSYgMb3smSrXwnNHCTyuSkXQxK4CWFe+gIMhZf8XjkzGKQUaxwCt9oBxKq1pkPo
         p7Z4BDFBrI44s6mI7trnhuslPjMnS16T4mD1luvLUleJlEkWbuLDI8sz31Ij+Z2dDNmW
         rknJwh7QWTu0oRu/Zpx3FqHai27DhO5/r751jZil7BcMojkqMxwRsaZSXJ07wu0yyTzG
         W/VfSFki/gMjB19b37rIJ53AkbGa2hae7gs5cWsKC/V5UPupJW4dpmaJ9WxAbbiqYo94
         gy3OiPOWgyxbb9hUiim2pFh49Lk6gbwIXiAAntmXmhLvKCv6wVQTtUV6u/C9I+KTpfLO
         vNUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756960874; x=1757565674;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M+tHIMSliIE1X01UkweQN30Nr+4SQPxJb3LwFTkW9p8=;
        b=sXbkV5WAXXh0hIyIhx0s4y4cvOHseorr9t+OhQ3D0435/1l58UBAYWvnD2XsqPZW39
         HkLhjCCBJ/2l+Zq9SCrEZ/k9j/qWkqeTemqF6AArYSNmFMPo9VgFrZsthp7R5fINOLgI
         DaLbI6/DiaT+LsniZeLmVue3QdWIBYy5hnCSzIS3G3wsVHWTGmvdliLZf3f6IIcys1sc
         i4xk39H2dCstjYuIl2ZVAaXaGmjnuhqpvNixiFRgZn9Ui6PhRIccJKuRf4+CZRAhxYDF
         2RhdT0gZR22hmUO9vtSaDYi1XXhExlJzbqe+kxvO9NTx70m5GA5sPcem6rDu5EZz7ZdJ
         4AhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVP7lnf2NRBdf2PfyAAsa9ya7NEFQWcZBDCToK6qiNoNIkWOtx4jv2oxgXElp/9EXhdVCAQGXjQqq+Wmqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlqO++R65KIKFXXbRyfQBDKbszifvqWEuiSam9RILCbM+yt7xi
	2dDXS/wyeUTAaB3ykv9ZHBF+J9tBUKgr1Jfqz/jS6a1+94VJrbYcZPtGGCfTTe4B2pljhmMWZB9
	4UMJOfHDBfA==
X-Google-Smtp-Source: AGHT+IH3tLIfwJ1fXs+d/59g5amTxS2ariwuJ4COkH6MIaASqWZ6k2eJbzm0UjsZYFZEYI8yBTNt4LxTUmeM
X-Received: from ploh15.prod.google.com ([2002:a17:902:f70f:b0:24c:b630:3c6e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2acc:b0:24c:cc36:ad92
 with SMTP id d9443c01a7336-24ccc36af60mr10217325ad.12.1756960874047; Wed, 03
 Sep 2025 21:41:14 -0700 (PDT)
Date: Wed,  3 Sep 2025 21:40:45 -0700
In-Reply-To: <20250904044047.999031-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904044047.999031-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904044047.999031-12-irogers@google.com>
Subject: [PATCH v6 11/13] perf jevents: Add ILP metrics for AMD
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

Use the counter mask (cmask) to see how many cycles an instruction
takes to retire. Present as a set of ILP metrics.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 36 ++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 20dcab5b856d..6f1259796c8d 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -120,6 +120,41 @@ def AmdBr():
                      description="breakdown of retired branch instructions")
 
 
+def AmdIlp() -> MetricGroup:
+    tsc = Event("msr/tsc/")
+    c0 = Event("msr/mperf/")
+    low = tsc - c0
+    inst_ret = Event("ex_ret_instr")
+    inst_ret_c = [Event(f"{inst_ret.name}/cmask={x}/") for x in range(1, 6)]
+    ilp = [d_ratio(max(inst_ret_c[x] - inst_ret_c[x + 1], 0), cycles) for x in range(0, 4)]
+    ilp.append(d_ratio(inst_ret_c[4], cycles))
+    ilp0 = 1
+    for x in ilp:
+        ilp0 -= x
+    return MetricGroup("lpm_ilp", [
+        Metric("lpm_ilp_idle", "Lower power cycles as a percentage of all cycles",
+               d_ratio(low, tsc), "100%"),
+        Metric("lpm_ilp_inst_ret_0",
+               "Instructions retired in 0 cycles as a percentage of all cycles",
+               ilp0, "100%"),
+        Metric("lpm_ilp_inst_ret_1",
+               "Instructions retired in 1 cycles as a percentage of all cycles",
+               ilp[0], "100%"),
+        Metric("lpm_ilp_inst_ret_2",
+               "Instructions retired in 2 cycles as a percentage of all cycles",
+               ilp[1], "100%"),
+        Metric("lpm_ilp_inst_ret_3",
+               "Instructions retired in 3 cycles as a percentage of all cycles",
+               ilp[2], "100%"),
+        Metric("lpm_ilp_inst_ret_4",
+               "Instructions retired in 4 cycles as a percentage of all cycles",
+               ilp[3], "100%"),
+        Metric("lpm_ilp_inst_ret_5",
+               "Instructions retired in 5 or more cycles as a percentage of all cycles",
+               ilp[4], "100%"),
+    ])
+
+
 def AmdDtlb() -> Optional[MetricGroup]:
   global _zen_model
   if _zen_model >= 4:
@@ -584,6 +619,7 @@ def main() -> None:
 
   all_metrics = MetricGroup("", [
       AmdBr(),
+      AmdIlp(),
       AmdDtlb(),
       AmdItlb(),
       AmdLdSt(),
-- 
2.51.0.338.gd7d06c2dae-goog


