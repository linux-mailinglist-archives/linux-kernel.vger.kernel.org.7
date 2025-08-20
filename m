Return-Path: <linux-kernel+bounces-777910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11569B2DF1E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A1781C829C4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FAFF248F73;
	Wed, 20 Aug 2025 14:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M6na9z5A"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7127326A08C
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 14:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755699472; cv=none; b=DEqJh+SIj0Df2PQIo11dEuLclnH+cVRdgrUOcma0s+M7GFpkZ+avCUG/uIqqdXz9ws9pkOJjJra9QRYFpuQNJxWosHvLFxNztJSBGm2ZQoY+wm1FRCd4lQx4W6n42uQnz5VDLC0Wyvs6AWh3OKDDYsisckkpZODOf2VlUrUnrvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755699472; c=relaxed/simple;
	bh=Pxy1ceX/K708ATMRkgiCl/qGBMScopnigW8cLcERjdY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qEVLzkE/munLzJlYEAzKat5UfojViDVkIcZ+27wsVxZSIFyPrFdmpgFoGousBm7du+b+o3RhXEI2iujZ9hQiOpQSLj3bfkXeLVHURHPus0/Bl48WVQAmdnmWC46Dp8w2sefD6sTEb4qCrWA2l96Em9oKpe5AM+pR6tGnxQgJSco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M6na9z5A; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-afcb7a5cff3so118979166b.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 07:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755699469; x=1756304269; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DH177aI32fcw+0fi3Kr7cEylMFjtb1+kKdAUsXxCdWo=;
        b=M6na9z5A5XkC0yXZ39NtrV6LhxGmcPR5qDFo7gRfd6RwiV6dzu/qQO927FVt6s+s00
         vbb7oqVNsS2x2LC+JBH9WuZqpiYIGViHtUKlFfCezVgySWD0cErIIeABVs57Imm2Ic4m
         5rjJUZk5HyYv+Z/LC6Et1RK2klRSQnjVL6Fqkz4NfJnChJe+8w9RN4aTlr/kLScDCyWm
         /5tIeMk1MMMsNazDetFX3xPgkzfGtmwst5TDJxFjGyKo5Fs+nKBn/B7RiYgreX/AJVgP
         BejMMjdJRlvDyBR4uYYchoZEZD3fBhsxf+HsOj/fnzK2JnNOmUwjhR8fi84Rbqcs28GI
         c1Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755699469; x=1756304269;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DH177aI32fcw+0fi3Kr7cEylMFjtb1+kKdAUsXxCdWo=;
        b=P1U8+8yj+zbUAgk/FKhyGyJYdzTT4xl2bFUKVIwWUs4NzI2OyAAprXtwKSNzwpmIjn
         PIBrE8yPrqdd9GkxzQ+P0a1SExwfz16Iu33hYRczxhIDj9GLHLiTi2F0JLopWxeTo8nV
         NOmzxti43bg8chY1XDbW64GmFqIS9reD5h168Ap3SFLUpMFbMJAH8rEu2q3G/CZf72U4
         vzljknEgcQ8jEJgj7E4L1kToTrW23iXsZIV24Osr9+pXHVpCKXSTXHLOfTloRE8L4LFX
         pyMfIKhIY/ajSGnDYVZGJUQP3FyUJaSryADVYgJjb93nVw7DufTFCbix9EvbGs1H/vOs
         U6Tg==
X-Forwarded-Encrypted: i=1; AJvYcCXU4EsNGf60Jh4UPo52pBqqdVE294eNrM4wHpctG7HWGp7caCbVMgo01vfAdi+QNJ0tOLure87CWFoIej8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOvUAW2bveqCX3TcRfzJUmVDyaNcR5gaYzRtt68t1yPrMjK9oQ
	Mg/W54kpscjV1Xo/yYPYiqsZj3jA1rEClsNbs3/820GWEnteHMtOXGxDuryrA0qf4Ro=
