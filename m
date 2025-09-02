Return-Path: <linux-kernel+bounces-796914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AB0B4094D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 17:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69E0A167BF3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 15:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC00432ED3D;
	Tue,  2 Sep 2025 15:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XHP3WVI+"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34D8322750
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 15:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756827662; cv=none; b=Ep7OnJprY+Br5FaOYgj3Hc+wTtU+ax7OECwfakHeZ6JHEPd5xvyrwrCpiVS18hbX5IfVZMZIXJDRzJeX/0RPrA+sdQTaeQSnIldk4gKPhiwIEhyZVdxNeRMYtOoZlvuuKTV3QSmua0LkBt4kKlmOG/oFjtJZBOmZilCUDRHGM9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756827662; c=relaxed/simple;
	bh=sFLVskm/GZvqeQI/f+rrxfYgvGE1+3DHh+EYMzpJNhc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j8venRjnURjIqNVZZ4SKf9XK7oBknIVKXDgxiZIr3P5B5ckA/4iJthwexk3CTAr6A+5QVI9ycewbCGrFnnv72mzfHUMnQwJCk4E+MGquxToWX2nzVfzKsYTkUvKgcZG1rkdhQqoWeJzo0aMEOTziZfmFoCXC267JImKTsIZ3pNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XHP3WVI+; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b00f6705945so22101966b.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 08:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756827657; x=1757432457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wB2hOz6NFjWbWAhm1PV1EJGvhxwPuieGYAKDStpXw6s=;
        b=XHP3WVI+RNDMqCh2yt9MR3dr5UtbbYHT2Wz2J5EYxUGWv9H6xCpv24rlB1wQJbOW2G
         BFwKOtkFkstQEpyiat3sKKgCYFTJ6684+/0+JuMnpgDoDnh3Ebp/Svo0lfDC21GKAOz1
         QzS7Zo+cYl0UzXmpZeaVR3DGA6WvDLzN5YaV9/ESdF5DAiL4D5VaiBTupL/h5cSken9E
         Er02XsJwBnfAxGF4EGI9MLWHiH7XJu5BLuaRrYR4MoqRxt/sR52QJk2tJZkQmF7czjTy
         gOqvM15GPkdu1rw/Jqq49CI10/QHetYDjfhVWFOI3dWhVAag37w223zZVMk3Xii0GeBo
         /LJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756827657; x=1757432457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wB2hOz6NFjWbWAhm1PV1EJGvhxwPuieGYAKDStpXw6s=;
        b=hCtFcXASoZd0ShyCiuTFUeNnNoXN2h7uLxh9Ejej2E7mBkhfv+BJpo4Isj/DI0u3KF
         c3DP6nj1GJRWfcHZqUgB/lHgMb+20WQPHAFi5qdWjgPKWbQ3g5TNF+qoYitVaWuOfYRf
         OlBPbXgyAMqmvp4764KnrfZPm+lObXAIGlcdbOg2gIPCQJyZ+d8TYv51yVG7DrGwng+0
         T7G/pTNsYvZKJUa8QXVMyhE5yhrUP82MbDQBmHTRAjPs/Q7CKFPI29c9X034f/Rnpmcv
         FJEzpTMVG5B/V40Q/p18OJHJZVG+qxf9odXJDE4QaG1jPoGItKvJP0ye/PXxIn+0TXRO
         no/w==
X-Forwarded-Encrypted: i=1; AJvYcCVSARPZuA/tn4khnNU1dfH4Q0XNWQ0ciUREp45O2ZBE885AV7U7nsTHn0FJuWSdqBnEdDVgBtP+3SKU3ec=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbfFKFouUrACPaPoFryXKUZi43I4+pTcQDKHFatPadGmTdMvKN
	VDzHnXfNJ9A4Y9S1nvT7iBG5Ew+hn6rACc4DlWShB5RFywVTKCTXZf3GLVdZ34nQxPc=
