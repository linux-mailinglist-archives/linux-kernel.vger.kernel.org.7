Return-Path: <linux-kernel+bounces-840921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5250DBB5BBC
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 03:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3C4344E29EB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 01:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5A127D771;
	Fri,  3 Oct 2025 01:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RdygujaT"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A494827510E
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 01:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759454648; cv=none; b=KXlIBd326qsD+y9rs0EAO7EjAP3NtqNIuukSMHB+Wq66Mw5lCPJommxEgc4ibD+GZIeFskEq61tC8rrzkejmSRTRPL7cL/H9wx79kPhMHiG21daFmwsic0Ut+hLfyd9vocvs9tTIZRACz91SivyK4YQeKKYm+3pShS1MAELPou0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759454648; c=relaxed/simple;
	bh=5YQj5whNsy944Tq1nsPgEs2SC3r0ANA3hsB9j366qHU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=YDqrhfZkBorXj9KeoF+JT802xsSVFiZmoySt5Pojadf7cBOAug2c6mW/DL1U7+2qyrL8Cei3DJew/E61wbeeMQn5M7VqDFjrN/9U+sDcal+mWbSM35Ys7+uaY4l5DvEDKpwyFLIyczoqeZUMVG8+Pd4ApgtgdGzNpiWeQCqKQYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RdygujaT; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32eb18b5659so1592946a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 18:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759454643; x=1760059443; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4a36ssrUk2NOwqoWNNokgafRmPGrKtrh3ueHGKtWlXo=;
        b=RdygujaTfvghY5aIrVszsg0i07xaYCGZ4tm89wKO89C4R9j9a54A7fJumfv++d/y6G
         2ghPPmp922lzXOcVBmxbOeu6LzoviFthD/Whysjv/CKa9oGHHesWpbtNvZkhqZLsTifA
         pGvT5QnynywUsl63+MM7n8oqeugrwzS8Wma5HtKGd/2Fw/LmwW9h2uLxvj7kQZwDx88k
         K2G26JCbuPbVu6sHQOH7gPf02ZwPU2mUUH/CPkvSN24lhwN9ttjlz/m7ENjwaWEE8i8K
         g8c0A2bSaaK20ugkeLfDJ4SXoxy5YHKaDCuBdsLnKcnHve/fDwpnRk3UamqP8fvCuzuf
         lr4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759454643; x=1760059443;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4a36ssrUk2NOwqoWNNokgafRmPGrKtrh3ueHGKtWlXo=;
        b=WWaoW1y1ZNPCwRDpTLjTf7QJAMadrZQj+rFk03mB2jOnxQbmdglqnucepsV7weNKPr
         CGzOCALNV00MJm1/BCQwHOM7EZMIVaufsjeDImc/nZYMbPb8TcE50custdpPt6ERkRaw
         zs0rPsJTeqGyPJp/gvw/KHrwq4OQqJZFFW9aZ031NGDS7+YQGhnH+dWk9Dz60+U09wB8
         tJShLyENET9EOeSnLB8IhYcq0SB5Y9iCdrKMlq+em72CRCwYTIXIeSX/ArSuRn3kBUPu
         FPkPoEk7I7b9tuq/pKnEfFKok0PxdjUhFG/mTsxFJVtcmaP38CIGHkGDTUSFZbqtLY1m
         Jmdw==
X-Forwarded-Encrypted: i=1; AJvYcCWt8ZTSeC0Fbrt62dQcaeHNoNcP2wv4PSxlbw7ufuJdXr2rIohN389gciiEaywlLD4FMlcTqvPN8n4k7qs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxMtozuq/E2B8FFjrgoUkRlNbz2twBRE+BceenHSkrPoU8fb6I
	arYaWtlQu665OXeqSrS7RdYbh4BUsSrPpgwrB2a84CYrg2QnyShcpJO97C1VnENszWriGdo+VbD
	txJCvgN8xbA==
X-Google-Smtp-Source: AGHT+IHfyZpoMDCQT8hkrc//s6nFD45TPZ427CL0dAfY14RayEbEgz2tiGZWsZyPld8miWOzUhmcMlj6XJBu
X-Received: from pjsk12.prod.google.com ([2002:a17:90a:62cc:b0:330:49f5:c0a7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1845:b0:32e:32f8:bf9f
 with SMTP id 98e67ed59e1d1-339c27d2ec8mr1417437a91.30.1759454642812; Thu, 02
 Oct 2025 18:24:02 -0700 (PDT)
Date: Thu,  2 Oct 2025 18:23:49 -0700
In-Reply-To: <20251003012349.2396685-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251003012349.2396685-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251003012349.2396685-2-irogers@google.com>
Subject: [PATCH v1 2/2] tools build: Remove libbpf-strings feature test
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Blake Jones <blakejones@google.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The feature test is unnecessary as the LIBBPF_CURRENT_VERSION_GEQ(1,7)
macro can be used instead. The only use was in perf and this is now
removed.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/build/Makefile.feature              |  1 -
 tools/build/feature/Makefile              |  4 ----
 tools/build/feature/test-libbpf-strings.c | 10 ----------
 3 files changed, 15 deletions(-)
 delete mode 100644 tools/build/feature/test-libbpf-strings.c

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 9399f591bd69..f9477df18841 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -124,7 +124,6 @@ FEATURE_TESTS_EXTRA :=                  \
          llvm                           \
          clang                          \
          libbpf                         \
-         libbpf-strings                 \
          libpfm4                        \
          libdebuginfod			\
          clang-bpf-co-re		\
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index d13d2a1f44fe..fd304dc2aafd 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -57,7 +57,6 @@ FILES=                                          \
          test-lzma.bin                          \
          test-bpf.bin                           \
          test-libbpf.bin                        \
-         test-libbpf-strings.bin                \
          test-get_cpuid.bin                     \
          test-sdt.bin                           \
          test-cxx.bin                           \
@@ -332,9 +331,6 @@ $(OUTPUT)test-bpf.bin:
 $(OUTPUT)test-libbpf.bin:
 	$(BUILD) -lbpf
 
-$(OUTPUT)test-libbpf-strings.bin:
-	$(BUILD)
-
 $(OUTPUT)test-sdt.bin:
 	$(BUILD)
 
diff --git a/tools/build/feature/test-libbpf-strings.c b/tools/build/feature/test-libbpf-strings.c
deleted file mode 100644
index 83e6c45f5c85..000000000000
--- a/tools/build/feature/test-libbpf-strings.c
+++ /dev/null
@@ -1,10 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <bpf/btf.h>
-
-int main(void)
-{
-	struct btf_dump_type_data_opts opts;
-
-	opts.emit_strings = 0;
-	return opts.emit_strings;
-}
-- 
2.51.0.618.g983fd99d29-goog


