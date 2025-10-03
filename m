Return-Path: <linux-kernel+bounces-841274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 274F7BB6AEA
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 14:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09F9B19C486A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 12:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483A02F0689;
	Fri,  3 Oct 2025 12:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDi6NY86"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32FB2F0671
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 12:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759495868; cv=none; b=PfK5/UUEwYIMhaloD2kHysWosaSqPQZAzmYWyv7piEH4Q72eku7H7Y7Ndb50PL+keZpVhhSi30QjthwxkUbGhxSLFUm+q/ufaC2gZMSn2I81MHqUiN0D66QdOnGszp5D/UWfx/2E0DUt/jmgHQeiJWXq2e5c+IZXarPo3IO86tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759495868; c=relaxed/simple;
	bh=kb2Jkd9IV6OKkT6ZLkEZyrn/OKU6iANd/7ecLkFvmkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BBFFFcwZqqGYg/JqkGMPAOcqmyQoQsacIfdELK/BGkIdphS9RVqva3gNgpQzX5/NwTD6F3j314l+V+0ariL3RHM7t6ciKX+sXzNK9GJ2+kePxol2FUN5EBk3elWU4pbh68bTevG/O9zSIHMizM6u0L/4hv/paWKpTVXioW5AhKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cDi6NY86; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-46e42fa08e4so20551835e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 05:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759495865; x=1760100665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lYgyMG07VqTYH5jn/t5TCThG/fj6xAJlnS1AF75htXQ=;
        b=cDi6NY86ZEzs43rvervQARRr0ciF9Vu2a393/6zQs8dowW5b2x3UG6VKhDyzxC8XBC
         JBIzCpjqeLifkUnTWyz0V51aupKH+jxJkq+Mgu12i1icY88Nj+dxzaaVGOhoD2p3Jz0S
         i/YLhyC2y+2V7wSK6ofiEyKZ6QJi4K6wVUTcrfhyIsKOn+goo3S/aZPPbR7lnnp2xtLU
         SBfoWRtu0gM3CrQkSP1PoprqWQ/VqqBHloBcy2E1jg4DEDrYE5H875ImsuHZmxPhFLns
         IeP/0O5ZgyA5TDF0oe61q6llIK48KHwqtD45azK1uxGEyCRCvo9NJ2zWh7mK9gvSwwmN
         b9DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759495865; x=1760100665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lYgyMG07VqTYH5jn/t5TCThG/fj6xAJlnS1AF75htXQ=;
        b=DZeAIHw+0ofKqXUbN4vEImVWEGjCyx45noKxyOgxG8OjEJrcmY7YrL04uAq/AEJLhA
         xNLonY1+9qeW7wbbqL2VTqDJWqHmNXDCHAg4kcyqO+s+kErtWYJlel354UghXiNe0gsy
         63sra49dbLSXQrGDATVTyDBf6UhErmBV2ZZMnGk6j75vUvp3O43yX+z4KKquABaOSuAz
         Ecp9zW7eTDFfSdZtAuV1kv5UarBotzsUZB3dgKtX8kDTb0qiWKOL6Dxr+wkBCZYHvlS+
         SCKnrF3yoePRPuD9JeqHzpfl2dDEEEFCsVvlNoBR90gRFQB8tcOlnnuH4x9Yed6l6op4
         QtYg==
X-Forwarded-Encrypted: i=1; AJvYcCW383gYfBcuoCE2xg7lKgGIYxbT7HhiqANZvPohNu14Q59VQLGsTZCoieQqCoBmqUQoSK9ZvhqrF4CK4Ik=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaI792qQbP5xJBjbACIxn7v9cYVl0KrFYzFp2MP0huW2n5VItt
	WlbmXYdyY+NBaRArsNcjCH6b2buN+WTQErjmiyAT3qp5pY9qufv9M6PC
