Return-Path: <linux-kernel+bounces-731700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5223DB05866
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 13:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B2D77AF49E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C7D2DCC08;
	Tue, 15 Jul 2025 11:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VsGLRGWi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050842DC320
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 11:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752577500; cv=none; b=JN7H6XYEEBLiXxb6DlsHpH6DL4MnjzRSu0DQZHa4g7FxprIX08tyXbecvEv8w1PYSk31rZyTWNqYuvYpikTzKXAKkPZ2ehZ9iKhumgZKSXXKRmLItoB1TSTbnOjt6xL9UzCsd8xiZlMfx5WHx8hdJYWPcSmAYYSBkt7P97r6J24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752577500; c=relaxed/simple;
	bh=H2q6q23Z7vtRJa/7WbSJfUzZryQ2TNmYQgFqYpU/rU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dv34fU0wVymKlq3LR/V7ignljXpRAvd4Z8/3c6HEY5NzLm+4jWVU2pjG9FzBB927KsJ3mmzcaxaF0V9G8nb4fib6vVq6ZE0eI/y7877JNTKEY0ncVzC3OKHaZjwiMmibd0jsPxDpvgVG3+yQvrieV0WrxkUq+4ckFn0M6l9C6zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VsGLRGWi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752577498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z+XQ0wnLzLRCtqZjvZ0JrZrVBsaHoyUy1S29+DwjIbk=;
	b=VsGLRGWijaI2b6pQ9jeFR1iLLmmZ4n11tZRwFyQ1w2vyJqylhKv8Ypvm2+l6te/qjAJnvI
	vMDDxiBaHqEjjllrvukmvaM+P8kgtI74JzjHDK1DEouo8rMAbXlS8pf4rNh5kKlE1T/FxC
	0hTxwQgzk9HK3ko/eWPOZZVtfxwRG94=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-1ovLa3ILMBefkSf2frhy6Q-1; Tue, 15 Jul 2025 07:04:56 -0400
X-MC-Unique: 1ovLa3ILMBefkSf2frhy6Q-1
X-Mimecast-MFC-AGG-ID: 1ovLa3ILMBefkSf2frhy6Q_1752577495
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-451ac1b43c4so29583365e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 04:04:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752577495; x=1753182295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z+XQ0wnLzLRCtqZjvZ0JrZrVBsaHoyUy1S29+DwjIbk=;
        b=EPYM9+6pHsWp2bf6Culo+Q0VDFotyBOYTlB584IdUdgkwnv9vMUWGWCYZFCzR3rPex
         0Q2B4DpOSIufJVmNq5WA0ZY+yRGjrbdeMxd/I9HjSRNX/DGyMD0Yd4opmxXrKlUgaJUe
         Ae5IMQZMmqq5fC0ZagOWLu0f3ovJEaVudZCMv5chcWXOyLMIG09cXr/8+WqwoYu72WrP
         eTPce9A9Of9xzFQ6PnHdBFlb1N40OhBIOQ6aitUsTj2bcnwSeRlKro6jNKXqCgvCfBuz
         s7RoWIGkkFuNCQFTKpiIQ6z3Nw2ZBhgxCp8ZzGrQvb8EMP1X6Bq4RSy1hTojtBjeNhtZ
         QxEg==
X-Gm-Message-State: AOJu0YzAB3xUqcMNqDp+kiCahTeiDltgyH1X8mYq+HYRPzeKwdz/Xeo8
	nAz+LM+9pI6FPVT1zLmIHRdtB/XLdPwyMlb0i1BvnnZ/FfhO11qFfl2vwAee9EDB4+Sg+sAkTRI
	sygTR/+VX1rOSEGdF6i1uthB1GEzPwYMVvXdCN7knNPIlIuxoKIJOpde5qjrOhCu1cRMs5HnXnA
	c4XyVY41Seog82ZFpWOARFGGsR4+2ZMFKEENBMRSt58HX70IbO
X-Gm-Gg: ASbGncvAkA5cL9gE0cD8Yn5MsAVxBXuqHUhuNiWHpp+lQ9eYPK+cX8tfTZUamuT1gu2
	SauGXGPzTbdbJPLSS4dFc1Lo8QuLoHjBM/sKmTE+6F/gfisZogIL5CfAXkE+df7y6kQBXdtTquy
	lejw1LkW25+vwzvkRJGPnOmPxGbXxztHAndsrq/GBoKDupjW/RXHqZDtlLaXpIJm/GiybfFZJbJ
	7AmHNe37g5Hqh0CeToew7hfGY2ltw+EiFrAijyQxDk5BOdMcg8fDy2J6nCJNURGYmRqEOigrZAc
	gKk8DVjxWRYbDgYD0D70DMLktjuT2KWU
X-Received: by 2002:a05:600c:1911:b0:456:1121:3ad8 with SMTP id 5b1f17b1804b1-45611213e56mr112694305e9.10.1752577494769;
        Tue, 15 Jul 2025 04:04:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEDf1q/9ll+0HqD4jBDdBu3RKQxiaOkxZFjweljA0KeUGAtwMbuwVCGChuZioa+ATzj+6OKw==
X-Received: by 2002:a05:600c:1911:b0:456:1121:3ad8 with SMTP id 5b1f17b1804b1-45611213e56mr112693785e9.10.1752577494260;
        Tue, 15 Jul 2025 04:04:54 -0700 (PDT)
Received: from localhost ([89.128.88.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b600a39281sm7146233f8f.73.2025.07.15.04.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 04:04:53 -0700 (PDT)
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
Subject: [PATCH v3 2/5] drm/sitronix/st7571-i2c: Log probe deferral cause for GPIO get failure
Date: Tue, 15 Jul 2025 13:03:51 +0200
Message-ID: <20250715110411.448343-3-javierm@redhat.com>
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

The driver already uses the dev_err_probe() helper (that only prints error
messages for the -EPROBE_DEFER case) when fails to get any other resource.

Also do the same when it fails to obtain the reset GPIO.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---

Changes in v3:
- Fix reset typo in commit message (Marcus Folkesson).

 drivers/gpu/drm/sitronix/st7571-i2c.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sitronix/st7571-i2c.c b/drivers/gpu/drm/sitronix/st7571-i2c.c
index 634b426e2874..fd9d6c701cc4 100644
--- a/drivers/gpu/drm/sitronix/st7571-i2c.c
+++ b/drivers/gpu/drm/sitronix/st7571-i2c.c
@@ -804,7 +804,9 @@ static int st7571_parse_dt(struct st7571_device *st7571)
 
 	st7571->reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(st7571->reset))
-		return PTR_ERR(st7571->reset);
+		return dev_err_probe(dev, PTR_ERR(st7571->reset),
+				     "Failed to get reset gpio\n");
+
 
 	return 0;
 }
-- 
2.49.0


