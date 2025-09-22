Return-Path: <linux-kernel+bounces-826839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D34EB8F779
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 10:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1294188794B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 08:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D722FD7BD;
	Mon, 22 Sep 2025 08:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHzRlgok"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD122F7ADD
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 08:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758529218; cv=none; b=oP4cn5XTrV46j91DB2ssMO1yWiZYfLI5PQNSW3x0bjiCV4jbslLUFc7T9Slbd967Qj0SriR8zTIwdr3sLOwUDZiTEsqZI5qz7jQv0zC7hWaGKkH2Zv8diagspSe9rymKau6+7bsVbvh+zecQvIJfBhZu051nrYWypdUoVCKCbXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758529218; c=relaxed/simple;
	bh=jW34m1dVcRktmghJ+wO36JmqpXfoGmyvLM7Vm/SWXcY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bj41A2irmgiO2RLobE14qPJzuaY0UnQaKTU0oy/vGNiGoKNuHef2C7FuKLJAD2Sr/VRXiyqpZ3fJkCfgj7Hfiv/dFVd2STToZY9FRw5yvi6UgpAdSTRPST0LtkIt/Ywi+JrPUgaKm+8iPN//k5VwbrVsEWuTFNDu33v3VEGoIA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YHzRlgok; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b2e66a300cbso34023766b.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 01:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758529215; x=1759134015; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DybTmKrBLOMD6vf+9QLzWDpmjWc+lV91VxrSnOsEhLY=;
        b=YHzRlgokpf+1JlLPRfPr56r++aULKk8OVKBtcy+ta16AXodelFSm/+7sTcg+3RkgKY
         MS4wtXxKfXZ+GH6H8RPLnEoALfWBnMcX2CZLqGt570XQ+VXgOwDOdWvKJRrvuKSR9WUQ
         /k1r9l6+uVs9zjUaPQmz7D9mkdBks0GEkAvGbkprcbcNnm8D+Kz2KjAn+7hR+HOID5fG
         eRqkauBdOVDppFctY+8UwWBN1d6Qn2FDUzW0efZ6jPCtLkVK7Zd3WG7lDATayUQvj+wr
         LA4LULzDXEyoycHUvlb+Of7BIeBV11M16PvLxid+q0eZTvOaDfd7/52UyP5db03+phMa
         FYNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758529215; x=1759134015;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DybTmKrBLOMD6vf+9QLzWDpmjWc+lV91VxrSnOsEhLY=;
        b=YgzW59LACbc2XZ/wN8kMRDcNQlwXf6ULteqqUXCw51qL/AmVSbk+u7ZXfHkJjZ/cAP
         5q74bEprVBNV11TxiVFHh9s/4TtT/xC3nNv1kYu5IgOc/u+JfXAojdlTuACRYw2I2xRz
         1CgY56ePbs9Eq8MbXeIIOLEysgzEn8DOaDdu2wETjxaDJzLdYzd44JODhixMYQ17Lt+P
         ZjSRgzownwDi5dfUaowzKuQVU+7M05pGiBQuMTrHXzwOTFuWKyoSx2amZ9ngiDgWc0v5
         RVrzGZ74i2Dld3cOCNqGVnrjXMc2c3HY779+90IjhJaom/5J0XhcvFuPekxbaxXanytC
         8xRw==
X-Forwarded-Encrypted: i=1; AJvYcCX3Df6pgrDLLw7T/AEjuRXnYip/1eu3vuAdWZ0+qQ3OKWvriBmWV6AFam3eW6uqh0X+pvv8gVKoEp0LrY4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/yksFwXJaM+dfWJ7uCcP7X6YuCUp67X+8R91U2kbxB/DmPW5H
	JqmkbVcMTHpnD/HE/SkcaWksRjYDpy+KpHCewb2fmWVoeibk/NO4JsFM4MIQtA==
X-Gm-Gg: ASbGncuHLt7N0xNDoV47xCtiU9O6SgBvIhTAhBPeZUIaWY+Y/VACd60+2vJFfiPryW9
	EfthXSHXkQ4FEbVP+eyzlXqlAD/fkycQa6RDOCPdN8yhebMjthQuFLt+vdibMNdPoeGMvK3821b
	5K2bebvZ/rc4ekMr1aqH3TsYrIXbfU+olr/JK6Nqxx4Fwvvno/EIbIR/de8fwNnaWlDsMCwSo4y
	azsmMV7SljTXcAIePJeTU0gL5XRNipAYs3HrzxF0WJjPMFwwj8UDKhKHBjBPYjcAO4fxS8Sz+83
	wI+ayDqowhEXRZTVLJZWEezIFElJtEbqF5QACTW3ae+7LPmp9PRHoOcgKTTat2aCyUusAxXVH2Y
	ctQcHhnqunTF3rVKo+bWpHh5F+i7bA89W9QKwQ/dJ3d4u2Cx6K6T65RX+rZAyOB595yqJYmqjjL
	ra0v9xBR+12/1JmND7XhGnIrl21UI=
X-Google-Smtp-Source: AGHT+IG7fGN4H1P92BRx3rITJwG9FHeCws+SAhbbvZLAva6UiKbmxu9K+H7jexOc/3MevB0fxM8y9A==
X-Received: by 2002:a05:6000:2383:b0:3ee:15b4:8470 with SMTP id ffacd0b85a97d-3ee85e26b27mr11700859f8f.45.1758528753964;
        Mon, 22 Sep 2025 01:12:33 -0700 (PDT)
Received: from localhost (2a02-8440-750d-3377-171e-75f8-f2d4-2af8.rev.sfr.net. [2a02:8440:750d:3377:171e:75f8:f2d4:2af8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee07412111sm18642688f8f.28.2025.09.22.01.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 01:12:33 -0700 (PDT)
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>
Date: Mon, 22 Sep 2025 10:12:20 +0200
Subject: [PATCH v7 3/3] arm64: dts: st: set rcc as an access-controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250922-b4-rcc-upstream-v7-3-2dfc4e018f40@gmail.com>
References: <20250922-b4-rcc-upstream-v7-0-2dfc4e018f40@gmail.com>
In-Reply-To: <20250922-b4-rcc-upstream-v7-0-2dfc4e018f40@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>, 
 =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
X-Mailer: b4 0.15-dev-0dae4

From: Clément Le Goffic <clement.legoffic@foss.st.com>

RCC now implements firewall access ops to check the access to
resources. Allow client nodes to query the RCC with one firewall ID.

Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
Signed-off-by: Clément Le Goffic <legoffic.clement@gmail.com>
---
 arch/arm64/boot/dts/st/stm32mp251.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp251.dtsi b/arch/arm64/boot/dts/st/stm32mp251.dtsi
index 303abf915b8e..fbedf23def52 100644
--- a/arch/arm64/boot/dts/st/stm32mp251.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp251.dtsi
@@ -1677,6 +1677,7 @@ rcc: clock-controller@44200000 {
 			reg = <0x44200000 0x10000>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
+			#access-controller-cells = <1>;
 			clocks = <&scmi_clk CK_SCMI_HSE>,
 				<&scmi_clk CK_SCMI_HSI>,
 				<&scmi_clk CK_SCMI_MSI>,

-- 
2.43.0


