Return-Path: <linux-kernel+bounces-837360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E52DBAC20E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 10:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51FB17A047E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 08:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BEF42F83D4;
	Tue, 30 Sep 2025 08:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBAmdwuu"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF422F7ABC
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 08:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759222024; cv=none; b=FbxeAArJsGUIJaScSF5A38LH3gf3saBflyB+uC+7v1UXpGMniuGiXHYNZgpk2TgbD5LlQKyN6I0bKw2OM79EXBOLz1tFxH4zvQkebbaxldAshoE3Yh2F6KyTvfYsFaYMQVgzbnO8+YqbGt3vQxHp3RA4YWhC2/n+5R1mejO66aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759222024; c=relaxed/simple;
	bh=JE5vzNG6Sy2HEFoz+DBwUg/nv8rP+wKI7N6BxDeuvto=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rsEMvXraHiibov5aTg+iFnDeTN5msYUrDQ3Mb+rKDebRpnEL0wvQAgv2CAQxxqqGx/NN8wW9H3On0swvMfLCDIeQtKZePXc0nwZKcAqZhgU6bQOI4F9IVQMSVqLquJmTK42sDvsvL1Rtut1c4FMSNmj9ZNU2BEDavSnN/eOxIa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OBAmdwuu; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3e8ef75b146so3875897f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 01:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759222021; x=1759826821; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HQSp6khD66PWakk86QjUyhjTSipaHZaw5SNW0wYKmlw=;
        b=OBAmdwuueYmyBTRRG0U2mpZPkWRuEtqLS6p43sBi8sZEx1TdIpEbpllzKMmBhMOIeQ
         BiY3fYAjQa00aslOQN6Q164/9g3WC79Dx5axj9RU7Cd/hDWtDUnuPa93C7tcEnRilLNP
         c85AcXeGByCdyZATxwWkaVp9MaypIC7IQiK0VLmHviinA9k4/SI87uM+l8HZbNyAo6WB
         9g6Zk1DPsVJMeR5kz7DgpCNUBSKTlLHjRWvsHCojktrA8+xlIZ51K0DnEJ10jWz2qNeD
         4pKdEwjMUzvNByYJ2p7CIjqrxGhRv5euJUt6H8CEWVBHkGlLDlaQoKZ8rusY8uI/xLKk
         BGQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759222021; x=1759826821;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HQSp6khD66PWakk86QjUyhjTSipaHZaw5SNW0wYKmlw=;
        b=sIw87X4hMIHFNYa/0pLbTtG9IqlRLhl8BtvYALtsmWnW6PcujkbgDK5TnLKoDF+/9Z
         kfMX8WFKHxPeh1k4wsG7M8xF9SuN3rQVW+ZCTALfozGoqG/KKrJW64mLIXT6bljrBtvM
         0k0G2uEzxvIQSEc9UiKCsKYCfSvVL4Wk5J0S0WQ2uNx99RcFBnZPnnFzvO/w925NF6nO
         KRl70lMaGjTzzbib6cNFHIyQk+x1UieC033GscGvrkHGhEPbGyucdg4xphuZXvINmw1o
         9MPvqVp0rMJw6mTpBuw5QgzsE8Xw4YxEAuFc5KXMVPBrimciLPw08OuCyqPIvv5v/uj8
         o+IQ==
X-Gm-Message-State: AOJu0YxBl+Z3xJIE9fpr7c5bqpZRBCbytMrWjPR8u7KjYbfHz2JS4jHD
	lTneEdvsl+jxF89yaoTYpKydboCJ1CPebKXs44VoXK7XxhZejs2b6UvA
X-Gm-Gg: ASbGncskZc4dGm4mXtKt91DRSNXHoGVSBSk+jhYaX+p50+b/ru46XrEJBijTwrtkUAu
	SMllj7DzQVp/ZB6TQaGD8H4UYEVWUQEK4+AN02wFYp/C8n0ZJDCxFrIE34I4jqXLq6MWzV8fN5p
	x6SMQvFgszA1l0Ie6icOXJfCmItvOZ79VS6WFfA/3P1R0KVmGkqzN9iQ6zy43n+O1vggIBwWXCQ
	e/5WwYdgssg89UMas0YUwqWPcKykD6K8gObIFtg6DOE0Si92NFCRcEvVVRXkw4ZItpQiwqAWHwQ
	OG15hIPJHWhaVh8i/Aiumy+QSzUVFoA5vemAUTG3/s1bVJJL35RjuMFA5Syh5yEKpJysuK7vnwt
	gnkLBWIc/O4QvKqZKuwXUMUp0qeoNRVL/7LGfHB1dFaZ1lrSvKT1PU/KkJ9uMHswTbeyuxKIdfT
	zwHzpUzhu140i9U1klKfyI+VY2O8kDs9/KTgwhRn26
X-Google-Smtp-Source: AGHT+IELjz8q9Wh4r7dTEajOLlhaehyVXuIINojrCEIqJ4/pZdMgPhXlF8x51ihCR4TA5ozMBPdmQw==
X-Received: by 2002:a5d:5f85:0:b0:3f9:1571:fdea with SMTP id ffacd0b85a97d-40e4cc630b2mr20809863f8f.44.1759222020801;
        Tue, 30 Sep 2025 01:47:00 -0700 (PDT)
Received: from localhost (2a02-8440-7149-a758-f461-9bc4-1c75-ebc1.rev.sfr.net. [2a02:8440:7149:a758:f461:9bc4:1c75:ebc1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2a996e2fsm282983795e9.2.2025.09.30.01.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 01:47:00 -0700 (PDT)
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>
Date: Tue, 30 Sep 2025 10:46:50 +0200
Subject: [PATCH v8 7/7] arm64: dts: st: add DDR channel to stm32mp257f-ev1
 board
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250930-b4-ddr-bindings-v8-7-fe4d8c015a50@gmail.com>
References: <20250930-b4-ddr-bindings-v8-0-fe4d8c015a50@gmail.com>
In-Reply-To: <20250930-b4-ddr-bindings-v8-0-fe4d8c015a50@gmail.com>
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


