Return-Path: <linux-kernel+bounces-836253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 311A6BA91C2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 13:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BFC73BBA9B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDAB3054FC;
	Mon, 29 Sep 2025 11:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IS7fUf7Y"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE24305073
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 11:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759146572; cv=none; b=Lm0oZYSrO3Qha2tOVInO47TKAKLx6+tM/VjHBFJiKHgbP7y477MbiWD9HPPPjKCW6rQanOMaJoT4m/A7kQJMMSCA/wCi04zldFDDhZRkVovfl/WscbStJFQFPx+FcQ8rdtI6PIInG/k8Q1hpHaxQn8Q8CCzJWAlOuu+CTx1d1yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759146572; c=relaxed/simple;
	bh=aZdTsMD9fgmVcy1PAS22fMuqSv0ykQeoRdnEip9V1nc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QCGl5czM6rJSFHwJBj9fowq8LdQ0OHal1QaBTRpf6zWRXGmN9S1TSOLKUqzaRHYrmxdb8XIWiCE9dkPNQgvYL93L1P5HUC05QgejGPW27mIGYKHtnr57ddQsxpA36wEbJjeOj5LRRVhuYOPTv34hoPaGn5r6WrD9/hrl8N21swI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IS7fUf7Y; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-46e37d6c21eso29901105e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 04:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759146569; x=1759751369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0mIMwirLGWfi6Q5dJnPwjrLRkS6cp6VZXhnc2huda+M=;
        b=IS7fUf7Y8AGuLsc9ycTAdf04Ov29bBf3aBLYx96o59VOzBW6bd+csHnACC1gpT5/ln
         cI/Ohh8FO2lQ6CW1js6/fJZbHaQHBqMm4wGA3RG6XUqI6nzYHl1zX5N6eYzerr6pjrg4
         xXZ+f7t+DN5wQvjIyopLu8SkyHhHBPidHR8cQkPqKBICXyqUlku/9AFPh0UfGCIU3bkR
         yv93seR3A1sHE/UmSsFA3XbUxqugdu7MOvUMDel7qonm6xmluQxFo6r+jOHw1j7yzF5e
         ly1/ixsqxS45aPKIESJ5d+ZWpyg1ANTPorogtBXmkVbfntNiPXmKlijJIMkxkFTMOC+v
         30wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759146569; x=1759751369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0mIMwirLGWfi6Q5dJnPwjrLRkS6cp6VZXhnc2huda+M=;
        b=VPm3x+yFLa6IT/bITSFL1/wdmmlNvE2ddoxemwj7G/oovseGoo/IuxGJWbpp/GgVC8
         6rp3Tjinwa/q5ZEAc2WOynB52XR/OUh2uQA91GzrXpXUgTF1zY471OTj5mgJ/Rm97A4m
         aYV7qTXGpI2u+jqlVHrp4X0ppfeiKx8gilkmehF7xfglC1+aENU5wQZHXiVd0H5DxhnP
         xFOpWT8hbwqwkZN/s6gMXanfdniJazIUygL6aT6lT3AJLWh+6YDtrvkIbghjmoSTC/Co
         BoWNnbKKuYuiCqGyaSK2gvn9tdkZPlIUJ0n/mF1zekXwGItriRhpI78wRO71bpCTuULL
         rGxg==
X-Forwarded-Encrypted: i=1; AJvYcCVeFtuOICnldstaPpdWThDdBhMFQBHVbfhsHA27C5e+pKIHnEu9DKuGDroqIs+9He6CcMSW8FLlBZatEqI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+tcQXllfLZ6iMQLwYiZW7sTXmUSzc8qNC1tbsc7KeVMRgm/3b
	665pmK+BXeQXAuTwgVGyd7LqEK7cM9X549BRiO9oGMb9/RWH8OrQOgm9
X-Gm-Gg: ASbGncvd4/bKSiAio0VBiROMzqU89uiwpTyvUMAdY5MyXiCdg/aGEoKhxNbCQ596t22
	2o1hHwfvHz9ONcOgDzq/FgKt918TLlWccfzuubMRbndFxYR1QH2Rn4fVnu90P0naoxcyrSqZJho
	N/k9STU49/6S12v3TfYL7TkdaLwufFHg2cYEeca8vIjXn+rksVZJWooyQbtpuz+AzGMKDUoFJCP
	nHXgeMq5TNtB2ErCe9tdO54ZWo0LUzt/fflb6ISSLF9Iah4OgMZserREcMhX6NNUgvHs5I+C1Fp
	vyaSZVEUPUWdkicIJS2Zs/Gniclu54J1vQGlpst03t5HxPTG76KQYFXd0SN7cj2PmV2ES/BPHPc
	wY8zWGVnHrpwwjzFq4VWzG8uHalUh1KQKTcr7OqEu8UXuCLfLt7Cf+GP0FydjgP1VDC09YXzEDl
	pLdDbrxw==
X-Google-Smtp-Source: AGHT+IHHeeXxNQFuhvyiL0e2I2I/uphT8IlYRgLGojEB+ic7yYz9UM+mWAZxKobXSmkeRjFhavSFKQ==
X-Received: by 2002:a05:600c:19d0:b0:468:9e79:bee0 with SMTP id 5b1f17b1804b1-46e3292ea3emr151179445e9.0.1759146569045;
        Mon, 29 Sep 2025 04:49:29 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-46e56f77956sm10030835e9.20.2025.09.29.04.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 04:49:28 -0700 (PDT)
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
Subject: [PATCH v4 2/4] dt-bindings: watchdog: airoha: Add support for Airoha AN7583 SoC
Date: Mon, 29 Sep 2025 13:49:13 +0200
Message-ID: <20250929114917.5501-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250929114917.5501-1-ansuelsmth@gmail.com>
References: <20250929114917.5501-1-ansuelsmth@gmail.com>
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
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../devicetree/bindings/watchdog/airoha,en7581-wdt.yaml     | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/watchdog/airoha,en7581-wdt.yaml b/Documentation/devicetree/bindings/watchdog/airoha,en7581-wdt.yaml
index 6bbab3cb28e5..6259478bdae5 100644
--- a/Documentation/devicetree/bindings/watchdog/airoha,en7581-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/airoha,en7581-wdt.yaml
@@ -14,7 +14,11 @@ allOf:
 
 properties:
   compatible:
-    const: airoha,en7581-wdt
+    oneOf:
+      - items:
+          - const: airoha,an7583-wdt
+          - const: airoha,en7581-wdt
+      - const: airoha,en7581-wdt
 
   reg:
     maxItems: 1
-- 
2.51.0


