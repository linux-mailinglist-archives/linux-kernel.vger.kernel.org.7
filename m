Return-Path: <linux-kernel+bounces-752722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF543B17A2F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 01:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96D281618A8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 23:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA9628A70C;
	Thu, 31 Jul 2025 23:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vAIALMc9"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7D128A419
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 23:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754005535; cv=none; b=tmYx391YN6E9+E305dh2lCyFigetlGaf7d5Ks5NghwiwLevsskxhnqbm/JNgF6w2zC135zvDo2GufzIn6MC75zX0ltoJ18noGkpDYvaHAC/j1qpyZ9t7fGt8rXmL/AOCjBGKxgx3Wp1o7+a8wBAOzXpNY6rNmdV6XRAASxrYdto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754005535; c=relaxed/simple;
	bh=2gt6Nxed+AFerebrJU3TYDHkF7LsDAD0OfwSV1lcaH0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T1c9JbKf8SQrYfFx7MACuO0fnF7YNBr03Jt9ih7jLY8QWxbce8lV3oDQs6w3PylwOyn+XTB1iX4X3xOUtFYXAyLVY6IF0S8WWq3GNPn77oRZ8YdMSM+SFmE3jDltvM1HBBICH+yi5EgJFKXgT0L0yShm46xX5N67p+CpW3jbRB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vAIALMc9; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6196fd7e9abso170039eaf.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 16:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754005533; x=1754610333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o5aj5vUWJXyfqyhprLvdwVUEl/uN3d7BC1IvykTif/4=;
        b=vAIALMc9cvDdQUpfHCK3eqpWjTikpAvTOsGZ+naGN3sJbFs73TobHywPpbzhpdOZNK
         zXKsOuJhniq89roybImciL06q8G0SOfj0NRTT6AkF8c4S7L3dE01/c6yl3HKiNBxtaQ5
         U/sMUfJNfjsgnM7t1zeJqd9xQcmtU6NGjo/o8E6CxuUjLyQWhxfd5EjyuSL0rYjFsxQr
         CFdzR6HJHaXFmFOq0Z0D0Jpku/Upx/LAsjWhi0EdShL4+0Bf09PewGPyNncqDOuFWgs2
         ib9B7pxPsxk4FA5DytchSBZwQuQceBaJbw2rDbypduCpUJ3NeH2moNulu3cT5EGBGuWd
         dcsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754005533; x=1754610333;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o5aj5vUWJXyfqyhprLvdwVUEl/uN3d7BC1IvykTif/4=;
        b=KjnF86eUvYFffTVjARr2EH60blvx60+4dSOGhqHjqbtwJFSgt2jdVrzRfrPyOCYk17
         GJwO1gBITdqPonADC9JWeav+ZeOv4rIBhgCrKXh1fVFaevn7dkXbOTXLj8ORp7jZ1ANW
         qnf+9SgpWqd+/TND7LVM0Qm3EStQ+ndAarvNdZIMRFEbIw74ujW4JmRzIaRz+g9V8oIi
         5Q/nhT2BvhjGdTDo9cjXd2aJ6/o7Grep1x14X/fmQKexVb/T+mXMxoLOf2FSJzV+vAK/
         K4ELm+zKfhjnTzKPGlNVFYaPoO+XnrI0oILEi5WhBHg/A5DdoCejeN+sBuTgx4PGGIw+
         L10A==
X-Forwarded-Encrypted: i=1; AJvYcCXXbuZfUQ/puR4ZOeXCuEtZ0oKHXwYofiZ80UGZUKYBululOVuUoaxY3Qcbr05eownfoE7UryrERZa5YPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfzigIbC56y/e7qUS8Fq592HWEoMB/kMY88TQsjuIf87A1Ok9M
	cvsKkdxj7S3arNEnp/bKqbRxdslp8e8yb3KfhZZY6EfbJYwQIFz2OtEPmtUf5jZXqXk=
X-Gm-Gg: ASbGncsqWMf5Lf6Td1st47FC6zVE1utbzJ0EowX9Q8i0wpCJKjK9uuzFhqCplAg/XZb
	k7+2AuXD8eKSnEcbgYh7fLM7F8FqoVW6OIZ/4OOb8nKoKmHrgc3MBkfWmJQLH54rVBo67uaslFI
	Vik9hJHxLWC/bVhdarT7rGUjeIFzt+QhXzO/bnuzhTV2i8WSZyZwtqJ/CgWlvzf7oL+/CL+kxm9
	ZwY4lTPmTl8hTDcTUpReza9RifVcCAzXyY5txe1N2voRHRshTvGHy8vmAgI0fnd1hyTT8SgFmGf
	F7SE1RryH4KzeFL+DW/wCTA48bQ4RJAAFls5wJIxaxXQdPxBm8CxxE3uWHDEu64WW8jAM0pn/+f
	gKkEGp5aQ/SFwCYFLHJBozCyqBQ==
X-Google-Smtp-Source: AGHT+IFuo3EccWt2eqaswL/GXTzhTAtiWo9RPTumIYwjblTx1Ehjy9OmBX7qt65iTSqVmlJ1VnsAJQ==
X-Received: by 2002:a05:6820:6682:b0:619:7ffe:b0af with SMTP id 006d021491bc7-6197ffec3b4mr712572eaf.8.1754005532733;
        Thu, 31 Jul 2025 16:45:32 -0700 (PDT)
Received: from localhost ([136.49.61.16])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-619704e167bsm373502eaf.4.2025.07.31.16.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 16:45:32 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: exynos: Add Ethernet node for E850-96 board
Date: Thu, 31 Jul 2025 18:45:32 -0500
Message-Id: <20250731234532.12903-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The E850-96 board has a hard-wired LAN9514 chip which acts as a USB hub
and Ethernet bridge. It's being discovered dynamically when the USB bus
gets enumerated, but the corresponding Ethernet device tree node is
still needed for the bootloader to pass the MAC address through. Add
LAN9514 nodes as described in [1]. 'local-mac-address' property (in the
'ethernet' node) is used for MAC address handover from the bootloader to
Linux.

[1] Documentation/devicetree/bindings/net/microchip,lan95xx.yaml

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 arch/arm64/boot/dts/exynos/exynos850-e850-96.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos850-e850-96.dts b/arch/arm64/boot/dts/exynos/exynos850-e850-96.dts
index 7d70a32e75b2..ab076d326a49 100644
--- a/arch/arm64/boot/dts/exynos/exynos850-e850-96.dts
+++ b/arch/arm64/boot/dts/exynos/exynos850-e850-96.dts
@@ -21,6 +21,7 @@ / {
 	compatible = "winlink,e850-96", "samsung,exynos850";
 
 	aliases {
+		ethernet0 = &ethernet;
 		mmc0 = &mmc_0;
 		serial0 = &serial_0;
 	};
@@ -241,10 +242,24 @@ &usbdrd {
 };
 
 &usbdrd_dwc3 {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	dr_mode = "otg";
 	usb-role-switch;
 	role-switch-default-mode = "host";
 
+	hub@1 {
+		compatible = "usb424,9514";
+		reg = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethernet: ethernet@1 {
+			compatible = "usb424,ec00";
+			reg = <1>;
+		};
+	};
+
 	port {
 		usb1_drd_sw: endpoint {
 			remote-endpoint = <&usb_dr_connector>;
-- 
2.39.5


