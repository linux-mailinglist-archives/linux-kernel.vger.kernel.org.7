Return-Path: <linux-kernel+bounces-888858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE52C3C0FE
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 16:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EA71D4E4907
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 15:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D57030DEAC;
	Thu,  6 Nov 2025 15:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arduino.cc header.i=@arduino.cc header.b="JS3CCsCE"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927C629E0E9
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 15:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762443092; cv=none; b=lyF9/biTez0lQbJEmFaOeQGFw1hiLXhWYvTtX3s5yDFXPz3n8RThnI3hKI/hxb4mruVonGMCOvyPdTRIh5qf/uYxx9eFjbiKU48F473THyVlgSs5BRBbqzJ1qTiN6CfFBsvCp2qoFTaiP3xj9mCElS/MEH8ZD9nuKPhqlWww3zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762443092; c=relaxed/simple;
	bh=nFTMiixlNvRzTbq7OpBGOyWd3t8zjaGziikj/c4xkbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XiUM3d8yaH8zCNYbcjyiy9zAJR+G4VDwHdzK4o0MGjVohzM/I2P59RS9M8gI5mHiI/4PecwIQRx/lxN2jU7tOo8MTxtWDmNf2IPGRlF2S6S4n5v/81v6CZT0n58wzqxAs+cwANJftD/Bh7I/ghIv4PuW9t+rzzuIp3Kkjt5Z0x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arduino.cc; spf=pass smtp.mailfrom=arduino.cc; dkim=pass (1024-bit key) header.d=arduino.cc header.i=@arduino.cc header.b=JS3CCsCE; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arduino.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arduino.cc
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-429cf861327so859004f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 07:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arduino.cc; s=google; t=1762443087; x=1763047887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GDJBjo0tk19MxLFIW+Axiq3QKZE3M5MjCU5GisKJEXQ=;
        b=JS3CCsCErJMWwevyobg0lxKdWUylGvqCGp6BmIqO8HOmVSe4JNASTi+TN+VWD3oPWA
         vxyJGFCT6jpmj6q19Z465yO5VR2/kbtR4uzr5ui20Jbw9/AnaP6YG0hs8RnZGcnJU8fK
         OOYP254loNWu7pfHLrKSWlvm21ooFBMYRlvS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762443087; x=1763047887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GDJBjo0tk19MxLFIW+Axiq3QKZE3M5MjCU5GisKJEXQ=;
        b=mA7pWqR5B8xN1c6mqO/fXznSzpj1JOIxmPYRvJWgBJ8kl1a1OTOpfPlgYj8Ps0aM/6
         uy7qfK5Nu/sypd1jazz1qTB2QTLCE/n7V8QurrCa0jV0lzYbogeYKGvEbwiHE9GUS+JF
         VTRe2YTkOkDt0832F3q0KuXv4Go34J1CFxjsWzKEG+tmODUgOSWwCd75E1VMP6lehih+
         2ussRd/bwDPJghXXr9WrnnZ2eMKMBDiLpPG2INMqoE9AkkzTmuH+Fg5IgB8kB11eWa4x
         8o13DBjebM689S2ZxZChpHbXRGgykb67RCB/9QLMXZ3OzHAsPGNf3RIFgh5vVneDRukd
         jcpg==
X-Forwarded-Encrypted: i=1; AJvYcCUsl5zBhccFaAP5Z5y6kphKEH8HeqHuxyoV3D8kjUco9AYxs58bRf6mwdVjxxIUQwk7x9Km8v6vaj+M3UM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBL5ziuASdUwxSDDm3h45IirZrMOAjFBDDgoXmMOvQrZVOIypB
	uz7toUTvkPTg84vFxfJQexRCqbRR2pvPJswNiFiyQFFiy6NK6BHj2Sffipf2iGh9S6k=
X-Gm-Gg: ASbGncvoxziJ6ZnjqgAKs6Pd+DZVJ186OE8nHvD6KK10+uwH2B9zM6a1kvBh1aphO6Z
	ctR4R0eXI+bKhZ1lHnOqit5L3du3DOY5LWb0hdRsAoniyqytAAYhfhVqQdqzSMhZ2q99oYHHHE5
	N9ARg4JB8wQZpRPzf09E26tMrvXXQaPMGM8V1EF/bnDZtljFizzLAj3ZposBSNdpBjVshAG8tir
	dBNJRNEUPJWZN+oaPNJJ+JMYk30+Wz39jJ3/NDEQpoOysUK0lO9HocBcIFZwCHIRzedZG5C8pee
	nMUpL0JbvVtIjLp1AK9Orf26//Hdzj8rOKB6K88sCAINl8SZjc7GtlUY2H2bM8Y4RcT3oCcs8fG
	7uUHh5+oQk77WL72qWy9ApgQmOoVYTJjaPX+dR6Y0pNW5dee2RCnYzt0cs+UjlE7lxRIZBgeRx5
	/mJeNN+sJzPpw0F2QG3tkeE9BD
