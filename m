Return-Path: <linux-kernel+bounces-830775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC3BB9A7BC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0B6E1702C2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396C830B522;
	Wed, 24 Sep 2025 15:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VQbZGceP"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F02309F14
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 15:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758726509; cv=none; b=VFTYpgzrnZsUHtAwsPqt0TeBA25B47MWKtiIod4dLjbxSYDCNmu1s3IkHjwX+ip0phA6NM+mc1P8FtdyjwQjk823P18Pg3M4aaASk9qtCeFExRnnCg6D2FA4jAXUp+kFpGpLuWR8l6/7D8A0LWy3vlUqOOQmfnyv24tX6iontL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758726509; c=relaxed/simple;
	bh=iNszQabvn/lRi8yKKlr/FXddBVqjWQ7NUr1nerkkTZw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OG/EY0nqis/m2iXjC6Mfh4C5ZMJY54BPmVAIUaA9EBeIooHIoTRvx8DAz8cpwAim+csH1/lohHaew5wQGEvUp2RxOBJHQ/64faFA7dlrohLR9R9LsW8hxbBB1hQ3ZidaXxNss5M+fsBqi6Hl6tpjiiS6vpggRaFflUDKD7E9BF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VQbZGceP; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b550a522a49so6066293a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758726507; x=1759331307; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4cPuMIb0mZC5xOmyRNwA38vJPNTs1ammKswmchiIKuo=;
        b=VQbZGcePsm8m1yZlMhbaTTTh+X8tl/s/ed/+14XTKzPJB0MENowjm4byGQS9C+MyQa
         7ReIuFMebo5+LfY9Jj/Ws9GQq/l38WvZLnZTBKV3cccYDKc/nI8QziPX+hbiGM6MDHkn
         gzbYJwOytz/tvy/0Rqu3deQn4oDStWoeOFchBI8eu8n8Y+F5nFxH47Lw/RevJKXk204v
         WEoIY71tGm/2dsW7GyRHXGWXFk5f0BiNJ5b7EY9+ba3a7NQb1Xrg8G2yZaGWI4f46SMr
         J4Wsp0MjgtprpWCGmsw5iNOl0fLFLkBrcsdtT+ZIzxTtEwdwE8NEXIRPl2UeggWJgGKx
         Dk5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758726507; x=1759331307;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4cPuMIb0mZC5xOmyRNwA38vJPNTs1ammKswmchiIKuo=;
        b=Kg5Lu7s7qnCvrTMIiFOv27uEqwSGW/63hSWOSjh4EqchcVfCXraSjg631wL+lqwKn8
         nIfndPR2h21bMtBtAAJ9Tz+JdiDLufvTzHFjQpoXCYidqQAFVRIOWygZ1rufo6Jga4hH
         M/IKcrxGD5XQDN0SMD2V0iypX8Y8GD5rI8Wq3hA8YnkMJZw1jwY9mdaQt5FcE105YYGZ
         OeTVQVzuuNzUCPJufTdYw3Lj0zg3eQdoyam0e6aMknyDXntVGImsKiKwFcKG9Nd8pmCp
         fPO/zBwC3zbuqZHkkcEB91jyEON/vDEBJyDJuysM8I5tvkXrzmd29Guk+XjaxxJJxIdR
         D4hg==
X-Forwarded-Encrypted: i=1; AJvYcCUDKmhOdeeiZWmR6iEaaGVwL50Bg0TwlkyxLqL5+qetJzuVRAxWFMYNB4mbcJFp8SnNpA2LA2o4qseVDTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YysYTJejVaz97DicqfiVV88Ux/7l3MJpp3PuGQ1Kfh9Zr1rcIK+
	Y/8xDW4XBHCO0m+Bf1u3qmJofb0+aS74vMf43ObHb+f/lfk8I84jy8SbTFk+annwXYA=
X-Gm-Gg: ASbGncvv1+ZtiB4922y1uhChiLnOweYj++K3jPFjxSi6HthWl1VEeSJzM+GLZ/q67jB
	MazPs9+mhnKCZZUtwGrYzXULL6ITsFXoaXxRJ6niKXJNVLN5na2H60aeqNlwLTZ7yb95+CJwuE/
	oFEgGjwuV0vtIJaUSSWn6DCw2fKFmIDQOHoDyZdvPAhDOz/S4FrUOWPtaaZHtTtntLjX2Tb8ncB
	MerPQY5jsvFp+pdcFqehb+kG2E6WSBUY/YU+LYirOJFtWsVGPjPC4MrWjgmcGkoQErWttT7VWi+
	Ww7rlfQt6UYqSY7r7WW9OJTlsl0v3muKvUdKaziTIFTQB4Iig+Gte0wd7/0fiqojZE79vpyAIMH
	deV6aCrfEzybFAq9w
