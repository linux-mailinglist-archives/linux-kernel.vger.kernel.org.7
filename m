Return-Path: <linux-kernel+bounces-726145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0EB6B008B9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 18:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5100117AE53
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 16:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4E22F2C79;
	Thu, 10 Jul 2025 16:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NB5Bg01K"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E6E271441;
	Thu, 10 Jul 2025 16:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752164894; cv=none; b=dx9XjFLAVEOh5zfkz7X9+WITWhR0pdQ3NWwJBdxxE6XG0eUiJMFh4aTTbaNOj9LUe8qLNuZXh4FB/cFuKgm3zjWB1HUW4JPvuSMkPz8OMlUr/fuVSm7YaazDThzHGRcNNGEdWpKiQzDi9DjDBftjW3Av9SskhjMOyNiBA+iIgoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752164894; c=relaxed/simple;
	bh=rCJ4UHBlQmfxDgbpJ2uhmTWmviQtY6ie5o73T+HrGmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JdNL7TrZbYAIWEGtekfPci+wybkV5LCpsA2/uV81gniERy9Rs9fUFVSIDSKOj5lXx8MKre5zU3hSbcjZYkaAOCkOaUQH83ylL1YyOiXX0AJOVJxLkWbiYGThOubHRy2+viHfqrGBbBo9MV014mbNNWMTf6gkBkhTO9WOe3t3CPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NB5Bg01K; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-454aaade1fbso12099255e9.3;
        Thu, 10 Jul 2025 09:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752164891; x=1752769691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SrX0jpsTLwGSB9oK+ETN0s3AYD2g6Vce7gGJ6DvgxDU=;
        b=NB5Bg01KWla7Rrv2q2U+/fcnj05zvuhLJq/iN3JcRqrnD9hUh1wfhjfrAbggcVEzxL
         Gh6gdAzqBeJKm+O5/y7TbiEXBlXSiKfvWTldVslUXu0nasXwp1+OkvmukHT1Mprk4GIq
         osFPyuiNp/9rSUZG4DaCmYYBY0fhT7TNk4gP7TSEqC/zQcYZQNc66OC0xrPeOxmmlyvi
         1p0XAMfuWm80p/lQiO9q9cDvUj95vSKyjnHRenpHodD6tE0+pOpUlC4b8QuxFkEbv6RT
         //0HlOTn+a9pubZSg5fKmdaE3kSo8uAapU0ocqKQ8tp5lhtUvJ+BrmVuTXyf3Ctoe8b/
         aWXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752164891; x=1752769691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SrX0jpsTLwGSB9oK+ETN0s3AYD2g6Vce7gGJ6DvgxDU=;
        b=SqDzk84NZ9udod8vwU265/NGpbxNVOD+XtllsQwZOhXyuaa9Nul/3e2lamIO6ytXTZ
         imxY9KAnccmxWwLfS2NPW3XnN7dVgGIzmMFSkb7qdGMtfxJxS4DZWHn1os9xMnTnhtdn
         MZ/7m/lQ3tvvkf4fGzIJjt7sdpB1W0ieRggrvydKbnPI9wFWZT86yBqyJ7nDE4mwMgxx
         /7yTeeiTQ4u+bd7iPxI9Ld55b1qDTowaCvDExmWucjKJAToS5iNUIPV8PrjHJRWJdgWw
         UNz4G7vMq5LcRk9Vu/ITJrBP6T3HQZB3d/2Dh44BS6OdHfm5QAGHrzn3hog/67yTXz4k
         yc1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXoog85a6i0y7Lc/AWYq/XpbQJwGzpVn0NxFESO8vkhZODxr2hv+Ciusy/nFuCs8mymU9X1pjA2RIz0cbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpyFuKmKYeXE8YSRKkHvxRyq6KdH/DjgP8zVyG7qqJiavFN+qn
	SJ2eNBKkReGgxaVd78dhMYcdA+byCjfoK++Q2/tGthnr3R2H2QueRAeqcAJ7bMnq
X-Gm-Gg: ASbGncszQxGool28aYaghQGP0m7/dVdY8ADhEvGQSFWEVZK8b0qO72ezpoj0ROuJo/w
	11XS7N+A81+5p3+ZMngImUqkj8oqz8CtvC7Zai5MYP673EM20XA42s5HTtut2xg4Ek/zs75yAx/
	frF8iZMHRoHajeQzdjEgX/aLpWtOrIzDiT9/dF4krzpgHSsMWhVXf60rPVAAaU9L/r7aDjD13/H
	/JlyM3OOrLBG3TviRpxCCVKZhXWPV2abvbCz9BsVBhzbyXz97STjIMdpnVhBBNVh7u6CKNakY6e
	1rtoXWUtuQfe5wFxuzduIxaJu6gcJkCQl/qVsnXt+pKQavE2XKy2QEUAILwQBwIKn0/OhhE3kBX
	AM/PpF9DaMxSyga0pitVIY1YNOrkkxdWe5GgpjaBPSzX+yQ==
X-Google-Smtp-Source: AGHT+IHfYUJWjLQik9Y+XlQa66TouPxnoB5rs7T/jhXvw5uiN8G0FF4CZRMj9bSEyBlCS/JHOIjkRg==
X-Received: by 2002:a05:600c:4683:b0:43c:ee3f:2c3 with SMTP id 5b1f17b1804b1-454dd1e7e72mr32290775e9.7.1752164890975;
        Thu, 10 Jul 2025 09:28:10 -0700 (PDT)
Received: from Lord-Beerus.station (net-93-70-53-177.cust.vodafonedsl.it. [93.70.53.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d50df125sm60871005e9.19.2025.07.10.09.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 09:28:10 -0700 (PDT)
From: Stefano Radaelli <stefano.radaelli21@gmail.com>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Stefano Radaelli <stefano.radaelli21@gmail.com>,
	Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 1/3] dt-bindings: arm: ti: Add bindings for Variscite VAR-SOM-AM62P
Date: Thu, 10 Jul 2025 18:27:26 +0200
Message-ID: <20250710162737.49679-2-stefano.radaelli21@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250710162737.49679-1-stefano.radaelli21@gmail.com>
References: <20250710162737.49679-1-stefano.radaelli21@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add devicetree bindings for Variscite VAR-SOM-AM62P System on Module
and its carrier boards.

Signed-off-by: Stefano Radaelli <stefano.radaelli21@gmail.com>
---
v3:
 - Change compatible string to match existing mainline format
v2:
 - Add symphony carrier board compatible

 Documentation/devicetree/bindings/arm/ti/k3.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
index bf6003d8fb76..d56046e439e9 100644
--- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
@@ -100,6 +100,12 @@ properties:
           - const: toradex,verdin-am62p          # Verdin AM62P Module
           - const: ti,am62p5
 
+      - description: K3 AM62P5 SoC Variscite SOM and Carrier Boards
+        items:
+          - const: variscite,var-som-am62p-symphony
+          - const: variscite,var-som-am62p
+          - const: ti,am62p5
+
       - description: K3 AM642 SoC
         items:
           - enum:
-- 
2.43.0


