Return-Path: <linux-kernel+bounces-723909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 032E9AFEC57
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49905587349
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FEA2E9EBB;
	Wed,  9 Jul 2025 14:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Y3Jg6bF7"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287822E9721
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 14:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752071963; cv=none; b=Km+jM+IcniGpzcSXrM+1bqtrGQVotSE/1qWH/j0kUsl2R0qcecVt/vih18XTSwwk3zGzCnirzwcRmkTlfy7IMkSl/4BsmmWRw5AMmtMUCmQSrlW1h+Jej36Ha+U61tx06zK4CfkWPcCzi7w8TBL5sk0x5BafqDWL1W8DYcHykYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752071963; c=relaxed/simple;
	bh=h9Y9QsarkpXYFnUZLolMrTl7+euN/vM4YyfIdXkl13s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JBF07AAZV1kv8+2lP/grE+M08h3aN5dpUUUPliw5oqU68ZSrZTXdELmiWnizrEXSj2aAE5ske4U2i/YOarvogurrEJ7hoOIn2S8av7x16cxPqdpqfccwvEktXzIcHIE6Bd4AnrLcVdK5hP6tkobpO56vVU0iLGhuNFZb3RMkl3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Y3Jg6bF7; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-453398e90e9so41222485e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 07:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1752071958; x=1752676758; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U/0cHEX1WGiZE8mwyI/JPOFvvGfe/GVd0huttz7DYHs=;
        b=Y3Jg6bF7d7y9+byyvlbQjlO71shSz7ZezydV9BSbvJBt4i4CnIdb7ewhHx/erQKCO+
         akb3CFTkWfU15VMUUT5T/IvpkZMOUTBO5VnhQlKz+vIfAfYTxwKlYZQ//4I7EwTwfVJb
         aRcOGHutXleQaaJK0nKVn4Ps/yKfRtayb5O+tG32VCBaPeXnvDJ7SuyCXUIJL+kA0sD7
         2NHhq1brPS/ABsttY525wI77y8jQ5vpnKBjdMZc9JLdH4quYar4fLP3LmYAPvfgMcCZq
         yHlhQMN3jVEAjzkPH0LoQtNj21THyNtWrwS+z/yTb+dcI+x2GaWLP2s+OP1jpB/gyB+0
         6yPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752071958; x=1752676758;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U/0cHEX1WGiZE8mwyI/JPOFvvGfe/GVd0huttz7DYHs=;
        b=Cc67Pc1hT/nv6H5XIa0rxU+y/qv6G6t1ncwsQf/Ar1Tmy1pfCr4aoI0VXjmi5vUdix
         EMRZdCEm6oInEFX5qULQjzSyw4YwiusybB86Y+gPtZda/6+AeZ8vAPc7NKkbLqtgizjw
         C4JCmSs7ibTDt7lwwjkVnvyzonjpWdxgaRQs9lCBAHPySnpIqpo405EfnGsYVrrMIMH4
         UZ+0n9DWdFDWWvQA4R+QmauE2CGxiAOS8W2zZskkHdhI+V8/5yMtnYzoPUXb1d6iccXi
         Pj808JmbMT58/Aq/Ob84sWIaLt5CMMwsZy0pUiACCCbPUeDLiCLChAX1e6yM+UdLJYNY
         KKFg==
X-Forwarded-Encrypted: i=1; AJvYcCV7iDFllZD0dfEQ8jENWBPV7XxUdpXuBd7qcBoCuNsishTDMohR+C7qrEr2gTG9WSjKEytstzyzPImttbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOpASZYQEoaBwO7rx/usoeFFjik2XkTYz4TFOwqRWD1CHtNwiR
	Y5Pyg0ui6C2nXySX/zmXZlvwpiUw8/ePLhjphYgMz+BwTs2SLYOyue6zX7nz2ZpUbSw=
X-Gm-Gg: ASbGncujlpQZqCcAUeN5ucun4izQsoGAyWsYIe7QfbXKtmBgXj+takKTLDM4W/jbqYK
	NcpEVA8F0yglM7DJOVM+6UjMQnbBIG8AFW59qBor2aKd7A1Z8ve/cNVKa8Qe7xXljJfDAaS+BCU
	wjx+c0NyiAl1d6ECXvPjT6XcKq3TGyaySDoWZBljWiXMIwThFNIWpqoAU7mxrdTGWxu9b5KHD2R
	vdLktbNpKi6i+/uIU8U7rhS3HJFeasB3XXmKoapBCaZ2u7WA1G/y46u4ipKrzIptFhP3mHBK4bW
	RLpmzYBLuIqVOeJtLK7gVa2qmPOYF9uTgDHeOsUiWt7Ne6CYpEv2uZs=
