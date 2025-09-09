Return-Path: <linux-kernel+bounces-808350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EAD9B4FEA3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C634C3A579D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1B73D6F;
	Tue,  9 Sep 2025 14:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bEe6PMM5"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAE822FE02
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 14:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757426622; cv=none; b=f0laNDRDZheh7C1hRvkfyyjN4ckmR8M2HBdVOQ9y+l/XzZu9u2KVd+0GU9Dan18LEi4zQ4I+w7dopWNEwq3neHefWmi8WRVcnbgeuTrNuHuCGM/34898G8sakahcuqHW8inRYaZYNMTM2qqAzSpDeycgYUBQx7b/lCtk5AJb0rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757426622; c=relaxed/simple;
	bh=kg5Xw/CZm9HjqXmiEvNrDXQY55QrcPnRUdquA+eckKc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tc+jqBhgJXgUAmxdKaUZg3TzPWD6qAnbr/MphQat+moOYeN52jFZZQJkZjI0jyHPWBHtISEh3wDQ2lC4Xc21e7EIYJ85MnVb4L+FgYqHLVDpN37Ce4aUMQe9bG50910VV53ZJ/y0Rkd5gHVhWTl6UCg9rlLWS2wak2WLJxCjNO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bEe6PMM5; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b041264542eso81673766b.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 07:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757426619; x=1758031419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=60uLhSl/0uAu4Ftj/dSCCuqQiKJnyoS7V/Oz88gSfnE=;
        b=bEe6PMM5Rr9StCp139WXkYQPg0zF46pOAL+dMhrAjwKJTvOMFnd7BGMXIlkiycyTAE
         DHMs4tzTZ3nQHpVGipNg7phWCQMTxkVlPYrMBHeN3su7m6YMTJr18pzzFNWtX6bK5Ncl
         6+nVUylsXhuWaeA6EZ/+Eb5C1VuqX3n4TKkivKpeOPpWTChyUB+LV5GWvN8/I7UJPi+I
         0qJZ99lqo4WwFbiMigRlsubU9lei2vV3gQettwHvA1d15oT+tuNhQxhDOJEJLMRmsP3e
         MWh70SCbIJ5ftqEunyKioQxbvCC10NsIlxFQivFtp2tNdeY8jiPN8xZNJb9YE4OFK29K
         zjOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757426619; x=1758031419;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=60uLhSl/0uAu4Ftj/dSCCuqQiKJnyoS7V/Oz88gSfnE=;
        b=aQ3Gfu7LFzJ/s2PxC7FtGVMGgAOR2s1NasCog6zibMw4HTmMl7BA8unJldSbLeYW55
         Zx7llBbNM4yqghENmKieLXIMd9jms0K0JxdAGDPw0T/M7woy3j3XBH5apb0SlOMoTs8B
         defO219fxzYt992tf+uPJohqSsgs3VPoizCzLP6TvZv9buoxwBzO25462WHeKGs1wpTb
         fLgWqidjuR9P55sALgINYkoqS9DQrG4ssTyVqStF5M5DZ/yj4EXh5aI4tIbpb1J89mIY
         m097Y/nDVC1lUnFehki013pcE8r9PCI54guZDCKJltCIQfYyP8uhz/8K2ZkrWzaMluKD
         pD/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWfnsrX93hb1bDO235ptJTVfwjwZJNuySq32msWXiQ3cI1xC8EQKPOV8Xv22mtr15m0Dbu430SqxaFZVQI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr6PJexynDyguQa/EGRXn3TevMNoC1gsKx5LUUU4+zvjzZL+mC
	NKG1351+kFpHsNZhbcSnBHTtQFuFyZpennKgVfpf5bNw7ZhPk5fVyQnIdlzzyn4rR7k=
X-Gm-Gg: ASbGnctTMooEcY/3Z32/i9rH26OdNVS6xztRyMX5Sj/QEv0ukfXwwbKqJw2rhZrXT6g
	xQr2owOe67Iosu2JWvr/4j++NfRWA5VhLPL/eFN29WQKJytI2J/WkcjJnQi5TvtESRdan39Mj2u
	AsGleDLa8Hcskg5g1NigEoa6QsEBt314QI3zopAUChKK/7Hdp78reXQRF25w/KzwYpGEk9DpVMe
	2FWQRFTW5loh6q92FJD5xE2Z+sC2bJKc25sj22YikOtFzbsy0at0/3rcK1ZZInl8zZxgCVwCrqx
	arIoaoKWvRCJMN9K+5C8MLB/l4NHtHQMbmrrwuS4WMqmLpmMnep8TWYmg9AlR/LNecH3dlIkysM
	ntCRnm4WXtp8hYFhC3m9+4o3bepWEgkkNlvkbaCMkjmsa
