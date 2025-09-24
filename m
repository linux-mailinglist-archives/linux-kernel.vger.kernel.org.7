Return-Path: <linux-kernel+bounces-830777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E29DB9A79E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 827124E16D8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558FE30C37A;
	Wed, 24 Sep 2025 15:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mRylzg0F"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F02E30C34B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 15:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758726524; cv=none; b=rx8ua0xgB+pS+21b6wLZiAnZLk42+8wiD6lqbOjrx/AqNz+qQGH4u9yv99/J7A9nUUQh0NWCrEKzLOiMJE+U1CK7YXJJDwvH20DgIiB1lYXzIrTabswrB3QtcGyFee5pnGuxdoHI8kH4C57lh9mAcM1b6E6R1I+StCaPHl/ZGkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758726524; c=relaxed/simple;
	bh=aqMS0Jn1TNh3mlyytrjaZuPheLrmPmhjXnM4Dd4ZxXA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TQNv3e0W/gkQGfOVjA7i9GoeHP1fl/HbalX8EN21mByPZXB/uEEBlD49j3d9kXlriApBGSDUbb78W0WfVjpG3UloeLIRcmTuL5Sj1tMBlB32oqVnrzZMyNXIrqUCEcKh+HfbxnQ0cTWB4f/l3EMbZ5EzPJLkO5MQtcI8m5pUFko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mRylzg0F; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-25669596955so61479935ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758726522; x=1759331322; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q9im2oqF4utRrC8rBpdrGYdBctIiIANDtE89j7rUJb8=;
        b=mRylzg0FMzv7mbqyzPNnbYEZMnvhxr9z9vsX5+bKWwcOkzS1dc3x1HkknHWM0dGymB
         OYtIKUff9ZSvxxqdv02ZOss/KbYN5fEhBcFpL6fZzAwCotA6QzLQ9sIBsqiGohnhVVpA
         WaQnOI4i87QSVyaONmNKvZr+yYJevjhb0IIvs3DsJ4R+BIy+kP79mlpbQ8wQ/Si+r/EQ
         r3n1b+qS7SuwBtPr+KcTGo4IpkcuwsAgZ6QoX80CKKSosscFRRw+Wx8UYCZNdrrEL2rE
         tEroIlEg4CnnFhwcawG7B2UE4jVjzYJ6jbx7iPv5g5SFQg6ueYEKoR3AS+FJ2xt6mu1h
         tOzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758726522; x=1759331322;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q9im2oqF4utRrC8rBpdrGYdBctIiIANDtE89j7rUJb8=;
        b=RSx6FXkD2odV7zhlzCzCFiLCEtc1UHHcEzBb0srGUL5Cqv99zF+kfG+ba7ObbWESDL
         4/AR/Lb0WIfhaHcHoCqx2rRXjPtDhdr3pz+Brx9zLBQ+OPqro3suDkWTu4CUkqfIHs9B
         tb6xZpcLjpwaxzPsWG4cJD4ZuUDnfNPJhvRgVU2QrLZ92I1dpqlnAatKJqQZq6fcXyY/
         TLjWpfHPUS/SEUD+bbefYy58wgdbZyRty6f0DXyfvQq2AxknCIOuHKyNoEoco30hQp7Q
         NXvGMCagCvVyMLztEyXUKF/P0wQg6TxRNQA3a+PgUS8rDRl6Eh11Hy3ayyUEud0OHodH
         7ZDA==
X-Forwarded-Encrypted: i=1; AJvYcCXBYG/JRfj1yVxt5lxktmDcxFA1Xh3efb/fggr6pyuiK45V5MuhdmhkL1gXFMXiSns1qSnOWSkbQPULI2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwED+9ShnQ820cuhB0ESru284rOgiyUrSrd22PKrWywHCVcQgZX
	U9OoXJYzV0Yl9poidTqaWQPQ9bFISfW5ks+7AvMspiuYLyfszcPWSUZjGiwdExNg1Og=
