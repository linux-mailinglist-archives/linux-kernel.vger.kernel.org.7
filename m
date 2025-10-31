Return-Path: <linux-kernel+bounces-880185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F1CC2512B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D96DE189BE70
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D9C34B43A;
	Fri, 31 Oct 2025 12:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tkuvf8gl"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F11186294
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 12:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761914726; cv=none; b=fPsrBBlFhvBhE2EsoxMh9NFM3hogil/b0+rQOU14YPQWCqKn1nIVWewFuW1UwjdRv6A0cbiTGV4TiPeaS6cNk9V9C/ca8fVuQaUA3Y1/Ai8sNdr8m0dG2qnfqTq6SgmjBfBzNuTUsQv5WjBFkEf4CTnDPtGQ+kbVgPcuBNimrAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761914726; c=relaxed/simple;
	bh=eShtlJ8Q5lLAIYL5hn7v+uZe4nyW0U4dTV2Vv/o37Is=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ooFEYHK1I7Ntyxcm45tbEXAnSDpfY59JRUXRSpfUiJCADJAltnI4ZSTjCwUVuzGPCoQ7xEmjrqDllz/8xqCdI5jBvdPePAh5dc0JJCpXPdFEu1Y0rrRwj3KGGOw6emcguJui0ueCJxPgAxkJzqfcGu0b80hv6bBx9xHabTtIh8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tkuvf8gl; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46e6a689bd0so21677805e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 05:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761914717; x=1762519517; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cbj3gKZ0mzSwdkwPXRoDa/eaYfVSxFDtUK1SIosiT1M=;
        b=tkuvf8gl1vis+wTuJce5VQPBQI8OXyaXxO7Oe/Kg9R2bBf0cZ0UiSOLp2ONdMl/YWF
         f4CYcAixwuCSCiN3gSDFMuIU6HffGEeRTE+ig2ImLchnH0Yiibvyaik2S9QbKcR50J1v
         G3xLFVAF/QA6VA09KivxvFLeIBDA/lC3E4en3TpVj43B1eJzaRz+BS2hyv/qMMBf9WuY
         jlr76nUTkZZFz6SyDN18cuBdF3cJcdlzlYKn1Spcbw48fjyLvC5Hv5PSL/EjJpr90xkn
         M6CnjRpCiVh7YzaOzkkkeRmf73UYHbhAHZ4xwxzVLin+vKUz/jTyGPSh+ht+wS7Eh/CG
         hZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761914717; x=1762519517;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cbj3gKZ0mzSwdkwPXRoDa/eaYfVSxFDtUK1SIosiT1M=;
        b=TtFUPZ0Du6mfflZfMggKvHO6ssvZ5aRtubYi+06/yGaF9tRnoZlBnKW15ymKse2nIT
         wmKIOOLiAL8Q1ehj1Iihl5bwg3fZJk6NS7usNn+Aoifrmdgt3AF7RL5yRXQ1UF7732Po
         f+J1Er6Du05ClPEf37INPsB9sLLji22v3Yjo6yGkSKMNvypLDSh/WAFHAEo6I9sa3RY3
         UTVOui5HOlRpfdKiRQD4nIbN1yM3PAWBk31d2nWWKR2xretjY5h4tptheyGfpQaYhtxQ
         41UQPpz0gbarxO5hNxBbKYKge/+8ZcYBikc32iSfhxVPApLlh/EY6tGiXkgBmm5ZaqTd
         naVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBf+JKy3w/qsWZX2bVlueIvbJ1CIbykZV6zVfgBeXsSKEg/xqlc+gdhlLI/ioXFOWHbeHAUGDd8K3NWGE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh35FEp0MauAceYHKhdafGsjTKSwwmtEHf8wszEGaQ1QY6E4PK
	gTaPt+mZATSe9t51wkVTPKOX6624G5vWmiUZv6CWMDrYU6NZalfu7qWZSpRm7hg9dDk43Mj/vE3
	N4PNK
