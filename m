Return-Path: <linux-kernel+bounces-739328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 614C4B0C4CF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 15:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A218A7AC236
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 13:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B462DEA62;
	Mon, 21 Jul 2025 13:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qQlpmKsX"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51A72DCF4E
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 13:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753103126; cv=none; b=JAMXyl4Vj3UZjm1kj+GlRCrJzyYNAZbD99kwr9FvEHvjaw3J09DkKXEW7iNvKvz2Ox/Bh32hjHCB12DbMNv8ANsWedoqI31t7qh16BtzvkiY2M7u9M4WO1MvrE/XPWNR5Vac5/s5YToPQX6UnU96BSpxFL7ZShMlDNx5TVL9A9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753103126; c=relaxed/simple;
	bh=b/ttJae4xiEHONrSB61gWYPCVcnCnqIpQyNKL5V/Pqw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kbKow2esvs8DdvIFBBA4PjTMVYT0lWGA8KYZXI1EkiepERs5u7GJ2rPsk7hLZG36uDml/TgYLGymCnRkLoa5ledOwgsRTYIzF6zf2WKcTVQvLCurEh4Ki2JYzp6nWwN2RtbzFm+ZJfEImJ0Hqobve5WKTui8huJ3tqam1emvFu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qQlpmKsX; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a54700a463so2408604f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 06:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753103123; x=1753707923; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YGtpCZfgBTuGsyBPIkbeq53HmntuKbontBvcg3TVESk=;
        b=qQlpmKsXEdRSk8zdwhOzInSekKeRUG4mdTqXX703NVvJQK+LBUT6sqlqeBWkABHvK4
         100Pwf8M6jwhq9YXV/v0vMn5LZ/xPlhDCQExu/RXIe99YZLCZw4DqabDDyhUPEl3vbXl
         psNxeu9xi4S0+VShYCXUo2bBNsRjcdSX29y3zaamf/3Rf6zVfEarmBp65g2tpBwf8mVn
         lclNVBKJ8p9TZnkOtEzIMf4MUZl3iQDPb4ULTp0DrqgUWiOgW3s9K8NgIlx+5Toi7VG5
         XWI0Dq18LMJTLmrF4zOMjoe6Iu3JI1lFtjouwFJ24DJ3Ys30ez+Y654XqVF4u3QJhyca
         0rQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753103123; x=1753707923;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YGtpCZfgBTuGsyBPIkbeq53HmntuKbontBvcg3TVESk=;
        b=E7wZegOrovQqCbTMUhnl3z3fHM13bKa8n2IzZUAsTTFLFJ95f0qlgjGsH8KdqeyaBh
         XkvwPIVBFd9JpKInqcZvAlgiSAyr/7Eq5SE1Wql5emVCFClRjMYfBDzMHKZSZoBR5q7J
         tKg8fVooaJGI6KHVx0HDm5A4ze+d0GKP1Y5hui8Jr6MG5kZdfy2bFJg/z8GQCDNm+R91
         gisuOWLwAEeXEajBtlmXfZQi13VZu0X5IXmQL/M6Fgta4q0Hg15+bzCR6HTdJa7W33R+
         c04hjEcG3Gm+4ArZJCV86wAScRperRT9lTjOgupZWnJ9dJ9eNBCRYAZ8Vk+jvgTQYtwI
         cMQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWAlpC4zKc7jflev0tT9pLow8w2gTCSp+iEHV9r4de1ZjYyCbDjlZZPYU56DHNW4fDoERB2NBawglnqeY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo2bPe1a0H+2K7L2Mp+I7vvUwgnBdQbOVzlRwH2qndi12CMkes
	KUlV9yX9K9aD5g5Xny40RsmBs0wxiAa/8FFOS3CC/rreQTU/DcG2QWDJPoBV4qHeZtI=
X-Gm-Gg: ASbGncvKwpK0+i3dq8PksqAo3jmd7si4u20H9R3IfLvYdkcHaZda5LbQDpJ0nZVfuK/
	aiG3NLd6DNDWyUP57ynjSHBLyd7/DFJcbq4iSlRzbpZjJBoez2Vr4pfwxSdDN6aQPvJvOvn0lpO
	cJG0BD8Ry69F0YMiPRbtElSSkNH7FClQmwtxsm+y3qbPBl7loYOo5HdfDioTvvZj6eXNDj/YEOa
	SKy/3BY0mf4Jiq1h0yzcsKf8cFHKRc42WPbA73NJ1tlc+qmb8LLKHdKK3JsJNcmHBNCMMY0nrkV
	2rPZGPPePZJng1GG9o9YX0gR5Yedz9gy9kiYOS+ylpJEUe5CnkridKkSlNWeVbOOC98gSrDlfZC
	LV2SL/h3DM4MWMXQzYiO2VWEZn/6rrbU=
X-Google-Smtp-Source: AGHT+IF6B+UvXtx0IYpruCvoBGXj7r+Qm/RbuQTzDQMBKY6Xx1qYG8QQ00o/M8y4LjQhDqQ1Ad7BQg==
X-Received: by 2002:a05:6000:25c4:b0:3b5:f151:207f with SMTP id ffacd0b85a97d-3b613aa23a2mr14510920f8f.3.1753103123024;
        Mon, 21 Jul 2025 06:05:23 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca5c632sm10485077f8f.80.2025.07.21.06.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 06:05:22 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Mon, 21 Jul 2025 14:05:04 +0100
Subject: [PATCH v5 10/12] tools headers UAPI: Sync linux/perf_event.h with
 the kernel sources
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-james-perf-feat_spe_eft-v5-10-a7bc533485a1@linaro.org>
References: <20250721-james-perf-feat_spe_eft-v5-0-a7bc533485a1@linaro.org>
In-Reply-To: <20250721-james-perf-feat_spe_eft-v5-0-a7bc533485a1@linaro.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, Leo Yan <leo.yan@arm.com>, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

To pickup config4 changes.

Tested-by: Leo Yan <leo.yan@arm.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/include/uapi/linux/perf_event.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 78a362b80027..0d0ed85ad8cb 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -382,6 +382,7 @@ enum perf_event_read_format {
 #define PERF_ATTR_SIZE_VER6			120	/* Add: aux_sample_size */
 #define PERF_ATTR_SIZE_VER7			128	/* Add: sig_data */
 #define PERF_ATTR_SIZE_VER8			136	/* Add: config3 */
+#define PERF_ATTR_SIZE_VER9			144	/* add: config4 */
 
 /*
  * 'struct perf_event_attr' contains various attributes that define
@@ -543,6 +544,7 @@ struct perf_event_attr {
 	__u64	sig_data;
 
 	__u64	config3; /* extension of config2 */
+	__u64	config4; /* extension of config3 */
 };
 
 /*

-- 
2.34.1


