Return-Path: <linux-kernel+bounces-880186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20877C25137
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AD451A615B5
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5BD34B69C;
	Fri, 31 Oct 2025 12:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ap30yFQH"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDBC34888C
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 12:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761914727; cv=none; b=Gy/cFBEixs79XlqcC3OkErcGPP6NYv8tjF9/BaWh4oJNDx9sgDbzJBZT0h0fCbPhhMoG8RaHft9t++rqzd2m82u7ymsMjry4Hrm7LECkrNGRWdiC+ZVT9o1x5h79njPxbQlgH38xrATQegETq5rSkx1jQkHxIb4Q1aQWSgKacv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761914727; c=relaxed/simple;
	bh=I1G4HrvyfbVAsbzmJD99V+Jtc43Xn5CLNWorLqJlsfM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FxVURu1MYyvgqjAeltcsZ9oyFY9CIAas6MD2NEoiA63fBU1QqWD8/z9GO/HgsQZBlieIpYmYb/2YhHCgwGvgH6RDc/ri4Jfjv8XNfwC9M2ou7L5yVxFgvZ/qArTAtYSW49wK5p1PZl9/YS+7toanPrSD5v7siNABBstK98k0VCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ap30yFQH; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-475dae5d473so17776485e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 05:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761914720; x=1762519520; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d1zdAt8alxKXu7+wwqOHFCprCPLCy2H4M8hpdej4l3c=;
        b=Ap30yFQH9xg23O8FH+RVs33bUtYP8s+BSNNZ0SzIZOfGB/0+SeJWLUGmHm8H8O9ByA
         vupbycdwJAJ1UXPbW9B9jLgzdUeIyWgI7qqbCiqCaBRiCCREdEV7+92pnPtGsjAeR9Nt
         bV5iASsienyGyP3MX58THmaNmgUJwWiylzXEIZlcesytmX/zmxCORpteshJU2bRVAg9l
         s3l7j8mhQeldt0GWh309GIuT7M9TErb+B5GSRtTyeZMUlDuTIVsygrbUkOd+Y3XvrfZJ
         NG4+OJX7CLVhe47eYBY2MIb9pY9y7PGxIEPQKRIuKBPHTAer8S0lg0rH6rJWU4KQt5x7
         GGBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761914720; x=1762519520;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d1zdAt8alxKXu7+wwqOHFCprCPLCy2H4M8hpdej4l3c=;
        b=m3H6cgi/FBUBkYjGBb2JS6xxkKoSbd/jgb4Bpjdvf/REIOuHro1oe2YPTDdpQP+U9u
         0GFNzwjvOSDhMWKVi+jw1VOV3ZHR3CtSHyIqQB9vxcT+HeVB+3FhJMiRRqM4Qm4sLb1W
         jY4QCk6/wCF2WXpTm/AQVEL3G+VkGVBeXQrKMUtQPI9x4zM+1ydh8j7pgPBIDMReKEgh
         HZFlL3PEfY/JPkz9wTGZ8j9CRHHXlqpdYUvTvJtWMq66/e1CAxVgmovlRHf0Q27cLafE
         5u8Wi7AV2UdLFfcIVBcMFA9lpkFlk/c1sXGxvDolOL1StCwica+QDpqkxpeJz1YFCX4m
         rOCQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2uYVrEbCuboBR1BernlI3m8RO3kCFi3Y97XaxG0a+UKOIwL6i/1QtzG7Z6QKSR5sTrUQrfrqI+EsKueI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxtXfXJ2XpY+xbD662V+LttsmEuIz+knFOY99L+ycgg2kq+n4K
	swxKDLJ1gO/8tKXBaIp1vrfuUUPpWHiv/nhkupe0K8G0E+g5bVX0bjk4DcDROS48qIc=
