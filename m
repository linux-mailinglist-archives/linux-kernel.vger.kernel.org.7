Return-Path: <linux-kernel+bounces-805749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27747B48CF7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51EBF20115F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 12:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCC22FD7CE;
	Mon,  8 Sep 2025 12:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uXlSsaNS"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680722F8BF7
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 12:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757333444; cv=none; b=RSreCyY4GEGJU1TjxVVoWxaBvkOnAya3N4HS9ET/UulSTFGrMfxRxzauDulGQ0bBmt2GG3Pw0u79hAG+iXK9jCoWSagBsu4tS4Kg6frJbfXQfwv8SzuUpO9xBSxPzr9VSsxHzQ4FUk06bOL/0tU1hJkx1mF/0WPQf9t3vsSQuUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757333444; c=relaxed/simple;
	bh=0kvhJTYzI5zCuQfF6zHXAyfebJa9RB+TyZLC9vyQ/uw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BsHOvewK84xJ/Bvof0mp8UgXaY/bXYjxvKqMmmMtzyAPBPpy9I1Gxto3uK7bVXCAF91CswPWtG/M1r6OxQYf2Pj/QDpUchKeNoilzgi3E3LJkUDPu1q1WucyKXvcNxSI8Ml+wAstoYBZlDqwv4U4xVLQehjWPnyd4nMfqW0KKVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uXlSsaNS; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3e2055ce7b3so2646693f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 05:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757333441; x=1757938241; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JPsz3uNLgOVT7SPTn9Igef5H+k3XdxFXx7NJztU0cBc=;
        b=uXlSsaNS7MAonEGjFPCTZKCTM+htf3AmuTfefpu610B9qcvKn5ZfrcTFeL4ReI5EDD
         eHY9JMhSiy2REgv0/HdTXiv/8/nIxwmm/sU5sGXb8HvXawhivDK/ZvusVQkLipeqRh0z
         pqCVeY+bsNrcTHsy1x4xgG1pSaugUHw2cYLCG8iBwEQNpVPWUHWbDNUlZXGvcqfehTwr
         ZS1cwnNB41KhFOBei9vrYMbyIhe3aw1ob4oL/Dr1waKrP0IjRkMmyn2vL9To2xTL20Wk
         ifZjodOYtHUvuE8D+gpV3enYmAJ7WvlSAkg1BEkrvHlyhlEFi+DHM6/cO6D9lAFnMVKW
         hysQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757333441; x=1757938241;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JPsz3uNLgOVT7SPTn9Igef5H+k3XdxFXx7NJztU0cBc=;
        b=tYmii/D6QQU8/VK+LtvO4L/691R29HHNZiFp9JCvvt3jBqJk9TSwtoNsULV83v7VFX
         +Qqu7Om9wVlk7Tft7prNr6aRCp77sLx51nVUs72D1mny+303RP/aJAnXIrU1fVb7GL2x
         fx2WR6MSbO2zoVDHKrJskAdyOKGWDiKNDCbH3gVVOi/4ZTht4Eur1Gfl2ypcEsy0aOcU
         5R8/nxQA2OVvGP9F31NGbwPPzoGF938yKeAr3rzgbOOoOe0z+7TsK7IAO4/0PDG1SaSD
         +9CU89egqXpm7D1rPD9pbpMVg0dLjUmGYt/xCe7uNo7IYcGLzO0AQdModmaimVl1mEuc
         6JcQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7bEI1ZpP+3AsmqohLlwk5oqx4wzHasU555WTrH5SLefP/LteA/D4zR1KGwOC+uHFVFpch5QtM+hKxksE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyistIyQtWSmdmY3Cb0N5Oee6DjO/CTSFXFmNO455NMojClYnCr
	KzFGcDWmmXjyiJ7USilcyMrjqIxmbw1j1occfuZyiF6T/VIbtwOWRUl1XHI+5NRHtYg=
X-Gm-Gg: ASbGncu/X/UauauvAsq8f6LVYUv1YbT3MAEwqarVa8G3CkGXS/RTH2pD3c2FdH2Zd1H
	mPWqu2uE93ykNAMgTd++aeLz6QysST5qc+lkEz21R1kjt+Ob3lJ/MXgExAkq6FUdU7ax3iIuZ8L
	MAeOvUN+To5Fvg39PYPNL5WHGh+WvAqarnTq1wb2CN40OKUdH1ZsL1SZRgBwO1apJT/xbNlbpB6
	jDCo67N2tTm2QQoK+60zovxaPFiBapwMVlU1L+stKK2PqvA9ALFo7+j0u4IkvreTrrRWeBe1adR
	s5t/wNGUCTfCxc6ncCOKXsK9/dPBeIo0ncNNpUYHZmZpzQIHCej/PDbQNWnuSNudijDkEwBODH1
	qTfDr5ucIu58KYk82viK+WN5m95cVMXIWcASkTBqY/Q==
X-Google-Smtp-Source: AGHT+IFAaqKpjwj4aPOKWJLqNnoA3Btfgww5j5z05x/U+gptVrld/EgQZppTeTjJAuYETx5PqyHeFQ==
X-Received: by 2002:a05:6000:2489:b0:3da:37de:a3c2 with SMTP id ffacd0b85a97d-3e642cadf51mr6040771f8f.24.1757333440672;
        Mon, 08 Sep 2025 05:10:40 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf33fba9fbsm41397825f8f.50.2025.09.08.05.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 05:10:40 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Mon, 08 Sep 2025 13:10:18 +0100
Subject: [PATCH 1/4] perf arm-spe: Show instruction sample types by default
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-james-perf-spe-period-v1-1-7ccd805af461@linaro.org>
References: <20250908-james-perf-spe-period-v1-0-7ccd805af461@linaro.org>
In-Reply-To: <20250908-james-perf-spe-period-v1-0-7ccd805af461@linaro.org>
To: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, George Wort <George.Wort@arm.com>, 
 Graham Woodward <Graham.Woodward@arm.com>, Ben Gainey <Ben.Gainey@arm.com>, 
 Michael Williams <Michael.Williams@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

Instruction sample types are enabled in the default itrace options in
Perf, but this never applied to SPE because the default nanoseconds
period isn't supported. This meant that instructions ended up being
opt-in by the user only when they requested an instruction based period.

Change the default period type to instructions so that instruction
samples are generated by default. This can overridden by specifying any
--itrace option.

This solves a common complaint from users that the unfiltered SPE
samples appear to be missing, and only the samples that have memory
flags set appear in the various memory groups.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/arm-spe.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 8942fa598a84..b33a0a170ef8 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -1871,10 +1871,14 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
 	if (dump_trace)
 		return 0;
 
-	if (session->itrace_synth_opts && session->itrace_synth_opts->set)
+	if (session->itrace_synth_opts && session->itrace_synth_opts->set) {
 		spe->synth_opts = *session->itrace_synth_opts;
-	else
+	} else {
 		itrace_synth_opts__set_default(&spe->synth_opts, false);
+		/* Default nanoseconds period not supported */
+		spe->synth_opts.period_type = PERF_ITRACE_PERIOD_INSTRUCTIONS;
+		spe->synth_opts.period = 1;
+	}
 
 	err = arm_spe_synth_events(spe, session);
 	if (err)

-- 
2.34.1


