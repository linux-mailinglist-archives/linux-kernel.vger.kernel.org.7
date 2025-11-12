Return-Path: <linux-kernel+bounces-898090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F15FC5456D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 21:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C97AA4FD068
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 19:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A582D7DE4;
	Wed, 12 Nov 2025 19:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G3dzzOCN"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285402D6E74
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 19:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762977207; cv=none; b=e0VUSYbu2pUfbYTtU0WqHGo/Gm6VSvSgPy5fTytJs8REd7vop3tGKBz+BTXdMAwEf+VC4DUwGSHb7oRGXQq4G4dqLluBDoiYQ50TaViujG5DumNALLDejaf196OTpYBk/cGwHOPuiidA2CUqg1pmM9wjhnHiAaa+7oXEPS1BJb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762977207; c=relaxed/simple;
	bh=V0KWJkkWP57M69eZSbl6MF20thMIqRQTy5N0N9OK3YU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=IKuT+LEfZCOaP0cKQQlnJMUayzjRaO6hCJRhtC2oOroNUekFvaKpjsfryhyMEhSANGjy/0TVaYr1nzLlZKrWoNJ94M+MKtCkXlkKQYx0rYGSsPIC4fzik1vK/Wqq9lDztDQUQGTBIOxr4Ojrut1np8dKAB+OqkNeIe8bX0Ik6wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G3dzzOCN; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b99763210e5so18989a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 11:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762977205; x=1763582005; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sf0aJeaxTeWu5QV0R458NriwUUamTc+0q0vKrwxanVw=;
        b=G3dzzOCNfVSjLAjaxHPQDMaIenDAXbSoiKsuT1BIA+LstY1Hmgv4eoO3/WmiLUZCXC
         MBYDCRVPJV7q1UIIh8UqIlXYXJ5dY0nGe3KYBkAQIfbagXSAVVLEBAidNPXibvPtgnuf
         iTULhyf4LK4IitNqxs+GHxX6KgASyNAf94/JRuTPUXoZCVK0ePJy5NDlhmbqgknXrbXc
         jhXwKQZ27E/vXISP/GltMo6hMpEmj6xUX0M51KvmC4SlHGqwV9PPi1XlrOYE0oCag/9L
         TgBQ7Opuw43wq7a6EnQJkR/GdzvPc62eVZ3IehcgKmpSn38EnEMuB4kjF/WwKA5K7Qc5
         cZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762977205; x=1763582005;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sf0aJeaxTeWu5QV0R458NriwUUamTc+0q0vKrwxanVw=;
        b=DHYhsoqmELcKCqSvQqfFzRP8NNNZMXR1kUHAmzoUdgoE1OLLfwzlY6hq45CqiuK089
         YH7a2BvnlsiEHYcBz/KPtVNP2zdrwn8zNsdnhkTB7OPE0U7wA2317qP6biwYAlD1IR/D
         DY+vjIdLV/yDKqU7vPJah1TG/G1Kxj2hrWYH2xQi8l0zkb32jEiBV2z5+yvzX+RwbsyD
         JPaXRCXLGISE5v9Cn2Yt+4QKA4a8r0Ceg6v2Js6WsY1nZptvpaBKfNkIsWfXflSLGVgL
         E9HXPsknUiQfUG/0rdLPQjRiYkYZ6f/dgdp5SyPrAhZ+ipMliT/DOsyUFcH0BUvCQvwJ
         SCvg==
X-Forwarded-Encrypted: i=1; AJvYcCXFgUTJnCQv++QbtlqKmgYlh2+Imc/i/LGP3LGLUMVNcBiyck9Tk9frj71aTBhIM0hMJh/OZBQUTZYrjr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSuTgiWtAon50CCP8I/xNDEWJQIz/zbDjLblGSaQ5anA3Ntp08
	Ucg43vjLIdWRTbwOtzVWmLWBzo/4ncTBccp8dl3ngxhxb683OHHL9lcg3M0HteYyarpFVqWbS6T
	U8ljlGkj42Q==
X-Google-Smtp-Source: AGHT+IEawx7w00JKKScje92At3LUybXF4Jn0RR4rsvxGaZj5ql5/vEbJL4i+EbvSQME0ybNylUkue5E5gq8k
X-Received: from dyx20.prod.google.com ([2002:a05:693c:8214:b0:2a4:6312:d053])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:22c8:b0:295:59ef:809e
 with SMTP id d9443c01a7336-2984ed41fd6mr48593805ad.24.1762977205409; Wed, 12
 Nov 2025 11:53:25 -0800 (PST)
Date: Wed, 12 Nov 2025 11:53:11 -0800
In-Reply-To: <20251112195311.1673981-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251112195311.1673981-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251112195311.1673981-5-irogers@google.com>
Subject: [PATCH v2 4/4] perf stat: Display metric-only for 0 counters
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Chun-Tse Shao <ctshao@google.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

0 counters may occur in hypervisor settings but metric-only output is
always expected. This resolves an issue in the "perf stat STD output
linter" test.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-display.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 5ac9854f8c58..6d02f84c5691 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -913,6 +913,9 @@ static bool should_skip_zero_counter(struct perf_stat_config *config,
 	if (verbose == 0 && counter->skippable && !counter->supported)
 		return true;
 
+	/* Metric only counts won't be displayed but the metric wants to be computed. */
+	if (config->metric_only)
+		return false;
 	/*
 	 * Skip value 0 when enabling --per-thread globally,
 	 * otherwise it will have too many 0 output.
-- 
2.51.2.1041.gc1ab5b90ca-goog


