Return-Path: <linux-kernel+bounces-860686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DB4BF0B24
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F3C63B0735
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF241257821;
	Mon, 20 Oct 2025 10:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XplTNVku"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B164E25485F
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 10:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760957897; cv=none; b=YDZrTZE+qtvIfyYg6sJ6x1P25anPFcd+/Ue93pbx4fdkiyWkLvKzbzOxvcz74pOslvate2fYvMieFrFHFuahvDv1gcQ/sTXaGdA4DpIhI+lRiTU5XMcvPzbXy7OGZxNuiokw//ZMrrVGMMo2b3u8SVz5/uan1SZik0r/wAG5B6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760957897; c=relaxed/simple;
	bh=Iu/q4CpFhSAJM0jEkgFHmScAOFtrgsT2qvatKDMc2d8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UnZGvmeTSBC+V8eU+3LxKO2V9rJZ8I+ZAes0CnaFOWumwGjID6yauSQLvQV+Gy7x6SpMfvpZeYNwPbhbOhGsGXz4sfNNH5eAH+iEnCQ55SuS7I3W+ZXlA0qihwYB9JHRz7FQdp9KKdwlpknPRcYz1MtuwniIWqFrmIxM3Jr7zNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XplTNVku; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b3f5a6e114dso77685966b.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 03:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760957894; x=1761562694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GkFaQ1bopt/VkRBUzrDCpvzpaSMPfW8Xt+ULvEdICqg=;
        b=XplTNVkuSRyRK6erExL6db9qLfvaxRXIfixgGaXuWFfAl8774XiacwOoBS+tJOX2Ef
         oPPJRsZiAgdDrIFN8XP1hXDAyeQ1RwPRj+HLd4VlOcMAzt/qN4F3vB4q24un2Ag1y2oU
         q9r8yvESEtYeZvDxdo2noYj8PR878pDXmnxnwnEIkQ5Ynbf1LwRjr+hIv275NM1yMFEf
         +BqtChybjxJ6AbNh0Hkc6oxC9Sw2R4YP4OljzLvF4rP9D4+kTXlFjNMbxqxD6NfAREzC
         JhbClJOjCiDu8NAJ/GFRXcAVwgU4L9Sej+w7rAV8SjyHqxSU37dYwHPh/PXJopvkY5An
         qcyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760957894; x=1761562694;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GkFaQ1bopt/VkRBUzrDCpvzpaSMPfW8Xt+ULvEdICqg=;
        b=B9xXjYBz8C6GZtDp6ggLclkR1PNF9OlFqjXPeUkxRr1o/d62ujlDT9DcatTsTb/rLw
         wdeLOW6lC+UVNuwd7Op7HtFTAZUiuWiuQsmclR65dqexMXt665A+SkZHlZmz3uapyUei
         c/WNpGpypceQ34py+TQDuoLNXcsKFrD05QWbH2MuKYO58+4NFzvSTxglW1a1wSTfW/G9
         VIj+C6qlwHISHGdbz4GBAhLeFNwm+qHRJY/m7Jju04a/za1zFUzlqZx36dwMXkYUoSc9
         CiR/3AMsM03Cs98OlWrXlXG57W+5Ksrf1dwGHfDHlphHcolRxEIZfgsNc+ZW2xHYDChg
         WkbA==
X-Forwarded-Encrypted: i=1; AJvYcCWYRjK631HGWpLPV2F6CFexwSofHCqKz5eIeVNJ5XmExqoslTlue+cpiGKE66Emegj9IxL2Il4KrNFJYc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFNYTHYiOovC0HVRZE61Y/9ndY+DgJ50ActLPNnWJqyk20cnvO
	O4dXQ1D6XzMyc84VdyxWKa6is2lhdV1oovX0HBPtq+niqaNy7Ysab5O7a1vyGw==
X-Gm-Gg: ASbGncuZeYBUe+/al50Skndn/AHEvkQiSjGASP/XP4kvmFn2IaTe/N4j52PUKKMm1XP
	BDSEPCKGmDVfumDVCLTZKn9ems1hIQOaAeaUdsm4F9BEpXGUrhzfNhHVP3oTrL1Qz366sDW4ja+
	TZfZ0aB44TW6iN6zoQQtUoc9hwXv1TKQfBf7krsMWoX4jfXlR2HWJJJ87ehnd5A6FSqUFUettcY
	3chvlCU7zVAt5AYAiYdBNHIZkL1+rstH0yu1En3Kak8I3acsa9tmT1n/HzmjAi1dZAVsqdyraTN
	NfB3G1mp/m6DrIWFk5aa213pxZShdvoU7n7/Me8FS/YMfZgjxN1FR4SVKmx4A58017r5axNxEwG
	CXoOrm6gW0Ln8JnD62JjEdGJ8oMmbHtjQ/7+NtTPfcLFQt5EmmSmoSmwmoFwhmUpQc2hMkONbUd
	ptLek=
X-Google-Smtp-Source: AGHT+IFonlP9IIaHnKYJ1FGKly6VFGVY9U/JNDCz4I3ar5aMmaJr0RPUUSGZ9EBntxqPtU8gcUrFxg==
X-Received: by 2002:a17:906:9f86:b0:b3d:5088:2140 with SMTP id a640c23a62f3a-b6472353d0emr769387166b.3.1760957893588;
        Mon, 20 Oct 2025 03:58:13 -0700 (PDT)
Received: from bhk ([165.50.81.231])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e8971897sm751474166b.37.2025.10.20.03.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 03:58:13 -0700 (PDT)
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
To: lanzano.alex@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Subject: [PATCH] drm/tiny: Refactor framebuffer's size calculation
Date: Mon, 20 Oct 2025 12:57:23 +0100
Message-ID: <20251020115803.192572-1-mehdi.benhadjkhelifa@gmail.com>
X-Mailer: git-send-email 2.51.1.dirty
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use drm_format_info_min_pitch() to calculate the framebuffer line pitch
instead of directly multiplying width and height. This aligns with DRM
helpers for determining per-line byte size and avoids manual assumptions
about bytes per pixel.

Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
---
 drivers/gpu/drm/tiny/repaper.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/repaper.c b/drivers/gpu/drm/tiny/repaper.c
index 4824f863fdba..aeff49bc6ba7 100644
--- a/drivers/gpu/drm/tiny/repaper.c
+++ b/drivers/gpu/drm/tiny/repaper.c
@@ -517,6 +517,8 @@ static int repaper_fb_dirty(struct drm_framebuffer *fb, const struct iosys_map *
 	unsigned int dst_pitch = 0;
 	struct iosys_map dst;
 	struct drm_rect clip;
+	const struct drm_format_info *info = fb->format;
+	size_t pitch;
 	int idx, ret = 0;
 	u8 *buf = NULL;
 
@@ -534,7 +536,9 @@ static int repaper_fb_dirty(struct drm_framebuffer *fb, const struct iosys_map *
 	DRM_DEBUG("Flushing [FB:%d] st=%ums\n", fb->base.id,
 		  epd->factored_stage_time);
 
-	buf = kmalloc(fb->width * fb->height / 8, GFP_KERNEL);
+	pitch = drm_format_info_min_pitch(info, 0, fb->width);
+
+	buf = kmalloc_array(fb->height, pitch, GFP_KERNEL);
 	if (!buf) {
 		ret = -ENOMEM;
 		goto out_exit;
-- 
2.51.1.dirty


