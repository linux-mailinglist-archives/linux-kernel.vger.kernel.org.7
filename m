Return-Path: <linux-kernel+bounces-722874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 048E6AFE026
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 08:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 587D41BC87B3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 06:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A345626F46E;
	Wed,  9 Jul 2025 06:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="mDvs2YNe"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C24C26D4C9
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 06:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752043340; cv=none; b=fqnPong2wd8ZikSNDv7hAbWxDhx4pbfMiKOCYIYNviWcoSK8/AnSlNVIP6DvoeSTkxHlWtaYRqHwlrpOAw3/0EY6ygCJZchvokuyvlHtsSlBRvVlkLk39wWBuIgScXMcHwhswRjzgXGXMD6VkKWI8PbjL51FgUIJcncuvkWOoos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752043340; c=relaxed/simple;
	bh=ouX9BrmDiqk6TCgMnk7v/OMLfLFu5PRPMH88du6gFZM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PG0E64GjYBb3nFH/DEQSKmfA1Gw1T2jCvO/YHkq54Jlc+I+UQcog7l60W6mVMxi0XUmGMhfwPuSn0oYs/o9uCfe6AZ4ifcdXuRcSDIzoO4jPS1AY8JQuhUmzyFg1qh2R4F+o7CIAVKF0XyzG22XbigObTdmbGt/F6PF+v1UbjSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=mDvs2YNe; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a57c8e247cso3922424f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 23:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1752043336; x=1752648136; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hyTMiwPaXIFDdT9wyK9LGoJhG1Tf0x1zce8tP5zIQCI=;
        b=mDvs2YNe5UNPqHAUgt1SROWtduvLimN0KUHXG7nASWEQj2XmhzeH/ox5nnBa7CZiyN
         nvAdjgHmTedsy99I1N2TNfWHNUpTiPPKq/PFKrIY0q/EgfQR4URkhqJCMsTdWmX4TvcL
         t6smDA06k2WOcNub/zPuqnWC/DvY/4qtAoSyncZ+LQbZBKaTcabrd/IgtOk8vqZCOfub
         EI1gPbYlQ0QZtllp33Z5KFTGP0jvJyReTNfYzjiuTFOEKHblXZBk5jiCMmNsFHnY/f0+
         2QtL7d3tacSA5yXOw1g+sJ3ftVaGUk//LGWS7Izq1BwaoVlyruEJVQxWW7t3mYdpLWsT
         JeSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752043336; x=1752648136;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hyTMiwPaXIFDdT9wyK9LGoJhG1Tf0x1zce8tP5zIQCI=;
        b=kQA2pbq3tUTVPX6Zu13G2B/7zPALoJJn2iZkUfTs9Q1QSak2XzBnRn+AAgFzjqUDgr
         f7IuS9g14ki+R3uHzb8cq7kw974b4T1gdFcM3WIy1U7232lrRn+xx0HFgFPaHap1t1wy
         feId5cLzxk1RIvibzMBbpnEPZwHX5GkI6tTubLSLOn6iFUqPb8E4a1C2g28FwRmnPbfb
         Wtsvlk+alI0iUgoDlB8L0setp1Rt+Fzq0qo4UN8YkPWxOxlqMWmKjWxZg9Ba3u/COCjw
         BhPHpSd9UHW2FIL20zAD6Eiu+N+SsgQZGaMZ9oMjPyqH+kQnfbQNa9jcD6FxUIMdmvt+
         SDfg==
X-Forwarded-Encrypted: i=1; AJvYcCWOBPdMgwPka9r2xp3YcMcHvJfr4Y5XusT9Iv8LG+QMEtKiPvDCNPzUY/kWLopnA0LvCRkmKoTLnbUvzkc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqNS/HftjtZiXElLdLrKJuTKadWeHvIexGfBm/nN2Oe8dU+zdm
	spJkaCsOjJ1mGAL5Yh3fMGohQD3mqvzBWj3ZfHJFIMGbiG3k9xH9okc5iX57f4SYo/gW0FtEDPi
	6k94JDr8=
X-Gm-Gg: ASbGncsZkEqJYesZEoCyrCl8CV47eigg1SricCE2KY56HBYuf0U+nYx6zkI1sC5GL2M
	5RbRfm6vOOJ3Ind7rLz+d65a4Rcy9cwgmIDnAqUPgAcajQPI49er0U978bBuTRSiSIJYk2aiDsi
	JLI8yFuVIU43HG3oYVrGgsq4SFWDWmy/OLVCOXcuWC+u5wd0JB4tMzpbHKWh4Ojs+Uni05Xa5li
	sBNQYpNIXwuDXyoc3qP4NUjuRLf96KRjfSHFtW8BEyVUL2hg/5X4M63n1EQwdFC3wLClDkkCQHW
	EoeINtgjyKYuRVbhJKPPURFDn5wbr/kqPdzmrOljN1ZzfaotCcfBHVdT
