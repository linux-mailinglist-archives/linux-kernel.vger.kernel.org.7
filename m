Return-Path: <linux-kernel+bounces-795917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF05B3F963
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4AEF1B21F8A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCBA2E7646;
	Tue,  2 Sep 2025 09:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v8HJrsCo"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0400E242917
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 09:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756803638; cv=none; b=lPwlGxAQo4f3+u6MfjtNuzqGjisNi2I8DFCqVnAWInXVgBIp0UXzGfGrEBvo81/wGWX21m+VscIMgoW10jfeG2JVlfqJASrKbJ8BL0pGdJ/ovgns5DGJ/CRrj4Xw+kRa4XetoF8/t0aKBqN+EZLq3Gn/Acq4lyMwCK0GKl1DpZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756803638; c=relaxed/simple;
	bh=yi+yrbIzGW/iL1vhPwZbx/n4ZLKTnBzZ9NjoEtR61eM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J+GiaJf/Wqhx75TqK/8g8X+xz+X0UV8IIkwPlK9VzvXzXh3BAbAphomqoTBGOW1koJYEifq/ekP/kpfLI8fqIHnxf3gnX7sx810l28Q1oYmCMaiBEfLWFf2t8CEZCbq769hoRugRxVfUhwb6yi6d+Itu2K21RIrCfABicVaxj/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v8HJrsCo; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45b8e28b3c5so10095855e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 02:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756803635; x=1757408435; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zGYSWAcPy26A8NcvE1GHC5uOZ8pXLq1QnhxmCLIQEEk=;
        b=v8HJrsCo9wfK1BIBPfvlU4/m5eKoB9iOUv+vKXb+8Uv1ShGZgkSFqzMmsdf5aJfQmn
         WwhB/LMc45SYN6/z2DgcQIBsS1YWbwImVdA8qRc2xUjgcdT1g9VOx12d221A5bjLQfsN
         H9zGiwz7oOJN6TM3ACL+ut9z988p+3luIKCVn5JRE4QFwOSd9ZDVLghtbKkfeCHBmfme
         h7baMqNwz0x9zOmU0Ob2gQs/bsZxPNWjiEKADDMTVqd0Q+tjzu29Phhvd4q3mXkkd7nR
         u18W6CK71YXRpJYOowh5CA2QOLww94A9q+TLHwkqfWO2khH6Vz/qOAjlmjpDjZz/KvSH
         Wkbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756803635; x=1757408435;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zGYSWAcPy26A8NcvE1GHC5uOZ8pXLq1QnhxmCLIQEEk=;
        b=kmZbJh/PWPq9UrcJlrcxK5daXWbGoGQbJ2RkCvnrNJpBCiyyLSdAD0OMOI94kHpWrt
         i0ghT8Fpl6kniQVjrpgEmIYqGxp579Jn3hnkS5Hd64W62Lnm/L0N0Qq3sNivHOrxDM0K
         Y0izrnHFUqPQvK05+XBkEYrO6SfCJcgbAv7oji25kdW+e2snp7UBSWRNjSxUWlucUHJY
         86c+VJw1AXYJh6nYzvBCh/Z2BWlhbFWtKXKSsmvSWHB/dNB1x7TNxYc3V/bk7D2w+jSQ
         hUFR3kA+8Ad9Ypws/dWFuX/UMxfhZCtH5BrkOcGvovtkOHEg2Wi/sLKxrwHOh0pj4Tjv
         3fNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXulRs5tH7LL6ZmKwC8ogBCQ8AZheuDy+RtxHJRIyYOxkz0jT9kgLTzi/JA8p2zVbpMwB8dGk6caC22ztc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR7ek6lvBx/itNH9gk0PxvkykwtVopFn4CGC7xxQZHvwNOg6WF
	4pSzXD2vII6gB7gvCgGiIYiJiaJDRUTf2iKiYpt3ycXl8fx0YWUYEj8UlFlgdlDowoI=
