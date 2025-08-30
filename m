Return-Path: <linux-kernel+bounces-792930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED02EB3CA9A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 13:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F86D3B05B2
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 11:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECB52749F1;
	Sat, 30 Aug 2025 11:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rssioEC9"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4051F26D4E5
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 11:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756553581; cv=none; b=JXHGwiAN5Pe4l5gZsTTKvZwAkJuuDmuFBE3LIISxjiUW34O2IC8VVekj8MGaRwYBNofZaOQZUcGqlY6Mq9t+3bXtckl4dyVq5aU1asGOWM5k/wbSe2cQM2HsX+9w3S1vBZ5eJ78+9U0yscbdSCwe85IIzucIags4Zv07VRV1MRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756553581; c=relaxed/simple;
	bh=kXo25ot71PKao96MF4jC5Q47IZVAt+tdcJDhDLvaoXg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e77MALKxmzDfhw71hqlUMj6TKIiJwuziKBdU8i6P1OrLGPv5m+0STS9Ed4grbx1M4KQml0t3lbZ+7LFkHfQVXYoR9BNSQLgidaataGoU3n8YYeT0osCbz4wY9qft1+qOh9/0USbuwZeuxTo0wHwlcBKxD2BF5CV6N3/4Xzu3RR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rssioEC9; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3cd99b4bb72so246583f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 04:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756553577; x=1757158377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vFmqnQTGqXxn55WYLK2556v68/MA/H1ggbgVwEpgWEg=;
        b=rssioEC9YMKIMphTqwLo/INDSk88mw57WswR9Ov3925dr+gljefdPhkKuISUsxEwLW
         EwgTdlqWO5ErF+l00y2D2Ko2DAqBsAKPgglniOejRNHw46Xum73R2ULLBIkyBfycv+Oz
         srXJmRfw23kEImEzzPVyWPYTSMHGQHPcB25/YsbybQk/lMhqkUZBcLI6gILU+toRkD2U
         g10PUQNhPnBSUfRYSrI6AGD8X3fWd3UNww5dbPZ/jPmY5p6U7st8eLCu5OjUF77gNMCl
         6/kix/HKftJrbTe661h7FjUp/H+CVeU7Xhnvi2T/6zfOcAhPDImbywC4pnOUZNluc/Lv
         4oew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756553577; x=1757158377;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vFmqnQTGqXxn55WYLK2556v68/MA/H1ggbgVwEpgWEg=;
        b=l9vd/PSC6ADNKnSxSZmmfy824L/+givwwtBIdvqv6WYpVj/vnB9AFo0AxBTZ8ltvam
         RPQ2SadYteJVrmAn6LmaFyCa8guUsKShHEbHxYaNpcATwm7t0UrwwfQ1g4hgaBMRWXeG
         ZgkUAj9PTD4RjAPg1xQCxjwAYk8Sa6B9lodqp1GgMlJyiuzpJWLwz31F8k0ayRZDqzPy
         F54qJ3nReQTezKEdSpzDtsSF9uhl1rfmnVH1ONt9pY9+71RLvzTWDx4a1b+f27SO/WHW
         /yfYDxhs9kMbnzYQjg6ruwheeAkjHpCkTffINpb+TXKR9UWXZq/So16SSqAb+pBwkJTw
         7Dqg==
X-Forwarded-Encrypted: i=1; AJvYcCVvmu/yT7o0idLBIFq+uYjOY7Q5IUVZRTL5YKFl7RC+X4GgNygyoQsW3ZBVdcVi+PvyTpZIfBgxnSYBpoo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1uTdVhkV5mAunLAyVQM3pakz4bTKRq67ok8ZAzl09+redR1Cr
	6NPxp6sNibCL1Gzhu5wOKOn1TtWLrf49YGXaMTwIW4iz9XP+NJ8JCuLvN8lFuivPBfmXhbzYyTd
	8Oj8x