X-Gm-Gg: ASbGnctXfvr/38zW3DyFts1iUZX4V4RgMk2tgTZveV0U26JsrniSEE2XOVFScmU6Z6r
	/C0UQTYYKOrz0ZucUrhxyew1Ieu9Y7llVU5UIRKtR4gxEZt1PUo8pp/bRgIUBoMmrlvS3Q4Y0MY
	mAcOyjtU7JDxbNt+ygPAjZrZs78v2eFoAmkXnsBZUWn9LNZhwJ+y0p3mJD8RVwiPj+EExAznNQY
	etUhCzHFI/PDWOOIYlMnPYgW3pATCB18z3LKEjfF4JfPtNCvkiT8Q1sq7DuKGG2R89Wn5Lnkktc
	mTWs3G+bD6uFnI+xiFJVLMfEN3+cX85NKeFOJCxWI3ZVQspAu8FGp/cR+dbb23+qtf6eftyKWil
	ztPQDeegyNIW1/YQqLmGZhyaJukApzHhSaGDmbj8=
X-Google-Smtp-Source: AGHT+IE1NDxPIblZHLyHWsai/l+RkUVe1BeuAZ+Wx+dsahTLJmxSzRi7+QTtrjLlctknkk8S6nYJVA==
X-Received: by 2002:a17:907:3dac:b0:af9:a9ea:f42f with SMTP id a640c23a62f3a-afdf020be3bmr125823966b.9.1755699468735;
        Wed, 20 Aug 2025 07:17:48 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded4796f3sm186541066b.61.2025.08.20.07.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 07:17:48 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 20 Aug 2025 16:17:36 +0200
Subject: [PATCH v2 1/3] dt-bindings: display: ingenic,jz4780-hdmi: Add
 missing clock-names
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-dt-bindings-display-v2-1-91e2ccba3d4e@linaro.org>
References: <20250820-dt-bindings-display-v2-0-91e2ccba3d4e@linaro.org>
In-Reply-To: <20250820-dt-bindings-display-v2-0-91e2ccba3d4e@linaro.org>
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
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBopdkGYy7rVicbfewwuVfkX00qnzDh4itZ/TN8Z
 KwT51inn6+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaKXZBgAKCRDBN2bmhouD
 14mYD/9h0PiQE9dy5vwP7vBJ76dItA2byuWw27+5o/ZLt40o5X+7eBO/du6Z1luxBiHrjoaJJ6S
 7mJN66kdDvO8897oK9TTcu3tnulzNRtpPDWhgxc7Z5Tzh5Gmx6GejO4Kp8aZ5ytT6WXfliE0+UU
 CgRDbNXfZQT/zIfB6J6mOUN1RYjKa2OflnN+xrE3eTjZW2leo0IOKYKQRhLJ8OnXbIaoWY6q6Iu
 tUk0woil75PeoPrWdZSUHViAmDvB8BNDpo6ay7k/Ek3AqTerB/Y9hXiDjGACQMt8YhzCXKbWPyf
 GR9V53exquBI5VWe06gYpDvK8iPPUcuBzyxykT9iKC5h1ycyfD1AsZccdu8Mpe9J6sSG6fd/uSW
 +XoKrVNJynBpfz6eSvjzyW0zaMZlcYrUYc/b8WHOetPwkwxR62UHlf5gVVwzY8rQYm+I59tXkYZ
 ExzC6ZIo/BCMfd/tCel3Vpnj9zG/Uou/x7kOJVcQ2yxWHwwF/ZCufw4+bfF7WDwF9eSETLHwDtu
 Bz+aSxFJ9CXpRQE+NK1yzUsKZ/HemJ8xcjrT2HmXT5thnOxp1aVBHaXEHLsmdnBq8OapPAm5VF+
 bvyxXAJaOMyqKHirUtqCjvtneBDKwVP2elp9F2Ste5sVY3UewOrHlc1ygbZNOPcwtmfMma2KKsM
 PQjztLAysb275rw==
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


