Return-Path: <linux-kernel+bounces-757924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 648E5B1C86A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 17:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05D207A7F07
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 15:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC0A29117A;
	Wed,  6 Aug 2025 15:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="bUyNzDTI"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FED528F939
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 15:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754493025; cv=none; b=I7Gqw70YQUjwxizCl9cwPu9i4VPbRlSntkhI9KgwkiEuLDqO5EFZ6B+O5xbSmVPSjV1OEKobpAY8W7DglmLCJBb0ik0ch7M3T9r509sdFfCDOaFxkd99FFXlrrira+0vNMmzjZPb/gaocAeYEQrE4vvrZvYyvFhOKVH1GDGW8HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754493025; c=relaxed/simple;
	bh=ET4/cnWWWkHcg4PrMTCOEmtwl30gm5wJvQlKvN+x1Uc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ria+wFSdkmR1/68UOERCdkOE0saWGk6PcT6ggS3V9/BZQWgTQBVOzK/kJkwjeZBYaa49h/y+m27rIfWW3JZAuyDhzl9UEzRD4KvuUQrTbinZ1iP7z35mjdk+xhY340qxZBBRMtTo+uU2rqrd5/CqhvT9k+uPKZHkTdkzU/6Ha2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=bUyNzDTI; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-af95d5c0736so624023266b.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 08:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1754493021; x=1755097821; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xWQOq9ZFA0+jON41lT2P1ONOkTPCL7fvL5fMlE2CuZY=;
        b=bUyNzDTIknj4zQQaX+uwMqIe6fNJzDG/mWg8dM7AFR9nyhZYn2nOu2ATy/uhjfg5UK
         sGQab9nMpgpvFgf2TY5cBzms4qksToqRDf5jk0FL5CQqZvIl45FFLYD5nNRJFMba579d
         V8NaefeG37BcywjIrz3W7FIhd4tw4/fBBnPP3W5narYeBXAkLnOZIS9F5toDg6HjNNEY
         GFQzE8n+bwgw4S69vNfYHGCiajBn6xY5bDGnYz9j4xuvvJDwRGGN8Mp2iBAJKvekOOFU
         w88HF6pJAwMQy2lfNy364273hbH9kRkvVptOBsuQUSPq3zMt8nYrq0CtGIB7AB62wPTO
         UnIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754493021; x=1755097821;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xWQOq9ZFA0+jON41lT2P1ONOkTPCL7fvL5fMlE2CuZY=;
        b=G2Az+4x0PZR2x7G6rB3hwjRE0IgJmPor6jGCpvLx+d+p9iaWpp7seYcJULMagwZRO8
         ty9KMvH7nY4Rdw16MdwdFvzucywsldZsX7FKNA5RBVLst374sBqwoiE0Nk6q9Lz/7w5i
         mJTrhr7m6tjfsSKdj+EcYRwONzZQ7rdvbND7s11T9SOKgTcBsUVlRH5RK+glau7s2jxr
         vfTGx9kGnzAdGokXRHDl8lL6Gsku5uNF10rSjrQoEuq0+GDvt2SLtv7nz7S4YmT+yf9q
         Fnmm79vM+qXC5mYm6WMkHxLPRVA0Z1TtUqLXC2D8me+B/5z13WFxr28qRf84KdyPNs9O
         xMdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXI3HOO4Q5+wY2tquEED6qDQrdhJJJpDQXPPLtCA8aeXrO2EsNEwcoNZJ4tKcJ5/9FyBEhGZj5dIUdHrM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1KuXoiO6GttnY0sSekGKLHJYEuTisWb3fNmW3YTMgsD/5HTpd
	QiMD3ZxkpjmZWmVod/PZ5+hRT+Cb7/XaHzIAfdSMm0GoqKt2d3M6cxbVwfMK2IdFwLA=
