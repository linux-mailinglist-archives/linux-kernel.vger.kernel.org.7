Return-Path: <linux-kernel+bounces-860236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 162CCBEFA40
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3DDE3E482B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 07:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D42D2DC330;
	Mon, 20 Oct 2025 07:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6NYcsYD"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351822D877A
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 07:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760944681; cv=none; b=rPuIED6kSBJsZl+xzI3KhPJs0QXNMy2oE3lWkFyD0g0nBfSN6hECcFbUkRRlUdfV+CTLmMLyiq7sDYVDxWJ+0fHb4IrFDE6pGrmPYlZbA9VA1KwI06h0m80M05FsYzrhG0trG2wqoVEbVLx9FR2f2cEHa/pq6JJFzdHkkw4Zrf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760944681; c=relaxed/simple;
	bh=5vuOIHtLq7CFaEidcZicx94qxk7qZlaIZNjnBzwUQCQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZIUApufSLJ5x3ZdKM4tlbIjc2idHsU1RHkLgXQ5Gfnt0l7WDa8oZhViz4dTOskunfEqFKAmhs8AnZ2s8qs756qJ+95OVOlYqlzNZrxqRI2SquP0l7Yb2LKeiftB7L6rqmoAxo8QjJiUuZeR7mZXSm+gKNlUnxzoHTa/34oq/tBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f6NYcsYD; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-375ff2b3ba4so43826121fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 00:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760944678; x=1761549478; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lFWIsHcR+hD5XAKLrrYCj9xMsNWxUYwTXzF4H7urqUQ=;
        b=f6NYcsYDfqQXcUFXxSKmX5xIqxdRWlHLi/to1+Srkt+Bb1urK1Dq3WssOlDf9yrjwE
         Cg0Rr7m3e5LydZTXAMOhNVgUaWn+ZP+pq5U433vfg25tOnmtQMutfbJf6qpmVt0Nd2dt
         q+CRCDyEI+rIVP3ZsmD+9cAkVwq/qVEtBmsSUlwyL5yB2HaWvwVbYY5GcKWokr1HrHDI
         aqWurkrCuuvrYhsEdaerhoN26SmrkDjaWoBeXbnNG3/m30RoNhfmrqYEso3BUB8u7gCY
         hPtxZti4HM/S8M+iGOC6nEHUi4uwhnwIC/4kOXp38zsSC86AUBY9MlzElDDGh67x4q2r
         lDww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760944678; x=1761549478;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lFWIsHcR+hD5XAKLrrYCj9xMsNWxUYwTXzF4H7urqUQ=;
        b=NBQhkN9jjvVCkzKNC5Y6EsmqSjVa4mTqCefHU3GCKAmewgUZQ9edgujKJDXD7FMYRJ
         KgtBGkTwnfP+NaLL//JRtbj61KtolOFjgIf/1z/stUCbJQyDxsO+Rq3JWFmIvK3gGOYl
         wQVRO0c2oLbQYcY+zqPspBIr294VNJzqSjzOYp8I6WnJ7ShmKpgqjIBH+VXHnuGcIlmt
         pfJv2e3G+seoGd8KF15j4uNZZ0+Q6AD+c/IoxrE8YvfMzBYv5Ax1L06i0KCbzwu1CNkf
         ZOKR8K3OBoF11o3gaZ7VuAczo4zPrM4gKJdvrlPX8iE4vewNf9pTaX6KOdZNaSPIxHnS
         Y+Hw==
X-Forwarded-Encrypted: i=1; AJvYcCW58BnyvRHyGbPr3oU9tWN1BLIUcYs9Cb1pm1nYJ4DZ4bq3VLe3OJnpzTbOjS5T8KcCc5k2f+i1hWOAo6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyayyZiUbDA4Nbnnugp48YGlYRPGMebz/qmLm8VSWAezlCmywXb
	g7KkKRGucEKd+VDfHnFKWc/1Vj9MLRkkwX0B8QmFaAsuySKRHYEwyMkb
X-Gm-Gg: ASbGncsiujJufvvKn92fydboDU9OwixrxYCFi6sVguzmor3+gQqLoUcqk+FTWiy4IW9
	WefbqtPMieQtyuhkzwhojCvnjB/w4r+LYKooSCYM+GelIEOqD31fDTOF32gAboRuulDU1aSUPkH
	QFPa6uuugX9AXpbscudMy5gpTOUFNqexzfGnPANaa+c8akyk+AMCs2MEsFdwH5/vpaPG2CrKoPf
	aYzdnnOpYl3FWKUICRQvfWq6aTTXlOvxy9zApaZ12SkbDmxig9bj3LtT0EX9XzXF00kVBPS5nLN
	7FVUsH7YnEMcC2cQtbqvA/shnb7HRD9NuHmCZnPicLyQhRHshDrKwz4cyXTGZlZZBrdJPp4JuC8
	JQ9gLaLFtMkP2Vqtp9gjft4O+BVkcRpu2uj4fVKuiCgJ2V6UoEU1sbuC7ZYXkpq8YV3M1QiSir2
	DGueLbMJMHmehOA3p8BeeZ39BGzlOzzx/egs8tGVDy99jgwJoEa91J5EY=
