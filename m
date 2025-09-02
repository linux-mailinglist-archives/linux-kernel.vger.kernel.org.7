Return-Path: <linux-kernel+bounces-796915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D515B40947
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 17:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B44684E83CC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 15:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668A632ED5A;
	Tue,  2 Sep 2025 15:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xQAszpdQ"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B949932A836
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 15:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756827662; cv=none; b=M0IUgw8h5Zupa+M8s5cleFNsIwkloeTuI7WxsB2vPxXI7InvVRwD5Tt4+Xg3k2cYsF3FRI/s6UjeM5kvTwpRgx2EQEdWvap3dFVRHG6IHVIpjIFR5aQfwibRKGWCzL6c/XgDoQJrLSM9/NGfxUPFjpRsnseTdlSK9KmLw6gMBos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756827662; c=relaxed/simple;
	bh=DD9yXaeypA2hr9FO3qZZJC8IuicCgOmdBNpfeVcWoM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p813wiLpfNOiNOJm5YixgE09pF5+OgWvhoWLW6Q035D0KZffwFmhGQZQah8ur0G05d9orBYVL5h5WDgLblrCVydc4ZeyDor4piowBXYUE7JAXFFv054cOladVkvtUD4iNx4GH59svh94vzUTSeQAWuxzoz2JPgzCJw/WotgbQfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xQAszpdQ; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b00f6705945so22102866b.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 08:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756827659; x=1757432459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=biM7Bjny+oEtW4RIbzxutTWTNB6Z2cdc0+Z2iihTXdU=;
        b=xQAszpdQCiziZSpbmFDVGRIH5/EtRyUnGg/S1FWhz5MTaSHyjZ+c/a0iLhESQZkij7
         ROPABJWhW8uoQeTCz106KSGUwby8K8RGcarV3QHxwnViqjwuln+N6MHVX5+JGQcphVGf
         4mD9D1cYcJeOIHBn94hvSQ4VyKahPy9Te/f/D+tS5/QZSwMhpum9rOv7BQBJb9SwHGwq
         H+VSnMfpKyW7m61CWdrtkjXOCXQh3Di+zMXch5S/C+ty2oKWpFsZqeQL6dQnFjVrRAwl
         OqL7iZow9GiokgBJlSBHAS22xswMww5upS/SLH7jri8fbTg8D0j2jhRoKfnEhAN3BNGr
         IiqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756827659; x=1757432459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=biM7Bjny+oEtW4RIbzxutTWTNB6Z2cdc0+Z2iihTXdU=;
        b=HM/lNC0ewx0ecDqT9Y9+dWjAntC/13Nah7ZLTSsgu3YBgYJ17W2MkLHWJ2zPocajD4
         AOtbnNFyO10x+OnZbIH7qatFRjKkX1hBqMFR1IB6prC6yEEP/gqYpC/QWUlaYvs/4QDG
         KCIZtfOktxmmuR4kmAsP5jY9fQZQKcHYgf5O42RHpP1R/vzTG8osJWEWXSMNrNRemdP6
         92wT+1kEVB2ZTTEpoKJBhruqlU7rBFaX2nWUGft/8bCvrzZgfMKFt5cB3E70o2LENtRE
         Jc7wiqC0XyTYIg2wUpI3KJWu5ieavRym/gvAf9HBCKrBiyzqGsOWaUjhPNu4sWzeM8YY
         FHtw==
X-Forwarded-Encrypted: i=1; AJvYcCVNwRmBQACcJIRV243hAAgs4PprQ68DmzFys0p2s+UPdUFZFGqQhJgM6PMdNlxsHuRP6Gl9zlfEggsI2iw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnc2xZx3YUxyJY5cDFxaOec01MPJbvf5LKPOfGpZ7KmG022LMs
	BlNVv7/31eYddeyh8K/RdmFnhbnGFr6A8DrZf4pEdjsJ2zVTEGcBNxLSNtVG6ZLBK7s=
X-Gm-Gg: ASbGncutgNnkSDOS/kE1rJ/cMwv1aMz4Rinn2iSUgsvNvqTKulMPDL+jpA6yPpHg+UE
	l9fk06E0g9vbb4MpNgW7iclOY8l3Scu5Jv5twMuL/rz9yq9I5mU1Bi08JHdSb/TM/yBryWrVLte
	6hjze8oi6Lmp+0pGcA4/9RLFqer9T+Wd0hOzBPz6oPH/QulJi7ewn6AwxS2d4bL7ZIWz70r3ll3
	Y4iGt/OTjZ0Sz3Gg+3kW+c8nzK51YOKvLpsnNrvxhO+UAmtoYfVaV9zbyXJ0DCQRoeoKGH2/N6Y
	SApoKJc15QqKC2gE3ln05wRCyTUGRG6ToZCAX+WWwgd8oxyADlqF+4z9Q3rB6SeCLphK3NlspEv
	/1Fm8zlWNXfNcC3Mvm0ZaIBwBdiulvgqyrg==
