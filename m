Return-Path: <linux-kernel+bounces-791042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69224B3B171
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 05:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB1761C86223
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 03:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD75242D9F;
	Fri, 29 Aug 2025 03:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2LxhrLpH"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8069623D2AB
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 03:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756436864; cv=none; b=aw2b3ArGImngwaF5d7XbJBFT7kR8wxP2YYXJh9zD3neMRHvLEVw9TYOQnl/72rSPshr4fx+PYTnmGaeRA6PDOsDr9ihOUxWZyprmScfE6HRMxAFwy5pADFCz76BWO4ZFAzXXGxcTSsJvJWpiZd4p4rMHfunvfxfxX8QHnDkM72g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756436864; c=relaxed/simple;
	bh=WEaVVhSK/6Kzfwt0tio2m5fgLf4Kjhprd+htTRjdV5A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=phZyjLSuDhgWfegCXjbF7zcdVfG5WpKUOpEFcAwTb32cV87cZrWL1LGgD9Huq6TsECq6kNEA2EsnAvqULsdc7n7g0R/guJggJsTUIc/umpS/bAB5TkLiK9ADMr0j7OxuTAPFI+Jmc9qM+WgYLEqImlwgtBNKJXYOJdkbR050uv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2LxhrLpH; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-248fbfc35ddso14673305ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 20:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756436861; x=1757041661; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OvBU2ACyciLuXu2F8DfOv8SJAwYRyI89UgDkHEBBKZ8=;
        b=2LxhrLpHgalt7Akro+UCkUB1AVxt3d/wAQM2h+2iLti2fLutqnrWM9msrhvyi3POcI
         wmtemXS46JVF440JcQQtKxVReRswNXQwc+R7grMwNrKsLwUJvKY5g11FlVAr9WcGJyXI
         cYjsWjykGi96gjWv1puPCfwP+wE/f6pKcT+1UwXcMPjW00hkZ4Lk1weSpNM/aDQXSJ3/
         l0+UFbBz5vW2OcrexrMowwSesktpqmVnslu7eieutcneYeSIWnRlq3z+r2rfcWEf/Gbp
         1FyZ/aNfnf30XkQZhGbNxp1FV/wxYIFrWH+2aXHLcps2XZ3yGlxa6xMWrDwgGF1HZ+/z
         kczQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756436861; x=1757041661;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OvBU2ACyciLuXu2F8DfOv8SJAwYRyI89UgDkHEBBKZ8=;
        b=hDUzsAO+q2MEvBfms8TcxDSGuSTK0FgRyA6H+LxOuJq6rad64fF4TlB0Nd/GidRRrj
         0iPiZloLGy9gtm3GEtY0Qr7+xWa1zzY5Gk8zqA07iA9fziIItJKhu/0+VuE8FO3rRHi9
         eKtcR5g4RMHPH7ZvsQDyAc2cYlfmUMmgh3w853wNroVbk89qqD6jUht/F3nA527FiDS4
         gJuiMngmeUUUgIVbMnnyPHis+pEEpMhRn/0c1D46+ZDR7wSSPMDh46UPwCKQH9tUPMmP
         XvmZYsJhkKavRqawjB6bRV/Ho64nmJErChXoYMDN4wf5KxBc7hMSHmwHjT/m4FlkqV3J
         thSw==
X-Forwarded-Encrypted: i=1; AJvYcCWD/6+VKxYp34OQgQ+X9Dq7EF3wuxsMgPyCVDfx8FFqvgu/mab7M2LZpiL6cv/KiXwjgodFgsdNQYz4Ka8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgOeQ6DHGoCuJYAvK6e5datfx71LlGAhMBxsl8cO/KcZUUX0wR
	rGTugmoy9ysPdOTC/Nuvl0VuMttgnjmMc3wTcIR046SksKIcWxysn8x+GSQ/QBMJrCqIv4rivEN
	1c0owcDii5w==
X-Google-Smtp-Source: AGHT+IHba7bj3xJQLnoAbns1ymqnpb7bf2P0DkwLSlskvstOEnoDpXVS8KhuocUtjzKfuHN3Kpixn1JcklXc
X-Received: from plqs24.prod.google.com ([2002:a17:902:a518:b0:248:a265:c642])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1ae6:b0:248:84eb:74ba
 with SMTP id d9443c01a7336-24884eb7babmr151051685ad.50.1756436860874; Thu, 28
 Aug 2025 20:07:40 -0700 (PDT)
Date: Thu, 28 Aug 2025 20:07:19 -0700
In-Reply-To: <20250829030727.4159703-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829030727.4159703-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829030727.4159703-6-irogers@google.com>
Subject: [PATCH v5 05/12] perf jevents: Support parsing negative exponents
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
2.51.0.318.gd7df087d1a-goog


