Return-Path: <linux-kernel+bounces-790663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76793B3AB84
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 22:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C1A77B9EDE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 20:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB9C258EF5;
	Thu, 28 Aug 2025 20:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjIvUAw6"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07B8285CB3;
	Thu, 28 Aug 2025 20:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756412299; cv=none; b=Cu2j4Bd7QCnIWJFMzRjx6ofwRwY9VvLmQXJDB/bYp/EY6iW01qL5uNMiYlkZR+fX+CLBJYjHixnM0gZe8A3w0mf9HiXAyD0a06aDMzNy99ySnagziVfQHEmA/ogIW5N/uusAkUIfgTRtpBjYada72o7aTd/XbD2Fe9bRuVQM//s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756412299; c=relaxed/simple;
	bh=dRjc9xLf4siw3Y4oc1iHFITWURimm3+I/kfPNSBCYXY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BWUmPPSkWFbCdegdPjsRmljLaV0kl4J9u/KfYCA7N/pFYG9+2bQRzWQEDWDWFhAslN8jqhL8wWG98aVagCULMBIV7bOXAEq1VAHkp5wYuzrNKmpiltOw2YpIVRko5bJ5sdkq2774lb8d/4CQzrnE4y0XBNat4sidXI8n87xsYsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZjIvUAw6; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3254e80ba08so1385364a91.1;
        Thu, 28 Aug 2025 13:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756412296; x=1757017096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hkl96sz9Yr5LrUJYz+vvxi+pTvjsFIFXM2mejqnFZu8=;
        b=ZjIvUAw6v/yFUPN0Awf8wTInDWK33foidPxumjV7xY8YpHChn0iButy9okWA3yoM8U
         YlU4Adj8X5H3ifkogr08JRr9nbSaSRdccgtSANf9CA9KdlgCHdOyj0IPoVllD3Hxa+lJ
         hNTO0mYwR2vGZZcES9BdlghxNgr62iAi6KWRCpYM5AQKrb+YI4FL6wlBY5EqF0DxovLF
         2zP37MgTNrsWEPZ0p4OgnTkb+i5wLM4LUJi1IAn1DYJpB2T88erWa4JShcQjaElSPfAg
         T6kK4DfvahInOP7ej9OiR2YviSpqWoCLqJ2G0/6CwW53MSzBqbtuH0tg30+knkrTBs4m
         VkHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756412296; x=1757017096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hkl96sz9Yr5LrUJYz+vvxi+pTvjsFIFXM2mejqnFZu8=;
        b=G5ubGtAwPBKYoPJ6MtA0+rr1c7H4J54q+ZfvOVLb9Ndl6ynVxEpNfqbXq5HDtqG6MB
         PVrcu8QAvUr4z20S94k50OfY/iIh0QrlVxyR9VVPGsyEihzcW2EMJRs7dRjMLAvIDTed
         jrotYYEMOHTdaxEBglDw7vBL3cvcNjVBQv80mgpabUsvSmaIo4k/1V4gjvzFH0HKGEcw
         DM3YxNhu09FPel80Po/2yHMiSsxY6lQV+/RZjXPo1wiRo/QX9hWLmioh+4AJa04UEfGH
         ExtGEK4wQhc9xfc87NtsckXGwjNLaWcrBM5x9TdEefuk4etQqn2mecaSKvV/6JZBSvup
         bopQ==
X-Forwarded-Encrypted: i=1; AJvYcCUECWrIcurd/Zam4YlcuxxLqGnyKQo/BQkeXbsrrdzQJA5jHFKdVqppGaBeaUhGQblPFXMdbB+58YoE@vger.kernel.org, AJvYcCVm4jE1W7ZPdWFlw7AeIetQ6Ldlcv0fiUcBKuPkngzUBJJCndNtKxzrJwm4L9IUMT0wBT6pXvhbXMDioN02@vger.kernel.org
X-Gm-Message-State: AOJu0YzkMVcl6e3oekw/M/VoItT8/3Y7BqcxGGuAuXMc6sMlfQNi4ksk
	jRGCJrJCxEVNO2QvOSkm5L9s1v/t6BCS+10COle8UWn2bqFm8RJUjDfQX4TxxQCBTf0=
X-Gm-Gg: ASbGncvuFkSJcui+EzmxBCTTsEbLm0Q0u2af0dFLevcIZ3luDunJ/WqhHQ2p6JIGSHp
	78uzAHON6bfn1FxgaT7AA3V3Ln37nzbZNtJ3/tZ7rgUb5G/Xvd22xZamlVZq0eZNQRUPDe0zVjo
	BcaHjCAGglVJWm944lDmD/MU4lztf9pUQ4m9iQ9UXe2eBnO2v9T3+6JJcWn7hv0hE4gJBUAi3gB
	jp7kAseX7a4fDFGx3eUNvsG8M/6h7ublkdfxg0TWG7mN+zcbf1TOlp72/STuwYMshw8ycFb90Ag
	24oh5Zs3G+O3hnW0RzOiGXPPcB8qYW0TysSkHq+KCwpaXinH9OvIOKEy9hhex0N1lGTjqfixN28
	bxB4ouX01fcK6C73dYJqmMJ3c5uD3o+K819cauBnhXVhG0CY57r08CBBcPJdP6hMU
X-Google-Smtp-Source: AGHT+IFNi8pMmnxtxmZvYnJUxy2Z820GYeE07V0AvaK8tiu/72Ud4aJE4Ze/ExduFiegC2/RegxJKQ==
X-Received: by 2002:a17:90b:58c8:b0:325:5229:8610 with SMTP id 98e67ed59e1d1-3255229874cmr28385877a91.6.1756412295756;
        Thu, 28 Aug 2025 13:18:15 -0700 (PDT)
Received: from localhost (185.3.125.34.bc.googleusercontent.com. [34.125.3.185])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-32741503367sm4540727a91.0.2025.08.28.13.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 13:18:15 -0700 (PDT)
From: Chia-I Wu <olvaffe@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: gpu: mali-valhall-csf: add asn-hash
Date: Thu, 28 Aug 2025 13:18:05 -0700
Message-ID: <20250828201806.3541261-2-olvaffe@gmail.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
In-Reply-To: <20250828201806.3541261-1-olvaffe@gmail.com>
References: <20250828201806.3541261-1-olvaffe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The values are written to ASN_HASH[0..2] registers. The property is
called "l2-hash-values" in the downstream driver.

Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
---
 .../devicetree/bindings/gpu/arm,mali-valhall-csf.yaml     | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
index a5b4e00217587..258bcba66d1d1 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
@@ -85,6 +85,14 @@ properties:
 
   dma-coherent: true
 
+  asn-hash:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description:
+      The values are written to ASN_HASH[0..2] registers. They affect how
+      physical addresses are mapped to L2 cache slices.
+    minItems: 3
+    maxItems: 3
+
 required:
   - compatible
   - reg
-- 
2.51.0.318.gd7df087d1a-goog


