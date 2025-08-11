Return-Path: <linux-kernel+bounces-762229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5760B203C7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 870B2423C7F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDEB1D54FE;
	Mon, 11 Aug 2025 09:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K1SdOJXA"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7884B21ABA8
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 09:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754904764; cv=none; b=p0B5U1CYRVuGIS7EkfvvhB0tiF4b9a4ZbY11iZL//Lf4VgBhu6SOmkcoZ4gHSu/yImHpu+d1fQ0qRDfj5vYJ2jTN+yzkaAD4OFVc+qskZVFhb/dkaXPG9sqYA3n38i4lNy6xgNV3vYkCkVC5UcLwxAj2wWIXX1DblZ8W+Rb0xPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754904764; c=relaxed/simple;
	bh=4aYl0ZlZfO9PKf1O2NFxApvTlFmO+ImWPT/xpvy6zJ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nvwU6A1IDwS1PY724SNtY1gPehoC+eBu8BuwXfQsYX2s3KBny2f2luWd3O/Bham/F6HxueJfShnHQk5d1kYptZsaK2GDfUtsVID5EjZ7ctHUAkr8yLHZIe/2r2OlOCcSmFwxMR6zIPs2RMS6f1lE3vJdvE06M3ehnCJtcSqGQnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K1SdOJXA; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-459e72abdd2so23744725e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 02:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754904761; x=1755509561; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=flPVDp6drpFtCapB44BZdn+149SFai2CStzeZGBA02s=;
        b=K1SdOJXAHZNRwKl4MCArq+IXqJgyKu0plDhI96JvCiAOfwwAlfCu3caJB7lTqE3zjS
         HYWqtaArVYTADDEf9KZhuaJuxmXGpN+RT9mSvxbwA1yC07ERoXs06yeyt+8n5VdSnbx2
         BzBHja4Dp/qyMFFeRuL7DzwkeHREoiSQycr5/YM+Ul5DeJw9R/y9vyglWoTzyOgsSdWH
         HbW/HdPlBVW6jftdYFTUFtki9QXt4LWRZO1LGvPPT+N5pK32c0x5vH4cArCEG1jKl9KD
         DeV/vJVDGN1EypiLfHEAbgH3AunfraScibyqV5jZMhC0wOEBbTM3F5iagHTSABiONK5p
         6xGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754904761; x=1755509561;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=flPVDp6drpFtCapB44BZdn+149SFai2CStzeZGBA02s=;
        b=TcGCFLmLGDYTTLo4IwlqMir9NqOe38jxQeuM6r4sbAAm86ZtmMPMM+UvNwFsQEATtM
         iw9HNlw9663N3LdUis50F/I9Spd8w5Sd4SHM7l8gFBxTBxqzkM1XewzP57F/qewVh0W7
         LF94hSoN1u5SQdoR16g/50T04iOLX01FJET3gLtS47qaAeO0c8N7ZOJWYdh3C97B7FAz
         ioQDKIoUAbWDCtggQCI1c8Jr87LT+t+LWX4/wJsP6rupJylLYSxJm5cn70dOd/3yBRod
         dmRx+Q44LCveic9CAQFwNStbUXgy1O6dLqCl8vx1gmqKnurvqcLXZJ6xRe93VdSJJuyj
         72lw==
X-Forwarded-Encrypted: i=1; AJvYcCW2P0X0EERU6sT6wUDSilrlqo+SxV2M+udywmrTMg48y9E/feZ4kfEf0QWuchh8qHF22A5AHT3TGVViEzA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4LmfKIKdNHLi7tCPx3BYfJosULR51E/w6QOH4Y0Z2y4QDvCi5
	J3f7p+pa9KAmNParB/FWVZ8/xTufHwOobAi+hKp0RjdYfp84ZIqda2pu8sI/Y3oefyhQIamY75b
	BU2dmOJ4=
X-Gm-Gg: ASbGncurPVOa5LSMX1O9utJREN0c5moTl6+dpIA9uJS8DoLfp1Hd2iLTkDL7DbXHuM1
	7xanUZN6JcEiR67HCJJSE6cFyPBlJktWIl6J4VRI3wAst3NTwXS466mR15sWt2ufJsBcCrK9Pc8
	4TJr++1sn5CtA9IXBSNnqPEHY8jeItgDOUuN7W5wHqkZLaDEM3iD3041DmSy13T/enrwQQP5FtH
	PcOpphmmDsJlvgQQtRK8Kg0iIzhc0ZEj1cZ50+a+rBvXwVomtgDsiH6fGkURhHxUr4GHdGRx4K1
	HzvZiIiflxW7JrVduLBRHarSFfqD68Hi33sS4ruTthqsSy5zRzyZxHA0GAg0uBIzxFvS1oNasN2
	oTo0O9/q4rP0MtOH6oCqxQhFwnOgVOa0=
X-Google-Smtp-Source: AGHT+IEnPjhNqasqLPJXNXfyUk55gExFDeENYeLrLoOeeRhVHgumgF4nMbyLg4qCMWphC66ZYVvMpQ==
X-Received: by 2002:a05:600c:444d:b0:43c:fe5e:f040 with SMTP id 5b1f17b1804b1-459f4faf68cmr95076395e9.23.1754904760755;
        Mon, 11 Aug 2025 02:32:40 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c45346asm39904799f8f.39.2025.08.11.02.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 02:32:40 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Mon, 11 Aug 2025 10:32:06 +0100
Subject: [PATCH 1/6] coresight: Change syncfreq to be a u8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-james-cs-syncfreq-v1-1-b001cd6e3404@linaro.org>
References: <20250811-james-cs-syncfreq-v1-0-b001cd6e3404@linaro.org>
In-Reply-To: <20250811-james-cs-syncfreq-v1-0-b001cd6e3404@linaro.org>
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


