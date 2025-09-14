Return-Path: <linux-kernel+bounces-815787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6DEB56B20
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 20:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C107D17B210
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 18:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE542E7BDB;
	Sun, 14 Sep 2025 18:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JCQhdvr5"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451D4635
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 18:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757873522; cv=none; b=R86EP8oe5+z6sxZmPwaH6Oj3GsU4jf1SLKhh2rTkBLSKowPzqnqOk02Au9qWwu2zsd1xeqwDaybjId7kEmj4Wf+Q+uM3cw/qjaLzbGmyEHxr8tbCOVnyS6ceAf/gkGRn/cikHFeZZHsu8lIGGKJgY2Ve4adOGm7GzRAmLG4uCBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757873522; c=relaxed/simple;
	bh=k9ZldP0/SVz9h/5AqDx45Gk8Qm/IOPK3wPViOLuKkOA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=BlLXUmaDUoSD1y1ww3jmFtxBSNR1NompQEyoHggv9oTMWK/cuTvq8J5sQuNQAWhgWwzceA3YjPb8DmNrGYeM9l57pRRl9KbS6PwQaJWlWxsqAJ+S2fJUuPfAlxNr7oqBgIY0fj8dYjzdErjOZPQMu1yWe/QyKzeHcQQMn5KSKSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JCQhdvr5; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-265c4769c9eso2482425ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 11:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757873518; x=1758478318; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rnAf+Rem08cXbs+wXch3cnb2eg6uZShB+fau+Osjdyg=;
        b=JCQhdvr5KxZ8IkS0bLA25oEC7GP+mjRMEiHYeH04GXFBh1+fiC870qh+vRIBjQ+s4h
         c04v59ZXUi0HR+CBRXRs3OJwxQOIoWxbcmdhl5v7R4CTHE1J5kRlQKY0OkEP2vRdWEO4
         vPo+HTibQ+VUq5siBanLMUdCDtSvFB/tXMi+lP0ZKCdYPBDzrHfwuWQbgzHtukTYeCBj
         7q3ephiTnwIaB1bHt/h+qjFbG7QDoat38gzoG9tWGeS6cyC9JZIQGurc0wb18y4sPgAx
         G2bw5cIQgCHedVCt2RVSD1ju1TjmsK5pyepcDIHKmK5shzaViEg0mFPVpRSYADf/IkYw
         4+Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757873518; x=1758478318;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rnAf+Rem08cXbs+wXch3cnb2eg6uZShB+fau+Osjdyg=;
        b=pdYiaK2eBdOAGcyAWvLhA+Wq9577/SrkUlpB0zo4X6xv8wM/6os9+R6yq2pPmtgCsg
         4hhKkYJYKIWuvNL40qXLQB+PIK2fF3D8U8YUOZasXve+y95E5afwYds4PU6YMvyK5VBS
         bz4E5uCzJzXtFCk3/3EJnqymz450zX+yyxWQftOtCQTZxYEOnwiiOTquUc5qWkenU8AD
         /VsK9KaMRhgY1roCAxZtNMEPgZ6MDOF/emF944GrjCS47wJ+UREU6/EdICGpGp9GZ7GZ
         +zas8zs9mfKtu5cGYwRfC2WH3wz5dNduAZQygyX0MHjQ3ww8/oyMjt0C14ZFjTptY1Jo
         F18Q==
X-Forwarded-Encrypted: i=1; AJvYcCWFIbiO8UbYJ8o8sV1szYlR5o0JcSdRpz0Vy2OEzZVxnSGjkXDsPZpiboYJ2kK+PCGTmlZIWG4l/k5EG20=@vger.kernel.org
X-Gm-Message-State: AOJu0YzapKa3BCqmacBvVJp6WabHiBu99XHfLeF/+1F3RZu4H5wPPfun
	wdxdizYFgjF176ZoRhpkyPKl7pSH7v/ipwT35raFLLgxXWz/jJ8+VKfGMcb1wiKmX8G/GIlyHuQ
	swZMQqJeq0w==
X-Google-Smtp-Source: AGHT+IGxhychhrWRfiCMHOdHSTzWtf1nrmSSoRnHNe7nXE0q5y82P53EwLDheSjVi9tvYLuwibnTik0KWayw
X-Received: from plbmn7.prod.google.com ([2002:a17:903:a47:b0:265:d4bc:38cb])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ce0d:b0:261:6d61:f28d
 with SMTP id d9443c01a7336-2616d61f5f4mr61952365ad.50.1757873518423; Sun, 14
 Sep 2025 11:11:58 -0700 (PDT)
Date: Sun, 14 Sep 2025 11:11:17 -0700
In-Reply-To: <20250914181121.1952748-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250914181121.1952748-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250914181121.1952748-18-irogers@google.com>
Subject: [PATCH v4 17/21] perf top: Use evlist__new_default when no events specified
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Content-Type: text/plain; charset="UTF-8"

Rather than distributing the code doing similar things to
evlist__new_default, use the one implementation so that paranoia and
wildcard scanning can be optimized.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-top.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 30a7b55335df..067af9b7be1a 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1698,11 +1698,13 @@ int cmd_top(int argc, const char **argv)
 		goto out_delete_evlist;
 
 	if (!top.evlist->core.nr_entries) {
-		bool can_profile_kernel = perf_event_paranoid_check(1);
-		int err = parse_event(top.evlist, can_profile_kernel ? "cycles:P" : "cycles:Pu");
+		struct evlist *def_evlist = evlist__new_default();
 
-		if (err)
+		if (!def_evlist)
 			goto out_delete_evlist;
+
+		evlist__splice_list_tail(top.evlist, &def_evlist->core.entries);
+		evlist__delete(def_evlist);
 	}
 
 	status = evswitch__init(&top.evswitch, top.evlist, stderr);
-- 
2.51.0.384.g4c02a37b29-goog


