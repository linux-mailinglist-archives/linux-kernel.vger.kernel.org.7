Return-Path: <linux-kernel+bounces-861300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5114DBF251A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 18:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E48544F7F3E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30D5287502;
	Mon, 20 Oct 2025 16:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NSRivX1f"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43579284672
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 16:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760976573; cv=none; b=cy8sQCRyqTDTd23dhsXdqiVi7X2ELg5m80KX2NnMGIS2L2/UBK/EMSx546NuigWffUd+y9dkBiK7vpcjM7uSwIz1kCNhpNzC6A+zvHlAwV2srCY3kXV6B1LZJrv/XNcUegCFt7kT6sGJFnnx9SQyo7s0vMFxyfYZvK84u+a16bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760976573; c=relaxed/simple;
	bh=ha6ie/2/u6zJrKwYTajAyrhyL5xMgX+Aax8ZNcQwaqM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UuNQGKAkG1rU4n1UXehyNc7cPZ5+67seAVB6syau0dCaDwv1t9wdEP8GX7iRRF/EvuzwEkFuz6oCjOIRl0ijMT8uR2NQ96QhPYwgF6d2GCWICpS8Zf/lIVOVvXgH1c/spkf9iKC2fq1E9hMplKdL1/KSCCga8su3wXr2ejim4qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NSRivX1f; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4710a1f9e4cso34079825e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760976570; x=1761581370; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EdGV3pXRvDZEMUVAr3wBUVdjxRZ+XlT8jBZ7bZa9MFk=;
        b=NSRivX1fB3h8ImFLmeyB9+P04/MCuwil2D2FB78RFUg+vq80a0DukPWYw4stJnIbmq
         S2E8JWfs5skricbml9tg0XdAxIfYTaBbRVU4ED7FBpJgvMfhHah7251Hswy2yMZNeBgr
         lsk2xgRN70spAUv8CpUrefh5/ueaPIw50kvZCCZ7TboANyE0nK2iO/ml8puoc+W/ljPd
         K+0CI+IdJRdWV/VPJ7arObsDwfRiUaZJE4hDoKSZrBvP4hQCPE5y3p/4uDj78sY41KGG
         fvPFtbBvKgvYP00Ac57DI/4KD1Jy1YiaGUcuEOG31M24PG10MY1vEecK/670RHn6VDEL
         0URA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760976570; x=1761581370;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EdGV3pXRvDZEMUVAr3wBUVdjxRZ+XlT8jBZ7bZa9MFk=;
        b=kFdAi1E+FzoAcIt1p58r0VTdxN+JLOdz9mVkKBNeef5sM6rZXRjktxEReiApsypFbr
         tLEzHaLCxmyJc+h6YZdrTSrf4muA4zaSbSz4wKYeCKCkQQ9rycorSV3A+xDzbOdb5n5k
         tEBzwsJNSngD1YYCrOGWDUO4V4kpSLisK1Doi2BYd1csHQlGLDWp1fqJaNJ53UQDX9Zg
         9jM5hEU242r8qQMt0QalOoGmM/88/B03pF77eoFhp+8ZzqZHTJV3YfPhhMEw22iT+BJc
         OBgnV03BhARdHk+BScPv+5E/gJ8kpIolBqBNY7xXDP39EXRW0RMyA41FXYERp7AxJkUq
         T29w==
X-Forwarded-Encrypted: i=1; AJvYcCVe0URSAnOninHai/EqnBiFIT4bV8RNgFupMF65iR2g5ffR3kekgnDcRBN8TVuV12kaRd6nL4VM/Vacdl0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqxbI6fEsMmPagtX17o5BSK3l610If76k2iI8nkODD+21J4zx/
	42B7URwxU1WSYyV6/twN/qCyO978REtVLaYVcLNEeJg9WqdasHkWiC5EWfjuj5VybE8=
X-Gm-Gg: ASbGncvLtEHysi5r5Sh4c0ZEFifBQlKAt0u8+FxP3aQHKR/5CnDjSBMI34r+Bwn0x1d
	V9Z+vJ1J4sUsOxG1xrxCea/zDqJ8QM7d6o7GM3HX3vuqMXHB+tGY56GCFh4e8pPZgLgNoVe8xO8
	w8kTL1BTOacHAuJWwPcTqAmG2HFlVO5WsDpulsXwTU99k3MPmwKU9qh1tTY5ojmJC92uQEsK5ci
	fzEO9ELysk5fyc/lw7YfOJbqSezur51kNfLo72oczlMONg41GLpJIK8IkGDh9B3yKVk2lycnXPd
	1YHXJhSDntB7hmhdmjWQBuaVJvZgz5sR4Eq8DhAsVhYePZE5cS1CuBHBuMDFsvcA/sc6fPBE6vP
	yI9mqELwsS87LS4lDi1DFjuK7tYJssNvRYWrXANkZ9qjy2t6ZCAmJpSZfANy4sUznPMtDYY6BFp
	/uoxnNzwF9IQ==
X-Google-Smtp-Source: AGHT+IEpD/dgfFxYo7Xn6Vgdco+3DDr06fnsR0Y91h0oS5NHj2q4LVKHPL4JNe8M5lo+EseIF/VeOw==
X-Received: by 2002:a05:600c:34d0:b0:46e:3550:9390 with SMTP id 5b1f17b1804b1-47117907a3bmr93162205e9.20.1760976569664;
        Mon, 20 Oct 2025 09:09:29 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f009a6c5sm16408067f8f.28.2025.10.20.09.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 09:09:29 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Mon, 20 Oct 2025 17:08:28 +0100
Subject: [PATCH 3/3] perf jevents: Suppress circular dependency warnings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251020-james-perf-fix-json-find-v1-3-627b938ccf0d@linaro.org>
References: <20251020-james-perf-fix-json-find-v1-0-627b938ccf0d@linaro.org>
In-Reply-To: <20251020-james-perf-fix-json-find-v1-0-627b938ccf0d@linaro.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, leo.yan@arm.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

When doing an in source build, $(OUTPUT) is empty so the rule has the
same input and output file. Suppress the warning by only adding the rule
when doing an out of source build. The same condition already exists for
the clean rule for json files.

This fixes the following warnings:

  make[3]: Circular pmu-events/arch/nds32/mapfile.csv <- pmu-events/arch/nds32/mapfile.csv dependency dropped.
  make[3]: Circular pmu-events/arch/powerpc/mapfile.csv <- pmu-events/arch/powerpc/mapfile.csv dependency dropped.
  ...

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/pmu-events/Build | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
index c5e2d5f13766..a46ab7b612df 100644
--- a/tools/perf/pmu-events/Build
+++ b/tools/perf/pmu-events/Build
@@ -29,10 +29,12 @@ $(PMU_EVENTS_C): $(EMPTY_PMU_EVENTS_C)
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,gen)cp $< $@
 else
-# Copy checked-in json for generation.
+# Copy checked-in json to OUTPUT for generation if it's an out of source build
+ifneq ($(OUTPUT),)
 $(OUTPUT)pmu-events/arch/%: pmu-events/arch/%
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,gen)cp $< $@
+endif
 
 $(LEGACY_CACHE_JSON): $(LEGACY_CACHE_PY)
 	$(call rule_mkdir)

-- 
2.34.1


