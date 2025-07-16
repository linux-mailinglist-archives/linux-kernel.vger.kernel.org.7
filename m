Return-Path: <linux-kernel+bounces-734364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2357B080A6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 00:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E2943A755D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 22:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4022EF2A1;
	Wed, 16 Jul 2025 22:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="URKmY4VQ"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92662EE967
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 22:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752705996; cv=none; b=EdmT3KlYK7eEkCKMU0/sOCswiUW/fK4DKx12tnboE1uIbbHOnty7pKv+MN3azla2EurHLvsRtHU5Z37sl3No3uE1kualaxZ5R8EAiVLhjVaxdeHikXtH2n9YZb7OplwKS/Sz30S3WZE4rXZGr/L5Fgu4Ic63EJzfffC0aqeuP0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752705996; c=relaxed/simple;
	bh=/e5+cFEH9w4+GZ0QyMKM7a9cjJ6N+Un3FjPHBIJln9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OSV52TME4O+M4D3jWknA4xY7oBzyqLCT1jAsU7cckSP+mJxflrHCrG/K1v6qxrTWvQR5L1/cPq8lkiVWQv7Fji+3cgDjVjodF8TcwEuLvyESaP9NQFMaEQugBKPiDJQGiKxMuhB34Um6FxuT1micsCxHFXtSo/Y+lolXCLCk7pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=URKmY4VQ; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2fef7f6d776so143704fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752705994; x=1753310794; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r+9WkLvKxCVNjpjJMT0iDzPKr8AA3uiZWqAZX0UYmVw=;
        b=URKmY4VQQvq4EojG92nnfug2RhZPt211qUAWXshUiPnfBj5xrhErAXU7IeGoxfHAT3
         i6bewPDIYxtLl5zduwwx+z6N3oxRlKXzKS1Iln5T3TEv/GgfDTXyIxsUrrnHvqeB+bM3
         UrpGiGbPOaGGm8AXSQOpaPsac0YyAdogaCq07qFw+qR4CKQ8anLYJPNRS6GY6aosvzMT
         VVa53j6IGP1yHwiBpBhJt2Xf4RE5mPa9DxniQdXIYrcG+g640T8gJkAwjsGjdyNg4wVF
         o7SYhX/6mWBIL+4JvAeVYXiE/VRx8rr4eF28UTN+1AfgmbfQR3p1HtQETvflH/8Qq2m8
         K0bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752705994; x=1753310794;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r+9WkLvKxCVNjpjJMT0iDzPKr8AA3uiZWqAZX0UYmVw=;
        b=DMtNkxwZj9Hq8E9t/hzOjCWVnXALwSCfo0PDso49YZAZ59KsmxeOw8oiByRGdJH+Fi
         oS6D+qu0dwCPAq2C/6Kw1Q1smuueeM8zni4Seu43qifvNeUG+kcw63gsTjw8YqqpQARj
         cfr3Z/3r+IFtjjuDU7kvLqIeyPQQHLFnc+8ImBqo/xWn/Mn/NZNI/Q0PHL9YcVfWHz5P
         heF+QeRAfmJlpVltZNTNZyFSfosSdcbGLqNwrCr+K+RDraJQaalfMYd9lOGI/4GouaxY
         /rK9fZc7YUJrYNuNWeM+oanBQEN/a+RVICQpT6E2uBs6GVIE7JGFVKa7T+Q/cjBV3tVs
         N07A==
X-Forwarded-Encrypted: i=1; AJvYcCWnvQB2MDnUVoIOv3iToJ/jHYi47WgMmt4z18lehmRk6VMjmiuueiKThvy01rvtLbXLhBemjSqfa3Bvafc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXjUs1+6V2aRn5QN+0dB6ApJSibc5/Lplb3Da3CES52XSpqiSS
	vJB6lGezixinZ98iJVs8N8bylVkVQsrTtIMMiaOe4nV6XjjUONwwM2Piv+f8cS5kTrs=
