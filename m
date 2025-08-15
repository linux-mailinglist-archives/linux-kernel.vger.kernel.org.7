Return-Path: <linux-kernel+bounces-770293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA96BB27972
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 08:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 253DB3BDC6C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 06:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954B92BEC53;
	Fri, 15 Aug 2025 06:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T3fHIY9z"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA8926D4E3
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 06:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755240595; cv=none; b=V2/x+7iSOVUKSawV6oZR8ohGeQUymVRm19IBLG8Ce9jdUZ0IEBPMTN6g50ksHDROBrPwb1GAeDRLg0s/r27WQi8zkrxrR6BFXe3WSvT0Qr/iIs4d0z569kcKDD93raQqJwuxBb81B4i2G0vXO9/vSdNfg58myBIdcGd4GDFF12s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755240595; c=relaxed/simple;
	bh=K0BHwWFqKTGMLEkMOxlrAMriYgYhyPgtOID8NF33Cos=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aH3Gf0DZtP+QSo+M/23leR01DwYwyuzjqVK/mmvlwhn7gj/jJ91ghcmF0nSkUI2lk2rkBsVk1rvWqJ2P5QAOpUFjC/NWuhHTpdA/xiBJOIPH3hH4KXBi243je/A2oV8HTlghDfc0soQVKeBgZfVBXrnlDsdk8AiY1CIIt6Qv9iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T3fHIY9z; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3b9df0bffc3so958981f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 23:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755240590; x=1755845390; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ih8jyns5XfrAsfrJ/D/bA3PgscUwKaCWqo6J4z+BpH8=;
        b=T3fHIY9zqW4G7fclg6FbxU0TVJ4RzBWyVgIwy0FMq9M8OGgHjmwrFIUjNutCHo237w
         lsgKW+yMtXra8SCeXRazSOkUXMMbmSn/eymRl20hiuZKeNj4/lnoBQBVSg2Cpm+tm/p0
         YngPdpzAC0yxcbyziJRhmmZ7FnYVSnK8f6VJ6Mv8+2QfooLbdh0uKj3G5jGk3XSxVMbT
         RNSfRjes4oO7LaLqjIf5WqT2HGsgmwoHZwmAd0hV193CPM1Bw+Rn2P7dLF050JMerEVu
         OZ9joAdvdmPKDbrw/esmgnmZFTEWyqnGPPZEcserN1Pw+TykBbB4zZ1uB/Xbf3gI3pvM
         hRvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755240590; x=1755845390;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ih8jyns5XfrAsfrJ/D/bA3PgscUwKaCWqo6J4z+BpH8=;
        b=tEAvPFWPXJ01aaZzBIPZfDU2vy+wBXKzy9LAgGIdjdgW5CvgmIv99ryMV8fJFsiQqu
         EOy2SmfsLMztAS1w9AT45x+1Gs7Dd2aKdwlbmpz+bf/RXuDZnRLLO+cLljqEVNEowPQ7
         rUi4ertCA2k+MgOA+/uWHjY6CGFaXawtBsKeKe+qMRnsI7kAL91VuUwR0UudtLzs05F5
         gGN1rMRcx/3zYaoOckxPoxTJLnttGakub+AZWWgQJXdACc9/McMYSURexo/peq7aRmBm
         O/+goZ5bEcb0MJqNmiJ0a5YG7ICnkNOieEhbNeRcOi8Liv/hsMDVsv0hgHZIptXzo/98
         86Tw==
X-Forwarded-Encrypted: i=1; AJvYcCV+yaYLjG/1iSyEgreEBq/i6LlcgTYwtIjK4gZtHIMc7R+sCOl89TNmy14+X9YlKXQsHuzMgnRLDn2yFgY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0HWwcUQxqbT7T9jyMQyooZlekcZNsr/SVbK2FzhLJ0Qjh5hq5
	XrS+UmD93I52SVO82vSYiKec7KmbFBQlM02jV+ALVvt9PIF0f591Z/TGTL8lwOvSrjg=
X-Gm-Gg: ASbGncva5ja+2X2/19d77ONpLzxS1TBm8CXgdwedhPikjbh9YnjEILNSYPuFXETXMq+
	QiGGwXZLxMGDmu53omO+pVtzW3bKAnhCPKWz50OCbb59UFTfEudHcmKuTVrJx6/EtsK+dpr5qpT
	Z6QNTdypQmUv28HO6FmJpi/vp4z1RdOAbqvHtSMPkk3SiO5Y5TOr7tkida/KG7ZVI4eigF70iPa
	TcLkYswaG+xQyVi08KK1rSGT0d7FpdAcOzXlht+oMnDSy/Zf4gu32GvSONrUqtx1OPm6lLnJSSz
	jo3uDg5mqO9uEJ6lwZXIecJJQgr8N99lcj5JuaWBSFKuq+d3b5jWnD3ZGnbkitcrGAYoxOxxXqI
	IbwUO0aGtmQ0+SGvEkxUIjZgFX3KHoYlbqFrn2EVmy80=
X-Google-Smtp-Source: AGHT+IH+DBG1OPf6MaEZOCGobGhY9B0ySgxmVlsCJLQpN6vJTZ2E7j3xNdPM/PtvVjUbEs2woGDf+w==
X-Received: by 2002:a5d:5f88:0:b0:3b8:fa8c:f1b3 with SMTP id ffacd0b85a97d-3bb694adc61mr648544f8f.53.1755240590473;
        Thu, 14 Aug 2025 23:49:50 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45a1c74876csm46766045e9.14.2025.08.14.23.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 23:49:50 -0700 (PDT)
Date: Fri, 15 Aug 2025 09:49:46 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jeff Chang <jeff_chang@richtek.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] regulator: rt5133: Fix IS_ERR() vs NULL bug in
 rt5133_validate_vendor_info()
Message-ID: <aJ7YivhlWlE6ifw1@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "priv->cdata" pointer isn't an error pointer, it should be a NULL
check instead.  Otherwise it leads to a NULL pointer dereference in the
caller, rt5133_probe().

Fixes: 714165e1c4b0 ("regulator: rt5133: Add RT5133 PMIC regulator Support")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/regulator/rt5133-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/rt5133-regulator.c b/drivers/regulator/rt5133-regulator.c
index d0f367381fbb..a83a595c0609 100644
--- a/drivers/regulator/rt5133-regulator.c
+++ b/drivers/regulator/rt5133-regulator.c
@@ -510,7 +510,7 @@ static int rt5133_validate_vendor_info(struct rt5133_priv *priv)
 			break;
 		}
 	}
-	if (IS_ERR(priv->cdata)) {
+	if (!priv->cdata) {
 		dev_err(priv->dev, "Failed to find regualtor match version\n");
 		return -ENODEV;
 	}
-- 
2.47.2


