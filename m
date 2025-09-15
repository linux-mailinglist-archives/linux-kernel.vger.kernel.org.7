Return-Path: <linux-kernel+bounces-817051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 864FFB57D1D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73F094C032D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F8124A044;
	Mon, 15 Sep 2025 13:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HPOlI/cN"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DD1313539
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 13:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757942936; cv=none; b=bEDCvlFsLo7r87q2jWqL5P8g+Ax5JG+965fltt2XTabJLgQSI1OK8D4clanIweikMmNB498dmWHiaCFwJ3fZhKGXd90Ar1MbFVlj+LEIPnxnZa1Bvp6vZwjbjgPItPPEvebe0K3AVIOs+In9SEbzR3OQgkwHUuv44WC7Aviz010=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757942936; c=relaxed/simple;
	bh=vnlm1slyNmbttO9fw4RIWStPZdVkW1FF3oJw8gyAinQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dke5ydjMOiOC/LBYXn7TfX8eOpC7NaArx9zT//MWtxeCbM5IZdLf7SuK4BZHhu43N3EgRzqngPNRbzAW0ByoQ0gA7gpFqK3XDATgfZwHkyXQqEJRJ4Vr7xSQSPPxL2Y+qXK3X9HCl7J5556SpJSe0Ede9eAs/TdYnvVX6bt6lhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HPOlI/cN; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3d3ff4a4d6fso2867574f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 06:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757942933; x=1758547733; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=35maHscUr/d47mvdI2u+bHhN47XfHp34cUHx+zt1aho=;
        b=HPOlI/cNBucj9ZmJ7fuE1dAKZ1e5jgYxSIx1PCtbLI0fwIMDMwRATM1CBs5nGoBOIe
         9EltpUsVZgTFPQTNOaPrbmAqxJW6NhYMo8WHzJpbx3kP0TgSxDl3ze3ScGjdQsoWc1nf
         dvo3a3g4EC5v8KQlljGghJifmGPxrVIZzbOoDgjudSRgS6k7ALdZjHsm5VGxPNvuKu8+
         Ln/2Z2ful+6bPzD8QEhmrCHhgpOxrWP/VqVjeIvGddFnAOlN5v7h5T25osJD7qNlPysF
         6XsZDhayoHi6Yi/KTbjc/TKR4+HrqVs9gWhnCeQuu1aDShIa3nsVnncojnbKBeWy59TV
         epXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757942933; x=1758547733;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=35maHscUr/d47mvdI2u+bHhN47XfHp34cUHx+zt1aho=;
        b=ChGiz7IZPMTqHZM+YqgfNxomko2gCXXiLDBf78S3sYn7pVQSsRXp5mDJytmcwfs0UD
         U6/pgNANuZMJl1Z5KYw+47DA2WuMYN3HyXw15oBRDW+eUklik/Q43e+UNda6lMfn/lQY
         46G1fpBxgOxDFc75giV8s8+OEqifEF64WdiBx/In3nHkmIesYrVQCRHKYr2hjBW8kEo7
         BDAKbhTjaLn91sNiTwb8ukAyXydEYjiMbNpN8e/FeWlqs969I/+RCfAJQ041oWI1LnCS
         3CQ8ti8U21licE4twT9D3ysAjlvQinig7b3eTwinArs+FZAtoHaILnAPy9DSabuvxi4S
         4ALQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsYXAPbhmzLSO/ngoOKgoHC4I99p8UA+ja0OLOYYVhPrXjwAVKbXuGHvGjv3dF18fTSoXJxwEdmSQbuqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0DDycOr680bOvNgRPrZxo8kHMA7fX9o5jQUfShy47wit/9avf
	o6Hl39E3PjfJYtM+JQLAuxm2cP4IZTSS6fjHsvkBOEeloeC6KxdIaV4khrgJ8pN/cSE=
X-Gm-Gg: ASbGncvoDGjAkGiSWfhbiw4lYVpUBdON/yzDyW/ipY5L4sW1lC+9JpgCbXG8gjvUk/S
	KkgwvMjHu459U3JC8UKWnKGIduV57VAbaRhZzEsN2I6OUS6YPfhENl/AZXHmYrftEcYUtIU2x3i
	Ws61+SdxjTALWfqeuWdvJFlVKJ+gswSavupewDJMpPTJIdzpBnYZ2OvKm2/25KJXC3RcYnElexH
	WlLnFloLm6vZG/ouVWRUcDxcJmGqFu7lzY9wTsplP/yK4HoXe9kJPsTtqjn573Yq5RY4kr7dkRK
	lHPufTgYCqffWxW42LY0hWc/3SzkkbDq9hQAW7jX8zfhD6ZY9rzoq/Y/0HpNcVbwxf9mWuZOaeX
	hH54MIrenhwMV99YEjdMKc0wdpdkQCDhIjCo=
X-Google-Smtp-Source: AGHT+IER/KlJED2PxaZ/4h5FniATgL9p4nd5Af5mJaje+r1DLi2JqavLb0mBaDaMSdEUYQIxaESExg==
X-Received: by 2002:a5d:5d0f:0:b0:3cd:5405:16e7 with SMTP id ffacd0b85a97d-3e765a2eed8mr11975067f8f.29.1757942933186;
        Mon, 15 Sep 2025 06:28:53 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:41:eee1:5042:e713:2e9a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e9fd89af70sm5978874f8f.43.2025.09.15.06.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 06:28:52 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Mon, 15 Sep 2025 15:28:30 +0200
Subject: [PATCH 1/3] arm64: dts: qcom: msm8916: Add missing MDSS reset
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-msm8916-resets-v1-1-a5c705df0c45@linaro.org>
References: <20250915-msm8916-resets-v1-0-a5c705df0c45@linaro.org>
In-Reply-To: <20250915-msm8916-resets-v1-0-a5c705df0c45@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Vincent Knecht <vincent.knecht@mailoo.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

On most MSM8916 devices (aside from the DragonBoard 410c), the bootloader
already initializes the display to show the boot splash screen. In this
situation, MDSS is already configured and left running when starting Linux.
To avoid side effects from the bootloader configuration, the MDSS reset can
be specified in the device tree to start again with a clean hardware state.

The reset for MDSS is currently missing in msm8916.dtsi, which causes
errors when the MDSS driver tries to re-initialize the registers:

 dsi_err_worker: status=6
 dsi_err_worker: status=6
 dsi_err_worker: status=6
 ...

It turns out that we have always indirectly worked around this by building
the MDSS driver as a module. Before v6.17, the power domain was temporarily
turned off until the module was loaded, long enough to clear the register
contents. In v6.17, power domains are not turned off during boot until
sync_state() happens, so this is no longer working. Even before v6.17 this
resulted in broken behavior, but notably only when the MDSS driver was
built-in instead of a module.

Cc: stable@vger.kernel.org
Fixes: 305410ffd1b2 ("arm64: dts: msm8916: Add display support")
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index b50c7e6e0bfcd35ab4f8b84aeabe214fd60e8d7c..de0c10b54c86c7795b7a0d1ecd80652e60e117b6 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -1562,6 +1562,8 @@ mdss: display-subsystem@1a00000 {
 
 			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
 
+			resets = <&gcc GCC_MDSS_BCR>;
+
 			interrupt-controller;
 			#interrupt-cells = <1>;
 

-- 
2.50.1


