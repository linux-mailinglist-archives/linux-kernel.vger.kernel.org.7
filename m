Return-Path: <linux-kernel+bounces-869319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6E5C079D7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 19:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64E7E1A66FDE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 17:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8D2346E40;
	Fri, 24 Oct 2025 17:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ubZl06AY"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087D9346785
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 17:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761328744; cv=none; b=DywL2Y71hOcz50rG34p0D5MNbtrH0QKe7yL5680/pLsytMyGZT8udi19wWv/Thr7tkq4vw2MIi8MvCJuOyI0Ce+L7jT+XjsdSeX6Ztd4MnsB22S4qR0jAw2+G1bXy99vp5i46Y2t8OGN1RFPC4A1m7KgBl8dbCmzE+VpbEhZUG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761328744; c=relaxed/simple;
	bh=6nMA14P6Qbyeexp3WnkGdWEw8fvqzdlcMJ8tkdNQ/+A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=cDtpr6AAf7UBh3o4awfyEqMbod+JKQHyfumSQxh1ptShHXCh2BaIx1/0fwfq7mCbcMVAFsihMZ3ge3JQDaEoAgrom+98XzNn4Fv+fzbqPlRl0n50fW6KWiaS0TUmpN0aI2vioZ5JbWZQLDLTVYHywXKk182/Z0xiiBAWmiFEKG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ubZl06AY; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b6ce15aaa99so1828897a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 10:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761328742; x=1761933542; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TbMR3wgxv/2o2pYwh/5JL78UktKAGHt4o5fQQRcTvk0=;
        b=ubZl06AYWKCcecnNa+f+OIfmu9cJHDMcYhHefMYbQS1vTjOXNsuLUjnxvxcxFtA64K
         7IyC1yNTcV317sz27u91BtdyfjseG6GcAEx/yLtS5Uu9WwMvn4bn9MB3ihAEISOd246V
         qJYZzj4JdKO4GnS9z/Iq8DBcfiS/QAI5jrwqzHLLj5Ny28oHX/HuUZGyNI54cyJPL0Au
         5d2jd83v8bC25XFQdzUzHrsa1OfQCzpYLWoiD/QWxL98H9rs4tBAIkaj1e/wYCpxLf2n
         L6NxDfWSQwRC0mw+m9ZuagCLzWKpwP6Hh5rpIdJJ/Zsi1T7+h1xc15w3eTW0WezrteMB
         HwaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761328742; x=1761933542;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TbMR3wgxv/2o2pYwh/5JL78UktKAGHt4o5fQQRcTvk0=;
        b=JhqS7GByFptwreMJflZ32egkbX/LjJG2dzyPynjhgrsjq035B4wyiZl7g+982Q1Ns6
         051ZzWjg4GvSSUxp5bu0AxomK8vcaTgOnax2spqHYZZS+dPLVtcX14/ql7gzJs9QRPF8
         tDyL5/031KuHkJp1dU190Iw8anCv6PN8uJ0qG6475jvA2sf2ijbK8PkT32BrF4cTpTaz
         RTisPs4Zu930CE6dbc4DvZ4fFS3mY7JAZ0PfcKrfmc/DSZ5xmtsdD7Rt9CLhD8GUYZVQ
         F97/P0aoHpPR8VAc4fxtfBYgTbTIEQbCsuW9U4DZLFSuZMKz1/Hm3DjFxQyv4OIYY1Ov
         JlNw==
X-Forwarded-Encrypted: i=1; AJvYcCVHe6UGhaJgFGXCvbn9R2y/B21emRORSVl35R2IWyGciQfegopJqkgoQ3YVny0uJ7Dut7RpUKLlahV7YOM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9+0Wch7/jR6Cza3WMZu3OxefdCkjKGWn6ur/Z+51j2Y9qkr0d
	dGkjHCcLj248gkTHkN1Mgt5pfm2L55vou+vOe7x0P42tgbYXGATRQ3i4oxMO3zd2m4LS1JqrfOO
	N7omkivN3kw==
X-Google-Smtp-Source: AGHT+IGpCt51qhaTx579ZsbwdfKtQa8stTm7ZlEnQVHPsQ32n9Rb5o/ubQYxcXG1X+7Sp4X8w5b20JtYjRD7
X-Received: from pjob9.prod.google.com ([2002:a17:90a:8c89:b0:33b:8aa1:75ed])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2412:b0:33e:1ed8:334d
 with SMTP id 98e67ed59e1d1-33e1ed835a8mr11420778a91.16.1761328742289; Fri, 24
 Oct 2025 10:59:02 -0700 (PDT)
Date: Fri, 24 Oct 2025 10:58:36 -0700
In-Reply-To: <20251024175857.808401-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251024175857.808401-1-irogers@google.com>
X-Mailer: git-send-email 2.51.1.821.gb6fe4d2222-goog
Message-ID: <20251024175857.808401-2-irogers@google.com>
Subject: [PATCH v1 01/22] perf evsel: Remove unused metric_events variable
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

The metric_events exist in the metric_expr list and so this variable
has been unused for a while.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 2 --
 tools/perf/util/evsel.h | 1 -
 2 files changed, 3 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index ad11cbfcbff1..67a898cda86a 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -402,7 +402,6 @@ void evsel__init(struct evsel *evsel,
 	evsel->sample_size = __evsel__sample_size(attr->sample_type);
 	evsel__calc_id_pos(evsel);
 	evsel->cmdline_group_boundary = false;
-	evsel->metric_events = NULL;
 	evsel->per_pkg_mask  = NULL;
 	evsel->collect_stat  = false;
 	evsel->group_pmu_name = NULL;
@@ -1754,7 +1753,6 @@ void evsel__exit(struct evsel *evsel)
 	evsel__zero_per_pkg(evsel);
 	hashmap__free(evsel->per_pkg_mask);
 	evsel->per_pkg_mask = NULL;
-	zfree(&evsel->metric_events);
 	if (evsel__priv_destructor)
 		evsel__priv_destructor(evsel->priv);
 	perf_evsel__object.fini(evsel);
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index f8de0f9a719b..71f74c7036ef 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -100,7 +100,6 @@ struct evsel {
 	 * metric fields are similar, but needs more care as they can have
 	 * references to other metric (evsel).
 	 */
-	struct evsel		**metric_events;
 	struct evsel		*metric_leader;
 
 	void			*handler;
-- 
2.51.1.821.gb6fe4d2222-goog


