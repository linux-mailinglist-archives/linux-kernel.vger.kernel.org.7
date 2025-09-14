Return-Path: <linux-kernel+bounces-815672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6813FB569AD
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 16:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D9203B9BCB
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 14:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09EB21CC5B;
	Sun, 14 Sep 2025 14:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAs78iFo"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9171E47B7
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 14:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757859482; cv=none; b=C38T1Aqyk5pBI5o52AxaV8lGFr9Ws0ITsW0jPGJFLOwHfdzVjKj99fGFIBVpDG9GzT78W3eAb2bjMdwnz9slA6ZSm/cBx3OQh9FWZ/0xyPvB/nZj8MoT/IcfNXLojYaWqq0o0oX7KMR+NE8xKB4Fbroi9ds3dDBU4XGTnap3dB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757859482; c=relaxed/simple;
	bh=DmOsX7Vf/ilavkrwxUtj9QNM909CJQfFtlFDgRHasuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AhRaZiN4tr1P+tQypeVvklyK4jypWXt046D/khzIHOjxRvnEvZcSkEioRP+c9s8ScI8fkQwXvxfh4wvV1R/iIiqQgpw/eD7NJPVoT25BZ1dQomwzmJ37ImkBHr6xnxKfsogyBrUMRZHi6NxUUPA42Go5BYmMujSLrtYj7drjwXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bAs78iFo; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45dd7b15a64so29837005e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 07:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757859477; x=1758464277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WLnk4ZbyfQe9FhVo0Iaf0C5FfaSInQx1UG35rxo35j0=;
        b=bAs78iFo5RW2G8RUQ7HG02HMm55yDkHX3miJkXl+rYXg/Wb6tPWjYpndPMUwU8H3R3
         hHsJB8+741YN65AQqOyF1SgbEEqINfmg5kTrblKuGzw//KTfBybI2ZQbiV9ley1NANRV
         98xB5vSNqlew6HeCNIBMUB/jFY+FtqBCfzvnmMu/fGcQ6L1vx5Ka8U/p9FXwQaKDLjEY
         EV0D2Ix80wG91CfX46o79g2/B8V6kaY/tS68EbgGTxc1IW/4N/hhgFBjHRFiN5kIZDaE
         CuLS85e6a7+xlSppknHLwLOlb+qX1FNDMnO6IqfN/HULsrNC34nCrC2VWf3iaZm0mShS
         byJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757859477; x=1758464277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WLnk4ZbyfQe9FhVo0Iaf0C5FfaSInQx1UG35rxo35j0=;
        b=H7kFwla2rkfe4y3DqGDt7O+JPqREfN1FpoCfrX3ukwMWKpInEzDSob5baKf7X0LdSy
         Ep2igfP77vGhf62csZd3CvLg12YZ/nQ89O9OM9FO2ffF8JotCYPnIc8j2jp7Mo1vCJ1F
         FPUClNT99A9Z5/DqXmnbwaJanYh5nd+4r60BFukIb2jOUf+9CCYQMwbcm+xMB2fLfc+4
         DP9se94teFThB0xnAPqwuAzul4RW1MzP3Aa/08STqE1p9iLjiUXc9196jIyHIlMa/hUm
         WvcjnoQmE5mKjCbsj/9fEDeuuZLOPT+T7BnmzJBk2mDnxju01HEnneWij9S6uUQLsk94
         mXpA==
X-Forwarded-Encrypted: i=1; AJvYcCV8ZBPpfieolCVJfUm0pm1wIemo2WP6voFq5KZhusfwLWBYqAFWXBxALFb75C76doctYyMMO8AL6z77gG0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhvm6Zz/7sNJWBif8fB9yhIUcqi69IatWB+lBNoJi4N0VSky40
	LL78jBHhaGyL7yzCLecUYnhycKZYskbQOuQsib7FqpiHa1BNmXd+VkyU
X-Gm-Gg: ASbGncsQPcraZ25qu3EU+3NC9EyVpHCgufJgXOZvr0Oo0PVjEjxpec2UKHC+06ImGK6
	ChFbmpgF9FH3R64vFawitDsREKGg3w1o7hKBTEbMSq4mMFzfLNKozz1uPX+BAFPoV1Ezd63N2J/
	DwxjeRBtK3qZq+YojAsdHQ37bWiCnmZrc6Xh4TBmpeuAzI/vTxODyXpg/kFLCN2viIR1nroNz41
	zuikmpA6+tQSn5vfE4CSRIbJ80PINMH7hSbOwOOjShIa2Awy0oH/GEYx4t9jO5izY1zBE/CANb6
	aKEu/5yiXU41XU1uCOMVcPrhJ2zhrFjootkktAL9lz16hOTljNRTpTf63g/LXt0uMiTKFlSMGRx
	0J0lQTVXHRza9bJ0EcGpfKptLDQ9UUAKtOtL6FWY1+phI6kpvuLtdEABphGQB8bG6gj4lpi9aww
	==
X-Google-Smtp-Source: AGHT+IGZa2TxgX8agd2exKpvk7TmNbKmYcyR1Hha+oaP27Kljq84rYHxWKx4npcT6+CgUwnc/mAUug==
X-Received: by 2002:a05:600c:40c4:b0:45d:e775:d8b8 with SMTP id 5b1f17b1804b1-45dfd5aaff0mr93879005e9.1.1757859477068;
        Sun, 14 Sep 2025 07:17:57 -0700 (PDT)
Received: from ivaylo-T580.. (91-139-201-119.stz.ddns.bulsat.com. [91.139.201.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e813eb46f3sm7319270f8f.23.2025.09.14.07.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 07:17:56 -0700 (PDT)
From: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] dt-bindings: phy: samsung,usb3-drd-phy: add exynos8890 support
Date: Sun, 14 Sep 2025 17:17:42 +0300
Message-ID: <20250914141745.2627756-2-ivo.ivanov.ivanov1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250914141745.2627756-1-ivo.ivanov.ivanov1@gmail.com>
References: <20250914141745.2627756-1-ivo.ivanov.ivanov1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The exynos8890 SoC features two dwc3 controllers with one USBDRD and
one USBHOST controller. Document compatible for the USBDRD one.

Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
---
 .../bindings/phy/samsung,usb3-drd-phy.yaml    | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml b/Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml
index e90640320..2b1544baf 100644
--- a/Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml
@@ -33,6 +33,7 @@ properties:
       - samsung,exynos7-usbdrd-phy
       - samsung,exynos7870-usbdrd-phy
       - samsung,exynos850-usbdrd-phy
+      - samsung,exynos8890-usbdrd-phy
       - samsung,exynos990-usbdrd-phy
 
   clocks:
@@ -209,6 +210,30 @@ allOf:
         reg-names:
           maxItems: 1
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - samsung,exynos8890-usbdrd-phy
+    then:
+      properties:
+        clocks:
+          minItems: 3
+          maxItems: 3
+
+        clock-names:
+          items:
+            - const: phy
+            - const: ref
+            - const: pipe
+
+        reg:
+          maxItems: 1
+
+        reg-names:
+          maxItems: 1
+
   - if:
       properties:
         compatible:
-- 
2.43.0


