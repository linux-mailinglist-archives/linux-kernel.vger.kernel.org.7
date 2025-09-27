Return-Path: <linux-kernel+bounces-834926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 470BABA5D93
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 12:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91B322A6D84
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 10:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09362DF3E7;
	Sat, 27 Sep 2025 10:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0tRh976"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDA12DCF52
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 10:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758968401; cv=none; b=NzYU2L43FNFxRECQyf+OcgiNWlFQ5ee9JDOzKP5ZgCikVGGn8SlwOXYtqcosvFw3qTmeygnS+uAcTw3JUyAIJjsrh8+cXLc5SH3YCQdgrOgiZ8L/nsF110ShZUhmix0eP0LdkWhM2h2NKxs0vquzCZzVopswWAI/nZ4L2DglDP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758968401; c=relaxed/simple;
	bh=vEHdMu4fZDG0pv0OrxT4yCsQ2r9RoDo1W3KJXPI34so=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SrzETHC8QQVoSyHvMQzxYOlWYTaHdjsV0INTEPpJA8/iJaS4oqJ9HzorsOWPuDCmrGEAE69PJ6ljCtbU7AT7EJOLbEr6LhvY5+1/Zk/J/3u5I2e2I2Da6iaPIY3rp83BtvwTLfbGoL5bTxUplYe8LNODpGpDTk/FKNKhxeTkJ7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F0tRh976; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b9edf4cf6cso3036059f8f.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 03:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758968398; x=1759573198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rVYljPZ7zSakciHIair+w4BKANbFUIx4H7fyvtM/0P4=;
        b=F0tRh976BZ5xb+VRYPxhpmSejlxQOjKfJVJLJhcMffxMcaAnBfPbghveIDhEb6A/Vj
         rolAVWhJfbYlTzwzyUzHkMWrvnSH74wDlNxjtyA8cLJId7LfZUqgm8cx+Z7gNa53o3T8
         k1FywAJlWGvbKBv1EDizPm5hqZGK5yUtHVTZhriYX+nIyBnfioXbWEva9IWaAg5DB0C4
         GVCIDazAkS3XQlifiVw2HoR6emLRQXm8B1Xr25iSZsrxWS+k4DmHmV0JYCrIzgfPK6hU
         IfhsO4vYNhmoKVXON+YMREKcrhAUr/f1AZZ4fhry4eMNW0DHUPZWl8EbqtRHr0t0Undt
         TZjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758968398; x=1759573198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rVYljPZ7zSakciHIair+w4BKANbFUIx4H7fyvtM/0P4=;
        b=jHYSdnvnRlRO0VSGnXhPsOOhDwcz2T3fAznzdiMLU0IBC2o8f4XT11RL6zYqV13STm
         5JC0a3wWGxX+X0+SkyK14K7zUruDsSSABF1WY7hT3Ydk4HsIx0CRsCmhQAbKtJ+NKTsZ
         H/wxnJNqYs7jmfNwnUC1MZgy4mCI3nM0ezB4m+USxuf36X0z+eibM3EoixtfGF9FKAWe
         QovIWIZbf1TKMnQ+X+ZQEeqkuXBPLmlr3yDo3Rq9PSdzJXOvkPG2iw/ycDpBlRlcvfr3
         aapB/t1IGOgYKsDLIrh2qnALrKeEUMWuU9edsusnjUIR0Ov1BchNzftlfidb75KgV3mc
         Wacg==
X-Forwarded-Encrypted: i=1; AJvYcCUAgIMTcegv5Skldp1mR4VVOBvXZcZk/Gi/8zErmbgUTrEqeMVojW6/NdhS1LjlHyXerUxzUitkszsYjI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmP6GYW1TAQJaH9OMdua4oO8H08NC2UusSPMnFpRDxsew/u9ZA
	Yi1GtNKi01RxznCnGb+Otix1HFuqmLLWxp74l85q+imoY++rhw/ZTQgo
X-Gm-Gg: ASbGncv7HgxpzvuRpxDbuKtyjm71DLuHfpwEKy2T8sIFCR3W+6TqZlUCfMRoV2irwVA
	Ayod+ntbLUxgBqqj+59EMFQqcjadQrrwSNNE/DAaa3jPTmCxVkT+BOdaxusQnmV/9/OZ8YY0LF4
	jB8yM96yXrFJp/q5lMjwXmxppUP1UkDbJfbid62Z++s3X9tFs3QfssirJJB5EYOYoBOlObYnb0t
	BBMFyruNVa9V0Q7orCGASh3r2Y3QYUqp4sgPvG191Kk1NRnIat/h4YaSzLSWGBYu4au+5mWXCaH
	8RuVF0eKe+n93Bh9h6zSEkvU3OasCEBYPMDkmca3rMd03PR7aEi3kYwhWglBbLORLs1gD0UEVy8
	PydmTyeSJaVujdeORSkjxxzjeW19gxkmg+Lqz
