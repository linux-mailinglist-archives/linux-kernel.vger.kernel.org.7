Return-Path: <linux-kernel+bounces-615944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CB9A9847C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 10:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62F9444299B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 08:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCD0242D99;
	Wed, 23 Apr 2025 08:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="N3Zzl0XY"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126511EFFAB
	for <linux-kernel@vger.kernel.org>; Wed, 23 Apr 2025 08:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745398557; cv=none; b=FR0B9hCFyEuiGKEcdeN6Ptk/ds6l53RJSeux7GNMUL8pHNcstEFc26Sd1gT6ruBx5c6yP9y7CeS803pqpdKNbEJaIaTMkxPWxCRA5+y7gkcicVvq4CvK++WaUeeOOr7vcL7givWikBPZevIvIBLPmmc82PIFYPK26+wRrdyNoI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745398557; c=relaxed/simple;
	bh=Gu/0qJDe/6CF3S+aMzTZR6rxmUbFtqhRKTSk7r76mcM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ubFdiU1e0SmPxVx4CQ7flAZlcKRP9TQ+T3IOwYDSjFi4/0cDEeBDynqPpT+ZG46IQofoGJ8VWYb4i4X3Bds+MfVuZLh/zTXj9ECvJj8AxYMHBjPgHtuwQbVVcf0DYMl70GxXJpv6sx8dzlx6Wm6oVV3ZdjFHlcCKdm7EuDL8Lco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=N3Zzl0XY; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43ed8d32a95so53286595e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Apr 2025 01:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1745398554; x=1746003354; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ccxqgGOTjGbrDoOEv7tkVOvhfhH/R12HzGiWH67Hg20=;
        b=N3Zzl0XYCwA5c2V0LHjxQP6WwN2xX1k73W1bQ/XhiLp5mRgeyuIlPg1ZYHkvV2aCUA
         vNyVsaSDDzlsX97p+WFi8xm2WADcxg8H5UHkD7qI8DIJ/+Vm2X/m+DVcply9Nxq5XUne
         bDJtFEZl5FGMNhQanD6c0pdV6gsGY9xN27LnnKAhzui+W5gBIA9HjIcKIdnGPt6uqK0o
         F121ZpmaX6XPAjhWwwxTGJsTApAwyFRYCaL2+w9z7MYm7rBByyX+d+t0ztTOQdMQ4jI8
         Zu7aDWXGZJyJ7woTjlrh/K6W4PnmuUZQepCiD4luK0K9nZZ4sPz/Tgxw9OfMyu1uo9GL
         UXCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745398554; x=1746003354;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ccxqgGOTjGbrDoOEv7tkVOvhfhH/R12HzGiWH67Hg20=;
        b=gyYWuphVmrv/vFKMP6C/8pHRcTm46SDVCvTF6meEDO/HaHON+55no55H4y0IVbsGrQ
         lqD6ZQ6NGQp5hpq6cATu9o0rDo1HJxkTUKfTpmRRE5l3BwZE++P3s4Wn2Fh6Dme8SALt
         4Ja8rUCr0/DCitnDgEG5pkRbMjtDHu2JWmWvnkVD4aOHSMg01zWBrAgp/uFfCUNE48lB
         IhMmLRLMmDj7FWOl6dAtVwKf40dzKseb1pnnQvZqm1m9tDFY6PnKoNGb4QojQbXVg+Wo
         V6QdRCJIQAu33jo3B3Jn7eqVoUh+h+TmLmq4hSM5sGvBju7iaH+3bH1FP4ISYA1sO5o1
         KceQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2a9CxEK/uAN+gmrr73dUpnIt2sf9zyjsWrUKKs8OO05SQkvMaAfeuW+qc4VddOkwXDc6rirVT4FKXFJA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+fjTfoTZXYwcbnoZAwxUIxwbdgs8DYpLwAFVEedvSutU3JqeW
	ScHNeptP7Vbel6bOLe4QSFDSnjCPIKDunR2wYMDyCTuzcqFJ2uKj2RhIPCtMfDO6Iq7Az4yMce0
	v6UE=
X-Gm-Gg: ASbGnctR9nBAehxK7CWBH7cLDqU2VYlNZk2E0QQCiRpyc/R9FMaOU+TQSQVSW+NkpcW
	AGyICS6fG93CovXc40rknSNnvhGGjfCKTHkyaw3ClKe4Zxe3tDT/fKejWYI0bcy0/6rxs9eIFCk
	7gaL8Ock+R+4vVC13wnpfRd+vG71D38NpQRI7bXd/10VhOiQ1k+WkBOkgh9zYHRpX3Lea2fIUTP
	VYykc/ZaVYeIQmCpZp9tw87MfnOhJNIfV+gy4FjK9TfnbslgHjtvjQCct05NmscM2l3EDPDbtal
	TCRqWeDbSXFUXGPDKb9hncKiDhopjfruvQ==
