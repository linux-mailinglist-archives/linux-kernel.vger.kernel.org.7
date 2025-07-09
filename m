Return-Path: <linux-kernel+bounces-724535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6734AFF409
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 23:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1D413BDD89
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 21:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BB625A357;
	Wed,  9 Jul 2025 21:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WVulkJtP"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6047258CD8
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 21:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752097250; cv=none; b=dmx8xk6W2kSikTjAqO01TKIYaFTrToH60Z+NkPI37acuASLN3shbyAouy0GLLUi1BBa89RzJZg9fqU5342QnBu0p9gXXPrM6XFBn5F5BqeD12L37xXzfzh6SgzHdf3JhMQDCoIKI7FK/wgm+Qci4k7kZ5hog4QgtPeZpclvAJqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752097250; c=relaxed/simple;
	bh=gv1i3DNEGxqaAyeBCm8oJ3IImT0PmMzZRaQt45Qua7I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Qx/EQIKAtUuuF6x+XDSYYwu94ivZwwyTVQHp3zBEq+/hzqNzqNGh100C3bNjaGCKx7vnZfxP1GyjSI4qf3Ysj+auMt53UN/BV4VJX3VhbTl0fDaGqLDvjE/B09HRm/+8iOOZGs16nmXZfAHs6pOEbDxrCvuzORpV/zVb51FO5is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WVulkJtP; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-235196dfc50so2989015ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 14:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752097248; x=1752702048; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WHFbmZZJXyMo6toKRekC1Kog8DjIMtKrGBEtrtRAi4A=;
        b=WVulkJtPYzidkgMfIz2HXX+bTEr3+bJWsIz+0xVf9kwJAO+dMADGGaubnaAlbnyb4R
         9v8jQhm11XuuJmRcG1zBR1IZ1Hp+568kVGhyYidARgb7ZQ/VBmZIeHf+qkvLBAIUPkX2
         7+hK/EGdPnkcSoj9TnKiQ2TxcIaJUSGo4z/Omqa8JtdpcagpfRMNatyXMvP3ldWw+Lrz
         gi7vECYqfWQYQG6n2/lonECi/6v9zbCgcStv+83qnxL4ti6pu5112hH5kTdiE8wO61iJ
         mlm+OLvG8TPcPUyBe9P0lv+TkCvuSM6HPW2FEB/vDPB5R1WiRxI+cXPjnN7QbfW4oa4d
         XR3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752097248; x=1752702048;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WHFbmZZJXyMo6toKRekC1Kog8DjIMtKrGBEtrtRAi4A=;
        b=eoL8EoobgaO/JK1+9UzfNYi5i9wfdOlLzCIq4NkMfFKfUa3Fwiew0X25X+w0Di71/H
         eO68qkdRiZHuvtt1A16SUfcTTnqD3J1yfL2NrFHQiV5aR9lhI/Ed6atW996K4J81utDE
         d2zRG7wciKDGZ4ZmrVuXZJvfIcLQoZkITkcMUhfj9dJhM9+PSy05zmycNAptaQ9Zc8ha
         vunkSVAZRAgevFGgcENDGTdpdlzzE4Fyp6aitOpmreOA1KCkgBeWpAiz75bsMy8YU7kO
         YTC8swQmADotqUpfSE9hH2HDX01MuJ+HJEKLMybREZZmxxw44gK3225U/ev57eoH0sSR
         ylRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDq0HfwPdPQqBT35GufQtldwQEkx57z+3Nqq1eMXyq9UrM7Y6Aw1i2WGKYVzsdYBM0Rp05ip3FxR56QHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeUjgFabsbp+gTtofkFjOtSNMGMqCTd6+H70PDXEZPgDqJkwQu
	z1BcA1FdkSW5dzUsv9AtEDl+/8nkTdVsoDje8yi6uNWTn6yUA5iPkr+T8JdclSJkM8pNAqVwfPd
	mLeyDAPUKlQ==
X-Google-Smtp-Source: AGHT+IEPhXi1EE/yKqxcf/Tb2Zb4kUGNN8tEUGHpwwrfPN8hR88hey/bUWtBivYsketan+WB+niZag1LozhC
X-Received: from pjbdy15.prod.google.com ([2002:a17:90b:6cf:b0:311:4aa8:2179])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1b2c:b0:234:595d:a58e
 with SMTP id d9443c01a7336-23de3008346mr15749645ad.25.1752097248268; Wed, 09
 Jul 2025 14:40:48 -0700 (PDT)
Date: Wed,  9 Jul 2025 14:40:24 -0700
In-Reply-To: <20250709214029.1769089-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250709214029.1769089-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250709214029.1769089-8-irogers@google.com>
Subject: [PATCH v1 07/12] perf expr: Accumulate rather than replace in the
 context counts
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Howard Chu <howardchu95@gmail.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, Andi Kleen <ak@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Weilin Wang <weilin.wang@intel.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Gautam Menghani <gautam@linux.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Metrics will fill in the context to have mappings from an event to a
count. When counts are added they replace existing mappings which
generally shouldn't exist with aggregation. Switch to accumulating to
better support cases where perf stat's aggregation isn't used and we
may see a counter more than once.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/expr.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index 6413537442aa..ca70a14c7cdf 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -166,8 +166,12 @@ int expr__add_id_val_source_count(struct expr_parse_ctx *ctx, const char *id,
 	data_ptr->kind = EXPR_ID_DATA__VALUE;
 
 	ret = hashmap__set(ctx->ids, id, data_ptr, &old_key, &old_data);
-	if (ret)
+	if (ret) {
 		free(data_ptr);
+	} else if (old_data) {
+		data_ptr->val.val += old_data->val.val;
+		data_ptr->val.source_count += old_data->val.source_count;
+	}
 	free(old_key);
 	free(old_data);
 	return ret;
-- 
2.50.0.727.gbf7dc18ff4-goog


