Return-Path: <linux-kernel+bounces-852583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C48D3BD962F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3A99189D231
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E27313558;
	Tue, 14 Oct 2025 12:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iCE0aHzn"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3911B31282E
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 12:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760445588; cv=none; b=LMaM037VO+YuVCo+OAmVUGR/7YPoOJURSxQhIojRr9euSt7iTbCVGAjv/a8C7BxsYpg1ys4h81DIL80vnDiDnVGDi7rzMfoYdgnWGTvssOFkxcGAiFXGck6w/Suq+aJ1qxxh63xEta9Te1plPmPuy9g+l17yQh0lDKP93Ce8MAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760445588; c=relaxed/simple;
	bh=E6rbjBM66wL3IoHHlXeJRdVPT7g2CsyRrCjh7DjI1gM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WFir94BH3i231wj2XwtNPXkeBlVmWoXxBcWq5Wmp9FpPqMFQgqOPkTsyIWEp173JiQKHt5CAbV2xbOgRFd7C7ELRJcr30XA8LFQH8uF2aTTRzC2Dg5i/OlFX9NOOUsQ7ERdrwqDknSk4+iRN/ZWWA/aVtxWeQ5MFasUO1/aUcDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iCE0aHzn; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46e4f2696bdso53370435e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 05:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760445584; x=1761050384; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WxfXNbeCWD17r/8Zg4XQzenoQeshlu+uRWMEBxO3DrU=;
        b=iCE0aHznKk8n9IgJ4hZjsbDk+hnac4obynwM5rDX6PzrnHoMZ5yuYFVxpj2yo+apGa
         uhTWl652BaXUtsk90gPqErtGWkDyKc1lNEliRrNkDH+A/FwO8bE/VBw10OysQw07G5kp
         D65lmZ85mbv6oL14eR4sxV5TUISNBsy+j4utSRBdPIcuv/2cTt3gsfqr/1s5IAl1ZSHB
         Ml0+rwc7eaW6dNbbOLJoYflIVv/Yj7fgjUFkYMFlb4UzbTbPD8958fL2Fo3LmG+KX60S
         BUpHYu9qZOVNnTvRYKC12MG3eA0h2fwBk0jj5MxmGtV8hmqZRUtCr1F7z96mAp31ayRg
         hEJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760445584; x=1761050384;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WxfXNbeCWD17r/8Zg4XQzenoQeshlu+uRWMEBxO3DrU=;
        b=ZecONcPLvv+KeymoBgoy17KQIau8Q4TJGT5ltrLiYXD8FsWcDEgZ7RZ5j18Nc5HkVC
         2SBJ/Wpau80JPKDPybVJruwZXnzZ9udbfK7R1PIC5RqxJeDzfqlfVjv44ddEBPDLZMAb
         wrOP0bwEVwyZzG6vVMnECgWgh1tr3rKj4sUQDpBQuj0B9epgaBMrAJfHHirkawEVivTn
         Kgv5mIh8EuraCLmh0+IdnOBBnPua34teAA3j+9Tb7kVtM/e1X5WBiQmv830VvTYQpy2r
         vCieLnicSo37JPfjJlpMzwiKwvGPaIOYQb3keInB4EBDTpTQoSY27fHd78oP3HTk8qAT
         DuFg==
X-Forwarded-Encrypted: i=1; AJvYcCWh3/l/YlB9g6g6BV41xjwKu/KYrEY/Wwl0g/UpXmTyq0r8BaYaEeQfzhrVAJiG7stEciNnKnggZygVibI=@vger.kernel.org
X-Gm-Message-State: AOJu0YztbfCYIfrPhqVH7DkD4nOFpqS6OfNqMKXHdGueOQCpDNq+Y7/a
	Favcsq0GlhIQW44lh8O++tWLWI/hIGw1qZAIKXFvitUi2AlwuAItcdhp8wQJbtfL4is=
X-Gm-Gg: ASbGnctvJHLfLy9MzG9sa1rPKxfCMrhpRbIfjNxRbiiTWNW22AnM3tbj61WCYyct2oM
	hztUQiYLpH8Q22xJ6m/b+5dfV3D1dUKrSWyytwgXztsTSuGTmHquukGqcFwrbhkiJcM9fNMq2mt
	8ccBYM70oSX5vZ+qE59QJshcpBWib9rUm0FXo08KkxL5Ur4JufDkQ1sxVjVw/S+AeQ3VSQ2e/oB
	ds/ex5pisb/zzU+uJkosuVLsVJJipOzba7WwPzGdsbPtDsc7+IyvmUFyViTHqscQaADCmbe1ud0
	19u/vQGWPya4y5IDhXMm21dDcactjnUoG+roPvqm/ElOVE8bvv0jPgrnNMBrntoWKyiEmVDKlJb
	EnJ3ur8o3aTU1t55KwudouoZGVci8plPh4gPvt/wh6QSRQo4H+End1A==
