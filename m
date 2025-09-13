Return-Path: <linux-kernel+bounces-815351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE81B56328
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 23:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63E18A07413
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 21:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5119E280A5B;
	Sat, 13 Sep 2025 21:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WISYPIM8"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD4528488B
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 21:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757798494; cv=none; b=IrTJfNxDLQxPNTo8sDO2N0PrfHsbyOd86FurNY0LONQTwLeqqh0KiClS1htn2YqwGisOFzHb2hR3kTRNMSycWDqa2Ala0EaePQq6cnoM96wtyGW6DQgoVkqgXA6Eo6BqHTsAoOSC4i1/YnOCwBGp32lPKZzMmbOhsiHYosa5vFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757798494; c=relaxed/simple;
	bh=igZli3gJlHsl2PQpYXr93eQBHQb74b0WC5i0KG6a+VA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QP/oSuCrBmMUrGliCK2dmIZpX7dzKoMVnfrZMCdA/MDO5N8+cfF4FhuLerDbBZeSPGR1l+TfnE4TdcM82cQ9rvJ1ebk/S080kElf56lCMDxvzy/IlK/h613sVAYaCUdQI9q/KcZMaOYEzDoy1tWi3wGkcSqNl4V0C4wCnqQV1Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WISYPIM8; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45b4d89217aso20960695e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 14:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757798491; x=1758403291; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oxWfkQz90C9L6MSNr2+XH/iEJ/4hSdL7W7krVSxEuE0=;
        b=WISYPIM8mjaQ7/B15WUWZ4dcQzMDqFFYp2yyof9DSjPkItZ3IrjgxWsGmk60KrjGNU
         2uNMNwF+Bfhh/shqswTN6ihMacTzhMbc7zQ2UiESkyZRNlVnN152r8PLRT6ai+lAv7ph
         jc2EDIufFVWk3NzHHgyTifKT6N42uRGTlxv6f5tD9ADvLABsE9AlpjNrjBv+USa051uV
         MXeiWco4c/EB10kfREiiCloov1zgo44j8d86v7GylhDZf4PspY71DColscl+5Lkzs+8H
         FfOH0m6FLYDEXxWQweUYcJC3gNnZapbpaT8Vnc3ZV6qOOyGHOxPZXcDM7hoduN7vbeY6
         SVHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757798491; x=1758403291;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oxWfkQz90C9L6MSNr2+XH/iEJ/4hSdL7W7krVSxEuE0=;
        b=JqnV1U2yyPhmvTm0dD1fjCMBLdn+/7GVPn+vco0jNcy9x70J68fiLOmJSmh7FqA1tU
         Y33LvZ1A5tntmzk2Fr+RjyOZtj8FeCIzMOtP9PBTTQSrJEehi2Vbr7TDJhl4OZPcClJ0
         E6kW9OgS1svJ69RUdXJBonKqY0/v9AZQIkklB0ClU6Z09a5F4Myn2EGBnf8fMN026CZ+
         nLH0YEkuOR/6gwAbLrld/pr+ueqsqcJMu3UNMpmWEhwwselFSLpgqFXgXOKlNf5Nuhi2
         rhj8IZqtlq/ynyxf+LtevoxlAGClIpLxdlsfZVMQzdKCceeb8DhnXjK49gNkbM/be30j
         YG0w==
X-Forwarded-Encrypted: i=1; AJvYcCXwlgK+hESSHJzqB6FGmSLWde0Uf0wmwmguhrXKeMz5+ZjSxHtQHxnRo7YBDmj0eZqOPE8p3B6WJYt/shA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+QFamWCn2I01yvodQn5btMlfKwYGNzjPrzzmvjlP9IlNQ89/8
	6FdDWv/qc67L7YOgWxVI51b32G6J/cToO8bqZDFsttlCK7dfHzg086dS
