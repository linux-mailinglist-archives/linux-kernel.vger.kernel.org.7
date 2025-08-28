Return-Path: <linux-kernel+bounces-790329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 953B1B3A548
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 18:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F37661C85064
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 16:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD78926E706;
	Thu, 28 Aug 2025 16:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="bAkBz729"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6BB202987
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 16:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756396833; cv=none; b=Y6VFGabcXKM5cWxxOtUmqyie26drbDr4aZ6cHXgWLKjtWpM/dtl9+SEWUQTE8UTc3KTHQ4lsDoG5uucRTrxl8z7nfSXaP1BLUMjbepkc/vg4DMJlsW6H6Qmps3H1s9WG4DSIaywA2J8ebo0z+IEdxm4pGMDZTYRbEk/hD2lzxUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756396833; c=relaxed/simple;
	bh=LOBwL8GyhXn2amKnj3tiisTz16R5MdNDH9LPyd5t80k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aLHbam+R8KM5SuRczgj45adiZv6WcP7cMNRnVt+LlctDUQgE9s2N7QtmCRi7LraIigGnSZVqshU49v3tjjd1uV1sfZngnU/73vQROB2SsmsT2yhwb5JG/ab1g5pW/B9cTHC5SaGT6HrzO8icOy+XtzetD6TUUZq1oSImwlchhyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=bAkBz729; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3ceb9c3d98cso257327f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 09:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756396829; x=1757001629; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jR/UQSU1rnoJqXet1GHMjYE6RZmBJb0DIB3rVaGeplw=;
        b=bAkBz729KqGA1mppmHfjaWmWEV1buUOH7bOsnuvy/egGQC7RX3nyLOPpzNiIP09UHw
         KqFhISKOclNCLiJYIqrBKmDGC7xyuadAxgGltVZwOhBds9gJ/r9CfgFr9xJQQPY4PiWF
         IFv+I6vgU1ut7uK3/o3m1Yq9URIf6TkBhHVovIcfdSLy4BEZQhDyDpJVbWZMFnTa4NlB
         fmsrW6Yqr82wmGvsmcpJSI6o/LaGd5ZyvZ4wwHmLAif9DXXVmGBGDpt3A/K/5/mq548B
         dU3LFcaky/sPKSnVOEEM7Vg6JjaxgzlAWoaoKN4qqpN9UzB35EiHj/+RPHCwKULY3yb4
         IlJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756396829; x=1757001629;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jR/UQSU1rnoJqXet1GHMjYE6RZmBJb0DIB3rVaGeplw=;
        b=qkn4ndiaT298PRjUcEFJTpEWDS4TlIlEBkqauq0H/cN37DAZ4Z6Dw/dQVAGd/K5yZi
         ekZlL4Jh6fajtsrmEhD9TVWd7v2NWhJb6j37c12UXQu8ljM5OLhjDM56dniNTrl2ii3S
         G4AscjAr63dXUeQ+ebfEaMNKYC8/suiiNcOo8QLRUgFFKZ9CcQQ553HjLcVyedv0n+cl
         /pNcZT7jKIuk1iGaJjc5Ff+utRQiODAmSX0GKKAyPDVZe2XRgROGipQjBh+dWNngPHcF
         K36bvvyynf5oZut5OG53tpJcQOh2TbqczRfkCeHljXjJt8x48Efc5GgfofwaMyj2iaHL
         aTXA==
X-Forwarded-Encrypted: i=1; AJvYcCVrOv8LAtwXm0eo+ZT8mPGqVkmnwyaxo2iKqkuG+0hSX94Zpk91So3SdeYZ3sqLNG+6PaJ1VnmZRoJxGbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHV4HJzEuLiXwEc0XeblO9ovR9e7mvJuCRpvz3fGZes3Pp70dP
	2ZjCx9d+FoIPm2z9mjMA3omhvt1o+S51xFKLVJQiZCKbuftbU9wMaMs/q9drfqq93AE=
X-Gm-Gg: ASbGncsTgEMmTpt4bXjYOgV2tmqV0N2EU7mQbB/sYX3fI1xCFZ8kuOmZUBcEcdciABQ
	px+bzoqzAe1lHx/hRqF0NeiAW+yQSVAnHs0sSEBIZmDQIA4POqanjgcTi59QwE8NferccF7iFI1
	eMtfgo7LZ00JiidWwlNvPSbdrltK1XniQ1XRT8t320mZfyp54Xo56WV8GxVR9N7rqgIUERUYGnB
	G43ydx9zvTSceOXGpRKZmaltWGBfqy11QF+P4e09IbPQF+uI9wEWccxoZQk1T/ngEpGZBbfKVW3
	ZMkFBGTyhBYetIJuEcNHyIVNCR3Ymy4x26uejGAnBsZz6NRMuQd+RRDo366z9gKfuRvY3o13Zqx
	FJAp7pFrGQLMBoYxnKA==
X-Google-Smtp-Source: AGHT+IHpa7seq9vvwG4pSrNyoWglcHVRKIa3k9MGizj9olBncMjomjsG4dZCZ0gf35TjhrILqQH5rw==
X-Received: by 2002:a05:6000:4029:b0:3c3:806c:b82f with SMTP id ffacd0b85a97d-3c5dd0ecf8amr20776060f8f.58.1756396828557;
        Thu, 28 Aug 2025 09:00:28 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:4933:4d7c:cf69:9502])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f0c6fe5sm80211675e9.5.2025.08.28.09.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 09:00:28 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 28 Aug 2025 18:00:14 +0200