X-Google-Smtp-Source: AGHT+IGdO7AHe6Adr0JVRoWrxVhan7hdmVuVEYOGDB1J6Z6YlniOSroTOkT9XhR+htou4GY59pzHXg==
X-Received: by 2002:a17:903:244a:b0:25c:d4b6:f117 with SMTP id d9443c01a7336-27ed4a3de3cmr643585ad.35.1758726506852;
        Wed, 24 Sep 2025 08:08:26 -0700 (PDT)
Received: from [127.0.1.1] ([112.64.61.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26b59d6538bsm158717445ad.82.2025.09.24.08.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 08:08:26 -0700 (PDT)
From: Jun Nie <jun.nie@linaro.org>
Subject: [PATCH v3 0/3] drm/msm/dsi: Add support to 2 panels in bonded-DSI
 mode
Date: Wed, 24 Sep 2025 23:08:09 +0800
Message-Id: <20250924-dsi-dual-panel-upstream-v3-0-6927284f1098@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFkJ1GgC/x3MwQrCMAyA4VcpOS9Q2k5wryIeookaqF1pNhHK3
 t3i8Tv8fweTpmKwuA5NPmq6loE4Obi/qDwFlYch+DD7c0jIpsg7ZaxUJONebWtCb0zEwqd448A
 zjLo2eej3f75cj+MHs2l9smkAAAA=
X-Change-ID: 20250924-dsi-dual-panel-upstream-4aded63bd2d5
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
 devicetree@vger.kernel.org, Jun Nie <jun.nie@linaro.org>, 
 Jonathan Marek <jonathan@marek.ca>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758726499; l=1682;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=iNszQabvn/lRi8yKKlr/FXddBVqjWQ7NUr1nerkkTZw=;
 b=R2JXFonK7pFkgd4mj9wIsv4DU1DOmzP4CuuDG3BZ/JK6k5rr3gcqHOzQEIW1nXqyTrVMHMRSN
 vZyLYGivB+2CKc7hjk474vCOrc4Ysh6AtEp/hbcX0DDEj6SpaIaO1sL
X-Developer-Key: i=jun.nie@linaro.org; a=ed25519;
 pk=MNiBt/faLPvo+iJoP1hodyY2x6ozVXL8QMptmsKg3cc=

The 2 DSI interfaces may be connected to 2 independent panels in bonded-DSI
mode. Horizontal timing and DSC configuration are adjusted per individual
panel in DSI host side. Support to multiple slice per packet is added for
the device setup to test the usage case.

Changes vs v2:
- Polish commit message to describe usage case and requirements to
  panel driver.
- Remove changes in device tree and add dual_panel flag in mipi_dsi_device
  to pass information from panel to dsi host.
- Drop the register programming to DSI_VBIF_CTRL, as no issue is seen
  in latest test.
- Link to v2: https://lore.kernel.org/r/20250220-dual-dsi-v2-0-6c0038d5a2ef@linaro.org

Change vs v1:
- Add device tree binding for dual panel case in handling frame width for
  DSC to avoid breaking existing dual-DSI case.
- Leverage Marijn's patch to configure proper slice per interface in
  dsi_update_dsc_timing().
- Polish commit comments.
- Link to v1: https://lore.kernel.org/all/20240829-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-8-v1-0-bdb05b4b5a2e@linaro.org/

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
Jun Nie (3):
      drm/msm/dsi: support DSC configurations with slice_per_pkt > 1
      drm/mipi-dsi: Add flag to support dual-panel configurations
      drm/msm/dsi: Support dual panel use case with single CRTC

 drivers/gpu/drm/msm/dsi/dsi_host.c | 35 +++++++++++++++++++----------------
 include/drm/drm_mipi_dsi.h         |  4 ++++
 2 files changed, 23 insertions(+), 16 deletions(-)
---
base-commit: a3306041f55d0f86c40d06eaad1d4e8f06e4483d
change-id: 20250924-dsi-dual-panel-upstream-4aded63bd2d5

Best regards,
-- 
Jun Nie <jun.nie@linaro.org>


