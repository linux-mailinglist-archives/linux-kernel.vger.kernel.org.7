Return-Path: <linux-kernel+bounces-743945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 720CFB105F1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF9351CE34AF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC57B28C877;
	Thu, 24 Jul 2025 09:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="VrMZ/WCk"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D3528688F
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 09:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753349097; cv=none; b=DITo1kVtB2lRAwOHfFqdNRTSDwWggoCsgpUwQm4Et3JMwxgsv9Dk3vFH/3I4u1ayv8mUmPfm+5rN08/vt2KPtH1PBtPtWbZ8UrTlskAKmri//a5nptebDmrFpqVAaqyMI6POQ/RnzbA1idTRoPGL0cHSn/YzFReE2PFEd1wGzZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753349097; c=relaxed/simple;
	bh=pN5GV9RpnHxQpsk+HalHBbLE8eiH2GyfU9FRFfex0qQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E8tcv70hKfgd/NnYCS877FiRwGfZG5A95JzkNP2NH3qa40MyP6zQrggvcc5/wCz1KPZ43RlyF/t6K1WmwNNrHhFKWTZYhqc7LIjPMLmM9ZhLcu/iIPZxzwDZeTvXYD1ecT2w97BIzFPuAcX7SEv32rPV5V23SaPTEZeMeS0SjdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=VrMZ/WCk; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a6e8b1fa37so604237f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 02:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1753349092; x=1753953892; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jKjrihfR5UlU8kWog9NeCNGGbmct3fE4f6uM9NGLS/8=;
        b=VrMZ/WCk8DpqIh/zsLs6nqZpOb48ezmpASa/Ot6P5HKpBxuG12Bq5F9KBFr3q+GVZH
         dIbVAVtQNJf6yiZm8OocRFqCvBNaeThVLV5O0HlypYIa6v23XTeJYCAIcCzgIinCuaYg
         kQ75s5ZPk2ocYakoPANQPEOCchXR7vWF8U9pA0P6y3tGBnDqSFMAL35U02/KZWLLM3XV
         /dulXKICsCyrmLHb0x+b1ZmLdLpu3fEHIZO+fs+PrmmPCtQ3T2NoFXnNd4yb/D/cjQPc
         rd1AuMaHVHdKLqUiwK5AF3OZndtErrAApE47kPWSpEaipleyPxOOSqGDy3xp0P9YV4kQ
         nPrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753349092; x=1753953892;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jKjrihfR5UlU8kWog9NeCNGGbmct3fE4f6uM9NGLS/8=;
        b=rWrV25dC826C5efKOw+clLq73ix0U8204W/hujyoN0zWEUc7czMERXnkQDQH6BnMzP
         w8ZIS2ni9TcI7xu76eSaEhp/7rUO62gaZhc3QX9CiN0yDxstZtmXOyy00eqXB0AhOa9z
         Bg3l3MS6xB7ztbz0uLlPBh0Qdbly+fAmd4ZV/lPWmVRlB+2MvhXjbsEa1UpIMDPW65jV
         OI4Gh3JjhwJqwDAGTuBEU/TdRFNpFnzsXMYiTz92Q20bgAd+0aTYBEJBC6vbUmxUfE+H
         J1Lp9PoEECVoNJ/fWXefBeEfNmjlBUWKygi1569gnVyQluMlRLDFEsa66tjK9D0wVezO
         IhPw==
X-Forwarded-Encrypted: i=1; AJvYcCVE6Auf8bI0k/IbK+y87Ax0xaDPaf9GLt6jrcvDQYCQ+vckKNrxOKweL7gZJUqdfkwuTw3oRpC70bRrBgA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1TcJi/CEIOaLWPXfX+GowJDFIBWzyLf0ZmEM7gtGJrOLwMZdN
	bsebOYsG8196zBxcV0Z1BkM/UaBi4m+PvQJpIdaFZ38I55Z4l3YjZzAXphr47lbCrjg=
X-Gm-Gg: ASbGncu/x2F38RHS/U9Y0mOS53M1VLv1e3428V1r+6299cOOLP7ujdmzT2pHBk/cJ6U
	s4VrlsU0LqIogfYgtA3xc2A3REg3l0HgyNZY3j6KBrgng2sM062GWz5dmjEwO3UTTi+TbgqraTa
	G0HZBD2SabTK/lCqnAU8vCc7XkpDpfymL1Ij2KtaHwubDBPWsrk3MZqYoojXV7JCHfZtc4lN1s2
	fDEScdbhYRVQCJcD521HbYmIjVKBohqEQNPilb6sD2HJG3gDzjglL36x52c6Fwo7YaGRQ96RnkE
	5LoOjvG1xmLWuFJB3CYcGrn4jVdWoAHmomtgLDLyK6PWnYKR7xw133wqFIkPSlBCUiijIXEz1ki
	X+VJ2mR10k71ZLZkf
X-Google-Smtp-Source: AGHT+IEew+Sp6i4Ubvb4XcJSx1ljbxjsNF3zWCFZCTjc0gm39mQLURSOD2KwaMMXuMVDrNvP/L44lQ==
X-Received: by 2002:a5d:5d0e:0:b0:3a4:e1e1:7779 with SMTP id ffacd0b85a97d-3b768ef8e49mr4370503f8f.32.1753349092060;
        Thu, 24 Jul 2025 02:24:52 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:f44c:20db:7ada:b556])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fc72548sm1600833f8f.30.2025.07.24.02.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 02:24:51 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 24 Jul 2025 11:24:36 +0200
