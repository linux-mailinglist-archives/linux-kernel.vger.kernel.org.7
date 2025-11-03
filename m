Return-Path: <linux-kernel+bounces-883600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E182EC2DDEE
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 20:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2B0924F0414
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 19:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E0C329397;
	Mon,  3 Nov 2025 19:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ggpNOXEC"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58394320A39
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 19:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762197294; cv=none; b=BGv7Epa8Wpj7juBNaFnPsI9qYhQpoIi+ryr+uCEMY5F8xhY9BVD5N44YQn1SLs7MJpNqhkqelj6z24GCoKpNm9BRFrytCtVi/6WA+QNGhyNMMy6wMz96Iij3ITBwchaC9DVI5VqqO7vYmPAuV2fbEVIog8EPbXrphpIUM/Pvwog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762197294; c=relaxed/simple;
	bh=BzOY7xFqFUUnN3PD+Nik686oui3xmNMlf7Dt/c4aSB8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lbf1FD6HJiwPe4EV5OPb/cUi2gdZg0n4RwYSNjzVRGKAKj+0pKgE/61KcIBlkyQhQfq3w/QSivYoqtumX3YgTuN71rtgMyNic5c+nBTB550Zy/s4bofW3PRSvp0YEhEURVAJHZxMWXI6Ip3yVw7XHHx7R8atub4UFopCX167qfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ggpNOXEC; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b3e9d633b78so1130401366b.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 11:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762197288; x=1762802088; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+H9s1G6YtgeqluWZseo7SuZhZNZyldAYEc85O7etNJ0=;
        b=ggpNOXECDGMlgIwPSzOb8a8yxZJSFajxHfelynNZzMdhgK7O+DPMqu4gpRd0KYqvEE
         LBJ6yBg/WUXKYJsdj4JRHSmnDkdbjN+OAbQ6MI5qnlQ1eT26KXWyMt8UVWrocqjvLwap
         jnH5wPh+9HeR3w3pLbqtvyYR5xmZfmSuirbD26TGd+Etd6I7HMmlkdI3D/KBTp/ril/U
         MYtF7DRdI8WkEi2VmURQDklA+Jk3zfg6nyZiGNibHJp5udV7YdRA30+5WY7H61YmtZl5
         D+2t+5+BaXxG7gqH1ZGkdtTNjcZGb0/EKR0007qCrRo1Oc3ikzlP5rx/JfBupJaY5/QU
         +e+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762197288; x=1762802088;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+H9s1G6YtgeqluWZseo7SuZhZNZyldAYEc85O7etNJ0=;
        b=LvHJFPcPaBE2MOC22BrU/OsEzIg81oKGU4yrOW59bK8Uw0qwpNJBQScCTAq1cKiG+p
         L09HhhRuTfcxYz5PipK5crXhrrAfoSPJf8cWRNIbX/mxflPCtGeOi4ls2tlL8uePKjDM
         JS/PcnswAGh8dNDQ+cIL8SFvbjKsYuwRe2IUvz2EidYbvC256oAIaQid1di7ohnSLA8x
         /0saCdfXCQzzx65DlzN4BrDkT4OE5Fa0OdKs6TWzSPpUi+O0eYmjLRDkpKq8z5tE1L+5
         Ntoe7EOIL7XinuhG57CnED4/OChVGPodBXCu7M/HPUTVpVdpUtZx/TwBD45/Y+s7krTD
         +vvw==
X-Forwarded-Encrypted: i=1; AJvYcCW5cdNAnxMrqCMegMC1+qDiPqnVQr7MATlBkwMteZT6DlgT3iKiQC8JE+Dbi9q+udNEncsQ3z7IGoP/Rn4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqb2aOUq6cfaDc6tgNqIZBn8LyaBIj8G0nGj3R2pokACR8HtE6
	6ZIk6u9vWh2xYsiR8y/agYqWT80BxveG1ceFCAqRhNwTKAjXOoGe5NN7jwJImHtbA84=
