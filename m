Return-Path: <linux-kernel+bounces-768625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 599D4B26350
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2F5954E55D4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B04D2FA0F7;
	Thu, 14 Aug 2025 10:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H0ADKPDA"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EA5318148
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 10:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755168684; cv=none; b=N04CPhoS4FLEVV6PAF/AdAABWYw6eJvC3NRw82OlSMAWrXrqRTqySvkyuAuVOG1sExmZbnyqS3+2IE6tKP0AjeGeC76XdUh+jcoc9O5mx3eZdJXK/PQ/aJZaKBi/nsztTXLr9a+ibXTOGsLESZqGbqQ09na63XXm/h8lW/dejLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755168684; c=relaxed/simple;
	bh=4aYl0ZlZfO9PKf1O2NFxApvTlFmO+ImWPT/xpvy6zJ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gxlqOGnW98uxf5G6wJGPst6ErBMKLfp9cjYlDEPdJUuHfIWnGXZ6ptXTYRjzw5kbzzsTsJOChnYus05i+qt1GzzMm4tQ6m0to105bnXn5k8cwLx2wetbCL+EirxPmwVVd1Sc9T4P13e5Rj9nJgmubOB4I1Oz5VotjkF4EgY0Q6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H0ADKPDA; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45a1b05ac1eso3464445e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 03:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755168681; x=1755773481; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=flPVDp6drpFtCapB44BZdn+149SFai2CStzeZGBA02s=;
        b=H0ADKPDAsxo6vhr5Goo7l2G3il5EtV9nvm6W2j0YYJm4GbHw01A5s2MdEoKabtL2ik
         7MF0IYaJ7Bwrtt/hbWfwSknkWcCoRtU0nk7rgjItCFTSY5rb+44+d0eFJhsZNQK93Vx1
         TQ6SEXgz5XeURscGQ+IYljvLS8AD4+IBNk3Gkv6ebJBvl+VOFgk9nwBhlqsfJLGvOQOL
         Ffa3o0K9Hbv5xZti2KIY+idZlhajew8t9NdmOh347vo7ylyWNGNDEVR8DXdoa8B/NBN5
         G4bHkjTq+J3NW6vj7dlVR27nv9cXl6axM3Jl2DqyR0x0Aqf1LBQIrO7fFSD4gXRnGpPJ
         BnGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755168681; x=1755773481;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=flPVDp6drpFtCapB44BZdn+149SFai2CStzeZGBA02s=;
        b=ERBTfUKHZm6jB/19hpwLAZCjzsAWcrDJZ5MZy02kqemhFxxZzwDCiB3xZ8m2UTeirz
         bp2O6A5I4MG6db+/6spiIxL71DR+IxSd9Tf0hrrwiIEB7MYZ08VHObE8p8kYY/ExJY23
         cO0bx5ELnMtKGgr2iP86MK21J3Yl2GNryd4dzVNXAnEb6cmKuufsvNkRGJuyZkRnMkt3
         TWi2PQAYT4lnNE64BNgyyCTbRuV4Cs+b8QKKEylsBxLA62sStGrio0UKDmzvHlW/3W4v
         ur4O0ggkVK8Luv5cmp/01rMgnQ6aZToScftZ+2OPXCswXDFwafXQyFle+Up2kuy0svia
         RXXw==
X-Forwarded-Encrypted: i=1; AJvYcCURb3SG1IkOm1xqMiAh7r7fnp6Shq7oeE3prD9oNT8ToBEsmjKtszSPRU/pEZ8TNt8hqFclli+E+CUqYls=@vger.kernel.org
X-Gm-Message-State: AOJu0YynW1m4BbS7/UIhPa7btE2BCbiijOz42g9HlL9VbWOMw67yw0+C
	KdCRa8QyR3NR2kZvcYQO/2UYCcIttcOwLYrNzYFCbCsKkMmf7ji/aKjFDSwDly74Axg=
X-Gm-Gg: ASbGncv2w227n3t4kJ1hgT0VA75r3a9w25eoN6v+sw/baPhvG7FHv2s1ABA/pw1kxh0
	SN9wv+CZD1LeS5cgucSToYNKa4CjQufaVia6nvarmztkXieHIQofg5ci06E4QG5zqKdQPTMSxqO
	AmY283jmy0injymvEcHLorVsyOG352ajG6rM/lso9ekLbFQSZvjOkeOZDB2dOHOGzR4SKcR0li8
	k+vNJnpHfqEQZN/2sFJGjXOueY8bNEdWcyrdZtoxsq3tXnwGsgVt5e2TJz/vdYH0840m8tLLLgM
	HAG0N0sVydT+I0jVT5cMAI/WQSuD3GLImQ1n9dk3Pof8KshkYU251fYGcou8tjK8CnaSYk/NdZ6
	SKIMqHix5jqD17frBpnPCvDBbxggUfWA=
X-Google-Smtp-Source: AGHT+IETr1S2IB5p0qvTLAX5im7MRWeRvzS+YGEJ7c0VQq1WWHunLmPo9zoxHd949lhLeds4azm7BQ==
X-Received: by 2002:a05:600c:4ece:b0:455:f187:6203 with SMTP id 5b1f17b1804b1-45a1b654a11mr20355505e9.27.1755168680945;
        Thu, 14 Aug 2025 03:51:20 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1b226eecsm14228345e9.1.2025.08.14.03.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 03:51:20 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 14 Aug 2025 11:49:52 +0100
Subject: [PATCH v2 1/6] coresight: Change syncfreq to be a u8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-james-cs-syncfreq-v2-1-c76fcb87696d@linaro.org>
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

TRCSYNCPR.PERIOD is the only functional part of TRCSYNCPR and it only
has 5 valid bits so it can be stored in a u8.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm4x.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index ac649515054d..746627476bd3 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -824,7 +824,6 @@ struct etmv4_config {
 	u32				eventctrl1;
 	u32				stall_ctrl;
 	u32				ts_ctrl;
-	u32				syncfreq;
 	u32				ccctlr;
 	u32				bb_ctrl;
 	u32				vinst_ctrl;
@@ -832,6 +831,7 @@ struct etmv4_config {
 	u32				vissctlr;
 	u32				vipcssctlr;
 	u8				seq_idx;
+	u8				syncfreq;
 	u32				seq_ctrl[ETM_MAX_SEQ_STATES];
 	u32				seq_rst;
 	u32				seq_state;

-- 
2.34.1


