Return-Path: <linux-kernel+bounces-829742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BD7B97BAA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 00:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E519D4C5598
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 22:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F253115BE;
	Tue, 23 Sep 2025 22:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AkqB01j0"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241CC31A548
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 22:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758666837; cv=none; b=Nh/0fNgAWdlV9ZOH054Zly61f8jZ8FWUbh/5m+DNPoduXu5dprJUhewFB9wzvxlVtqXc4tWOewwMQrsV1v9YpvPvkdK9uFuAAd5WWm9E9JhN5FfSMvt3Awc7aA4gsfhPvJiu7gvXq56r5ppYoyxVKcEcEsPs6Fr7CNgyf3uQXDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758666837; c=relaxed/simple;
	bh=9O0SNp6qNzDy9oFmBjqIkwm4W7+WsJXlTJVpqO78PTM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=J3vsxAJM02AegdBZQhgCLUh3d5VryYv7okRyK9TsMctDjSOLM3LwxqdbYUotweyx6+0Uy4RuBiBu7PepKkvrIMJupQZaTkYX/CFhwtLkl1TBkH5FVtrcBzOo08qSVExpKh7DeBGG9JqTgBTaVldGTpFUhfhRNExY5GQx9BlW3qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AkqB01j0; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b554fdd710bso1659869a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 15:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758666835; x=1759271635; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I0JHoX72jOJKlox/FmxfaLo+8gSeVEW25ROCTEI3UNc=;
        b=AkqB01j0nG85EdHMM2VicaSpqMv570EVKtUePvhBbbPistVY9w8y2W0INLtNiik71r
         sgVyWQgvdZn/zQIcd8SbmEONuNtyn5GbjKkUuqelUNrA7kDlQW+avHGm+f56+o3Hrz3C
         KN02iJSuCGgA2P60g28KBUaqUmqYDI8yk98HbCwem2tzPudowU1+61nUh2CS/r53WPKj
         rsaPb+cJnX/UgHPuxn1pMba0i1sNwQhVcGR8rLkgdihvfPPKouUSuxph1jw5gdlcU9Ib
         vSIU3xy6SkIdMUWIkxMEvF9Pse9WvpPpUsrQP71Qk7RJQeyWOlH58p+fmNrVlosmmyKA
         XlYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758666835; x=1759271635;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I0JHoX72jOJKlox/FmxfaLo+8gSeVEW25ROCTEI3UNc=;
        b=ma8l4eCvglM210Bkl/pVKSeOMEGTlUe/taSircslCqVmmrbEB6MzNmgCwqWJo+yz+l
         Ib7ejkfCOWqzFK7W4+0SU5sHZWdASsFq4ZtdcciZ0ai/gz6vdUkeFBkm44zmyRhEuRpH
         Nyf9rX75m8wXhd8scNVuTppSMSgCcoaSV2AJZ+53Qi/fE6ROlEQrTINd99P62FKx1W4Q
         9/dZjAwIQKBkv/9F98/Ta0tCfAbDAYYFpfL39dA1T2+BZjrVW7SnKB9DHOTQysHfKtPb
         IublBY7evDx0F1BgWHMjNAB4+gaqn3MUxKexRWn2H6xzUAQtAARq4FcC9qjKRY8Qi9i0
         2SIw==
X-Forwarded-Encrypted: i=1; AJvYcCW3/kOkKyoJ6TN1L1/M9hGSrP/i6IiMdVSP3oRVm0i1YVkq5xs5DVCE91oOJOBU+7fKh5h4QxMF57QRdY0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0y3T8GdPU57DSx/m//0JsV2ROZiM9vs+sW+Bf/J1pqW2zwTR8
	etqP/BUSa8aIttlqLgt3he1aEH5BtytdFBgptf/k/DJ1+a3SFDnFU7BcuzE9skkEExGiUt7bA/u
	8X/SSIXD6lQ==
X-Google-Smtp-Source: AGHT+IHeQypyUqFsEbVICSrUYORKs3zwl6NWeWm2GkcngOh5TzAu6PZZ0+z1ndYzdyFum5JrUltuzhGtqt/M
X-Received: from pgar28.prod.google.com ([2002:a05:6a02:2e9c:b0:b55:509:7882])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d07:b0:2cc:692a:3a32
 with SMTP id adf61e73a8af0-2cfe96eec4cmr5942185637.26.1758666835335; Tue, 23
 Sep 2025 15:33:55 -0700 (PDT)
Date: Tue, 23 Sep 2025 15:33:03 -0700
In-Reply-To: <20250923223312.238185-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250923223312.238185-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250923223312.238185-20-irogers@google.com>
Subject: [PATCH v6 19/28] perf top: Use evlist__new_default when no events specified
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Atish Patra <atishp@rivosinc.com>, 
	Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
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
index a11f629c7d76..710604c4f6f6 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1695,11 +1695,13 @@ int cmd_top(int argc, const char **argv)
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
2.51.0.534.gc79095c0ca-goog


