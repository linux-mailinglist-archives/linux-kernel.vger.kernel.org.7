Return-Path: <linux-kernel+bounces-841607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 11760BB7CFB
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 19:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AAE5B4E7B3C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 17:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959612DCC13;
	Fri,  3 Oct 2025 17:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s0IMBpAK"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA672DA76B
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 17:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759514181; cv=none; b=cJHnG9kuW63cg8D8bvWPw6NkHKT2lKsxzlolv8y6disPDiw9dD7cDmjNt3e8UMjorcgxwyN8I8trNwoMH2x4BzgUaw/72eqk8aaA38gtABfYWLTR1ZjUEKMLoeGoxkjFxu5UKIYrHSZ5BYmTzmZ7OUpFr4M+u0IZrgO8u2adQk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759514181; c=relaxed/simple;
	bh=OpUdHXUA0W+Q6HfIdjC5/Eo2qQS6nQyXRDaLDwwWGXE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=mY70Mpb0vNkPkYMEgBvUzKcc4yx4elIS3z1I5c1Bij506kzB/k3yjblGNs9y1sIETcTf2tpVzqBCVIIw5koi2X1Fue/ytCa1bEKsT7bS8Qj4yWTiC++BMyqAexKhRAJblMIe5hu1VV0X9R4r4i5gz/WOVRaUJXobl8tsxBBhIw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s0IMBpAK; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-28e8d1d9b13so28146515ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 10:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759514179; x=1760118979; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CCzKIcxSwtwSrniu1/P7nPNHr6oMGAp8BGuB6qmiLI4=;
        b=s0IMBpAKz/JVPm1vKae+sOXUR0QBPH9XFsxcSLKJ3ujbJi45AJs84rV8LHNE9YrIO/
         xPM0zCwgqkPty/8XYPgJwy5OK4KWI65Ii4rcrZquLT3PiTQIuNkCY+SRjVoA3koyl4sR
         Pk8hH1EsycPXWwZajy6QMI/HOmpiANd37h77dQvK5+0OtfaKHZargv3Yt3CvrpKH0BZw
         32xYH6x3sqGcSP7Mw3/wIaRD4xMxeKX/pyusTGn9UltXdR8o5TPJKuWSSHw0hw+1XWOJ
         MVGdWWgVGVgrycy1kNNeHPB5OMhUHox0Pcm96nUQtOzlaCy9U9ybZoy1BAG3z35kdn/c
         OOKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759514179; x=1760118979;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CCzKIcxSwtwSrniu1/P7nPNHr6oMGAp8BGuB6qmiLI4=;
        b=uGd+EHpYm32g/F2of28rtSDXonHwq92KpwchC8Gl3I8ncVZ/oFXkO78JVz5oOF8s2s
         o8A8R7oDOr0HH8ag0WqPygIPr400S4gY/CYn5du3Z9MndHWQd8vYeO/IZT74HwKQ7jDA
         2zA64U05e6RnK3XIqHBCXf+sMPZuzjPFA4FbO+roJUM90GOBDiQ5kaJoYD714jvXEm9u
         2lFTniaVS8c9BK/1Rx+J7+KNmhFOvu8typbVEsn2/Wp0Mez5Ihnvt6RuWhlclQ3TE0Nl
         sYD2pSKz9DbdxGuEOI3Op9qtfadtpozML+cD/pUfYLCaAW7TccR+OIekIwyVXcjo5aQq
         DIYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWN+aCSsQXoGJ8DFg/ZelI4MOTo+jPOnmvk/jQ/vYvTz3k5M4pjyJUiGnX2x24IlQJLQRX9SrH3+lJ2TR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCUUFdeDnBTka8e1vozQOOfww4XWMU7setTlGbLOmyLTWz9up7
	ZmbJyhgGXF8pc84jPRrJEhYxPnAy12wfITcRXesWNnl+ZqyVvdPfzULhzD3xqdGGeJbgS/tAVvK
	4ZmrBT+FMDg==
X-Google-Smtp-Source: AGHT+IHKDcdAUZyq92R8ZR4IijMnwzdyQA5mSI8EW4fYoNjLYVkiyYERcuKa/NQHiAhzl51yVbn5SUEahEmU
X-Received: from plsm6.prod.google.com ([2002:a17:902:bb86:b0:267:dbc3:f98d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2c7:b0:269:96ee:17d3
 with SMTP id d9443c01a7336-28e9a6fd7c4mr42004505ad.51.1759514178808; Fri, 03
 Oct 2025 10:56:18 -0700 (PDT)
Date: Fri,  3 Oct 2025 10:56:13 -0700
In-Reply-To: <20251003175613.2512296-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251003175613.2512296-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251003175613.2512296-2-irogers@google.com>
Subject: [PATCH v2 2/2] tools build: Remove get_current_dir_name
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


