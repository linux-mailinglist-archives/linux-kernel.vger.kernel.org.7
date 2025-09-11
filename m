Return-Path: <linux-kernel+bounces-811756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04CD2B52D7E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21140A08312
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 09:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFE52EB86D;
	Thu, 11 Sep 2025 09:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j76i+kiZ"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C3F2EAB72
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 09:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757583812; cv=none; b=mdAxU47glED7HVtcadchjtmA5IpVx28wlfOq8gy68QbS1PzHZX0JqidNAhcO8tZ/YX75fEButtSj6IhtmvhKpPKsbrvZoRrm5wHeZ5cv2wQTRzJYyH3e0N/LwTnWrAK7kdI8xjKDMdA1isvjbHQhcVGiGPNMdh6MQgUjfAlvGw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757583812; c=relaxed/simple;
	bh=+1ac3GUtdyb/dGqR8+GvO4DnEY81F76aKbH4bVPkyxo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kIjC+yT+G1jG2+BMZ7RnAjPgGZ1etmecvOw2O83VYIVZbUJjVlx5MunSA/fCiWdmiq5/R5H50KvE1Kyorv0SCJ5oPdElsdErTZqkmSDt5j4T633SXE439KkJHng97a6j5I9t6KtmeA74pYkocLAd8nxs4QquNKn9FWeJ08gFYLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j76i+kiZ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45dd505ae02so705325e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 02:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757583809; x=1758188609; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WiDSDs3vgPK4naVERjozVRDiMqNnwv/gBegchhROC9Y=;
        b=j76i+kiZqzpBC1BNt1rQb88tkfU9lL4LEV+j4nvwx0dwqY/h1resxoc76rMoZLjSTr
         4+UjzIAhgrG6DhbqqUa2S81H9FwE9LiKygc1XJBqHnjMSTc7tYyuAZ73+vtjXcQ0a4I0
         mKgjGB6stbbLUeqtpfolSVAbtc5UaQk4iIYM7QJ+3XkY+cCagOz/1r6Esq1vaH+MKnwO
         nQIjmixfVJy+pDB/a6V18oN6cX5Wn+5Fq/BmPdE4QEdtuUpxpPpJLvFk4q3QtwcUY6QH
         Ys1E+lYAZBxnetraY2WBieWHtiaviM1OMUPkgIOZjG0AgHoeO/w32hWPLc7W9PQ/7DLw
         ftpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757583809; x=1758188609;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WiDSDs3vgPK4naVERjozVRDiMqNnwv/gBegchhROC9Y=;
        b=vm/vk5lcO29p6T9MFbUdlMzSQe3ebKn6wBtx+xtljvkaxjQyeupLfrYnUKU62lHtX4
         o08Z2qd1v5ZUbFzaxet4VcdYpDxG1hphu3dGJtp9/YwMGCx4ugLzWnVI19EyfNBPksQm
         JXIkfUM6w1o4PGKYpSte+JghznF06qB6Z8nULuR28DOZ3IxAaCWLBq2LUZ+/LTCbm1B3
         5gY+SgRjAQJniXKZr3hIZvnXH0hb0OGo8aJ/tbrIyQbYHjB6TQzeKk+nF6uxPICncEaa
         2us06MPXSQiSM6Xb+3b/tnBIUn7HrTiZe9fk/yp44CXGkEQ6ImSdurqJwNkFE8uRLMej
         NBPA==
X-Gm-Message-State: AOJu0YyhfK//6V0w8/swQ2JncZSzyrDKcZ3dveSSGIO5lIItlNPRCQMT
	pEdats0nunIN/EA4wkFDti271SFjF7XPSHLdpdc4Rv0NbyLPSKKMtv3sIkdhyAWqISs=
X-Gm-Gg: ASbGncvf07K0jk5abJzv1DVRKxcAVfJLJkTL1XJFCoAT/yHRHJsxb7xS0jRYCMPXEoe
	USub+FTad13+NKLYQKidqcPO97hs2dcQT2tJHoEHMkfFBMVkJ5cNeQWwNO1Sho4dpHRT4QqhlVZ
	c2t45J7gJ0n/jeuOCyhU6RPuucORmteLeuWP1VtjoOeQxwVmLOmh5JTF9NZmht/8PLhb12T69m4
	KaSfl2crJ6Cd9bDgsDiLC8hccniunPbHRGjPCxcWNAGucYIX/0gCNhhJMgc9O1LXfQGebB/KrXS
	x7I3wgjD2X294/g3rqc6pwA8ZMJ5Rh1EvWCPADBI5PcBjyroS4XPK+ygy5UIxue3nKMQ3voHCr8
	HbdfMxslLFiz2UaTLm+E6T405dzmktjSChxspjgKQSPdNyLnkiA==
