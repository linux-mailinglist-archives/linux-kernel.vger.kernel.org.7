Return-Path: <linux-kernel+bounces-827024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69AA4B8FEA6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 12:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66D8A18A2432
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 10:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318AA3009F8;
	Mon, 22 Sep 2025 10:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hy8PPrtA"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A112FFDF4
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 10:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758535591; cv=none; b=Gq0z2pzI5uyUesF6jwkC5db1Y4lZwF5ZzKjFlYXezpCPCxW7WFW4NyyGZwaUSCPtj6ljXGIkn4FZTKC78xL0C37PazZSwyViQlWVkqrOCRTZgH2bwp02vjn7JJa+j9OCgeHO6qwRk3ESHbCQTjO5gdc/EyHq50T6oRkV0p1dJNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758535591; c=relaxed/simple;
	bh=1OJSwnVWIOwJ9ZLoYl+VQDzy0Ex+adY43gmbor4fP/w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kOREnC1TcITGtZy7wO5exfRilnqbVlk9rIr6zZNpFZqVb/oQISFk+RKr3D8PUukqk6meuqFy0Z5yCKvlwOiMb2YdgfUbhm6IQkScwPvflXy0ktklttAz4Bpb/FkGuXFuBCiV4PH4zWL4OXQsTmBk1oZSLns60luyi9VTRITilnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hy8PPrtA; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45dcfecdc0fso37004185e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 03:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758535588; x=1759140388; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lkTVKKAKgDTt3rd0xPFa8W7IH6WaF3o91NFw0CHdy6w=;
        b=hy8PPrtAvdqlla97+he3bkpnjSTOPkVEctxdtuRRV279sPmkbooqdQCZK4qf7L71uW
         qGfwNpnxnzYyZM3l8mR5ABfJ9uydWNTQRsmQRghlQvN44Ful04tga+1RlT1785uNRawt
         J3B1Ux4QLYq7j+Kw41Fl/NuUc0+D6rib/6wuoeF5w+GalR1K90D2XFkao6ig+aiVAPsl
         UOYSth5+nln+CY+d3p7oVlbGd+/xruovHX7y/+dWBD+yjL+ior5dKQq61M4H5s4hryRG
         jaSY3yEimzlS8j7y1/C9k0pTkk4fS6j0hEtVrvt4s20wpG9svb5FegUnA41qnIamHlOu
         WqJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758535588; x=1759140388;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lkTVKKAKgDTt3rd0xPFa8W7IH6WaF3o91NFw0CHdy6w=;
        b=rfyV199KGR7mu50wsqd1/BhearpGawG41iqbSR+FNfbm7k0IeDrpB0R0lMocfelH94
         91vyXw5BLt1frsVhO2ugL6HexolsI/68quA0Dn7wB6VozEXAl34hH2a59FJiLmX81rpl
         /NywEwT9mCI5xbLKAT5IaWXNp9KYmRPoqRBRiK5lCYVV7j8m7EsgS10Yek12fkPKtvnh
         y7imWztX4GKoGM2gMlVvMWVWQZ5kRkX26qgyrCsSxQnMdbS2zXnz29bmVAQQtx8/vo8l
         QTi1/lAIYETFcnkDlhLziC4UyRwH5LfOrtfKsiT0XlKD1YjoHKQYC0uJ1ZGpS754x8CE
         vmSg==
X-Gm-Message-State: AOJu0YxgbvEotzIjC92XQ1hVb5XxAib2l4YeHgFFj3Vio2cLnMKT8fOt
	WDFf08MDtsF6QVTerJrpwPwV1Oa36Ggs0BS6cls82SchlxWFw6Bc8G5J
X-Gm-Gg: ASbGncvSCImmB9KPB/0p7LjrDFKvKx/ChtcJCxk40rrrsJPHf2XaWdvxdzV7I3Ggt0y
	lD2qkCVjS586/l6Czk402Gewq4wZOngxO/1GpGwHJVMrKj6ccjVPQss8NJhfr0TpCxQcnc2yk+D
	YopNhG8d5NPafb18OG9qrI2rHWlt0qrfZrgzpUbq9nz76BeUdhkGE1ODGrBJW6mHMARLpmSGXPf
	rzsXfVJ2hJilan7ImDMazWor539vO45Vj1DO7o3wDzvQ4LX3ao+GQ8uPIYeBEyavbJ+DIOkZyWs
	m8dhr6NjA2WDMJak0KksOxM0aYca0NhCkTbkMDouQvZIplmB+umu1m1CORo9Zi8p5NUiPLj8mDp
	Khr2s2LC/WfRt09siiOSbHrADR9DrvgeOwPk6bpsjQaW7WkwoicCRvIQHzhbpHiyUdIputPBg2r
	MPbkRxyqno2HCBy/HA
X-Google-Smtp-Source: AGHT+IFsCK67zkg+eo0L7Dzd5uJH0Dlu0IC2iqPXJB3tB0I3Vgc0sQFVDvDEMKtjJDMRNUKipGcypw==
X-Received: by 2002:a05:6000:3113:b0:3f6:9c5a:e1ff with SMTP id ffacd0b85a97d-3f69c5ae5c9mr7470157f8f.39.1758535587944;
        Mon, 22 Sep 2025 03:06:27 -0700 (PDT)
Received: from localhost (2a02-8440-750d-3377-171e-75f8-f2d4-2af8.rev.sfr.net. [2a02:8440:750d:3377:171e:75f8:f2d4:2af8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-401d7fa1729sm1345904f8f.5.2025.09.22.03.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 03:06:27 -0700 (PDT)
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>
Date: Mon, 22 Sep 2025 12:06:19 +0200
Subject: [PATCH v7 6/7] arm64: dts: st: add LPDDR channel to stm32mp257f-dk
 board
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250922-b4-ddr-bindings-v7-6-b3dd20e54db6@gmail.com>
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

Add 32bits LPDDR4 channel to the stm32mp257f-dk board.

Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
Signed-off-by: Clément Le Goffic <legoffic.clement@gmail.com>
---
 arch/arm64/boot/dts/st/stm32mp257f-dk.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp257f-dk.dts b/arch/arm64/boot/dts/st/stm32mp257f-dk.dts
index a278a1e3ce03..45ffa358c800 100644
--- a/arch/arm64/boot/dts/st/stm32mp257f-dk.dts
+++ b/arch/arm64/boot/dts/st/stm32mp257f-dk.dts
@@ -54,6 +54,13 @@ led-blue {
 		};
 	};
 
+	lpddr_channel: sdram-channel-0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "jedec,lpddr4-channel";
+		io-width = <32>;
+	};
+
 	memory@80000000 {
 		device_type = "memory";
 		reg = <0x0 0x80000000 0x1 0x0>;

-- 
2.43.0


