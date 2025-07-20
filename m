Return-Path: <linux-kernel+bounces-738409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC9EB0B7F9
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 21:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85B817A4D1A
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 19:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0C92264A3;
	Sun, 20 Jul 2025 19:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GhgEKvBi"
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E920722425B
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 19:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753040328; cv=none; b=RqWMOs3drk+7Sy8yrGD0UVxYSbcGq2dP2PuOkih7YGqrl5qWHJ4SyxBzW+hBFerHsgE5SN1nqwyxq+wb9kfcD55Rvzrmqu0madT6tc8wX9eihD+OQc52GBMAUL4i3wJSPZaLbzeN3ejrETfTW9XzYxo8OxrxxftlEVRrKXkujPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753040328; c=relaxed/simple;
	bh=65YRWaYQ/xNnHFyu5hWqKKOZEWxUH+v3jmAFlpWeXqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VpBoXLYIPtQE500GTXxNgOBwJv6aoCXY4SfFrrOK7RGF8mnFjgrTRAue4BpABR0C57ZqF6IrlN9tpPzNUO/esD89Us0J+ssn8oqGb5RXgOGsaZVgdaMFRaiD6DxhxLjamjclwCeTzFedn9S+nLvuSMelVc0p6IH34gqi28Li6SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GhgEKvBi; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-615950642d9so2067723eaf.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 12:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753040326; x=1753645126; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Sk/Cvjmn3F+MvNcu5ECj0qva2OjAj6ueLb9Dbmgomqw=;
        b=GhgEKvBiSXoS2jkpXTQ01Fz4368D5gxq5tfy8+lrw6IfQp1NMC1s1EAAkto3VIZi6W
         r3Sz2QJ9t6jpdCQeW+Znq5BimyDQBQ3Q25xepI6GzM18upKNAyM8SFSNlZLbkWpOyydn
         Pe9k098ivHjFugjLSG9t5CZ0lRhWiGACLnCcfogiMoOoJtYkjGjMSaN/Pjho/UYZ6CIl
         jl+1MX2PPqLxpj12HyXfGdKTdlQJ4YmDncD14/NoDEMm0gdSZf3HnYXPSKyxvrfru/lJ
         UKMcsKKfu5Cv/RxNm8MU/CeOHiWT7FHqyiWgJpG5s5wAHuBT/lX6smAQTpQjpMAdgybg
         7aYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753040326; x=1753645126;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sk/Cvjmn3F+MvNcu5ECj0qva2OjAj6ueLb9Dbmgomqw=;
        b=MEyz60FY2H8fnifGgV14U8BcUrkd/Uk0FtFNVlscpkzWCfC3Bc43jugaRXuV7NPBi9
         BhseaJYYdnLJs9cCuKqYyQuTy9UWtv20qsNWY8MtqH677+ASJQ3IoxsJ/7AQyw+KAIaj
         C4u5yjI/0aeTlZcAON8XoZwXhcj0fJZTGPRZ54qpyPP6bOBoGTuQfMcRhWpkuv+IMkz/
         x6+83Dqy/4pGaR/0xAVP06aFVrwiGYcngoI+RCOSlUkyB6mxWwKwPPA92w11Tf40BHnE
         QbDNawFiZINOW6Yg3QCnBmfvUVbQd5sVX0SDqKkFqq5UHkpsa7CHwC9vN8IXo+ITHYD4
         dSCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOngMzmd8jBANBCoqHltLyP15FFTnncOB0YQDhOsXHZGB2E1kq6xj+/x3imU2BUytUdiynA90+u5O4alg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhcQlPgW3znyF4pZDItl2mqgrBiUWOyN5NL8iUp9G3CdaWLAio
	OfX74PeL0GuKsKDMuKPcx3UdET44jkWTq4JYHhde5ZI46P319Hh7M5cKKTLwOoaceCMH2K7iIZ9
	6Ai2pCIY=
X-Gm-Gg: ASbGncvbB4AAV4H6QITcpAqJ7+M5F5bT3yIxgkIkpJkmFwPLpYfzYI4/+PqrACwU9vm
	/jecxXqyfM+pzta6Hqv1xpYpcySdb2SDVaMS7eIsgdQd6vburXgKkTdDDpIcU/8BVCYRr316yzD
	vXHTzBU0YKMJmVlJZIiEhl6FC/B4r5pz+cYqH1Fcc0+h0p1vzquSwYIuieA9aN4Np1qm5NkQtX+
	JXRG+GAFkrb+A81glAXHrspniZPIJqS78jD7bGGlJPsK9nWIOWmHA5Q1teUjjWGRER9cOaOJw1Z
	x602CPFAlPK5ttGbnZNjNuxzo/+dgk7b5hgcqW5dXvv3Md3ksxf06dda+EG0miHwqilwZjTMYNz
	LnscI/GCQ9hZwZVOrVwh1PA==
X-Google-Smtp-Source: AGHT+IHv3AJy6WvLlnGO2CccdtcgTjsbozHvajCI7dbyHtAdaolcMplcFhzuNXWcUN+G/rBrd/RjDA==
X-Received: by 2002:a05:6808:10d0:b0:406:2bb4:cd77 with SMTP id 5614622812f47-41d034f1585mr12534170b6e.5.1753040326039;
        Sun, 20 Jul 2025 12:38:46 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700::1fec])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-41fd498d8d4sm2027882b6e.24.2025.07.20.12.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 12:38:44 -0700 (PDT)
Date: Sun, 20 Jul 2025 14:38:42 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Sudeep Holla <sudeep.holla@arm.com>,
	AKASHI Takahiro <takahiro.akashi@linaro.org>,
	Michal Simek <michal.simek@amd.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH RFC v2 2/7] firmware: arm_scmi: add is_gpio() function
