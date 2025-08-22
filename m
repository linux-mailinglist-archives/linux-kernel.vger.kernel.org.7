Return-Path: <linux-kernel+bounces-781799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 534ACB316E4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACF8F7BCD49
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12C32FC027;
	Fri, 22 Aug 2025 12:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zjtfmi1S"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BCA2FB602
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 12:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755864276; cv=none; b=l3T8CamIabRr2HL6vd+e2Z162y0B3oO07cQ/oc2iX/vDzodHtQjCZ138fv2nhZonXo7r3TfNnocz3iBUgXPt1Aa73GB6vQtUctooOKKWipsW22dglQnallyQo/twOfRzgS7kJl4L44EwJ6oJ/R3Ad+g2vjYVcDevaC46mWwaVSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755864276; c=relaxed/simple;
	bh=/b5Zazjl+99qC3Qy+yEPozMfJljMU0yUYb3X5nUTek8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HlSs3zcSWKm7oEjrZDjyR87kTNHZhPA6elEpADHPUHO0ufTRXAFYWJw5Squl+Quebg04Knoj4UbtTf34eFMS9FpgcQwZ6CZeFzylxKGGCbxZlG1qjVPQGpwjSiZS5YuncgwLVe+tlXn7YZbSv6Vmu8ZzwBXpj0osdMOGVDj1mig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Zjtfmi1S; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6188b6f5f9aso276046a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 05:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755864269; x=1756469069; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xkhMBlBL1V4MbzC6fWXXMTH9/XMHxxc/1U+aAD903p8=;
        b=Zjtfmi1S0zVlsLVkEjk3SPQ2BRqjs0f+CznC5A5B06/qJ5Xo0DLbAyrkkObE+SyEgc
         Oh24fjtK1i19hgI/pnLj+Ab9nbQGQwA0+O83Km24Lfxq1Ip27qkXUoiTcKF+rY8LBHv9
         0yOtCSykuHzP5wa36QYvnn9hOzO3VsHq3zdxN8+omkRJ3Swd8AEf8RO3kLeoUPMDByda
         4YbwZXpMSUibvuoRLR0kLFID7TBKOtsjB0eisruXkqCipCmh/iFhoqUIm+jejSdm40FQ
         8r907JyrE4f6K465ujHb19yA6W0Vi2axwFubsDZye+LJXvGr//K9vxIeI0x5pT323/yQ
         qzLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755864269; x=1756469069;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xkhMBlBL1V4MbzC6fWXXMTH9/XMHxxc/1U+aAD903p8=;
        b=S3TwzLDsRahpuSSJShHxgBaH98o6x3/GL1hvqUzxLgEayiLq1dYiQj5lh8FYjeCFNX
         4slOmg6huk8m4GDtEKyzkz7Qo9S1cFCRDXjhxAqyBJN0sMQkw5Fp6LBq2OEZv0vAtqhP
         LBnevg1sXWvK1mgmOWtBoXHwKl0isFTWF7FNEp43jfO+CnAHluARE9yuTDV1Ed4THJLo
         STuX+MFpuNIMC2ofRwk1sXclByoghUFzIpNi7jvMPxsNt9NlrQ1Kk7Zyti+AFBfT25qZ
         rAlMrJKPGWOUrmtrUjOVhvk35bPmqiW4MP2KewZNKUUvqXmbLoxqRtFoCvkCKoqF/kOV
         tnVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyXMhzazJ1alx/lMko+qRPCcZJPGfmMnQnYpbQOWfjzE8JKkkLHWWp1wRaji7HE5EVo/LI5vH3hz7dUwM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy42oTZItZh/BykolR4lF4y2DRbseuQckQarXETgYbTpvOALlea
	aCY39tcxhKPW6E6JRoL92RzM+e9exwOTzcvWpRWg/uP0wmN+HABthWq1/8K51Ebi8do=
X-Gm-Gg: ASbGncsx9jU3Z/ZGlpBnEo2JAqwYAXKZl6v2YMCRJwGAhNzYl6E/+QwcQwbS1lK3u+S
	iUgG19IpeR0S51Iisz5kMDW1FnfGzpK+58mcfes/hhRJHxrq13oEzFHtiZyFZcs6WCfWoeD/3lA
	x0MR1dyB7mYv2pYhPRp3q1IwdGPSMe8u4Uyb4qtXejtSRKjZSBBhQoJJGlN6DLDNwCHYGMUY2F7
	WicJznpa1OppmNyt76KvlJ80Jrttgf3OWN5wSQef0f/fv5R7kabPAZI3S//dcVYK2/BQwOtyF6f
	14U50kQe26sLbhL3pFE4uTeTS0f3XYox1w0aphvnleQgq+AhJiAYrnbymxSMfrDbQ6ZoppIQ8Qb
	DlzL/McY4Qrm7yL14eGJ/m8GlMG6YIYmDDvym2Ds=