X-Google-Smtp-Source: AGHT+IE9xCVTVdqT2u9dI/G+heLKnP1NNhdiI9CtfIYdTO/CcYuKZEAr3OR47E5E6uuiPGrWVXyIcw==
X-Received: by 2002:a17:907:7f8c:b0:b04:36bb:54e with SMTP id a640c23a62f3a-b04b14d6129mr621629666b.1.1757426619229;
        Tue, 09 Sep 2025 07:03:39 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b048009e7d1sm1279289466b.69.2025.09.09.07.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 07:03:37 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Courtney Cavin <courtney.cavin@sonymobile.com>,
	Vinod Koul <vkoul@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Luca Weiss <luca@lucaweiss.eu>
Subject: [PATCH] dt-bindings: input: qcom,pm8941-pwrkey: Fix formatting of descriptions
Date: Tue,  9 Sep 2025 16:03:32 +0200
Message-ID: <20250909140331.69756-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1947; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=kg5Xw/CZm9HjqXmiEvNrDXQY55QrcPnRUdquA+eckKc=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBowDOznk95c0Z2ZGr5PsOvUnj4a2XFn7vxsxxot
 4eyTXL72xaJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaMAzswAKCRDBN2bmhouD
 1+oiD/0amjqhOpCCqQyOcDS052xCbmMJFa9awROyI+2qZYsLiZa2bRsoj+J6oZc31GIyk3emynV
 bauVh0C6YYcEHOEMwdMkjKiqGnri/hFy0KKGNFRh+yQWhh6c1iPPrDMJmYMJgzGfwB08VZSFyJo
 EcqFOOf+jbJk/kzR4OrvxNIHViWHz32K6aMdEmZr2lfXuSFH/KxGsypCPrKdtUbGpj0EYwAXPSD
 7dJw7Vfk4MmvGnUW35LzGObHr1JyEg1EccKcEnJjpJqpXf+9h1fUdopcDFvq0IdhuBsjDDA5aVi
 yUw+SPefzELS6/iwsZXjyMuFQwigViJz4CybZfiU9TEdG3W1nTWIalcNzt5aUPHMzUPf5SImIHW
 hQ8qyKapvmWFISvvY6bEF9E+gbVtAWryzAwQun8ESnS86NDcyNj3eBObvrG/j0laBAfWRK/3U8Z
 +JLh/PZjSUb01X8K0SEJYa4nJ8tXo//iJ444iu9lgCNB0T4T0Lj/gdTfgIKROpqMJWWTT2APyef
 0ckgejAHxUN3Jp22o5kOZNq87DV16P9Q1IEa9cgLNelQsoddu7na6YzvBZihean0tPdlqLy5/si
 cPPjqIsuHhRxsOpmppCyhfgi7N4BXeBGgPcyOo60VW+eNU3aK6bvQh7NgL37HyycKDyvX0wxglr GJzrKLUuqdPXDxA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

Property descriptions should indent with two spaces and they do not need
to preserve formatting.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Cc: Luca Weiss <luca@lucaweiss.eu>
---
 .../bindings/input/qcom,pm8941-pwrkey.yaml    | 21 +++++++++----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.yaml b/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.yaml
index 62314a5fdce5..72006a14fd41 100644
--- a/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.yaml
+++ b/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.yaml
@@ -25,23 +25,22 @@ properties:
     maxItems: 1
 
   debounce:
-    description: |
-          Time in microseconds that key must be pressed or
-          released for state change interrupt to trigger.
+    description:
+      Time in microseconds that key must be pressed or released for state
+      change interrupt to trigger.
     $ref: /schemas/types.yaml#/definitions/uint32
 
   bias-pull-up:
-    description: |
-           Presence of this property indicates that the KPDPWR_N
-           pin should be configured for pull up.
+    description:
+      Presence of this property indicates that the KPDPWR_N pin should be
+      configured for pull up.
     $ref: /schemas/types.yaml#/definitions/flag
 
   linux,code:
-    description: |
-           The input key-code associated with the power key.
-           Use the linux event codes defined in
-           include/dt-bindings/input/linux-event-codes.h
-           When property is omitted KEY_POWER is assumed.
+    description:
+      The input key-code associated with the power key.  Use the linux event
+      codes defined in include/dt-bindings/input/linux-event-codes.h.
+      When property is omitted KEY_POWER is assumed.
 
 required:
   - compatible
-- 
2.48.1


