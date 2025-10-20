Return-Path: <linux-kernel+bounces-859951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B35BEF07B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 03:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D12083E036A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 01:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2296C1A9FAB;
	Mon, 20 Oct 2025 01:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CwRYl6BI"
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173DD17C21C
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 01:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760924580; cv=none; b=hhQQ4n8ZHRSN6Q4OzB3XxPraTvqiKHBN3ftGrdADg9nFmpMyxM2/BVRyRiLNnE0Q5sxzJ33tSLkMVF8PFyzk1mHQ1I5C9P8cS3U0W5+l12D9O9k4NPPil+25WykTJUzOjjCtXU6WssQF5zVmiX5aCIrHyPWPIMzS+sqdU7it0Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760924580; c=relaxed/simple;
	bh=dU5jUUVFvncdY640R8IfjY/VolL7tG7nvEyjZFyCRTY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mD5jla0hsoG5GbPSM9zoC1wWYCkjs274Ru58EK2cRY/juthsYG/DdfCbGoJVwzYwsgwDkUBmcojZgELf0AMZEmOMkFX3SPkQD+o5HgRIlyFEbcwIzmqNXoQ04LJgN2IWtkkGe7ZxoBsefluGivhqeMMjc0dzOsTgXs2PK+ls5dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CwRYl6BI; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-b67ae7e76abso2791790a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 18:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760924578; x=1761529378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hLJMAroOuEjEfmiC8wuRqME2tmvcm6bRHXY9lq4lfzg=;
        b=CwRYl6BI7fgUHsbEeHmCneRQa46+PE77NjdvyBNvBEDx7OtHRCiDRialmNIT6DOkLE
         qPE1Z6OhelkkXO/PF/5/TyIhFnPrr3C/RuguKNzXjW2AdY6UVqt9+py3DmLEinMah/9S
         lzpI5omknSEV3EFwmpc+a/olMFqiA3mbnKuKoEUaqkv9AGzOyUm9fM3IM9OBTrsYV1qq
         8F0Ak3Zl39ZX17J2u2T15uozgfCecpu79fRZu3fewSQoUeyLax6HGUTffPB6JZLQlpDp
         7zYxgVgOG6KmT8770TgY4i2o27gBBuFT5vjPzRF6G8r1lNcZkhTxDeOcbx6X+haRzhxv
         M4+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760924578; x=1761529378;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hLJMAroOuEjEfmiC8wuRqME2tmvcm6bRHXY9lq4lfzg=;
        b=A2ZKazPBaL1aqEQUx1sJ++RSzYu8fSz01KahdhsHhiH4J/o+jjnBabXkukPiBhHoN+
         QrwisNNPiPjfKwFi4BLJ1GPs5aggNn3qfudV5VHG4oPSP9dbAI2fbLjuhA3tbcvNB2nl
         H12Et/YJtKfHVmSHqwwnF4MZn123+tlRSgr2sdd8XlsSS9ElfAujRfSwTqkq2+K3v+Zv
         Qk7+nYdOYJ2ZFThymClggbLE8VllZQTLa9O17RFnqrgHi2Xo0h5yAFEZX610vbHYjVHY
         3v+5SLy4+Lpjpq66CcbwEiiL6qbZkRbPJMDKIz7S+6PcnJeg80a4ZMus3CjM1JTPCf4k
         8qJw==
X-Forwarded-Encrypted: i=1; AJvYcCVAXwnTzpdvw2bgve4/rfeg7lfLtJlkvE9X91zML2Z5fL7c/CDATBJdGGhwKF3otaGFtF276vIl2rJ0X5s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+3PtmWYa/6v44O+xt0xQx0NTOXlzd28HudWw9dWAHIyj0ZVhQ
	LKTS3gZsFju7wC25BfH+D26NGYyHwxeT28Z0m3Tj5DM4GGahoz+YY71C
