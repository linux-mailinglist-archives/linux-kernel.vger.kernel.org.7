Return-Path: <linux-kernel+bounces-852273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 821EFBD8973
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48ED23E1ED0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89662EB844;
	Tue, 14 Oct 2025 09:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UsZ0H7dr"
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8931C305043
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760435385; cv=none; b=KptzbOSezgj54s+g/dXNLxMVYjj+06mwnmG79CE+VvZCsmZE8C1R18M87YlTlgblD0fL2xgvaVfMTWWySVhrsr9eoruEhAOiAmBbTOTyyFuREPu3N30udIuRUHTINQQkpfhkw2hsa7k0FCiaD6X/ofqeD4fWyO6QSqb0n714yaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760435385; c=relaxed/simple;
	bh=dU5jUUVFvncdY640R8IfjY/VolL7tG7nvEyjZFyCRTY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QYf/E8Pb2Sl6QX3yAgDGPz1l+UYY1xeZgdphSjiOqdE+eKBRAwKxaXC85KcjFUkKfiWSo8jZAUM6VJBKJFOZF5B10qXnV2bkPteN8dznhKjgkzIK8Mfh6EZHhCoAA0tkGzEKK/yu52JVC1X7WWVZZTQ7Qfju3Gl2T+GKwlyAxRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UsZ0H7dr; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-79ef9d1805fso396939b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 02:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760435383; x=1761040183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hLJMAroOuEjEfmiC8wuRqME2tmvcm6bRHXY9lq4lfzg=;
        b=UsZ0H7drkYi7afGI31SsR/2j9CaJnuEK38LlQsBHlpUADdItHxev0HKVoT3BrZCwZR
         2iXaFW89OHf4qXuGOfphZuG71LvyVK0b9XjFG4It/SAkPByAC+n60EWrelTtg/RWLWPE
         YVE8GEXzclyegnMCvjpoK5NGVlfCOTLT1UNOVsHeXTzhlUzt1fFeHBiL6pR5lsZWOxIR
         gVbTtUls2Oitiu76WfiCH9PImEdemo43fPS5ScwSMezb/WdzX5Obs/lk+lHGuUA4eQkt
         sbHX1CdOaGlfJHgIQggUu4K5M/M2a9cOHb8iW2M2OBKEkJpmiite9PzK06eZQymi35Dz
         /I8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760435383; x=1761040183;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hLJMAroOuEjEfmiC8wuRqME2tmvcm6bRHXY9lq4lfzg=;
        b=sP+otNPUFNkFZlFyl5u3aOBVY5odPr4ENLoLfa3xnA5rMUnlVvZC0BG/OW3V0aNSvR
         JhRksAzWTMv3JSV7ydpxRh+Wn8P+iDrr0zCy1wMOapMEfeExkkiX8xE1LdXo1B5ew1bl
         QvfYFxrGDwuvKwqWEwlmgcJocDGYD05G5AJ5pocVW0DIwm7PzUFf1dcxQm3sY/cmKqK2
         ZMiUaynVvD2X8z7O/1u7FCTo+UHfZTHdJ/TPUUY98AEXR97TB2TKIm2ffLMxQKVdl1Ht
         BKHUV+Cfnef+arzMRO61fCE9C2ZmIOD2Z43uz0uhOCdm8Vm9z4ax5ZgMMLTsB94aYAci
         DXyg==
X-Forwarded-Encrypted: i=1; AJvYcCWqlRZIXsDwW7pOZ3mjH1ECUa8E8tIYt3rZgW4NGoW+11JsN+AK5ZJEJk4te+4yj3/QZ6d0lC7+9LGZEF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBFEZZjvjZ7hUAvWtGBnU07Tcv4oBY4z+qLnoH8t2F2kAkikIW
	dDEhmrL8fPwlJDCoSarVR0UJ0MGGkkTg30cI9LyvgAYkJmmRZA/Yc1sV
X-Gm-Gg: ASbGnctg/7bD+CcIUx8MvJVNZS9xr8FiGhSYMUf8moib//pxAovV/htILJJZOphQ0Kt
	CtHOw7IqcQ9DbwrNrWN4uYYAc0ieDcOmtidyNSgGWi4WC1XmUBNNdSjv9YhW54RoUe2rUFXDXgi
	TPbTln19OI8PqnD2s4xnDJfpclj+eYZfwH1BEVYBscsBuQuxzQmNIpLPGZj6bJz2GNYWSLsPKNJ
	OYz8ET3UQDK5FRZcezVlvzYNdkTKp2xgAkLBJuYuSIuB3F2ldaOniSVwnbiYp32NTIjd+M9k5Tt
	eKMhFSaULYJFWPhv7yoIqLn+IshX+Cn8GtmFwvCrws63hLBoOrqcMFCz31NK//C1BQC7rrGWZa2
	toedznCXS9lZ11ePM6c1AuIrh1BDdoNwh/G33Bc2eY9tsJpdo
X-Google-Smtp-Source: AGHT+IFnYsS5ZcTdUSC0sy8S/l3Mte/pJHbg/gCPohDJTseErwus40m+az1L8i+R6KD3mKSJoMA8Aw==
X-Received: by 2002:a05:6a21:3288:b0:249:d3d:a50b with SMTP id adf61e73a8af0-32da8462f15mr31236051637.59.1760435382798;
        Tue, 14 Oct 2025 02:49:42 -0700 (PDT)
Received: from VM-0-14-ubuntu.. ([43.134.26.72])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b678df66ab0sm11465258a12.35.2025.10.14.02.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 02:49:42 -0700 (PDT)
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
Subject: [PATCH] drm/mipi-dsi: Add dsc_slice_per_pkt field to mipi_dsi_device
Date: Tue, 14 Oct 2025 17:49:34 +0800
Message-ID: <20251014094934.322834-1-caojunjie650@gmail.com>
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