X-Gm-Gg: ASbGnct0FrTYLyfRhS7xPvlV6j4FBPCxLft3qTtT/Ef3/WXFZxWuU2MIB6FfB7SCXLN
	dfeheqNR2kEs0QjbFSTmUvad0nWjxxXGW/2UtCq3t6yuIg5BU3JlYKJzpiJmD1bdmULcw1DfOEv
	Xm0bmPzU1P2IPV41QS4Jj0NnaP9s4gmSFLIC0diz7tA1TODMIs8IAXN6m0finu0r2H0c0+HGwNu
	MILt5D6olr9ZdLIh7VKMuiwrAb1lCXslsCbG+OdtQzLZawmQsmdy+R7BL21IaUdBCIHL2LGxlIW
	3WNPIbmy492wdlnrFsBThKaDI5h+WJh/lByGTxe8YJaCtptrH74Phmo/tsEOw79DhC++KyoXME+
	alzdVqs1bYKhLK1aFySuFiAGizopQjyTd8IGyW4SNbjC4DZQ6TOvC7LHeDI0n5K7wfxWWFyDj4J
	p4VM8=
X-Google-Smtp-Source: AGHT+IHDiUvyZem9mnKzHWgCS04byao7rqFEhYeBxSdb8hW07XFM2TDwH3AdldZ5yojPBgR8oG59Tg==
X-Received: by 2002:a17:907:3d4c:b0:af9:610e:343e with SMTP id a640c23a62f3a-af990116764mr319719666b.11.1754493021348;
        Wed, 06 Aug 2025 08:10:21 -0700 (PDT)
Received: from [172.16.220.71] (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a3b77sm1120100666b.51.2025.08.06.08.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 08:10:20 -0700 (PDT)
From: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Date: Wed, 06 Aug 2025 17:10:08 +0200
Subject: [PATCH 1/3] dt-bindings: input: Add bindings for Awinic AW86927
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250806-aw86927-v1-1-23d8a6d0f2b2@fairphone.com>
References: <20250806-aw86927-v1-0-23d8a6d0f2b2@fairphone.com>
In-Reply-To: <20250806-aw86927-v1-0-23d8a6d0f2b2@fairphone.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Luca Weiss <luca.weiss@fairphone.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754493019; l=1612;
 i=griffin.kroah@fairphone.com; s=20250804; h=from:subject:message-id;
 bh=ET4/cnWWWkHcg4PrMTCOEmtwl30gm5wJvQlKvN+x1Uc=;
 b=BDsHRqaB0NzKRARDq+jBvJ++2ZAtUPhBQ/H+Gqwm7jqsb0bXU98BNzQC8cF+qPuWKJxaCp9uB
 dDm3Lq00oPXBY7wtUrNl7cOp4oHfCuthzhNe+/zObhAHLfzi3AI+g3v
X-Developer-Key: i=griffin.kroah@fairphone.com; a=ed25519;
 pk=drSBvqKFiR+xucmLWONHSq/wGrW+YvcVtBXFYnYzn8U=

Add bindings for the Awinic AW86927 haptic chip which can be found in
smartphones.

Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
---
 .../devicetree/bindings/input/awinic,aw86927.yaml  | 48 ++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/awinic,aw86927.yaml b/Documentation/devicetree/bindings/input/awinic,aw86927.yaml
new file mode 100644
index 000000000000..43012f28d9aa
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/awinic,aw86927.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0-only)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/awinic,aw86927.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Awinic AW86927 LRA Haptics driver
+
+maintainers:
+  - Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
+
+properties:
+  compatible:
+    const: awinic,aw86927
+
+  reg:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - reset-gpios
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        vibrator@5a {
+            compatible = "awinic,aw86927";
+            reg = <0x5a>;
+            interrupts-extended = <&tlmm 101 IRQ_TYPE_EDGE_FALLING>;
+            reset-gpios = <&tlmm 100 GPIO_ACTIVE_LOW>;
+        };
+    };

-- 
2.43.0


