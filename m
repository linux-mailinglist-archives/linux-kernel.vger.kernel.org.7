Return-Path: <linux-kernel+bounces-840920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 790B2BB5BB6
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 03:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB8AB4C0462
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 01:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24ADB278165;
	Fri,  3 Oct 2025 01:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tuM0tYZm"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0BF242D67
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 01:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759454646; cv=none; b=uD5xl4ZIdt3j/tvIu7FLVdXP6kHn3xSfxDIT5MFKKmHN67f0Q9oEpnVMRXwLRlgOgumOwrR/qxxvh/KgsWHuWLIdd6bvR4ktqY52gaghUBML/KHIyIYqe3rCrJ+xuV4HRqDBu0+X4K8lNV2zpTJNpGUjYDk+RzSDm08/PBUINFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759454646; c=relaxed/simple;
	bh=kUOXFIeRSqDtSv2ZkPiFOO36c2y12fUPmamNdNMIsfE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=LFuvjcLLzsi2usTReRyQD4XGJWSE4L9aw9OgOGSidPMjmRnDCMWjJ+kETR2IKTJ2gJqvNGWelvrhFCa5Gi5jjsvb94WsWqf87+8+XslVuXgONBmEpznG4IabD0NgGztRu9eUhevD+5sOm67mq04W2i9O2G6woaAnEf3ZzJgkfBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tuM0tYZm; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-27ee41e062cso19623175ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 18:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759454641; x=1760059441; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n/6Q8RQGaqyFoWu3nQe4KiS7k5Z8ub45H9dHX2o1RRQ=;
        b=tuM0tYZmktgmDOeoT2mc48nX05B2gl0YjKQ8Mg8m8oDe6TX+qI91n209THMEXjyAVz
         htubc1ZZPsYppl2A6veuJfJ1o7PyY1kFzAHZDdrL92BaS093t9y8CPdJaPkHmIS9azap
         msOVCboCtu+iCU7dedMyZ5D3ztWBjGi0yYVm/IKrN3a4GebohckR8B7mU/Gbfp5rNXoC
         OOe3K1ExEn0+cCXmTdeZI7jk68GVOlzY6uOwtldIGLY/b23UAv/fP4lVCqWBPPTmEgxF
         vLgVBPiZbPwLpGjPq4guQquzJR/XjiXNd6XAkFx1D+t33tiddZx/2oylswqqCdNh8Tcc
         rHiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759454641; x=1760059441;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n/6Q8RQGaqyFoWu3nQe4KiS7k5Z8ub45H9dHX2o1RRQ=;
        b=wSLpg2JA8mE4UZubMwSkwh2lrzJInAP3W9TO3aM84YpaRiCmZWFnOs79+d8k3MpyJr
         w55v1gpTSjm3opaFSqriwH9w7Au7ShOF2I5PRxBoYIhEPZw8E3eAXKR4lyGB8jIpvb7U
         uvl40ot52DSqA2iXL4BKhvMM4mA4W/8nbOZVciHWAl5yqJJ/8JbWjfXYi9Jg0ocFlN19
         4npNfIF6kEi7XT/CbQsMbk9Gj92kuJI4hcaQEY3NDK8XNVJEzObcSOr86RgSZb40e6W8
         jBz5BHa8gsv2LFKe/s+OSpWUmpKJdKoNNlrCbeploUA7hwxGLJ2CprNv32Y9q5XhAO7A
         JxSw==
X-Forwarded-Encrypted: i=1; AJvYcCX9G+4veSkLlzdyhDXRSLZg4v2yvC/uP1/So7OaQQKb3ygmj8ZCOY6wzrkB4hqv9/ka1ri97ChrQJ9def0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEVm5JEcj8S/a09WGXNXwojVyZ1qjFDTCyS7Xxu6uXK9+MBHNB
	tR/DaBJUcztuHwHcsZs0xl074UbIWN0Prp2lGQ2/0tI/bVEz/H/6GmskbNflpDzuR+JEcVJ9est
	OX7Ct8XaOfQ==