Subject: [PATCH v6 06/15] pinctrl: imx: don't access the pin function radix
 tree directly
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-pinctrl-gpio-pinfuncs-v6-6-c9abb6bdb689@linaro.org>
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
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3140;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=64CEOM/GWFRZVaWr+uKwrz1KsAW3NNZpIdWvwWCf200=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBosH0NaAPsNFFrpH1CGMcLygHSJdcPneCN6Unyj
 uWMtG9dPUOJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaLB9DQAKCRARpy6gFHHX
 csz2D/9MgJP+ectOeSj5tPh3IRoQSIVu4AU0U2BIk9qLJsstYn5YRISv7Lr58AGRakRZh0m8/iL
 nNYJSQ98/gglKMupuS/yKusX9iGKVWnw8cqQtR2qBPGmRcImx2/9e7HLfz7CCVT/iDAjPPeMjUg
 YyeBqbeDoAKR72CednspSFx12VxQ7Ja4n65O2y2fjtejtwiGFuNvud6b8+pa/eKxHeIkigHEh5/
 T71+1u33HaK5IxJVGK5qUbh7pJm+lSgmHzuPOJN9R8CcQO6lPBSWP9VXM63VfHNUfkyoPokJSyz
 Sxf/B6Qkyzd49YG3csk8gtZiCCKGeJeBgbEt5oY7bbuS4sOICYGYc42MEa1akallSWRvGv6LRxt
 VSBbX2tu/t5fI8EdOgROdf0H+VFhKPpz5Nytk6raLEJDU0dwyqO+Gnj8gGhHxOb8i3xBVJAN3+e
 oE6PlAYq1yoX/GSVH5H4ADkWHVGM922imRvR15JI7TpVxnLWaGZ0chIV87cWv3rtvcLtI5mW2Fr
 B+7CeIdbYV9gHFjqLi6dmVbK4CJXBZS8z/5DqhmeKNRvDwYkxvZBUfHoz6MdXw3oLpMfA7kO2Ar
 g9WkATffjdMY9P7gz7AyeDLdWVlb4LSx5uyzu3rOuNrmxYeEg//XgZ5loqLh0eTb8Oth0yRUqaa
 tb3/62Fap1QUnSg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The radix tree containing pin function descriptors should not be
accessed directly by drivers. There are dedicated functions for it. I
suppose this driver does it so that the memory containing the function
description is not duplicated but we're going to address that shortly so
convert it to using generic pinctrl APIs.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pinctrl/freescale/pinctrl-imx.c | 39 +++++++++++++++------------------
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/drivers/pinctrl/freescale/pinctrl-imx.c b/drivers/pinctrl/freescale/pinctrl-imx.c
index 18de31328540458b7f7e8e2e539a39d61829deb9..3d626d8c9ae9ebd5f7eb76216924c46b34233749 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx.c
@@ -580,33 +580,38 @@ static int imx_pinctrl_parse_functions(struct device_node *np,
 				       u32 index)
 {
 	struct pinctrl_dev *pctl = ipctl->pctl;
-	struct function_desc *func;
+	struct pinfunction *func;
 	struct group_desc *grp;
 	const char **group_names;
+	int ret;
 	u32 i;
 
 	dev_dbg(pctl->dev, "parse function(%d): %pOFn\n", index, np);
 
-	func = pinmux_generic_get_function(pctl, index);
+	func = devm_kzalloc(ipctl->dev, sizeof(*func), GFP_KERNEL);
 	if (!func)
-		return -EINVAL;
+		return -ENOMEM;
 
 	/* Initialise function */
-	func->func.name = np->name;
-	func->func.ngroups = of_get_child_count(np);
-	if (func->func.ngroups == 0) {
+	func->name = np->name;
+	func->ngroups = of_get_child_count(np);
+	if (func->ngroups == 0) {
 		dev_info(ipctl->dev, "no groups defined in %pOF\n", np);
 		return -EINVAL;
 	}
 
-	group_names = devm_kcalloc(ipctl->dev, func->func.ngroups,
-				   sizeof(*func->func.groups), GFP_KERNEL);
+	group_names = devm_kcalloc(ipctl->dev, func->ngroups,
+				   sizeof(*func->groups), GFP_KERNEL);
 	if (!group_names)
 		return -ENOMEM;
 	i = 0;
 	for_each_child_of_node_scoped(np, child)
 		group_names[i++] = child->name;
-	func->func.groups = group_names;
+	func->groups = group_names;
+
+	ret = pinmux_generic_add_pinfunction(pctl, func, NULL);
+	if (ret < 0)
+		return ret;
 
 	i = 0;
 	for_each_child_of_node_scoped(np, child) {
@@ -615,6 +620,10 @@ static int imx_pinctrl_parse_functions(struct device_node *np,
 			return -ENOMEM;
 
 		mutex_lock(&ipctl->mutex);
+		/*
+		 * FIXME: This should use pinctrl_generic_add_group() and not
+		 * access the private radix tree directly.
+		 */
 		radix_tree_insert(&pctl->pin_group_tree,
 				  ipctl->group_index++, grp);
 		mutex_unlock(&ipctl->mutex);
@@ -669,18 +678,6 @@ static int imx_pinctrl_probe_dt(struct platform_device *pdev,
 		}
 	}
 
-	for (i = 0; i < nfuncs; i++) {
-		struct function_desc *function;
-
-		function = devm_kzalloc(&pdev->dev, sizeof(*function),
-					GFP_KERNEL);
-		if (!function)
-			return -ENOMEM;
-
-		mutex_lock(&ipctl->mutex);
-		radix_tree_insert(&pctl->pin_function_tree, i, function);
-		mutex_unlock(&ipctl->mutex);
-	}
 	pctl->num_functions = nfuncs;
 
 	ipctl->group_index = 0;

-- 
2.48.1


