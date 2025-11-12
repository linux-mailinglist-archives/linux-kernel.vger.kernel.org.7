Return-Path: <linux-kernel+bounces-897173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B107FC52372
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F4653B453F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79E7315D2D;
	Wed, 12 Nov 2025 12:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOo9g99c"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D482749C7
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 12:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762948990; cv=none; b=l1lS+Og7bM1zv4JFCEjKfIeVpKiq5x4DdwT8u/+zcpo17nyVs6mYOa4718FzZcqE7cR1ddWg6vkh37EvrFiYdNqp1IAHjzR+x/SoKfVa7tTWHmTY9uvLkNUc86uk3/7RuwNoG7nXzNKREiPZz51/DuwHkVpwtIrkP7jey3dviws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762948990; c=relaxed/simple;
	bh=dmywMDxYR3I/zwmn8fb6UkL+Z5wEfHZ3kih2ppTvlI8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OcBlxrM6iumFgQXrWWFgPnpkO89c92f7GPgxrdgMCM5zYJFSpRbOK7/GkUzRdPv1BUi+OFJTJRWs1HasRxmA6YpBXshMg4FNRzm7nldoDtZ+7LkSrIVmZywsHMkhnH2OVrrqvjjuUYv94/pzidjraJm1EWwfRtgXjJzE7p4naZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WOo9g99c; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7ade456b6abso636207b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 04:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762948988; x=1763553788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=otVWZ64buPz8pDhvcNsi4ASjJ/PcM+ziHnstNNH1WqQ=;
        b=WOo9g99cEqZ+pHEMAqPPipeiCL84lfSDjNbXn0eqRMc7JMLZk5X/2zq1NSt3xke2k6
         cvQOKQK7sy0+uw6clivFQBKoP+bK8EP778bTvvowhPPQnc2oyQ8pM1vdHomT5f0n+nYS
         095FMQ9jniny5Wq90n9/aKz3/ZqtZiW6C2PZHip7y4nRHmrUO522s6BVx1WrVLM2vqTq
         G4axJieNwSCeyTNG84aFaPosah08Q6iYvXPpRQx9nGY9jy+SXMhSEt5vzVaeNE34dV/l
         kF+5M28kalanNo5ZrzJFQRyATqTdT4MZJaQrvj4LRJcNUP57J+EHg35yGd+8nDyhVM50
         dcAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762948988; x=1763553788;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=otVWZ64buPz8pDhvcNsi4ASjJ/PcM+ziHnstNNH1WqQ=;
        b=EnmrB0ljtlt3JZ0rWTFLx7kI3KxQbZO/3wfjtaHXLBEy3vFJXQpzLG/TF35Z80j5jK
         Da89u8A5PxXR9+c5m4InF/DJWMwGAaJWriRpRebqCZJzv2LKKWYzxuFNvpYgpr9kR+NI
         3UV0L9btGZCS3WdJvpj2tZrrJ+7wtcj+Y7U94lYoojuvEfuria9XQ2wb+Z1y1hfgf6sU
         PT03e3JUtBs4W3ixN2Uo+aY7j8cinUxpKfpswzLHI5YU6ojVsNLRL7FJ8LBVzhyM/JBt
         7yejTwORWweZzYtQ1FWfrB7j5EbpB6wdKx0kkPrA6JIip9+MbaZRHVw36b6CKKfSd+QI
         NIxg==
X-Forwarded-Encrypted: i=1; AJvYcCWOtCc+9KFEeAZF/cqKs8AtFVpdxTwREcehrXB+oAmhjBixu+BukOfzaOSSLMSbr/sQtXab6vX9J/IQ13s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgdzO0SmgBGfV1bDe9JAPfCPk7cAjM9pyKyIp/A0YSELjmTB6R
	FoUbE2NYqsm+KtC1v8uuqX6Uepjs6KvqT18JF8oZg62o2TpdEoGeyE4o
X-Gm-Gg: ASbGnctiHBqzL6uvjysR39o4iAKiYn+09EPdJrX2J55vtHYhiQ56MAWEdnrjBLprMtL
	2NkJqcUyr+OZrxZNJsziqDBEO/ul2/6cuUj5kr6WkdpUGO3YIn+DmO5h1puF71nOkHYaIfWeiIG
	S4RQRH/vDE/pdmdL2P+P9unETcDjehiNRPyVRpdHc+PJ8qREFeFY/TP1j64onZCHh2nuik6aVs8
	Y0wS2tTMNXNF2w7gh32RhtgL/Y0/zMtpK1slPlWwjkBAROofC1TFNRVmurwC7fx7yo0hfqQVlPd
	145neeCQG7wiASQS3hA7nbzLL7yPPqib74f5ryQmt9GTlrgum0Rg+mT+/KclgCWsaoXoS1FaKUQ
	BbSS9zH0j8Ii/hoSJtaFQs7uApwudEM2lXdIXSQO/F65xW8pvb3ULdOXq5NcSM16RTg==
X-Google-Smtp-Source: AGHT+IF4hw2zR9LkezHiZj+TQdW5+kwzMar8ofxTlchBLpk94hK/dhLo2AjVNSCvpazqsVsABOfrRA==
X-Received: by 2002:a05:6a00:4b4e:b0:781:157b:3d2e with SMTP id d2e1a72fcca58-7b7a4afa3afmr2857131b3a.21.1762948988116;
        Wed, 12 Nov 2025 04:03:08 -0800 (PST)
Received: from oslab.. ([2402:f000:4:1006:809:ffff:fffe:18ea])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0cc17a688sm18738044b3a.40.2025.11.12.04.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 04:03:07 -0800 (PST)
From: Tuo Li <islituo@gmail.com>
To: krzysztof.czurylo@intel.com,
	tatyana.e.nikolova@intel.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tuo Li <islituo@gmail.com>
Subject: [PATCH] RDMA/irdma: Remove redundant NULL check of udata in irdma_create_user_ah()
Date: Wed, 12 Nov 2025 20:02:53 +0800
Message-ID: <20251112120253.68945-1-islituo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The variable udata cannot be NULL because irdma_create_user_ah() always
receives it. Therefore, the if() check can be safely removed.

Thank Leon Romanovsky for helpful advice.

Signed-off-by: Tuo Li <islituo@gmail.com>
---
 drivers/infiniband/hw/irdma/verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index c883c9ea5a83..a9ae5a38d03d 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -5204,7 +5204,7 @@ static int irdma_create_user_ah(struct ib_ah *ibah,
 	struct irdma_ah *parent_ah;
 	int err;
 
-	if (udata && udata->outlen < IRDMA_CREATE_AH_MIN_RESP_LEN)
+	if (udata->outlen < IRDMA_CREATE_AH_MIN_RESP_LEN)
 		return -EINVAL;
 
 	err = irdma_setup_ah(ibah, attr);
-- 
2.43.0


