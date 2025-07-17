Return-Path: <linux-kernel+bounces-735502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78813B09036
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 17:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87F553B1886
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912182F9491;
	Thu, 17 Jul 2025 15:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2sjr0KQq"
Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FB52F85F6
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 15:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752764954; cv=none; b=fWXERCCvqqIffOkiznc9HvOPoduvF0jE3KeOVV3v4IEMq7OAadMhk513/g9qL6V+HCkTSjIOHVwyNd7WtihDpZUt1zwk5Q/EMSWkljRUeBdPQ+CPEubCJat9o3kB23vw1O6v4V1JCNF2VrOoFD5DipxPmcEAi4r/VzdTnL2fUNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752764954; c=relaxed/simple;
	bh=yk5WicchXH7kEqMOOINlnmBRjpljp2ExxBrZz1eU5C0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=dzf+3BkXs59QPpBPANPaspkZd6HppghEQMRcBWBMN+iCDGdZZXcs6XwUhvRBkP+G8oo+32tasl4OnUPQW6JbxmXhmZgc55/Hqomvsvmr5rlM42SyO472QoBPzhD2kzYwZqxALJypKI6hjhWtQK+izVm4019x8EdhuTDTP7NdIvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2sjr0KQq; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-2e90e7f170eso1032135fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 08:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752764950; x=1753369750; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9YYyU2vUox54cPmAD4uAW1jDEZGoCp+ay+KflLB/XBk=;
        b=2sjr0KQqJ7gCuxw7R69bR4POfd8Zk0KZyBu5f+pewdZVDFaGj+ASo+TMHKfRNgusnV
         eMB3gx+RXM1B40y3UP5AZh7HSEoPguIhkaqS/8J5d7snp5P5Tx7mlgD1ZZALCsWfdwTS
         LACEv12QaHLT0E88eF6l4wrWDEAAlNGt2vYAqs15piIJM+f4v2KT0Um69dcxQX3Yeg6p
         RHClDt6LoNb6KoBkZC2bj1NzGZ1O62l5/375Owb3j0PWP8kTqQVazenB2T8DCyighlEC
         TQZQ9B1Ti9tFMcU0uET2XLrR0lPS/ZwvGb4xIYbk7xrM813eIN2IBPVe1xpOvZU2eLIG
         X/cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752764950; x=1753369750;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9YYyU2vUox54cPmAD4uAW1jDEZGoCp+ay+KflLB/XBk=;
        b=pXQoQmVWz7229Nk6C3Q5vF9qPgNQ8HIMdx4iw5R+J163Z2y1EyZ4yA7lbaSYmhyd/O
         Fk9l3o2/ZV+8wJAtN0lQouYvX16421uamaB4RqM6Za5lRk8cqgLRcGsvu+OcUDfAXs20
         l/yw/Btw+cM9vsczgDpizz5GQOfMmLVPALiA1A6UM5z21JhTUOMBn0tgxuVhuShTZkTv
         2zapRObXuIk6D3Drdi5LWKsji0IOmCFOeZ7VAHKfkDceC/CY90qU3oqG9DXsKhDTP9j1
         kipbsvn2PiXrkNaGSemM9ndoDkQuf43U0wknDjiylTjP4CVlHpg25p2wcqqa5g+b9s3c
         iURQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBtgWygEW8jILtk75F9224s/rY/KmpB16zuiM1E+APJnFK9AJ+3I5ntiLwea4NqE3FKA8I2INy5DnGbLU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd1oaJboDFMDRSe+Oq93HPUhGZs8EAm3W9ZZHRKH1kCqHj334P
	iZmlbNG7HleG3+2HBPxNUgAWWqHQnigQL2+m4hRVsBFLxEIyvO5SsXJUcrY2z9h93xqKBwW/eCb
	eu/dp+C3JiA==
X-Google-Smtp-Source: AGHT+IHuliN83IC5yCzu25KQ7jXi3r5RebwiytHJsRDzpP0JlthTbt75BQHnqwSI+kC34hatoiwpaeL2NT81
X-Received: from oacdz7.prod.google.com ([2002:a05:6871:ac07:b0:2eb:8b8c:22d2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6871:80a:b0:2ff:a802:68a0
 with SMTP id 586e51a60fabf-2ffaf2c7465mr5321830fac.10.1752764950394; Thu, 17
 Jul 2025 08:09:10 -0700 (PDT)
Date: Thu, 17 Jul 2025 08:08:55 -0700
In-Reply-To: <20250717150855.1032526-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250717150855.1032526-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250717150855.1032526-3-irogers@google.com>
Subject: [PATCH v2 3/3] perf ui scripts: Switch FILENAME_MAX to NAME_MAX
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

FILENAME_MAX is the same as PATH_MAX (4kb) in glibc rather than
NAME_MAX's 255. Switch to using NAME_MAX and ensure the '\0' is
accounted for in the path's buffer size.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/ui/browsers/scripts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/ui/browsers/scripts.c b/tools/perf/ui/browsers/scripts.c
index 2d04ece833aa..1e8c2c2f952d 100644
--- a/tools/perf/ui/browsers/scripts.c
+++ b/tools/perf/ui/browsers/scripts.c
@@ -94,7 +94,7 @@ static int check_ev_match(int dir_fd, const char *scriptname, struct perf_sessio
 	FILE *fp;
 
 	{
-		char filename[FILENAME_MAX + 5];
+		char filename[NAME_MAX + 5];
 		int fd;
 
 		scnprintf(filename, sizeof(filename), "bin/%s-record", scriptname);
-- 
2.50.0.727.gbf7dc18ff4-goog