X-Google-Smtp-Source: AGHT+IHqvfJxZqJi2NLaX1BO2h75+SQL5o+3GXCX6kDD5SLJWDWl9iQlkkXuKU07JA390ij54jHTOw==
X-Received: by 2002:a17:906:161b:b0:b04:3333:7e64 with SMTP id a640c23a62f3a-b04333384c4mr332760066b.4.1756827658993;
        Tue, 02 Sep 2025 08:40:58 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0438102debsm418746666b.66.2025.09.02.08.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 08:40:58 -0700 (PDT)
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
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 2/2] dt-bindings: net: renesas,rzn1-gmac: Constrain interrupts
Date: Tue,  2 Sep 2025 17:40:53 +0200
Message-ID: <20250902154051.263156-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250902154051.263156-3-krzysztof.kozlowski@linaro.org>
References: <20250902154051.263156-3-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1188; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=DD9yXaeypA2hr9FO3qZZJC8IuicCgOmdBNpfeVcWoM0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBotxAE2AXqGVkkvcoMa6jmHyX5xtJs6fM/mG12F
 ql3xWH2zgmJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaLcQBAAKCRDBN2bmhouD
 104RD/9almm968xEPzjvlHGWaEROIstSx2O4TtT+LEnIzl7A7LlYbWUS1bQsIK2CPEsYTNsT5NU
 bxVJoFKk5YoPO3EubhPUUgfdCfiLbkA0AdQwi+sEsXd7HRh6fRyzxZND7F5zC07LZsS0UfpPZpD
 nECB2+rLdtwaN3qCuLT0YlPBFgNeGrf7j8tRuCtVg3VyL8cu9Dw0Xn+/l6K0Tw1z2Sy6x9qY/LL
 uxrDCVCHFkv99Z99VRTIeRo/C20Fr6xq6/NUatv72p5vFaGujQpJLIgXEopsTV62Pr8ljFLfabD
 tecCrVnC6YN4rhQRd4cN4iSYmKbgan5OIlnSneFdXA26T8gunnV9pq8flDPk+C3Pe0UQF5dEgrd
 0hrv/TLGmDsJuxK7375AwcweBBgfao8BlJkWRQoieTDkuI1SkYPbfy+bImFD7FyWLIEuSpiesP/
 KG4Heoz8S8AdFqjFJ8AWAp4z1fhS28qO7ZkOX2mHVujftP3JxueVaIvQ4daAP9PSySXjmrCmPco
 phxcZ753X5HLZ02B+63d30c9Iew0UnRuor9xudACczVOG+PUngW0Kxsj9tX+I6cKZyHUT+akTmV
 Z7OkHSHslLZopuyqVL8FLpyyJkv9aME8QmyaHYmymzjwPjCsK50Ii+ARGaCL42LVETwBhjo227f OwbKy7oAP+avSig==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

Renesas RZN1 GMAC uses three interrupts in in-kernel DTS and common
snps,dwmac.yaml binding is flexible, so define precise constraint for
this device.

Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. Minor typo in commit msg.
2. one->three interrupts in commit msg
3. Rb tag
---
 .../devicetree/bindings/net/renesas,rzn1-gmac.yaml       | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/renesas,rzn1-gmac.yaml b/Documentation/devicetree/bindings/net/renesas,rzn1-gmac.yaml
index d9a8d586e260..16dd7a2631ab 100644
--- a/Documentation/devicetree/bindings/net/renesas,rzn1-gmac.yaml
+++ b/Documentation/devicetree/bindings/net/renesas,rzn1-gmac.yaml
@@ -30,6 +30,15 @@ properties:
       - const: renesas,rzn1-gmac
       - const: snps,dwmac
 
+  interrupts:
+    maxItems: 3
+
+  interrupt-names:
+    items:
+      - const: macirq
+      - const: eth_wake_irq
+      - const: eth_lpi
+
   pcs-handle:
     description:
       phandle pointing to a PCS sub-node compatible with
-- 
2.48.1