X-Google-Smtp-Source: AGHT+IHJL3AtHw/EonyubylYUgvsAX3aEA1kWb+hfmhi4rwD64AqP18DXBVWa7fZWLEMijUB//O7/Q==
X-Received: by 2002:a05:600d:19:b0:43d:4e9:27ff with SMTP id 5b1f17b1804b1-454d5c8ae6emr21757475e9.7.1752071958441;
        Wed, 09 Jul 2025 07:39:18 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:b04e:cfc4:3bd9:6180])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5dfbf56c9sm4480687f8f.79.2025.07.09.07.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 07:39:17 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 09 Jul 2025 16:39:08 +0200
Subject: [PATCH v2 12/12] pinctrl: qcom: make the pinmuxing strict
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-pinctrl-gpio-pinfuncs-v2-12-b6135149c0d9@linaro.org>
References: <20250709-pinctrl-gpio-pinfuncs-v2-0-b6135149c0d9@linaro.org>
In-Reply-To: <20250709-pinctrl-gpio-pinfuncs-v2-0-b6135149c0d9@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Alexey Klimov <alexey.klimov@linaro.org>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, Sean Wang <sean.wang@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Paul Cercueil <paul@crapouillou.net>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1081;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=iQ18p+opwS51aj7kQgPPUv5KuYwgsHKMpCHQbdUzIuo=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBobn8Hh53vwVwSAhW66U/ZVT3BJ1K+Xx5actm8W
 SIfx8mfLfuJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaG5/BwAKCRARpy6gFHHX
 coG7EACGCen1sbTZOcLtihqfgfleRvxd76y5gasx5ejhY5jN73Ryz+vjJHtDwd0l8c5SrMksrB6
 t7OuK5xDmCoMqMKP5oOyeqLRRCAkG+Bmb5B2OQB1nzWC9+7adNNl5rNXdk1UlZJum3AJqNI2xaU
 HzQ2ZDMceCyhG/Rb6B4qmWtfdLKiwGQTSjKvy2FoyiKyP1Kkg9mta/0tJcbaoCJ4KIGpY35E1Bz
 vNq+LbVz1VduLsXlH77XQUw5YQApX2JOKQ6E31YI4F6oiDHonqOoshmaQi+J0BEZYUgZEJIgRGe
 U0vwdMdBK4dlY3yHw6HrK2Tnqh8kawBRgh7OeZYoldO7ICasE0MkR1/VRArAynV34jM/THvbj3H
 +plh1jmtOLBgb3t3xLuhkdAjsXU7lLuznLsCsL+cweuriClQTCPwJtO/CuPSxCxQ0O/D4BSRZu5
 cVnckT4XlctODT6EkMNWLvzHgb/PAfHS0ZpGItYuV+nSdQ0nI653/gECD1stS1bkCeVnT/tJ0nJ
 WcFn6s33bTLewA0UiRkRJa3fwOCoP8hZripGucl8phvCVzKI8bI+ueBfR9B0nZzOJjwDDtVTdjj
 Xun95s+UXln6QtpXMasLGtGzUdktTreMUdgPihMF9TwaoN0biXPnFeXfQt2JXn4vWrGO9/mcIM6
 vn/2GgtvVmDuNAw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The strict flag in struct pinmux_ops disallows the usage of the same pin
as a GPIO and for another function. Without it, a rouge user-space
process with enough privileges (or even a buggy driver) can request a
used pin as GPIO and drive it, potentially confusing devices or even
crashing the system. Set it globally for all pinctrl-msm users.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pinctrl/qcom/pinctrl-msm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index 7010be8d1ace062fcf7743e539d2065d4aed856b..ad572c923e2ab8caed134207ec02c4107d4dc2bd 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -268,6 +268,7 @@ static const struct pinmux_ops msm_pinmux_ops = {
 	.function_is_gpio	= pinmux_generic_function_is_gpio,
 	.gpio_request_enable	= msm_pinmux_request_gpio,
 	.set_mux		= msm_pinmux_set_mux,
+	.strict			= true,
 };
 
 static int msm_config_reg(struct msm_pinctrl *pctrl,

-- 
2.48.1


