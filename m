Return-Path: <linux-kernel+bounces-768627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CCAB26366
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8228DA23299
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434EF2FD1A0;
	Thu, 14 Aug 2025 10:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RtiOu9ut"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AAA2F99BC
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 10:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755168686; cv=none; b=afsC6jHpYwpGYiqWp9bR+IKeSA+7S4i4vZoSGHt9jesTzW5W+ipsJCU6UJExqvtnx5MowGfCkpKt+GgpbH6NyFWbURez4rNKKsX8DIpn3Lvgg3H2MC+rtglQ8kyjXAL/YOQg2uIKSWeblmYMy82v3Cvd91aMsxDkNBwIrxz/sOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755168686; c=relaxed/simple;
	bh=m7ucCcGVN0FUBECCGdzVEI3m8S2GTPWLCEum9ShUMNA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G7NW5ixhHgndsI+12tsEmHpBihXVXpzoRMFXLX00xR9wniFzsiMqGq23+H6U4Pcp6/rr0MuSnShXby3ggqZmRIKSCz/pCLcqe+884+v/p6KaSyoxqG1svhwEyEkoLvv2KmPayWpmc7QT+aUyISVDT4D2ezbofcSqgF/5D0nY8uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RtiOu9ut; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b9d41cd38dso496540f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 03:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755168683; x=1755773483; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3GDsN9LxSDEitQ0pzvRQqf9bGA4AutUNUEYwRrkhQ70=;
        b=RtiOu9utFfz+FjMdc7GSDmmMWdyK6WgSNNETXNohXIpAKfY8ob2E40xm+e0afCNeN/
         XnQY9Y7e1KMfQdWPQsF5v7c+Os0PDmjc58bCrpIQ076Jr1SfYAtglbvZO5fbqV9FVqV4
         lB2YKsXJ76qW/tZJJXfSy9gp8pRtDwMxhhLkONPlmsJ8mUB2HAq6DYUP1DDCEWnGRNvJ
         6i3wB6yF2x5Il0uhFRPKjktwgsAQe7R3yKe+yzHTi2PXn+TXNZ32UCGZalrvQqsWX59S
         sP7L62v6Rj6T+j/Rzr46pfHW2HNleQbl7blpPYzpzIdG4yhfaOJ/p2ozPoS9TsZVZda/
         bZCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755168683; x=1755773483;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3GDsN9LxSDEitQ0pzvRQqf9bGA4AutUNUEYwRrkhQ70=;
        b=BSPjqfGHwuCknng0K+9ZdktwCPsks/bJp+5A1oriGeydbhTNBFXNPnSE5u846QbASx
         A/lrYY4XsRTX/VncX96AaTKcVwiPM/FdCO/DQZXn4CfY2JPAjeUBnqs7WyHgCS8zc3Wh
         VZ7vnZuTNHP5k52pp1vXr5+x3nhj3/LvNGRjjfEBLi93PHR3fbB5MFc4M6wODcdeE9Gg
         SOY79ljyb4EqiKQpnjmBldi3DK+JEA9WmiZaT5niG5APXmWemxpvJzkwz25hZ1iUjDHZ
         WnACPnDeNIPKf46wRNbwGmlsbVRwJKWkecHIp81ZJ3g5+Ku/xC3Jx//OQ0SrrF+nGxAp
         cvlw==
X-Forwarded-Encrypted: i=1; AJvYcCUFpJSwiNuepRUcrMP4Ek4kp5glH1i5JIVM+pgpHo7d99sTfng8xoaZRK+3hcqyfU4UCJa0Vtun263dAOk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4YCOvtKL2U9D7Wk+d+M/PfYsPXiLSn+iLqfAQ1vOV/uksgbDs
	HoAEYrElbx/+dCNRTo6MuNJ11hgLndqV5pkjFy3MfiLENAwszjj4+9rjMltO2EpG7Tg=
