Return-Path: <linux-kernel+bounces-809979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8224DB51438
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7101F7B4F51
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3363164B4;
	Wed, 10 Sep 2025 10:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="be8PJGbh"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAED3101BD
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 10:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757501060; cv=none; b=IlwCuWqhhoGye0wUFBDcUOuM1lh2FsZpCkHNX633BzfoHG1iEc6jiEARUAjqKZZ25RV+0pZEGEcG5dR3S7B2ccnVj98CoDoZfIrRmdQHXoIa8IAFqucFir4r0og2f0qHNCCwluUrBnVE81wYC66KjDBx54sgMv9ETkVWic47WmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757501060; c=relaxed/simple;
	bh=oEubvqZI2n3V9FuebymqRYT9aJaRR3Y7ftHMN9o4xTM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZtTzK//qhC/daADgOoznqOKfYmwPn/ZBFCugQsT1LEMPgsL8kIyPfDjBy8XCEl/IKJ9ZNHMBm6qdUt/NgQHe99cqcjQQ/o6wVJvXWBRF7IOGZaxMhbqAJbP4B9nbWHp6jxV4t+9h9w9Mqxy819mkP4NIVUdPnTwbodsJd+eIHGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=be8PJGbh; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-629f06935e6so684382a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 03:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757501057; x=1758105857; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=65ye4XkCH8izeRtH/tdAUKF+n65DyQp+SjhteFd0SJM=;
        b=be8PJGbh7EYBgYYjmRfX0phRDdQ0WsEOEV5bhWeK4/0guMbYPnLyxbjQxdsowcxt6b
         hkTvAT5jBfm+fqqQyIRvFL0GRZe4fyUmQ8nQMfn6M8Cah9LqgcnSYGKgUy6VYZnLbk1i
         OfjgUl9d9Re/1NcS/RVcDWxHpSaaoRnZNkbFF+e5LouvsvN6ktQcH03TPncasFPmHFlg
         4Qzi7QP+W+JA8ftacRHF6AMYt8JmDci3w+UqnBDK1qo91VY29m615VeLCpIXt6FpoyqF
         +sq0QKAZAQGRvt7bVof77aI4wGUIjd2FJQTjCqvPLtIFRZl+tR5vt+P6LkS4QlOAA0TO
         3cWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757501057; x=1758105857;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=65ye4XkCH8izeRtH/tdAUKF+n65DyQp+SjhteFd0SJM=;
        b=QYLhbjkAuDds5j+f+m7lmG2wzI841gh3Uma8xzsLW430lv5o32cyT7PINf7mixp+pr
         7Y8tHiPk+jhp2UT7r7VLokO9T47/XgFLEIja8h3OitvA0d6BL358IewS8RfXHKBdKe0o
         Qjba7bs+taBrVk+wjcNd194xvzs/wYbvUaaRMtXUvNkKklI3gmVoTvcmbFCV2tBc0PVl
         LYEP9Ip+3LDnayuAZay92CaYaDM910+jRRxWlcrC85dRXV80OPaHcE+fXEO5PgQxsc4M
         4jWLNW9IQ+xjdw/dL+Kck3F1zRZZP1YGXTVw+dB+nf1KsNV0bp4ZreJVY6KtxAbEIyCI
         8S0Q==
X-Gm-Message-State: AOJu0YzFlZiS4YP57FQ07fEGsmzeVf5Zqk5aGQzYqo0+GMDuopIu05x2
	4PNomITy7sqfaEa3/vLYSCy1B+GTd3pTK9aLTZCjQqXmbMVRjyikiLAYasrLpkdvgFw=
X-Gm-Gg: ASbGncs6GKCGV4Qm/OPeMeNaoKM+UdnsdErlphajHcwgW5pQrVxGJMmhteoFDKsitQg
	PZfLJmi8fxqFxgoXEnjoAcRjXe3NJlmFfR3LTdnfZ8Fa4excDtf/WOE8rxqaYtv1Pr3nmMb+HsJ
	tOyn+4+RnwtSpj99JE6ZCiV4y4usZbgePOgTulY5BhJOoctYzBA5JBRBi0j7Jn17GZHwwp/Sp1l
	0G9dy96M7dS150AcWCM+mV0AyKcfdmRqg61jfEZYuCqMpnV9Ju8mcIeKN4wJKLO3Z286HQCKFSk
	sjWvTbq9imr8Ln/5iCbXdIpDsR/G9XBLm5rBSICMEOTMgbyvYFaMe6zdwRdVRXmDk7Ns3Us7laA
	186J/H6pbeJ60qAlqmelZyHv+eBixSo4thXXC3zO26JKDbBgCrw==
