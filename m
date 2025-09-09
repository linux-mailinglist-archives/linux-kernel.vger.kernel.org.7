Return-Path: <linux-kernel+bounces-808793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 849E6B504CF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 544491740BD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 18:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D30F2C0273;
	Tue,  9 Sep 2025 18:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MfLEcX+T"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998D73002B3
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 18:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757440901; cv=none; b=Quab8RwadUOKh0wYOExBHYf0JTKaO4A6kymt68ubUpETgcpLCzSCOeKW2Mas17RkqzdAuz2jeyQEpM7PnGJxaBBJUHwIyDiPo5bnq5oPAh1COoj9SSdYjK+02l4DhRXnAQiPK8eZpG0prvzRB+ZtQ+Ma3Nv7++bQ+CqcvPwDsbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757440901; c=relaxed/simple;
	bh=lPSneZP6QA4IVA2DA2vcr6ck9xWg1uRXp8PmH5pXh0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kwz0n4buI2ftUF/Mbf/L8yLk2xXmgUlxNOZU4ETw4fQZaKvqsfwEGKmz9iVSUWbHlYp7RVv/Wp4+AniYFtCaK9npcRr1IZ/NT8p7BTesWj7ECVfGPQiprPxDP2T6c7LjlNrmDxcH0rDdzVZF1L3K5Nrbr8D7+KvDJVX8/LcmbJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MfLEcX+T; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b017e4330c9so67918666b.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 11:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757440898; x=1758045698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NB3rahRir377R/zsN8HMeSS97H1bc/fP4p5/jH1URm0=;
        b=MfLEcX+TwAAlLLpolOxXl7QApTRgegL4+PttY1mXCc6ne3qnneV45N7Pv/gdLFjl9y
         ldmHo8drwJ/wWA8ZxeR/hx0nPMdbQTeco1vHsB2B/hLp7mOQY6jtctBpufb9G92M8xil
         Gq/7PNV4vcbL47/Vf03Do/GIUcniORNgKkw2uSvwN5YdLUy8S7mrbTkr5W/MggCZSRNg
         G0kNBy41oXtUstXsWmAYCpoK/VcyPb3vo9TfblfzdJnnGrF84LYB9HMasMhs+9RNKAGI
         GrZNqmf31kwexEEcKdCdUnXwKL0lGC5RZUaarZjG7qI7mcfZPyGRcH0Zo1ec47F2GRMO
         seCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757440898; x=1758045698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NB3rahRir377R/zsN8HMeSS97H1bc/fP4p5/jH1URm0=;
        b=XUKAQm7jhNge2Z1LFrn7I8mXEzZvxPIhK5iqJeJU5JsqeBPb0QFteHVxGUjXbOPbdx
         Px55wjMdR1LtKfN3o9jJttocJt/f0FWeaPCfrJMVCbx2zfMCuIw1nd+Yp+RuUX1ne7CY
         avj9EnXtd2Q64mWY5l+IGlnkWOe9gCyrcHXUZLdIDz+dM5sCZD9LEVUwPEmJZ3WYZ2Rl
         d+uNMs6cYbwZbITZYiX2eCKkLnWhyRnkA1GvwVtYu2cjha5sKLZZ7S1A85OohiiXLEtZ
         7EqLFg9dQa5fzv6IM6hzxDPfS4qjU/40rwIrQHvPvrqcET6P5P71pRY0PZvwtdhqsj/Y
         OwZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeXX4wM4EitrPnfYvODh62Szc8ubP6PwZ+U4RFrM/n/mi8ppljmiqzfHzKeDfEhJ686eUdJq/ES7Kd/Fw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ5HF3AGgsmeOqUertUrmFZf0+Uadf974IB0zfXTLSsrB9jDJn
	8UOHTG5eYTVxdzbSTrLvoa4MvZw+H3bw5poMNobTa7g74u8Oip6k1dy98OPFwKlO0+Y=
