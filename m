Return-Path: <linux-kernel+bounces-845127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 73196BC3A25
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 09:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A27084F8CB2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 07:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945E32F60C0;
	Wed,  8 Oct 2025 07:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icM78hie"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487962F5474
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 07:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759908691; cv=none; b=qhy+MYEghCDxHUqD1J/mZj8ZR/U6USsXbt1i3/rCLaiHQlvTXXVKwp/Y+wP9QQ21jncidrpUkakDX25trny4tBbQWxcqmdhwrXZ5uTHM5HcxxXvI+y4ABe8gbFhIzxqnOgcuKmPIR51gWTFO35e4HsjZOlDZ9Oe5M5PJcfGKAko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759908691; c=relaxed/simple;
	bh=unhDWU3j7HXm8tKnMiJwHfKNJbf2ZhuKuePm6ASfLQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nNO0bLAzZhaQWqJt0/uQoCCUhxk12IBbVOqpDN9yMwnjyklBuldxjz0oJwyB2xdDlYOqqc1AhQJg/GM72Cv0Ti6RiJrylxEY6VwZCIZEKiyK1d/rjSacRNLjVF4In8DD1etPJgOx7gntoC9FhNkR9JiiC+96VmpCsxyw4exMcQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=icM78hie; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-586883eb9fbso2494837e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 00:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759908687; x=1760513487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rAO9OwRfZdFmlMl3mS0tub2HzSBi7qv3ODFvIZHKgFU=;
        b=icM78hie9U+Z0fwC/uppdOSKbaas91nW9zLII2laUcdu3ka+DZHNMfrL+Vxi2jv/bt
         w7c+T++TX/LkIvCMQSIXDqys/PElxerQI3VKp11Ih4qWTdAei3W+pppBlgUbeJPU8gfM
         Z8t1pk4k7ztXptaNWC6JkhYUa3iKcPOaRkqz7k5ylw0XtPhAiivwpCzN3bmuAak0yXq/
         8UtHPBX8YZcg/mY7ow3ta5cO5Lr/iZvm2mCeDYaP4y6fIIf98mG3NT8yYvg1BEayJblu
         s0kScq8exE+I9jitwwZgHGXmVTZdYv8X7myxANDsyNMSIbAmmjNd0fbNDsBkhwE9pXcB
         ovHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759908687; x=1760513487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rAO9OwRfZdFmlMl3mS0tub2HzSBi7qv3ODFvIZHKgFU=;
        b=bQOdZyCdsCoGb6faItFWb0bxdDPmOL2bw6b6HeSm10VNkEUQfdusKBGYaGykjJ/3EB
         eD44YG+63bcn4mDpOjlCuAoPueAXbtuQAYIfJ2xtxAn0DO2Jjshso1FIZcXPNG3FAOqt
         oLkwksT3gLjJkcsnXdN1M1AzHbCItWtrUSCaVj1c8GYYEkSqyD89gXrliOM7UkLOYCi6
         hbukJpZt+LO1mrWLGsQxGIz7VGn14ZzkLfZ+shC8xQyMEW8WecXjasVe7k49Zwcv78oD
         lrdfcwcpFlOQ2LDV6j1TYcyswkcb/PqxgUx20+hfv01kE2jcijh2axjxoGWvn/Y5UgUv
         nhfA==
X-Forwarded-Encrypted: i=1; AJvYcCXo1VNL5LAYopmwBq9YE3lmNx+jqcvIfbOGJXLUbOkzTSnYqfeQ0GJgJO+8B9lvAGlkd2yTHcoAh/j+NME=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF+FFiFwA1nCGfhV2ErGqMgObyPf6nFuqxWSBKkgjYg6JIZIpS
	PXRygTpEpqHHFqqb88x8wYnTehAISKdewJZd4IptA3TE9+Dcn3AH7GRC
