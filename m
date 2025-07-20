Return-Path: <linux-kernel+bounces-738411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FDEB0B7FC
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 21:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31C587A8796
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 19:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCD022424C;
	Sun, 20 Jul 2025 19:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rq+X066Y"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64EA221F0F
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 19:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753040344; cv=none; b=hk8yvr9aWd5yriv63ptA8U3TXs30xZJTpPHzvHbgga7z3cjwd/GIlYcm2JBglzDdDvqGDKfIAMSXWUEUYwb+Gkgdtfm1nFyvkBQjfBy21sTJOlZDH8OgWOvTzQ0NrRAJlo4r5RjbtK2ZF7epKScXAp83n2qgzFtDitV33+nCEyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753040344; c=relaxed/simple;
	bh=9auUBQhB8O3iigsJ/KehzMZyztYeJf1B88SFG08/JSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u71TOVZ8KyZUNWYYqcjLMnLWJJKk+ccwgHgYuT3H/pihG4acLU7AnVRvHovOzkw5hb8VB/m8sE+gjvxTvc6gVFqWKAdfqw5qKWZz+BDfyNfpSVc/4/Cjf/nhZl9AZDoDx3Ne90velXvp3EWizBSwxFfasw9TkIUAoPz3oL2WBR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rq+X066Y; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2edec6c5511so1740894fac.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 12:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753040342; x=1753645142; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6uCGwy/uGkpfb0pvgcXUB8vgobgSJDaGpbJSvSenFqI=;
        b=rq+X066YPJYvj7caU6QoRh+ck4ryX4OBTUpKgnOv18omKOBrBoveEWtqW7OR1YHFjX
         yMNzJibFgVDjbmQCRT4RpaN+uH2+2qU/EpXLAg+NxdfFJeEAfnrRl7SaUgcsM6cV7+tv
         rwEZu/Vw5JWZt51u6lmnjOQjNydOHkHF1B2a9TJWP2OOWY6oioQQGvuryAN88KmeByKS
         6Ufu+JCjyuU5ajWVOVH+O5420L4Yd43zAdiqfpXObIPC9SSEkzcLzxVmXDweqwiyIfmz
         ABGZKDG69/eahe5HyIGgOwVX0I64tg9sH9a7olXVf1vtHVxlnD4jcaOrDmtUl4IecLVo
         HjeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753040342; x=1753645142;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6uCGwy/uGkpfb0pvgcXUB8vgobgSJDaGpbJSvSenFqI=;
        b=K643QKx00ARxaoBz9oulwE7NNC631x2OrRbQKixLM0VXM2b661bFASJIJboqdcGxTJ
         mCQOxuJc99Seb3/+LPAvPnPG1uPnp24uj9IPYTxkzEogxmLhvJTYhKFQtpkscvsxj5se
         1FttzY1/b859fMYJb6DCaAyZdHxtHChR+YvgLTkJn5y+3TUdqHgsdeZ2gokEFPRH3WTk
         64ClqB3z/5CWfWiwbdiBy5B2oXJI2vuaIntHL4/Ur9AmFJs03ivaPbP7mCB3l3ecyjJb
         WLVB+qTe03UQjHcHGNmur6IjwP/kD9o4tdviNScAoXHAOiazYfWkviUx3h79tEn4ciUb
         ZrGw==
X-Forwarded-Encrypted: i=1; AJvYcCWf9/pDQPjzph+XS2mFV8g5Fxdb0xKX6Em3qcI1HG93s9Y+9bhdYSOhFF37sSOqe8tKdVg2VskkPuElDOE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywec46px2PMqmXIxlvRlINIprt/KNC1TiDaKSMdW0QjdvztpeEw
	QoskPymvP9qTuOC1os4+UJpB5GrVxpSa9T8YFe8kwL0xn89Srh7ASN0POFdNsEFO/u5nGsIQBwZ
	hAxjTYEw=
X-Gm-Gg: ASbGncsUJaCKcPBhv3vPjyE253rxLOyr0WUWUUXkjbVVUlO+HcYjDXP06FioQZxU0gN
	VQqe9rh3ihlyGU0gdHZSqMDSpL+ZwTTYIzo6m0uOA8mEUlDpquhJWWYJWVwLeqzx/PoipvIL0NF
	KrTo5nhM1hp0KQaLU7lhiVVNmtjChrUAAkPixqe22252zrY104POcKfHfQFg5n9otApNBGzvAig
	gGhYzdmPxJMFVuF0ZUILEvXlkw143BZblLx6qtCG9njFm/EIsrcCOHxFl4T1mIFckJAbo59l7dz
	82hh1eZZ/OgTsOmT09mv7/eGeZFXr5Oz2FEHSSY7TAuxI5NoNw2bXZup0VQ3qvd5/aaG1dgbpTU
	vQz9TF61UESw=
