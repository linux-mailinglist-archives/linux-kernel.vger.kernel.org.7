Return-Path: <linux-kernel+bounces-775446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C68B2BF40
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D9FC624A32
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 10:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCAF2326D4E;
	Tue, 19 Aug 2025 10:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dYo+8Plh"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57416322DA9
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 10:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755600339; cv=none; b=BHqE+dhFQMaF3tarzUQlFmr1QO875E0VvQ2BXxvXHiR/F8ImC/aN43d1HXtbpTS1Oyrpn3I0J/S0M3F7NRiFoYqY/BBiMP4fN4WyzBykqQSqJ7ps41WDkaA4VpF0A1I+K7qwEOX8Ey6c0Q9C70dekW9hEIUIoHjPBdJwBbYZmlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755600339; c=relaxed/simple;
	bh=CoGnRVCEsryh+FbJQYTFV1jTmW3dnOmX3oR1hC3xB48=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DuGsxP9t1NLuYyfi115edtkfGPLguFVHPMOHDvvY7EkKnV9tcj/RkiEKDSDZDtzCxeKf+kjMz8GGtS92nutXh4rcAwxizybfJP7IylwJJuHAjhEnrbESOgiMGsUQZ3/CA0uHTZX01E/2H0Ct45l4LYIFND38dNqpX6XzkPtmliA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dYo+8Plh; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6188b7550c0so7032119a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 03:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755600334; x=1756205134; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NNWfg+jnR/IJfZkh2W9jbuKIKGtjrjEx/l7JEhyxTVQ=;
        b=dYo+8Plh534a3EXzfPYL0+N/Czr2HKWjO4hiXtpOFMeJwMudwbhoWaVCeqEjhI4TTa
         T10k0JAHQaj5HOFYoMj/rcwEKNetItXqSXU19yH4VgHJmslHKQrkVlzxq2P76VMxy4AX
         7drq5i3EWDrEHkpVW8Pc1a8fRWQKhDNkgaVDUDHZrq+Bui3DWBnBVJzZDqZsT8k3N6v1
         soMtYLj7ePTFjZGvb5BJm2OQs+DpYiWXEwo+mD/MK01aFJ6D+ypdSy8sBr2cNexF1DQY
         Y0v7ZQi31r8nuzbW1IpCkLDz2D6ghuTEzPoYmjlqYP6j2jafwBsYlZX6aRNBMMvfil0d
         831w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755600334; x=1756205134;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NNWfg+jnR/IJfZkh2W9jbuKIKGtjrjEx/l7JEhyxTVQ=;
        b=XUcC9ZdCNluzxhB5PMorJbcU5sMX0NhbJWbhk021TDtcQ3IZOlXBqF0UseA81FtW3w
         /lIg88D+R1IioYLKG0Y+OBNlQMm3InDdkNE8o6zDAMq6f6bhSkw2G1tag9WekEMWZDad
         mis0OEpnehUOb/UsEUsLkLKJiPXirJbjKVm+8CyPF0K71tww7AC1wCNa7JecsOKCChv3
         SM1IpVoQALmBm3S1O+X/gJy6mS1z7VJZTZnSqDTrAICVDdrMrrmoMNWTo8kQTSQEttCJ
         K694OPOch8VIqduazaQD1jbdOGlsQGBV/7O/fKIDwZV+8DpBul9CDKXaoANkdwodyIcz
         kaYg==
X-Forwarded-Encrypted: i=1; AJvYcCVSvJLmB8/m68iQh1O5i4M87LCZoDDjFesDzwinjyyHQ9w3Tdu+q1nORzYI9jao51aXEz9b2pS/+CvLynk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw5JovIrcS+nSyGUYQZzixy1ni31ycM4xaYIPiNJrSTKnKHy4c
	7xCmLP1afTlVMittpufBk5SWr6d5DwlBGCXLu2f8JRaxxPsT5vNOqk1EHDF1D499eXY=
X-Gm-Gg: ASbGncu7VDXb6E7+5ComBgKH1hdVfFo9FuJIfpKSt/qeDr+2inRlnAA07N1HtQwZgF8
	kcniKZ/doVZkx+xKs3kXHHYgrTquaAqY4vDNJPER+FCPnGP7+GPuI9BThLquCNUmI1KNk5nMjfM
	erpVhXjCiwyM9Nuu+Eg5Veh7eT1l57dv7DNM4uebVzF17pRAA9dR0lJgJHB+eG8FOuc5Up2wLS+
	htgZWzuGJEDAt1eIH3W3xUj9KNJekhN4QQ7nKD4eCVyRnqTfNO/XULFARKHnURI6sJc5HYpyTyW
	LAstZoZ6W2o3e5+tvefqke4EvsIasgcTIIMiSfrYwf+/ENsahitdUyy/odLtTzO4Kx13w6TM5gF
	e/8LwWpS2vJA9fUwq0mEKcgEYAE2suvNlviso9A==
X-Google-Smtp-Source: AGHT+IEE/a1cKOzDFjQ1Qc8gYfnMR8SKLgI15DshI4v7Whp0lmGCWNGsKtl8WSrbZmbUgtPlX0xdNA==
X-Received: by 2002:a05:6402:5247:b0:618:6615:30df with SMTP id 4fb4d7f45d1cf-61a7e70bb70mr1435647a12.15.1755600334057;
        Tue, 19 Aug 2025 03:45:34 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef41:db5f:8096:4609:9b24])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61a757a48e2sm1469787a12.40.2025.08.19.03.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 03:45:33 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Tue, 19 Aug 2025 12:45:21 +0200
Subject: [PATCH 2/4] arm64: dts: qcom: x1e78100-lenovo-thinkpad-t14s: Fix
 swapped USB MP repeaters
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-x1e80100-fix-usb-mp-repeaters-v1-2-0f8c186458d3@linaro.org>
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

Fixes: ffbf3a8be766 ("arm64: dts: qcom: x1e78100-t14s: Enable support for both Type-A USB ports")
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
index 4cf61c2a34e31233b1adc93332bcabef22de3f86..e04df29a8853797c0e36cb60ebc2fb3161a41d30 100644
--- a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
@@ -1543,7 +1543,7 @@ &usb_mp_hsphy0 {
 	vdd-supply = <&vreg_l2e_0p8>;
 	vdda12-supply = <&vreg_l3e_1p2>;
 
-	phys = <&eusb6_repeater>;
+	phys = <&eusb3_repeater>;
 
 	status = "okay";
 };
@@ -1552,7 +1552,7 @@ &usb_mp_hsphy1 {
 	vdd-supply = <&vreg_l2e_0p8>;
 	vdda12-supply = <&vreg_l3e_1p2>;
 
-	phys = <&eusb3_repeater>;
+	phys = <&eusb6_repeater>;
 
 	status = "okay";
 };

-- 
2.50.1