X-Gm-Gg: ASbGncuEHnhkeDRePu5EdcQuSDOoD4yDEuYo7ILZcFnTsQR1kxAMsMad/cTOuGl1IIa
	fp7w6F6U1ABDlDda3fHkXviDNK5Ob7gELK5VEWPO81enUqjXWxewAicWLRQROGvt/+OKpfwCZDi
	EPg2LbNPsx4Wci7020IO2A2179rbF5BKI0mop/RGECvip8ItNEaEcs+T3vhyrexGoFWN6Gg0bDX
	rHuPPBnsQ7Vph+eTZ4PYem251KPg0EI0IjP8iI/w4/P1jR8jxYRdGDtZ4ARg7xbIVAkujJn1U61
	JlHhsxPFlWSBgpZ9McF466mvLxKv4Oci+8m9/uPvzWBKH6xSjSy7oCnUd3bvfYO9yabQDHUJ28q
	728+9S3oDJqS8231KZVl6iLik+Kp5YyB5et8MOLcL7WG945L/mUUkzLuZq3ESr5x7faafCzpKLV
	0r5A31jHCt8pB4KEWaShES7wP+NSgXfurW7jvxQHri0yBmYtYsZjJ+Za5shsaxgWI=
X-Google-Smtp-Source: AGHT+IEK/W4yVhoAW7D+P9TnpwW9uaMPeYy0pNTapbce+kkipDxqWnUCZ98HqD9CqA55/PAeTmV/UA==
X-Received: by 2002:a05:600c:19d4:b0:475:dd59:d8da with SMTP id 5b1f17b1804b1-477308c8e97mr30921705e9.40.1761914720095;
        Fri, 31 Oct 2025 05:45:20 -0700 (PDT)
Received: from ta2.c.googlers.com (213.53.77.34.bc.googleusercontent.com. [34.77.53.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47732ff7fdbsm31077535e9.16.2025.10.31.05.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 05:45:19 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Fri, 31 Oct 2025 12:45:11 +0000
Subject: [PATCH 3/5] arm64: dts: exynos: gs101: add OTP node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-gs101-otp-v1-3-2a54f6c4e7b6@linaro.org>
References: <20251031-gs101-otp-v1-0-2a54f6c4e7b6@linaro.org>
In-Reply-To: <20251031-gs101-otp-v1-0-2a54f6c4e7b6@linaro.org>
To: Srinivas Kandagatla <srini@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: semen.protsenko@linaro.org, willmcvicker@google.com, 
 kernel-team@android.com, linux-kernel@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761914716; l=1131;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=I1G4HrvyfbVAsbzmJD99V+Jtc43Xn5CLNWorLqJlsfM=;
 b=yAkO8ftyoCV/NHjE/cZ5n3J89+y1CpBH9oKdPf2i/Iw3cYgeO5ytN16n4FzJPlPsQthtA6RjQ
 br/xIVSj+kID7nVyxZXCRkDQ5qz5DOZQdITvF1tNxmulCKbE7QhYorD
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Add the OTP controller node.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 arch/arm64/boot/dts/exynos/google/gs101.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
index d06d1d05f36408137a8acd98e43d48ea7d4f4292..3cd5675c094c0774b0efba1b5f76f8916cff3fc4 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
@@ -571,6 +571,23 @@ soc: soc@0 {
 		#size-cells = <1>;
 		ranges = <0x0 0x0 0x0 0x40000000>;
 
+		otp: efuse@10000000 {
+			compatible = "google,gs101-otp";
+			reg = <0x10000000 0xf084>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			clocks = <&cmu_misc CLK_GOUT_MISC_OTP_CON_TOP_PCLK>;
+			clock-names = "pclk";
+
+			product_id: product-id@0 {
+				reg = <0x0 0x4>;
+			};
+
+			chip_id: chip-id@4 {
+				reg = <0x4 0x10>;
+			};
+		};
+
 		cmu_misc: clock-controller@10010000 {
 			compatible = "google,gs101-cmu-misc";
 			reg = <0x10010000 0x10000>;

-- 
2.51.1.930.gacf6e81ea2-goog


