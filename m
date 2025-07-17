Return-Path: <linux-kernel+bounces-735870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 099EEB094C3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 21:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 955A17BA764
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 19:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B825A2FF496;
	Thu, 17 Jul 2025 19:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bu19DkbC"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802A62FEE1A;
	Thu, 17 Jul 2025 19:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752779810; cv=none; b=DVt/XykAzUkNSCETYEnI3Qa4mPhOCRhTKkm1AI8Y+CKFi1gwdesasUYus105qeL1+kLeqyjvBaxwdoYlDUy+VzBargGy8CnQPaw6nZXOs/Q0at7zzBFm9tx1cEdmaWqGBdTslcoQBcKjdSwYn9jemnIGtvAA8i6nezWkC46wp7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752779810; c=relaxed/simple;
	bh=l0o8fS1wvKD2cvbhZZBTKbtQIm4NdpPP35SyjFhlGvg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=glVLulNVJu+RqG6l5FWn006LaXL/VTCndFymcJCq4h/fpLz19rQUgzbK0uSl/ujRHzA9B/W+90fj6xdJV/QvniC63PibXjvJm8DyPFLslrDvo99TvYo7itQMMeQpZ55KnLEPQ2IEtWRaSWizqZFdmtYnVu/Wj18Rk/xVHuARIvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bu19DkbC; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4560cdf235cso7070805e9.1;
        Thu, 17 Jul 2025 12:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752779807; x=1753384607; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IniKC5WKFomByrKxv+MfxE4r4cLS1U5X+1446OuWw/4=;
        b=Bu19DkbCnOjlcPUCkm4RveOSQunEZRP9bVkIkMVfhFBmnCeVHHtkzB+LmGLgJzffMX
         9frUOBNe+JZYO0V+3K6IVVmsuQI4+2kL8xgedopAI+9D+QRZkSYgZenGKMJB6wYqlcXx
         kFZNT5JX0E9TZpV30x5RpXEn2w8m+O04j5TB8WAR7ZoZP5hV+LNCJLp35D+cm7LaEAIT
         y5QiURo7v5pZcUzPSeqVfx8sJKWWbFKpogPSsy6MsU6yYq9NrPW5xmef9awWVCmL+MLi
         6swjnPHJ2s3ttulkAWB38YCD1pKqsP2s2i+EreDOo/XVS/pXY8nnpqLCh6Dpshe4EQ7Y
         fkAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752779807; x=1753384607;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IniKC5WKFomByrKxv+MfxE4r4cLS1U5X+1446OuWw/4=;
        b=o18SHuBJmiiVRQMjn7XDnNfVlRokrSq8DN7Be4EGP+IeKH8NYBvxjouUFpiT2meXJJ
         0Lk9b7Q2oYOm2BhpdliT7jYULyeQWBIXJIXdXEfQBkqOZYmBu+wIfv8Vkavv8Khi0W5v
         tyCkE7uRX6uDaD+32dn2A+KzYCJqehDeQceTacsuvI47VRzcLyEmUpiTcskYCvW2u4jW
         756okqM4Ux6j23pGUwIdCjqcLCt9bBvV2l3CYDRr0EmQpoDqbOeRS73OlzsB2rANlrWf
         tl9cByhYSl7E2+lhMpuYEO7/ykzQs7HdK8t+XUV2HsHk4nacERYbgV7xUV84Tdp7Vafp
         RElg==
X-Forwarded-Encrypted: i=1; AJvYcCVrCxNuBBFHV20Od0oStyf3BzwiBB6je4Dh+d6H3L5DOLn/RBNc3uNLSfUY5q78wPnGBeF/tWWfCri/@vger.kernel.org, AJvYcCXns5LOXxPfAerF2smm7ufxqadZLmIRNUr3e9P0Xv+NCOph1iCZliy+XWcerDArG1afGNh9JHijwHvXz0ka@vger.kernel.org
X-Gm-Message-State: AOJu0YxprbeUj9gIOltQKo5plaBPIA4tmycsVzXnsqdTwQXXJQnYz+2J
	GMh3NLZE2qJSXdcM3LU60qXKczwOmvNcY2Q5LJ5gd4FfHxTAT5rzfKmD8+DJ0w==
X-Gm-Gg: ASbGnctJrN32tgJbg62Yh7ukOjwpsjpMMyoRp37bRjMGxXeupFf6p14cQKhz49e5iSu
	Tz0oGfk0zhmDp98EG7KoTt4Jz7bit8ttsapUQ2ghwvZIWtba41RhHJUXwTW7eM6VkTRg7vHqkPr
	3uDyd3zG/1raAdtnYEFoB8DxjO7mpGZUUJl58kaMjyycVgCshErLEck1LEtMIid9/LVDaQt3K7A
	9bVO7rRrcR6uE1EVhJwiZ4sBSLmNpML3ups59AWarELjceO3/maYR+tgjLuTM5dxhhVHBf1fEai
	//BU2ptRRm21cU5Q8QGi5dAj0qywGABHOvilyZ1nCEYtdugSzfFUTqS8ixl0TXg9kQKKdL/WFUv
	TggTYh7GPxLjm2YVP+QRw0+8SB+0V/NTz
