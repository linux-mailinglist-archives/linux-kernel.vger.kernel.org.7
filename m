Return-Path: <linux-kernel+bounces-832180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E61FB9E91E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 043A31BC63D8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC96F2EA752;
	Thu, 25 Sep 2025 10:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="ARbZW2Ds"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FF72EA723
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758794872; cv=none; b=oKSi0u/tLPtV9l038/HkVQpj7/qKRYk7g/K3+Lp0g5L6dTscj1IupobtvIwO3C6Sb4ClizmBVT+Unje4Xyc3125E1FdfCPy1FpkMS/5yogeEl5jdYNQQ7T2vEseaWN35rO3SrnspI7KGKX9AiOlfUDgULkiyQlh5Jdq1EKIOMtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758794872; c=relaxed/simple;
	bh=LhKzzlkTCNl4IkWDMHZ1OAuhVnKTDiivlJgT2WmkiVk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cPAmmw55JvgT0RX02Wd1mSzV9mgEDesOoHgoi2qfw+zG0GEynxQQR5V+OVxE8GIr78XayYZl+JyOo4FH04Jw1fxrag7BW+O/jTC0C6hx7bMw8EtbNWjpkP9CWYdN/bYncwXT0Ce8vmKl8fOqWIiiOE7o6WLiBNMcN+7AFvobIt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=ARbZW2Ds; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b28e1b87aa7so120120466b.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 03:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1758794868; x=1759399668; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=903p68FO4P6xFpR2fJbxs0+vg6ytltVcymRFkkxQT9E=;
        b=ARbZW2Dsa7h48FcBgS8Y87noqo0j6tF/GHZePIRsLQ1BLftnoe4/gWqNiwgodeOfFe
         VMHQD6lnlp2WyX2yz/vN5qmuflLKRnupwqkCM7UXR+YSG0JlD9RNfqwqIdsv8Ekecxon
         CyNP2jb5HFrN7A4bOWGpF0pbhqi9DOsemrzVGUnWINpyxx1V2tatKJ1ln675j6yb35Nu
         aE7Hd25uEI1x5AA0E2y+Qc7Tgj3uDsgHge7rbU6uHMJDFYR/nKUvOUM310NIum6zqaM2
         XqSvMklKeakEEre0aE5GHjFRYtqv+M3vDT5vtFSA6RtLlibzNeHJrfDzToAHXAoCNWFt
         F8IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758794868; x=1759399668;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=903p68FO4P6xFpR2fJbxs0+vg6ytltVcymRFkkxQT9E=;
        b=YLUnpYySDVC/mSILibhHdXOWqWF20WquW21tVkSlPX0jcfldAh7TzF7ho7fTO3Ezbo
         y8DP1pju8TQqxjHTo3GXor9nRkXNed7qV3Gv/6NwmJINPi9VIM82rhR+ZyKfyc95zwb7
         +6ksola/Ozb1LmWRPYiSlEuKGjihhzmkJSs//48dk5hIncjci0NDFGIZmMfkCsKYjxjR
         dhhteojdZzSqqL2x4+2QxwD/3HZF7dhKtl+xGafcLP3BxLAyJRXUNzFie8c9S12M/e4G
         3DQ+8/2cL5MMCuSp/AaqW8e+ce/yCRHUPn4o2qOWvS1L21lF6XaOVGeHsAXeEx7EK9Su
         wE/w==
X-Forwarded-Encrypted: i=1; AJvYcCV8t1V/8zgSVUzZeHkOK6QsEwPvW+aewR5WOK7F4DK6bpNn2cg0yFroofBTTjgojbP3acV3+6dY+8a0BsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YynbKnRJvGP18QfgriLC3XWlpQ83wKFogkmkqltj6xLsyGHo3ol
	ZM+eP8tSH/sBukpnf+qPIlsl5/AB9WAyk4LlkZz2IF+PZKa0vOLZ3QI2vNCHKaw3H+klCjJRFYS
	xwOLLotqXhA==
