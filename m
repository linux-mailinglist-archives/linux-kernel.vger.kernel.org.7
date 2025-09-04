Return-Path: <linux-kernel+bounces-799883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C847B43126
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7C127C10AF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA92248F40;
	Thu,  4 Sep 2025 04:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZqUP3rrS"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2327A24468D
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 04:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756960343; cv=none; b=h3vuZ6OolFQt9rmT7g1v3Q7FeMxQwyFiamIthVR3EFb7zTc1Bk21WPcUx0aWKesH9XBm+TgtO2o4pgfca9PZY9gM2ZK46XR1ePPBf8niAmKPOyP7doi/fL7TXfDKgWdTUtura4T14Q/CPqC703r8T/kuvyo/Kwc17mxXx7JYsdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756960343; c=relaxed/simple;
	bh=ob1BOk0xpWJ/65Y/oICDF5KmX0QIsSHCj7b4gJHHsMk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=I+ugN/ZSdMkbQer99pNjzFd/7QyVzpSaBeklSL2Fofv4cB6d/viONA7lqNarmTuHztcWev9JCqLoYgmLrnM+71ai+K7xmNEEyco0t6yATp+pjeF1x7wMZAzWSawgx4g4kJlT0m69ayVwIR9SECo1FIj+TQk0kSRVpo3WbraHe3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZqUP3rrS; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-329e1e3b25bso535255a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 21:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756960341; x=1757565141; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DKUbez+xUjFw3Ps2ZoGOBYgPDtEbw+fIaql4cuAQlrY=;
        b=ZqUP3rrSVgtoeGTcs31aXIItu2XV6xQUqnALJWlnuTusN83NPX8slVoUx2gXJVJ0wf
         O0UCRBIvjadTGp5JRsW6HLgzRKT/nxK6FS515GGrDoXvxhstPL+Qxoy//CSb8ul9r7Az
         iZ0rJO/j0cLDR5S0YTJq1BU+y2HlHNfjFtlqiHDoRsWFKOdwYLfhURPaIP3KtfqRorZt
         Ca2IMuiTG81FemDe7ZLwabhIFY+PNOBZI3qmKJdGy6txg00FowuyJVn+YIXOqXpTkHsu
         2w63luYZYoz6J3Yiouku0bHVrfpNC8zP/eKJYwWeaHf+b8K7cP6msi2CK6/OgwOJpYZx
         t3nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756960341; x=1757565141;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DKUbez+xUjFw3Ps2ZoGOBYgPDtEbw+fIaql4cuAQlrY=;
        b=UZURW17Djbm8gaW/hgDD0aSWdrma6VXSkCbyPYWLx3zeSZ8FbgVK1Q5Z0KmvzvTCGT
         ijOc3ULyViY7X/ez5PPrVJpducBxrRAYKsM+tIqHXfSjU/ihV7bLpTHCUZ7KsfD70fzS
         E9FQ+KBTKUhQTHHYf6e1+zNT0+ZIVrS+rGeY1Fry8XlkZT9wiz+5faVxXKNXfutYN6Bw
         hhynAxKl1xo+8F0gsR545nWyZkNAIgQn9ZZB2NiZNwOXMCSAwPbdwHVLOV3ciPhAubIj
         h7qQHFMJ8xDZReXtdetfbSvvkZLhFITHtPKf7OlhBLBOohrN2JalpG1X+p5Jhp9XG9IN
         rXRw==
X-Forwarded-Encrypted: i=1; AJvYcCV97t7aLlF8zJglNwO2/8JA46eJu4Qfg38F/xerwrq0ZQmLli2NPCK9r8F4pvTxAdW33/3O7rn1h/lauyU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/3p6a/qJ3Qx62oft2Sz/6c76+BfOOKxcxwLk5+wALu0GYKDSB
	fsIJAbqP32xDFZlbKqghXqBEf4+vy6LzbXiRjs7QvjDfwAbGabWvkGBBDpWxueT9JTw82Ko7ii6
	PmObyXQPTgA==
X-Google-Smtp-Source: AGHT+IErc8+ICD+hbg4Hw78DlTvjcXZ3MoDT39jCspINC2OKdOchCVWJDAb8lKhuNbcoipstdiQEKgrpOLme
X-Received: from pjbli2.prod.google.com ([2002:a17:90b:48c2:b0:31f:2a78:943])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1e51:b0:32b:87b7:6dcd
 with SMTP id 98e67ed59e1d1-32b87b76f7emr2907125a91.14.1756960341131; Wed, 03
 Sep 2025 21:32:21 -0700 (PDT)
Date: Wed,  3 Sep 2025 21:32:00 -0700
In-Reply-To: <20250904043208.995243-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904043208.995243-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904043208.995243-6-irogers@google.com>
Subject: [PATCH v6 05/12] perf jevents: Support parsing negative exponents
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

Support negative exponents when parsing from a json metric string by
making the numbers after the 'e' optional in the 'Event' insertion fix
up.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/metric.py      | 2 +-
 tools/perf/pmu-events/metric_test.py | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index 847b614d40d5..31eea2f45152 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -573,7 +573,7 @@ def ParsePerfJson(orig: str) -> Expression:
   # a double by the Bison parser
   py = re.sub(r'0Event\(r"[xX]([0-9a-fA-F]*)"\)', r'Event("0x\1")', py)
   # Convert accidentally converted scientific notation constants back
-  py = re.sub(r'([0-9]+)Event\(r"(e[0-9]+)"\)', r'\1\2', py)
+  py = re.sub(r'([0-9]+)Event\(r"(e[0-9]*)"\)', r'\1\2', py)
   # Convert all the known keywords back from events to just the keyword
   keywords = ['if', 'else', 'min', 'max', 'd_ratio', 'source_count', 'has_event', 'strcmp_cpuid_str']
   for kw in keywords:
diff --git a/tools/perf/pmu-events/metric_test.py b/tools/perf/pmu-events/metric_test.py
index ee22ff43ddd7..8acfe4652b55 100755
--- a/tools/perf/pmu-events/metric_test.py
+++ b/tools/perf/pmu-events/metric_test.py
@@ -61,6 +61,10 @@ class TestMetricExpressions(unittest.TestCase):
     after = before
     self.assertEqual(ParsePerfJson(before).ToPerfJson(), after)
 
+    before = r'a + 3e-12 + b'
+    after = before
+    self.assertEqual(ParsePerfJson(before).ToPerfJson(), after)
+
   def test_IfElseTests(self):
     # if-else needs rewriting to Select and back.
     before = r'Event1 if #smt_on else Event2'
-- 
2.51.0.338.gd7d06c2dae-goog


