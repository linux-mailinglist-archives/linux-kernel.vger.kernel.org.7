Return-Path: <linux-kernel+bounces-852931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AD2BDA3C9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 17:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4970119A4256
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8F22F2617;
	Tue, 14 Oct 2025 15:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1ODXOwH"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E88B3002A7
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 15:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760454337; cv=none; b=Z6hTk+d8gjaBNS4Wtvs28v7LMDAJNCPuAJGdOA4LOgUzZXQBwRLMSyqzTWhsFOUJuPVFdYu70yGUtOlEiO1CoaEIXxEhB6MGn1OsE5m4QPonH2QJSdv3pSg+OyOy8jot+J+C6PfvJYmCXOB19BsqMhQC8vLyNf/oh1MOARFA1tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760454337; c=relaxed/simple;
	bh=NgiaadnBWzmQWHLVGXTkghr12q4e2Z2pGwu46CpKaLI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L8EUIjELP491WKOluTO2CUEPlYKZyFgtbIbmnHviZodOB2fOzn3bYdYZeGQf5bm2CCqzAVQyckFtqeDftL+k7s+FSdez9J/ibfkppv/lOfEzAMffzn3YUAjS+PTcmI9WLM6tI2IDuc/iL9zcoxO9S5O4nmmg+c6KO8PNIxlMSdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l1ODXOwH; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b556284db11so4826557a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760454334; x=1761059134; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kj7fG7XAER68na8hgLjfPolxfyD9eQkGEiz9N4R6m0U=;
        b=l1ODXOwHX4RHTUMAokaq07RB32KPCjn0Z2UEf/39fX+bgFSerj07NKdYQLmS6oeRp8
         Drz+geJ7JXGfx10OOy2OvgXohnvCgAvoW3ZJIF8E08xwy4QCwFi+jeth6OBQ9KQ9TbE+
         zFrP7MulpTLVAHGw/pODksDelJZIRBzs7QkKXVNENVDTfkhnfs6VxVVucB1gdKo80hoL
         pyRB/2JkQ9AHM7OYYTyMBaM0oHMRnYCd3nu9qZ0Qud9Smbjz6q0QOTH/X4qYjFD/wEMu
         MEAp4DuYSYI2dIV2QzeGlOFuARUS499e2amUUP4mhaRFzfgGxTmMbxK4UXUgv+0zkkWL
         r8Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760454334; x=1761059134;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kj7fG7XAER68na8hgLjfPolxfyD9eQkGEiz9N4R6m0U=;
        b=Rx2jsB9oSQQQkOBoK/43PmeWwa08tlfJrEYlN1H3nRTzFy+gSt98pE28NfY9Vfg9D4
         rW+z82Bdm9YBAsOLQQowu1S7WADFMWNn/2VwhBUExfh5xnrEh91LVSDmHkt9jEOu89sc
         ngZvWmsRPi3fY2Tyt/num5DV7IbDDmXdPlq1QQcbCdMnLnPFG2iXRl3rWeEJdb4zLRe0
         3Vd51g4dAmm7D+lFGGwxhH4LGgKGPRAK74ceWtsuAQJ5m6gmEaZQo4VNXFl3p11K2tHG
         25AV3S3OUH1xFjRtl7anDxXrtzqF20Qz5Y1i6z7bLyDS2Uy1/+1VSa0WdOqfP1e3YJ7N
         HOtA==
X-Forwarded-Encrypted: i=1; AJvYcCV3IcBLPuPRqjnMOY2VbvtK/eR47o5zB9CJCDSsOZwTenqxGFr6PdD+oSQS4jK+8NJtIpGo/cD2vZDkXBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrM7UPn9eZMqEkTMYYKNIZogarqT4DmlYLk+6Kk48bn1txqruV
	9ACURQQeUN5SdKnhMAaK65Temfj1iQ7qsPIH0wg7/oPrr9qabOaIGFyIomsjqQ==
X-Gm-Gg: ASbGncsYgMoTD1NGyz2edokeDK3M8CW4bYGgTV3Kd3FJgcZBd5G0OqkqmMYxJNa183a
	VKq52dy2DsctNVYBuRaXgvcjSvTaDxqvVJW5AjP6mANcBwu3ICdWop925hdmZZQmO5QFCgq7Nll
	PUT/3js5X1cKN4UrHPKPg0nD65334nfoSe3ekMVFp42nQKh6CSKt5BoZDEBPzK97DU/Qw+4BJo3
	uqlH2yT3iaqx7H784qyAJMe1oC1gyZ7ebSwwvbt4Y6oTJsG08/hrFv9wYAS7RAke7hbfeBle4VV
	vfbvqBDS9KARyIt7NTmF8BjGAoJDHb70Gz9a1NbfvoA/NQEf3iL1mPU+ZyxCGuyfActFMsSRCQk
	kZ+5rUEYlC7lJAMIO6yFj8oThO3Q3ltzZiO3sg91///s=
