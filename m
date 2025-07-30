Return-Path: <linux-kernel+bounces-751277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F6DB1672D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 21:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99E757A743C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5BA221DB3;
	Wed, 30 Jul 2025 19:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iHG8/XAp"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC7921FF3C
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 19:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753905191; cv=none; b=L780I5h71ArQC8tTj8/n4E6j39rWQ5qvXVmRZfJRZRlX/Imba76/vpBh3zP0x1FxgY8IdUo4VYRGfBHb2CVDNhjqlVsYMcXZ2q4Cw/ZDoIa/sLpvSoNMCm6QajZ7TWtiTM5TcPQKy7um8tOy4ZjDSzThsUmN1BZQ5Ti7LH7tiQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753905191; c=relaxed/simple;
	bh=7RciCMLdB/EjIizO99C1aUwFW6lsuJzA7tbC0O2NF28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JxHYfZsFVUgSdEi+k1p2rnZ5sCnAkN9OVkG7kA/MJaakTK6A5Zlc79GXck8mbzVuEtJWJtYU0jy5RtGCDZMIzufahbhIPFKL9AYkOhX86rlwwzhvAupWlDav8kIEHqaJMPYE5WtTmc+H3iPQV+R4Mx7aHswlI+1e/TwZXGgkaBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iHG8/XAp; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45892deb246so914825e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 12:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753905188; x=1754509988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S1tDMbTuCN3Y0uldNJTdwwCiPIYOQ819zTdnVjVwO+c=;
        b=iHG8/XApc85qDUWizV2U+7+m9PgP6veA1H9ShIOhchCCRqcxUD83EqZ3tlbPDiI9+/
         Ey8dKh1WYnsfLNjqbk5SPP1p6T7IamJJIHeK5WyEFfNW8gkALV1j7cd1Ftlar8AaNdw+
         KhBHR9mPybF/sXGny987HsB09sSvyH7bVXPbT0ZUoMRVOnrEiYqfZYlBFrnVVNglFJOJ
         DfAtMFwZw2BAwF6kTQsf7AkmB0KdExHk0D8fpsoaSR6ZRKC1bqwBwzL0vEKtllS27knG
         KLpZor0qwimmTdKQ45jHhyJ+ULQbCDkrdZ5T11N2V2H910DJbkneeNNtY4AUYT8+utsF
         +P4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753905188; x=1754509988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S1tDMbTuCN3Y0uldNJTdwwCiPIYOQ819zTdnVjVwO+c=;
        b=DfG7WMllIuas1Sx520BSHP3E08UvdlRWqPgeXKFUaE/VbLQAlHn19M3c95/MIHNknK
         ojLP9pXw20DHgTpgf2ALfrOUWzWDNkGRp1EqlZfTSyUIfOJwMNoVE/jq9leEtlB5nssQ
         c2KtCbzi/F1GNN/BXdGwJbaQNH/TmvJoIFTVOblUknXw6xfCAUafF0ctoh9YqlBPNXZA
         4eDSl/9S1B8+bcQzNUOqyV3kvPXoz+ZK6l0diVPqLKnFZJkHNVYK7BJWxM8YfFYz8de+
         TEb0/3cCS1qEWPvqucdED/h/s1A+RhwxxOJSeo+pXlcR/cztGafB8XjYXfmRQDL6UFEc
         MlZA==
X-Forwarded-Encrypted: i=1; AJvYcCVb5r+TWbB2APFD3T//bosbfYQkRsH2sdjiCtrVhbOzMT/Y0e9X09lBKbSAXJ42WQQ5AbT+3DTTPy2vs4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXNnBrYcpJD6D9V47W9+aC8i8Byfn04xHndNygDNtewuavuy10
	hs94jAHXAjrzRHDCo17KxNOvqrSnOWtOG6w5V8DSGVrg8sK401T6UtJT0DlKMp4F5PU=
X-Gm-Gg: ASbGncvGkJIJUyTwtXT/otDeNcVyMhQ8TrbAOgyFXlW7AGz7BUhmcGDveet3ZhpCQ6R
	7j8Avu8uCDniU8akl7H7V/ROl/xF/z9p3WA6NaeTuY2sC+YEkC7Ouwqg+X9ysTCmA0J8WRgVRQz
	hcH9wWnZ3n5b+mCwZttuIeKeNVMZ3anqooOjuPbrmzZ6hemk9vNTP8XniN17C56aVUWOcVoqwVB
	qVjfyBCtxOjCQM16d+l0azct3ZJ/mfrigZslf0ohJ+MM64Wr6Mz53fiUcJlixh25ia51kuWPRbv
	xvvBoVAT8D5UalOvpk1rJLU/MIXJdWViY5mAevgbcYU62lpQyFmpO9eMcF+nihqWZJK7SlX38aO
	v00wFT/tVTcfBl+pVVzZwugDoPsrEWz9NvQBbaD5UQIoYdsqi
