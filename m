Return-Path: <linux-kernel+bounces-777045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE296B2D46D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 09:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C0362A2428
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 07:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BD42D29CF;
	Wed, 20 Aug 2025 07:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AdvSAJ68"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E062D23A5
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 07:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755673375; cv=none; b=bxlOiuEZu55nu0tpAViN/1qFndrdBtQVgigPgMtCco/orA2hyzpmy5v4LvCseWZieOXNkzCzMQMOqywwlf09sDCpssN/UoLAYMtBYyqDWDPKdwN9PrfY6XLggFqJK1Bimv3S1ivZHNG0yhwR65MHcD4AXyTkQNP2BUewZHcnSrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755673375; c=relaxed/simple;
	bh=Pxy1ceX/K708ATMRkgiCl/qGBMScopnigW8cLcERjdY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ubmEARf8QAp0lY4nPNSGtig2mMLtXd5Pq6pxSL6OFua25AXUMCPVbZMNCA4HyHhp/+ENTogx+oqCtwhGsa/vNYnDcyoShRdgFtgjLf0YnzgXRuxfEXucZbiTjxtL1Xqhmr7pt2MTLH146IdG4ZekgfTjcdx+uG1sufNX3qBcrLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AdvSAJ68; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-afdf5843940so1192666b.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 00:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755673372; x=1756278172; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DH177aI32fcw+0fi3Kr7cEylMFjtb1+kKdAUsXxCdWo=;
        b=AdvSAJ68XSZnVb7UaPm7wodp7sbHA7ey0737d5oKC++nhOluF3g0ugaz8/bc5DgOTA
         PjtGs1UgJMsNjxIDilzxQM9q/DkKL2hqhXkU0ri5pIIzeSxzg7bxOPYtN44jBYbrOh6G
         gJO+kUVusosyVAWIl3IKOj0o12Tz9gMUIZ2IePuOi+Bt53gcaE03cOPeJX6qaASLurxs
         EGsqtZp1az1xNVdN6ub/IwNmyBtx/vQ3YR4uLyVYkJfrohevgnfZUzjgmxkuqIMAGxoQ
         1CLGKgXS2PeSZjW2aazOR3VwHW+09dYZAkuJ/KtJIf5sBxiV0UZKI0dg+vTgM9LC8pL3
         MLJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755673372; x=1756278172;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DH177aI32fcw+0fi3Kr7cEylMFjtb1+kKdAUsXxCdWo=;
        b=vMmPYuv+D78z3WhOWBSp+aHCtI+jO20/LvJntVTHFB8i6XMWfqDeaoaXxCmpg4lQU+
         T7rt4pIvqocYsG7Uou3k+lunixQN5mPuKBqUKkDr5lJ2S5NpcgXFAlGSbLInhkWiw9it
         hb9KGk0zCJKE4sd6GF6+FNezT3lYc81QdC4YCqXlfD4OYC6lVJfyYlzNfi2hOGSWAFdm
         p5EpNzaK7LBOtRarCUZ7JU8wDF21N9sTclthO/mLA2qlyORFsDTAmhDxGuoZi6j8SvF5
         SlGC9wqaTNwdCNdo1MQH9CgBETMqke/VEIOA2wTlUHLs7QYGNkH/R0P8Inkm/JijJTwo
         6P4g==
X-Forwarded-Encrypted: i=1; AJvYcCXO02TFAMFkKmXPvd2mAXOX69JEnAeKVdqNttpvsOIadNa7D7oSBisK2PgLMM1IGmPcx16czc8766sO0Dc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHgvuyIFXLzVnOWGW6WDIeUCCwRYXRRIkPEgH7Kyym4S3E/tgq
	CyrY+c7Fl86q/CTVh1xmbjfgaQJ+72GYOAkJeyzS5vTqi18lu20RpfIJHObVvBT1LGs=
