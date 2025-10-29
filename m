Return-Path: <linux-kernel+bounces-877258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE99BC1D960
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 23:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1336F3AC51A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 22:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD3537A3C6;
	Wed, 29 Oct 2025 22:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z/G5VkJt"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987E51C5D46
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 22:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761776811; cv=none; b=QJ+eout8OajqCe1lBnqOZxzbLOY1FouQEVUbQ9srCcHt1Tcp5T13kYOK1WmCBN2XMFjnps3takBUlVmgMy04p0hOD9Tb2iLecFX/gQMSF0WjZNZsB0VMmq4ebonl5xn/4Xy2O82oAdgteifGi2Pu8pFzQDOjb5Ax5QhPV32gxVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761776811; c=relaxed/simple;
	bh=Mz4nL9edUly3xfUhkPe7ctPnCjWF7RaxzJpnZwbwSJw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=CLFj8CA19OQmCz+T1Om00YyYlcpcKaBTXpFgBEBVmDnSVt+PFI5bkHDQsCkCu472yJoN/nxCp2HO1ggH8UekD9gEilI+0pQK/mdFmbephVSZhN/Wfd851IBApQF/xAANndgEQSOcq1AnPiCRdTUMiNOd3DnvOXv7c1NYGpUk03U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z/G5VkJt; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-28bd8b3fa67so2266055ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 15:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761776809; x=1762381609; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WWBrSbsTgF6dJTLcnwWeup/RYUYA1buu8R4v1mz/Da0=;
        b=z/G5VkJt1dTzsd2ew6wtEmbTD0p7aKmPa4DbLACJSqmaWX6U9w8XWaf8wvANnKgNY7
         4AyBaBf0ZI/qV57Qu6ybtDLXBfJ349NC9wS8GBsnTJnf0hb/23BznE0LQYSPlDc6YNbs
         8UQMFcQhwiBzX8T9903GnOjM0lROPO4N564W+RW0EV47KV5x+F63RgR6clbQmsWoLECo
         0WsAI4iJdXoxOyk7ZTy9qKQoPse0lzFeW9yfVqpzUMDL+JuOa6psltm+creUfk+mjlv2
         YF9NuFrHp5p7SYLhUdtem8abUjXSCRLmZgW+HchLkml7FGTBFm9eCQGfszyqO8x2dYV9
         qwBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761776809; x=1762381609;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WWBrSbsTgF6dJTLcnwWeup/RYUYA1buu8R4v1mz/Da0=;
        b=fLDJR3/02sLUaVj5jvKWJVKADABGu+vP/xYHbKyFEO1RciHNH7jhHqClXDdJoWZEHc
         /i+LTfIi7UERCPDHI9m6IEwje8skkdjVkKFgLH8QHgklsXJq9+YGZp6dC/mz4U+gsiPL
         xYEzegn40g3QHgf99ww+s/9zU1llp29dbAqysgfEb5ossXme/Ev8iLd8BaDWV2noLjmz
         Jy4m2kbKRjwYA/SQ9x2C1MVLYVzDBFAdzo0ZsG5bgg2ELLy4T/ORr0kOEfRAnxmSrIrp
         K5HIHuRzc2xEUqR/lCrwwPVdwyk5isXCsqS76SLEmGzrH3XqcuZEklm9EJ6SEexc08if
         2IUw==
X-Forwarded-Encrypted: i=1; AJvYcCX8CU5rUCf2MQqn5DKS4QrJ4CZsmlgbROsqG/1T1U7VFnY/c0FX4PjOwCAzssnPiXw2cnjVc3bcGzKEllU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg3kWwxGUfr6eUQ7ua2c3zUojECAFSMYlTjW99vFILIx0vU5BK
	F8QkrWWwbfvYj25uW763vB7xjpZIWhuJWCRAq++kDRt04FlRMPVwLT+gCQ/hBEh0YQ/mNxLNCc6
	/gIrUTJ1mhg==
X-Google-Smtp-Source: AGHT+IFFTG+0oYWzOwWWLJO3ZVw1o782JcycH5aOEUzvwNGgnbzVL2DxrWK4NtLIooCmymlzPYFcQbZUymmQ
X-Received: from plbbj10.prod.google.com ([2002:a17:902:850a:b0:294:5f94:dc3a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1b4f:b0:290:c0d7:237e
 with SMTP id d9443c01a7336-294deed19d6mr56850855ad.39.1761776808908; Wed, 29
 Oct 2025 15:26:48 -0700 (PDT)
Date: Wed, 29 Oct 2025 15:26:37 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251029222638.816100-1-irogers@google.com>
Subject: [PATCH v1 1/2] perf pmu: Make pmu_alias_terms weak again
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The terms for a json event should be weak so they don't override
command line options.

Fixes: 84bae3af20d0 ("perf pmu: Don't eagerly parse event terms")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index d597263fab4f..f14f2a12d061 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -802,6 +802,7 @@ static int pmu_aliases_parse_eager(struct perf_pmu *pmu, int sysfs_fd)
 static int pmu_alias_terms(struct perf_pmu_alias *alias, struct list_head *terms)
 {
 	struct parse_events_terms alias_terms;
+	struct parse_events_term *term;
 	int ret;
 
 	parse_events_terms__init(&alias_terms);
@@ -812,6 +813,13 @@ static int pmu_alias_terms(struct perf_pmu_alias *alias, struct list_head *terms
 		parse_events_terms__exit(&alias_terms);
 		return ret;
 	}
+	list_for_each_entry(term, &alias_terms.terms, list) {
+		/*
+		 * Weak terms don't override command line options,
+		 * which we don't want for implicit terms in aliases.
+		 */
+		term->weak = true;
+	}
 	list_splice_init(&alias_terms.terms, terms);
 	parse_events_terms__exit(&alias_terms);
 	return 0;
-- 
2.51.1.851.g4ebd6896fd-goog


