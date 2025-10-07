Return-Path: <linux-kernel+bounces-844524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DE974BC2210
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 18:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9896D4F623E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 16:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810512E7BCF;
	Tue,  7 Oct 2025 16:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="McDnTTra"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132F42D9EE6
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 16:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759855127; cv=none; b=En/MGq5cBkMYVJVQlK+SWiTLnltF6cBuwObSKoEB8YVRkAA4z1p9JZvcuv1sO2ZdpaQWSTaJq9sDBUhpQe10iiV5LektRAmuVVhiRhF8eIQvSFXr5wRGCfupD82PuImu1PxVkL+QDX18T2cpvEoyZtj7FYDujGJLJVHnfYZOITk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759855127; c=relaxed/simple;
	bh=Iz+x78HLYSZaQpNLm3kCHEGGKMwxMagiRtN4S/z3TNU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=R8wraw8i9HWg4gD11dtZDrtDUC9O45vNHdcusAJu7Ff8KOsa1n32fAOy9ern/ABTvYZRD4104dmXnKznVuOQGGlj2BDZUzc4AHPvPjIYpDw2RDEJXPw8ewDDtfNuLrFljFSM/0ubwyfsGYI5329hgz8Dj5rET2H7MLIycU6eNKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=McDnTTra; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-272ed8c106eso40408585ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 09:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759855125; x=1760459925; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=A0ywbA7sIthMk8Bw7nASVIQCHDtkv+Fy+F9l75lqBYY=;
        b=McDnTTravPZQJwC6necJYrot5yojig63pJPTtfXjkwuEGQPhsc3nPXo/00zjMQmYoE
         BeXEPxBH4Ol3nmZ8WbTGH+osvr13cM6KMZOUeeaXPg6YfvXFETSgBdV5WA+UZCB0Unkk
         3L6e19IIvs/sNEeGaQexdHE819kX+FIQfxpsLqX/dHEQvfcpr4m6KFy64vPjbEIY9l+Z
         FiW6fh19D2cognLG/fCw17ZWjkpCn3B/oWMEerqnWNMO5pVcz3L5viPzBJyYxM/BmqCA
         KxSGPXAStCMHkhp/YKOVnerHKs1qkqx5O7/y7Hr+B838/aeRm2fki80c2AzCKiPhu2j0
         8Ung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759855125; x=1760459925;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A0ywbA7sIthMk8Bw7nASVIQCHDtkv+Fy+F9l75lqBYY=;
        b=TQPCqggLWsyqTIIvpvs6O0pqi/0kTVAJ9OwrAEFQ6xR1alJrbio40EfKW6Sp97zvnF
         gOAxTp8FfW1/3Wu7i/Fg3kx3pL75PBefhu9BHeLSvHOJ6ECRy6ijYnrzn2QSl1tv46ah
         Ac9Ft3jqFdTPLBMWqmobnyjEWcmuIRDArUZtHu9aRXrhv3KNtzQi42oSo9LYp6SHTfOB
         BN/D7xkRdhShWavH6t2t4x4CLFk0P3ba5iLrv3TkxH3/Jn2DslY6IeUxWTsKl3ysYCN9
         /N1yI57xPUUWp0aDO/VcEEDeX0x8+WD7so9DWLmdt5B1URFUUAdEhTgT/Rj2Y9L7fKOo
         InxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSSxX8Ma4RbGx25UUuKSRm90+zy6371X8tjQ6KUT81SszDFg2gMeSn7I2nmZuiIdNDYr+T7y+cE9oOZLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNa2aY0KOQoY4nnpQQ79MseqO7FEot7vRD9otDbLnsC5k9jk2F
	0w7zDKYL5AqVCxd7mkZNR/ySN/l3aTVFuNnduDdowLUpxkI5usPsviaO3wLFN/QaJYnlW+MJ4DK
	CXf2cdVD/jQ==
