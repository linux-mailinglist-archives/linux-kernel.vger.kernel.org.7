Return-Path: <linux-kernel+bounces-585771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5259BA79758
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 23:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F0243AD5F5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 21:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFD32E3360;
	Wed,  2 Apr 2025 21:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s55bdx8w"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B2E42A87
	for <linux-kernel@vger.kernel.org>; Wed,  2 Apr 2025 21:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743628392; cv=none; b=MpUzxEeLhPGjvTZxK1DD2vf2UmXN3fmlyx+gaW9meS3yuWGeVPUP5oM23hT5A0DakMpUAmW0x+WCUfbO5lgfUBDTvbMCklBT7u07UD9Ec6w4BzzHgSfnJqCiYUEtgHkJiVT4d6T6aEZU4EJCkyvK9NG/QSh1LLJfO2ym68KMC1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743628392; c=relaxed/simple;
	bh=TgbJXRei/MJkwBQQW2CIi+RzmhVoGrHfJWNl7eYbuiY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=J5lg4IA+ISKyKob42zkBSOcEBh9BSyHOeZklR0JY+eMQroUiQSOP+kFJEtu9vJdjoo32r1CdGLahsxNWLTDyhWyjowZ5WAptELOMOOQJHnVOV3dI0xV30AL7mnSxRPFZysyzNc4lThBDbla+33QKw16DeuEAQB/sUyi4TFpqWhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s55bdx8w; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3055f2e1486so335982a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Apr 2025 14:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743628390; x=1744233190; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uXRs0g5yHeq9YWfa/mzLTHdotWe9fUMTKG/kzmLAJio=;
        b=s55bdx8wGjrLk+9mOiwDGhy2wXDK9B0ZHehfFjBiyjax2qfGfhHNR0QvA32CPajnGZ
         Ys5HaVpv4PgxgrBYr1tIpv49Hb3Jix8kiYMs5KLrZrWTwRY0ItP6Q7hIfeTfcqkW0u3p
         KP8SB995Lt9l6/3+iJPi8MemzI7vw7gzawBKf4J20KdWaCYHCj/oC6W3/cB0xxl3GHEJ
         MiTZt3Fcd10EjgIN20R+hCJD4St4ma9EFczBUlIGlzJfsK2aydsyapRIJQcgxko74eb1
         BflfcJuPWoLWZ44Onmgeyn8/QYkA2Fuz+vUkZIWS7iRzPkvjBd56ZEzxICp6GGHQN78C
         KTlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743628390; x=1744233190;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uXRs0g5yHeq9YWfa/mzLTHdotWe9fUMTKG/kzmLAJio=;
        b=e2hg+LeihgypEHVrKBE5InyEhCQqvuHgCEYl4HX4p6IdcaqEH/zo/mLKAAVplxh5Du
         BEbbhVUcVNlWaYV3+k3wij4JEQ0JMkcULgLFdeiUyW3QNW+eCF5w/n2Wgq7CKUcJnP3L
         y7PHUNiAPctm0wUnmsf7tqavEmpMQ4DpKU2LMxhAD7hk8xzIGJkT0jVGoreTxn6omJuJ
         xi1OekWkZ7kCD9PDttsDZNOv5Bfj1VSXmfCz5i4PLSbQWJ1/bzBzjMrdadRMtTb51zzp
         f4BpiIpO2or+tMbnnzOy/h/z6T+ovakfMgcLeMk6b1tEylXNR2zEVkxT7ny126+kZJ7j
         7ZXg==
X-Forwarded-Encrypted: i=1; AJvYcCUZr6XgMMlG++WbrMzQ+t6lai/KFa4Nhz2UTgbCENuc1ysqojUJljdxyPh6HO41GYlUvY+ks22p3Fgs+r0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMooHxNmovKixqDFHrWAepqBKq4k3DirVXid3TT1lIfVeUDWMj
	sJj/e5QtbX+9CSoB+qjlqO3FBMMsVXXo+GhchS6bmoeJl0Mly+N10To1wansr3maOGmiftVyNQu
	Ehj9XSA==
X-Google-Smtp-Source: AGHT+IGHthZvqi8f3jdcHEj1pWWCdlVYj8vIju8F4mWAOyu0u3NRzdUftrasTm+qavXg3+eaqvrYn7kaqRTf
X-Received: from pjbqb12.prod.google.com ([2002:a17:90b:280c:b0:2ff:6e58:89f7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2811:b0:2ff:52e1:c49f
 with SMTP id 98e67ed59e1d1-3057cbc1fddmr276370a91.26.1743628389999; Wed, 02
 Apr 2025 14:13:09 -0700 (PDT)
Date: Wed,  2 Apr 2025 14:13:01 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250402211301.4153441-1-irogers@google.com>
Subject: [PATCH v1] perf pmu: Avoid segv for missing name/alias_name in wildcarding
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The pmu name or alias_name fields may be NULL and should be skipped if
so. This is done in all loops of perf_pmu___name_match except the
final wildcard loop which was an oversight.

Fixes: c786468a3585 ("perf pmu: Rename name matching for no suffix or wildcard variants")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 31f1e617eb20..d27bdf421c19 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -2060,7 +2060,9 @@ static bool perf_pmu___name_match(const struct perf_pmu *pmu, const char *to_mat
 	}
 	for (size_t i = 0; i < ARRAY_SIZE(names); i++) {
 		const char *name = names[i];
-		
+
+		if (!name)
+			continue;
 		if (wildcard && perf_pmu__match_wildcard_uncore(name, to_match))
 			return true;
 		if (!wildcard && perf_pmu__match_ignoring_suffix_uncore(name, to_match))
-- 
2.49.0.504.g3bcea36a83-goog


