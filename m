Return-Path: <linux-kernel+bounces-876023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1235BC1A69F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AA96E358FCA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C827355053;
	Wed, 29 Oct 2025 12:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Fps+S7L+"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8199D354AFC
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 12:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740943; cv=none; b=a8RAUFVcisalQgTLiE/EE+nJFT3ZCblA8r+TCrpUD9dz8Jvhsjf4NUCQynMVxe3lztgsWRhiHBkcSkf8Qn4BHvX7cD9H7XKjawmVy942QJ/Z7xkKkJuVyoCQj4XjZAbt7SlhTc8wDft7hQKTs4G/ify0JJkBl+xE4Zscl8qvaw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740943; c=relaxed/simple;
	bh=NNGvjwESjllaEF7LxK3T1yowFNpjBHh1JCstJa8YZdg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IF4saYre+1kSnYkpTMFGjolrBu7poiCD1pjmhaM/sMrv1LBD2rtEtwFYew7TcsunuP4EBbEIbkSY+WJIMjso+geC+E9+TnroCZ6RgWO899pfVBsVnCeKgYZ/Jv479SWIjct1kZ+XPbqp4jqh2LjZCStJJSYlH6JBNjB/SP4y4y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Fps+S7L+; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47118259fd8so56018265e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 05:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761740939; x=1762345739; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IzbX/LcA5Dz6VEQqEws9evNBv2Yi49eBen6kb0VfhlE=;
        b=Fps+S7L+QV2ezvhDz6w13RtuAVSObqOXel2aGPb6YBczdvQQkf/9zh3AwiHJnWhKt7
         kTiB29pAgzijdwNE0HY1Aih8g30VyyYj4dFaPfiWDd8Il7MQXPpxvHe5DYikvu7G84Br
         cGm3iUbfiA/eUb6GqzU2byNUk6I3cZavWEbx2wz+rUWqYJyF3SJRrQ17fI7vttYmjTOL
         JCu7Yg7XvGg2ihM3Kkj3RKzytpMrimvvlEScGpCS5JN3BABCeYB9ORtY0NEdCM7Qwczq
         KSqA4ETFIct7rxP1Ul/DEO4VtCtvARl35utAQUOzXJc2dqUrXT/VNhtzfMvyljdi4Z7C
         oZCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761740939; x=1762345739;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IzbX/LcA5Dz6VEQqEws9evNBv2Yi49eBen6kb0VfhlE=;
        b=BMu2lBv1o9XbLcy23MDXvxl60jqF/TQWMVn2E8gX17fwW9LX2iHbzp7725S5KGC+qC
         4Dns+5Ps1xAnnknI33bUW84Y9DfT/HXNG1NmPclFxf20yVx8w2QTeWX8yM3Qwii0wdhW
         wNyVxDD5pBozFjNtBXTKIJa70w3PEsikP/fwE2HoOfyKvTasronoR1PVkvptOaeu6X+1
         g/nhu9hZy6zkMv8iqWR+tu7kZIhNVI4WWeqe4M7vI6V8p+oi6AwoGGR5lJsmb/9l5Tbz
         utw4rVQvZZpoBq3o6t4eO7COlrMRmI1GkV808mKhfyPWLwhSziWvoqslTeeeViFGAaGe
         snuw==
X-Forwarded-Encrypted: i=1; AJvYcCWMPJg3WqiR4zw1+y2i/s8bE+Qq27B+D6i8blxnBNufxOcjjnotRWKJFIXRhMdkQPOQP3SVmqPvd/RnfXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwddMZw0A4ROS1NEvy7q6sYqp7r+5X0OxX7kz/h23dNwKYt8K6+
	1FAjZrMcERoK1xkoZi2KZyGggToKJLrlxkOMgKbp7NJPbRnOaQ6KRI4GdSVLQ8Sktlo=
X-Gm-Gg: ASbGncsTAq/iGqpWfPNbUBMbAMFp+lUEe1Chrt5YMH/whGZNvHCRY4XBjdQ8Nbu30qX
	w7C1Bv0rCUi7QsCPcmoGQ1lOFSPkFS8x3GHS/EavRi1HPOmZqv27EJUjM1O9PCph03I0kEg5z18
	KnCbSpZjAfdXvtt8UGSoDKeId3cnDIqU5kh5QDCFMCriLghMZJGqLTAR81+ndN0RVMJ9pFkMTnD
	UM4xKgahg0iaDhorspGgNZkzdisqt6Ody1z0L2n2MmjbCApw3rHyONfF3tMBEaCUGThwa8qp19f
	qH8CrO2Kh/dBhw4nLOakb79ogRlcocrV/PWJ+EYvDY1brWy++qOzxUnCMMFo6Cb9ZYqEMCT/QrG
	sdWOpsYoDABItlQWtejQmg1kb9TaKxBkva6rkwKYKa0jZ+6o6PGvig06sI1DGcrJaC+Y0SDlbfp
	Z53jun
