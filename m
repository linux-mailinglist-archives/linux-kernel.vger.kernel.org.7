Return-Path: <linux-kernel+bounces-832856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4C0BA094C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 18:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64D9F7A710E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 16:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDD53074BC;
	Thu, 25 Sep 2025 16:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nowPuaMz"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2E6306491
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 16:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758817430; cv=none; b=emUpd6OACcXtduAXoFh59Bp/8rft/wTT6wHB7RzigoPtvEqWoblU67QhL2U66wpR5E7dE1jDsi+YBZ6kOg4O9QZtW7RyUtAA8VVTmJionyhwXneRjT6JrCMCoNphbjLsBWaU4HCEZALL+cktk5YFn0y8aocpoHKBO1Jz3tbxsqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758817430; c=relaxed/simple;
	bh=59SyfGUG6nSEzjiJE1uCa6wYniUO5aKzhiQrG33uKX8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ByQvolsfKZbH4Si3JmZxoh1wPCkQKUhr+AEl73Di3VRzU09P1svfFTTbgFuXjLKBs4+dhJqrEc/WRBeUSTKE1Oh6TAVG1cTVbK2LSFBubUisS7g240mHG4yrIOK16Fj2lmjLi2T4QE6qpyokfrHSuSIPD4hDC2kx0hi96hiZwd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nowPuaMz; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45f2cf99bbbso5781635e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758817427; x=1759422227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bhfgeWKTTFehUL5ME9QvRLQsevmzrNA8iD7btwmAz3g=;
        b=nowPuaMzywjIrzGc5zq1Ws1553kNgA/t0BWdtAo7mGlD1A38EWNDdoOSULUaSFkxOn
         9qcn2EcxxYPq8CX6GGwZabBoL1jIzNllOcUrCQKnA/15vqtnB4XPHms4DICcMe3vi/nM
         MXLsHlx1mf1wodbQxEl0uMx7HaDW5V00hEwadU1SPb6Xj1SIpLLv5CERov5qeo+OXn60
         GrYrsVS+y6gcYhVFb7QzkKCgOZ4TokXjCYBzpiRH9u7ohIUQ/jF5QOfd6aL0wGw51sm6
         hRctnqop+3n93XV/73OE3aKLJNoK/eVRKpSSqTZ58Lg/OA220vvZomo+LpXyoLTFgGxS
         dekQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758817427; x=1759422227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bhfgeWKTTFehUL5ME9QvRLQsevmzrNA8iD7btwmAz3g=;
        b=K40yE/r3P8QGoZIK44RkAx90OkDhL1sqjf6gYZ98BK0KGJ8nNBN1vCkUecqK7V6iHP
         dryFhviT1WzSXyZp76jDJJxaUf9DZcMcUxsMWvaytJvSfRnw83Xe5xpjnMAETpd/SGn8
         9Vs6mveYEIkLVho9eL77HANZSLvhBjsQ5oHAAJSqxAHx2akVRO5kCwoBSEtPytJ9Z7BU
         9fX63WN26fzWouM7H8UjEiRjwaP4lgRwEDVZcAqroJ50V4z2eBfcj8Z9MOra1+K/TuTN
         KogpFv9sUgIWGPOQ/vKoSwjIaycNgTVqbYOagnpTnGTDxixY6NJKtNS9ys8R33AZ0fzk
         LjwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjINKI1tG7CA+GkJM1Htf2K7WNtiVzun45tS2eKoqrPprRSrC0NTsAGnu41asHdvqr4BoyuOEgAXDX1io=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsR1iEVNzGez3xAbZGUEl9IjW4wOq4Llb6vXOja1fTrqBRlIed
	pQo8OmKq1iE0MIoOVtl7/TqcPfCuesHTgeM340HmwKC65lD/LBP8g1TF
