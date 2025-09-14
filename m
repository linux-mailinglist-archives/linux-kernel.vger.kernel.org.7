Return-Path: <linux-kernel+bounces-815804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99048B56B3D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 20:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 584F23B6417
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 18:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B6723D288;
	Sun, 14 Sep 2025 18:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EdXbVEOj"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2236B57C9F
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 18:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757874699; cv=none; b=dORhL1Ak6QGBALBHoMuS45zROAf5TASlC3EeLLIb/jIEJTj+1rNqb/arOst/p5Img2+67vcdDx16iXvDTLt/8homEanAeqi3AUPzgmgwGmXLxeqDXQVuh9wq+JIxuMTlsq3Rk/LIi5qNQb8ovPjPL5Rfq9gYOcYBjtO8NuA3Els=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757874699; c=relaxed/simple;
	bh=6UFG4+fViSeESuEnKM2lAgu7VSmoW0Id/xL/ZujVnrs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=Nqj6Zn7dCwxR38m8Ib2Poyl5cpDF0Dfjgl33exfCtp0Y6cKcVRcqnMkQamfwDkoeBIIVJjdYqdPlbtf/komRkC0JZ5Ug8f9m/fgsYThDyrmS+GAOJlONldkTkliki5+rfr82MvahMY/4kY2Zos/oAZwyqGhC4pdaJLZFMhbJq4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EdXbVEOj; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32e085e9c77so1345274a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 11:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757874697; x=1758479497; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+0HLF0l6sKrn/QwWnrA3S0LQAY0Lo5116W81vJMiWo4=;
        b=EdXbVEOjtVwQKx4FdSIqlrMSVmAvdE2/KG/kguc6n9XrO32E69zus5H91dbReMFjBD
         tb3DV0MTvueGFqLigqpMQkr+bJFpRUv3geKOdfO+3VypF0U3ZIxRcvMX4hjjCEdd5Onn
         VMABLVGRk9ZcSt+r9cPHGTwqd2c82OoPSSgrri3sNJeIHA3xoRwHYzaC59xakS/67ZHI
         m5HxGzgmmWhDx0lRxDHpQ0V64wpXajU+QMgbNFY3avvn2t23aejk3KSefLf8A8qlvTa7
         jxUOUxm1iAbup4ucAzHRfvEqQrdh2Dd4PjrxTwOQIY8P4N7bIRIqDxkdGO0fwu0eTe/B
         q0BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757874697; x=1758479497;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+0HLF0l6sKrn/QwWnrA3S0LQAY0Lo5116W81vJMiWo4=;
        b=SOZn9I8TPVBZF8IHTfaZ8AqfkBi/L81tdjO5zg4MJK4RRlfwx1G6kUmEZ3s7fSzI/e
         jC+07ZyUNoqhkU/S5sJkPF6jia4JOckeD8RA3VqPeIEnZqveqbOY4U/RnXvK395WeHfy
         VEGDjvo7o7YW/PdfJW0vdNAP2LxnIU0wQmgYpYUvXE40eQKyNVwqW54A6FL9HWLLpJ9f
         ZU5MnSzuhsruktA8PVz5dVkZSPN63FSu650j48jg2Hz2o3xgG2eCDAa01qvkSVnf+RZp
         Hy8JDbQDFZx88c5WxrO+SUJEw1grYfYrAMhfcDKCrFATTJw2UcrLG72rtTwZFqPPIteY
         vJww==
X-Forwarded-Encrypted: i=1; AJvYcCUV+rt6kQeSLfdnrS+OrYVqcC5CjmxtDwWsWM6Pu8R1O9G5nrHU3JboXtmacG0CZODk1sbQ0P2rMt7BW1A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw924VWHPEkdawfg1dMqyxCUEjCF+FYLXMl8Yx3InDVr/UaCRId
	49cH/ICpxgs2xtJgwBHKuGl45r4IvSmZVa/vj/PHdWOsmMDpyr6qWYfPNj0yDUMRIwkPk/paXG4
	AwCupUwo8ZA==
X-Google-Smtp-Source: AGHT+IHknLGJwo1dZZlB1b6P3ynSOQKzTXmXy62zaLKX4wDxFaEBVQxKejLei4la9mohWs16XOWfwXwEAsj0
X-Received: from pjbnw4.prod.google.com ([2002:a17:90b:2544:b0:32b:65c6:661a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:38c2:b0:32e:3592:5807
 with SMTP id 98e67ed59e1d1-32e35925d53mr3068756a91.26.1757874697522; Sun, 14
 Sep 2025 11:31:37 -0700 (PDT)
Date: Sun, 14 Sep 2025 11:31:31 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250914183131.1962210-1-irogers@google.com>
Subject: [PATCH v1] perf symbol-minimal: Be more defensive when reading build IDs
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The note_data at ptr is read as a nhdr but this may yield
out-of-bounds reads if there isn't nhdrs worth of data. Be more
defensive before doing the reads. This is motivated by address
sanitizer capturing out of bounds reads running "perf top".

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/symbol-minimal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/symbol-minimal.c b/tools/perf/util/symbol-minimal.c
index 41e4ebe5eac5..aeb253248895 100644
--- a/tools/perf/util/symbol-minimal.c
+++ b/tools/perf/util/symbol-minimal.c
@@ -42,7 +42,7 @@ static int read_build_id(void *note_data, size_t note_len, struct build_id *bid,
 	void *ptr;
 
 	ptr = note_data;
-	while (ptr < (note_data + note_len)) {
+	while ((ptr + sizeof(*nhdr)) < (note_data + note_len)) {
 		const char *name;
 		size_t namesz, descsz;
 
-- 
2.51.0.384.g4c02a37b29-goog


