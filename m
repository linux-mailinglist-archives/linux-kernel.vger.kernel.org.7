Return-Path: <linux-kernel+bounces-898573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 643A4C558AF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 04:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 53C9C34E980
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 03:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6705E3128AD;
	Thu, 13 Nov 2025 03:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I2/eN7Md"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533F22C0272
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 03:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763004105; cv=none; b=Z5xkMQwcVILz0+IhlLrQyc/QkSPHtWBo6G22Ei5VuOCacQcGPrrKiVYxj7AM54SzeD6fHpOEa9D73rK1TjKblAJfecZoKAfGSNqOQtoo1kQ+z6LHTJ08JbcoyAkmqTVWQEBB90sKSmCb6COwJ+Ax7jdoTKmtEk8vZyGWtWImv88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763004105; c=relaxed/simple;
	bh=pV+WNDCnQhxRvnfIi+n4K9mLvGVMQOvtB4c39yFsGdc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=UpsRi2o56wJgECiILXZOS0wbvqYsSruK6t/2oWMs0cSO3qvu/o0yVcFay+WAKjO73GAOlv1re/vBGqYjTHNZZGACi81KDUT+4u16xqWzABzACfS9veyfTUwzycEU1eiuGd0iJytnlihfq8X5yYXKaZQl2EbeQBikW8WxQf4tiUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I2/eN7Md; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-29845b18d1aso4342115ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 19:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763004104; x=1763608904; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IPV3zg9wSus+6cMKVH3VLLLSx6vn2lsxLF5v17k7AMs=;
        b=I2/eN7MdPqlKe6MgnqD5pPzgkjYUrVdRy7RMcLMDve5rWqxFAX5jNiESDLXV0qwAEc
         MohaUum6nd/K00AxsbmijaXdEHWcNqF55vhbhFqkXwCzWjvGc3oe1uSVJvkNGciKRdAQ
         lBqSOjpEr6V1DQ2WNzhalAdOZRD+KQv8i0MqIFCmUvoixXb8WhSmou+Nawj1FDLmjXyp
         22jZOPMHE18MC99MsvKz6XP8eyjp3zHof814BVjcfScNdxRw3HjkCwoD9Ru8pF17nov8
         Xs2KsYtpWlIxBU/iARG3ybS82zR9k9OYvdDYsNm0woaNdB2KzzWYRdhryNTZ71pnZREV
         RgBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763004104; x=1763608904;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IPV3zg9wSus+6cMKVH3VLLLSx6vn2lsxLF5v17k7AMs=;
        b=ZLjj1GoBdlJL/FWC0f1HTMjirgXvZWWdxD3ack445YbpE9vuK7/tSAzuR+GQxu4/Di
         GVYV7ntNkpQwF4E/0F4lCruc50ry9PtjtGEylh+uU0IVxHhI918Nc1dmwwNw9kEF4+99
         UPkXNSPBlUF5sjvTbFciLypCIn4YreFPDatjSWEYizO0aQiaIim+k0sFwDouh855uzRl
         xkwSU76+3Bkl+dwBY8dZrGghdlPtLaKICnzhv6cPgkoKMQeMMOKWZTKFAqzOiAbcLRB4
         8M3KpcM67Ijr9+exvOMgZh7qQBu8J8QXmj1+VL/bXaXEvfk28YuUsE0iSEJRfOOMDaTf
         UUHA==
X-Forwarded-Encrypted: i=1; AJvYcCXLl6Mi4OkQJdowAgllJl1angwzykfJGJLv1Iu2jiY3RzYNpKoKlGuJX0SaZeGXtvvDWXNfU1R2Sgl8G/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQz8Wh0FyZB4s8Sn1Gk9a9MlptXQ4Fq/WhprWWxnXY9M7EzTsA
	UBODFmMmDZi4IaDQIlXN5ai4d+HsH1M4Q58IKz+FPglnzEB0dmZpEKllt5NEF7cRTqoCx/SxKmD
	hUJv2iD8f8A==
X-Google-Smtp-Source: AGHT+IH5cxaVcOC+y4AvBWvi6GKryT0Q2SJ3dneyb+9AFzWpTx/cspqaQ01uen/DoDcrnOuBsV81qjgbqpSK
X-Received: from dlbbk11.prod.google.com ([2002:a05:7022:428b:b0:11a:3780:4b65])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:11c8:b0:295:5dbe:f629
 with SMTP id d9443c01a7336-2984ed2b8bamr51947665ad.8.1763004103707; Wed, 12
 Nov 2025 19:21:43 -0800 (PST)
Date: Wed, 12 Nov 2025 19:20:14 -0800
In-Reply-To: <20251113032040.1994090-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113032040.1994090-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251113032040.1994090-27-irogers@google.com>
Subject: [PATCH v8 26/52] perf jevents: Add context switch metrics for AMD
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

Metrics break down context switches for different kinds of
instruction.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 33 ++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 9a39e23075b8..da50337557f5 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -121,6 +121,38 @@ def AmdBr():
                        description="breakdown of retired branch instructions")
 
 
+def AmdCtxSw() -> MetricGroup:
+    cs = Event("context\\-switches")
+    metrics = [
+        Metric("lpm_cs_rate", "Context switches per second",
+               d_ratio(cs, interval_sec), "ctxsw/s")
+    ]
+
+    ev = Event("instructions")
+    metrics.append(Metric("lpm_cs_instr", "Instructions per context switch",
+                          d_ratio(ev, cs), "instr/cs"))
+
+    ev = Event("cycles")
+    metrics.append(Metric("lpm_cs_cycles", "Cycles per context switch",
+                          d_ratio(ev, cs), "cycles/cs"))
+
+    ev = Event("ls_dispatch.ld_dispatch")
+    metrics.append(Metric("lpm_cs_loads", "Loads per context switch",
+                          d_ratio(ev, cs), "loads/cs"))
+
+    ev = Event("ls_dispatch.store_dispatch")
+    metrics.append(Metric("lpm_cs_stores", "Stores per context switch",
+                          d_ratio(ev, cs), "stores/cs"))
+
+    ev = Event("ex_ret_brn_tkn")
+    metrics.append(Metric("lpm_cs_br_taken", "Branches taken per context switch",
+                          d_ratio(ev, cs), "br_taken/cs"))
+
+    return MetricGroup("lpm_cs", metrics,
+                       description=("Number of context switches per second, instructions "
+                                    "retired & core cycles between context switches"))
+
+
 def AmdIlp() -> MetricGroup:
     tsc = Event("msr/tsc/")
     c0 = Event("msr/mperf/")
@@ -636,6 +668,7 @@ def main() -> None:
 
     all_metrics = MetricGroup("", [
         AmdBr(),
+        AmdCtxSw(),
         AmdIlp(),
         AmdDtlb(),
         AmdItlb(),
-- 
2.51.2.1041.gc1ab5b90ca-goog


