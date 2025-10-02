Return-Path: <linux-kernel+bounces-840108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF72BB38F9
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 12:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93F92166ABF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 10:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351B63090E1;
	Thu,  2 Oct 2025 10:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SHagyM1M"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C853081DD
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 10:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759399800; cv=none; b=VY7dSL1AKAyBDzWqAEhyVhV774zCnA2QP4DSjfBx6L6+/b/2UHyuQwDVsuShjlju74rjP0hFkpo4AA/K7JJGSC8ioAiYpv3JSCU6rnbSxfuEB1toO+wFQtov4+94WRwZamRWlAoC4lAaNJi85zv64N8ywCeT/Ze0QXXdfY77mA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759399800; c=relaxed/simple;
	bh=n/ki5M2njQxahsIARlEQ5/EDGT6nzs4YYtcnD4jhUFM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t02+NqT+cgitFvdzT0S7IOxYaoPlf+OuhCaWz6VtqubQFR863//69umQQ8NsThy2XGb38iIfCpVV1DH+GPyX7k1Fb7nHtE+ckFd8f1do71Ze2yh2Hc6dxpUL/cxWrozu3SdONW/75l6HGqP4+qW0EN+3kImC6Y/0n5T3XkJjgyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SHagyM1M; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-46e6ba26c50so2885125e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 03:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759399797; x=1760004597; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JRa7xRBz2y8KpSGnCFzpBD76XugU/yocJFlrtOCXiPE=;
        b=SHagyM1M/JqOExcGbJHGHNzMmcQz+05OMNj1E600FNxTtXNCU3PY2eisyl9+KrvRRh
         Y7mNMiahOi6JPqhqegz8oh1u5z9cZsLlJno3Y8w0oA9SJyj2ENtGuGyVeaz8qCmZ7tt1
         G5Il2irKv6NYJMjJ/iyHJz7ev8hGD0ZvIa0brwV3sk5j5WL5yBgQ7Z1bEwbNHvELI8mK
         XuS1gayC9EmOBj7BjZ53sYU0lrgCCm+GACvUFlQi2wLCP97gsJLVKrVfDy47xWO1IMl6
         WfYYA1A1KX1KS856JIWoiodt7iFrF4H3T64NABf3TC8rnib1I7yP5TnMSyeclstmJ6zV
         Ym7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759399797; x=1760004597;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JRa7xRBz2y8KpSGnCFzpBD76XugU/yocJFlrtOCXiPE=;
        b=tKdt3bPGbALhEFeAPb/Uqb+PGe/N3jnVcaRuy5KuXjrm05lWQ7DCWwHaGP7w7AIOLg
         O3vJGI9INP6nNTvvAgm/ObDb8kelLV1KlVMXik5cS21DDYsdeSr/Vt6fMn43SjyX5zPE
         iKuCgKTVkVChXXr67mNiQZE/VtzzWBcJ3ZaSF3lxEkQeeLFRqDXmn5cNVKZuBwCxsZpX
         kCx0sNOPgjnRUZaUgILJUoGHA8RO3c2rx2ZuX4Qv7HGIRBudyfFP2gjVeqfDCAnAYGZM
         cNZEppLqx6aUWvcP4WooacnZrB9mj2/u5XhLeg6qxYHDZfZVHza+8Nyqcn+VEVFkPJ9B
         nJPg==
X-Forwarded-Encrypted: i=1; AJvYcCWURnLM2hgrtkwQimo5Y+MHDTX7qKNPsVcVxKyKAbmHXnH8IZrV8XCGaZ/cCnYL6mIVGlixzl7iNRnpw2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhWTPj+Z+sViTkrS8+njEq7AGKXsKzLqp4+jsk26wZNmrpTk8t
	3shaORXUHOPDNv5CJNi8EQbKkxzPcu9UU9SL1NxPYJ27+hoeV4mgT8/8Hg4JT09fACw=
X-Gm-Gg: ASbGnct2CmdDhOgsKT58PSNXeJiGLDiE1Z74HaXl1UnvDaCKfITIA/E9oeY8XF5s8Y+
	oMUNMVWGduGCLQjS45mzi78PhGpq43/6awcbcLYTyKnkKZrm8ZaZQfIC+VP09DE54pUbj+RdFpA
	dUXanjycyBWgf8KxytksHvAICdsrTAJr4+sbQoe1lQwCESgP7U/AQCHMurxakIKMFkJsGc1soYt
	EuVUH7ljIpZQ0prR99U2hPh/6QrnhqWBGltvZemV/DZSW8lzYT2nA/xiVJsG6AkPN8evYqTqovT
	EtIORSDCRCs7UY7Mf7xnnb68MJdXDRRdYmy0ayJ/Zm7VEqJleozvHiU4MeBDtnV2CvqX51hJBuc
	Vg/rYw7XH++xdWZMjshULZ7pTPoBF6EC8u+0shx0RtT5dyDvgvH5a/JHLq8Hj
X-Google-Smtp-Source: AGHT+IG4GBS3+OrAu9Dh83TZttIqZGo8QRmCmJgUPzocrKlVSt2VDpydcJ4X+uH+k7EMuUUvSzSyQg==
X-Received: by 2002:a05:6000:4382:b0:3ea:c893:95a7 with SMTP id ffacd0b85a97d-4255780b1b8mr4828795f8f.31.1759399796900;
        Thu, 02 Oct 2025 03:09:56 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8ab960sm3017289f8f.13.2025.10.02.03.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 03:09:56 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 02 Oct 2025 11:09:30 +0100
Subject: [PATCH v3 2/5] coresight: Repack struct etmv4_drvdata
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251002-james-cs-syncfreq-v3-2-fe5df2bf91d1@linaro.org>
References: <20251002-james-cs-syncfreq-v3-0-fe5df2bf91d1@linaro.org>
In-Reply-To: <20251002-james-cs-syncfreq-v3-0-fe5df2bf91d1@linaro.org>
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

Reviewed-by: Leo Yan <leo.yan@arm.com>
Reviewed-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm4x.h | 39 ++++++++++++++-------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index eda3a6d2e8e2..813e7208ad17 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -1019,29 +1019,30 @@ struct etmv4_drvdata {
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