X-Google-Smtp-Source: AGHT+IGRYElrDpNrl4+NOhTLGZelVLohbX8W6yyY1T9P0SsEBWFP5ZTfZfawxMYWXsxXjtUKCFrSbg==
X-Received: by 2002:a05:6000:25c6:b0:3b7:8984:5134 with SMTP id ffacd0b85a97d-3b794fc0fb7mr3760889f8f.16.1753905187980;
        Wed, 30 Jul 2025 12:53:07 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b78b26a4dcsm9556193f8f.32.2025.07.30.12.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 12:53:07 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: mbrugger@suse.com,
	chester62515@gmail.com,
	ghennadi.procopciuc@oss.nxp.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de
Cc: s32@nxp.com,
	kernel@pengutronix.de,
	festevam@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] arm64: dts: s32g2: Add the Software Timer Watchdog (SWT) description
Date: Wed, 30 Jul 2025 21:50:18 +0200
Message-ID: <20250730195022.449894-6-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730195022.449894-1-daniel.lezcano@linaro.org>
References: <20250730195022.449894-1-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Referred in the documentation as the Software Timer Watchdog (SWT),
the s32g2 has 7 watchdogs. The number of watchdogs is designed to
allow dedicating one watchdog per Cortex-M7/A53 present on the SoC.

Describe them in the device tree.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm64/boot/dts/freescale/s32g2.dtsi | 56 ++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/s32g2.dtsi b/arch/arm64/boot/dts/freescale/s32g2.dtsi
index 3e775d030e37..12ce02525ae1 100644
--- a/arch/arm64/boot/dts/freescale/s32g2.dtsi
+++ b/arch/arm64/boot/dts/freescale/s32g2.dtsi
@@ -566,5 +566,61 @@ stm6: timer@40224000 {
 			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
 		};
+
+		swt0: watchdog@40100000 {
+			compatible = "nxp,s32g2-swt";
+			reg = <0x40100000 0x1000>;
+			clocks = <&clks 0x3a>, <&clks 0x3b>, <&clks 0x3b>;
+			clock-names = "counter", "module", "register";
+			status = "disabled";
+		};
+
+		swt1: watchdog@40104000 {
+			compatible = "nxp,s32g2-swt";
+			reg = <0x40104000 0x1000>;
+			clocks = <&clks 0x3a>, <&clks 0x3b>, <&clks 0x3b>;
+			clock-names = "counter", "module", "register";
+			status = "disabled";
+		};
+
+		swt2: watchdog@40108000 {
+			compatible = "nxp,s32g2-swt";
+			reg = <0x40108000 0x1000>;
+			clocks = <&clks 0x3a>, <&clks 0x3b>, <&clks 0x3b>;
+			clock-names = "counter", "module", "register";
+			status = "disabled";
+		};
+
+		swt3: watchdog@4010c000 {
+			compatible = "nxp,s32g2-swt";
+			reg = <0x4010c000 0x1000>;
+			clocks = <&clks 0x3a>, <&clks 0x3b>, <&clks 0x3b>;
+			clock-names = "counter", "module", "register";
+			status = "disabled";
+		};
+
+		swt4: watchdog@40200000 {
+			compatible = "nxp,s32g2-swt";
+			reg = <0x40200000 0x1000>;
+			clocks = <&clks 0x3a>, <&clks 0x3b>, <&clks 0x3b>;
+			clock-names = "counter", "module", "register";
+			status = "disabled";
+		};
+
+		swt5: watchdog@40204000 {
+			compatible = "nxp,s32g2-swt";
+			reg = <0x40204000 0x1000>;
+			clocks = <&clks 0x3a>, <&clks 0x3b>, <&clks 0x3b>;
+			clock-names = "counter", "module", "register";
+			status = "disabled";
+		};
+
+		swt6: watchdog@40208000 {
+			compatible = "nxp,s32g2-swt";
+			reg = <0x40208000 0x1000>;
+			clocks = <&clks 0x3a>, <&clks 0x3b>, <&clks 0x3b>;
+			clock-names = "counter", "module", "register";
+			status = "disabled";
+		};
 	};
 };
-- 
2.43.0


