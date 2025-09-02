Return-Path: <linux-kernel+bounces-796352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC806B3FF25
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACA821B2787A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C39311974;
	Tue,  2 Sep 2025 11:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="rKvuVv1G"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E106C30F555
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 11:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756814368; cv=none; b=Em6Dy3UjtM7C9fz8RJT0wV+lqkB4Me6Sb9xpjCI9Dl2bASrS9Qbq0S/d9onyYXl1wbnFx6Ohu60c4Gh56H9+pVvcFEFA0sFk4RwOPQleQgEvW39EvFJqmWDDgIHh4jJYmpqSBcposRKKRwf319nBLR1a2w2PcX1X5nruWV8aPd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756814368; c=relaxed/simple;
	bh=1Pr3q9yjXNf2iBsjHD0NIK47nOJbqENWNEx10XqPY9A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f90uMys3y7YRW7TJX54dWeE94QoEVETGPbyDxgI4M/8UE4WE1ev34tKTkR1rIm5dWSnKeMcIFDJFB2lfETUEtHUZlvK66FkiyDmig6+dDpOdLOrMo83ItWqDYinesfapOClzK7ObJUw+8kH7a/I/nRq/B3wQxIzRGKyGjPZ+OHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=rKvuVv1G; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45b8b25296fso15501885e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 04:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756814363; x=1757419163; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=frWO1MUM1iHp10hYQSMpeWUCufaMLUNxXxOHMSOr6+E=;
        b=rKvuVv1GYI1ozV2nQeP0CijcrTfWT79BH/OS1/0Xf6TiIO4sIQZHEFcHDNILSmOqoc
         SmC6FWkaYP76GasQKKSLCszEc7Aj/twNjd+1qTkzQxGE0h3Mtrh629jXPtY1pn3p4uAx
         Id4ak67RmzoPq8Ty+YzWQAzD8liXvmNkvCuH3TF0LxLyiJVGfAarMncst19KIbORuROL
         2YIv0pcnEiXJZjwXAdz4pWouPMYcqCZ5lpWWM6TikvAaoK0QCCmiwHDz7+zkDmrsUWff
         WpnOYYC95smExnRJWS1nM1Psgq4OIJ3Hg46qc/v1jHsjjlmml4Xr//A3RA8isViJ5zQw
         B0Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756814363; x=1757419163;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=frWO1MUM1iHp10hYQSMpeWUCufaMLUNxXxOHMSOr6+E=;
        b=mC5Bdn6dAb3wwLhO5v1LL23/94B9cKlc0JvbTNEiE8DJXnLsNmJHSAo8p6wFI3ibRG
         WXz9fTww/Zq2GMeXvtb9oIlT68FZ3bsbbeITx59Cm1cjnL3QKAgfrSrry6Fun0HqFGF6
         fICGGrFQfW7P1egFG2q0T+eMWreP5ky9iAAt/GavtoIhHw7KJ3vWebguF5xu1tDIuGXI
         awfTijUAQlhSr/PIcMyMNQZ/HRx/kLk1lcgJPMNa/uR8WCzZTSSUCcDvI6kkP7VffXvq
         hf4whmwdTAwTTl+W3nj0KbnP+8ANqEXM7enqYde3aHmrrw9xHrExfktUxwEDJwLQcgiD
         Vgeg==
X-Forwarded-Encrypted: i=1; AJvYcCV4gbSfv7Jxi5tWetN2su4rZtfzEXOAC4WztjtJi8+zv40aoW3EdfdRvguL0xKHlG594SWF+6mJ7+EHZYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXf3TDIMMh24538a7aniJ9jhglTTGorkqaGDrXi5l1qRUuq0e2
	DiBuxDf6i5bP1wEAunpVITJa4ObsqR93ofbSli5uBrrXTxZXrDIRJXRLKdNnj6CileI=
X-Gm-Gg: ASbGncs73mN1Qq8tE+J8Kt6pZjcqklIbgKhz103a2/hCafpBX6LBoSxM6bUoR6Ut5FY
	KxqRVmwR62rsjZYFGrYHSgSYmZSTTeODIdj5/qNia8LeTJuTPWVmdS/pmmovo2qiV2IluDSJ4K5
	S2X8n3G0hvaVaaLfHqpoBszmRBYksrZmNX09bTOfbZhDKsNZBonFTaptRDG11T3ot/8t6W3W/LC
	oFmAYEOv657E9PMKgDn/0KLqoZCsHpoPOe+K1YDkqraBQFDxqMlFXFlMg0TS/uITPMPJV3ZRgiB
	iXqHja0Oa145JDYF4yM3lH9D7ntgc8LNRCi5S5QMUiY7Rpi4TZ9siqTAcxfRcTqv/oX6N83/aYG
	0es5UtcQMuLFW6eiTtPQn70lOp5g=