X-Gm-Gg: ASbGncu6orF9iPtQbNepWPmz7fBVt6HWxwf+3yNtyCdeMXlWnZ1lfIkLBAMCbfqhZnV
	1aeeDtdeyk+Q76RerZM+QV3OtNzBZEJ2pnpaLpebg+05qOP6arrhMnMAsTWviM6ymgxhxcec9h/
	whk8uMJXBBRPSnPbUd146p/kq7TLRs9tF+FzCya/vTkePll5Uqo4mDwcAxHJ9N1CRGLnweuqNnA
	OvV58OfPQ2Rv59GU5A1++OfqwQ/QJZy/7ADEqfnnfamnSlMIGCr8X0z3wSPAWuWW/gWdOcwtMF6
	BdA8QMTTjJ65B2I/FG5gaBJaJYYlDMCbxsuWurvbMIDCWgH9Wlvx9VjuF1M/S7HXOIXSaPySvjp
	pEPl7wPS3eCC/I52WYMiohI4RlDoWqX2PEn7vhShKyVH7dYns299Giw==
X-Google-Smtp-Source: AGHT+IGo6pK1+48xuNgN3auTewN/EHFWBz9+Iiu+OQ7VN6pvjPbYNc8364yuEsgI32HicaXdpYLUhQ==
X-Received: by 2002:a05:600d:1c:b0:45b:8b95:7119 with SMTP id 5b1f17b1804b1-45b8b957228mr58823695e9.8.1756803635309;
        Tue, 02 Sep 2025 02:00:35 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7271cd01sm261112045e9.23.2025.09.02.02.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 02:00:35 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 02 Sep 2025 11:00:29 +0200
Subject: [PATCH v2 2/5] drm/bridge: simple: add Realtek RTD2171 DP-to-HDMI
 bridge
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-topic-x1e80100-hdmi-v2-2-f4ccf0ef79ab@linaro.org>
References: <20250902-topic-x1e80100-hdmi-v2-0-f4ccf0ef79ab@linaro.org>
In-Reply-To: <20250902-topic-x1e80100-hdmi-v2-0-f4ccf0ef79ab@linaro.org>
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
 linux-phy@lists.infradead.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=933;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=yi+yrbIzGW/iL1vhPwZbx/n4ZLKTnBzZ9NjoEtR61eM=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBotrIu1rzwhA3usNfOLqoRch32SVvHPgyil+fD4ZNq
 nNQ95BCJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaLayLgAKCRB33NvayMhJ0c6ND/
 9lkmS7XWOeRpyO4D/IzKA6TOlXSIZbQjaXoiBZoCqEgQlddd6BnF+B4alveipEBm919yvs0w1oObaB
 B59pxJbpMnIYNDW+uZmhwvJBJTK/53NYszuzbVoIlqkj9xB97pt2CPdTFV2uTSc07gMqFi5X99dFtl
 eZYOzch/q449Ca3DraYde5kJWpk9SyCNzbGP5i3JXtZ3IT/oNLFFbQSavQ5k6bVPheGKHC3BsjydGA
 jIZ1XAQRSbM4WzLqtbk5UKne7vEabHKLtMhNv59vtVx0Wa0fDI/MCx5ex+3XrkYxcKMSO3EHlRFUdJ
 v9jJUv/Sj8dXnlMfNcnc6yj2Hhc9ioIWFvxHbVcYwtP/fU8wZxRoBH1esjHjMnsCH5iVijJg4bxplG
 nG6vT5YWAXPvoKgBFjSqWbhHZMv4Fi6Imi9pHlqEvXl4LsKqrjRA5ZbBFy7VqihvOftvruy34dI6ZW
 IAFs+aHk0hdTgD2LjY+TvqDAgKFbh79BWvZXm96KLxMXu2BgR5zRjmJCEetGeomk990fCaX7382nma
 R+AstoG0xrZ8ZbOj1HsfPBTTkyf2r7gaeWHotRSS/gxmbZctKhpFyrqbo0qAGxWJoi0u+ggzay+Kjy
 LrfDkeCFTU1rdZCgQtdOJH8u9CmnA6jSAf1dZP6spP0Kc7SbACB0DnK35DNQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Add support for the transparent Realtek RTD2171 DP-to-HDMI bridge.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/gpu/drm/bridge/simple-bridge.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/bridge/simple-bridge.c b/drivers/gpu/drm/bridge/simple-bridge.c
index 3d15ddd394703a351c1a537e7ab5f1487e024ee4..acf8a6b639da4119f17e4a7c40605947495da0e5 100644
--- a/drivers/gpu/drm/bridge/simple-bridge.c
+++ b/drivers/gpu/drm/bridge/simple-bridge.c
@@ -261,6 +261,11 @@ static const struct of_device_id simple_bridge_match[] = {
 			.timings = &default_bridge_timings,
 			.connector_type = DRM_MODE_CONNECTOR_VGA,
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


