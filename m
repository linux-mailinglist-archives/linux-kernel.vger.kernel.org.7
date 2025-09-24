Return-Path: <linux-kernel+bounces-830259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CC5B99392
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 11:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14412188C71D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 09:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08CA12D94AC;
	Wed, 24 Sep 2025 09:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J9pMeLkg"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA07A2D77F1
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 09:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758707100; cv=none; b=Rir+rT8X0v8NhjGZeuEoWW5GQmfpG50uMo08rHpclVmx6XAJQOoQBhd4vbWBK38gOxSXjp71MSZlrHRmjthY4nXPDE1Gv3f1G0JC/7GDQfG9QQS5xpWdikV8EeoMiVPEpJN63E4rC7aEcT/AaCtIG5ucXmnRMZYjr2osa5q2/h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758707100; c=relaxed/simple;
	bh=w5eO9tXRAj53rucPnsS4UWOkqrDkGW0SbludZ3UzkzQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IcNw4Myrl4vu67V+Nmb1KugJcp5nmHOAp8L6b6bpElI4xqYzbAdDQSuSJXQIJ4KnKxp/24wH/hJREd/h8Vi4TmKcX64BAJbHYNb965hIW46ccS62osr6IKTaphKLT+zH3V92gvb9Vvkfy7LrcjuYBiFOK7KGD3dgZRN5Ku8WuWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J9pMeLkg; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45cb5e5e71eso41203655e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 02:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758707092; x=1759311892; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hH7fDiyFIwd5GKCGsoTM7UQ+n2/6xvaN9QjJ2WXUyBY=;
        b=J9pMeLkgOs5J6cFyolsAJ40ige3A2oejtHlRQyVeX8sUgDG3YlyIzLslNd5X5uYiUL
         ZXUMCTDN3yYRVwqKe7wBF3KizWUG2hQi9O/WuvMEfO53i5VLRfjXBl+X98M7qOVM0ZES
         DKilxb7HwGEUQn1CPNjJDAQvT3CuroFkDGRA7yZJSWZ7q8Vjrfn0HKzTAIWDyDfbcVuw
         V26yz/6R418gVtQTJHehVXRB6JVFaGQglGongrDcvWoZEwFxhozBm0gnqiWPr2dYD3r8
         OCz8EVx4DDLE3mbVHcMLtKz8EVDC9+KbiQ6Lb/qjH5RHlKRSunZp0xkPmu//RwnQ6H5X
         D+Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758707092; x=1759311892;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hH7fDiyFIwd5GKCGsoTM7UQ+n2/6xvaN9QjJ2WXUyBY=;
        b=XIGmRGm4kpVUzHhzaRnEgRtgFx3rXf+6S5YiC1luNGn3S3PgS8SNnAZbQaWLHypbQI
         hdTdLmzQ575ziT06p4EBy24fouNCqd7USZxQV0GT+4Vz8iCS3DzAM1YvhYVQlYeAuwKI
         3fCPR5nx8nDvyaKiNkLTdChdKXPZNGG+XUl5xaHrxLbYUyzF0BOr1/VQUH9N63sr37hZ
         oOiwVApdWylRSf42DQTnVCHFFGcG2LH5YDl9PXD8XVm4ZFU15OJrj0gA9PKKDk/dhGn3
         sFZnirGeUUpw6t0YMulD2pnLFb4AteNbGyNwg+chKw1FhSsA85SAtv/2HG81EqXq+asG
         qSWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdUeMk71PypC/vOyDoT1QXghCMi0AA5sxIzFJ2zLNOwU9wL2k3utKFS6Gyoxrj7cOlh0b4mqqbjy6/oRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfUI3Gm4MA4Zk3U2hMeQOYgpyCPu3i3VeMhsYxUIXc46Ya/DZg
	S5LNSWuUOnENej2JXDAqRyoaipRUEuP2MqeVPklmvsxZHCtbzHmQr7R4
X-Gm-Gg: ASbGnctg0OV8/5FSEClNkHkxUn/G6lIfWp+U2nUN3nG/L/elUe6uHz11FZYD+/3g1y1
	UuoSan9XjUplRiN4GOMKwhToh8tZFApQv/8M7HdRoww04+LKh6zevgZskCC2J5GDGNBlTo9JqWL
	o1OuB+boEjhGnST8gauZbiyM3ZJpg4TiAKEWE+rI42lHaKBRLH4rheLyW4QciepM1G7uuOBb1DO
	jRoAVZSbrBQtSHNdmotMcVjL8wikMv1JI7nE0/qLCPBs8403W/8HeuPxPQUF7B0iXpTPdGAt7rh
	77O6chlBJR5u+ULIiSmpCtJj0tTl55agqLapvHr5wdKt1wxRZhuGYhKcY6GBJroD6BZzYzpLPjg
	e/J0FCGGm58B99rtiHr7Dp6XeuDDfo+gckBXcED/Exy0xWEijsbVCiLkuf+ChgbK2B3ic1pq+aT
	VSEZGhlgbGQVgcIVy4UCwQ2+mV
X-Google-Smtp-Source: AGHT+IEIpicMOfP08Ui6PtoUDCNZ6++RjL5ZW9INST6VLjpDrbiX7bE7tvizzZ3gSwxM8E2g4eP1TA==
X-Received: by 2002:a05:600c:1914:b0:45b:8adf:cf2b with SMTP id 5b1f17b1804b1-46e1dab512bmr50452905e9.21.1758707091986;
        Wed, 24 Sep 2025 02:44:51 -0700 (PDT)
Received: from localhost (2a02-8440-7503-805b-0076-f865-8f03-23d3.rev.sfr.net. [2a02:8440:7503:805b:76:f865:8f03:23d3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee07407cffsm27184233f8f.16.2025.09.24.02.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 02:44:51 -0700 (PDT)
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>
Date: Wed, 24 Sep 2025 11:44:44 +0200
Subject: [PATCH v8 3/3] arm64: dts: st: set RCC as an access-controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250924-b4-rcc-upstream-v8-3-b32d46f71a38@gmail.com>
References: <20250924-b4-rcc-upstream-v8-0-b32d46f71a38@gmail.com>
In-Reply-To: <20250924-b4-rcc-upstream-v8-0-b32d46f71a38@gmail.com>
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
 arch/arm64/boot/dts/st/stm32mp231.dtsi | 1 +
 arch/arm64/boot/dts/st/stm32mp251.dtsi | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp231.dtsi b/arch/arm64/boot/dts/st/stm32mp231.dtsi
index 75697acd1345..8c0dea2796a4 100644
--- a/arch/arm64/boot/dts/st/stm32mp231.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp231.dtsi
@@ -776,6 +776,7 @@ rcc: clock-controller@44200000 {
 			reg = <0x44200000 0x10000>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
+			#access-controller-cells = <1>;
 			clocks = <&scmi_clk CK_SCMI_HSE>,
 				<&scmi_clk CK_SCMI_HSI>,
 				<&scmi_clk CK_SCMI_MSI>,
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


