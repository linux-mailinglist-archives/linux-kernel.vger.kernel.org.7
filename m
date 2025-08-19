Return-Path: <linux-kernel+bounces-775814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA61B2C540
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C05E3B1D8E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3417B343D85;
	Tue, 19 Aug 2025 13:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LSPYjr1x"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7897343206
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 13:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755609427; cv=none; b=elB7xo1J/xnW+RYVqOFrmSWWRJJEpATVb8SG1a9e2KpFPhzC7S/m5GNbB2ccO1PIAJE18M7c1CJ/oKF+hsE+f3By6+lEK0HDancY2h1x//RtruyRwbWesuf9Cf/4KnHWWH3+7TSKHPXnP+ceFI68TSDSjK0VHXVcSt5bpr/P16g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755609427; c=relaxed/simple;
	bh=ORjrWSJV9aCCGAusfNEVPPkAuUkckxWAi/ugZ/Z4HPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EepIdr8fYuFZ3X5GHU811b49fipVmqjo0ae0Q8ARabDAsCrF6k9OOzPUTFxS+b4jp3X0MvAKmETQJ9C756FuwXCxHHhgUe+LTJfyGdrTrolzClSCtPvgk/wwsUZ5O5vs/CY1Hqnz0wxRCseNokY3MHvSLe7qinoMGMaKio4Cl2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LSPYjr1x; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-afcb7ab87ffso83184866b.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 06:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755609424; x=1756214224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ul4oZAmMUIisCohsZ+bnfu1tIYQt4ZmQITM62Hcbbp0=;
        b=LSPYjr1xfIF8lJhSpH5hP6W1Utkt/cf3/0A2opTlqKTmmoIiG8uoTPBLgGljuNc5Xe
         7isJg7ZxMoVLT/jnhcVx5381AiVbtCurg4eglwrI23t8kgmvjTX3f/4xLSExounzufeM
         sVv8cWqNl1PK1wgTh2xLknR+ouQh5b7t2GsLrGTFmZ28oK9JEUDknz21MZtz9iFTqHgK
         p+V3+Uq/e+NXJbMwtIOEUygNQaFFtMa060HTl4m8+UpTp86BYA6IvmgRuEj2EGQMLWrD
         wqbY7cjsEsOJ2hFjiud8MwZcT86aMgUxOYo94tVYvlZ0P5ecSti1VvQDGWGr5OA92kg8
         2xdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755609424; x=1756214224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ul4oZAmMUIisCohsZ+bnfu1tIYQt4ZmQITM62Hcbbp0=;
        b=dLlwT54fNFM3dP/N/YzPthbZN+RQNQZ0cTgSZ94fZ0lJk76TqkqqJCvmJufQYjsU4Y
         mBQlSloGg/Qgo07j53glswc17tJn7FX+i4WulfBT0TJlw/x4fTXCed7g/svFSoeGTBaO
         BPhaJsAYGMK8XtxYPKUxxgSUdGOohTcyXKdJFY0dt++8VrqHlHizlihhTTqtQfyqtBG0
         vgICs++RWVwxLrs4kYfs+bePpcNzLimr1CPoEq9JeaMZ0dFTGN2QyFupY/miZSQHp3RA
         kUhZPsIl0qR0hkPvf0puGs3/MO8+a3euGt4SgXp9onw8KLZhdRMYcvv7Kf7jog6HO+q+
         KVQA==
X-Forwarded-Encrypted: i=1; AJvYcCX3nKmWaoiJUZSHRd98QNgA2U9TztNmWZwCHFkNzwj+dDQNmUEA/L5+SPFTnvZiRYXVlBt5D8VmtjAUa+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzI4H2Mq9LRhW9CtMVMoQDRN+R0etvU7zPEBMGAQOX6/5vdEkV
	KgNfzWuwp9g2TdFf3fkNucRjKu/kFVs50UsHfGiW7Jp51016HygXgPYLLqlfrLL8KLY=
