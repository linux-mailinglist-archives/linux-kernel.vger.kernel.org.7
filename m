Return-Path: <linux-kernel+bounces-898546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FF8C5584F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 04:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9F23D34BCA9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 03:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF13E29BD9A;
	Thu, 13 Nov 2025 03:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fn9tMqBt"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE6D2882CE
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 03:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763004061; cv=none; b=ugieS5bX1iq3NIdVmH1krSjMfHnY4fG3LalmSHBU2W213Bf+u+eY38w7tsem+43aMU/1D4Npc56ytMPgCyhvnlydByrJvClkKJa+s98pmp7QFVZR56fq2JYAdxJyi7YFFA2x2xN4YNnBtwcxZs7xX8Ch+CN4WJ4HeskKbSLMdI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763004061; c=relaxed/simple;
	bh=fjbZFVZ9kzMDzkzeahbLVTlZyu+IhPBVWCZ/lkymL2g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=RSbCuL57trdpa4y969I/hwtDoNJ+lWb0VCj11Ts2Tibn9zbJUYcLNVPwR4av16H/lDsZjPdLj6gmEjG1WrpiyHsibEOrlHexY1WH1jDNTS6zICB6GORUrwPd48oUYlL/KusVKx2NbJhs/lzx7E55F7gRmG9/rg2aiJcNrX9L9oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fn9tMqBt; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-29845b18d1aso4336825ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 19:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763004059; x=1763608859; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yus/JHJRfdxmiJc2DFKCHcb270q3oFWZc29urA1fcyc=;
        b=Fn9tMqBtSEop8xGyN+AnsCvnbtMKnTW1trD11CVCt3z+PVygOH4SM5eSlO7N2Gi/ZA
         lD4GTOJkFoUiTAykU7+6sgx9KmCemHY7j0QRDE55wboGhAFQvt6reZZsN71xNPlqlyeR
         pEVTi26cFGmeuTRoE4uOaeRw2gBucAwANVAL67BLYkryu+AMa2DJgF/JTkXlx/GiiM5L
         wVL9V/gm21tMqyLu2tYklgFTJS6ytqB5npdOOez1LtJwdgccYRo/V0fTnW6HPJjPFr+9
         qGM5TLtus2EGfZJF8VDPnAGrrtYrjqPAaCJitn7lcpltmLftPVdgjbas7Hdxcqy8mfnZ
         nHUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763004059; x=1763608859;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yus/JHJRfdxmiJc2DFKCHcb270q3oFWZc29urA1fcyc=;
        b=QXwD5WGz82ufEI+GeI+bUccC5jfgHLwWlsmLGTwyPdftA3/j+Kg/ldozCStTppEJEf
         ZYTTj1znqhhCFdcQTdR3KYtFJFSbPt2vb14PWt8elcGC0nyniBN6dBNG5I7v+7Hqe70a
         C9T/5gMpyVn8d6xEI+au4rliims5GsFcXVX2yyyXCjJWbf6MzB2D/xvhZtbO3tMgP7Lc
         Z53/CceGAAfHiyFwT5S+7eeM1LxrFjGzEo0cCuuIhoYGJbjRbTt29hIZJQMgcQGRxWXv
         k4qaaxcSqQ58z3ohJ2f2IDR6UEEQjLEOP8EEluaypyDMvm0/jusfYNR0IF5teiEq/vWc
         gFlw==
X-Forwarded-Encrypted: i=1; AJvYcCV/b//FINezIlZi0viorwQ8sCLXvKYQ5cMsw0OWd1uKQnLCHEusrtqutqrLlECWc5BieiFT3gP6CnPOH24=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtX+JD7YKb/wXQvtcXJVSbbpdpn34X+dzr9pn85BcK3TWg5RTq
	nVUzTXFg3qBdjBN5r0mSOQqNbB/8hpidVm3qN6TIkUI/m8Qg+pKklpc03nvOHKClreC+YfiYv+c
	svQzvwY95Qw==
X-Google-Smtp-Source: AGHT+IHOc4/ckeRmxoGeVZwtx6KFPt3w2ttsOfqKDRF0iQ7MW6VW8cxP/JuYnx3/yzVmxD61DqaDDrtvcmRj
X-Received: from dlbrp11.prod.google.com ([2002:a05:7022:160b:b0:119:78ff:fe11])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d2cf:b0:27e:e55f:c6c3
 with SMTP id d9443c01a7336-2984ede3affmr67609405ad.55.1763004058907; Wed, 12
 Nov 2025 19:20:58 -0800 (PST)
Date: Wed, 12 Nov 2025 19:19:50 -0800
In-Reply-To: <20251113032040.1994090-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113032040.1994090-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251113032040.1994090-3-irogers@google.com>
Subject: [PATCH v8 02/52] perf ilist: Be tolerant of reading a metric on the
 wrong CPU
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

This happens on hybrid machine metrics. Be tolerant and don't cause
the ilist application to crash with an exception.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/ilist.py | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/python/ilist.py b/tools/perf/python/ilist.py
index eb687ce9d5a6..0d757ddb4795 100755
--- a/tools/perf/python/ilist.py
+++ b/tools/perf/python/ilist.py
@@ -77,8 +77,12 @@ class Metric(TreeValue):
         return perf.parse_metrics(self.metric_name, self.metric_pmu)
 
     def value(self, evlist: perf.evlist, evsel: perf.evsel, cpu: int, thread: int) -> float:
-        val = evlist.compute_metric(self.metric_name, cpu, thread)
-        return 0 if math.isnan(val) else val
+        try:
+            val = evlist.compute_metric(self.metric_name, cpu, thread)
+            return 0 if math.isnan(val) else val
+        except:
+            # Be tolerant of failures to compute metrics on particular CPUs/threads.
+            return 0
 
 
 @dataclass
-- 
2.51.2.1041.gc1ab5b90ca-goog


