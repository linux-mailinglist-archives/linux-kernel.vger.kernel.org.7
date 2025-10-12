Return-Path: <linux-kernel+bounces-849692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E9701BD0B1C
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 21:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6B2DB4EA59E
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 19:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26812F25FD;
	Sun, 12 Oct 2025 19:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVHmPDsE"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA9B2EF667
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 19:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760297025; cv=none; b=n1Xj83Yt+3FpqRXZ0KH8Il4C5Ilz8561dTSsugKDiHX1W/mNiSezMeJ1N50r6Jb38uNQfupqqU25S/1XYdl4kn/0B2gxIhQg5SaT6XbpJp0FgQLHwvUs/FrRLeu2DbpvjWFJWSt97kVjg2W7YBNHhO6+5RyOQMR+fqSTbZRUPW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760297025; c=relaxed/simple;
	bh=NgcvXnqcgYXjrcWR7jLLpOQ3cQB6p2pkTov3MyQ+eCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lsfey/Uv4gS+bJrZV1tfn1966+VPJ7BZMdw/6eMIqRsR/JWjyzx6gtAgPxnZbjjKCzwXjP9OnrwqJ7M+nA2QeRZtqf1q0HDlqYhOGJ/RnTQ5WKC3MoUFHy3WJX0k3aqHHdpBS0hcBBYtqxQmisrfTw6aYLPwbjSfiENbR108d48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bVHmPDsE; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b3d80891c6cso703896566b.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 12:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760297022; x=1760901822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O9pllFFRdLbfJa3CzMw9MDenjUagmZAUwkBtCn+ZhPI=;
        b=bVHmPDsEaBlSVU5vTwAsbDT/X7nROLvzvm/iiLSMIqxApLp+Lg09cAZwdvdoXl0ui4
         heKA/XHGnX8EelIRbK6ioH/5k23kw6jgIGZXXuP/ZUS9F3Xn4QTT6dr4yeGG/h8kQA3s
         mNnos8lHCg5xUc2vPxzwOgrUhKS6LpPSD58g2llsYAYzaUPuS6z7HNqJq0C4tDZ67CCp
         OWw0LXV+jeb6nIakfxItYgu1xtO1DfmeOdrO+PtYzd8FrXPV7C+MtzKf8pL6tXKB90El
         Yn2rqLlyfCQqb+fpScIZZbucVeWJm/Hn9HqMehyXU3Rom8xQWAbTAaVrB/29ZZoQsR/3
         aLKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760297022; x=1760901822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O9pllFFRdLbfJa3CzMw9MDenjUagmZAUwkBtCn+ZhPI=;
        b=B7FQYu+FzllkmS1zD31Q36gdLNRfqtCbaqPajmxW2cwlJRuK6ZJzs9kMWrLgjRggea
         8STCJS0qI0dVjQUPgFT1Laqrj3A8lIw1GZAWKrdKrhDotKDP73Obz/6hGzKsPUEXV3qy
         MvhOPCxZYzYy71khbzO/927gR0qd3WGuvHpJAV7ieGDercXaLzU10YBQsjMv7bQPTGIl
         B9w5YCFbk3AeIx7E8ZKsDxmMyqqQJrH9d4RdQjQawWwOvdQg2B5Akg2hd10YNyawQp/d
         ZGdFI54nZfRJg9mm6Ixu5zzUuZbCDvzBeFrUdrt+k5MsCFcOV6b9y9W+YIDDkwyinvmh
         agfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXychhccxbZNgTLQahr80N4/zRe2gYmLpGb4wN/CWjzry5/3/tIql9IQvlEc+Pm67IP+G58pFbsqhsARE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAks4vkPLp4nd1ir2iT7tq7kF7ab1bq3/10Qi6/cTKkeyhHIlu
	wdjEwlIUiJX1QQG2qpj/ZcxUw53qimHRkyln7mKNMNQp6qO/uJ9w3oK0
X-Gm-Gg: ASbGnctJmoNOQd5lNZru9iWAQ7SwIcHxbhjAJd4WLMFOaMsAJSORF8NYY1TwzY5mbCX
	i9HEXZTE7iopxLvzrvyJp3MW67ExCBj44/DC9xT40wtSldOgw6RkII6vXAHj9S4M2jubNeVIn5L
	NKwvA0awNNFLuzFptK+6DSy5+vtMB+xgMLVfuZ6BNk5xjxEzfUi/GG7HK5f4aC7HnP4AVDTJPjv
	+Iw3zY7bQM1zDqNh0ZcRaLxVGc02PwwzbawxPXcWw2Xuiq7WmARakj6IIbN+Z2recTE8AhA5aky
	rNoAFNatTznn4YAtNHhtW5p42zwois3QAo4kIF9fwThB+6kI4AWa/WnX7qgEGRwFig1izak50P1
	THdsB7APAI8Ct9xrcUqLCBPhj3Js8h+FsOM3/1JYc9g2QouL5wFXV4sI9ErwXDZ+Rcqk57JNLgc
	+Mel19lkuT346PZfnchvRL
X-Google-Smtp-Source: AGHT+IHSovbe/H5UYTgSA1JPDJbOFUPVXMxcZWI/chJwYDsAxjOuahQb+OA171YuZ238MSsvaekD/g==
X-Received: by 2002:a17:906:6a16:b0:b23:20e7:b480 with SMTP id a640c23a62f3a-b50bedbf4f1mr2357634066b.18.1760297021975;
        Sun, 12 Oct 2025 12:23:41 -0700 (PDT)
Received: from jernej-laptop (178-79-73-218.dynamic.telemach.net. [178.79.73.218])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d67d8283sm760176466b.38.2025.10.12.12.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 12:23:41 -0700 (PDT)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: mripard@kernel.org,
	wens@csie.org
Cc: maarten.lankhorst@linux.intel.com,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	samuel@sholland.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 02/30] drm/sun4i: mixer: Remove ccsc cfg for >= DE3
Date: Sun, 12 Oct 2025 21:23:02 +0200
Message-ID: <20251012192330.6903-3-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251012192330.6903-1-jernej.skrabec@gmail.com>
References: <20251012192330.6903-1-jernej.skrabec@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Those engine versions don't need ccsc argument, since CSC units are
located on different position and for each layer.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/gpu/drm/sun4i/sun8i_mixer.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index 31a8409b98f4..f7f210a925f8 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -790,7 +790,6 @@ static const struct sun8i_mixer_cfg sun50i_a64_mixer1_cfg = {
 };
 
 static const struct sun8i_mixer_cfg sun50i_h6_mixer0_cfg = {
-	.ccsc		= CCSC_MIXER0_LAYOUT,
 	.de_type	= SUN8I_MIXER_DE3,
 	.mod_rate	= 600000000,
 	.scaler_mask	= 0xf,
@@ -800,7 +799,6 @@ static const struct sun8i_mixer_cfg sun50i_h6_mixer0_cfg = {
 };
 
 static const struct sun8i_mixer_cfg sun50i_h616_mixer0_cfg = {
-	.ccsc		= CCSC_MIXER0_LAYOUT,
 	.de_type	= SUN8I_MIXER_DE33,
 	.mod_rate	= 600000000,
 	.scaler_mask	= 0xf,
-- 
2.51.0


