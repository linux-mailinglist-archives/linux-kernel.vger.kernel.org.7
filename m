Return-Path: <linux-kernel+bounces-814926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E2EB55A7F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 02:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2269E5C0A17
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 00:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE264C83;
	Sat, 13 Sep 2025 00:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gP7WqKpj"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F3F1607A4
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 00:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757721695; cv=none; b=KoQ/ZJM/U5LS7H33M0PjKqZTfS0b9soQg1k5hYZDLJj54R/BezTsZDAMdlQFFB3f+IRTBKk6sqtB8hq2U6lURiMTaCp4kRdeezPJ5F94UJVmMENmhZMC9IiBixrbaKxDHMzwGqtqsJRa5TRtTknigsd8VcagtrdqOZ1Kn3Wn5wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757721695; c=relaxed/simple;
	bh=hCsy/qb5fsV4U/ZfD33cto6EmCWWefY4GtL+u9D9szM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=AWEc6la6SrfN2hw7oSRb9gq1B7f11b6hHIc8iWulDN1QqaKdGHTtfjWOjzTQHb3rhsaMV0XDcf1fyFXr2aKf2iV+a8fNW6mQv4X1KI3fhDNI34S/f+L+dWCBBqaT14Bt1lJN6hyswwkeM5HPdDR60+GMdnyJAJjEEnvs06k17NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gP7WqKpj; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32d4e8fe166so3384812a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 17:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757721693; x=1758326493; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PMhMwVUWtkQhQozvbkaye4gfec+Uus5/E0Yhl+qmRTo=;
        b=gP7WqKpjI1vLr8cB72GdxLrnHx1Spm04uAAuX0l1LLDghpUpY8k3VsG8NqIeF/9I4q
         wgf+eoM3YD8v3dwmXmkGdluAGj14fqLlsUZKPj93zyv5qOFDSXXoxs8/9npaeJ6Y1fa+
         yEvOPpWRwgTDGwbgaSmZ5H8Jik6dSl6Xl59z79lf0mB5Her9VaPaLtjw1lZrat2Bgp/1
         q0YDbK9KbYz9VR5ol0CppbRuMUURFBpXJ40wGfM400cUp5DWTgSr9kmYKEVycsPQtlMJ
         8au5WZ4NFMj3hX/N39HRMqQaC4kYPGUsOkABHra1LJB4bIbZGKINKvVCLitP8xIL7r8n
         OtzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757721693; x=1758326493;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PMhMwVUWtkQhQozvbkaye4gfec+Uus5/E0Yhl+qmRTo=;
        b=ScuzyVJ1QnNKjYNEASxPOpSo2MucSnZC2Oz6ElCWsHlkjA6K3XKneInKvVEcPTxJq1
         XWm06YV3dA2SHEEqf0Uh7LbVbM9u9kXDi/gVhDNQsiNgSLhBy0zuwpjSluzmkH6y2rDf
         1GKSwQIKKIh5DLTEKTUEtpASzWqLVRwPY0ynIxoVnd5A0vfInDUNuBY7zqikRflnqDoQ
         4EgfcjPJoSXQEUhNSHcPfv5TX6suMp9jRxwOPi/Zb1jgws7b7qXqHhF5iLqnXpmXYVXc
         kWI3l+gI5s1w4kw8V7v7OlpFUnVuBx4s2xYSRX68Yu76fSRo15xD6Lr/nM/0aPk2DfvU
         s3jg==
X-Forwarded-Encrypted: i=1; AJvYcCU7EwZmBie9g2HvM1It5Nffwwr7je5O2MoLZMz+qgLOx5QtNiAP+0OCr4JDerZUK3IRFi7GUUZkPZ58Wyc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+uR/7E2ZmEkfkiDrABNRIH9iQti9+JtYzAGu5ueW2Y8xT3ChM
	SA0Q1oirGu0NhR6H5q3R65Y6fhiDgNi/bYTKDbqn6M49J0CIw9bcjRLhQRPtM7xEfOkLQQNHxDI
	wK+z4JZrRsg==
X-Google-Smtp-Source: AGHT+IFYXWG5c4pWx8SGKm+MYzC4up5S0kC5qWHuqEAb7gKco/PQlJGOcBTDF6ZQWJ2Jg2rbCpSXqG1lYr9B
X-Received: from pjbqb3.prod.google.com ([2002:a17:90b:2803:b0:32b:8eda:24e8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d40c:b0:329:f535:6e4b
 with SMTP id 98e67ed59e1d1-32de4fb9de0mr5671674a91.37.1757721693349; Fri, 12
 Sep 2025 17:01:33 -0700 (PDT)
Date: Fri, 12 Sep 2025 17:01:29 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250913000129.1306162-1-irogers@google.com>
Subject: [PATCH v1] perf lock: Provide a host_env for session new
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When "perf lock con" is run in a live mode, with no data file, a host
environment must be provided. Testing missed this as a failing assert
was creating the 1 line of expected stderr output.

Signed-off-by: Ian Rogers <irogers@google.com>
---
Please consider this patch for v6.17 fixes.
---
 tools/perf/builtin-lock.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index fd49703021fd..078634461df2 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -2009,6 +2009,7 @@ static int __cmd_contention(int argc, const char **argv)
 		.owner = show_lock_owner,
 		.cgroups = RB_ROOT,
 	};
+	struct perf_env host_env;
 
 	lockhash_table = calloc(LOCKHASH_SIZE, sizeof(*lockhash_table));
 	if (!lockhash_table)
@@ -2024,7 +2025,10 @@ static int __cmd_contention(int argc, const char **argv)
 	eops.mmap		 = perf_event__process_mmap;
 	eops.tracing_data	 = perf_event__process_tracing_data;
 
-	session = perf_session__new(use_bpf ? NULL : &data, &eops);
+	perf_env__init(&host_env);
+	session = __perf_session__new(use_bpf ? NULL : &data, &eops,
+				/*trace_event_repipe=*/false, &host_env);
+
 	if (IS_ERR(session)) {
 		pr_err("Initializing perf session failed\n");
 		err = PTR_ERR(session);
@@ -2142,6 +2146,7 @@ static int __cmd_contention(int argc, const char **argv)
 	evlist__delete(con.evlist);
 	lock_contention_finish(&con);
 	perf_session__delete(session);
+	perf_env__exit(&host_env);
 	zfree(&lockhash_table);
 	return err;
 }
-- 
2.51.0.384.g4c02a37b29-goog


