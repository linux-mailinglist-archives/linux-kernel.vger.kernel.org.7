Return-Path: <linux-kernel+bounces-891773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4894C436F6
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 02:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 530AC1889EEE
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 01:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E718F2AD13;
	Sun,  9 Nov 2025 01:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZAg3J2mu"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D811C695
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 01:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762650014; cv=none; b=o3svi6JDqMWj9oHPQXEuvUDxajotzRmOqP3rDV3NOqe/GuW+bS0PlWnKhtG9Lfl7riCkvVW3lICGP22m+0kC7B47XnsdHKzbHD+9Eq1h/GtVOZuDp2r/yDNMmdtezf/RNA0vfzVJDUHtkQIA8rOIk0NxItMA9m+UB58sbzhgd5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762650014; c=relaxed/simple;
	bh=S7/+HBtEvZG9Qq5Szv4TpB9V0AyAe5mzIsqylrNZYdg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Yc9N6q/slNiOC60qaCqeOYlD3iRxsklQUCv6avynE04KE1ggxT1/lCM/Cply7sAwNoAkceuhltKttUX8Zbi6TcSkNKDJp22N/c/0GFRtOcQjt0mYaI3vluHMzh6d4Q5c3D44PrRifcWc0Kw19nBHr/dA5YlEMvoliXacSQjfvko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZAg3J2mu; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7ae1d154993so2026358b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 17:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762650012; x=1763254812; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P6y3TFdHBEZk/bwF/qWSyN+tu4MCaAtXn8kZScOn/II=;
        b=ZAg3J2muVmQDB4Cl2VOD+xMOh8NVMc5XK355uFVGeDXvQ9HReJFaKyfKH8+kJpaLf9
         Dw5RJpcSyXKxtWQ/JYRCxPk0pJqXHM4skV7x5lP61Cv+4tJyhX9dDTMUATKb9ndvOx1x
         AZ0V6ACa5WRoya93lwsZOD3Inu3F2OoKutK8ULsqEbkOQLqCw6HfIVNWFg+XgYwkwJ63
         kmbVPlihYKDGBShG61I1XIy1D+lK7C+IwqOhSSJXoNlNHDkgGugu6JYBzb+FVID7B8b8
         JrgAIX/ihVzXVgLVnZV9wyq/kVan+v7jhFC0AGV54Q7KAJrUUrvQi41PL5aP0/CKA19q
         GSeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762650012; x=1763254812;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P6y3TFdHBEZk/bwF/qWSyN+tu4MCaAtXn8kZScOn/II=;
        b=xUu9/AzzO3w2MtZ2yZlgHMENOGBZsZ1oqaaG2YM5tTkiXCfNziIJoWzAqS1q3mq2g7
         qFLbItJJX6guEMwjZmx1/TOFiwWCbsd/DekTmW0S3zPMiZDNU53CzD/VRnwT2+d3zPa7
         JhOn+2IPdnfLiILYNY84TkL9VY1V9c6vIW62mcH4P7QnEqlRIzk2wJIGTjnCz5aXbDNU
         UgrBLxqLmBfxnMpQq+LiLut8lyFWNS7hFAMmGd5SqtaCdHZgwkIeJhW/1eLi7WBVCyd5
         sHJGH6BcIBwysXuncykTHhjsCzQ0QorOUT5d4lH5acVIrbOzFBQR3rDm6FGJCk+hWHZ3
         v1Wg==
X-Forwarded-Encrypted: i=1; AJvYcCUCMisjKqvVUzxEsxJNxmk6ZvquyJqAP0cghVofBGANQpRPDdA7KaY3uuWI0ycrFlXKmHU78IuQwfzz/rw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVLuQ3FVF7mqC2EQFIWWptZO5N168L+SK9PU4ZN1N825S/BInk
	UlyQJPBdLbOIMUSGXLt34zE8aaVHUm24yqz9KrpMKA2ikilNVPNGvEnno9DFC4GjcIDGQQvJ2lO
	C2n7lgHXlNg==
X-Google-Smtp-Source: AGHT+IEwqkPO0LTwSEjO/KwiMnjaDr60PlW1k0ZcISsA6YD46M1sO8jbptz/j0pezzJdaDxc+ODhmQXsnv9Q
X-Received: from pgbdn3.prod.google.com ([2002:a05:6a02:e03:b0:b97:fcac:5547])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:734a:b0:2cb:519b:33fe
 with SMTP id adf61e73a8af0-3538b0f60ffmr4779118637.21.1762650011997; Sat, 08
 Nov 2025 17:00:11 -0800 (PST)
Date: Sat,  8 Nov 2025 16:59:58 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251109005959.2540616-1-irogers@google.com>
Subject: [PATCH v3 1/2] perf pmu: Make pmu_alias_terms weak again
From: Ian Rogers <irogers@google.com>
To: Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

The terms for a json event should be weak so they don't override
command line options.

Before:
```
$ perf record -vv -c 1000 -e uops_issued.any -o /dev/null true 2>&1
|grep "{ sample_period, sample_freq }"
 { sample_period, sample_freq }   200003
 { sample_period, sample_freq }   2000003
 { sample_period, sample_freq }   1000
```

After:
```
$ perf record -vv -c 1000 -e uops_issued.any -o /dev/null true 2>&1
|grep "{ sample_period, sample_freq }"
 { sample_period, sample_freq }   1000
 { sample_period, sample_freq }   1000
 { sample_period, sample_freq }   1000
```

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
2.51.2.1041.gc1ab5b90ca-goog


