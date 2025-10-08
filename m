Return-Path: <linux-kernel+bounces-845125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D20D5BC39E9
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 09:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFA0D19E2DAC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 07:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B773A2F4A10;
	Wed,  8 Oct 2025 07:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CrrAeZ4i"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E03F2F49F5
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 07:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759908688; cv=none; b=cZO1OpKiiDEZuocgkjK9G+wBHbl20Hq8hGgo3AYTyvcxkBzcsDqtZCl9hH+0yGYxPOuWVqy3NMAO2nqBKCRXJ5+yD9XjsguW5xHGp4e9T2Pffjgq0PvxhrmmjeuMyBwuBEFrJZ9W3IymUlVH3UaTfV5vhKhfSSHx4jpiKILdKjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759908688; c=relaxed/simple;
	bh=sgN5V56YM4qhVdHy0m6Dz/yGVt5884z/MxNndOF+8Hg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GmkmDS1sW7o8p2ns5IXDzwWTWa0PfIEMhVp0N3p7IoTuK9xEBqMO81ho/0ExT1P75SXFE5TAgmTb7Al8stDRmMO2A7J5ENKKTATUWhgIslveaZ8tW+tqBGFxo59iQwfqYkK/1IUNnfefP5StXqEu4X6kAzv2PvYc4g9oJDIrHa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CrrAeZ4i; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-57f0aa38aadso7789503e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 00:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759908684; x=1760513484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LDpFX1J+/TUvWrJNHxxt+1RfUZNV6gVxsd2JBSzQm/w=;
        b=CrrAeZ4iW1dDa2BngLDRhwtv77B2k+j8uzVrqvg3jNtlmvYgnxFYaLB0icpuhqZLFK
         dINpCJ6IjQed/kV8GEGAC0DRPmuWzBEoUP1x+My2+lkqO0f1kkTODtgMWJYZTgZeqWIv
         j/SM5v6TrkDLL7LizDX5lVsILYN6nvMuzvDXYOruekdvUJYCA27GqFJxn3Fr/yKwqbrV
         d5do01A/NRU4hIYaIITue7nx6Xz89xTpJM91AdEHjjj2tN9Gne9WLOqtIr8YmEJAGxx+
         SC2OkxSDdshm1E9S9xsU1oUuRWSyLiSSPsB5Qxgwl1sxL3pRccAvApyRYbBwDsJW7YY7
         KVLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759908684; x=1760513484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LDpFX1J+/TUvWrJNHxxt+1RfUZNV6gVxsd2JBSzQm/w=;
        b=Kn1JsktRKdwIQX2nnPzIcKXQZWq+1McClJblKJhj+CQugGAXvv+gnSOR6JH6gWLFhJ
         ADFIIO5EodWM0s4Bl5U5vzsrEbMT/xlMn1TCy/ETYp/jBFyqsEmcWAxrVwttp7Z5PXbc
         HNk+ZdjNnJIK0PmSsX2jL/m9Wa8fqiIhz/qOUPCP9jvlFVSScUb/T/suwagVGdxUCNiX
         TE8TGizzFHSiN8+kJxEzhRSIz04c+xylSGTQNZl0VMZTTx7YFLE1/X/6bMJmqiXg4kyq
         VkrA2v8yoY5HwhzWrMk4F4sEYcLtv9P27BuLPyV5+P5Np1HlYP6OActzCJCYKGXpfKLR
         sCXw==
X-Forwarded-Encrypted: i=1; AJvYcCVcEL5gcncY20vNoxwnO+kWaBjroCP6SINaUQJOaLe2G2i9iArBDcb7aTIrcinvZE3oLt6Sc5Cgvufg5Js=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdZrVojv7c2R4kH+olSQgaW8d2voiriTQcqWEW6leAnWGDSa90
	kjItXbLXJeNVml7hR1Qk2g7aL5XiSwgED3uDeJTaZr1lBfuXcKDTTqc5
X-Gm-Gg: ASbGncuxmHmlIuFWBts3/KvQHV+X/XMCuYO0GGUBGIJdUmmnFqH6ftt6DEG6LUZpa1t
	CDAGq383lQWi6OaZMYwbNDZthEVDiqMO78mxdVbIXajw/LAyKySKqzIclONcd8fv9VRkC2gxdjD
	x5Oc/+/5UwtiDjjdMPAqUOrH9pysgGUZmpeJOvXWeBxcw8w++zsazaTbh4ixwQ45etMMF9hvpFc
	3K59EIe/QbNoCwRvgmU2IB7vrLZoja7Pl+wQ6wJ2Iuf5aAxzynJ38YN6Eu8HArWt9XfNbjNYZg0
	rbvinpDOiPItgprjOvLjl3NrXmNl5RtZREj/QwNT0ppG51QT+uSTcZ5qnW78RMFkkEO19eDoxPP
	zuaim3obPp7tvCOOOnf3dCjLh5ouhKGxvbTsFLw==
X-Google-Smtp-Source: AGHT+IEDn+mOKOkExskkEHmiVmmAHBRTPG08XJfXi47qrRyipXy27ogpWUhWkyGqIQp8qUggurZtlw==
X-Received: by 2002:a05:6512:10d0:b0:585:1ca7:1b69 with SMTP id 2adb3069b0e04-5906d88b1d3mr616741e87.13.1759908683479;
        Wed, 08 Oct 2025 00:31:23 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0118d22bsm6911016e87.85.2025.10.08.00.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 00:31:23 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Sowjanya Komatineni <skomatineni@nvidia.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Prashant Gaikwad <pgaikwad@nvidia.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	=?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
	Dmitry Osipenko <digetx@gmail.com>,
	Charan Pedumuru <charan.pedumuru@gmail.com>,
	Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>,
	Aaron Kling <webgeek1234@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: [PATCH v4 06/24] staging: media: tegra-video: expand VI and VIP support to Tegra30
