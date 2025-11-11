Return-Path: <linux-kernel+bounces-896081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BE12EC4F98C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 20:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 430A0346260
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 19:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAAF325734;
	Tue, 11 Nov 2025 19:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fworl9JJ"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D265227814A
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 19:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762889201; cv=none; b=UuG3EtN0Tbyq7/rBwmZ4MiP6xqdkaozzAbZQkf0Vqw65575BAfGvkVKfjSw7RTdBcHlH3W1S1ICNzcSK3XwLs+nDQRwiDOctDy679MfbfkzvWMuQdJt2E4zh+7HVFEikWZjc5vIAWs0FGUWTeWspYaxwE/mbyye1/7Dt2jOEQeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762889201; c=relaxed/simple;
	bh=f5tl5Jvq2Hy4zPlmf7aG3KhINJQaIW2CKTgzdHwDxdg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g6mMj/u/d28KEVePm76UkLsewgillvUimdfq4ZK+d3oxvSpxkx147b4AIwExAMXppcv1RCI+cdY15kayYGngdwrrsWP/vZsKg5MDKxANStxfpgnmvWO+de1S60tkHT+xb2Pss2mYvYhhtmFDTT6FlnIPfCgMmTJgtVgasCZOkSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fworl9JJ; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b62e7221351so52205a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 11:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1762889198; x=1763493998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R3hXO0kohcojDK5N1gDQnbb7SNR3dS5AVJdqaUadyUo=;
        b=fworl9JJ+4vd3fn2WOlGb5AqkA6rYiZCmYBo3d8aQGQ/NqLkXAa0JVpDvJ9nuWPKRz
         d8RiWHeAVHBDeQ+L2pljavh42DtQMbly8l+/q9T5mt9H24Tn0ZevyKB0JjIYrztvMmC/
         +OAG35/iohrb9LkjxkXhwy2Uwdr1kC+w/fjMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762889198; x=1763493998;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R3hXO0kohcojDK5N1gDQnbb7SNR3dS5AVJdqaUadyUo=;
        b=ASHbllp/JY1yh+fgFUv7UkseZq8AV0uBPsJ/Uql/sRNlBNFHuhxUHWMmAu8mCkDILb
         4E/CeUGe9B29UZ0zJ+3d4YC0jcXRHoBvmt2d2Tghd2gOsk8UKZtzwuKGtlm+bT8TSmrt
         l6FxB+WYVOJk23d0qM2kilRIvDLJ03ziJhHsvkSNvb2bhldNz8hFtr+kx/e+IYEumQ+g
         r/PI7BCFZX9o9r/R74pHsbas04seJ5W6x2u+NMe4j14IFn6ymtz0t32qtz+n8dEwIj06
         VJCfc0jF/j8kR51PWgEA+dHD6OyoQ4e0v+9nchj7DYR9tFdaFgsQSmUH/Ll79WgpzfFc
         FiWw==
X-Forwarded-Encrypted: i=1; AJvYcCV/005M6bOo/BQok8brTo2Q/BrLG2/s2Lu6ok6UpxkwieZfEleEjU1h/2mf/2W/FFIqGhav/uRSGmkGec4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGc3khtDIdR2/TB6C2jodSiP7r4mQ/PExP6SyboGqhXPhLUBht
	XSCdxYNDknLxfAzuYchxvd8WcVoeLnYxHdmQTRK7BBTuZBQCzuOEjo/E2n2/OxcoRA==
X-Gm-Gg: ASbGnctpgiXJlLsKnO91rkXAdPyStdNrutOmSW6crQG92wUtaB3BuhyoHUYtV9+tW65
	81MWD3cy0JlbeyYuoL9o+KqjmsKVBcFg9CXUn4xqUpytHVgaJgNOTlJTYofyFHSOVUmbbehzNNc
	VuL6Tf41ZAmGDKldmZ1mqRnqRpzoWulDIxtuSqAtbLtwkmNZEeEN1nei5tg+TQ9ZmcYz6O5qx2s
	rzOnwlHurCD6HuIT7H//dqAZcHrRZDWvdE4Bud5joej3tvVndwRQ4THXDdrjcvjFF5p3r1+9yT4
	9A62NH0dsXB60wb4qJ9SbGBtQInlkgg+mMsdKky1K6OdTjw6RRsh3JZLJ42NJRa/aQpoRPd29AV
	eVQxR64dP7/r13e5IFus59MHGBixowSy51o9y6C7zXJ/LiJVCRuqdNCfv9vsW2uuZ9y/2Xcr1di
	sCfdHzwEtkxAsdf4I7iI1fyr8//xTa+h/nvx1ApmUD10o7+RhQY5Xqoif/Qz0=