X-Gm-Gg: ASbGncuLLe7tJ1T68lRWbuKgDiJ2Xrv/1tMDMUHpaFPQ7KBBFCyvdMmgelcZ0voLcNR
	lt8Rmar6qj3stMsfc/T7t2iJqKKJeELbsksH+2Z9TFzRDKNk0FrgkDRGcCm+m/Zb71wiTrM3tFq
	F2H1erxnmqSkfUmCfv0QooHqqQgrft7nu4ZJMR9iAeM4Df3LeoeMQ1j8T6769E0tCzUmI/eD8UW
	KUOs0je6Rcx6OWiT7MDDpoObRYb20DRYBfgDTzGVO13zpkSTM6V/CblfgROZYpFGGLRMtWrqLQc
	aAiiJsFdDyhIeyjxJzzRt8nhXTM9ggyp0eHcEXccYjaQytU1yzxAr2mbNwmc0zGEoaBj/mvFEO4
	f1TYabJiDSj0Ucv1Y7gMzx6w+5Ko8NR59WDMkmUaemPsl
X-Google-Smtp-Source: AGHT+IGXL1lC6sfR6puzIfYw5N3tfqCgjfuu9nQRbjgZ453UE5FzV7MG4pX6BoUszCm7i8a3ZjXp9w==
X-Received: by 2002:a17:906:c113:b0:afe:af91:2e54 with SMTP id a640c23a62f3a-b04b16e17ffmr664688966b.9.1757440897721;
        Tue, 09 Sep 2025 11:01:37 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b078334e899sm26294666b.64.2025.09.09.11.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 11:01:37 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>,
	soc@lists.linux.dev
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL 2/2] arm64: dts: samsung: dts for v6.18
Date: Tue,  9 Sep 2025 20:01:27 +0200
Message-ID: <20250909180127.99783-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250909180127.99783-3-krzysztof.kozlowski@linaro.org>
References: <20250909180127.99783-3-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4448; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=lPSneZP6QA4IVA2DA2vcr6ck9xWg1uRXp8PmH5pXh0g=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBowGt6T0IuM1YHzvBZgMmsxOPoA4RqAtH4l9R+s
 O/+YUMZ7M2JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaMBregAKCRDBN2bmhouD
 13ukD/9SHoOx8xFBNg3/qjAVgkV/PKibiiWFgSvp6djzxC911MYrbS7OtoTWqyhX0xK0iyHuOW7
 PN8neHL723EiARZT2emcAKewRCoVR+JIpupio/HkHlJB6y5vbgjg2IenEfimryx1cOrMNfqZQ+I
 cNO/zF9Ju65IZy3iewiWmkDa+fU3bmvaghQAFUn06v9pwFskOwx175V59C8dhz0esy0AzJ4WOle
 CynzK3kMyxW0zgMCfY0VJlb1tHLT5L3aKshyCcMyWobfXTYUEtrgMg61ixGjB5+N0mzpfsBXAIl
 RogLQahDUlFbZznXU9t2i+3p95Itak+WQIBELc+jNYF6nQ3sPzbnbrqN+APvTbzk5wGb7Qxda68
 YA7TQzvqUOy49Fs3M96g2MNNXPMAklgxHapdg/vZfpUPUUcANjvQUt0NAVSh1SfeiR7iJ6+XyCc
 ZPN1xATGm49wV0tIklKkRCCumCv7bcL+8N7uLz5UO/47GrBVJC2iKUxxSWs+mqzVczxOwqz7/y+
 mwDLOiqF44cEj8+rYp4ZVPV1knxExrSErXOhIFKAZabB6EEaJ/L/RLpMs7/6NZTAhFKbF832zDp
 soWki6uSTE8O+5IY83+E8U9FPyZM7SedwJ+wVqxLn2RE675/djB6hWgnzx7u4RDJ0Auo4oHsWdJ f9vWGBZswpSDS7g==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt64-6.18

for you to fetch changes up to 44b0a8e433aaad8aac51593a052f043aeb9a18d1:

  arm64: dts: exynos990: Enable PERIC0 and PERIC1 clock controllers (2025-09-07 11:13:06 +0200)

----------------------------------------------------------------
Samsung DTS ARM64 changes for v6.18

1. Exynos850 e850 board: Enable Ethernet.

2. Exynos990: Enable watchdog and USB, add more clock controllers.

3. Exynos2200: Switch to 32-bit address space for blocks, because all
   peripherals fit there.  Add remaining serial engine (USI) nodes
   (serial, I2C).