X-Google-Smtp-Source: AGHT+IGYt9KIPNXopceY/Wz7BYzncJa/dJtRXyS3DNCe3z15St7GRiEUgi4k0Frpx7QsgvxF1rBmfA==
X-Received: by 2002:a05:600c:4f81:b0:43c:fa24:8721 with SMTP id 5b1f17b1804b1-4406ababec6mr187469325e9.17.1745398553910;
        Wed, 23 Apr 2025 01:55:53 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:74b0:71bd:6dda:dcc1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-44092d3654dsm17731685e9.28.2025.04.23.01.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 01:55:53 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 23 Apr 2025 10:55:44 +0200
Subject: [PATCH 6/6] hid: mcp2221: use new line value setter callbacks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250423-gpiochip-set-rv-hid-v1-6-2e6762b582f6@linaro.org>
References: <20250423-gpiochip-set-rv-hid-v1-0-2e6762b582f6@linaro.org>
In-Reply-To: <20250423-gpiochip-set-rv-hid-v1-0-2e6762b582f6@linaro.org>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Rishi Gupta <gupt21@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1645;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=MEE5NFlP4KmtuHYj7k9R+CBXmokE3edPEZ0O5ma2pfA=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBoCKsSH/VXonHZEwN/oJAifE3FFvtTpHXFAVsbR
 csNJghfdFKJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaAirEgAKCRARpy6gFHHX
 ckNNEACGFETGqtGc03ttguBEngNRxDLdl4o8bT8wLRRMmsuoZ7GwjeYdR7gJzGUuauyvr25iefQ
 WIJtXrAVJRGdo3ywRWDoAoBkcIhBzKODekM+lLb+TfrxGNihZhZc+poRmZP5NFXpbEUNbG/7rLH
 o+d6KjzKpZh5ScEUwdxphZbuy/OQCcKiIqsxL+Aw32s5oCgFmY4rbuy33ayIW0sfiOTu+r5wTHX
 ud079wGcIS3vwNbu3mSi+86C9yc8OJHpk/3D5aHB9QuR8apzjwfliXcCIPAcdsUctVF3OvhbIYq
 XIpGPy3Gj8AYcg5dvQJRPCLnCS2RHjKBbCp+Iy7tnzwletOS653KSQgAd2GNZn1sQ3RYxPlRjjC
 ARpIH0Xhg5iqg6NCcMfVMrheL1rtNIZdYE5X42rtaIKNRkFTK2ieKSvQ5uVZDCnsjhdtmyiM1Iv
 WZAZQ8s3HJ7mG6nSwOxPce8mQdpuPYPCiAo0kIsQ4a1e0GRwFUdv7eZQq69eVZ6sWE+ZaddPBA5
 NBbV04I/8p2uMrWzHVYb3o1TLsOE3lXREZcQJr0GLIoIxf1Dp/JEfq+BpQ0iTBgmApdrGX8qn7M
 VKWBDRmRvogkCjJx5HfdhzECCJfcL0HQoo1IF+b4pJFVv0uR9Bgao/miwdPHi2hRs8e6E/W4IX5
 H7aKMrZNAetOhtA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

struct gpio_chip now has callbacks for setting line values that return
an integer, allowing to indicate failures. Convert the driver to using
them.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/hid/hid-mcp2221.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-mcp2221.c b/drivers/hid/hid-mcp2221.c
index 0f93c22a479f..6c0ac14f11a6 100644
--- a/drivers/hid/hid-mcp2221.c
+++ b/drivers/hid/hid-mcp2221.c
@@ -624,10 +624,10 @@ static int mcp_gpio_get(struct gpio_chip *gc,
 	return ret;
 }
 
-static void mcp_gpio_set(struct gpio_chip *gc,
-				unsigned int offset, int value)
+static int mcp_gpio_set(struct gpio_chip *gc, unsigned int offset, int value)
 {
 	struct mcp2221 *mcp = gpiochip_get_data(gc);
+	int ret;
 
 	memset(mcp->txbuf, 0, 18);
 	mcp->txbuf[0] = MCP2221_GPIO_SET;
@@ -638,8 +638,10 @@ static void mcp_gpio_set(struct gpio_chip *gc,
 	mcp->txbuf[mcp->gp_idx] = !!value;
 
 	mutex_lock(&mcp->lock);
-	mcp_send_data_req_status(mcp, mcp->txbuf, 18);
+	ret = mcp_send_data_req_status(mcp, mcp->txbuf, 18);
 	mutex_unlock(&mcp->lock);
+
+	return ret;
 }
 
 static int mcp_gpio_dir_set(struct mcp2221 *mcp,
@@ -1206,7 +1208,7 @@ static int mcp2221_probe(struct hid_device *hdev,
 	mcp->gc->direction_input = mcp_gpio_direction_input;
 	mcp->gc->direction_output = mcp_gpio_direction_output;
 	mcp->gc->get_direction = mcp_gpio_get_direction;
-	mcp->gc->set = mcp_gpio_set;
+	mcp->gc->set_rv = mcp_gpio_set;
 	mcp->gc->get = mcp_gpio_get;
 	mcp->gc->ngpio = MCP_NGPIO;
 	mcp->gc->base = -1;

-- 
2.45.2


