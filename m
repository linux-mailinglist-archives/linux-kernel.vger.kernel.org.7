Return-Path: <linux-kernel+bounces-813975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD50B54DB8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 462FB467BB0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8498D30EF9D;
	Fri, 12 Sep 2025 12:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="UuT9PLWb"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31EC30C62D
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 12:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757679903; cv=none; b=SjiT4hBRC1MezXfbfek8J+QQFWvlMVWLRz8HxBc+h+nefMjKpNEoVl70YO+WKSWqTlXfvQvW1Vq10sSaaQTJWhYU/qqHFwajjZTqFijxcLWsCxUi0GNqxNue+dHEKdB1gtrYEkpQYNzb3859qNqRDz6Kbexofgr++RDvOEJM428=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757679903; c=relaxed/simple;
	bh=rlU12FG+4sUq0XnXmaxg6zY2V7ONJn4T+IfJgTnkVPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D/f4yF3vpTv1egT7JRt623r0y+0Qj2ePPgllWa2YBBuAFefiRKphGy/BOfFu2w9TtEtYf5zZ4hbFtL0MyLcNZ+GNUPdBvVtjmFsYOxqyYk7bPxYenjpRcdTbqX3V9saZulrJSGHdIfdFJh8RA2PYbTJ6lra428cv2J0GPTOHzkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=UuT9PLWb; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3e2055ce973so1041855f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 05:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1757679900; x=1758284700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=md5nkDmRRh2gMN/cfSkiCbamlknh5oiGopcdy0QJF8Y=;
        b=UuT9PLWb2lfWbAIh0WkT7qwgzoW0KT8KC3XMLU9NE5FRaozLRPm4CS8L6q7a35uSL9
         49+DAdxtYhNJIrCiw6sz3BYnCMkDSu0MIquWtcQAyeAOnLMJF+LNcb0dvIgsKZpYhXs9
         5oq1c5B8AZL9zrdbYBR21Q/Bn9wbOSsKvzA1WbREOC5qmtIDZ3eHZslt/6rKxr9Htf4i
         g7JJrb3SosqooP9y2AuPB+hZdsII1wlGE7kHcYf25imF9A1TmriSUzDLPyC6GDLCKGu6
         8jQbaSkmnJCymmITs7rPIi9serU0ipAcFhuoSMuSm2EKES7uZKHNzpd2e+Y8WVA77jtZ
         hAJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757679900; x=1758284700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=md5nkDmRRh2gMN/cfSkiCbamlknh5oiGopcdy0QJF8Y=;
        b=Kjp2yC94Ufple2P+07UR3Xamzn2prS7mGtiiSyMJT/3mOIwWhe1CQDwtTdLmZE6m/+
         G/wstWc1IngcxVPwJfTBANEsenUWLJ9CixatG9Zsh85c7o/ycQ3dURbt3Jaz255/Mqen
         IRIKsGEIGkpF4/3GckA9WefJwCQMFpqoXJ/TKBOru71e9Ws8TmPF2lH+vkFpoOh0QFmF
         /TbwelLDVjNtLKd8g9BYwkH/GAm7h092hO49R4orXmcwNERv3XObtfY078Xcpto7Nkr0
         e4HTlm0xgJTt6AMbn4qxrSxLCDViBunYutlRWVaQQPuPzfaaU+1wHvYDjeWjiFGmN0qt
         ujTg==
X-Forwarded-Encrypted: i=1; AJvYcCWG9enWK7NgDc01RU651jdV7bBSfjTlIC59HsoLrqk5tcKnxh2xnq6TZJBVuJHnap+XEIPxbxRAVOMD7X8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaSRqK4XsGNgEPutuA1WNT75V8EkO2oak0H/8DxJsrkHbKZHaf
	yAyslHR3kVeW/e+IZRofbxy8YWYFVc/vKFtr1auRlSI9Rr0IuuDzb6hclVSoaDluJ94=
X-Gm-Gg: ASbGncvc0lHfKi7cZmfp/pXLgV4MQ9dqWWdzXoBVOGKlv0w3yl8B21LoLni4LVmOBxt
	DtUJSpvGItEd3wB6Dv4kgySEMDnXk4LXBVLuRWSNnLkWDnLSr/Woa4V50W4FlPut4EqzdrmlZ99
	rkWnRFTD/ncegY+X6/ZYQa4FDNQ0CvTOi/24LfcH57gO/c4hcUdtvMlMWrmRNl1qWJRmTiFNc1s
	PaVjXIrFJS48Re+qimnPX6jMYRN54r4FJSmCNVNFcC2DO3JscMNZwS59wcdPtzEh/iooTSrcQgc
	xdbabQlATdpndoszrgzxkiyrP6Lj7Uso64eQ/bfli7kGSFx2ISOf8gSqSvpIAfHkOsLZKl+JNOJ
	3TT7OEK+0zogye0fJcpDnq35ysqnK1Z4AgduWGxuOm2nmH477vlMC
X-Google-Smtp-Source: AGHT+IFeFgkWbvNLPP6zQb3x+mqbY/nkKchmA7T4My9baxdYYpQETFEEocYlizuFZpzNAgPRzsrfUw==
X-Received: by 2002:a05:6000:240b:b0:3e7:6457:ca85 with SMTP id ffacd0b85a97d-3e765781280mr3017656f8f.5.1757679899686;
        Fri, 12 Sep 2025 05:24:59 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607770c2sm6320091f8f.8.2025.09.12.05.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 05:24:59 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v4 6/6] arm64: defconfig: Enable PCIe for the Renesas RZ/G3S SoC
Date: Fri, 12 Sep 2025 15:24:44 +0300
Message-ID: <20250912122444.3870284-7-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250912122444.3870284-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250912122444.3870284-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Enable PCIe for the Renesas RZ/G3S SoC.

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v4:
- made it builtin

Changes in v3:
- collected tags

Changes in v2:
- none

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 5dcf36e99cd2..ca731843a9ba 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -230,6 +230,7 @@ CONFIG_PCIE_MEDIATEK_GEN3=m
 CONFIG_PCI_TEGRA=y
 CONFIG_PCIE_RCAR_HOST=y
 CONFIG_PCIE_RCAR_EP=y
+CONFIG_PCIE_RENESAS_RZG3S_HOST=y
 CONFIG_PCIE_ROCKCHIP_HOST=m
 CONFIG_PCI_XGENE=y
 CONFIG_PCI_IMX6_HOST=y
-- 
2.43.0


