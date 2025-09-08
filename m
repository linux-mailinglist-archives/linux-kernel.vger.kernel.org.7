Return-Path: <linux-kernel+bounces-805868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 106FBB48E98
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 803B1188EF55
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FBE30B515;
	Mon,  8 Sep 2025 13:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gvsDVI2q"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5213309EF2
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 13:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757336670; cv=none; b=j+UYME003PQj1m2iY64nojIn9V3UZiyRitQ1ylyWwiGYbX19iEwx0VQgKhQMUC3lRr/n1Aa11R/gWTXJNxXliTDl1WVqJ7KsyJZWluZ568u8rvDi7BW5K+bjbhbICZQzyUS4NbMb/yaXRy7tKMl1KP8L94u2VpT+R4LQWHVXMHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757336670; c=relaxed/simple;
	bh=57wYQRJRg4ExArTqXm5cpG0+xrX0pV4cmaNg44EIRGY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P76HXR7M00qJoashXyklIkC8Tcrz0LEfbOdwXdWzSFfnV8LWHCdJHMzyqCgy5QUhWYgdjsuecCpaTVuoLJfv5N31vqDfqqVo21TdlIIevMl2cr5EC/0fVsIAvS4KDAfWnO+5Z1aPl/QoetPKLWP+L8YjcO1y1ot5UgUjqIKjxyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gvsDVI2q; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45dd7b15a64so26730135e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 06:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757336667; x=1757941467; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4X5mW1qB7suLhxQR7vN67LmE2/9l2QgAFiGjCe5Ekvo=;
        b=gvsDVI2qH1LMysWNZZ+CW2coXEC+b7YnbK/opp8ICi6WmYzgiq9dxCz268Ere+vcmu
         0+jdAGBkiEf3bHRya/USxlyz2bmpjTyG26rz4+2jMvnN8ilZRSIZTdmrQMf+YI4+NJRH
         ZPk8U2sSJa6jAanFc/kohg1VQ8OLjrbBnunyy+0Ao/TYMQ1qOz94y67e7LOPrAkRL9z5
         GPa51wnqyerMULt6UCrzidPBHpFOaqYzew6ZQKCn9J0INC7RZj8RrPZQcKHX8af4iARe
         Jn4u6XryQLQN/RNsPxf+Jm8a0ZejWm8PT6NhAeV/9Td6/SBOnPcb6MD+bAU3Im607KXL
         za3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757336667; x=1757941467;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4X5mW1qB7suLhxQR7vN67LmE2/9l2QgAFiGjCe5Ekvo=;
        b=a2cO2WgxLI0loyoi9StkhfuNUjd6U7ZF+R9hAboj0AJ9qbI6EzhTYqiGibtZL3ee81
         oJMU7GUaNYytjGpgC4I/c99o9CT5ACEfHnXzMeo6m4Zm6E9wAPjh9TXNXjYjH72PYObU
         o7PisswXcY6QBjYbFNi4MFumcGnifW4UQp2bZPFXYBn39efNL8OVWp0dgA8IRn8ZY7ls
         6RSvNpIjFzrWk+nP+1U9mFWG9BTJXR6YUMC7+bmas53LqUmOIjizajZq/FVKUjI1E6Np
         pJbc0W8KnQ7wEVPRJzgEwdha9O0qRwbvb/msn/FFf4wSKm+SppB8jzDE0BVkmTvAHygw
         rOGg==
X-Forwarded-Encrypted: i=1; AJvYcCVhZm0yoT3cD9zJOcz4If1TRF60zDjY3vWmgvg/AtW1as28WDx+RLoP+YzCd3yzRjtWPpkWPamlli/Naxw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9J2yeOubTIqtFP0EXQYpzZe9voNjgE43htAdF3rTijT/raJfH
	kYDZ3G9+zFmGvy4FwdSb85e59R/tNq+zq+9UryiGqA6NojAbyndEhmfxsrgiLlVQhyY=
X-Gm-Gg: ASbGncvMC+6uhaGxcU0JuixU2B1lfV2Ljuzc6/OzOHErMasSCdPCiuamtM4lQFqnjX4
	OX3T09fZVPW88SAg2SUmJ8YNeNfxm2c8P/lFgXfriLrAQyXnDVRMSdfgkWnwi4v3vvL2DX4mgiI
	7KIJWaU/jGtjrVVniyVgkYO4rwsYl37GjkzWt8XwACS5FWB265QPOTuA/7h0pLJGaf7Tw1YObHV
	1Q4Zog8QG5xhIWUPKJKF5h6LsFHNwdiBS52NSgUj1Dy0U7T/YK7+sa9rkmFmqEW39zgkdCj2yPl
	TRrlXJODzpBoaSdqcoghTVOaleCAbBDztI+T3K0ktGYTH/WeCPaOr+N1Sjaxvr9ugRkWaFG/z5G
	5q/zrcOtdkOZnO++bwI2KfSXJR4UyS3DdpUZs5Q9fXf+t1VaQFc4MIogWY6fZ/IBd
