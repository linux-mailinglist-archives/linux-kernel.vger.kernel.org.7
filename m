Return-Path: <linux-kernel+bounces-882573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE61C2ACC3
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 10:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3D27C4ECB6B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 09:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3D12F0681;
	Mon,  3 Nov 2025 09:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="gHIbov7D"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FD72EF64F
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 09:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762162550; cv=none; b=q++WRzWEB4AYCWhe2euNjy5SrzqJ/ABnt/DmaKZTgaV8C7Y0XKmm2KexiufA1QL7dxX0kysMyedxuy658qgsB7OvhlvV/Q/sOscyYWqmyo8qCMt4TFvgGOm/w6xABfaA0PT1n/qST4Rssp9xR511iyTahirxav43+slTFudws78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762162550; c=relaxed/simple;
	bh=cxrSuSd3SffFCsNE0jm4EfEjLQ6o2VSj3hMZ52YiwyY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T7xchJEXwAKHL5t7LHWzjm9OcHFQtmGt9IQJX/KvYZQTM1wisQGsF/i1EGiEjqjkZQvLFdLuc9/E01twI1E0zXV8u7rd0m8+sKKDtk7/f+ieH5GLR2ngAHzy08gqMYVXg255Of5aRp/3G3EcuZWllHEcPSiHDlvgDuyDS/0SUfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=gHIbov7D; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4710022571cso39768285e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 01:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762162547; x=1762767347; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ph4oPh3xLmZTcDXzCKTBGJeXK4U93djPD2oimgH5xG0=;
        b=gHIbov7DzpfAJO6Nmba4LHvyaK9qF0nsIPpFjMJS0T+bdgzmHYoZ6W4iJzyZEXbXEm
         g2jNbZmfySRJ2XEPYHeKnBZs3jc4Tp+RfMUagyZ8OEheTBilDoDLIIfLcPndetG8l891
         9T6RKP91O8kostSln5b8Hsw8DcGg491KBBmARiSCtM4VaQY3eFktNTye59od3W/gAGEc
         itJk85NzuLWrA37zx/X7IGHl/Lv0OFVSs5BR7uW/x//ieuSE9LONOSj7JTPrmlkwuW8P
         Xk1j5Fgbpl/+cvw2OhhLOAkDnrEdr4c/6ZEx5SeY3KOMd3gT92U9J1heDBdII0WWIBqX
         sGnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762162547; x=1762767347;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ph4oPh3xLmZTcDXzCKTBGJeXK4U93djPD2oimgH5xG0=;
        b=SU4uGyXsu+jSL0eS5lUz+vQ26zaQMXq6lUcwyLbwgXIm/WBjTUSg9sHIiyH6jtwPdX
         lvEY59OnPxvF6eammNrcAk9qd9ntk1QF18tZ90+6dQFUdibQn5jGOdlrLtoOznfzEe7G
         7ZqobIdXVZZmrI4nzfipYlBaSHZYdg5WSjz5WIZkX9NgkJ4NKmUV6wpSmdBrjnexXa2b
         5ALXUrmXs2RLeYACykvhFqiKqyPMjiw+g6DVufDGFdi8I58dj1RWN3CQdsPO1Tpua8LW
         dcWzGTKrfTDbcrla7bhVOjTdH9JylJaoGAGQ3iSsD3JTZWECLbmBY5RFvjZMQHkF9uWA
         HFpA==
X-Forwarded-Encrypted: i=1; AJvYcCUCWzIorm+YZ5K/RdI9lGm5WUch+Ce3Jd2JxVkBWxmgapQ1TSkXg0RwCgF965/jAmFBije0Rv4lOtesgCk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMEwPCrKhUwpWbj/1U+eoj0z/1ZMvGuA3XPDpJTH6de7T92oWQ
	7NToAckR/2RaV6DuxvuwBEbF3pAa5cK8sdIdk7ILFS/kHzbns8oR+uNmY4w7dGoUAeg=
