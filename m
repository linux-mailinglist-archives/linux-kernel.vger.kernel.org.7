Return-Path: <linux-kernel+bounces-834468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89322BA4C1B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 19:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42C454C8075
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 17:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1CB30DEB5;
	Fri, 26 Sep 2025 17:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGhM/Ian"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4742A30CB2D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 17:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758906819; cv=none; b=drjkXie6H0dn4rtrD+GpVrwtfnEAYXvEsDoJGnn2XBDqkz9ih4NHf08heL0OE7ytN/7kxRLp/wttsup8nLukXRmkwqyegK2k8sfOiMSqlJ+AtPuwyZ0ec2TQzPpkbj+c/nHeHPIIFS7Vib4M8ndX7zsMmKxhDVrdrgKxgDLDJsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758906819; c=relaxed/simple;
	bh=EUACCdRjiK5h0OZliVlHWHxQvfuSljSctDfK8UqIv1I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=onzEF/gKiXl0C9BBeBrLZ53wfgP5v2NIvbfhE+hYk4ovk+0Qf5clFo9fN9oCAyPTTop0cyeTc2DqWj1f9VG9/Ive4F0E/LedbvV/W3msy2+s7oi5eOVqcjiWgVAQu/IkRSKoLrY5LIQRgm2FsPvkQCI+C6CmMMqBG7v2ejMMVw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GGhM/Ian; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b29ebf9478bso333730866b.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 10:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758906816; x=1759511616; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j6zQ02c9m4sqkS/7KLMcRYfwBcaXI398hYzmmlN8WXI=;
        b=GGhM/IannxuW1QP5LZI7ostUeMoM89gu1e6UuYI6OpkXC6XQPi5nBZtcaXpqSWwfiw
         vBB7rBJS3CgV1ezrDzZ6IFWCDO5TKHEIGxXKtguU2RmuLZD1IUrOrLNbYtaLMBHYGO7g
         nL9RTP0QdmK8Gk7/00XkalP9xrUGwJnJfVz3KN5N+6o4vGSDQWUtru03HbrlgsEoE5hs
         r/HkkPM6KcJ4luC6iiTFIj0X5QCXUjHaUatTL7k+bd7LyOoaSTKFeARFzRtwKAXRzmEg
         YwfLM+2tUG79k8o210Df45mDv0A3E17Dv4tAhGyrvz11BSM10kq1lqyRYNoQtc44kzdp
         CDPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758906816; x=1759511616;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j6zQ02c9m4sqkS/7KLMcRYfwBcaXI398hYzmmlN8WXI=;
        b=a0jrpQzzHzHvJJJ38mZIUY3fdCiOa/se+5JzaNrohk+8jAI3HAvTwSs/ShQ3SMkGwo
         Aai9uLYS5y4ISD3iFSc3MiqtLT3M+uEF8rOlFn1UbMFDhuAfBIPIxOhTfgqbjinoDP7Z
         lZ0133FMwA/CCelkY1F65o6s3CbCkPdlYVSfm0u3hOG0u+usoR5biFdem+WwzIiWTUSF
         LjCb1QwXfYDQP+j1joOLnnqFFzrAaUz94BTCWZjInq3Xo6aKfFQ19my/S8JkEvQ0MV/D
         BRmUzqIc5qqIQw+5Wn+hhUnaX+sT/OcV5gABRu9SOT3nbyUhoq1i7OIErPY4bzZeUiC5
         w80Q==
X-Gm-Message-State: AOJu0YxoBGsOAr/tMlaX/61Ort7QIfX0zzMP+DsTxRoWZKNHNPBPqCnV
	es40D9/YAkFK8cOZzkqFdF/B63ycZ4x35jwOORBKUt5q6C5Us8Fge8NFNUOO1A==
