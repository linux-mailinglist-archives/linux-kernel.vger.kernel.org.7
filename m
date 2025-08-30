Return-Path: <linux-kernel+bounces-792929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3331CB3CA97
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 13:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A25B1BA40C0
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 11:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5366C271457;
	Sat, 30 Aug 2025 11:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CBCWDiwp"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036391E130F
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 11:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756553567; cv=none; b=nR8Oulc5cSykn2Kocg21lU0eft1za9cwXoV3e2wVs6cmn3qaGzd6yBHLQoHioKqCb6Gp8kl0JqbYuVnDRd43lsOQD1Rn8AXUglRLULtiIhNuGCHgYckR/g41MAN1EHoEcaRwskbZIA1Sqat/EGyoPtHGMsNt6RcuLJiaJXUwTjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756553567; c=relaxed/simple;
	bh=Oc2a4NpwxzUJtyJbjfj0lVP/6AEXYLaYIj96LTX3/ZM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ltv5GEF9qtifRI1y05HiZORDot4/BB2B1T9NPKX1Va9Cv/v2neQpgQkznFWGW/9wiUDAyusE6YBVfMG9FRPNCltzUge/CnDWSZQQyVuqdCDJRHOkoCBiMmnHCB0QdeYgvAE1CeGGr+5jIegu3a1/Ky1CRbc3dVPmNcV7zQKUBnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CBCWDiwp; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3ce208c7505so419183f8f.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 04:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756553564; x=1757158364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=42CgFZpoDZA1WcUF+OxPFlrBffkIpHm2VCK1V3rCRQM=;
        b=CBCWDiwpa1YkDYUVqJ5KwCWAPVFHiqZlfzh6B+jCoTkiEi70HfmdoGYGa2EOIhi0Gh
         tHJLwvdCvzBXbl4Eyn+SfVCHXrmpNdSuW21tyyBt7OqnoMfaGHqOltD9KGBHmw0xNTBF
         tuC+w2COpsKIDAA9EpARBD5dsp01gCbfoxlo/Cf4ph008apj+Mu/4+9oZRdh7kpA8f1P
         m2Oi2sW8DpL80kuBmvOlrBxhc9HbUJH7Engg7+vTeLHAbUdfkZXjpgt5qwNQ2ecTpxAj
         QEm2KOnjVeFZ3oK87d1ZsGzkTQ5xZGlNTMhrnTjrgBZmUkYndunJDSmsL5PQAWTXTZly
         K3WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756553564; x=1757158364;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=42CgFZpoDZA1WcUF+OxPFlrBffkIpHm2VCK1V3rCRQM=;
        b=fM8EWpH0EgLa3TmfpqqJwVcIxz34JEuNugSel6vIbXQCKg2znBH5vmBveEL7qIr4Me
         3ePBvTnq8XPtW7uF/ACFcouUaCCNhZWd01nnH37Mcnx0yhwBclSfFJtMKldEv+dXs+IL
         MvEN3Zv1gU0SlKW4wFwlOTCxbByBmOQ6dHKZlCD81SS/K0unGbYnGlVrGtdZkQm08aIJ
         mVQ/Pqwqd9g4al3sDo3wfgSe/EUUx3ZYa+bzqdfX2VhwLhf0Eyg/F6abZcYiGoQJmlPJ
         fUzNeYGGumWRysws92/UlGoxaj0SyZs1o9nysEe/Ypc9wCpaKyK9A1OxyiGdNNRcABP4
         sApw==
X-Forwarded-Encrypted: i=1; AJvYcCWZlZsz417vVy0028pK0yAX16+kfGsX9So38FmOeUtNu8vm5EIp4barljxb2tx9BdcIj2ePIb6eJ6nj3hc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8EAZmq7M8tNIoDX6m7bHfAxuWjVaTOaMlZH96c4a/Sqk8l7qA
	tZ7bbKVE/UeaxIG3rEZ+1V0p6ooZSv6bF07924cmi4ohkxZGsec8Cf0v4eYotPwfs+U=