Subject: [PATCH v3 08/15] pinctrl: keembay: use a dedicated structure for
 the pinfunction description
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250724-pinctrl-gpio-pinfuncs-v3-8-af4db9302de4@linaro.org>
References: <20250724-pinctrl-gpio-pinfuncs-v3-0-af4db9302de4@linaro.org>
In-Reply-To: <20250724-pinctrl-gpio-pinfuncs-v3-0-af4db9302de4@linaro.org>
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
 Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
 linux-hardening@vger.kernel.org, linux-mm@kvack.org, imx@lists.linux.dev, 
 linux-omap@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2974;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=F6LdqVWEdZj3r0RjhnhQHFPIp/g37mzkevNQE3gBMmo=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBogfvTVpmOt4llz/Wm2IBwGqzmLiabzjvGkJwgW
 9xjEp8YqIeJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaIH70wAKCRARpy6gFHHX
 chw1EADi1Cwma2fZbyAAR08OmSEvcij1RMAppSgkXsomjoqmNxyiDsx/Czg2kRyC22gO9vwQqkT
 Uf/mb5otj++jYRqhZyvV7MclKnpF4WwzdBXRBa/WHPlSYG07T4/L1hGfsvls07EILfhNwIL+RPM
 /BUWIYNe0zfbRm2xmCJtmf70uzw8rin45jOPKTrMJnSO5HNsOg5RraEPuEddueRGcFbej7oVsGa
 ElSq0O8joGSLsQKHwmLLyGg9FmyG1OrfkGdzcGW3WxAYqAyYGWiz4IP75vvmPP6Rah9aJVV182n
 x6nLwVmRbj/a+snxdIZyIHA9DirbuUWpqoDun3Yhi8UNTJK4/AsV2qWTaiFV/iPMkKc1Q5W5uej
 2p4P77moT4hVppn+wdj8WyzOnCAozcG9fsb7yyo9f///qd584AZtQy3UuZoQdGlH5BMZEBDRVqr
 UsfF9FOpTq8wcoxRwm+rG0j6Zz5DwVaGlApq2J6uGGvSEXcNBgjYPPJATtkjx6DiPzUM9szzMxC
 PRu8c4ZcRcemfjr/JMdUW03WNHm/BNiHcLF2SLd0Kh87tiUTRC4cq1hT7OF99/ZU2Fshy+5NK6G
 Brszu+Qp0v/qKUnyO4BlTlEZBbGUIYaN2H2+DwVoaNGBQQ5RPl6WhcYO4E244k9qEQzG2Etk5E2
 j0z9HYEHrL6J6qg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

struct function_desc is a wrapper around struct pinfunction with an
additional void *data pointer. We're working towards reducing the usage
of struct function_desc in pinctrl drivers - they should only be created
by pinmux core and accessed by drivers using
pinmux_generic_get_function(). This driver uses the data pointer so in
order to stop using struct function_desc, we need to provide an
alternative that also wraps the mux mode which is passed to pinctrl core
as user data.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pinctrl/pinctrl-keembay.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-keembay.c b/drivers/pinctrl/pinctrl-keembay.c
index b4c7b3ef79e0a34111f46f23adfee4c269e5be6e..060d64ff3d9f01ecd3374935af66b55c38f60d67 100644
--- a/drivers/pinctrl/pinctrl-keembay.c
+++ b/drivers/pinctrl/pinctrl-keembay.c
@@ -135,6 +135,11 @@ struct keembay_pin_soc {
 	const struct pinctrl_pin_desc *pins;
 };
 
+struct keembay_pinfunction {
+	struct pinfunction func;
+	u8 mux_mode;
+};
+
 static const struct pinctrl_pin_desc keembay_pins[] = {
 	KEEMBAY_PIN_DESC(0, "GPIO0",
 			 KEEMBAY_MUX(0x0, "I2S0_M0"),
@@ -1556,13 +1561,13 @@ static int keembay_pinctrl_reg(struct keembay_pinctrl *kpc,  struct device *dev)
 }
 
 static int keembay_add_functions(struct keembay_pinctrl *kpc,
-				 struct function_desc *functions)
+				 struct keembay_pinfunction *functions)
 {
 	unsigned int i;
 
 	/* Assign the groups for each function */
 	for (i = 0; i < kpc->nfuncs; i++) {
-		struct function_desc *func = &functions[i];
+		struct keembay_pinfunction *func = &functions[i];
 		const char **group_names;
 		unsigned int grp_idx = 0;
 		int j;
@@ -1588,14 +1593,14 @@ static int keembay_add_functions(struct keembay_pinctrl *kpc,
 	/* Add all functions */
 	for (i = 0; i < kpc->nfuncs; i++)
 		pinmux_generic_add_pinfunction(kpc->pctrl, &functions[i].func,
-					       functions[i].data);
+					       &functions[i].mux_mode);
 
 	return 0;
 }
 
 static int keembay_build_functions(struct keembay_pinctrl *kpc)
 {
-	struct function_desc *keembay_funcs, *new_funcs;
+	struct keembay_pinfunction *keembay_funcs, *new_funcs;
 	int i;
 
 	/*
@@ -1614,7 +1619,7 @@ static int keembay_build_functions(struct keembay_pinctrl *kpc)
 		struct keembay_mux_desc *mux;
 
 		for (mux = pdesc->drv_data; mux->name; mux++) {
-			struct function_desc *fdesc;
+			struct keembay_pinfunction *fdesc;
 
 			/* Check if we already have function for this mux */
 			for (fdesc = keembay_funcs; fdesc->func.name; fdesc++) {
@@ -1628,7 +1633,7 @@ static int keembay_build_functions(struct keembay_pinctrl *kpc)
 			if (!fdesc->func.name) {
 				fdesc->func.name = mux->name;
 				fdesc->func.ngroups = 1;
-				fdesc->data = &mux->mode;
+				fdesc->mux_mode = mux->mode;
 				kpc->nfuncs++;
 			}
 		}

-- 
2.48.1


