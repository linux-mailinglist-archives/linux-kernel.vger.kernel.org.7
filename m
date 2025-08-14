Return-Path: <linux-kernel+bounces-768626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FB0B2635E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27E421CC50DF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C882FC898;
	Thu, 14 Aug 2025 10:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OmtX9LTj"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F852F83BA
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 10:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755168686; cv=none; b=rFdo8viHhRwAr6kvMumOeQ7OaaoYgI4553nSQjRGuRLDSKi1NE6xL0rCEf49vPutEHu+u9tXIbUvwFXs7wWQAN1Vho4fBxNWJSyui3nldsl/YmQH7lE3I7noQKCPVWHXfmTY4OvZfhC3zoJQt2URUWX35vNReO6inrP8xLWbu9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755168686; c=relaxed/simple;
	bh=Ghk9v8X6ZI95UzDotAn+mX7JIMr1ajnOOt+YAT0AZyc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bwoNJzpsYgyBMGXkjLYZXQ7hzKO45DtxNFJOkU3j4aMDb2hOW/Gr2nfCk7DXpa0OBIL5UKlfnVJs2O2GwkMutfMAyH7vIPIupbzNgDgJIwquFHYaNE9jH8eu4SIIHf4yaYG/jaz4Fg7jXCwzXZkPqpvUSl5lThlWcHOfQ5OEgSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OmtX9LTj; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45a1ac7c066so5075685e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 03:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755168682; x=1755773482; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KdeJ4JSRd2ijrq8xQhXxaRgP6MLKlDNmproFaVga4Ac=;
        b=OmtX9LTjaAzR9ffv9I0XS1DaypOTDqAeBJNizUCg/DwkKSlxy9MAEfc4dfTPbZedxN
         qela5LeGTD9jubgN1tWmqQAd4XmFvHO6T1KKXZdjXy5IDi7Kh2cypGFitnVxhwyURn/Y
         3BkDHk8M5CRexplgBklaeeiElb45lIoB0Ddftdgh6I0FvXWcqHBQLZO1+pYFFlr6S2Nd
         4JhaMcmEuYBUEsYDqKCNt1D3iz5sTzUVwHEu/hlyzbXX3p7SdAVRmmUZa5VN7KH/OY/b
         KacQlQ1UPf+eBoyLDwUPanxe839rYxn4Y4dEOV7ATX3V+JtqR88wWCHbD2GtVXAh6lIS
         5/+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755168682; x=1755773482;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KdeJ4JSRd2ijrq8xQhXxaRgP6MLKlDNmproFaVga4Ac=;
        b=mSStsMX57FHkg5epQksKLZ5gVlG7HSW0eYoWQDypzsIlDiucp1/2l9o0LAUG/sD8uK
         notQDAeJXo3Ys9Igdy9XHBU7R8YzPZkZ8wr6ymRKdvr8KY4F2ZtgcCT+p6vuFzmEtpkF
         Q+C8Og7cW6LhmVZlnpTWHj+mRwiWB9T+KW9UTJxjoF6Cb4bxtlBBKPCj6QeefCizWc0G
         OB1udT88JOTvaxeESdN/XBr31c/vAomx4FPs5efZfcDy3d2JDGYx4ECZLvaigCuYkeFM
         uv6W9rEToYCNl997e53ll5JFS7DtY3/cRU3aA9zXKj5/YCCvDc+VFFkN0gc6gdirSRfz
         TxSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQiag6YqZ5995J/TnnYoc7k1LW+DXCP/b03gYjxgaYmZ6OOjQXGCX5aVuDZdBExiWdkzCpJaLttg3aXtE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlYrryVqcoxGqMf/cvXWTrT9dZ/kAVeviVvhjLDNs0qOGLJ6iS
	lBcrnoKEkm17+w9pSxO4UCyfMr7T0Lp3rza8eU2uqnIA4ZACXGKP+DrLE/0zx0qt7Bg=
X-Gm-Gg: ASbGncuvbOxAClcsWNIzIOf1f3vc7NyNnUYE7st0FtLBBndG6aiAag28mXE8WaQbV3e
	WZcjNolXK9QR34d0YwuCJj+tV4TEJpjH1fVF2J6bRel3jJ66cp7fjhJ6we2BZYCKnNAqE/earu1
	6dhsV72ODy1mjc6G1JO9SjWpqlWLzT2hSwdw8Rs/arL21Dedpb4r+2xkZBi0Oa/St5cxDQZhzH0
	Whi7qepGEYyxFdLZUXTpSxP5w/U4lRLcf0Bf15+nVy8WEu3xfODwA+GeBMyC+3YDrKs5VkspZlB
	rYpYIN+yPC9GK06WnhnRDT5kmlWSGPcy0WX8j3QFCkX3Z/Eochwl/1Z+Eib6J5VmlCzRpdiIQxc
	4tDzXoAptK7pRmA4tLVAbNiqELqpskTA=
X-Google-Smtp-Source: AGHT+IGiw9zB/I+LYQU9OZmJehztvJAaw6EEWckqoahlG6F9UH7uBsO+Dc2b7nrazKkmaZlJ83qC6Q==
X-Received: by 2002:a05:600c:8b05:b0:459:eeee:2759 with SMTP id 5b1f17b1804b1-45a1b6c7e20mr20628185e9.14.1755168681929;
        Thu, 14 Aug 2025 03:51:21 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1b226eecsm14228345e9.1.2025.08.14.03.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 03:51:21 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 14 Aug 2025 11:49:53 +0100
Subject: [PATCH v2 2/6] coresight: Fix holes in struct etmv4_config
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-james-cs-syncfreq-v2-2-c76fcb87696d@linaro.org>
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


