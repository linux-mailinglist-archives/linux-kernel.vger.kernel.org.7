Return-Path: <linux-kernel+bounces-731699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA845B0586A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 13:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36659564B96
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E2F2DBF45;
	Tue, 15 Jul 2025 11:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b0PRHcdY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306D72D8DA3
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 11:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752577497; cv=none; b=Ffug8FGGhhRAWXByTriV4BBIp1LZySO49yzw65ML4TdRrQVzRN7q55FqJ4nfSuafr4JIwiB2uEECY2tus5NXF1rO9hXSbMI5RExxUuQHpVxDnK6gE4+t2nCa4HwWP+fZbM4vTcvtm3ZMduJugIBeKho+EoB7M2n/9/eRgIUJdH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752577497; c=relaxed/simple;
	bh=2wvpb/7iw3/tUpBGhNYsnG9ClvPh3Kj5BMeJKkLIGts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NemkC12qXn4BL39MmXzLOa+VkHjQfl20i9Zyc4J0I8aash6cP2QuoMW0E878hgVCLrhkdKvmn014T9tHmfY2naZ6tduosCytzCfZIpZiBH9P+kqAjLlHa47o0wofrfMtzpkSHO1V4B7UmiTOf2P/rzGO+hSVGmm4OXu8pdBn/68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b0PRHcdY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752577495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GUTEx4OQ+iPu+/+Q/wKZm/HJQyZUITrMttNxYEYt9Oo=;
	b=b0PRHcdYZRS2LXovYPGPhNT3A3Yrl65rAYpLQfsqqqxG6JotJopgb7QFBVF7GdPnrwPGpG
	EM3dGBfcUNlH4Rrv9MSsIV1Oxhvs/GLWoI/au32+HEH7438cs1hBrNJJm8ZKEywJk6Yavv
	1j5Ko81AyRoPPJhgC22tkMowfTG6f0Q=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-1Z5aw6TgNR-Vzxin2MXrXw-1; Tue, 15 Jul 2025 07:04:54 -0400
X-MC-Unique: 1Z5aw6TgNR-Vzxin2MXrXw-1
X-Mimecast-MFC-AGG-ID: 1Z5aw6TgNR-Vzxin2MXrXw_1752577493
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4561611dc2aso18493085e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 04:04:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752577492; x=1753182292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GUTEx4OQ+iPu+/+Q/wKZm/HJQyZUITrMttNxYEYt9Oo=;
        b=atgOIyuUhzAcoxvb9aNUtjPlbETvXUS8qnq/JyO5CRM2ClhZEeOZGILeM8cGEDQ8xI
         pY3D/lcQlrc5oYLHS2ikzb/JAOVJdZx2vTlQzG+Z+02LAg5YcpxqwYS7QzAU4TuZQMKL
         dQH+eeltpXDE1UwghqfSDeCr3XtFxfoRZa8x1iMISdC2tJAl/UbwPYlyMVBR3RhDdCvE
         Epd12QUhRlZkKTcbYr/4tdEXyoL+sfYmy4vpXOiWRCQnDXwXCByzeJZ5u3daJiClfuwy
         3SXsVM5GCDRgxjEThr7L7lyfgjLtrAg2r69TUdzGmiEZQizsXRKC8byCpQNMiCQkiaLb
         UHUw==
X-Gm-Message-State: AOJu0Yytk8tIxMWoIE8SMNIFCCIhW7/8hrztHDys5bupW9KzsITeYEJl
	hR3Y1WJJj3OOCe6HQHLpB4m+nhzbRpaLU1w+qnLcArCC2QEcgCCp5kkDyY+fMU7KqiQKYrdDw0K
	SdmIedfa3N9vWJ3jRnU7QAMShEWDkrBvN8YxkOSrAbp1qAEgJ8z2l6aLnN2MLYhO1rnhrGzEvSz
	I22i63BTKiNO6YjkRzPOPW2CLi8wD4bOTte3uHoK/EBdZvR9BQ