X-Google-Smtp-Source: AGHT+IGSDpXQTDlp1VxndrxWzCAqXHmiwD+D7q+jxH6QwOgs6VZlAYCg4fJPWrsSgEjEu6T2Fe/K/Q==
X-Received: by 2002:a05:600c:138f:b0:46e:19f8:88d8 with SMTP id 5b1f17b1804b1-46fa9b17d03mr185755555e9.34.1760445584277;
        Tue, 14 Oct 2025 05:39:44 -0700 (PDT)
Received: from hackbox.lan ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb482b9easm245813815e9.1.2025.10.14.05.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 05:39:42 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH v2 0/7] drm/msm: Add display support for Glymur platform
Date: Tue, 14 Oct 2025 15:38:25 +0300
Message-Id: <20251014-glymur-display-v2-0-ff935e2f88c5@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEFE7mgC/13MQQrCMBCF4auUWRvJTCtaV72HdBFNTAdqUyYaL
 CV3NxbcuPwfvG+F6IRdhHO1grjEkcNUgnYV3AYzeafYlgbSdNAtauXH5fESZTnOo1kUksWToas
 9NgjlNIu783sDL33pgeMzyLL5Cb/rj8J/KqHSytYtmrqpqSXXjTwZCfsgHvqc8wdPz85qrQAAA
 A==
X-Change-ID: 20250910-glymur-display-12d18a2bd741
To: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kuogee Hsieh <quic_khsieh@quicinc.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1859; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=E6rbjBM66wL3IoHHlXeJRdVPT7g2CsyRrCjh7DjI1gM=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBo7kR1NKRRqIO4/VJxX1w0FK4IziT2Nr+YGPX+H
 01KO6LzZieJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaO5EdQAKCRAbX0TJAJUV
 Vh5HD/9nE6fTwwGQFiwiPBHCieNeh9X8dzP0HxIbCfVq1Brz5IOWonJI/Ybt9tAq4ILBNf0citc
 YrhihjdzqHfyJjV6+LkgzPtmh3D3SUEWn0HGmMK9vHLw2QrA+pYLAOb4N/otKxbPwYU0Utuxb4E
 +mqd9tsr+5AvKyM5uDEw6vsOVJsg4VdzZMHSMFwQ0pEMUtljRG9ANtdUuiPGZ5tcrwgTmNRDZsz
 fzR3EHogY3BDWkjjoa2wnBiWOyQfDQYMsLPLYPfS6dPzgZTg2dXJWTOkVqDCwegp+JK4GPtqEUf
 qEGgUqxOOm1QuXh1XExBAOTk60s3920EIJ4IBjbAWHLpCIxsXazznT+Eq3ezfrG4J03b53PgHJp
 E1KWT/Obhamb2Fv/L0WAtX2yhwyLofNVpHvUTkEYP9MSjcmm/1iGLStBHB++8Fv353tgzDrzCiM
 uTYUMv+G9HAJINXgLPNvLYZ/kIJfrQbc61FFcuvO7OoKMUKUDHDSDpGJaAnfjdhk8xKw8w9hb/J
 ZJAiX/x2Ho6kJ+b8vnJM2+goK/EFkG080zjAQHSfS+9RKf1oU/kVxaDGhNMFeXBgcsX4nUQkh+N
 B9/qUdvgLyw/MlGgMOX8g0Tcwi0bRYezbmOLi4kkptyZOFt8BFuNHfvA+evmSY9C0X80bkZNe9K
 s28/pRE6moARlHA==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

The Glymur MDSS is based on the one found in SM8750, with 2 minor number
version bump. Differences are mostly in the DPU IP blocks numbers.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
Changes in v2:
 - Picked-up Krzysztof's and Dmitry's R-b tags.
 - Fixed the bindings check reported by Rob.
 - Fixed indentation reported by Krzysztof.
 - Re-worded the commits to better explain the incompatibility
   with previous platforms.
 - Add the UBWC config patch, as suggested by Dmitry.

---
Abel Vesa (7):
      dt-bindings: display: msm: Document the Glymur Mobile Display SubSystem
      dt-bindings: display: msm: Document the Glymur Display Processing Unit
      dt-bindings: display: msm: Document the Glymur DiplayPort controller
      drm/msm/mdss: Add Glymur device configuration
      drm/msm/dpu: Add support for Glymur
      drm/msm/dp: Add support for Glymur
      soc: qcom: ubwc: Add configuration Glymur platform

 .../bindings/display/msm/dp-controller.yaml        |   3 +
 .../bindings/display/msm/qcom,glymur-mdss.yaml     | 264 ++++++++++
 .../bindings/display/msm/qcom,sm8650-dpu.yaml      |   1 +
 .../drm/msm/disp/dpu1/catalog/dpu_12_2_glymur.h    | 541 +++++++++++++++++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |   1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |   1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h        |   6 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |   1 +
 drivers/gpu/drm/msm/dp/dp_display.c                |   9 +
 drivers/gpu/drm/msm/msm_mdss.c                     |   1 +
 drivers/soc/qcom/ubwc_config.c                     |  12 +
 11 files changed, 840 insertions(+)
---
base-commit: 65dd046ef55861190ecde44c6d9fcde54b9fb77d
change-id: 20250910-glymur-display-12d18a2bd741

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


