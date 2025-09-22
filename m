Return-Path: <linux-kernel+bounces-827025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CB4B8FEAF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 12:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18917162FDB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 10:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD8B3009D4;
	Mon, 22 Sep 2025 10:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWiLK/E8"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513ED3009C1
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 10:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758535592; cv=none; b=UWz4GoCPWmPUMKSykdpLWou02RyVAZ4mx+ziZgqK+d9tGPa+2aL629oI8c2cWwfgrTSu3jVmD8EK79PKDYBKiGLSUhj7YulCoZh0kdU35hUcwnhUYdHcJTiZ5Mvx8yWSzDUCxrFNFamGJ5+76p2z/9JOkt4+JQCqqL+uXf4ZZGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758535592; c=relaxed/simple;
	bh=JE5vzNG6Sy2HEFoz+DBwUg/nv8rP+wKI7N6BxDeuvto=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RXiyw9wH1JYWn90ztIQeXo6xS0fTmVxrcmVTOCx6WMVPAYNzPhnkH5RbdX1d369O1DX7O9NVwzEA6j/KODsnQOeQ4Dk+dqYG9+mdbvMzgxwcId+RfJr/pPbJngWyTIQ7qAAZ6bPkCuQZtG0asW+gimhE7UhHMxLcplkiiAyMATo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EWiLK/E8; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3f2cf786abeso1450591f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 03:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758535590; x=1759140390; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HQSp6khD66PWakk86QjUyhjTSipaHZaw5SNW0wYKmlw=;
        b=EWiLK/E8Usdl1hIMoIV3HvUUQp0vbGRsEDcShSOntPVn/q+x6Ob7eS1WqcM6FPXY06
         f4UTpwvh4GdkfSoc/tQmu0rVA+5WQHqkoZFPya+/9zfv0koinmbGQsJoLkNv19Gtgf3s
         52Rtj7CgG8cV6n4mb5tG2mBZSEd2IkH5UmwEwII/vrdCspJmlf5pvYk1syw9mqmA8CHj
         2KyGlrgPgquAQr8K5bYk4y4ymNV7/UDHx57gLU1p20kD0OYmQH9KHaq0wekeJds/fHkb
         ff+QIqIQuIn+BV4+ekpnJynOALQPRMe/6nfGN5C/PdqtRD6e9IY0Eo7F+os3rlpu7vpZ
         hkiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758535590; x=1759140390;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HQSp6khD66PWakk86QjUyhjTSipaHZaw5SNW0wYKmlw=;
        b=bG4FhT83MFKwQ1Y3Kq6+oCUyeVQ770+X5whZGFQU9UqoCaayD4pInhavTRsktIXxEj
         9BhusJ4pWaSwigQxH31/BTYZQeb9Rs039D5o26IpaM96Wc/tSQAFnc6v2c7ftlwDLUva
         al4jxDzgSWfJxzgsxkprTQQ9F+z9GfnFaxaWCeiBZxODdICHsoYT/UNImLPsj4/tZrnZ
         UF9jZY5ce3XCIwHFOPLEOpIql6R+juj7E5mzlLM0n7MC/EBLsXm94ODNRxSMcS0v8FQR
         U0zQDcKzIexI1p1EvA2cK8uEQyU00zBQyuGYfdaXPXIynKYOFM3hywc5crPQ0owPlRTq
         aGBA==
X-Gm-Message-State: AOJu0YxAxN5M/Cehfvw+FePsNUmT8y+fPiE0DMVbE7K+TVgVyGn3qSe/
	BzBma4i9EPjFEUx2ljQkd+jxZH2zRu8oJgGg8sJqnENBlSLH84RJ9Y33CkS/DA==
X-Gm-Gg: ASbGncuGHq4YT1BQz1laOt6+zjiHP/b9huzd6Ry+CqdeWDYkp1SAVCTNjZQqbvI8G1X
	nUW8PNpOqv5NYvOAVp2gZGyjw3Gi7RMhbLe4Suq1P4hINeMuD8ZuM1hEp6olRYlf1RT5eiXbyDg
	kSJosg6sjgOkRwcm8s5mBSIGsfYQ+32G9P87AJpfbaeM0rgrokHd5DrKYfKX+LxEGcianC3T06W
	0i7235BQaukvIBbQHE/OsjRhA6PfS1ffjvhiAisJTqjkXqnwIB6iJd4jejACafI3xpPZ+MRkdpd
	iQkvFBuYshsVdhwDBnVdzCKv86IdN2DgnPAvIVc89LNaQ8pMvuOCu9Y4bvqvi363S7lEp+nX4uJ
	fyeBi4EAeisTX2HUJ0pnAc6ENolxGdWQ5pDcRDOGJ83PuXLK7FSl34sQ4xmqLuqjYu6PLGiuGss
	a0mH8b/aemuaSyotaO
X-Google-Smtp-Source: AGHT+IFMdYeYi2iaeAdjrGDcnkGPmrB4GjWSDhVK2rF2FgfKPc6GjT1SHKlJ9mXDLcRp77TRnBlKDg==
X-Received: by 2002:a5d:5d88:0:b0:3ee:13ba:e140 with SMTP id ffacd0b85a97d-3ee7e1059b9mr9638251f8f.21.1758535589473;
        Mon, 22 Sep 2025 03:06:29 -0700 (PDT)
Received: from localhost (2a02-8440-750d-3377-171e-75f8-f2d4-2af8.rev.sfr.net. [2a02:8440:750d:3377:171e:75f8:f2d4:2af8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbc7188sm19867335f8f.37.2025.09.22.03.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 03:06:29 -0700 (PDT)
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>
Date: Mon, 22 Sep 2025 12:06:20 +0200
Subject: [PATCH v7 7/7] arm64: dts: st: add DDR channel to stm32mp257f-ev1
 board
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250922-b4-ddr-bindings-v7-7-b3dd20e54db6@gmail.com>
References: <20250922-b4-ddr-bindings-v7-0-b3dd20e54db6@gmail.com>
In-Reply-To: <20250922-b4-ddr-bindings-v7-0-b3dd20e54db6@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Julius Werner <jwerner@chromium.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, 
 =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>, 
 =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
X-Mailer: b4 0.15-dev-0dae4

From: Clément Le Goffic <clement.legoffic@foss.st.com>

Add 32bits DDR4 channel to the stm32mp257f-dk board.

Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
Signed-off-by: Clément Le Goffic <legoffic.clement@gmail.com>
---
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
index 836b1958ce65..c4223f06396a 100644
--- a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
+++ b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
@@ -41,6 +41,13 @@ pad_clk: pad-clk {
 		};
 	};
 
+	ddr_channel: sdram-channel-0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "jedec,ddr4-channel";
+		io-width = <32>;
+	};
+
 	imx335_2v9: regulator-2v9 {
 		compatible = "regulator-fixed";
 		regulator-name = "imx335-avdd";

-- 
2.43.0


