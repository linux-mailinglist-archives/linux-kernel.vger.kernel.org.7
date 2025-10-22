Return-Path: <linux-kernel+bounces-864777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A17BFB869
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C4AF480D91
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D8C320CBC;
	Wed, 22 Oct 2025 11:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I9nZJOBQ"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E7D2EC0A9
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 11:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761130999; cv=none; b=XKG7w+CQ3Wlyzm8x2y2bGC94OlZzjO/h+/RKIQLOzfy9wN926gp28CK/aOXgQ01AoCvVUzFW9dmYe5ifeK9Kl6kCQBNSH/vlRMbiOSJp0/ZidygsqUTKZme0Oga3KD6jkdr1Z0PTcsz08unwCXkVmuvuoIcw4YlHobZ5t2e6fOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761130999; c=relaxed/simple;
	bh=4JavVz8FkRkGctrnUlx06KbkSyRHDh5aZttv1CaU6Kc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SbfXkutjRACYkwuDFXyp3vGYgedr9h/diNdhU0vpM5XYmUR6jvLJYKIAaJm/kkWYl+wAlezTWC8UkOe644h3FqW5LNgukxyfRt1DB7+KAgt4lvXmmUh/NTnmLh0Fg20ZxmVSneTZeF4RwhaWuQ9CN4PXWJ0jGD6T9CCR7c3wZBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I9nZJOBQ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-471131d6121so51153015e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 04:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761130996; x=1761735796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PPx6FKp7wmsKPVdZUwCuuivNwZpWI/suVikvoWWTCC4=;
        b=I9nZJOBQWHuvkALQw7x/4/IHwjikF1LT/jGknpEgoPj+79csdyT55R5BQP2d3IPHzz
         9tagl4z7/WibDdqDod6djpXW+xDUREmHIcWA8ZrV8HFR0Euy5JtCnwJOkdLQ1h8/kday
         en6+HK1Y2dm3JWuUkQiF66nceBES9jdZmpO4PYNuFstuBA2iv35GEzIsZ/lDS7hDEAt0
         fEBIdIP2s4sGLK3v+/PRtG9iZRQZTQ0yD+1+jW88SZw5fJuI3LILYHEppy6/r+EeEnzJ
         +SvkkENaz9OpQ8ZyUjFEjRBB+PvGkhff+e+JirCMM6ZXJ+E1zyyQbvYa+CWQhRZnNJWh
         nyHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761130996; x=1761735796;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PPx6FKp7wmsKPVdZUwCuuivNwZpWI/suVikvoWWTCC4=;
        b=E9l8Nkw8+hq5lXjHdR84hZndWYQ8Bk9tp76fR/yu2BxJhl0YI4xXfm+c8ijubXselH
         jOaxKP1kM5Gq+BDGfYBiSHI1vU0R3WFhWX3eBTRr08BChOoDn6WuhqKcZ9aWp/7aSyCa
         pMUA7JOy6hJOxrp9vFfsrEm6uYpo0asu4wx2ClXijoXwQ4zcfZRjPX2V92Q47wL6JyrA
         4Ya/yTz0zVs1mSHxax7yJeZPyQZiW16uXe/MNVjtBguATl/ivG1733viuBkh809wSKon
         Snp9tPQXwgeYNwC6Nj28yCeqotjVCAUnPmqPMYIYeRhZ6ZguAqrqsAy0TjlrjteM8hxo
         P/xQ==
X-Forwarded-Encrypted: i=1; AJvYcCWru7dn9LoDWTlGx/u/z+sciQktKMeM3Nhw82XM5wHbpDhUPr8iibxl6iZ+wZRNaLS1n296RLTfcf94Mt4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHIVJzwJ40qQWepl+a5PB5qm1fdzD014gHnjQN67/ZkcnrMoSJ
	kXHNp/G1WR+91cG0pav3aNj/PkrnHJv+lb8BnCFwNCGJ49wtFz1WRr+JIJ4eejQwfnY=