X-Gm-Gg: ASbGncvBY52RZNEmleczlJ1/6KbVPM39UYxQ7MW/sMunJHiYMTxRCe88HBpGFiCb5Ut
	/tLkVCDYzqiQRXgQHCAOBXISbXzxhrpYB7r4A1O9ZTl+0yz6cJwTKQLyVycR1c0S7IleDIlryu4
	uZDWy8TreUMn7MUT5zeAY4FgPmNqO9LN/8g59iXL/XZSgoKO6SmuVs/IHcw2zsQ4pI99l+HSpRn
	aNCSKDklOK2Q0rpGCep8x1HUlLPxxLuuHHEZBh/fLOEinM8+IxzDPOksv4OEPbgn2c0XIGa1XKG
	7C0KhEbtRspaBhQF8bulEVKU662y7AcVRD1fykl+4jGn/iPxreJQ9b1KR2zHRYdWeUGqP/t1alu
	+RDZgnriz8Z2UBHGLrQHv+lAy6QVZ94t4Mp4ZnRgiGCtO6hLD
X-Google-Smtp-Source: AGHT+IE+7DyJpwvFP5qOZN8PeNT6/Gm3MISOvz3ifkWRFTEcK846nRXZ88LLrVfYB+NusyJQJau+2g==
X-Received: by 2002:a05:6512:3f28:b0:590:656c:d10c with SMTP id 2adb3069b0e04-5906d88b1aemr661760e87.16.1759908687027;
        Wed, 08 Oct 2025 00:31:27 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0118d22bsm6911016e87.85.2025.10.08.00.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 00:31:26 -0700 (PDT)
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
Subject: [PATCH v4 08/24] staging: media: tegra-video: vi: add flip controls only if no source controls are provided
Date: Wed,  8 Oct 2025 10:30:30 +0300
Message-ID: <20251008073046.23231-9-clamor95@gmail.com>
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

Because the current Tegra video driver is video-centric, it exposes all
controls via /dev/video. If both the camera sensor and the VI provide
hflip and vflip, the driver will fail because only one control is allowed.
To address this, hflip and vflip should be added from the SoC only if the
camera sensor doesn't provide those controls.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/staging/media/tegra-video/vi.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/media/tegra-video/vi.c b/drivers/staging/media/tegra-video/vi.c
index 856b7c18b551..90473729b546 100644
--- a/drivers/staging/media/tegra-video/vi.c
+++ b/drivers/staging/media/tegra-video/vi.c
@@ -961,6 +961,7 @@ static int tegra_channel_setup_ctrl_handler(struct tegra_vi_channel *chan)
 	}
 #else
 	struct v4l2_subdev *subdev;
+	struct v4l2_ctrl *hflip, *vflip;
 
 	/* custom control */
 	v4l2_ctrl_new_custom(&chan->ctrl_handler, &syncpt_timeout_ctrl, NULL);
@@ -986,11 +987,13 @@ static int tegra_channel_setup_ctrl_handler(struct tegra_vi_channel *chan)
 		return ret;
 	}
 
-	if (chan->vi->soc->has_h_v_flip) {
+	hflip = v4l2_ctrl_find(subdev->ctrl_handler, V4L2_CID_HFLIP);
+	if (chan->vi->soc->has_h_v_flip && !hflip)
 		v4l2_ctrl_new_std(&chan->ctrl_handler, &vi_ctrl_ops, V4L2_CID_HFLIP, 0, 1, 1, 0);
-		v4l2_ctrl_new_std(&chan->ctrl_handler, &vi_ctrl_ops, V4L2_CID_VFLIP, 0, 1, 1, 0);
-	}
 
+	vflip = v4l2_ctrl_find(subdev->ctrl_handler, V4L2_CID_VFLIP);
+	if (chan->vi->soc->has_h_v_flip && !vflip)
+		v4l2_ctrl_new_std(&chan->ctrl_handler, &vi_ctrl_ops, V4L2_CID_VFLIP, 0, 1, 1, 0);
 #endif
 
 	/* setup the controls */
-- 
2.48.1


