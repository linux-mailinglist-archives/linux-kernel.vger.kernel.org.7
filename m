Return-Path: <linux-kernel+bounces-777046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63704B2D46F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 09:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34F1F1C23958
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 07:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4D42D3759;
	Wed, 20 Aug 2025 07:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XMZCfzHN"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAEF2D29D0
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 07:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755673377; cv=none; b=oIiIGYRPdyfImbxwB2zVfqAHiJai9SfZWtxU8DbZq5D6HKdJb5LI6Y5FmoaEem2moyl2Edwsl8KWDuFDVxmyaXtltrP85fuu1xSKv4RkVpOr16+LYvgwum5fE6/DmA5DaIW1lxZunGHfR5a0Dw7mQz80Vv6RQ8VYLJcBacezTmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755673377; c=relaxed/simple;
	bh=AkV3VRQfJAkPuyGMV3zApyjndBmAsTYMa/X+l+hz0eY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aQZgoaadv4xdR8sfczmFGW1KuwB6T4XRlP/FNrVCmgITWjnR7TDPrrhpOiHoIYlyjuhuWnKbWemM1+Rtx1jgSmFe/iBBwj5pWNDwVP3lPkfoSql6BfKKxz5+0HI2xwQoDvqo0XNrpex0cjeaGh5ewJf8QXLQlam0pbqxTgQkIME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XMZCfzHN; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-afdf393978eso1854666b.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 00:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755673375; x=1756278175; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JYDyb1l+byMOiaJzKn+UnmmghGQhvpVn03tecEee7KM=;
        b=XMZCfzHNskL/FbJUIb4n1JeVmbNorbHHxgb6PEFDRs+qrsS2gOijhEBJjfKbw3cirV
         m9Ez5N0NbiVrjWEYNK7bS5W+9E4TwSH55zQaPpPLMQ8S3gREswQ9ViXV8i+HoIGwfX/F
         IFbbxECUj83P1IGUEZkR0C7iLzHzo1DFc75HK/XCYUOYGS81FKayUDVwimWdT7Eylmbe
         fumUApbwBW7Fs7nEZHX5kPe0Z5AsEm2Fk6bitPU5pdO3te0CeLCuMRwd3mu7h2wyxE0q
         KnRo+uyI+gZQP3cHUBXrp9ZSg3xYraWqTaw9HQhRyPbcwJJPsEjjBs+FiPDhwVUYLgip
         kXbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755673375; x=1756278175;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JYDyb1l+byMOiaJzKn+UnmmghGQhvpVn03tecEee7KM=;
        b=ratySAzpRWlZQ/EZGvZxH7R11UqwDTvqMMN0jf0pbbjBwMqTUmPwXaaWaC9X1mXPEu
         OxLl5kfQNwnMs8Q75fIfM4Pj9tUPECS8oDRZ9saV/NKt/aA0MGdQUYM+/t4r4NQqNsDl
         UO+mGgm4jjG/5UjC5y2ZfPTCn6f4J21BCRxDey+Hrq/bv9o/uYThdk21Qok2P4bElsyj
         7EIaNuVtrbk/M41ps0JJdCti6lGq7J5FcLrTAM6yCS4OlL+3a8/LVxLNX6fZBdeMA++S
         RYg8aoxsfqU0N9rDWtnoY8xOYiPYqLpJzRg+aYvTOY/epyPzWtTumZXiL3fV//3ekZyG
         n2GQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQCfZZZbN1HHIdPcg6VAntv1aUc+VW3seH9xi7CnkQ76kSem/pFIFnPkMJqitcbVJ5mg8EnZz/QfZuQIw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8cE6fa3BgMbP0Po1VNv5/BpCXjmB+uRYT4hCsasEtjzt/0EKd
	QWIpwsUSdRQxV42KyMQf+mExYgZ34onLN9bqSSUt1JtdMpWma7Wp6tMv2D1WyUFTzNM=
X-Gm-Gg: ASbGncvi3k+hpXfV57SD302i2hndZ3x5HlW5vBNCa91vjt7vqAZuG8HMpsCUQL4QeP6
	IWmiO/FXEgRzwAzCtffOEWVUt6EDENDqx/jriR0lig5jdgTBfvlLaaBb2qooBAsAHclGR/uZdgQ
	1VUmUk9P4RgKDzOKjNNENwQvpwldPAL5BGVa6iyXKmOW/upC2ViGa+ZBf71Z7PVPaL7Vf917b7W
	3oG5f01o1K8fKocSmMGm/suXu9wC8o50udOZFcwjqiD12YhGMjiLZweuuZ0LhDeYMs1KCxaU8PA
	bSsmX2VkqC7VSyVfdkcnkP2IhsR9X6ES3ffkCojpV3S9EPosLhRs2lny9di3atyXBXzmDxeHc53
	aYAxWDhFQiL13lW6Kw0pmSdVNGWX2/0gFvCTmZjM=
