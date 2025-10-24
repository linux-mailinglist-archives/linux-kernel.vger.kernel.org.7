Return-Path: <linux-kernel+bounces-869334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC78C079FC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 20:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FDE019A439F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 18:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E91934D4CC;
	Fri, 24 Oct 2025 17:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cAJSdZA2"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4A534C99D
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 17:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761328777; cv=none; b=qZ9US80KQBX8klfQB8j8seBe9ljWAq1iiaDNJ06A7iIMJ1ezvZxbk9N75cB0ucOotlSJMQQK4fjzuVA/K/g0ZmuVb09NcYC3CLCrMFYj/P6tjqGk7y+p8q/iAsDA4hj9HlXwvKNaF160eCSt3pNOY0L1pPP/gb8pUJh3eV31ARI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761328777; c=relaxed/simple;
	bh=oyhHdo1LBjj0VodlYK8qf6Zt9QK2SSQps2VhISTUJHY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=GGMWDaawVVnOANscu+7vmnd0kusXIBQoKcTGzmc7axD4xcEf9ykOBq64Z0SvOBk0yV0YyUWp9F/Qie/wrOAlCETyrjfdQCdRpujh3jIFqkRPZvMmt+VyO+1Ac/bjPczkz24f8pH0oqff10gFpalxDpH8xlokCjLA3NNqtUHwvCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cAJSdZA2; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-332560b7171so2611778a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 10:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761328775; x=1761933575; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=doWCJlIodi2evuV1XPBQp6vnTKO7fG8Tf8DSVry8FPk=;
        b=cAJSdZA24nx+56SEGKBJ3XUptbYA1H3ScGHmJTOkQpScxbrTmpxjaQ8cMu8bRe0lee
         rsC1umRRF4JchjpOkJGeeQPNU6GQQHJdHEcNd7Uqy/Drb09sTxvzsih44QPjcpFMkw/p
         i7wtGcpyDp8chhxJlv4ucO2xBh4bRn8nsdAPpSwi/vYqf/i5/D22rgLm3+F8XKWVbCsE
         zNplzWQtYTNUClhEIEPMZnQEuKbb/UX1uUlwVsdttdrM5UNc0siTquMVp2iNo/4xoHiR
         k63K+Re8d7mcc1grHU5HeIakdln7eeVneTlkeatEdpxIMYQhHWjsY0jj8lM7oZLiNG0r
         5S+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761328775; x=1761933575;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=doWCJlIodi2evuV1XPBQp6vnTKO7fG8Tf8DSVry8FPk=;
        b=mxkXIJqt5i1/6/1s6jqN9HJ9OhD62fG/hUwWnllr8+8I1UMSGk/w0PuJz8psGs2Ifb
         jTWRmOHmUMYWGRWSTmox+AFfR+8N0S38Y9SIjFFsaxmzf1qnxq5yN7EE43fUESktZ+4a
         oS4g29lnoPR4syxYBWDaktbowiDP+0rFqNFzTKTSwW2CLmO5ADU2E0bJ5NniNKsC8TYX
         S6KUV2Vn3rk3AjsyEEWJ7QGd+LfGeodwv0Yv//5m4LYr8KT2J6UQOsoMLUoXBzykz+10
         6QdBp22MJdC99sTpf1og5RpVxDcTOGtYgd3LiJAJhVcAkAafHQJGrLxcztfmiFsSSKWA
         nD9w==
X-Forwarded-Encrypted: i=1; AJvYcCXRIkWVFSZ+f7C4UlTrBOtEFYJjCygpekgUNXoJTkH4E4AquJN8nlJwcJjt4lw69z6SRLGuQWigJfZcMY8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw5HxnMBdsr2prqMmGb+/reEUF8vJaYoZTFbRdZ8qN6B6Geq8+
	U0DQYu+kf9AWTDszuTigjbP1V5w6eEkF4FzEIDj3/k2a9jnD4HkTKeSyAQrqIemmQs6JU30h13o
	verVjwciFtw==
X-Google-Smtp-Source: AGHT+IFly8CqIb+NCd0ZCTDC/mipInJiYu7MMuTrzCPyxtjDDRcyMm2QdKhaWwsD4uTg7mLm18tnoe1cQHH6
X-Received: from pjbgx22.prod.google.com ([2002:a17:90b:1256:b0:332:4129:51b2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1b50:b0:33b:dff1:5f44
 with SMTP id 98e67ed59e1d1-33fd3a566ffmr4234320a91.6.1761328775447; Fri, 24
 Oct 2025 10:59:35 -0700 (PDT)
Date: Fri, 24 Oct 2025 10:58:51 -0700
In-Reply-To: <20251024175857.808401-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251024175857.808401-1-irogers@google.com>
X-Mailer: git-send-email 2.51.1.821.gb6fe4d2222-goog
Message-ID: <20251024175857.808401-17-irogers@google.com>
Subject: [PATCH v1 16/22] perf test stat+json: Improve metric-only testing
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Chun-Tse Shao <ctshao@google.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Collin Funk <collin.funk1@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When testing metric-only, pass a metric to perf rather than expecting
a hard coded metric value to be generated.

Remove keys that were really metric-only units and instead don't
expect metric only to have a matching json key as it encodes metrics
as {"metric_name", "metric_value"}.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/lib/perf_json_output_lint.py | 4 ++--
 tools/perf/tests/shell/stat+json_output.sh          | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/shell/lib/perf_json_output_lint.py b/tools/perf/tests/shell/lib/perf_json_output_lint.py
index c6750ef06c0f..1369baaa0361 100644
--- a/tools/perf/tests/shell/lib/perf_json_output_lint.py
+++ b/tools/perf/tests/shell/lib/perf_json_output_lint.py
@@ -65,8 +65,6 @@ def check_json_output(expected_items):
       'socket': lambda x: True,
       'thread': lambda x: True,
       'unit': lambda x: True,
-      'insn per cycle': lambda x: isfloat(x),
-      'GHz': lambda x: True,  # FIXME: it seems unintended for --metric-only
   }
   input = '[\n' + ','.join(Lines) + '\n]'
   for item in json.loads(input):
@@ -88,6 +86,8 @@ def check_json_output(expected_items):
                            f' in \'{item}\'')
     for key, value in item.items():
       if key not in checks:
+        if args.metric_only:
+          continue
         raise RuntimeError(f'Unexpected key: key={key} value={value}')
       if not checks[key](value):
         raise RuntimeError(f'Check failed for: key={key} value={value}')
diff --git a/tools/perf/tests/shell/stat+json_output.sh b/tools/perf/tests/shell/stat+json_output.sh
index 98fb65274ac4..85d1ad7186c6 100755
--- a/tools/perf/tests/shell/stat+json_output.sh
+++ b/tools/perf/tests/shell/stat+json_output.sh
@@ -181,7 +181,7 @@ check_metric_only()
 		echo "[Skip] CPU-measurement counter facility not installed"
 		return
 	fi
-	perf stat -j --metric-only -e instructions,cycles -o "${stat_output}" true
+	perf stat -j --metric-only -M page_faults_per_second -o "${stat_output}" true
 	$PYTHON $pythonchecker --metric-only --file "${stat_output}"
 	echo "[Success]"
 }
-- 
2.51.1.821.gb6fe4d2222-goog


