Return-Path: <linux-kernel+bounces-897541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 066FEC53539
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0CD64A6B6B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACA7277CB8;
	Wed, 12 Nov 2025 15:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ERh989SS"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5BB224B14
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 15:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762960953; cv=none; b=vGu8GVn/o7WL8qWMN0yoojdDnJk2mdOJ2OX0dB3Ew9aKpQ38sMo1GiA46Qg91SDiEcPdpW5/R++snp78KVEsJyZqd/HgVB+Rrve7COm0MDnyKzKYkutqyG6tWj1r+aeLRCrDe08TOwEfL2ao5swB0JYZKzMRWvsqUGfcvn9WJ08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762960953; c=relaxed/simple;
	bh=thGvUXe9EBJVjRo9zSLEvcWrnhmXPs68T9d9mh3yfxw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=scAKMbjF6tmzxyYnyLELdFpyO5ls9eoCE7pUuYrNUuYScIFe/dNjEjHjuHitOELCILXrJiqr/BGs7Q+nWbV2EUcxx082+IxkS/zXM//AH08RbIAYvpyVLjVyjc9QK7uvBHC8B5M2AIrVPv5qwSeZ8dNuT5YQPYkBAdAJOD8HBkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ERh989SS; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-429c4c65485so759875f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 07:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762960950; x=1763565750; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FHWft60bOhabLyvWPLsf9Lg98jcEqwRduNX+1kYsZ4Q=;
        b=ERh989SS0br/fLIqkyHtsKNvataLKMoqtsnbjeTsyTnpy5msOD5FNbUbvzqGqOY86u
         bN3uUNghcKjSbjo+tQ3jP9FylEl4anURf8H+LC7WwA4gYg+l3awUDWFyB6oXEuTGwk6V
         KarkE3KtNuX6L+PSICn01ITNoXoHKRAMTD+ULzJDClnvX0RRPcbOAZitvdOICpmrRr1k
         jNgu2JPKloBNxZwZSPhviZIodK7NhQkZ7KL1Zv3pPabaknlv+pojfECb+NwxA4hn1FT+
         Wolpci1c5XMDvNj2BNR7IDnWGK2qm1Ejq9B/zah9yiuBzHl4MCKbS/awPE/i4PkZmjJx
         CMOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762960950; x=1763565750;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FHWft60bOhabLyvWPLsf9Lg98jcEqwRduNX+1kYsZ4Q=;
        b=cqRSPH2rEJjd1xZGdf5JlzswjIclNNc+Bd/ioLOS5eE8w7YUBAyD4zhvIYxFn1LJb4
         YFjG1w0q/CJ3cGQO0na4waGDAgsI+1HUgeYebKRwF7DyBolM9SF9HINDUipOcxTYDH3H
         qloWQJy7AbvYNCgXzjmRCT0vw+WeCZz4omNhNp6I6H78KSSnddSpN1dk3J2EeWer36mJ
         VAoW94hW1+Z78FoMWYndHymxCJuBjvfO1xt2X6P1Ny1lr9uV1dPFREc+K/Tu1jYgYajm
         yHY7kNObsYK2wypehEGMem5Qrob0JRZIlWQkZ2y2p9L9GKhrMeqm9d/G2iAGZBigIYwZ
         oqTg==
X-Forwarded-Encrypted: i=1; AJvYcCXsh2SelUI8o1YrBpyywtVbSUrKO0xk2NTFrHbzGu9c9M3RIAhdKx+WQ/pSouWf47QqHHWjp8imxZeq4mU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLObEZYmSA9w3Y+EKmluOGeB4/TcsFPxSSQPSKZr0tfqfCiCSt
	Ak19oFIS9UfCX4qNEnGtz9BZk/uGI3q7xnmq5vj53Iu/piYOgswNa1Ys9bkVhtRaB6etJRf1qey
	mM+mN+PA=
X-Gm-Gg: ASbGncsqGHdXK81TjMmfzeFU1Dl3CfUYwS3sANsP8SENiJ/zNO2dBsNaNgLgJ14mI0K
	8ulZZm7N0jXuAyd+3UMqTn6+9zHX+T+NAbeHt6kNrnWS2QkK/a3mqzDyBBaZSY3G8BCBiUE4QVp
	0dis7/7fvCf5V8mpJx2HInjRxasQNf3P5HNa6JAWteXIfpYMV5EYe3jqt/ntvzqNs8u1AzSKMMa
	Gg4zPUBxXQ+gjQfS8+Vg/GxQNgu0hcUrDtHtQ+WdMA4TDd4V0lhCcjZ5vTMnddbTp0RrAPXu7Wa
	GGVW3eVdo9J28xsq+x0EMveBnV8EaS4Pcg8KU7WvHI3jXK72MYgcedZhdI1q1P6r4OXHGGruo6T
	7kEbOdRA8auKX8QEwXJ5mhZsq8nGCa0ipbziOfgBFFQyUspBerF0ggcaGoWDxnTEjIC5kEze19X
	9B3lO8Rk6L0Q==
X-Google-Smtp-Source: AGHT+IH52DNTLBb7al5zttlsVEiexafiX+OCjlQQr0fildUN7BN1eWHybUmsF+e2JGT9znBkdM3Dzw==
X-Received: by 2002:a05:6000:3106:b0:42b:3ab7:b8a8 with SMTP id ffacd0b85a97d-42b4bb91763mr3253408f8f.17.1762960950054;
        Wed, 12 Nov 2025 07:22:30 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac677ab75sm33573485f8f.35.2025.11.12.07.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 07:22:29 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Wed, 12 Nov 2025 15:22:07 +0000
Subject: [PATCH v4 01/13] coresight: Change syncfreq to be a u8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-james-cs-syncfreq-v4-1-165ba21401dc@linaro.org>
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

TRCSYNCPR.PERIOD is the only functional part of TRCSYNCPR and it only
has 5 valid bits so it can be stored in a u8.

Reviewed-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm4x.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index 8d4a1f0f1e52..56a359184c6f 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -826,7 +826,6 @@ struct etmv4_config {
 	u32				eventctrl1;
 	u32				stall_ctrl;
 	u32				ts_ctrl;
-	u32				syncfreq;
 	u32				ccctlr;
 	u32				bb_ctrl;
 	u32				vinst_ctrl;
@@ -834,6 +833,7 @@ struct etmv4_config {
 	u32				vissctlr;
 	u32				vipcssctlr;
 	u8				seq_idx;
+	u8				syncfreq;
 	u32				seq_ctrl[ETM_MAX_SEQ_STATES];
 	u32				seq_rst;
 	u32				seq_state;

-- 
2.34.1