X-Google-Smtp-Source: AGHT+IHJRyotiUitRQlmcmuPpwvWkmkIG5BFx79tKET0/ZCpVsB1kmI1FDM/O1dsctY74CZHdQJyWg==
X-Received: by 2002:a17:907:869e:b0:af9:8a71:e090 with SMTP id a640c23a62f3a-afdf0280436mr79978266b.9.1755673374003;
        Wed, 20 Aug 2025 00:02:54 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afdf6ff14f8sm37756466b.67.2025.08.20.00.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 00:02:53 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 20 Aug 2025 09:02:41 +0200
Subject: [PATCH 2/3] dt-bindings: display: ti,tdp158: Add missing reg
 constraint
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-dt-bindings-display-v1-2-d5b2555df51f@linaro.org>
References: <20250820-dt-bindings-display-v1-0-d5b2555df51f@linaro.org>
In-Reply-To: <20250820-dt-bindings-display-v1-0-d5b2555df51f@linaro.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 "H. Nikolaus Schaller" <hns@goldelico.com>, Arnaud Vrac <avrac@freebox.fr>, 
 Pierre-Hugues Husson <phhusson@freebox.fr>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=990;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=AkV3VRQfJAkPuyGMV3zApyjndBmAsTYMa/X+l+hz0eY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBopXMW9wkV4htcYjEWNJWdk1zKtmlcN5CE41MJX
 1lvlVHNyB2JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaKVzFgAKCRDBN2bmhouD
 10A2D/9nQCtB+BeS3a1GcRicjBMuO4BkqDJ5fzrjdybep856QeJGH+n5b1OlnWduayCgJ6pf6Dl
 LypCyElXEf/lACJADLNxNjsYmPhmf1xM6Pcn8rUiaRjTWzL5kuaKrt8ebYHsWZLGMPLPjWAInos
 ehCcXGVg0K+9/wGg+Ktof4C42Apwde031SvjTDqRFovXzfZiMksOvKip8EqCLBP0Q7I2ATk/HMo
 YNb5TZuVXvQei+SPOlGiDyjSE/lrv2u6zX/8Cgs4bgm8+lgw2vhnoLu6FCSssgBpspHM8XdK4mi
 7RVZ7+AejZe9/NrCUiby/iwRcz7r9GZBpbYj4AgyEMwchWysCpt/DeGaKJl8wFIUvCVHtQlInvQ
 u/+ww52Wz5tbPFYypkn8DeAl8xTQvvBB+tdGFPq6HedhtRQpF5e3TI/f19j7CO7XbFvdc7L+Ij2
 AaU9Z2GXgTdcvBI7CQn68hNqcoGYQm8dmxaObXAHIRncTbasCU41dBaRlDqGBxwIpW+8mzxHOZ+
 mxP5i8qdMzLlDOb3upooTdHnHYdpxv+4rHyKsOa0BR3VtvCISQUHiIlfo44ZFT5KnxqQrJQPqXY
 QmdKI43hwtGaOR0OnRZzVR/elstxfWt1N+1ovS6R0pbZnNLTFD73gtuL9gYcz84OOUd1K4qOkvk
 Uj/DMPJ6az2a7Nw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Device can be used over I2C bus, so it documents 'reg' property, however
it misses to constrain it to actual I2C address.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/display/bridge/ti,tdp158.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/ti,tdp158.yaml b/Documentation/devicetree/bindings/display/bridge/ti,tdp158.yaml
index 1c522f72c4bae3313930b5c76dd04dde1aef5151..721da44054e19ff04fe9d8c1dc31a9168e8f79f5 100644
--- a/Documentation/devicetree/bindings/display/bridge/ti,tdp158.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/ti,tdp158.yaml
@@ -17,6 +17,7 @@ properties:
 # The reg property is required if and only if the device is connected
 # to an I2C bus. In pin strap mode, reg must not be specified.
   reg:
+    maxItems: 1
     description: I2C address of the device
 
 # Pin 36 = Operation Enable / Reset Pin

-- 
2.48.1