X-Google-Smtp-Source: AGHT+IHgWiURe8rwqi0CThvoChXPR1NJTY3Li8W5h2CF68BaUDzW6c1mZpNja/bMnKWPQ7G6dPP4vw==
X-Received: by 2002:a05:6402:42d0:b0:61d:144:81b3 with SMTP id 4fb4d7f45d1cf-6237aec0171mr7047976a12.2.1757501056627;
        Wed, 10 Sep 2025 03:44:16 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62c01ae5f75sm3144890a12.46.2025.09.10.03.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 03:44:16 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 10 Sep 2025 12:43:59 +0200
Subject: [PATCH 03/13] memory: tegra186-emc: Do not print error on
 icc_node_create() failure
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250910-memory-tegra-cleanup-v1-3-023c33a2d997@linaro.org>
References: <20250910-memory-tegra-cleanup-v1-0-023c33a2d997@linaro.org>
In-Reply-To: <20250910-memory-tegra-cleanup-v1-0-023c33a2d997@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, 
 Aaron Kling <webgeek1234@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1229;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=oEubvqZI2n3V9FuebymqRYT9aJaRR3Y7ftHMN9o4xTM=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBowVZxV1dccXkjMnXDYvGcn9mUHt1MDzGbra4i/
 0k4sRP6F9aJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaMFWcQAKCRDBN2bmhouD
 17QaD/9Yk83uNREhrvIVbI1EgtUt2rjF7L96kZj66dFcmCArEVmxlptyov0C/LPYaumKey5wYu8
 E6AvRUCRM7uwz29AjCX3epKiHj8V3VA12LPDHtIF4zLq8bTuPfrR4xPHAWAoQMZhSwioutYQGZM
 kLJ6CWBgwFH7DGAL2r4eyGfjpgJWAcCBZTsV/xTxIbXsGbGMn8WmVho2Wn2UrWJ+ZfbWzNYGvhX
 E3f/8y/OIUJnXLmXdDxeTBvDg1juyeIiUAGxSsKslWSfcgtvzlbK+r2j+ryp7y7NFeA4v0ZKAB+
 oqsW/gy0M46Xr+1fGlGp4EacCrtonLoLwQtKxdDQCBtkEZ8hwxow1qC+7D04m5NRLEPFMGpMsc5
 aHOsJy10tWC1YAbKO1IPBIpI5fvbP4ygBbCrl3ngfxNYii30Wz0ZNXMHDhGv+1G22/3X1TaES6e
 16ayxO0M5UDeqPkoAbULccWRx32265mhrYCHAkAQ/f7Kb5VZDH0AVkAX1l7olBL9G/umudPNa+n
 bvbgraONqFq79rewYDIxEw6evmCfVwCfzgD5r9KOxk0ZOZHqlriDnGcbU2BRk66zmDeDfD4r5SG
 CA+33pcSkarqeJ5veYqP601s37WZfco5bH/04YgM+qDEC/wcnPSnL2VOCJDapWJbg0Jf6AgcrNu
 G97FONQoxxEp13g==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

icc_node_create() is alloc-like function, so no need to print error
messages on its failure.  Dropping one label makes the code a bit
simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/memory/tegra/tegra186-emc.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/memory/tegra/tegra186-emc.c b/drivers/memory/tegra/tegra186-emc.c
index d6cd90c7ad5380a9ff9052a60f62c9bcc4fdac5f..00baa7ab89214b1a151ab0c0a9ab76f90f922478 100644
--- a/drivers/memory/tegra/tegra186-emc.c
+++ b/drivers/memory/tegra/tegra186-emc.c
@@ -273,10 +273,8 @@ static int tegra_emc_interconnect_init(struct tegra186_emc *emc)
 
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
@@ -304,7 +302,6 @@ static int tegra_emc_interconnect_init(struct tegra186_emc *emc)
 
 remove_nodes:
 	icc_nodes_remove(&emc->provider);
-err_msg:
 	dev_err(emc->dev, "failed to initialize ICC: %d\n", err);
 
 	return err;

-- 
2.48.1


