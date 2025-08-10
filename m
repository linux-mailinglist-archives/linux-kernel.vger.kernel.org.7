Return-Path: <linux-kernel+bounces-761422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 327BDB1F9E6
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 14:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B52FC189A36C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 12:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A0D262FC2;
	Sun, 10 Aug 2025 12:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="YbKEMTE8"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BAE25F7A4
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 12:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754828514; cv=none; b=rZ4P7T7AnsuPN6OmU/n333OM9IW9Xg4PS17lEkOl9FLFkmQA7gs8NYk58ZZg1JoXOp7nCn3Tp7lsl0DcS0xQ9uP9Xaj/LN/KcBzkrtV4y7KKLHefCLGwmbBOspOFM2MzpdO3ufRDcUNYPdN6b0u3Ik9K5zw8S8SCL3ACjui+Qtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754828514; c=relaxed/simple;
	bh=WZSwcNr+pcS2CFvCJqEO0bTLFx2Y5UNax5ZJ2og89Us=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D4mQPigzlJprukpRhP1UQzHhv9RUcnBQeHCv5QQhN93/wwujv10azpJSr/+gjoqRhDcsp1QQ4JTzMMt1AmOghtWxn1z4fz9apzBgkhYrQSItkqjtmqAPF5YTgjijNl7TL7Oo7tLRBJ4kBk2MR8t7/SVSu95PdrfiDzM6CZzxmUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=YbKEMTE8; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6180ce2197cso1929862a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 05:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1754828510; x=1755433310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IdKoLiN4BRQR4DmjNDMMqfI3cdNQZlmAjUao5oPGRe0=;
        b=YbKEMTE8gIFdGyrqJDxqYur0LPFpXattN2f7+5jnXvTdloPFNqZn/mo9FJjYO7rScZ
         cwPavncIccB673ocrJlCz2NVyCCXlZVVfAOtY8YHPIxoxvooWPz6rD6IMeCteT6R/9ye
         ch+Qh1ciHgDEs1AHNR+oZpwpku7CwizYTk1jhGWIZs54ZgZ9juqJuX2wIAeUaRLpzN+j
         GwAsV04FvuuXA5qyyzHEeHzb4ewQA2gPPgPJhB26qT/jsW6iGo0CevqBttADXfaUfoCd
         4OkoA2t6JhnnnmLBrxpi2/F3vvzfWW1IDELqx0iOaNhTGMh5X661S38klfkZbASwgmrD
         lKhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754828510; x=1755433310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IdKoLiN4BRQR4DmjNDMMqfI3cdNQZlmAjUao5oPGRe0=;
        b=sbYXFOjAd2G91Y8WhDNJqBAv44n7fjwcs21tf+rdxRh6KZhsOBHERefFh0SZt60nrY
         Jd9gcMaQKZSRo8eQrOH4lED89ar+lizAOKZtn8qkjbJw2ZGR/kkeF/eGjWu/cf05jEYl
         2x3X2C1JgEnYJQ/OHzmO7bqqD8QTCCwPMhXB9T+b2842fyLmLpdJDgTACSyO62w3ee76
         gDd/XD56zHy7QAHhh76ip3MpPi1qP2nmq4S26I3s2ZBBUf5+GSieyiXizvuFPuDXZMqg
         bTVaCPRR/5Qr/uHSAdTJQPQsJLv0qzuXnBqZNvtCFs8yj31HOsJ8b1bNMJsr1/FuQr9v
         Xzkw==
X-Forwarded-Encrypted: i=1; AJvYcCXWxlfdKxzvofBv4GRYnCjiLgqDgHHYvP4YI/S/aILeVX1XitYzri7jFKtH2gu6eLehIUSONsAZxQ9LVRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeTArgYXOo52ou2wgJkamezR69Qz1A09U7wXThXb/zyiHDLq2H
	xRUM37QPtSJEO4/Bdd7YhlBHldCoa7oQcQXEQbpwt8Kutmk7QYIOAxqa8m+o+SdPh38=
X-Gm-Gg: ASbGncuberDZstS2eRpC2q5dxoX8SniVO1Dp5ccrwpn3blQXLaVTjg3ldKMkRsZtwwj
	FT7+7ULDsakae0eMyCYbFif5fLdUhRLaJXmg2c+9HO5wD/bjA6hW9F7vE2wGfBiwYMfbO1C6h2W
	j+WCXhDEQuXTpFIurSBG1R5x8J6fGZoVDEQYPxVAdg3BAiVg66RR34z0kx7b+P9u1L2YSwxSMR4
	BimswF3AguDPn3nwfNptUBqzJbJ+AlxH0LcnXXsAswtUSd3ZohlV44h2ARMI6Mh290FVGRyiI/X
	eeidqMwCnx5tzQrEM0Bl6AN30/eikWjqrMn/D3Xlc5J8Uw4o9VPtStj7NlPE/v2AhUPkRUgOpxp
	Vyz058dtmZpdRbKLjCN9vsCWwZhkQSwhZDe/juS2LQfJDhr0r4V8Y
X-Google-Smtp-Source: AGHT+IG1VR8s9CUfGvRNrN+MgDdRWdkJbvcTgCrAzRGDjCO8ytytK6dbDH9qosonfYZ+QdH1pck48g==
X-Received: by 2002:a05:6402:13cc:b0:617:c6b1:70e4 with SMTP id 4fb4d7f45d1cf-617e2bd993cmr8435556a12.15.1754828509709;
        Sun, 10 Aug 2025 05:21:49 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.188])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a86758fcsm16611897a12.0.2025.08.10.05.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 05:21:48 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	niklas.soderlund@ragnatech.se,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v4 4/4] arm64: defconfig: Enable RZ/G3S thermal
Date: Sun, 10 Aug 2025 15:21:25 +0300
Message-ID: <20250810122125.792966-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250810122125.792966-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250810122125.792966-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Enable the CONFIG_RZG3S_THERMAL flag for the RZ/G3S SoC.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v4:
- none

Changes in v3:
- none

Changes in v2:
- collected tags

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 58f87d09366c..540e85a0c676 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -728,6 +728,7 @@ CONFIG_ROCKCHIP_THERMAL=m
 CONFIG_RCAR_THERMAL=y
 CONFIG_RCAR_GEN3_THERMAL=y
 CONFIG_RZG2L_THERMAL=y
+CONFIG_RZG3S_THERMAL=m
 CONFIG_ARMADA_THERMAL=y
 CONFIG_MTK_THERMAL=m
 CONFIG_MTK_LVTS_THERMAL=m
-- 
2.43.0


