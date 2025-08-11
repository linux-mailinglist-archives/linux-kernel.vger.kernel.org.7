Return-Path: <linux-kernel+bounces-762230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCB7B203CA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DFE042430B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4912DE6FF;
	Mon, 11 Aug 2025 09:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a5m2uTZV"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6ED1DED4C
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 09:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754904765; cv=none; b=JH27GM7zof68fvgJJCvzKgQw+LzGv/MTndZrBWSL6YsOlBTbueVnBcYjH4L2Q28g7ymdVFFqyhH3pQAt72JPEOJhOCVCBnFpaUL9booykk5u+BzjrEq9F60twquJ24s88HrdJoxVCfikFdaErFd6pvgFGBJ/iJpNOMTwwuP8cx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754904765; c=relaxed/simple;
	bh=Ghk9v8X6ZI95UzDotAn+mX7JIMr1ajnOOt+YAT0AZyc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kgsHDba8Yq9SYPFaXceHXoi68Tl2AR7/Qoj5UVxikTqHuIWZ74bzyBrZwG+CPH6MCeqpIAMl0cf73CZPxMp5zFgWPX423Q4pv3oCcQtbKiRJMJmdwi1n5PVEizgei/PGPpbGMybbN5Oqzy1ShJrHm34z/K6uRAbGlwqolV0mc8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a5m2uTZV; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3b7886bee77so3122459f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 02:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754904762; x=1755509562; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KdeJ4JSRd2ijrq8xQhXxaRgP6MLKlDNmproFaVga4Ac=;
        b=a5m2uTZVGIwKTuVt2sU1f5NGG8cD24Mr/QP9+AR6d/Z7XSzlSFMtVYphcXV18rC9pM
         RjFhWjl3Wq5Yqa8ooxYJofAEg228Oy2Zz4Dkjp9+YF0Ic5rhwOvYxQa129GekhbfsNpD
         mJPpE2a15zFvtBRlx0OlEG5O9bM0zosPoRcR4HOIUR4KyxvI9VZAQGD2eQJ3kl3NM6Hw
         hnqxkiSWTtQcqEf7ys9HkcbYKaJ1NjQOyWB2CNdycs8rD1yTsUhtecwVtFsMRZzrhCRr
         8/akQpJeOJrODWaFH6jFDYYy6pOKlxEN8HIJFUrcbNGW2fEVCfjfqwrgxXOAuYefbTFp
         5pyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754904762; x=1755509562;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KdeJ4JSRd2ijrq8xQhXxaRgP6MLKlDNmproFaVga4Ac=;
        b=hYFqN4yDw/5MXOR4Zp70bUGL76vjShtF+Dr9pCIK845W92EZUQ2YkuMX28UPe6450n
         fZMOuknpPXrxu+CHgqAMtjpVMJjihHWXtcPePRL8VKb5pIgzPnI+uih+1ry/OvemTFOd
         Hd1EfcW7viu1PND8FkkLELJHImMbUp9G2lUC/dDaLS4BbT69uNOV/SAJI3JdSc1WaVPV
         tvoZ5WjaV1EtTinclBJKc0A3xnyKus1xjwG77FxPmpIPHDxMjesBwdy/yknoO8l/yfCE
         9XGWo9HGYgGDKj0TAUUJUSyIyp6pdEFWIJ7n/8DFw71wuJdB3Jh/AHnwicUU4INwJP+B
         30/g==
X-Forwarded-Encrypted: i=1; AJvYcCU/adaScMFcoZ9HtopFL98EwQcdPDF7Ya6ZtF69+OXxv5gs+4joJ0oGgTylOvmRDA7+5a4qeCLNYH0cHtU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqq8mXyUzM1lx9By23k1iOzebfPuvdU+n6gLk0kq7Obl4Mdn0b
	NjALT98xjbSm7Kgf/PK6ptFEY9PVpP2Pi8Wq2jgzVVGG+go6CoQ+JOb258ALZnTcpmZ+IHjgz/u
	NwkjCduw=