X-Gm-Gg: ASbGncuayKTUK9k+OzNleTE9BViH7Ff48Sn3GcFHlJH9QLWgRXvHA+nRpbewTYaiw5U
	yPbPuDsf1hmqSXsBHjcXuaDUtofbXahmShtbKLTdvIMHzJ0aEOnsRG0KfEhEb97vyAvuwIhM8/N
	M+38EPm427buO0TmnJS6VdMCG0kQ+9tMi7SYKRFuY9wPCs8yYq/PKpjItybiMG+U4pSGZAV4H7R
	Hcnw22ivU/CHff8MDSJRFoP71XTh3OhvlVgJzbFbchoNx1KwkDBBJ3Tg4/Wf2aQPtM8zFEpTKM5
	NMWUsuJSzK09ZI8bDP9Eha0H4ug9NB4j
X-Received: by 2002:a05:600c:19c7:b0:455:ed0f:e8d4 with SMTP id 5b1f17b1804b1-456272e0dcdmr24887645e9.10.1752577492029;
        Tue, 15 Jul 2025 04:04:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmwDbcGpQzV7o4wqwdcJGo0K3alKOX7KRNvEVVhHGrglQiohTq2M8WgJ8ZVBcysc2DXDnXhg==
X-Received: by 2002:a05:600c:19c7:b0:455:ed0f:e8d4 with SMTP id 5b1f17b1804b1-456272e0dcdmr24887125e9.10.1752577491479;
        Tue, 15 Jul 2025 04:04:51 -0700 (PDT)
Received: from localhost ([89.128.88.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-456114a417csm80207945e9.25.2025.07.15.04.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 04:04:51 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: ipedrosa@redhat.com,
	Javier Martinez Canillas <javierm@redhat.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	David Airlie <airlied@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Simona Vetter <simona@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v3 1/5] drm/sitronix/st7571-i2c: Fix encoder callbacks function names
Date: Tue, 15 Jul 2025 13:03:50 +0200
Message-ID: <20250715110411.448343-2-javierm@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250715110411.448343-1-javierm@redhat.com>
References: <20250715110411.448343-1-javierm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It seems the driver took some inspiration from ssd130x and some of the
functions (encoder callbacks) were not renamed to use a st7571_ prefix.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---

(no changes since v1)

 drivers/gpu/drm/sitronix/st7571-i2c.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/sitronix/st7571-i2c.c b/drivers/gpu/drm/sitronix/st7571-i2c.c
index eec846892962..634b426e2874 100644
--- a/drivers/gpu/drm/sitronix/st7571-i2c.c
+++ b/drivers/gpu/drm/sitronix/st7571-i2c.c
@@ -550,8 +550,8 @@ static const struct drm_crtc_funcs st7571_crtc_funcs = {
  * Encoder
  */
 
-static void ssd130x_encoder_atomic_enable(struct drm_encoder *encoder,
-					  struct drm_atomic_state *state)
+static void st7571_encoder_atomic_enable(struct drm_encoder *encoder,
+					 struct drm_atomic_state *state)
 {
 	struct drm_device *drm = encoder->dev;
 	struct st7571_device *st7571 = drm_to_st7571(drm);
@@ -565,8 +565,8 @@ static void ssd130x_encoder_atomic_enable(struct drm_encoder *encoder,
 	st7571_send_command_list(st7571, &command, 1);
 }
 
-static void ssd130x_encoder_atomic_disable(struct drm_encoder *encoder,
-					   struct drm_atomic_state *state)
+static void st7571_encoder_atomic_disable(struct drm_encoder *encoder,
+					  struct drm_atomic_state *state)
 {
 	struct drm_device *drm = encoder->dev;
 	struct st7571_device *st7571 = drm_to_st7571(drm);
@@ -581,8 +581,8 @@ static const struct drm_encoder_funcs st7571_encoder_funcs = {
 };
 
 static const struct drm_encoder_helper_funcs st7571_encoder_helper_funcs = {
-	.atomic_enable = ssd130x_encoder_atomic_enable,
-	.atomic_disable = ssd130x_encoder_atomic_disable,
+	.atomic_enable = st7571_encoder_atomic_enable,
+	.atomic_disable = st7571_encoder_atomic_disable,
 };
 
 /*
-- 
2.49.0


