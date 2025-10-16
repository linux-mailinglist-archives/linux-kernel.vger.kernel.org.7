Return-Path: <linux-kernel+bounces-856902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF13BE5621
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 22:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 27E314FC49F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 20:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEC02DE6FE;
	Thu, 16 Oct 2025 20:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CrTqTzKU"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4B02641C6
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 20:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760646350; cv=none; b=LUqwDovm9tqrAdhIUzS1yjVY1V8h7WVS3k5U/SBLF/QoKKkenANM1xjJsujtYVWHgwcxC+NzrV3g5ev8gtvh48ct63YFE2wXjuUGYy/uphkucrLOM+3zYb2eSTXESLUl4Oqn06UDZ9q4bJ59jyLJkyYVQctOhimEijM/iDWdVcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760646350; c=relaxed/simple;
	bh=4MorCO59o4ngT3WTImAyOmAQefEGE/Yx7a5tOnd1kGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jtmS9pZhxleCTlEeY7h4Mw61pmfC7ZAqoaIhWUDFud/TNil85s/VMmchFCTY2LjyRiG3Q1Hr0UDKiO13FQrSFXcUJ4Z9yGXxcCcx+qDc8ulBCrYa7vDwGJY5XVGBPVUXYSYaJ7K7jcE8Gy76fL52cdflz0Tw02owU+vcxwXHxrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CrTqTzKU; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-28a5b8b12a1so12225925ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 13:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760646348; x=1761251148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HoRC8rzlOUghjW1nZB0Ysh1s7K2vI38CKjf2YVLdEpk=;
        b=CrTqTzKUqyrRvB90hUC5edlQS9trliF9EWavaGIkxezk7tnM8Ot5Nm+7ZzNw4nrJmE
         0WXt+nnvWW5EmM2OjjFF156X8qj0+FKEoJcCjM+yCbzz8wJKkE7dBsMQ/1Pp8HvTFcur
         +j4Ypq6pWan/CeInJamcXuFuI0nhwSLHzlRr0nZOz3ucZej3Bh3hdKCuyp4pwVwa7UKI
         x2MlLGKOeFp9iqWLkapqUhSGt2aG2k7PybQOt27+JlBVnHXGzzDzliJoicbLDZMXtF0B
         7n1niCa2aAUca+axeBP+lYq8O4GOAYFOKcq1WullApg42ZbVGuoMnhGnC9677rXKI5Hz
         MdXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760646348; x=1761251148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HoRC8rzlOUghjW1nZB0Ysh1s7K2vI38CKjf2YVLdEpk=;
        b=qcJ/JIBHvP99ALr8scz/TrID/jPoeVIWWpdJp6owqOaz/0ucjy96dJo2wNXIMXYGYW
         rDiBvzc67/6YBZOLyn/9VxA57bHtOQCLm2kgmxrrED4cii9FJM0GtpItqCpRPZxnbZq7
         LXx634MdEFtxG8RtGCRjTLpqYyiNFqbyQqoEnuQR6laMINOk4MWYg25OyLktqGYX/ipT
         CdveqHqXvSaCQ+rk0n+fqgrwZVKitm0XIW6LJxIcFNzFKYWsrHa7Et/iuDZgowN1SmV7
         Vt+G0ljM9duZmc38CGdNum/Co0vFEOUJf0j0EayW7XXu2inzxKJ9pGgM0mba2SnwR3up
         FP/A==
X-Forwarded-Encrypted: i=1; AJvYcCVcaHjXIadZvwdva0enOLJ4+rg9agRIeSpHFqGs/Yv1OiPWK3LHbtN9P9InmhYiw5DOkdVUWkqj51GaLgo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqGa8EqA2rCnZWZtyi1MT6/qcmcrQKjA1n9mAJrq2UBXqUCv3V
	gNadSZONcBqzudecDuN6enGHhZLLNPtYLMD2f5/UL9GSTUQRS+5STdKb
X-Gm-Gg: ASbGncsa/8d0DeCvMnMDanfDcXxT7QX/kSdiLJaPQEO0k7krRJjcf690+TU4r78yp5Z
	ML5pnb0EHIxLkpYiX5/ATsxAm9xgtwtI/zpmydbjhOdUQx4Hn1CpUtBRlo3pv4Qeb1RYlTr85SZ
	eESvpkIDbbUohfEaR0hJmxpCokgns6knBr0hkhHQSMUwAunhkGhSQa6AmMZZ6Fsy6K7GNCklOm1
	S9A5Q45DmCoQXpNdu0fbzsuFpktgSvabX26ZIDceYbszby5yaC+Jsk1vwU51sHR49ks/2Cm3yPk
	msIbgElwZCLD5SZJAmh5uKcS9pt14HTMB3im23gkeGwUdBDODHWADZ6OuF7Qfurhggs4P+ItBx1
	szKKqz9s3OyFaNXIFGVIQyFiyx+R+DfcSHRghMjg16htlS3NbuQpcIrDdxPXNA7G+4kOjtSwiZB
	xfnWRQRYa6nSOp4xvl6ejvDeEymT1g7Y3V
X-Google-Smtp-Source: AGHT+IGU3Gnxzp4j9ETrO7y+Ta4C1JD8pRmYX7qSuu7CWNXyZOpSTIP3EnNE2PmrlvN4UF+sZNpcIw==
X-Received: by 2002:a17:902:f687:b0:290:79ac:a0c3 with SMTP id d9443c01a7336-290ca4f9a89mr15044565ad.23.1760646348049;
        Thu, 16 Oct 2025 13:25:48 -0700 (PDT)
Received: from iku.. ([2401:4900:1c07:c7d3:a396:54ac:a48f:c314])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099af9131sm39577735ad.103.2025.10.16.13.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 13:25:47 -0700 (PDT)
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
Subject: [PATCH 1/5] arm64: dts: renesas: r9a09g077: Add ETHSS node
Date: Thu, 16 Oct 2025 21:21:25 +0100
Message-ID: <20251016202129.157614-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251016202129.157614-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251016202129.157614-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add an Ethernet Switch Subsystem (ETHSS) device node to the RZ/T2H
(R9A09G077) SoC. The ETHSS IP block is responsible for handling MII
pass-through or conversion to RMII/RGMII.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g077.dtsi | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g077.dtsi b/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
index 0086f7953cdc..e397dd262c76 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
@@ -270,6 +270,43 @@ i2c2: i2c@81008000 {
 			status = "disabled";
 		};
 
+		ethss: ethss@80110000 {
+			compatible = "renesas,r9a09g077-miic";
+			reg =  <0 0x80110000 0 0x10000>;
+			clocks = <&cpg CPG_CORE R9A09G077_ETCLKE>,
+				 <&cpg CPG_CORE R9A09G077_ETCLKB>,
+				 <&cpg CPG_CORE R9A09G077_ETCLKD>,
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
 			compatible = "renesas,r9a09g077-cpg-mssr";
 			reg = <0 0x80280000 0 0x1000>,
-- 
2.43.0


