Return-Path: <linux-kernel+bounces-759762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DA5B1E21C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 08:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05C9018C3C41
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 06:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99ED225A32;
	Fri,  8 Aug 2025 06:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="kkvgosaJ"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CE82040AB
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 06:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754633908; cv=none; b=B51ZB/Umaj17b2GMDQGdO3XfcsuwzvsBe1vzVT3j1STZpq7POPADaO208vOVluuPce1f7ZOrGvtx/sGb4Vq0iVWYTu2v0VZ6qOT+245DeJGRaAJ0t5L0pI67u0p/8asObuBF21NQ8IDwusIX4Pd7nfKtz+9+p5sZlgM9up4MTmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754633908; c=relaxed/simple;
	bh=DV7qaSxkgQncKuv/GTzdbgjK+UuA/kfChHmdQOLS6kU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SSVXw+izW7DI6lrBZp5FnlIgWH1AChbxEvUhrxAvbL4zU3fF7JVe5Y7wq9lkuQSOkSxpE/RoOJIGeuoJKs5cDw/gzd3kLJRGP24BkEFpgtWuxYKdw2EKB9ugaYuKb3csJzRPXe7fqC5tONrlVh04cDkQ2XwqFdEqv2sI2m2ubvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=kkvgosaJ; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-61568fbed16so2790029a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 23:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1754633905; x=1755238705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fhbtdj94kG4NkUv432zTOJ/Zv8zWX0enR1AW1GYhXCI=;
        b=kkvgosaJAEmUps23nxR9V6gZEqubmaPBOPT/YlrZCUu10c+BtK7DlqmY58XwU5CFdb
         HadjUNU5JbD0i+cSlRmx2Ou5JL5MOmppi0R42Y0vqUgLle1hBfmaCXgnp/YsQGT25EoN
         tZ9rSsuvQWj2BWbn47z8tVkyJbiw/S2QK5nTS/+vkvTgmwR3hVE+tFw9EN7t8g1KBUyI
         KF1fJsMMoFZb1FFFg+rZvrpUpPXOKiUNUtQd+DFQgbJzYCpOFwJ53hBx6U/jR+iz1QnK
         T/L7tn05mkzLafeQeTC6VudLuT7rY7yFl1uobY3JLVQaVEWNm1yVrSMLXRsGQZrzN2Cg
         jy2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754633905; x=1755238705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fhbtdj94kG4NkUv432zTOJ/Zv8zWX0enR1AW1GYhXCI=;
        b=avCzazKcKkfFve3oTUes6V73GoLwu5ZWiSxuAizw+nkRHiuQAbJXrF/pXWTmp5D0RR
         WN2sAYLHuBmDWSBNtNjhkf5sUAyoF17mBNNfZ6qtF9wjiJUa1PbJ75YrkCgUqZftSarX
         1FEqekjDJoNFVRfGbVrnVdlhNu1sdbHzvhWOTiN5LlqiM3M3QiZO+guVuMSreT6AW1kC
         nxgtQw2sRDtnfXPKT8595+OhCeX3p0v64UOBkBQMxIaNkyZ3Alefrkm5xkUMoYpBiZOt
         GsXR5rbBi9n/Keo1johBzsD+EmeoRwKZzDhldHPDWwpSd5pGJiOVDy3a5lcm6MJFdkf2
         w/kA==
X-Forwarded-Encrypted: i=1; AJvYcCUXyZVo0RgwPDg+kqbO3JBvMtRLcHE76XLmSThd6khoiSnjBjzl/0fH9BbFN+y6NjLrjgTdGgSyWyVkGoU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQLVkOtdw1MTndEpS2EwskcEQsaxY7o9onsySKnlqWSlncTJHK
	xyyVgLCi2dcplA0KDHDlOMyQj2nw4GmgEDZk0bxMdOQGn5J2r1qmm8LUVsF0U9u7hFI=
X-Gm-Gg: ASbGncuvkgKOgExl2LaXBTqpirByHTaTfeRK1H/ws+qQtkfuf1T/932S5kWu1udqdtn
	UV0dZzAF95ZrJnbXEe7kTrJCOQQhYLUZCWG4wukauE10x/OGUl5m0EuPZxjmD091Vdwclt65kbC
	TiV6752mUhnOIqXZIZAm1OLtKqu/asmHjUuvYxmehdWlooYjoYT8wiOgvLvPeh2LE4EbKwvvTBe
	p1Y6lotZt3OAn/kXQ6T14G8aGdPtC/OnBEMG8px+PtV6jKlwXnuD9XSIOPe1r1O/APIaPLmeUo/
	+/+3g6KYhK6ZBGlXLqcXFqy5/0/unQ78FfrO8JT+HXQCKCIIbggMbxqtrOSHL29X87dYG/m6TO6
	cv4UDfJMoQcmI5R6RkTFHlEbM8CV1LyWuF1vLpD9TNcxjVvaIwJzf
X-Google-Smtp-Source: AGHT+IHjyrVfPv/9Ic5LGXUUAuL+aPH600lqb/NKnTolyX4B+YeUK5CzWrXMgb4RJiQ3RI7UIsodxQ==
X-Received: by 2002:a17:907:e8d:b0:af9:a53a:6b38 with SMTP id a640c23a62f3a-af9c63d4439mr171415866b.20.1754633905418;
        Thu, 07 Aug 2025 23:18:25 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.188])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a218ab4sm1440488566b.92.2025.08.07.23.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 23:18:24 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	kishon@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	yoshihiro.shimoda.uh@renesas.com,
	biju.das.jz@bp.renesas.com
Cc: claudiu.beznea@tuxon.dev,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 2/8] dt-bindings: phy: renesas,usb2-phy: Mark resets as required for RZ/G3S
Date: Fri,  8 Aug 2025 09:18:00 +0300
Message-ID: <20250808061806.2729274-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250808061806.2729274-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250808061806.2729274-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The reset lines are mandatory for the Renesas RZ/G3S platform and must be
explicitly defined in device tree.

Fixes: f3c849855114 ("dt-bindings: phy: renesas,usb2-phy: Document RZ/G3S phy bindings")
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v4:
- none

Changes in v3:
- collected tags
- rebased on top of latest version of renesas,usb2-phy.yaml;
  Conor, Geert: I kept your tags; please let me know if you consider it
  otherwise

Changes in v2:
- none; this patch is new

 Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml b/Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml
index f45c5f039ae8..52d777057281 100644
--- a/Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml
@@ -112,6 +112,7 @@ allOf:
           contains:
             enum:
               - renesas,usb2-phy-r9a09g057
+              - renesas,usb2-phy-r9a08g045
               - renesas,rzg2l-usb2-phy
     then:
       properties:
-- 
2.43.0


