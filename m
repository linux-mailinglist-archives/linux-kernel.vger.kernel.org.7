Return-Path: <linux-kernel+bounces-849076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25918BCF27E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 10:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D389E3E1876
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 08:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C67E23ABAF;
	Sat, 11 Oct 2025 08:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qo0dZ229"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07F323AE9A
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 08:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760172244; cv=none; b=S1ojN+NPjWpJta+2TEbP+oqr1K70fVGDU+a72lIDxBsFZxYrfv7L7tyWROHH6gHlQ/RGBQCEM1eUQGYLVlZQox6q2eY8locn4meed7qJwunYT57gA26o3E+i9VX6Ebbo6RizPvO+8RYwgxWM2UfzweIuz5tY4DYZbPiBEahqaqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760172244; c=relaxed/simple;
	bh=WupZjDzp+mYLUnPliPNHAA8llyM+D76W7Nv/oh/99/Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TCMKsvEAx1H9BMpj65P7bW7qmP0EQOCmM05QKsJPxVdqvFbIDQuUyN7jGy1Za5BB8joHNCG35XBLzGNjOeezeTxRiArkJRtIPsMk59dgr5GFzZWhiPq0hC9gg8j65MyfPbpEhHZidGDcN6KCagiMBclFIxm/mgwRC+5d6+2ShBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qo0dZ229; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3304dd2f119so2252639a91.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 01:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760172239; x=1760777039; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H8kUPDmdGFI5dlB1Y4l1vU9fWBs35HJfqSRekTM7U1A=;
        b=Qo0dZ229E/eq+7ywW972jK8byHgbfnOq29CXOGodzABs/1NVKhK4dXPtiQK11s19sL
         4IACOZVSTxNPiB/J9mxmOigspTOefa5f8F3gMng/IonoqBqmWyBDGdwba7vkKZh8EIRx
         rQZvKbaGCn96JhEU980upuVi2Ug/wbkQSCC7qBMB7qBbVrEfUm7Rlbbiq0mKwSE6GsVh
         Fm5PKJ8zKcICV/IyVtGchCloSyVaBdwq7bMstu1YTq7EA+UoBUbYJz328d+kPMb9OW+m
         tfLbaTCFZBIV2qRlXDx5jg2nRJPfTSm+NLKM3n5UmG3HYeWz0sjSRVdv3HiLW73sP+cG
         V4AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760172239; x=1760777039;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H8kUPDmdGFI5dlB1Y4l1vU9fWBs35HJfqSRekTM7U1A=;
        b=UiDPisQMZk9+MRVZnHtDxCG8phSqIzDCrbU0QrdfwPOSkZoGCccBqBfTPWiCb3nWE+
         cL7KdK3BVuHYUfKjGeL6aSH5983X4/1aYqQgq6CzuZhbNaBN4NS6fAl2WBU/i/tkGFEK
         fZDYUt9y0YdcDaHntG1NWdgCE3Gnr7qZDUfomLhnxHfVusoUHLJfJarcvaDfF+rzCZhH
         9ZnCokSeVL8EyRthlA+Dub10mbKX27PJa9VypcLBYlmjcE+3EJH5TLitdAWOseyd1xj4
         G/x8ye5aCqkqE3lIrGIChdIk0xWetx9P3vc5cKtQfEnv2b2044zpSr0XM+JqaQ+Gs3IF
         RuxA==
X-Forwarded-Encrypted: i=1; AJvYcCVMF3iPMAhHBamTK4U6JQpXOqKXQyrLRbPvLUu27+hk8Y/g/ufftoTvEAkn+HThrWUfSco8Ik0wqEJumfk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0G9FGSiVIR4IAJ47JgHk6kSNDbRHQ2OD0072LjhdPdwxP7MAa
	KKC1wBlRmjnnqsytMzgPg/8Id6vBJjQme3dxvIn5tXSXPhVRe92qdCRGUTur4A==
X-Gm-Gg: ASbGnctAJOkXBZ6CGOcG6BvfxLhlDjq6oo4ReyAJ55DwB7LwbVpoV9mtc0/v5nKp1rL
	xGuZuyrn0ciUORRRf702A8Jaa4sn39j3oSpWXqQE0BLWtoLhnCY0IIRJNSMXIAdIpsGWbH9Kbfl
	MQyQGslgEFVZebBKa1OwBe5IYFV+H4fReaUSFigQHu4j2zhj9fhkXkSizHviiMMYVPshcDg+M5w
	Z+Xms5zbuBlEPBh92MVGXKBgPB3FTf4iJ0FsZZ5wpwvxg1QsiKjULRT2NFf0VYfI1RKjHh9GrDR
	Gl3u+e+c+E6ECkocsDuUjZ0ykviSwklxXYkPotYnOaNCB4WGXJlrUwynqC2hk3usEOhQyy1xrZJ
	8J0I+Rc8lPMVNc/klkznRQx98d+lPgBc52NyiMK1D7P9zsbvBQ+PXgb3Fj/qwoiG+tRUecShlBd
	6rsmA=
X-Google-Smtp-Source: AGHT+IEEOTuflRqQKofgn/Jm+9c1ebGng0TIvOwkuJKhNdEWd6yjANpMqEqY0yHrWn9gQeTyxzynFg==
X-Received: by 2002:a17:90b:1a87:b0:339:f09b:d36f with SMTP id 98e67ed59e1d1-33b513a1e0fmr19026440a91.28.1760172238813;
        Sat, 11 Oct 2025 01:43:58 -0700 (PDT)
Received: from Black-Pearl.localdomain ([157.50.164.155])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7992d09659esm5401090b3a.45.2025.10.11.01.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Oct 2025 01:43:58 -0700 (PDT)
From: Charan Pedumuru <charan.pedumuru@gmail.com>
Date: Sat, 11 Oct 2025 08:40:23 +0000
Subject: [PATCH v3 1/2] arm: dts: ti: omap: am335x-pepper: Fix vmmc-supply
 property typo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251011-ti-sdhci-omap-v3-1-9487ef2de559@gmail.com>
References: <20251011-ti-sdhci-omap-v3-0-9487ef2de559@gmail.com>
In-Reply-To: <20251011-ti-sdhci-omap-v3-0-9487ef2de559@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Barker <paul.barker@sancloud.com>, 
 Marc Murphy <marc.murphy@sancloud.com>, Tony Lindgren <tony@atomide.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, 
 Charan Pedumuru <charan.pedumuru@gmail.com>
X-Mailer: b4 0.14.2

Rectify a typo for the property "vmmc-supply" to resolve the errors
detected by dtb_check.

Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
---
 arch/arm/boot/dts/ti/omap/am335x-pepper.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ti/omap/am335x-pepper.dts b/arch/arm/boot/dts/ti/omap/am335x-pepper.dts
index e7d561a527fdd9eeb15237ddee4c8db1dfd48edd..10d54e0ad15a7ff9770ad02c224b4b47aa5040de 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-pepper.dts
+++ b/arch/arm/boot/dts/ti/omap/am335x-pepper.dts
@@ -347,7 +347,7 @@ &mmc3 {
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&wireless_pins>;
-	vmmmc-supply = <&v3v3c_reg>;
+	vmmc-supply = <&v3v3c_reg>;
 	bus-width = <4>;
 	non-removable;
 	dmas = <&edma_xbar 12 0 1

-- 
2.51.0


