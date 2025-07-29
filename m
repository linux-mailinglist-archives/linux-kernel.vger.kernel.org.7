Return-Path: <linux-kernel+bounces-748944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A36FB147E2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 07:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 188404E3F75
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 05:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF72E245010;
	Tue, 29 Jul 2025 05:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="KkSPvf/r"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C721238174
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 05:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753767890; cv=none; b=sNN7Ydryv5kMu3YdTfB1LVdjq6Vbzx2XvA/CTrJ1b8qlbQrjNcCYRYWmeTy7Hod2tMy8fcIvpXpdtDl8tg6yXitEL5AGe2gbQxONXA+U2BAdJsF+0T0FCTM6ZgHdeld3mlnGv2TRTQmyWFJWwakv9C/EDEG7XHKNOLb/uBItu6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753767890; c=relaxed/simple;
	bh=pZTzoaMuM/R2zsyjLEaONzg+ycGqE0htri7pc30ueog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ghSXDKfA9ihGYFFl2nH96aFXjugTynW50V8t3j2L83xkNXcRwTZBe9PlxEdlsli4prMZJtB9ZNvpPpqBWtxHN7zYkBc3TWRluU5MbTPba8pNPQgbbHjMrPrKpFpThZCLMmYpxL05yCHI3MIq6WyEmHW4DzXbqwSrecbde14KpiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=KkSPvf/r; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-747e41d5469so5641217b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 22:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1753767887; x=1754372687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3cz0hAfmTTvl+76x/6A3khLDSp6/1Q/+pHFEJNnO3Rw=;
        b=KkSPvf/rtvTKijbrIcnZsbFKLo2fk7UKUh+YYWCuB9GMbDB8vuXdp/vtksdg8ICDtW
         uvLC9vqiY1AnsSTmsQfeX2swsEghS9wNAyCPmJk8ivy5UB/ty216ce0CNYb0sI9i6DOu
         1rPRHIc7R0BueNqPDSTA+EVy3RlPW/5tAU0edDzjfZEiwjqzypFA4u/sQwAqJecDrHse
         XV4ENMvddAstFVbvkkrUSSLY0A53yL3cZUtRvSiGI5DY1XyACBzVCJogkqkOLTx68x/z
         SY2jYpSyMInNIdj7yK4mVGRcN74vk6yc/NXOnqL2k1ghtoD2Nqg+UyGm5kgxcRZgfDcF
         GGdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753767887; x=1754372687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3cz0hAfmTTvl+76x/6A3khLDSp6/1Q/+pHFEJNnO3Rw=;
        b=r48N285csIQfWM5jdU4iRqdOUWeKA+4siyQSwk/VmbDbXo0n0cMOlSvuk/cHKocaOG
         O5vLHIlmYLfwOgeyFXG69VIJtJ1oQQ2cSUzl3mF7bY9zkmi5pcpdqfr5ZIJD1q32bnt5
         pGdFYUyGF+mXezyUaVPDFbbt9x/j57lFRmorGJ9Hw3qxKIAh6b78tSgS14wd8b/V0kbl
         Vi6N2SXCx7nmR2sAAXevYNTFeDE/4Qq6w7Q6df5kJC3ORPdCKNWULAkgWU59lpNwwpy5
         q0TF5BEG6wKUHPp8TZBCq0s/jwN+5iZKWwGcpSQOtb/nxydTseUIXDCcFHHTVx+FVGbL
         673w==
X-Forwarded-Encrypted: i=1; AJvYcCV87NXmM+ng/+nlsfM+1jLbfcmJZ7iRWI/UeGeAxhggsCslMb84EOVsiyLJWWhJJ8o1w+7mfXfj2VaqoqI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx7VbpKdylCOoW2hzWgHmAcKe8S1YtEMIDem1XFt+3iWl0buDD
	wD0iv6flYUvM5c9L7m42yV+WLW5sXcuYt2HTIrGRQSRhKIZuUeBYdWzuWofb4NUrnAE=
X-Gm-Gg: ASbGncuRbd5hz87h1BOgAVvfe2fllFeUt8UziiG21NUuylVfU4xSH9s6uhsucuhgo85
	dunNCfOUoT1hgPWS+gVV/0aZuq8DipP7eAT27hda7nZxY+D+ws7t4UfQgP52nKrz7jAgXpMPW3G
	l+AXrxaPIhU7quhmWdeuwkl80RNOyUIUBfDJHRLHBmGl6W5yn2HXZOGHbUNSMv/TJetiaCaea7G
	aFpKJEZEZ4NWvlmZBH1ZNAvqfDFC11h1dnvE1gLWi5+s9TQMDIwh9lzJilx00CwGx1DRjGOiw42
	l1dAWoD9SwuF/83kOAkKRm4y+ynfT0aMSPYey1UuuZ8HJArrhFcCjH1OMdNVqYl6DlkoqHmip5u
	2Hb+XsKUzPV7kIzt0NZOAEh1BJa22yAQTTi04NBP24LND2RMmGDbQMQnLSFiq
X-Google-Smtp-Source: AGHT+IGah/K2Kf1bDWtenETiFySO8an4FDCFWmr6N2dAeClkfyN4gd4Uk2XWExkSGq4VfY6iG4VPBA==
X-Received: by 2002:a05:6a00:2e23:b0:742:b3a6:db16 with SMTP id d2e1a72fcca58-763377f25f6mr21242667b3a.20.1753767887419;
        Mon, 28 Jul 2025 22:44:47 -0700 (PDT)
Received: from mystery-machine.tail542cf.ts.net ([64.71.154.6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640872a500sm6972462b3a.22.2025.07.28.22.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 22:44:46 -0700 (PDT)
From: Brigham Campbell <me@brighamcampbell.com>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	linus.walleij@linaro.org,
	neil.armstrong@linaro.org,
	jessica.zhang@oss.qualcomm.com,
	sam@ravnborg.org
Cc: dianders@chromium.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Brigham Campbell <me@brighamcampbell.com>
Subject: [PATCH v2 1/3] drm/panel: novatek-nt35560: Fix invalid return value
Date: Mon, 28 Jul 2025 23:44:33 -0600
Message-ID: <20250729054435.1209156-2-me@brighamcampbell.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250729054435.1209156-1-me@brighamcampbell.com>
References: <20250729054435.1209156-1-me@brighamcampbell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix bug in nt35560_set_brightness() which causes the function to
erroneously report an error. mipi_dsi_dcs_write() returns either a
negative value when an error occurred or a positive number of bytes
written when no error occurred. The buggy code reports an error under
either condition.

Fixes: 7835ed6a9e86 ("drm/panel-sony-acx424akp: Modernize backlight handling")
Signed-off-by: Brigham Campbell <me@brighamcampbell.com>
---
 drivers/gpu/drm/panel/panel-novatek-nt35560.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-novatek-nt35560.c b/drivers/gpu/drm/panel/panel-novatek-nt35560.c
index 98f0782c8411..17898a29efe8 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt35560.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt35560.c
@@ -161,7 +161,7 @@ static int nt35560_set_brightness(struct backlight_device *bl)
 		par = 0x00;
 		ret = mipi_dsi_dcs_write(dsi, MIPI_DCS_WRITE_CONTROL_DISPLAY,
 					 &par, 1);
-		if (ret) {
+		if (ret < 0) {
 			dev_err(nt->dev, "failed to disable display backlight (%d)\n", ret);
 			return ret;
 		}
-- 
2.50.1


