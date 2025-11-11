Return-Path: <linux-kernel+bounces-896198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9748C4FD5E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 22:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37E61189FB05
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 21:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653AE35E55C;
	Tue, 11 Nov 2025 21:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="coniG3pH"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD3735E53C
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 21:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762896161; cv=none; b=A/whg24okBYZLmFvKv9RXNyfiQrjqzzzivlvx6QrTL+nBFKSU2jjI7uZdSP6KygsAtQWqIFaH07Iv9W5we+kThCImM8KOUBlWdBF/cRpTBtLDGwRNUfB0UNfOcLnxq4OyFVUsEPbkSvblj/mvvltrghfhxKfrl0+SLky3W3vrzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762896161; c=relaxed/simple;
	bh=vsAC+bALI30qElPFV06AjAurdz8WlWhRwpAQxUMz2cg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Eex2MdYkRPejWVcCjAbvXEeHFn9l5r0w5aUrIykt2W4gNz7NmLOEDPS3RRJk8LFTCixxTXI7cQoFl+TCRqPmUejbmEe/JBpSeYgBofMpHgBwHdiVVpYKuLmexbrvqx/SNAWSKm+YHz/gZC0EoPICt1gterVfLYP760iwN66jA2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=coniG3pH; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-297dfae179bso3450325ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 13:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762896159; x=1763500959; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ScLENsyYSFxSsSXeHlp0LDfphHjWjgXO0/fUWwSEsxM=;
        b=coniG3pHJaGgCepR4lYGUulN7vqvFxpIT6o57Dlz/j7voUP+4mFUiDLvtt+ztPo2y9
         qu0XdU2KNBWJvBm9iulY1L1xTdhuGwhHY5NuMJNIvYUW7DlbELoxtrsh3pyINic9DiXH
         OEshMbjYSxF/LGbloZfHqeThDDzEQ8zQWGvFSJvcZRkXJ1JjNgN/QNd4KK/C7ObK4Jzy
         6Mw9q+xli2M5nsgxvu9FsbK4cfLR7SzcW6GYm7dNkIHQTlfFau7ZkG8kjfPIuE60TIB0
         iwLgUN/ggLAyRxPzFpdNw+KV/0oWQT6aGFBfiohUDeuqw/er9O8Q6rgSpC2mAhPwAy7y
         w4Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762896159; x=1763500959;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ScLENsyYSFxSsSXeHlp0LDfphHjWjgXO0/fUWwSEsxM=;
        b=cTgBXc6x/6b6CLYP9wI+38jrF1zeVjjfDoh2JU1cERXCNetg/EizHevv6wwN3zU58U
         uvjoCzVMwS7Y975ql3jvmT2jtijAtB/HHuE8a+gU1xiM7D+THiOCbsSK9qn8ZTRR2MB1
         5MZFCcJriF9xGdErAQ/gcQrLVW9+QHeoXaXJVAEz9SjvbmOMTh24LRifq7YH5uobouCk
         z8pW82+2+JKJVC5iWEdO4RItaU4HXj08WKncs1dkrUsR3Kz6e9kJ5tE8KkOdHFSpPUF8
         Z/lKlLnsdDMDkQ4sqkbHh6xZt5yQKARReefZ8J+YdjAzaI//fAbCV4IixjE+40XOsfoM
         +z0w==
X-Forwarded-Encrypted: i=1; AJvYcCVGav2PD/WBWJcicc1HEcwwl9kZDlhhFQCjXhcJkYPEngoKtExtTGWFmaVvyM+sr1CzLkKWwUCpv9uoYKI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZBAUF+C+2z5xyLM7rk+9MzppAsJYlu212B9p7TL1gT4G/nouS
	yjYDqFqs9nRCfTEjXCH7Z1bHvFcmnM0M3adUQqxdQ/hh/FWodvcGC85TwWtBWF12r+M9qPk2cap
	Yp5yK3czDUA==
X-Google-Smtp-Source: AGHT+IGyBb3NWbtlDfa779ZrbxRMqg57a9R7F/3vf9mUBNem1tkTuWomktDqMFzF0JhAPH3WqspGueo1CvY+
X-Received: from dlbsv8.prod.google.com ([2002:a05:7022:3a08:b0:119:9f33:34ae])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:dac3:b0:297:c04b:3a3c
 with SMTP id d9443c01a7336-2984ed2578fmr7507915ad.9.1762896159007; Tue, 11
 Nov 2025 13:22:39 -0800 (PST)
Date: Tue, 11 Nov 2025 13:21:59 -0800
In-Reply-To: <20251111212206.631711-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251111212206.631711-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251111212206.631711-12-irogers@google.com>
Subject: [PATCH v4 11/18] perf test stat+json: Improve metric-only testing
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
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Weilin Wang <weilin.wang@intel.com>
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
2.51.2.1041.gc1ab5b90ca-goog


