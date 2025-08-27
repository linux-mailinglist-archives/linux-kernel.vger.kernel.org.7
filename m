Return-Path: <linux-kernel+bounces-788473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D68BCB38514
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 16:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 039A97C7F39
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 14:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B921FCFEF;
	Wed, 27 Aug 2025 14:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JVdAXgtK"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903B21C4A2D;
	Wed, 27 Aug 2025 14:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756305307; cv=none; b=Ez0nJaahoKvdWVae+kJiQ1DpGj8TvjA03YrNqjZQAdMI6orvvLGnLJmplYsvNJN8PjL7Lw4U7etK2oS91hmcy5dz+NRp02lhCeA6H+WQI/jKVpTXcrQiK3fdWjCbiT4SLxOn2M5jvY86ki8yYsHqb/12ikHCcp51LF0VqDSk8iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756305307; c=relaxed/simple;
	bh=xJpjm8hurGVZiyhrrXJYAHFNPyJ/Hf2WzKuycTUqhwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AVvJD+H0k99kZPiVGZ3waCXTM+TDnJOHetRtfm9sem6rzCszPQQE2IfpYfDm2uhLPVFNE5kOVBtV74XUN8GsmYfVhsB2JYpKMWGV188rZx5olW8ST3eJ2Xn9XUTUnYTbCmume8jLpts79dKE6kD6JZkzPQL93bYY2CQoQ+yvXWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JVdAXgtK; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45a20c51c40so53359295e9.3;
        Wed, 27 Aug 2025 07:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756305304; x=1756910104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F1BUyJVLso5e3sw9oVrEXxJTuPzZqZWk1jkcADSRdMY=;
        b=JVdAXgtKvt21ladUnNJBCRzifiaWYg7FbZWWOpmhZ51xcVXMEDLFxJsql08H4U7A1h
         5NNBqHexqKdjAuS9FBYFLCLxo/v3+ZgU/8Qh0jggOwL+gbcpUWzOD3+m6WtcDPWq21nK
         lv7EV063NwYQNg65JHRvgx7oWp5aET94kAlo7eGsrtKvdj1J/AevQ7lAW34rKWL6J3Nx
         T32bibPvSMvjGELa1D/U5a5mfGhdGP6AS7VbdOQbqCyKdoV0nBl2Fk1N1efY5EMnDhLL
         vK39V+p/NY1vzNSlfPKr9rfNXS7VVhpYDI9ca+my7gFABo8/Q+HyMVmuevmMPax+0G9b
         tiEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756305304; x=1756910104;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F1BUyJVLso5e3sw9oVrEXxJTuPzZqZWk1jkcADSRdMY=;
        b=RGQvXhi/p/tee/D8/LV9NA0MTXuSCenHB6PCGHxL2KM1VZ5Shv5ENuYjbqNbfBghSq
         vGZ2useB3qGG0dOkB0dr+O4KoHnDVTTxatK/y8nHHcrt18iaUe6Piot2IGqVti6TrU2Z
         9fNjFPLFnZ63zljcCZ8tfeIZYN23kCAikRGhFX26guEgTbHF72zuwWCDu6+sG62gWSDE
         XE4F4QH30qTRfkC1o4yC0xzefNmDth6a6Obhqs095htYX2GV+urARtP1F4OaocL/x5a6
         bdhoYw3lo+YKAC1hunXDFZgpapoJ3SJ0jTq7oSxv1PzJsG6qoNgpEkAI8yEkOLztv1tQ
         b2aQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOhmaHaYhPpa+u9HOEy5l4bGkT1+TgF9UCAUWEw/WY2qCsw1ORPWvDCO4AdQolONPmeFqVJj05+IOu@vger.kernel.org, AJvYcCXTtRjwjCYnbD45J+mVMXagaYmZwZO/NuKGPcPqMWkEJUVFGUaWTrszLKZPeSEW8l78bys+1AxS1iIV3hpo@vger.kernel.org
X-Gm-Message-State: AOJu0YxlpxnACDjyyJR4AP339x5gHAsKK27SQOe45b6KFjydLMRDu4+8
	arnEE2wh0uWEgEG1moYOzGRlacA719JaJ8DesSB3SUmnN1kbcbqvvicn
X-Gm-Gg: ASbGncskCTAZB3EBXdeLDAkGE/9kpt5nRW/g3Vz547L66OjrVGRWKzME0+E8kpTU8oj
	lharlKCbLGR3o0e0gOcV/pDwPfCom0nNM6piRw4faPHMxMJLp3UUJWxaQ5zuSEnHdj1fiVY8Mus
	bVKSaLM/hnloFE3tuh8s64RHMSD/qoC3LKrYh05OT2HoDDqygKXLTR2sDouZ7CMlFsKnOFJsVhD
	sY9MMM0o9YOItOqLkEJTB1Mdzdof1HcqtMyTwVLi+t7ZSa3pi5Ry4/KNkuEA+mXrFqa0JhJXP/u
	gZ3arvJD5/C5AoYLckLNb5SRlrl5DzZWyu4F6rr1XYqB7gI2Qv0s6ryqlu9Jmsf74T7luWzSXsc
	giHLlyQpqC3X5x7k5vxo1B9p4d0NZfHDxigmTKEbS8W0/2navj357N0LAM1nVyHqiH2cQ+K264q
	hUBMd2lRfk3uJW+DAlrWm/iCUKFTVP+ijZP9BLXWxfT8jX2wqCrhcJPECx33CezWA=
X-Google-Smtp-Source: AGHT+IGkKJ1XhDqK4M+m0K4FkEys/uX4rfEbc6c/Gcwva4PyVBgFs99pGKTiljPLXjMWH46PmsM14Q==
X-Received: by 2002:a5d:5d08:0:b0:3c5:20d3:6041 with SMTP id ffacd0b85a97d-3c5dc54071emr16944872f8f.41.1756305303612;
        Wed, 27 Aug 2025 07:35:03 -0700 (PDT)
Received: from cypher.home.roving-it.com (7.9.7.f.b.1.3.0.b.8.f.0.9.e.0.0.1.8.6.2.1.1.b.f.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:fb11:2681:e9:f8b:31b:f797])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3c70e4ba046sm22750178f8f.1.2025.08.27.07.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 07:35:03 -0700 (PDT)
From: Peter Robinson <pbrobinson@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Diederik de Haas <didi.debian@cknow.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Dragan Simic <dsimic@manjaro.org>,
	Ondrej Jirman <megi@xff.cz>
Cc: Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH] arm64: dts: rockchip: Add vcc-supply to SPI flash on Pinephone Pro
Date: Wed, 27 Aug 2025 15:34:58 +0100
Message-ID: <20250827143501.1646163-1-pbrobinson@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As documented in the PinephonePro-Schematic-V1.0-20211127.pdf,
page 11, the SPI Flash's VCC pin is connected to VCC_1V8 power
source. This fixes the following warning:

  spi-nor spi1.0: supply vcc not found, using dummy regulator

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
index be90e049a302c..24e4365a2e588 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
@@ -772,6 +772,7 @@ flash@0 {
 		compatible = "jedec,spi-nor";
 		reg = <0>;
 		spi-max-frequency = <10000000>;
+		vcc-supply = <&vcc_1v8>;
 	};
 };
 
-- 
2.51.0