X-Gm-Gg: ASbGncu+fDAkajdX08grRwezcOsAAg4H233D4ARCpp8g9eTX18E7pwBhmaG8rgBIS/K
	jcUyLmljZzDWLhhOivywIMeeSh7AvNwzKi6nTRLXmh+acmnuQnsJN76DeFuwoFmMYRzzEt4Az4t
	EZRypI4ONClDq3ctH5a3Bu6SJhcB4Mz2KTxEF0VQ1fvTQWvXSwLz5NrrnSpJGqEOYX4p79ypMtE
	Fw0Zf+06yitGFrf6HsJJDEM5w7IqmQKwDV+tWmzDps1JFWQaMaNtTumu0KIsK+Oragk1S2fgJXM
	9+NxqUDQwyU6ftIr8Z6qzNxlwSJycyFpui8mJ2SDr8WbywG6SAYV5LfhrtN26Mx1+M9AAuZCcNr
	V5sWoQBx3VoJwWrq/7IRI9DEb0mwGEw==
X-Google-Smtp-Source: AGHT+IF0LmgLP0/FrplToo3zBIOwwv/f/5ChaEptepbpq2yLyxK0fU0sEf+7Lt3bCWvy4wpyOrIgrQ==
X-Received: by 2002:a05:6871:60c9:b0:2ef:e245:c65a with SMTP id 586e51a60fabf-2ffaf6002b4mr4420295fac.38.1752705993846;
        Wed, 16 Jul 2025 15:46:33 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:3f28:4161:2162:7ea2])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-2ff9ff853b8sm1651683fac.23.2025.07.16.15.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 15:46:33 -0700 (PDT)
Date: Wed, 16 Jul 2025 17:46:31 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: Chester Lin <chester62515@gmail.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	NXP S32 Linux Team <s32@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] arm64: dts: s32g3: Fix whitespace issue in device tree
Message-ID: <52960eb1-4432-436b-89aa-d50fc7da2c3a@sabinyo.mountain>
References: <cover.1752703107.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752703107.git.dan.carpenter@linaro.org>

Checkpatch points out that this should use spaces instead of tabs.
"ERROR: code indent should use tabs where possible".

Reported-by: Xu Yang <xu.yang_2@nxp.com>
Closes: https://lore.kernel.org/all/u7glt7mn33lbdeskbr4ily6tjjifvffy64llwpi5b2rrhx5tnv@y2h2y3oz3xc4/
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 arch/arm64/boot/dts/freescale/s32g3.dtsi | 32 ++++++++++++------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/s32g3.dtsi b/arch/arm64/boot/dts/freescale/s32g3.dtsi
index 68c11ebd405f..e80144e33efb 100644
--- a/arch/arm64/boot/dts/freescale/s32g3.dtsi
+++ b/arch/arm64/boot/dts/freescale/s32g3.dtsi
@@ -489,22 +489,22 @@ usbmisc: usbmisc@44064200 {
 			reg = <0x44064200 0x200>;
 		};
 
-                usbotg: usb@44064000 {
-                        compatible = "nxp,s32g3-usb", "nxp,s32g2-usb";
-                        reg = <0x44064000 0x200>;
-                        interrupt-parent = <&gic>;
-                        interrupts = <GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH>, /* OTG Core */
-                                     <GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH>; /* OTG Wakeup */
-                        clocks = <&clks 94>, <&clks 95>;
-                        fsl,usbmisc = <&usbmisc 0>;
-                        ahb-burst-config = <0x3>;
-                        tx-burst-size-dword = <0x10>;
-                        rx-burst-size-dword = <0x10>;
-                        phy_type = "ulpi";
-                        dr_mode = "host";
-                        maximum-speed = "high-speed";
-                        status = "disabled";
-                };
+		usbotg: usb@44064000 {
+			compatible = "nxp,s32g3-usb", "nxp,s32g2-usb";
+			reg = <0x44064000 0x200>;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH>, /* OTG Core */
+				     <GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH>; /* OTG Wakeup */
+			clocks = <&clks 94>, <&clks 95>;
+			fsl,usbmisc = <&usbmisc 0>;
+			ahb-burst-config = <0x3>;
+			tx-burst-size-dword = <0x10>;
+			rx-burst-size-dword = <0x10>;
+			phy_type = "ulpi";
+			dr_mode = "host";
+			maximum-speed = "high-speed";
+			status = "disabled";
+		};
 
 		i2c0: i2c@401e4000 {
 			compatible = "nxp,s32g3-i2c",
-- 
2.47.2