X-Gm-Gg: ASbGncsuK8HdD8hM2iZi8zBWZFfn4H9FkTRzZ2FqduuMO9JXYnKZg8eci36F+Z1mmjV
	OrQWVqTmnafN+LvlJGkkxYhCVJcgdMeXN6nZDLaP37p54P6u2f2ywvWKgfVliFy6HEiCB4tExGA
	taMBa4Sa/diHwxPEMRb/UrzFaEs39DLEfS7cDnEni6UIMh//nv0pux9OORp4PPQzh1SftPkr5im
	Ui6AQccqg3XI+s1iqzUkfNFxa2faFl4TQFj8Zo5D4e2xGfC8j4B5mKyuKJJpn021YKHjzqiyReo
	9IXKSinuleoIG78GylqKRLa+CN6mYHd91ttlNs7eser6tWYzXS9sfzhuhIAsGi1wR/R07xKFaY/
	RZ+upEdky8G9ZtiOW/FSSNVf8avjUbZg=
X-Google-Smtp-Source: AGHT+IGhMATBN50BQ4koKK/tdDQSDYP3EaX/YyfRUkzb4/dz3hYKjgmVJS2EDPkjVV19FfzP3ATrdQ==
X-Received: by 2002:a17:907:9495:b0:b04:2b28:223d with SMTP id a640c23a62f3a-b34b7fbb4f2mr904623266b.20.1758906816244;
        Fri, 26 Sep 2025 10:13:36 -0700 (PDT)
Received: from [127.0.1.1] ([46.53.240.27])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b353fa65be9sm397211166b.48.2025.09.26.10.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 10:13:35 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Fri, 26 Sep 2025 20:13:28 +0300
Subject: [PATCH v5 3/3] dt-bindings: max77705: add interrupt-controller
 property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250926-starqltechn-correct_max77705_nodes-v5-3-c6ab35165534@gmail.com>
References: <20250926-starqltechn-correct_max77705_nodes-v5-0-c6ab35165534@gmail.com>
In-Reply-To: <20250926-starqltechn-correct_max77705_nodes-v5-0-c6ab35165534@gmail.com>
To: Chanwoo Choi <cw00.choi@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758906810; l=1689;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=EUACCdRjiK5h0OZliVlHWHxQvfuSljSctDfK8UqIv1I=;
 b=WUPWqhaMTOLKQ+D/4kK1apn2p30UvAs33mO5aJ6sqIfx0Nnw/nfNDV2pZHlrs2krpUfFfsBHs
 XwfuilYuLUzCnpSlVva1yA9ZffRqXslFhNqsuwhhQUPagne9MVygPgc
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Add interrupt-controller property, because max77705 has dedicated interrupt
source register to determine which sub device triggered an interrupt.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
Changes for v5:
- group interrupt properties together, including #interrupt-cells

Changes in v4:
- fix commit message: node -> property
- fix commit message: minor reword and punctuation
---
 Documentation/devicetree/bindings/mfd/maxim,max77705.yaml | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/maxim,max77705.yaml b/Documentation/devicetree/bindings/mfd/maxim,max77705.yaml
index 0ec89f0adc64..8b62aadb4213 100644
--- a/Documentation/devicetree/bindings/mfd/maxim,max77705.yaml
+++ b/Documentation/devicetree/bindings/mfd/maxim,max77705.yaml
@@ -26,6 +26,18 @@ properties:
   interrupts:
     maxItems: 1
 
+  interrupt-controller:
+    description:
+      The driver implements an interrupt controller for the sub devices.
+      The interrupt number mapping is as follows
+      0 - charger
+      1 - topsys
+      2 - fuelgauge
+      3 - usb type-c management block.
+
+  '#interrupt-cells':
+    const: 1
+
   haptic:
     type: object
     additionalProperties: false
@@ -118,8 +130,10 @@ examples:
         pmic@66 {
             compatible = "maxim,max77705";
             reg = <0x66>;
+            #interrupt-cells = <1>;
             interrupt-parent = <&pm8998_gpios>;
             interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+            interrupt-controller;
             pinctrl-0 = <&chg_int_default>;
             pinctrl-names = "default";
 

-- 
2.39.5


