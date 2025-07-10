Return-Path: <linux-kernel+bounces-726669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13710B00FEF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 01:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC4DB1CA50EB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 23:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C02315518;
	Thu, 10 Jul 2025 23:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qwuvr5lO"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBAE30E833
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 23:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752191546; cv=none; b=nu811pCwH71TfW8sEpb+blrTEzu3EWwHwH5d72skHOeVFBOvSDgiCDgWTVS+aluWhcsK3czh1TfEKxEmd6aRZL2ORzlxkYisObPvCkuyOldCv4imzdNDTbOR4BNOkj9CoAMmzNM7whR+UZHCZSl27HHT92qIjigYs6O5acFNE34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752191546; c=relaxed/simple;
	bh=m3mVuOV+FjGGQZSQOa/RyvRh8gyTPqaU/j/jeYS6pP8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=r8gG8m4MVOMSkf9OXuYkY/kB/NXCcxsctoQ+mpaVpXOuz1ho/77fgwvdxQS12iyZJwxnuNG63oNUpDckzdU31qOTym7s93BZgWJvJ52EQFzS6qhPCHb1SMVcbw+NemfTbb3Pwml6DgU+0FGkpzFPL1xhz3maFYUHuQXiIq2GXrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qwuvr5lO; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-311e98ee3fcso2381405a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 16:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752191545; x=1752796345; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bKKjyG04zvY4B3Cxa079gRu3GQTHZmfWcF0bIyCmCUs=;
        b=qwuvr5lOwwqVPQTQsMSGw0l30jY/H4mszQ1VzIOx5OO2KBF7MUdi6kOlaAwOjw3NdO
         yKwH+olDcyKIeY0Y057UQMA0jX3ocn4AatrS08Fya5H6gEq5Jd+/SugcrzrrPRLNMYTU
         i06G92xBBsIOzWTYcoIKCe4cFsMFQgQLRV8Df7ADCYNEn8EulimyX5ln1xLCdC9/7CmQ
         aHIGN/EDULPC9KFIeJxnVAhYJ/TQ0cq6AMuURrwNYC0egyGXryP4fVK9ySPbupoWQn7x
         QOLXhKEniDBEDtdNCSDT1AMZxdocNi1f6vkXoxbxi5UNQaC5QvMNL2zRWpdE6ibWrqxp
         eG6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752191545; x=1752796345;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bKKjyG04zvY4B3Cxa079gRu3GQTHZmfWcF0bIyCmCUs=;
        b=YarYucWHFKnsEPBaY/K+LQFpAjq7qb2vtS2liQLLpWUcXJqYe8mt7SEX3KQLAQb7Ig
         YZgwHGhtogt1RsQmcOnuu0K5kUM4gL9UEEU18yV2EoU3OHrXw17FGX3/Dl1K8dp3/6xW
         TpQ73LAZqFmWVZ5swbKIQumSWuZ56YIfEswiVC4AqV6dJRkajyOw0Xwojhfs1Qe09ySE
         PgTTF4yuy+deI6s/dIxbrOzuCSs164gr0E/EPLFMEY+iB6NQXogNYyJrkDu/aIAFISTS
         YoucI0Ptg/9UvMp64blts61bxLTVBIs/dFUYVnLyabkGtADlpqLQR50lkruabQPuCyag
         nWDg==
X-Forwarded-Encrypted: i=1; AJvYcCU2TL2l6jSpd6M4fNLnywoUCuVcyg9JfminHNxbAIwGfY+mXBWVwdIyo2RN3V1BGXn2D2Oo4SWguiySw1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdmvhUxruE90Rh9sD2D/VZfa/74LCvPzms/WaRmIprSRzrLyJZ
	e8r27Ec31O2ZgulDOzWTdbTMOv25xVX5rLVaatESNMVuBq5wsgdTbyUykBjl/jqxaFyz5S4kqzp
	h0Ue5BaeGsQ==
X-Google-Smtp-Source: AGHT+IEft9H81ix8+PRtUb8fGu0rx8aTovDOrMeNFLdvqd3XCOAMP/4bRQbIg7tplRXJRqSEWXoqJsDp6j+n
X-Received: from pjbss4.prod.google.com ([2002:a17:90b:2ec4:b0:31c:2fe4:33be])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2b50:b0:30e:6a9d:d78b
 with SMTP id 98e67ed59e1d1-31c4d4d0740mr1354347a91.12.1752191544776; Thu, 10
 Jul 2025 16:52:24 -0700 (PDT)
Date: Thu, 10 Jul 2025 16:51:26 -0700
In-Reply-To: <20250710235126.1086011-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250710235126.1086011-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250710235126.1086011-14-irogers@google.com>
Subject: [PATCH v2 13/13] perf python: Set index error for invalid thread/cpu
 map items
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

Returning NULL for out of bound CPU or thread map items causes
internal errors. Fix by correctly setting the error to be an index
error.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 1d9fa33d377a..2f28f71325a8 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -529,8 +529,10 @@ static PyObject *pyrf_cpu_map__item(PyObject *obj, Py_ssize_t i)
 {
 	struct pyrf_cpu_map *pcpus = (void *)obj;
 
-	if (i >= perf_cpu_map__nr(pcpus->cpus))
+	if (i >= perf_cpu_map__nr(pcpus->cpus)) {
+		PyErr_SetString(PyExc_IndexError, "Index out of range");
 		return NULL;
+	}
 
 	return Py_BuildValue("i", perf_cpu_map__cpu(pcpus->cpus, i).cpu);
 }
@@ -598,8 +600,10 @@ static PyObject *pyrf_thread_map__item(PyObject *obj, Py_ssize_t i)
 {
 	struct pyrf_thread_map *pthreads = (void *)obj;
 
-	if (i >= perf_thread_map__nr(pthreads->threads))
+	if (i >= perf_thread_map__nr(pthreads->threads)) {
+		PyErr_SetString(PyExc_IndexError, "Index out of range");
 		return NULL;
+	}
 
 	return Py_BuildValue("i", perf_thread_map__pid(pthreads->threads, i));
 }
-- 
2.50.0.727.gbf7dc18ff4-goog