X-Gm-Gg: ASbGncugCQmhqV+t9q0JpvPka5udLrMQ6NcZwUrr00Epw2F9HoRo8X8qvPl5lJhCgcQ
	1BsThewJdx+ehEudUbGwGPHwF7+F9fpe67NqVfsoO1ayVUwa0MvkwJfWp1fsUkqc62BhzGYpCa9
	0Xm+3Sh/aRZ1PqYbMB2rhrlgbbldrvtQzoc1k4h+v8MOJV0SEVYH84ybA1IUT2HXcBSB+SKPjQs
	k1VwaxY3cXL87uIqU4wFviSjh9w1MMEh7YiF9Ls7Wmr3Qe+2tT5PpWehtonACxn4nd7HClW2sRq
	9ih7ggcQbVlgZi47a1wMXRModaLKJ1aNw8GVoD9Lc4dOigGPcqQOFlx2fUrCItFBazNAexQnUV2
	PlnfoIgb+x3Yj2VX7XPTj7w5HvbCF+5o=
X-Google-Smtp-Source: AGHT+IF5P4dyVkR12cBMw+uYpwiYnNAlcSu0vH+8udQzxGRbHLddJ/1K+6aeezIw6lInsN/G1CLYWg==
X-Received: by 2002:a05:6000:1889:b0:3b9:7c1f:86b1 with SMTP id ffacd0b85a97d-3b9edf35019mr1847829f8f.37.1755168682900;
        Thu, 14 Aug 2025 03:51:22 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1b226eecsm14228345e9.1.2025.08.14.03.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 03:51:22 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 14 Aug 2025 11:49:54 +0100
Subject: [PATCH v2 3/6] coresight: Repack struct etmv4_drvdata
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-james-cs-syncfreq-v2-3-c76fcb87696d@linaro.org>
References: <20250814-james-cs-syncfreq-v2-0-c76fcb87696d@linaro.org>
In-Reply-To: <20250814-james-cs-syncfreq-v2-0-c76fcb87696d@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jonathan Corbet <corbet@lwn.net>, Leo Yan <leo.yan@arm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

Fix holes and convert the long list of bools to single bits to save
some space because there's one of these for each ETM.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm4x.h | 39 ++++++++++++++-------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index a355a1e9606d..1c67b263b01b 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -1020,29 +1020,30 @@ struct etmv4_drvdata {
 	u8				ns_ex_level;
 	u8				q_support;
 	u8				os_lock_model;
-	bool				sticky_enable;
-	bool				boot_enable;
-	bool				os_unlock;
-	bool				instrp0;
-	bool				q_filt;
-	bool				trcbb;
-	bool				trccond;
-	bool				retstack;
-	bool				trccci;
-	bool				trc_error;
-	bool				syncpr;
-	bool				stallctl;
-	bool				sysstall;
-	bool				nooverflow;
-	bool				atbtrig;
-	bool				lpoverride;
+	bool				sticky_enable : 1;
+	bool				boot_enable : 1;
+	bool				os_unlock : 1;
+	bool				instrp0 : 1;
+	bool				q_filt : 1;
+	bool				trcbb : 1;
+	bool				trccond : 1;
+	bool				retstack : 1;
+	bool				trccci : 1;
+	bool				trc_error : 1;
+	bool				syncpr : 1;
+	bool				stallctl : 1;
+	bool				sysstall : 1;
+	bool				nooverflow : 1;
+	bool				atbtrig : 1;
+	bool				lpoverride : 1;
+	bool				state_needs_restore : 1;
+	bool				skip_power_up : 1;
+	bool				paused : 1;
 	u64				trfcr;
 	struct etmv4_config		config;
 	u64				save_trfcr;
 	struct etmv4_save_state		*save_state;
-	bool				state_needs_restore;
-	bool				skip_power_up;
-	bool				paused;
+
 	DECLARE_BITMAP(arch_features, ETM4_IMPDEF_FEATURE_MAX);
 };
 

-- 
2.34.1


