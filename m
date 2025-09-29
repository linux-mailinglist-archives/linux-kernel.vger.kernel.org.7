Return-Path: <linux-kernel+bounces-836727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1886BAA6EC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 21:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A03F97A118C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 19:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA6D2BE024;
	Mon, 29 Sep 2025 19:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L9yQeoMo"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFE42BCF45
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 19:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759172966; cv=none; b=kDpvwJjTmaJ/FTAUoozY6n5bbhTAJne348BzL+dyHlNT/uDmjaMkbbpZmeUePLWWWOWOJy0pqhPF62ZcP3kd6jfadxh+1KBzD8/4+ODXJNTRbAh8xVY1VkTFnD9IL2ElXL32a5iQTwO4n3SAGcfHIgvlOMadcsBSEMO52YZwq0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759172966; c=relaxed/simple;
	bh=AdUfJ3+HbRhbK7PtlXvfEfALYxdhT7u77r7aSN4uwZk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=J13YBJZriCfO96nhCUCDB084qud11lmmNyl+JU6ymlFfEgnYATHjZNsiSE0JLd3QUfKTDJKR+qy8OCy6Onag3TZc+6Bixv1y42LUbukKW45euoglXSqi2ZOwne6MFvMEYCoeJt+APdECfN+WPW1wGR+4NAyNj2a8Oaoc5fBFx/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L9yQeoMo; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-28d1747f23bso6456075ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 12:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759172964; x=1759777764; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4971M/0zABDO+i83fcQEQWVemuah1MT0Et0WsfrEZzk=;
        b=L9yQeoMoPkXg5d5lT2D7Ra4n++RDy2SE9MSuD1eTVbKyNZt8WSLkEloIFCzXNqO3cf
         wgo7N6WOlI3EbhXo5y3QghXVKhaL+Zvz8smMzTX6PYl9BbIVf1GEj4T9C4wjsBNEy4Q1
         KlOwLH5/fBorFi9cSI8qqlETXPIa4jpkZ8BNK0uEtWK6NZAVH6EQ+bKbkY9YGqEsyc6E
         BLs/sdBbGMY+DbRGhMRogroFvjoCF9NtRqAFJi8SLM2GPrX1fIc/hJ4vsLdpOiDW5Wft
         CCZEQXne39KFIdsPDNuxX8Nvhvcr9ivaFvj2gSVR3Mwpc54sE3l3Kzq5pqKdVIvy3Gzj
         r7NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759172964; x=1759777764;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4971M/0zABDO+i83fcQEQWVemuah1MT0Et0WsfrEZzk=;
        b=odKJYnKt5ImKVDrK5J/bVDD2WE6hYftGi1POM7+BTGSokw0fGDG3Wlr+vTUPrICS8r
         pHe5CDSIEHPC8319zDPinAy7IpNErsr0Jc0qbDQZQCnFrBpH74Bip0/NX3G2m8JTxlhw
         6ChYkXDLc0KROlalEmY7MebESlu+OxyKqfk+7C+/ldSytqSf74FJAx5soNZX43JL6n2+
         ETwp7SUClIV3YOdFUBP11TTXh0FxbOYVjNInSCyVa0fxyrARfAmyLlUjmtrDT4i3Ne7l
         fxeQwDBJUTc9eoxNQvavVGkpzM5KiLofz+1v3F8R7nGEH9FjQZ+knb9QP2cRo9JsA2m9
         Klrw==
X-Forwarded-Encrypted: i=1; AJvYcCWgdtM3Wcc24C3g1dvO65QOBSp0dntgNQ+mSv516e3KGPYmSLHRUk/zct2z42To4cr9TiQHHbwHW29XUug=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoXylZJkQ5Vz3NjGQtppXVy+d+UzlhocGNfSFrQELaRDar5+by
	96i6Vz7SgUnv90QjA0HtHHGGpw/Su5ggbOLbpnsLVnt71jvGF6H0jAu9oBygSapgDicxi9inWZh
	wDGjmvfY9CQ==
X-Google-Smtp-Source: AGHT+IGSCDVx0cLNNfPAO34F5NCMZLpRD91/a9vLPfmnYqOXMggPFusn25YIXzpM5IEFpb7ikaAU0IUITXOR
X-Received: from pgar25.prod.google.com ([2002:a05:6a02:2e99:b0:b58:4e62:6f3d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:acf:b0:274:5030:2906
 with SMTP id d9443c01a7336-27ed4ab8df8mr196816435ad.46.1759172963586; Mon, 29
 Sep 2025 12:09:23 -0700 (PDT)
Date: Mon, 29 Sep 2025 12:08:05 -0700
In-Reply-To: <20250929190805.201446-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250929190805.201446-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.570.gb178f27e6d-goog
Message-ID: <20250929190805.201446-16-irogers@google.com>
Subject: [PATCH v6 15/15] perf disasm: Remove unused evsel from annotate_args
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
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

Set in symbol__annotate but never used.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/annotate.c | 1 -
 tools/perf/util/disasm.h   | 1 -
 2 files changed, 2 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index c9b220d9f924..a2e34f149a07 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1015,7 +1015,6 @@ int symbol__annotate(struct map_symbol *ms, struct evsel *evsel,
 	struct symbol *sym = ms->sym;
 	struct annotation *notes = symbol__annotation(sym);
 	struct annotate_args args = {
-		.evsel		= evsel,
 		.options	= &annotate_opts,
 	};
 	struct arch *arch = NULL;
diff --git a/tools/perf/util/disasm.h b/tools/perf/util/disasm.h
index 09c86f540f7f..d2cb555e4a3b 100644
--- a/tools/perf/util/disasm.h
+++ b/tools/perf/util/disasm.h
@@ -98,7 +98,6 @@ struct ins_ops {
 struct annotate_args {
 	struct arch		  *arch;
 	struct map_symbol	  ms;
-	struct evsel		  *evsel;
 	struct annotation_options *options;
 	s64			  offset;
 	char			  *line;
-- 
2.51.0.570.gb178f27e6d-goog


