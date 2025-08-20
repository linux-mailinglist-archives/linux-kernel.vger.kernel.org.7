Return-Path: <linux-kernel+bounces-777911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C498CB2DEFC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C3ED7BFCCE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD0A27510E;
	Wed, 20 Aug 2025 14:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CSRNj838"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6663426E6E3
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 14:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755699474; cv=none; b=ksKefqOyx+FrgkGQmvWjRD+GsQknGX1kUNI9bu1aSDl3HryfqLqEFJugRxeKtBJzjnXtN56YKcQkcdzIOoJqVqJHekiFDf8uLpVfz0zuJ+lQ0YCUujgmySyBLUlFSuxRquiC5g7PVoA2QmAK2W2HILo7Afianr+c8fydOW6FuNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755699474; c=relaxed/simple;
	bh=AkV3VRQfJAkPuyGMV3zApyjndBmAsTYMa/X+l+hz0eY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=apqkIzy9rcfSgBi695m/uh5DEQywUqpGGpIXhCKv3bJpyjhhtomcUprkYycMiwEfO4lG/idpG8SmLhgrtmE+zyFA1sYTr8lfyirAwfFdBNv6E/RIScMMNiOi3f5Vap0l3/znCxUGP2yP9ndqkqypvAj00R4nwYMPxwft8q1QXzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CSRNj838; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afcb7a5cff3so118980866b.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 07:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755699471; x=1756304271; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JYDyb1l+byMOiaJzKn+UnmmghGQhvpVn03tecEee7KM=;
        b=CSRNj838skiu9ginMhalfHnWGV3ONbvOb1D5ziA25WweaBZe8fafDSZOvPie8N9tFM
         7VThUGMNF7MYTIiWH47dB7jn9azGaH1tWG3nHTmd+lEnBgukTBGQrg1Fc1W1fzoLDp09
         4HgtMpVIiR203JSOPXPnXdI4H7VjxlMErTWXqv36+PELWbNi85k/ksma1obCxXBU0DDC
         Ck+LTVPQTtwHTKlLOdy/x1T9FtlH0NahMCZRgmOLU5+Zu34D2+pmoeGMUVZbrLwcP20q
         eZ2k/geozVgz2xCCKRt/Na11Ogy4FTTg+lvtdLO5ASI+c8drJ1+j51a3+sA6Bk0lFXLY
         Zgyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755699471; x=1756304271;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JYDyb1l+byMOiaJzKn+UnmmghGQhvpVn03tecEee7KM=;
        b=fueFHytHHFZwm5TpxEZfm3Wtk6sizoiQEVb0iimnNRU+bW+I0E9WSdIGSpF4hyG56j
         Uv8ljY1c8d3NWle+D487cVyfYreDodfOrYnM6hdn5XiRXf+YQNwCdIrBUHtxqwuGZ0Nc
         r0/hhNJ10WQ8rTIvIGYrS9djDCJHlvgrBBJIkFiqjPILlF+yuK5KCtt3G64MSFIf4tlz
         sI5XR06FgXylPTIvLPeQgNlfgl2zDbcqqn2S0DSh+TRc7TfFTSTq/qsH7i0m3RrNafEa
         VJB+KosMrXmCxB3pwC2GS6eNjgQNs4AXjJqHclFt3m4NWRnjkMUKIJF4QzH4AmuZpn+3
         cLzA==
X-Forwarded-Encrypted: i=1; AJvYcCVo8813RVUiIlagXAy/0i42OWMP8Sv624VhOj3mUNWwTXd/ULwVDn4QCMd0hijVv/n4BVedu8pETWt/M8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF9BHsmUZRwyMD655WFTJ3bTJ9iUcZoMvdBNq9dHTZjh71IY1K
	OxRuAmwNssfRYwUGy/0OLCPxVd2QnuyYYf4Zqc68RsB4XVfXyJshIBv009ujwSxUXFc=
X-Gm-Gg: ASbGncvyCuktXCHk8dlncnUN/pwYszUWBIC7r8jNiluEmkUjyQBT6rGYuvYtzRAeWjR
	L4fyJTymeYIYoaYX/5Rv+pMbbgkYTeaPq0QzReBCQqvheb4bjZz0TfWrwuQue2QjjofBGfOiZGt
	fEBlmYgX/dy3XGp98Z06F5m+bz5/OyfU+LtP+NMhTqwz2waQ5WR+jLU5VNjQmSzw2abzg3Wkwl1
	YpUmyQ0MwxkCwpt8x4lco79brhIjStSf4mWsLQxquUNn8yKumg7uYklTOUIdWn8RW5SAsa5Qbt5
	FsQIWSyJu/xnyFfhTWmpVMOjNlHcsIdqUbC7BhiefJsAvere+zB3tIhuQQvqiQK3sfkKnjl4WKr
	d3AE8KDnJsaFGI1oPJq2vwbsNBDyE/0bxg/owTVs=
X-Google-Smtp-Source: AGHT+IEmrLUelKKUOono3ov9GvjFbcW6q4Zw0ULLzvLJYEr2I6DZLLZrvFrkswdj/bNZgbWEgb8PUg==
X-Received: by 2002:a17:907:1c12:b0:ae6:c555:8dbb with SMTP id a640c23a62f3a-afdf0256674mr142702866b.11.1755699470561;
        Wed, 20 Aug 2025 07:17:50 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded4796f3sm186541066b.61.2025.08.20.07.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 07:17:50 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 20 Aug 2025 16:17:37 +0200
Subject: [PATCH v2 2/3] dt-bindings: display: ti,tdp158: Add missing reg
 constraint
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-dt-bindings-display-v2-2-91e2ccba3d4e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=990;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=AkV3VRQfJAkPuyGMV3zApyjndBmAsTYMa/X+l+hz0eY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBopdkHTLdBz/9upwUfV9iV1nnV0fegXMDVGScJS
 +323M0dU0aJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaKXZBwAKCRDBN2bmhouD
 12rlEACGX4EZLaWfGRRN8ipoGBIacbdpDdtXYFRu0zv6iVQbYo/Um8r7PYFUZQM/dehtOi6wewV
 Q7+E7dUwXKMF3wuZGjwQ0m2nXcHr7i8EXzrKcN27rlX5w/2qp2+9GMlwsZJp8YgMsUVs78qZ3dx
 f71D/9101SWQN6XQU/m5OF2Ar4lzohcm2vb4Lkl4nSf0j2t/oxG27/aZFBDvrRxFFFKS4HwCii1
 yxrYrkwvvrTjXvTxsawafd6ESN5uWS3lsAEBkFc/1SaarnsKPmznKyyapyv2hiX6OqeYEmdgvj9
 32QnIY2KF39R5Y5eq/950VSdt078I36aG1vljAwfAPg0bnHx4zjksF3ToHCEGfaBhffoonrjPPE
 GA91+7wy1+262Ue8Dp70IEfYnPDB8byAmj2rZOTwQ7/uiZK2BkS/vXAHqm5FFXersWKWhhVgdAZ
 7i8Vdf8NMJiwABhUKwH1HgqLLqtT+JvY/JDOLDDm6XJLwpbQMRHD5SqA1E6aMq6zgfPhU9hdLLj
 i60X6KTKsgXASFkbZfNR5zwJGyZLaOQWwsIR4EO86n7d4HYFJpHdIM/Z2F68KTezqAIJKi55v6P
 /e2J9tF+gLqLSjo2KD93r2bVnlCFTlBwzOpGT7rJlzdNy6w/4/zWTu/20KJaORbwEOX5apcLqy4
 ydTdZieF1pfoKyw==
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


