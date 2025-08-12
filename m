Return-Path: <linux-kernel+bounces-765528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B79FB2398C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 22:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98FD81B670EF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 20:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22EA72D0620;
	Tue, 12 Aug 2025 20:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O/XcwEb4"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DBE2D0607
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 20:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755028884; cv=none; b=ZjlSba/486lpScDgjhumbxGUWMPTu7FGkTvtxi8M5mOBG5R3/PcOrD/Qg0w4CVpm70A64ZrANkSDuvApsyCD06wE1c7fSmP4UKbosUI3v96bmt1oH/vPImD2dsVbRc5SCelqp1sl6cKaaVH0SRhfe6+7aHWbnR8az873vFCGmbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755028884; c=relaxed/simple;
	bh=ZwMx34V9OWcExmMpXYmSZnw1baiVNmb8joVWoNfeyq4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S4M1jG8PQVIql+WTVPGLdxy7YLL4gz9lJZMP5eWVQugQhQFz7PoCFggU+3BcBJwVOdfgXWVclKdXhwrnvsh0pJpns49AY9w0ZXy6temML6STWaYGeEcR6Bghrxrak4s6kQK/YbXehGwIP6LJcUy8i7pHGNgNJf/r6c8qHWNoAzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O/XcwEb4; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3b78294a233so4856209f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 13:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755028881; x=1755633681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U1y+cWIfL3TjiwtoJYCWMjcfzPHs2ohpLn5LEWTCz7g=;
        b=O/XcwEb4yUqXO2ucKljqp7CZ+HgG22TnzVScVR+MLWYL21xJCv3ssKALH0EnHrJZfD
         lIX/hIHbvksSlgQgFzPo8jP6LpQCTwKQn2jJ5swIbW5jMP4FdzAqbbPsu6YeF5crxRC0
         mVNYpQhpgSsL1Qss7cZ6DCkVcaevbyCSGqyiUw6bi7id8xj35Wo9WlTCVgWGrPTCkEgf
         KnWR9EXjXo8bG42zyU8Nqjp4TlTtmb7R7gBzD2sOZLVwrRjDTmGeL+DXdd6732UEmhjE
         OiTFbrec/txx8TTWbGMN7PPxdy4Q558TW12ScrdxnjvFxL+0Mi8AkIKf+kvlVbYQLlDG
         lf8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755028881; x=1755633681;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U1y+cWIfL3TjiwtoJYCWMjcfzPHs2ohpLn5LEWTCz7g=;
        b=rBT5FJl0njmLOFBYH5hweh8yOUCffgNM9k3kketLoJZXXu/dempR7CEdQFWIOOsBIy
         dIj26xxfe0ofk5/jWz7LtFenU/XD/c0D382HTy0FNv0rPZL4TqgwIlwiR423PoyElrw8
         hkI6g2E265q5YiDU44C2DrejFoJrWqJEUYeHACSNQ9vDmZ4WmUQLvXI2T5WJ+uzOBgvM
         5S2ed000Yn0mCn3LNH+FpRn9CSnJg7h+EZfJItRZv/KM9WM9dRPLBDBBJx2lwet6jO02
         L2acP//VWY+CBmTPxa8yHcD5VPIx++kYsMCSimJSW1VCPw7yvLWK8RCXrt9TKRLhFfpf
         5X1w==
X-Forwarded-Encrypted: i=1; AJvYcCXSyudDLglHjr7CGGr/q9Rm83B06PZO37KH3yH+8UX14LVJjMBdjIsupy1otsriS9lO/PM9JM/sHPkEd3c=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrgxnpa0Xr+r+Linc/zG4BpoA76G/hCoxZJWaiCG4q9BjQyckw
	aPrNPQQwOqYmmL0B3XXb2FAdHSe5RELTTIdz2C314OLR3vHQjBdPP4TrdJozemYTKxY=
X-Gm-Gg: ASbGncu/ZVM4kcw6dUvZo/LuKyZeMikqwEEUvWiEKptv1KFzdp8g2R1w3Hkv2Z8VaiZ
	og4hhXWwzbyHgCBZ+c3P5tTniSVlwy/laUhIxuSOdpjcQLwSIJt6IYInoRhL8BvseBEAZJGqVlI
	WCBp6Scpc1wTd3BVqwL67SSj745LgpPNbsYB9HIc8Tyf0dGoRe9GecP89mKwdZDdsFpgWDA5jEe
	WaXDnNvKCvvwkX76BgKGBR5wSRk3fP20AzIavc4Nct+N5thH6sDbOGia+ziNMe999X1Pj8Pa8Vh
	L0yG9IPYxcfmi80iKEP7unKdurVnlLLoRRPzI/W3m1VkFWFU3djdrfC+qtdaS6BJxjouFRiqCGa
	EbMVLH99viDUFEtV9vqGs91s7JHzw8X6fy7oKjjl3Swwoyfrh1YaxjasYSX4=
X-Google-Smtp-Source: AGHT+IEMKTjUNjqR+kDkoO/Ph/EbTK5O4Z3JvXSkJvS/sag9rK4IKE3PjLUYL4y2eNGemDoFHXmgFA==
X-Received: by 2002:a05:6000:2f88:b0:3b7:9564:29c3 with SMTP id ffacd0b85a97d-3b917ec5398mr173299f8f.49.1755028880987;
        Tue, 12 Aug 2025 13:01:20 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3abed3sm45143947f8f.10.2025.08.12.13.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 13:01:20 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: ukleinek@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Frank.Li@nxp.com
Cc: linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ghennadi.Procopciuc@nxp.com,
	s32@nxp.com
Subject: [PATCH v3 0/2] Add the s32g2 and s32g3 FTM PWM support
Date: Tue, 12 Aug 2025 22:00:34 +0200
Message-ID: <20250812200036.3432917-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The NXP Automotive platform s32g2 and s32g3 have on their board a
FlexTimer (FTM) dedicated for the PWM. The same IP is found on the
Freescale Vybrid Family and the i.MX8 SoCs. However, there is a small
difference with some registers not available on the s32g2/3 and 6
channels instead of 8.

These two patches provide the DT bindings for the s32g2/3 compatible
strings and the code to deal with the FTM difference.

Changelog:
        v3:
	 - Fixed dt-bindings subject prefix
        v2:
	 - Merged the two booleans for the regmap holes check
	 - Clarified why this is needed in the changelog
	v1:
	 - Initial post

Daniel Lezcano (1):
  dt-bindings: pwm: fsl,vf610-ftm-pwm: Add compatible for s32g2 and
    s32g3

Ghennadi Procopciuc (1):
  pwm: Add the S32G support in the Freescale FTM driver

 .../bindings/pwm/fsl,vf610-ftm-pwm.yaml       | 11 ++++--
 drivers/pwm/pwm-fsl-ftm.c                     | 35 +++++++++++++++++--
 2 files changed, 41 insertions(+), 5 deletions(-)

-- 
2.43.0