X-Google-Smtp-Source: AGHT+IGHzyOYCw/m0HyP4umB1YuYT0FPkPuXBFk/lapuzoe2X+waZSCxE0xX5hMXQCuEqnY0X0GUaA==
X-Received: by 2002:a05:600c:3d97:b0:456:29da:bb25 with SMTP id 5b1f17b1804b1-4563532c32fmr38379325e9.19.1752779806421;
        Thu, 17 Jul 2025 12:16:46 -0700 (PDT)
Received: from localhost ([2001:861:3385:e20:6384:4cf:52c5:3194])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4562e80246asm58861725e9.10.2025.07.17.12.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 12:16:46 -0700 (PDT)
From: Raphael Gallais-Pou <rgallaispou@gmail.com>
Date: Thu, 17 Jul 2025 21:15:35 +0200
Subject: [PATCH 4/4] ARM: dts: sti: remove useless cells fields
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-sti-rework-v1-4-46d516fb1ebb@gmail.com>
References: <20250717-sti-rework-v1-0-46d516fb1ebb@gmail.com>
In-Reply-To: <20250717-sti-rework-v1-0-46d516fb1ebb@gmail.com>
To: Alain Volmat <alain.volmat@foss.st.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=834; i=rgallaispou@gmail.com;
 h=from:subject:message-id; bh=l0o8fS1wvKD2cvbhZZBTKbtQIm4NdpPP35SyjFhlGvg=;
 b=owEBbQKS/ZANAwAKAechimjUEsK1AcsmYgBoeUwYbZ7h03ffdcgJqJpcrr4dawhJoUjOSplKv
 rVN0WaP95eJAjMEAAEKAB0WIQQgmXv2E+fvbV/9ui/nIYpo1BLCtQUCaHlMGAAKCRDnIYpo1BLC
 tUtkEACW2KbCulMwEimw5aLEGZ5XRbUYEK7XeBo+HKLYJJZUDJuQC1lR6m2p044x5FaJ90wxFic
 DwY64YN6E1Y5WlBqrd9DRQPsD64eKHKllh8x1vnZI4LpzBcFj9Npq6E7ozfkWRn6yMvqJLcOszf
 SN3aZcsYMAZE71FPuYLnl9SikG4VidpUxwdQcdZ8s6nAFiLhujxNraibTFDnYhD669+iLSx4RP+
 qIq62BqIZXxgUn571k4tMjWD/63S7F0utZeWyyrlraP6NJkJaEVSsYyrtvgfVN1+I27Km8O7nWH
 Y/yH3h97XhTfnK+ipaY4hvjbo0G71vRJ+yKtlU0UjLTYYDk87RsuxPl8DKe4r3flNbC7mqqW2/w
 UbDCozcdswbFuNBu8+d5kpg5CoYwGjuVejsf1UeECrDkwrIsXnoQWOMZSC40NSGwdzzvOirWVQa
 iu7JUWIOiNYhbgvgtcbwrZmRRD1KUHKCOroSkxymsxUWyfDP5q8ILa8tDUXT4cWuKzdYNFP0oUx
 cSqDGKJ8nhMkWrjkZvuPfisb6oUGkOU15WrBM/ChJB3FF062Jws69igkXENPjXQ4kwXgmHS7JWT
 qMiKi2iGZrtWxXIiwzgB/NEk209ajh85JzSlZHgcCK3GOS4IlC4IDTIyDukjbYO/3Q6UXaE43+t
 oIYTG2joSLVDe2g==
X-Developer-Key: i=rgallaispou@gmail.com; a=openpgp;
 fpr=20997BF613E7EF6D5FFDBA2FE7218A68D412C2B5

tvout node do not need the cells fields. Remove them.

Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
---
 arch/arm/boot/dts/st/stih410.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/st/stih410.dtsi b/arch/arm/boot/dts/st/stih410.dtsi
index 47d66d7eb07a3d73d98b3e21d62b2253aa1171e4..07da9b48ccac16c25da546ace8e6ac5773c68569 100644
--- a/arch/arm/boot/dts/st/stih410.dtsi
+++ b/arch/arm/boot/dts/st/stih410.dtsi
@@ -191,8 +191,6 @@ tvout: encoder@8d08000 {
 			reg-names = "tvout-reg";
 			reset-names = "tvout";
 			resets = <&softreset STIH407_HDTVOUT_SOFTRESET>;
-			#address-cells = <1>;
-			#size-cells = <1>;
 			assigned-clocks = <&clk_s_d2_flexgen CLK_PIX_HDMI>,
 					  <&clk_s_d2_flexgen CLK_TMDS_HDMI>,
 					  <&clk_s_d2_flexgen CLK_REF_HDMIPHY>,

-- 
2.50.1


