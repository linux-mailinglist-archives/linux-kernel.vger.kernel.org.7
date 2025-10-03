Return-Path: <linux-kernel+bounces-841272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE65BB6AE1
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 14:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CB111896D0F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 12:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4962EFDB2;
	Fri,  3 Oct 2025 12:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E12M+7GY"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E552EE5FC
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 12:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759495864; cv=none; b=K5ai8660t/6qQrY6GEyaWVVZ+C/51qNLZiEjNowLqLUkGkEOJFKxXHQSuLbY7JwYmNNmdBLnn976GfSWdzN/ebz9uWS1vh7cuTFe+3hy2Edsex9LHynVhJVYWSiS7VTkTaJHrQ7g/aDnspBm4T6jiOKrberguVmC1F4mEb8uKOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759495864; c=relaxed/simple;
	bh=fPZ/cJSJkaF11EllnT7kgWt76oa1pY42U6aeyHqj7pg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P5+sKR7qpLYGpjSlTlHYVVtY6NdmzssMFZ0j77p5B29TQSHKXbixEkSiVEuXPJW3jXCUcs5Id4otMzkpraeDwVo4fWFF5Y/dD9OgF2S6oynZsIFRMH4yZUUHDHTNUl8wCLFRxSpw8C+QEkfxwpXsKAueOe83rVG/VrcC1oI8vgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E12M+7GY; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-46b303f755aso17885795e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 05:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759495860; x=1760100660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WaXfwSB/FRGqmKy0Vb2zzmiYO4dF/Wx+pD0HOeUkg6Y=;
        b=E12M+7GYdz9yxn7MKWSMPlaIGG+69Y1f1EMSpigGSzcG2al79llkGku0b2Qokyt4U9
         z5GyGZMZ9TtS+Jfk1h4iGxM3y/IQso1EN9y53Kl2tVRcCd6c6kaJCh37tXmf+vbyI5Mf
         gwQE+KqQm71N2ialAVOqGghIvXx+FWj7ZfCN46OrIWDPVzdDy8EOLHmUu7NFC1IztFA2
         yhJ9MsmYqBMVK7FsKuBq7PLrxW1aewdLoOEpHSJ4GiFnz7aqAP+4uNTpjZRWlg+5l3uF
         NemA2/MLptp0ctpOGUbkIzHdvnjJKzxW4XNQW6x35uwyVesPBubTn1rlQOu36NnihCmM
         aakA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759495860; x=1760100660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WaXfwSB/FRGqmKy0Vb2zzmiYO4dF/Wx+pD0HOeUkg6Y=;
        b=tzPyXa4gvGzQbyXesjOpH8U72eSXO2hB1sxwFfnaWFdz9KxOKBvOj3/A+5e0rhC9lN
         32W7hRxvZQROuvEtMjNbSpY5AKLs0DyyBOEpzBLnoVmWtVZVWrc2tbC92STD655IeUFu
         eRwHuZv9MYQ6IB2mtyvOIVlqrzxXpAx8eowTH8yhlLFcs9MgQHt6Js87l6ujjisdywVe
         hWPtDq+IgGmZ3pbfCrPBKT5on9W4gp/jZIgH5gDMGPB/BcH3HClpU7eIN/D5rY58HMHX
         RTwfw3zEHtGrSgoZLz+X1Neu8XPogA9rm0kAW8zqKYNfwfasQmhCxmpyL5MZdvxV/+dV
         x8iQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeLtzygxJ1s9YdoJoOI74Wy91sIXdYM1DZBR25Rn8FbIzLbMmjk7HkCNnQBfdJg3KM+yNLTnhoctkLTLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXTBRZ/bAfsjpmM1COBjKPpMvq4SOk7VeVwTlvFLw9d72CjZfH
	WdUMzzuTjsKYevKobeaw5LoQVWfR9r8yLQwJXktIqUJde+af2yB6bjqj
X-Gm-Gg: ASbGnctVTwOZA4tVtxSNAoGjDbmK+jPQD1VrTcYlXhvf5DPMIXlKFWGo7gAgMOgFmpn
	HWObBs8u6u8Sr5A2jtYxUIsUVQyG0TCrixJ6ex+OrdWyZehkYgz5pFNqfDGMB2J2QiPTRCV4wEy
	pSTudlqIFssyTAZ8M9IBHZhG2tZrgWuE9vE14p0zr8OdX8ov6eHrB4VMWGC9tHZFqy7P+XOvSzq
	fZGGMkMVkqyuhjCU/fo9YS1qkLA91PHz3myLNcmTgrR3gnFfmWfPK/n5P7eGXFQ4BeyThNKkXl0
	xre7ebs85sOaFl01ko2PN0nNjzzTu4AoVUnc1791hdYpt9RpNn+lJpxTjlsXDsrnfngtMa44mYf
	Az5ZRCPBZ729TJ7Jbwk0BFiaEMpRsJR0uGY+EbK+u+zQsuyQInl2Og8n2Nloo8LFQArJ69yAtoE
	8JEooL
