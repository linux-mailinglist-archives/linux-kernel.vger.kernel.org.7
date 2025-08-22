Return-Path: <linux-kernel+bounces-781808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CF2B3170F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A88EB01E27
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5574530147C;
	Fri, 22 Aug 2025 12:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H1lncYhw"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C812FF168
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 12:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755864288; cv=none; b=ez/LEyppbobf39jNH3yV+EzrZx1xTJ4HJvm/hBt0oBChRojN4Nu5xZYYQqJEVUBYGsfbWVU8btfmqEJv1KbiGbK9xFzDiLJiJsDiT9zwa56ubwF4IIM+sJPbUADWaeTMRYe29F9PjqxjVp8xndBQfPONLng6n6JqGjPjFrZyiOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755864288; c=relaxed/simple;
	bh=fhx4qA5vbBxGuVXFp2zb0fxoKg/HfmMBK/SJLBwRLLc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PldZX8H6bBY/GiKywtGlzjxethwlzjNkwsZSjhzYcfSCo6SHKoKZJtKBWe97jKhWxeEviIZy/wZ7SMCU76LivKUZUJHYPj3S6LFbK4wDpd+ez0qTqs4Dt8swIJnZCEBjd++qpVCiWKenCEfznUXGtv5WyA8W8FFQqR/cTFkGyNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H1lncYhw; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-61c297e8306so21930a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 05:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755864284; x=1756469084; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EQa5S8p7ueAmkYOj48doK7QNoe3xBD1AkU2ddIbj1ro=;
        b=H1lncYhw88bsWrnotqtVIVxN8QOJBGD3Mk5WbMmGglgcf9f6i+Deypmqtpb5yXwuf+
         o968O+gtAVTiHDdTOzz1aPzDVlXz3wUy61y0f/jV0+9iJg/j91/HExHlBI4Gc1U8pOr+
         ccgouFVgwIBjf5xLno4YPJyq7IkiGqdIb61DmCxEWrtgsDDX5pMXrKcx7N9gfxNXkiTW
         A87BcCUoj2mrGhSMIOFXrTyfUZCVGEmHu0I8g4sl76FDG9leu3j2FolAGaTWThyeogyw
         RpSLms5BuS8MrXb4x21gKQOKYYtc1wzZIBzXSNM75xwWbhWIzQU44Sr4Psmo8CkHJAmx
         k1Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755864284; x=1756469084;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EQa5S8p7ueAmkYOj48doK7QNoe3xBD1AkU2ddIbj1ro=;
        b=i58HpzaC6AE0tnxmIvX1/2euMF1LreMOJwHEMljz46DvMpXghnhkmtC4WiZMlZf45S
         P8G7GFIy+aBcqjeE5mhp4oakgdeCFQmRxrrLO64cILGvDPIZJJa6hmlhvcL720Hm5xYY
         3i1+3yz/9i/8SpPGnjCVAsyTVOp5ZazQ0R3sybIFZ2cGoc70IR2m2FlfhKQbcQUaq1Qv
         SRt3qjoViPm8N6OZ1kM+GQNI9QUVzzTlv3LXWlhSe8xWfpYsnSpjD/AIQW46LYCa6JYf
         ITW9M50bynlf+DvFl4jYGC460XvIhVOQnAfWGiksMsweir71NUzUQfrEgQwm8f6NikWP
         WeCg==
X-Forwarded-Encrypted: i=1; AJvYcCUGXsL4iLcJ3jx8M7WT06aOwLaNOVGcc5K9md/HfV56vCmZ4VtuS+N3WMUzXIgjx2wVcPr5cPAAoZJNfKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiEfGdyvdiumQMuXxEK9eB7mwqQ07RFlN5PmaSnLVYEDcUKp5M
	5T59ZVOlM7FqJ15bIs0KTdKUIXzP1JelpSRMrktiI3JAUZQI7nGDJxNMstbK0Xk1ZYk=
X-Gm-Gg: ASbGncvEFdX/l4uxxgScQmRn7+8L46yuLD7g4CvFUYqLZrECAwrm4EXY1MTjqMJKoe9
	SN+hairVX2RPBRMexIx/Ao9iSH/0UjTZTd1izzelTK9V7/wy3g8QYcivjh1Gr12GSynsa5zZIfv
	Nv/U2e2XzWKp5TiIzASg4EqZ29oCKfNs6UZGghXzA/9P5nJVUbYgef5yDq9Y9J79BHmVxcEeABT
	hO7x8JNIRmgaH4tRsKaNbs35K+ZeaGWhIkKE2iCryBL5EYXoolLfwcpmoR7obceoJokyncHdT/c
	9BvBQ9qFVdO2C4WiJIWZJmckFJUlRl1lY2aDAWV29q5eEnqhz3cP3bPiuGsBKJmIfZIX3xB0Prp
	jca/n5DKJmf8NnuicDELikoVnJWMFSpK4JP1BoxTGr+EgQps0Ww==
