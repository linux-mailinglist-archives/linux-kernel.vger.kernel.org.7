Return-Path: <linux-kernel+bounces-815795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B783B56B2F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 20:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDC427A501D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 18:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598C3243968;
	Sun, 14 Sep 2025 18:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gCuPDNuy"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674B684A3E
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 18:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757874282; cv=none; b=PYP4Bj1ICJNWhGzt2+xDO6XgDfMKjA+sNUGKRG0avjT0xMkOjTGLj+53aQTYrS1n+nfX8YJxQPjdxw9lAFd2NH7qrgzL0mdwQGm1pjB0s2vXMgKOKUGUY1Z8/f9WrvgcYP2XISrinFmpdO13jBU0CVkBIKn8uRPWpNrZ9b/IWkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757874282; c=relaxed/simple;
	bh=c1zhOVVMQ8wU+7mhRUNPp+wxtAoMdBZyfu+0+9wUxd0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=Dct9Nx1URLys/1L5zkfTpHQKmIMNylCK//dOrxzaqrMR91yl+9j2iaJwNWiHyXRsYUAXGH6I/oJ6K//lLYYD7L5GrPTCCahyfKP/n6GrXZvzFPQBF1VwQwP7GAR4MZpZsRp+3PVq0QD+Evm7urDGv5n1AGYjFeeS7dj3gMRwPEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gCuPDNuy; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-25d21fddb85so46072505ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 11:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757874281; x=1758479081; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IE+Ce4sKejx+7TLffAwOq5GqAqr/hiqBaebc9tZypdw=;
        b=gCuPDNuyiH4TcTrmuWSyE0jSnaTxfRVxOPFdEIeTfFPeYe0okwSc+yzS91nKQdc/uy
         bl1n7M0zTauWiF7VITlmMVkGWM8ob9i024OI6hSockcoUCnq66DtUfnsa1bEmh9jnXg/
         Om/LV44mfnwJwBBn1kZ5RUxCUWWEec7x9Ol4313L4FVnd4WAONtwAmQsJRQc/IeEV0XG
         6bIKJwF0yIAZ1NwpwAvmuzdgjxg6UHvEm+LAxmw877TOGR0kXgDFkYKxkphvT6qKFvl7
         Fs8PgbYx1HVVV4/LLJUVWIYmEocxjc2qo/wmbIPDhMvuqHGomX6CvMZF4tBofPvEFrjT
         349Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757874281; x=1758479081;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IE+Ce4sKejx+7TLffAwOq5GqAqr/hiqBaebc9tZypdw=;
        b=T3yOdFXwiv4Nuh5pZ9AlVdh5oXoqKutVpnznE6OExzaRbEYIRZs47/PQwqywY5gOR2
         2gXit3RimJl2mO3MqSbQgjDp1yBoaIiPdZZn9gGSWMZS7SmS/drN6BOukkLE6SN7gOpT
         iVHLA5ck/pCVDlC8qPJoDbyOaIbhiAozPObQUZrkWZD2E5ItZV1S2nUeBgNzAvlPNrW4
         saJQ/kYvZNeVE6Aw3OG1ox5X2JJnrsFtCRBPoWIFfxlvmPPU96Irb1eCwLiWp/3AqGCW
         f56SGf77c6QCpHImmqm/zP5pr2NH+IUox8BSYl6cbnoYZ2UmzdZNOJ/6OUn85Fwl5RBj
         9oiA==
X-Forwarded-Encrypted: i=1; AJvYcCXquq8Hui8ZLwhT/hTFMnqvXEiDRqdyLj5D5b4lAl5wCFsDfA1VZphHe8tEFlUA/gBCXCr3sAmvygrpiHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUb6M4Jzc3uU8Cdddm9Sijx6KCJAJx5mRJP11+zvI8sLFHQQ0O
	uR57o+VYzNR5ZSFF62rBoKm4J0kRaL1GhcraKOQhVaYCW59qfPb1RRwKX7X0POmsaJzRbFkhAGB
	LGc3h0SV5QA==
X-Google-Smtp-Source: AGHT+IEni+sfrUT3uNfCX7z902e/80bK4Z6raO5OgXAr7WxdCZ+MhDqLjdto7FL8yKctv7osY/7uM7ublLqw
X-Received: from plsl15.prod.google.com ([2002:a17:903:244f:b0:25b:db75:cd39])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d512:b0:263:b8f:77dd
 with SMTP id d9443c01a7336-2630b8f7bedmr59519585ad.57.1757874280773; Sun, 14
 Sep 2025 11:24:40 -0700 (PDT)
Date: Sun, 14 Sep 2025 11:24:37 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250914182437.1959331-1-irogers@google.com>
Subject: [PATCH v1] libperf mmap: In user mmap rdpmc avoid undefined behavior
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

A shift left of a signed 64-bit s64 may overflow and result in
undefined behavior caught by ubsan. Switch to a u64 instead.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/mmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/perf/mmap.c b/tools/lib/perf/mmap.c
index c1a51d925e0e..ec124eb0ec0a 100644
--- a/tools/lib/perf/mmap.c
+++ b/tools/lib/perf/mmap.c
@@ -508,7 +508,7 @@ int perf_mmap__read_self(struct perf_mmap *map, struct perf_counts_values *count
 		idx = READ_ONCE(pc->index);
 		cnt = READ_ONCE(pc->offset);
 		if (pc->cap_user_rdpmc && idx) {
-			s64 evcnt = read_perf_counter(idx - 1);
+			u64 evcnt = read_perf_counter(idx - 1);
 			u16 width = READ_ONCE(pc->pmc_width);
 
 			evcnt <<= 64 - width;
-- 
2.51.0.384.g4c02a37b29-goog


