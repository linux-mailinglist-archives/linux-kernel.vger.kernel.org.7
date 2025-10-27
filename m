Return-Path: <linux-kernel+bounces-871225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C35C3C0CA9B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8825189A4A7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A112F25F4;
	Mon, 27 Oct 2025 09:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V77sgyDD"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F752E1730
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761557548; cv=none; b=CfRewDJq1urQpHsX98xqHqyJrjABQ5a0uEIbvYRRpcMDmZK4jONXrUfhkgnG6AOioZgpOzqoNV4/ohfbJET6s4J9ssbVwwv35t8XgT1PYB2AGeNDDz7MqOFIJj+543CoGfdzerpyK6eWHFA4ZYct2c/YSNkvr27IIJtaZPK3Ogs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761557548; c=relaxed/simple;
	bh=ytEuxidEeyGVWdHcSV0Cu7NXfhvzR67Ajz+zEcL/AU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aVONVgKU9ewiKUSOBUWlcqxEsL3ztB4wvRZo2z/zY5n2TeLoKmPzD7bysG37LaoOZUzDghOOA1N/ArtYZIC3bUeoF6CfB7Gw93z63uGPSYXEkHGLpyl2wyqNMARlc8itKjl+I9QiWHdglGR7AIf3KKOniwxoU/w9lDBhmRf28Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V77sgyDD; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-63c21467e5bso296981a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 02:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761557545; x=1762162345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=23eUEQXgE/OVJfCXbnrki5PnT5McCVtuG+I3zbarJTQ=;
        b=V77sgyDDk60FaGLVpLQPdAE7mY2vIiDOhEyDNeZNBd4U9eIfRdT9Y/hlXANtNLTmOg
         ItjpqbsQ+/f6rQ4n5L9kobOQlonDGC8O0T5gUCSlUj/3Y5OOzmEYuAGb/D3zYkhjDedq
         PNDt/mfmlS2mf/UZZX+ibh0skxo/ytf9FUFnJjftz3TONxw+FKOZduMDCeeJgGPnnjqr
         hyqRxpFR6wiZGrNbQqsFlX7z0KZQOwlseWYrvTMIW4UWkhhLSzGG7vhOM8OexnJnqyuO
         JZAkuTz2EH40u5r52mgB7n/fd8Ufr8fKOJMWQDE2NDOg7V2gNKqRqAJMEl46dcEB9zyJ
         SvRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761557545; x=1762162345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=23eUEQXgE/OVJfCXbnrki5PnT5McCVtuG+I3zbarJTQ=;
        b=HYZkB6knStMp11bVC5MPJlnVXCPxHjiJhY3SVs+7qLi8ZHrJZcC44POM5MGwaQRg8m
         OXjzlPK6dS86DWBIGJx9R1GHxskMgGLlGVgR8gvAxy/4MV+DIrKxO/JNtG3KXSo5rk5a
         j0QWjt6dn4xiLOMATdu5054IK7Vwvj6VIgHfqUOlwmD06fuytAO5KbZ1donxhHspu7UP
         qQd9fZPbs/LUp/NMzpJ2GVzJ/LxuIPWqu91U4KtS1Pzte1vE9Q+1YAQMj0uqYK7ooN3s
         LriCqGT2WDnVcjNLt4qCP1P+Usg/GErp5Xjwvxnfpyw5LCalO0DlunfPltE2r0hM9M8I
         3cIA==
X-Forwarded-Encrypted: i=1; AJvYcCUOdZSMxM9a9oBSAF2m+LHTStKbVw1XYV/pCHUXjYkhvnAj/Drqp7b3VnixbX5cC4U0b4pC/EB29xOYTJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKHDtYuFMnSu6JNRfp703StvvMq8ydUQcoh19OkjL5XI1o+YsT
	AMH87Q+9m5zwRZ6oSl7ZLrHzK9Z4oFWW5JNe/ihx1FtwRf82iEyJrF8l
