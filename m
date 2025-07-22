Return-Path: <linux-kernel+bounces-741510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7A6B0E524
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 22:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25B5B3B7835
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 20:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1166F28134C;
	Tue, 22 Jul 2025 20:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bn//0Btr"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083DC157A67
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 20:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753217837; cv=none; b=N4uCsWIWCF3Fief8rb5Dv/+spUF8qnKQEMZK+AJ1JSvZFx6uyAmAFnukb0av1nD3iKsup/UDZrs0PKmterd4AoOkCGJmKqGuaTRnncSuAfVlZDxAf2KDD2HGghEGlgu5+B5Q30tWdA4u7hVDP56OvZHcd15uhradbGgum+6rliA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753217837; c=relaxed/simple;
	bh=xSPzksZNwBR9SNi+Q5CzDpsVZ4hExuAC80mJru1Tt4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QNFlErwrnDBMwKImdkg4WqhTDh1hy4/AHNQdFZLcRsGC8zvbiA3aag6dSP4WpbnjiXq/DvH3YG8SgtqvD6nYSaHeVbhhRCAtcHHl7sR3yamxABG0WROFoaCuNhe5mxcQV8AJlgzCCVA8uN75UydOwKBF0bKxHgln1PR5sPQQwc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bn//0Btr; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7e33010556eso11900485a.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 13:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753217835; x=1753822635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9Ni4reSpg/ovbb+dQzWuFGbKfq/xFDZYYdVHUx+/XF8=;
        b=Bn//0Btr/Y0cANWg0wpz3G23M6WRul767S0UAQDWqOu4V7KxANC4k9bVVmj+puMXMH
         U4J5XkezNk2n1r4LtQKtZwX5IA2BhHfHjNIut3d5CWV4HSznWfBNc/XhU8XtslKXdCuK
         z37da9DjgVQLcCsy0cH6KH9uqYuFqXXTIzCw7XFHpHUgLmakZfH6o5JHTS4WrwNTM0lo
         QQvcxriStmafzJZExmDmDIV/1niaRTc2wOH2YtXH6Xf9mSZQ7KnWBKNvF1Jtq+DLN1+o
         +JaMDS5SuVE7XoW5uG9fgPKrvuB7wyQ/x0Rhpxn0R/IcC9npNPPXoQuNR3xRD89PYLkO
         K71g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753217835; x=1753822635;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Ni4reSpg/ovbb+dQzWuFGbKfq/xFDZYYdVHUx+/XF8=;
        b=raGe1WJzYr1Bg/x4nll/k3gpUT+WQjdlAC8/gGDCYY6bijGt8lLRVKVCch5R7wLbY/
         WCgYUwL60i9yjnXYiZEaeGsyxnQ4QUvPpby4l8mRci9OdKhzlCamEFfFnfieKe5PmVBv
         NEDN+O1WuFkqOABHwAS0O3ZvjPDyZMnqsvVAg7iRYFZA7Ez8OwtDZhiL6VTonlLruSEY
         caNcoD60lWcR5IFl1FexA+oytvCpHrvOVk6uSgf8OvJLG4ZcEkybRm37rcCzfwpuqRnJ
         0Uj9VPiIJACUWC3GFsFdH9C0j0y/ZeP1O3AXElbtXhsDVnA92cpvTPMfVjOtgLrdYvv2
         yivg==
X-Forwarded-Encrypted: i=1; AJvYcCUG/kzNzYZHOx50GXdf8sGs3jGe5SfCkDozI+0DUa6cj+kOjFg4P+xAWLNU7APu9d2xBSBoDY/u076aI0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCUggKwUBdwbUqJ6mSli07xdKGGSCfoLKSsYtDcP78DeNJW1xh
	dsRqZKvsJCGNgwMawUvF/+rSnN3kidalBc7mggRAanxOQcXGIgtwzww=
X-Gm-Gg: ASbGnctHaG2Dh3UJ7A3/i0WJVVTjaH9Yfi8V8jPHKypg3Q6g7rs12GGM5OvQ4S+NASv
	4jMrEvhriLwv1dAbMNQHF321heb9kP63PArGDTs3m4HMu6PS8DBsppZA/lIs16m0HObEW/K4fEn
	3Oi6joa3feq1rjrkoVaDI7XVMKYMHccRazLVW025iqEOxP2uXior9z70RIzm/nSHCw0oLAeEC0H
	m1MT/4gR6RQFfLRdUtjWx9kPomTOne/k6KR9yCNRBOnfkTBhdn7poSluIoihhjmvwBrg7iSwqDH
	0XmBOP8P4B5BKcLJB0nFETChWFqMgX+qs5OuFPYKgPtovbZv4T0gsABZvorPNVQQlnHkc7btMmx
	Xz/lR9re1ywpOOLs+8Us=
X-Google-Smtp-Source: AGHT+IFI703RqUMPXBkK6u4DMpbC2ERSWtTtuSuXl4kfMXLj5oteqvHgAkjlrCVXUcf5ncI2KnMTyg==
X-Received: by 2002:a05:620a:3720:b0:7e3:30a8:4c90 with SMTP id af79cd13be357-7e62a134a91mr49551185a.3.1753217834709;
        Tue, 22 Jul 2025 13:57:14 -0700 (PDT)
Received: from ise-alpha.. ([2620:0:e00:550a:642:1aff:fee8:511b])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356c9230asm570181385a.93.2025.07.22.13.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 13:57:14 -0700 (PDT)
From: Chenyuan Yang <chenyuan0y@gmail.com>
To: andrzej.hajda@intel.com,
	neil.armstrong@linaro.org,
	rfoss@kernel.org,
	laurent.pinchart@ideasonboard.com,
	jonas@kwiboo.se,
	jernej.skrabec@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Chenyuan Yang <chenyuan0y@gmail.com>
Subject: [PATCH] drm/bridge: lt9211: Add null pointer check for LT9211
Date: Tue, 22 Jul 2025 15:57:12 -0500
Message-Id: <20250722205712.3527922-1-chenyuan0y@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

drm_atomic_get_new_connector_for_encoder and
drm_atomic_get_new_connector_state could return Null.
Thus, add the null pointer check for them with a similar format with
lt9611_bridge_atomic_enable in LT9611.

Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
---
 drivers/gpu/drm/bridge/lontium-lt9211.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9211.c b/drivers/gpu/drm/bridge/lontium-lt9211.c
index 9b2dac9bd63c..6be30c8bdf15 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9211.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9211.c
@@ -463,6 +463,7 @@ static void lt9211_atomic_enable(struct drm_bridge *bridge,
 	const struct drm_crtc_state *crtc_state;
 	const struct drm_display_mode *mode;
 	struct drm_connector *connector;
+	struct drm_connector_state *conn_state;
 	struct drm_crtc *crtc;
 	bool lvds_format_24bpp;
 	bool lvds_format_jeida;
@@ -516,8 +517,18 @@ static void lt9211_atomic_enable(struct drm_bridge *bridge,
 	 */
 	connector = drm_atomic_get_new_connector_for_encoder(state,
 							     bridge->encoder);
-	crtc = drm_atomic_get_new_connector_state(state, connector)->crtc;
+	if (WARN_ON(!connector))
+		return;
+
+	conn_state = drm_atomic_get_new_connector_state(state, connector);
+	if (WARN_ON(!conn_state))
+		return;
+
+	crtc = conn_state->crtc;
 	crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
+	if (WARN_ON(!crtc_state))
+		return;
+
 	mode = &crtc_state->adjusted_mode;
 
 	ret = lt9211_read_chipid(ctx);
-- 
2.34.1