X-Google-Smtp-Source: AGHT+IFup095STF/nYlaIZ0iLYVWQccCjphW9SpOxehfPg5FRUsXrc0HSdjlMRXIFqI5q8sv+v4nuA==
X-Received: by 2002:a05:6402:13d0:b0:61a:1fb2:3297 with SMTP id 4fb4d7f45d1cf-61c1b7015d7mr1305505a12.5.1755864283924;
        Fri, 22 Aug 2025 05:04:43 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61a757b9b39sm6690444a12.48.2025.08.22.05.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 05:04:43 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 22 Aug 2025 14:04:13 +0200
Subject: [PATCH 13/15] ARM: dts: qcom: ipq8064: Add default GIC address
 cells
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-dts-interrupt-address-cells-v1-13-d54d44b74460@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1349;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=fhx4qA5vbBxGuVXFp2zb0fxoKg/HfmMBK/SJLBwRLLc=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoqFzG0ReB7S7IIfI1P1jRs6m0jx5gKuNFiPiPS
 T1/G1fMoCmJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaKhcxgAKCRDBN2bmhouD
 13GJEACENkhXxp6OXltHIJkjwjath1Cib1nzmgosBRItvf9Ekm/hUoX1mjBKZ76suWtFLQvJK6w
 q/nWUyjVT66Y4F58RA+O83ucMR3ndUzKv+2utB40n6advv0XVwwLkHo643hpMjPWc5kKUaWYik8
 odR5IrtVs16dzDR4pthJeBFJJ1PfwGQAet5XHhDMAkGbWRE+w+iY0145SSDY5N4W3Mr8DGqakZZ
 QqQwjp3MEfcc4g1HTsQqWRJKmrClbiPPTMthE1RVFlPBVg1QVCgjXYvAB5j+kz6zBigaLbNpXcv
 sn/mdl9dY3PA5Vgwv/NyjhuU6cNlnAHxJv3aedH+a0vVyoiEEsqevsOUCTOi/DpIraqKGp8T8d2
 SCHKG38l4FKq3YIOZNhbZ4/6YVjTMHUxhgIOGGjRkRxRWg5P/wwJGZGYBssVF/6Sb1soD69JNJJ
 ED8CHgM6sLPth8YLIQ7u9cvBKrwRj4PyvLO9T34ybGgEKF+WVvdQyA5UkfMOPxVFXJsV2avpEsK
 ThxskWXiU4Xa4rXmOSqmIEMBmAnumWdKV8EkNWhfzJUKaSiaSunTpeihptW37mNpFci2afpv6CE
 yw36LJssdOh4Q5x4Msgrnb7F8NewT7632KNqziWQoRtJEtyZXesbkbIRKG758Zw/7OuI7oYVSWQ
 oIN9KMzmczqSXMA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Add missing address-cells 0 to GIC interrupt node to silence W=1
warning:

  qcom-ipq8064.dtsi:1201.4-1204.29: Warning (interrupt_map): /soc/pcie@1b900000:interrupt-map:
    Missing property '#address-cells' in node /soc/interrupt-controller@2000000, using 0 as fallback

Value '0' is correct because:
1. GIC interrupt controller does not have children,
2. interrupt-map property (in PCI node) consists of five components and
   the fourth component "parent unit address", which size is defined by
   '#address-cells' of the node pointed to by the interrupt-parent
   component, is not used (=0).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi
index 96e97350153506922b7560131e33664d51e891b5..03299078fc5a2cdf9037770e9de2951efce9b487 100644
--- a/arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi
@@ -527,6 +527,7 @@ sfpb_mutex: hwlock@1200600 {
 		intc: interrupt-controller@2000000 {
 			compatible = "qcom,msm-qgic2";
 			interrupt-controller;
+			#address-cells = <0>;
 			#interrupt-cells = <3>;
 			reg = <0x02000000 0x1000>,
 			      <0x02002000 0x1000>;

-- 
2.48.1