X-Gm-Gg: ASbGncv+2STcPlOGZh+CkK+cYi6ZskQlp91Z4gUhIndFzj2QqwzHNSM56srTbWTPdLT
	z6iTDIRKrj+v7zdWlkHN4+MGr4MtmsVdM794FWumUmKDGbI06LMbfuxBVCgsIFPqPtC3ElIyu5l
	ygjCvEVDA3tyRcRGOb2ekLZ6v4aFVDFDLAJAWJWKp42Zm3/3JDzjYh/hJF0+byM08mlk/h3mroR
	Utv7Q8FK1QsfuYhtsVdjQDzbv+sanCojAFH/UVNbvzlHH6QE7du7ZnFirBS8nicpQzxSXjIJpzs
	gVK7IFk4nkOByghj+SHXEIqHcHAsBv23MOwlRHqn4GnDh4Uk8WICL1+vqaalXlvGSEEUJGhrVuE
	Nwq2FNM6DIff+VpJBWMlnPCK2sIEhKQOQ9rQn5ydHjShor9TRGuhLr6wZKVC8eGca+xoWzyqJId
	xhwFVYf1OjzTVJkW6o0Y1GiIiqGhhi/Ll5MJ8uLCQwfz/NW6NqRvxxM+VQI3eHjH16pfBVLrdA5
	AZjTL552EVtwl82
X-Google-Smtp-Source: AGHT+IGTNqBigSY+yLBm+K5D+Qhni0CTXFG23WNwy2NenphYWj6Fl0c8XhhQtLNokHDZRXhqxEvdhA==
X-Received: by 2002:a05:6402:2282:b0:63c:2e3:6cb with SMTP id 4fb4d7f45d1cf-63c1f6cea3fmr28237052a12.26.1761557544632;
        Mon, 27 Oct 2025 02:32:24 -0700 (PDT)
Received: from toolbox.int.toradex.com (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e7ef6be28sm5681014a12.2.2025.10.27.02.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 02:32:24 -0700 (PDT)
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
Subject: [PATCH v1 1/5] arm64: dts: imx8-apalis: cleanup todo
Date: Mon, 27 Oct 2025 10:30:07 +0100
Message-ID: <20251027093133.2344267-2-max.oss.09@gmail.com>
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

Functionality has been added without removing the associated TODO
comments.
Clean that up by removing TODOs no longer applicable.

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
---

 arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi | 8 --------
 arch/arm64/boot/dts/freescale/imx8qm-apalis.dtsi    | 2 --
 2 files changed, 10 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi b/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi
index 86d018f470c1..6ebeade2ce72 100644
--- a/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi
@@ -31,12 +31,6 @@ gpio_fan: gpio-fan {
 				      3000 1>;
 	};
 
-	/* TODO: LVDS Panel */
-
-	/* TODO: Shared PCIe/SATA Reference Clock */
-
-	/* TODO: PCIe Wi-Fi Reference Clock */
-
 	/*
 	 * Power management bus used to control LDO1OUT of the
 	 * second PMIC PF8100. This is used for controlling voltage levels of
@@ -269,8 +263,6 @@ &adc1 {
 	pinctrl-0 = <&pinctrl_adc1>;
 };
 
-/* TODO: Asynchronous Sample Rate Converter (ASRC) */
-
 &cpu_alert0 {
 	temperature = <95000>;
 };
diff --git a/arch/arm64/boot/dts/freescale/imx8qm-apalis.dtsi b/arch/arm64/boot/dts/freescale/imx8qm-apalis.dtsi
index f97feee52c81..7594ac61fe56 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-apalis.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm-apalis.dtsi
@@ -314,8 +314,6 @@ &pinctrl_pcie_sata_refclk {
 		<IMX8QM_PCIE_CTRL0_CLKREQ_B_LSIO_GPIO4_IO27			0x00000021>;
 };
 
-/* TODO: On-module Wi-Fi */
-
 /* Apalis MMC1 */
 &usdhc2 {
 	/*
-- 
2.42.0


