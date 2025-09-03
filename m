Return-Path: <linux-kernel+bounces-798938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 312E8B424ED
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A3B0563899
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF0E242D67;
	Wed,  3 Sep 2025 15:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qvjxV+lb"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F56C22B8C5
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 15:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756912549; cv=none; b=mHGgRxOEpgWVB12RESewO4PiWJ0FY+A1hQ3t/YX28iH7DaoL1m042HosWRZLT3+8Xkez9ObL9OsdD6jE9U8cAfQSmgq/OLs+D8z33kiWv3zTm5H1aCV1fcBfdtvaw0+k4okNEW7kTKk+rqI1B7atdCmEGZkEYZx4yRCsOjjQ4pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756912549; c=relaxed/simple;
	bh=oB6YH9stGXXmyWf9fU6U+hcPYGMIbxOjTtbnKUQ/AME=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tccsYfUOPXSGnmCARJXfXPBsF0qDj+H2swnMKqlRToS7v6He8x3pv0oXYmWj0o3Fkawy6xJzRKVf3AEkew54iXCB+SAAGY+oMTgO6ET+LCgesI37jY9RJmG/RHVEUR0zUjz8nxQzSwjNxPlRuGEmiBOoubraNXlSSmf9KwXiuRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qvjxV+lb; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45cb6d8f42cso478255e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 08:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756912545; x=1757517345; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ETVP+OvG5GLGu2xaJRcK8WzZ71eqDw1aBK23tnlVu0U=;
        b=qvjxV+lbOJi9x7MxnhjaFUV2Lv25/li2a2aW7BvtnLw8mk1PGrdH8zCwM7PEvnMNp4
         7xOSfl23Seq+dLQY1gSziABSfG2RkG8kPFF+kv4edOoXM8xcsLXMZwhhyA3M5xIdaFOT
         iWqhRD9aGaDhRHduAXNSPCa0uUz4m9WbJQP7mzTJp5eudUiZjMw3MIPwO2FSG7EM3lzI
         S4jwFoEiusmHq6fQlogrgqg1HPHnnGG+W5WFCOs/GkzCeIjxGaL4Hp6/NN5gZ7b9rcTs
         c3xe16oUT2Y2gndzz1Qd1f6LJh0jdkQOeVvxOBh4Da70Qgc0HLJcgMfUYdUR2ujpiHy5
         0M/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756912545; x=1757517345;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ETVP+OvG5GLGu2xaJRcK8WzZ71eqDw1aBK23tnlVu0U=;
        b=G0jR9jk8wFQjRRe4D1BA6IBtU4lQZ2jxYM3fvET5Z5hdP5TwHoX/Sua9lomWjST27x
         75lp5YJjUsW3qH7hBi8hoxXaaMk1GiK+SNGG9vs/Umstagz3yvaRQv4WoBCGwxjJG+8i
         vec2oMYPCpKlKtxwY15wKWGB9avpQLb8GFF4cnlAtQNwSCzoAavP/Tdd6RLz6C9NwvLq
         1/d/RpuI+3ofACIQu/UgEP07t/hv15n4cxjwu5VOCikpiUiP3+yQ9xFHzHnVBumOvfeP
         LG/dT9+pwK/2vQytEyymPkshRMvWmr2V5tBnDmdVPDqO0rVw8YRgWsroOGMfIKRyVCk6
         B5wA==
X-Forwarded-Encrypted: i=1; AJvYcCVY19MISInoS7PjfsclzvPVGa/LNTd4V+7EW1u9NONdUaBf1gRkf95EBFYC02+4d3gDYuIudWUjbJryxfI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2HDCeUhsb11oMY0iqIJSQ22Zj6tZpGJKQIblRvbWK22acnouJ
	JxLKHcw2hSM8uvijZdtHcAF//tAkOOZ4/k0uQ/3HREMBQQ8pZFQsHXReK+cROOndn6A=
X-Gm-Gg: ASbGncu53V7slsfIF5POHppMsJ022jj4VRd5Rzup1JpSwuqoljvUZK3v/VlDsQQtgf0
	XmEcrrC3fUO9C6P4gcQQYUbgQxz4TLR4dVelQvTOGFfih/dICmVVMPbb3EVRM+DrRH4YvDyJjfx
	td+Y2UTpAipBy3imOg7oBl4eLVNGkiOXZmniZoD07N2WanmZ45+q6QcNW1X24jMAocOTv53OxEy
	HvufrIilIM6y0AQQ+HcFJOuHx+QNIfiiynZTC2CmVHItDTigDWRtPnXQaTfndY+ZsrzZbPcspOJ
	zo2L4g87d0lZMoVYSFqNvrdLVCB7sMO8Qfl5VT9QGGm9AJ902Ox8+DGSPnYBMzYe9Dg0G03fanS
	q1B8fwTGaRTAYOBw98+BVqcz/TODzuKPWR29LQINHUg==
X-Google-Smtp-Source: AGHT+IGQx37RL3c+ClyXLKbsQA1OFjTpe2lVkHyoUBOyO2DmfYjczXJvj3+g+jXr/QP+2ORQGmopGQ==
X-Received: by 2002:a05:600c:1384:b0:45b:7b00:c129 with SMTP id 5b1f17b1804b1-45b8558d694mr136409375e9.35.1756912545579;
        Wed, 03 Sep 2025 08:15:45 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d0f85c287fsm22090097f8f.52.2025.09.03.08.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 08:15:45 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Wed, 03 Sep 2025 16:15:26 +0100
Subject: [PATCH 1/2] perf tests: Fix "PE file support" test build
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-james-perf-read-build-id-fix-v1-1-6a694d0a980f@linaro.org>
References: <20250903-james-perf-read-build-id-fix-v1-0-6a694d0a980f@linaro.org>
In-Reply-To: <20250903-james-perf-read-build-id-fix-v1-0-6a694d0a980f@linaro.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, Leo Yan <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

filename__read_build_id() now takes a blocking/non-blocking argument.
The original behavior of filename__read_build_id() was blocking so add
block=true to fix the build.

Fixes: 2c369d91d093 ("perf symbol: Add blocking argument to filename__read_build_id")
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/tests/pe-file-parsing.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/pe-file-parsing.c b/tools/perf/tests/pe-file-parsing.c
index 30c7da79e109..8b31d1d05f90 100644
--- a/tools/perf/tests/pe-file-parsing.c
+++ b/tools/perf/tests/pe-file-parsing.c
@@ -37,7 +37,7 @@ static int run_dir(const char *d)
 	size_t idx;
 
 	scnprintf(filename, PATH_MAX, "%s/pe-file.exe", d);
-	ret = filename__read_build_id(filename, &bid);
+	ret = filename__read_build_id(filename, &bid, /*block=*/true);
 	TEST_ASSERT_VAL("Failed to read build_id",
 			ret == sizeof(expect_build_id));
 	TEST_ASSERT_VAL("Wrong build_id", !memcmp(bid.data, expect_build_id,
@@ -49,7 +49,7 @@ static int run_dir(const char *d)
 			!strcmp(debuglink, expect_debuglink));
 
 	scnprintf(debugfile, PATH_MAX, "%s/%s", d, debuglink);
-	ret = filename__read_build_id(debugfile, &bid);
+	ret = filename__read_build_id(debugfile, &bid, /*block=*/true);
 	TEST_ASSERT_VAL("Failed to read debug file build_id",
 			ret == sizeof(expect_build_id));
 	TEST_ASSERT_VAL("Wrong build_id", !memcmp(bid.data, expect_build_id,

-- 
2.34.1


