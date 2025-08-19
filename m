Return-Path: <linux-kernel+bounces-775445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37683B2BF3E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A332D1BA262C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 10:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F1D322DAD;
	Tue, 19 Aug 2025 10:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l6VjhCHd"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADB2322C95
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 10:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755600338; cv=none; b=NzE/ZU4JJ1aNhiDtiOmUlwYH2PyGmBFY4R3UpEa0+aiasXLCyaaevdp1e1Y6nY4vUVAxBYbRzUMLvuNuniUqSIQvlGBUlOKFpXj5SBDHOvEVUAiP6s0ZFUdrAdNzWUOVDj06bGZ8nxI7aXNVTy8uwvbaYBrluw1VL4z3ZBhkp1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755600338; c=relaxed/simple;
	bh=1sd/ouPhwY994V2JgIdwhDUDC7tKLXQbXK+ZAjrzaC4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oLXfc+rj0IlaKPxNbpWcYTG0INiFvQY6tgAmGBYKhmrjpv+oBMBWrDAdE8wn/ieklClc2B0cU3n/6IjfwXQxRQWQ9On15KmbsBDt45I9ANsLCANWZ3oHHuwnmUR+ajkwD4mv7eSlFI8Vxqz/G6PopZKtikQ126z0loSqEMEMqwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l6VjhCHd; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6188b5b7c72so6993897a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 03:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755600335; x=1756205135; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0xeIRINnU2V4r2y5NX1BVLBAPpQQEZ1x9/pnnUXPbAU=;
        b=l6VjhCHdZC9bksGfTkdQ/6iUxsMhe8I72v4TDB5orJgVUSwsUSIwEf96uQ7PLlphiI
         Qp0aJ8FwRXN+B7IQnq4qwB5B4/CRQuyW4FRf0YMGcyq8osw8xuQqnLD4Fz+12bprZ7Yv
         1f3CoWnglMojyQ1cpeCBBi+l7x14Cl9cnCJl5SVO6vPzC+mNSaZCx+dEbAwQI+AUOh8x
         4m7UAcBddrkAb/VmqtF9ZTsKhUwOMxmEwYWE1eb4VuUCejX+rU2XusiR0UKPrCBBBiar
         Vu96SVJhqPmuaywwkOsTXsdEWNY6w1kx3TJ2nQEz9QqyzuMPr6lyHe4IERv3FLYktZ6j
         UQaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755600335; x=1756205135;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0xeIRINnU2V4r2y5NX1BVLBAPpQQEZ1x9/pnnUXPbAU=;
        b=oOngFCC1hE0IUx3J3Dt1PWB1eo6tDlmaS8U7kOrBRi8QXG7GihKvKFWisU3ZomYAO6
         IIcmyECYY69ElNhKVf9Ve0Ci0Ay2M+TVbNqT71HFJSIFEldnEscibb12baOslZvS8Tsj
         fWAY3ajWOl3ScrSLSumV+TVtmB72shlJ1FDwkT6NNIlVwagpoN82a+vPQ0KYAXo6sjuq
         MvmFHopcs4o43U/6pC3n6S3jQnGv7SAej4J9IIqTtjjxDOJN7IpUZ+/hdypFqxSCn8O4
         JVcpirpnv3qhH6VSmWWYc8egEcUuLLYRKk15V7auCwvVRmHuYtCGciq8iQBOYBByo/jg
         2iKg==
X-Forwarded-Encrypted: i=1; AJvYcCXHi5EHlPCLlbDdJg8M/i9qVtC0AI+hYoG1y+Ly7jsmDs3jhvemZqK7oGdXMNwaPGsvJ8Zt7Gq4gdvyKLk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt4aGheC2lKFQdqOCTeb2YU0UL1/xD8yXc31I25wDKlq000b9Y
	ddtLpY3NgJmJgQZ5jO5M0Khw4U6za34jhI0fXdt7YvVp32juALWr2NK41uBhIL3Q0gI=
X-Gm-Gg: ASbGnctAYoxLoXP6wnmAEgGX7hYf8mrmSES4V2LFADxVrYkYPyQ3RPlpvofqykNWrdz
	NHfqr2nfl2KRlN/fo61jWbiAE8pO65bV0LfDc6/RSS+P5WVkhNXIikah/X527yatwCaVyHokExB
	ng/4+/e4yLgPJc7hot77F/G0KZRkUPsKlJcF0+Yjx92N8b9TT98ymCOcsw6ZJGVu1YoNuYxaYv5
	Y3wUVoTxZHXNqKmONpy8A62HvPq4QP6n4bK/HExkt4W3VvwweJ43li6z6CdihggQXWjYonntZJ0
	lFcKsde9jwMerTWm1Hj/izR46lSf7yHKDNjJc0iEixcJI9zEMWj8NgfNrbtFDjMYRcJC4xGHaOg
	TFVAkgIiN7dl3R5BD4PVIlPvAWafPvaAXNBAR9g==
X-Google-Smtp-Source: AGHT+IFnMjA2JxcB/d7vwACjWOfZsT/t2ar6gA3xAHBBf9g9sMPI2AdWAWOkEAfZFqMDZRqYYdtNaA==
X-Received: by 2002:a05:6402:2683:b0:61a:89aa:8d16 with SMTP id 4fb4d7f45d1cf-61a89aa9104mr499308a12.23.1755600335215;
        Tue, 19 Aug 2025 03:45:35 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef41:db5f:8096:4609:9b24])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61a757a48e2sm1469787a12.40.2025.08.19.03.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 03:45:34 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Tue, 19 Aug 2025 12:45:22 +0200
Subject: [PATCH 3/4] arm64: dts: qcom: x1e80100-asus-vivobook-s15: Fix
 swapped USB MP repeaters
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-x1e80100-fix-usb-mp-repeaters-v1-3-0f8c186458d3@linaro.org>
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

Fixes: c0c46eea2444 ("arm64: dts: qcom: x1e80100-vivobook-s15: Enable USB-A ports")
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts b/arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts
index 62eba17cdc87c088ca471b4cbf5b44af06400fe4..b571e8349d3b378ad2436b86044652db3f16993f 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts
@@ -971,7 +971,7 @@ &usb_mp_hsphy0 {
 	vdd-supply = <&vreg_l2e_0p8>;
 	vdda12-supply = <&vreg_l3e_1p2>;
 
-	phys = <&eusb6_repeater>;
+	phys = <&eusb3_repeater>;
 
 	status = "okay";
 };
@@ -980,7 +980,7 @@ &usb_mp_hsphy1 {
 	vdd-supply = <&vreg_l2e_0p8>;
 	vdda12-supply = <&vreg_l3e_1p2>;
 
-	phys = <&eusb3_repeater>;
+	phys = <&eusb6_repeater>;
 
 	status = "okay";
 };

-- 
2.50.1


