Return-Path: <linux-kernel+bounces-831707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C79B9D5D4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 06:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB61D1720FA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 04:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A018B2E11CA;
	Thu, 25 Sep 2025 04:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ct1Hq1Vb"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A152B9A4
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 04:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758773155; cv=none; b=qluWNulTUR+GpIT8dcJ6DifdQBTTHsHi7O5QgZDGmx8dYdLTxN63T6P1byNU6AzGMgzVO0bi9HVUWrk8IVWfGj9cAyUFJEiVL6KiD+FUbWKMiyzIDOEqFtv0FAFrtuSa45Ee1yHkcbsp96MiYT+pFbgDVq/J2r3LdrUIv147HfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758773155; c=relaxed/simple;
	bh=gM869wqfg/cPNnr3+A3Zr5UmdmofsdcyZ+eZHm5ZaTY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ctvN+cSLWlUGmARyE3klSs8z7yTJ79YgHabVnewmMCD/W0Nw5LR6R2c2uJ6+Bb2iwY/LsCATwdIkdHh9vGK7GOrShKUS2nzW2S4Q292N5x2STfqVff/gFm5Jn+J/pXoQ0P5RVoium+PSfC5xN/oh84g7JbDXAjTHOhSImDBIdVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ct1Hq1Vb; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3327130c135so95055a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 21:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758773153; x=1759377953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dG5OFuUhTzJArlzJLeHU0Z6lT0pnWQPiV+Gn+hR5Mck=;
        b=Ct1Hq1VbEFqy7oH8AR8NIlq8TdBlLvRt1df8EGpnXpABpuH0ZR+XxA80/TRdViJUbl
         DQ5g8SXfdSwnfXhzsfE4PcpOPIZJ8EVTYTIIKinUv2iIPxvOIZfCm0vq4vH6duplg0pG
         j0nLNipnvPGBHe4moTv8jG/0+A/yQnoyciCXA4LuuBH1NTH0sU/2P+C1V1Z9JzShpB+5
         pBi9b4XsCp2jF2EE1mJccg/tUB0dGTjDUunk7M+vxk+g3J6hpv841GwTaTE+1Yq2ZWfD
         lJKOUUESNt//Q0nNasJpYiUg0RQKDH1UHyk82AW2qybq2X5zywTMydYeSSc0o7TXkOLZ
         KLAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758773153; x=1759377953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dG5OFuUhTzJArlzJLeHU0Z6lT0pnWQPiV+Gn+hR5Mck=;
        b=wPZC/Z8ZyacjqpFS1owGjf4DLN5LZy+P6dN4q35v9VR0HHxkt+TfOyRf93g1Yvm/Ga
         slMYCq7xjQg3MHkiZ7fClFFFqKFih1Qple0XJYxIiG/YEDzSPWZJtrBPwnZ15Zx2UUac
         MUkC9mdQ+oGCconbo8+q+jxRNjPrU4dG0K1KDUwZxIJmDBurvVHKqoMwCLFotktn2jcX
         pQ4FGBhSOMxHYL+0E1PTrTzVw85wag9st3v1XGU2It2DthO0W2J6r0OQR3FlcEAJP4mX
         D3rWiHIQnuK1g/EMEF5BUs8IDFhEDOZ+HDoWd4ILX1dcrsrK1i9eSxBhrcBcMjlbOA3o
         tL8w==
X-Forwarded-Encrypted: i=1; AJvYcCWp6khAH9NpP/C4//7z6cxFhNxTcx4nfmM9P27BhrhSQYv6zIIL74/NXv8YZn9TC7u0I1+2KbEX6tcNR2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDH1mhEaRf7Lcpj5BykHguOtCJfzeuFBKUwn3VFeBtYc2r7bNm
	YPvtSL+gRfj5avabcqXAuJUZSXGZ+CUbtzKH9I5d6DisoHyIy4mepksb
