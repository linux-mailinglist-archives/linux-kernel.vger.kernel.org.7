Return-Path: <linux-kernel+bounces-890279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 94937C3FB25
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 12:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4B44A4F11ED
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 11:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07807324B2D;
	Fri,  7 Nov 2025 11:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezilsY/Q"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B94322C7D
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 11:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762514262; cv=none; b=pqajmeFVxS67fknIIdXLAG0Jqz+CogzPSCH3q/FOf5xZCm86nUkVN9ho/dVAexdQAVYve7Ud2T/gxOTcj6SYkCsdQ++7S/rLxo+W0IPSUZ9M7ZE1OkT3wAf+7MHwcIvJsPV7X1TcWzRgQoJ6F2uwzGFpfhWwUK6WLnibh1pqpCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762514262; c=relaxed/simple;
	bh=/s3k3gaQa5vELRzkRL0kZbmW5//OLC8cCCrARdlhhI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gSmV5oDNbUGO7dzmWkAXpByKOGiazFeNWlLWJVRb/cqxcN2Zj9stYzNaAHoaHYz1MUZ0BSJetXjST/OQLX62M9xULEAHD+M+9mfQURFjzZCRoYdtwSoGtLlqv7aAoy69jrwrU5rVgAkaoz+uFdUHHIxnU6YlrR159mTvGQ76Y0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ezilsY/Q; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-781ea2cee3fso538614b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 03:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762514260; x=1763119060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+DZ/Hzt/Z4dyeSpA3JZAv4iA86Nxbb9HIqSS2XvFzQ8=;
        b=ezilsY/Qa3PiFl6X9LeVDH2A0a7gKBHbBqWs2cwo/aJ+cgr7wRiPQepenViWVBUEtk
         vjkmftqgYAgCuaY+EkhaBZ5ecBkbcrcQwq7hkCk7xkn+z2drBCXw5GQHEjCD6pmxxrvV
         zTdjM2Ybf6m2LxwalUHXdcvg0TPxSzlg8bi7LKDqxWqGpI4DvHHqWGcceRHwGzBIdcJo
         IMxwfFfhHQOJUnL8iVy3WLCsFafVTECyXxjUCrP2q0YXWP/kPd0HAB84lX9erwsXXj1U
         RJaUyDpl0E38VlrbWuhhlFzJxOBjoU+AzrN16J/AVf12tLi5Gr0BhH6QYRIbdtK/OXPx
         D7fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762514260; x=1763119060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+DZ/Hzt/Z4dyeSpA3JZAv4iA86Nxbb9HIqSS2XvFzQ8=;
        b=mPQ4oWXK1Kfu9UHZYm9AC/T1LyipRCQGDUNkKbJdp6u3OEIf4BEV/H2ofCJ8wH4EHc
         pheDpEeJEp9oVATnmEOzqECUGy+3t6IE8dJs+HFn4jsX8RmUYLMgKvees4eqIpvmWehy
         3wRO7HX+xxU7V+6AXld+YMR4JCQxpcKFjQG/pE0z8vNs6h6NLQ6nWUAlc7mTV+5KH/IC
         RHIJvU+R9OCr580uUOiA/eKM0wOVhG6GEFBPk2+UiwGXqgutG4/CxCrxNE7oiXYLu5HH
         gZrAovyVgzr14JbutIuwZ5mDnwj5TGgskuy7O0BLK8EP5j/pIy4ijWhrON7zzdr299sH
         Lddw==
X-Forwarded-Encrypted: i=1; AJvYcCWkyADLXL/X15NqqgAlil48XZpiZw/NNGbR6OZpNIggNNUU4JadcHi1m3Nd8AMUiZhF8CW8q1F+lOfG1lk=@vger.kernel.org
X-Gm-Message-State: AOJu0YybMOwYSgOSQxyFegS6kz08ElZXkcihekMh8WHeCv74D94jQG3m
	vKKzBEVKkgjpwgwoLdZXGV1ZyWSD71HUITK/3HjY/YSUJHwrBM3mGrJU
X-Gm-Gg: ASbGncuqofKNEykr7XXSajBiCeuCtv7UdaadHuO0OuurZysKyoN3vDG/r74thYXWf4P
	b6KVjHP0lzmxujzVF9Rqt1jxtdDPkJaEd1udS/OKTWdCi07wFkXYZNBFEXitFNLdV1BYB5EV8Pz
	dcMJ3tawqwr3wDwcLTtLL5KXq1q8F2Y/WLWmK87iNVqY4Gk46VTmuU0LeiWmtLXSl1t2eq2G1Wo
	gciXvCpdQWuASCl2wCm/1EAVuHxVXOYGlaMDH+okX3oVLTn2CgEwmuzaXP2OUYVIcod78x9mouT
	dDgNcHKzfCV1St6tiRJ8WPab1eEelJK9CA6g1+X2SIsNkd8NxJXFk4nynsto0CoTpskPwRwmT82
	R68I9lupBdseZrHvin7jJKsRAuTakPNTUPfNNYA2Ah+UCsHmmWVDEqbw1pyeDSNNOewzoTib7JI
	c=
X-Google-Smtp-Source: AGHT+IHjf5f+YuLvxkmcrd3cJvkmjsyY1yheeW5iHSKdbzLJ/p2M1xTgPY5ean6VA+ewJk0yolgl8w==
X-Received: by 2002:a17:902:ec90:b0:24b:1625:5fa5 with SMTP id d9443c01a7336-297c03b66b9mr44655785ad.11.1762514260220;
        Fri, 07 Nov 2025 03:17:40 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba8ffe3616fsm5131381a12.19.2025.11.07.03.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 03:17:39 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Han Gao <rabenda.cn@gmail.com>,
	Icenowy Zheng <uwu@icenowy.me>,
	Vivian Wang <wangruikang@iscas.ac.cn>,
	Yao Zi <ziyao@disroot.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v7 1/3] dt-bindings: net: sophgo,sg2044-dwmac: add phy mode restriction
Date: Fri,  7 Nov 2025 19:17:13 +0800
Message-ID: <20251107111715.3196746-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251107111715.3196746-1-inochiama@gmail.com>
References: <20251107111715.3196746-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the ethernet controller of SG2044 and SG2042 only supports
RGMII phy. Add phy-mode property to restrict the value.

Also, since SG2042 has internal rx delay in its mac, make
only "rgmii-txid" and "rgmii-id" valid for phy-mode.

Fixes: e281c48a7336 ("dt-bindings: net: sophgo,sg2044-dwmac: Add support for Sophgo SG2042 dwmac")
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/net/sophgo,sg2044-dwmac.yaml     | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml b/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
index ce21979a2d9a..ce6fc458be61 100644
--- a/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
@@ -70,6 +70,25 @@ required:
 
 allOf:
   - $ref: snps,dwmac.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: sophgo,sg2042-dwmac
+    then:
+      properties:
+        phy-mode:
+          enum:
+            - rgmii-txid
+            - rgmii-id
+    else:
+      properties:
+        phy-mode:
+          enum:
+            - rgmii
+            - rgmii-rxid
+            - rgmii-txid
+            - rgmii-id
 
 unevaluatedProperties: false
 
-- 
2.51.2


