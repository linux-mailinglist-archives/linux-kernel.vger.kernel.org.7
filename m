Return-Path: <linux-kernel+bounces-780310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB80B3004C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 18:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB76D601FEC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 16:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3612E11D7;
	Thu, 21 Aug 2025 16:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pYLRkxMi"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA502E0903
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 16:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755794314; cv=none; b=ChHTyKkOIIdUeWLqhYVadTX1tJWS6sixVHI44xJggDW6+qY0VCRm59PXEG519abJ7rW8TPOivjGHboX+88Fs4gxTOfliMOpmwYFO/MckpfFL5kHA0zfuuXHwfkCM4RC3x7RzRzsqYf90XVqA6P1TkdbzT4//Q+CE2irLTgBsQ4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755794314; c=relaxed/simple;
	bh=eyA829iLXKDV2aXN/zMNIAyNupu1EE+3JDyACL8MmxA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=nfsUAlmq/ZcK1EWo/NlzA8GdyeMiqDVa4LRXD36RdldaXArbdAMVnqTG/pkM654XEcIakYzeC3uNGGCKDs78XifqPSwZvrPfWz1mvCS/th0SNg5E5iJMjxs54Lbyc/NUB7AbauGDpvs65MhSN+dIK5RsnnrP+Wo8bhk6XYfkrso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pYLRkxMi; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2445806eab4so14450315ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 09:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755794312; x=1756399112; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TzxYkTMP6IjvFIINqgjg2uV8ks/7NGouvlIDUbYRfdg=;
        b=pYLRkxMiuNnaubXwwWYnth9NbT/d1s9oNEmb1qokkQQY+bhZGdM69/p0XtFQOpcydh
         Ows8UEFpDc8TujZdSyRY7pivo5GCF/NO3FSKo9ChGw4eXirXCwDuby0HxhPslTOTsjs5
         enOmaTheMHMdXCrOUF3Cmrs0/Pqwmrm+2wVS3RjB2GptyqUwJ2ZZ18WF7RN0rBnUYfM9
         /TyBhnwdePFCKRVGK+MhAb1TBjV/L2Zqg/L2pZ1Nd816cR68aU7ycFhzEK58304jbESp
         jgbNX+p8ZikHcVYC8SLlatBiz8ij7BFAGehYd95vxjTqLE24q6m+42R8/H60iFCF9VC2
         3e6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755794312; x=1756399112;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TzxYkTMP6IjvFIINqgjg2uV8ks/7NGouvlIDUbYRfdg=;
        b=nDVsixvS5BAwZwNLN+XEZ2+NAKnhKjWLP30iEivcszA8mUJOXLTUHLI5Iu9Lkf7bN1
         jgRK/wMWUW9Z6QdC5XibxYwFRGhodeFwKsfBeV7GUuGo6wYvsJxzmNCvjz3MZWibzN5W
         3gweMVjT4AOzGwVMmgssGy1V+JvN7yf8DYX5v0P1lpYVup40Ex8k1VlRHJZRfasersa8
         2swfl2wOv6MQ4G4gyJYlCYuCm0aG9w6FUKz4Ac/xCme5g1FQlW+OyCasXHFKLfyYOEOv
         pAghEEa8TjuQYR0Rs3MiyB1F0yUOCxTZEbU8IAhg2CsvwCoTh5UswOFpyni4OWnLEX0/
         IUUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXM9k1u73g2Nu3roxBl6Ch5kk9Z+5gf7mLpq/khZbjA6k76Wkzey5oMXicoxld/v8sI1cHilY90CcOqBR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGcs17TXoogLh4ZodmHh4R/bmNcQ9brQtqzUC1q4M45QHsptBP
	wrLMTPmfGv1cNtNvTEGlmniS8qDCuYO5TmXGloY7pRbBbWEo9xldPAHT7/mdHObEWFy+ZCCtWTN
	Yw2/dtlbARA==
X-Google-Smtp-Source: AGHT+IFuEyc/k68SiPnvKZHreOAHcRO5VQTmY+lSWGvRBKsZHoGobugZ/jQ8sxPqHUjGsGhHdE3Org0x44xq
X-Received: from plxm13.prod.google.com ([2002:a17:902:db0d:b0:246:17d2:ab51])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:db0a:b0:242:c66f:9f87
 with SMTP id d9443c01a7336-245ff87a0acmr33871625ad.51.1755794312333; Thu, 21
 Aug 2025 09:38:32 -0700 (PDT)
Date: Thu, 21 Aug 2025 09:38:16 -0700
In-Reply-To: <20250821163820.1132977-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821163820.1132977-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.rc1.193.gad69d77794-goog
Message-ID: <20250821163820.1132977-3-irogers@google.com>
Subject: [PATCH v2 2/5] perf test trace_btf_enum: Skip if permissions are insufficient
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Chun-Tse Shao <ctshao@google.com>, 
	Blake Jones <blakejones@google.com>, James Clark <james.clark@linaro.org>, 
	Jan Polensky <japo@linux.ibm.com>, Collin Funk <collin.funk1@gmail.com>, 
	Howard Chu <howardchu95@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Nam Cao <namcao@linutronix.de>, Li Huafei <lihuafei1@huawei.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Modify test behavior to skip if BPF calls fail with "Operation not
permitted".

Fixes: d66763fed30f ("perf test trace_btf_enum: Add regression test for the BTF augmentation of enums in 'perf trace'")
Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/trace_btf_enum.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/perf/tests/shell/trace_btf_enum.sh b/tools/perf/tests/shell/trace_btf_enum.sh
index 572001d75d78..03e9f680a4a6 100755
--- a/tools/perf/tests/shell/trace_btf_enum.sh
+++ b/tools/perf/tests/shell/trace_btf_enum.sh
@@ -23,6 +23,14 @@ check_vmlinux() {
   fi
 }
 
+check_permissions() {
+  if perf trace -e $syscall $TESTPROG 2>&1 | grep -q "Operation not permitted"
+  then
+    echo "trace+enum test [Skipped permissions]"
+    err=2
+  fi
+}
+
 trace_landlock() {
   echo "Tracing syscall ${syscall}"
 
@@ -56,6 +64,9 @@ trace_non_syscall() {
 }
 
 check_vmlinux
+if [ $err = 0 ]; then
+  check_permissions
+fi
 
 if [ $err = 0 ]; then
   trace_landlock
-- 
2.51.0.rc1.193.gad69d77794-goog