Date: Wed,  8 Oct 2025 10:30:28 +0300
Message-ID: <20251008073046.23231-7-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251008073046.23231-1-clamor95@gmail.com>
References: <20251008073046.23231-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Existing VI and VIP implementation for Tegra20 is fully compatible with
Tegra30.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com> # Tegra20 VIP
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/staging/media/tegra-video/Makefile | 1 +
 drivers/staging/media/tegra-video/vi.c     | 2 +-
 drivers/staging/media/tegra-video/vi.h     | 2 +-
 drivers/staging/media/tegra-video/video.c  | 2 +-
 drivers/staging/media/tegra-video/vip.c    | 4 ++--
 5 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/media/tegra-video/Makefile b/drivers/staging/media/tegra-video/Makefile
index 6c7552e05109..96380b5dbd8b 100644
--- a/drivers/staging/media/tegra-video/Makefile
+++ b/drivers/staging/media/tegra-video/Makefile
@@ -6,5 +6,6 @@ tegra-video-objs := \
 		csi.o
 
 tegra-video-$(CONFIG_ARCH_TEGRA_2x_SOC)  += tegra20.o
+tegra-video-$(CONFIG_ARCH_TEGRA_3x_SOC)  += tegra20.o
 tegra-video-$(CONFIG_ARCH_TEGRA_210_SOC) += tegra210.o
 obj-$(CONFIG_VIDEO_TEGRA) += tegra-video.o
diff --git a/drivers/staging/media/tegra-video/vi.c b/drivers/staging/media/tegra-video/vi.c
index c9276ff76157..7c44a3448588 100644
--- a/drivers/staging/media/tegra-video/vi.c
+++ b/drivers/staging/media/tegra-video/vi.c
@@ -1956,7 +1956,7 @@ static void tegra_vi_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id tegra_vi_of_id_table[] = {
-#if defined(CONFIG_ARCH_TEGRA_2x_SOC)
+#if defined(CONFIG_ARCH_TEGRA_2x_SOC) || defined(CONFIG_ARCH_TEGRA_3x_SOC)
 	{ .compatible = "nvidia,tegra20-vi",  .data = &tegra20_vi_soc },
 #endif
 #if defined(CONFIG_ARCH_TEGRA_210_SOC)
diff --git a/drivers/staging/media/tegra-video/vi.h b/drivers/staging/media/tegra-video/vi.h
index 1e6a5caa7082..cac0c0d0e225 100644
--- a/drivers/staging/media/tegra-video/vi.h
+++ b/drivers/staging/media/tegra-video/vi.h
@@ -296,7 +296,7 @@ struct tegra_video_format {
 	u32 fourcc;
 };
 
-#if defined(CONFIG_ARCH_TEGRA_2x_SOC)
+#if defined(CONFIG_ARCH_TEGRA_2x_SOC) || defined(CONFIG_ARCH_TEGRA_3x_SOC)
 extern const struct tegra_vi_soc tegra20_vi_soc;
 #endif
 #if defined(CONFIG_ARCH_TEGRA_210_SOC)
diff --git a/drivers/staging/media/tegra-video/video.c b/drivers/staging/media/tegra-video/video.c
index 074ad0dc56ca..6fe8d5301b9c 100644
--- a/drivers/staging/media/tegra-video/video.c
+++ b/drivers/staging/media/tegra-video/video.c
@@ -123,7 +123,7 @@ static int host1x_video_remove(struct host1x_device *dev)
 }
 
 static const struct of_device_id host1x_video_subdevs[] = {
-#if defined(CONFIG_ARCH_TEGRA_2x_SOC)
+#if defined(CONFIG_ARCH_TEGRA_2x_SOC) || defined(CONFIG_ARCH_TEGRA_3x_SOC)
 	{ .compatible = "nvidia,tegra20-vip", },
 	{ .compatible = "nvidia,tegra20-vi", },
 #endif
diff --git a/drivers/staging/media/tegra-video/vip.c b/drivers/staging/media/tegra-video/vip.c
index 5ec717f3afd5..34397b73bb61 100644
--- a/drivers/staging/media/tegra-video/vip.c
+++ b/drivers/staging/media/tegra-video/vip.c
@@ -263,12 +263,12 @@ static void tegra_vip_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 }
 
-#if defined(CONFIG_ARCH_TEGRA_2x_SOC)
+#if defined(CONFIG_ARCH_TEGRA_2x_SOC) || defined(CONFIG_ARCH_TEGRA_3x_SOC)
 extern const struct tegra_vip_soc tegra20_vip_soc;
 #endif
 
 static const struct of_device_id tegra_vip_of_id_table[] = {
-#if defined(CONFIG_ARCH_TEGRA_2x_SOC)
+#if defined(CONFIG_ARCH_TEGRA_2x_SOC) || defined(CONFIG_ARCH_TEGRA_3x_SOC)
 	{ .compatible = "nvidia,tegra20-vip", .data = &tegra20_vip_soc },
 #endif
 	{ }
-- 
2.48.1


