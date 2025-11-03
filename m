Return-Path: <linux-kernel+bounces-882892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F00C2BCF7
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 13:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41F4D3B89B0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 12:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588FC313279;
	Mon,  3 Nov 2025 12:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="eRWAJG4b"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7123126DE
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 12:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762173618; cv=none; b=lwrTj435det/jjjs/r9RVmWjpehXc/GDxa+molt1HWKjLGg/ipUUhVYOLsPUFSU6MPii7wDocbvxxP2Eetas4eVtoLeOFVjm7RsZ8EBV43QFYhIwTUuycNLmmWcm2Cd4vq6xdVWqnbwz9+ciFaEtonKqv04z/WL6chQg1ix5TCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762173618; c=relaxed/simple;
	bh=6hGcnBOkrSMQIKieC/McV84XZyXymXT7FDaWvZWNWbs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jBsVMDXwL3Cd46WAN1fek86vO98YJ98mKLbMLast1H541+pzwOgSiFybWVrzgczidoCQg8qDP5kuLSp+VUmJJ9mC/++FhEUkfGdey1fzuLu50NnlYIHzZFM6zmLDHJp23dtPOIvcRW0doT7Yz1v0USI2jFe1GLqfBM4WiytVoHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=eRWAJG4b; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-640b4a52950so1318668a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 04:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762173615; x=1762778415; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wJeAn8jSSo6/JIcJaohDppo/oGstUTXUuYjdPwTMcs0=;
        b=eRWAJG4bVy4QyGFoCeVd6LfvAKURh8+/VZwRJvXP1RN/w986oKpAs2dlTP+evLpAJi
         rsD1S4w30x0fLfEqUCLMbjUcP/pTiq4UO4XnaYXxuUJd5o/sChP/ggCm0rzakfs2yWBb
         AKsq9LcuZJxp+bUmo+hY7lK5hQ2N2jyJ/3S3b298eX15sfRJ1W3/bfDNb/Mm7zAaINlK
         g3QxxrjXubiZ1mepz5VMeWwGcW/PuRpNo3uhtp5y301WrS5MU/MD1m/QUhomOS81jeAh
         xfnd628HkZMi4rtz1/u+QI+xZA2EBWAJxDidVmO2P8WWXKFi+fwk56TSs3FTKj+lz9XH
         sGLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762173615; x=1762778415;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wJeAn8jSSo6/JIcJaohDppo/oGstUTXUuYjdPwTMcs0=;
        b=VFwRW7MZK/d3rDqt53wnBfRSNhAPpCsyXMiqXk6DZHmX23AuEIkelWXgOn2Dcq8bpp
         dSMPwQyU/mj23GEWo8DVowZzXH3Nv9+8TX4cLQyEoljvhhG/ka228HMWLAWDYWY7+9cl
         QBVtyJv/yGruplVClMCVxCNUWFe2DUIWfODPWYW72SnQqqyRcaw/7vlGaYKi+9ZAN9E8
         U36kjTaPDDNbaIVq8pMDkhG6Jh1ZD3APKk7OLHnDn3bXTKbBqoO+EjYNwBVIk+w1RtuR
         21Kk2gMJRDafqITH7yO8+GrA+wbfyW+Jk6pHhYvoPNixGSzHgg33IKZ+ws6UA8gdVyQG
         i3bQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWg7f7RwjyocEl18DmrsFuIVx1A3swyNGrIKdythKJzemlBNQkxVOkC8hg3ak7uDpLM6rIyisBRy64S6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR/uOfsIZP2zAM4Y/4DzxTvf9+YKOi7mXFd6hoYGDDnrOUm7W7
	vqcAGkchKxONH9ZbvYhGL562hd1c/9dq8sAUGn3CqXUBed+PLZXVCOLLsJ5913Uc8Bk=