X-Google-Smtp-Source: AGHT+IG/vuR/CAo50CO49IE9FciQlvcGqdjye9qI1zbG5s4qjXYiiVKt3c5dUTv9WyX4imP3L+OHVQ==
X-Received: by 2002:a05:6000:26c9:b0:3eb:5e99:cbd3 with SMTP id ffacd0b85a97d-40e46514db2mr8969382f8f.2.1758968397541;
        Sat, 27 Sep 2025 03:19:57 -0700 (PDT)
Received: from builder.. ([2001:9e8:f11a:4416:be24:11ff:fe30:5d85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e32c31df7sm53416435e9.4.2025.09.27.03.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 03:19:57 -0700 (PDT)
From: Jonas Jelonek <jelonek.jonas@gmail.com>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>,
	Andi Shyti <andi.shyti@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Markus Stockhausen <markus.stockhausen@gmx.de>,
	Sven Eckelmann <sven@narfation.org>,
	Harshal Gohel <hg@simonwunderlich.de>,
	Jonas Jelonek <jelonek.jonas@gmail.com>
Subject: [PATCH v8 7/9] i2c: rtl9300: use scoped guard instead of explicit lock/unlock
Date: Sat, 27 Sep 2025 10:19:29 +0000
Message-ID: <20250927101931.71575-8-jelonek.jonas@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250927101931.71575-1-jelonek.jonas@gmail.com>
References: <20250927101931.71575-1-jelonek.jonas@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the scoped guard infrastructure which unlocks a mutex automatically
when the guard goes out of scope, instead of explicit lock and unlock.
This simplifies the code and control flow in rtl9300_i2c_smbus_xfer and
removes the need of using goto in error cases to unlock before
returning.

Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
Reviewed-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Tested-by: Chris Packham <chris.packham@alliedtelesis.co.nz> # On RTL9302C based board
Tested-by: Markus Stockhausen <markus.stockhausen@gmx.de>
---
 drivers/i2c/busses/i2c-rtl9300.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rtl9300.c b/drivers/i2c/busses/i2c-rtl9300.c
index fb3ebbd46a18..c67463228604 100644
--- a/drivers/i2c/busses/i2c-rtl9300.c
+++ b/drivers/i2c/busses/i2c-rtl9300.c
@@ -72,6 +72,8 @@ struct rtl9300_i2c {
 	struct mutex lock;
 };
 
+DEFINE_GUARD(rtl9300_i2c, struct rtl9300_i2c *, mutex_lock(&_T->lock), mutex_unlock(&_T->lock))
+
 enum rtl9300_i2c_xfer_type {
 	RTL9300_I2C_XFER_BYTE,
 	RTL9300_I2C_XFER_WORD,
@@ -283,11 +285,11 @@ static int rtl9300_i2c_smbus_xfer(struct i2c_adapter *adap, u16 addr, unsigned s
 	if (addr > 0x7f)
 		return -EINVAL;
 
-	mutex_lock(&i2c->lock);
+	guard(rtl9300_i2c)(i2c);
 
 	ret = rtl9300_i2c_config_chan(i2c, chan);
 	if (ret)
-		goto out_unlock;
+		return ret;
 
 	xfer.dev_addr = addr & 0x7f;
 	xfer.write = (read_write == I2C_SMBUS_WRITE);
@@ -324,20 +326,14 @@ static int rtl9300_i2c_smbus_xfer(struct i2c_adapter *adap, u16 addr, unsigned s
 		break;
 	default:
 		dev_err(&adap->dev, "Unsupported transaction %d\n", size);
-		ret = -EOPNOTSUPP;
-		goto out_unlock;
+		return -EOPNOTSUPP;
 	}
 
 	ret = rtl9300_i2c_prepare_xfer(i2c, &xfer);
 	if (ret)
-		goto out_unlock;
-
-	ret = rtl9300_i2c_do_xfer(i2c, &xfer);
-
-out_unlock:
-	mutex_unlock(&i2c->lock);
+		return ret;
 
-	return ret;
+	return rtl9300_i2c_do_xfer(i2c, &xfer);
 }
 
 static u32 rtl9300_i2c_func(struct i2c_adapter *a)
-- 
2.48.1


