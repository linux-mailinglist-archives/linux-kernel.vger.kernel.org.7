Return-Path: <linux-kernel+bounces-802542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 455F1B4538D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CECC7A191A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616A027AC3D;
	Fri,  5 Sep 2025 09:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Xjoj2vRI"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DAB2571CD
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 09:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757065252; cv=none; b=ZKIpNbucBNb6pzYoicAJnA8Rk4CMfR/vIeOAy5gzEPsGnYSSWmZdf9QGsRnT2UnHJu0hIBYk5NgMiudDQiFLTCEmLOVeJvSYGfJJZxsMsXE+VJK5dX40ObdqR+fNWYHJb84CgZ5F39dLfAutXztXXvwrh0kbVJ2C113xYjEt2sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757065252; c=relaxed/simple;
	bh=EDIb3s8WJz3IT6jQ4AIZWqSmKNckUnK9mEaJyhV+Zzc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=DkQkR1ZROy2u6M22DcRNhvxPmXFjtqUdObxtiswucyPYwt1+5uSRT2t+gPLtZlDGZrD2hk0p845xnUjcC4Nm1zAiGwrJIpuFfVgJC7MdXykWLIBFj8wAowkv/JxEj74gcLhx6pE2nYOJCcd5xpbHa8QQf0kSxICk9uYDXMY3lYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Xjoj2vRI; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b02c719a117so366501466b.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 02:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757065249; x=1757670049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=J/4ivpOE8qtitd/efpLlMj5E5YlfY95TXIstr7HGuK0=;
        b=Xjoj2vRI8nYgcZEYHL+vOezLuSylXFKNcdTok2cuAkdvFQYraTvtsfctPrcSyw/xCf
         XzrDQON7KEsJ3W+sUGspybeaoIBC2gYelINGJB8aBNiO7fvhB3bvRe0ym+CSF4Vb7vB2
         TgAkibK1VbIs8JXr2zcN+qfdGO+TKbJuF2+ZeFGeq3bhN9m2Z0T+d8E/rKdRCRwX5C5n
         7pFOl5+tYLps/Fmr7uQxn3KS+7C6CbJjUiUygrZ0LKNt3DBIKQy1Kl7AITiCsJKr929y
         jsb6o8LPdhu59LCvSezsYcCTJZo7dQPVdMC9lFWwaHhylly/x1XOsq5D9mDw1CoMVbqN
         TdRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757065249; x=1757670049;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J/4ivpOE8qtitd/efpLlMj5E5YlfY95TXIstr7HGuK0=;
        b=pu4DjTKiiWKETC6X5EliPJipGTBWt2xV8Oqypoehy2sAhJfkckG6poQgAXT3svEybw
         781eQNirEcxyjV6yrZpCS2MzB/zfLkIEKBeXQB4Wl4dVJVxMMp1xmdRmBGPgmWf+F3K5
         x47D7k3S0lzy/WH67r28AbFvLeY5lh9tPRaxNYSrm8cN0rZQbbPUfpPAOJUQvAqaUe3P
         Ci3deNADa45GkGeFym0R7Ox/H+hyCQUhKciDlc3y+fQu8MSxFHdplfBZNbfNvovChEqW
         3Q9+gIULSHrfg2rfdTISONkPcXPNIfmwqmt7ebU0RvRbdmvIV3N/+gm7qWxuBjxiBVoo
         MxYw==
X-Forwarded-Encrypted: i=1; AJvYcCWxdSxZZ7mcL+X5jbx43u84ywl9bySKqqGN3wMdQrVj+W/VaitYlY9ULl45Tfvq3J+tWlIED3DD1a2EqDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeDncNxHsfgPq/Bw4QLl899T7ykSEJAyzXkpzrcBSx08LmacBp
	3nKjLPfDp6+yzEIAdCe3yEEU3cWBcmy6R/5i1sfrWW8laFYZCE/ukCnUFF/DjGl7vLQ=
