Return-Path: <linux-kernel+bounces-764287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DD1B2211C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 633F816C76A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A35C2E7F04;
	Tue, 12 Aug 2025 08:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="JM5vbmM9"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BC82E718B
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754987252; cv=none; b=AoONujcdP+c3lSjHm9T0UYT3YcPCAbQvQToFPCKOrSpZOjdHMSddV5mjYKu7u62/uVy97ys+8qeiaOHYngEnv00rbAXqBTFZqjvDMR2Wn/5MuDFdrWohww+bGnMYDl9Bba+0kCko+b4h68uLdE9feJUgANN/oU6juhZdry5XN9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754987252; c=relaxed/simple;
	bh=+QvEm53FGBL8kbed9CrGkfR7JQ0mUkCssMIU9hMIktU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e3ac2paYTXnhkg/qxwsZOepp/24La1pKx3ERx8BEAuRSFpsgjp0Qzg6SraAKhFDjxeFEe477Ij2ad/loQqyH2JVfkk6AAiXf8BJdO2q9vruYbHfXZxqFezFDf2re0mwtxj0OzzVEsZyjgoh8TXxi4mR3+o/Rf2lPozwsXtN1Ohw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=JM5vbmM9; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-459d62184c9so30572145e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 01:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1754987247; x=1755592047; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fkIrT982nu0l7atioMtbVH3OTcGWcWH7NZxVXh73dLg=;
        b=JM5vbmM9DRsPp3WjiceB66fPydz6iaLNxhRSir4GADMhX+PUE2BDDAtkn30deSHj1V
         m4OJE7Uz78EJcU5soMGWTswv4MYTdu85Wgj4lK4jCZlJ5/73K/bxftLEW0aTmc+0tRMX
         xU1okMc/TuCRoGbGb6MXBT6g7isUdFQhbi+2L3fqrkPHXNqgCzLQqu11NGbMSccd+hGS
         8RjMZfINtEryw8TcbM7DYtaFhJkgRLlQDH0nzp8JgsbON+0h3nV0oxepYmk2X8DkoQ8o
         Zvf9N4aLHRUm2W5jx5t8uV7c/o692LsxQwe437mpRBfpqV//RKX/iWFXcX62THKWcplC
         +30w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754987247; x=1755592047;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fkIrT982nu0l7atioMtbVH3OTcGWcWH7NZxVXh73dLg=;
        b=RvrgllN1GKpeZ2sbFEJAFzL69kRK9swJHAK5FdfSitqTDatoL/27d2dAh+qevomWer
         rWVaMG5fWcMxxQmnYx3FKaP2iMAX564EpUyc4eOAxpRXddzJvcbvtst/K26lFLi5gJY+
         1aNq+V6AmQD8OCKq7hCIuH+yPZhBVt97wmIx/FdT/GGjl/adOeuXWekVurJ8Ds9RtXEV
         +uEwzVOgNJzt3uj0PYwqkyg00FL6RDbOQNlUF7EYluAyF0lIGpKdRd4DSRM0peTVHnC2
         jXuPzksu1XWqoVZIgFLHZHj7Z/vHTl0kBev3ELm6FQJhczmmLqWe4sqywhtqpj6N2mJA
         Tkrg==
X-Forwarded-Encrypted: i=1; AJvYcCWYrobffcCmcn+Us5InIp7TmxZ3wwSH6/NGZ7jGYe4PXPZAiwSeaI2h6TSP7mkysv9AARj/Gtpu3kdUMxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqxLUXa3JOKo6vxYv6qFEtnR6sdRPoXnzcey6zHqmyHXfqpVYn
	xyp8eCC4V3a4qJ2L9Rg7TbA7U40Ep0W/sEcWlwZzAdDXbDrD9h437CL7Dc+bKrz1VnA=
X-Gm-Gg: ASbGnct8bEFu/ZQGPaXIZczIx/ofcAKE5WMAOBVjiKY2V/i88DyLpp+fX2bb8UFGux5
	9pkAETQfoqzW7a7+mbJyjv//afmirEu2X9loKtMyZtkmd/YzUDxMRVd75pFzMoGM1DrvgkU+sZW
	K0KQrh1FuV6H630jwpJ/UYuKgYvvZOTBIeSyWLe7+i0d2EZbxYK44TWo3Hy3dJj6EOxyXqTfaJx
	sPSAj73g+ad99EhSHlDL2tQOjm8h1F7bX5LCqZ7tLsofNNreSXJXYireiGHUf5dWjEqvfcYtXCZ
	HtCcss0ybc8gNSBeE7tNsYXn1D15xjBAS+UO/4ekNNA00f8gob5BBKxmZJDvdeKHvUc4PHyTrhT
	7dirNGLQ0qqvTpNE=
X-Google-Smtp-Source: AGHT+IFwsqbb1rEd24wsckY1+KDaOixyeJmTQXPivaE2uZXRqBDhR+NeTCmIev7yq9yZGKWaYyUBJA==
X-Received: by 2002:a05:6000:310f:b0:3b7:7c3b:1073 with SMTP id ffacd0b85a97d-3b911014a84mr1715986f8f.52.1754987247118;
        Tue, 12 Aug 2025 01:27:27 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:16c8:50:27fe:4d94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3b9386sm43549423f8f.18.2025.08.12.01.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 01:27:26 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 12 Aug 2025 10:27:10 +0200