X-Gm-Gg: ASbGnctXeHMbn+ASlyi9B55QJ4A0/U+OHjoh4tIl8kZaId5p6/M2KZyu/M/YDDhLpU8
	WUitgTM2tRWhAZDwSgIfmxhlK0jbnKJw9eRVfMako5fGdQHbTHXsYgQqEGOAYWjKhiCgNIbNLs5
	XUdTAd9HXeqYf5P4hN5ttefjt6r2U00yrRSn8Ojn9LehaKgQqVlijEgyR1qp0bG7ErhCvpof++r
	w3hn0DN0+/hWDfunnSG38+4fykk4M4APCsrWW3F2Iq1zS6ad1MHQiJpIpcHi6AFUiwtmJswj96u
	ukwg4badP+oGWUFIM7WvC8QnGRIafRRHz80b0pdE69WfPSu47UqP2ktndrPRH70FvuyHO7rq+MH
	xilbBrFeDl3xZz9PsVDL26xgRsOoFZQUhmqfDSwiUMvOqkNk2Sox9OzbY+sPfhnzLsVY/btYHAd
	aoTT3j
X-Google-Smtp-Source: AGHT+IF+rhp1gxg0uR33r/iYlZ/H6zFSEFREOPZi/QkHkOOsdTv1r3hShr/lDkKFBiRpBVxjnCVhdw==
X-Received: by 2002:a17:907:7f1f:b0:b04:1d07:40de with SMTP id a640c23a62f3a-b34bb32043emr296615366b.23.1758794867875;
        Thu, 25 Sep 2025 03:07:47 -0700 (PDT)
Received: from [172.16.220.225] (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b35446f7746sm134270766b.59.2025.09.25.03.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 03:07:47 -0700 (PDT)
From: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Date: Thu, 25 Sep 2025 12:07:30 +0200
Subject: [PATCH RESEND v3 3/3] arm64: dts: qcom: qcm6490-fairphone-fp5: Add
 vibrator support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-aw86927-v3-3-1fc6265b42de@fairphone.com>
References: <20250925-aw86927-v3-0-1fc6265b42de@fairphone.com>
In-Reply-To: <20250925-aw86927-v3-0-1fc6265b42de@fairphone.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Luca Weiss <luca.weiss@fairphone.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Griffin Kroah-Hartman <griffin.kroah@fairphone.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758794865; l=1348;
 i=griffin.kroah@fairphone.com; s=20250804; h=from:subject:message-id;
 bh=LhKzzlkTCNl4IkWDMHZ1OAuhVnKTDiivlJgT2WmkiVk=;
 b=HeTBl3q9SOYLzKQKn/q13ycWxEYizcLQXQkg7cffIeB26/YJEFy+IePzXMRYWra4/avx87cX2
 zjAzQHQoBoTCbjALCUOjSkFG8L0xlt893+/BK5/GDrVjRmfMDicC1Uk
X-Developer-Key: i=griffin.kroah@fairphone.com; a=ed25519;
 pk=drSBvqKFiR+xucmLWONHSq/wGrW+YvcVtBXFYnYzn8U=

Add the required node for haptic playback (Awinic AW86927).

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
---
 arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
index 4c6cb4a644e2a7a5ce6848283e8732b3dda1758c..9576efdf1e8ded31dd2babd40c377b2de9ae9c41 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
@@ -866,7 +866,16 @@ ocp96011_sbu_mux: endpoint {
 		};
 	};
 
-	/* AW86927FCR haptics @ 5a */
+	vibrator@5a {
+		compatible = "awinic,aw86927";
+		reg = <0x5a>;
+
+		interrupts-extended = <&tlmm 101 IRQ_TYPE_EDGE_FALLING>;
+		reset-gpios = <&tlmm 100 GPIO_ACTIVE_LOW>;
+
+		pinctrl-0 = <&aw86927_int_default>;
+		pinctrl-names = "default";
+	};
 };
 
 &i2c2 {
@@ -1415,6 +1424,13 @@ usb_redrive_1v8_en_default: usb-redrive-1v8-en-default-state {
 		bias-disable;
 		output-high;
 	};
+
+	aw86927_int_default: aw86927-int-default-state {
+		pins = "gpio101";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
 };
 
 &uart5 {

-- 
2.43.0


