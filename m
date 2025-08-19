Return-Path: <linux-kernel+bounces-775444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDAEEB2BF3C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC41B5A009D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 10:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF54322DC8;
	Tue, 19 Aug 2025 10:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JBb5doAE"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA5125C6FF
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 10:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755600338; cv=none; b=HX3fVqrR48uvj4OVd51kQzShWNlX66NK1djGSBwWriCLcpEehzfp3pQOvrc4nWvdE4jnkuyZDBT6FzzpiYqHPygBSxbRMq1OO1vIMWyfKAFrLn6XUDtADfaDW8CACbnkqwXvtsYe+4CnrQ1xLYAzMIakqDsDEAwZAwP6NhEv8t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755600338; c=relaxed/simple;
	bh=lBEHY3oqwrkzdEyLXUenBPe+fR0fQKUQuPgdsV+am1M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mi8q8xAmlc0sNChWqWY4qjePqJPDDBrh1H5Xke2nscCGw3pzW8Z52OWwaFxbt/zhP78cv8SAANJc3HQdwSpnenmKITnpy6PYFgFzrUY4QQ8XyRANDJAdj58bSdr5qWvVTlcVnrUQDidC5aaioxavs6yasz9q8bNGUmAqmmanj4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JBb5doAE; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-afcb7a2befdso692086666b.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 03:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755600333; x=1756205133; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CzTgDVH+QZ7Kiq60lbhQJSp7V9UuP3VPtTcxTzVGwi8=;
        b=JBb5doAEkc8hHBcww5E3GP60Zt1YvB27wKoqpYS1F8h/78WRqspD3qxbZXftCHdmZc
         NwxAjzuS1eQqCbvuJEXjPfvUZe2WpC5rdvsStpr7N7j29P5faG4LM1A94vyoKP/5MFOP
         svCpiMSw7AnmxiSj3l/5Z2jU+hAcDmdykHQewKvcN1GRr8XJgt7bf/wbfEXYUGA6rGD4
         c4v45E1ftzV6qL1jVVsDFAC6H40ECnEQ4gkt85J0OIXj4qFGxwHT6O6AZx9lCBJ3XgWg
         pOP0HU1+MaRIFHd7+FUOcJnF9bvigrsq4cNZHqJ3UHHPxieHdt1Sp70ANqwk1LUReMld
         nA1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755600333; x=1756205133;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CzTgDVH+QZ7Kiq60lbhQJSp7V9UuP3VPtTcxTzVGwi8=;
        b=KC3kM5yIw0yBezzT4RVAAeDqY5X4enNEqDe5Lr70oyCuy4n0AJMFOZHZYReBbLVdXo
         rTYtrhQJwyDiW8OwLz9QrLJjapsiQUGB+azaxXB8yq2hUscWu+wZAc+dnW/oKHpzUZMg
         UHj2Yhpvsa/RIxRaB/B6PIFLA7DVZF15IeCDm1LuEd+o5u8Jq5dkGldli+zT93thh6YS
         gTqX8naTj8kXuajxtOUOnngCARyogfjuqqB6JiTqvvdG/Z3Ksv0ErgcKEp7sOIe4myEf
         qcApx3exMCh4oWr/roEz9sBv/BDpb9XvVaiGx+N1uwIxluqyNJQDpbLD+KdZ2gb+qzJZ
         KLZg==
X-Forwarded-Encrypted: i=1; AJvYcCWm/zZmormRIE2Q+gV755mdR2tDuK/fDE9AfLIVpu+/lDhMRycU+buOl19FcDKYzCIEKM0NtxGRn4TcZO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkA3wgH4ZHgGUe+yTfrQU2coFjBW45jh93Y7spRw9261sXk7Gk
	cLk24O3KRsSApzA80RtPlhQyDfpdQOIKGGzq+pDcK44rpYnpf5dXiUT2o2aWVX1qJP8=
X-Gm-Gg: ASbGncuwZiJ+8JImrsL8cNjaeciSn/RC2/UKS7A+JvTehcNO3TF6hoAqH+c4PtI07kv
	VndYIjzdQd+jdfaKhq4nxTGlZB91yTJudhhmsLn3YVZ0nN2mIk5EFYSibB6PblsTTokonnV2/xc
	N0KKoTSLRmBl2zEKLPWuG0rXg5jEzARDeC4LfXoQgddzx8Ok4DVCriOmmK6z0H7g1c7x8nwRALX
	qOidKK700e8QUgelbvjCKrqhhFi7P/ymf4WHhvmzg08YyaDjPi7WyX8X4sn7Gr42Q30fv6ID10R
	9oPt9YfRkZY/RXry7OdJ5IJSjlYnLjcA81mn5MZCy0FXtBgT86o7Aj6vP1daS4egAbfdxHUNggL
	fliK3+A29zuIU7itRrcha66i4A+wCYS1PdiDp3g==
X-Google-Smtp-Source: AGHT+IE1IfNii4lYyAmhItgaQj/g69X1RMtfpryZPx9MbrEv2WxcHcjyfwhOTzesYRX/AF41sipqbg==
X-Received: by 2002:a17:907:d7cb:b0:ae0:35fb:5c83 with SMTP id a640c23a62f3a-afddccf2aafmr183951366b.28.1755600333117;
        Tue, 19 Aug 2025 03:45:33 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef41:db5f:8096:4609:9b24])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61a757a48e2sm1469787a12.40.2025.08.19.03.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 03:45:32 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Tue, 19 Aug 2025 12:45:20 +0200
Subject: [PATCH 1/4] arm64: dts: qcom: x1e001de-devkit: Fix swapped USB MP
 repeaters
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-x1e80100-fix-usb-mp-repeaters-v1-1-0f8c186458d3@linaro.org>
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

Fixes: d12fbd11c5a3 ("arm64: dts: qcom: x1e001de-devkit: Enable support for both Type-A USB ports")
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e001de-devkit.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts b/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts
index 2d9627e6c7983daedba87619ba01074ee22b43c9..a3323d03f644e411c472305f5cf3482ecbdb787c 100644
--- a/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts
+++ b/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts
@@ -1474,7 +1474,7 @@ &usb_mp_hsphy0 {
 	vdd-supply = <&vreg_l2e_0p8>;
 	vdda12-supply = <&vreg_l3e_1p2>;
 
-	phys = <&eusb6_repeater>;
+	phys = <&eusb3_repeater>;
 
 	status = "okay";
 };
@@ -1483,7 +1483,7 @@ &usb_mp_hsphy1 {
 	vdd-supply = <&vreg_l2e_0p8>;
 	vdda12-supply = <&vreg_l3e_1p2>;
 
-	phys = <&eusb3_repeater>;
+	phys = <&eusb6_repeater>;
 
 	status = "okay";
 };

-- 
2.50.1


