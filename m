Return-Path: <linux-kernel+bounces-727585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47547B01C80
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 14:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3AC37BC488
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 12:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7FF2D3752;
	Fri, 11 Jul 2025 12:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RqSd/0N+"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759EB2D29B1
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 12:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752238684; cv=none; b=Mz6Cwq7A+FlI9BRYq5UrhifRINmMDM2uK6s3x0wlvwga1Z2XbomCoLwo7Y8qBhxWRDRLPJ3v1n0jBRj5kQTr2TFVUOH+fXE6rY6vBCHD4f1fXDu9kqb2miaCYA3OVsV/n8VzhB84/jqELcY2hnQIlBi8B91XMthc5wuQQFcjUgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752238684; c=relaxed/simple;
	bh=5VDFXA8I+E5iXu2Bb9Dkpc45x4jcmubRsSn5foFMXjY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YS5FtMa3jDO7LTf3wM1bOg/M0On0voxmNsd9az8Bs996Fn6ZMnr0fnPKRqh7qmZW6RGkD7am8P6lGApAnr3BitPxWI4L882A45Y6d4sj9TAMrixdscEjbbEbPFbL5wg1uYXlJUbDbNd8QWOrTgTXdLd4i5J5QdkPoA3RGHAlbRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RqSd/0N+; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a4fd1ba177so1399334f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 05:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752238681; x=1752843481; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S1AQyvuxz/zrLJ/xQ09mTaJr5J8m3jd+X+5DNs4wLi0=;
        b=RqSd/0N+SgKDKa//Dvwb03fYb1HFmFjFNvrjCSTv2Y2TDSI9voxbGBHaewOPCHjOCp
         bpCTM+ZOOgnvSwKRM0XOegA8I0elU+s8BNKKELlSI9VqlYYXJI9x3B0joLUu2WmmS2Or
         +GiUGThboBz2ZdLW/ONWPmgx4AaoX2F5CVIMuF4Xg1HyCIrQg92pxcK5wZ9n9BPHu2pf
         Of5tA18ts+KHNzG8sBT/tGGG/67P5xKdFf580KfQHxgWNGsZnhFD8jS3c4ZTAIiGDSxD
         m6x58bzR03qmIg446JwtEdT4OfAfCWaXLAO0Oo39cdr26unIEmSnKFRgnS3rGvHsOItK
         4CZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752238681; x=1752843481;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S1AQyvuxz/zrLJ/xQ09mTaJr5J8m3jd+X+5DNs4wLi0=;
        b=bFgcsHb1VBLXm7etO6B//NKpKiTh+Kv+6Zs2/XqoJwLq2Yuk/E1qRdojTcz5pjQPrn
         iS4t4hJOyj5vjBpoichZlaCrGd5b4qaKH0Pwm+vb5wUQys8QOI1Ub5RncU9Z58vxuQwZ
         kVgRGq4ayvHkJuXzQE7gAJtZsEQLdz9PjaROuxPKcuDfeo6+TX2Q9LetVAcXPk3pmdje
         no8uhspj0gjb7wXQgJPmwSyQDxP9t7FrFrTtpN9Wo6EY+7oUTHRlh78RljltAOKYdGYc
         PGSYBb0YDVWHApjB9dhAZbOM3mkT5lIhn6aLUVIg88yMVMuHANut46rdJoK0nNBZcom4
         vT7w==
X-Forwarded-Encrypted: i=1; AJvYcCVRdQT9+XGosGPxOHTfYGrGh16tvpdp8FMNnxa0DiO7mqcrA/LX1ckuIqLwTZkvBJOekqAJxpElv+Z7mvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRv0T0tV8UhQ25GXdcPUeD2y//1hR37Z25vmKtrPrwD7o/rGp9
	//Auh8OzXy43dp+OwaCdt5TOMaTJXHrmqy377fZ7WlpdAZQEp3VYC3U28088gABafXo=
X-Gm-Gg: ASbGncsiKlxNK+kKNonNtd9wDslj87d7w1Nnsf8jGc0wxnsCXmEeKH5yVpSFEtLfPSp
	2JupTLe6Fuq+X+8WGxZ0945+DEDdsKJwMNL2qSB0DfIUqaNL1sPd6SkjeO70jgf2+asa1u0yW6f
	gfSaVW8zGxvSDDMuzbvZiIWFpv/ULJn8rnVn9YzCqWoMnYoh3oSdk2zHs8gSjl2hspzdx4mudDd
	40+k4cqny1safPbfPn4X1lu6WGIFDx0o3H60Xl5ocokKMeg1novzcIdd4yV0t8VSmdm6EGOH6BF
	+eXgoWbbl6erckijuDRE1L21vVfoKoTnKnb1ARq24JIT55eaKn5MK6gaMAgLrJ35InFNupa6YM4
	uK3qTUspwK3J0NjzOru23DUeMdSopkJ9fE6dGGIoZeF3kvdRrWLfpNsXeCa292h06
X-Google-Smtp-Source: AGHT+IFCINtjBENaeAj10KtYw+ipI99HYuyHocaT2yFg53cizOICcvS4H5wwYoC8qC05rHejKDw6xA==
X-Received: by 2002:a05:6000:642:b0:3a4:da0e:517a with SMTP id ffacd0b85a97d-3b5e7f34e49mr6891264f8f.23.1752238680724;
        Fri, 11 Jul 2025 05:58:00 -0700 (PDT)
