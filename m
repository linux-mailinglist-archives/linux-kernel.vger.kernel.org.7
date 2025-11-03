Return-Path: <linux-kernel+bounces-883653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D28E0C2DFAD
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 21:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ED6964EE6B9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 20:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F66C29AB1D;
	Mon,  3 Nov 2025 20:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFPHBCqC"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6302629994B
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 20:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762200274; cv=none; b=pPUNsIH186ROw71I0TOM3yZ9ZSg+qSLaRQVTkx6oWs+KlLfcxFb+CyzdNBnMylGA2lL4uQpTowy4uv9dZW8Fy53pSSalyoeTnebXvJQvvydIJuRY/2WQILFbXpuOXV+9DEVmbrQQTQjz/QpADgOwK8OJ8/Z+jsuF5xECdgRZAFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762200274; c=relaxed/simple;
	bh=QLYFPz+iYP5CjA9fN/raAFqjs9deftRM7H/UAUtODdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lEqylUXDFXe29eX7ldVcmiX6O6I3w+xRv+6JPNLmhUrKORMM45WKqjI6wZcwEzXU4defPmwQK0CDE0C8aFkzgv5RSo2DYWxXS43UmYlM+tEtefrsh9cBgOSrqojXiDWq71JBh2/SbQwozHdgHEExEeA5qsUcyFLhgAGXWj6psOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFPHBCqC; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7abe8442103so724707b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 12:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762200273; x=1762805073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jh3uwPLmYR07dlhjkDymOyq+/CPc5KFjXFc3K+Rn6uQ=;
        b=CFPHBCqCYM8YJGJTmO6oZUo+Gi7BXzq6lDr9zmg1//y1rr1o7HlecgSVWodxiO8R4O
         nKkLe3/RJoRrnHU3BVx4O3KoHspir2QyBuijKEJ5iytpMXZ4DL41UuRB4B9pCEuXO4Do
         t4IIQnL7IuUD5eIwMA/PQbwydVCz/YVZV/LfPmWldv8XfF+58SD88LbW7PSWZ4n/KDTE
         F72zwEbzK3ZXV1g1dnD/0Qjb+EaIVcvi7Mn0d6O9YNPiK7cQ1AG64VkGIF3vMz3iHbdx
         3wk7MCn1h8eXIcTVrkK5t2r36qBIEf90fd06R+6biCSncJQrhxIIo762//5c7FZwzifT
         VwSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762200273; x=1762805073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jh3uwPLmYR07dlhjkDymOyq+/CPc5KFjXFc3K+Rn6uQ=;
        b=DQljLqurmKLLfVQl3u9a9qnjzMxvH3bi7B8G2JYFqsKM0k2Z6lWPwetTZb9tuyG/KE
         7y/Sk3CxiP+SE4+kx7px83R3749DKt0o5f8WhvwQ2jNsy3yETNP0PoMcVmXK2NClfv62
         rvVPrckGv0qALn7oPEqckJ4E94f41HZHsxsv9/TjQMWyFrXPXAwEzX4jNsOMrD79XFKB
         rKVhwoKTcdKYAhHbfPhNXlXAdKnQoM06p/drsp8LeqzYBcIBegJtqyvfT86H2ltL8C7o
         M5disWTsSUzPoWC474hHD7UKUYOADNMhT9qAkcL4ioqf6U+pd1NgQyPJlbxk6ZzMUYhh
         QaaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhWLaVxvzH0xIkTIdMKqpUPvoMaSJgY37yw68kmdXoHbg8WDF/aqEtetPgkeDs1N2omb34QB/0EYvVDsg=@vger.kernel.org
X-Gm-Message-State: AOJu0YydhbkprqdarFV1G/2B+CT9sc7O/D025Zt8dsHLgmxcMrZHmSPp
	kMw6QvyIi/rD2BO4XBHHo34xDdqXpCDbSJKSFAOj4eYFWS1+ZYAw8w76ETewyyLLW/A=