X-Gm-Gg: ASbGncuxn/EhYpbCrMTJ14J3dLtHUgFFDcDfnrF01joP6MHbQUmhgwnT5+kVMV1pWrt
	uLVDDqo+rZYCnnw4RtJtNZnsdAidIqBSKJuk0w7b3LqjulI+Y01yG37bmj0x6ZLPM6JppF7eGXi
	nGdMQpshxryjXMfxTtU2Y9PWleGi5oixQKyIpsBwE4yuLucsjqa/pPmImMAv4TwXEQuAGLP2UNR
	I57otuSM78mz9T03XGmOrkOdOGB1SSDUHKS/6CXx9jnrYVDFh4whpfGGvQd6Q7BS50Vu09OkIL/
	/MFfcUN2aq0ZcJbaZQHM7SpVkDgVLy0HFTbLYSphTSd4D9qja6bDS6CSeqw2qyFHrxvQtAkzc6w
	UwSk7UweUKXCgKxJTH/Glfer5P1SsGdrr3A==
X-Google-Smtp-Source: AGHT+IEWMtUipiwvP55o7SnFFNedcIB9J8Y92SnsL3bGTAtWU6+jlkNHHkULu5G9fMF+Xt5W8a2bmQ==
X-Received: by 2002:a17:907:3cc3:b0:afc:ebfd:c285 with SMTP id a640c23a62f3a-aff0edc4d6cmr819502266b.1.1756827657134;
        Tue, 02 Sep 2025 08:40:57 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0438102debsm418746666b.66.2025.09.02.08.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 08:40:56 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Matthew Gerlach <matthew.gerlach@altera.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/2] dt-bindings: net: altr,socfpga-stmmac: Constrain interrupts
Date: Tue,  2 Sep 2025 17:40:52 +0200
Message-ID: <20250902154051.263156-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=968; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=sFLVskm/GZvqeQI/f+rrxfYgvGE1+3DHh+EYMzpJNhc=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBotxAEs7Pi4pRQzSl+H723I8RHNxnqQ8YsTSkC4
 vkxAmnxXj+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaLcQBAAKCRDBN2bmhouD
 1+k/D/0UuXc2i9vi5ZJEk2QSnLsML7RPV42gQabAHH1WKmWnL4CAxBu79LPPNM4a7I1ooZ1jhtF
 Mr0HfnWsGPBrGmp8I1/uv/bXwxzHoXkai/Nz6y8C7yM+JNberjHA+TiBdQVzwbVM3RrI3EPANB3
 lWmBIcSxHKokKT6EaVY1AKnmFgurZZ6y0eBstHMsdJ6ELNsyPVyS6BaAUipo++or72IL3/XbP8t
 o30+Rbvby6HDByLMYbdefwjD4wAzJUzz8Y4uN+rOxXGvErZC3E1bvX2mJG5WVYkRRwTSN+cWw3R
 YUEAJdS3sN0m7TIPexcrKhSmyvNL+7CebE/kX8UNOcms6KyQpmTkmoiwlKEITwCuKHu7rqCcloj
 kXbG0f20Poz5QjpvoBJMOu13+2qCJcWhUCRNVXOGGHVR1EEKa71BYZzwH+6eM1Di4nxFa901haa
 MPJ/wDC6mZ5vqxoKG1aMzF8c5gTYUdO8z/1pyNpGzkwLLdQdFo+k33FRQmngLKLdN3TmFgHHaya
 RVG8d1yntleXzsQP6HRY2mICIMlwAy2wmRJpiusUUYtjnOE96Z3zIcA3TBfTXlXA92EGeJtuUKv
 O16pHUiaXsjIP1644k6rtwNhNVpYEVZ1NJokD2I0xZ5+2h1/Xa7D3vHI9tqIkagc3GnIv4q92i7 pJ52l3zbCm7aBLQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

STMMAC on SoCFPGA uses exactly one interrupt in in-kernel DTS and common
snps,dwmac.yaml binding is flexible, so define precise constraint for
this device.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. Minor typo in commit msg.
---
 .../devicetree/bindings/net/altr,socfpga-stmmac.yaml       | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml b/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
index 3a22d35db778..fc445ad5a1f1 100644
--- a/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
+++ b/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
@@ -62,6 +62,13 @@ properties:
       - const: stmmaceth
       - const: ptp_ref
 
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+    items:
+      - const: macirq
+
   iommus:
     minItems: 1
     maxItems: 2
-- 
2.48.1


