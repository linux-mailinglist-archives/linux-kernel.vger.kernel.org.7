Return-Path: <linux-kernel+bounces-874438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E320EC165A7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 19:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A06E83BEC7E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9891534EEEA;
	Tue, 28 Oct 2025 17:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k5RjJpfA"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9067C34C9A3
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 17:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761674122; cv=none; b=dyYhxegoc+xUyo+Tv+MpDyTbNUn8+7reqTxCY4MwSk3iLVo9+99qlxEsh9FbtocnTC4kvHHpEGbNpLb7UEKNqHBNxQPrxiS10w7yKbhJWoh3VADVycq+0KHv+tcyvly32C5Yj461TcoJBrfCmm3t2NawG9M+5Bb5f+bL19z8gfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761674122; c=relaxed/simple;
	bh=sk58oMsvqvthp8Sb3XNcmu+ux8iLDsOLB3U0EqxlW+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LLp6pbDlQMPkLCBZZO/zUKXui20ZK7fjyYYw2KwNRvC+ypVnJDLSxXBCaKm/Yu+cbkIS7JJx0Lmb9MKxBkUrY+p7QjrA0efPqUVGbacq0sWj7r3DnpQQr4OhK6RkhXHAJI68nEaxLCGcQPOADv9Cxt4idbQMnWxzmUJHqpv6k34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k5RjJpfA; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b67684e2904so4554686a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761674119; x=1762278919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHxfmdeCFW0aCq5x00keTOMAkOcoFT2JLV5G6kLYawM=;
        b=k5RjJpfAA+VrI0hnF5DzvOQEUm7po/aE93Ek+zjvQ8RAzuS+HOxl5nyN/EuBiYHH0j
         9Vxi++qffsTJjXm0FyAZ3K6nliJ42nB5fD9wzWnms/yEo6ZS71V/W3HV86Ockc5cRAlp
         0lxAcL9fd1AjYpl4e97PQQlrGtSgJNKgJmB4QISd4zHk8faGfeNFlIHOtxYTF8vo3hOL
         nUkV93urAV/swopsTePIAOehrKxrTU6s+GGX6NX0sFPi3Dr80LV71uvwxetSiA3mpvOZ
         CF0Z+2dD0pYe53ZWSS6ui7eVTnuuO5swTwhdksgMb1JtxaDAE5fbR7rPmD6UDt5kQ4jF
         Dr/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761674119; x=1762278919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lHxfmdeCFW0aCq5x00keTOMAkOcoFT2JLV5G6kLYawM=;
        b=ONrP2nY2M4MIUXf3JyO23VFs8z6c2Kvuf4iYHTdHImx+uGyc91t9MIlAm310vo3cEd
         boOAO+fsH+zXhue51HXr6cJMbxnynYioxajX5zbyL5H9JscCF5xwbX6X/GW2mWP6V7bv
         7XW5KCvQ5+SvR8db7OxZ0RA2lcfvH03LRUZ+VXj2VUizXTlmdJx9zx+kqxIts6JbAfo5
         UXCKIG1VGQgU5a/g7dd+HEYtBaGBEbdwFRTWLj4d6wrUYA2KPBBFm8rsHhiMt3mTpyWY
         AFaKbwmOAj1ShMvV57MHmLHMfvwza/x2F6hkWgNDiiaHcYVSO9xyxRwRFj/zg84J7m97
         Ezig==
X-Forwarded-Encrypted: i=1; AJvYcCV7i99SsUFlCGIWwf38+8dP8qmEBBuL+5cB/dXS3Mcz57e+y97uVCJ7dwMHu1UbTrNsq+x0fweO5xzZOMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPUmNeg6w1YnTFVlwpwU9z2X+Ps2BDqvcYBhmve22mHcVTF3W5
	/zccl8jb2ejWz+ksXtsmm64UsIvWfGQQPUdZTXCN88kJXaM0IbxNZbeE
