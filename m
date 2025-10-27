Return-Path: <linux-kernel+bounces-871227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C09C0CAA7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4EEC94F09E6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BE02F1FE7;
	Mon, 27 Oct 2025 09:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3t9x0HY"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794E62F1FD9
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761557550; cv=none; b=lviS/Ve0hydRxjZW8c+SESGFjCPIwl+m9VtNnDQrse+zy6Y7gFT4FOQnSpEkQRQzawiXxLm/jxKz9Xm8Qx0CgXkRIvB4ytbBwBVjozfyakLLG6l7tBo2COImnQw5Xuyz4bd0KhQxAR3iUTiVeqsB07/yQ4X/Ir0BPOk3DhA1Jvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761557550; c=relaxed/simple;
	bh=I+vPrkGtVY1KgrH1yltmYPBQNdvYIVKIbmnLGF2Vio4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DM9Io5la2c++zuKnokpS49ofdQo47+R5Fxl1pqQ1ViB2OaItQlWV4/8I37tW49PXX6LC2B/Dsq2jghnkr9k0PgayniNQPniWI41kv6JniQokOxmUGzp55BuLVie9W9oF/io7A0EiGlmjKvz17OopUmG8MODVd1fRmpwRQCl5e44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3t9x0HY; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-63c1a0d6315so8431692a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 02:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761557547; x=1762162347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c6jnR1l/knmmCE7j64ceFOiYUTsDgn50GkewewG1O2A=;
        b=A3t9x0HY9kK9ARaUbuq5ZiwW1g9VAKbkj/XPkliNOm4F7JHj91X89u193tV6IJ3MVR
         govgEi1gcS5hZ35o2M2D3eE61c8el8S/mNQ50qCI4FwARP0oTpEyTp6/H6P9Qwn+kVrz
         1yl+n7KfonlQxh7s1hqE2eVSXkTo1uBLoYb+utA251eyLt0IEOkZVVsbYFf/kBfPeNIo
         rKPSB+TIZkV+VzFKevXt3gYk4nxP7vVuXqReveMnMyC7F+SeqAEyJEw0LY7uHYtOmv7y
         rLZRxgvdetHCRarjxyPxQcTTTxW6/fRKP+6oz7xeNPxYZx63igdWYguOKcY9j41sPbZB
         44GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761557547; x=1762162347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c6jnR1l/knmmCE7j64ceFOiYUTsDgn50GkewewG1O2A=;
        b=jPR87UDDAuq7f8FpRhTx5xAOdCTEA3bqaCvbUWgmQfy0nBCapeMwulx+wWjhMnGxgy
         TTsh36oG10vN55SzHaaWDxZJK/GDsGfWmmfUXgj6wdUQeFQOgUSaRHZEwmx3k9AFwFag
         R4W96uvr8w11o4l9sA6i2vU3q1iPD1IvuCVFOJu6TcrIf7t5vmIheL9UzAFfhW7q03eu
         yftrx963n1ZvFP2vHJYUobZ9EJF4KGRrsKaAfN6kWkzHVRnTgmiXP1DV9NwvQ48Hl6pi
         E+ZzNi7CFg06cj3Ppu1KSzjbug5iGFc0BrkrLQMEFC/WSyqGrE61RGRNoDlGyTTd/aLp
         Pjhg==
X-Forwarded-Encrypted: i=1; AJvYcCWB7jsa+Bz7yuNskEZaKsvQZotpqCf2FAs2e4HZMXF3pO86qkaq7Ihw5KhG+HgM7qkOX9Yg8Ggormbe7xA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn+G8G6vrulLH3MzM1is9R5fR8/hN+voSdK4HMaB0tCe+JKbop
	Y+xv/sbmhfpa7zDm9hUxSiLWvgYHYQDF5tnReb21pPbE2BzwkXKmol85
X-Gm-Gg: ASbGncsO+XR3Y6wMQRu9XO3oUQuINYLnyGyI17JPAhNY9LGf7qj7kfQhZp/iswkUlo/
	nEwnjEaQ2FHjeCvdEoqzpUcsCO10oFwuw8Pvkj5vQw96Av75DTO4gnuFp5nyb1hMjL/Xf8rztOh
	iUjEvh0BYjgubDtRmmE3kJb1GA5vDdBG4yee2SDpe+fDQAyMhPeQepOvmGlVl5r2jh7bwgRpnbf
	mbFkJqp/p1wFiJVHQ3V+TplkickuJZEiipC7jsG6qadnxogbqnleSjs/J5Q0GGCTiP/pSLjaTqS
	spo8WkNmKhpFHaHWHGfiMDC3UVq0jmw631JS45wOT9jXhU22QJkbTJH4WqFZ88Yn864c8METTJd
	sYDSUKY5pQN10AkK7EXA1z6yKEnQOE0VltoSBNoIEmdjKkpBVsByVCrpjTxOgFx76Dm0L7mhcqc
	99zbTUpmKN55feDKM/pIZWM3HzHK0has68cS66mFkxl00eLaEAUhQGE/1c+QVTr6bA6uIQERALY
	oSzIXZ1JIwCGuhc
X-Google-Smtp-Source: AGHT+IGo4pfv6hPnOdMTXONgc4qw1GUfLg7rVGlLeAbdxBQfM+FdGB1kbkQsXhoL+4Azs4JdFAml5Q==
X-Received: by 2002:a05:6402:1443:b0:63c:84e:614f with SMTP id 4fb4d7f45d1cf-63c1f6b0b87mr34969695a12.18.1761557546755;
        Mon, 27 Oct 2025 02:32:26 -0700 (PDT)
Received: from toolbox.int.toradex.com (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e7ef6be28sm5681014a12.2.2025.10.27.02.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 02:32:26 -0700 (PDT)
From: max.oss.09@gmail.com
To: Max Krummenacher <max.krummenacher@toradex.com>,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/5] arm64: dts: imx8-apalis: specify adc reference voltage regulator
Date: Mon, 27 Oct 2025 10:30:09 +0100
Message-ID: <20251027093133.2344267-4-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20251027093133.2344267-1-max.oss.09@gmail.com>
References: <20251027093133.2344267-1-max.oss.09@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Max Krummenacher <max.krummenacher@toradex.com>

This sets in_voltage_scale to calculate the measured voltage from the
raw digital value of the ADC.

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
---

 arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi b/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi
index 686fce7443bb..abf6d543380c 100644
--- a/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi
@@ -284,11 +284,13 @@ &asrc0 {
 &adc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_adc0>;
+	vref-supply = <&reg_vref_1v8>;
 };
 
 &adc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_adc1>;
+	vref-supply = <&reg_vref_1v8>;
 };
 
 &cpu_alert0 {
-- 
2.42.0


