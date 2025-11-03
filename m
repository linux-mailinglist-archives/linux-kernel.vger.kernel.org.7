Return-Path: <linux-kernel+bounces-882222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FC9C29E9B
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 04:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 148473473E5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 03:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2E428751A;
	Mon,  3 Nov 2025 03:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1UuWpou"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22262868BD
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 03:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762139149; cv=none; b=lkWyidfxUZsw58NJ6mtCxGgyK0vA5kx5pjTduZrL1r2OrucZaERmEGs/5JSAsC0Zk1nGVKS7QtwB/hLGFTxqc5D+YOr2W7AeYByuYbzmR15tQtpqJXz2TQby2cyn5j67YCRKfHrxm+UCcy621pkF58XsjjqUjqWeC6hf35BEHq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762139149; c=relaxed/simple;
	bh=/s3k3gaQa5vELRzkRL0kZbmW5//OLC8cCCrARdlhhI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WxyX2/i0cQ5cClDCAODfHb+Ie5N4gj/ct3/eJNUnyD0KHXuAdsp9ft75gJhnTYYA4A0QTuiyF5nzm5bqSenyFBGAwlXbh8cVB06zCwmMztmKBpctmIuz4vlA6Rf+8ZTNEKOLy+HLRDBrARtgH3fPFwQ5QqugX3/u3PC4+ovw8/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1UuWpou; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-340c39ee02dso1241079a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 19:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762139146; x=1762743946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+DZ/Hzt/Z4dyeSpA3JZAv4iA86Nxbb9HIqSS2XvFzQ8=;
        b=L1UuWpou9idiDQNUAp4gJzOxH0D7RIwIv/pL0jH01rbrktcGuunhnb/8WFOhTik/KP
         VledN+lZcxX9aZzQbeQ7xgIl3unai3VCYpCTm6+uQ6okuxk44JEC0Z0ImcA/PgC7uznJ
         eeZA8gfOspEAqFdPUW4iarxkQrbITcg8Gd6JE0pjzpPXwxgaBWOaC42zImamKiQDjd3d
         kc73Vjc6ekV0m6LlUvLGOikt/kk9dWGTOHhBbD3qoo3jxv/6cCJZVPNW0JQtOdSx5ahC
         IS2ihPAG7WQhRYzsDl5A1M4NjA4Y6C9qCGjtSzL7KYDHw0FnUEDoekmGTLidvRZi6eC/
         N3zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762139146; x=1762743946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+DZ/Hzt/Z4dyeSpA3JZAv4iA86Nxbb9HIqSS2XvFzQ8=;
        b=oHqjre2j4mBKIS7uyF+z7Y9KjL5a35XxyZV7tzTyt+XU5++8TXxAH2IgQhINGQLzyW
         3QtNar1S9IyE4xXuvQ3/RQdkFrLsF9aBx/IWgubgKu5wdu0c482VJK4Hp/oydOcUvw6n
         2dqAmA8lHxVFyTtjkh6qnp3O/JYD46s793Ifh31mYD5jHj/S3SMZMye8QsIkAXAaa5le
         5NFGg6F7eRsa+lB8jvlq41TfMzZpG48m0iRzwUs/CFA3ZyMTs3buRT+y5eUfvXeMGKcB
         AZBQRpGVfdU0sMaSHlUNAseOlBvJJrNfCLyFX11C6VPjD57YeMv1KDFGgGY0PwpEyrzg
         0iaA==
X-Forwarded-Encrypted: i=1; AJvYcCX2ba8w1bsBJvjqzhLguXluEcyDS3u475zlpVVlSoQ9acAkBYhL2cTJRmqB80tH2FSDdDCmcQkAJiKUnRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3sfCr/agfsu079i1lfjpYE0kpZm33wk7m7ex8O4phjO6ieVhb
	IGwauajQqvnXp1puusnbuYwSpJXDymX86X5duRyJI8N6FNRjMY+dn3jn
X-Gm-Gg: ASbGncvAJ3NGbR3Bp0RBqawgDqBudepi9+hVeceRos/ha8QXGmAxp3yjwFyDxDrzmOA
	YjKAJTN725t5Gf9wESJn4zP8JO3uxs9ndafEW2s8J52D32Rzi157WpuDRzyeCv02IVGV2eWHvKk
	YodYK2G/CP2fGRBPXBdsBimVqyWKnzPFBQxXCK33sIei/yYPUDDToKB3ZauF5YxEfox0TUh58U/
	SRGecA+7YpNiWN940nK7DbBgEimQv10vmkWTzR586LRe6H56GWI7aXB18KExw3Fqr5A+xD4BYWm
	LdR75k0GaK3m8oIPETr4BCa1bKwT/hzw7FhtSnShk59zRTBBbV5TWoIWN/dLRXzr2iGbfCuAt8P
	Cdw03fSDEI8a1S20R/yVg1GjDTNLPy40jd7hhSnXXsQnqz7KQp8gZ1PewrXwNApwhQrRDIhwXho
	3EBUClo+lhQw==
X-Google-Smtp-Source: AGHT+IG+udK6Bhw4W8KPlkD75NTM1WqC0W+OR++Yhtjf/iYFIJkPzmpXbccgIuGWio8g01Hhjhz5ug==
X-Received: by 2002:a17:90b:4a43:b0:340:c64d:38d3 with SMTP id 98e67ed59e1d1-340c64d3b78mr7086982a91.12.1762139146285;
        Sun, 02 Nov 2025 19:05:46 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-340d1a4a587sm5157684a91.3.2025.11.02.19.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 19:05:46 -0800 (PST)
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
Subject: [PATCH v6 1/3] dt-bindings: net: sophgo,sg2044-dwmac: add phy mode restriction
Date: Mon,  3 Nov 2025 11:05:24 +0800
Message-ID: <20251103030526.1092365-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251103030526.1092365-1-inochiama@gmail.com>
References: <20251103030526.1092365-1-inochiama@gmail.com>
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


