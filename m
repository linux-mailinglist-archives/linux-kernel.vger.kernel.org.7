Return-Path: <linux-kernel+bounces-888857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D430C3C1AE
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 16:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B20433AEE31
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 15:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B17E289E06;
	Thu,  6 Nov 2025 15:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arduino.cc header.i=@arduino.cc header.b="CxGpMew1"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB5429B789
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 15:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762443090; cv=none; b=nqRk+cW/ZjbfZhI6G2SS/JNV3xAcoiJZHR6/yNrvi0rFM4Qoo+0ltqbahiA3R58FHuPDIaJFb1IcNaIVglyo2XBqknOBmxbo1A7i3NeP6V4uHkDhoF5oFtW7S9tQmg/ePed49adbmLaZS7a6mijvtWD6JHT49IJIdW1i00Bl9/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762443090; c=relaxed/simple;
	bh=d46gMm7iAqkq5ja/k89Jqo7GJI5rgDOyd5tUdQbUG1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mV4XU9QuA/vUut7CjMxsGoAfR1CzyaLht/B3YNhsW06s67zGe4hmgH0+58g9+0wragNEAb53XZubNXy4XkepYdcT2fIIE70CYpgZIH6wo6zmTq4CjrQqNSP+OrLEzfsG4fgpN9lSLYFrYPvAqwGaniEnGq3Kz+D+sGCBfP5aKlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arduino.cc; spf=pass smtp.mailfrom=arduino.cc; dkim=pass (1024-bit key) header.d=arduino.cc header.i=@arduino.cc header.b=CxGpMew1; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arduino.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arduino.cc
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-429bcddad32so849054f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 07:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arduino.cc; s=google; t=1762443086; x=1763047886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NaXeZHBypXQ9AI6NR5KHVtefsgfrl7pnV/7arSANDLQ=;
        b=CxGpMew1KMsN98nuVQsyY87ch6ieaQFk4IdU/auNxZQ+3Vdr/xDHwSjwBm1kwA0SGV
         rIXs1dXXsRN/XSbYwzsLcZF2vMmS1/uo18bHtz6F8NfEyJ/LIOUW9qmuuO9R+eHk+8FR
         NJuzYCGDYqx79pL2wV9A8mKbq2B9yvXF2Tygs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762443086; x=1763047886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NaXeZHBypXQ9AI6NR5KHVtefsgfrl7pnV/7arSANDLQ=;
        b=HzJlOVXk2l+njR5Pu+p8pFqwbcl38Ly21yFU9x/32/j8spTItxbv3O9jrnorMwj09g
         cfZoOCagvRDhfZegteD0at0B49OABgq/8egcMqjeoOSUHzzcDja+BLWvR3gJ2E1BhG4Z
         GaGpMaOckQu0HltsWVatDu7+XKefinNVIZCSyDrVNzoUsF2BUedbWsmtwHEmBjMwH+hz
         SBpQzZK3l1C7Do3zy2kB0cjAlGBE8vOpBzM2SXGkmmAUzEM58N+O01d7R49ArKsgZXqX
         oTh4HsE/F5H/sGE2TuWHpaDiG7MkODsprSarThN878sjBF7s5UXG2p+FBMctz64dnkIi
         sVBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpCBsjR8x+vs/idzU7MmrW04sjFthr5RQPZwEgSP+7UBVn4pTGrga5o7kbH9YUAUg4mLf5ejdkSdBnZ2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMjwpShLHrY+hTiJx0wxLmwK6ihZcVR/K0ZzhltfDjT6H7XNpR
	rcxq996HwYD5B3APCcyBHV1BLN2OY8CNthr3/drh1OcCk3zZKKwH2ONK+gnchqlNbaU=
X-Gm-Gg: ASbGncuuknOXyAX0/kH5W8r8jIy0atvD9c/S9RVnLGOept7KaOSyJUco23rNwixvQre
	eOUspLCX1rDrip6scMdTqyIBL9OYR9fPeE6iO2WD0bbKiDvfJ5OmyIKtDKNWPh5YDwqdwc1qyoS
	sLT51f0GsDP4tqwfdCfvp3AnW/myq5CfVT6ZN5DLJtbpB+sRnoQoEkRNDcu6ZPCMXDRUOw0VY8S
	UzoetmTLwyX6kv67ohXkRNGk+r104F18XS2nTLtNAorDcGTZrI2f/yz+IKmSEcd0zOiygpphVmV
	k6itcTej9o29z0cJugL3YYQBw8qeMGJd6GOYvH4q7l0S7ks6E3d1RYGnO8gNjJeTSNBxSkfcv9T
	TOlSxIP3/8+Y4DaT/ixhkBnfPrGYbHtbCaF90sEvKzRw6TYvTaHhjz+afm6LDmaSzeOz3fCGBHS
	DzUjDg4w0zt9gr5nTv5DZMlld7
X-Google-Smtp-Source: AGHT+IFyU9B6PrVivm8Ey9C3gGeg3vLDWayLnp/yQBozk7q8OZ+iEgdw4cIjtCmIUPVOhruID2h90w==
X-Received: by 2002:a05:6000:647:b0:427:6c6:4e31 with SMTP id ffacd0b85a97d-429e32e43e3mr7999624f8f.22.1762443086154;
        Thu, 06 Nov 2025 07:31:26 -0800 (PST)
Received: from riccardo-work (public.toolboxoffice.it. [213.215.163.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb49a079sm5966719f8f.32.2025.11.06.07.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 07:31:25 -0800 (PST)
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
	Riccardo Mereu <r.mereu.kernel@arduino.cc>,
	Riccardo Mereu <r.mereu@arduino.cc>
Subject: [PATCH 3/5] dt-binding: arm: qcom: add arduino unoq codename
Date: Thu,  6 Nov 2025 16:31:17 +0100
Message-ID: <20251106153119.266840-4-r.mereu@arduino.cc>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251106153119.266840-1-r.mereu@arduino.cc>
References: <20251106153119.266840-1-r.mereu@arduino.cc>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Riccardo Mereu <r.mereu.kernel@arduino.cc>

Document Arduino UnoQ. Arduino UnoQ is a single-board computer
combining Qualcomm Dragonwing™ QRB2210 microprocessor with
STMicroelectronics STM32U585 microcontroller.

Signed-off-by: Riccardo Mereu <r.mereu@arduino.cc>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index d84bd3bca201..1af19245b1d5 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -336,6 +336,7 @@ properties:
       - description: Qualcomm Technologies, Inc. Robotics RB1
         items:
           - enum:
+              - arduino,imola
               - qcom,qrb2210-rb1
           - const: qcom,qrb2210
           - const: qcom,qcm2290
-- 
2.51.2


