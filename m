Return-Path: <linux-kernel+bounces-891521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6559FC42D6B
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 14:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F26C534894D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 13:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284B11DED57;
	Sat,  8 Nov 2025 13:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ftv/matx"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72ED6D1A7
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 13:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762609476; cv=none; b=N7XQJ2ZgnxdurfkKQZC3TP969Ehk5WI1z4xdedsr5FKjKl3BvC7ZaAP5px5QtxUPdK2NptYO/YyLsn6xawPLUVT/yVotzSnVz6pDVrDBKvFZ04dEv3BIQFTvXF3+qQnGUvxxt+pOclDdhJXvkXoBn0xLkO0v70LOfOq4yfmuqyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762609476; c=relaxed/simple;
	bh=FtCvi8AIrARWMNDczj1sLrGTJlSAggLQnxBGZTevvzE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XrlQkSWeBMyAGzSd0yF+vOQxUIyA9IVRkAyc3M82fQtrxhga3smt6E0AntT8Jlcat5App5uRkhDzQdWzcpSY0wE1KhMNH6UciAGgOkZQ9/v0+qB/+3glbvJPklwx7iLR2eBR3oZSfj2YNG+T3e9AVRLvSO+TJCCw6dshhWjBZFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=ftv/matx; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b5a8184144dso214996966b.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 05:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1762609473; x=1763214273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ab0dNgePo+ve9gQ9R7d2FYgAaNZrPU8kUu+qmhjPbGo=;
        b=ftv/matxuIrMcGOxQ5Z9ddv0n5BrJ4+2aQs6jRGt8fgxxo+KqevBR7xP92YuyrAfce
         C4M+14pXM+Xsde96MxN7ZQUqv8B3TriIZ2NYxv+88IBCtNr+ltinOgGLX93fEAQS5axz
         MKZQqu7TUSUzXTt4rE06EeXswWxHHTcQ4NTYBvqBqDE5Q60gVEgWYB3qZf4dy4KjyLtJ
         ygQMt6uQifD72wQs6jkFI8byd9AQZc7zlR48XVHB2xFrhexd1cu96jZzsOhke4+sAa+N
         F6CnU7weiTVN1epDDCAiXfl7fSaQUk+8AdNlM2hcjLcrrRZp8NpLPgq5whfgNR0qZGu7
         JmzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762609473; x=1763214273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ab0dNgePo+ve9gQ9R7d2FYgAaNZrPU8kUu+qmhjPbGo=;
        b=jxL20/rz2myN6pZiJXjUw0ZaQ3F8a6T6BBsFXskxj4+jfws4zsrw+vbPlWWeJfm5bm
         Zik58UZY7zupGdqr1sd9wbz0FCXSBYqqzr3kb9DmbNYtwG6uGrfZLqgUE3f8jOs4vdc7
         i/Cp46PQ2D9w/k4SXOrXs8ARzmeFAHggD+GiPzasdmFOn9ORdV9OHeYNPJ9+oQfiT/Un
         vTB+Wx6aOevq0jKsVykYhaIQPxkZGm4eJ/3pS6/e5xgsVeQUyekalUWMQBIl7jMigZmp
         5Vq1RF9uktN+FJJmVJ4LOPGSfTItHpIeKWSABIc2oLs0VC+U9BR1vpQt4geLRX2zt0rT
         yDjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWu+RbxZiHHkU1WAvGk7vuyJlQVAoSmBEu6DVZJN7HvS8RH7h6/O2E4ZmCdBBzNYfDMzGznX1S6Qs4iXus=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+fWs3is48eig54DM9xfJ4EarYMPf2NzV7f5YA5dT9+3JpuC8l
	EIMfNYxHrkCfcDAvzmn2qXVnY+FQDvTWBY+Y5w1pZzvx4Ntn9Zrn0cT2
