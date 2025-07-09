Return-Path: <linux-kernel+bounces-724565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C83AFF46A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 00:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 272587ABCA1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 22:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C83248F55;
	Wed,  9 Jul 2025 22:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkrG+avE"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1BE23ED5E;
	Wed,  9 Jul 2025 22:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752098883; cv=none; b=lWbW97Uk3qujX2nuOBpvarw31hurg1wqhrlBO3xcn6p1fvwKYje9c9RBjTCSm2XJglq08lPlaKELOERIsl7OGVs4KcsFH1rvJ0qmaHAoaLxwJfnYaCv48zTcxqDaMkzGQgI7vqFupP42T3wWypC2uD6z+KSeWyFoC4P8ezWTGqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752098883; c=relaxed/simple;
	bh=xGvWdqKSX4M969CIZEzAazfWep2CB/hspQf7BxrJkOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=axf6jJJz3VIdhvPKB597zlqB38w3ZN56DRl5V1nzyqH35c+gO/wO1xfr8E8m6F5MyqpoEs2tqSx3X7jn6sobpuh4ancOY47CQ0t4HI6JnE7XNyplERo6HwJ6ZiE9DQjxTXATcGz8qvdnk8ghm4az4Xuw/ZbPZJtzwrye8SA5VIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FkrG+avE; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ae0df6f5758so52037766b.0;
        Wed, 09 Jul 2025 15:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752098880; x=1752703680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L4vGOKIiNJI2tJXCMd0e5H54wpKvUXMqTF3rDPaUqc4=;
        b=FkrG+avEwWg1pOVN5SpSpxZImIe2LbhHHvgzS9ZlJBS7keH9vp0QxfOBg2vzwADJ/m
         Ao4ocjQf2roTEXCgNMfpIeOPIAhnUf0QKRjKX2FTUg7URsdXn5ODhekpNV6bofJdLKTR
         uJk12fGhorp61oQUFdQmEosFJMl4dTiedBGJbLSJdtnZgvMfXWXxc4PKW/zEhO/2R7Hg
         aTmTogMNKymB22aMWBwvNzr8Pw20bsyt4NETNm/roMn2MUaKemCUo6ZdmGGXa/G0N+bA
         x01H5VclWlfaJ+rL70uOlErWlHlMAVztgbEYGE3Ii4y1YMhb6MgGUOnq9Gsn+KPNe7kA
         BbSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752098880; x=1752703680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L4vGOKIiNJI2tJXCMd0e5H54wpKvUXMqTF3rDPaUqc4=;
        b=RCKdgIC8CXIi0uCSuUrvHPdI1nS+AowWgHi1Rv0n0Csg8L+RgpuUDqBNLuIfImvf7q
         Exv5GO3Qj0GGOLX+qo5PEfNlOBmBfLDPndVUwGPfR/aky7IEuXf4MxE8BqQZ0OBUNuV7
         3xmHncXamS2iCIJTodlKDspnzkG8jGfsLNRaRMZwsJLY6T1nIfjwzMrcIrNwCzA3iotx
         0Ym0tnJYt9brNgO1o7wVPpC9FPW0d5HbHXoX21Qy0Iuhg6i51EnGqrIcdXchtmbwstSd
         Bk4JaqTcNhXav/qYOFniIktH7bmhKjFKiY9CVGzhZKGS3uMJ6EEErZ3k5RgRKX+dSKyy
         dIcg==
X-Forwarded-Encrypted: i=1; AJvYcCV/LX2aGIgEZMSN0M+DDRi7+fsv1yu3ef+B1vvAuX65YRtjcila1DVmsmJMvGeYE3VWMcxrx25LGQ0qPis=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6gf9gyHTVMgSP/OXO2ShqHeX/c53NMm50BeRds9EGm8gbuZ5d
	OuZSSrgRnOHTYaikiNPHY28sZAWk8WRddyX4FZfB+wfxJbHZqkMPFu00Vfr2Eqnx
X-Gm-Gg: ASbGnctVXfbZD7JN9b4hfdxhm9hX+QssxJpwy4072z9i0gP4Ds6W+rHk+8QsvEvl83P
	XO/c7c4f9E+p8hcsIWdy+tTwvHYqdFuqImclfwHCmn/KTvTthmCxxPE9J7NQ7Q3qDkz1IASs52L
	/tdPcVJ5Lw5zKHBNfzxBhX1dF3ArZC8sjR5KuJCImIkR3d0ck5NMckpUw7OIKprkhOGJqh9JLTh
	eYOL+2aeS7/Qn79gceWkPHTzeagSKai5yL/o5GYKCDcAQLoImrrg9q9GIGdnQG/9ligOKCJPqz1
	2X7l7DhYRZuMG9L4mthTMHqmGeU5VVxBh9yZA8I4XomyJyjYCH1+hNkYhKdLykJFCCIkfapKczf
	snZ/ruQqe6fTZm4xW7vJ79CryPMY58t1GX5XTihAaykceSg==
X-Google-Smtp-Source: AGHT+IFL+9YADh5yPMNkcoRGEhTWR60Z92TfBO9E0RsbRdcIJ90t6RAh9BWmJiSAtRtxnaUfQ26NHw==
X-Received: by 2002:a17:907:e8c:b0:ae0:1883:78ce with SMTP id a640c23a62f3a-ae6e709ec9dmr38876866b.47.1752098879866;
        Wed, 09 Jul 2025 15:07:59 -0700 (PDT)
Received: from Lord-Beerus.station (net-93-70-53-177.cust.vodafonedsl.it. [93.70.53.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8264fbcsm10520666b.75.2025.07.09.15.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 15:07:59 -0700 (PDT)
From: Stefano Radaelli <stefano.radaelli21@gmail.com>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Stefano Radaelli <stefano.radaelli21@gmail.com>,
	Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/3] dt-bindings: arm: ti: Add bindings for Variscite VAR-SOM-AM62P
Date: Thu, 10 Jul 2025 00:07:04 +0200
Message-ID: <20250709220714.85697-2-stefano.radaelli21@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250709220714.85697-1-stefano.radaelli21@gmail.com>
References: <20250709220714.85697-1-stefano.radaelli21@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add devicetree bindings for Variscite VAR-SOM-AM62P System on Module
and its carrier boards.

Signed-off-by: Stefano Radaelli <stefano.radaelli21@gmail.com>
---
v2:
 - Add symphony carrier board compatible

 Documentation/devicetree/bindings/arm/ti/k3.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
index bf6003d8fb76..780fbb5970a5 100644
--- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
@@ -100,6 +100,12 @@ properties:
           - const: toradex,verdin-am62p          # Verdin AM62P Module
           - const: ti,am62p5
 
+      - description: K3 AM62P5 SoC Variscite SOM and Carrier Boards
+        items:
+          - const: variscite,am62p-var-som-symphony
+          - const: variscite,am62p-var-som
+          - const: ti,am62p5
+
       - description: K3 AM642 SoC
         items:
           - enum:
-- 
2.43.0


