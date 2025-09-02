Return-Path: <linux-kernel+bounces-796363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1E2B3FFB0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9736A2C6D94
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56BA322DA1;
	Tue,  2 Sep 2025 11:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="kemE5V4x"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF3231E0EE
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 11:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756814389; cv=none; b=kNobZgpAIYrYUklax6y4C9ee+VJPBLVWpe2W+xClHncfRzi32Egbrptiw6tqlxEp25mYDlFb+xWGH6p1njeelrX2FUlCW1gXOGl0yhNTKERJvWYZcYnR7rLJkpr/qa9yRr8O2nV+uffsnLcRECWIGl10GJzkgM+zCASyeATq4rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756814389; c=relaxed/simple;
	bh=6d9MjHR2YhTCisvLaCVyCEkbUcnGQXIAZ1ywg14KUyk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oJPsg97ev0unai42YhGfXNL7uQfqxov35jK3nm8dN1eY9wyFpGxTCsbk7fd5J5wsW+oyr3FvWiM8rN8sBI7yokxb30AgrS1MGmdtR23vwxsVy9gsh0C2/soweald76lLKZuzTJ528ZyQNOvoJBaNVxQ8Ap8lg9yGJR6mLVb6umM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=kemE5V4x; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3d48b45f9deso1525065f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 04:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756814383; x=1757419183; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bZoRwAWe6yFgH80j8Guyt3bkXloByFSMSyop0nIDEao=;
        b=kemE5V4xiv6zhcKiyB0S8kkfARev8ST2Nz3SMyXXjVJdhZL8QkAJr+mcAkDcnPwbEd
         dbwU+kcLm4/Tgi/l3X6SyA6lhQfPjRrqK2sBN5qVNFhhvNWTYul+3mEbIrfMnIhhxBL9
         /yIVeE51yro1M3jJgYk+0EsAeQoRKdn1EV+iDy5RafJTrsXoRoVAYOANgJpIU+fYw+5R
         aqQqj9YYi47VR3NL/uM3SOOVXEdkUU3PsEzJgrCCS39i0H8fRTfn84PLRG+6zrX1lQGC
         teHWNcRA9EEdUjekBqergokimqBfBrwtcfkhzNaeIjJKLNQMuafKiR0LC1CtS3RGdCiQ
         Zn4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756814383; x=1757419183;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bZoRwAWe6yFgH80j8Guyt3bkXloByFSMSyop0nIDEao=;
        b=hZ9OlsozmUD7QE7LRePT/1YpNqal4ChcUplPy0yvndfkmZTQsHoG/Iz/Fkwh9YLaZ2
         2Ga0P2FCm7+d60JYrJnnHJZv5R9yYKj7FcietRp8Jd1RFiyls3U7BxsEREGIxts3isdQ
         u1CLkvAZG5MwDEQIpRVq8QpdlsIpDoLemKAnPVHN23IqbInNn6CUS3yx5zNKffJoBk4G
         5apOGWqxk1DQAG3Hro8qNncHEP1wRWRXk7f38IPsZ1r3BJB2HTK5nM+X8yi4xzmrEOEi
         VH5evKo0jp8APGtaM5BO3TMlVd8EYWhKVzhIWMPkfAj5EDOKaqC7N4mx2zaHkZXnFeDo
         VzUg==
X-Forwarded-Encrypted: i=1; AJvYcCUOohhZ+YQMQQA15MD3gC4JlcteG+m5Vl/zBm6J0usd29I//CdgPCg5YmKu5VcgT3XfOAArhztbPB2bEPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzapDsM0/9ngUwaURvfwph1GfRGW3MCN8kfRN6mGVKyK4rnGIQ4
	dBj6NCxrpYdSx8ZXbFzOUPmEA0fQdVoTgYg0R2eXL+GpZOVkw9/mQ7VZbe9tsCY/Cjs=
X-Gm-Gg: ASbGnct4NJr4mxwNr1zrog+lNl5Rs43Fc+wJ8VG40fG2yZhlOiv7lkh7Ec2UNug90bQ
	GKb2+X/+RlNVbPOCpiybk0YKeLgBAXjCNSCM8mG4ue/15i75oODGwHFzWCxIUqgmu2g02MqQspO
	SzwxA5udPLVChRzENjYa4dJk09C6X17UlROYEoXSCajRz1zNrF2GD6qg0mAX9lpXyVBjn/7yRq3
	tkdgSz3eqAWr4cNJbkT33qKMRUfQwA4kx4ITC9DU9RfSTNxP2XJ+7gs2qBF/2C9mhDOseZHZgaP
	uoUQh3uKzvroeNY6XkuxRcxhU6KoxqwbyS6BDLTT4mIMDQiMsZO67UXY9YjjsxhnRCfqH5kEGZQ
	oBRski64FHYGG5p7czbf3HpsYjWY=
X-Google-Smtp-Source: AGHT+IHihsnMuL05+vqbU1MvgQT0F+2Pejjix+ounk5ux1VyL7KdAqS4iEwvv3M3i/aDvS1YgEbYFw==
X-Received: by 2002:a05:6000:1acd:b0:3cb:46fc:8eaa with SMTP id ffacd0b85a97d-3d1de5b087dmr9071418f8f.31.1756814382749;
        Tue, 02 Sep 2025 04:59:42 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:3327:447f:34e9:44f7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b9c234b24sm10224195e9.16.2025.09.02.04.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 04:59:42 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 02 Sep 2025 13:59:23 +0200
