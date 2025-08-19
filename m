Return-Path: <linux-kernel+bounces-775447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C30CEB2BF43
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 739721BA29DE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 10:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB24232A3CD;
	Tue, 19 Aug 2025 10:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JW1j8lB9"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E54326D6F
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 10:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755600342; cv=none; b=J0q350j4TTPqldsrETIdpKmiEStIXKkW7SOsJTM4/xKQh2r9rh+3YpT9z+VzobNZHGjkTuvV0UIr2A5GjpMo3cDjRK7pGgLbS540m571Gqk33KlsAgqiLVOsp2dHSONHpWO8BYY8I2DBxoEKZuwjGq3t9yb6nrz6j8dSTA2D6jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755600342; c=relaxed/simple;
	bh=x7zE6RyMG5SmYkscjJboHkA/xd9epaIl07B119p3nJE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iRNivgSbNT+xlf2CAehdBauCxpKT8OX3l/+cAa1GbJ08grR1LjQarCK7shSOI9SWYnp9A+cFVLTpsz/2ZHMzyBwrIPKsAuC45V/CRpPTvafVgboLwMHqaCNjSCiO2Re/IwkZlxOVytT6UjZg6OtINvwdSDgLYRcOOWmyBeSsrao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JW1j8lB9; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-618aea78f23so5182484a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 03:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755600339; x=1756205139; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vlgDGE85YBp2j9bhgXZJumZoSN1cJSrjsFNnN/m97uw=;
        b=JW1j8lB9hcaa5E/Nw9yvJ1ekrUmIkoERLs4fyU9NoGFzw+eYYlfx+IQ/ObGyN7IacG
         TnFg6Tt7Muy0KdePPclKPPPaUWOHv1oGaAfOaVAvufCoGI+WbMODGU5M1TqCCikpPEbe
         qBjWdrY1dlJF01U/mTfG+cUNv3KYoFlQcmEWFuTdYcEOjjzMgFlTDWGiFdmZfpyMWre2
         u7HaY3FQGRSsnvZGdxqCZZ/6Y+nkp7gPzdsgapBbdJCp1y/xkpD6xOpANDSAxiKMGsP5
         kRlcSXSvnKhP0TQIAenA0Npd+KhhPElj1TcGrHG0mbdQEvjza0ad9pLYw6yJoC28b1g+
         riAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755600339; x=1756205139;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vlgDGE85YBp2j9bhgXZJumZoSN1cJSrjsFNnN/m97uw=;
        b=Hcjm3jkACMxiDkmmzvchrmsVuEW7KH+vPlelC/IoLJdbubTnj/XGLru/g8RitYWeN+
         G+9gfYfRooioQhD4fZX8mGzGMsMcmQ2SaXAVGCsAYPmCzo9QKHOkI/prJDGjMxiBZQM5
         naETUWIyWliA8e0z2C/zfRKrjWJzVpCze2+eiaExPhCjTm/k4N4EQAaLHa0yP/8/zkjs
         4+Q1hsQVGucF3ikcnKLzJj+WJgGDf9XqUbbm9BNnHGP289RdKbCC8ZcnXkCSKJ31bHMl
         dfBfTpqXhIr4HuqQBDn9lAENOtNbU/9YqXZHR7det5ExeexTDctwBy/4QmKne8U0MgaB
         u/eQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1z5Gt5wZHXuGBCV+9h054+W9LVblTk1I+HUShzIqu/wYhBc9WtI0Q7Bca5muWedETYIoS0k6MpiyiZx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaPMFWi3OfcQOroGP3ZxzQcgGugUd05cjm8oFzgL8w5eL1ZQIE
	JWN/zJH2by4iWKXzdFu8esnaN0q52rXePuLAgCyJiH/wI0eWnJ8BDRpmNzJDxI5wIuY=
X-Gm-Gg: ASbGncssog0c12Atz1tAznbQC2lUKDZ0DRlfowS8heM47yf6LL7mClVzdYr0TAAQCln
	9foHmAKUULgYeHG1gtFG3KLEiK3/1yCMjPzRKhGPOWAbiP0WKVoJOOhUKeH8GhoZu501/LmmnD8
	9Or1P2Q9kFxC1KFWYEdqOh2PWm1jTjJEbHz/2k+EX8nAFP1opW+8hl/xgE4OktwRL/hFqUuQyRH
	9d1fr0a1OoOXFZDuLORNKyuzrVKmVFI8Pd6xT+SPvWT8ELWE8y9CTrmkGpLKzRhV7sSXYtWirtH
	zfkw/SGMWao+cfB/P7jnpSja2wZfAyqWuGI+Gol6YjAvwKW458kSCTeQ0JjFzkoPZSeGTN7MkBs
	4sRV48sM+jkgDg19m/0LDvDdb4f9Hp5faU1R1onylSuEp3C8v
X-Google-Smtp-Source: AGHT+IEJTLHyh0N/3ZjA8OKmxUPpDwP3GB0LJkHFUpf5OZrWH5pLrgfrVM4pyeZ8cSQdbw2CHOt10w==
X-Received: by 2002:a05:6402:524d:b0:617:dc54:d808 with SMTP id 4fb4d7f45d1cf-61a7e6d99b2mr1532953a12.3.1755600336112;
        Tue, 19 Aug 2025 03:45:36 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef41:db5f:8096:4609:9b24])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61a757a48e2sm1469787a12.40.2025.08.19.03.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 03:45:35 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Tue, 19 Aug 2025 12:45:23 +0200
Subject: [PATCH 4/4] arm64: dts: qcom: x1e80100-qcp: Fix swapped USB MP
 repeaters
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-x1e80100-fix-usb-mp-repeaters-v1-4-0f8c186458d3@linaro.org>
References: <20250819-x1e80100-fix-usb-mp-repeaters-v1-0-0f8c186458d3@linaro.org>
In-Reply-To: <20250819-x1e80100-fix-usb-mp-repeaters-v1-0-0f8c186458d3@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Abel Vesa <abel.vesa@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Maud Spierings <maud_spierings@hotmail.com>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johan Hovold <johan@kernel.org>
X-Mailer: b4 0.14.2

The &eusb3_repeater belongs to the first port of the USB MP controller and
the &eusb6_repeater belongs to the second. This is obvious if one looks at
e.g. the CRD or the Dell XPS where only the second port of the USB MP is
used: They only have the &eusb6_repeater and already specify it for the
&usb_mp_hsphy1.

Swap them to set the correct repeater for each of the USB ports.

Fixes: 9f53c3611960 ("arm64: dts: qcom: x1e78100-qcp: Enable Type-A USB ports labeled 3 and 4/6")
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100-qcp.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts b/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
index 9369b76c668b5c008fefd85d5ca18e87ab9ce93f..b02a66f0895e9c91e5403553620615e0a3bfd7a9 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
@@ -1507,7 +1507,7 @@ &usb_mp_hsphy0 {
 	vdd-supply = <&vreg_l2e_0p8>;
 	vdda12-supply = <&vreg_l3e_1p2>;
 
-	phys = <&eusb6_repeater>;
+	phys = <&eusb3_repeater>;
 
 	status = "okay";
 };
@@ -1516,7 +1516,7 @@ &usb_mp_hsphy1 {
 	vdd-supply = <&vreg_l2e_0p8>;
 	vdda12-supply = <&vreg_l3e_1p2>;
 
-	phys = <&eusb3_repeater>;
+	phys = <&eusb6_repeater>;
 
 	status = "okay";
 };

-- 
2.50.1


