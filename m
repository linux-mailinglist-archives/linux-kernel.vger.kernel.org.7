Return-Path: <linux-kernel+bounces-751278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A820B16731
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 21:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF9D77AD6A1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253AC21019C;
	Wed, 30 Jul 2025 19:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f0zcxdA9"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C746F20485B
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 19:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753905192; cv=none; b=jtSSFnqIbVa7cRkOHj6msZL+A/8N6ROEg8ad2X50a24M9F7VSDkZNbUlsbpjnofAQwweZuJ0jNJ6AX40MLH8YdNkjPICEQyhBVBDw4L2kC+8yPpglp8+Pz3SUPW4MH2HBcDDUGo3imIHwhXxT0FCDzM06sS9EfvJW/OycY0E9m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753905192; c=relaxed/simple;
	bh=kidXAy0mvcs3fegsiwVQUUCUIiIdfC0KACC45Gf8Baw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lQm43bJ3/wFwAwJJAEpLTE+u85OBSjCwwOXy0JgzxLoCdVP/SQm4yru178y/ttUqQhJOGYAwkpLFzEik4X8wykyv3ZlneATQV1rrESENPM1kJN9tPsC9+XwN7TmZ6Hf112AfFMckNafM2Y6AKvxmMWpZzMYWOFimUc1yIm6+sWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f0zcxdA9; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b783ea5014so119738f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 12:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753905189; x=1754509989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fIjCGhz8tLixz44uwO4xKNvBCCKp5RNzQO4yWFCNcHo=;
        b=f0zcxdA9b2sFZZlciMhAPj/Np4oRpiT5aay/ELvuwwmfe0IdPKTfelXPyUyZMmKXfC
         YwW+WBRYJBT48pBoZ6GTC6ajfwWlUiCkDeFKneTNNr+geDEw+luECt16pt9dPykRtMJw
         apbO+l2FXAzh1S3KNmtmevZJ/3OBabCU35+dEAkpLtqsJ+ibOEp5+AmX8fGLDFSA3TLn
         jMcWagbHNcdvYRpge2qmTBP1p2k0W4kyRYjM0CSa+5q3FszbzMTXzKMVxNDIZff4rPWV
         3Fha8H3+2XxOykE3+nSlKNdcHWX/GKStsJDRKOlszDfVuBiO7W0PLNbBCST0zy/O5C3A
         Tlyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753905189; x=1754509989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fIjCGhz8tLixz44uwO4xKNvBCCKp5RNzQO4yWFCNcHo=;
        b=lwtG4sW0hPEpPTCbyPmckH1lSetW66ZQ72I7JNHwu4Rer6Smoudgy9cbJCYaLqqXHb
         uU5CC9NQj9+SftvG8pi9T/ewulB5O1EBcovjKevKWzqlN8pGwF/q+59dDy0EsnhvMPhQ
         Ao/LlwNqAllLNkW7CJMipEqZnYo/ZWh/32Z5yH4cB8fe2zB/e8DhebsDtBsgb7BEbTiN
         VUlop+jncd0Ht9Q7mkRDafLsyRla3M+c6/FbgCYDkgCxb+3pbLN4rOFuh0/zNIFRNV1T
         UAG17ANy6P4HTcuVdW5a7GmnlY2UTT4gPJfC/fhwBQa3aeIGJZvNJILOuM3fi7vEr8on
         hNKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFuz3KtzzqoD6rgaEOlO4sAM5xrNRljmcYPP7bgBm1JYMtJHHyc5xM3B+3Zi+wus7XCKJh6qfAwo9pSlM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo6HmKTWsHVxiacX0356RMLP7JIhNag+3U43P5+OflT9ErfDOn
	b+ICOefhpaxgNObFyfoSkgxyz6p+hpekpmJsm32K0J+JlLf+76qVIGYvtd7FLR29bN0=
X-Gm-Gg: ASbGncslbwgxTUA4+meTgqY/3RKUhb9x3qh1qXXhGFbwcJxrTUU3vuT7clTGBH6WcKv
	sjDOAR5/XQvHOAcjkiZgDkHkutE0uLxdU1bpXNKAY2AKZWMwle0iV496AWHwFLMy6ljN1R+LgD+
	SpgXc0b3liv49soS4VWCDi+2b5/VniDbo4m7crPXYHj3iB4kv0taszZkqQT+VQZSw+z8n8vSGUx
	61VFLmXDijcnssl78NItmzf8Nh2FUFFL2GZHaDBIVSTKVx48O3x9OfPxQz4zEWDbHdR37ZQPP8z
	38LJ+Bl8I3yTVSoxiWIMOkMUt/Up6VQ0w3D8gVP8UHvGIyyBeEaj02VN/Iw9norAUaT13z/UpsW
	aroI+84nhg02/SDRMScyzfAeZRFoJRby2/O51S1ekFNule/+s
X-Google-Smtp-Source: AGHT+IEmsYHO0oNTJZYruShh/TW9R20EpAqhA//OGFPfdlNYdNfaTg5M72i1uh4bkKDQ8O6mJZ4IOg==
X-Received: by 2002:a5d:54cb:0:b0:3b7:889e:2b2b with SMTP id ffacd0b85a97d-3b795010da3mr2683397f8f.47.1753905189071;
        Wed, 30 Jul 2025 12:53:09 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b78b26a4dcsm9556193f8f.32.2025.07.30.12.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 12:53:08 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: mbrugger@suse.com,
	chester62515@gmail.com,
	ghennadi.procopciuc@oss.nxp.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de
Cc: s32@nxp.com,
	kernel@pengutronix.de,
	festevam@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
	Thomas Fossati <thomas.fossati@linaro.org>
Subject: [PATCH 6/8] arm64: dts: s32g274-rd2: Enable the SWT watchdog
Date: Wed, 30 Jul 2025 21:50:19 +0200
Message-ID: <20250730195022.449894-7-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730195022.449894-1-daniel.lezcano@linaro.org>
References: <20250730195022.449894-1-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SWT0 is directly connected to the reset line and only one instance
is useful for its purpose. Let's enable it for the s32g274-rd2.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
Cc: Thomas Fossati <thomas.fossati@linaro.org>
---
 arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts b/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
index 505776d19151..4f58be68c818 100644
--- a/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
+++ b/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
@@ -56,6 +56,10 @@ &stm3 {
 	status = "okay";
 };
 
+&swt0 {
+	status = "okay";
+};
+
 &usdhc0 {
 	pinctrl-names = "default", "state_100mhz", "state_200mhz";
 	pinctrl-0 = <&pinctrl_usdhc0>;
-- 
2.43.0