X-Gm-Gg: ASbGnctnMjMCOvdrk97o/vAwgl9y/14A9oqIWUpboqKbH9DdYvIIpIuYG3tG4S8heY5
	iV+70bWUJU0OWyxEPL53SQMtRtvWS1FDmI0e9dPhoRbkQZ/Xu0WyPmviPVF7ExZgGiZ6dDAIYYV
	4+RKWwNrt5/Uju3816cl39mxcb1yURcoE8WwLqaBr9cWFy00eXJ6ShnTj8xBEQyOQHH6tLvE5Y6
	6frZacJaLK5uVlU+PuKvIVqZaDJF+AOPU3FSoA4NuaqcM16UHY30ZAKwoobX01GNSysc5XQ/FUn
	RvaYmQueu9HRQ3lPTH5UwpQd/1h5ZQoUzsCmVu0sLeXFXifsWB/MJjJ57Rrj8xf3jgNknnaIrHS
	LTjiaUV9r/ytjwrts+gcsg8QZDH9l3lDnU0jFpuMdIhZz/XbEk4UvstuQK/E2kYwUHVeNUdSeDe
	Je6fOj+EDroJLEFv9pD3VU6UAD9jakoIDhiP3Wbg==
X-Google-Smtp-Source: AGHT+IF8LilulXH5At0tgqLHRXCGDcvcWLjbyZ+//qsb5pM2DM6kkE8yghXjTsH7iBfpaK0P/8VeBQ==
X-Received: by 2002:a05:600c:870b:b0:46f:b42e:e366 with SMTP id 5b1f17b1804b1-4711791fa34mr146867135e9.40.1761130995897;
        Wed, 22 Oct 2025 04:03:15 -0700 (PDT)
Received: from localhost.localdomain ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c4369b33sm37756895e9.14.2025.10.22.04.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 04:03:15 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: linux-perf-users@vger.kernel.org,
	namhyung@kernel.org,
	acme@kernel.org
Cc: irogers@google.com,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Tianyou Li <tianyou.li@intel.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Zhiguo Zhou <zhiguo.zhou@intel.com>,
	Wangyang Guo <wangyang.guo@intel.com>,
	Pan Deng <pan.deng@intel.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] perf annotate: Fix Clang build by adding block in switch case
Date: Wed, 22 Oct 2025 12:02:40 +0100
Message-Id: <20251022110241.1283519-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clang and GCC disagree with what constitutes a "declaration after
statement". GCC allows declarations in switch cases without an extra
block, as long as it's immediately after the label. Clang does not.
Unfortunately this is the case even in the latest versions of both
compilers. The only option that makes them behave in the same way is
-Wpedantic, which can't be enabled in Perf because of the number of
warnings it generates.

Add a block to fix the Clang build, which is the only thing we can do.

Fixes the build error:

  ui/browsers/annotate.c:999:4: error: expected expression
  struct annotation_line *al = NULL;

  ui/browsers/annotate.c:1008:4: error: use of undeclared identifier 'al'
  al = annotated_source__get_line(notes->src, offset);

  ui/browsers/annotate.c:1009:24: error: use of undeclared identifier 'al'
  browser->curr_hot = al ? &al->rb_node : NULL;

  ui/browsers/annotate.c:1009:30: error: use of undeclared identifier 'al'
  browser->curr_hot = al ? &al->rb_node : NULL;

  ui/browsers/annotate.c:1000:8: error: mixing declarations and code is incompatible with standards before C99 [-Werror,-Wdeclaration-after-statement]
  s64 offset = annotate_browser__curr_hot_offset(browser);

Fixes: ad83f3b7155d ("perf c2c annotate: Start from the contention line")
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/ui/browsers/annotate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 3a81912279ad..36aca8d6d003 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -995,7 +995,7 @@ static int annotate_browser__run(struct annotate_browser *browser,
 		case 'H':
 			nd = browser->curr_hot;
 			break;
-		case 's':
+		case 's': {
 			struct annotation_line *al = NULL;
 			s64 offset = annotate_browser__curr_hot_offset(browser);
 
@@ -1012,6 +1012,7 @@ static int annotate_browser__run(struct annotate_browser *browser,
 			annotate__scnprintf_title(hists, title, sizeof(title));
 			annotate_browser__show(browser, title, help);
 			continue;
+		}
 		case 'o':
 			annotate_opts.use_offset = !annotate_opts.use_offset;
 			annotation__update_column_widths(notes);
-- 
2.34.1


