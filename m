Return-Path: <linux-kernel+bounces-869325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E84C079F0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 20:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20B5D420F16
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 18:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E30C346E40;
	Fri, 24 Oct 2025 17:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J3AKIj8r"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E02134886B
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 17:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761328757; cv=none; b=SYdk2u6Jg4A+ecjHQZ7lb3Y0DK0pQJTLg3J5yWOCTsT2rBuyoeD9qNWSL+eINfzNO/rbzY4vFPYa+Lm2aFhltirlj5wzayRpZOwBO7c3jioleBrEpQa8DGg+kwUvJsSlJz6Dd/qcbTKlDaGWBc/rbdXCNi1JJzE8t/KcpwwpKio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761328757; c=relaxed/simple;
	bh=9/epWOlvqRElvVAYkJLo+3zLaR28RumkRGXocbmxMUo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=XdZlMKivLbZkpSfHMY8nJFPHuSv3iCD1WTk5g6qs5y/YNNC30XCLUNAaCCI5X7tJ2YJ/OmMWCq9fYPYkPwbEzRYZSmyELWltj29Bs1hVNjrS67ENmtq9RpiZZNZbTIyM2K1X3F3YBDgyyA1btsG6L0gRENL7+QBEtenYtLFXJIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J3AKIj8r; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-339b704e2e3so2316611a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 10:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761328755; x=1761933555; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=APc54Tj3AQGNHWIUCnd6bMLg8AtBQwOaMT/IoX0GM6E=;
        b=J3AKIj8rfNUPwYC0wL2uniOeVPOnWuZKfrfIM1GjmbG5/6wU5HNBFaQj6GRuzLaa88
         5pzOFcUtliJmkx2xl2r4urdJwQRRTP4mAUfS3zqMtsEsmok4Bn3WgZtZUTR6yTtpvPtI
         5u3vyF2L/KFEUltnLDiF061ou5Oibb0PBbMnZ0SPDE6PK9TcAVBc6VIRdWvQWTWoiQFu
         4aRxNC47flr/qS4MIoKoJ5GlCcQ9opNemAYftCTO7Mzl7zRCHxwFdO3ra/XARTOIHiWH
         /QhvyhKpv016k0B2NnLsEKdQCt27j5rGr/cnMs6HA9e4BmaRKkbpqEA53O7qa2in5cfu
         2eyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761328755; x=1761933555;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=APc54Tj3AQGNHWIUCnd6bMLg8AtBQwOaMT/IoX0GM6E=;
        b=CuzK45cDVLh/hgsH07OGHImlU0ijOCt7Dur3fBPLEOhC8UnistGL5PmHE3MrHusTyh
         zqihXPTOLpRaX7x1+RVDdbRtoEpWhEwzPyY8lW/iKoIxO7ktOGnniv/N6riF5R7kZKH9
         r/SOEFA0yUJeNkOv8G+SIdsfI6Id3KphGZsnwWsktajXeb60oibDnMnTWF68rnM8i6xc
         v6PFpfbzEQ8RkgB+CSAmD9AKF4uNwB75ipZxkEZgKDnvkhU1nq5IRxi3cnMfa8K9BemY
         Vyg2bQRvSUYG34XazBUDrZ5eS8tfMSPth52k4w8qhXebb1k+huIT2M1YUI6eeBSJE02S
         W7HA==
X-Forwarded-Encrypted: i=1; AJvYcCUePRuWETewFmLKrbdudl3EFLvwjvWlP13mP284aDBShSHwr2G4UTCxLnq9YUX8ELFFk7y2mNtOOZAx+1M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0i5pk6vNTcjP3k0SktyurcfJxX4dM6bMR0+tHIgUcKhqoS+UY
	1UDDChCfgHJQArrNKGMFQXSoUap+/m1JGZiYEVh+8VNvR+/3ovFLDtDj7qWJHd9tEzftqbcRo1K
	ki4qxxrcd+A==
X-Google-Smtp-Source: AGHT+IEN1iYOPYV7RXFzzvFzF07chEYfhJgksicY9whr0oTjDXk5EpLLJoQwOutmfEvwxm3VlnvXeCyC0ic8
X-Received: from pjbjz8.prod.google.com ([2002:a17:90b:14c8:b0:33b:dbe2:7682])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2b4b:b0:33b:c20a:35e0
 with SMTP id 98e67ed59e1d1-33bcf90c1d3mr34702592a91.30.1761328755526; Fri, 24
 Oct 2025 10:59:15 -0700 (PDT)
Date: Fri, 24 Oct 2025 10:58:42 -0700
In-Reply-To: <20251024175857.808401-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251024175857.808401-1-irogers@google.com>
X-Mailer: git-send-email 2.51.1.821.gb6fe4d2222-goog
Message-ID: <20251024175857.808401-8-irogers@google.com>
Subject: [PATCH v1 07/22] perf expr: Add #target_cpu literal
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

For CPU nanoseconds a lot of the stat-shadow metrics use either
task-clock or cpu-clock, the latter being used when
target__has_cpu. Add a #target_cpu literal so that json metrics can
perform the same test.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/expr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index 7fda0ff89c16..4df56f2b283d 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -409,6 +409,9 @@ double expr__get_literal(const char *literal, const struct expr_scanner_ctx *ctx
 	} else if (!strcmp("#core_wide", literal)) {
 		result = core_wide(ctx->system_wide, ctx->user_requested_cpu_list)
 			? 1.0 : 0.0;
+	} else if (!strcmp("#target_cpu", literal)) {
+		result = (ctx->system_wide || ctx->user_requested_cpu_list)
+			? 1.0 : 0.0;
 	} else {
 		pr_err("Unrecognized literal '%s'", literal);
 	}
-- 
2.51.1.821.gb6fe4d2222-goog


