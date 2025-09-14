Return-Path: <linux-kernel+bounces-815657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 982B2B56984
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 15:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59D6C3A6B6E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 13:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C751F1315;
	Sun, 14 Sep 2025 13:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RDUvw4qs"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DB535957
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 13:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757858316; cv=none; b=aCIQkStmfDKT3mACCYl+uB05shJ4hsj3TMHPKOLOGPQK7jUebkyh/FCzvkzuJg/OAPDicA8FxpZlzJqs1ia48qOXDgjUA16W3GPAJ6IjtGKrPotKva2KcXTyEKQkDBDvSwDBcQ++AKux2/9iYrua8mySBh1GqN0KUAxcxtN8K5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757858316; c=relaxed/simple;
	bh=3DSZ9s2DANNYKPQcKLUe3zmJ00fltppqFY17S2kZcZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bu81Bn87orHvdZYI9PFV7m5j7BdFMD/e96vsDQZHicLRkR9A6potDA19DE09p2QnSbTbqFxgsDrvxfoHlYrPPrAhF+pK+EiUAYQNDdaLrsvD4c7UI5oR7xLXAuZfQyakEE8HIY4ZpvQWGl2zwZ8We2z+9zouAO+m1WVnZMv8BoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RDUvw4qs; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-55f7ab2a84eso3145876e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 06:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757858313; x=1758463113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b+JQ4r5PDj4R8lIryIhg8A2awcNjFM3HKh2AWh4qFhM=;
        b=RDUvw4qsobREc+/PrbaOLt53JHsLSTS8BorgyAoc9o1bDfKERofr3+OKziaOM/5Q4g
         xjWSEjC+3Z5+i7IC0SFEDddDUgJ050oRHvaJVeXK6+1DZ8HOLBDAs8yr4yHGhjGqnaR5
         vXb+/QjCEicKDo7i47sy0keZo/hkDX9UCcMCE0d3lAtwQm9UO09/bUtk1DrWEU81BH4N
         Ld7/VsQk1Mxc33Nf6tMGI0R6CzcEZag3+M1dHooSh9ARpX+Qk+Cm6QNgLsHwiFTmGdUg
         LHp+E0dm1jPbloruIoyaNLFVGsBcEhQi3hzRKI4dP9oAlckAYsb53tGXuSRoZkDeHF32
         kdUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757858313; x=1758463113;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b+JQ4r5PDj4R8lIryIhg8A2awcNjFM3HKh2AWh4qFhM=;
        b=rupVB80EZMTdp4XYZ9oJl43j6jKKnjebmlHSu7kkmfYtfjPOVfeKdFbp/W0E0W+M/I
         lPje3wqkiBW+Kz8jvu/EAOAeaWU8I5p8PmGz/Gf8/tKxeuOFvuZdpvhIid9/7U7i9CMH
         AC6pOeqFexfXcTkrAP1PjNR2C2ByE06Vi7+IBPEEP4CLkm7ZhlXcoR9kTAS/QaJIw2RS
         F2u/7Gjx8e3tb1OVH7HxekGhpk8I8Gst/9PI6nQWYlRmF28f+F8Sue7aLziV5aRunMyq
         aS3Fytza7pg19lqQgAJKF0BBrSLAixejY66Wd+72p1dHY6uOLJ8iQRZfA5PI8NtJlNPQ
         ownw==
X-Forwarded-Encrypted: i=1; AJvYcCUIoqLeduiFLwEDMpBbm6R1Vxnopie9r99q1zDcWdQ1UzGbOMvq86kgQwEa3INmuVDzoA1XHWWUx/2iZlo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQF8GMznI2z5cav8JgYaxvX+OXYC3pREqkMaQmLIKB9sy5pEtK
	NlgYXcc96Zs7JqvyhdBGx/XcfYjCXuaSwNQAHTEBfxE64BGLOoh+lNmc
X-Gm-Gg: ASbGncv3Jxrb+9BL05ZxEvCa+xdHmmv8DApWwsL1of6Clrgj3AnKo6tvPLlYkGk1PGJ
	5Ta+rhj6cfT+OAYUKtSKPYNVqImVz2D2yExJdTkr7/N0kbhIFE21csnxmUbFsyiff5Zjpaaq+/V
	r0CcvXSBIP4kcqRL3ICLl4BYBR4PMHpOI8Bt6noDRjTpVeIV98Dxf3N/IkrgvQhRDEajBZhLM/f
	6UAfGsqn7BHOcT+LO9xJBwOQHGTjTgmUcfLcTFzhOSTYt1n8Ru0uyxIU+tbIg1Md6v6IAkihas3
	ISAKQCq8uqhgPkjZV0WEHGClQvU3W6d9RErZSLgRH1Io14W4opUYailoNBjKC1WIzii/dEaYxia
	amJZ215LbE9s+03Dp0WgFaDEL
X-Google-Smtp-Source: AGHT+IExdpXunQGol+DW1knCbeObDIX+rDrTqqxE2omvrrj3UQ5Dw9nR9gQ4rjIZz1H0Y2IylfO9jw==
X-Received: by 2002:a05:6512:3d09:b0:55f:4512:7206 with SMTP id 2adb3069b0e04-5705212662bmr2889867e87.50.1757858313003;
        Sun, 14 Sep 2025 06:58:33 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5701c93cc05sm2320551e87.114.2025.09.14.06.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 06:58:32 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Thierry Reding <treding@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Ion Agorria <ion@agorria.com>
Cc: devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] ARM: tegra: add support for Xiaomi Mi Pad (A0101)
Date: Sun, 14 Sep 2025 16:57:52 +0300
Message-ID: <20250914135753.94277-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Mi Pad is a tablet computer based on Nvidia Tegra K1 SoC which
originally ran the Android operating system. The Mi Pad has a 7.9" IPS
display with 1536 x 2048 (324 ppi) resolution. 2 GB of RAM and 16/64 GB of
internal memory that can be supplemented with a microSDXC card giving up
to 128 GB of additional storage.

This patchset includes some schema changes not yet applied. They can be
found here:
- https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250909143432.121323-2-clamor95@gmail.com/
- https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250912065146.28059-2-clamor95@gmail.com/
- https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250912064253.26346-2-clamor95@gmail.com/

---
Changes in v2:
- added fuel gauge interrupt
- added CE gpio for charger
- removed always-on for vdd_gpu
- improved pinmux configuration
- added camera regulators
- removed usb@70090000 (already disabled in common tree)
- set correct modes for mmc devices
- removed thermistor thermal zone (not used by mocha)
- fixed pmc interrupt polarity (removed interrupt inverted prop)
- configured OTG support
- removed bluetooth reset-gpios
---

Svyatoslav Ryhel (1):
  ARM: tegra: add device-tree for Xiaomi Mi Pad (A0101)

 arch/arm/boot/dts/nvidia/Makefile             |    3 +-
 .../boot/dts/nvidia/tegra124-xiaomi-mocha.dts | 2790 +++++++++++++++++
 2 files changed, 2792 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/nvidia/tegra124-xiaomi-mocha.dts

-- 
2.48.1