X-Gm-Gg: ASbGncugWygdyeWLcKLFMZ1y4K10mpg3P7s0J6DS+DnowrPcTsP9bNcw/dZfQ30DfTy
	5Xg7JwcTJlRPDnXG52TdEh31c+OzoDV8A/itGwKhV4dENRxrJVpaDCz3m7v5Ae93LZaP9LdZ3C9
	Hij2IqeBRUFC4MjSbsz3V4CdGSOfCVoWFPdruD/IwRo6+7gxign6+82xqjYY4i7f26xnPsM/rQ3
	mgNq2dvBNlTgIEYj55G0J3vW0fy7cVTB0uWpx3bCDcnIu1OrV8IOdIeZUQdT8vDt4kUX6093dlC
	rzBMl/LwA2WqosS696aVdE6jw2aXPai+45eZg1tEx0hHs9+IUWilNLcLPgAD7XwerVtYLZmmUx1
	mu+ASyAhkFsBzJ2RuuLiu1jRDlKL3z1gEBFtQ1j/UBt/zKWDkFtiofEKeSY7x59Y5vstFlLWNBH
	gwQU6j+EDxbiXy+qozsbsRfJrki5K1JWpS
X-Google-Smtp-Source: AGHT+IHUDHuJjsleRsQTk/qSu97rV3jdhcfaODQkbUhAaumpEvisyB/1lzmWlJnkChbNYC6NWWQ7mQ==
X-Received: by 2002:a17:907:1ca8:b0:aff:321:c31d with SMTP id a640c23a62f3a-b01d8a277c5mr2226502466b.7.1757065248826;
        Fri, 05 Sep 2025 02:40:48 -0700 (PDT)
Received: from localhost (host-79-31-194-29.retail.telecomitalia.it. [79.31.194.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b04279a59ffsm1228257466b.60.2025.09.05.02.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 02:40:48 -0700 (PDT)
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
Subject: [PATCH v2 1/2] arm64: dts: broadcom: rp1: Add USB nodes
Date: Fri,  5 Sep 2025 11:42:39 +0200
Message-ID: <16d753cb4bf37beb5e9c6f0e03576cf13708f27d.1757065053.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RaspberryPi 5 has RP1 chipset containing two USB host controller,
while presenting two USB 2.0 and two USB 3.0 ports to the outside.

Add the relevant USB nodes to the devicetree.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 arch/arm64/boot/dts/broadcom/rp1-common.dtsi | 28 ++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/rp1-common.dtsi b/arch/arm64/boot/dts/broadcom/rp1-common.dtsi
index 5002a375eb0b..3be14ac53c81 100644
--- a/arch/arm64/boot/dts/broadcom/rp1-common.dtsi
+++ b/arch/arm64/boot/dts/broadcom/rp1-common.dtsi
@@ -39,4 +39,32 @@ rp1_gpio: pinctrl@400d0000 {
 			     <1 IRQ_TYPE_LEVEL_HIGH>,
 			     <2 IRQ_TYPE_LEVEL_HIGH>;
 	};
+
+	rp1_usb0: usb@40200000 {
+		compatible = "snps,dwc3";
+		reg = <0x00 0x40200000  0x0 0x100000>;
+		interrupts = <31 IRQ_TYPE_EDGE_RISING>;
+		dr_mode = "host";
+		usb3-lpm-capable;
+		snps,dis_rxdet_inp3_quirk;
+		snps,parkmode-disable-hs-quirk;
+		snps,parkmode-disable-ss-quirk;
+		snps,tx-max-burst = /bits/ 8 <8>;
+		snps,tx-thr-num-pkt = /bits/ 8 <2>;
+		status = "disabled";
+	};
+
+	rp1_usb1: usb@40300000 {
+		compatible = "snps,dwc3";
+		reg = <0x00 0x40300000  0x0 0x100000>;
+		interrupts = <36 IRQ_TYPE_EDGE_RISING>;
+		dr_mode = "host";
+		usb3-lpm-capable;
+		snps,dis_rxdet_inp3_quirk;
+		snps,parkmode-disable-hs-quirk;
+		snps,parkmode-disable-ss-quirk;
+		snps,tx-max-burst = /bits/ 8 <8>;
+		snps,tx-thr-num-pkt = /bits/ 8 <2>;
+		status = "disabled";
+	};
 };
-- 
2.35.3


