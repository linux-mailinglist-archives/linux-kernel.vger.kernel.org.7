Return-Path: <linux-kernel+bounces-723945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6AAAFECD4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C984A1C812A1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169BD2E763D;
	Wed,  9 Jul 2025 14:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="S2X+5WHk"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EFE2E62C2
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 14:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752072928; cv=none; b=Z/yB2lFeaYanDmWWbCQ4l1CkcxbZF+5RonQbdofhZDZBQB4L1xHfaSfIaUKnYUzQ04XDJ2UgE0T/juPg8nlzBvZ4euV5Gj7PWQhCTfXdgBRcp8ou7y8/EbHI0P/qfJXF7PxzcrjamSeupKclAPZsRe5yP27sLCgrpda7WKXNt/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752072928; c=relaxed/simple;
	bh=NXnGscA8zt8gzxiNiTYIUpV9OfGd5HRPGvlVvXT/iJo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RNu+f9kT0wuWwLWHq8i3fxxT0tb9FoBsjD5F7mkD911lAudFZnn0ZW2KrLFZYxS3E8v1DspEh5JZUMZdqwP1lJM2bWkQD59O2iZvG9nI7sUMM4QXyK+HgTtvBxdNSrJHX4XxE7E0FiMH+acVLixlufxtB2yak3uGjHQ5ul7fjVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=S2X+5WHk; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ae0de1c378fso867069766b.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 07:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1752072925; x=1752677725; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q3A3hRQjja7NMerwUSuHLGaJ14/ejKpqQyPzO1AUrp8=;
        b=S2X+5WHkxvCTkI8GCnIhZ6XJc4CH/JVvODRxquvXfi8ySc1qbffB5YvWv5Ax8Htb6V
         80cNmZKswnQWtSkv05BGtBrc5iWe6L4jpssglTblkmQcntpFnN9eSUaVRZui/YfPkor4
         JNElNPQoTjYCJjyezgc6q++paIgQnsObA7Erol1sNQ252y7OOk8x7eTN7PR8guccyFIw
         i3+Bz3RgJk5humniUz2MIpbUDOqwEaTHRZoRG//587PFmRA/8oBDruHURm2RQ4E6mfeo
         1NmtOMJmn+5ZaoaTmM2SL3h/0tb347K/73r5fkR6XhMXj3OeCNy0lxNd8Tq9+nxife7S
         P9ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752072925; x=1752677725;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q3A3hRQjja7NMerwUSuHLGaJ14/ejKpqQyPzO1AUrp8=;
        b=Wu6t95Zq6pvcdrNIeTcjlGXWOidXOTRD8X8Ex8DzninLKttTJCkEMiQu5BI89bpa9a
         JuJP/Tr9NVJiRvnE2GURrmzasTk7/qjiKdLDtUzUPGboRq66c9b/G90pyVoLURDTuEyX
         jgyQu1plU1AZT3Oyy+x8sfr8JrgaayT6LBSUVGJEFZz7LRvZKTdZ1aFW9IIy5xt85TVn
         WTOvelqj1fd3yeOfPVCjUuu9n/UXqZ/Xu1TkeIDVrwJGSBc5hMdb3XSpfsu9tKgo+/e3
         11LUm3qW6Lm7xd8eJtLCjfISPuM7Sl9llpsN+XlmxOqU4roU8nO/Gr2Y4936K2JZXeGU
         jdmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBjr/ySOHPEg61Y18SblAgZ5SLdsPjXu66aOpHg0xtXorbdkdO6JvsCkoC4Hx63hSpX/ecldtUMXWENXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXhz6l+XjnU9O+pAA6q87OV4IJj+5nbtE6TvNEHPHYLWjehbsA
	5zMV3LpxciHYgjPCjhsNQ/yph8WHn5u+OgFmKP/qm0GViwaDQ9eLSbEpQ4WID2DJxus=
X-Gm-Gg: ASbGnctgl05R0Brl25U3m75BCn/R0/CC77bRNrx0Y0ToRkGB7B8bOr2qbDyMO8bdsh/
	nKbfzHnw3qtxd/NPDjeWYbRt6hyqGG4xoeb0vps/AGjc7rgQgecZvZbwjEiXC/UJbnf6x4CAtxw
	AjnogqBchfK0tJv/VjknYo2CO/Vt5RXXrEcPXlPFr5mPfQWUfpRl+yia4GioFUF2RG+aXLq2Jy6
	rXKCn2Drd0ii0XbstvQjcX29HnQUwVVrp/RC85D/oD5Cl9EhlIwii72XRawxaaTtq+a32uIVWXl
	u1sJ56yQ+xuoYDuDZd/B6yi1rCRaytGR7JRgkPY1hX+HmtdI14NKHKv44NzawwV2O9cTUhH4RAs
	Cnmxfx30EFn9yJOKZbShDgYxXAsLlJRTZjuiy+KVqJ0E=
X-Google-Smtp-Source: AGHT+IE1CWKVdaIzESsJv98mg9o7AX3rvILsP4/LmkQKyHBEdouOQ04zPbRMcVC/GnkZe9exm7j4sg==
X-Received: by 2002:a17:907:3c90:b0:ae3:6cc8:e426 with SMTP id a640c23a62f3a-ae6e1049e58mr9441866b.9.1752072924666;
        Wed, 09 Jul 2025 07:55:24 -0700 (PDT)
Received: from otso.local (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6b600ddsm1116795766b.158.2025.07.09.07.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 07:55:24 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 09 Jul 2025 16:55:14 +0200
Subject: [PATCH v2 1/4] dt-bindings: phy: qcom,snps-eusb2-repeater:
 Document qcom,tune-res-fsdif
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-sm7635-eusb-repeater-v2-1-b6eff075c097@fairphone.com>
References: <20250709-sm7635-eusb-repeater-v2-0-b6eff075c097@fairphone.com>
In-Reply-To: <20250709-sm7635-eusb-repeater-v2-0-b6eff075c097@fairphone.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Abel Vesa <abel.vesa@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752072923; l=1262;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=NXnGscA8zt8gzxiNiTYIUpV9OfGd5HRPGvlVvXT/iJo=;
 b=H+Maa8FQfQMc4eZK+lVTkgEgw5axIHwWJiezVuUHjjiMKqtPvImloJEAECKGkVNX2B4QbuKj/
 VbyHsa6K3PHDkywR6SF4gjvn6DReQ+U5+SEDTmfS3zD9EEvXZb76HsM
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document the FS Differential TX Output Resistance Tuning value found on
the eUSB2 repeater on Qualcomm PMICs. The tuning values have special
meanings, being different offsets of the resistance to the default value
in Ohms but the exact meaning is not relevant here, as the correct
tuning is determined by hardware engineers to make sure the electrical
properties are as expected.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/phy/qcom,snps-eusb2-repeater.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-repeater.yaml b/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-repeater.yaml
index 27f064a71c9fb8cb60e8333fb285f0510a4af94f..6bfd11657e2992735998063b3ca390e04a03930d 100644
--- a/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-repeater.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-repeater.yaml
@@ -52,6 +52,12 @@ properties:
     minimum: 0
     maximum: 7
 
+  qcom,tune-res-fsdif:
+    $ref: /schemas/types.yaml#/definitions/uint8
+    description: FS Differential TX Output Resistance Tuning
+    minimum: 0
+    maximum: 7
+
 required:
   - compatible
   - reg

-- 
2.50.0


