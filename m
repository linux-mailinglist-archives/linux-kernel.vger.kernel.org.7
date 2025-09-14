Return-Path: <linux-kernel+bounces-815674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E799B569B2
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 16:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26B233B9EB9
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 14:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2BD2222A1;
	Sun, 14 Sep 2025 14:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lEgFIYxg"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6509021576E
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 14:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757859483; cv=none; b=u4taYRyF/J87J+LOkjd0HnoTCTgTj3IsPER2f2ZreDN/TCNUvNfCnklximdG37UvGFRXT+6gR7YrMLJ7JOXiV8VQGvJp5hAYhk+V4ntYy1+7CUPeiz/ZcPlelwRjeW+g/vWo/QMrbPheTZXuge4Dpdigf6j0yfUv94UG5fmK39Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757859483; c=relaxed/simple;
	bh=DmOsX7Vf/ilavkrwxUtj9QNM909CJQfFtlFDgRHasuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VTDZqnQnm58ZoTUSag5upVOfQb8keYGvqRmVdQaNzBbN/apVcqPrd/rysp7z/UssBYsMdLJk1UmvWGxbelhd+fAGejiOZQR1bh1IvWf3v0SOJfP7ABEwUTZ9cxrmYXJ4aYUPsyJX6dsNcWr7rc8ebRNcx9SRz3EnUpX6zogpPPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lEgFIYxg; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3e4b5aee522so2007644f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 07:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757859480; x=1758464280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WLnk4ZbyfQe9FhVo0Iaf0C5FfaSInQx1UG35rxo35j0=;
        b=lEgFIYxgLGHYqJn+ddhQ28oIZ/tjQi5GuPHuzoxr+Bn289qSDM276yQyFigIXMPG8L
         419MkelxiTX8SXCa0ngobbcKxNqUdomev6m4ZmRy7r0Os9YxTkJl4RRXW2ttzm+sS4zS
         9IEyF7ffKYegwSe99ElP7IO4xVr8kelRwbnu8iJtfJL4Z9hehRE3DLomRaRQlntbFUf0
         FitHnEM2c3we7suSR/9BdVIktzdXKqbeeqRkTBKaoWoK9VM5Vq9+briz/pu1j7MJHgTt
         vQtFL6OKPs59/xfRZOar+Rt99oO9PBz/cuSAyC88KuhP8jQi03wsyC6/EhNBXpkvEYKL
         915g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757859480; x=1758464280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WLnk4ZbyfQe9FhVo0Iaf0C5FfaSInQx1UG35rxo35j0=;
        b=FQ2uJZvkvc34o2Rxdn+qBT/F8S5hneeSRI6S/MsSCtWRrNiSZafnrzurrcxqcojouN
         k1XFh/FAs5v7JZJG+NiepCP3jHd8YUzjhcYwZH373VOVnxHbcwLZNMW6DgzkiyvSmAnR
         ZzJZuNshBBzfA5yo7sViqjl9+RNRrZcpPMGapLPz9hFPi0DqkfkyCebGl4/Q63deT2h+
         YOi/CWLaGZ1DLqyNZoKKnJPbSH5hJbuWAOA333+ajpdh0IfsDAGRYmVH1hDRvbBSrdCc
         4YeSr2i6rI71BvtEa7kZ7hbLZsq+s/P/C6bxEXUa3BqGsJ5pNwOSI8khbFr8oRPhkq2U
         hvCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgxPHn2yRKPgm5DJ7EZ8yg4y9J6Fgi5OdYExLxLY5TG2yYhedyVDjdoZsYFCvyqHEXlNhL6qiR6zGOcXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUmOWX4Pq2PeJc6xyfSczQP597t+bhjl0/oWSiTkcsRzDBphep
	ZEQNYUCQylCJXD3FBMldxktg2LmZSitd3SfJ29DLjrK/GkyWAO9dEha9
X-Gm-Gg: ASbGncuEBbpNyLMjxriRiEo7ffJwbmbriRAMPm5xTI9wCOsEtlGnGT4TGQXJGSmAuuR
	qiMhftBi/TpVYSgr/xf3TowlANL1G314Ns2Ax11NX7U2apqXgiYRNN3ZAL+zwG5gufA4ggkVPiF
	7OSdNrk5fSQQ1oqdjn+lLvZ4zUfM9qDf0m/RS7GTxYg6gIckl6unBQEcnDKDI5M24EQ/NVaq0rq
	Mp4+MuYr19k7mmiScAL9+1Hb8QI3h+jG7s8aSzV13qOad3NySJ0SxWwuiOevMxV4NeefFDzjgU3
	7Tx1qyBOrJ0HK/qFUGJBM5uB72JiA3fbcLRDK2J3s6Fd/aFwbCtmY1DIe8sR23aoSv8sv4nmwCw
	htjWKjCmAKlMQzUWa7/8BLvpCVlXyv/70F5MiKUOqZt24vyiLvIZhTYoNUJBPZoqHEwYidMC6WU
	+llYR7WDt/
X-Google-Smtp-Source: AGHT+IGob/FXoyz3+A1gJIBnwRTgWRN15gu4QTGHa/hPMhwPvI0q1Q0NHBycPN6rl7zOaTPDOVjCoA==
X-Received: by 2002:a05:6000:22c7:b0:3e1:1cfc:ee90 with SMTP id ffacd0b85a97d-3e7659c4a5bmr6355341f8f.30.1757859479650;
        Sun, 14 Sep 2025 07:17:59 -0700 (PDT)
Received: from ivaylo-T580.. (91-139-201-119.stz.ddns.bulsat.com. [91.139.201.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e813eb46f3sm7319270f8f.23.2025.09.14.07.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 07:17:59 -0700 (PDT)
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
Subject: [PATCH v1 2/2] dt-bindings: phy: samsung,usb3-drd-phy: add exynos8890 support
Date: Sun, 14 Sep 2025 17:17:44 +0300
Message-ID: <20250914141745.2627756-4-ivo.ivanov.ivanov1@gmail.com>
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


