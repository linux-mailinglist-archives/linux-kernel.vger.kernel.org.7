Return-Path: <linux-kernel+bounces-665313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D652AC6780
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 12:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42CE17A7C7C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 10:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041D0283FD9;
	Wed, 28 May 2025 10:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vViflLmX"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A920283FC3
	for <linux-kernel@vger.kernel.org>; Wed, 28 May 2025 10:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748428938; cv=none; b=AVa+ptsL2I6A/3k8bQam2Xh1QI6m3y1G8TJmzakhXbweKY7CMFbnDW8GhfEHn47HLgN/7fDP04VSrCl+kEEoZtgmr29GoamkvAyzQs77OZpTVpeQ8DfjlcibcrWAh0vJqFc5hvLHtHq8RYCvJif/Us9Dtqn7fkO3v9Nu+H/Pl6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748428938; c=relaxed/simple;
	bh=dTmy1ylBupLBEHMWc/Z23V5px0USEJlmCJKSN1EAvfE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rlfU5Xd2pl31rHHZrlOEyk5Sw4Q556afwUjOUdoY6Jz1Ji72JGem23FyrfMRE3bzUOHYwGFz5wFNFJNghhmMEo3o2nqrMiMrCtPGIYfXmt4ZodW6XGliNat3a0p+8UO3+cMjhODU+bpJjtviuS1rZzTCdoZkuIHIX8XLXhQl2ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vViflLmX; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-442f4d40152so5987895e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 May 2025 03:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748428934; x=1749033734; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sCzXGrMy4mrth9Y9XnnMqTwemBq/IlPbQZ3QBo3OiYA=;
        b=vViflLmX1qVnW6soV6rjSZBoJZrb7wPAxtn4e/EaVt8rJMDxqTzbwamgP6t7olJTNP
         3q/xWMeH4fGdTSiODY+mbssXpR+UFTmjSQYt4ff2q/toKIHYSUjZ00Xh4JQabAA+n+fr
         0Jj9aijMyyDCH8qzQTrKpq6VUbIbLCKZI6ZXs42kMV9/F8yFAOx5kpVluI3t0SAfs9r0
         mvRUqBqhc51gN8V9dJAULkrK0y2A5oekKofRg9e8tHxjV+vEe1FgGEudp5fWsfWKUdot
         f5lMY8nfEMQKx0T7UpRkPcqnQAQs3dftycmdOlVU8SUJkIzH62TVBoliAfnFWIHi/eAS
         QAvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748428934; x=1749033734;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sCzXGrMy4mrth9Y9XnnMqTwemBq/IlPbQZ3QBo3OiYA=;
        b=Xq3X6m7KAYjJe3oczhHVUH2y1s41QNdEKT6qw1mQwIgpeGmSEh85XYNWfiCZSk0bZf
         3WYIEbGXvkhFXHS+N7Pk6nVptLVdlWxaUCbdhLoQz4QmA3BDLfhqC3qKNY0qEpERPDYE
         MV07XAMuAcpacYBefgOxu+d6dwjC1qj4X0OSZKIkSKRbVrqzpOoCeWYG+DneOT3BeExZ
         J2OamkAxX3ibaBAvy8lCnsHSS1jx1rY5+AKeJ6BE/KD58tbZL+Iad81xUMl5eQqV0eom
         zRnI5jccvT7UnYoaIt5VbOdIZ2BS7G7ZCMZWTRmZX+Myp0/KqJTIzbVIuctGxPcgMH9a
         NxHw==
X-Forwarded-Encrypted: i=1; AJvYcCVivYTO3mnNxt6cpodLjNXu/tbKaCPTvDZZ5sz6wJwacknNDyCa0RaDUmmvhYzY1G8UrxU/aUEVy6ocRCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsCiH6N2TGXkLg8w0m+PtsIL6sGPO1NBRF0IvpcJtReTolOLmB
	T61YEkMm9qEbR8Q7DIDmM4R/rwZTr1YxHqwWroIGlgnGerJ8wf4ARXWijcwmQ6kGTZ4=
X-Gm-Gg: ASbGnctmVMPTFi4/13hB/biz49pHJGJYVNmjePHJApjhQS1RqvtQsl1K1SVJqTCw+on
	q3ilB2KhtDBUSjVw0ytdRfrkgj1R5GWI6g4ybKYxejm4qhCDf6t+edaxqPnRlZ7BDlmCNfVq86w
	9//pdksj3IY6bYj0lPqE+qkXntS68gaW3lXHC8xpMDIX8R3i1FGN5tKLHmp2YdW/yLeb8HIfl3h
	tUXtQthXSafnhMAw2gDxcL5EMuFcC7pe7Nnrh0AkB4LBrXI/SpAhKiMmr5AM0krKUCErc/NPC1+
	KHzYWgTYuQmUp8kaH2YtFukjh4j/hSM4UX6OMry1H4lAdgNiCCWFwZeYjvP6hCnxHy4Tvmo=
X-Google-Smtp-Source: AGHT+IEezznZ4tc//+iyg9VgEejs2PqgHy+UHoiBZ9D2eixnIzEPRTC2rWF2EYyDVV6zOvpBJosC8Q==
X-Received: by 2002:a05:600c:1385:b0:43e:94fa:4aef with SMTP id 5b1f17b1804b1-44c93cae9acmr51123845e9.8.1748428933700;
        Wed, 28 May 2025 03:42:13 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.223.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450064add8bsm17331595e9.17.2025.05.28.03.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 03:42:13 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 28 May 2025 12:41:09 +0200