X-Google-Smtp-Source: AGHT+IFY9UEJwnhtwJqOYlJ+khMMlSHN/ze27dGvQJuRPcqqkdwyu6/B38lIGuCrw1Ue1guMSz5HzG4uq6lR
X-Received: from plev16.prod.google.com ([2002:a17:903:31d0:b0:267:e964:bc69])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2405:b0:264:a34c:c6d
 with SMTP id d9443c01a7336-28e9a6a90c6mr13499045ad.37.1759454640628; Thu, 02
 Oct 2025 18:24:00 -0700 (PDT)
Date: Thu,  2 Oct 2025 18:23:48 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251003012349.2396685-1-irogers@google.com>
Subject: [PATCH v1 1/2] perf bpf-event: Use libbpf version rather than feature check
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Blake Jones <blakejones@google.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The feature check guarded the -DHAVE_LIBBPF_STRINGS_SUPPORT is
unnecessary as it is sufficient and easier to use the
LIBBPF_CURRENT_VERSION_GEQ macro.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config  | 7 -------
 tools/perf/builtin-check.c  | 1 +
 tools/perf/util/bpf-event.c | 2 --
 tools/perf/util/bpf-utils.h | 5 +++++
 4 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 6cdb96576cb8..b0e15721c5a5 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -596,13 +596,6 @@ ifndef NO_LIBELF
 	  LIBBPF_INCLUDE = $(LIBBPF_DIR)/..
         endif
       endif
-
-      FEATURE_CHECK_CFLAGS-libbpf-strings="-I$(LIBBPF_INCLUDE)"
-      $(call feature_check,libbpf-strings)
-      ifeq ($(feature-libbpf-strings), 1)
-        $(call detected,CONFIG_LIBBPF_STRINGS)
-        CFLAGS += -DHAVE_LIBBPF_STRINGS_SUPPORT
-      endif
     endif
   endif # NO_LIBBPF
 endif # NO_LIBELF
diff --git a/tools/perf/builtin-check.c b/tools/perf/builtin-check.c
index 7fd054760e47..8c0668911fb1 100644
--- a/tools/perf/builtin-check.c
+++ b/tools/perf/builtin-check.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "builtin.h"
 #include "color.h"
+#include "util/bpf-utils.h"
 #include "util/debug.h"
 #include "util/header.h"
 #include <tools/config.h>
diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index 59f84aef91b4..2298cd396c42 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -288,9 +288,7 @@ static void format_btf_variable(struct btf *btf, char *buf, size_t buf_size,
 		.sz = sizeof(struct btf_dump_type_data_opts),
 		.skip_names = 1,
 		.compact = 1,
-#if LIBBPF_CURRENT_VERSION_GEQ(1, 7)
 		.emit_strings = 1,
-#endif
 	};
 	struct btf_dump *d;
 	size_t btf_size;
diff --git a/tools/perf/util/bpf-utils.h b/tools/perf/util/bpf-utils.h
index eafc43b8731f..a8bc1a232968 100644
--- a/tools/perf/util/bpf-utils.h
+++ b/tools/perf/util/bpf-utils.h
@@ -14,6 +14,11 @@
        (LIBBPF_MAJOR_VERSION > (major) ||                              \
         (LIBBPF_MAJOR_VERSION == (major) && LIBBPF_MINOR_VERSION >= (minor)))
 
+#if LIBBPF_CURRENT_VERSION_GEQ(1, 7)
+// libbpf 1.7+ support the btf_dump_type_data_opts.emit_strings option.
+#define HAVE_LIBBPF_STRINGS_SUPPORT 1
+#endif
+
 /*
  * Get bpf_prog_info in continuous memory
  *
-- 
2.51.0.618.g983fd99d29-goog