X-Gm-Gg: ASbGncuCzThuaZNaA6XI+itmahC+RrxDUDFuDBes37OdiiKgjan/HfVx06gfgNrSifK
	wRbU4tRms8E5aQZqy+0qbvv4D4Fdeim1zyNVU/KTcMLvYXiXdenaIn4ZwsVF0MzAnSZq+K4clP8
	HKfRJjJ+zBbpF6ozDK9y2FwK+GHqc7/1Loyku/C/UTSA4QJFMyh0VxkJgTHNuFntMIkIbu9jN16
	gcuBXip0w06xUz1gJOXbilvnbyaeVfqGgjXTwVcHZNj+KQ+/pVculkIzR4xWKeKbZbgVGRUI2XP
	fPzH9S94begbpLJz1qU3Q56oxeI3BMMi3ZfDDYyuosscngKtTobWufwJPQ+NzTNdT3NuUmZ6kC7
	waT/hyuznu7B+luwcHMx7/x5dCCd4pe2zkFFms8HsrQA9
X-Google-Smtp-Source: AGHT+IGWlub2tHYqZLn4Y+mI9xFcceW1rbNdyeQHTnc2M39YWAxzrQnRH8Sc7BJCl5PkCIgpr8GXqw==
X-Received: by 2002:a05:600c:1c9d:b0:45b:75d9:2363 with SMTP id 5b1f17b1804b1-45b8016df84mr22260915e9.1.1756553564311;
        Sat, 30 Aug 2025 04:32:44 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf33fb9dbfsm6810544f8f.43.2025.08.30.04.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 04:32:43 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Inki Dae <inki.dae@samsung.com>,
	Seung-Woo Kim <sw0312.kim@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: display: samsung: Drop S3C2410
Date: Sat, 30 Aug 2025 13:32:39 +0200
Message-ID: <20250830113238.131006-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=954; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=Oc2a4NpwxzUJtyJbjfj0lVP/6AEXYLaYIj96LTX3/ZM=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBosuFWMrOH9wMnIOUGeuz6fivJocB17MxIWX72q
 cv84YMrJ9GJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaLLhVgAKCRDBN2bmhouD
 1xMjD/9yAHNChQiyhDuhCbIe0MWQK1qq9Jmh1fcZ9pRPq7eR79rxzW5FVpZOqYwEDhv9XC077d4
 nyWP0++jir3pNYebpsKp0huLFx9UQNiibETumy8WYb1jmax6S6nUqF5vgbowBKRK/k9YWKVzHSG
 IMhMdaVBFCbmFwMaGxKgoYx4iYVBG/D9oyf9pbm2igwHNK/zipAQb2smGD1A2DKstuP4ifgbDFG
 wSMiyl41rzWOeVldvTCZZNDTvV25zeF0h7oyz0zb6xEQCGGYkSrDbC70zIdUPo5De9L3vZtnvEZ
 mVc/nPUMBizPV/UG36lE6mt6kRx4JovQ/P8r+9kPfnRqWqs3+t4L968SMa0knB/7j1+6tzY/QL4
 i3dLQD6zxiQi/Mdraw4eo6b6HDS9mA/a1STsKkEfU+LxVgOTZf333HRRbvyekp16BwLm4Db3mxF
 97J1kznBRjsdEg5mhwjDai7lAyGkcLJedM3RQ3z62i3GY5XX0tOu2OBK64MUQP7psD5/2MkUh4k
 DoAK56/27e210XLhZWR3GUMSpm3O5iTNQkcydpUC2eMCDzupGusx9/QBoo+24by4huyWSoyk3B2
 cRd5ttVPsjaQR2Odol6ufCDNsoMUKW1jBK/RyvxMRbO425Hy0xpIpedLbjU64PFWzEUm+ysXm3J sB01Kv8ldlM1Qqg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

Samsung S3C24xx family of SoCs was removed from Linux kernel in the
commit 61b7f8920b17 ("ARM: s3c: remove all s3c24xx support"), in January
2023.  There are no in-kernel users of remaining S3C24xx compatibles.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/display/samsung/samsung,fimd.yaml        | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/samsung/samsung,fimd.yaml b/Documentation/devicetree/bindings/display/samsung/samsung,fimd.yaml
index 075231716b2f..ff685031bb2c 100644
--- a/Documentation/devicetree/bindings/display/samsung/samsung,fimd.yaml
+++ b/Documentation/devicetree/bindings/display/samsung/samsung,fimd.yaml
@@ -15,7 +15,6 @@ maintainers:
 properties:
   compatible:
     enum:
-      - samsung,s3c2443-fimd
       - samsung,s3c6400-fimd
       - samsung,s5pv210-fimd
       - samsung,exynos3250-fimd
-- 
2.48.1


