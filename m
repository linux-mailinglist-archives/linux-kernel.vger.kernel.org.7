Return-Path: <linux-kernel+bounces-775585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09876B2C0DF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A71CA1892FD1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3B932C33A;
	Tue, 19 Aug 2025 11:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lv9lj/cX"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C4632A3E0
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 11:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755603956; cv=none; b=Q7Fuo5/uWt3v4J/FJQ0N9oLySCqaEoLIXosTvpULmzX/kpY3ThQIHHjcjupAVL+uTQjzun5ArH5ji+B4FzA6+Tv25+tRz9O+21pRMC9tdLTuwHVVJtOUSV22firmmEofwieQRScTgMBY43Xw9zMoLE2MKsVMsO1U43gdrFxszMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755603956; c=relaxed/simple;
	bh=atHOVDZrHoC4KUAzLF3V2ExuFabINMR3JpSKKqoKhGM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=n/bdK2EPF2g/SsLkt3vS/5jJW+Pm6YKRHod+kUOlTm9BZBkSIvBidQboLtxDL1KNIJC+50Q5LFtJ3s3d0C2gKmKU7FvESNHhMmT/XIUXAdTjdUpzgIEkk7i6rT7j/io2FRyCU9VjqQFZ0txqwpHLP6xgSUIhTlLCLfKJ/HHgtDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lv9lj/cX; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45a28ff47a0so12552405e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 04:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755603953; x=1756208753; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9mI1h+BmNbILdGpeniKvEeoyTFz8pMoc//wK6fMdn9Q=;
        b=lv9lj/cX2UXwsb1R9a98hQn+oJ1MDC6y0tX8Ws3JMNdkTzaDJi3Hj8e8Lzk/KL5Jr1
         LEZMITgWLiGdxcKqWWUMy6XgkmDFabymAggbcEuOlmgxR/IL8pSIHKrjRQZM51mJa0qX
         bfWN77WiHAWVctXeQbBov1X6Q/9VkYTPxZt+Ldne96kVPSevhw1TXlmJU0wSb0eC+KGJ
         KSzVKGitGeO9zfnp+67ee9OmaJSwHuxfjKR7wpCsnco3xNqOkDJEDW42igYYIScXQwgD
         JeFW6ucAe2OI0POn+nvUVVJ/OClejf7g0cZ/OR/d0HBuRbQfkrkWh7vM61UcXQeFjzLq
         15fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755603953; x=1756208753;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9mI1h+BmNbILdGpeniKvEeoyTFz8pMoc//wK6fMdn9Q=;
        b=s5jg2j+l8MGHlu6uEp1cxeoMcCL/zi9Z56vVb4wA3DkFEvyKBnYCPQtOf3Vp3o90y7
         5BCPrX58K2JLmpGEpPfff+4aSvoTUcly6TjglDDgPba/44VRLAu2De1MvBf9mLBtL0P1
         7JOpZIBojT9TTqu++VLpMk8Exk9bdQ4FRCUKFn74RJffRPgALbX+VE5W4llduvwuMKf0
         92pUwi3aE6To4q21LPsAQxJcJbs6FVwKay+27zs2TcRoW4vrHdhT1WQ4FMs5NcG4naQR
         DptDEl1x24Y674SktbEtBj8snpG1uMNbHVMjCQwSpdvNjwMwjEETztS3IG55w44Ihjab
         mnqQ==
X-Gm-Message-State: AOJu0YwFzG6fzEgNsfwEf6SZWKVHTSLXLQXyUKPnumQRQm0tFtW51ACb
	/t2geaxam/hYUvIh3VWQIwtT3r+w5ZZ7q6XcOBSCVbHDHcITCFA6TMFrbu0gf16jjuQ=