X-Google-Smtp-Source: AGHT+IHS9tYhf091OBztmobdfbj5Fdpeq8uN9LnenYjgCcxAwPpUy6aF+2m0BHN5JBLR2HOO67w8WQ==
X-Received: by 2002:a05:600c:430a:b0:45d:e16a:8cf8 with SMTP id 5b1f17b1804b1-45de16a8e06mr53531705e9.8.1757583809243;
        Thu, 11 Sep 2025 02:43:29 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e76078fe3bsm1759218f8f.28.2025.09.11.02.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 02:43:28 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 11 Sep 2025 11:43:13 +0200
Subject: [PATCH v2 02/13] memory: tegra124-emc: Do not print error on
 icc_node_create() failure
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250911-memory-tegra-cleanup-v2-2-d08022ff2f85@linaro.org>
References: <20250911-memory-tegra-cleanup-v2-0-d08022ff2f85@linaro.org>
In-Reply-To: <20250911-memory-tegra-cleanup-v2-0-d08022ff2f85@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, 
 Aaron Kling <webgeek1234@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1227;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=+1ac3GUtdyb/dGqR8+GvO4DnEY81F76aKbH4bVPkyxo=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBowpmyTvZfpYOtMF52dmosD2C8tgzKBSg7E/br1
 JS1uYmsOn2JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaMKZsgAKCRDBN2bmhouD
 10SRD/9OA1b8omkL0LsNd9stCmk1V1blJAOrM4xI+7jqN8/hi3wDYMp+m9MFbLP5EseD6eEZgKQ
 eyHqS4ZOfiM1C/MSdE5EyODE7qpSQz/onyYdM/TzbnRBsEmxagb2PiQADiAu+RRfJXGpUX84sKM
 cWeEPkueaFUa2UlhUZzYRYGEJZyb16Y2QkkMWVXw5p7dLJRKcywnyAkeJj89hwW+YNJUef3+Gq1
 5jaueSy63dCk6WxOwSK9MGkF2lrSWVcs6FMyttCe2/rCFnHjav/f4E5+rRi/YsU+pwjJ8B0BPNx
 ww3jACB9E+0l23fkvIZiOiE5VFFq8Ar7ByvKhkvG7EP6hE5VKRNJvYkpiHb4NJCcsQI5b8vM9cY
 ycZkTrxb6C3mAso2HTdV2dvwcD0PfIC6w8A4Y87Zsc3Pc3iqHuak90A+0lIJGgykJGltRMQwfTr
 Xj5hMmw2mpMkqUR8+qbgsZs+etMKqqUcUEJwwG20JdOG6v5k8XNzFtac3la0WUysSDGnKSby5E6
 EG9OdfwT9W6pMqdZ2Ukdb6pbBRyoTqhJV1goiLgJOgBmoDiyQQQtpII1Tpu5eEfS21UnzQCo1w0
 L9rifFeKp2OE0a1S0AjBcp6lNMXQVTAJXPj0Mdmx0by5gKnPCGZkVBU/L/6BOPhADTvr6Vdtecz
 tuBvxkdbSn7bHIA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

icc_node_create() is alloc-like function, so no need to print error
messages on its failure.  Dropping one label makes the code a bit
simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/memory/tegra/tegra124-emc.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/memory/tegra/tegra124-emc.c b/drivers/memory/tegra/tegra124-emc.c
index 9aad02901613f1b2ed855c11bcd76fef153034af..f3372bd78ce8db666015a7844cba4e6aad79e61c 100644
--- a/drivers/memory/tegra/tegra124-emc.c
+++ b/drivers/memory/tegra/tegra124-emc.c
@@ -1350,10 +1350,8 @@ static int tegra_emc_interconnect_init(struct tegra_emc *emc)
 
 	/* create External Memory Controller node */
 	node = icc_node_create(TEGRA_ICC_EMC);
-	if (IS_ERR(node)) {
-		err = PTR_ERR(node);
-		goto err_msg;
-	}
+	if (IS_ERR(node))
+		return PTR_ERR(node);
 
 	node->name = "External Memory Controller";
 	icc_node_add(node, &emc->provider);
@@ -1381,7 +1379,6 @@ static int tegra_emc_interconnect_init(struct tegra_emc *emc)
 
 remove_nodes:
 	icc_nodes_remove(&emc->provider);
-err_msg:
 	dev_err(emc->dev, "failed to initialize ICC: %d\n", err);
 
 	return err;

-- 
2.48.1


