Return-Path: <linux-kernel+bounces-707388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31EE1AEC365
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jun 2025 02:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA40F442D24
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jun 2025 00:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9BC43AA1;
	Sat, 28 Jun 2025 00:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WZwCxa49"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB6D1F94C
	for <linux-kernel@vger.kernel.org>; Sat, 28 Jun 2025 00:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751069381; cv=none; b=KWjiPp/U/T9OiO07EEBWd7WVldBbkAYpeTFFORTmmiLEnnObsWaMgbbMRo6iVIQTbN5L6SFae+LnTDfincFcQcvpXwUVR4t63Dbro0Hadr5KhBCmQY1YRdy0ArqbIpmT2gZZk8H039syC53rwYTNF3lC1958yl81rcVK794tUAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751069381; c=relaxed/simple;
	bh=kNO3vDYlEvZ0C+HDMguSyMRCpwtCigdQZxRa4vWHttI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=efh/BDFCpaJWERK5m0iJoThJTZGLixoASUx3OJXBGmgH//us0ZWUEfUpEplMahSmpXEBOTqaE/BnBSIpF29UGXDT/0pEdTKM9Eibgkrz+YXG4wVO7uN26Vl9r9W/xvoGWOx57RzLZmU3Zyzmi9AsJUcfDsFy9Y9bXIJh20JNH3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WZwCxa49; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-313f8835f29so160432a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jun 2025 17:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751069379; x=1751674179; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nvPGYLp2e0uvMUDISbttjjvlMzPAeAoLlzlxkD8oChk=;
        b=WZwCxa49MtD46LTgrQmAkBuArQm/dBuKuPw/CsPSK2sn19TUPKZXH24wzFwP8jYblZ
         lfzFjTmPAqpmkgxGDuRqKQ9MULR9GwCp6r8moZUbRMl1NyArM2jZr4BaIA0yKyWj7Wsh
         u2goOrUE8P0WeLWyVMq7oeGEr1sL9hH0v+2r/MwfDRqaVClTOpesbeOmcIbi2/z+PZIi
         SD5b4yS3PlVw8OV3cU4vIJrL18G5EOCYfM3RFNgCbv7vNzy27FMP5vgLUan8UrU/1T4Z
         BZRyarAvmYve2Xx0u9qjGTysPfYQ5XN24MONpwTO5nibpnJu3H566hwBMF9LvqILji7T
         hg/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751069379; x=1751674179;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nvPGYLp2e0uvMUDISbttjjvlMzPAeAoLlzlxkD8oChk=;
        b=oubqnZYmRpQyyJaGckBFxPUTT0tgnHawCeSR/rZYQalX6m9x3AiTSsW5zqTFWyyxvP
         MWDtnfp9HBI2iawddaqhz4EKZMtM2oqA9JFFnU8ToPVHheWco+Hre2rJ3q8fASK+JCXs
         jcYDuZHcvPlTWQWOEk4O8o4CPKeWrGAlM2k6bNZ8gg6fW8/zJ5riWPZU86TQZfauZD6W
         ZR8r2+lcGM4ZSN26BEOL5OCpYtYX4GU5Mkr31vFpyEl9Lqc1kllCdALgwGoEJ3Xu9OIu
         tUaLryvVYEsJya4D0ytkkZFslYH0H6tDas8cUClUrtmEK9jw2CNUk0Tm7IFt8Klkyoop
         2z9g==
X-Forwarded-Encrypted: i=1; AJvYcCXPakatkxDfIoqSELQYRyOGi9UGQ7MfDGPxlA6USf7oQiMPxYrPaDPxrPbZbjqzM/1xY4dRnvG/lXpL77E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWCrQTfEoyG41gZbtzPp8KpBWQSasv1Z7M30xgdlAwRZ5DwItz
	WAd+zmuixPzQg4nqybQjN4p70ZXmYpT3yncdQqAgaEuPRCYKWV9VEQ6fGf4ck28EN4L0MxMoxJz
	EGHdCc0eaUQ==
X-Google-Smtp-Source: AGHT+IHpGtQcDFGzzHgc0j/PCxoD4+w4FTFjtyKxM9ve1cFeFf2CfBeemT2zOvJvofJH36F2BKnoJP0G5mWE
X-Received: from pjb13.prod.google.com ([2002:a17:90b:2f0d:b0:30e:5bd5:880d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:28d0:b0:312:1d2d:18e2
 with SMTP id 98e67ed59e1d1-318c9243c54mr7191341a91.20.1751069379352; Fri, 27
 Jun 2025 17:09:39 -0700 (PDT)
Date: Fri, 27 Jun 2025 17:09:17 -0700
In-Reply-To: <20250628000929.230406-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250628000929.230406-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250628000929.230406-4-irogers@google.com>
Subject: [PATCH v4 03/15] perf python: In str(evsel) use the evsel__pmu_name helper
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

The evsel__pmu_name helper will internally use evsel__find_pmu that
handles legacy events, extended types, etc. in determining a PMU and
will provide a better value than just trying to access the PMU's name
directly as the PMU may not have been computed.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 82666bcd2eda..49e1db3feb87 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -924,10 +924,7 @@ static PyObject *pyrf_evsel__str(PyObject *self)
 	struct pyrf_evsel *pevsel = (void *)self;
 	struct evsel *evsel = &pevsel->evsel;
 
-	if (!evsel->pmu)
-		return PyUnicode_FromFormat("evsel(%s)", evsel__name(evsel));
-
-	return PyUnicode_FromFormat("evsel(%s/%s/)", evsel->pmu->name, evsel__name(evsel));
+	return PyUnicode_FromFormat("evsel(%s/%s/)", evsel__pmu_name(evsel), evsel__name(evsel));
 }
 
 static PyMethodDef pyrf_evsel__methods[] = {
-- 
2.50.0.727.gbf7dc18ff4-goog