X-Gm-Gg: ASbGnct5S3RhkD7z6CUy5Www5uroasM0auHJNnuAanJqQLXF5k36QqgFKyWB52rS7tk
	KheAjWJ2+QCiDAzD6BerR+iWzo928N33N5H/RU7sXqD+neE7NCJ7O36fqu+VBP1LAjkzz7128z7
	T6O5FafttdchxJz9FBpvIt6XvJdkWavtn8kvNhWXvkuhgNJW9SMuLvJR8qLS5k8GguhIG+LKi4S
	cox2TLlDUTC/FszZlb139UO6K5fj2GgLxc0YlsHViDnrDUCEOQ5XaMjeREXPoBtUVv6KPeiIvyi
	F94tEfTIjQx3RuLkjmJWDqrApCKRFvSRyIJk0rDvZl2TRrdwtv5cG5TAEDvIbQ9aa9BOVng1pEv
	R/agsY/h+cXGAtwPFCHheLGjM86208uG0GiylXu+a50ajtjqbQaUu7Cq6FY4QfMFHT7Lx/2AWBl
	B94ooLprr/gAjEBAjro6o+AahG/uGzKHKT3W+GJq5D7iU1eeaPCmtOAESE2j3DaZxqteg7dQCp5
	Y3hMvS3hLGYy57BwTWsMF0cZ8pxMW9LU/5DlRFstM1p3QPtagIo
X-Google-Smtp-Source: AGHT+IE3t5XHoEClnas6c0fwEVjyNk2axByTaO1rMD+gsebxQxdsSRmYQhKPt6+QjmiTNvXr08iIdQ==
X-Received: by 2002:a17:907:6e8f:b0:b6f:9da9:4b46 with SMTP id a640c23a62f3a-b72e056cc6dmr230845266b.43.1762609472959;
        Sat, 08 Nov 2025 05:44:32 -0800 (PST)
Received: from blackbox (dynamic-2a02-3100-ae88-0800-1e86-0bff-fe2f-57b7.310.pool.telefonica.de. [2a02:3100:ae88:800:1e86:bff:fe2f:57b7])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b72bf97e54asm531374566b.34.2025.11.08.05.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 05:44:31 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org,
	dri-devel@lists.freedesktop.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	neil.armstrong@linaro.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	tobetter@gmail.com,
	christianshewitt@gmail.com,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH RFC v1] drm/meson: venc: add support for HDMI DMT modes up to 3840x2160
Date: Sat,  8 Nov 2025 14:42:36 +0100
Message-ID: <20251108134236.1299630-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 5d0bfe448481 ("drm/meson: Add HDMI 1.4 4k modes") added support
for HDMI 1.4 4k modes, which is what TVs need. For computer monitors
the code is using the DMT code-path, which ends up in
meson_venc_hdmi_supported_mode(), which does not allow the 4k modes yet.

The datasheet for all supported SoCs mentions "4Kx2K@60". It's not
clear whether "4K" here means 3840 or 4096 pixels.

Allow resolutions up to 3840x2160 pixels (including middle steps, such
as WQHD at 2560x1440 pixels) so they can be used with computer monitors
(using the DMT code-path in the driver).

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
I'm sending this as RFC as I'm hoping to get some comments on the
"4Kx2K@60" note from the datasheets.

I have tested it myself on a GXL Le Potato board using a computer
monitor at 2560x1440 pixels.

This is the spiritual successor of a patch titled "drm/meson: add
support for 2560x1440 resolution output" from [0]

[0] https://lore.kernel.org/linux-amlogic/20250927130239.825060-1-christianshewitt@gmail.com/


 drivers/gpu/drm/meson/meson_venc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_venc.c b/drivers/gpu/drm/meson/meson_venc.c
index 3bf0d6e4fc30..4abd0c09b442 100644
--- a/drivers/gpu/drm/meson/meson_venc.c
+++ b/drivers/gpu/drm/meson/meson_venc.c
@@ -868,10 +868,10 @@ meson_venc_hdmi_supported_mode(const struct drm_display_mode *mode)
 			    DRM_MODE_FLAG_PVSYNC | DRM_MODE_FLAG_NVSYNC))
 		return MODE_BAD;
 
-	if (mode->hdisplay < 400 || mode->hdisplay > 1920)
+	if (mode->hdisplay < 400 || mode->hdisplay > 3840)
 		return MODE_BAD_HVALUE;
 
-	if (mode->vdisplay < 480 || mode->vdisplay > 1920)
+	if (mode->vdisplay < 480 || mode->vdisplay > 2160)
 		return MODE_BAD_VVALUE;
 
 	return MODE_OK;
-- 
2.51.2


