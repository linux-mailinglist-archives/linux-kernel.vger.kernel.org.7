Return-Path: <linux-kernel+bounces-723946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 510F9AFECC5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2665D4E160A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171042E765F;
	Wed,  9 Jul 2025 14:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="E1BwbKxT"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3822D1F5E
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 14:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752072928; cv=none; b=OMD10UNMOCt/3jrW03B94prHDMBX5lKM2bV7tRao4JPGpVp1keZqV1MvXdQrGrrrLOUJA585rnfIVyLvNBt32nf4r68raioQX0GZ+oj+QHsW/GC+bPpivvdOXTuuSS7C0t7IX+v9YSsMnX/IQRJa9U6hQPY+lH5iZo7RRlHuTgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752072928; c=relaxed/simple;
	bh=+2bfuo/XxdFtjNlpBnRSz55oWsfelV2bXIgIhY/HOGo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=P2Eo4/Y0L1GTqAwlO4cCuXfNMc07LqwezIgHN/z6/2gM9RGBc5DsKm9oe7sw4rAeD0XiX8ugjrpNvvFjnFTx83zscaIS6aicGFGBRP5awhdSj2EGFriu6kr2Bsv8tQsT+bZO+OjYx6ZwMHya81SRsafBxyOMWUOPVv7YU4tKLL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=E1BwbKxT; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-60c3aafae23so2363067a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 07:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1752072924; x=1752677724; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xsudQgPEXLO/8rlrHg7A+VcqH4UVc0XGQUOkZdmkbM4=;
        b=E1BwbKxTcKBCaV5Ij/+rHcE8p3g0bwuFB75skGhRurqQLpG69++LXi8ntlEKOZSY1i
         S5aVNip+/zOF0yFON+7v6uW/QmZUjR6in5NOtAwEo2YcLk95LUCBteD6HZ4EtbMlJ+sN
         LthDYz5Fe6VW3RDlMiNG0wC/d34MDA1fQpNWITEGQtf3XfQSu65mcQIHAEzOd3YKhUIv
         FHxt/+J9G6mPvm6I/xMByj1BmBCVE6yeB75OwzYdL72YkoLNo+AHcOej809fHjzMXUJX
         k8FvTVqDtd4Jtxutjwa39PJawUcE9Sdxe7Y2fEM7gRk4vTyPJV2VusGZ94a+5SKHDJVU
         LivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752072924; x=1752677724;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xsudQgPEXLO/8rlrHg7A+VcqH4UVc0XGQUOkZdmkbM4=;
        b=IlyOyUHeVYilkb4tk38zbf8QdB8l19WR3NGvTO318NsuPR/V0wDR7KZq6YekUA88Iv
         FyTcPAAC95pSl9plFJ8x/R4WhUrKSzbO1wSRdiPTRUOEzZh/m7G0GN8lCeDtl5O10a47
         klSkQ2YFpvL+t7IdVQoBCm8JiznF+2F5pIiE0TBq9Mb3LvR3Oj2c3l5QesRL2cLRMyD0
         BjX8l+WtaSvMFYtcTfD3FJqqbBUOWoxBXlRSt7pSVyL16LeFlfeF02J0+jRgv32j25W9
         2/9a7Lx9nX4qUd+k8rhpXVj037DRQKgk2aXmQGZqkgf2HDEXm8sgmGaCR929kdSa/eAk
         tSKw==
X-Forwarded-Encrypted: i=1; AJvYcCWDF/5+U696+4ICMxSIwP7Z+zioJGFTHhSjwlN62nEwbJT9ipRw51x0wa+43lio3FfqlWNHS1pnGdMtPVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWLAZmFN4BXgl5W3ObEZqSQezUpiOH8tG58mA0W/3UHUwzBg0x
	TEkr5XswUQBKsT4dwDol9CHH6dilH9gu3dXrhJ4UE2tgyPRQ5Ho0kqpl4LhyJc1oY8M=