X-Gm-Gg: ASbGncvJG2MWx+4LjrSOfiIvHfwP+5SnONtnDc9AYw5z+8sV+X8kJqYWlzR7lIZwQka
	XQkyVqz3kboOGW0WAu2aGNk9/ieukjPIPLD6QHPkyUIpTBjTzjHFZiQOTziVpT45+7k0RqCS/qd
	D1kLsOZRF9y8lJqq9O2a2DP5s9xxx1AH70QXqyx/jHAJA4o2qMi9k2MV1WLHc5M7rocO7uETlnR
	2k2jrMIXbwgughqZcdyvoOFwAg8D1Hfb28lhDDZQYnVdyQmSZQEWpKiXq27/VeBAu9JwWFZzIkn
	K2u+ySH4reMnw3naG/eRu1uB51LksFr5XPtYBwXD471y5XBh99LvefXkKrKQA2Ny+fvGo+iDt8f
	R2wK5xwL5Bu+/VTvYWe73fGTqCrzAYck=
X-Google-Smtp-Source: AGHT+IF4rGypTA6LAa8xSMn4qKFuOrcs8J0oYr3jFggkDuO4RAE4D4QxeRDmMlz2n46JWmeJ8gWF6w==
X-Received: by 2002:a05:6000:290a:b0:3b7:9c79:3293 with SMTP id ffacd0b85a97d-3b900b8bf31mr8716728f8f.58.1754904761700;
        Mon, 11 Aug 2025 02:32:41 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c45346asm39904799f8f.39.2025.08.11.02.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 02:32:41 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Mon, 11 Aug 2025 10:32:07 +0100
Subject: [PATCH 2/6] coresight: Fix holes in struct etmv4_config
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-james-cs-syncfreq-v1-2-b001cd6e3404@linaro.org>
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

Lots of u8s are mixed with u64s and u32s so repack it to save a bit
of space because there's one of these for each ETM.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm4x.h | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index 746627476bd3..a355a1e9606d 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -832,28 +832,33 @@ struct etmv4_config {
 	u32				vipcssctlr;
 	u8				seq_idx;
 	u8				syncfreq;
+	u8				cntr_idx;
+	u8				res_idx;
+	u8				ss_idx;
+	u8				addr_idx;
+	u8				addr_type[ETM_MAX_SINGLE_ADDR_CMP];
+	u8				ctxid_idx;
+	u8				vmid_idx;
 	u32				seq_ctrl[ETM_MAX_SEQ_STATES];
 	u32				seq_rst;
 	u32				seq_state;
-	u8				cntr_idx;
+
 	u32				cntrldvr[ETMv4_MAX_CNTR];
 	u32				cntr_ctrl[ETMv4_MAX_CNTR];
 	u32				cntr_val[ETMv4_MAX_CNTR];
-	u8				res_idx;
+
 	u32				res_ctrl[ETM_MAX_RES_SEL];
-	u8				ss_idx;
+
 	u32				ss_ctrl[ETM_MAX_SS_CMP];
 	u32				ss_status[ETM_MAX_SS_CMP];
 	u32				ss_pe_cmp[ETM_MAX_SS_CMP];
-	u8				addr_idx;
+
 	u64				addr_val[ETM_MAX_SINGLE_ADDR_CMP];
 	u64				addr_acc[ETM_MAX_SINGLE_ADDR_CMP];
-	u8				addr_type[ETM_MAX_SINGLE_ADDR_CMP];
-	u8				ctxid_idx;
+
 	u64				ctxid_pid[ETMv4_MAX_CTXID_CMP];
 	u32				ctxid_mask0;
 	u32				ctxid_mask1;
-	u8				vmid_idx;
 	u64				vmid_val[ETM_MAX_VMID_CMP];
 	u32				vmid_mask0;
 	u32				vmid_mask1;

-- 
2.34.1


