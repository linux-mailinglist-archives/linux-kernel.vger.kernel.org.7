Return-Path: <linux-kernel+bounces-840107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D647BB38ED
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 12:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D402189FCF0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 10:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1093081A6;
	Thu,  2 Oct 2025 10:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wX+f9wjT"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933EA3081D3
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 10:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759399799; cv=none; b=d3tljmi83mFogxCgS480++Euknzcs/xrX/srF1DngwLpMT0RM4JPQa/j79amoz7q1+BRvTNGL2OncYGjbSakXWm1ud/2jwIcGUbDO6j4rVmNIjKOP7n1LbxfwtDPikCNthekmO2Ld+bx83oZRQxjurX1zGevR1tRWiUzJzfcs3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759399799; c=relaxed/simple;
	bh=sRI+ID+m2Lx9QDVOIbsgrLRcAb5ulEd5vxdqy4VfGDA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=urrcev2P6H0jEU6dzX0gNU0YbWjXWUzKjPf6xXYtzc9YRcL7TxSAoEF5YfhPDL2BusoHC8o9IccABUQllRv8G07IBn1Fa966tf7Fc4BepfOjDXqAoips+rD/unAsWfwxCd1uaET3j4Wkbk8hL9h4ZSNpGozO5cXkQp6298PPOZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wX+f9wjT; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-421851bcb25so435390f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 03:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759399796; x=1760004596; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fNCXlVNyxqLTWGPAd727pHruXWdWdx1GVnhxX/js/0A=;
        b=wX+f9wjTw2XKqGfYjMw4q3ITYy+1PcL9MxZouUAtPWj57tk44LeNFnawYzI6OdX1eA
         jBCkgWZFoPI/CmhMelDOd06nrOVVRNIR0UNf3x6h0ZoXAnHpMNSZjJEfL1fYdDlOCXej
         MqtUYB/eAOfRxYJHpo9RmyrMpOPaVeWCLy6Tr9IPDlSpVKM8m9k24jDe5wSPB4hE8d8b
         Y2yLTYX0qDK8Jo7G0o0giouBGbSdk25ipGPpdDf5WOg1itU/gQ6DbIP4vShbv59BoE3L
         mIu/4/RqzlA+2DmeXyh26ItuwaMlLyZDFbyySycdT7gbgBvLmJXBWy1kei1jOKy1UQPg
         TdHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759399796; x=1760004596;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fNCXlVNyxqLTWGPAd727pHruXWdWdx1GVnhxX/js/0A=;
        b=YZm7XAlKKnZZ5te9Rh8+ZaOeRBDR6Hv4vs9nPsZfSJFBWKPd0S3ATT+2bXt1kqknyn
         bR8qcAWC+7NN/mSMWGh3xHfEUY/Qv+K5cFdsMIVTVe1bC95KOP2dPRAi55e2RSoVUyhe
         v5y/WmUSTEQJl7b/4Ow1e0pIVSfZHiKY1mmciWCrNLUi9eLxZxcnJWoRusOkiDivqxSF
         M+rijx5Isokt86u5PRiPZxF1XKtup72NiQDwoB/lKgggIyFKk1rHxKC/omHdsA/R4yhr
         V1RBvPs3XyFLsRKZVtl5OYvfr23Zbsq/ZwOqaA9lXPHOAdIAllFEHpD4rFN6QlhN6dU7
         MkoA==
X-Forwarded-Encrypted: i=1; AJvYcCX+DXzCgAfgoljaz7PDsLEp4pvS/oZ6stvHPTeaQsCiVzl8Rh5a+hkU3wNR4f1K9vvuLXk+p3FeogeRFcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9kbe4bwfd7pJbvmVmpDcUiaI5cI0iHD/kIS18ir4Yic6JZ3PB
	fhVULIxIfryk/5v4rRQhRwiD3mxotys0wETcaBbHFDk0IOH0KjeZoQWxhrXvOy2qAT4=
X-Gm-Gg: ASbGnctW+RMh86lJ1jm5HrLXp6F0t5oRM8jClAia+npjRsHvDY5zyE+xGWW7uW1zVRv
	u4RvIW35gpajGOBiUyY2poxL4qttBN5nDUtRWOzWp20vszkJF/XdXRT6K49tT2JgVUqePUICO3j
	YLU4Uh/jNwPrly9EAxRK5ON7SXCfCD1Cn/fRnG9A1Zg7Mi9FNR+Q/wq3diskdoLR3x/fAx6JG37
	E0B5yM/+KFSA5NJjWLUcCmt1XMT9ufMLCDEwDDZZpKy88YULu+xywzBrefZE8/2562NxWIesZwk
	lRwJV77P3N+/4L4EgjaVol6jesMYkf3cwtUoK3QrZkbEs753v2lrlk6kCWE167SCvSiyHwWqIhx
	H0I47mVw0/bQecSYiYq3+4iRDYYgpnO0icD2julo6OpNJC47yNAlKKLtYVGtZ
X-Google-Smtp-Source: AGHT+IH3VmgaujpFJUxnfsTdoqXNgTblqfU76kgYqYrSDq7oNx0Tfc38ceRWlaEZ0lvNiD8i/BA2zQ==
X-Received: by 2002:a5d:5d13:0:b0:3f3:c137:680e with SMTP id ffacd0b85a97d-42557a15a5bmr4399609f8f.43.1759399795840;
        Thu, 02 Oct 2025 03:09:55 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8ab960sm3017289f8f.13.2025.10.02.03.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 03:09:55 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 02 Oct 2025 11:09:29 +0100
Subject: [PATCH v3 1/5] coresight: Change syncfreq to be a u8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251002-james-cs-syncfreq-v3-1-fe5df2bf91d1@linaro.org>
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

TRCSYNCPR.PERIOD is the only functional part of TRCSYNCPR and it only
has 5 valid bits so it can be stored in a u8.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm4x.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index 13ec9ecef46f..eda3a6d2e8e2 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -825,7 +825,6 @@ struct etmv4_config {
 	u32				eventctrl1;
 	u32				stall_ctrl;
 	u32				ts_ctrl;
-	u32				syncfreq;
 	u32				ccctlr;
 	u32				bb_ctrl;
 	u32				vinst_ctrl;
@@ -833,6 +832,7 @@ struct etmv4_config {
 	u32				vissctlr;
 	u32				vipcssctlr;
 	u8				seq_idx;
+	u8				syncfreq;
 	u32				seq_ctrl[ETM_MAX_SEQ_STATES];
 	u32				seq_rst;
 	u32				seq_state;

-- 
2.34.1


