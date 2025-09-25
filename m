Return-Path: <linux-kernel+bounces-832887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5F2BA0AB4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 18:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB7557B054A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 16:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C45E30C342;
	Thu, 25 Sep 2025 16:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7a2QSA2"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC1630B50E
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 16:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758818455; cv=none; b=Y1cu1CUM/IJhtSJM0Zh9pNvcX5hBt4o/zna/1h0G+tN0cuxliNFaXJHlZH54vFp4/0PuXb/bL3eXfNUCBy5DxA+OVx/D2R23EQ0/syrZNUbL4checn+BOlLlPgMtBI0+BRNNj7zr/+AKhhWQ1blHKF3oERGbGkrgDUFSmTP0eD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758818455; c=relaxed/simple;
	bh=5bKaIyYtkl+MP8Bbq3igxb/jXbBeVFx0aqkgSriTev0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vev8Xc0DwlUSqpdDDpXxKGejber87ma5YEVWaHLjWX3EFDwd2+4sYXV9IDwCUbVf8aw/tqNEWquhZ50SUeHN72+sjPx8td2il2i1mzo6Yzl3wtZaJ+RIeMao9IdQIGWZz48dOKfMijTN0ALEN+/ZVHUWy0biSTQVTmvY8HQlUxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e7a2QSA2; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3f2ae6fadb4so1230243f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758818452; x=1759423252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2eyp9Gi1dreOzDe7chY8j7wPpNbM6pbeZ96TyLDdfpM=;
        b=e7a2QSA2TOGxL50CH7x8FYWAIaHtCmjWVXSJlEEaHykFssFgAUUaSzl9CA0iI3OQd+
         S2PxDRp0mhh53lnxRnsuXgT7N/YMqMtrdP0E4ZgdYfeTDMa75XQrt4mnTfihLKNLyTr5
         M7rgK6KPpL6A5Uq0t+Bo+53aXuuABxmePeJkVPtzFGf4/JG1GV7IwoG79CG/3cibaJNM
         dSHtqTzgl7frw4fRw5y7jb63Qc5gk11Cz+PPnBpQjYCiPuH6HrL9UxCK2GYWIygZCn5K
         lNBDOjU0uShScE4bwA2qLeJcG3N1lmbhhxbYjxuBOIJuICNU42pi93ajw0R7KE9jNBaY
         Zb/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758818452; x=1759423252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2eyp9Gi1dreOzDe7chY8j7wPpNbM6pbeZ96TyLDdfpM=;
        b=YNgKVd35tRs73m2QYdHqVt4HlwqVyU29TRf/6M0IJPbn6TPSlrJFE4hoNLv5cKNUoz
         c5osoNpNyulnUqI1PSXRYTpw0MKt7Kzs/pBFS/AgYbPloKGtwYqPNwM0mv86o8W1adwP
         VjK/XaYLK4/muSAutd4bVZDn9r/fUDbwkxiVz3jo+OK02qIpKHIkIhpSdu9jQzgDV9DW
         GE7fSmKdXRWEF4xpg4Zaw517tNWClE8tG1NhyhWLu5pFBOVu+dxBn6MQqQDpPaeVXGJh
         UmEB/Fmnf0cBjC+WfwBwdvsaujX/6yqHu10bwZ0X++LVRlI/85c9COX3FeFyaCvMyi7L
         g8+g==
X-Forwarded-Encrypted: i=1; AJvYcCXRAyakuthh4Xo9XaYyXcEYxm8nXWnx/qxuYFeLFBhT2vxFv8tK9HA0zh7aTPR5T8uGFLabXD9cc37JCtM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHz9ZivOlBnnUbBD+rn2uOeVPDb5Kj5d2EE0nEGfGkh9WFdQwT
	uUw43SFUoYrRzKZRCJkQeoeEtBy57L4v0faNqsGUDsFUpEFaSBj3+tpO
X-Gm-Gg: ASbGncvWhXRlCSvDP2CUgK2kA95a+6glCe2qOBXwGPTEzYxK12XkmXRVgp39rpLfJL9
	61mwDpW90CnYPMWzwpB3L/enZnTiDfMvuRhoS986HdEpkolq8kI743DI83SaJEtrGTez1pCISyr
	LNHRqNzZil5YXajFWsm7D0MexKBkI+j9+SIMbcImximnh6Y8i4dHHRWPaC/3LqPgFZWOUreyfWc
	gGQ1BIInIggkydxR2jNGt8ba0Dv/Oxm8VOykcVb6oqHkr2k3GXjZTYOHTiNRsh7A2x+jF71OATd
	Mp9QCIXHkEKu/X4BunLxO6C25hdG4ZCfCnM02+ym1g7whFVC6lAixqmq0aBVHimLIQLvDFc6s/3
	UPSYmHY/6yFexwxdpFaV5qcjr3IDnTdrUQtzUotvbjJ7rzXfgPsXYlTVOFLHKY5uYuG0QV0Oqtw
	nhdrGQkg==
X-Google-Smtp-Source: AGHT+IFuboP96UTpd7Lrf1lzxKViS1D5GdrbEgDmgGvbVgns+3irooGx/K0KSA4xhs66h89FOOvM5g==
X-Received: by 2002:a05:6000:3102:b0:405:3028:1bce with SMTP id ffacd0b85a97d-40e4886dea7mr4262966f8f.32.1758818452397;
        Thu, 25 Sep 2025 09:40:52 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-40fc6921f4esm3591904f8f.44.2025.09.25.09.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 09:40:52 -0700 (PDT)
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
Subject: [PATCH v3 2/4] dt-bindings: watchdog: airoha: Add support for Airoha AN7583 SoC
Date: Thu, 25 Sep 2025 18:40:35 +0200
Message-ID: <20250925164038.13987-3-ansuelsmth@gmail.com>
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