X-Gm-Gg: ASbGncuqZqottD7+RIQRfJDfgdfJNqy6quhFh4UOIFi5C5aruMvybK/QG6R7jyA/bZL
	MKGDchDD3wbNokYtuuLSPlEdVtwU/L2JpkxN2q/Hn19vVpP6QwHlHI+xFNBCwtM2uA5IeSRixjX
	AkOk5f3q1kaAKvmMrtQ6Hdhcl++8IVb9oN3bJljcGRYx7Acamq7QkD1UEJShCVvRnnmFvnrpoZ3
	e1aN2GXGTcIWTKwiMZQ+sKFzfmLUcQPndtMfo9+RRTbIjKZnen83AoNutGhkXJ3cGBVXXswbY2S
	EDk3XDBNhID76vmubwSYlPdxREf6rSaBQVl6aLc+qTmwwoUk2rGhVOhE9QQ1YFRZhtI6Lw30m2s
	STyg2XKynW1EEzH43/ZSjDAZNpD3FX5SWrG+420FikY77
X-Google-Smtp-Source: AGHT+IHIEZ0cqAuQ9z2NxnVy2zmkSoGqZVpGMt4PSnkN+/AzbQ7kBspgtZUPvFrM+aYznnjNvgIxIQ==
X-Received: by 2002:a17:907:3d03:b0:ae3:617a:c52 with SMTP id a640c23a62f3a-afddcb63ca0mr100010466b.2.1755609423877;
        Tue, 19 Aug 2025 06:17:03 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdcfccea7sm1005948066b.67.2025.08.19.06.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 06:17:03 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Tony Lindgren <tony@atomide.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	linux-omap@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 4/4] arm64: dts: ti: k3-am6548: Minor whitespace cleanup
Date: Tue, 19 Aug 2025 15:16:55 +0200
Message-ID: <20250819131651.86569-8-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250819131651.86569-5-krzysztof.kozlowski@linaro.org>
References: <20250819131651.86569-5-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=741; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=ORjrWSJV9aCCGAusfNEVPPkAuUkckxWAi/ugZ/Z4HPI=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBopHlGHslltHets9pe9QRd/Nka4ehFvGyWO1fzw
 3Crv5EMFQmJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaKR5RgAKCRDBN2bmhouD
 1xnzEACSo5uaWhdcpZ3vxl4F+ufrZhnxwghg1RpSkqDbNjA14v/O14NJ0BplGA1kN9H6teg0/tD
 45eZc5/jrsjOU2ePK4/mzmrVErEppjEpBNeiWcPc67j5nPnt2RZOeJEDoFNq+/QPZB56FRbVooT
 8jVo6FZiqWhTRQDrDBasWAvXwW2J+vY3KmturJdMyvmaTUlvE3jS+vS36IqXmXbH/ZJ3wvmMK9m
 No3A9cORAdHIkilGC/8fh5lo2Ss2IUPbhGOQptgHDdGUimDF9S4piGtE3ZUCGX1RA8LzSD+wE5K
 rsc+TbXc1scsxMYLhEgb/cKHNLWKg6eIFZcCcp7HSEHLPBBf26kFQAryE1O8xglgrC0TkY08dHS
 csk8/K3o2iOkIA+nEF3ynmMLPTYj9a917Qvtfoq0XbVZMzQ50wDpj7EdWcded7k97bPrb5iQw/j
 mL8M20Cs795m35cCeBdFKtBwgeqPVs/HTfUgN8LAQYbPFOtzb0ixnuJppGmzeKobrUT/tFIeCQA
 IxdroEfyAMgsQyru3AGY20HMh4Okr9J43LRAYPrHMChOJ/TssH5/shCRQxX9ZV3wc9M88LQvZbv
 uWW8cDEiUGIJx7MhidAnsqA/6WAKyXN39bFNt62VNYMVWZxHmwVbf+nYllcHCN6pjShEEVuPnzN Mcg5heNDUIFaX8A==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

The DTS code coding style expects exactly one space around '='
character.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-sm.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-sm.dts b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-sm.dts
index b829f4bcab69..adf4da7dfa2d 100644
--- a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-sm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-sm.dts
@@ -145,7 +145,7 @@ &main_spi0 {
 	pinctrl-0 = <&main_spi0_pins>;
 
 	#address-cells = <1>;
-	#size-cells= <0>;
+	#size-cells = <0>;
 };
 
 &mcu_spi0 {
-- 
2.48.1


