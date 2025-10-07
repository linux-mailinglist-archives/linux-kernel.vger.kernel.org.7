Return-Path: <linux-kernel+bounces-844452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D635FBC1F35
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 17:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C66861893631
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 15:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4F32D29CE;
	Tue,  7 Oct 2025 15:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YsKbOCjP"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AD71F3BBB
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 15:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759851527; cv=none; b=kHtm1gOas4WkoFPN7BxuzXmwJ5NhU5it38fk0kPqRaP3xaVq0rrdPjvGD2MVtkPNYQ4vxvq4Rw/nkINoG5ZGjOgJZDU1Qvb4njLwP9el/kYgd+N3YYKQFeGBgKOpO+zqLPQZJlWvEIaQX/ZI2gBuJaQetQIacI091Vyzo3/Tf2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759851527; c=relaxed/simple;
	bh=n9zc1w1kc+MtlfYX6aY9R3/gS+Fpbxtfvrs5vlvfd2c=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=KFcVNMHbKpDPs5tX+xRZvnXIBbB1PCthTQmseExlg57l7ub7K42bAY6wgzXb8SKUoRWI3HqBBNc9ht2A6J9s4kJzK+nie1Acy07GRcL2BAAnn8bRtyjVJAnaSY3yGMKgHx2wbyw4bpSN5ZPeN6HXnvCeM8SswqepzuD6h1e+DpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YsKbOCjP; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b55443b4114so4343139a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 08:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759851524; x=1760456324; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fTztUGRGLRXSGwUvW/0++WhlrFfWUCK68FeZSvOHSCA=;
        b=YsKbOCjPcMHjjzV5Xqkas6WqwEiUpKyDBMzfZ7evfT73aSF0+ugFFCPHDNruWzswuC
         +nGMtnG1eHsUmdm/2p3bVscfwa23N1kVmfTDQ8thlqN4CSlJscc3+AbuGFRYt7pTuA9m
         4/w+UsLnUQ70iG8cVzoI0A2uTOpoivpbjNcKAUOcANRTu/i9CtFvltpSe4Yv4nF+ewgD
         FXhqFjWz0F5RVtq38ECeXNGqZnkUoQvHXzc3+MTVxnUyB+AfIK+E0IampkkiEgV7s/9Q
         nBrIuIpfmuj9KAjSHU796L2jPYYL1UlQX++CTzjZ0Pw0RZNkUseD1MstY1Iv7z6dc3x5
         Xrog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759851524; x=1760456324;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fTztUGRGLRXSGwUvW/0++WhlrFfWUCK68FeZSvOHSCA=;
        b=YC5zq26rFK/A7fCnimFdzuBsEb4PRV+/0J+LRHGYRwIFldeDte6hY9IiEvwB7vDWzm
         vuwm6ASzSPTkO3a1yxMUVfKKkzyYS4jp6UPO+ieXWIBGuU5o7WmgO75sIsgGCnIvhj1e
         ykoX8xa2ioE3V7WyCY4JVsNqSGl3DI/QQIPt5OyM5FaO84VQAUeW6TFGTzx9oP0vqQK0
         X0WL86gSnxpzctDW5V6E/w9vmSJRU2V+a+OhIwN8baHg9lAsXqCrBPFBJvfGokJfNCa4
         Wt7Zxon1gC0KcLKyIHWjIXUBY/4+gHH8a5slPof/hOlAKfghRFdtkXFRquBLDtozLjZ7
         ecXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrZYlrERgK1TVjMQorEACL99jDXbV3Cd4mDIx+IpF7LW9RwpmKdZR/gkr5t7LwpbOKv1JGjCOQxb40MzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdxUKAge7jO/n5qb39Xuj4/90TDHyi+Axm+0QQYnc9/tCased8
	e7lcTBo5J9nYs9w8FsKyB1tPUlvr9/7Tox9Ren0QXjUKme8u1zOCTNIQ85ibIyc0RsIuFS/9+Ww
	plYHEZJ1w9A==
X-Google-Smtp-Source: AGHT+IFb4J3Q5QVLqW4wuwDUxu5iviXENAhxA/eiZMq2fcGItwB2kmamIaNQlEnBytkBWVhE83h4sHsR4CeG
X-Received: from plau18.prod.google.com ([2002:a17:903:3052:b0:274:bc82:df8a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:910:b0:240:3b9e:dd65
 with SMTP id d9443c01a7336-290273eddc4mr2078165ad.38.1759851523912; Tue, 07
 Oct 2025 08:38:43 -0700 (PDT)
Date: Tue,  7 Oct 2025 08:38:35 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251007153835.3578633-1-irogers@google.com>
Subject: [PATCH v2] perf build python: Don't leave a.out file when building
 with clang
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Testing clang features doesn't specify a "-o" option so an a.out file
is created and left in the make directory (not the output). Fix this
by specifying a "-o" of "/dev/null". Reorganize the code a little to
help with readability.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Justin Stitt <justinstitt@google.com>
---
v2: Resolve merge conflict with:
c6a43bc3e8f6 perf python: split Clang options when invoking Popen
---
 tools/perf/util/setup.py | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
index 9cae2c472f4a..b65b1792ca05 100644
--- a/tools/perf/util/setup.py
+++ b/tools/perf/util/setup.py
@@ -23,10 +23,17 @@ assert srctree, "Environment variable srctree, for the Linux sources, not set"
 src_feature_tests  = f'{srctree}/tools/build/feature'
 
 def clang_has_option(option):
-    cmd = shlex.split(f"{cc} {cc_options} {option}")
-    cmd.append(path.join(src_feature_tests, "test-hello.c"))
+    error_substrings = (
+        b"unknown argument",
+        b"is not supported",
+        b"unknown warning option"
+    )
+    cmd = shlex.split(f"{cc} {cc_options} {option}") + [
+        "-o", "/dev/null",
+        path.join(src_feature_tests, "test-hello.c")
+    ]
     cc_output = Popen(cmd, stderr=PIPE).stderr.readlines()
-    return [o for o in cc_output if ((b"unknown argument" in o) or (b"is not supported" in o) or (b"unknown warning option" in o))] == [ ]
+    return not any(any(error in line for error in error_substrings) for line in cc_output)
 
 if cc_is_clang:
     from sysconfig import get_config_vars
-- 
2.51.0.618.g983fd99d29-goog


