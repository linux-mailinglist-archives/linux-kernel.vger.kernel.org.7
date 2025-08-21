Return-Path: <linux-kernel+bounces-779740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB961B2F807
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A9F03A3871
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 12:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383322C11DA;
	Thu, 21 Aug 2025 12:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i5YIxm7Y"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E54CDDC3
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 12:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755779461; cv=none; b=bC+nzNMakU+FpQrCUUr++K7Z40t2oj8+VykzqLbqZ5PM4Q5caOsOAy4s13jXt8h818QPZ1nP/CiY1zQ/fItq0x8xGb0VwBe1H8xCKdLvMUjQu6oj+hujYp28y2yAlAOeKUbeixoibaA6dyrUgBlsfeEgbTzIxVNkR9+23W6uw7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755779461; c=relaxed/simple;
	bh=5pkgB/5rQDps/saQ/w0q6u4l+URqfRYReC020bzEeak=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IunV8Fo9wDvvJmFGEfIswfisbMy1oIL8OsdSXd8Agrwz0cDXY3dwbr5CYnAkwQDZC+9Uv2LaT3i67pPE8bgL44CTyjUO1LWqjnI0qbMzYkOQTdYcTaOs1iICoTZV0q+sjwVirC3yzl6HjT37ggfTfV5y+U+26jSyZfS5KO8MFWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i5YIxm7Y; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b9d41d2a5cso773221f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 05:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755779458; x=1756384258; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mxR/dg8k3HLUiS1lV7+VyCFpJVOb/C+SddN5AU6mmSY=;
        b=i5YIxm7Yhbf0pJ/pSHLsoiV+YR+/Gfqhpy8DlahLMJo9ErD9FlcmAm0ixb8bMF/4ku
         V2FCfOeYNPFf/LIohHLihnua2Ar5PNi2eHohJu6thDeY4yd327tV+L5IByDzQHm2/G8Y
         VWSPHEptihfxqElZf+0HFuMrzeOAJD1HwA3pRJR5n8XTiiAaH6wJzrBvxFn3CWObfKuF
         vqP9qHS+yREIH8U8pSRfCPKkSNPzyW+9W+Bwgxriti/wHiE3N5vM9QsCI3JrCxm4kGJP
         WCFl0r7Yap9fRP2ebBKqvCUhUM3L/g+jQPB/vRoIb+9MNht96sHkS/wOteb/aZQY2WJ1
         4q9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755779458; x=1756384258;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mxR/dg8k3HLUiS1lV7+VyCFpJVOb/C+SddN5AU6mmSY=;
        b=sYlOM/as9DAbnXGeybomp3h9r0ZAtqqwcAiqGTZ0ecZX9NaVisU387YVzXSvHHXnLv
         XcBpJ5F9PLyZKbUnkM9PWKFZbKZqTjbeAwJqXGmVC8QPOfDRPvD6HcQSyiOR5sZlCvkh
         i5MhS7kkzA8UkGDmbucB3rtj+MR5+CLZsp5bqhh1Zyq9B8WUo3bws5jFdGOlkynMzFEy
         B/dIK/uwFWehzQDJZ2Fq0B4KeGClF0lwtEr7Bkk0O63g9PKWGJlPdUuocLtLL0S0H5pw
         O36FWoPH2jjMpIFM4cNYYhS3cT1R05iPUWYQQELYT2b0dRZzkvjX4m/q4w8lGakvZj08
         52HA==
X-Forwarded-Encrypted: i=1; AJvYcCX1PYHY74nFsDhXzaMZKJfQXElq90goVAiTgbkNlzVGVrKxQvk2KUkROYscCC10Yo80j9ZXnNh+cx6T/Do=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgg3aLVvaPoduWH0kl6jIpPV2im4f08zLe/lbddtM4axqtaJdH
	sts+30qYu10t6GmB1eKwhAiszR73wNqhFyJwhXIVWGo1IAUIlGpyaKCAmi467AMkP0o=
X-Gm-Gg: ASbGncvkP88j87aStyizGlvLr8xnFp+bGxqjmmWzNWwLkS7zkxMLllzLQTFQ92eMVwo
	wXwdaZuwb8/1zjXFmW/ViedTRmpt+PXsjqORkl2RhdW0EZ5YHA/a+MaQIdsRFPeipI41lf0Kx5o
	5FXgZTTTib5sxnp+d2fddPH9IfUBiV3z2Wi1ziRD03u8D72FVvdI+A27oK2ZT4PY2dXqjEIa6tI
	cd9rAPss6ssrg+0nczwBa54I+FyladdAHO/b0x0PXiLn2rLXdrNLj9aPCu27TtWB2arwgaOcGpQ
	o9IxVnFdUMRNNswAZXkqTX+74NFShRIjf3S5bXQ38P3oXONuv/Fb9wlYuvWjWjJ5BQP06hpox7N
	0icxLK+FpWbVadwoehCkSphZzl9+2o0aVGk4kMA==
X-Google-Smtp-Source: AGHT+IFuPjndS1sGpXpxAnUf6FSnfiNYp7Zpbio33Qd34o3QKqntyeIWA/EHXuRLsADAhCMT72Ozng==
X-Received: by 2002:a05:6000:40df:b0:3b7:6828:5f71 with SMTP id ffacd0b85a97d-3c494ed18eemr1595254f8f.9.1755779458355;
        Thu, 21 Aug 2025 05:30:58 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c3e673aaacsm4966796f8f.23.2025.08.21.05.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 05:30:57 -0700 (PDT)
Date: Thu, 21 Aug 2025 15:30:54 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Brigham Campbell <me@brighamcampbell.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Douglas Anderson <dianders@chromium.org>,
	Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] drm/panel: jdi-lpm102a188a: Fix error code in
 jdi_panel_prepare()
Message-ID: <aKcRfq8xBrFmhqmO@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

If the mipi_dsi_dual() macro fails, the error code is stored in
dsi_ctx.accum_err.  Propagate that error back to the caller instead
of returning success as the current code does.

Fixes: a6adf47d30cc ("drm/panel: jdi-lpm102a188a: Fix bug and clean up driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/panel/panel-jdi-lpm102a188a.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-jdi-lpm102a188a.c b/drivers/gpu/drm/panel/panel-jdi-lpm102a188a.c
index 83656bb4b0b2..23462065d726 100644
--- a/drivers/gpu/drm/panel/panel-jdi-lpm102a188a.c
+++ b/drivers/gpu/drm/panel/panel-jdi-lpm102a188a.c
@@ -233,8 +233,10 @@ static int jdi_panel_prepare(struct drm_panel *panel)
 	mipi_dsi_dual(mipi_dsi_dcs_set_display_on_multi,
 		      &dsi_ctx, jdi->link1, jdi->link2);
 
-	if (dsi_ctx.accum_err < 0)
+	if (dsi_ctx.accum_err < 0) {
+		err = dsi_ctx.accum_err;
 		goto poweroff;
+	}
 
 	jdi->link1->mode_flags &= ~MIPI_DSI_MODE_LPM;
 	jdi->link2->mode_flags &= ~MIPI_DSI_MODE_LPM;
-- 
2.47.2