X-Gm-Gg: ASbGncv1DIiCAg++W5cD7zklMhyFTaVTMXAH025Ky/bHf2+zH5fiv8IBiAg8Z7kITMP
	E34oM9iXH3PvArVXMfDmVLML+dPRfZx06rW1g2tm9+r+R62SxXISAG2qFWEV5zHiqZV5emYhT6G
	PxCFtyctc6MSedDoEPZ5nsN9V3l5rC1smABCVA/O6ItedP+qGAh45PK3Y8otb0NJh4V1BeVIRS/
	ET9movNSv19oW/gLC2UEEOagCNN+38b/9xOH+4iGIAcSZcR4V/qL8ha5ihbaMZRMLQmebpUDPEV
	0zQIAtjFfrgbQe2N3LICloeaxqOtKhdA8iIDqqpq0fcdyr4eBaVVDONEvAS/VixLTFqMxesRi9z
	5BFM9nFc+lfnb8NmdRbzE0UVNzHhZz9MbQvZcF8M=
X-Google-Smtp-Source: AGHT+IF9FNxgrgCt2MNISlOazft7efckRUUOCCyDUI6tMZE11GXZO0az7ewPiYnvvCxno2JpihA7NQ==
X-Received: by 2002:a17:906:7316:b0:aec:4f0a:f9ac with SMTP id a640c23a62f3a-afdf02106f1mr69015866b.6.1755673372063;
        Wed, 20 Aug 2025 00:02:52 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afdf6ff14f8sm37756466b.67.2025.08.20.00.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 00:02:51 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 20 Aug 2025 09:02:40 +0200
Subject: [PATCH 1/3] dt-bindings: display: ingenic,jz4780-hdmi: Add missing
 clock-names
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-dt-bindings-display-v1-1-d5b2555df51f@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=999;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=Pxy1ceX/K708ATMRkgiCl/qGBMScopnigW8cLcERjdY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBopXMVT/M8Kz0Rj97OPMv9sVNcaz0uJrb0hpTH8
 kC19UClVTGJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaKVzFQAKCRDBN2bmhouD
 18JrD/0Q2MVyZwW9e4PQUvRkQCrJj1FZOoyd6meUdkZZCtOx5WXnCz6j7oqqPHzA84QftUJIEsb
 J4c4cgQf6k6PZn+zX7ck4MK2YbM5Z/ptaV6cyi5Q3nB+sNqkWxX2ZTEt2GFPbSjFVhmYB9G28K4
 Ov8uyjdeLuFnCQxWj9RtBVw0joZGfx5pEs5xI9dHfCJbMd95Qou4cqJtAbFwUnE8dLMROGaJyp0
 sxJYXnKH91zEJl+MxF5orITmFGsZsdBUfeBrzOlkJHZWSEDQHaJ5u8e6qzq6z3tVXu8wUWdL5kw
 PaiwcT8AQrcAndkVNiUDkjMc14HH383AyaT0//MGYrdZPxZmd03GC8hGGBAf/duk2GfNHN7ZifZ
 dGPbiOqW6FdyG5Hztz3myV2M9Tozh5G0/H5NHGpehXf3dgFqQTgWKp9xBiGUcsuPBLrJft2S0U9
 OC4BNjPaJ+KtIYYmMETw84dGimY/hECbjUO9Oo+d8z0fMtuPrSp2j4130edqJNQ5SrEPEfuEgDj
 +vk/PCpEVNFcSGXMqqrTfeewDXEfp+mdbh2t6yLFC6pnfcu7X85/2W7+8Qbcohm+mmv1EcpG6EP
 IPbnKFuQQIHsU4CgtjCPd4w0QEevG7ssarieYUB4hEUsO005lHEsQP8BMgUTZCPPdDUPAp//BRy
 HNJzhF/eT5axvSQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The binding references synopsys,dw-hdmi.yaml schema which defines both
'clocks' and 'clock-names' with variable length, therefore we need here
also same constraint for 'clock-names' as for 'clocks'.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/display/bridge/ingenic,jz4780-hdmi.yaml        | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/ingenic,jz4780-hdmi.yaml b/Documentation/devicetree/bindings/display/bridge/ingenic,jz4780-hdmi.yaml
index 0b27df429bdce0b7e080ab291ee0c4c6b51f8e1f..84df3cf239d5bedf8a5806bb48507fea207c7167 100644
--- a/Documentation/devicetree/bindings/display/bridge/ingenic,jz4780-hdmi.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/ingenic,jz4780-hdmi.yaml
@@ -26,6 +26,9 @@ properties:
   clocks:
     maxItems: 2
 
+  clock-names:
+    maxItems: 2
+
   ports:
     $ref: /schemas/graph.yaml#/properties/ports
 

-- 
2.48.1


