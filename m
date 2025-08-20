Return-Path: <linux-kernel+bounces-777909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8EFB2DF16
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE0694E3F13
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DAC826CE2A;
	Wed, 20 Aug 2025 14:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hsAThv74"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CA71DDC2A
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 14:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755699471; cv=none; b=kjMDuJIc5cCIfj4upV+yqY2K4+WfxxLlWo4yim4/4MsZO4k4cUkhsMRfqm2m+NIedqs6SS6V34oYRU4vqa8rCIXv/KbexVfBdtOMe3cUFBYjubbuHctlkedqfSDmMlMa4U1yrgU0t+DMr46O9NxlcmCpc8jeKQNi/vyotiaU6Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755699471; c=relaxed/simple;
	bh=oB8dIVv772U3FjyT8hwtDeOa1n4Kz8C5WHwIQxNF56Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jcfZgL6WSE24RqOQboz0oBYogjL0U3truIWoYhO/3De56B0wxKZdQR9WahFZkP3ZBE8r0de/vMcSUyeuRI5W8iJZMLL+RHD5X8pd4kOLF2+aF2lgTTfW+RqHsjRB32dlmbh3HPA54WQQFj2CkO78gQunrfhesCYlJvcCvonBq/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hsAThv74; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afdf5843940so6743366b.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 07:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755699467; x=1756304267; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=idm/KKu2Ca8SRF7L+P8XLw2Sm8cV7IELEUwwZ+skCzo=;
        b=hsAThv74iLNW1O2zDCyChBYltTPaIuQkoVHKbQDDlOT18m4xfQ1nqb5m2utqurr0tv
         3MSwEg5NJYMcWqcbF65VE/ESgbOLCJzZYr7e+xDaKq5r3z51VbbB6vdUOwu3V8XAyXgf
         IVKDCigPy+00W6cZbO5hTXNfJYvGOdyqh5aAIyVI2/t3Gl7ccng79x8kArHYabW6MJo9
         Wv+pPi1OUB/Urmm3sTroniPTuCfayQ5v1yo09sfkFigjsd/xcD3i7kJWPlk9J4H8Sc0s
         +n2G7NaXFqZ5i0YF9WhJwMTZ2ED4M4KQOtmh2h5/3+fsgVKrLyFyoSWKmIEVhiqDRPpj
         YapQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755699467; x=1756304267;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=idm/KKu2Ca8SRF7L+P8XLw2Sm8cV7IELEUwwZ+skCzo=;
        b=wuFB3jFVp1yXx7sO38UoGoLK8OhyjtkYviKkO+kO2WfmSHGmhmOUcRp5oNCL5zUpcH
         ezTJP8EeRs2gMerjjsSH8hz57o0EzEKEYiNH7sJPXIWy/sRjqBUG2Ik/qr/XjrPoP/Up
         we5BrF+g1gpvPWj3s4RkTiCxJ30rHdB9MX9OWB9mDQujEzplLBRgGO6SQhi7BbXP3R5d
         kfpeWTMoXfhNTtg/xPus2pEOAHQbzB5gljLW4OoCODmjWUY3QxzFCFebIhQUkKHFD3UE
         8lmmLOzxF1n/lcrP3S5OPTpah5EzXWyjDn5TmoCbP4UlkxgI7cbrPW6ciL0V849iC8wZ
         5ANA==
X-Forwarded-Encrypted: i=1; AJvYcCWWbdchRcI+SB4JqhVsY2mY1Nup1jaKwjF8JXYdlDVRrYjEtHz/ulaK1+Ghz5l005o23e0Pj9HaNa3lQrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YytvhIs6pZxODjpg48+w7MlJRg1ewPLtesIRYEvOQuDO3x2RIgG
	yzDdnKGYeEW/1zL/f2lv8B+xGLCrq6+2WRbhW3I1sKxDmAIwVp0AuXbmw96/E6SMUK8JWRYVgqu
	Ey2o8
X-Gm-Gg: ASbGncvM8kNahHdIMODs4wfyX7icrZ7e2H3LmdVtCCk/z72vlc3TDFXJ2yksmzjZsZR
	tAUv7RMjyEIcnksrfu3uqjQi3hwDK8uWLoW90n5YztmKmTLIa5o7OnXIG6i2mRGvaVkeGax7z0E
	EZmgvnq16J38oOcguIBTzWG0X/Hlv92MIHhMhrGD1fanpEqBnevfByiiHVSGwP+FfkORbBnlN2d
	dQGrX77W4jqG9++NkbQoEc9U13xGG/rs7tBYvTtIWXNFOV8Md7KlEWHVRIRNwoq8PIXghmyvQir
	viGeBbrVQBPoHN6R8F3XSbbO5gfWpSyPVpmwax0cspK4theRAzL1ZnPXvO40keTKyJhfqGeVtQ/
	PMa4m3JlKMnIdkJTVQM2llEZe5LNsJNTFyOqOfcZRQt0hcNjm4Q==