Subject: [PATCH v7 14/16] pinctrl: qcom: add infrastructure for marking pin
 functions as GPIOs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-pinctrl-gpio-pinfuncs-v7-14-bb091daedc52@linaro.org>
References: <20250902-pinctrl-gpio-pinfuncs-v7-0-bb091daedc52@linaro.org>
In-Reply-To: <20250902-pinctrl-gpio-pinfuncs-v7-0-bb091daedc52@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Alexey Klimov <alexey.klimov@linaro.org>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, Sean Wang <sean.wang@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Paul Cercueil <paul@crapouillou.net>, Kees Cook <kees@kernel.org>, 
 Andy Shevchenko <andy@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@redhat.com>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@gmail.com>, 
 Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 NXP S32 Linux Team <s32@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Tony Lindgren <tony@atomide.com>, 
 Haojian Zhuang <haojian.zhuang@linaro.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Mark Brown <broonie@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
 linux-hardening@vger.kernel.org, linux-mm@kvack.org, imx@lists.linux.dev, 
 linux-omap@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1810;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=YcrXV+Vw/YHr5QitFviEgvwH6L2clCkUiJkOzNHp++Q=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBottwUt1OLXwkEzKoyV51MgdE+jkRh1wSFrqCYt
 Vx/Yn7dwPyJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaLbcFAAKCRARpy6gFHHX
 cv6rD/4/T+Qmd60Ccvmhx/iayQBqYuiWX2dIgsN6ptYMZPxH3lMhAjcyUTDe0eLlcA5KhOrzexH
 jqtqCqq/9JjES+aB5QllNPZSkMWARLzm8TbUEJfWBiCUfzW6G3IKJyzPlNTTYqVeIvhsSKfgCmv
 QWdcag5NzqCY6gKbKw7yFlbwX1vSpzMPvHZfThPRU/b7acMqdTixRbX4p82v8yfWBomrf2YPAxF
 HNHiaWoxArt0IuU41K9SrV0bWr7NhN6d8T1lRHbElpUuREWjXUkVZuAmO10agrMYGFKWLa9txPi
 4TASGnIkv6iU+7pbKOnQx93qTnkOyybTQ36jPlfCdSM96g33OctlRbaHJMWgwT9LQcGCeU/SvP+
 XO1yDDk72nuvYW06zU6f56KjqYxpGwPbs6rcWWs5hDDCyZaRsW2hjmhSl74EBy8tFnQZIwWsaF1
 8qNVhRbJpHrHr9QbM7CG9SQ9y8zVRVG0oV4jPqUV0Udf9sLgMaj0lH7n4v8HPpGeTbFSQNy8haB
 FVxnGiavvme6IkSRNMKQYiRTqKVegC/zsQSeUCdMvnPW+GMvQFj4kC+gc21akybe/N7SOsiQ5pB
 /rLl0+WSQVyHKvouXSW9LJKrXGy0cPRzk1A+pSR0ba5zneegrMyjCFbeB+P97W8RfuwxF3Vw69I
 1xsWVkKRbjBpFeA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add a helper macro that wraps PINCTRL_GPIO_PINFUNCTION() for pinctrl-msm
pin functions and assign the .function_is_gpio() callback in pinmux_ops.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pinctrl/qcom/pinctrl-msm.c | 1 +
 drivers/pinctrl/qcom/pinctrl-msm.h | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index 96e40c2342bdedb8857629e503897f171a80e579..a5f69464827119dfe2a7781b558094b283fca215 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -265,6 +265,7 @@ static const struct pinmux_ops msm_pinmux_ops = {
 	.get_functions_count	= pinmux_generic_get_function_count,
 	.get_function_name	= pinmux_generic_get_function_name,
 	.get_function_groups	= pinmux_generic_get_function_groups,
+	.function_is_gpio	= pinmux_generic_function_is_gpio,
 	.gpio_request_enable	= msm_pinmux_request_gpio,
 	.set_mux		= msm_pinmux_set_mux,
 };
diff --git a/drivers/pinctrl/qcom/pinctrl-msm.h b/drivers/pinctrl/qcom/pinctrl-msm.h
index d7dc0947bb161868c8f433dc2536719b8afc8bd8..4625fa5320a95a4d24e3a0c98a249e4f163dd4c7 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.h
+++ b/drivers/pinctrl/qcom/pinctrl-msm.h
@@ -29,6 +29,11 @@ struct pinctrl_pin_desc;
 					fname##_groups,		\
 					ARRAY_SIZE(fname##_groups))
 
+#define MSM_GPIO_PIN_FUNCTION(fname)				\
+	[msm_mux_##fname] = PINCTRL_GPIO_PINFUNCTION(#fname,	\
+					fname##_groups,		\
+					ARRAY_SIZE(fname##_groups))
+
 #define QCA_PIN_FUNCTION(fname)					\
 	[qca_mux_##fname] = PINCTRL_PINFUNCTION(#fname,		\
 					fname##_groups,		\

-- 
2.48.1


