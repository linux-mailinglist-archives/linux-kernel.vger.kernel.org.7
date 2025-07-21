Return-Path: <linux-kernel+bounces-738731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 081B9B0BC65
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 08:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09B2B17A050
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 06:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA291E8338;
	Mon, 21 Jul 2025 06:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="F+ux7PXi"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746E2BA2E
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 06:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753078599; cv=none; b=dNxL294ibc9psod3J1D8RsUwY48LCgfCKuSQjk9L8QUlFolN2eDS1623eIgbbuVUzhzwaLDXpiGPRo9NWTy9FpxcfTfyr36bsuYRY2C8Osl2EkYGhj8S120xdhXQ4Lb6AiCID2wItidjZaV2nD0jeKDrCzPhlJpo3GRb+d84BUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753078599; c=relaxed/simple;
	bh=GnSqybJHU7IyBNyIKyZOBRaJJq4pOgmLUgH/CkkoYRY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WYJUbFvIX2fk+/G4s9QqyQQp6spfW6ZzrDm+hSYpCw9t4XRLoG0QMQo7djOyWCwekiufvIadFuLeJp1Rv6iHwTN4qgxLZ0v4+38W4wjt9wVfJiKAbZwnW/UCIzkIvOmba0RaMGTSSsXWhelUHvNxrytEYAFhsSbTkmVXOrHGIP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=F+ux7PXi; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-748e81d37a7so2520802b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 23:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1753078596; x=1753683396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N0ENQ275HCx0o/sjGDH+fa7srMZMEHCVXuFWv7uWYYc=;
        b=F+ux7PXitbdN86iil+YXj05l77dd+JGoBtqs+gHL8JxHoK+I6nxYGP2mH3t0prOGmk
         dwiu5FjAKCrAajYvumkzTeIcQ+uUr+7CVYCGfdKhrPn2PYjTsJua4eyRQq1EvO8Wdj8l
         TSRrZJK/dPUbML1ZzwtAYB/LqDNxu5AZTjVjqTykbaY/hrxn8iFcxRAS+BNv7MgOh1Ly
         UINInkBZdAqMFr7fzYEuDW5cQ4mHwVrdmqMPxWlX2nmtVthhtQGUQQGBGkRcoMdMl9QL
         WTmv18HbwSoGD/aLavjqXgR1XfF24wFcYnhrbOgMesia1gVPzFIY2BPMACCulnRD1T2d
         ODmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753078596; x=1753683396;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N0ENQ275HCx0o/sjGDH+fa7srMZMEHCVXuFWv7uWYYc=;
        b=pIBxFElHdj/q7im9seVLgxK7ag1C83i4GF9n3GfM+OzIZDlsFOSBLSRmBdVqLBdIQm
         Sx4Bj26jdPTiSwg6Vqo0It8rgYShECcPr9YG7W5EqZ6LMsyvcdYl3j67Pcmaoj1LYyie
         2PPKJWPYZI7phBwKZsLGPxMBD5S8FaVzQnFJoiVGnyO/YaNZ+lVgL51Y5l4Ev2LVo1qj
         0nOkgbfLUS9RcWZOSXQpkSlARO6LFyYATGJV/sGCQwcDyvDvjDUsGaZh7ask/3oNYx2a
         jxj3rwc0G0/73gF3Speojd4f0aWUWV/GU8NgO0Zr8I/T9kTJrfeTx1T3nP6Piso+WpX/
         k7CA==
X-Forwarded-Encrypted: i=1; AJvYcCX6qa6l+SojFzpjVmzR9jlBTo6rVbm7ueMeMoDqT01o3Zw5esMxcKME6Nlbu989cKiaunEZz0XvYAYbWXE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx02FXba4R6U0s+jKURrfIX4xJV8z4IY6HFGG4yok9StWaZ0Ydr
	QAfE3AzaL60/PRzwjnv42VEuT/HiUAbPwhj68/ZrN+E52rirkPqdgsr1ItFajhovCVfl/ji6wMl
	q+Cer
X-Gm-Gg: ASbGncsdgFEZ39hGHpQsOtOGt/zdzt62I3CCg1TYPlITvJ1N3WRbpgRzueBY8fGR/G4
	R2yushxBUQBfdJgFg/rz6Ab6goGDVzHvIY9GfOV2q5+XbMtOsYF5+acY2xt9nyYFHchNvHGxids
	sS8qnBI3G03Q9LI9hzt7XosAXx0q4m5wVlKPcrE4fs/V3UQVkQprKaa2c6YfgoFw2HpF2jqISi+
	+RsfV0xGs4x+sue9IDxe/ZvEzYWBtUwkmy2BOUs0Okq/XyRej2ezdYzsniGMAlxVnmbl32Lz8t8
	UBxaoQsB/EcsuFoQE74BaJUIUhVdpk5Pcku/ve5YZ/um4xi4RE7AjhUjQ6s77s+F4G0W+hrHWqd
	JcwN9SJSNmRsNHYwuLL1qYrirZ8Yxck68vpKMoGoiHQ6/i54URRgFkrqDWI725fdKOT12fg==
X-Google-Smtp-Source: AGHT+IHjZqTtlpY0pL6h5Pp0btNtFSEGfuHRyOoDc2GP654jKlH/a0zZPhaWHOyzP97vMnL9W7trlw==
X-Received: by 2002:a05:6a00:3e23:b0:748:e150:ac5c with SMTP id d2e1a72fcca58-759ae1e7120mr16787301b3a.23.1753078595560;
        Sun, 20 Jul 2025 23:16:35 -0700 (PDT)
Received: from dgp100339560-01.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759c89d0678sm5104153b3a.43.2025.07.20.23.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 23:16:35 -0700 (PDT)
From: Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
To: dianders@chromium.org,
	neil.armstrong@linaro.org,
	jessica.zhang@oss.qualcomm.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
Subject: [PATCH] drm/panel-edp: Add disable to 100ms for MNB601LS1-4
Date: Mon, 21 Jul 2025 14:16:27 +0800
Message-Id: <20250721061627.3816612-1-yelangyan@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For the MNB601LS1-4 panel, the T9+T10 timing does not meet the
requirements of the specification, so disable is set to 100ms.

Fixes: 9d8e91439fc3 ("drm/panel-edp: Add CSW MNB601LS1-4")
Signed-off-by: Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
---
 drivers/gpu/drm/panel/panel-edp.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 9a56e208cbdd..09170470b3ef 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1828,6 +1828,13 @@ static const struct panel_delay delay_50_500_e200_d200_po2e335 = {
 	.powered_on_to_enable = 335,
 };
 
+static const struct panel_delay delay_200_500_e50_d100 = {
+	.hpd_absent = 200,
+	.unprepare = 500,
+	.enable = 50,
+	.disable = 100,
+};
+
 #define EDP_PANEL_ENTRY(vend_chr_0, vend_chr_1, vend_chr_2, product_id, _delay, _name) \
 { \
 	.ident = { \
@@ -1984,7 +1991,7 @@ static const struct edp_panel_entry edp_panels[] = {
 
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1100, &delay_200_500_e80_d50, "MNB601LS1-1"),
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1103, &delay_200_500_e80_d50, "MNB601LS1-3"),
-	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1104, &delay_200_500_e50, "MNB601LS1-4"),
+	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1104, &delay_200_500_e50_d100, "MNB601LS1-4"),
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1448, &delay_200_500_e50, "MNE007QS3-7"),
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1457, &delay_80_500_e80_p2e200, "MNE007QS3-8"),
 
-- 
2.34.1