X-Google-Smtp-Source: AGHT+IEGJNo8lvHD3KT1nd3z0SZyukocp+3vpAes2A8i8fYAVWbJ1r9NqWQEV9vNhvmGaNyomqk4OQ==
X-Received: by 2002:a05:600c:3b1d:b0:45b:8ac2:9761 with SMTP id 5b1f17b1804b1-45dde20e5c0mr71641885e9.13.1757336666930;
        Mon, 08 Sep 2025 06:04:26 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dd6891d23sm145632475e9.4.2025.09.08.06.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 06:04:26 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 08 Sep 2025 15:04:19 +0200
Subject: [PATCH v3 2/5] drm/bridge: simple: add Realtek RTD2171 DP-to-HDMI
 bridge
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-topic-x1e80100-hdmi-v3-2-c53b0f2bc2fb@linaro.org>
References: <20250908-topic-x1e80100-hdmi-v3-0-c53b0f2bc2fb@linaro.org>
In-Reply-To: <20250908-topic-x1e80100-hdmi-v3-0-c53b0f2bc2fb@linaro.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-phy@lists.infradead.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1010;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=57wYQRJRg4ExArTqXm5cpG0+xrX0pV4cmaNg44EIRGY=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBovtRWQc6EqvDQUILTPG2XMP0l4jGNYemvl7JX0cwS
 ZQL48r6JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaL7UVgAKCRB33NvayMhJ0bWxD/
 9GOARmjbH2RhQfFuwESyv5NkmWCcN/CI2i9DNfY/SfhlryWRHAlztPNcY3o93MW3GOANYV7L0wAhTB
 C7qiw4uh10jFrOkhxeHewFGc55BdptV0ZuALp9fKoKpUSUvYU1rQ+jdgm0TJmWXoJUkrqbchBbMA4E
 pQsPkfWINXsZ3Km5s0bKu+j6e/2GfqhtLXnW07cjOEUfdr2MMNYK4JHrhU0iXSTtQMYh4txKmi2NkJ
 59htO8o93xz9hWLFoZWKKEyjm7SpZRZbwcwKN0Gfen/vSduFv/FNZYd5eDMbYwoqh7vSM1/pRhk5vg
 pnBHMDL+yg6zAvfBNvoSFPjqqTWlX8NySuam9JE1tluCspNls9s65c+U7eK+OKYvx/P5w3NGASQK66
 dNOGUz5/3160k52iVHpxgPdZMmVffGChGKctVoUbda98pR80nm2yEKmre/ky3IHog4ZqTBcIs2TU9u
 i2XqCudzV1iqvnxR70jMiGjVFp4yDTwq8ClGhFnkK6sfJwLfvK3wPjwYYhR5u/FSJdYmxyILYJgsBN
 cFvByrkVdDKR44TOtXhSXe7K11w2/z2u7pzCGzqrS8zpHXb/0BAqBpbkGDRPE3CT91hFnFlzd/6NCd
 lxp4tzknBJLQus3yJHTmE7pMiwLC8t+TXPiw+c1Pl4lu1eKClLhmFD8eYKCQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Add support for the transparent Realtek RTD2171 DP-to-HDMI bridge.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/gpu/drm/bridge/simple-bridge.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/bridge/simple-bridge.c b/drivers/gpu/drm/bridge/simple-bridge.c
index 1f16d568bcc4e0fb56c763244389e6fecbcb2231..e4d0bc2200f8632bcc883102c89c270a17c68d0c 100644
--- a/drivers/gpu/drm/bridge/simple-bridge.c
+++ b/drivers/gpu/drm/bridge/simple-bridge.c
@@ -266,6 +266,11 @@ static const struct of_device_id simple_bridge_match[] = {
 		.data = &(const struct simple_bridge_info) {
 			.connector_type = DRM_MODE_CONNECTOR_HDMIA,
 		},
+	}, {
+		.compatible = "realtek,rtd2171",
+		.data = &(const struct simple_bridge_info) {
+			.connector_type = DRM_MODE_CONNECTOR_HDMIA,
+		},
 	}, {
 		.compatible = "ti,opa362",
 		.data = &(const struct simple_bridge_info) {

-- 
2.34.1


