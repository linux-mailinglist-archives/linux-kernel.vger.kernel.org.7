Return-Path: <linux-kernel+bounces-723285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2978AFE556
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 12:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F6901C46AB7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9925E28C02D;
	Wed,  9 Jul 2025 10:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KX7qqliJ"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6241C28B7F8
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 10:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752055795; cv=none; b=a6pdeVFym+clKEtBbxyERpD4eo8GmL14XFzB4U6G+fIuPCINGaXSahzNwWrmkAi+9qwp6RGhxDFRXr1anfjj0qwJlQwXE8FPGqi/8ePlVDHrJvXTcbVxBaq9MpE2nAHiYTbREAuZDm2Wp4zjFwKNDSC0LpfULSEdo2mdwhjFJjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752055795; c=relaxed/simple;
	bh=JYs69k4hNVS5lPqOM38UStT63udUZ2u+pAlopyA1oc4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P1EY74xz82Re67AajXboEFNe7pS9OVWq9kopd+ZFyrPQ6i0Z12Rbepk2JPuj0xfjyVwcRlVwB0PKW+DXnPJ96t/q29MpZhwDzsGxyBty/x/e5F7ne/tcfALm2neR7EgtrnHapKmb+DkGP5zgK5tMzVg9TX+AyYTRkZhfxaqYp/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KX7qqliJ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4538a2fc7ffso5786655e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 03:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752055792; x=1752660592; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uJKs6pSGcR05CnjZyNb4F7ZsaFdoT5cYwaxabxCmccs=;
        b=KX7qqliJw4Dc3rjdyQ2hqqAKJ1XvyK5/WawggUIhwE2Mz/y5QmefMxkn+pQ99fHjA0
         +QXUqFgfHD1Irp48V/jLBD09dteEmiiKF2ayWEiXsxmQ8jIhiXPVWrZlTjhyxAUdYpuP
         wybA3vCXm7d2DP1aq3DpDsuRYbnhC4I8Fi4jkOBkMsoEUEy5+0AHjtuWJOAOt3pt2Gdp
         s89tbRDuxH/2TH8878Otz1BOYxKSHU4v2PPUxK4fVrUMAFNjeYpNR282WUCFzvKxOE1R
         Bq227UzZKJWzo7kZQIS1OrW9xjRAf3GMBXYUJdCkqRWMk1x6IKwahawUviSqtuNGGYii
         2uRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752055792; x=1752660592;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uJKs6pSGcR05CnjZyNb4F7ZsaFdoT5cYwaxabxCmccs=;
        b=LNlEe03cAdLZie3VGENPgFfIYZVnsZranWHExeB0TfXGg4yU7QgSELy2lbKo81UeUC
         pgk2Yz0DXJBa2EH6HZtA4A3y0IOQMgg8WXQepJHStWbI4O5x2m1TGDcUr4JbsgyvE67Y
         bYh66Hew0Vc0pu1DyMxuak/JYqBtCPFPu2Z187dJG0CPtJuXiGz741GyxqC5BzhvTR96
         81pHPfEDH7jU7MOHlpbDFJU6fWPez/RBeSNBcSeV0Snax8pchJv/AyZcdwuhpnYvwnKj
         jZAJFqegB+xevTS0KI4q3bnyS0vr/ffSS3xP2AknM0r7EfxtCiUn9PvzB0Lo4JMKPKi7
         DnKg==
X-Forwarded-Encrypted: i=1; AJvYcCUkN4Tfpn2x3sxzuafIn9EwrA1tjTQh7gvasucdvmIRaq7Vrj5UgkRDrk6y5IE2wS8pkFwQ/1+WEiD0ies=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhyEKjaLSlfLVMP0MxGo8FxATqhEMQhUtk1E++gvbs66RY3l02
	DXBKbOcy+bDd7XSW7wiHwOzMhpa0AVrFUjl70Bw6c39vWfcztHn0jOG9zFhz3M3/IZE=
X-Gm-Gg: ASbGncv4K1k9FTCsFE680efMbPHi75mMxx8Ui2BrIlsRKaC/ZotGVA+31aTYf+L+IUW
	bdlAZzYvR7xms9ku6TrzOsmTQtFiJPN2/oiFFrsgfMjhUOcjqloBwtdpcwwyFw2uBJ93nGVxjEb
	xRfXriuT5qfWtWCkvhRYFsI8K3KY/pc7fQMSu6V7aP1psU+X2vntu/XsRE8RD9UEK5iQZvkwd4T
	ydbp/jPikYb+IpK1D06UqFrY69CiOSSUffz655wIcOcJRBBNAU51yVFLMxRyteYnhVQ4Nne7tQn
	1fOu7gSGifWeo+2wOgYx1YXfLNDSt+K3w3iQWQbqa2hDmj6FNPgdWRi/TyY8XwfYTaV4hOodXeW
	4+w==
X-Google-Smtp-Source: AGHT+IFzc5yFh2wY77gjYrxQjTpVR45vDYq6+m5WrPEq+P+xzIkohYmigMzwvUyhRV68cdwu0zEDuQ==
X-Received: by 2002:a05:600c:8b0d:b0:454:b97a:486e with SMTP id 5b1f17b1804b1-454d5602748mr17103525e9.10.1752055791519;
        Wed, 09 Jul 2025 03:09:51 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef41:d3be:a88a:dbb9:f905])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d5032997sm18342105e9.7.2025.07.09.03.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 03:09:51 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Wed, 09 Jul 2025 12:08:54 +0200
Subject: [PATCH v2 2/6] clk: qcom: videocc-sm8550: Allow building without
 SM8550/SM8560 GCC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-x1e-videocc-v2-2-ad1acf5674b4@linaro.org>
References: <20250709-x1e-videocc-v2-0-ad1acf5674b4@linaro.org>
In-Reply-To: <20250709-x1e-videocc-v2-0-ad1acf5674b4@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>, 
 Jagadeesh Kona <quic_jkona@quicinc.com>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abel.vesa@linaro.org>, 
 Johan Hovold <johan@kernel.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Stefan Schmidt <stefan.schmidt@linaro.org>, linux-arm-msm@vger.kernel.org, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

From the build perspective, the videocc-sm8550 driver doesn't depend on
having one of the GCC drivers enabled. It builds just fine without the GCC
driver. In practice, it doesn't make much sense to have it enabled without
the GCC driver, but currently this extra dependency is inconsistent with
most of the other VIDEOCC entries in Kconfig. This can easily cause
confusion when you see the VIDEOCC options for some of the SoCs but not for
all of them.

Let's just drop the depends line to allow building the videocc driver
independent of the GCC selection. Compile testing with randconfig will also
benefit from keeping the dependencies minimal.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 drivers/clk/qcom/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 36d6e6e1e7f0162d53f02f39125f4593517e0dba..26752bd79f508612347ce79fd3693359d4dd656d 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -1391,7 +1391,6 @@ config SM_VIDEOCC_8350
 config SM_VIDEOCC_8550
 	tristate "SM8550 Video Clock Controller"
 	depends on ARM64 || COMPILE_TEST
-	depends on SM_GCC_8550 || SM_GCC_8650
 	select QCOM_GDSC
 	help
 	  Support for the video clock controller on Qualcomm Technologies, Inc.

-- 
2.49.0


