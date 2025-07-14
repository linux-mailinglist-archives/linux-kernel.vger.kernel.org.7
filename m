Return-Path: <linux-kernel+bounces-730791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B63B7B049ED
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 00:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10AA87A64D8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 22:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F45525C810;
	Mon, 14 Jul 2025 22:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=scandent.com header.i=@scandent.com header.b="Rt6ho/nA"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E45D7464
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 22:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752530797; cv=none; b=ngbnqN2XfrV9irvYnUrdRvDYzQldhxpNRTIR3ZIPuR3RRT18sT+J3AYi8gMsazRnuCHhuZDrzkM8G23e7qaKcj8Sus2qAfjfYVaCSRCc8vMMRFqJEMKBL+I+b/1agZb8sukQhl4SIarMWaW+vSJlHTBKPsuiEhs0uQ48T180KIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752530797; c=relaxed/simple;
	bh=phoyocbz5D5vKEkTNRRRN2l4oOsprhXdNTcDfO73Tf4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cS688m99XegNsHgBx8plIf2NICEtHWm8M69HMlesNAx3bnxnQWdi5MExN3Ejk65zfxJsmMQY4hk2TTlAn3CpGCFXsVRxlm2EJzH8qNiPLlmdL7JzXKOHDzVxuKsWOMCPZd4PEbavmr0kM5IQYzIL2Mz/tORHtecMSmiCDZ8EbfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=scandent.com; spf=pass smtp.mailfrom=scandent.com; dkim=pass (2048-bit key) header.d=scandent.com header.i=@scandent.com header.b=Rt6ho/nA; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=scandent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scandent.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4ab53fce526so27739191cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 15:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scandent.com; s=google; t=1752530795; x=1753135595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wZdUQjRuXevrjG9zfFX20PvAf7NCX5bdBDziT4aMcwQ=;
        b=Rt6ho/nA2jeaaaEMq7hk7mkiYWa2nerT8j7a+u71mHIxt5fv148BMORpUX9duOwmL/
         S3ptVWqV8PTkWt9pz7tlU2u/VgrMR4BsSJjZla9uLem8XvJQPhRNPevg3woELwU9Rvb6
         isqZgpGIzzhi3wmlIGBXYCaxZ51JLRt/pr1KLYaGkRTNlGDxHCmKHJXp5mp0vWXzHzMs
         tcQlhjgGDtKVsBTdfeO9kBydOF0zc08Me5/AY8fxY5VAZlPKAJFLliPtPzTBiF5G8Oqy
         toW8lUVoCi2VF3YQUxmx82pSWafWTUtUhoiucPWe7EtU9iIHZGeX74I5qBO3nB3k2LTB
         FSAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752530795; x=1753135595;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wZdUQjRuXevrjG9zfFX20PvAf7NCX5bdBDziT4aMcwQ=;
        b=kHSfsb7x1XpIP5XCKixOA9B1Zpc4P+wXvWuKH+6jbYHg1D7kttNEKgJJ6HaoKiiUZr
         dMBvadloE061FHGI1QteX3Xu0uhq64cm6TLGnzzqQaMjmZhJe0JNUpOUKTg4Ajqhi57i
         NCVPvXjeG9P83MjtATJNnlcIhuVM56yPmV7QHiTlCfVKDzP6vckeAaPHE083uXfZfNvr
         Ust+yrP0pmcNqh5QwLxdX5c4nulfGM7t58tBGyq2SIHqV4+H7KR3+cmvasU1XuCGiDxG
         ZRgUOX7CRHBLWK54zxof/SVnmOZHp73kQpyNdxfDClif6/iMPcw8QERMaf+f25mRLML1
         bG7w==
X-Forwarded-Encrypted: i=1; AJvYcCWMwDIUk/MfJXW6BoGCZkzbGF5rMieBLTAm7a6iA3AugqbNchGUVIGpq5fiHmg+dF78eNHxQ0EG+0OxF1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY7XkimAxQ8M50BygeNJJ1hwiZ3tVSHuyUnOWUnBflgwiz/cXI
	qriBtUkSoP9p0wAbTIn1c7ryJ1x02RMNgXt3vBFs9ZdxN6MVeWSGF83CxC2u/6szFU7251kiDZw
	ftieQ8Xc=