X-Gm-Gg: ASbGnct3sZqUlw40zEnR5HkmjWRF05Olk53rDab2X/mQQvjIHA3QqxWuK9VVZKGCsn9
	54teJYXWbh03ueWCt2j9C8evQoM7kmcKGW7iS75qTz8JYTa04LBZoaf/jwvaFI8SvKFBg2Kwa5R
	s7HRNsdzWvm7SdWv0U6cQaE5yfyf+TIJ+xvEzHyN6ejtVK1beC1Pi3TGsNVHQSj38Nh+QNpEuoW
	j2VOm31P57oJFMtf8w/PI/TULrc/WH9sUsM+WB1JmFsVuZwhD7jf036/dH7I9gan/4+Zovz0NuG
	V9+0+o57Ii5tUvJ5CPrkg1BTET48l+MxwrqlNl/EOkIQ18qxrpOrrPSQRDUghMn5Goyid5KVubS
	ZO9j+3HET2Tz03eS6OU+N84okYdghqhGvG/ByK2mTRzoPrUXJePXK
X-Google-Smtp-Source: AGHT+IEs/fk+jCkMcX17PxuJzAl3BMnHRPZjZ8PBJFXUcfnuVJskMnNC5koV2QxLjtd7wZEjTRjvpQ==
X-Received: by 2002:a05:600c:45c5:b0:453:66f:b96e with SMTP id 5b1f17b1804b1-45f211ef88dmr66556345e9.11.1757798490854;
        Sat, 13 Sep 2025 14:21:30 -0700 (PDT)
Received: from Radijator.localdomain ([93.140.65.23])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd6absm11576842f8f.34.2025.09.13.14.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 14:21:30 -0700 (PDT)
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <dujemihanovic32@gmail.com>
Date: Sat, 13 Sep 2025 23:21:05 +0200
Subject: [PATCH RESEND 3/9] arm64: dts: marvell: samsung,coreprimevelte:
 Enable eMMC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250913-pxa1908-dts-v1-3-8120cdc969b8@dujemihanovic.xyz>
References: <20250913-pxa1908-dts-v1-0-8120cdc969b8@dujemihanovic.xyz>
In-Reply-To: <20250913-pxa1908-dts-v1-0-8120cdc969b8@dujemihanovic.xyz>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Karel Balej <balejk@matfyz.cz>, David Wronek <david@mainlining.org>, 
 phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3698;
 i=duje@dujemihanovic.xyz; s=20240706; h=from:subject:message-id;
 bh=8/peqm48tCTiEczHfDYZk/YBJQovtzWt9KQ0JhK9ewc=;
 b=owGbwMvMwCW21nBykGv/WmbG02pJDBlHH/iXbxO44VcrF9qzRXLzgmz7d28d/yQ4fUguaD247
 amSxPXTHaUsDGJcDLJiiiy5/x2v8X4W2bo9e5kBzBxWJpAhDFycAjCR8B2MDPvn8IomPP5QfVl3
 86QD/VOXm555zJEWyxtWvVnu/v1z8v8YGT4wz157xuv64fv66QyrH351u68YtHFzhVT8g1maq78
 8O8oIAA==
X-Developer-Key: i=duje@dujemihanovic.xyz; a=openpgp;
 fpr=6DFF41D60DF314B5B76BA630AD319352458FAD03

From: Duje Mihanović <duje@dujemihanovic.xyz>

Commit a41fcca4b342 ("mmc: sdhci-pxav3: set NEED_RSP_BUSY capability")
fixed eMMC probing on this board. Enable the eMMC and add its pinctrl.

Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>
---
 .../marvell/mmp/pxa1908-samsung-coreprimevelte.dts | 79 +++++++++++++++++++++-
 1 file changed, 77 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/mmp/pxa1908-samsung-coreprimevelte.dts b/arch/arm64/boot/dts/marvell/mmp/pxa1908-samsung-coreprimevelte.dts
index aa161982ca43844287d212e8a24884d2b8440fed..78b7bccfc5f299889d1b9a8fd2c08554f17eb147 100644
--- a/arch/arm64/boot/dts/marvell/mmp/pxa1908-samsung-coreprimevelte.dts
+++ b/arch/arm64/boot/dts/marvell/mmp/pxa1908-samsung-coreprimevelte.dts
@@ -292,6 +292,79 @@ sdh0_pins_2: sdh0-pins-2 {
 		pinctrl-single,input-schmitt-enable = <0x40 0 0x40 0x40>;
 		pinctrl-single,low-power-mode = <0x208 0x388>;
 	};