X-Google-Smtp-Source: AGHT+IHaPUVFcc04OVpsf0ZuU3+RTTx10mue8NcUtiq8d0XqEJtDgxMexyu56RdMDeLF78O4BSmLNw==
X-Received: by 2002:a17:907:6d0b:b0:af9:6666:4acb with SMTP id a640c23a62f3a-afdf0284f7amr121034966b.10.1755699466673;
        Wed, 20 Aug 2025 07:17:46 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded4796f3sm186541066b.61.2025.08.20.07.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 07:17:46 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 0/3] dt-bindings: display: Few cleanups
Date: Wed, 20 Aug 2025 16:17:35 +0200
Message-Id: <20250820-dt-bindings-display-v2-0-91e2ccba3d4e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP/YpWgC/32NQQ6DIBREr2L+ujRAi9GuvEfjAv2APzFgwJAaw
 91LPUCXbybz5oRkIpkEr+aEaDIlCr6CvDUwL9o7wwgrg+RS8U5yhjubyCN5lxhS2lZ9sL5vtXg
 +5q7VCHW5RWPpc1nfY+WF0h7icZ1k8Uv/+7JgtVCTVEqhVcIOK3kdwz1EB2Mp5QummM8ktwAAA
 A==
X-Change-ID: 20250820-dt-bindings-display-996a143c86ad
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 "H. Nikolaus Schaller" <hns@goldelico.com>, Arnaud Vrac <avrac@freebox.fr>, 
 Pierre-Hugues Husson <phhusson@freebox.fr>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1018;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=oB8dIVv772U3FjyT8hwtDeOa1n4Kz8C5WHwIQxNF56Q=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBopdkFFX9cVJd6R5kRcdJyWNeW8phvfrUFyZvky
 c7O0B46Z76JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaKXZBQAKCRDBN2bmhouD
 14V/EACaWKZnwFKpJN9lLx5+T8AvWwAzgkOcpXvf56f5kFn2bPSGrQBlnke++fV4S4LaZeLKD+j
 RNS/SKkb1UrH8ApcexnLjnJ8wXNsFb2ezwUx4ZfPNNq9xTrexoH0ucdW7PxWO3+fEUi1VI+Merk
 V513f1Bq0galRpDcsLCVjiT4vxTjtQmBfUayw2FIijw11JgpNq8l75sepw9rO3UdUjR8uidIwxd
 90FazyGUdtQA7oSWKaH4p0OchouEApC24D8fHRo1SSR66d7aiKNfty5gFEqWc3seDnsG+CbdSv0
 OCRm8NY3QuvoYiGGQCLb944NQYv+A5Jf9mMUhz1yTRbIyzus7gaywh5xCEJbhu1N1Qv6LmsOESi
 pCoGYnFfrWEszEexkxl45XNeqd7gtkvVUQAfD+m/It/RfHE1GsQw4IT9mz9PSVOqtmGKpVMCkgE
 DAQ+mM3bahogaj2Zjcnj7RUOeOTc2BfLl9Dq4B161jRwKsSZEJcdIqM/U+Nsk7AFfIQ9+tXQbcv
 q6fmAeAu1Sq03EjLmTdsPokNT+wkTBob4sDeg08VO1xDDBWZ9iPDQbzp8EnlGkkdn1Trm1g5W4j
 nyvYDMDoiXYNg6W5c9auHrqzpiD/RLXXOE1SbDLRk2WSab6M+LNAVxCZDiR+/e8Oud6RLdMu24P
 Btij8qdVePtogvw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Changes in v2:
- See individual changelogs
- Link to v1: https://lore.kernel.org/r/20250820-dt-bindings-display-v1-0-d5b2555df51f@linaro.org

Few minor issues fixed.
Rob, can you take them directly? Display bindings are pretty often not
picked up.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (3):
      dt-bindings: display: ingenic,jz4780-hdmi: Add missing clock-names
      dt-bindings: display: ti,tdp158: Add missing reg constraint
      dt-bindings: display: rockchip,dw-mipi-dsi: Narrow clocks for rockchip,rk3288-mipi-dsi

 .../devicetree/bindings/display/bridge/ingenic,jz4780-hdmi.yaml        | 3 +++
 Documentation/devicetree/bindings/display/bridge/ti,tdp158.yaml        | 1 +
 .../devicetree/bindings/display/rockchip/rockchip,dw-mipi-dsi.yaml     | 2 ++
 3 files changed, 6 insertions(+)
---
base-commit: d5b9a4f227e7d13a60f7704cc0d8e16be4bed157
change-id: 20250820-dt-bindings-display-996a143c86ad

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