X-Gm-Gg: ASbGnctkdkcAlZvlZIjISsYetNu5pPx2H2X0kLLS4DL/ww95hQ1mH2M9Q1D3l3OuTPY
	5FZq+zwpCBFg9tKwD0rM6EZgj4Ukx3EFvaeTujB4pMpm4nXQv9ykb1Zej37e/k3A5VJrfxtFyw2
	tPbWKOnrFDUOHiZIE+MynQpTeT3Tc8b/wuSpMsCFCONeaeQoSN0H4YQRzVQnuqct/n8mq7RqXgi
	o9wbMTT2J3dXdjVnauPX3uYSaFwxWwlmXbvpp+9i3wtguOVNYDBTKRMUIeOY6ifly8JEVrCXP5x
	tAI3iWQEg37NiBJDtvfUhKHeOuPiQ7kW+UE4OjOi9dT365YH+G7HlLotWeccYGLUpUAgUjcAhPf
	+V2/7hyZRo8RvhJq2YKTqd7PMY7aqRR4HcNSH0aFDFaVM/jh4
X-Google-Smtp-Source: AGHT+IFuK42Dr2TXk0jJlKJvYbbUoHS1t+GayRDQM86fdZ8yBZAHPMI7oCFh+clT7Nh1wPBE4gQeeQ==
X-Received: by 2002:a05:622a:40b:b0:4a7:24b5:71ad with SMTP id d75a77b69052e-4aa35ef7d72mr202420811cf.35.1752530794761;
        Mon, 14 Jul 2025 15:06:34 -0700 (PDT)
Received: from vserver (ool-44c5118c.dyn.optonline.net. [68.197.17.140])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ab6fdc7731sm13137311cf.40.2025.07.14.15.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 15:06:34 -0700 (PDT)
From: Richard Yao <richard@scandent.com>
To: dri-devel@lists.freedesktop.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Akshay Athalye <akshay@scandent.com>,
	Richard Yao <richard@ryao.dev>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Andre Przywara <andre.przywara@arm.com>,
	Junhao Xie <bigfoot@classfun.cn>,
	Caleb James DeLisle <cjd@cjdns.fr>,
	Kever Yang <kever.yang@rock-chips.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Richard Yao <richard@scandent.com>
Subject: [PATCH v2 0/3] drm/panel: ilitek-ili9881c: Add Tianxianwei TWX700100S0
Date: Mon, 14 Jul 2025 18:06:21 -0400
Message-ID: <20250714220627.23585-1-richard@scandent.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Richard Yao <richard@ryao.dev>

Hello,

This series adds support for the Tianxianwei TWX700100S0 panel. The
first patch adds the Tianxianwei vendor to the vendor prefixes yaml
file.  The second patch documents the DT binding. The third patch makes
fairly standard changes to the ili9881c driver.

Runtime testing and validation was done using a patched rpi-6.12.36-v8
kernel on a CM4 using a custom carrier board designed by Scandent.

I have confirmed in writing with Tianxianwei that this patch series may
be released under the GPL after sending them an early draft for review.
This should be superfluous given my signed-off, but I want to make it
clear that I did not assume fair use when providing signed-off.

Changes in v2:
  - Fixed typos in romanizations of Chinese names:
      Tianxinwei -> Tianxianwei
      Shenzen -> Shenzhen
  - Link to v1: https://www.spinics.net/lists/kernel/msg5767021.html

Cc: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Andre Przywara <andre.przywara@arm.com>
Cc: Junhao Xie <bigfoot@classfun.cn>
Cc: Caleb James DeLisle <cjd@cjdns.fr>
Cc: Kever Yang <kever.yang@rock-chips.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: devicetree@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Richard Yao <richard@scandent.com>
---
Richard Yao (3):
  dt-bindings: vendor-prefixes: Add Tianxianwei name
  dt-bindings: ilitek-ili9881c: Add Tianxianwei TWX700100S0 support
  drm/panel: ilitek-ili9881c: Add Tianxianwei TWX700100S0 support

 .../display/panel/ilitek,ili9881c.yaml        |   1 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c | 242 ++++++++++++++++++
 3 files changed, 245 insertions(+)

-- 
2.50.0


