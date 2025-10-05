Return-Path: <linux-kernel+bounces-842467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E84EBBCC67
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 23:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2DAB54E6D43
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 21:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588B12BE643;
	Sun,  5 Oct 2025 21:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iNUpK6jh"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436F32C21C2
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 21:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759699360; cv=none; b=Zcp6wlcN+kRbX8hvFnPJAmDgyOCIm2TgVUIkBos4Ax+E3hz+vz4ZoTGm7JAbm5SyD966Yb5L09EkQ/dCeiwdHsZ690NNORXnbnpxcOt5QKQpLfz5kOsXFvI2qUiXV1QDIjvJ991Z3Asp3BUdkS5vL3luPEScAA23IiGljn+91Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759699360; c=relaxed/simple;
	bh=d45wEUY1c4jrn84/iwX20DQE8nKTJ3WT+ZgvlVq/fR8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=i94OOCFkOfAcSS4VBl4vQ3YrT6IxY+Z4b2hgvl4Yn5QpUPx/+q5D6Vcp53sXuUUeW4clZSLTn4YD9MZJnkVuQ4hiVhK5GIT01xE7YDwsZz8db8B1zgbIz8hw2deHbCihML57E1LdVK6cKe9MxudLFtkStVYRuC9S83TcUtmS8dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iNUpK6jh; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7900f597d08so335920b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 14:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759699358; x=1760304158; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5UwuX+qcsVkIci0z0OtUlxAA0Fd588bD/7/Leb924no=;
        b=iNUpK6jhPiS5f/hKDyyWnevN+OHiX3QhhcYyX+IlJdkzeQ66LZzEt6M9X0NYe0WshC
         1gS6cd6/5KuHzgs0hW3p7qCSZvV8krOdyGJ0QVlYzJaaNMkEepNQOdw2AdCpALrGc//I
         RYKINoeHj7LsI4WF8RPr8WcpSG5q/nUC3zzFGUGQp/FCM6T4z0ob9ZjrkX1p6yPKzceh
         4Y3/NBeioidySuI6sX5jNXJwgCg/XYfmWm9IU8twlYnyHwSIYSJ3QDahNyOnoBfZy4u6
         f+GR8GTQvvd0ptxbF6t8nxFI7lxwXne2dloWt28sXkwOK4vyHZu7SgHpDKNFl8RPKu7M
         N1zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759699358; x=1760304158;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5UwuX+qcsVkIci0z0OtUlxAA0Fd588bD/7/Leb924no=;
        b=aB+h/q/UJftHs59Fx9urAlJRm2xllUiT5oqWHZgvjN1Gg8GhNUeQ1ECe5MxMwQBZTT
         qcULKYhmpufpopxG1lOekJ0dzkSzui5LuA2NYoPmYzHxeCsFQMcpsfa9mP4xiX8Rq0la
         BiqSYPiRvAPPpXcjq+kZF0rHrw3shWASDETDq2S70Wh1nkmkjdQIBcpDkdoB5RULA6t1
         x3IUbvvOqZaCD6KxWS5CKhEs/cTmnPp4WT5o4Ar15DTIObwNykf8jpNrdZfnhg6XDqPG
         sC62dSVNPDNjTM//C8pdHU6GHAF8U9FufDuxcyFOTK1tf0paHAFvtDhZuszQD9x+DV6a
         NLKw==
X-Forwarded-Encrypted: i=1; AJvYcCVPSoG6Dc+V1f+OsOhvlcjVw2cqOdoOquEhUmqCG3hVmpXNuKs2m72O+SHm9arKAiywpgGko6nzTJfzUtI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1MUubeWC/Kvwqi/ruZpNAKZrz8x7goDTG+vJ0esi2z+Kq8iyp
	Ej0yc7i/QMlZCSb3X6r3kVAAUTq/SKKN58tYKqRGZ3PgtrultSPbEiws/2Yp6WlrxXQI1n8mGdr
	ZDC276UIEiA==
X-Google-Smtp-Source: AGHT+IGvT5pslbMCXLmkI8dz33jGeGYCBPk++vUXwX3QDvVBJVh6+9SImEKQrDsiOMs+ve1hP/rqlLC1JAam
X-Received: from pgac17.prod.google.com ([2002:a05:6a02:2951:b0:b58:7d6e:e9c3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:d527:b0:32b:70a1:7c84
 with SMTP id adf61e73a8af0-32b70a17d56mr10844469637.28.1759699357519; Sun, 05
 Oct 2025 14:22:37 -0700 (PDT)
Date: Sun,  5 Oct 2025 14:22:09 -0700
In-Reply-To: <20251005212212.2892175-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251005212212.2892175-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251005212212.2892175-9-irogers@google.com>
Subject: [PATCH v7 08/11] perf disasm: Remove unused evsel from annotate_args
From: Ian Rogers <irogers@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Eric Biggers <ebiggers@kernel.org>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, James Clark <james.clark@linaro.org>, 
	Collin Funk <collin.funk1@gmail.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Li Huafei <lihuafei1@huawei.com>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Haibo Xu <haibo1.xu@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev, 
	Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Set in symbol__annotate but never used.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/annotate.c | 1 -
 tools/perf/util/disasm.h   | 1 -
 2 files changed, 2 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index c9b220d9f924..a2e34f149a07 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1015,7 +1015,6 @@ int symbol__annotate(struct map_symbol *ms, struct evsel *evsel,
 	struct symbol *sym = ms->sym;
 	struct annotation *notes = symbol__annotation(sym);
 	struct annotate_args args = {
-		.evsel		= evsel,
 		.options	= &annotate_opts,
 	};
 	struct arch *arch = NULL;
diff --git a/tools/perf/util/disasm.h b/tools/perf/util/disasm.h
index 09c86f540f7f..d2cb555e4a3b 100644
--- a/tools/perf/util/disasm.h
+++ b/tools/perf/util/disasm.h
@@ -98,7 +98,6 @@ struct ins_ops {
 struct annotate_args {
 	struct arch		  *arch;
 	struct map_symbol	  ms;
-	struct evsel		  *evsel;
 	struct annotation_options *options;
 	s64			  offset;
 	char			  *line;
-- 
2.51.0.618.g983fd99d29-goog