X-Google-Smtp-Source: AGHT+IHXByz8VitGJjgs3nH3R3vZgX618KuW3LJgEm0Ki4juvIMqSu3YilgibjYpLhrcCwdymQlHCQ==
X-Received: by 2002:a2e:9a0c:0:b0:351:786c:e533 with SMTP id 38308e7fff4ca-377978ab86cmr37067571fa.15.1760944677919;
        Mon, 20 Oct 2025 00:17:57 -0700 (PDT)
Received: from [192.168.1.168] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-377a921ae62sm18863341fa.21.2025.10.20.00.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 00:17:56 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Mon, 20 Oct 2025 09:17:24 +0200
Subject: [PATCH v3 1/5] i2c: core: add callback to change bus frequency
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251020-i2c-mux-v3-1-908ac5cf9223@gmail.com>
References: <20251020-i2c-mux-v3-0-908ac5cf9223@gmail.com>
In-Reply-To: <20251020-i2c-mux-v3-0-908ac5cf9223@gmail.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Peter Rosin <peda@axentia.se>, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Marcus Folkesson <marcus.folkesson@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1672;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=5vuOIHtLq7CFaEidcZicx94qxk7qZlaIZNjnBzwUQCQ=;
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBo9eIJOGymSysyiJWdt2FAXU9oW4MmgLIfe0XX0
 4y5pTaPSXaJAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCaPXiCQAKCRCIgE5vWV1S
 Mr39D/41YR5hxoU0Mg4dWKd+5pjXIF2UTG5GSN1R+tXLqNmx2OdXPIGIkovXdgmYHUjNa1tBR90
 2giVBkbZLDeXNYYQEAUtm5qvpvp/8usQxSjjP+uFPF/Aef5wokgaN7AgzeMxOzJMlHRgyJSrmzc
 wm7Skn/P2U/Y3s0fhc4oMR0yGN6CCtb28h5HEffgwi+MwgA3n791Rj9diEsokY/SgcgLR9hnk7Y
 S0/0lnkOvOHPAg4OSGYFTvHPTYilRhk3zn+7Z0oci8JYkOqafe2KPBn7z/+DJBZxLcQEUNENxKY
 RurpcfSDe4KfwHPWM9KZ3XU2S6gkt2cslYH5n575XjBwSy/MNYAGKNNbq0eg5z7S/ytUNniCisz
 f+O0QFKJyuWIo7KQMPoIxV6eGDqigYV0jgbcUP3+j4oC22UcCW70PFwFjBJPbPSF0A/UYefzf+z
 B49NvCs4Aa+xMUfz8w3jC1xOPHwvqKdxEWXzwJQRSO/JMrybif7ugMEqTYcmzigjajTUKgbTwJH
 Z+FgOE0KSUurN3H/H/6Ugsn6B1IFZAgxzvF/XxoVeeCsXIW0pnYP+xETiiZ+oJExzpC/2K6gc3v
 16WDV+P0PNZf9SBYt9hCcR5z9uusyMHsSjJwL8l+0JhkikVO3sS0nm0mvVVtLIxuhFB7ClWb3US
 eOBtKLUftn5S49g==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

All devices on the same I2C bus share the same clock line and the bus
frequency has therefor be chosen so that all attached devices are able
to tolarate that clock rate. IOW, the bus speed must be set for the
slowest attached device.

With I2C multiplexers/switches on the other hand, it would be possible
to have different "domains" that runs with different speeds.

Prepare for such a feature by provide an optional callback function to
change bus frequency.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 include/linux/i2c.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 20fd41b51d5c85ee1665395c07345faafd8e2fca..d147e388dbab27966beb4dfbf869928b429e082c 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -742,6 +742,8 @@ struct i2c_adapter {
 	struct rt_mutex mux_lock;
 
 	int timeout;			/* in jiffies */
+	int clock_hz;
+	int (*set_clk_freq)(struct i2c_adapter *adap, u32 clock_hz); /* Optional */
 	int retries;
 	struct device dev;		/* the adapter device */
 	unsigned long locked_flags;	/* owned by the I2C core */
@@ -835,6 +837,17 @@ i2c_unlock_bus(struct i2c_adapter *adapter, unsigned int flags)
 	adapter->lock_ops->unlock_bus(adapter, flags);
 }
 
+static inline int
+i2c_adapter_set_clk_freq(struct i2c_adapter *adapter, u32 clock_hz)
+{
+	int ret = -EOPNOTSUPP;
+
+	if (adapter->set_clk_freq)
+		ret = adapter->set_clk_freq(adapter, clock_hz);
+
+	return ret;
+}
+
 /**
  * i2c_mark_adapter_suspended - Report suspended state of the adapter to the core
  * @adap: Adapter to mark as suspended

-- 
2.50.1