Subject: [PATCH v4 11/15] pinctrl: qcom: use generic pin function helpers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-pinctrl-gpio-pinfuncs-v4-11-bb3906c55e64@linaro.org>
References: <20250812-pinctrl-gpio-pinfuncs-v4-0-bb3906c55e64@linaro.org>
In-Reply-To: <20250812-pinctrl-gpio-pinfuncs-v4-0-bb3906c55e64@linaro.org>
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
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
 linux-hardening@vger.kernel.org, linux-mm@kvack.org, imx@lists.linux.dev, 
 linux-omap@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3269;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=chxUZAtCU37mhXCr4qzhIIkekcZb+5ZpnLwzXbUTM0A=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBomvrZTBy24+EiQ0I9n9YAoAtc9GJc+mIbjLJ4c
 dVv83dQyiCJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaJr62QAKCRARpy6gFHHX
 cnS7D/42s+kq9cudWSpcHFuc0USVQTKWUm9m7Hr3iADyqxdii9U6wnmYgtkZeD/gBnn6eZBEVM8
 936OPO+6JoHACjR+Mrib1JBKvn+2EAhtvOxa2y8krmNl8HTrOwK24miaRuyQryIP2PDaUu9a/0v
 CCXeG9pcuY0VlCVndCfLAIvMBtoaf435NUcJbfRAUA1pqIBnAMgYNXixlJA8FtQj1cHIXYnoz12
 NRcDaJrJJQBNezG7RIxA0m4pc7nknsJMic4H6VJuhEEDURLIX11SZosiXspOqRzpyjWrifX9JKM
 Ir+XQCb4e9wFmhsQb0WJyDW4DxOxxVHaxO9vl7HLgXd9OcX+TbJm6dmibj6OQY3tPabfLIv5t5b
 91zGUu5y6bJ4d6/+OO0qmV6kzCOFxZBaFnx2uqKVn+ubzX7Vb20TGm0ArDrHQT8cG/W3iKRJf7D
 j/tojt9LnoVrmeBXBoFp75tWYfAtotKruu+kgi2o90mx5CL3RgXe+BHu8kcgoLmyby/jSygW3ei
 uD4SzRu96+iIJLTUjRzqRbv6WujNxkKHdcXIXO1VNvLuJ/rY5DhvLN9VFlnYGI0Pi1b4vN3ZwtG
 ZqR5bOzeHuNC/KkCJphUX/v8hHAqRSHlvHv1oCenO2VC8TSwJ/RtpstfLf8KL5mLGj+tYmim+md
 2lrEOwVF6POBJpQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

With the pinmux core no longer duplicating memory used to store the
struct pinfunction objects in .rodata, we can now use the existing
infrastructure for storing and looking up pin functions in qualcomm
drivers. Remove hand-crafted callbacks.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pinctrl/qcom/pinctrl-msm.c | 43 ++++++++++++--------------------------
 1 file changed, 13 insertions(+), 30 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index 83eb075b6bfa1728137e47741740fda78046514b..96e40c2342bdedb8857629e503897f171a80e579 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -31,6 +31,7 @@
 #include "../core.h"
 #include "../pinconf.h"
 #include "../pinctrl-utils.h"
+#include "../pinmux.h"
 
 #include "pinctrl-msm.h"
 
@@ -150,33 +151,6 @@ static int msm_pinmux_request(struct pinctrl_dev *pctldev, unsigned offset)
 	return gpiochip_line_is_valid(chip, offset) ? 0 : -EINVAL;
 }
 
-static int msm_get_functions_count(struct pinctrl_dev *pctldev)
-{
-	struct msm_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
-
-	return pctrl->soc->nfunctions;
-}
-
-static const char *msm_get_function_name(struct pinctrl_dev *pctldev,
-					 unsigned function)
-{
-	struct msm_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
-
-	return pctrl->soc->functions[function].name;
-}
-
-static int msm_get_function_groups(struct pinctrl_dev *pctldev,
-				   unsigned function,
-				   const char * const **groups,
-				   unsigned * const num_groups)
-{
-	struct msm_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
-
-	*groups = pctrl->soc->functions[function].groups;
-	*num_groups = pctrl->soc->functions[function].ngroups;
-	return 0;
-}
-
 static int msm_pinmux_set_mux(struct pinctrl_dev *pctldev,
 			      unsigned function,
 			      unsigned group)
@@ -288,9 +262,9 @@ static int msm_pinmux_request_gpio(struct pinctrl_dev *pctldev,
 
 static const struct pinmux_ops msm_pinmux_ops = {
 	.request		= msm_pinmux_request,
-	.get_functions_count	= msm_get_functions_count,
-	.get_function_name	= msm_get_function_name,
-	.get_function_groups	= msm_get_function_groups,
+	.get_functions_count	= pinmux_generic_get_function_count,
+	.get_function_name	= pinmux_generic_get_function_name,
+	.get_function_groups	= pinmux_generic_get_function_groups,
 	.gpio_request_enable	= msm_pinmux_request_gpio,
 	.set_mux		= msm_pinmux_set_mux,
 };
@@ -1552,6 +1526,7 @@ EXPORT_SYMBOL(msm_pinctrl_dev_pm_ops);
 int msm_pinctrl_probe(struct platform_device *pdev,
 		      const struct msm_pinctrl_soc_data *soc_data)
 {
+	const struct pinfunction *func;
 	struct msm_pinctrl *pctrl;
 	struct resource *res;
 	int ret;
@@ -1606,6 +1581,14 @@ int msm_pinctrl_probe(struct platform_device *pdev,
 		return PTR_ERR(pctrl->pctrl);
 	}
 
+	for (i = 0; i < soc_data->nfunctions; i++) {
+		func = &soc_data->functions[i];
+
+		ret = pinmux_generic_add_pinfunction(pctrl->pctrl, func, NULL);
+		if (ret < 0)
+			return ret;
+	}
+
 	ret = msm_gpio_init(pctrl);
 	if (ret)
 		return ret;

-- 
2.48.1