Message-ID: <fbcf6cca-784e-47bb-9b61-3028f59a92ba@sabinyo.mountain>
References: <cover.1753039612.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1753039612.git.dan.carpenter@linaro.org>

Parse the GPIO response in scmi_pinctrl_attributes(), set the gpio
flag, and create an is_gpio() function pointer so that it can be queried.

In SCMI only functions and pins have a GPIO flag so that's why groups are
not handled here.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/firmware/arm_scmi/pinctrl.c | 34 +++++++++++++++++++++++++----
 include/linux/scmi_protocol.h       |  2 ++
 2 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/arm_scmi/pinctrl.c b/drivers/firmware/arm_scmi/pinctrl.c
index d18c2d248f04..10c92007bc1b 100644
--- a/drivers/firmware/arm_scmi/pinctrl.c
+++ b/drivers/firmware/arm_scmi/pinctrl.c
@@ -28,6 +28,7 @@
 
 #define EXT_NAME_FLAG(x)	le32_get_bits((x), BIT(31))
 #define NUM_ELEMS(x)		le32_get_bits((x), GENMASK(15, 0))
+#define GPIO_FUNC(x)		le32_get_bits((x), BIT(17))
 
 #define REMAINING(x)		le32_get_bits((x), GENMASK(31, 16))
 #define RETURNED(x)		le32_get_bits((x), GENMASK(11, 0))
@@ -107,6 +108,7 @@ struct scmi_group_info {
 struct scmi_function_info {
 	char name[SCMI_MAX_STR_SIZE];
 	bool present;
+	bool gpio;
 	u32 *groups;
 	u32 nr_groups;
 };
@@ -114,6 +116,7 @@ struct scmi_function_info {
 struct scmi_pin_info {
 	char name[SCMI_MAX_STR_SIZE];
 	bool present;
+	bool gpio;
 };
 
 struct scmi_pinctrl_info {
@@ -189,7 +192,7 @@ static int scmi_pinctrl_validate_id(const struct scmi_protocol_handle *ph,
 
 static int scmi_pinctrl_attributes(const struct scmi_protocol_handle *ph,
 				   enum scmi_pinctrl_selector_type type,
-				   u32 selector, char *name,
+				   u32 selector, char *name, bool *gpio,
 				   u32 *n_elems)
 {
 	int ret;
@@ -217,6 +220,8 @@ static int scmi_pinctrl_attributes(const struct scmi_protocol_handle *ph,
 
 	ret = ph->xops->do_xfer(ph, t);
 	if (!ret) {
+		if (gpio)
+			*gpio = GPIO_FUNC(rx->attributes);
 		if (n_elems)
 			*n_elems = NUM_ELEMS(rx->attributes);
 
@@ -610,7 +615,7 @@ static int scmi_pinctrl_get_group_info(const struct scmi_protocol_handle *ph,
 		return 0;
 
 	ret = scmi_pinctrl_attributes(ph, GROUP_TYPE, selector, group->name,
-				      &group->nr_pins);
+				      NULL, &group->nr_pins);
 	if (ret)
 		return ret;
 
@@ -689,7 +694,7 @@ static int scmi_pinctrl_get_function_info(const struct scmi_protocol_handle *ph,
 		return 0;
 
 	ret = scmi_pinctrl_attributes(ph, FUNCTION_TYPE, selector, func->name,
-				      &func->nr_groups);
+				      &func->gpio, &func->nr_groups);
 	if (ret)
 		return ret;
 
@@ -772,7 +777,8 @@ static int scmi_pinctrl_get_pin_info(const struct scmi_protocol_handle *ph,
 	if (pin->present)
 		return 0;
 
-	ret = scmi_pinctrl_attributes(ph, PIN_TYPE, selector, pin->name, NULL);
+	ret = scmi_pinctrl_attributes(ph, PIN_TYPE, selector, pin->name,
+				      &pin->gpio, NULL);
 	if (ret)
 		return ret;
 
@@ -815,9 +821,29 @@ static int scmi_pinctrl_name_get(const struct scmi_protocol_handle *ph,
 	}
 }
 
+static int scmi_pinctrl_is_gpio(const struct scmi_protocol_handle *ph,
+				u32 selector,
+				enum scmi_pinctrl_selector_type type)
+{
+	struct scmi_pinctrl_info *pi = ph->get_priv(ph);
+	int ret;
+
+	ret = scmi_pinctrl_get_pin_info(ph, selector);
+	if (ret)
+		return ret;
+
+	if (type == PIN_TYPE)
+		return pi->pins[selector].gpio;
+	if (type == FUNCTION_TYPE)
+		return pi->functions[selector].gpio;
+
+	return -EINVAL;
+}
+
 static const struct scmi_pinctrl_proto_ops pinctrl_proto_ops = {
 	.count_get = scmi_pinctrl_count_get,
 	.name_get = scmi_pinctrl_name_get,
+	.is_gpio = scmi_pinctrl_is_gpio,
 	.group_pins_get = scmi_pinctrl_group_pins_get,
 	.function_groups_get = scmi_pinctrl_function_groups_get,
 	.mux_set = scmi_pinctrl_mux_set,
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 688466a0e816..b4ad32067fc4 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -792,6 +792,8 @@ struct scmi_pinctrl_proto_ops {
 	int (*name_get)(const struct scmi_protocol_handle *ph, u32 selector,
 			enum scmi_pinctrl_selector_type type,
 			const char **name);
+	int (*is_gpio)(const struct scmi_protocol_handle *ph, u32 selector,
+		       enum scmi_pinctrl_selector_type type);
 	int (*group_pins_get)(const struct scmi_protocol_handle *ph,
 			      u32 selector, const unsigned int **pins,
 			      unsigned int *nr_pins);
-- 
2.47.2