X-Google-Smtp-Source: AGHT+IG8g6hB5SNsI9e3DFIiomt04U0/8paaItGpGlO3FT91y0uqvdH+5yl4I4VWVEOoGHFf1gWiAA==
X-Received: by 2002:a05:600c:3e87:b0:477:a9e:859a with SMTP id 5b1f17b1804b1-4771e21ed24mr24759875e9.22.1761740938806;
        Wed, 29 Oct 2025 05:28:58 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:69f2:5f2d:9ffc:a805])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e3a88fdsm52775545e9.10.2025.10.29.05.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 05:28:57 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 29 Oct 2025 13:28:40 +0100
Subject: [PATCH v3 06/10] gpio: swnode: update the property definitions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-reset-gpios-swnodes-v3-6-638a4cb33201@linaro.org>
References: <20251029-reset-gpios-swnodes-v3-0-638a4cb33201@linaro.org>
In-Reply-To: <20251029-reset-gpios-swnodes-v3-0-638a4cb33201@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1044;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=D+u+srU0OvfgxDXNvd1XP1KSLBihAFjsPd14v+EnoX0=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBpAgh+2HH+Su1AAscYKxfH8/3rvA7k8r533eDCn
 Ldd6OcmdAiJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaQIIfgAKCRARpy6gFHHX
 che6D/9p4upU6sk3sQDuS0I2iQxv92BNCBoKjG+TgACcJJkxU6gyOeuHQXE50IpbE2xosVdtrP7
 1IAIOU8xIMZEKdejFaDCJGSQcEt736bVQxE2dAL1nHzEptoQpighIlHrvFoNh74kaRPEZzbW3OC
 4JEokhbUb1skelTNCxcnEpBBwZU/eOTRmSlzaMJJ1ZDeDyZYMzDxEf0iQ4Kbt7czKAAqG6d+hH9
 L43IIu1QqjdhFq9ohwnFSauLOtF5e1XYSsQICLuu2YPDzjh4xw3/oPfl/fZnrwJyhGaCrAleiJX
 Zy2OgE4pqXz0aMNzU03IZwR83zUqHcTpWZLH4oIR+qbf1EdDNCVtygCu/LPVUVJvuh1azuRtxUb
 Ku4UpH4CCWJCfak/Rh/CQrvhADdIMHlxu5NeQNHvryNmg4qaZgnZQN8n7F8v6OfOrlcY+7BV1mL
 m8SwgjxaXSk2c4NdQ5edxIYIkHkNSdco4z7f4CvIhHBzk5VTHiYtKsAYs72npndQqVNDtMs8kYy
 uHOo56N1n3r0traQSanJWHCKUqSdYXakyXCzsbk+mc07XKLcWDds55EFV9AznhCcTI1Fqi9BqEu
 fvBdoEQZE02c0hWqhu2jAAO4tHluPPK0xXvuPdVHONE5e++f7qgmRAqpAS5TGgYh1+JxYIr/FT0
 GbxVZXq6EdNM5zg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Use the recommended macros for creating references to software and
firmware nodes attached to GPIO providers.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 include/linux/gpio/property.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/gpio/property.h b/include/linux/gpio/property.h
index 0d220930800276a21b5ba96a68371ce66fc4ae3e..6b1c2ed9c57594bf3ead5edc82439f9fb7f514fd 100644
--- a/include/linux/gpio/property.h
+++ b/include/linux/gpio/property.h
@@ -7,7 +7,10 @@
 struct software_node;
 
 #define PROPERTY_ENTRY_GPIO(_name_, _chip_node_, _idx_, _flags_) \
-	PROPERTY_ENTRY_REF(_name_, _chip_node_, _idx_, _flags_)
+	PROPERTY_ENTRY_REF_SWNODE(_name_, _chip_node_, _idx_, _flags_)
+
+#define PROPERTY_ENTRY_GPIO_FWNODE(_name_, _chip_node_, _idx_, _flags_) \
+	PROPERTY_ENTRY_REF_FWNODE(_name_, _chip_node_, _idx_, _flags_)
 
 extern const struct software_node swnode_gpio_undefined;
 

-- 
2.48.1


