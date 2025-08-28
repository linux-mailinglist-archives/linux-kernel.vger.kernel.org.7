Return-Path: <linux-kernel+bounces-790094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D4DB39F4F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 15:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 112881C205FA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 13:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAEE11CDFD5;
	Thu, 28 Aug 2025 13:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="O6Vcntji"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411831E32D6
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 13:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756388895; cv=none; b=XbmhsFknmVNaP/v218EiUNBUjCkSwrc21Sw1fDG8AqgpCpU23E92Debqxf4aUOh0HNDtnhZS1W7BtBdNHWDKZ6ufEDRaEAwlFsgxjNW7QdX9sN3cKKvBd/mtwA42KFerKByL4j41Wp3XddAdyax77UK46a2TiR9PpBMrdyEIvrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756388895; c=relaxed/simple;
	bh=yoqIoDX6mNRAd+QNlEthQLnCb5/yYRoOXkiDgoqlFBk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=cSYFmwohpMzBCVd7ZtaDrlsf2BvtanXGx4w59liUyVm0JVQTuy0uxKAn2a0+Bond4PcxOXX+cs4YgONWS9rdACOFVxtwTUQCBcOgU06MftV3y0SIjbOyauw5eADr5OQwU5dHgoJLdSaPAoRu+ejcvDmCqORL/SDBeEttdgUH7Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=O6Vcntji; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-61c26f3cf6fso1765409a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 06:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756388891; x=1756993691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8ofMDnt8aegB1RhhNAN0+9aJ+qAFEpSg+iG9bqL1LWI=;
        b=O6VcntjikbvTAeRxEoR/jSHzdhKKepuyyOe+8pm5SqwKmA9Fjf3EZ5tP6ozmFjGe9w
         oUlb87dOPTlhJaDQTPkkexKViXdeez4s3wBMbUj5o7RBsNtr+C5aMlPSIvEmQa4AmU1E
         ylYiyS/QKQYUwE/qYklEgPSQ3W4V2+4HVWNmFJWbDZVUzZ7q30/Mp9NFmBfOlHpvJDnq
         KpUu60uxg4cIuIWYFADiE4YWw+BZ4nUaQgVtRTrXLqo06hC3nalA5Xs9D54QB/LS9tMu
         N4oWq+pMrBQ+eH7QbFwC79lZrp71Pg3/ecjTfpN6WU4u1/X9P8Ou17koG4cdpyR61St6
         HpOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756388891; x=1756993691;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8ofMDnt8aegB1RhhNAN0+9aJ+qAFEpSg+iG9bqL1LWI=;
        b=Fh0v3BPwkSa9RWgY0p0JYSaB1WRlObhcfWUJzCw0v2gXiXEFkUo6aAOYnvoMHmWohN
         b2ujzNCWj7ej0kxc83QYfebc3Fi4PcpNha+oLShFs0F7FfX+doC/07XkJuuFsZpKoA5d
         0HZp3YBBjYPesrkr/2iiLyJIrZOiTmFE7D6kbW1V0EiaLwMm8FoWL5rTE52OI37ZtmdY
         BQ3Hu9+HU1dlAJyY4svKc7Wa8l3INS9pqg6lSIF0NOmoHAXqlaSyscQqXXs+zfPliQfL
         VBhwUcKZUxeCPgZsR6oDGGhKMCo49xQ2IIxEvmflG12XN12yeOaSSknwhFgOmvUM9qx2
         628g==
X-Forwarded-Encrypted: i=1; AJvYcCUBn9NYMFRX6lAsHdMgeVgbmLzvsudIqWE7aaF1IuHKr2DmbnXRCginlD08rkySV/6DW2CP3W/C11fRbZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YySWBWrmKCiPWqG3kHirjiCnydFHY3L3ScwPrnsAJbxcq+5f4hf
	hWmwempBShxsti/IX72XTu8cAzpVBjguFV7VkBjllo1b+hISpgpQmZyv/+4TBklJNsQ=