Subject: [PATCH 13/17] pinctrl: palmas: Move fixed assignments to
 'pinctrl_desc' definition
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250528-pinctrl-const-desc-v1-13-76fe97899945@linaro.org>
References: <20250528-pinctrl-const-desc-v1-0-76fe97899945@linaro.org>
In-Reply-To: <20250528-pinctrl-const-desc-v1-0-76fe97899945@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>, 
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 Avi Fishman <avifishman70@gmail.com>, Tomer Maimon <tmaimon77@gmail.com>, 
 Tali Perry <tali.perry1@gmail.com>, Patrick Venture <venture@google.com>, 
 Nancy Yuen <yuenn@google.com>, Benjamin Fair <benjaminfair@google.com>, 
 =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 David Rhodes <david.rhodes@cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Charles Keepax <ckeepax@opensource.cirrus.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, Sean Wang <sean.wang@kernel.org>, 
 Jesper Nilsson <jesper.nilsson@axis.com>, 
 Lars Persson <lars.persson@axis.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Damien Le Moal <dlemoal@kernel.org>, Vladimir Zapolskiy <vz@mleia.com>, 
 Michal Simek <michal.simek@amd.com>, Emil Renner Berthing <kernel@esmil.dk>, 
 Jianlong Huang <jianlong.huang@starfivetech.com>, 
 Hal Feng <hal.feng@starfivetech.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org, 
 linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
 linux-sound@vger.kernel.org, patches@opensource.cirrus.com, 
 linux-mediatek@lists.infradead.org, linux-arm-kernel@axis.com, 
 linux-riscv@lists.infradead.org, linux-rtc@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1235;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=dTmy1ylBupLBEHMWc/Z23V5px0USEJlmCJKSN1EAvfE=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoNuhUPwoRAjJQz5PFO5DfSHTMd24hsqTzRr2IB
 0jOv1r3k8mJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaDboVAAKCRDBN2bmhouD
 1ynAD/49mYORosdid1df8HmR8x/OWiv0Zm6goccLiqpVflRmzsFrLN+cLFMbhxRMl34fM3yuPci
 b71Zx42gtn/VEKIdJ4nLISvF28thcNbAG/plhINy2OOwfUm060Kcfaafl/ZP4AiXH0q3u3BS5cs
 fRHQErxwUgQBlHIgCJL61LeQp1Whs8/m3ImG8NPjZwnPdezu9Oczth6hm/aG0Og6NB4QdZkVhtO
 5xyGBrnkXFjRo2HmrUPl2PTYkNrTEjBPv4EZH2uCaBsHPSd+ND4J/ajWESZ3Vh0wXEyzTcd3/jl
 dCsZE4KBxpy/+gWzMFnXBN0HYTkqwqwVnkosUS0jsWofWTu/7iijgYxr0xF9ikcr3aYdlxgxGE8
 kkh76EFKdrmG1NbdijJPiOC50b+vAChB+zRdWvfXUBnmWsm0/uJC0Z+ttf7Nxbq4uFdgZVfD95d
 z6ZimmSBL0cf2VB2RBfUdZPPyT2hWvFdDUyrrSsugiugcfo/m1MciUEAKpSK2bk6d7S6K/ZP+Ie
 ydztgCpY5oH2z4aXxETIgUcH2X5Zx4g5H+iwFhMME8VjfrLHe+T6xEeRsGvuWg4C7Ij2NMquouc
 skaEKK7orgbEC9jAJSV1kP4K0sFWd0Zdc431k7p0EaxblWY7N6iELiPx21AVf6/XJYBh9eoI0r1
 RBtd9sQPwZc6f+g==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Assign 'struct pinctrl_desc' .pins and .npins members in definition to
make clear that number of pins is fixed and have less code in the probe.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/pinctrl/pinctrl-palmas.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-palmas.c b/drivers/pinctrl/pinctrl-palmas.c
index 9e272f9deb4f8c49f91d2f09c2c100018a7617f8..d69f114e46426c345d9ffe7567a326eecdd91bb5 100644
--- a/drivers/pinctrl/pinctrl-palmas.c
+++ b/drivers/pinctrl/pinctrl-palmas.c
@@ -956,6 +956,8 @@ static struct pinctrl_desc palmas_pinctrl_desc = {
 	.pmxops = &palmas_pinmux_ops,
 	.confops = &palmas_pinconf_ops,
 	.owner = THIS_MODULE,
+	.pins = palmas_pins_desc,
+	.npins = ARRAY_SIZE(palmas_pins_desc),
 };
 
 struct palmas_pinctrl_data {
@@ -1023,8 +1025,6 @@ static int palmas_pinctrl_probe(struct platform_device *pdev)
 	}
 
 	palmas_pinctrl_desc.name = dev_name(&pdev->dev);
-	palmas_pinctrl_desc.pins = palmas_pins_desc;
-	palmas_pinctrl_desc.npins = ARRAY_SIZE(palmas_pins_desc);
 	pci->pctl = devm_pinctrl_register(&pdev->dev, &palmas_pinctrl_desc,
 					  pci);
 	if (IS_ERR(pci->pctl)) {

-- 
2.45.2