X-Gm-Gg: ASbGnctn5LV9BrKClZW4FZDqU55nStHCI+VRY1M3blJyCCXeplercIOpCEWbp2vn1LV
	c0tG+aGqdBTrLy0madsnENcQHlPLidGrMeovzQEyMLO7fmNRusg0X+blZN4R2aZZriVhZUpmOIi
	avu+X9QaWT868vtOGX0VjxwTsnTRD0N8H6DPZt/ZdOxBRKLgQA3It8tkrkJ15T7DSBxnjC0hoSO
	oBbW5j3U/nAgpMqyRMfGxuzuaX0Sbe5PAwEazN3NiEfxcbMLMG9IPfMtaT6fJVdnAq5ElVfVXkl
	7rpgb9RqZonVyy7X0sXLxbWxiGxpyj+g5gEuNXBZrlr7jzsi4KcoGvuCeQoWGVxpXU90ERUK7mJ
	riu6Sfr4lTj4QLXb3zYCGvds=
X-Google-Smtp-Source: AGHT+IF2EgcFaR+V5r2laKG+fB7NOWuBnZAvcXdgYuPLY/fKj/+eq4e4iwbDLJlE07LtaXblbPtUpQ==
X-Received: by 2002:a05:6a21:6d89:b0:2df:b68d:f7e with SMTP id adf61e73a8af0-2e7cd4044a9mr1241172637.5.1758773152620;
        Wed, 24 Sep 2025 21:05:52 -0700 (PDT)
Received: from rock-5b.. ([45.32.55.39])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c55bdefesm796568a12.49.2025.09.24.21.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 21:05:52 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: linux-arm-msm@vger.kernel.org
Cc: Xilin Wu <sophon@radxa.com>,
	Jianfeng Liu <liujianfeng1994@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	David Airlie <airlied@gmail.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	Simona Vetter <simona@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/display: add hw_params callback function to drm_connector_hdmi_audio_ops
Date: Thu, 25 Sep 2025 12:05:09 +0800
Message-ID: <20250925040530.20731-1-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After reusing drm_hdmi_audio_* helpers and drm_bridge_connector
integration in drm/msm/dp, we have dropped msm_dp_audio_hw_params and
use msm_dp_audio_prepare instead. While userspace is still calling
hw_params to do audio initialization, and we get the following errors:

q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
hdmi-audio-codec hdmi-audio-codec.0.auto: hdmi_codec_hw_params() started
q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
qcom-apm gprsvc:service:2:1: Error (1) Processing 0x01001002 cmd
qcom-apm gprsvc:service:2:1: DSP returned error[1001002] 1
q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: Failed to start APM port 104
q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: ASoC error (-22): at snd_soc_dai_prepare() on DISPLAY_PORT_RX_0
MultiMedia2 Playback: ASoC error (-22): at dpcm_run_update_startup() on MultiMedia2 Playback

msm_dp_audio_prepare is not called because hdmi-codec driver only checks
and runs hw_params before q6apm_lpass_dai_prepare(). This commit will
add hw_params callback same as drm_connector_hdmi_audio_prepare, so that
hdmi-codec driver can work with userspace alsa.

Tested with Radxa Dragon Q6A.

Fixes: 98a8920e7b07 ("drm/msm/dp: reuse generic HDMI codec implementation")
Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
---

Changes in v2:
- Link to v1: https://lore.kernel.org/linux-arm-msm/20250924085804.34183-1-liujianfeng1994@gmail.com/
- Use more detailed trace log in commit message.
- Drop the empty line between Fixex and SoB.

 drivers/gpu/drm/display/drm_hdmi_audio_helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/display/drm_hdmi_audio_helper.c b/drivers/gpu/drm/display/drm_hdmi_audio_helper.c
index 7d78b02c1446..6ca1c7ad0632 100644
--- a/drivers/gpu/drm/display/drm_hdmi_audio_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_audio_helper.c
@@ -130,6 +130,7 @@ EXPORT_SYMBOL(drm_connector_hdmi_audio_plugged_notify);
 
 static const struct hdmi_codec_ops drm_connector_hdmi_audio_ops = {
 	.audio_startup = drm_connector_hdmi_audio_startup,
+	.hw_params = drm_connector_hdmi_audio_prepare,
 	.prepare = drm_connector_hdmi_audio_prepare,
 	.audio_shutdown = drm_connector_hdmi_audio_shutdown,
 	.mute_stream = drm_connector_hdmi_audio_mute_stream,
-- 
2.43.0


