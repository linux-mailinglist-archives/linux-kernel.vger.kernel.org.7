Return-Path: <linux-kernel+bounces-744665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D047FB10FAD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 18:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9971AE4D39
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C6F2EB5D1;
	Thu, 24 Jul 2025 16:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kiOz8ttW"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685052EA730
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 16:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753374800; cv=none; b=tS03jkGUPDHhhcfoxZF/l1W1CiTZF7NTUt8+j+cgILEHzweCql31ZWJBhCDf3P1O6oG4C4spisFrUbvH/k8XegCdLhcB641epY/8KX+afFEpq8eD9GhDqJmgdCCzL2ffDxsfz+TCGXGMz8/BR9guPBaa4mq/mv7M/7WnpYRo+Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753374800; c=relaxed/simple;
	bh=6Kaw3YeDSjFMbgSGwOQqcOiX76bLmOxHdfk84Y2TCRw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=S6ibSuaSvp8iqn5fjD6+v6wfR8mNTTPd5bssSOSzomKn/08gWC3COn5JY3m7aESv5JddqaGvIfYrsHJLM2nd07xllLQHjsJYK+hZO6pJ+Bp6RKeH/zPW3jlePHxI9dHzRIQ8FNaD+7Qyu/5CJoVFZpsc2zB2OIi6yxDXCW1TkIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kiOz8ttW; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e8420d8a209so1358764276.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 09:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753374798; x=1753979598; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gpJDjPIAX11d0UZM38x2TXJLxVO8GJl81BGUasQciyA=;
        b=kiOz8ttW698LaJeJYL/n6KpOJ1WYvBu52tEDQ/bn9q3IxZF6IsjangfBsRDZ1reU7X
         Z8wicBwQB3e2XX10FtTyz+CD66m6cb+FzA76UqtRfHnRFnEUMP4rAO6sz2KC4/KJ/U+j
         nYdezqoMhMhXR0kd/7gqmtJ5K3orSonWcCm04/9+Fcd7AUCvVoV80mFatuPU01xgMJq2
         +mD+uRpQsNf5RXbjHbDh22Kdy17PqK8YV2H/u4kbIFeAU5tvUJC4CIIotzwh7bChdPBy
         Y32Wh7aScskTjuggMSDoDd+XqFAh0L2oP9Ktd918wtV92pYZeBL6kMZeHMkK4Wr3v2N4
         lcCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753374798; x=1753979598;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gpJDjPIAX11d0UZM38x2TXJLxVO8GJl81BGUasQciyA=;
        b=QO86MO+OdBJuw8D/NOugoLTitLjJrBxM+D0mxx+uGJ0DOPJRbPhMBCr8NrObx6z4WO
         iKc0vuPR5cpLRk7fLGH+MY8lwr4jkZdOvge4GE8W3pPsiuW7tl70UkTnhOt1kgeGZYsx
         +RzCG9ZUkbx8MAR4KfyGkG43LxryYNXSKPPSm8QnIdSHQJc2VP2ePp8Hn5bsdeOt0epD
         dw+BZrnRlS42nmRdZZoIbMxuRTPz5mjGz4HXQAef4xsksvAgUIF6iRlGtHIa1RII6OdF
         vSibkPvrF779LV0AB/nmMRoOYYXEALLuhmbQ36bRi8vHiB/axO+hQFBIue0UcLyY9qN/
         KnKg==
X-Forwarded-Encrypted: i=1; AJvYcCWLlPWx9oLoJ7INbCrKvI/NTtrmgXKVYCA9dSAiz+so9jqCIfqAoRGei71mExIJWFQS9lUy13w2En7zXYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmXZQxj4I/QOoABIj+pG7PGTCjYJyINb2SPjgQFIizhJZuzq7B
	kpxlB6x4TYXItTtDgZNI6oj5i9wyJrdiCSJY/3dzKArc3v6TfH+3WFzM5QrTNAxsPXZqUZUtOhK
	CrtHZde8ctQ==
X-Google-Smtp-Source: AGHT+IH+Le6f7elHvBNL2n4qLT95uBiksK6rxQ1HIiL9ghL9ctylAbDJH7pUOUMT0lkqyTaWdv3fLin5G6C3
X-Received: from ybit77.prod.google.com ([2002:a25:aad3:0:b0:e8d:83a6:26e7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6902:3292:b0:e8b:cf19:6675
 with SMTP id 3f1490d57ef6-e8dc5a1089cmr7455723276.33.1753374798321; Thu, 24
 Jul 2025 09:33:18 -0700 (PDT)
Date: Thu, 24 Jul 2025 09:32:42 -0700
In-Reply-To: <20250724163302.596743-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250724163302.596743-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250724163302.596743-3-irogers@google.com>
Subject: [PATCH v6 02/22] perf build-id: Truncate to avoid overflowing the
 build_id data
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Andi Kleen <ak@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Graham Woodward <graham.woodward@arm.com>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Li Huafei <lihuafei1@huawei.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Chun-Tse Shao <ctshao@google.com>, 
	Yujie Liu <yujie.liu@intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Levi Yun <yeoreum.yun@arm.com>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Matt Fleming <matt@readmodwrite.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, Zixian Cai <fzczx123@gmail.com>, 
	Steve Clevenger <scclevenger@os.amperecomputing.com>, Ben Gainey <ben.gainey@arm.com>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, Martin Liska <martin.liska@hey.com>, 
	"=?UTF-8?q?Martin=20Li=C5=A1ka?=" <m.liska@foxlink.cz>, Song Liu <song@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Warning when the build_id data would be overflowed would lead to
memory corruption, switch to truncation.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/build-id.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index e763e8d99a43..5bc2040bdd0d 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -951,7 +951,10 @@ bool perf_session__read_build_ids(struct perf_session *session, bool with_hits)
 
 void build_id__init(struct build_id *bid, const u8 *data, size_t size)
 {
-	WARN_ON(size > BUILD_ID_SIZE);
+	if (size > BUILD_ID_SIZE) {
+		pr_debug("Truncating build_id size from %zd\n", size);
+		size = BUILD_ID_SIZE;
+	}
 	memcpy(bid->data, data, size);
 	bid->size = size;
 }
-- 
2.50.0.727.gbf7dc18ff4-goog


