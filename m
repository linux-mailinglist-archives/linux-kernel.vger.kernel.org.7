Return-Path: <linux-kernel+bounces-809978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A248B51434
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C035F4E37F6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FAF3148AB;
	Wed, 10 Sep 2025 10:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F3Z3ITp5"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172B230648D
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 10:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757501059; cv=none; b=rb74nI2wQu7vCEQR5J1GrURpjn43WpXXb1ocqJLN7Ta6a2tjQFUG8v/ekUvTgfdaUS1U8aB21Nq4AIuWi48XBNdCXCHRzko2gE1h122X2G32I5esLwNN4x1NoHQnUJThtH+GikKHRux2TGgPzJ9TAHiREif80wuGtWLqDyu/MUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757501059; c=relaxed/simple;
	bh=+1ac3GUtdyb/dGqR8+GvO4DnEY81F76aKbH4bVPkyxo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G25RAOCv6zsLvCehQO3B+5B2XICnJUm/tX/6C2FcErYhp5G4/zaL4rUeUxbe8uMbfqxppA9pDKHvkRAdnps5HvcsGNpgYAiUttmqJi4syIfJWP2fo7KeaBYGVktZvRqHEuyGLxQS9cw20xGpr61iyLd149YBvR+0LV7jZgywYnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F3Z3ITp5; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-629f06935e6so684377a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 03:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757501055; x=1758105855; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WiDSDs3vgPK4naVERjozVRDiMqNnwv/gBegchhROC9Y=;
        b=F3Z3ITp5JZuSkEq1hregftRiGURgb+i4NQhT215aY/RdSZecDspVhQfF73cMPU/F6Y
         r1+WsKX9UtMWN07ZKUnpoUP96ev+sWhnLUmamBQ17lDyhVd8tEIfC7Wriaa9BTuiPNNv
         7xkP6m0TuXhPv4zy4T1sF7DyzhCB8T3+1SzwjS0QooCBCgsWkz4Zi8dNhzheRoMt5Ydc
         5ljTD0fFWIHgBnxbvry/zOXAM0VWzCWgJCU5/CmUknRurpinT1/sGGjTQQwVUnqb78xP
         LfFIkbGaidRDes7nsJYaGQnwXOl38xQgkFX7+JQCBo3XFE3tP0zSVk9eLr4PW71hzRwg
         dIRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757501055; x=1758105855;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WiDSDs3vgPK4naVERjozVRDiMqNnwv/gBegchhROC9Y=;
        b=hHdtkXqEk+TUWbwNq/TlOAAI2QkhR9jhabZCb2No5pmaP/vd9Lp3T4br9xn0ZbeSho
         Z1JKOzmu7Jdaeel5dyN2CPYt/gZwbO3uaNz9jAHx0ln9Js/j4OMZNDkNvBNs34RWFvR1
         elr8aPBMmPRsSmwyJ14zokFhQa3yODncwZqQ0ruQ6QtE83DvjiTW/x+YRpTrPHj2K/l5
         CNPV3HQfyDNRdlGJNldiJwvdDQhgH8uxnnVQqZvZIOVTLjjMW07NGuTF3EXicNLnN0cC
         lvwDMlGYVCJ0dYrnl4YOy4WbecR5H5Vdp/3iTb/TJP76fsb2AiMXTBrYu2WiaSZDmqLp
         0cYw==
X-Gm-Message-State: AOJu0YxKNuNMJ0eN+37Aa41cZNtY+FX8U6KdzIUqEoyVMgapg5+oCYAH
	jNSi45g3ZlRHWjw6YK+zih9z2VcqSAju8cNW69iXcxmZxEBcmg7AgWda9DwZSzDr288=
X-Gm-Gg: ASbGnctlPvOpItkRkcbOp3BNd3nPnNS2sg5Wj1BkYwk9LgKqDbkrq8Nwl65rrZsSIei
	7U3SMyGNF+yNk/5/EaF4x1c+rc3CwigjRuGV36ODbzqJV0yCTvlef+PlXsJ9LtVHisE0LpBOjaq
	9bKFhERNQIPZVt1Fr/NWbZj7fMEf9aCm+7JvSeGaNdyLH44mLVlHIUTWjsJIqUvy8YlaSycCzWe
	TijG3wTCvfXzdSH8rPg2dbKsHb7mMdLA2N18davzufucaHpE3YVcCde/xYkS15weSmrnU4UdL1Y
	xnyypDb2Ss18OzRbPFFTnQauGHp6EThpzmDEtb6V8q0u/frNwe8bQznFqauRrO7ONsP1ItXlSZs
	q6Z4mBw2i4Q7uL6kqOI5t8ZbV3MR1vZK6ijkv7/Y=
X-Google-Smtp-Source: AGHT+IHdm9CW5J37x7w4w6YiBADoTpSU61DocOxKYkYVYgBvdU9khcBxjYJ/0bHx7R0zRRKmXU54zg==
X-Received: by 2002:a05:6402:26cf:b0:62c:af05:5814 with SMTP id 4fb4d7f45d1cf-62caf055e34mr1668538a12.1.1757501055395;
        Wed, 10 Sep 2025 03:44:15 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62c01ae5f75sm3144890a12.46.2025.09.10.03.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 03:44:14 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 10 Sep 2025 12:43:58 +0200
Subject: [PATCH 02/13] memory: tegra124-emc: Do not print error on
 icc_node_create() failure
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250910-memory-tegra-cleanup-v1-2-023c33a2d997@linaro.org>
References: <20250910-memory-tegra-cleanup-v1-0-023c33a2d997@linaro.org>
In-Reply-To: <20250910-memory-tegra-cleanup-v1-0-023c33a2d997@linaro.org>
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
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBowVZwT3CDVMrlONPdbY6jb2lou5Qzq4s0WqSSA
 WTLLi9mfjaJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaMFWcAAKCRDBN2bmhouD
 1z/4D/4wQDr9ImbS8nVtZoels+VrzmHSn2Rn7SqdrZma6/9cna4iaQBKEW0PVotkmNWHCgYVKwW
 MX1q3lgo/unq1+XXRIT8MDmbPaAtibG/hi9O6ymO1DDp8GzRtI8E6/Aeh6mlpPeyj+H6YwwpeUj
 Y7spFWZ0fXFjor0fFwCOQ7ciKRAi0RC/z0NoLSeSNp+6NydPNilliS+nmF1zY1PeZTmUGsWOaOZ
 yqYgGrc6koHC+ghjcmp/dakCHy1tdwKJq3TXZfJiIad8rBzGOa4xgTFXsQ6+m7LHht5v4d7uBu2
 QK8n5EfObDLKxZq2oVIXfc8sucLyG4zUDH9F2ndJpBucEfWEn+j0/LGZPuOlTGuH/IByquDSqy9
 5qHvgM3KzFqY70NM+Fe1GWIeojMVYoQqRnYQtKjazEVRiQvRI7iAx2YFDGZHwcRDvRjNKG1ClRA
 MR51FfRSr6kMy2hvYvmlep6vAuTlpRZxWyBw7wh53/ZyGyBc3R2uWiXWb9a4RibASr5kgluA3hE
 wEWyh5rllJglMLCVnJTbGtB/m8wESG+hqDmIyZowUjoyd11d1CFBU1bQTyVNTse2AIjee4R09uS
 eqjNXx9fuvaoeMf8XRxvkTw3h52aXz/dGyfVDCAE8fr48zzl9lH31dhZNXt3NHQZdh69aqVw8tZ
 goBtZtGU27TngFw==
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


