Return-Path: <linux-kernel+bounces-790095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F212FB39F51
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 15:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C74241C2511E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 13:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FCB21E0BB;
	Thu, 28 Aug 2025 13:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GnGolf8j"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3A11A9B58
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 13:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756388896; cv=none; b=aLAvKCPfu+V9ZybVMxDTR95jqpaL3rpA5CiX/pgxkxIjhvRBoIkM3S+/G12/BI0OwW+C3hZH9IxZJ7mEbbS7aSq9U/xVZzRIiIKdHjULqczMC6/nn9FhaBvXkTX6oceScv46Eh4GmdDXvxqTfdqNolgYbAatg3f7udn5zlWEdgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756388896; c=relaxed/simple;
	bh=CyBzeTKKQTYkP5v9fH3Sisy9Cw4GsHTyaTY2ml6XFmQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PEBfLQS9d5/PrQNd6bWNh4Q7N3LDIKiX1GiuoB5dyxw4nTaVqR6DYS3nJCAc3G3sC5xiJ+6pigPogFoCzMOUV9j2krytZXoDKenkilAXVuGyPdTs++eVu+prKMosXYdoPjUcSFkYIryQSNWmbpfQIvpG1Hmxw/NG5u75GEb2y8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GnGolf8j; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-afe9358fe77so70057666b.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 06:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756388893; x=1756993693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QSWkjItMEsVNotyoDAMPLMvhhraXQe3wDj+bg0giOKA=;
        b=GnGolf8jvRXkubxI2aWdntXyCWSmraX1wy1FG3jAgOPjN0jgC313bk4r8Pw8mHPLXB
         eus4xdwX5087qLMfIgFg0BHhyUfFhDeDFT3/xmhHf7B6nBclzzkTh9YstizL5L6Bezmg
         ppq0qouBksSq3l44P1l1Qh4pP2MSEIh1tz3neg7B4IqEbWmNMF2u9ofUR81KExxYGx4v
         N3rbKLqe4f4lNOBqkweNBkn2glTUY4r7d2ZXj4pwz56RqY94x7/Wqq1cFVKTiPF4SRE8
         n2KYcq358U+pAttaG3uRlXlfFu7p/h4/c+c/e5mI+RNLVd0W5aNohWJPsiDAySuYOcW+
         U/Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756388893; x=1756993693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QSWkjItMEsVNotyoDAMPLMvhhraXQe3wDj+bg0giOKA=;
        b=NiTLguy5bG2uF3kEgI9oD70PTJxRs3Jvhu5gyMvOrKzSjnf+yk0HF46n4vd4nQrq7o
         X5DPKPmMh9IL6yENzSEFiK+QdZoVvy/TttjJ7EvzR92TtTHdxFYSSHdcGcOpeEoh47aF
         IEK+Ej3RgzHTOf3RpbgEn1fP1XbzVkGGrVjLIZsYR+/o2EHcupPOQti7rLJfY8kUj2Ax
         yVbw237PuxonBhnOFnvLPUftRvp4unUEhc52KsJic1Kj1c94QjJjM/5V3l5SiyMkKP6b
         jTCicFN8pYQqSODJb0Y/gUfOrwIiVAAOI/uNLZ81XfqJDaEvy3WlXb5c7Yjx82A/eMEs
         bdag==
X-Forwarded-Encrypted: i=1; AJvYcCW5mao7Eq1vj+Hbuwmjq681pGATtSryWVs2irvOH+SrVYUX/m7B7rFzmqGnNU7g82DEwn8Ge9Nw/pu/W6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdSC2e3ZV9o3cyCnaT+WZkk4cCnG4M5vzfTjqDmVgvTa+kVcaV
	5RK0Kz2z4PnDEk/m8xNoEJcCoy4dCxHqKUTcFhLZdYbhnXa3vKTOiT+1aTM4WqyUR6M=
X-Gm-Gg: ASbGncvA4BORAj+7zM1hLA5ovGz5HWOwPauBgO1F1rhTDpfnNmkWvv2N7o6+79YxHuH
	pFGDAJxw9X5dH77o5UCndp8f7THkBrzREQuKvX3vFImKY2MxX2ddD8JsvLiNobQjIBw2kp2RPDI
	gQjGE/16GoY2dsE1F/v2WzQT0vQGTIYNx3flQiYoFqVL5XIoJBGioZGOb0Ajaa+poANbtEeDRKd
	CqjYPsuVXbSEw0sC3E40AS2se7LpflWBlauTja2JC7OSc6e+TSoQBgm31FSyCt1w0yo8wvAYTyA
	m/PoDQPF2g1/T3+Cel3sp1prWIq9cQl/6Cnlp9ixahXPvJh/gkUyoulVoMQlTC3j3gdK2I1nNSr
	U8h8WaovT41DzcimCvJqy5dzLM82R9T856ew/35byS596J6YPKU8Hqo4wPr3mUtREz8i9sL30aL
	KDP96d19RuxslZfTdV4mGtbPytzsQ=
X-Google-Smtp-Source: AGHT+IE0mnnz/V1bhpFxlBdsAbBHx4QqqEGn96nhy+Mvodra/CXXwAofr1j9KUPTZWvQ5QP+0+sP0A==
X-Received: by 2002:a17:907:86aa:b0:af9:8438:de48 with SMTP id a640c23a62f3a-afe29605c0dmr2169147366b.48.1756388892528;
        Thu, 28 Aug 2025 06:48:12 -0700 (PDT)
Received: from localhost (host-79-36-0-44.retail.telecomitalia.it. [79.36.0.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe7c93b86dsm515729266b.21.2025.08.28.06.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 06:48:12 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrea della Porta <andrea.porta@suse.com>,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	iivanov@suse.de,
	svarbanov@suse.de,
	mbrugger@suse.com,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Phil Elwell <phil@raspberrypi.com>
Subject: [PATCH 2/2] arm64: dts: broadcom: Enable USB devicetree entries for Rpi5
Date: Thu, 28 Aug 2025 15:50:04 +0200
Message-ID: <9926b25f2932668abdf99d30182ddca4f7d18d9a.1756387905.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <4e026a66001da7b4924d75bd7bee158cbb978eed.1756387905.git.andrea.porta@suse.com>
References: <4e026a66001da7b4924d75bd7bee158cbb978eed.1756387905.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RaspberryPi 5 presents two USB 2.0 and two USB 3.0 ports.

Configure and enable the USB nodes in the devicetree.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 .../arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
index 865f092608a6..95ab67c7aa47 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
+++ b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
@@ -21,3 +21,20 @@
 &pcie2 {
 	#include "rp1-nexus.dtsi"
 };
+
+&rp1_gpio {
+	usb_vbus_default_state: usb-vbus-default-state {
+		function = "vbus1";
+		groups = "vbus1";
+	};
+};
+
+&rp1_usb0 {
+	pinctrl-0 = <&usb_vbus_default_state>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&rp1_usb1 {
+	status = "okay";
+};
-- 
2.35.3


