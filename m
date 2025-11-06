Return-Path: <linux-kernel+bounces-889507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD95C3DCA2
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 00:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5F17D4E8687
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 23:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011BD359FB1;
	Thu,  6 Nov 2025 23:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MvbgYCNX"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73319358D22
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 23:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762470962; cv=none; b=RIq2DGyB80igx5qDe/k406V2O6sG1uKBU0SQ1NmDJV3yFojcE2GS1bg1MLpiJvQ7O3E9hQDtgh4O3f8UYegn/VYMXxkWiHlMh8u8g3OrCdf46dnJGTgAjunoLtSN3nVPVVUW8oWjrjZaO0WpbF51aIQtX+Yw5RpL1dcORfD5beM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762470962; c=relaxed/simple;
	bh=vsAC+bALI30qElPFV06AjAurdz8WlWhRwpAQxUMz2cg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=bLlz2fYvP4rrogOC2SaHDQkPk/4erEXRWGnqfJcz7F5p5cIHhQE3CtaZ02NYP5WdLni9daZr2H0E3RuHrHnfiYJPCLOkRy2KwyZBvnLRVnKhVlA45UVR8a6707NLgPxZCQC3jnwhqF1NNNVRCYRLTB44T0Y4TVx5wAk/HQoQ8fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MvbgYCNX; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2930e2e8e7fso1949375ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 15:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762470960; x=1763075760; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ScLENsyYSFxSsSXeHlp0LDfphHjWjgXO0/fUWwSEsxM=;
        b=MvbgYCNXDgx6Kez59C5aClvU6tiGpApTI4UK9WJEE8bE11buT/K3A9GSB6z2MMLcWI
         XP2uj20eENuvWWaOkN9Rm8ahGTVQxXs36dLVp+BkGV1Rf6Pckbv2sqFYzwbz65+ej8bz
         XZH0ZcorUrFmcmBOB6DtA9bYgrS22K30rs6IJj0MkwL4+bYw6vc5J7lXtYLej3KbMnED
         H7s7wIax7lEphBxryMNMxdBeN7CdZANKeX/2x0TGqYTkKTClglepRJc/ojeiVPr27sq1
         eqh+47W/6KUrP3g93oXwPpoX9ZpNs8UzUY5GyMdoNPPQvQ67+kNpzhK4M1172DKAEA5V
         r7wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762470960; x=1763075760;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ScLENsyYSFxSsSXeHlp0LDfphHjWjgXO0/fUWwSEsxM=;
        b=mztfP/r/Efm6YS/hapFL7hdorE4Td7qy+VlEoODYXyfK04n26KNvixC+xLRAF1V9Cx
         EwhnS8gwY/xY2jNpoDcnH9h9M/RO6SU2VRbLMb5GZxb67OyaZBDMcA9Va4TA7dkMRXk4
         aa+2UhWK+JkcXzW+PnDO2uNnmfS1waLp0/INq5DR8fSgezdvKJKnKbrJDAwG+hbj9AWz
         ZjtTSbRsn90mtADnSQH4WRiNKdQ1upwiSfhstWqnbBr1usN/ah2BQ5b6K3icFvKqqHd4
         xizeqGfi1JL6EMSXNEZYH5qrVjykL8vcVP/IMtiL78bw+n86Qmd2eyF8ej9L7Bmuazp3
         oJ/Q==
X-Forwarded-Encrypted: i=1; AJvYcCW7ljOezDM8Mmthku8ggIPFBaWQtxnqthpn9h9648W5kFUkfX3/OVHzF/7eRe6RvfXWarMqxk0xPgGGA9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1ogJIsOl6YH+3Fj7ALnrm4sX1l3O/rdLlTUTMncRDXMB21gps
	/EIQl7eyMnN7GOnCo30nJLlfK/6snUyATFfpFizCyuOSIQFUY1NimmjzzyyBpBJ95+DBaUG5Glg
	cnvgdeeiSkg==
X-Google-Smtp-Source: AGHT+IF7+Q0cPmYHz5/abpijevA/om0VtU1+3MKAlA1OEDRxVqteWbaXmduw+smzYLuvecGGWKpEaTo9uj7A
X-Received: from dlai18.prod.google.com ([2002:a05:701b:2712:b0:119:49ca:6b9c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ce82:b0:295:5a06:308d
 with SMTP id d9443c01a7336-297c03a84a8mr14347725ad.14.1762470959559; Thu, 06
 Nov 2025 15:15:59 -0800 (PST)
Date: Thu,  6 Nov 2025 15:15:01 -0800
In-Reply-To: <20251106231508.448793-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251106231508.448793-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251106231508.448793-12-irogers@google.com>
Subject: [PATCH v2 11/18] perf test stat+json: Improve metric-only testing
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


