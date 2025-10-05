Return-Path: <linux-kernel+bounces-842460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5290FBBCC46
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 23:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2747718914A2
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 21:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988972BDC19;
	Sun,  5 Oct 2025 21:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S8HAgs+t"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E6D2BD5AF
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 21:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759699344; cv=none; b=Oj6WEeCOfGzjMRE+I5Jkkp7rNM0JFWcg1HKzdrnvMkq+57dPlebGA+gdlXECIaNazASrJO3E+fpQbSEYCQVN5R/++wSS7TcT4dGNZ3rk31bID08+utycyXdhUI4VpSvchlmE/ZmcjuNzHUMgaKtzbat2bRG9n1qxcX8jLB5vi4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759699344; c=relaxed/simple;
	bh=/luZGaDcmbSsI2ELFDFE/EBkhdco1hXagnVGpUVsYwI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=AbgTi1eWY00dodRMtw7kNE9ot0/8m6cJGwYYf5U++5s6X5sz717+IvA30tSeKrNek7sXFzk8WpAXLHQPPDeUZXNinuPQ3GEoy8zDMmZC7czswyRtF2fdD6/02U9/nfUXyb+f5wnOyXGKNAP21jddmFN6+8zljqo4xg/lpCg+sN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S8HAgs+t; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b5529da7771so2625799a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 14:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759699343; x=1760304143; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hHVoU7VdAErJHQsuyUDkFaSuPa656SpDfPesPL1Iw7A=;
        b=S8HAgs+tuIFcFHWZluFX1V2ArU5mhlRIUv7OnmeUWYsOvITyfFwugvZpXHWvf4qAVY
         i/GsatlzOcMDl+pWFfQUzAVbRXzGTBwfkyoYSedRp13mMyaa+rKDuYNKYuY+XVyXudC7
         33tk1S/Ald9PhmhKyv3aKvtJ0he0kxgFmrjfZYgdhL8nv9vSKnK4q4EP7Ye3yLZ6Dg09
         aMz8KDB0nneJ0EfmYx/FXLeJ8k+aMGtVyH0NkSAnFNJ+tsnNw7jg9rL3eI7LELfQc4nm
         Qvqsb/VuJGQ/mXKCkwIFRLYOumNzpwYCkrGmk6fRXx6WaERvkmL302pR4f/PoyBKIACt
         0oxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759699343; x=1760304143;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hHVoU7VdAErJHQsuyUDkFaSuPa656SpDfPesPL1Iw7A=;
        b=hQA2xXADwgPtiIVbGzCum9SRbSFiNerNGoLAyQ1tPw4ybw4tf8fDe8jLC1nP28cKqC
         ZM/GJ8+DzYcAn72p0HQl4CSuakp8cp/bp2Lv9Orl8L4MWHeWCogxzzSjHKqzKcVYby+8
         oq6jqQSXbXPIG/m3hSUWHR1rxpLDsi89FhboF+vsQpP3t1ovyqOuZARB9rCv6KG2wjY5
         OT4UQc2a6ma5yI09jIsdO+XJT9NjJxyKjQAPHQdSmcwVFjTC7gVkOkHtBNyXyfpCAR9Z
         P5S6cUMqNlRf93IYvJUNhmjLUVii0r5vVWCIeT4/dOaNO1PmxL+OTcQMbDRGUugkWZNd
         8Syg==
X-Forwarded-Encrypted: i=1; AJvYcCU+xyMX6MAF08kRLjvU1/EmcHxBUF9v7Lh7Q/+IZRRxrHC/WgZ1ii0uhkxyGUVclGU5tnAG7N2Ng4paXzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDup3CYpkdK7teaFaCBU3G6KLiuFT2YbPA40NRe1xBHidKlN63
	zaBmh+5SlimigjsfptePKZjs2lKP1ds6B6zKs5pbqcH3lwuRk1Az8odGAo3QKvkyO+7Ci+CNUBA
	A09XItzKT2A==
X-Google-Smtp-Source: AGHT+IF9xACFD4NCBC8YA4+1DxHgAs4tVBez0mS1xBu199M+awLsaSCkEQ1/ioP2OUdMojXU72RjQE/JWxIn
X-Received: from pjbpf16.prod.google.com ([2002:a17:90b:1d90:b0:330:6c04:207])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:e211:b0:240:1a3a:d7bc
 with SMTP id adf61e73a8af0-32b61dff87emr14700817637.3.1759699342575; Sun, 05
 Oct 2025 14:22:22 -0700 (PDT)
Date: Sun,  5 Oct 2025 14:22:02 -0700
In-Reply-To: <20251005212212.2892175-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251005212212.2892175-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251005212212.2892175-2-irogers@google.com>
Subject: [PATCH v7 01/11] perf check: Add libLLVM feature
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

Advertise when perf is built with the HAVE_LIBLLVM_SUPPORT option.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-check.txt | 1 +
 tools/perf/builtin-check.c              | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/perf/Documentation/perf-check.txt b/tools/perf/Documentation/perf-check.txt
index ee92042082f7..4c9ccda6ce91 100644
--- a/tools/perf/Documentation/perf-check.txt
+++ b/tools/perf/Documentation/perf-check.txt
@@ -56,6 +56,7 @@ feature::
                 libcapstone             /  HAVE_LIBCAPSTONE_SUPPORT
                 libdw-dwarf-unwind      /  HAVE_LIBDW_SUPPORT
                 libelf                  /  HAVE_LIBELF_SUPPORT
+                libLLVM                 /  HAVE_LIBLLVM_SUPPORT
                 libnuma                 /  HAVE_LIBNUMA_SUPPORT
                 libopencsd              /  HAVE_CSTRACE_SUPPORT
                 libperl                 /  HAVE_LIBPERL_SUPPORT
diff --git a/tools/perf/builtin-check.c b/tools/perf/builtin-check.c
index 8c0668911fb1..9ce2e71999df 100644
--- a/tools/perf/builtin-check.c
+++ b/tools/perf/builtin-check.c
@@ -48,6 +48,7 @@ struct feature_status supported_features[] = {
 	FEATURE_STATUS("libcapstone", HAVE_LIBCAPSTONE_SUPPORT),
 	FEATURE_STATUS("libdw-dwarf-unwind", HAVE_LIBDW_SUPPORT),
 	FEATURE_STATUS("libelf", HAVE_LIBELF_SUPPORT),
+	FEATURE_STATUS("libLLVM", HAVE_LIBLLVM_SUPPORT),
 	FEATURE_STATUS("libnuma", HAVE_LIBNUMA_SUPPORT),
 	FEATURE_STATUS("libopencsd", HAVE_CSTRACE_SUPPORT),
 	FEATURE_STATUS_TIP("libperl", HAVE_LIBPERL_SUPPORT, "Deprecated, use LIBPERL=1 and install perl-ExtUtils-Embed/libperl-dev to build with it"),
-- 
2.51.0.618.g983fd99d29-goog


