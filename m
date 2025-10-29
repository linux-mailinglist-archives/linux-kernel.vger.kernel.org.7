Return-Path: <linux-kernel+bounces-877259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 57555C1D963
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 23:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 263164E0385
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 22:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C33831D377;
	Wed, 29 Oct 2025 22:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0rlXNU2h"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB0B31A81C
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 22:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761776813; cv=none; b=huLoAKPXnLsuzONIdd8ZBCjIEvZ2+FqW9ho58lY+5wjYQysN2Jr1hPEKKlXejecEhOcMpnUSdH946L3vKYcowEyDbLR/ssS3Ivqgs2nYThiIg1LHCapTwhrienHEWBZJsu6pXI5Iy9rKQnMGfTk2De3TOwTzAMktlbXnP0sH+rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761776813; c=relaxed/simple;
	bh=vEml0nY7zwMEBRkTxEnZxDojqNcE+phmONas6Xsz+6s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=HeSUFsoqSJe54OA/BD+ByLP5w0K3UCcmqNjvWKg5SqqymwcaYcyfxaClPy7s6L2qvY++T8fXGpU+s3uNdLOK/06gaXBTW1oTj4IQIddJKibOebOEgkU4hk/gMsyZE6HXI9/wwOaNjMHTLpKYYt+8MQ9SlOAHVdF4JreLYXE58YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0rlXNU2h; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-340299e05easo313852a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 15:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761776811; x=1762381611; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aF7r6sKwQInSld9XZOaAVT/TCE0DKpB4OW2lzWtXOuQ=;
        b=0rlXNU2hs73kXXIDNeqLEuWo0rxa3tu/jz4TNQo/I4V5CT7DQiMMKhPaEuJta30cd/
         301eTLzR3B+3e/UOHg5sWKqzw2k2xVYNhoNAuE0nGjohS+mMfE/8xvjbZnuOlOLSUi9M
         WBRq7xY64EyyD+I79mpig0PiladSr5PaARXJKjHdKhaAa2SBRAf3crLzmvh3gXylmscJ
         t0AX7ysH8FBLEipSIR9uX2DKWU158TyrhAR5elCOA/qtGdY/xe0T+9RqOi1U9V2CCX/y
         eEKkpqRHxjgJUw89Pt0hdD8qf7Sh7fMtBN2Fjuf4rCjp2hR2qnQxaR56O3ugtrQlIxC/
         6UCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761776811; x=1762381611;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aF7r6sKwQInSld9XZOaAVT/TCE0DKpB4OW2lzWtXOuQ=;
        b=byK3GNTcZ2/3UmNp+BoQMWBDPYlPiRnxvOrYUuEaBP3TsGGxvnDztNI986q9y0N+9J
         QjjP4SXxOCFXQDXNb9VfVMcJZLXrJK2wBp9gjOqNgq4Z3cgmSoB/oRc51yD9V4YKmT8h
         ImJqd2rOc4dGB3ubeQDikP6ABi/JAk9EzPIERUOosy32qmjW4otaRjyR86bo5d+EmfSH
         Qx0HWu0opd0joZom6TC9BiIOK79BNW4jIQrdKCGmQwoGay2t7wucJVoSen9jlGayzc3e
         nDrhcWb1ZA9XsDE+NHTLmjebLecUQrfT0Lie7oGq/Qe2Nx5871r9fB0xdW964afyR8kA
         ciYA==
X-Forwarded-Encrypted: i=1; AJvYcCXo1aITi8VcoGj1Nj1T2APljcbjqhBD8yrPTJhRlztRPz5Nd+Dj2S07beXGyS5/HDInv3QTRWvbFKdqUUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYCPIiA65nPquL9MYjt3j2kSpPak91i74CtlGH+MshMO9VahPl
	hDWTiJEV+/GQjca4ZtmIEdIq1dTBUL2BOkBRevavCPEXqyzJu2Cbmisbyc9mElSSZbmP0gpTsnI
	a+v1De55ECw==
X-Google-Smtp-Source: AGHT+IEO3ovuPS0VCt6iHCKTFMfXaor12qZK+08DOWiHvRPGBw+3szq4fFwRy/zyWRqpfvILEZlt1XMSmDeG
X-Received: from pjph23.prod.google.com ([2002:a17:90a:9c17:b0:33e:384c:7327])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:28c4:b0:32e:1b1c:f8b8
 with SMTP id 98e67ed59e1d1-3403a2f1869mr5703128a91.26.1761776810838; Wed, 29
 Oct 2025 15:26:50 -0700 (PDT)
Date: Wed, 29 Oct 2025 15:26:38 -0700
In-Reply-To: <20251029222638.816100-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251029222638.816100-1-irogers@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251029222638.816100-2-irogers@google.com>
Subject: [PATCH v1 2/2] perf test: Add test that command line period overrides
 sysfs/json values
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The behavior of weak terms is subtle, add a test that they aren't
accidentally broken.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/record_weak_term.sh | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100755 tools/perf/tests/shell/record_weak_term.sh

diff --git a/tools/perf/tests/shell/record_weak_term.sh b/tools/perf/tests/shell/record_weak_term.sh
new file mode 100755
index 000000000000..7b747b383796
--- /dev/null
+++ b/tools/perf/tests/shell/record_weak_term.sh
@@ -0,0 +1,25 @@
+#!/bin/bash
+# record weak terms
+# SPDX-License-Identifier: GPL-2.0
+# Test that command line options override weak terms from sysfs or inbuilt json.
+set -e
+
+shelldir=$(dirname "$0")
+# shellcheck source=lib/setup_python.sh
+. "${shelldir}"/lib/setup_python.sh
+
+
+event=$(perf list --json | $PYTHON -c "import json,sys; next((print(e['EventName']) for e in json.load(sys.stdin) if e.get('Encoding') and 'period=' in e.get('Encoding')))")
+if [[ "$?" != "0" ]]
+then
+  echo "No sysfs/json events with inbuilt period."
+  exit 2
+fi
+
+if ! perf record -c 1000 -vv -e "$event" -o /dev/null true 2>&1 | \
+  grep -q -F '{ sample_period, sample_freq }   1000'
+then
+  echo "Unexpected verbose output and sample period"
+  exit 1
+fi
+exit 0
-- 
2.51.1.851.g4ebd6896fd-goog


