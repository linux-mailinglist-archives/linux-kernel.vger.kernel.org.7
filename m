Return-Path: <linux-kernel+bounces-889475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA54C3DB90
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 00:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DBE9188D6E3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 23:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87BAD34D4D4;
	Thu,  6 Nov 2025 22:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPtDDeTy"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7A4350D74
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 22:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762469985; cv=none; b=AoZIpaNeBmxo/D8LUq/toacPMMQv6pYAaCTJjXBQdRmyBrRkRJL/hIMstzxZZApFF/I1krdGPiNQybh+gVCn9umba7oti/jiy4qIeTSS5FfI7sJEAnrH0qQQRzVac0G3oCKY5cTDAxTmIA4go5KjZ4Ln4QgpNdjfzq2LAL+CJPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762469985; c=relaxed/simple;
	bh=+bnTZyQICeowwwYQLMCKPFQJkT5wEjHLAFKEoSLLAEo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gsy1ypE7/5OpALtad/CY60iD8fCPOeqgnn/XSzA74RS4zkLjDLP/qbTTyRRz+joUKQVwh07G4Hv3rAGjKUu3N2X3oUWha912tchXhzLTy4VTmJzLChJQ02+rF+6ixbMMtR4hzpR3uqY2rRL9j+/nvF4dELDwfXYwoB64+S3UJWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lPtDDeTy; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-429c7f4f8a2so64688f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 14:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762469982; x=1763074782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NL4ceoBRc0C/nkwU3+YZ9NqssX+vPCISopwMoiY25Rk=;
        b=lPtDDeTymU1Cq9i7xi9Ofr086SvH9UbG6fwuxSPYHHfutqa7RhLwbJFZX2E49uInUB
         cucgAlG0+jy0d5C/HGyRPxahD7BPliPZrqaHzd250EjpQi7muKfPuYDdbILKdEcWEWfk
         PDXLGikMzapMreuVOXL7KrlSKz1yz7J04teHI2vupCG0wlpZMIRzh+0wY8GzX+5Fm8L2
         Fi50sSIbmATjIa9RtKjePrAqk2iTv6DYCVEQYQiLYol/vOAsqWCvJiM4yLzXG+QFaA0k
         m4CgS7sIahDmsTiYdtMO/gVcxvB0By3YWCnkKID/3YwDaw1AOmqdORXao2kB80Xyjzgv
         TLxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762469982; x=1763074782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NL4ceoBRc0C/nkwU3+YZ9NqssX+vPCISopwMoiY25Rk=;
        b=E1hk0YPRIRJ4DhT8771n9NcTvGnD362rDI8qiT0cL+FyduipAxCATS/YF+S3/QiIVN
         5qGzUvVspjGUumW6NrvWcM5VTJOGOskeVSA5NJ8dApdNsL7r+zGHUlBc0dfmYgynz0nO
         i4pngq1WMF//iZZUGCjx05g9YelN8MX/EotR3YqD1CJCirou6N5tGzZQFAWH1+1moXHk
         hjOSk+EpOx1A+6B2Xw7hjb2kWE4Yxjtv2D+a6Zj0qyrlL5B5QkHNCHwWg/WsDKvSxd6p
         3GRzeTKdRUR7xdtSeHd0BPYp5oCEzpGeUTkHt/x0aSYKNSYfZo9VGPyAlS30nja9nQn8
         UxBA==
X-Forwarded-Encrypted: i=1; AJvYcCUy1NdVBKns8qeIrvZUXa7vVI2d813dW615rUXvN2hSKG8tP2kMxPhk/h2k02u/8psOI/3SMkx8Bu3zzxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOBq4VZyLeWj5NBG6iyGQiZXko/UmP8+BVPXf6/5L1WdAS6Njn
	k+RfoH6DEmsj7PL0jr4IAHlV6p8xM1Mx1XZEUaxCAZ1zbkDG4ckZW3PN
X-Gm-Gg: ASbGnctfyZwCuW4Mr/tONGES+HIK9Mk64BDTa7EthCKXwyAE5WuwR8VGZKxqCibybtC
	nMdyKSyPyQBVMSGPhMXX4If3tGrv95ZE3zohS2d1OWEW1n9jJeD530jgqZvWctVJSIzd8bpdCxj
	n4W1bgu8YzeZ9PPI6TGG76+lEaTkCgMHEkJ+BM70QCw1EI1Z2fgbxkwNerLiYij+bAFaY/n5Z/h
	AKnx25rtWC/QwZqhL5z7JoaqDu0/wrXiGzIOAtm0X0lL5J4KqXj6tkS/viJZA+zl25hXnH5tuGC
	0EC1WoDhz5L8vK+wa5l+6aqXgSAorsMssNlersR6odAcBljs0DWYQASQgHnYSveIT+dluR0KLHx
	KESlBBsr4H3kIWu7Bg2Sg6NdH5ZVouwjiN3iLaIZkL8BUaB8NI4XEpn9LUamyP+biAvgw/P7DXq
	rxgvUC9wczcGtT2GZ7iL9U/McZtkNVoQ==
X-Google-Smtp-Source: AGHT+IHaRadCNFbOU7XwnhOefNWC39AvuhSs+DGIQ7TUB4uKubfoPpSUFGQJuVgfwconMXMRFYM53Q==
X-Received: by 2002:a05:6000:2506:b0:414:c2e8:a739 with SMTP id ffacd0b85a97d-42a957abc0fmr1388930f8f.31.1762469982247;
        Thu, 06 Nov 2025 14:59:42 -0800 (PST)
Received: from Ansuel-XPS24 (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-42ac6794f63sm1640000f8f.42.2025.11.06.14.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 14:59:41 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v3 4/5] dt-bindings: arm: airoha: Add the chip-scu node for AN7583 SoC
Date: Thu,  6 Nov 2025 23:59:13 +0100
Message-ID: <20251106225929.1778398-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251106225929.1778398-1-ansuelsmth@gmail.com>
References: <20251106225929.1778398-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document support for Airoha AN7583 chip-scu node.

This is similar to Airoha EN7581 with the addition of the presence of
thermal sensor in addition to controlling HW PIN and other miscellaneous
pheriperals.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../bindings/arm/airoha,en7581-chip-scu.yaml       | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/airoha,en7581-chip-scu.yaml b/Documentation/devicetree/bindings/arm/airoha,en7581-chip-scu.yaml
index 67c449d804c2..0d042fb90a78 100644
--- a/Documentation/devicetree/bindings/arm/airoha,en7581-chip-scu.yaml
+++ b/Documentation/devicetree/bindings/arm/airoha,en7581-chip-scu.yaml
@@ -18,16 +18,30 @@ properties:
   compatible:
     items:
       - enum:
+          - airoha,an7583-chip-scu
           - airoha,en7581-chip-scu
       - const: syscon
 
   reg:
     maxItems: 1
 
+  '#thermal-sensor-cells':
+    const: 0
+
 required:
   - compatible
   - reg
 
+if:
+  properties:
+    compatible:
+      contains:
+        const: airoha,en7581-chip-scu
+
+then:
+  properties:
+    '#thermal-sensor-cells': false
+
 additionalProperties: false
 
 examples:
-- 
2.51.0