X-Gm-Gg: ASbGncvkFCjv2dDhd0GRZHo1Agj1bUGhCYzqt2mnhjVPWdHaL8MJASQQkuDL+hPjnDw
	ltzVVa5T4+ZI7R3BEyEeOgtGAwr1X1TPZpUIy/41SdU3mViExS5/Ijthz792UO2A9C1Vr0UCDzW
	JRQPKLgHN0dlZEH+QEq02ePm1T3tyXTuxpTQK16WqFkvsIhRlYxP1dHfCR1lcufQHaJoLNxab4m
	kl0rJ4465WK5XB0ZFZFHBjsvicWPUCJxwRGIWY8oCUt9b0uFCjOEwgnFqDK6w1mGXKTXHqfXebZ
	ElFf3lLYgmgsLwBgIu4VCfh+ehTrIOwtBRCoDP7sIKtUu+Ng0dOQCOL6xw8IMRxqRbqkQnKT4X0
	nmdwd7kbsuL5S+vEFVKxyoVRwOS+MIrvtY9oXVKi5mPQjeK0VQTH7sGeu62JmcdlYRjrNVA==
X-Google-Smtp-Source: AGHT+IG4L2xBls0a2hrXeyuJrwzw+WfFt28AIUJ+Fp9Tp8p1FnhMDnBRj+XtHMpNn4kg611dyop0Sg==
X-Received: by 2002:a05:600c:3b08:b0:465:a51d:d4 with SMTP id 5b1f17b1804b1-46e71101a79mr23090835e9.6.1759495864829;
        Fri, 03 Oct 2025 05:51:04 -0700 (PDT)
Received: from localhost.localdomain ([37.159.33.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e5c40983asm80598605e9.3.2025.10.03.05.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 05:51:04 -0700 (PDT)
From: Stefano Radaelli <stefano.radaelli21@gmail.com>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Stefano Radaelli <stefano.radaelli21@gmail.com>,
	Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 3/3] arm64: dts: ti: var-som-am62p: Add support for ADS7846 touchscreen
Date: Fri,  3 Oct 2025 14:50:29 +0200
Message-ID: <20251003125031.30539-4-stefano.radaelli21@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251003125031.30539-1-stefano.radaelli21@gmail.com>
References: <20251003125031.30539-1-stefano.radaelli21@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The VAR-SOM-AM62P integrates an ADS7846 resistive touchscreen controller.
The controller is physically located on the SOM, and its signals are
routed to the SOM pins, allowing carrier boards to make use of it.

This patch adds the ADS7846 node under the appropriate SPI controller.

Signed-off-by: Stefano Radaelli <stefano.radaelli21@gmail.com>
---
 arch/arm64/boot/dts/ti/k3-am62p5-var-som.dtsi | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p5-var-som.dtsi b/arch/arm64/boot/dts/ti/k3-am62p5-var-som.dtsi
index aba72d0b767c..fc5a3942cde0 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p5-var-som.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p5-var-som.dtsi
@@ -322,6 +322,30 @@ &main_spi0 {
 	pinctrl-0 = <&pinctrl_spi0>;
 	ti,pindir-d0-out-d1-in;
 	status = "okay";
+
+	/* Resistive touch controller */
+	ads7846: touchscreen@0 {
+		compatible = "ti,ads7846";
+		reg = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_restouch>;
+		interrupt-parent = <&main_gpio0>;
+		interrupts = <48 IRQ_TYPE_EDGE_FALLING>;
+		spi-max-frequency = <1500000>;
+		pendown-gpio = <&main_gpio0 48 GPIO_ACTIVE_LOW>;
+		ti,x-min = /bits/ 16 <125>;
+		ti,x-max = /bits/ 16 <4008>;
+		ti,y-min = /bits/ 16 <282>;
+		ti,y-max = /bits/ 16 <3864>;
+		ti,x-plate-ohms = /bits/ 16 <180>;
+		ti,pressure-max = /bits/ 16 <255>;
+		ti,debounce-max = /bits/ 16 <10>;
+		ti,debounce-tol = /bits/ 16 <3>;
+		ti,debounce-rep = /bits/ 16 <1>;
+		ti,settle-delay-usec = /bits/ 16 <150>;
+		ti,keep-vref-on;
+		wakeup-source;
+	};
 };
 
 &main_uart5 {
-- 
2.47.3


