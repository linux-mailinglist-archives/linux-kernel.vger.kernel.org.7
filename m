Return-Path: <linux-kernel+bounces-628616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A893DAA6017
	for <lists+linux-kernel@lfdr.de>; Thu,  1 May 2025 16:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 842F97A3FB4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 May 2025 14:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0718202C50;
	Thu,  1 May 2025 14:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QQCvsXqT"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F831F4C92
	for <linux-kernel@vger.kernel.org>; Thu,  1 May 2025 14:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746110020; cv=none; b=XSSqlNjIxHo3FGk7iJQEkxSvnLZf6ihDkPPO/W2zDNE73LvWfVz0sz+dvvnKDDBXG01RrOOc+sxxuyFoZA83HWrEX4XTk7sLpyz/bgxm8IaEWqy2rUiZz+diLuHROiSWfXeru+nwNUg84oP+3ZL1PgZF7swJ9JiOZ/R13+U+cHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746110020; c=relaxed/simple;
	bh=RSvClL8Zug/P8IaPf0bu7goft33I+jFzMuQWhTt7CeQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OYyeeJU95NkgNZKtqRKxD5cFIrMIqo7bIsAJxMATmf/wNb5SwqXTNZkZ0RqkPaGmtBVbwDZVhGyZmsNde7IEKfxK6sVc56heullSXeWcUt8S6LPsyoblTUK+duEV4OsyttvkZ71nh1ajQrmgDl19P1G6eD4iXv7bRjcffM0MSzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QQCvsXqT; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43d16a01deaso1324115e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 May 2025 07:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746110017; x=1746714817; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UPS5TTZ2Ma7zjGs6FuvJZ9IfhLucZzH25kCN+tl1ZQM=;
        b=QQCvsXqT4L33pGXFHL9j4xKoLyqQ6ThOUwcUQiqKq0hTA4/k2OvlZO3v7jVNPY8dWy
         L+iOczHKpCdKtsJlUm3T9YR0KovyPRac6KhdhyM3dZWBm7Tq/tAcXa7rGrRndLKx5YTK
         XxAK5xBF/OOFXGywR3lt4hOBuC5/1wpyGp8BuxKYnk0fnncsLJzPxJCgk7+pfESxnv7A
         4oeskvaaCC2u5a7pfcdZdC5dX07m7kJStvHxwGQwVZCO2XYkiNbTKhWfr7hpIfy0/MSM
         yKsH9d2UvdYj87bLNuvz44jcZi3P5CdyiQ157PY6neDtVkKLmf+5Yxihpl6c7UgfmNJI
         uupA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746110017; x=1746714817;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UPS5TTZ2Ma7zjGs6FuvJZ9IfhLucZzH25kCN+tl1ZQM=;
        b=t5Kw9ms/iAIX55yu9kRhhtu5U9IpUxsaeKX/YxIIOFIP0Sz+8H63cGrSDfdZJu6d/D
         Rc8Oqh0buYCzu5GZ0Wui5NQti8lStuwQ87yRLjGLAjUugyewuRWhU0fjhLfJiFw5Zj4G
         foevudEceqxlPPtjthasQUTDga0uVn8bzK04LIKfcV5FSrTM4mmp3oYWhncVCZIgW/wp
         FGV9k3n3JiDBL4WER3m7WxAF8qF98olxzCeAr75ecU7JFXXtkXEkk6Inn80DnggDCTv9
         k85jnJBaZGfYtehq6ezgsiNaOuEx68O9KHqY6RS63XakSgU4Ls1xwMVUTugprd+utoRT
         Jovw==
X-Gm-Message-State: AOJu0Yz848yvnCJKFwGyaCPOGOwfCX2HWzWFBjtythdFWDpZaBpTQsz0
	sEKxAtr8lREeY3ywjHpY47r/ntFSOGVbwi4UabpjS14D2oqAP0U6D0BJIWQ/zcI=
X-Gm-Gg: ASbGncvap0EnHbl8t5tsPg124SxY1n2nmgyZ/QgkPE+rTZIO2uBWuPnchrx4NsulPcW
	8lCwBwViDrqVwNMjtZxhKcXIyNK3mUKmzfuIYDvrL8bv1YEAnaSdemJYoDbUmDI7Hh12XbWC7tO
	xy2gB1IKOHeVDUqq5VDbMDCq2gYSDcEm5XJ7TWP1kVVjeLlSzjisKVLVK4/wvNB8L4xceFJ6P+Q
	HhvLDC2UX64GJOzmFpAJ0G66MXZJjTjp0EER+lkIziVgkOaTXZBENmS/RcQMAPkRXdrQMyO3MOn
	sI04uwK2ZJzgA+ZEPBCPkbXBcZ+gVvp70w5c+i/D2RgScf5v4V4S3R8mg0o=
