Return-Path: <linux-kernel+bounces-790334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2769B3A565
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 18:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A51BA03316
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 16:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B5E2848BD;
	Thu, 28 Aug 2025 16:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="co6w3OTX"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23BB27A451
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 16:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756396844; cv=none; b=NBRLyOWNw+dPDPiK4kQM8aLoiJNOi7q6mA0BfGTo6/WyNI5McmvOZ/E3H2LVorTmtpW8ViLE/YH5qd5uQY4XwOxSoIah8NQHle0dwpkjt+Y4BpyedL1qtxApkyOwu8kLn4Ru+j/L44i9S0IdJ8vrl6xMbG1I0vWPzSBHmKlEjv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756396844; c=relaxed/simple;
	bh=gnGkjaHtZR5cG1YYWSUpvgHnNwtSkmlkHkuvNgBor9E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UDDVfm8HtegXCtXw7WNWGtfqn3WSQhYsM5txqCKULlu50BangEL833YbCe2q1v2+ccylAMPs47BzbEBas4ojDyi8Ms3UBVzhTkM+0yadG8egOD6pFmMxZDz5krkxvnaQnrKOpZYxaAq2UI3NYnX2SUl5pGECYx6FSAFBih1e8Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=co6w3OTX; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3cef6debedcso90491f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 09:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756396837; x=1757001637; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kyDGhfJgrh4J6gn9SuBfsKVPoVuurUg4MDMRSiTssr0=;
        b=co6w3OTXKX99n90RpI+O1BHXogGfoKQExgalVQDbJqJPuvxO79Y3WjrQAwS6lIb2JR
         v/htFMBrtxrEyzLUaSstUdMVLFOXMjK2VFWYF8EoNfEPGYsnoVvw3koF/mGkKIM6uZxP
         Zh9PK8J1NbnynjM6tk80h+VIWgUAypUFOe7ng1wwdZLmMVYcla7PSNeRtshnaXqBLRTq
         qA5n1hzrjHE2GKhnMMuNZgaiA6vYA7UUAzu/GBUH6wtiSCKUdAedUg6ggQD4Q+tEN57j
         OZbtXILxQqaxee1l04hyiDPsFkoIvx7Aochq8PgM7hPY0pe/QiEuvgRTUSS8rKtOUcIz
         pIrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756396837; x=1757001637;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kyDGhfJgrh4J6gn9SuBfsKVPoVuurUg4MDMRSiTssr0=;
        b=b0Nck/disttj2v7Gr65s4gbA9TW4VGkxhXRd2rpLfARhklxWRYNntltJ1yHA7kd5tB
         mzvkF8vZ3Ut+aHLaf09X/2l5pGUPEOiPZWtrKk5undblESVo0dV6IIXWZ4ZV44jpSxCL
         Cha50q2bI3XoEW0co8cL7g2Ydg15e7a0kbgeteNCHNDryFSX7XRt43zBpSrBCjjyMEmC
         zos2DU7sHXsfZ99k9I2pouAy23sCyVpUukBza9XG0T9qUjuicC6e+gykOTcAMm+xA5Hm
         9WFzN97PA8623w19EOuNPh9zCpiVW2pqifwyHkRRhEnC6RlPHbhouQgRvl7k9yXQK0IG
         6uow==
X-Forwarded-Encrypted: i=1; AJvYcCUKBqcV4WarCdBsAOk0o9F32ZyHMAbEmWMubRfvb46TnXYhedzxAKPa6YlVld0FJseq4JbUH04TcKZIGdY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGHoC3jBDEIsYG9xXdwY1gAPv1bkcFKDimtxuO6tFoCUNKLv+H
	Chju4BfXx5e7+mqN2J7Z8xWAcx+4A1bMoi2hjbu+RbeHNXjlcFyhnmc7niCnvDSiBs8=
