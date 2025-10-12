Return-Path: <linux-kernel+bounces-849715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A26BD0B96
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 21:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5C9824EC201
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 19:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3560D2FC867;
	Sun, 12 Oct 2025 19:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dThX/gtF"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDDF2F28F2
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 19:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760297053; cv=none; b=bkmcDq3JaapW+Cs34gELPE7GGK417Zh1t86Bb09PIbRDpwLaMugXjH6jDmsdfg8GBMRFLRZ06FSJR/+lTOqf489TP5C3pxfgS48egGFB5tLcDAjCe3aVJNUPl+reNm56IVRNKGe4ph4Etd5N+opqIlABo8Xyqd0KEe62CHZfvuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760297053; c=relaxed/simple;
	bh=7Vpg5pdcwhpe6j3H4rCvIT3PXPexXBscDV/N0+A/BKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bvIAXlsp3j7yUI0EhTqhAi/SvDwPcIHiphEIbBK8EOnXirOrj13zyZoFs+ZGYCzYywQ3f2CAQmscLbOy7bcoojLHP3igpZk/5bznYBk6dEH6dm6jzzI0WZpiC+/ErIQcKXijkA//JM77Ngk5OYZpum9Jo9p6byRgKRlfKjfr6z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dThX/gtF; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b457d93c155so572112266b.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 12:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760297049; x=1760901849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WhJ4Mx5N84YekwfwtgsaM13tMkuKqezRguQA+ougb2A=;
        b=dThX/gtFUTD6lhiUMmmIyuFBR0KeNcvon8MYEMB/+Tfc8whvQeI+9ScsML82yBYFRR
         SYea5PSszloayNrREBwLi0b5KBR5mm8dYn2TpaHjgEA0AzCyLPqgPPX0TPN5tsd5WMYM
         UMbfs6Tlg5XVOXDx+M/bsXpjq84wtZ8cyVmf+31K10a63xlmkH3DpokavvYKYruqJa2Y
         qiBUe8jgPwmzRbgsgPTyl8KiblyGH3Jqc+DhzH2TszV23TK1ljXiyZtTjRnjbR4PF9Hd
         CuHBuc8zxJm35zXMuZwj2uz7KphYa8t8G2BeGpPK0pwO2cJtYBi0i0vfIyNMMCHcv50C
         50+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760297049; x=1760901849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WhJ4Mx5N84YekwfwtgsaM13tMkuKqezRguQA+ougb2A=;
        b=bLJiDCjs9FvBg6UnKAZXL6PUv0H9mTEEUbSaQhXcHYlMDqpn/gwzBpeEgDaU75OXji
         Runvb8VbCjWDDc8yehP1YoE8/rhN1S85bQp6X/5FNWfTQgljf8bb2kF444wC8RPu7k0x
         Ig0QxoVaiqV88MPgLSa01oYPaVDucR5Ef7jEBCoXLyT4yZECBzo3C/XMIkWwClWhGLA1
         1jE8E1HYJ+Gp11T5B8m9gsysli0qqLb7FELkL2vxtD5eHUfsZ8Mx4pDBtO9ThGD9KIqI
         eLhy7E/1GQqZgeyUu+pPRu+tzDa0+jDmqxqePLyGSCxUo1py586mIY2SiTpuFEE2dYM7
         ekBg==
X-Forwarded-Encrypted: i=1; AJvYcCU+fnkHB7OzQ61cKxp8vrcmym0HpvhGi0f1JnYiMeltKUe93/Ic9s0EMceAPBRfK/ux7kr/bnKjE+Po/uw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyHSfuvOEe1N2Fo79oeMCZELysbD2SptnToGAI4o24rUlTUJb2
	FTR21Mq/9Fhl+ZzeKKFwW3gCQ7zogbFFaZQunafSz/2k7+wNiWqAT2lO
X-Gm-Gg: ASbGncuKwe6W+T3Z8z+kq/xDsvP6faA+AKj8iMPONu7ZZ5J6FjeKJDoqOds+rKYGM+7
	Mkk6BcMCmw2aGc2SftktZ/dyICQ+IO5QgB0pX9q9CRA2LT8KBSK/B2JoZjyiiPqgVLuFW414//M
	REVyaUelDAduicLiUoUhs8qtfrDpzDDaRdWK8w9221e/kbu4w36MkIgJ+n8iweOrmLREJwewix6
	1W49zGaGFjg4x/hhygu2m/ocENAp6zexvrQ2lJCkvfBTUDv80eOAJQldnh4FLVGV9SA/ZiOoKfF
	5PIm7Qgluns1S/HHZd+IIGoKA8O6vwe4HSN2+z/UgH7sAfyEy2fRjIyDcfm5d/Es6Ad1Wh8QeeJ
	6I+49DInDtsKOsrBr0+d4zzJmAcL/IfMqkg1vLkqWPM2qkRbb9R1lZt2sStJRe5+oLfvTnwXGlq
	I2/BpRk1cR4BIC69Wj3vqlBQhU895eE00=
X-Google-Smtp-Source: AGHT+IFR0pZ/YrbCaB4kbdDAW62+ktVARq4KWPwTuGdcL/MYc6Uu9RhwoTSIe+WpqZdntWjE7guIfQ==
X-Received: by 2002:a17:906:1b47:b0:b4f:3c7d:ff5d with SMTP id a640c23a62f3a-b50abfcc8f1mr1504360166b.51.1760297049525;
        Sun, 12 Oct 2025 12:24:09 -0700 (PDT)
Received: from jernej-laptop (178-79-73-218.dynamic.telemach.net. [178.79.73.218])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d67d8283sm760176466b.38.2025.10.12.12.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 12:24:09 -0700 (PDT)
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
Subject: [PATCH 25/30] drm/sun4i: ui_scaler: drop sanity checks
Date: Sun, 12 Oct 2025 21:23:25 +0200
Message-ID: <20251012192330.6903-26-jernej.skrabec@gmail.com>
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

They can't be triggered if mixer configuration is properly specified in
quirks. Additionally, number of VI channels won't be available in future
due to rework for DE33 support.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/gpu/drm/sun4i/sun8i_ui_scaler.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_scaler.c b/drivers/gpu/drm/sun4i/sun8i_ui_scaler.c
index 2fc54dc20307..c0947ccf675b 100644
--- a/drivers/gpu/drm/sun4i/sun8i_ui_scaler.c
+++ b/drivers/gpu/drm/sun4i/sun8i_ui_scaler.c
@@ -132,9 +132,6 @@ void sun8i_ui_scaler_enable(struct sun8i_layer *layer, bool enable)
 	struct sun8i_mixer *mixer = layer->mixer;
 	u32 val, base;
 
-	if (WARN_ON(layer->channel < mixer->cfg->vi_num))
-		return;
-
 	base = sun8i_ui_scaler_base(mixer, layer->channel);
 
 	if (enable)
@@ -155,9 +152,6 @@ void sun8i_ui_scaler_setup(struct sun8i_layer *layer,
 	int i, offset;
 	u32 base;
 
-	if (WARN_ON(layer->channel < mixer->cfg->vi_num))
-		return;
-
 	base = sun8i_ui_scaler_base(mixer, layer->channel);
 
 	hphase <<= SUN8I_UI_SCALER_PHASE_FRAC - 16;
-- 
2.51.0


