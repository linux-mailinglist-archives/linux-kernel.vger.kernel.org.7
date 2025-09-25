Return-Path: <linux-kernel+bounces-832764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28679BA04A8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 17:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72D041C25D08
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CA12ECD01;
	Thu, 25 Sep 2025 15:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VSgeSaYj"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FC7311950
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 15:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758813467; cv=none; b=QYaOEIv0n/NanW1Fmf91Vc7uCdnDCoX2ovdaSpffK0Ta1Jv+aqsqYJ/CUXkGh5sDJxQTYuiFhZU9Dp7fq0I5MMg4e6YMxmVerbUTJoVPZ02VTyB7GZ+M/6GtibII1CnGlGZcHyYDzGiyC0ueO8DvXGHdyLTKV5iQ15ouoka27eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758813467; c=relaxed/simple;
	bh=xEdfxaJK8UlRjMN0vvEHNNvzu0cwg9hFbDlCPM7oEtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YBLnJYeSQFYGZRqvc9H1LU0ci1jt8qZ0GBOEW277Lz7/BH5jqrNbQsgcqZRLDdkBj1Y6hGzs7qpFRBvpfIy1xxJs+85LsS/JxPpzdAcrG5qhEh49c0IbbrNP5vO1jb4pTOlJH+8kyEQ+DCaF+hc+s07IMd62b8115DFqwbDgrqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VSgeSaYj; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5797c8612b4so1479111e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 08:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758813461; x=1759418261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PUp5v1UIpnZY/yoewRvmgW706IOEqdQHhaBwZbL9eqA=;
        b=VSgeSaYjfCaYUP34XZrIH1hyfG2ZLivVJd0XLNP5KF7vq9JDHtDUo+sUO4oqrsr2py
         T+qEKo8MjflVxMPaLmvWSPBIcRP3+GkflyE1yDQ/GuOEmHGMQbFi+waTOHHf6W2UkHP7
         yV4R/76O7mD2LainVUvaWnOC3/qZTV0JWjfcFQjwEOSsQGSM/q6cDya7lOKtn12IxhMz
         4btz0X8egaimyU4txTjN93t93/fInL121Wbn4kC5ls2ULjqooSERYyOs41k19hLuHSDq
         nzzBwii6xSKj0fMZ7fA29O4UfhJdyP+zGEQwyamzAubw9TjXYDTIewhxIIlBgIIQIasK
         t+9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758813461; x=1759418261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PUp5v1UIpnZY/yoewRvmgW706IOEqdQHhaBwZbL9eqA=;
        b=bH/1d+zj7qOa+ec9ACLdXZN/AfXVELSsd2mh4N9TnCJXvrL+dcX5J8yTbMpV5KU1MD
         JZuKZ00KXkzcbH63dAjjzl5uyHTdrYwfICl2Q5MWZwkDS1I/crjAMBfho0gnHDejKhm2
         lLk6hW17LecTxZc5xsRa4pIO50d78xSGrFRBihHpctt6HMxRAAU5gVxXfeSl3Gh8HYXb
         y6tgU9wue9iLvGYrxH9ldj7zAJ6VvOz/4O+UaSvqdKGJJq8H/Q5vd6ynMqWj/FCF/esE
         EfcZYL9PqijFQhV2wrLVurL1RVn9Yg0I3txh964VO9/B+KsGwhuUSRSCJTaGukzPPYDN
         NoKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcYDYysvAvqO2+gpm684b1Jl3yd0X6K6JETCvm852FELRAdVqYti4DGAT6waAdldTtkLJs+0A7um6UzUI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4fbfKCnRohRX8lr6d5qJ86Zqp4zXZl0/MLp0v7tqyRLRDNxI6
	vsIy/MgstJEMtzga2E2h6kAOzn69YW6z9ZoDbw35SiO8dVDVtdlnAxH4
X-Gm-Gg: ASbGncsul+Yt1etyjWym1Ig/wB+c7G782BEeWdG0iwLjYEbVK/NftFGN7bYBS+gNqoI
	P1vKPJIKmsnsW4MZyV/FwI0MRaRPd5nk8WibUBO+VfqKT+OAEW4zRK+L1nWN67GTZpfymURt9ez
	RAaAPhxRUshFlgs/7CQCInSJJme66wTZngs26nO/lD0gu943VeDknimzyEG2GE1FH9ET6AwMqzs
	UoplS9DfBFCbdK0U+JepWHTulQRVgdkbAGu+lkubcLVjrbDVdOeoxHy5adEaJ3qqArvFMhiShRu
	EjvgYbmKcmmJvL3Z/HzzEYp008zPHaAGf2/OlHgJLstCAv7G3b/RdDf7xDpxzJYTBA/hlw4iavd
	uM3bRk/baRE2Hxg==
X-Google-Smtp-Source: AGHT+IHvquA0M+Xh1SpA+3oDLguKIe9WLFehMUyaGA/+DL5kSgZuWAoo44DRA7J3InsbPnIY3UchVw==
X-Received: by 2002:a05:6512:2207:b0:570:b85:fa9 with SMTP id 2adb3069b0e04-582d0c2a151mr1077864e87.13.1758813461247;
        Thu, 25 Sep 2025 08:17:41 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58313430496sm870084e87.27.2025.09.25.08.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 08:17:40 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
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
Subject: [PATCH v3 17/22] staging: media: tegra-video: tegra20: increase maximum VI clock frequency
Date: Thu, 25 Sep 2025 18:16:43 +0300
Message-ID: <20250925151648.79510-18-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250925151648.79510-1-clamor95@gmail.com>
References: <20250925151648.79510-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Increase maximum VI clock frequency to 450MHz to allow correct work with
high resolution camera sensors.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/staging/media/tegra-video/tegra20.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/tegra-video/tegra20.c b/drivers/staging/media/tegra-video/tegra20.c
index 4b69b556387c..43f545e6c45b 100644
--- a/drivers/staging/media/tegra-video/tegra20.c
+++ b/drivers/staging/media/tegra-video/tegra20.c
@@ -591,7 +591,7 @@ const struct tegra_vi_soc tegra20_vi_soc = {
 	.ops = &tegra20_vi_ops,
 	.hw_revision = 1,
 	.vi_max_channels = 2, /* TEGRA_VI_OUT_1 and TEGRA_VI_OUT_2 */
-	.vi_max_clk_hz = 150000000,
+	.vi_max_clk_hz = 450000000,
 	.has_h_v_flip = true,
 };
 
-- 
2.48.1


