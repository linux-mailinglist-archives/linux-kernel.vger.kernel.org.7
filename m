Return-Path: <linux-kernel+bounces-826465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C91B8E98C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 01:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37C747A7FC0
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 23:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DD225784A;
	Sun, 21 Sep 2025 23:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mnc5yK+0"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACAA19CC02
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 23:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758497752; cv=none; b=kv1kmdZwcq3gPrqjpXCRqYc65iOOg4wX346m49nWi5uKnEiKCLd+HBUJtpKVtWZu640IaZhfSBN+znlF80LsTAhuOJHoVXgjE0QDS8F4D3dViUNiLFV9PY9MFjDXTd5994up1VEWMOkCYEoHr8j4ViIuTw4Q8zpZBEeCYcOr17E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758497752; c=relaxed/simple;
	bh=j8OaHWrjT9UQ/r4y3qiFko5WnsxDSsFubeziXVztAQ8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GGgNAYSM55svFFyYoTlZp7jx9ntdUP9hF3uHSWP+mMh84uBoJbTS8+GWtwXUt17RXNv9B2lFYCERCYT9j7FoY1gB6k5W5d6ncKaS2GPkXh7LQv/HBi7UsySnv3/2DPKz4njyCWf9yL3NX59ny9ST7LC+xIKjQIHTRFMDfEhqjTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mnc5yK+0; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b7a967a990so44159021cf.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 16:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758497749; x=1759102549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CZN69W5Mtb3V8lrpdaa/KxTeb9Pg1cBMFpA8nrb6jkM=;
        b=mnc5yK+0gWFe91+iYESAU20VR9K3dZCICbpqj/M2qzdVQmGNygLvghBBkL2bFI3wau
         vPLuv+03davdm16HbIvjQJc/RjU5th6iwZRYaxt2A3BxswsfwnzGO7FIlCnhGPyuA4bG
         JjQKB/69CWUMv24RIkqBMrbg1gxwahB4Mx9a/AMJ1GKC5lgGQm4SCqEo9PZTjDmAu3Zo
         oGNwYeduxUunKAgaOqqiO7aFvVSLuHZLEM5nRomPjOy//UYgQwkv+HuJrk9wawL7KM95
         /R2TKxvCJ/M5zmgfOFGrvEqc+aYBbEOQPWUmIQWMbkk9oTMUmnr7VpItAxHDwUwKtlzD
         oftQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758497749; x=1759102549;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CZN69W5Mtb3V8lrpdaa/KxTeb9Pg1cBMFpA8nrb6jkM=;
        b=xB3TmkzymPXXRvn3PpHjdAhOyCY6fb2fSrrnejChG/vhUsbMMeN2bRtcKTdeLuggf0
         NvACP/UlR2495kypDxto5zYHgutwrWdgeoulIE1MhY3V75/QvRfO3XcxkVGDyPiReCDN
         tcLFwogeNrAE58LwUzyQrWb+Xkb00K+DIizMIeCeLBV9h970RlpgyXBMZ02fh2yPGslC
         IYqYZDgHjbwSTwHWpMgbUbpFnAYQw8od5Ku/qW6fy1OGcuPAFl1BoU/KezXOTU/EPnqJ
         ZC0XL4ycdd+VP+pL+QBDWHRb7ntB19lOKVx/1kyi0CwOon8PyNByU8VwGpCQNfKlqKn9
         zMFw==
X-Forwarded-Encrypted: i=1; AJvYcCX6Ybu+0LzNNfhm3Ka62n+gCP8bIWSpj6ju0zyQp96Ls5gYnsVu3ojDMmFebRsKPYNjlAojlY7w77U4AEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtSy5++4ymOJEengtgGPkkY8UR9jHy1VUvRaLj68oHD4vK2A+0
	1982qPHaI5At+gN1cuOGlT7vGi/5X+coU1JDVEI3CnHgbDmKGCeWz9dv
X-Gm-Gg: ASbGncss5xQLIkb5B0iYoA3fzL8VdfbzqQg53BCul9KB2+Xzc3sorN1c6M7Zo8YWgU8
	FPdXzU99L6cuWSQz9z/5HUFo9lX7DB2sIHmgnJHUig1xF1hbZkJYdTCQskBtly+cxG9l6O3N4SK
	T8J1QiG5IH0Lz1E/sxHgKnR5cVyKKPKN1BMawpN4MLd8PRLqt5KWgJFV6Dy8QHs66TGdd6i9+Il
	4SxPTbhOZBr4MatHQB8ScotIrpD5mAjmzPENEvrbT49/JWmZfEZjTRz8nG/aeSbROzXkOxWeEbp
	imRXvz1h5uQqQhRrD6dgbpBiEkDz1UZby74IthTTogY8/W160cOfqUB0T1+N1D3H8iIQmQ8rvJP
	z4uwLy69GuxDnmgAJLFvjclUSp/O8+hDtWdar4UDl
X-Google-Smtp-Source: AGHT+IEuX/rG6D8K1mfoAz2r7noBHe6o05XMZUMyqXmXpDmWRhPab5YZzhU8CSDkzsIHOEEXRhXr9A==
X-Received: by 2002:a05:622a:1103:b0:4b7:929a:2e49 with SMTP id d75a77b69052e-4c06e3fa3f6mr142548381cf.21.1758497748814;
        Sun, 21 Sep 2025 16:35:48 -0700 (PDT)
Received: from rogerio-laptop.home ([184.148.194.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-83631a8095esm725949085a.49.2025.09.21.16.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 16:35:48 -0700 (PDT)
From: Rogerio Pimentel <rpimentel.silva@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de
Cc: xiaofeng.wei@nxp.com,
	kernel@pengutronix.de,
	festevam@gmail.com,
	alexander.stein@ew.tq-group.com,
	dario.binacchi@amarulasolutions.com,
	marex@denx.de,
	Markus.Niebel@tq-group.com,
	y.moog@phytec.de,
	joao.goncalves@toradex.com,
	frieder.schrempf@kontron.de,
	josua@solid-run.com,
	francesco.dolcini@toradex.com,
	primoz.fiser@norik.com,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rogerio Pimentel <rpimentel.silva@gmail.com>
Subject: [PATCH v2 1/2] dt-bindings: arm: fsl: Add i.MX8MP FRDM board
Date: Sun, 21 Sep 2025 19:35:33 -0400
Message-Id: <20250921233534.838680-1-rpimentel.silva@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device tree compatible string for the i.MX8MP FRDM board.

Signed-off-by: Rogerio Pimentel <rpimentel.silva@gmail.com>
---

No changes in v2

 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 00cdf490b062..8bddf1f8a78d 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1099,6 +1099,7 @@ properties:
               - emcraft,imx8mp-navqp      # i.MX8MP Emcraft Systems NavQ+ Kit
               - fsl,imx8mp-evk            # i.MX8MP EVK Board
               - fsl,imx8mp-evk-revb4      # i.MX8MP EVK Rev B4 Board
+              - fsl,imx8mp-frdm           # i.MX8MP Freedom Board
               - gateworks,imx8mp-gw71xx-2x # i.MX8MP Gateworks Board
               - gateworks,imx8mp-gw72xx-2x # i.MX8MP Gateworks Board
               - gateworks,imx8mp-gw73xx-2x # i.MX8MP Gateworks Board
-- 
2.25.1


