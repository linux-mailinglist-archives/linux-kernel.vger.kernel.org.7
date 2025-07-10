Return-Path: <linux-kernel+bounces-726663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9AD6B00FEA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 01:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B275D1C48502
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 23:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9B5309A57;
	Thu, 10 Jul 2025 23:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AJbawKBd"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBCE309A42
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 23:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752191528; cv=none; b=VAFd5+l86UbRQxUYNbbH+SqsLAVhGa/mcoXWm3HPL9tt7y+2Eb9n0Zkrd62vshRq/FmRyJ8aK7UTDX+K9AFxBvWNoyknsg/7MBWDZGnAbL7fzF/+QJThSHvoLh/Chhq1aju0ZGuqgbUYbKZtRB30+yiC2Ce4dsJonsV04G8a2LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752191528; c=relaxed/simple;
	bh=gv1i3DNEGxqaAyeBCm8oJ3IImT0PmMzZRaQt45Qua7I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=hwoNh976ba46780CdYz/+M3CmZVpHO8hZMYsMuKyXdSd1r8fSdLdn4qlQ2/vSaxYiSaicpNObD4+8bMCV1rRbwvXzskul5IdlXf68gW7kaOeFCtODmP6UQrAkTvfPGRziIgV15bIhHeqz/n7V/817uHTpT1+w3PMPeIrfkEXwsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AJbawKBd; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-313f702d37fso1588713a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 16:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752191527; x=1752796327; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WHFbmZZJXyMo6toKRekC1Kog8DjIMtKrGBEtrtRAi4A=;
        b=AJbawKBd11qgB2xmABcsQN/zKaiEweQH6A9ZkLPB3BJHXOprZBS9tBHcLZP0b3mVKl
         DjBMVTJ/1oHlEOHItYn4FVFFqB6FDo61+6zMDCa/hxewTFhjubwzkj/FH1nHCNhVtnjl
         yQH0rnI2sm17WBZKdHFC4sTAOVlRbf3hwI1FDIn95QljZEvodH+Nhjwmqqp70oSf4e+T
         HfnbrEtVO2UfttWf6wskyBEXaG932HkMElLfJq0rD3RZTLC8bVv2DTSQhGBbJV3EMcQo
         HvLWCqWP507uyAhdnItQR8pmXEBP6QV1N8uUxvBM/NfHL+bu1gHSXHk/DHRJfdWColf3
         jLoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752191527; x=1752796327;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WHFbmZZJXyMo6toKRekC1Kog8DjIMtKrGBEtrtRAi4A=;
        b=fGyWSgJ24JBVLLUr3MiqR/0QqUj9W+76pS3Yzg2qCstkviHjkFxQCFScFSUED41NMy
         jWELruCPSY3RcPRlAHbAhSzW85miiY6z6KkdLYb4GDVeCFkhkoH97OLF1EnSK90Q7hgZ
         YDKmBPNcTx9np1RbE+uLYxj18UqImwTzp4FhQ+l99emgwkcwtBfNFmsVEqjmYrkRN2Uh
         7zCIHy8pL0J/HG+NWc4J0+LPt05jzoS0ilhgOl/s30TT195v4f+aVRZNbg0p9sNH7ttV
         TP/HFqQ42wvbv3+sx3Rm74FOBFXgG1kdYV7Am2EYGde8c0MiTH+opqfXtuHhHuSJxZKj
         XqVw==
X-Forwarded-Encrypted: i=1; AJvYcCUGg47zbT5AX27lI94H830sTLX1AnHuz9izlzWkmjbyc91ehn++mW91I1BFeAn2cisvelyRa3WmckgApm4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3UH0INYB6Lmdj5uteLiJl7g4gxbcGW5p74PmrA82IRoUsRpEI
	rQdibwtAryK/pZ/P1JjBBzO+yGBfBUwPHVHxzm/EyBNmRI4fYj4ogqnFLS8dEvLiXsRvPV0nci4
	KBxQBGjIXwA==
X-Google-Smtp-Source: AGHT+IGxVkRUBkrU23Iuy028HmTd6f1O0vsX3aB33ymJ13pw4jtm5YKvpLkoaVw9+YgZTXWB3mE1TOSYqRv0
X-Received: from pjbof7.prod.google.com ([2002:a17:90b:39c7:b0:31c:4a51:8b75])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:f944:b0:31c:3c45:87c
 with SMTP id 98e67ed59e1d1-31c4f4af646mr640793a91.13.1752191526857; Thu, 10
 Jul 2025 16:52:06 -0700 (PDT)
Date: Thu, 10 Jul 2025 16:51:20 -0700
In-Reply-To: <20250710235126.1086011-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250710235126.1086011-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250710235126.1086011-8-irogers@google.com>
Subject: [PATCH v2 07/13] perf expr: Accumulate rather than replace in the
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
	Thomas Falcon <thomas.falcon@intel.com>, Chun-Tse Shao <ctshao@google.com>, 
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


