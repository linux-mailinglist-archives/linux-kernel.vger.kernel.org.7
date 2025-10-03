Return-Path: <linux-kernel+bounces-840901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 928DFBB5AE3
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 02:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09B563C3599
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 00:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77110189919;
	Fri,  3 Oct 2025 00:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YB8tnYmG"
Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910EC6F305
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 00:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759452085; cv=none; b=GoqscCAppF7gOJBgTxYGRNJ/OKm+oJBaGWg5MPcGNrCQOr44KQmo6F6nUySxq7U2B68g/Y14Q5X+BOh12ybpvoQVWwhyOQOuw5wMfqs30pB4/H3fFZsTkbwEMb9JnpVdBrYMKMtFxguXve7YJd0huQbPT1pHDOhzpT5Sb2BJTIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759452085; c=relaxed/simple;
	bh=OpUdHXUA0W+Q6HfIdjC5/Eo2qQS6nQyXRDaLDwwWGXE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=mrEM7YbCdG9jJcRqGBaWaz5kzVegMfyuP0tZ6i9yvT8PCj6C6AKTv6pZs/o5m/xH4QBt6asxFma5IhP5HViQhBzks9GWlHEjrznH8Rh6U3Y1EOPRMwBzihq6+XAyIazx4bVs4gizaLjk9bWWOyPEgBczUus2kQId5/HNTdsm/BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YB8tnYmG; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-361a25fbe9eso1610263fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 17:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759452079; x=1760056879; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CCzKIcxSwtwSrniu1/P7nPNHr6oMGAp8BGuB6qmiLI4=;
        b=YB8tnYmG6SsChHmhZRyXLRygcNNa5qwkZ/2foxQC2WeaEYBFCYjEUmtZ/azd/GWkUh
         U5J8kCU7+O0XS0hBRcImloJYZnGrMe9zwVHAySnijZARETnVEJCbzYH4dfuOtpP8afna
         o+Vdk0BRl+Bm58G1mey1tE2SWbVCHSnzZYnSdCuxvhHjcGmxMJIifH1IFJyv+kwQE1kx
         JOs1D+YBm8Nq2ydXOjmcWmkoYPFXJ+7x+0GgDznKKzbkQrdlHND/WRU3VvLfSSrinx9v
         Wbl4rhS6KpVAgeRs4DFlUMXDbbzz1pf2rktjYkgeVebir+DQg/aridgHKiJvKGsEDspT
         N1HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759452079; x=1760056879;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CCzKIcxSwtwSrniu1/P7nPNHr6oMGAp8BGuB6qmiLI4=;
        b=LOSI77w4wJMr18hCZTt1HEU2iy//325quXyJ81qcHL5eK/X0EUS44l25QIyqPhRGsy
         A1RZLDcmgCuNyQxYu5EKWFTdjnyKWyA2enkI4bDVzufVfQbwA+dmPmGVv/moVyWOJLIT
         ekK0yL2dNghN+uIxz9Ujkk1iHOWzC59fNqcV32Phm/GBUgoMzhUXco1U8NAQMRmfyosT
         8OI6xrSF5Dn6Wb8RomomzMhYs/TdOgEfXan9OuGo6LnMYrJf/HIKlCugqghy734b8yfN
         B3oMiNaJS2PnhQ3N+vXqgDdp7BAAHdjlJzM9q2wPd2gHut1isCeCsezb/R6uSINq8Mjz
         lLRw==
X-Forwarded-Encrypted: i=1; AJvYcCUWaHqLyQlxKKxvtsP4FPKO77I+7IeqdRTkn8+yV+zjwq1ml0chDdZ6y3qFg1t1UzeusE24Iq7+T460HUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCfKBFGTdvDDRSRXzdqbkL0/CHOllW25HWjuNmUainlSX5HCWG
	mHYfFaMV0iWmQUhPcqpnsiT9H5UazZjiuftssOcWwUUkyIqLGWvfLm01tV1kKfawK6ciJQLQpYG
	uQMncHD87vw==
X-Google-Smtp-Source: AGHT+IHSKO6pynCvlxVgyPpdGQ5vMYpKoedA5Lj/IAAoV6RAFlFnYhVoeUzAmxNCKVa7k5b0HLTSZ71wpDdu
X-Received: from oabmk9.prod.google.com ([2002:a05:6870:d09:b0:368:ae2f:aa00])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:f116:b0:322:5678:8245
 with SMTP id 586e51a60fabf-3b10283e0edmr803446fac.31.1759452079552; Thu, 02
 Oct 2025 17:41:19 -0700 (PDT)
Date: Thu,  2 Oct 2025 17:41:02 -0700
In-Reply-To: <20251003004102.2369463-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251003004102.2369463-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251003004102.2369463-2-irogers@google.com>
Subject: [PATCH v1 2/2] tools build: Remove get_current_dir_name
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

As perf no longer tests for this feature, and it was the only user,
remove the feature test.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/build/Makefile.feature                    |  1 -
 tools/build/feature/Makefile                    |  4 ----
 tools/build/feature/test-all.c                  |  4 ----
 tools/build/feature/test-get_current_dir_name.c | 11 -----------
 4 files changed, 20 deletions(-)
 delete mode 100644 tools/build/feature/test-get_current_dir_name.c

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 9c1a69d26f51..9399f591bd69 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -68,7 +68,6 @@ FEATURE_TESTS_BASIC :=                  \
         libdw                           \
         eventfd                         \
         fortify-source                  \
-        get_current_dir_name            \
         gettid				\
         glibc                           \
         libbfd                          \
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index b41a42818d8a..d13d2a1f44fe 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -8,7 +8,6 @@ FILES=                                          \
          test-libdw.bin                         \
          test-eventfd.bin                       \
          test-fortify-source.bin                \
-         test-get_current_dir_name.bin          \
          test-glibc.bin                         \
          test-gtk2.bin                          \
          test-gtk2-infobar.bin                  \
@@ -147,9 +146,6 @@ $(OUTPUT)test-libelf.bin:
 $(OUTPUT)test-eventfd.bin:
 	$(BUILD)
 
-$(OUTPUT)test-get_current_dir_name.bin:
-	$(BUILD)
-
 $(OUTPUT)test-glibc.bin:
 	$(BUILD)
 
diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
index e1847db6f8e6..778883a32afb 100644
--- a/tools/build/feature/test-all.c
+++ b/tools/build/feature/test-all.c
@@ -22,10 +22,6 @@
 # include "test-libelf.c"
 #undef main
 
-#define main main_test_get_current_dir_name
-# include "test-get_current_dir_name.c"
-#undef main
-
 #define main main_test_gettid
 # include "test-gettid.c"
 #undef main
diff --git a/tools/build/feature/test-get_current_dir_name.c b/tools/build/feature/test-get_current_dir_name.c
deleted file mode 100644
index c3c201691b4f..000000000000
--- a/tools/build/feature/test-get_current_dir_name.c
+++ /dev/null
@@ -1,11 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
-#include <unistd.h>
-#include <stdlib.h>
-
-int main(void)
-{
-	free(get_current_dir_name());
-	return 0;
-}
-#undef _GNU_SOURCE
-- 
2.51.0.618.g983fd99d29-goog