X-Gm-Gg: ASbGnct5ZPlLxhaDeBVQonvZ4fH3GBvJCAYHLhSGoLYYEZRJTwlsvGyEEA1MXzaZVhu
	BXYFvE6K9pJ8K63cpSrXvMRPQCMBZKX7hz1FMlNn8PVXNodIA6hML3icBkFuj8+nz0dF67H4K/U
	LsJopHVGySt4md32Omdhl5k9z4K3jvjrIV7igGXOCvylhfyJ3J9WuygdFemJU/e/mzkhr31ZTX1
	2pfOTyUilGory08qwG6vOgtK5gRINx44NA21fU1TShJocoS2brkYvmCCwqzCZkgQ/vL4FtXScn/
	qUoxkRu7B1cz9JjQ02BnytZRyqJDmUu3bZKYSzmNJZ3nE7tf3teZj04Mlxhggp3RvMvyoNpoEYn
	PU178QMQArBcq8+TaQVjcwyGqC8bmYdT4KIlkbeTI9bxJInM/llW3jv/AxaikGPHqOrLvDAOEUT
	VjqawrKcdYMlcayWV+AQ==
X-Google-Smtp-Source: AGHT+IHbBpBYJ9xuTUr+8e8R2x206I3Dg3JjY2xjNJ+AjmYNNy7hKRGNFm1GDWB2gyHgbSQdRzGtdA==
X-Received: by 2002:a17:903:2310:b0:246:4077:4563 with SMTP id d9443c01a7336-290ca121a15mr136211665ad.34.1760924578216;
        Sun, 19 Oct 2025 18:42:58 -0700 (PDT)
Received: from VM-0-14-ubuntu.. ([43.134.26.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471d5c0bsm64773965ad.69.2025.10.19.18.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 18:42:57 -0700 (PDT)
From: Junjie Cao <caojunjie650@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Junjie Cao <caojunjie650@gmail.com>,
	Jonathan Marek <jonathan@marek.ca>,
	Jun Nie <jun.nie@linaro.org>
Subject: [PATCH RESEND] drm/mipi-dsi: Add dsc_slice_per_pkt field to mipi_dsi_device
Date: Mon, 20 Oct 2025 09:42:48 +0800
Message-ID: <20251020014248.2846466-1-caojunjie650@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some DSI panels require multiple DSC slices to be transmitted within
a single DSC packet. The DSI host will only correctly program its
registers and avoid display corruption if the dsc_slice_per_pkt
parameter is provided.

Since dsc_slice_per_pkt is not part of the VESA DSC standard, it should
not be added to struct drm_dsc_config. Instead, introduce a new field
in struct mipi_dsi_device so that panel drivers can specify the required
number of slices per packet, and DSI host drivers can retrieve it
accordingly.

Originally, this change was part of a single patch that also included
the DSI host modification. This patch splits out the mipi_dsi_device
changes. The corresponding DSI host patch for Qualcomm MSM, along with
a panel driver that makes use of this field, will be submitted
separately.

Co-developed-by: Jonathan Marek <jonathan@marek.ca>
Signed-off-by: Jonathan Marek <jonathan@marek.ca>
Signed-off-by: Jun Nie <jun.nie@linaro.org>
Signed-off-by: Junjie Cao <caojunjie650@gmail.com>
---
 include/drm/drm_mipi_dsi.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
index 3aba7b380..a6357e8c2 100644
--- a/include/drm/drm_mipi_dsi.h
+++ b/include/drm/drm_mipi_dsi.h
@@ -180,6 +180,7 @@ struct mipi_dsi_device_info {
  * be set to the real limits of the hardware, zero is only accepted for
  * legacy drivers
  * @dsc: panel/bridge DSC pps payload to be sent
+ * @dsc_slice_per_pkt: number of DSC slices to be sent in a single packet
  */
 struct mipi_dsi_device {
 	struct mipi_dsi_host *host;
@@ -194,6 +195,7 @@ struct mipi_dsi_device {
 	unsigned long hs_rate;
 	unsigned long lp_rate;
 	struct drm_dsc_config *dsc;
+	unsigned int dsc_slice_per_pkt;
 };
 
 /**
-- 
2.51.0


