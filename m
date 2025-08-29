Return-Path: <linux-kernel+bounces-791102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54741B3B20A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 06:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14EE52006B5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 04:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF4A253F21;
	Fri, 29 Aug 2025 04:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RFUNEay+"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F13824E4A8
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 04:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756440713; cv=none; b=k1piJstUW3Vz7EzFJJo9xTO0t1BEFALOY15Eeho849UgIp1pkJUwSXCFizcPRX58Y/tY61u5iwz5L7hF8Z6g3yIKFIP3fmXKYzPRjBaa5q5CU81l92TuLXs/tuA6fSvf1qJ1jwTvLnS4lzvTbRjMQtH4hSKfYCcUOvgM2831pU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756440713; c=relaxed/simple;
	bh=Hp5WV0n8SnsdwaoqohkLH+hIH0gHJxo/yXPqFsFnseg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=IFHcF4pxEc180aEt0YkFiOTzX/6IuoJi2R0Y4RraDCt54Ye8rziRbkFk3THG7WM1qWovLBAO9V6th9XJzM9EcI7hrR2TgQSP4C4b5VHTHEDWcE115LSzr354+kn1I5zr1WODuLy5qkRjKi21Uk9zlaFlHIsyh+CYUc1cmzAMdms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RFUNEay+; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-248ae61487aso18646485ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 21:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756440711; x=1757045511; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HhMZdtMjJhuzLc6gr9GuhAcC6OciUjcHbgWMOwK4Tk0=;
        b=RFUNEay+gPu0Mdj4bQ0ttfkLBO9q1dJFEfjRTpW0pEJWZqzIg5+qo3ZHK1sEwPjoto
         XkLMzuu5DFx1eVIEnY0Blz2G16O7xLmtkruXD5nYR+BHBiczYXEUXLLEzLABs1yjk6CR
         b6Zm/uM6vQ0chZQabu3zprgSg6qJq7lBoyYCb3CjJhpOEtmPYqZoO8BLqRZq0Z1/z88G
         geSF1DDwoBx0RgfDP/un7ztF4dfDrrT1z03IhiUe8botWpTHfshe35lYdcNtJny5uq4f
         oHSKG/hofBtwdQjFQLX/oTnyQnz3YBC8Q8m3Lwl7nZqYzJ/60o+UkrG9S18Fw4Kr03GW
         /1OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756440711; x=1757045511;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HhMZdtMjJhuzLc6gr9GuhAcC6OciUjcHbgWMOwK4Tk0=;
        b=PuMfdXTGUrtMyI/e1rc5v8YcXTa9Km3r8BF3q0S4M5iMB4T/9eOX8otxN8cPiYHsNs
         k+nzk04cZq6ulcPNpVTXlE1+/iuIZOmx0XUIBAioSvXZWvyHctB0gJeMKHEHEype/CNF
         7VcG2O4l19cuW+RXLZY6kmJB0w3NyWtcP367quOJc+819gpbktXbDtqFgi7T5taM26y4
         H28pGAZmj15PN6CKayb79O5HiI+rW35ZzZoaumrwfGSlLJSYo8Tpk/UI7U4yRyxVdF3s
         SGymEJ4WTguCf3rp2+ELC9RHYi3TYpcprn/pC9Kcf3G/xmjOMV/VIBwPukAqVPs3LRM8
         FaXg==
X-Forwarded-Encrypted: i=1; AJvYcCW4ITdiZPQEbAs3xJunX9fSSjnrQzh5y3lPhmMIvFeBWEbTvc3ow8pqnH/4+NTWDPO3DacxRJhErWhzKok=@vger.kernel.org
X-Gm-Message-State: AOJu0YygJsXI3QrPp6PejucYbWyBsGecM/2sYBHkryY6YnpD/0Dr3CCq
	v8ipbKGGU0Ze80Dp7wqr0SNCMyNItz+kl7McC62u/yabTKtEldlbLJDrl7RBP6bRJUvtbn7zDYd
	oOIz4952F8A==
X-Google-Smtp-Source: AGHT+IHF7CHbu3OvL/I74+5b3sbk1r/AjOT14kvv4VtBF/x1sIiXfR96ALsS6D+gUrOUzz1+usM/iTT4ggNj
X-Received: from plbm11.prod.google.com ([2002:a17:902:d18b:b0:249:329:c51c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3843:b0:248:741f:2c31
 with SMTP id d9443c01a7336-248741f2e2fmr166214065ad.18.1756440711503; Thu, 28
 Aug 2025 21:11:51 -0700 (PDT)
Date: Thu, 28 Aug 2025 21:10:53 -0700
In-Reply-To: <20250829041104.4186320-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829041104.4186320-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829041104.4186320-13-irogers@google.com>
Subject: [PATCH v5 12/22] perf jevents: Add ILP metrics for Intel
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

Use the counter mask (cmask) to see how many cycles an instruction
takes to retire. Present as a set of ILP metrics.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 39 ++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 03983107c5c0..df0e1dce041c 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -262,6 +262,44 @@ def IntelBr():
                      description="breakdown of retired branch instructions")
 
 
+def IntelIlp() -> MetricGroup:
+  tsc = Event("msr/tsc/")
+  c0 = Event("msr/mperf/")
+  low = tsc - c0
+  inst_ret = Event("INST_RETIRED.ANY_P")
+  inst_ret_c = [Event(f"{inst_ret.name}/cmask={x}/") for x in range(1, 6)]
+  core_cycles = Event("CPU_CLK_UNHALTED.THREAD_P_ANY",
+                      "CPU_CLK_UNHALTED.DISTRIBUTED",
+                      "cycles")
+  ilp = [d_ratio(max(inst_ret_c[x] - inst_ret_c[x + 1], 0), core_cycles) for x in range(0, 4)]
+  ilp.append(d_ratio(inst_ret_c[4], core_cycles))
+  ilp0 = 1
+  for x in ilp:
+    ilp0 -= x
+  return MetricGroup("lpm_ilp", [
+      Metric("lpm_ilp_idle", "Lower power cycles as a percentage of all cycles",
+             d_ratio(low, tsc), "100%"),
+      Metric("lpm_ilp_inst_ret_0",
+             "Instructions retired in 0 cycles as a percentage of all cycles",
+             ilp0, "100%"),
+      Metric("lpm_ilp_inst_ret_1",
+             "Instructions retired in 1 cycles as a percentage of all cycles",
+             ilp[0], "100%"),
+      Metric("lpm_ilp_inst_ret_2",
+             "Instructions retired in 2 cycles as a percentage of all cycles",
+             ilp[1], "100%"),
+      Metric("lpm_ilp_inst_ret_3",
+             "Instructions retired in 3 cycles as a percentage of all cycles",
+             ilp[2], "100%"),
+      Metric("lpm_ilp_inst_ret_4",
+             "Instructions retired in 4 cycles as a percentage of all cycles",
+             ilp[3], "100%"),
+      Metric("lpm_ilp_inst_ret_5",
+             "Instructions retired in 5 or more cycles as a percentage of all cycles",
+             ilp[4], "100%"),
+  ])
+
+
 def IntelL2() -> Optional[MetricGroup]:
   try:
     DC_HIT = Event("L2_RQSTS.DEMAND_DATA_RD_HIT")
@@ -633,6 +671,7 @@ def main() -> None:
       Smi(),
       Tsx(),
       IntelBr(),
+      IntelIlp(),
       IntelL2(),
       IntelLdSt(),
       IntelPorts(),
-- 
2.51.0.318.gd7df087d1a-goog