X-Google-Smtp-Source: AGHT+IFK24Hmy9qDQXQFVbal729f+4HuhDIUzQDqGeKXa8THbxiFFtjcu/scKAzTeHzoz76wi6we2g==
X-Received: by 2002:a05:600d:4392:b0:46e:74bb:6bc with SMTP id 5b1f17b1804b1-46e74bb07ecmr9696025e9.5.1759495860204;
        Fri, 03 Oct 2025 05:51:00 -0700 (PDT)
Received: from localhost.localdomain ([37.159.33.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e5c40983asm80598605e9.3.2025.10.03.05.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 05:50:59 -0700 (PDT)
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
Subject: [PATCH v1 1/3] arm64: dts: ti: var-som-am62p: Refactor IPC configuration into common dtsi
Date: Fri,  3 Oct 2025 14:50:27 +0200
Message-ID: <20251003125031.30539-2-stefano.radaelli21@gmail.com>
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

Update the VAR-SOM-AM62P dtsi to align with the refactor introduced by
k3-am62p-ti-ipc-firmware.dtsi common file, allowing to remove the IPC
nodes from the board file including the new common dtsi.

No functional changes intended.

Signed-off-by: Stefano Radaelli <stefano.radaelli21@gmail.com>
---
 arch/arm64/boot/dts/ti/k3-am62p5-var-som.dtsi | 52 +------------------
 1 file changed, 2 insertions(+), 50 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p5-var-som.dtsi b/arch/arm64/boot/dts/ti/k3-am62p5-var-som.dtsi
index edaa4f99295d..b93372f22732 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p5-var-som.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p5-var-som.dtsi
@@ -63,18 +63,6 @@ rtos_ipc_memory_region: rtos-ipc-memory@9b500000 {
 			no-map;
 		};
 
-		mcu_r5fss0_core0_dma_memory_region: mcu-r5fss-dma-memory-region@9b800000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0x9b800000 0x00 0x00100000>;
-			no-map;
-		};
-
-		mcu_r5fss0_core0_memory_region: mcu-r5fss-memory-region@9b900000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0x9b900000 0x00 0x00f00000>;
-			no-map;
-		};
-
 		wkup_r5fss0_core0_dma_memory_region: r5f-dma-memory@9c800000 {
 			compatible = "shared-dma-pool";
 			reg = <0x00 0x9c800000 0x00 0x00100000>;
@@ -320,44 +308,6 @@ &usbss1 {
 	ti,vbus-divider;
 };
 
-&mailbox0_cluster0 {
-	status = "okay";
-
-	mbox_r5_0: mbox-r5-0 {
-		ti,mbox-rx = <0 0 0>;
-		ti,mbox-tx = <1 0 0>;
-	};
-};
-
-&mailbox0_cluster1 {
-	status = "okay";
-
-	mbox_mcu_r5_0: mbox-mcu-r5-0 {
-		ti,mbox-rx = <0 0 0>;
-		ti,mbox-tx = <1 0 0>;
-	};
-};
-
-&mcu_r5fss0 {
-	status = "okay";
-};
-
-&mcu_r5fss0_core0 {
-	mboxes = <&mailbox0_cluster1 &mbox_mcu_r5_0>;
-	memory-region = <&mcu_r5fss0_core0_dma_memory_region>,
-			<&mcu_r5fss0_core0_memory_region>;
-};
-
-&wkup_r5fss0 {
-	status = "okay";
-};
-
-&wkup_r5fss0_core0 {
-	mboxes = <&mailbox0_cluster0 &mbox_r5_0>;
-	memory-region = <&wkup_r5fss0_core0_dma_memory_region>,
-			<&wkup_r5fss0_core0_memory_region>;
-};
-
 /* mcu_gpio0 and mcu_gpio_intr are reserved for mcu firmware usage */
 &mcu_gpio0 {
 	status = "reserved";
@@ -385,3 +335,5 @@ &main_uart1 {
 	/* Main UART1 is used by TIFS firmware */
 	status = "reserved";
 };
+
+#include "k3-am62p-ti-ipc-firmware.dtsi"
-- 
2.47.3


