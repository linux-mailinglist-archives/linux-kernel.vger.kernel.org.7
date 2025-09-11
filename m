Return-Path: <linux-kernel+bounces-812849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17903B53D93
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 23:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48E3318935DC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 21:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847512DEA6D;
	Thu, 11 Sep 2025 21:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKOMaMqx"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718D4229B18
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 21:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757625599; cv=none; b=jqEF0SBPdmajdpTUk0YSP7rdKeWfs6AFEOjYawli0f/U9P2zpn97wQzjOu3bvX27+bQ8bx+eullR/zNwoHFIqph2ItR2TH8kmBKAtmAcURgMSDveqkD6gWZoUwrIPqiJYOUem5QqUqXh4Dmip0q0zza+h0/7/wlzJy3grDy6mss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757625599; c=relaxed/simple;
	bh=2L+fSa+PA432zDUt5H/Hau7R0lcNqW58ONINBFxp+Bk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iJcmqM9uEuxq1LvwH9UpTl2DGKnpNQRJceBY+8fMfw3KRjqm9jPFgQFnP+YtmiIPsrQZlZWpOv2YmbtfuEwc9x+5RA0ZaAZeFvmtIoWRSZg2bLjli8s6bzLqVjvnng2Yrzvi5csB0GLRsAIgg8n4ZG8tAaFNmYid8W3nKBwzBds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CKOMaMqx; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-24b28de798cso8636175ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757625598; x=1758230398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1mxio7D4lH3PMkSvuoADG5CMond9DDQMBys3+vGlQ/Q=;
        b=CKOMaMqxaOD1e6Cw/EvPg+bw7f4iPMVpIdG90bAPhp4FDoFeJGdZyHuUbnY0h8WQyt
         lZne2yaa+O7aAnNYvZciZ7eg+CSpACbeaq0GeHsQp2Xx+U1QnclpuE6MKH0HuK3VmOno
         rD5HrJ0v0lgJOFen5DxLWxvTROy07Uo0AHF6in4UEFwKtZ36nuR6Syn7kl2INszfjttt
         3UGHM7q02sQzomvOLtSqZn++Ih4EGk1pSGQSNJL1XhHPYrVo2pXgHC7wfFvUq8OtaVb2
         mEk4YmeShlWJudwiWYcYyKLmdoY7oLG+k4BFRWm5D6BaOws5VDLQEGnMzoLCCDNQpbht
         PGAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757625598; x=1758230398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1mxio7D4lH3PMkSvuoADG5CMond9DDQMBys3+vGlQ/Q=;
        b=JWfBv1zFmXrp3Y4jhkTlYlf55S7NvyA2blQ4Bfo7E9531e22KiaUCZOKeYZ5XEes1Q
         I/9xnnx6p/OQ5Rxys7UcrcwjJHFB1KYGZ36tbsvrhd7xaZlDa4G3fFdltcDNt7nfLY8A
         yGTCl2qf/V21/lPL5kKas7mfxnryvFPHzpOo2UUpym7J1yYgsNAueNdJv7nPTQY37/Fa
         97CLTh7bS9kdqNoq5jgiKS3QeRLVtl10hl6Vs6SmCHOqmhHWAOPNeXn+fWWiyNOx68tW
         hWrscXzwxaqcDop158O02m+7vFBtKGQi3RGqFKdQPeTSHwgml16Gml9PlU7GkzEjZ3t3
         tzHw==
X-Forwarded-Encrypted: i=1; AJvYcCUeeEyzElGdUQeakQ7MtOd4dxgjcxCqw6QdxUue3nQVOCRxo7kVbVenqqJW+oEa12txNZioLnzwrzBEIjc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv/4inuKPrBPXwZeAHI+KT7gdKmEYU3C0mGCM3k+ZDwHATjD0a
	u5KijJ/D3pIan6nhthw5/zHetfojaBoCkNfekF1nYjZCSOFloUSqekTS
X-Gm-Gg: ASbGnct3ZmmmUbh2Jtuy9Sb5YIBnMDvk0qUR1l2XlWNOZTBMxzEV4K1vM+P2qrosLYb
	XJO+sDkqQYQl5k1k8hgwMVPvIc7hIaKehrQEqAPNG5+SYuQQCh6yuvZJU0Z2z6f1jG3E03alRkl
	2KOeCUjXQGbNbrqHAcCQshFH1lFo+FqNQbJsFLZTUxVewXc+S/aaQOVCbZFkKHEt0g1dXYmMvAR
	qYLykdklWlw9XttBaKtGZ/gbghQ0VtblmerJShEpEDjODOxCmdB8O0MBoW56AFu/MKZnZv8KrIg
	ObnkR2PKOHS791oPnNBv1pwHE4tlo/j2eAThk+66gAZ9v5uIvO1kqgLQUzKSCpZIjYT7N4B5SQt
	9vLf+rgdvAuoMBz/fXWe6q8N48hnkiQ==
X-Google-Smtp-Source: AGHT+IHJ0YQITOH1cO+OS2gCc3deW3ojCo0Hw4piYT18eYlxrwjAwVB/YDz0ez1UkvorsCLsmq8WMw==
X-Received: by 2002:a17:902:fc47:b0:25c:cfe2:a0f1 with SMTP id d9443c01a7336-25d243eff84mr9799115ad.2.1757625597678;
        Thu, 11 Sep 2025 14:19:57 -0700 (PDT)
Received: from archlinux ([152.245.61.23])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c36dbb159sm28705045ad.13.2025.09.11.14.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 14:19:57 -0700 (PDT)
From: =?UTF-8?q?Eric=20Gon=C3=A7alves?= <ghatto404@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Henrik Rydberg <rydberg@bitmath.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Eric=20Gon=C3=A7alves?= <ghatto404@gmail.com>
Subject: [RFC PATCH 1/2] dt-bindings: input: add ST-Microelectronics FTS2BA61Y touchscreen binding
Date: Thu, 11 Sep 2025 21:19:09 +0000
Message-ID: <20250911211910.45903-2-ghatto404@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250911211910.45903-1-ghatto404@gmail.com>
References: <20250911211910.45903-1-ghatto404@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add the bindings for ST-Microelectronics FTS2BA61Y capacitive touchscreen.

Signed-off-by: Eric Gonçalves <ghatto404@gmail.com>
---
 .../input/touchscreen/st,fts2ba61y.yaml       | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100755 Documentation/devicetree/bindings/input/touchscreen/st,fts2ba61y.yaml

diff --git a/Documentation/devicetree/bindings/input/touchscreen/st,fts2ba61y.yaml b/Documentation/devicetree/bindings/input/touchscreen/st,fts2ba61y.yaml
new file mode 100644
index 000000000000..e4d076bc7bcd
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/st,fts2ba61y.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/touchscreen/st,fts2ba61y.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ST-Microelectronics FTS2BA61Y touchscreen controller
+
+maintainers:
+  - Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
+
+allOf:
+  - $ref: touchscreen.yaml#
+
+properties:
+  compatible:
+    const: st,fts2ba61y
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  avdd-supply: true
+  vdd-supply: true
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - avdd-supply
+  - vdd-supply
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        touchscreen@0 {
+            compatible = "st,fts2ba61y";
+            reg = <0x0>;
+            interrupt-parent = <&gpa2>;
+            interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;
+            avdd-supply = <&ldo17_reg>;
+            vdd-supply = <&ldo28_reg>;
+        };
+    };
-- 
2.50.1