X-Gm-Gg: ASbGncshg1Ib1u9JdtF97Au7hCwtj3dp/RhW/Js2lDrXOh9Rl09/hyzT/0rX9wNU0Ar
	ZxGjfa1ZVJXsF5DJmIFsBcJ/VFJsKxQ23qtCbgf/dJlhhLFIRE1RzWhPJsYeQ9gDxKZjkLyq4SH
	rc9NnTZi6j4Qc08DuWYlz3CdE78027nuLXDVJywWJmXkRxCNBIKnwsw0FFRrxX2TN+XDE6++NXI
	fEcfC1iBanZuwK9h6s15rWddwoqb26T0QktVtJ6rClzcE783lZAwiEyrWkRJeiDvcKyp86xXpdw
	C3AGBTwW4y9l7lT4F1NxyzRJAkIg74eU5h1YIlAqGW9hSiHd72DMsxRCoM1sh1Z13tXEBi+9xwk
	2xtv6bg+HR31tyx7NDfNO/YWWK5UJDVz3Ksd2ZeZRp2jDEsjSksgSu+DhpksCOLJcE9WPa3XJdl
	WUiaBfWpQduevtD6EAkAkO9+UAXyk=
X-Google-Smtp-Source: AGHT+IFkrszRCxrFihFU24ZaJl7ZC3CwfnZHIryHv8hl7fJKUiWiXfcIaoNunoVL5GDO8tLcbR0fRQ==
X-Received: by 2002:a05:6402:430d:b0:61c:9585:9eae with SMTP id 4fb4d7f45d1cf-61c9585a269mr8045358a12.6.1756388891487;
        Thu, 28 Aug 2025 06:48:11 -0700 (PDT)
Received: from localhost (host-79-36-0-44.retail.telecomitalia.it. [79.36.0.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cc8d32821sm2092757a12.9.2025.08.28.06.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 06:48:11 -0700 (PDT)
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
Subject: [PATCH 1/2] arm64: dts: broadcom: rp1: Add USB nodes
Date: Thu, 28 Aug 2025 15:50:03 +0200
Message-ID: <4e026a66001da7b4924d75bd7bee158cbb978eed.1756387905.git.andrea.porta@suse.com>
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
index 5002a375eb0b..116617fcb1eb 100644
--- a/arch/arm64/boot/dts/broadcom/rp1-common.dtsi
+++ b/arch/arm64/boot/dts/broadcom/rp1-common.dtsi
@@ -39,4 +39,32 @@ rp1_gpio: pinctrl@400d0000 {
 			     <1 IRQ_TYPE_LEVEL_HIGH>,
 			     <2 IRQ_TYPE_LEVEL_HIGH>;
 	};
+
+	rp1_usb0: usb@40200000 {
+		reg = <0x00 0x40200000  0x0 0x100000>;
+		compatible = "snps,dwc3";
+		dr_mode = "host";
+		interrupts = <31 IRQ_TYPE_EDGE_RISING>;
+		usb3-lpm-capable;
+		snps,dis_rxdet_inp3_quirk;
+		snps,parkmode-disable-ss-quirk;
+		snps,parkmode-disable-hs-quirk;
+		snps,tx-max-burst = /bits/ 8 <8>;
+		snps,tx-thr-num-pkt = /bits/ 8 <2>;
+		status = "disabled";
+	};
+
+	rp1_usb1: usb@40300000 {
+		reg = <0x00 0x40300000  0x0 0x100000>;
+		compatible = "snps,dwc3";
+		dr_mode = "host";
+		interrupts = <36 IRQ_TYPE_EDGE_RISING>;
+		usb3-lpm-capable;
+		snps,dis_rxdet_inp3_quirk;
+		snps,parkmode-disable-ss-quirk;
+		snps,parkmode-disable-hs-quirk;
+		snps,tx-max-burst = /bits/ 8 <8>;
+		snps,tx-thr-num-pkt = /bits/ 8 <2>;
+		status = "disabled";
+	};
 };
-- 
2.35.3


