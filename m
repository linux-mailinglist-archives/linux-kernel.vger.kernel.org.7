Return-Path: <linux-kernel+bounces-791040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE6AB3B16F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 05:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4350F7B8F3B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 03:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282F8238D54;
	Fri, 29 Aug 2025 03:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E7QxjNIC"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200C62309BE
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 03:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756436859; cv=none; b=Y+/Fw9eRfrAOhiGWLZZiQTHz5ywddz7bE5fKRZjUUy1PpiuBRpsUkPrnwArktt5nS5JsABs8VD1YfG7maH6CHReU4EE0a7DyHcu4vuj8EKWwn3OCDbxBQTR5TFWQpOzaHQqam3Wwnn6zq3+xeNk0eh3voSf9u1STFiw4PIgpOWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756436859; c=relaxed/simple;
	bh=2SPnKIFCU+FQBYmrghSz9B73YgOF3w87PVycTgRd918=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=eBA6VTMRY/lfkZlZ1+9rgm4ElfiWdIEjU3uBdabUFgft9a1VCwcntkrgUjCxfidORtkA3L+bXmSyN3Y5OaezEEb+ePIIMSdNwmwDCQS6gNyMypZzEFpdiNLy5hAjDCyLJqgUuAlXU4XK8LFNlp4FEoxPbpEHmknL2gFUO1aTiOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E7QxjNIC; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b47174bdce2so1327364a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 20:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756436857; x=1757041657; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wF9CmQztZ8m+ClwavvS0RwKzE4shCD55tHGvz6T3N3U=;
        b=E7QxjNICA3TGuUks7yjnoMKY8MPqj8J5SDks4QfTZzo8BGnqjUHYm8NL/PxjEHLy0i
         /FFmn+e7xz0lO186z1H1iv2xUuOM4ElZqDYRvQlaWPyhNvW/CyqGYu2Lz611E0h/7wpm
         FFZNTLtjbUSenM52L3ZaoyUhZYlEpjyycP9XgDIpirJsf3930jNgST61nSvmL8eHkDx9
         C3vGUJJ5u+z3lz3RaWVInpRDCLG9rSbQy+dpUQ+lZ6lDj9Q1Ev9ViuB8Pi4OmTil+0U2
         Rb+JDE1IQpUl0Xi50S1xNKjSJ5bkHdSsiakANXeuRkv1m+eyEZl7WwcbWjPBzNFEfcVh
         SniQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756436857; x=1757041657;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wF9CmQztZ8m+ClwavvS0RwKzE4shCD55tHGvz6T3N3U=;
        b=dU+NwW4Qz3yIlAkmIQ1f0MNnMi1ANL4Nwto3G6KMCePTuCOd6swNRCXtf14M5rdAxc
         IjQTBbWMM2icF1Sfd4pHG6eS93Zkeqb40ttVoFKEUDuHgpyrDamt7yUD7EDL4CXwEkEn
         rAIDNPr60Q1+T56035BoegLGjz2+W/Fm5+s5blw6/JaTWfewPvlUKDdgGwylK8KCQ5jK
         KE5+VpjjNjZihWZEvhwWLiGrtUnUa/Yhtp1s8s3+3hvhiKJWgR40zm5FhSCB5GNI9/1w
         re+4lp22gVRJuL3x/g3XGKZ4bEmZX2oDzfIMNP6pgTmQjG9MxJojXAIVF/1svLfXlKjk
         Pang==
X-Forwarded-Encrypted: i=1; AJvYcCUjY3REcaKYsK9xehNvqxpuI2GJMoLFgnP24aLORlr06qego7qtkF2ywJjuZ4tRT3ROvkq22ESS5kXdyaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzegFU5HHIX+oR46LzPwsU63fu/StL8V/5/3EvxMxaF/8inEbSw
	QUmGhiWtb/4pbus34BmBXvOXaSex46ucIBPPPR3Ny1wM5eBmRPxCjEvTuNmZSNy7wAspmyzVc1n
	w/9d8CWjTqQ==
X-Google-Smtp-Source: AGHT+IELgHMT+riRT6ooQjHoRr7Egdxg8DnVNOmmHcV20ZKxJTX+CwreDH0HXsKO/ZJVtC9CnbSyJrVGPJgH
X-Received: from pjbnc7.prod.google.com ([2002:a17:90b:37c7:b0:31e:d618:a29c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a03:b0:243:b20d:5df8
 with SMTP id adf61e73a8af0-243b20d61bemr6950671637.10.1756436857397; Thu, 28
 Aug 2025 20:07:37 -0700 (PDT)
Date: Thu, 28 Aug 2025 20:07:17 -0700
In-Reply-To: <20250829030727.4159703-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829030727.4159703-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829030727.4159703-4-irogers@google.com>
Subject: [PATCH v5 03/12] perf jevents: Add descriptions to metricgroup abstraction
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

Add a function to recursively generate metric group descriptions.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/metric.py | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index 8a718dd4b1fe..1de4fb72c75e 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -475,6 +475,8 @@ class Metric:
 
     return result
 
+  def ToMetricGroupDescriptions(self, root: bool = True) -> Dict[str, str]:
+    return {}
 
 class _MetricJsonEncoder(json.JSONEncoder):
   """Special handling for Metric objects."""
@@ -493,10 +495,12 @@ class MetricGroup:
   which can facilitate arrangements similar to trees.
   """
 
-  def __init__(self, name: str, metric_list: List[Union[Metric,
-                                                        'MetricGroup']]):
+  def __init__(self, name: str,
+               metric_list: List[Union[Metric, 'MetricGroup']],
+               description: Optional[str] = None):
     self.name = name
     self.metric_list = metric_list
+    self.description = description
     for metric in metric_list:
       metric.AddToMetricGroup(self)
 
@@ -516,6 +520,12 @@ class MetricGroup:
   def ToPerfJson(self) -> str:
     return json.dumps(sorted(self.Flatten()), indent=2, cls=_MetricJsonEncoder)
 
+  def ToMetricGroupDescriptions(self, root: bool = True) -> Dict[str, str]:
+    result = {self.name: self.description} if self.description else {}
+    for x in self.metric_list:
+      result.update(x.ToMetricGroupDescriptions(False))
+    return result
+
   def __str__(self) -> str:
     return self.ToPerfJson()
 
-- 
2.51.0.318.gd7df087d1a-goog


