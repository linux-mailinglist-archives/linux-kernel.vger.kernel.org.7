Return-Path: <linux-kernel+bounces-832886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 524FABA0AA8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 18:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6B3C1C241D4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 16:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D7B30AACD;
	Thu, 25 Sep 2025 16:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2CgI8rh"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D121D307AEA
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 16:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758818452; cv=none; b=Mfcmr0jY26VkhABJgcCXPeJsqbsGj6JmSu+kr8iX8xROjhJZNHntcgyOVgL4mBP27eHZqNN58wr2XHYUEdOkbNA7k4ZDo1wLjjHVx11kUw3jBpkUTulL0RLR2fI9D5BwgqI3DrPHTi0CCXUnl0dKXXQNrw4rRmZLRh4w95s8VdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758818452; c=relaxed/simple;
	bh=5uSR4NDN/aBsd24THGZvPsdUrUX4xTeH0oi/5l1dY5Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r9cB6XJohh+EOz/TWNE9Y6HTcLpra+79MJDF9P1kHU81mo/glFRezLHK6MK5ME8C266/cGwhp4c+N7tBfROCxnlxJNB2mYKywwNrfy3QRHAvEEGTAHtkjykaxnq23twiO9UCUuiAGkt/DqBV87aLRnn+ceX+Lao/dA5q9DT5Jr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k2CgI8rh; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e2562e8cbso10430995e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758818449; x=1759423249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k4zaJq9JJc/9ryK6cY2Xn8ASZ9hmcyfG8y41VjWW8NY=;
        b=k2CgI8rhkCMTu/2Fr1Dh8tcv82JbH4ZgDFX1Q4Ee7Pg0oxEvu6D6wbQv37XQ3ypxsP
         jNaIGdXt0YKXBUA7cPguKcXb4J9AvGehE6wXA0YBZXs8sjDtyuEjrexGdjFWdLPGKkfq
         BSSOF6DgnNWnnaoN39p7WYPook+azDZVSNugF9/i/kV3FK8vNOSqA61xBbRaJ+qcfTyZ
         IyPEGsY732RpYBONwgC/e5LKZTcNrqzzpQriI7/T8go0IexjQe5/Le3J0neFnuhEm057
         HXZDb4Y+utK3U0kI6xVvYpv/lsR3/j8SV6X/424ae+jKQU48uL50UusYy0RI9WNUbSq2
         mKqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758818449; x=1759423249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k4zaJq9JJc/9ryK6cY2Xn8ASZ9hmcyfG8y41VjWW8NY=;
        b=Rm4LJi8b0YC9BA4ImHVWZ0BSinlIa5JHMX3A6aEqOGQ2xXaZy6rk/Gb2flq2FuUdd5
         ZVfGZlDnpuqFuB9xdz/Uww6Dn63Su5/wJ2OAHzX9k7uTC9g3wOXJZVkGYLeRuRY/mrBC
         S6KnyuAWQUgtjs5YPiOSzmyaCW1Kiey2KluDvplRgy3E31370iZdSIkrYUqI7a2lXQpp
         zOXVd7lsRY/m1bhba4YdyoQ3dud5BJTaZt+7MQzAAj7hlVTbZbw3EN9KFwZqHjNuxR2m
         5Rzm24HSUiHCDDAespgmO/YB06Y+3ot8dAvXOS3E5OavkwLcrwtBjMaEV4vywnymdR5M
         LBgg==
X-Forwarded-Encrypted: i=1; AJvYcCXBr3iel3rUzCkCV/BYcA9pXDakvrbUprG5msYb9FyQGvlH39yKxRqd0cxbb47I2Fm6T3Ussh3dGk/2aC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDPGnfs0rexZM0kqVw6Y2b1pW9LzQb+h86D8QurayknMRUieR/
	JfQHVf4MuNkpajhljT0iOGiTBPcqSlzn235uZHprXE1hNSPLpIziXAiB
X-Gm-Gg: ASbGncsaT0JWnZw18vbybAm4Wulaen//KX8mrq3ylPVpG/Yfql1EgM5Ay16BG6TaLVa
	C1Yl97JmO133tCaH8J6or/pgUgljetvpjFGPeopMudL9B85SWrDIkDDBUSIYcx0jwo/mR5faLVv
	Kz70iay6ApSuC14d/n+xWJFijS5+G4oL6o9/cl0g0z0FW+gOV1t7n4h6iigSRsOlNCKhfalVCwI
	ftZel8b/9kcgF+hB/m0yaUYHsDQNhdkQixMgu7C1yeI9/dteDTgN+3JqgXo8PT3t6fJi2MFBdbA
	UI2PmTto2Xm/syVUSNs0hFrjhrX3P8vAMT3Kh02MBtEEf6ZyvQTDsdNG9PnHjUOPm9KBEUZbMRx
	U1f3ET18/sOmvvjxWdieHhu8xbsXSUJVc/4UiZBrdrx7/fX4gyy/o8HlwksMra4z/WtBLOhA=
X-Google-Smtp-Source: AGHT+IETYpPO9LAGX7zUAqFXRCr1IR36jr+nRkmsy96nynVShQ03CfruIEzXhdMASLXdFRjMR/RaLw==
X-Received: by 2002:a5d:5f52:0:b0:3cd:7200:e025 with SMTP id ffacd0b85a97d-40e429c98f2mr4337564f8f.5.1758818448972;
        Thu, 25 Sep 2025 09:40:48 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-40fc6921f4esm3591904f8f.44.2025.09.25.09.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 09:40:48 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Felix Fietkau <nbd@nbd.name>,
	John Crispin <john@phrozen.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v3 1/4] dt-bindings: crypto: Add support for Airoha AN7583 SoC
Date: Thu, 25 Sep 2025 18:40:34 +0200
Message-ID: <20250925164038.13987-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250925164038.13987-1-ansuelsmth@gmail.com>
References: <20250925164038.13987-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add compatible for Airoha AN7583 SoC. The implementation is exactly the
same of Airoha EN7581 hence we add the compatible in addition to EN7581
ones.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../bindings/crypto/inside-secure,safexcel-eip93.yaml         | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/crypto/inside-secure,safexcel-eip93.yaml b/Documentation/devicetree/bindings/crypto/inside-secure,safexcel-eip93.yaml
index 997bf9717f9e..2269d78a4a80 100644
--- a/Documentation/devicetree/bindings/crypto/inside-secure,safexcel-eip93.yaml
+++ b/Documentation/devicetree/bindings/crypto/inside-secure,safexcel-eip93.yaml
@@ -30,6 +30,10 @@ description: |
 properties:
   compatible:
     oneOf:
+      - items:
+          - const: airoha,an7583-eip93
+          - const: airoha,en7581-eip93
+          - const: inside-secure,safexcel-eip93ies
       - items:
           - const: airoha,en7581-eip93
           - const: inside-secure,safexcel-eip93ies
-- 
2.51.0


