Return-Path: <linux-kernel+bounces-815800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FC9B56B37
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 20:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 842087A4C2C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 18:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538172DF3EC;
	Sun, 14 Sep 2025 18:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3Xg7tmdP"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443372DF128
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 18:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757874551; cv=none; b=onMKN10R8XMywYqVc/Z5IuKmOd8pZOiSXu306wbRqVw3N9205qkqe/EfbB+9rMDWorTkviKNN7cPt0ac7kqrlSTWgsIwo328tUAnVaxbDJRxQeXOwi60udZ6tz5CvuAnw+I8Jt033l3umv57lNPqBBO20e/kHA2zCQYsDYkZ/dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757874551; c=relaxed/simple;
	bh=0lYXmqlBpYk30yEty0a21FLXkVSzUHTg5T5wQf3ZAeE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=K144qSL3kc5jJw0Qz1hglV3N0ST7vNr+TtxGLFALv5W94kRW26A2mECFXZn3WU0g5edxd0P9wAuXfuYCW/+0WiFFvSxzjAfLHuEmM4OVnv/tET4wDtDGZNBqIqwEWqqhPG3rjoCtqYZCNb4KEgXLLBGbntH1T7RP5zrb7+GOjB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3Xg7tmdP; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b521ae330b0so2535908a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 11:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757874550; x=1758479350; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TvKgbG4XWpm9j/FvFDZJd7wO0CKfdrc2kepJ8gLxvYI=;
        b=3Xg7tmdPIR4FY3+tzNRKBWwjSVfd7O6KZJsj8dEJl0s2eEc1hakrznlhxxcXr4ZQnO
         7jQkLswZBU7vqFCyMtfiLMbTwPsWRTKUmdWaT6ABumrP0YhWlLIjpTuqq3iA2gIAGJ49
         x7rcxbml/aY2EqSbYShHdYArwp9nC97Yc8N70wLEb2uG7a+MHYZioaq+6p9KfjB7Gf5V
         a+wV3/zkd0ZG+b+T51DNK+PnOAA+7DngVY3poCDSggmltJ5M7z8LlCmNtCvNc7Rzkrh7
         euh8WwF2IdJEzqnfV/w/yYw2ZaI704STvy5fnbSTwuoRQQTmUa04sv90B7lKtSu0wOUv
         M9YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757874550; x=1758479350;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TvKgbG4XWpm9j/FvFDZJd7wO0CKfdrc2kepJ8gLxvYI=;
        b=oAId5sHqjRuBH4hqiNndTi400nKFtngDBmwYUHqBtvME4HatCL/ORWhAD9aZGX6jDg
         DeOYmWMkS6BAW63UKam8dhjo8CCuGUDhjwzow72zfzr5q6Fw6EVDYejch23kmfTv2NnX
         zCSq4w4FTyQqwK6v9v7DZ77jQ8BbZvXbouzrOZ9pMs6PIkah0tAt8KGWBvEnL3/FnT6j
         tbbot3fbbHe+eW6JGmWVxpbyPov32s69iT+Fy5Np/xZgX0FgDIFvQ342pWjGTn/ExtsW
         2q9AHUud5pbiAzE5s5NRbzNQzunZ8nUNVhL0lMjiBZB13GSgSJ413LXjmPme6DdzfoPW
         dCyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwRviJ6wnEzDAr4bdPWtfYzPXCneN8TwMPphEkd9bSENRg84BsCIf56zgiGOkstmB4mR6a76qLSqnVSJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvfL9qd89TncHV3yPbTy8nOhhP/nczWNrWjHdZKj8Sytc4qnVS
	piMkdPvOGlqjwNGg3gHBwx+mnNkVw3XwQ9t++ydzVtN24Y4qBTn7GdtxR9tM2dTwwwFY3kltRAG
	jBJB7h/kL+w==
X-Google-Smtp-Source: AGHT+IGxW9Yja9epoc4iIK/yOFAiIZoZRfLvsUOXZa2OGRrep9OIb1OYkQrTlNUDj0uJte5SI7cFznkvnVg6
X-Received: from pjss8.prod.google.com ([2002:a17:90a:1c08:b0:32e:12f0:20e3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:548d:b0:250:9175:96db
 with SMTP id adf61e73a8af0-2602aa853eemr12978800637.26.1757874549586; Sun, 14
 Sep 2025 11:29:09 -0700 (PDT)
Date: Sun, 14 Sep 2025 11:28:59 -0700
In-Reply-To: <20250914182900.1960567-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250914182900.1960567-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250914182900.1960567-4-irogers@google.com>
Subject: [PATCH v1 3/4] perf test: Don't fail if user rdpmc returns 0 when disabled
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Chun-Tse Shao <ctshao@google.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In certain hypervisor set ups the value 0 may be returned but this is
only erroneous if the user rdpmc isn't disabled.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/mmap-basic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index 3c89d3001887..3313c236104e 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -322,7 +322,7 @@ static int test_stat_user_read(u64 event, enum user_read_state enabled)
 		}
 
 		perf_evsel__read(evsel, 0, 0, &counts);
-		if (counts.val == 0) {
+		if (rdpmc_supported && counts.val == 0) {
 			pr_err("User space counter reading for PMU %s [Failed read]\n", pmu->name);
 			ret = TEST_FAIL;
 			goto cleanup;
-- 
2.51.0.384.g4c02a37b29-goog


