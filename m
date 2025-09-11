Return-Path: <linux-kernel+bounces-812178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5313EB53413
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 15:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EA021C87976
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 13:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EEB133EB1B;
	Thu, 11 Sep 2025 13:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SuxQAa98"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B50733EB18
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 13:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757598046; cv=none; b=Zql7KWxioSusJfY/SwO3jzDBZ8jdacIILw3QxKGjMI6bnnlNrR+dZvTxxcG6agKVj8FUD2r7gSWOAjQ3XhMC2lH1ULRVpN5Ly9YMV6Cm7+fRk0rKhYz0EmgSdBjIfJeIHLatMNyXtzQ6E3F/Mv0k7sV+WF9Vz5PoRyx7z3bVzPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757598046; c=relaxed/simple;
	bh=cR+i0j2nFSKam+gq7FWSsr5apx+a/lZwZMhEZIsHfcA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OlgqE6qo55DsUa617C3UXVMWNS7vxs5WpcjF3K2xyXR56zIVwQvy5PHOK3kE+aVTP3iDvGsPOm4GNb2sJlNpUY60PAUVHCSVgUoVNdaPUqefgLD/JWZtdhnV94WaHtKPObhu0rO+Sq8DM6kJk5G/rHwtoERagnWAoLoTuX+Q6fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SuxQAa98; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45de6490e74so7344605e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 06:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757598043; x=1758202843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HxXWRqnFqGYPd1tnhNthT3WKgGhl9VmDbyQfQ/+snwM=;
        b=SuxQAa98uT2YzbAANMDIZgzMnMCwLVaPwBorQtAJ78TaFoSm9A+mQBTfz4UaT1YVGM
         hVCzl0sBQHjmOSqH9D7dSO37jV0QmrDSv1MsN+WIf3ZN0F8mLBngYU7dWVBkKDPiYddw
         HoenTvB6+lfZge9JbhdCMMc3Nun9SLoVOZM5sEBhnLpB27a/Ayt9FI046y5bDY7dIq/+
         4WO+nEdPW8OV1mLQDw3DlSkgxeRD+KuVYlX/IpsVFk7GdyiGkCwk2KqF/K1uK43RBX4J
         LA6phTA10kNDC+JAjDFuqJBqkReBQyD8TsCvj0nnoJmhBV2V+mh87//oJIgarJxWK/u5
         husQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757598043; x=1758202843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HxXWRqnFqGYPd1tnhNthT3WKgGhl9VmDbyQfQ/+snwM=;
        b=ZmLDOZ5A5EeotrrpPr9eyNfU/uvO1FgdCdxQgf7QjkC0JniXdozFBQeCTEuWkUJVeK
         bltu+evOtAb9+XTzvcjshNO4E8x7zSRqaN3TZq1l701kSdBCoPjnvGONJJerBwXATty1
         vt54gPv1RBBgO7HaB11C54sn2ioplMNzVFpuNhVtUqM6GkTg5aaslCarlnhS2BrDZc70
         ZR3yR3ju3TrRm2n8qaX7oRHrlWoO17hPv5qUG81agZWOfjb8pJUUhaYgiN7xEPi5vZoi
         wPIwpTxhGg0spJ0ko90Nlr70r0+gRCJ8vccpCQowgzd7e6ypTtloake2+PrMW2qAf0bh
         VmhA==
X-Forwarded-Encrypted: i=1; AJvYcCV47R4vfrRGYDaV/PRGuUUJf+qZpr6wAaJF2swjoKXQELsXiMLlTI0H6Oc237YFTiRcy+2VPu4o0rE9888=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRVmWb2q+34hZtvX+bo/YhVDOm1HB8QJhsZEkiItAAbLiG+GQ5
	j6MR0xy1d6deXe2rhBBVty4yBhnuo1tofTT29FyBj0VVAVxQpZerWpp6
X-Gm-Gg: ASbGnct91Mc9nxBdhvU5yUmOeazH7+IJB2MTZshZ5p/StpANS1SbjjqO6N35HR58QVH
	FqUs4d0IIcbz1/mZY3VhZ7kQfZrKJqOmx4XeOXFsP4throWPXhUnl+USV0eTkeAabL0kBG5eTZo
	v+H/m4qne+wDmL0i9NJ5mWxL9aJLrOAoTVf87Z9VIZdI5KxGQQ4N3OZfCn7Rtb+AwNJtDcn1vu0
	I3gPIFk15s5oUMJkXBSqQggC7sd8k6i/x96Uu0A9uPSVVkVa0cJCdVrOi8W3tmrnsgHuZAoSL1E
	yvBPbjsSe7XPCS2UPEpPNwrB/6L8kKiJf41H2i0lagd7nlX3gC3K8Wv0Sxaa1MEC1fQwBLmiA5g
	yzFw1sm58qHIZshOOmzx+ggQAP3KX+Cy9JHgO4MdBCnpfv7ZdS94txjSCqGfMEdugH+7I/h+60O
	zhjKoUpw==
X-Google-Smtp-Source: AGHT+IG2KpWHVxRYHBojS5qhqOAZS3ZPHK9ADJy0kEMpbU3Dfi9X/AHkq0y0EQaVaEvtw7HYElj84g==
X-Received: by 2002:a05:600c:1d16:b0:45d:dd94:7c09 with SMTP id 5b1f17b1804b1-45ddde955c3mr180709415e9.1.1757598043155;
        Thu, 11 Sep 2025 06:40:43 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45e037d741asm23413475e9.23.2025.09.11.06.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 06:40:41 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next PATCH v17 8/8] MAINTAINERS: add myself as maintainer for AN8855
Date: Thu, 11 Sep 2025 15:39:23 +0200
Message-ID: <20250911133929.30874-9-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250911133929.30874-1-ansuelsmth@gmail.com>
References: <20250911133929.30874-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add myself as maintainer for AN8855 DSA driver and all the related
subdriver (mfd, mdio, phy, nvmem)

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 MAINTAINERS | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b81595e9ea95..818fe884fb0a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -740,6 +740,22 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
 F:	drivers/net/ethernet/airoha/
 
+AIROHA AN8855 DSA DRIVER
+M:	Christian Marangi <ansuelsmth@gmail.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/mfd/airoha,an8855.yaml
+F:	Documentation/devicetree/bindings/net/airoha,an8855-phy.yaml
+F:	Documentation/devicetree/bindings/net/dsa/airoha,an8855-switch.yaml
+F:	Documentation/devicetree/bindings/nvmem/airoha,an8855-efuse.yaml
+F:	drivers/mfd/airoha-an8855.c
+F:	drivers/net/dsa/an8855.c
+F:	drivers/net/dsa/an8855.h
+F:	drivers/net/phy/air_an8855.c
+F:	drivers/nvmem/an8855-efuse.c
+
 AIROHA PCIE PHY DRIVER
 M:	Lorenzo Bianconi <lorenzo@kernel.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
2.51.0


