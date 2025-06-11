Return-Path: <linux-kernel+bounces-680779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE76AD49A3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 05:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42E0017BE94
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 03:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE302228C8D;
	Wed, 11 Jun 2025 03:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eUwcktBf"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAD0226883
	for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 03:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749613580; cv=none; b=n2pK8m7TTzZySMO4wk4mELR+JR+iX2kDipi0ANGHvGAtjr+48qCgshbzF6nRgccuJJKw6lAY9Wc31oxugpUepKOTu9nXhxwge6C5j1sjzuq2j7DNl/ldnE6yXXIsBSCeej7enmI7aNDlr9jeB7sX1GYVUrB1610Pc3s/eh23sjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749613580; c=relaxed/simple;
	bh=d1DekuT4b+RpmHHw8+0cV96WV12ZXy4R3fduBzB7g5w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=ZLnlWI6WJlr9QePCCxa4eb/w9mQXOUANIKhajsdPDe6DN+IH+qqF2FTdhvfiOo6i+jtxBGT9jvjt5+5tDKVtL2yoafAA7rQy5T++zX6M1vzi72nqMN28H3RBK5AKrnyGmwbuei10we1GNyYN+3ae7XubYaIbF1O3OuMrcxQfOVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eUwcktBf; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-235f6b829cfso44075705ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jun 2025 20:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749613578; x=1750218378; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oTVLN6IxdloaWx8kgCQ0wDt7X84NOVop+ZW7Gi+fQHw=;
        b=eUwcktBfTjUJnVMp8XMGX6Wx2OAAvIQH3hskuGNAUEU1DbUx/xYPKn0iDJQctjbDgq
         QgbuIzIlYi8LHBzODtD252oR/bY8qYTjnnqhLQ/2EEQIUaRaE1FKDnaG6sfcf3LfFUbc
         qCb9IeVlTliDujUgZWIfXJxLOqJnvA2iASEZWBfGXimpg4rWNOd15Ljh9MJUZAduIRNG
         JglaD/v9NJhjspr8g5nNLNQtk27b6BzffkvmW9h6it+rwgVutUGHvumV4afpWlqbkRsM
         NFW2A9MG+F5zK42fuDqw2r5+o7pTW6JARsf4/yCs1sp+TUHjK7364z+zFHp5B1dlq1i6
         BKKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749613578; x=1750218378;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oTVLN6IxdloaWx8kgCQ0wDt7X84NOVop+ZW7Gi+fQHw=;
        b=diwgkYbdhPl8p3kKxXMbPy8C0tXDNmfjNBWKcNpMWRnhrSEuA/CCEkb76JseYOR487
         SC2CjWlb59CpUcRtREnEGq9ZtywceU9o11R2CXfOGBe9pBhWqHcoPniOVDfEQmZROGJK
         SGtojTzd/bl3NMyoX21PTCd13vRJtHwW26SIGhwuRn+u35YktwwuZOrVtYJOtve/0MZF
         K8fchdJNmzceXQ2pGWAJdZBM7ky52IzaKYwhS6wpUMh3+zeDuwY0T0ZRXg9mgjmzpkVz
         d8ncWrdaK5MY6aN52tOEBy56d/0ZNOU4CG9UOd29R2DxqNbyu12D8W4AewxIUUOr94FZ
         Zk8A==
X-Forwarded-Encrypted: i=1; AJvYcCXK++NR0+B9HuEQQFEJvyNt37DnPhUwn1P6ZOrtQL74ufKg2PxEvLfeowvVhbwydgoYW/m1M1GO+0s216M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMF27sWct9F7Q9SJAFgQK7htorLqOe0BtB8AVZVKJ0U2+qPb/S
	zmZd/NfE9eWoIlWWd7VsWN4fl99PtXy5LmNSXpzcssSJh7jVjt9nXOl73/0mfgADzBJl4IrXCzQ
	OTl9OHBD6Lw==
X-Google-Smtp-Source: AGHT+IGSJgxA1iCXoAQG6NxNIRILvjbosK7Sjd9nbn9uBjPLyroUJZd0wkV7a7NAm7Rr+yI+dwb8Go+aAlDU
X-Received: from pgct5.prod.google.com ([2002:a05:6a02:5285:b0:b2c:4a89:4b36])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2985:b0:235:2ac3:51f2
 with SMTP id d9443c01a7336-236426a858emr17252575ad.45.1749613578271; Tue, 10
 Jun 2025 20:46:18 -0700 (PDT)
Date: Tue, 10 Jun 2025 20:45:18 -0700
In-Reply-To: <20250611034529.508842-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250611034529.508842-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.rc0.642.g800a2b2222-goog
Message-ID: <20250611034529.508842-5-irogers@google.com>
Subject: [PATCH v1 04/15] perf python: Fix thread check in pyrf_evsel__read
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, John Garry <john.g.garry@oracle.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Andi Kleen <ak@linux.intel.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Gautam Menghani <gautam@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The CPU index is incorrectly checked rather than the thread index.

Fixes: 739621f65702 ("perf python: Add evsel read method")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 49e1db3feb87..b724478fe34a 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -909,7 +909,7 @@ static PyObject *pyrf_evsel__read(struct pyrf_evsel *pevsel,
 		return NULL;
 	}
 	thread_idx = perf_thread_map__idx(evsel->core.threads, thread);
-	if (cpu_idx < 0) {
+	if (thread_idx < 0) {
 		PyErr_Format(PyExc_TypeError, "Thread %d is not part of evsel's threads",
 			     thread);
 		return NULL;
-- 
2.50.0.rc0.642.g800a2b2222-goog


