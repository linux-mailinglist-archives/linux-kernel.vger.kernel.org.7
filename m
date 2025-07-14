Return-Path: <linux-kernel+bounces-729829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E2EB03C1F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 12:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCE2B189CA2B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 10:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3050246773;
	Mon, 14 Jul 2025 10:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MtklcR1+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2392459CD
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 10:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752489884; cv=none; b=XBZFmNXrzugk1DrzWAT6VwmZI4gQEU/lsw1erS7oOGxU99A+Xakm5vHgy8UuAb+Y/cRWNgXehCItS6gptXbaMiK1cdBHs/awzIXpzRfW7VI/yPo7Yf2uT+coLVaeIuijxpAfnsuMSNBl+JsOOiqE8TKOY+PxQnHoFFnAhWVtq20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752489884; c=relaxed/simple;
	bh=rIGyUZ9LVAbBaIPfC/oyomOqbL1G/CfPPKXddygm5jU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aMCxJs2EqXJc7Bp3T2X4hgCZzXOt8KoeuSuwgyDPds7uafNpH9rSM/xb7XWHmGEAd+SG5qZqSs7bqpgk/LSzhCWgrHJfhQ2yesRRuUqmYuKgiRp3MhR59Z9JMM3AKr7tCUBmSp+lAqpmDDpRoD6SWNYcWNO3q33CRwQPCy+K7Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MtklcR1+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752489881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HNUt6/bURNRe9U6oU/7WSlTHdeKZKLnldCNgh0UMvWk=;
	b=MtklcR1+W9pHszbXOJ2Oms2xyP9XjPmtY8NtxH7V7UrnkAJu3YNydK51uJKPQpSszB1Eiq
	74gEBxB3DSPC0/b2+oWeEMZZ78cHA76qvvGkVQQgcqarOa+0SHeIEOjq/Et8CtIbNKj5Zj
	rYTucIFJa+1abW2wkJgJFu2ZKcoSCnY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-IMVqQeYVPB-vaHYMYgYRKA-1; Mon, 14 Jul 2025 06:44:40 -0400
X-MC-Unique: IMVqQeYVPB-vaHYMYgYRKA-1
X-Mimecast-MFC-AGG-ID: IMVqQeYVPB-vaHYMYgYRKA_1752489880
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4f8192e2cso2382226f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 03:44:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752489879; x=1753094679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HNUt6/bURNRe9U6oU/7WSlTHdeKZKLnldCNgh0UMvWk=;
        b=R311YE4wzWZQrDmZFo1JT4W2dz6flFMBcuXb0AFTUIdydJDrFq+0kvU1CV/stJ7sXj
         sHYiE0QDFMZyNwTjuiXt90dDXxSJFTkIjGeQI9c8Rh4ICmhJyK0Zk7hP8FnnUUQWKSwA
         0Cn7aAdfDYI6eyRD+B7h0yQijC2zrsRCr3pdnatV1N10+MQ0Ocl4Vmam/K0cDsOuazyB
         jVF8hbjDJ/kYSEIhXsIIPVezg0rsQypUE+GhyvusjFT1LKDe4AI01vwy2zBOfMnMRGCR
         nH53lIYwHazi31IGKzBAFsES/jvwx0j+XHpSjgwGVaeEBC6Cq8M3qiBDKspZHDjUWdrQ
         XjKw==
X-Gm-Message-State: AOJu0Yz4QpjN5Cv1XYRbmg+w6FedOEKOzQe0OcaCnv2qBx7I05nuJJje
	XaV5klp9Z4ShxsG1ZW52wBxzE+3bPupzLDKfysDvkExhPnt+xUkrk0xWVzCRuF0k+cmOoW2GY1u
	c7D1+MAmKjv9iAMtKcrAsk62/ubOWretoOdsxHejNrY8Wpp4k1w4YYuzc7EMsvj4DLH1+LMn71e
	cUSFfT5RI6xijWorFwNLFElsbHB6odP3M3u17WErsItHD1b13Q
X-Gm-Gg: ASbGncvuzjDnEdSxQHaw9XDJV6h2Q5fEOXdzzvpldJ9m6TM/Fzjpks0ox3KZ1JeucxW
	QBESdnWlsOxoUDczo0YY6S/HnMhkyommvqHq1u35q5/6wiBnVaGak0fgbumzNhtv0psHiKn+ZBP
	8hMb5awmbqSA/yCRynIPFpT5aEWy4H66DFzO1nHv4G7lG7FdBAkfP3uTb/xiB4vUSJ6aP3IzwUy
	MdkvR9m4wkQ+POgm4Km7FKVNBFClaBDkWHUanRA2npXMwKoINIMrswnLCac0hLM7snzC5fD3d8j
	ypyBzdHHS3PE3iVNSVQOyZvatmUcJY2/
X-Received: by 2002:a05:6000:2f81:b0:3a3:7baf:f06a with SMTP id ffacd0b85a97d-3b5f2dfdd45mr9421896f8f.37.1752489878934;
        Mon, 14 Jul 2025 03:44:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2W3lgSoiGCAE5rXtFzBHRvbFoJu2axAL5r6zaGdYjc6OVX8whs77OvmSuJ9iTy/37bnR2pA==
X-Received: by 2002:a05:6000:2f81:b0:3a3:7baf:f06a with SMTP id ffacd0b85a97d-3b5f2dfdd45mr9421846f8f.37.1752489878111;
        Mon, 14 Jul 2025 03:44:38 -0700 (PDT)
Received: from localhost ([89.128.88.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e1f4edsm11880604f8f.83.2025.07.14.03.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 03:44:37 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: ipedrosa@redhat.com,
	Javier Martinez Canillas <javierm@redhat.com>,
	David Airlie <airlied@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Maxime Ripard <mripard@kernel.org>,
	Simona Vetter <simona@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v2 1/5] drm/sitronix/st7571-i2c: Fix encoder callbacks function names
Date: Mon, 14 Jul 2025 12:44:00 +0200
Message-ID: <20250714104421.323753-2-javierm@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250714104421.323753-1-javierm@redhat.com>
References: <20250714104421.323753-1-javierm@redhat.com>
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


