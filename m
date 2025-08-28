Return-Path: <linux-kernel+bounces-790408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F1DB3A6B2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 18:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9929A1661C1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 16:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D10326D50;
	Thu, 28 Aug 2025 16:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPRMtuCD"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321F4322C7A;
	Thu, 28 Aug 2025 16:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756399387; cv=none; b=aBVIpWHbWcoOIRjRAkLQnPuES5iMWSQx80TvxRHJadxqmveenUr/VFtPRf2VPz/rrETwmv0xRaTyVRPOt6pe85tXHdfKtjGpCBW9/xbbsbKa0yRSw1eTvOtmgMqInoK3kJf4wYHLFm6HD9uWJNFIlkwElwhJCM3eyrT/zEk8/zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756399387; c=relaxed/simple;
	bh=WKQ/xtRS/9A7ZGftlrzoXfl01ZUnmFCsUW8TVKUVE78=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g8GUg+SVVXIMLvBJckgOJD6WdUmuB6jVmc3S0rhJBaPQvRW2za3y1o/bklrQaBQP9KMRx66UOzhhpF4Qm5AoM1q0qRu55cS4gUS7iU+RS9ONid6QS1u/+TCgyKDVTU/j+t4fYmZkRzO32NGaB00vfCI3J/UrHA0IWXUf9l3Y7mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fPRMtuCD; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3c7edd71bbfso842726f8f.0;
        Thu, 28 Aug 2025 09:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756399384; x=1757004184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kmiVUhRavRhbmTQQVKaXaG+VoM+x59cj+sqorjef2E0=;
        b=fPRMtuCDXPsXAD6cEMmUttMycJNe1zYQuyoK+xVvgtlqptjMleOP1iuRhga456XPaA
         IAinFZNyGgU25dhmVh8euVk59gwt3Bry39h+pgji+lMhVTABmwZ3g1KHZJ16iZD0Pnf4
         nZ2X9VmrhJfDrejT0ogDAgrnARHPfZSJirJdvX9NApcwYplxpwbdPV7VSlPLODKOzrJs
         0llmF74b4WR8k4hECYYV6zdEz/PRm0ehFpV2xOdbMzHDcrdmBWrpvuorMFjjtrOwtZWN
         zQjyeIrpqX2VzsmoOBjaKuhQvFkkys04hPi1CD/WPplkHhvBWNvbFKfjpBMKLkNqYYyC
         hLCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756399384; x=1757004184;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kmiVUhRavRhbmTQQVKaXaG+VoM+x59cj+sqorjef2E0=;
        b=ILhKJwyAKCybiNNVsJuXem5Vl9G1MnHnZZIf5oDXMbv4d2rOP3AcaJNTchVXwG6Hdq
         dL5stT65yu5tFHcPy0ezJtuYSAU5kVb8231cn0xfsu7U2mB/dc6OyenvV+1uh9MRUsgi
         coqAnC1ms0ApAf6A3kiwGdgI/G7f8OG24wTlVM+g+keJrAoUkbs7BYPFoPzyMpUlCkes
         lDZGAmCI/qcptoeDsqV2lgBWyjjVSSF6dLf4+8t5sw8vNBNcAUC+lNPZEZSbx5An6YBE
         /jF3/GHn4gwbBVeWPF/tSfdyKm3bykBTL/0M+j3f8j4IccyGlaohxwHMA4oC5RhtlPqF
         Jv3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUyjVquIo08RELdW9njbLafHGsqiD9EMUNYV4whlM1rX2MADxhUUN/sFLX54LBaTQfOKWrydio3lNYR@vger.kernel.org, AJvYcCWzFmWS7vzAvwUao0sQEMs927j2jO9atlYTI94s0tVgZsnt9IGHFyXIkSK7j3TooFsdtO3b3z7K4E3w7PUa@vger.kernel.org
X-Gm-Message-State: AOJu0YzX26Athk/3yVmY7ucE85Zn911a3XefAw+AOKwe7mzX4TnSLN+c
	T3fcGOAHDJ+cPvBn7D8noLCjaAMNfQS5oBvvW0tKd260U/hNJkFcL6+M
X-Gm-Gg: ASbGnctX4aTfhoFn3UYktqHkbs569B3jSPVWrSs6siBUyDYhwTcLuM2PWT4qufCUZB8
	BMlKx+9BYqy0rqNqiCQEk8zd7rDpFJbn3EWcm/HiXTjqM7phwusaRMSZhFC8gTJT6xaKfHKfJot
	+2MtETbnBvE/KjTqHJRgPNf0ZmYjfhURU2l1SPZDj30qqRXgzwqnjWYAdMRRbwGsVaH/ZI9PSev
	ylA7LA0lU9dHUoBYEGLCwzHcyDqWs7dT+0aCdzeyrPbUVveFkNs+YR5C2svsWuzlCLhC5qrzjfq
	zcBJFPZfUSiRVC3YoDjbs7TbRo7K5Y3SZvE/eqfN/bfHxHr72P0/HsM59Knx3sDVny3IlEXejjP
	Wr4TyaUClZGs0AJAOEMwKno6sTV+DRkkATIh7Pw==
X-Google-Smtp-Source: AGHT+IGZ1oHvbw7/WV61DeDUCKQxNQm0uGXVNfsfYJqhufPLLEDZwzYCkoecNuE41vbu/p9STOdVJQ==
X-Received: by 2002:a05:6000:18a6:b0:3c8:63bf:4681 with SMTP id ffacd0b85a97d-3c863bf489fmr14282744f8f.54.1756399384355;
        Thu, 28 Aug 2025 09:43:04 -0700 (PDT)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c711211cabsm26033204f8f.32.2025.08.28.09.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 09:43:03 -0700 (PDT)
From: Christian Hewitt <christianshewitt@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Alex Bee <knaerzche@gmail.com>
Subject: [PATCH] arm64: dts: rockchip: add SPDIF audio to Beelink A1
Date: Thu, 28 Aug 2025 16:43:00 +0000
Message-Id: <20250828164300.3829488-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Bee <knaerzche@gmail.com>

Add the required nodes to enable SPDIF audio output on
the Beelink A1 set-top-box.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3328-a1.dts | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-a1.dts b/arch/arm64/boot/dts/rockchip/rk3328-a1.dts
index f7c4578865c5..b276a29bdd85 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-a1.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-a1.dts
@@ -58,6 +58,24 @@ ir-receiver {
 		gpios = <&gpio2 RK_PA2 GPIO_ACTIVE_LOW>;
 		linux,rc-map-name = "rc-beelink-gs1";
 	};
+
+	spdif_sound: spdif-sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "SPDIF";
+
+		simple-audio-card,cpu {
+			sound-dai = <&spdif>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&spdif_dit>;
+		};
+	};
+
+	spdif_dit: spdif-dit {
+		compatible = "linux,spdif-dit";
+		#sound-dai-cells = <0>;
+	};
 };
 
 &analog_sound {
@@ -325,6 +343,11 @@ &sdmmc {
 	status = "okay";
 };
 
+&spdif {
+	pinctrl-0 = <&spdifm0_tx>;
+	status = "okay";
+};
+
 &tsadc {
 	rockchip,hw-tshut-mode = <0>;
 	rockchip,hw-tshut-polarity = <0>;
-- 
2.34.1


