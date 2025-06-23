Return-Path: <linux-kernel+bounces-698848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F49AE4AD3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 18:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BA7844220B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 16:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9A22BEC42;
	Mon, 23 Jun 2025 16:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FTPmvnz+"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BA52BE7DF
	for <linux-kernel@vger.kernel.org>; Mon, 23 Jun 2025 16:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750695594; cv=none; b=X1kT5zGYuHGQlR9BoN7C7E19KBPqblMzurG8vSItj7SkgIArt6uo671fuQ9CQcKj7K11xVWEoz5js2BBRWgFnW2UkEvR/aLjrRnHPlaB0dWisuIeT/ybKqp4YtLLE8BIuHyVxtVftVr0QHzI5QnChu2/SKhCOcTwz60wBZhdhww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750695594; c=relaxed/simple;
	bh=E7B9Inl4HmoHc+FGyIR08o/IahvU3OEIJ8rKhq2/Rgk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=exofLbJdWjPAL2Wi+zYF1sHsa2CZgX30XJ5aBDayevU+/rIOIlP+ylI5RYsXw/7IBi1UvAVhXPbLFUL4CrYA52KLiNPto7EltPWElMVCyb8e/F4JNNDwIr9uR4mODd9yn3vlkPbHPaV4/xlwZFVohIFOAtY3zR2Ibz1Qf1T2Sp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FTPmvnz+; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-235e1d70d67so44005695ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jun 2025 09:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750695592; x=1751300392; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3gPYRA7DgSeHibArew+2c4iZf1bh70D+3mjPGfPwBAk=;
        b=FTPmvnz+XigJoE2P5gCFTdI/bq7k2AVcyNdXfqW6LTjYpr8HlxFYbQn/AmuBXIcPXn
         SzDA6Y7mdJFhp3DW4U7UN0OmzU/EhcQlExhu4w2x+CUA6KW+gcFZU09qohHOaDiOu+/+
         b0v/Cyp1uA1usITwh4anNRYIuLSJajns5dCUBclDJDzp51hhbKjFK3OzHiCXTSAxjtuA
         gwDwpoQmTSSELGhsW+2uYi3O7M9Bwr5pKR/HVHvw1sSDCkkASahv0+9DJtftF+akOXZw
         +BVGYUOjot0uzc1o/pc4Rty7w3au/mrRoevqJpxXNZhh7IWKiy58VAGjtfKUb3Vz/UDV
         e8Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750695592; x=1751300392;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3gPYRA7DgSeHibArew+2c4iZf1bh70D+3mjPGfPwBAk=;
        b=PG6AbVrWtnnPGvYfYpojxOQzP+5GBOJLrRiXRaP0SMXrFSoEDZXPL1J+gTWgsmrZoZ
         Lr9JsoWYo9YVlW3Nlg3x5/5RT5l6GF+5gnLuBRtF6ecHPgR3Ccl2bUxt3jvaUr1D6unC
         8CXCQq2EpjjnC7opmO7sD/9Ilmoni7ODmVYQN1HeXKoinFaPmwgJPi3LQqign+uho7Lw
         h8tEdRNQ8RpZP7rY68cAeiUc2uHM1fpJKGiIStpdA3lvSfNKZkUJ9Z8Cb6aXb2msD7Za
         7urCJvSXJczDDZi7Irw9dyYyBPLuAGpsHC6QRYkQ2Wu0UBFaaKHQk7Z/QrpCH7/XAwBJ
         9sHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVX6GAmxPdSd6hfNX5TBdvJdrc9vmzj7RSgzeQlSdO12mfL8YCWCLYct/X7TaJDY8OUx7lfGZf4oss9sHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcfHHZgpoLrfTcc79TPd3ObMSaksdrVRmxyfuZ6703lCKWdwEx
	yhG3cOoDUU/+Ik3V2QBdpMgpvFrdCzlxQ6VqwIRVnfXjompriUCLVxngV3tnU4Ho/K/7j+zw4hu
	yhKcXtIA0WA==
X-Google-Smtp-Source: AGHT+IE8wJAtcCLfGEr3MPHoptFsiV13Q3gnuYSO8mJqsxSyGq4eUFYf5ODIbkzt/hsrEqq19XIPqppchKse
X-Received: from plgk10.prod.google.com ([2002:a17:902:ce0a:b0:234:8c63:ac2b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:230b:b0:234:cb4a:bc1b
 with SMTP id d9443c01a7336-237d9b8cbc4mr205740785ad.49.1750695591820; Mon, 23
 Jun 2025 09:19:51 -0700 (PDT)
Date: Mon, 23 Jun 2025 09:19:29 -0700
In-Reply-To: <20250623161930.1421216-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250623161930.1421216-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.rc2.761.g2dc52ea45b-goog
Message-ID: <20250623161930.1421216-2-irogers@google.com>
Subject: [PATCH v4 2/2] perf srcline: Lower verbosity on addr2line debug messages
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Lower non-error debug messages to verbose 3 or larger.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/srcline.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index f32d0d4f4bc9..3e3449e35dd4 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -524,12 +524,12 @@ static enum a2l_style addr2line_configure(struct child_process *a2l, const char
 			style = LLVM;
 			cached = true;
 			lines = 1;
-			pr_debug("Detected LLVM addr2line style\n");
+			pr_debug3("Detected LLVM addr2line style\n");
 		} else if (ch == '0') {
 			style = GNU_BINUTILS;
 			cached = true;
 			lines = 3;
-			pr_debug("Detected binutils addr2line style\n");
+			pr_debug3("Detected binutils addr2line style\n");
 		} else {
 			if (!symbol_conf.disable_add2line_warn) {
 				char *output = NULL;
@@ -595,7 +595,7 @@ static int read_addr2line_record(struct io *io,
 	if (io__getline(io, &line, &line_len) < 0 || !line_len)
 		goto error;
 
-	pr_debug("%s %s: addr2line read address for sentinel: %s", __func__, dso_name, line);
+	pr_debug3("%s %s: addr2line read address for sentinel: %s", __func__, dso_name, line);
 	if (style == LLVM && line_len == 2 && line[0] == ',') {
 		/* Found the llvm-addr2line sentinel character. */
 		zfree(&line);
@@ -641,7 +641,7 @@ static int read_addr2line_record(struct io *io,
 	if (first && (io__getline(io, &line, &line_len) < 0 || !line_len))
 		goto error;
 
-	pr_debug("%s %s: addr2line read line: %s", __func__, dso_name, line);
+	pr_debug3("%s %s: addr2line read line: %s", __func__, dso_name, line);
 	if (function != NULL)
 		*function = strdup(strim(line));
 
@@ -652,7 +652,7 @@ static int read_addr2line_record(struct io *io,
 	if (io__getline(io, &line, &line_len) < 0 || !line_len)
 		goto error;
 
-	pr_debug("%s %s: addr2line filename:number : %s", __func__, dso_name, line);
+	pr_debug3("%s %s: addr2line filename:number : %s", __func__, dso_name, line);
 	if (filename_split(line, line_nr == NULL ? &dummy_line_nr : line_nr) == 0 &&
 	    style == GNU_BINUTILS) {
 		ret = 0;
-- 
2.50.0.rc2.761.g2dc52ea45b-goog