+
+	sdh2_pins_0: sdh2-pins-0 {
+		pinctrl-single,pins = <
+			0x24 1
+			0x28 1
+			0x2c 1
+			0x30 1
+			0x34 1
+			0x38 1
+			0x3c 1
+			0x40 1
+		>;
+		pinctrl-single,drive-strength = <0x1000 0x1800>;
+		pinctrl-single,bias-pullup = <0 0xc000 0 0xc000>;
+		pinctrl-single,bias-pulldown = <0 0xa000 0 0xa000>;
+		pinctrl-single,input-schmitt = <0 0x30>;
+		pinctrl-single,input-schmitt-enable = <0x40 0 0x40 0x40>;
+		pinctrl-single,low-power-mode = <0 0x388>;
+	};
+
+	sdh2_pins_1: sdh2-pins-1 {
+		pinctrl-single,pins = <0x64 1>;
+		pinctrl-single,drive-strength = <0x1000 0x1800>;
+		pinctrl-single,bias-pullup = <0 0xc000 0 0xc000>;
+		pinctrl-single,bias-pulldown = <0 0xa000 0 0xa000>;
+		pinctrl-single,input-schmitt = <0 0x30>;
+		pinctrl-single,input-schmitt-enable = <0x40 0 0x40 0x40>;
+		pinctrl-single,low-power-mode = <0x208 0x388>;
+	};
+
+	sdh2_pins_2: sdh2-pins-2 {
+		pinctrl-single,pins = <0x5c 1>;
+		pinctrl-single,bias-pullup = <0xc000 0xc000 0 0xc000>;
+		pinctrl-single,bias-pulldown = <0x8000 0xa000 0x8000 0xa000>;
+		pinctrl-single,low-power-mode = <0x288 0x388>;
+	};
+
+	sdh2_fast_pins_0: sdh2-fast-pins-0 {
+		pinctrl-single,pins = <
+			0x24 1
+			0x28 1
+			0x2c 1
+			0x30 1
+			0x34 1
+			0x38 1
+			0x3c 1
+			0x40 1
+		>;
+		pinctrl-single,drive-strength = <0x1800 0x1800>;
+		pinctrl-single,bias-pullup = <0 0xc000 0 0xc000>;
+		pinctrl-single,bias-pulldown = <0 0xa000 0 0xa000>;
+		pinctrl-single,input-schmitt = <0 0x30>;
+		pinctrl-single,input-schmitt-enable = <0x40 0 0x40 0x40>;
+		pinctrl-single,low-power-mode = <0 0x388>;
+	};
+
+	sdh2_fast_pins_1: sdh2-fast-pins-1 {
+		pinctrl-single,pins = <0x64 1>;
+		pinctrl-single,drive-strength = <0x1800 0x1800>;
+		pinctrl-single,bias-pullup = <0 0xc000 0 0xc000>;
+		pinctrl-single,bias-pulldown = <0 0xa000 0 0xa000>;
+		pinctrl-single,input-schmitt = <0 0x30>;
+		pinctrl-single,input-schmitt-enable = <0x40 0 0x40 0x40>;
+		pinctrl-single,low-power-mode = <0x208 0x388>;
+	};
+
+	sdh2_fast_pins_2: sdh2-fast-pins-2 {
+		pinctrl-single,pins = <0x5c 1>;
+		pinctrl-single,drive-strength = <0x1800 0x1800>;
+		pinctrl-single,bias-pullup = <0xc000 0xc000 0 0xc000>;
+		pinctrl-single,bias-pulldown = <0x8000 0xa000 0x8000 0xa000>;
+		pinctrl-single,low-power-mode = <0x288 0x388>;
+	};
 };
 
 &uart0 {
@@ -320,11 +393,13 @@ &usb {
 };
 
 &sdh2 {
-	/* Disabled for now because initialization fails with -ETIMEDOUT. */
-	status = "disabled";
+	pinctrl-names = "default", "state_uhs";
+	pinctrl-0 = <&sdh2_pins_0 &sdh2_pins_1 &sdh2_pins_2>;
+	pinctrl-1 = <&sdh2_fast_pins_0 &sdh2_fast_pins_1 &sdh2_fast_pins_2>;
 	bus-width = <8>;
 	non-removable;
 	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
 };
 
 &sdh0 {

-- 
2.51.0