Received: from [192.168.0.34] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc1f70sm4373648f8f.27.2025.07.11.05.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 05:57:59 -0700 (PDT)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Fri, 11 Jul 2025 13:57:53 +0100
Subject: [PATCH v7 01/15] dt-bindings: media: qcom,x1e80100-camss: Assign
 correct main register bank to first address
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v7-1-0bc5da82f526@linaro.org>
References: <20250711-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v7-0-0bc5da82f526@linaro.org>
In-Reply-To: <20250711-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v7-0-0bc5da82f526@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Robert Foss <rfoss@kernel.org>, 
 Todor Tomov <todor.too@gmail.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2647;
 i=bryan.odonoghue@linaro.org; h=from:subject:message-id;
 bh=5VDFXA8I+E5iXu2Bb9Dkpc45x4jcmubRsSn5foFMXjY=;
 b=owEBbQKS/ZANAwAIASJxO7Ohjcg6AcsmYgBocQpSbcpVOwqqdTtfGI5BM/HqJWyqBUExf7p0G
 0Syw5dgTj6JAjMEAAEIAB0WIQTmk/sqq6Nt4Rerb7QicTuzoY3IOgUCaHEKUgAKCRAicTuzoY3I
 OsGoEAC2MVpyLtQF+tRtU9rVblWxWJUGQDeI94C78Rh0mZLPctX1bvnhPFvnnpcAteCS+LZkJaB
 W918YbzQfidrn6w7PmXn3B0pNjsvhfrTaKjigDeQU0J/zj8WElu/79CtffjBbM1uFdFtQtKgzhy
 nMzzI+3jYNWfKGEfFzw9ZDRbxo2s4xkEKlhQIo0MIxr5X4rzvdI5KuIsjczjAsHBMYawT+LhpT3
 8YAC2i3MvtIsxLQnlcjjtAutEmgpr4r7qAKQFqLqWmB+ZWW4D0KE7SKTNZkYY+mvj4s61/vPOcH
 NHRI3Cq9J50DtDZDe6kCXfxfyK+Wdt8EzugSqVDzyGBTDwgK3A1yMJTbF50dO2aEsuQxv986D/q
 4ynvYNtr1QdMek99gCuFY8R18IxdSkdIdf91az5uzRjeDOiVkg8gxf2yFmHJLSbICF1onfkdTab
 vmYS5bSv+MbP1DUg+9vQvrmGABrz9QuFEoI0w63hIQJEzLnhuj/yPWuTH6N4BcRPEpoa0ieiUx6
 MJX5l2YsKAXX1J8Kg7sJ/X0tbuC6KQBHErkyfe4Ufmb8/aW5atTa0Unfy+TzpQAKRhjJZ8ZuUTJ
 kNR+T2s8qUfZ9JJhmX7R22GJTn3CjCELB4A7ylEaQMJ2+CdvgCeiBzHyFMibTmnmfNuFAQVWjze
 qfiZBsmx5CmjVrA==
X-Developer-Key: i=bryan.odonoghue@linaro.org; a=openpgp;
 fpr=E693FB2AABA36DE117AB6FB422713BB3A18DC83A

The first register bank should be the 'main' register bank, in this case
the CSID wrapper register is responsible for muxing PHY/TPG inputs directly
to CSID or to other blocks such as the Sensor Front End.

commit f4792eeaa971 ("dt-bindings: media: qcom,x1e80100-camss: Fix isp unit address")
assigned the address to the first register bank "csid0" whereas what we
should have done is retained the unit address and moved csid_wrapper to be
the first listed bank.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 .../devicetree/bindings/media/qcom,x1e80100-camss.yaml       | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/qcom,x1e80100-camss.yaml b/Documentation/devicetree/bindings/media/qcom,x1e80100-camss.yaml
index b075341caafc1612e4faa3b7c1d0766e16646f7b..2438e08b894f4a3dc577cee4ab85184a3d7232b0 100644
--- a/Documentation/devicetree/bindings/media/qcom,x1e80100-camss.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,x1e80100-camss.yaml
@@ -21,12 +21,12 @@ properties:
 
   reg-names:
     items:
+      - const: csid_wrapper
       - const: csid0
       - const: csid1
       - const: csid2
       - const: csid_lite0
       - const: csid_lite1
-      - const: csid_wrapper
       - const: csiphy0
       - const: csiphy1
       - const: csiphy2
@@ -190,15 +190,15 @@ examples:
         #address-cells = <2>;
         #size-cells = <2>;
 
-        camss: isp@acb7000 {
+        camss: isp@acb6000 {
             compatible = "qcom,x1e80100-camss";
 
-            reg = <0 0x0acb7000 0 0x2000>,
+            reg = <0 0x0acb6000 0 0x1000>,
+                  <0 0x0acb7000 0 0x2000>,
                   <0 0x0acb9000 0 0x2000>,
                   <0 0x0acbb000 0 0x2000>,
                   <0 0x0acc6000 0 0x1000>,
                   <0 0x0acca000 0 0x1000>,
-                  <0 0x0acb6000 0 0x1000>,
                   <0 0x0ace4000 0 0x1000>,
                   <0 0x0ace6000 0 0x1000>,
                   <0 0x0ace8000 0 0x1000>,
@@ -211,12 +211,12 @@ examples:
                   <0 0x0acc7000 0 0x2000>,
                   <0 0x0accb000 0 0x2000>;
 
-            reg-names = "csid0",
+            reg-names = "csid_wrapper",
+                        "csid0",
                         "csid1",
                         "csid2",
                         "csid_lite0",
                         "csid_lite1",
-                        "csid_wrapper",
                         "csiphy0",
                         "csiphy1",
                         "csiphy2",

-- 
2.49.0