X-Google-Smtp-Source: AGHT+IHELHXEiTGWiEpmGPrkcyIBKwg9ONSuRuJUaTdgABkFi1hrlGa5toyIr/AaHb96Toujbn3Bww==
X-Received: by 2002:a05:6000:43cc:10b0:3a0:65ac:2b46 with SMTP id ffacd0b85a97d-3a08ff351cbmr1415773f8f.0.1746110016886;
        Thu, 01 May 2025 07:33:36 -0700 (PDT)
Received: from [192.168.1.28] ([178.197.207.88])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a095a8ef66sm957636f8f.88.2025.05.01.07.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 07:33:36 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 01 May 2025 16:33:23 +0200
Subject: [PATCH v2 3/4] extcon: fsa9480: Fix wakeup source leaks on device
 unbind
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250501-device-wakeup-leak-extcon-v2-3-7af77802cbea@linaro.org>
References: <20250501-device-wakeup-leak-extcon-v2-0-7af77802cbea@linaro.org>
In-Reply-To: <20250501-device-wakeup-leak-extcon-v2-0-7af77802cbea@linaro.org>
To: MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Hans de Goede <hdegoede@redhat.com>, 
 Chen-Yu Tsai <wens@csie.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=808;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=RSvClL8Zug/P8IaPf0bu7goft33I+jFzMuQWhTt7CeQ=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoE4Y5xiCTqFubQr8scqk2hhG8BLLucDvaBTylq
 n3xQH0r0LGJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaBOGOQAKCRDBN2bmhouD
 15QOD/0e8dH/ke6LYzkD5ysGMX5eU0YRSaD0eWUfthbO6U87X9odFtkRDGZeNW/XGOnxrHOI16s
 hPqydHbLe+SiJSuK5cLUtyeVcAoSeKPYaOKiQX9xESno9VZ0/12mGWW9qURiJNGNxoDBs37t8F7
 bsT21/ouYLJtZhF/uYKYR6HXU7cMZc98L5Mg2xNL0od4LdmwD9fokmXTjW6Ive5Tl6H0tXmLdqS
 jIMVjBejAEPkjA34C/NHyYVTuh6lGpEnuwa1Yp2i6tmVY9K5EthueQ+Zq8cd6KX4qi+GIy3UtyV
 bIEpiyH/2U5AvA2g8EDiBY1MjG6IIoQPqwQDPJs0DcqBUL3FOjG+UZa1IeNRALlwErEHubJYYA0
 oSB/zYwH5MJc1PKJPE8DFzaTCm7OAIbc8dadN6a7bTqokVESmccGseLJ11Ur8yI+9AqkN827yzU
 Vf1SKDq3carYAztYVxVkZdeAMRLi5i5gTHE+XDieo4mY+hRcMiC3YYOyxrDF9zCRy09a0QHh/1X
 Ks+wdR2SqC1/vmAE6jPb2VTHC5rKhqdy4/CkxeCkDriQzjbpKHUPo3aCud/ZV9ek8IHtGMuaO8a
 MguPsqGAX4s3A6dIbi+NqJwho7qWvOVUQT9JAWcRQLCVlqugYXETlOCp/pLep3hSXmmQ8VpaxKy
 +xThYRXkWO7q/0Q==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Device can be unbound, so driver must also release memory for the wakeup
source.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/extcon/extcon-fsa9480.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/extcon/extcon-fsa9480.c b/drivers/extcon/extcon-fsa9480.c
index b11b43171063d6dc14a5a4a7efb63e610397312c..a031eb0914a0b68aacb0f5f1f522597ea286fa2b 100644
--- a/drivers/extcon/extcon-fsa9480.c
+++ b/drivers/extcon/extcon-fsa9480.c
@@ -317,7 +317,7 @@ static int fsa9480_probe(struct i2c_client *client)
 		return ret;
 	}
 
-	device_init_wakeup(info->dev, true);
+	devm_device_init_wakeup(info->dev);
 	fsa9480_detect_dev(info);
 
 	return 0;

-- 
2.45.2


