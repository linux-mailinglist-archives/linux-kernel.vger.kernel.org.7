Return-Path: <linux-kernel+bounces-798939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3651DB424EE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68EB1584A47
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CEF224468D;
	Wed,  3 Sep 2025 15:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GA1sAcT3"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4698023F412
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 15:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756912550; cv=none; b=LrIWefJ+EIjIbausC6aabGMJrV6t16QePuWjuON5FSR0tcAtSyq/TGqhPDCqOb+Ppc6fF8bW7GBd8Ibhe7bCXewD9XJ0mrv7bV9aqrFRlPj0JVAIS1PBxBNJ8Hgvugbks28OWsz0Gw66+7CP0FyZ3TnSTJaeYHsSXt16iY5mMVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756912550; c=relaxed/simple;
	bh=l5JR3+UPUEJ2ClCwj8ex+lrVpnlr8I65tG5mWXGoWUU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SwJROpJhoNXhgVPgoZS9GSdKs/NrgtwzCCKjUaUxIwqb5uYOMLJ6H+Ur2RUxeS8bjLIrPRDBtw8OHW8cKpxMp5dmmosPFAvYDJZhEnyy1F9f0i5MSvi+1p4jvUeVUxV7qItCQpbJcPrzaSSB8vwJMSj4tXqcvHB3cWCFfCpbqds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GA1sAcT3; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45b9814efbcso8250185e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 08:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756912547; x=1757517347; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fMR5sXuAMQlcJIniIrDARobJ0FFiLjcpiPVUSqhd9zk=;
        b=GA1sAcT3ccTSs2srYyACOmN28J7qbl1PHVLGf5113S5hPo3R8/WgzMjHTylDPyiwMR
         rXfTB2/8D/BILYR2lmdC6QjBTH8eIGuQUvgXknfsMDL9fPXnqaBZtEfqMP6gAvcZmQSD
         Q45srAuWBQ58+9i0LLLRlXy3M6McU96jtu32VAEHmHeEvId0UsG0QNC1Xcap+v0S5FvF
         DckdgkdZ8Iv0dAjpiio2SHoOsGUCeAinyoNoImuvRJs9E9aqPRanWOTAD1wIVmKH08Qf
         mWUZED9dbwXbrk481LjVZXs+gkJpZdYxbDiv1BTFQeHS5b3FBG+swqkWHE6/IGna9PPe
         ICEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756912547; x=1757517347;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fMR5sXuAMQlcJIniIrDARobJ0FFiLjcpiPVUSqhd9zk=;
        b=n4a/9WV7Ui3n/jUA+P6AJ2vOQ8nApS+gChs/GSn4Kvy+Fr6BJ/hQ4ouJkGICo7GKOW
         C3S3Ff3VMPvtckphyb+jgfd1T7tYafSDsJ4YY1SzoOwyN9nHe030lVhKMiqzmJG3BGqZ
         iLul0LFiWtWi1tULs31dLP+Nves2uDFysh5UWcc50ifI9QSWj3RoZif+z6I37EfA2Peu
         pY4XwrDLhISnd/OafbGV/pUjt71gm8ovlZ91ZZkkDaVCXTr0IMsIWkRs0UVAgnsuuNIE
         ailznqr3hBVtQMoH0h7LUSIVGOSyGGahxr3bwpbfkFUeH0UQFUZBm1HhiASW9P/ugvYs
         5uNw==
X-Forwarded-Encrypted: i=1; AJvYcCWsGYljjRmRnmGcqzNyekq9CiHd+hJffUcCnRzPAv4PUjGsw1FxxtCo7mKr/Dx3i7jXQ4tjBb3XsR2m/bU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGwC5liGwsJ/MbW+kZ+9KAohlJqLQXNHiP/w5Swf/95DYD5swb
	Ab8nqqw6bXyM9bj2mzAf0eNLePRtJCed11olJqfduS93PFVioLkUcZVz3OiZwgHytzUhBdhnKvV
	vvgX3LrI=
X-Gm-Gg: ASbGncur329g+zvDoix5NXezaxiU1Qdbh1/QyLZmdzAMfZ4ixnyjygWzKdq2MTpLKh3
	0yjLBWy1eCq45A9Nsv0esP5NhFnoipuakMvrRDTLogkvU6g71etcSqXPQbXlbNqpLVI0Ad06TGv
	8ndKPJpnHOMHcswiFCvUWlVuzjlCgyYrmfWBmUc1mpkgO4hjxKOVp8YT6Z6qBwDVq62fXUFlspH
	VWDbPZmHThjMV3F/CVoPr44wMLeZ31jDzMemUsNFfBZUZdLA36PysSaaChdKucmlV43swSTAdjK
	N7KQl30kCqWDS9CtDevI5gj+ca/eK8Hvkk4AnzmChsVcM1dk5AO2E0U5Jyo3qgFv+hZsnQH6q9b
	1Ph34g6yAh8D/9x91U5fAAHy4zY5Y5BeiwIs2pBYGtQ==
X-Google-Smtp-Source: AGHT+IGqmlvtcSgBojPlbYZQhWtD2pJ/2FpKNNBsSoYyGicnvhdImai5K6SAb/1Au4J2gguwRAbk9g==
X-Received: by 2002:a05:600c:648a:b0:45c:b523:5a09 with SMTP id 5b1f17b1804b1-45cb5235bfbmr28123975e9.16.1756912546581;
        Wed, 03 Sep 2025 08:15:46 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d0f85c287fsm22090097f8f.52.2025.09.03.08.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 08:15:46 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Wed, 03 Sep 2025 16:15:27 +0100
Subject: [PATCH 2/2] perf symbols: Fix HAVE_LIBBFD_BUILDID_SUPPORT build
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250903-james-perf-read-build-id-fix-v1-2-6a694d0a980f@linaro.org>
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

read_build_id() now has a blocking argument, but libbfd uses fopen()
internally which doesn't support O_NONBLOCK. Fix the build by adding the
argument and ignoring it:

  util/symbol-elf.c:964:8: error: too many arguments to function ‘read_build_id’
    964 |  err = read_build_id(filename, bid, block);

Fixes: 2c369d91d093 ("perf symbol: Add blocking argument to filename__read_build_id")
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/symbol-elf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 033c79231a54..e0d6ff7d0acf 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -873,7 +873,8 @@ static int elf_read_build_id(Elf *elf, void *bf, size_t size)
 
 #ifdef HAVE_LIBBFD_BUILDID_SUPPORT
 
-static int read_build_id(const char *filename, struct build_id *bid)
+static int read_build_id(const char *filename, struct build_id *bid,
+			 bool block __maybe_unused)
 {
 	size_t size = sizeof(bid->data);
 	int err = -1;

-- 
2.34.1