X-Gm-Gg: ASbGncvlHVmFVAeyaClq9YHHNl9PuPw8bjTcQGkGH+dDMSoz5c9uXmzpmqP12hZeXsG
	Ev3ytWEvUYdUDoTo66gGldcJOaz5rY13l7Viy8KwplO6mObvPpW/yW0oj25+nfD8WAaBdFIdezC
	AM259LYx9Sp4my30+eQq7fqExjVYrHAmTcLMt/FJ5h8dh0K7LBLjj7kCNIMhb0B+ie9x86YJtPh
	ahgb1ZB0rZmHbRrl+4bUZaWgmYXS8iJgN94/n8uuBGfknfRAZKgjJmCjFsf7P7W0PalUmCFn0Lc
	zyrIotHmGx9lE9x0LVJzI+Ka+t8NjLQfrblX3UlYxJCpbXLpjLOxuS5Q7ah/Hc92fr7z0MJgpPG
	NjHPdPFY2x3azsJgvasDglw9SpFTYjKLlT55qfh1Z483PQw4ue7mKJutexSF/cmHLk7WLm3q2xt
	0XPXFuB8W/ysilZTZ0DMCVkcctzTO6hTB/ycf1GWHKV+Cun4dy/7vpY6fpl7h/X8qvn+dOXvk=
X-Google-Smtp-Source: AGHT+IHrMiuYLZd0vMCvo+Ek4nTQVztiZC07CKVGfY4NotHksO5aFELwrIdhsXO+9Y0y3M22E4+puQ==
X-Received: by 2002:a17:906:dc92:b0:b3e:c99b:c77f with SMTP id a640c23a62f3a-b7217387225mr57792566b.24.1762197288276;
        Mon, 03 Nov 2025 11:14:48 -0800 (PST)
Received: from puffmais2.c.googlers.com (254.48.34.34.bc.googleusercontent.com. [34.34.48.254])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b70b9f29c8asm466765066b.8.2025.11.03.11.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 11:14:47 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Mon, 03 Nov 2025 19:14:49 +0000
Subject: [PATCH v3 10/20] regulator: add REGULATOR_LINEAR_VRANGE macro
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251103-s2mpg1x-regulators-v3-10-b8b96b79e058@linaro.org>
References: <20251103-s2mpg1x-regulators-v3-0-b8b96b79e058@linaro.org>
In-Reply-To: <20251103-s2mpg1x-regulators-v3-0-b8b96b79e058@linaro.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Lee Jones <lee@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

REGULATOR_LINEAR_VRANGE is similar to REGULATOR_LINEAR_RANGE, but
allows a more natural declaration of a voltage range for a regulator,
in that it expects the minimum and maximum values as voltages rather
than as selectors.

Using voltages arguably makes this macro easier to use by drivers and
code using it can become easier to read compared to
REGULATOR_LINEAR_RANGE.

Signed-off-by: André Draszik <andre.draszik@linaro.org>

---
While this commit doesn't introduce any users, the upcoming s2mpg10 and
s2mpg11 drivers are using it.

v3:
- new patch
---
 include/linux/regulator/driver.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 978cf593b6624228fe1fd9c2a3e186b53ef172f8..977755db64c6dfaea7246067eab0d9a2971caa01 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -53,6 +53,11 @@ enum regulator_detection_severity {
 #define REGULATOR_LINEAR_RANGE(_min_uV, _min_sel, _max_sel, _step_uV)	\
 	LINEAR_RANGE(_min_uV, _min_sel, _max_sel, _step_uV)
 
+/* Initialize struct linear_range using voltages, not selectors */
+#define REGULATOR_LINEAR_VRANGE(_offs_uV, _min_uV, _max_uV, _step_uV)	\
+	LINEAR_RANGE(_min_uV, ((_min_uV) - (_offs_uV)) / (_step_uV),	\
+		     ((_max_uV) - (_offs_uV)) / (_step_uV), _step_uV)
+
 /**
  * struct regulator_ops - regulator operations.
  *

-- 
2.51.2.997.g839fc31de9-goog