X-Gm-Gg: ASbGncshI1OE5MkRkQKIRDMj378lG2VpB5ofm7mKW8RmihQL874yw0Kn3B2HdcZcUf7
	x3CZlGzMoOZEEotHt8GxpQ7vlsrewDbOJqIyCZqEmpgaGdfLdAyM0IOBorhWTYa1KPpyYjUp0PN
	zIDmoyptGqVigT8vHToxF0sKxFUjIRVm9xuiMql7Rx2BhdO2Byb3xsmVOFzZoUlKgqrQXg9aQ8G
	Q0zIxgnKL5h6ZKDh1YwU9gaRWHnTAsD7qYjsuzLvqNcfMHNwOpZLMCLei1PWJRKqNUBiJWPvGkA
	qTZrkR9QIAQ0EJMuL4QovH5l03ySzPBsnaXJnKknpovMvyEeZH0d/tj/o8vVF+Un/C1y2fkwima
	IEAzZby4FrscAnQLtsnD6MSDuJ5D91rqa08Z56lbW4aM=
X-Google-Smtp-Source: AGHT+IEJi9D3i6knXbAjsckZ7Ciww/QJ7BLM67HvKfXZJLKXPgCmFN58CA6mh9SyrO15bCmZYpI2PQ==
X-Received: by 2002:a17:907:3c88:b0:ae3:ee3a:56ee with SMTP id a640c23a62f3a-ae6d1266a1bmr305624866b.3.1752072924078;
        Wed, 09 Jul 2025 07:55:24 -0700 (PDT)
Received: from otso.local (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6b600ddsm1116795766b.158.2025.07.09.07.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 07:55:23 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH v2 0/4] Add support for eUSB2 repeater on PMIV0104
Date: Wed, 09 Jul 2025 16:55:13 +0200
Message-Id: <20250709-sm7635-eusb-repeater-v2-0-b6eff075c097@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANGCbmgC/22Pwa7CIBBFf6WZtWOACtWu3n+8uKB0sCxKK1CiM
 f33h/UlunB5ZzL3nHlApOAoQls9IFB20U2+BLGrwAzaXwhdXzIIJiRTgmEcG1VLpCV2GGgmnSg
 g65ujlbIRJ2ahnM6BrLtttb/nVw50XUp7eg2h05HQTOPoUltltecKg+HwiS0WG7SsnjTxxqXFO
 39BK1Vdc6M6bnWbBTxJg4tpCvftn8w31L+6/K6eOTLkp/4o5YFTdzA/VrswD5OnffGD87quf4d
 lDUsmAQAA
X-Change-ID: 20250620-sm7635-eusb-repeater-0d78f557290f
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Abel Vesa <abel.vesa@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752072923; l=1322;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=+2bfuo/XxdFtjNlpBnRSz55oWsfelV2bXIgIhY/HOGo=;
 b=xWvHS2PiKGx9o1Y75d8aHnX5JAyJpQ/n8m6U4OfOHpTGyPApAs6B48YmWcriEDLmsi3xk8qVe
 PPsYGLmQPflDDpV6LeYtlYy1puVL7D8jpEP5qSk6tv1ji9/vpUFkq2+
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Add a new property qcom,tune-res-fsdif for the eUSB2 repeater and add
the compatible for the repeater on the PMIV0104 PMIC.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Changes in v2:
- Expand the dt-bindings qcom,tune-res-fsdif commit message regarding
  the register value in dt.
- Pick up tags
- Link to v1: https://lore.kernel.org/r/20250625-sm7635-eusb-repeater-v1-0-19d85541eb4c@fairphone.com

---
Luca Weiss (4):
      dt-bindings: phy: qcom,snps-eusb2-repeater: Document qcom,tune-res-fsdif
      phy: qualcomm: phy-qcom-eusb2-repeater: Support tune-res-fsdif prop
      dt-bindings: phy: qcom,snps-eusb2-repeater: Add compatible for PMIV0104
      phy: qualcomm: phy-qcom-eusb2-repeater: Add support for PMIV0104

 .../devicetree/bindings/phy/qcom,snps-eusb2-repeater.yaml |  7 +++++++
 drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c            | 15 +++++++++++++++
 2 files changed, 22 insertions(+)
---
base-commit: d9946fe286439c2aeaa7953b8c316efe5b83d515
change-id: 20250620-sm7635-eusb-repeater-0d78f557290f
prerequisite-change-id: 20250616-eusb2-repeater-tuning-f56331c6b1fa:v2
prerequisite-patch-id: 5c504d171a4d1acd9ec376e01e0dd0fddbad92b8
prerequisite-patch-id: 0c97dcf5472fbed8ef4cffbd482f3169fe1e972d

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>