X-Google-Smtp-Source: AGHT+IHCZAr95mKcE9yjFtJyCN1KyzbJ3I4nTiFSTQevwcerBzM8hslgjP0KyUU+ToTYxmAmb25Lmw==
X-Received: by 2002:a05:6000:310d:b0:429:c5b1:5c63 with SMTP id ffacd0b85a97d-429e3337679mr6689753f8f.61.1762443087151;
        Thu, 06 Nov 2025 07:31:27 -0800 (PST)
Received: from riccardo-work (public.toolboxoffice.it. [213.215.163.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb49a079sm5966719f8f.32.2025.11.06.07.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 07:31:26 -0800 (PST)
From: Riccardo Mereu <r.mereu.kernel@arduino.cc>
X-Google-Original-From: Riccardo Mereu <r.mereu@arduino.cc>
To: andersson@kernel.org,
	konradybcio@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	broonie@kernel.org
Cc: linux@roeck-us.net,
	Jonathan.Cameron@huawei.com,
	wenswang@yeah.net,
	naresh.solanki@9elements.com,
	michal.simek@amd.com,
	nuno.sa@analog.com,
	chou.cosmo@gmail.com,
	grantpeltier93@gmail.com,
	eajames@linux.ibm.com,
	farouk.bouabid@cherry.de,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org,
	mm.facchin@arduino.cc,
	Riccardo Mereu <r.mereu@arduino.cc>
Subject: [PATCH 4/5] arm64: dts: qcom: qcm2290: add uart2 node
Date: Thu,  6 Nov 2025 16:31:18 +0100
Message-ID: <20251106153119.266840-5-r.mereu@arduino.cc>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251106153119.266840-1-r.mereu@arduino.cc>
References: <20251106153119.266840-1-r.mereu@arduino.cc>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

uart2 is used in Arduino UnoQ as an interface between microprocessor and
microcontroller.

Signed-off-by: Riccardo Mereu <r.mereu@arduino.cc>
---
 arch/arm64/boot/dts/qcom/agatti.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/agatti.dtsi b/arch/arm64/boot/dts/qcom/agatti.dtsi
index 8bf5c5583fc2..32d58e66f57d 100644
--- a/arch/arm64/boot/dts/qcom/agatti.dtsi
+++ b/arch/arm64/boot/dts/qcom/agatti.dtsi
@@ -562,6 +562,13 @@ qup_uart1_default: qup-uart1-default-state {
 				bias-disable;
 			};
 
+			qup_uart2_default: qup-uart2-default-state {
+				pins = "gpio6", "gpio7", "gpio71", "gpio80";
+				function = "qup2";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
 			qup_uart3_default: qup-uart3-default-state {
 				pins = "gpio8", "gpio9", "gpio10", "gpio11";
 				function = "qup3";
@@ -1315,6 +1322,23 @@ &qup_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
 				status = "disabled";
 			};
 
+			uart2: serial@4a88000 {
+                                compatible = "qcom,geni-uart";
+                                reg = <0x0 0x04a88000 0x0 0x4000>;
+                                interrupts = <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>;
+                                clocks = <&gcc GCC_QUPV3_WRAP0_S2_CLK>;
+                                clock-names = "se";
+                                pinctrl-0 = <&qup_uart2_default>;
+                                pinctrl-names = "default";
+                                interconnects = <&qup_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+                                                 &qup_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+                                                <&bimc MASTER_APPSS_PROC RPM_ALWAYS_TAG
+                                                 &config_noc MASTER_APPSS_PROC RPM_ALWAYS_TAG>;
+                                interconnect-names = "qup-core",
+                                                     "qup-config";
+                                status = "disabled";
+                        };
+
 			i2c3: i2c@4a8c000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0x0 0x04a8c000 0x0 0x4000>;
-- 
2.51.2


