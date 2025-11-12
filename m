Return-Path: <linux-kernel+bounces-897547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA6EC5310C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6B12334F09B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D106333F8A6;
	Wed, 12 Nov 2025 15:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UmspWNsv"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AC733B979
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 15:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762960959; cv=none; b=LBnTVWsaqTcIzzRnf03ddK/IC2Y5Mp3PQE4EpAPyWOTx2u8tjEoN0PJ3OAiIxbAr0/A2+T+z7L26nEA4NI969XQwX+eaC/6L736udxnvh1DgxfN66S01wGjEoI150YiV23ubHJeNq+IJFxujuwWEwrmiTEBSGObWs4vgVFlig6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762960959; c=relaxed/simple;
	bh=0Kw4cpAnclJkB05dC5A9233l+BCrc/iioVGiD2gkc6w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JTNB1ekDAmH7xvdN//V94wHB89bA2LV+xJpe4ODSpwketRfa1bNDnexyxBvTVF91b6siiy0dyshnIDI5JED/YUvsZZznuRVYgwDZlLWIgt7kzN2avZegBtDfY9jLvRC4t46V9GGnk3Q7uOX0uG1oCLcPLIp6NkgCDkVSw9MZBQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UmspWNsv; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42b3720e58eso887180f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 07:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762960955; x=1763565755; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4QaaKNFNqowM2WQP3QSzkztxHtPDe8RFUGO77+dvhWo=;
        b=UmspWNsvPvOWfvCEgO4livn3MDzJHD+lGmgXXC9cF/wiNRgEbKuHAa6dKc/ygACMuO
         +9cggkIjOkZK3JokUj3iASvyQoNrpT62S9VfCr/jAlJgLnUbPkjdF8JZ5fAnHtXbswg5
         vHn7KQpIQG5Ojd2vXxlOsa3OfKljo4HRN8q/H9Gc56QRY9sznACw8eKUiFq3in7kxJLl
         jeJPRo4KMMQznf+NvbPK6PExPfMfTMMZyecz67iQazPbmsJzfp9whDIOr30iWgWUVIZA
         9o4vwjtyjS6gXwkgt/1dMCAkXRktTZvDEKZoIJv0mVxlnnRYqqXSLqPQJRM01XutDjsc
         ZdLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762960955; x=1763565755;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4QaaKNFNqowM2WQP3QSzkztxHtPDe8RFUGO77+dvhWo=;
        b=IZuWETnjzZmTfJalz+mY47k1WpZJUW8N/0n72yxz5pD1ftFzAa9cc3KGjT2Kau6ys2
         u4OVxFpkpsdAsT26TJWggSGU7d/hQ2/WAF+oV73Cx+ssPr1SsinBZZNNpwpuBEfVlAnf
         4XZZTmPMwKYCxJIa1gwezwI+xuCR4yhUWQE01uPvlzSTuWVBRWqr2yc9+0KnxkMcwLU0
         lxkxSSgZuzqs8JbFdfqLvG9v62CL0LW1S3qkLLi6Bm8vUMuNPPlfIcICqnIM8Ujf05eH
         6iVxgy5cxKiaoKJHai4grhLnf/3Ry3v7Lk4J1zl/hRywqGf9qO+morgIoU/J9AmvKI/8
         9jWA==
X-Forwarded-Encrypted: i=1; AJvYcCUbGo/qzP9kXG5COxHOy9pq/Ak9tnFMe8uVQfu63FhGLyGROF1iadIJ6BN/6FtqzbfHyJxKE4ShRGSFFSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YytxOmpxFkf6ebtkmNH31OPWz9H+1fllXpcMn3+Y7h/QtEG5H9j
	d3hxqatdWUITtmG84dyPBj1E1Mr340ig9KEh4G4WDO48dBdI5m3elamX0HI4ePiGlScHAHP7V1V
	IgPEPaMg=
X-Gm-Gg: ASbGncundvRIahB5r/L5/sfemdKf66f72z528L778QvVO1QwM1Jv6aSOtd6ewFVbB9r
	JaMR4XGeojbG+dtQ6m2ihlKhNeHnXZog+/Ob8T8uGoj9JI/lmno5p6+4npgw1Xa5idM15eI1sa3
	yHo3FrHI08qwLuPVX5ofv8tSTOJMIMZbtjPOZYEgj5ntUMWbU70RulZtzbCopORPLQoMUHq/di4
	S8aUcbY7mOS6+iETY0mTSFt8O2/cG23fTze7QqgHBojYpdSUr5y4L8FQmneaOtOUY8MpLUqZ+BS
	bK2LOdwCB4+7ZPFHLwBfAvhVr/HJlvMh39Z5qlAJiJqPuJyKOIwgNVyDuOHQuzZzKtPhkE5Lhe2
	WVJgvMP9kPoxFOIsgkSvwZjfYVLzenVLxNRV6YiVu/rWaBDwlLmfR9XcN8y+vJgsHmbypJwQt3k
	IGGQnQbzQJfQ==
X-Google-Smtp-Source: AGHT+IFw8jUIYvhHHQaSc4qHGp9oC+g6GYxlDDWV26ZjuQvhCnuoCCgNV1aDlJVXL+R28ybNJLrR3w==
X-Received: by 2002:a05:6000:1786:b0:42b:3ccc:91ec with SMTP id ffacd0b85a97d-42b4bb9fb98mr2774010f8f.22.1762960955263;
        Wed, 12 Nov 2025 07:22:35 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac677ab75sm33573485f8f.35.2025.11.12.07.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 07:22:34 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Wed, 12 Nov 2025 15:22:13 +0000
Subject: [PATCH v4 07/13] coresight: Don't reject unrecognized ETMv3 format
 attributes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-james-cs-syncfreq-v4-7-165ba21401dc@linaro.org>
References: <20251112-james-cs-syncfreq-v4-0-165ba21401dc@linaro.org>
In-Reply-To: <20251112-james-cs-syncfreq-v4-0-165ba21401dc@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jonathan Corbet <corbet@lwn.net>, Leo Yan <leo.yan@arm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

config isn't the only field, there are also config1, config2, etc.
Rejecting unrecognized attributes is therefore inconsistent as it wasn't
done for all fields. It was only necessary when we were directly
programming attr->config into ETMCR and didn't hide the unsupported
fields, but now it's not needed so remove it.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm3x-core.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm3x-core.c b/drivers/hwtracing/coresight/coresight-etm3x-core.c
index 4511fc2f8d72..584d653eda81 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
@@ -333,13 +333,6 @@ static int etm_parse_event_config(struct etm_drvdata *drvdata,
 	if (config->mode)
 		etm_config_trace_mode(config);
 
-	/*
-	 * At this time only cycle accurate, return stack  and timestamp
-	 * options are available.
-	 */
-	if (attr->config & ~ETM3X_SUPPORTED_OPTIONS)
-		return -EINVAL;
-
 	config->ctrl = 0;
 
 	if (ATTR_CFG_GET_FLD(attr, cycacc))

-- 
2.34.1


