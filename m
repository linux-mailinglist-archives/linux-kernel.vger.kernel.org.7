Return-Path: <linux-kernel+bounces-768427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF15DB26109
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D2337BE88C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33862FA0F9;
	Thu, 14 Aug 2025 09:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p/laRN4f"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97012F83CD
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755163575; cv=none; b=NfcogNbKojcChmz9Fw3RrvVaYAcUOZA/4JWRSxWedH9wuBHyn0q8eKC1+S1Utw2vCuctTqhEiJiWBwlhqDFno1LQJXln0u53A92/R2dpfZ9M21rhEtpMFgiTBXkd6Xlu57cfRl5+gbrCJA2pX4M/0v2jphVSBlZ+ZK6aK4z5Tzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755163575; c=relaxed/simple;
	bh=b/ttJae4xiEHONrSB61gWYPCVcnCnqIpQyNKL5V/Pqw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UBvfS0vMeVxQ9ZY5ZLNILHrudlErfHkYMgQtmklnSSiFWwkWM6qhuUJ4pLrTQdgREwuUGrD8Gy6b8FpCY599kZvpN2oQXS39uT3FBxSQgcpbzVWzgdM5gyVRr9itb0DqBqQq3Dz45ct8f7AbxIuZIt9mhlTqa+N8c7DjpaQIW0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p/laRN4f; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45a1b00f23eso3760915e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 02:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755163571; x=1755768371; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YGtpCZfgBTuGsyBPIkbeq53HmntuKbontBvcg3TVESk=;
        b=p/laRN4flPe2/P1CowT86YgfTWKRwrcfXfn//tIJLMZ+YmZK+B0jRpyKDZw38m+wW8
         ydCeeK2gkUgAjVHEM4cIUR2kL6W3Soi/dSBZPnpMT4aCAutvLbRZMG36u9APU4tqUG6/
         7fPmdPp58FQSpF9P3tPiLe8u1vZT1E+SDCCrl4iGvxBGl/r12Qfqi5DmpUSss7G8Mx30
         vpIz1U+4+IjXJbmUBWGih5ISiVPxzUOXyUfAWtQHoi2E238TJYENgXByNSgMI7/XNrt1
         NH3XUGOweofx1kC4mk3gjayod4rKeRf4/kUwumiJAPcv1xNijXF82noWUxdXz1ke2wkk
         hoBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755163571; x=1755768371;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YGtpCZfgBTuGsyBPIkbeq53HmntuKbontBvcg3TVESk=;
        b=rdXkwZQ42Yf/XLZIgi/mgpIMqYFDPziQfAIrAsyvO8NHYpB8bq78nMMQWqXWjOxk7J
         mM/0kdHLqWtQiQO6tTAeKr5SR5zzTm8wjXIh7Izap9xWF36jau7lGJSjV3lJ4PclGRIk
         0n+JDCQ7qxF2jhvGA7vDy3f6xxOLpj1uVbrBVOvg0aAgy3iQ4jSlSSSYuUtGe3lhxbnP
         BSLS/b+mOxG3yumNr74vO/L31hDuiN/LYzhdipmMv1a3+1ul5r3G/1DElpDKHdfuA0tX
         D+LUefPcMWqyVhGBsEA1q9ZAgkuKvCqXnB96A9vsaycjXQUbWdA5N0OJ60zVSnotWbxS
         apOw==
X-Forwarded-Encrypted: i=1; AJvYcCUDB/rRSs3X5z2xC5C4p4UsQOfnKZPgA0nqf3NxPTq8Rp3LKbPQpJX6IANdsA9cKp8KjwhU0V3rR3Dyvh4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUfN10Wgo3Of+ZSmt61jGb5p4gOfoosKRmqjjvssLOsw4J6Mt/
	DKy11+4cqvLm8RHgLvq/IizJbfJbs5AmeJAJEGfRauSfqz/8s8rwswZ9AVNUJ4nMWwI=
X-Gm-Gg: ASbGncs0Ar4tyK9AHDtNEwvNSFc+wq41bc/nllPdkOkFVYCrMac/OFP669oObSveOp2
	2MqZ9LHmx9iUCsx+Pss27hOj0siSVcU6R+SyYqw4wdN7G4aUt5plehcQ2S1afggd2UuxDBpq8aU
	DDcAQ6ZR1HnIO24+s7mUJ89817l7ouj8KlSKgLCsIZEHbZ/zNj2hyj78IXHeNyMgVyrwGd4mMCW
	r0+ErLYcccInhJ7VYE8//H0RTeslQRLftFYIi5aDguLsuRadNHzkUVnqslofnA/rEVoSsYgtWhQ
	RK7XbwCdEuTg8gGO9y4qAnRdJ83bDQj9UvEV15DF9213g3Chthax99mCXIQc56KaEsCcHcHavm/
	6IDDKjV93Z12TWCZDGjt9+tj5LxYuYQE=
X-Google-Smtp-Source: AGHT+IHtct+umesyv5x7r2OiRVf/2g4YUX/d+UTbwfLkfG/5sEvYEqn1B72mWCeZftKk8wn55AxWng==
X-Received: by 2002:a05:600c:3543:b0:456:1a69:94fa with SMTP id 5b1f17b1804b1-45a1b628566mr17809305e9.13.1755163570902;
        Thu, 14 Aug 2025 02:26:10 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c76e9basm14536775e9.21.2025.08.14.02.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 02:26:10 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 14 Aug 2025 10:25:32 +0100
Subject: [PATCH v7 10/12] tools headers UAPI: Sync linux/perf_event.h with
 the kernel sources
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-james-perf-feat_spe_eft-v7-10-6a743f7fa259@linaro.org>
References: <20250814-james-perf-feat_spe_eft-v7-0-6a743f7fa259@linaro.org>
In-Reply-To: <20250814-james-perf-feat_spe_eft-v7-0-6a743f7fa259@linaro.org>
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
 Adrian Hunter <adrian.hunter@intel.com>, Leo Yan <leo.yan@arm.com>, 
 Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, James Clark <james.clark@linaro.org>
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