X-Gm-Gg: ASbGncuy2kUgfTcayBhJuQFtFjoRlFC6xeSama9VqcTkS+nAh3E2JMqYqHPC4G6btN0
	V43qFc9Fcz3dg8h1iu6eK4xkeIJXCd/CwfkHE/4QqBxdgUDOfAyCUVAvDIQ8n/sYrn9Zf9mA340
	rt6aXxuPdlq/SQynEKEuRX46mQS85920fl3zLilqyk4y5yJABJQJmsa9e9ZOslzW0ihOfuGdFEV
	WbbCOB0gReCwCpfB6vNWqVeHB0XjaybRCoBj33bKPIQC+lYDJVx+jxZQQFXaL658YpJUZbft7ii
	axPgkdTUYIy1PQr5hl8bJpynaztlvgDLpq8FwY5vN6z02T1zusZ5rDuD6Dx+gW4j5pSFHr1JQMY
	XKAn/3Q6LPdixrm5zvkOd2fagV/jWHplMDp6DOs38NTXurDummXVI9C6xZk98RqC5Ajj+bOXwSf
	dAgv6m4kfTmMa8HjqPDAm87g==
X-Google-Smtp-Source: AGHT+IE8fi7wgchyIC2rRpsiOwRv/Y9Zy79HUMma+Z/tBt8eFg9esKKv8OGA2Wlc6IDn+6DYsFdD+w==
X-Received: by 2002:a17:902:cf0e:b0:276:305b:14a7 with SMTP id d9443c01a7336-294deec896fmr406115ad.33.1761674118818;
        Tue, 28 Oct 2025 10:55:18 -0700 (PDT)
Received: from iku.. ([2401:4900:1c06:77f0:168f:479e:bf92:ce93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf3410sm125713005ad.8.2025.10.28.10.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 10:55:18 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 2/5] arm64: dts: renesas: r9a09g087: Add ETHSS node
Date: Tue, 28 Oct 2025 17:54:55 +0000
Message-ID: <20251028175458.1037397-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251028175458.1037397-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251028175458.1037397-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add an Ethernet Switch Subsystem (ETHSS) device node to the RZ/N2H
(R9A09G087) SoC. The ETHSS IP block is responsible for handling MII
pass-through or conversion to RMII/RGMII.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2 changes:
- No changes.
---
 arch/arm64/boot/dts/renesas/r9a09g087.dtsi | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g087.dtsi b/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
index 3ece794fb0a7..fe0087a7d4b4 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
@@ -270,6 +270,43 @@ i2c2: i2c@81008000 {
 			status = "disabled";
 		};
 
+		ethss: ethss@80110000 {
+			compatible = "renesas,r9a09g087-miic", "renesas,r9a09g077-miic";
+			reg =  <0 0x80110000 0 0x10000>;
+			clocks = <&cpg CPG_CORE R9A09G087_ETCLKE>,
+				 <&cpg CPG_CORE R9A09G087_ETCLKB>,
+				 <&cpg CPG_CORE R9A09G087_ETCLKD>,
+				 <&cpg CPG_MOD 403>;
+			clock-names = "mii_ref", "rgmii_ref", "rmii_ref", "hclk";
+			resets = <&cpg 405>, <&cpg 406>;
+			reset-names = "rst", "crst";
+			power-domains = <&cpg>;
+			status = "disabled";
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			mii_conv0: mii-conv@0 {
+				reg = <0>;
+				status = "disabled";
+			};
+
+			mii_conv1: mii-conv@1 {
+				reg = <1>;
+				status = "disabled";
+			};
+
+			mii_conv2: mii-conv@2 {
+				reg = <2>;
+				status = "disabled";
+			};
+
+			mii_conv3: mii-conv@3 {
+				reg = <3>;
+				status = "disabled";
+			};
+		};
+
 		cpg: clock-controller@80280000 {
 			compatible = "renesas,r9a09g087-cpg-mssr";
 			reg = <0 0x80280000 0 0x1000>,
-- 
2.43.0


