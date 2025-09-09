Return-Path: <linux-kernel+bounces-809085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C68B5084E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 23:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 128C3563962
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 21:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD28126056E;
	Tue,  9 Sep 2025 21:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NirSh0ET"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A44225C838;
	Tue,  9 Sep 2025 21:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757453890; cv=none; b=Ofc1CTQW93639jUxaPXOS1i1On7rgVE38YRLt5p5q/CEnabe4G09gZ/q2GZTOyfe9tT2UoVXfN2QBQ/xej9aUscipArgKL1Pc0z5R8qC+K1xmH0y91ub1JJIuus1XKigLpu+QOWEocthbbBnJJ6aCjiSp5Ek7FPtrdeWxDrjDa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757453890; c=relaxed/simple;
	bh=hG/DGXN5bBjkGBZ+1s3qPywgR4ptrVM66FWiFFDZhxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pb7ifG0/Xeoy9NQmPNxS6K384NDDcW/J09ysDWcJDAHJtpLoeXKYkZNqWI50s8Md8r7RJUZwtj2dTE2qo0L+Mpx19NPX2hKT8UAoQrBQTxgfRaV9HbXzol7tsX9DvIj2dXJgFO1zwDHyDqYTUNqFAHNz5sDAr/jwL2ataacgWMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NirSh0ET; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3e7512c8669so976377f8f.0;
        Tue, 09 Sep 2025 14:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757453887; x=1758058687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sXZqQ6drOwBvtPC0IyxHBKgG/jQ2WfmdAaB2rXR8h70=;
        b=NirSh0ET0B/BCFG7ZSOUYeogeh5U2hEgXuFOkmHt+t6jgcH47GVyPIapXRauEWBWbY
         9IkOOBXH4MtLbpm56sYawKJuY8pl8fQMi+F4NzzC7ODuj/DEirYvR5TQXbvkV0dXjF+I
         CVAvIR9nFR475A9DDzo6jp0YHlWSwDVSwdY+yFgGadYBDlb5ldovEEkhyYOsqAwWSfeB
         CdStEqFYIdH1AJoMDC2w0tlu2WvhOxzFcNneHZm2ExDy2LfS5XN/k2Pz4E4BICRbW3EL
         RA/lECiFRNC3sxOuiliu9etkeRkoBqSFMrftZ3zHmkF3R/1Cr980vccz+Ud7Xsl74jse
         Bk8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757453887; x=1758058687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sXZqQ6drOwBvtPC0IyxHBKgG/jQ2WfmdAaB2rXR8h70=;
        b=UXJ4hv34OqGmffAP5UgxyofIruni/ijmCII0G8aPkCoU1NQUGrjSC/38m0BDAYYfBj
         yNZpoMAkD7g9NxRwoAXBb6kKLIifEJWBrlg3fOgqV4CGqbmk2f5L3lNQQ5GXHQYz3xGN
         9ZkpF2zLPfOtNsDAdLAz0jhZPeCSnwwFx824VFVwteaZmyVtLv1cEHwvLq4g/uyTzSPD
         fjhYZlP+soWN+xV0DYGorqYHUHc5/GktM/lsNeBvZ+NRsOH8bNiXaeld40nxHgO1DrsI
         Q2wqIYYhIHT5Ww2iN/rBaxClYM638Xz/xk1yCtMaOLdSItLWoqye8OEnqgyR6FErj2VW
         rZVg==
X-Forwarded-Encrypted: i=1; AJvYcCUC/wmfY9bupjDun0+5pkz5an5qbx0driES+Yr8FzHhauwR7MAAwvarsPJJSZ7s/GZoRogVKy5tfo8hGVo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHr6I1odiEhJyw7ObVjD5owqkT4ozX06iuC/TaDTBNnY/u2UaT
	ZYNEOkRMSYLeZzcaWCLxdx/08NLgZMd+1dR78Zge33etIdZbsGcMBtl1/2BxW4m0
X-Gm-Gg: ASbGncv0lJbJ3polGF9bKi8m+DKnsJ5nvqE5MVvMEz+Pfbba5H952LYP0g/6wUcjjwJ
	CpQTEol/zQQxUFy4/dphMtpPdrZ9sTjeAzSdvIlt1BV9LmBPedLW6OKZJgdYF+FvDcfsBBUUCzU
	AQwRt3L59b+nogsFGpNpXVDQHkJTJmUNQPHDhwHroZF80aB/C01l1qab3DfujQV+wI6fK4/VHTR
	nI2x60mXMPIUA4EDXxWs/VhbyCqcw2wVRavgeQOCGzIgJSHfnEUPlyYHalHymWU323O/iGTjt1m
	2Fi/j54v7Fw1mELTKtWm6aUK6dfoauLKRHVMrrsJQrb69A8p3yAKghp3zsWbvvhxwYj44L0SoLA
	XRwHvHq66NqOowHI0f5CKKp5DCoRWVBIgSGrmslqtECl+u2s73t6IDYAyVAkIf8d5qZZC
X-Google-Smtp-Source: AGHT+IGFr2W5XNaCtAtSPeMBbVjp/Ht51W4UIIz6VlgzEHG2zATsumVqb9oE8i04JOPAV6L7BQ2BAQ==
X-Received: by 2002:a05:6000:26c1:b0:3df:f7d1:f8ae with SMTP id ffacd0b85a97d-3e636d8ffadmr10185808f8f.4.1757453886663;
        Tue, 09 Sep 2025 14:38:06 -0700 (PDT)
Received: from localhost.localdomain ([151.84.244.111])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45df81cbb08sm2315165e9.2.2025.09.09.14.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 14:38:06 -0700 (PDT)
From: Stefano Radaelli <stefano.radaelli21@gmail.com>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Stefano Radaelli <stefano.radaelli21@gmail.com>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Judith Mendez <jm@ti.com>,
	Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v7 1/3] dt-bindings: arm: ti: Add bindings for Variscite VAR-SOM-AM62P
Date: Tue,  9 Sep 2025 23:37:39 +0200
Message-ID: <20250909213749.28098-2-stefano.radaelli21@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250909213749.28098-1-stefano.radaelli21@gmail.com>
References: <20250909213749.28098-1-stefano.radaelli21@gmail.com>
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
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Judith Mendez <jm@ti.com>
---
v4:
 - Added Acked-by
v3:
 - Change compatible string to match existing mainline format
v2:
 - Add symphony carrier board compatible

 Documentation/devicetree/bindings/arm/ti/k3.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
index e80c653fa438..1cdb6464e920 100644
--- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
@@ -106,6 +106,12 @@ properties:
           - const: toradex,verdin-am62p          # Verdin AM62P Module
           - const: ti,am62p5
 
+      - description: K3 AM62P5 SoC Variscite SOM and Carrier Boards
+        items:
+          - const: variscite,var-som-am62p-symphony
+          - const: variscite,var-som-am62p
+          - const: ti,am62p5
+
       - description: K3 AM642 SoC
         items:
           - enum:
-- 
2.47.3