4. New Artpec ARTPEC-8 SoC with board. That's a design from Samsung,
   sharing all basic blocks with other Samsung SoCs (busses, clock
   controllers, pin controllers, PCIe, USB) and having media/video
   related blocks from Axis.

   Only basic support is added here: few clock controllers, pin
   controller and UART.

5. Several cleanups.

----------------------------------------------------------------
Denzeel Oliva (1):
      arm64: dts: exynos990: Enable PERIC0 and PERIC1 clock controllers

Igor Belwon (5):
      arm64: dts: exynos990: Enable watchdog timer
      arm64: dts: exynos990: Add USB nodes
      arm64: dts: exynos990-x1s-common: Enable USB
      arm64: dts: exynos990-c1s: Enable USB
      arm64: dts: exynos990-r8s: Enable USB

Ivaylo Ivanov (4):
      arm64: dts: exynos2200: fix typo in hsi2c23 bus pins label
      arm64: dts: exynos2200: use 32-bit address space for /soc
      arm64: dts: exynos2200: increase the size of all syscons
      arm64: dts: exynos2200: define all usi nodes

Krzysztof Kozlowski (5):
      arm64: dts: exynos5433: Add default GIC address cells
      arm64: dts: google: gs101: Add default GIC address cells
      arm64: dts: fsd: Add default GIC address cells
      arm64: dts: exynos2200: Add default GIC address cells
      arm64: dts: exynos8895: Minor whitespace cleanup

Ravi Patel (1):
      dt-bindings: arm: Convert Axis board/soc bindings to json-schema

Sam Protsenko (1):
      arm64: dts: exynos: Add Ethernet node for E850-96 board

SeonGu Kang (1):
      arm64: dts: axis: Add ARTPEC-8 Grizzly dts support

SungMin Park (2):
      dt-bindings: arm: axis: Add ARTPEC-8 grizzly board
      arm64: dts: exynos: axis: Add initial ARTPEC-8 SoC support

 Documentation/devicetree/bindings/arm/axis.txt     |   13 -
 Documentation/devicetree/bindings/arm/axis.yaml    |   36 +
 MAINTAINERS                                        |   12 +
 arch/arm64/Kconfig.platforms                       |    7 +
 arch/arm64/boot/dts/exynos/Makefile                |    1 +
 arch/arm64/boot/dts/exynos/axis/Makefile           |    4 +
 arch/arm64/boot/dts/exynos/axis/artpec-pinctrl.h   |   36 +
 .../arm64/boot/dts/exynos/axis/artpec8-grizzly.dts |   35 +
 .../boot/dts/exynos/axis/artpec8-pinctrl.dtsi      |  120 ++
 arch/arm64/boot/dts/exynos/axis/artpec8.dtsi       |  244 ++++
 arch/arm64/boot/dts/exynos/exynos2200-pinctrl.dtsi |    2 +-
 arch/arm64/boot/dts/exynos/exynos2200.dtsi         | 1434 +++++++++++++++++++-
 arch/arm64/boot/dts/exynos/exynos5433.dtsi         |    1 +
 arch/arm64/boot/dts/exynos/exynos850-e850-96.dts   |   15 +
 arch/arm64/boot/dts/exynos/exynos8895-pinctrl.dtsi |    2 +-
 arch/arm64/boot/dts/exynos/exynos990-c1s.dts       |   16 +
 arch/arm64/boot/dts/exynos/exynos990-r8s.dts       |   16 +
 .../boot/dts/exynos/exynos990-x1s-common.dtsi      |   16 +
 arch/arm64/boot/dts/exynos/exynos990.dtsi          |   77 ++
 arch/arm64/boot/dts/exynos/google/gs101.dtsi       |    1 +
 arch/arm64/boot/dts/tesla/fsd.dtsi                 |    1 +
 21 files changed, 2038 insertions(+), 51 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/axis.txt
 create mode 100644 Documentation/devicetree/bindings/arm/axis.yaml
 create mode 100644 arch/arm64/boot/dts/exynos/axis/Makefile
 create mode 100644 arch/arm64/boot/dts/exynos/axis/artpec-pinctrl.h
 create mode 100644 arch/arm64/boot/dts/exynos/axis/artpec8-grizzly.dts
 create mode 100644 arch/arm64/boot/dts/exynos/axis/artpec8-pinctrl.dtsi
 create mode 100644 arch/arm64/boot/dts/exynos/axis/artpec8.dtsi