X-Google-Smtp-Source: AGHT+IGzawljQPfuMSEdjKEu2O+TbUwNMNOGAm74gscUESQKCa416kMewGM3RhTWM1GA5ootFgKOLg==
X-Received: by 2002:a17:902:f684:b0:26a:8171:dafa with SMTP id d9443c01a7336-2984ed49524mr5944105ad.21.1762889198163;
        Tue, 11 Nov 2025 11:26:38 -0800 (PST)
Received: from dianders.sjc.corp.google.com ([2a00:79e0:2e7c:8:ba9f:d4c6:9323:4864])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2984dcd0974sm4861075ad.90.2025.11.11.11.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 11:26:36 -0800 (PST)
From: Douglas Anderson <dianders@chromium.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	=?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: linux-samsung-soc@vger.kernel.org,
	Roy Luo <royluo@google.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Chen-Yu Tsai <wenst@chromium.org>,
	Julius Werner <jwerner@chromium.org>,
	William McVicker <willmcvicker@google.com>,
	Douglas Anderson <dianders@chromium.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Drew Fustini <fustini@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	soc@lists.linux.dev
Subject: [PATCH 0/4] arm64: google: Introduce frankel, blazer, and mustang boards
Date: Tue, 11 Nov 2025 11:22:03 -0800
Message-ID: <20251111192422.4180216-1-dianders@chromium.org>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


This series adds barebones device trees for Pixel 10 (frankel), Pixel
10 Pro (blazer), and Pixel 10 Pro XL (mustang). With a yet-unreleased
bootloader these can boot to a UART command prompt from an initramfs.

The end result of the device trees introduced in this series is really
pretty simple, so it's expected that most of the discussion in the
series will be about compatible strings, file organization, dts/dtso
organization, etc.


Douglas Anderson (4):
  dt-bindings: arm: google: Add bindings for frankel/blazer/mustang
  dt-bindings: serial: snps-dw-apb-uart: Add "google,lga-uart"
  arm64: dts: google: Add dts directory for Google-designed silicon
  arm64: dts: google: Add initial dts for frankel, blazer, and mustang

 .../devicetree/bindings/arm/google.yaml       |  87 +++-
 .../bindings/serial/snps-dw-apb-uart.yaml     |   1 +
 MAINTAINERS                                   |   1 +
 arch/arm64/Kconfig.platforms                  |   6 +
 arch/arm64/boot/dts/Makefile                  |   1 +
 arch/arm64/boot/dts/google/Makefile           |  10 +
 arch/arm64/boot/dts/google/lga-b0.dts         | 391 ++++++++++++++++++
 .../arm64/boot/dts/google/lga-blazer-mp1.dtso |  22 +
 .../boot/dts/google/lga-frankel-mp1.dtso      |  22 +
 .../boot/dts/google/lga-mustang-mp1.dtso      |  22 +
 .../boot/dts/google/lga-muzel-common.dtsi     |  17 +
 11 files changed, 561 insertions(+), 19 deletions(-)
 create mode 100644 arch/arm64/boot/dts/google/Makefile
 create mode 100644 arch/arm64/boot/dts/google/lga-b0.dts
 create mode 100644 arch/arm64/boot/dts/google/lga-blazer-mp1.dtso
 create mode 100644 arch/arm64/boot/dts/google/lga-frankel-mp1.dtso
 create mode 100644 arch/arm64/boot/dts/google/lga-mustang-mp1.dtso
 create mode 100644 arch/arm64/boot/dts/google/lga-muzel-common.dtsi

-- 
2.51.2.1041.gc1ab5b90ca-goog