X-Gm-Gg: ASbGnctZ8x//CgSg7sg3IzsuRmwKCNFGZPivO30ZW+BEgd+zBwn6JzW3znj3iVPvL+9
	ULvo6aN5D+xOdUkrZttfbYNG8bbGLYWfgpu0dM9ldL8oFqSijg2Dnvo4z/Da6U6LEADHi71P6Vn
	SR1+7Fc79rysrXa5DFr749bVGYdp0Y58hNxldvm1mm9G2YToL0LeEZPIB/Fd1lMPLowG1UIACgA
	6wvvvsjgRsuN5weQul0aV+Kf+DIV/9QloQeyHgP+QwPQxEMVi+RimICymJ/HIvu+wwncW++Nma0
	G1TkI+uNZ0MBACwoMw61kKgrxXH27M22/6jTHBT+vFg2kloNTTAaA4G8LfPck2P65O9pPTAqreq
	04N07qKyrytakV/imbuzyK2lBWKQqqLpwfEMRZF2vY7AvJvxHzYNuWFSqc/qeSW3KJjCledsVsH
	N4iA==
X-Google-Smtp-Source: AGHT+IEnwmvW6IIY3fHtQYIYoD1wKmz1nhv91N571YRo5fDdb1O2yoXT6VRpNYHi8x8OdTISvstKRw==
X-Received: by 2002:a05:600c:3ba5:b0:456:2698:d4d9 with SMTP id 5b1f17b1804b1-45b45374caamr14002615e9.3.1755603953268;
        Tue, 19 Aug 2025 04:45:53 -0700 (PDT)
Received: from ta2.c.googlers.com (245.92.187.35.bc.googleusercontent.com. [35.187.92.245])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c077788df7sm3430817f8f.48.2025.08.19.04.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 04:45:52 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH 0/3] exynos-acpm: add DVFS protocol and clock driver
Date: Tue, 19 Aug 2025 11:45:35 +0000
Message-Id: <20250819-acpm-clk-v1-0-6bbd97474671@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN9jpGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDC0NL3cTkglzd5JxsXSOLFKNEc4tUA2MDcyWg8oKi1LTMCrBR0bG1tQD
 TV39kWgAAAA==
X-Change-ID: 20250819-acpm-clk-28d2a78e0307
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-clk@vger.kernel.org, willmcvicker@google.com, kernel-team@android.com, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755603952; l=1667;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=atHOVDZrHoC4KUAzLF3V2ExuFabINMR3JpSKKqoKhGM=;
 b=h6Bb36OJtt4jZDYOdwe5maGI2bcHWggh27JZXK/hNIDehiPXcAddUEhsj/76QM7GPPUeu3kqb
 jydYZwKtvyDBk4+2SmWwopkALIvvL42OrRHIifDVPAm8txJvXd+GSM0
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

The APM firmware exposes clocks that are variable and index based.
These clocks don't provide an entire range of values between the limits
but only discrete points within the range. The firmware also manages
the voltage scaling appropriately with the clock scaling.

Add support for the ACPM DVFS protocol. It translates clock frequency
requests to messages that can be interpreted by the APM firmware.
Add an ACPM clock driver to model the clocks exposed by the APM firmware.

All patches can go through the samsung tree.

Thanks,
ta

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
Tudor Ambarus (3):
      dt-bindings: firmware: google,gs101-acpm-ipc: add clocks node
      firmware: exynos-acpm: add DVFS protocol
      clk: samsung: add Exynos ACPM clock driver

 .../bindings/firmware/google,gs101-acpm-ipc.yaml   |  28 +++
 drivers/clk/samsung/Kconfig                        |  10 ++
 drivers/clk/samsung/Makefile                       |   1 +
 drivers/clk/samsung/clk-acpm.c                     | 192 +++++++++++++++++++++
 drivers/firmware/samsung/Makefile                  |   4 +-
 drivers/firmware/samsung/exynos-acpm-dvfs.c        |  85 +++++++++
 drivers/firmware/samsung/exynos-acpm-dvfs.h        |  21 +++
 drivers/firmware/samsung/exynos-acpm.c             |   5 +
 include/dt-bindings/clock/google,gs101.h           |  15 ++
 .../linux/firmware/samsung/exynos-acpm-protocol.h  |  10 ++
 10 files changed, 370 insertions(+), 1 deletion(-)
---
base-commit: c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
change-id: 20250819-acpm-clk-28d2a78e0307

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@linaro.org>