X-Gm-Gg: ASbGncty0/z/S80pfiZccg/VqOrexw9XOmEK23riaBAGzNg4Qex6FSYcsqSyLP8+dqn
	wbqy36GIntkFvj9Kro/Alw6QnCa/UqzeElByXTLZqIUjTT7Tpm2PZLChg2TA+BtzzUTHfZGy4a2
	VdUCR48nxCTuzlI2Z5rbv/ktZbFfRb94SyMd6akrfwN0bHhk3Bwg/mzGreNg84B4p7XM5lRscrm
	65IpVe/WabNX35tfb2U4Uw1mDjX07dybQUcs8oFZNb7Ph+GvmSVhhJag8JFyjpPsWUk+/AzEPFX
	+BV8zMEUtivt9QjDYCCnvF/tXb31y5t87P9jnfS5k/Xbs1XHtJcpAQi5osYr/UUjpXHC1F5jnVY
	a9ml+MBk0gnS3CM1X9vIk820X7l/hzn0x0D8Am9SeOZR8/vGe+IG3HI8bII+anBasLCHHnEE=
X-Google-Smtp-Source: AGHT+IFtVVqljuKCW5f4r6Ri/wyAAiuSHubsIp0V9cF0MgqTvnQQpbVTM4xuWKtVwgdiUdE8atDHyQ==
X-Received: by 2002:a17:907:9484:b0:b40:da21:bf38 with SMTP id a640c23a62f3a-b70704b654cmr1222307566b.36.1762173614941;
        Mon, 03 Nov 2025 04:40:14 -0800 (PST)
Received: from localhost ([2001:4090:a247:830a:fe22:a8:f29a:a5c3])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-6409ad0d7fcsm6763392a12.37.2025.11.03.04.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 04:40:14 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Mon, 03 Nov 2025 13:39:30 +0100
Subject: [PATCH v5 3/6] arm64: dts: ti: k3-am62p: Define possible system
 states
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-topic-am62-dt-partialio-v6-15-v5-3-b8d9ff5f2742@baylibre.com>
References: <20251103-topic-am62-dt-partialio-v6-15-v5-0-b8d9ff5f2742@baylibre.com>
In-Reply-To: <20251103-topic-am62-dt-partialio-v6-15-v5-0-b8d9ff5f2742@baylibre.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Vishal Mahaveer <vishalm@ti.com>, 
 Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>, 
 Sebin Francis <sebin.francis@ti.com>, Kendall Willis <k-willis@ti.com>, 
 Akashdeep Kaur <a-kaur@ti.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1357; i=msp@baylibre.com;
 h=from:subject:message-id; bh=6hGcnBOkrSMQIKieC/McV84XZyXymXT7FDaWvZWNWbs=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkyORVO4zlYb+XjuFNbb80/xB5vjh8z7fb2SysedJPd9r
 +Va+JS5o5SFQYyLQVZMkaUzMTTtv/zOY8mLlm2GmcPKBDKEgYtTACbifIiRYVkAL4ton6lHQkOp
 oNsa8dIOnRAu/5D2CT6CruxODC7LGRkmv4sUdeM/JFNwb/Ixj7SuDumLy3y/7lN7VnWE8R733BA
 mAA==
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

Add the system states that are available on TI AM62P SoCs.

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 arch/arm64/boot/dts/ti/k3-am62p.dtsi | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p.dtsi b/arch/arm64/boot/dts/ti/k3-am62p.dtsi
index 75a15c368c11b068430362fe0b8d2d9ecc052588..c69e16f16c835489f2bc5cba158235ab955347e3 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p.dtsi
@@ -44,6 +44,33 @@ pmu: pmu {
 		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
+	system-idle-states {
+		system_partial_io: system-partial-io {
+			compatible = "system-idle-state";
+			idle-state-name = "off-wake";
+		};
+
+		system_io_ddr: system-io-ddr {
+			compatible = "system-idle-state";
+			idle-state-name = "mem-deep";
+		};
+
+		system_deep_sleep: system-deep-sleep {
+			compatible = "system-idle-state";
+			idle-state-name = "mem";
+		};
+
+		system_mcu_only: system-mcu-only {
+			compatible = "system-idle-state";
+			idle-state-name = "mem-mcu-active";
+		};
+
+		system_standby: system-standby {
+			compatible = "system-idle-state";
+			idle-state-name = "standby";
+		};
+	};
+
 	cbass_main: bus@f0000 {
 		compatible = "simple-bus";
 		#address-cells = <2>;

-- 
2.51.0