X-Google-Smtp-Source: AGHT+IF5Gg026PMBc+wmeeoFlHQXhDUm7S6G6MprWABukRZeRHmcK3qyq3gJFr7xHIHnJj5SArS8h4iGYEyu
X-Received: from plrt19.prod.google.com ([2002:a17:902:b213:b0:267:d801:ca2f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:8cc:b0:24c:9a51:9a33
 with SMTP id d9443c01a7336-2902723c258mr3999935ad.22.1759855125193; Tue, 07
 Oct 2025 09:38:45 -0700 (PDT)
Date: Tue,  7 Oct 2025 09:38:32 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251007163835.3152881-1-irogers@google.com>
Subject: [PATCH v8 0/3] Capstone/llvm dlopen support
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	James Clark <james.clark@linaro.org>, Collin Funk <collin.funk1@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Linking against libcapstone and libLLVM can be a significant increase
in dependencies and file size if building statically. The dependencies
are also quite cumbersome if bringing perf into a distribution. For
something like `perf record` the disassembler and addr2line
functionality of libcapstone and libLLVM won't be used. These patches
support dynamically loading these libraries using dlopen and then
calling the appropriate functions found using dlsym. Using dlopen
allows libcapstone and libLLVM to be installed separately to perf and
when that's done the performance will improve as separate commands for
objdump and addr2line won't be invoked.

The patch series adds perf_ variants of the capstone/llvm functions
that will either directly call the function or (NO_CAPSTONE=1 and
NO_LIBLLVM=1 cases) use dlopen/dlsym to discover and then call the
function. To support the function signatures when
HAVE_LIBCAPSTONE_SUPPORT and HAVE_LIBLLVM_SUPPORT aren't defined
prototypes generated using pahole are given. This avoids requiring
libcapstone or libLLVM for the sake of the header files. It also
avoids having a build where neither dlopen or dynamic linking against
libcapstone or libLLVM is supported. There are other possibilities in
how to organize this, but the chosen approach was done so for the
simplicity and cleanliness of the code.

The addr2line LLVM functionality is written in C++. To avoid linking
against libLLVM for this, a new LIBLLVM_DYNAMIC option is added where
the C++ code with the libLLVM dependency will be built into a
libperf-llvm.so and that dlsym-ed and called against. Ideally LLVM
would extend their C API to avoid this.

v8: Rebase down to 3 patches. Update commit and cover messages.
v7: Refactor now the first 5 patches, that largely moved code around,
    have landed. Move the dlopen code to the end of the series so that
    the first 8 patches can be picked improving capstone/LLVM support
    without adding the dlopen code. Rename the cover letter and
    disassembler cleanup patches.
v6: Refactor the libbfd along with capstone and LLVM, previous patch
    series had tried to avoid this by just removing the deprecated
    BUILD_NONDISTRO code. Remove the libtracefs removal into its own
    patch.
v5: Rebase and comment typo fix.
v4: Rebase and addition of a patch removing an unused struct variable.
v3: Add srcline addr2line fallback trying LLVM first then forking a
    process. This came up in conversation with Steinar Gunderson
    <sesse@google.com>.
    Tweak the cover letter message to try to address Andi Kleen's
    <ak@linux.intel.com> feedback that the series doesn't really
    achieve anything.
v2: Add mangling of the function names in libperf-llvm.so to avoid
    potential infinite recursion. Add BPF JIT disassembly support to
    LLVM and capstone. Add/rebase the BUILD_NONDISTRO cleanup onto the
    series from:
    https://lore.kernel.org/lkml/20250111202851.1075338-1-irogers@google.com/
    Some other minor additional clean up.

Ian Rogers (3):
  perf capstone: Support for dlopen-ing libcapstone.so
  perf llvm: Support for dlopen-ing libLLVM.so
  perf llvm: Mangle libperf-llvm.so function names

 tools/perf/Makefile.config         |  13 ++
 tools/perf/Makefile.perf           |  24 ++-
 tools/perf/tests/make              |   2 +
 tools/perf/util/Build              |   2 +-
 tools/perf/util/capstone.c         | 285 +++++++++++++++++++++++++----
 tools/perf/util/llvm-c-helpers.cpp | 120 +++++++++++-
 tools/perf/util/llvm-c-helpers.h   |  24 ++-
 tools/perf/util/llvm.c             | 273 ++++++++++++++++++++++++---
 8 files changed, 660 insertions(+), 83 deletions(-)

-- 
2.51.0.618.g983fd99d29-goog


