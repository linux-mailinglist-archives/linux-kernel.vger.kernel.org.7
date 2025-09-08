Return-Path: <linux-kernel+bounces-805752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1158DB48CF8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F9281893309
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 12:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BA32FF66E;
	Mon,  8 Sep 2025 12:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VWUXWoc/"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D182FE059
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 12:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757333448; cv=none; b=T5INe/Q0Ei7Bcoey4+KP1D0tnQGjaNF7cTriWsjbIzuXN+eoPpsqTpbhBY229QHXacBmtEM1Tz1X3f4BuRSinjoFWwtYnTg7Zx/jdk1Xycge0o8uFT0aqt63WxluiCh6tJJRuxlAsCZHFamcumuFT+YQEdZdFx/52/YMGs8RFHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757333448; c=relaxed/simple;
	bh=raNLMpkl+S5CZKwgmk04jznUUUHrI3AfobHlmwQcWqw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iJBY8C/ZXlFqrjE3jInrN3OQudIlCZgZ3MKNvEAgvFlSXuFlNxD556WvfuyEPYA33B2+kpU1BU4YkHblx2PzJAdBVQL4g0+VXB973qj37AsvJt/BKmClAKGtWyG1rA+UjLIflR6FDtSRLBqmwHhAf/ZGa97h1WSAOor/0UAk4/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VWUXWoc/; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3df726ecff3so2177182f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 05:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757333445; x=1757938245; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qqo1+7mglImJW3/ESP2sAU0K/vghCbEUc7ur867asyY=;
        b=VWUXWoc/iOIswXuFQ/jUGWkzn9QTQDuJXTvwFpkb6CDeBeCVZj/0gnUp6nNtVUs8Hc
         FDTUM6W72x7X3FUfbDa/q/kn6vjt4tSw0KdtDjKgJTyiimgOwNGrlLA8HEOt/JIWyvJ0
         wo5jEx5DQd37QQCYqP3Z+Mok2nb5Y/QfUnp+/6wqMIVAaAInGGSu50iH4zGK0adw2Z5+
         kdbzWM8MbnmBLIZrLbqOnMmEWSfEJxNGrOQ6EQBfVkS5U5wqqoscg+iuGQGh2gwlAYPc
         6NQx6DCamPSw5h3OGn3+ccYPqLAr4dq2ciw6XvTpYhyWT3iZBuEGRwVcXzWpdHziCNHZ
         AKqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757333445; x=1757938245;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qqo1+7mglImJW3/ESP2sAU0K/vghCbEUc7ur867asyY=;
        b=wq6HMOaZ2bI8MRWfckxFzqbBWBm5piS1n9GmJiTcY11Igxyid5PRT8n1mKY46Tk8bL
         sH0xXSe2GltAYee3CFwLPq9gnj7GThpPVmW7AIj8w20yABcnXrdCOZgc7YHonvEcBzEo
         fKjjdff/LVJ3lyWMG1G75I8kICWvKbk4bQQc3EAUlJ9g3EPp0Xgb5IvMY4+SWvzKj/yk
         Sj2KtTDGWIyfKBCDwauQc5vk5MwOPqweFUb/zkw6f0xxpJAFZzYVjxwvT1Ksa5gh/DUD
         2PyOjIvPTNChCjTQMiBAUhDtNjNPFHfJJa1cbmkgQ1CHGmwGluFtR7a15b/NzAJYX6bG
         jsqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSeUmesZypw4EBSmlNpObaB3RXShnaUQ4xVJhXn+8OjJ6kJspU6jpl75BwclVvNfAIekeQKv9gR7NCvUk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz07jm/aZ0u0WoLwbPuScVmyT4gwOIrSrYGSE9dxTP2nc6kub5q
	bZi4D6A90PjLyzurdxmKsR9lwqGkFx8uF/mUmElw6/dsmPamGOEGp9dMAUpCQlkiI5Hk9ytejXA
	Q288jAFYjsg==
X-Gm-Gg: ASbGncuBTTxyhg9k8fQr3v6TAPI6/HJp/4J1sW7U5YOk2dLa30sgF/2y4js5pI5/LxV
	BsYL+uH8+RRVAK99cZSFT+bsfwmVneOZv5dHZU+MY1b0OG4XbQJo3CxYFozflZ6VHib9aR0J5rV
	TFGT6tODlNQkOJY6g9PoS23wUSLvUjdVHPn2xBZcTeoEoX29dC+VqmOpgtReiOOESnpspGdYH7a
	0GlAECB5KATpDpK8/HvOrdA/Vv0BNYp+/bTB2AEsIzyYrtIdLqOSKTkf9jSPBx1Yu4ALX/UBAEC
	TLiiLNYfpRCMdX3nR5LMJXS9n2Vor6/oZVJtFcE1I93n3Bg6x9EkwlMyXebdb5mocSw+VS0tynl
	OYQTZy1dNvEwSlVJuGGJ/VbuT8GVJcFI=
X-Google-Smtp-Source: AGHT+IGBWxzyRFeeGevfk44/JfpKxel/pd+hKUi5ugftmEIb0KfQdxCQwGM4PG30BiUOferaK3FuAg==
X-Received: by 2002:a5d:5848:0:b0:3e2:5d59:4868 with SMTP id ffacd0b85a97d-3e643e07d6amr5074970f8f.46.1757333444701;
        Mon, 08 Sep 2025 05:10:44 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf33fba9fbsm41397825f8f.50.2025.09.08.05.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 05:10:43 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Mon, 08 Sep 2025 13:10:21 +0100
Subject: [PATCH 4/4] perf docs: Update SPE doc to include default
 instructions group
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-james-perf-spe-period-v1-4-7ccd805af461@linaro.org>
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

The instructions group is now generated by default so update the doc to
reflect this. Also explain the period/downsampling mechanism in more
detail.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/Documentation/perf-arm-spe.txt | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Documentation/perf-arm-spe.txt b/tools/perf/Documentation/perf-arm-spe.txt
index 37afade4f1b2..cda8dd47fc4d 100644
--- a/tools/perf/Documentation/perf-arm-spe.txt
+++ b/tools/perf/Documentation/perf-arm-spe.txt
@@ -191,14 +191,20 @@ groups:
   36 branch
   0 remote-access
   900 memory
+  1800 instructions
 
 The arm_spe// and dummy:u events are implementation details and are expected to be empty.
 
-To get a full list of unique samples that are not sorted into groups, set the itrace option to
-generate 'instruction' samples. The period option is also taken into account, so set it to 1
-instruction unless you want to further downsample the already sampled SPE data:
+The instructions group contains the full list of unique samples that are not
+sorted into other groups. To generate only this group use --itrace=i1i.
 
-  perf report --itrace=i1i
+1i (1 instruction interval) signifies no further downsampling. Rather than an
+instruction interval, this generates a sample every n SPE samples. For example
+to generate the default set of events for every 100 SPE samples:
+
+  perf report --itrace==bxofmtMai100i
+
+Other period types, for example nanoseconds (ns) are not currently supported.
 
 Memory access details are also stored on the samples and this can be viewed with:
 

-- 
2.34.1