X-Gm-Gg: ASbGncvU/dYSlmcgHoCkQj+/iGA9NNo0nwU5PNo3zOtAGXcQIC9Jc61zHnByq+Xi13i
	iC4yz2qLBQTpZOGgZqykKJeixFMiMOMlC1dggH94zElZfBtYGac34ghWRBlF7X4q6NdTfbIprqh
	z6NdVrfUsIHepRsBLmESeh61I8HapREWu8xie09RT1sv1g26HzfBXxpSDhXL51Z3MYajjchGB65
	ZhJR3r45Cte9ia0shZBuUpNdW8TogdwaqYDXNcMx5QbvyUfeZmMDGsZ30X9ltjT5TTZ/Qypt52j
	J5i7iLUtJvmlwXOrh134dHtjMYreslhJLLNsybdFnqDDT08vZprLjvUINR9evykeWeGwsvcwa3H
	0/2MonR94B3zfpPwrk8VoI/aEp5adaNC59JX7ptQMSx4kKd8jIeX01MYDX/HxSVF8PeP+xMrIxZ
	V21XuG
X-Google-Smtp-Source: AGHT+IFWvdmE9jmhQNsKEv6lmznwGqw5UnLkSV15MT4Bl2LI+E4mEEbQhnuOQCPZsh65/2pUAKVNOA==
X-Received: by 2002:a05:600c:811a:b0:475:dd89:abc with SMTP id 5b1f17b1804b1-477307c147bmr93023785e9.11.1762162547012;
        Mon, 03 Nov 2025 01:35:47 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:e6eb:2a19:143f:b127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c4ac5d6sm147285675e9.8.2025.11.03.01.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 01:35:45 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 03 Nov 2025 10:35:26 +0100
Subject: [PATCH v4 06/10] gpio: swnode: update the property definitions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-reset-gpios-swnodes-v4-6-6461800b6775@linaro.org>
References: <20251103-reset-gpios-swnodes-v4-0-6461800b6775@linaro.org>
In-Reply-To: <20251103-reset-gpios-swnodes-v4-0-6461800b6775@linaro.org>
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
 bh=qZrP4QmicRIBgZpjf6GIYTTtJ4Ab1ZJJcvonbYSz28g=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBpCHdlOJbVRFWRlEo0P4nO+EKjxhnkWfiWzi/gi
 qvS22CUKUuJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaQh3ZQAKCRARpy6gFHHX
 clHFEADAX1IIKJHPYl9molA/DVVacZ6hlCW756bmj9ygQweMqXKTT+Ro3HmZstzi2WUcBqTt3sd
 8+9YMIIz6po2F5UV/AIL5f3SeApVKc8M8wdAuBOPRIwK1IdZ58Znzqih5oWZ015oFpBAoJ81571
 swG1RS+7stycB/WZqDNQ/plBrYXLX/JaICRwKHu2mljxJ1hPPgnj6d1TiH3YDft64e4dmT4tIz1
 SGltEOoNaz261yXI5BjxUxooq9r3RudHHPBxtSjiLu8p2ipOu8Idc19fnjwdRXqqDrm7LjgDrXw
 KHHvPc9phV8t8tgxU9gS2Wx3sA+CjsgK48wYdUdJn0cwc3szUdcEqQKYdRwDv+RlGiD2bstfqOe
 QdqBSVds+eO3WFJsA8QDpFct4yBr4vICwttJuM/Y+ZQ5x/BiDOG+gq8GQLB6TKO0/e64fTB54j9
 YfslTv98OqAs47S91aWgLaBYaPWeQppbLsQ7D7qQ4cQllrR3wVQ8WaJLpfCT5WoAIX8OtjTdD+c
 +IXcCtJSkhQX0CHlMxMHXj0qrHP2mzOCwJ5ybHVxiMFFLdNiKOr1Tm25Yer+f+o468eTofi1Lan
 IWKmRZw36aH2ahMFQR1LhngfJ7v0U30OC1plYsO0sbGc1J50/s+EfFYibxeeD+WaqpIlbnhGxS8
 zMCymHtbB6LO5zA==
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
2.51.0