X-Gm-Gg: ASbGnctBNlSg4GCIWfboDbC5bf2a4aW9g6iiPdWTZlQa/DTg1idJT9WO4j6suWg1vPT
	tks41aU7v2dWBQ6tA1bQKVVMkhVNSTfx2LSZQlWlZHkyGimsCuDHz5t8IlCjNQj1fePVlBZkieJ
	TjgAp8kYuJVHd9uGaxxYyS0Dv83OqKhTUOWeHk+MqvQUuLl4jG3OVpZLqRAkRgvuqLP6mgKfstg
	0TfygC2L7sCiEWQVMdtdgyjtl8X0oVmGxA9d2BpNX8KiJvsqjLHp8IWewpBuDZOTQ7Ti3KBgPuD
	YIOY+1QBD+ABCv0gMrExpLnVMdJVrKq0ZNpXgiiWhPHkZ81aeGju/SQfv9Fg9P5/lKBPGzlSZZx
	ZTmc8C/x6LfXfzPeIDLSlWOfOTl+FuI7mb8Pl06chprOZL560Fu54bE1Sj4XPTXRy4HT7AmhrST
	XpMY52B+2knQ8ktX4Z7pyz7kiyRUlL0rulIQWqBannRKd8bmGI8Hk/
X-Google-Smtp-Source: AGHT+IHqy0NvjSEdkC5QA4dlobMBtMSys4ERttR9A7YfgXRw5s+9LrWnpqc3fCglT5Vt6XnCw3B/fA==
X-Received: by 2002:a05:600c:4687:b0:45b:7d77:b592 with SMTP id 5b1f17b1804b1-477307c1f24mr29666305e9.12.1761914716741;
        Fri, 31 Oct 2025 05:45:16 -0700 (PDT)
Received: from ta2.c.googlers.com (213.53.77.34.bc.googleusercontent.com. [34.77.53.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47732ff7fdbsm31077535e9.16.2025.10.31.05.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 05:45:16 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH 0/5] nvmem: add Samsung Exynos OTP support
Date: Fri, 31 Oct 2025 12:45:08 +0000
Message-Id: <20251031-gs101-otp-v1-0-2a54f6c4e7b6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFSvBGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDA2ND3fRiQwND3fySAl2jNGOLVIskkyRzS2MloPqCotS0zAqwWdGxtbU
 Av8ZwdFsAAAA=
X-Change-ID: 20251031-gs101-otp-2f38e8b4b793
To: Srinivas Kandagatla <srini@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: semen.protsenko@linaro.org, willmcvicker@google.com, 
 kernel-team@android.com, linux-kernel@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761914715; l=1825;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=eShtlJ8Q5lLAIYL5hn7v+uZe4nyW0U4dTV2Vv/o37Is=;
 b=Cav6xp6EkVef+kR5+xm0NcqzjGfCB8JtxlbVHdTW7e4KMSsgOBlOfS4QS/NSWUZKRyXAq0Ff3
 4hPYHB6jVi2BPtPgXa6/b8DGjvet/fG+YJ7cfBVavtwrAhttcx6A8OS
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

The patch set has the typical dependency of the DT patch depending on
the bindings patch. I propose thus to have the bindings patch taken
via the Samsung SoC tree, if not all.

Add support for the Samsung Exynos OTP controller. On the Google GS101
SoC, this controller provides 32 Kbit of OTP memory space that can be
read/program/lock using a specific sequence of register accesses.

The OTP controller register space is of interest as well because it
contains dedicated registers for the Product ID and the Chip ID (apart
from other things like TMU or ASV info). Register the OTP controller
register space as a nvmem device so that other drivers can access its
contents using nvmem cells.

Support for the OTP memory space can follow and be modeled as a
dedicated nvmem device.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
Tudor Ambarus (5):
      dt-bindings: nvmem: add google,gs101-otp
      nvmem: add Samsung Exynos OTP support
      arm64: dts: exynos: gs101: add OTP node
      arm64: defconfig: enable Samsung Exynos OTP controller
      MAINTAINERS: add entry for the Samsung Exynos OTP controller driver

 .../bindings/nvmem/google,gs101-otp.yaml           | 68 +++++++++++++++
 MAINTAINERS                                        |  8 ++
 arch/arm64/boot/dts/exynos/google/gs101.dtsi       | 17 ++++
 arch/arm64/configs/defconfig                       |  1 +
 drivers/nvmem/Kconfig                              | 10 +++
 drivers/nvmem/Makefile                             |  2 +
 drivers/nvmem/exynos-otp.c                         | 98 ++++++++++++++++++++++
 7 files changed, 204 insertions(+)
---
base-commit: 73f7017e663620a616171cc80d62504a624dc4de
change-id: 20251031-gs101-otp-2f38e8b4b793

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@linaro.org>