X-Google-Smtp-Source: AGHT+IHO9WGYVdkgtVyjF3FtPCnvvXecLAswmBNxyYIMX+vuVg32YmANKpoKwd5qMd3GFwOppYLtEA==
X-Received: by 2002:a05:6402:234b:b0:618:1835:faa4 with SMTP id 4fb4d7f45d1cf-61c1b4d0198mr1457381a12.3.1755864269185;
        Fri, 22 Aug 2025 05:04:29 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61a757b9b39sm6690444a12.48.2025.08.22.05.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 05:04:28 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 22 Aug 2025 14:04:02 +0200
Subject: [PATCH 02/15] arm64: dts: qcom: lemans: Add default GIC address
 cells
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-dts-interrupt-address-cells-v1-2-d54d44b74460@linaro.org>
References: <20250822-dts-interrupt-address-cells-v1-0-d54d44b74460@linaro.org>
In-Reply-To: <20250822-dts-interrupt-address-cells-v1-0-d54d44b74460@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1393;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=/b5Zazjl+99qC3Qy+yEPozMfJljMU0yUYb3X5nUTek8=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoqFy8fwO/4blwnQnNg7cR0tlGlGzM5kBEH6CQg
 YxwXDJxIBKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaKhcvAAKCRDBN2bmhouD
 19LxD/9t1AapJFiNmaYTBr+fbqAXDUCayFUZ7If4gI9XeZ1IyNixz5QtUU9ul0ya6ANh1cgtC7H
 VKT5qi7zHttMBZ6msMm5nkMOXpMtcvRpKzEF0JuEVllff2NvYeKIKfIRfgejTQS3ZtB3eEGCxYM
 zwlCbgsIFtmngh1+jqFzNzGDkhGtHeO7H56/PESD4NIoWdr4MjpxaP8s8pSZzcZHQTiZHRIKAFV
 Ew+qOKMjZNmhW0wJqbwrm7kVK2dBfEIk63uWRSP2iRCBLlkLRm8d9vuuAqFiknKxteGcMf65ZyH
 Da6BarrcCS3/9LsG18TC3dELHCuBHqzY0duWqBiPhN6kb+1+b5rqEGun3TdJTZYu1iLHec35kAE
 rsMUtyq/5AOKHHAdGZFU1dxwJ5II7PPf5/BI9CRDAi4kMEVcOeA6BW8wvNQGxRIQvv/gXhj/GWJ
 uH8UEZnm/Httx67ZegPj862x6o8K1ZtTGtPWGp5r8GfgXsdu+5wyBKgHrsi4pHbDG82xx8NjaMc
 JS165yCZxAjEXdymgZ8bN87dJj/OM65gduyBcFpY4z1OooOIilFpbMud6PnST7B/qC+qFpIuEbh
 j7Rs2+0T1xpPJe5D1JX4fh/lulNBmL+R7EQIMOauW3M8T6gJSv5gPW3C8nfRGqUnAXX2VZR+tpr
 drNfkdiC4dNtpOg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Add missing address-cells 0 to GIC interrupt node to silence W=1
warning:

  lemans.dtsi:7623.3-7626.29: Warning (interrupt_map): /pcie@1c00000:interrupt-map:
    Missing property '#address-cells' in node /soc@0/interrupt-controller@17a00000, using 0 as fallback

Value '0' is correct because:
1. GIC interrupt controller does not have children,
2. interrupt-map property (in PCI node) consists of five components and
   the fourth component "parent unit address", which size is defined by
   '#address-cells' of the node pointed to by the interrupt-parent
   component, is not used (=0).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/lemans.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
index 64f5378c6a4770cee2c7d76cde1098d7df17a24a..55eb2bc36b23dd61aae65f0160074637c8e7e1a2 100644
--- a/arch/arm64/boot/dts/qcom/lemans.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
@@ -5866,6 +5866,7 @@ intc: interrupt-controller@17a00000 {
 			reg = <0x0 0x17a00000 0x0 0x10000>,     /* GICD */
 			      <0x0 0x17a60000 0x0 0x100000>;    /* GICR * 8 */
 			interrupt-controller;
+			#address-cells = <0>;
 			#interrupt-cells = <3>;
 			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
 			#redistributor-regions = <1>;

-- 
2.48.1