X-Gm-Gg: ASbGncul4Q7tY6x+xOhHnvaadJWJeFa1F5XOiHjSSDPzaqHMMfFj+9VVAoCDGzl2LhD
	vNnxnxSwUZ9e94srxlQv/IaCH1RlMRi25MpOHfCAd50t5LOi4FiCxA5lqmXfYae6/CV6jOke2Ff
	SEplHcRHSY2cvBlHi09j3gK1Tgc6TXNksFelG61qKEXTGd15psnaci5Em8vXnRMw4wZkXqrr80X
	XgLCp1GwHVF5F6a/K2/O6odErWS9u+IZTdPIzHeXUdjTUMmD3q4T2ZR6IPsdt3RHeLJSGf3jwjC
	HKJQRNUS8mMtGhmrs5vmyEdv23t12d05IugKXr7C/zqazL8buHl0TU1+IfX8jsMLxLB5Delt8Y6
	duHITofTeoNxviW9G9EUqSli00SVzrjHYmW01E4p6g68nMudaHGbm62o5drGHOipDBoaSJO0=
X-Google-Smtp-Source: AGHT+IE30qlsw+LGQbGsOMA9cwguph9rKHkg04I434dGAXsnLJ3Ub8ZjYMz0XZC+8/ecQZtZP2gmGQ==
X-Received: by 2002:adf:f10e:0:b0:413:46a6:6a51 with SMTP id ffacd0b85a97d-41346a66a66mr555231f8f.38.1758817426788;
        Thu, 25 Sep 2025 09:23:46 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-40fb985e080sm3534819f8f.24.2025.09.25.09.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 09:23:46 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	upstream@airoha.com
Subject: [PATCH v3 1/4] ARM: dts: mediatek: drop wrong syscon hifsys compatible for MT2701/7623
Date: Thu, 25 Sep 2025 18:23:15 +0200
Message-ID: <20250925162332.9794-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250925162332.9794-1-ansuelsmth@gmail.com>
References: <20250925162332.9794-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The syscon compatible for the hifsys node for Mediatek MT2701/MT7623 SoC
was wrongly added following the pattern of other clock node but it's
actually not needed as the register are not used by other device on the
SoC.

On top of this it does against the schema for hifsys amnd cause
dtbs_check warning.

Drop the "syscon" compatible to mute the warning and reflect the
compatible property described in the mediatek,mt2701-hifsys.yaml schema.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/boot/dts/mediatek/mt2701.dtsi | 2 +-
 arch/arm/boot/dts/mediatek/mt7623.dtsi | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/mediatek/mt2701.dtsi b/arch/arm/boot/dts/mediatek/mt2701.dtsi
index ce6a4015fed5..128b87229f3d 100644
--- a/arch/arm/boot/dts/mediatek/mt2701.dtsi
+++ b/arch/arm/boot/dts/mediatek/mt2701.dtsi
@@ -597,7 +597,7 @@ larb1: larb@16010000 {
 	};
 
 	hifsys: syscon@1a000000 {
-		compatible = "mediatek,mt2701-hifsys", "syscon";
+		compatible = "mediatek,mt2701-hifsys";
 		reg = <0 0x1a000000 0 0x1000>;
 		#clock-cells = <1>;
 		#reset-cells = <1>;
diff --git a/arch/arm/boot/dts/mediatek/mt7623.dtsi b/arch/arm/boot/dts/mediatek/mt7623.dtsi
index fd7a89cc337d..4b1685b93989 100644
--- a/arch/arm/boot/dts/mediatek/mt7623.dtsi
+++ b/arch/arm/boot/dts/mediatek/mt7623.dtsi
@@ -744,8 +744,7 @@ vdecsys: syscon@16000000 {
 
 	hifsys: syscon@1a000000 {
 		compatible = "mediatek,mt7623-hifsys",
-			     "mediatek,mt2701-hifsys",
-			     "syscon";
+			     "mediatek,mt2701-hifsys";
 		reg = <0 0x1a000000 0 0x1000>;
 		#clock-cells = <1>;
 		#reset-cells = <1>;
-- 
2.51.0