X-Gm-Gg: ASbGnctMk3cYuliiYOefk1QKgJZsWUB9wauOHSyeV1CNgxaipimO+s4Sckvd2HQ+9KF
	9pJIoWpJs29uzyIG2you3modKHM9mkxD938i9sIs2EMaoxWH6qvaGfKljP4ejp3YBtCWKznsSTe
	E2UfpgLfTqt1xX7bFpjfpHtxo7RVzI3zWiZqKaF2DLwgh+cw1eDhHnJ81WKArMSJcX1iSc/1Qb/
	cfS86dUvfjHE7DQqz/No8NwdAxSM/O7KYg3vw+MP52BwQmZcaNhP2EknYmAX9/Dt5tWH/raMTPK
	gbxGOMsGoSVYiiSGrDyxFjaP87WwGVXtkpOdmUMfasEO6gx2or6FRQ54FX5HcZoicheujsgQnv8
	DkR4rXwTjQLMFh8NP6Q==
X-Google-Smtp-Source: AGHT+IGRb2IFrJR7/1J+rjeNU8GkVEAEf5qNguD6R0jJVoV6aqw9N3uve9t0ub2p/g9PXQeEWnV+2Q==
X-Received: by 2002:a05:6000:2403:b0:3c9:1433:f8c0 with SMTP id ffacd0b85a97d-3c91433ff3fmr12100077f8f.7.1756396837431;
        Thu, 28 Aug 2025 09:00:37 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:4933:4d7c:cf69:9502])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f0c6fe5sm80211675e9.5.2025.08.28.09.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 09:00:37 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 28 Aug 2025 18:00:19 +0200
Subject: [PATCH v6 11/15] pinctrl: qcom: use generic pin function helpers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-pinctrl-gpio-pinfuncs-v6-11-c9abb6bdb689@linaro.org>
References: <20250828-pinctrl-gpio-pinfuncs-v6-0-c9abb6bdb689@linaro.org>
In-Reply-To: <20250828-pinctrl-gpio-pinfuncs-v6-0-c9abb6bdb689@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3751;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=qmbs27ufzmC16v+sdcPEY4dDQY3iNSX16sXKxiePlDE=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBosH0PnC9WMdqFML1hS6pX4Ax7d8FKU/1NETcnI
 wejv8+DrUOJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaLB9DwAKCRARpy6gFHHX
 cgUlD/9h+MbAVo/wpsAgGFq0gzUJAW9nwwGnh2UUoj3Kqv10EutSXw2RS8/j2v+ITd4A7ABEv04
 3e7T9KxIfgTGIQNStI/av47LGaFQoanqW1bbicRWetgfw4ov9Kg8DBWxmiM38ucKX0TH0B1V0DZ
 1ickY8HG8BK6FO+qam8qf//7NJ03enn6xAFDsdu8gsOOiGGf/TaB+M09CpUjTROpxx4kOdwoyRd
 7KEgzKdp5nr/aTr/5ymPx+D4YvdV3g8g7zKgpOv7sNzlh6q4eHpIyRXfSLTNFfMEK27gs3RfQiu
 nFjbrmBC/Cm0Dx3PtrZoiuGFLIynOHFozfI8W1nxeIcTH2drbiUpQM+PMyzn6QwdQLyuYsWIIp4
 P97TifYj25rmdWejAC7ce0M/MUr6ym5k13HkeDFMueER//pdQh2BB6H45PG9So0YrhSESCqN3TL
 0rgOdRqufzPjxELShQhA8C5ca/bWsVuYWVY2lPBJxS7oqgJQ7yO0V9lityx55QhQweeXFlkDOCa
 odj5YLA2Ua9lK5nhrpJl4Pm++PVW/VroLuBJuEtg8pEYp5QOywE1m2GdXhZxMn4fOMb71Iy8Ye/
 YCmOhCxdeaxT35vIe0apm4cT9JEQFY8JhotGnkxa3p+cTEYqk4BreR/mYrEtQrZJAOXNvDQXIeL
 AWgGjt+UZOIungg==
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
 drivers/pinctrl/qcom/Kconfig       |  1 +
 drivers/pinctrl/qcom/pinctrl-msm.c | 43 ++++++++++++--------------------------
 2 files changed, 14 insertions(+), 30 deletions(-)

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index dd9bbe8f3e11c37418d2143b33c21eeea10d456b..f7594de4b1e9b95458c2c817e1158026a8006f64 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -8,6 +8,7 @@ config PINCTRL_MSM
 	depends on OF
 	select QCOM_SCM
 	select PINMUX
+	select GENERIC_PINMUX_FUNCTIONS
 	select PINCONF
 	select GENERIC_PINCONF
 	select GPIOLIB_IRQCHIP
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


