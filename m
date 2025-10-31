Return-Path: <linux-kernel+bounces-879337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A77B9C22DF3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 02:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7141D4EC431
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 01:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A319B23D7F8;
	Fri, 31 Oct 2025 01:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajOjly6+"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDE9248F77
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 01:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761873898; cv=none; b=F+bYnm6Adw8G8qT3pRj3VcAzNEzrs5eUjVoB1lMCw9uRIUelAqBSi1Mqv7Rjd8jJ6QQziurYWDcVa5A2iHa2V6RQ9dle90Yo4NvN8/4q5daQ1N7riwGi+MjMyyQ+57SyVFDvbNswdiSs8D+CbbQPMoycYm30FBfBbAQHKcgO97U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761873898; c=relaxed/simple;
	bh=n/NOeusvOIuwuiyL6YDKNwZpNTHixN6YVX8wwU6wlnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BFWW/r0ilPPrn40GFEXOZx5zluIryvbDzm4C5v59aP3zWRBgDkeBdEWK2xYkvchEP3WVqT98Vf83GrCk8bdIclS/4ilLMnY5tQ7OLvnfBF9vawf2n7QqFsVaUs0nQS8Gc4As+fYvdvcMR1BYsy515NF3VDJex6HdgylXGLMdHi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ajOjly6+; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7a74b13f4f8so700541b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 18:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761873896; x=1762478696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x3s1Pf2chIyJ4GtiDiT2mhsesiDGOlvUaZYqYIQFp28=;
        b=ajOjly6+9vKFYHlh0ZumYpLPxJ0cam7l4DD/r39m1opbxe8CP16SmgdYXnVRXOzucs
         oxn2+QS4kZGnFDZJK/34ZSYnSfPRZXDdBfKeBszUz4L/iaCT8y8nst22UVc9zzZq62dL
         asawvdGcjui8CbQHNU4lm3h+aIcaFkiNvPJEO+7cdaphm7vCzOtctzXzC4ThvUrqx3KL
         TuPC7ikkVqvzLJPxI51cdU15pbrgAszgtbRncfoa3qGWCNTo4xtfyP66bR5k4wenJ0z/
         7KehBs6i2XiftEsR5FM0JZJv48Y5hHOlP9PlpEBsnVbI8ribLQEPKgZm7VkuHTy4chzb
         WL8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761873896; x=1762478696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x3s1Pf2chIyJ4GtiDiT2mhsesiDGOlvUaZYqYIQFp28=;
        b=om2j4WcpwancAYjUDd0g0ZBmmpd1rQmU/Nf5FUPj453dy9GpNzaKMLgn0hw8QyeZNj
         s3i+3hjWZ+lv+Gobgsv/17Yj3KNgQx3O/stABuHVe8lziK/n3ShZidxiW9Y21t/sjnhP
         ir6EMi6KFMmx8ueG9e8XTIUrfKiQIrixG2+iYlbptMTkbOCFrpEIWYq0Nu4ceTUOay1b
         q2t6YVuuFDC017et+/KbOdpDOYSbLIpgmxbsUa4OFIUePn0WPiSJsV/FEaFv+t9FAnPZ
         yaDw9HdVntXq81YbVWUrdE3n++XCbeUWA5QBDiHk4l+TgmdSomouRg+AWc5KwSxCnSjQ
         T/Mw==
X-Forwarded-Encrypted: i=1; AJvYcCXmU6WAxxYsqWOrKUL3Zhyu4WbZyDqAzftZjmP98cs3Txg69r7F8Bv9JzwuO4VQ2zJcP1vZK5uvLZkHYBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhenO1N/5qoD4sN3HiQtqNaOzJOtT/Zzs/31tMm3IdlGcE/i6B
	GiclvsxYN4Ah95cdKP9taiKYAJyzGUugJCl26Ny7KxcCtUkT3p0s8I1g
X-Gm-Gg: ASbGncvnN0Wn4sfKOd+B/Pi9TCebe2MCuJjocgViWHXF/WwXu0fqUbcD173GTabwgBo
	LeYA1oloyUQu7nj2mX+UznvA31DLrKZLNDKOTkHryndnnVtlKawe/4Pbko5QGoqV/VfvSWHfH+h
	bHeE8V0o50r0tzKsaASpqpSu2HaLEj2094focnRCyldRAHMbqNNxrrEFbrj++FKnG8wP16q8WdA
	ipJXRh4yCsBf41mmVRpusmm9/GMk+iWPRjqmb40uiwp1KIoMVEo67mNwFb55qgFZ3By7LeaqMfr
	SDrqz8W9WbxramzImhBsL0nZy4Dxgwdw+1BsPkrXRZ4iJs2xOWP4NqKl/FQd0gUbokvfTcwmGoB
	CbsWZvZ348HueoI5l/wAy7JOSHWd3awiOuP7EjrHxXQ3eBhRtB2g2Rrlol4Oe1TiZMHTnLzPzc1
	p9oC6Iad8X9w==
X-Google-Smtp-Source: AGHT+IEQpxdK7nDSwTz1wkNW6JuGLevqLFpUO9kj409rzEmnNWQoF0aH834gvH8ZTJyvDlZYvh+hhA==
X-Received: by 2002:a05:6a20:7290:b0:344:a607:5548 with SMTP id adf61e73a8af0-348cde0a4e6mr2555602637.58.1761873895775;
        Thu, 30 Oct 2025 18:24:55 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3407f09fb16sm534423a91.5.2025.10.30.18.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 18:24:55 -0700 (PDT)
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
Subject: [PATCH v5 1/3] dt-bindings: net: sophgo,sg2044-dwmac: add phy mode restriction
Date: Fri, 31 Oct 2025 09:24:26 +0800
Message-ID: <20251031012428.488184-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251031012428.488184-1-inochiama@gmail.com>
References: <20251031012428.488184-1-inochiama@gmail.com>
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
 .../bindings/net/sophgo,sg2044-dwmac.yaml     | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml b/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
index ce21979a2d9a..916ef8f4838a 100644
--- a/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
@@ -70,6 +70,26 @@ required:
 
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
+
 
 unevaluatedProperties: false
 
-- 
2.51.2