X-Google-Smtp-Source: AGHT+IH8XmyhhsiwXlgfzLZBUO70j3GY7Ll+3IavnthbKLQPwxSitZFNpac9MaQeewUcKGCyD5gWsw==
X-Received: by 2002:a05:6871:7383:b0:2d5:ba2d:80da with SMTP id 586e51a60fabf-2ffaf5c8720mr13188863fac.36.1753040342019;
        Sun, 20 Jul 2025 12:39:02 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700::1fec])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-30103d1d804sm2810796fac.29.2025.07.20.12.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 12:39:01 -0700 (PDT)
Date: Sun, 20 Jul 2025 14:38:59 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Sudeep Holla <sudeep.holla@arm.com>,
	AKASHI Takahiro <takahiro.akashi@linaro.org>,
	Michal Simek <michal.simek@amd.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	Linus Walleij <linus.walleij@linaro.org>, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC v2 4/7] pinctrl-scmi: add PIN_CONFIG_INPUT_VALUE
Message-ID: <6f732f53-7e00-4f0d-82a3-480bc81497bd@sabinyo.mountain>
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

In SCMI the value of the pin is just another configuration option.  Add
this as an option in the pin_config_param enum and creating a mapping to
SCMI_PIN_INPUT_VALUE in pinctrl_scmi_map_pinconf_type()

Since this is an RFC patch, I'm going to comment that I think the SCMI
pinctrl driver misuses the PIN_CONFIG_OUTPUT enum.  It should be for
enabling and disabling output on pins which can serve as both input and
output.  Enabling it is supposed to write a 1 and disabling it is
supposed to write a 0 but we use that side effect to write 1s and 0s.  I
did't change this because it would break userspace but I'd like to add a
PIN_CONFIG_OUTPUT_VALUE enum as well and use that in the GPIO driver.
But in this patchset I just use PIN_CONFIG_OUTPUT.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/pinctrl/pinctrl-scmi.c          | 3 +++
 include/linux/pinctrl/pinconf-generic.h | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-scmi.c b/drivers/pinctrl/pinctrl-scmi.c
index 383681041e4c..d1f2f971cd96 100644
--- a/drivers/pinctrl/pinctrl-scmi.c
+++ b/drivers/pinctrl/pinctrl-scmi.c
@@ -250,6 +250,9 @@ static int pinctrl_scmi_map_pinconf_type(enum pin_config_param param,
 	case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
 		*type = SCMI_PIN_INPUT_MODE;
 		break;
+	case PIN_CONFIG_INPUT_VALUE:
+		*type = SCMI_PIN_INPUT_VALUE;
+		break;
 	case PIN_CONFIG_MODE_LOW_POWER:
 		*type = SCMI_PIN_LOW_POWER_MODE;
 		break;
diff --git a/include/linux/pinctrl/pinconf-generic.h b/include/linux/pinctrl/pinconf-generic.h
index 1bcf071b860e..b37838171581 100644
--- a/include/linux/pinctrl/pinconf-generic.h
+++ b/include/linux/pinctrl/pinconf-generic.h
@@ -83,6 +83,8 @@ struct pinctrl_map;
  *      schmitt-trigger mode is disabled.
  * @PIN_CONFIG_INPUT_SCHMITT_UV: this will configure an input pin to run in
  *	schmitt-trigger mode. The argument is in uV.
+ * @PIN_CONFIG_INPUT_VALUE: This is used in SCMI to read the value from the
+ *	pin.
  * @PIN_CONFIG_MODE_LOW_POWER: this will configure the pin for low power
  *	operation, if several modes of operation are supported these can be
  *	passed in the argument on a custom form, else just use argument 1
@@ -135,6 +137,7 @@ enum pin_config_param {
 	PIN_CONFIG_INPUT_SCHMITT,
 	PIN_CONFIG_INPUT_SCHMITT_ENABLE,
 	PIN_CONFIG_INPUT_SCHMITT_UV,
+	PIN_CONFIG_INPUT_VALUE,
 	PIN_CONFIG_MODE_LOW_POWER,
 	PIN_CONFIG_MODE_PWM,
 	PIN_CONFIG_OUTPUT,
-- 
2.47.2