X-Google-Smtp-Source: AGHT+IGg7TNxjvLn1+O4R81Nlx59R/nNeBOpFRuu+g7ycDDNSE0Rc5+slCF1F8/fhz7WHbhW52wyuQ==
X-Received: by 2002:a05:6000:2305:b0:3a5:2fb2:35ac with SMTP id ffacd0b85a97d-3b5e4513735mr899716f8f.24.1752043336357;
        Tue, 08 Jul 2025 23:42:16 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:b04e:cfc4:3bd9:6180])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47030c443sm15115341f8f.11.2025.07.08.23.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 23:42:15 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 09 Jul 2025 08:41:39 +0200
Subject: [PATCH 02/19] gpio: wcd934x: check the return value of
 regmap_update_bits()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-gpiochip-set-rv-gpio-remaining-v1-2-b8950f69618d@linaro.org>
References: <20250709-gpiochip-set-rv-gpio-remaining-v1-0-b8950f69618d@linaro.org>
In-Reply-To: <20250709-gpiochip-set-rv-gpio-remaining-v1-0-b8950f69618d@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, 
 Srinivas Neeli <srinivas.neeli@amd.com>, 
 Michal Simek <michal.simek@amd.com>, Nandor Han <nandor.han@ge.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 patches@opensource.cirrus.com, linux-arm-kernel@lists.infradead.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1112;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=L8ZxQSAM9ifx3ERmIubAxxHUaqeVMMBoWCsBpWCjAR8=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBobg9BkyVTRpVtFgtzuqceZbIliD+pMfIv+5Avz
 WnfpHrLxc2JAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaG4PQQAKCRARpy6gFHHX
 ci9XEACMfKjaNR8nzMjem5gOkjsgPOsIqsqKsOjLId25TkdZs5SuKfJpGfYzUMLAyvdz6EzeKhz
 +BVO0NSAttg1SlZWbK1NRBDLb0gmVtLckJHFgKvroRfmC20CvR9RgbjYpste6qxY4MjaUcOSMCB
 PgcLmXylfywY/UbH0C+1kuRLo9WdGpRjlN+tciP8wX/WGGMSH0q2G2T1A2k6UpjqMvpjuid46jS
 qeT/eI0rQQJDKIebX575uDlUzAHDQr14n9PZdacfFZnbO6ULsxA73IoFScDMub0rBVux/Ef8hNB
 4h0aCJBcsLlzR0S71DTRKowvDGTO2YT/FJnbHbnCP+wgN7AxaFu1vE51nPM0DS/bEUxlhMEh2/K
 1pTA2fbGPGTsWbLu1m19ldLFvpnbi8yKMuNN7bUK8fQGXrmUnoAdZ31JQE5AiGf5XvLxFHahD3i
 kz7oJaxbi2lK6jAddcQYhhUHgc64j4g3itiO5aTLD8wm0RC/LJJGewpiHCmhF4c5Pq9vJEhyWJk
 DyAtPi8a+mVfMS4jOaiivSyUcJxbfj3SaV325zRHnLB+PlT7rS/AOqfHjdehW8/i4qyykTODAno
 PwahK+QW+f6E8ujYx2aLajZ8B6FeRKDJfOBWL7AP5iAVRxwg+xzCHD6lgFtOHkAiCdkH+7FV4bZ
 lyMAXxdaAag8xjw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

regmap_update_bits() can fail so check its return value in
wcd_gpio_direction_output() for consistency with the rest of the code
and propagate any errors.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-wcd934x.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-wcd934x.c b/drivers/gpio/gpio-wcd934x.c
index 2bba27b13947f14459c32db4812f6451eddbbfe4..cfa7b0a50c8e339603bc5fc70a8d7354f3bc6486 100644
--- a/drivers/gpio/gpio-wcd934x.c
+++ b/drivers/gpio/gpio-wcd934x.c
@@ -46,9 +46,12 @@ static int wcd_gpio_direction_output(struct gpio_chip *chip, unsigned int pin,
 				     int val)
 {
 	struct wcd_gpio_data *data = gpiochip_get_data(chip);
+	int ret;
 
-	regmap_update_bits(data->map, WCD_REG_DIR_CTL_OFFSET,
-			   WCD_PIN_MASK(pin), WCD_PIN_MASK(pin));
+	ret = regmap_update_bits(data->map, WCD_REG_DIR_CTL_OFFSET,
+				 WCD_PIN_MASK(pin), WCD_PIN_MASK(pin));
+	if (ret)
+		return ret;
 
 	return regmap_update_bits(data->map, WCD_REG_VAL_CTL_OFFSET,
 				  WCD_PIN_MASK(pin),

-- 
2.48.1


