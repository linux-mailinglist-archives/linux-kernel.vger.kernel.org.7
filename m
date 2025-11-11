Return-Path: <linux-kernel+bounces-894617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BB3C4B6A5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 05:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D99B14F501C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 04:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1F334AB0D;
	Tue, 11 Nov 2025 04:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TOJjg4s2"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DD234DCF3
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 04:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762833900; cv=none; b=kjW+Ti5GV6mrzEBV3GJiR5rRMv+iC+tq4Crlj8Zp8hz/ydr3JswRWltinz5P7BnV7iiuFAtbbcy8Uhrqe5Ab2rHxvwW3U4Lvx4Lost9BO0pYsc0TV6jqAKru/TSGRXOvndR119eGGFZOELp9zSRGJjqPOxbBr4Z5UpNCxpoNJls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762833900; c=relaxed/simple;
	bh=sWmDIev9bpAFqHQEit38MtJHcI5r4PnZTO5Rq4PESvU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=pXOCeHj44tKzrhWfecyBv5dndfTcMbIpRTJtkm4S6pJP2deonnZn41xXceKD5KQO21cKXyVrj4zXrR+gF7TedZIARE8Lb2TPgz8f5WYaiNPFpw09RoA0RwN4+GyIRzfOAGvOHADOWXaQX9Y8+MiV/fAzkF/WRveGyVpwqH5jVQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TOJjg4s2; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-295b713530cso44560015ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 20:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762833898; x=1763438698; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9rrubnbGxO/GZTc54MaEZH3FM5tqPTfV8BFx99302Q0=;
        b=TOJjg4s2uUYgXGYo57ZGDTu+pwW+z8Wb52s2YHvyROvAMg1XM+DUW6IFpMMhqtrEbT
         b24oVaLLjP8pRlgBxbtO1heHthVgZ89m7+lOm4+ULVjQeesW3vYfx25uOv6cZ8ZfOKbU
         2XVBXN0aFFw1ZRWIYNpwU52YbMAhVSsK8p1t/08zvzENk3nBYlJyjBCDaUX3/U1mU2gg
         Dbq8yJHWkuPvHsF5303wM2ut8fHnJMSwAyM5hc941XpHqyPzVDbOaJk8Pi3xF7Yi4H5H
         ZdtPEVTNnA9xHBMZX9nu73fN14Bfy7uwO2LJ2fMdvH7g3bCY8bnvBWdK3tKaV7aCLFPF
         jt/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762833898; x=1763438698;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9rrubnbGxO/GZTc54MaEZH3FM5tqPTfV8BFx99302Q0=;
        b=XJHYNAEIs/2+Mv+MgNqfHvMUtYB1m6Rcnj/qxTzkUP5rSj6wUNLwBVRvl2sVZS2OmJ
         AfedktZv1Em0PREv2KVEx4hM8HhxfU21i7C/YqC6Mv5FwZfxJ9cpQZ7MbwOhz7omBcz4
         Srwb84m4a21TyN+jtGZijZI82aM2y7rGbBc80ObFBgPKro+AyIj29YOcPkFpdGNjZBKg
         2+R1wHgByGtPW00Usmsw9niyDXsmtfDkYBzChPZ4rcYTwgI9UKYZaVZEYynUuGugZjYS
         28Bxi5j/NZVfauKimZQcSTAQ+D+YvkETPSrbse6/mzrfz6vHgd62s26zYdg5w4xKMY0L
         72kw==
X-Forwarded-Encrypted: i=1; AJvYcCWm4Eh5SwXWH68zXZxg0E1saMgbE1PaMlTj7FfN+mZapDnxRzHZVelLrgdhJ/aFNaV8BhGiDmlOzlBmjZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZAS2/zOpmQAEq2EhrS8fDoip6E1YoevMs/ACw0GWFd5JF3pXq
	HVEO+aRp57h2CIYBRtsdTI3FSwWSRleMX3r/z3/E1TbOFRHllUxLlXTuoPCujtPdpEd/LTGLj1W
	UHNi5mPPEsA==
X-Google-Smtp-Source: AGHT+IHBUjhm1HAHK4fknr5+U2WBmlW8IIK5MxW46rm68+SMCCxdxu4P7aNsuW9rnpZloIRA3zNCNzCWCDVW
X-Received: from dyctx7.prod.google.com ([2002:a05:7301:5f87:b0:2a4:612e:b41f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cf42:b0:248:ff5a:b768
 with SMTP id d9443c01a7336-297e540d533mr131917455ad.10.1762833898118; Mon, 10
 Nov 2025 20:04:58 -0800 (PST)
Date: Mon, 10 Nov 2025 20:04:16 -0800
In-Reply-To: <20251111040417.270945-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251111040417.270945-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251111040417.270945-18-irogers@google.com>
Subject: [PATCH v3 17/18] perf test stat csv: Update test expectations and events
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

Explicitly use a metric rather than implicitly expecting '-e
instructions,cycles' to produce a metric. Use a metric with software
events to make it more compatible.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/lib/stat_output.sh | 2 +-
 tools/perf/tests/shell/stat+csv_output.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/lib/stat_output.sh b/tools/perf/tests/shell/lib/stat_output.sh
index c2ec7881ec1d..3c36e80fe422 100644
--- a/tools/perf/tests/shell/lib/stat_output.sh
+++ b/tools/perf/tests/shell/lib/stat_output.sh
@@ -156,7 +156,7 @@ check_metric_only()
 		echo "[Skip] CPU-measurement counter facility not installed"
 		return
 	fi
-	perf stat --metric-only $2 -e instructions,cycles true
+	perf stat --metric-only $2 -M page_faults_per_second true
 	commachecker --metric-only
 	echo "[Success]"
 }
diff --git a/tools/perf/tests/shell/stat+csv_output.sh b/tools/perf/tests/shell/stat+csv_output.sh
index 7a6f6e177402..cd6fff597091 100755
--- a/tools/perf/tests/shell/stat+csv_output.sh
+++ b/tools/perf/tests/shell/stat+csv_output.sh
@@ -44,7 +44,7 @@ function commachecker()
 	;; "--per-die")		exp=8
 	;; "--per-cluster")	exp=8
 	;; "--per-cache")	exp=8
-	;; "--metric-only")	exp=2
+	;; "--metric-only")	exp=1
 	esac
 
 	while read line
-- 
2.51.2.1041.gc1ab5b90ca-goog