X-Google-Smtp-Source: AGHT+IHbjYg+JErGsDXlogYv4U5n/Ev957SikqxwbnwgsM4THfPZkc2ANoLT1k5m1jk1sr8QGnevjA==
X-Received: by 2002:a17:903:1a8f:b0:252:5220:46b4 with SMTP id d9443c01a7336-290273ef076mr279316715ad.37.1760454333232;
        Tue, 14 Oct 2025 08:05:33 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-33b61a1d3cfsm16258161a91.2.2025.10.14.08.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 08:05:32 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Tue, 14 Oct 2025 23:02:54 +0800
Subject: [PATCH RESEND v8 21/21] arm64: dts: apple: t8015: Add CPU PMU
 nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-apple-cpmu-v8-21-3f94d4a2a285@gmail.com>
References: <20251014-apple-cpmu-v8-0-3f94d4a2a285@gmail.com>
In-Reply-To: <20251014-apple-cpmu-v8-0-3f94d4a2a285@gmail.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Sven Peter <sven@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1462; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=NgiaadnBWzmQWHLVGXTkghr12q4e2Z2pGwu46CpKaLI=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBo7mZv5D6VFnHY7xtzs/SFP7ACL+A9EPJr60YCu
 l4xx7HpGz6JAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaO5mbwAKCRABygi3psUI
 JKcQD/40/H4Fdg/0XKvNk/ItYQoUHoX7cpR1j5MG1alkId+ifV/HOPZMjKMjSRzMBWEFpbI8g4V
 O6OUkcbVVog+LpZYlwx371Vrm0G+B0pRV61KchCZ/kvp9AQg8ndMtQr50YU83ZYfOtadimZJPVu
 QoUgY8jK2tUHciPv56GZXM52jMQObX5HxyStxCJzUI2zB1vkbtBQSGXn6T87ivVS2XuB3OMV/bc
 USy7QhDP0YG19Ebb+i7ck1ZWzvZQio+cgRvA/DxGCmYgigKvmoJ+UEM/6W13MC+tfvEQddvjUSQ
 BpsWJLbERjxTj5k7R9HyBfYhjDt0jQW+7dYBpuoZel1Jw66Gf4+Kx2az4LuCHWcOhRngr+y1wf9
 revK8izGXomy+QY3xFi//K9Qh42saySjl1/qTUVHVizoI9JHc19TWM5tTFFmiDnY9whiJjGHXiY
 lyluNFhn4Xqza6j6Cs0jFuVtftS9a6FNkZwrw4WeR/6kPh+He9okbF3ZWKAoWRzVxhxU9CSW1UF
 ybR5ss86Mp5fxT6x4SOQPPAbgnW1tOA+J2Sx/217mVxPsQoUGsgBkUzNvQVLr2+mbFnPESUngbR
 R38m7Yq3XQPAlQfy+T1iQev13fHjEhR2/9QCGV665dG3ZFCmJEgbvP+1X7oBauAkjhRXGiZgCmz
 vLivvLjl0yITmHg==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add CPU PMU nodes for Apple A11 SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/t8015.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8015.dtsi b/arch/arm64/boot/dts/apple/t8015.dtsi
index 12acf8fc8bc6bcde6b11773cadd97e9ee115f510..9bf5157f0e504b7394ef5354411d3d37e8d5760a 100644
--- a/arch/arm64/boot/dts/apple/t8015.dtsi
+++ b/arch/arm64/boot/dts/apple/t8015.dtsi
@@ -284,6 +284,18 @@ aic: interrupt-controller@232100000 {
 			#interrupt-cells = <3>;
 			interrupt-controller;
 			power-domains = <&ps_aic>;
+
+			affinities {
+				e-core-pmu-affinity {
+					apple,fiq-index = <AIC_CPU_PMU_E>;
+					cpus = <&cpu_e0 &cpu_e1 &cpu_e2 &cpu_e3>;
+				};
+
+				p-core-pmu-affinity {
+					apple,fiq-index = <AIC_CPU_PMU_P>;
+					cpus = <&cpu_p0 &cpu_p1>;
+				};
+			};
 		};
 
 		pmgr: power-management@232000000 {
@@ -412,6 +424,18 @@ timer {
 		interrupts = <AIC_FIQ AIC_TMR_GUEST_PHYS IRQ_TYPE_LEVEL_HIGH>,
 			     <AIC_FIQ AIC_TMR_GUEST_VIRT IRQ_TYPE_LEVEL_HIGH>;
 	};
+
+	pmu-e {
+		compatible = "apple,mistral-pmu";
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_FIQ AIC_CPU_PMU_E IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	pmu-p {
+		compatible = "apple,monsoon-pmu";
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_FIQ AIC_CPU_PMU_P IRQ_TYPE_LEVEL_HIGH>;
+	};
 };
 
 #include "t8015-pmgr.dtsi"

-- 
2.51.0


