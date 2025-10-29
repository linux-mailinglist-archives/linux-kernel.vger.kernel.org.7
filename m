Return-Path: <linux-kernel+bounces-875147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D44AC184E7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 06:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D58534024FF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 05:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A50A2DCF4C;
	Wed, 29 Oct 2025 05:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BFh/Q84l"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A06A301027
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 05:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761716074; cv=none; b=sog/1HKjJjZf8O/wM121w0WJRs9U1lWOdWPwqh37Fo9g94M9eroZx+ll/+pc+Xwe5yes53YQDn1pCxbXEOIrF95YFQt0JO4zOU4XK5XXVAaP6TntkcXMjdRI2BujbITXX36jjBsnTaFMheYTCoHzxco2PdDHbNMBsFyDupkk2as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761716074; c=relaxed/simple;
	bh=FpTNaUgVqmGmNx+bs8r+sBPdEgElqkdTfPkxVn0Dheg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=ALC7FM5zsJObVhCFFTOBeP4ZfXGwLquINF39EhgvSjM3rPh76vxdWbwiyUl2Lpi07rxTdQdcmHBIfPgI+uxEC1tHveWzEK6IuWOCARAQY/wAE8wSVEGmXi6ntQYKJjz4y5hGpkVQvJLDPsfdJVTf4vnpBOR8H0Cmx/J4Wr5cVY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BFh/Q84l; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-33d8970ae47so6321745a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 22:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761716072; x=1762320872; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cXh9vvoEB9Xb55r/nl1gF45ib8UAR7LGEcM4G2fJGr4=;
        b=BFh/Q84lpAFXB9NGqxntPcB2KPeHXTY9IbsQk+d6jOZXRd6oCfcjeKQDjuBpXRVDQz
         S2OzuI5JZ10AOAlH30fEY91Dp/QWUfM07H07gAgGnevBAlerPK3QoL2nd7iCqEyNHZXj
         98bRjRrCXMwP0YaeDDrbOMZMgVdX+haYre9fbfJZfa/NJFM834nZXUP8np/40ranva7t
         3+B/Iq1vkHYPoSgvdOXvpDb/e0ERmRSlWOX2uzx2LqcgiwnKYXpXDSj1Sd1yzp5uRKTq
         fqZwdGqWEr1hNOgKSqQMEAgpzOHHxTmscxtWL6Huh4WWOnCGQ3JwP+rh62u7sfRygqOI
         uAGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761716072; x=1762320872;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cXh9vvoEB9Xb55r/nl1gF45ib8UAR7LGEcM4G2fJGr4=;
        b=mO04+BuZAquBMjqrLJxiIA9eSo6/5Jg1iA7DmIbXLlYn41qEMTWOUAc5SLn000zV3q
         TTGfaEvlzNhs+HXcTP153xx3A2dtdOZdX82XsG71LpFqdMr5I479jcqLC+C0obrLc2IK
         G7U+o0BNfvB0BlQlek14vnS7YEhfX+iCogbM4lADuT2PIUl1WbEq6BsrhRspi4EvNzGA
         jvdsfSWvTBNYdj4+9cG5KdzzFITIFpQMXEmSeQWuJyCsSn3pvLOorBzDMdhgcnkKPZH1
         uKtacxmdRO/G3OaavKGmTddwaA2t/7kw23dl4ugM3DeeudLFlAlTmvCWEeeG0wV9CRYp
         bvEA==
X-Forwarded-Encrypted: i=1; AJvYcCWTn5Eg2sAVRGjy/rhEwU6CQyBMGxJpdqF8Dhhrm3e5wys2TbgUyaBvXkssnMot/ixmixBI20ai17Mxokk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeMhY48XJrIO7PdpXijaRTdp28sIbUnyHJD9QSp7QelFyHVFUd
	wX0nvQtw2RayjaFc4A9UfwNcGMpUaK4pJ2anxjt2kV+7ig7Bx2OBfxFhCtzTEIuUuCUVSVFW4Rs
	aNDKGDZqtsw==
X-Google-Smtp-Source: AGHT+IFYFiJlBRaGLzSEmcCEbMSqw7Tcy2yTZ+uTBtdINjm9r1zrdE4366XK6lGXYL8X+Dma5glPmwjlqQdn
X-Received: from pjbhd9.prod.google.com ([2002:a17:90b:4589:b0:33e:3482:597b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3ec4:b0:33b:b020:5968
 with SMTP id 98e67ed59e1d1-3403a2a2304mr2228319a91.21.1761716072438; Tue, 28
 Oct 2025 22:34:32 -0700 (PDT)
Date: Tue, 28 Oct 2025 22:34:06 -0700
In-Reply-To: <20251029053413.355154-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251029053413.355154-1-irogers@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251029053413.355154-9-irogers@google.com>
Subject: [RFC PATCH v1 08/15] perf maps: Move getting debug_file to verbose path
From: Ian Rogers <irogers@google.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	James Clark <james.clark@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Charlie Jenkins <charlie@rivosinc.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	Howard Chu <howardchu95@gmail.com>, Song Liu <song@kernel.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Blake Jones <blakejones@google.com>, 
	Anubhav Shelat <ashelat@redhat.com>, Chun-Tse Shao <ctshao@google.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Gautam Menghani <gautam@linux.ibm.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Yang Li <yang.lee@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Andi Kleen <ak@linux.intel.com>, Weilin Wang <weilin.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Getting debug_file can trigger warnings if not set. Avoid getting
these warnings by pushing the use under the controlling if.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/maps.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 779f6230130a..44cfd63f10dc 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -811,7 +811,6 @@ static int __maps__insert_sorted(struct maps *maps, unsigned int first_after_ind
 static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
 {
 	int err = 0;
-	FILE *fp = debug_file();
 	unsigned int i, ni = INT_MAX; // Some gcc complain, but depends on maps_by_name...
 
 	if (!maps__maps_by_address_sorted(maps))
@@ -839,8 +838,8 @@ static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
 				dso__name(map__dso(new)));
 		} else if (verbose >= 2) {
 			pr_debug("overlapping maps:\n");
-			map__fprintf(new, fp);
-			map__fprintf(pos, fp);
+			map__fprintf(new, debug_file());
+			map__fprintf(pos, debug_file());
 		}
 
 		if (maps_by_name)
@@ -861,7 +860,7 @@ static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
 			map__set_end(before, map__start(new));
 
 			if (verbose >= 2 && !use_browser)
-				map__fprintf(before, fp);
+				map__fprintf(before, debug_file());
 		}
 		if (map__end(new) < map__end(pos)) {
 			/* The new map isn't as long as the existing map. */
@@ -879,7 +878,7 @@ static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
 			       map__map_ip(after, map__end(new)));
 
 			if (verbose >= 2 && !use_browser)
-				map__fprintf(after, fp);
+				map__fprintf(after, debug_file());
 		}
 		/*
 		 * If adding one entry, for `before` or `after`, we can replace
-- 
2.51.1.851.g4ebd6896fd-goog