X-Gm-Gg: ASbGncs6PIuj4vf7wXR7BFeBb1ZGFDG6jyO4+uWMC6wA+MGULUT5TEKOzBDxpIoh3Yr
	TU6rySWTsf1ifmf1E3cbL3MT/t/eKYA1lXByYEaWiTkxzaSM/qhyVem1NkhsqzC55iScEiatYXU
	SReY54uBNyGFItcdcRiYjU3wI98+hu/g6h5wiXE8vHPdxggsJDPnYVj1LWzLq8BjsWW7cTR51kC
	yl1BzvX+1fiyD18VcecwY6e563mXg0PfGgrmiK+iqM3ev+oEIQjXXqKBXs+NHwtNACAFOHADehB
	hzS56DkrGTCrjDomB0WPE1uBdPWvM9jQPjUjPbcjG8yNhgNmOJ2jPZvDd6FUKcYxa4svSSsFDu3
	fthh2gqsJtlNPicde
X-Google-Smtp-Source: AGHT+IGCHLd3pnmTwxyL4D3bJHLTKcwCMZ56M/ra999jlI6cfFbIZbbFFt5flDomb9K12MnR6LGiYQ==
X-Received: by 2002:a17:902:e88d:b0:267:b0e4:314e with SMTP id d9443c01a7336-27ed49df055mr820305ad.23.1758726522301;
        Wed, 24 Sep 2025 08:08:42 -0700 (PDT)
Received: from [127.0.1.1] ([112.64.61.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26b59d6538bsm158717445ad.82.2025.09.24.08.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 08:08:41 -0700 (PDT)
From: Jun Nie <jun.nie@linaro.org>
Date: Wed, 24 Sep 2025 23:08:11 +0800
Subject: [PATCH v3 2/3] drm/mipi-dsi: Add flag to support dual-panel
 configurations
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-dsi-dual-panel-upstream-v3-2-6927284f1098@linaro.org>
References: <20250924-dsi-dual-panel-upstream-v3-0-6927284f1098@linaro.org>
In-Reply-To: <20250924-dsi-dual-panel-upstream-v3-0-6927284f1098@linaro.org>
To: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krishna Manikandan <quic_mkrishn@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Jun Nie <jun.nie@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758726499; l=1401;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=aqMS0Jn1TNh3mlyytrjaZuPheLrmPmhjXnM4Dd4ZxXA=;
 b=6HLYqVGBQbEyuiZQevtXQREU6fOO4xIxqwSNXpTmZaJF78+kLnDym2AXLAFumXiRTuz5lKPBq
 Bn0Cs8FpfNoAOUh5922IfWiIiiZraGlaBvn+PXp5YEZTERAfDDDR7Ws
X-Developer-Key: i=jun.nie@linaro.org; a=ed25519;
 pk=MNiBt/faLPvo+iJoP1hodyY2x6ozVXL8QMptmsKg3cc=

Some devices treat two independent physical DSI panels as a single
logical panel from the CRTC's perspective. However, two separate DSI
hosts are still required to drive the panels individually.

Introduce a `dual_panel` flag to the `mipi_dsi_device` struct. This
allows a panel driver to inform the DSI host that it is part of a
dual-panel setup, enabling the host to coordinate both physical
displays as one.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 include/drm/drm_mipi_dsi.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
index 5a85ba01f402a3866b70828391bb417bb8dd5956..0faff285d9ffeb19e4523cdc7bf21c1ec20e6eff 100644
--- a/include/drm/drm_mipi_dsi.h
+++ b/include/drm/drm_mipi_dsi.h
@@ -170,6 +170,7 @@ struct mipi_dsi_device_info {
  * @host: DSI host for this peripheral
  * @dev: driver model device node for this peripheral
  * @attached: the DSI device has been successfully attached
+ * @dual_panel: the DSI device is one instance of dual panel
  * @name: DSI peripheral chip type
  * @channel: virtual channel assigned to the peripheral
  * @format: pixel format for video mode
@@ -188,6 +189,7 @@ struct mipi_dsi_device {
 	struct mipi_dsi_host *host;
 	struct device dev;
 	bool attached;
+	bool dual_panel;
 
 	char name[DSI_DEV_NAME_SIZE];
 	unsigned int channel;

-- 
2.34.1


