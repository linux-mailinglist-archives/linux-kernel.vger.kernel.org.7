Return-Path: <linux-kernel+bounces-722890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B29D0AFE05A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 08:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 323C47B5061
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 06:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519012820DB;
	Wed,  9 Jul 2025 06:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="lXfHQojA"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E56276041
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 06:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752043359; cv=none; b=SX5i33HFlp8bAmbZfCdCggutsF0e/JQGcJ/gGz0ikcdp4Cbt/b0APy9U4cxr8UglXxWim/e7C2q3vC5DWCeVX/5xH6LOJsJCVQiq8QeQiR1HfGs4TbbU5qB8JP3nRoTG+BbCxqrVwfcF5CBPbc3qd6tg8iXBo20V3dLnvxu83sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752043359; c=relaxed/simple;
	bh=ue4Q4JSq5Ul2Rj1GyOmeAMlOMS9PP0+lWjHpADFV4S0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eb5qLZk9973kOQDflzphtcdmtLxEBAJ7VzIH70H3VeKpnm79iGHlf/5jLsPiyFQG1KRn8682Qaai6b6HWxWyvUN5Eg8FPcmm+7mZSvaSFl5EE+wJ4f0hDKVR2URUdtWrEu/j1mEoEcBkDthH2k6Sd274ywjKcL1Ewxq6Mh2FHY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=lXfHQojA; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45363645a8eso35981295e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 23:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1752043356; x=1752648156; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8kni8rM9yohp8QWkfPh22xACO4uj977q/kgFbK4r1YI=;
        b=lXfHQojANU+XbBQ5yeRDkE3wxyF9v4fsmHNgYdJWxFjVYyVPbjBOVl9wu2ZaPbX69o
         4TVavaaGL1Il0NYpSkEaaiduj+eJqglvMWQv7Xr8kB7IFEgYBf+J/jCGbuhvpX6EphhL
         4yhM1SgzmciDCGHkJjWAr9sXS0wlb0W2R/Stk0yU2DtHAk7RfebuK40eOElMPAUkE6tB
         Ps31Nc2g8ZoY7urGx2ZiVvM8eGfiDKeUL2nlgKjoyTm7Dfwb7SYkVjAaxSNvE8CkIRaN
         Oalz0z4J2qRtnRrJhXLAwvirn2t6zTAt1Tcu6HTjYsY5+KqCQdYO1CtBZoC8s4kxdOu1
         oV2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752043356; x=1752648156;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8kni8rM9yohp8QWkfPh22xACO4uj977q/kgFbK4r1YI=;
        b=Rx6JORjGNZxWsIAAxcjVoirZhUK95ElzWqQRkhJMEqpjMAYLMjhji5dUJ54ZUg6x/X
         5mbU+fHUnzNU7CmogbTu9s2OfpDESOKEVd8xeOPYiWQ20WM/jnEm2JUTAmeT3groyraU
         dUYOC5SSKcUw1WO8YZ38ugW75zRlN5uNQpmhE7Lb8d3ervoM0h4jP+bBi4NmX0RW00hq
         4hweZU5QWhIRSbfOZog/mybE68NGIFi2AjA9UXqc56t9FrzNsEXop/T6tyToTYBObG2w
         DAELzvVLLrJnPeUIzD6Cjfad7i+QKHZqyAAQuCBOBslU+flIGnGGno3LyDdQbKu7SdiE
         tYlw==
X-Forwarded-Encrypted: i=1; AJvYcCXgSNTtl1AXwI6pxo5lvUCb3n4qDQjHGeSaw3JzABc7fhUw9Qv9sVv0QiIwRPcYkGtoDQA2V90I2Lpl0lE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS/zo1PLte28PfVxVkRoW3T/+RU53iYTIBEVOzm0NZVLYg1JQi
	MytdNyiKyt4vErxOmMBmyOd/fHyNQ5kCwTOtUH0RFYgRLBRUXVL7A9LxV3vlBHI1F99k3LnOuvN
	D+H1BdCc=
X-Gm-Gg: ASbGncsBqbl08VOhbgr8Gy2rQni3C4juUUe7ElGOhKBrHvNAce7wLaJdV1j68kckrpQ
	fNq4GIHJI1chQnha3tusJOr4C5dKukKV3RD567ILEqjUz5aL5EfZ/Qh7nw1CSAIO+LwMrzr5+Me
	golGRdHidXDkbocAk/rgl4wqPBv/9plnJDrIf24XymShnRC0NNQVQAQhS3zUjiApL6hgOkN+G05
	mzMwIUf10C5kbSn4eegrb/W4iwZhJv1wq19MWrbSaccGz+dpgwccdF147ISuIz6X7kXJzv61i46
	7O8pEgn2heu6min4BhDPvVyjX2+dMECwadFuQ4Kgf8MtQhdQ6coNC+pG