X-Gm-Gg: ASbGncvbaA6dOdSvYrq7KNQFIGwstf0sEpcrwBhSmW3KCBG+i+hgixRTpLVFNHpV9NP
	HfmQPVcnpipnXqOq1BFCfQBSDjBnGcCgh2GjwTJiXn52KUaTXc2Z6sT5o78xU9CxekuS5TcJkKd
	9VV72yR+z+Z0yE4OA9E7Yv3W89qqWaNM9HqRIQP1A6nyQmwwj7diKT0RHD29KoH2FBAt+ZvvpuU
	4m+9+zyDq/D3w82SRr3Nx8MnqGcvdLoahDNYJCUSZzUMWiCc+gxZppRNAV2PTgumHiv8cfuHOFz
	MVPG/QXnnluyPfHGwYE+FbuvcaPWxmsg5C752DYahsAsO8YD+5qEUOki0Q0+DhP7uyX4nf4FsuP
	SYNNPtMEimDZLZKEX7gWXZxWy8TI9xh4Rz8mRx5sYp/kdpt9D6Jpas6rPH7cr75j3sXA1DbPjY2
	nPFX+/I0GXVXa+bLitH4LOiMnvOsCopAvJK6e5XK+FaA==
X-Google-Smtp-Source: AGHT+IHUWa64MAKdOLu6VI/4meUcfZ5QKprxUjp2FXrj9UBY+kBU1nKWPbnLHdfg53QEZjhB1qdhsg==
X-Received: by 2002:a17:902:ec81:b0:288:5d07:8a8f with SMTP id d9443c01a7336-2951a3d0b6amr160180325ad.24.1762200271921;
        Mon, 03 Nov 2025 12:04:31 -0800 (PST)
Received: from iku.. ([2401:4900:1c06:600d:df45:8e1:7a61:1482])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2952774570bsm127494895ad.99.2025.11.03.12.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 12:04:31 -0800 (PST)
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
Subject: [PATCH 2/3] arm64: dts: renesas: r9a09g056: Add DU and DSI nodes
Date: Mon,  3 Nov 2025 20:03:48 +0000
Message-ID: <20251103200349.62087-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251103200349.62087-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251103200349.62087-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add DU and DSI nodes to RZ/V2N SoC DTSI.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g056.dtsi | 65 ++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g056.dtsi b/arch/arm64/boot/dts/renesas/r9a09g056.dtsi
index 32a8005058f8..68f7a8b68d91 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g056.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g056.dtsi
@@ -958,6 +958,71 @@ queue3 {
 			};
 		};
 
+		dsi: dsi@16430000 {
+			compatible = "renesas,r9a09g056-mipi-dsi", "renesas,r9a09g057-mipi-dsi";
+			reg = <0 0x16430000 0 0x20000>;
+			interrupts = <GIC_SPI 874 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 875 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 876 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 877 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 878 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 879 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 880 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "seq0", "seq1", "vin1", "rcv",
+					  "ferr", "ppi", "debug";
+			clocks = <&cpg CPG_MOD 0xec>, <&cpg CPG_MOD 0xe9>,
+				 <&cpg CPG_MOD 0xe8>, <&cpg CPG_MOD 0xea>,
+				 <&cpg CPG_MOD 0xeb>;
+			clock-names = "pllrefclk", "aclk", "pclk", "vclk", "lpclk";
+			resets = <&cpg 0xd8>, <&cpg 0xd7>;
+			reset-names = "arst", "prst";
+			power-domains = <&cpg>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					dsi_in: endpoint {
+						remote-endpoint = <&du_out_dsi>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					dsi_out: endpoint {
+					};
+				};
+			};
+		};
+
+		du: display@16460000 {
+			compatible = "renesas,r9a09g056-du", "renesas,r9a09g057-du";
+			reg = <0 0x16460000 0 0x10000>;
+			interrupts = <GIC_SPI 882 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 0xed>, <&cpg CPG_MOD 0xee>,
+				 <&cpg CPG_MOD 0xef>;
+			clock-names = "aclk", "pclk", "vclk";
+			power-domains = <&cpg>;
+			resets = <&cpg 0xdc>;
+			renesas,vsps = <&vspd 0>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					du_out_dsi: endpoint {
+						remote-endpoint = <&dsi_in>;
+					};
+				};
+			};
+		};
+
 		fcpvd: fcp@16470000 {
 			compatible = "renesas,r9a09g056-fcpvd", "renesas,fcpv";
 			reg = <0 0x16470000 0 0x10000>;
-- 
2.43.0


