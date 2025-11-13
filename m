Return-Path: <linux-kernel+bounces-898550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F34D6C55862
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 04:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A21A13477E4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 03:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345F72FF663;
	Thu, 13 Nov 2025 03:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mkDeAIH3"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287442FD67B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 03:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763004066; cv=none; b=eQgS4qnohh82GoAG7Jnta+bz5n5F3m3bXxvVf3tBWCvKBjz3PK4JLv/DUZqeay/vgKqStqlyML9XCloHlkvzoK2scQbFKf73+x7Wdu6qanHrffeQVjiRlJSaNFVgilx3Le0dN7fYYmJZjP6Hxnjl0Ex6LtXQGpVAkLGTUAjJBes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763004066; c=relaxed/simple;
	bh=ll39V2qdoFxHdFFwQS3a8L9s3zT2jLussMPdlxPuhUk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=drUPhhyVyBZGYv5cWwQr7uhpc9rO2YxDlG55qEmuolLf5UwD/SHlASepVdl4jMGb6Ufz2446LsTHmqk3U0kQvlze/Y6OwwBaYCCC1OWdM+pPxFAgkuBleAE6W7g1ZRqm+KpPiJiBCgS+uf3sZrfePKQcoaIeR8PZ5cC99Q4QAgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mkDeAIH3; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-297e1cf9aedso10152825ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 19:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763004064; x=1763608864; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CXTurUZpdKg+xkGscaUyPXmPr0z9dOgdUTkRa+Mc/0U=;
        b=mkDeAIH3P8quIpNAuJMrD0LkXarOL+UDVqFFQmO7BOGYXfPo5PIHMhrec0zIOFAIVh
         FDUwH2bj6mhhzHH+QdThVu883n5rd59RbxYLXC7V+VsHW3pt5P1MYP7ENd3DSfnkFKuD
         tQIN2L6JAg/spK45oCjg55/sPF2QMIvg/XIB6rFTWe/AyOpN7IDTV7d+CaeflAM/dbFg
         h6Qqx8Teavb//hLJfGgZVrvbrrILtq1imHPqbKPpaWs4QjHWoXWjaKHhRmKp/iWeQl3j
         TbsJ9gcsgOSvEJZ/61K7p11mbwQkeX6Ifyqa8TWTHRH+f8OYWDImorJTfNuARIuixVqD
         E0ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763004064; x=1763608864;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CXTurUZpdKg+xkGscaUyPXmPr0z9dOgdUTkRa+Mc/0U=;
        b=S0tx0dQC7JN1sXT9yNfOn3sz+QUcgXfMA+ApfEQLL/SNVK6gjbE85j7yn3mmr3YtWV
         4aDX896Qj2HsSYDx9Ti3jZ8P9h1M8Ss9mqD+2yfnAvNGXo3jRVaASaQkGjahx0WodMTU
         +gnG9J/HvW8a9Odqny6qliYR7VcFZB+CFmSgqy1oS8HF24E+wpRfEPY6ZfRBeNqyRQSc
         IPYyXckFbtSRY5H6BgZZY1gYoY6FJENMdEWSm0ozdUsmfEq5QTQYEBiw2CenKrhRm3A0
         L9OgHUhx6JvqtPlL2craBFAMEJfTEX/8TKYyQyBKu2tIcSPCUriDoD1A9rU9vGDrMH5G
         KU1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUjuCvoYhP6MMjRd34RFOYBWdWoqNhx/q24KtY37TXJpbbab15InqRkEHZLjkKZb79Y2IGa7xnvs2gvoTg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7vI4BbrDv9DMrfsX4gQW8j0v85nqiAgGYoMeBYhLRn6bsMBJg
	BslxmbqpAlMYFA2USBrEOBsSosJ81mih6bVMTZRnzV2aFzHFox+RRCwWsWgL/mkbTQ3aCW3+iLz
	1lowSeTOofw==
X-Google-Smtp-Source: AGHT+IEKgZ/z1qqfBO071TYiJliOPUoShccQ7ByZAFpOF3Zn5qVPoXNpZu78qaoxOaZX1PoMJsYDKwIMOxus
X-Received: from dybkl22.prod.google.com ([2002:a05:7301:d16:b0:2a2:4de5:16b9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1b63:b0:298:4ee2:19f3
 with SMTP id d9443c01a7336-2984ee21a2cmr68729945ad.49.1763004064248; Wed, 12
 Nov 2025 19:21:04 -0800 (PST)
Date: Wed, 12 Nov 2025 19:19:53 -0800
In-Reply-To: <20251113032040.1994090-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113032040.1994090-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251113032040.1994090-6-irogers@google.com>
Subject: [PATCH v8 05/52] perf jevents: Add descriptions to metricgroup abstraction
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
2.51.2.1041.gc1ab5b90ca-goog