X-Google-Smtp-Source: AGHT+IHIVDR8rddjy7RV7ZbbuRADNMRvR7rlZ3ZGeS34S5+8FSs5H/zQ9GNc4Gl4e4fKiYZOjpN+wQ==
X-Received: by 2002:a05:600c:a205:b0:442:f4a3:b5ec with SMTP id 5b1f17b1804b1-454d60d5911mr4376595e9.4.1752043356135;
        Tue, 08 Jul 2025 23:42:36 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:b04e:cfc4:3bd9:6180])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47030c443sm15115341f8f.11.2025.07.08.23.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 23:42:35 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 09 Jul 2025 08:41:55 +0200
Subject: [PATCH 18/19] gpio: zynqmp-modepin: use new GPIO line value setter
 callbacks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-gpiochip-set-rv-gpio-remaining-v1-18-b8950f69618d@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1623;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=+dlpJ7MrL9mChGkl+8FCGhAb1GH2Nl9pZqi9frvclsY=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBobg9EIIDF+vQFIBY/FkMRWNfVSiQi8ty3QWnmd
 cjFnFvQYtSJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaG4PRAAKCRARpy6gFHHX
 clPBEACMBKXxXtSp4qeKszk2Sd0wYBkrTcQuFITgefg2aEjcU6z3wTea5FGrGxYLY1iEKuLKns+
 NjQeqCxgmAjXhA1LBhrBIDzgm3sYdDMmtr48b94aDG9ScZ7vJh7hgrN2kQc+EYMffrny5Wb8Rth
 QjNVwAvohyPCTbIftFeluuGA6qGfaJJqemgxG5epESDeFUpPdCl7K+VQlvnp6uhhJhYHCWIQ1Wp
 /ZJuc0OpW/BkN1iupYZbViczjN3FQkMF46nSIcDbKjNSuCSuOSylyQnwiFOF/UtvLyiYjVFj43D
 Rq6p6+XESNN9CWXhhZFqa0HjTzYFsxFvFe2vDDMZQ5V2j9eejb9loNSTvbhVHCFzjL1MsQ63a2a
 Gto8Oso+5bXhEQlisxE7NrdOuAh35t+CqaJQPGeIblmAXKV/NdsuDLGdC9JwcxwcGT9uvTf+JOB
 FhVvS9Y+w18azSeTEDk9+cFOJ880GEeFAv65KYFswQ7nThM3Lmuwp7VSDPao1oCxs8ONbOWN2ZM
 q5cLeddMK794+Ji2a9dTcSQeXysGXzKsFw/s12dVTglazmDEbQVLKZ19bCUnNoXEYtkBCEWm/bc
 4LcwaoW33Sjd4Nhz6QAkD2D52MJUAvbpEepkQL3tD+eX3w3KSeKZAoFv6GrWezD0W5SdgF8dWgV
 cE5aGyuT3IERIYw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

struct gpio_chip now has callbacks for setting line values that return
an integer, allowing to indicate failures. Convert the driver to using
them.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-zynqmp-modepin.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-zynqmp-modepin.c b/drivers/gpio/gpio-zynqmp-modepin.c
index 2f3c9ebfa78d1d6bc4624a614c316e4fbeae2aff..36a547d6fc5a5c100f81c72600e14d620a462cc5 100644
--- a/drivers/gpio/gpio-zynqmp-modepin.c
+++ b/drivers/gpio/gpio-zynqmp-modepin.c
@@ -57,8 +57,8 @@ static int modepin_gpio_get_value(struct gpio_chip *chip, unsigned int pin)
  *
  * Return:	None.
  */
-static void modepin_gpio_set_value(struct gpio_chip *chip, unsigned int pin,
-				   int state)
+static int modepin_gpio_set_value(struct gpio_chip *chip, unsigned int pin,
+				  int state)
 {
 	u32 bootpin_val = 0;
 	int ret;
@@ -77,6 +77,8 @@ static void modepin_gpio_set_value(struct gpio_chip *chip, unsigned int pin,
 	ret = zynqmp_pm_bootmode_write(bootpin_val);
 	if (ret)
 		pr_err("modepin: set value error %d for pin %d\n", ret, pin);
+
+	return ret;
 }
 
 /**
@@ -128,7 +130,7 @@ static int modepin_gpio_probe(struct platform_device *pdev)
 	chip->owner = THIS_MODULE;
 	chip->parent = &pdev->dev;
 	chip->get = modepin_gpio_get_value;
-	chip->set = modepin_gpio_set_value;
+	chip->set_rv = modepin_gpio_set_value;
 	chip->direction_input = modepin_gpio_dir_in;
 	chip->direction_output = modepin_gpio_dir_out;
 	chip->label = dev_name(&pdev->dev);

-- 
2.48.1


