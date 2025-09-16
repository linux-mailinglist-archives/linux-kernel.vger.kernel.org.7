Return-Path: <linux-kernel+bounces-819104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88DD2B59B91
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 17:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3CE34A0E53
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0B035E4C3;
	Tue, 16 Sep 2025 15:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crY00Hmr"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B80350852
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758034990; cv=none; b=LhN10FM+rEdT2iUxemRcvFsK5y9mnCsPHm2kTK0Bl7IpS7rql2aVhdxWVuodp2cNrHkmYzG5YT6EzVTEng5QRQMGBlzeQghVrQ6ScGcLKB/o38qtAfUrNknZdcn3gJ+2lNheg4H+QbUqzRCN5wmvbOnEeDGaxn206lfP+ps4Z/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758034990; c=relaxed/simple;
	bh=FOsyc4iTtZZEmD7yB6cXmyuTyn+sg28a2cx5viYfSEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WkITvdUYPh/+fCjCIOXtdepuO/EHNQ0/z0GBJBe6a9rDNmYERr239OfeuuKGLFJ6mU0LS85fhW4e6ETMT1BnsKDdCJkI54n2eLV+OYJg9q9UE9N4+gmKEBNv3MyJCnTv8h5QY/mhRZimrX2n/XW9xeH5iO9gUWE3PARG3fYpT0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=crY00Hmr; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3eb08d8d9e7so1657116f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 08:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758034986; x=1758639786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rl6m3dLF+FoSV4DHt3Kr11DCSsPpVABda9m8XauItOo=;
        b=crY00Hmr75GBZFAvE5DqElCcKLCnnRAVSj6lI7dX0929Mj+UfdWdqnT7TUYghf7EvD
         y6PaWfrh05GX/Db+3iKzIsGE7WDj89MMbdcyGgdLn6N5T6w2AFGL0qVi+i8tpn57k8+w
         vVcefrLPU5f0/JMyBu6PcmkTXv0ZwXiC+s85gQL0ajbJ2PcinmEtbqpI9S7GitiIZFdG
         ywomrGyACf6TbhlX1qEScK3akI3/JoBDPeBUJgZeSmicT+m4MMf5J6DbpAOTuwFYsrh7
         3Qpa80FQ4I4yHI1einG6OcQWO/iXNbi4paE5EzD4z3VRKrnleXuR6zgt9/X5pUMDA7lP
         HBfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758034986; x=1758639786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rl6m3dLF+FoSV4DHt3Kr11DCSsPpVABda9m8XauItOo=;
        b=eoJ0nDFQbg8TF3a3Kdd5Bq0JWOiv0Co9YO5m31mK0Vhg3ipF46JICoKne2mdhZd0R+
         /+djx6/W8t1yFMZRjfC/rH3+ioBFJgp2Cwkh2HEttINDgRzk5beeqHozIfsKVrx4Q6wU
         7atunWnxzQT3kZQBjF8riqVDeFU+B4jIUf7trR26CwTgelyR/Kz4GA9tPFquN/vs5SmS
         jvXPoGZXw9CJv3Z/H/Hu655pgukKRiHVU9ZFFXTty9NW/r0pUDxLCcUIODKUyz8xfGlS
         xZEoB3z1dDMu0k/7PbDCQGT/TSoRnmMP0V2YBy9FuMV4weXCR70/Kdc9vZ2GApoygDVc
         zv+w==
X-Forwarded-Encrypted: i=1; AJvYcCW49nkaJ+I6OmTHhXvb3Dk+2ZJDqEirFKEs5XsHdHOF2kc+Dua11rKUdeELG4kT3QWgY5hxHItYuP3nICQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqiQKQV3kDwop+CbmqKtXha6IIhtWBrnf+VU6RQazFN+f0M/Ck
	fxyzNIPlClS2mCq3IKd83WgxjbAO0fn8B0VUuUNnI9h8Na6JBGCWLahp
X-Gm-Gg: ASbGncuWCZ2E0y4p2OligUxHJUsVnVuNzAtXDz2KP2l9Bp2l9hWDc5+aX3Ile2n2Zf0
	UmA+V0XCzJq9cGj9DK1fYPqJgR50+pCZjoHWKtMrOZQW4wXVHEMNnKU7Mdf8ztLH2kD3Wf4vAn0
	TOG+znEc6z1HAiqr5vidDs1OeMQOxkfwV2zyvvn4GjkimkaRrRd6aEvYaTL7kTmg/zMx/LGLD7W
	XNSm1AFn0PWkWi7MmICtuTCUac9ePC0nY/SfnJpMMrCuzB9EyFl2NHEviykxnXlpJlk7aXBh8du
	66Chp2etblZrJebnnNywzZ9lAzJiIaAnZh4UeGaWnksGO4ZB5xib5rmzJIIDbnD2oNurrROmkyD
	skpSO+kQ+5rmiLmBRicwBz8QJAc45VrCW6J7JYaPEBgV01xVKPc9QbefQ9Jmrh00+JuPFCVn0q7
	qgRg==
X-Google-Smtp-Source: AGHT+IFTMl7Iu2v9uaiJKg/NvSyBcHv3ge9i73c6OhxrNuGCaGVDTjf7/+54dBjDp2D6UiuwU5idlw==
X-Received: by 2002:a05:6000:22c3:b0:3d8:3eca:a97d with SMTP id ffacd0b85a97d-3ec9e2abaeemr2429023f8f.11.1758034984289;
        Tue, 16 Sep 2025 08:03:04 -0700 (PDT)
Received: from biju.lan (host86-139-30-37.range86-139.btcentralplus.com. [86.139.30.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ecdc2deb20sm932154f8f.47.2025.09.16.08.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 08:03:04 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v3 8/9] arm64: dts: renesas: r9a09g047e57-smarc: Enable USB3HOST
Date: Tue, 16 Sep 2025 16:02:44 +0100
Message-ID: <20250916150255.4231-9-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916150255.4231-1-biju.das.jz@bp.renesas.com>
References: <20250916150255.4231-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Enable USB3.2 Gen2 Host controller(a.k.a USB3HOST) on the RZ/G3E SMARC EVK
platform.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2->v3:
 * No change.
v1->v2:
 * No change.
---
 arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts | 10 ++++++++++
 arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi    |  8 ++++++++
 2 files changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts b/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
index 08e814c03fa8..0fd90d79b020 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
@@ -164,6 +164,11 @@ sd1-data {
 				 <RZG3E_PORT_PINMUX(G, 5, 1)>; /* SD1DAT3 */
 		};
 	};
+
+	usb3_pins: usb3 {
+		pinmux = <RZG3E_PORT_PINMUX(4, 1, 12)>, /* USB30_VBUSEN */
+			 <RZG3E_PORT_PINMUX(4, 0, 12)>; /* USB30_OVRCURN */
+	};
 };
 
 &scif0 {
@@ -179,3 +184,8 @@ &sdhi1 {
 	vmmc-supply = <&reg_3p3v>;
 	vqmmc-supply = <&vqmmc_sd1_pvdd>;
 };
+
+&xhci {
+	pinctrl-0 = <&usb3_pins>;
+	pinctrl-names = "default";
+};
diff --git a/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi b/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi
index 58561da3007a..8b3765b8267d 100644
--- a/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi
+++ b/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi
@@ -106,3 +106,11 @@ &sdhi1 {
 
 	status = "okay";
 };
+
+&usb3_phy {
+	status = "okay";
+};
+
+&xhci {
+	status = "okay";
+};
-- 
2.43.0


