Return-Path: <linux-kernel+bounces-751276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD78B1672B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 21:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC4257A392C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA46022126B;
	Wed, 30 Jul 2025 19:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H6HbuqjZ"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444E721B9FF
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 19:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753905190; cv=none; b=DwIuApy41O8HlS120F32IE2XXNMS5zqhQW53nUE+QSkgjb/+okI7GDBsGdm4gMX8tb4O/sa+ngVD9VheJh3mi02+QoHfqad1zD4mujKgnPASCYQoYgYoGpxxZtmlC6afF4q4rA4S6WCd4TBqkw9h+D1KcnF/hAM6hMi8bsxLs1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753905190; c=relaxed/simple;
	bh=68r7hd0pYMiUK/yXAM7DDOhRILor97PK5YEExmDMI9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i7K/ouaoglI9HxkAPRJA9fC0ZOgSrz3xuozO6w3kYReeciIDMfXJIsvKIEzo++Fqun1AAw0EKJsx/6pFKRsJQDMpl1ISybHxP97WdTFm+CfY+GmwnOKaTrGDqYMjDwSK5I2imotVLGINrPET8tCoxIqHSMVBTBnQHbwNxZNrzJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H6HbuqjZ; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3b78a034f17so131959f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 12:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753905186; x=1754509986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fbQUcocXM6VHyJ4FeiW0D1YCdpoLynB31hIqBFpFpXo=;
        b=H6HbuqjZ9GE/48kYLSuQVq62XsdGJPoXcPO48jLGb0wyMUzo2vzFtFfSBVd0ktmr7t
         EsGnAuvquLA0raW7Elp6oX2Xo1qhTaouAd2iNy+/YQDutEaoNbe+0SNeyKjpGEBwjESU
         SJQnnKieVLuI1pOA1XQnewKwfq6qJVN+f0gizREuVB59nmn5Xy2fXlJ3nfBQ8KZoZ1xA
         eb1aNI1XMLs/Wt74Tsc4qZx6vbkjhOtWBg6Fi8u8DLugFmwvWWChxBacDKdXHzt3H72H
         pgHDwgqOq91tfUdwUbwYGFXwTbEeeCC5mQ/hvEZ0GhlXJ5CiKi0SEBI2Mwdo53szBzFk
         5XxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753905186; x=1754509986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fbQUcocXM6VHyJ4FeiW0D1YCdpoLynB31hIqBFpFpXo=;
        b=SSbA/tjLQRShxFUZd7EOok1+KC5S3GJY8nQs6vI4Y/E+jXX1Usl2rwuQyeAY5tRqO0
         vwHLSI5nhTHL+L/r79WkATKLxU70alOKzK/kogqimgKvCSNyduo9TehB6atKx9ONI9n0
         JCogoaEzCNNT8cv0+tHHWK7+llCEPfJLq9/wb0jofxAbvDMjhut2VqIp31bzyQGpRW++
         5HWzyBSbCR2zmqQiFSHxc/JSRkR9T1SluTlMBuRat97BTx1I+YTOlLxJvzIpXiPRk0//
         ZiqX/km8NIT74dvjXEP2EDjKY0Z7Ptifbkx9CKRWcJ9YK3xuNlrjw06kHP1EZadcvLZP
         GZbA==
X-Forwarded-Encrypted: i=1; AJvYcCWJWBy+n76w98n/WMx9F2PlXUAtK6+7AvJutItjDBnUnx/sQDvnu5zt/QsOVS5UHam25eL3nMOM0A35lxY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyymln0FqARNJvARwIBZSWxrzYD4EHZ3jVnTufkHxrrjRhZN57S
	DZ6a/mM2aqcGdZccMQMROCSV9fQuYZw0liujRkGzt78o9qXZMw3a//hMadDu378gKqQ=
X-Gm-Gg: ASbGncveAph9ib/KTG2Fdc8HXzXk0ViICT9frh5S8Kv4zPM4Vag2CvqSAYS1vt4nQbd
	mdPVlFCbZqDS2s/8aN6vD1lRhJ0jfgdhC5A4wSrTo1vbDS40WbhGAeTs56dJ8KpvaJY03nCIBaD
	YxHEVsWLYCQfAW/m3QpkHW8xp+zPRo4tdDTTpZm3xizmLWbmEOXC1iK+0gFLklmcdjsGJlG6f7i
	qp6uieW4OCVAhboE748y9kNTS51znNUgqylotE7JKT3JhHhCERi4mNMrQkbYV2Z5Equo0M3inGB
	7IsyXPtRglaKmS6q3Ga+OaO9ZpY9nVyYB6N2R+r/xjizWq7heh+gajtDHq1/SE3sF6g0/Jo/Er/
	B7tOBPgcHxzu4zYd9/Qm3usPrfh6sOGBOabVMCU5gitAFmFs4
X-Google-Smtp-Source: AGHT+IFWuBrLIEbeUtZdtLqTw+hW1a9tpEUu4JPcNe6Bb4qKpFMMypY6fb8mghVdvzohIsDDM0+1fQ==
X-Received: by 2002:a05:6000:1a88:b0:3b7:8832:fdcc with SMTP id ffacd0b85a97d-3b7950093b6mr4274596f8f.38.1753905186428;
        Wed, 30 Jul 2025 12:53:06 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b78b26a4dcsm9556193f8f.32.2025.07.30.12.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 12:53:05 -0700 (PDT)
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
Subject: [PATCH 4/8] arm64: dts: s32g399a-rdb3: Enable the STM timers
Date: Wed, 30 Jul 2025 21:50:17 +0200
Message-ID: <20250730195022.449894-5-daniel.lezcano@linaro.org>
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

Enable the timers STM0 -> STM6, STM8 on the s32g399a-rdb3.

The platform has 8 CPUs and the Linux STM timer driver is per
CPU. Enable 8 timers which will be used, other timers are useless for
the Linux kernel and there is no benefit to enable them.

The STM7 is skipped as it is slightly different and needs an extra
property to be handled by the driver.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
Cc: Thomas Fossati <thomas.fossati@linaro.org>
---
 .../boot/dts/freescale/s32g399a-rdb3.dts      | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts b/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts
index 802f543cae4a..467e0c105c3f 100644
--- a/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts
+++ b/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts
@@ -40,6 +40,38 @@ &uart1 {
 	status = "okay";
 };
 
+&stm0 {
+	status = "okay";
+};
+
+&stm1 {
+	status = "okay";
+};
+
+&stm2 {
+	status = "okay";
+};
+
+&stm3 {
+	status = "okay";
+};
+
+&stm4 {
+	status = "okay";
+};
+
+&stm5 {
+	status = "okay";
+};
+
+&stm6 {
+	status = "okay";
+};
+
+&stm8 {
+	status = "okay";
+};
+
 &i2c4 {
 	current-sensor@40 {
 		compatible = "ti,ina231";
-- 
2.43.0