X-Google-Smtp-Source: AGHT+IH0xKJNlyv4ZyEJNfQNwTyZdVQINH+cdoHboUNYQ9kgUCTDaVU74ZUCabwWO02Je54HFp0TUA==
X-Received: by 2002:a05:600c:3541:b0:45b:8adf:cf2c with SMTP id 5b1f17b1804b1-45b8adfd08cmr65485875e9.26.1756814362526;
        Tue, 02 Sep 2025 04:59:22 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:3327:447f:34e9:44f7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b9c234b24sm10224195e9.16.2025.09.02.04.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 04:59:22 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 02 Sep 2025 13:59:11 +0200
Subject: [PATCH v7 02/16] devres: provide devm_kmemdup_const()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-pinctrl-gpio-pinfuncs-v7-2-bb091daedc52@linaro.org>
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
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2225;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=/fPVmazhQjlUCOZ/s2UWyZhfkrmgQ0oqqeO6j82ecPA=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBottwSqkj5THulrOPioeZfQvwHNm2obXZdlx73n
 rLgQ+gp18SJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaLbcEgAKCRARpy6gFHHX
 cicBEACBSsEN+zHGYUqQzH0L1fVuUR4Uyab1CeLWPuBlfFDOeIdpOAiAwQMbodQXN0tUpDtsdfE
 td+XDUygwggIWKTi8v2mOwA6u592fDxYytsIYAIKlwnxlylnU1dq0YsxtPM2jn0E12ksyZRhxRZ
 fUAmR0hg5A/YXoadpFnbYagOSaf2hU+jiUmL4f4K+ypadqW1bAlVSzT6gI1r0pMJYfh7/3yX0PY
 YG5m0U1+PTJ7m3EfG8+corSJRAS78Sh2FtPt6tkxA7SvyTZCtkF+9hE6cIDbwl+EePrpvN350H7
 EFf+SVimrXeowCmoBm3yNNB1NmuPdUpEfzD5NZKO5RNzpC43CqCeDbSGBcJ0mJbKZ25CxZfucRO
 qSqYqC705VQLTtzvva16XMEqe9r+MoAoLj8CRWuiZqQ9X6/Q5UsCNHlK1x3nPumfgoDNaUvz45z
 Ag5VkkTMHChrka1WySas247IzRPM0u0mdh6XwAooEFp1tu73+eXbgiljzYdlNrgwFRfTawxE8Yj
 leay7ODBWo8jv5tzc2mdo2FJx7d3gfD7s0sqbn6ynztvSoE77DkPLxqZJOW+LO43En0NrOYz7w0
 5QL1qvQD9C/lNGCMdrGAQxAR68tpaPC8h6+FTYhcH0YAaO+EbJVergnm02z7RlL4YUSmUYKfxPq
 1bB7j/qtQY97tcg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Provide a function similar to devm_strdup_const() but for copying blocks
of memory that are likely to be placed in .rodata.

Reviewed-by: Andy Shevchenko <andy@kernel.org>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/base/devres.c         | 21 +++++++++++++++++++++
 include/linux/device/devres.h |  2 ++
 2 files changed, 23 insertions(+)

diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index ff55e1bcfa30057849a352c577bd32f1aa196532..c948c88d395607ff511ffa6eb0a75b7847ab9239 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -1117,6 +1117,27 @@ void *devm_kmemdup(struct device *dev, const void *src, size_t len, gfp_t gfp)
 }
 EXPORT_SYMBOL_GPL(devm_kmemdup);
 
+/**
+ * devm_kmemdup_const - conditionally duplicate and manage a region of memory
+ *
+ * @dev: Device this memory belongs to
+ * @src: memory region to duplicate
+ * @len: memory region length,
+ * @gfp: GFP mask to use
+ *
+ * Return: source address if it is in .rodata or the return value of kmemdup()
+ * to which the function falls back otherwise.
+ */
+const void *
+devm_kmemdup_const(struct device *dev, const void *src, size_t len, gfp_t gfp)
+{
+	if (is_kernel_rodata((unsigned long)src))
+		return src;
+
+	return devm_kmemdup(dev, src, len, gfp);
+}
+EXPORT_SYMBOL_GPL(devm_kmemdup_const);
+
 struct pages_devres {
 	unsigned long addr;
 	unsigned int order;
diff --git a/include/linux/device/devres.h b/include/linux/device/devres.h
index ae696d10faff4468a41f37b5d5fd679d4ff11997..8c5f57e0d613492fd0b2ec97dd384181608192fc 100644
--- a/include/linux/device/devres.h
+++ b/include/linux/device/devres.h
@@ -80,6 +80,8 @@ void devm_kfree(struct device *dev, const void *p);
 
 void * __realloc_size(3)
 devm_kmemdup(struct device *dev, const void *src, size_t len, gfp_t gfp);
+const void *
+devm_kmemdup_const(struct device *dev, const void *src, size_t len, gfp_t gfp);
 static inline void *devm_kmemdup_array(struct device *dev, const void *src,
 				       size_t n, size_t size, gfp_t flags)
 {

-- 
2.48.1


