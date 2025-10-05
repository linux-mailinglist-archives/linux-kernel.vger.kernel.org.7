Return-Path: <linux-kernel+bounces-842412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF75BB9B02
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 20:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E89D1895BED
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 18:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F997205E25;
	Sun,  5 Oct 2025 18:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cb1k0Uo0"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3949729D265
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 18:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759688717; cv=none; b=Mfc9VIR3cyi8ExnhmCtdT0ApmhDxNI9CrSDGCRWALTKSUmNUrp3Rax/9BQ/Vlmvw2nqAXBgCiHVSr/gHsF186Df2de4+viMfRRO+8vrpMbIEfGyzUOFs2cTMVaJsA0p8n70wFy03HeqB4n3ym4irMF9MoPn3CO6BotZUOoxtDvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759688717; c=relaxed/simple;
	bh=HLWlGuKKGsxbZ/VlexXCASHgD2Zqo2tv4jU6pHirNCU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EYiqUllo98OpSkukY23NxDcsfRZXzfVD758OwDAySJcZkpYTDA5uVMuLYWHnnbHVqcw0gROCnOz4+KrX/93va69NMcoho1jqrZ1CaxcHJd7M9hLVWnk8od+/CChw9OfyKQYYAr5GW1xlzVO5qm/NXaoRWFSA2lnURKhOkL+ZdUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cb1k0Uo0; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-269a2b255aaso84448335ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 11:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759688715; x=1760293515; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pGrB9wpoGRw4wb/VV8boqf4ZZbV8ujvZqQy8douNpFU=;
        b=Cb1k0Uo0It61gCSPdDMfP+80+oc9l/oFL8Z/yuHo3YwGYXQocWh0z3oXdmYh3LtHig
         uJTIBAZMoLwLRPcHcs1hoAaSApB4zQSfx0/UOcHAL7zjvRp/dJV+Hx56ARLLfrUG1xjc
         247QLjg3B9JybhSxyDvF38p2F9VJEiaYXbe05tI8jdnNBbuwZAarEEvR4O+2obyk9KP6
         /VaY05tH+4pvo4/9hlxUxNqlSNkCWWqWSoJ1ly3f7xMp5BLjXFn3Rn25blHRA+fTCjQ+
         mDj2wgAB2+2UdzULR9QFuWguwBifei30ZnyynG1JumQZOYf2LUkn2NvmzB+CG5yKoGCi
         2sFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759688715; x=1760293515;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pGrB9wpoGRw4wb/VV8boqf4ZZbV8ujvZqQy8douNpFU=;
        b=YDsNBKiNxD5/PlZigLMc/GkVoCoCYPbVlnbzHdtyBTtmuAdl9cS7eMrpAJ/AQSiYLy
         YdGUl6XZ6QqlmhfjdDKePTH7TfaG3HJgNA8LImTUzzWnYrdLLfYxHlMF+Gs8il2HizHk
         Je3HQeaOtMV0fNp85LKBCVWgMMMAKknQ16G/oWhwmPLwOWz/TVI5hTau9AIQTmA2p5/o
         Ma+aOGRHoZJI29az/7/vnBBlUyoApCxclZQRMnuGtPMTuxX6JLJiRh8s15omcUrkkoVM
         PJpybYkmXkpWPXwmbNk4mK5iNjY/42QDXS6l0wCLWgCFq4fafi4UjOpjV4NI+oy0PVs9
         BnAQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/wgIbYYHvV7LANMfZ6gFD3onnaPHD9zTgVm48A79su5JE1LIcGhCwkqNPMbpbx4RrZcWRTn400TvKK9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOBQU0HA3rV65guV+nq9rO05tpnfzKMZ2zGwVt/1MqIuWqyT+T
	8iM2CYPVemPK3BdWXYmovfrt7cKK5h8pq2WWpAZm46hSVxxeKzOacYRF9XZ8reD0hGZQFedJuEk
	v6kcilUWWPw==
X-Google-Smtp-Source: AGHT+IHuTTRLk6nyHFo3u33c5lPkL63Gcmyz1jzNBU2q5+TfJ2opM10Z3AmlL82Ky7TkElo3bLnq5800X+qZ
X-Received: from plbkn4.prod.google.com ([2002:a17:903:784:b0:267:e964:bc69])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3d07:b0:268:500:5ec7
 with SMTP id d9443c01a7336-28e9a5b9441mr127956365ad.2.1759688715580; Sun, 05
 Oct 2025 11:25:15 -0700 (PDT)
Date: Sun,  5 Oct 2025 11:24:22 -0700
In-Reply-To: <20251005182430.2791371-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251005182430.2791371-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251005182430.2791371-20-irogers@google.com>
Subject: [PATCH v7 19/27] perf evlist: Avoid scanning all PMUs for evlist__new_default
From: Ian Rogers <irogers@google.com>
To: James Clark <james.clark@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Rather than wildcard matching the cycles event specify only the core
PMUs. This avoids potentially loading unnecessary uncore PMUs.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evlist.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 80d8387e6b97..e8217efdda53 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -101,16 +101,24 @@ struct evlist *evlist__new_default(void)
 {
 	struct evlist *evlist = evlist__new();
 	bool can_profile_kernel;
-	int err;
+	struct perf_pmu *pmu = NULL;
 
 	if (!evlist)
 		return NULL;
 
 	can_profile_kernel = perf_event_paranoid_check(1);
-	err = parse_event(evlist, can_profile_kernel ? "cycles:P" : "cycles:Pu");
-	if (err) {
-		evlist__delete(evlist);
-		return NULL;
+
+	while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
+		char buf[256];
+		int err;
+
+		snprintf(buf, sizeof(buf), "%s/cycles/%s", pmu->name,
+			 can_profile_kernel ? "P" : "Pu");
+		err = parse_event(evlist, buf);
+		if (err) {
+			evlist__delete(evlist);
+			return NULL;
+		}
 	}
 
 	if (evlist->core.nr_entries > 1) {
-- 
2.51.0.618.g983fd99d29-goog


