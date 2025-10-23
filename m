Return-Path: <linux-kernel+bounces-867799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9000DC03855
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 23:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 476A53583D5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 21:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A59126158C;
	Thu, 23 Oct 2025 21:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbQoZqYr"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E01F29DB61
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 21:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761254613; cv=none; b=ZHTdc07cpBsvFvvpbqFsKFtVHqiPDuAttykh/sLkjwf7wlKt8FN20Fn+u/j1EhQ0al5ROgrUL/oZOF9vp/XHUncHURAjc1CPh+bKa8RzlAGxWqhFx+wRVlrx54mhP7Z20YToJlW/x7RaviEMr7RwEK8+RM9OB5OwGFvwuSkPqVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761254613; c=relaxed/simple;
	bh=iP4ZDFq1INSnx7yBwMuJweZZLqEC/SAU2vNsxpWXv68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hcQnAeAS9JXKxubfxEPRM2Tcsh3w17+Fm9RpbtPT9gaCZJBALLFIBy3IHif1HXKRUw2l03QB16K20xMjVcMtmfClr7Pv8jl6aXJGO6XNttnbOyDuEimh7kSS1J67se1Gc/RM/pi+PkJ5XWGLdk0ayjPURaETne9peN8s24eaHuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dbQoZqYr; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-290b48e09a7so16253945ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 14:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761254612; x=1761859412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z1seM1hvIEshn8BU43E+5LBK4A0vgUOVZMlNQ5n1LMI=;
        b=dbQoZqYrFqiXJViTr3yNsPvlf7xA030Km9P7gjLVN+sT0ZKLWyfSbwiE68kyZLo+5U
         1XABI+kvvkCIZ4XwRdmSb2LUkNV4y91Y4v5Uap0F/fDPhs/bII0DSbh7NDubD6plJM5M
         fblk0IGA0JceRQPVbkSuAHmPc/shETJ+y+J+gWqZ7d8A+RKW7nd76uwHN3GtqcQP3qG+
         RHGO5ctJ9MtK7ytkSc+0QFlKidVLpObrwb4x2+YvIwByapf0RUKJvcGG/3XqDE3+mfEs
         /qd48uTpFcSwOYK1vbP/YSbkGcgmlMhvmEz9034xDe1+G6tdQ2rHStn3B/MKaTWfKwO2
         ED+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761254612; x=1761859412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z1seM1hvIEshn8BU43E+5LBK4A0vgUOVZMlNQ5n1LMI=;
        b=HPGw8lW8IZcr8QztKYsVfEKyLikc7Le4XD0OOkMQI+JJOt5u/k7TZ1dFMhS6oAPoVd
         oU3Aiav52RRZpW8BT7FBY/XHxcoIM8diaV51vPP2bZrbZ9ELbpaxShoLF7j8RYawfQIV
         LVzy4J7/PDOB6MhmCN0dZ0lgihUyCeTaPpI5fG1KEWXBy679fpHIShvvX2M8e9VNzvyl
         xDoMtPSmIwDzAYW+eK7oc3aT0dDPKMT5HOiw6A0dd949accQBg2lQq7rpMfCu80FhIoL
         lLTV1hVhDs4bbQ4dC668dDtNd08+zfcT2VA6zal7/kDuMwyBnX3ZzlbSwbeiz+QjQbjP
         TLmA==
X-Forwarded-Encrypted: i=1; AJvYcCXTUQo5brqeMt7/lDFFHXHTfcRwonxRHAqq/aCZldC+vSacUDiwVBYtPhYC4gYL36EOh2zpK2sqG0OOLzY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywld7QEzqNs22L2+p6SG2q/+9oWXC8pmSJkeYfTndxdJoXR8R6C
	+aHlLqMChw/xR7Shl1nvlu4Ki+/rFRiICW4LgZOdbbe0D6JhzujDkEx9
X-Gm-Gg: ASbGncsyFMbONEOSb8a6F4SSLKoupmIf45cFUpIQi82pTqmA90t8NrXzpogeeVNksb+
	tuX86VEHESDw1q2bN1Sj/OfTixaJXTTywds44Ri/qYzWaBW13DWmZ4Fe0Elo9D68V5po/1Qzz8a
	mxfuaN9cc7a2rbJ4mu5lQpkHSCfYdBCtIaD2ykCG7ZNt+kTYSCML1rakcEApdIL39acZDrT+sq8
	YTbjtFxScxfmdYodqcGWM84oX92jb1JtdACID+PpZD0OVpUR6Wj/nPMYIDJIm7FduPABfmtk9Ze
	7Er2p06qU2gl0RE9L+EZhB3fnhuB0EALi5BgGNM3E1f5HXQb8JnhpiQN7RUFUaPQQ1Pv7Rkex2f
	5CbNYws3aFjG/GuiEouueCXPB2bNzrzN6dqeq0acARc8pvGKTnv6ICqWC8SKb46mItvNMc0hn6t
	sB34wRC5B8skVOAINN700PoS9+apl2TA==
X-Google-Smtp-Source: AGHT+IFQHRcbnegoHkxRL5BKLxnCZvQirOZChcfqu9A1/v4tEA40NBThc5X1UaiPmXR/ffXmqbVk8g==
X-Received: by 2002:a17:903:1248:b0:24c:d322:d587 with SMTP id d9443c01a7336-290c9cf3facmr318282275ad.26.1761254611807;
        Thu, 23 Oct 2025 14:23:31 -0700 (PDT)
Received: from iku.. ([2401:4900:1c06:ef2:36b5:9454:6fa:e888])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946dda7949sm34306965ad.3.2025.10.23.14.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 14:23:30 -0700 (PDT)
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
Subject: [PATCH 1/3] arm64: dts: renesas: r9a09g057: Add FCPV and VSPD nodes
Date: Thu, 23 Oct 2025 22:23:12 +0100
Message-ID: <20251023212314.679303-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251023212314.679303-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251023212314.679303-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add FCPV and VSPD nodes to RZ/V2H(P) SoC DTSI.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g057.dtsi | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g057.dtsi b/arch/arm64/boot/dts/renesas/r9a09g057.dtsi
index 40b15f1db930..47b3502846f6 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g057.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g057.dtsi
@@ -1303,6 +1303,30 @@ queue3 {
 				};
 			};
 		};
+
+		fcpvd: fcp@16470000 {
+			compatible = "renesas,r9a09g057-fcpvd", "renesas,fcpv";
+			reg = <0 0x16470000 0 0x10000>;
+			clocks = <&cpg CPG_MOD 0xed>,
+				 <&cpg CPG_MOD 0xee>,
+				 <&cpg CPG_MOD 0xef>;
+			clock-names = "aclk", "pclk", "vclk";
+			power-domains = <&cpg>;
+			resets = <&cpg 0xdc>;
+		};
+
+		vspd: vsp@16480000 {
+			compatible = "renesas,r9a09g057-vsp2", "renesas,r9a07g044-vsp2";
+			reg = <0 0x16480000 0 0x10000>;
+			interrupts = <GIC_SPI 881 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 0xed>,
+				 <&cpg CPG_MOD 0xee>,
+				 <&cpg CPG_MOD 0xef>;
+			clock-names = "aclk", "pclk", "vclk";
+			power-domains = <&cpg>;
+			resets = <&cpg 0xdc>;
+			renesas,fcp = <&fcpvd>;
+		};
 	};
 
 	stmmac_axi_setup: stmmac-axi-config {
-- 
2.43.0