X-Gm-Gg: ASbGncs2E1xOgnkc2XvAm/c/84Yi/x+Oju3MVX6IiBR9eT1sjAkt0KXB6Vcfd+l7pyP
	x0QcPtua8GvWEWeMsGrFBqL4jQFyL4lZLk3elUmVhhku8U16AeLPuo1Ms0RCyAxRPJGcX9gtH/+
	kMcre9j5P8Sa+WSnM4H5spxNvasp2sJhuDqHXmvBAyv8JvBMHdBznO6o4Mdq1V/GSqIKsYlFOox
	S4wyjpWkHkD0mmrREgMfW5qDizEliGpze6pBoBZpC6jNGguH+M9B7+ZpW45K489p5SGYiRc6FK4
	5sK2+gcSrlPlB5VarTLi/K3yAV5/6I3t1oolM0f2ifqHZ7Vu3S8wnHWaLphEa9z8Ba2IKqBGsyp
	48X8mGqjc5yWLgeImyP5FkbrWfu7TGuQsmE1uymkKM9ia
X-Google-Smtp-Source: AGHT+IGKK/qSnUCxIDpMGOBRaCQakj8d6VMwSyKMl0I+FHgNN+kuVHKO2/oVKVJVRl6z/fpK5Ky5LA==
X-Received: by 2002:a05:600c:37ce:b0:450:d5ed:3c20 with SMTP id 5b1f17b1804b1-45b81f23e6cmr21995105e9.6.1756553577525;
        Sat, 30 Aug 2025 04:32:57 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e7d2393sm75468505e9.3.2025.08.30.04.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 04:32:57 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: arm: samsung: Drop S3C2416
Date: Sat, 30 Aug 2025 13:32:54 +0200
Message-ID: <20250830113253.131974-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1099; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=kXo25ot71PKao96MF4jC5Q47IZVAt+tdcJDhDLvaoXg=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBosuFljxKGu3v2hhBhALiaOsXxtFwZ1tXYGnBn3
 xTfxiSjsCCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaLLhZQAKCRDBN2bmhouD
 10PLEACNZW39Nn75JA5RBUdU7uRFLAFlwQAQ6FGdpKDD+l8AbufT6YOx7/PBxVjhYlDta48gbu4
 UlLeAl7EQ32fF1mfnZMHRrJ7Js47GliPkqqQRTkbRLSfheo7JYwa5piEB3nT0vxvz95pOIC3jIK
 6Dka65RxK1r/EtTHQga1a2NsL+kwEHNuoIFqwa5QX/8C86fG4RGPsjdlzEsDmRpRgDMPq/swWCP
 Q15I/hWTJNEiHzQRZhGaUuslwpxoxbAC1RBrcf9g5WDcqIzzUAvkWMf8ARez2KIpVTtxIxyBM2i
 AQ4ZL7Jhv9AA7o8r8h0hpqIq+j/WGf/BdVuHVwEmRbn0BaWgMeVYH5UVPhuh3UHvhPoEDogh6M9
 qYnu/EdxJSf/x0pgfx1GD17M/b09DYVf9Lh8RQFClQEW6/xubuuUhK5XvROErwBz31uzaFl9SHj
 svhojbfHpUUWZc4GGQYBLkucUZkWTJL5gVEdYzf34i4z0UbtTe4W5mDQI9u2a6qr2TcjvbTcSYY
 9h0e6+gaxnxSFkf1PfrOoygwuPKXGEwYa/O9hL0MuiFF2Bf++4AywoeM7Itvv8sKFrXC+ZFZmlO
 v0h/yglPvU51VaoQRAwrfqwNxKIW15+JK7G1vCreJxRDhUujE3slFTTC3dkQIr2oq2sq5H+3/wn i+Z6nZNekhuYSJg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

Samsung S3C24xx family of SoCs was removed from the Linux kernel in the
commit 61b7f8920b17 ("ARM: s3c: remove all s3c24xx support"), in January
2023.  There are no in-kernel users of remaining S3C24xx compatibles.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/arm/samsung/samsung-boards.yaml     | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
index 26fe899badc5..f8e20e602c20 100644
--- a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
+++ b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
@@ -14,12 +14,6 @@ properties:
     const: '/'
   compatible:
     oneOf:
-      - description: S3C2416 based boards
-        items:
-          - enum:
-              - samsung,smdk2416                # Samsung SMDK2416
-          - const: samsung,s3c2416
-
       - description: S3C6410 based boards
         items:
           - enum:
-- 
2.48.1


