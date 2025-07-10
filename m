Return-Path: <linux-kernel+bounces-725443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE1EAFFF34
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 12:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61C1B5A4FAF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5618F2E3371;
	Thu, 10 Jul 2025 10:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Govq5dlr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C6A2E0917
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 10:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752143156; cv=none; b=qN9T412HpmX9h6gfQpkELvqeMEPcN/I+6qRJbGD1c8u/mg6khm39ra8SSY6NcN6rRHTsKpcWS5sipkT9vtMpBQp7ZZ+3V+kg/XI6GW1MtFwHuUoeS63pJWnf2lI7tTaL22Yp7wuoYoe0KZScRYCpR0fHMDrlUlWJXVNa1jwHlFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752143156; c=relaxed/simple;
	bh=TkVPWhJbQhPK9Aj1BbeG/nddu9GbZww+lnZ9m+BLeJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CfxmHGtytLf/VXL3+ei2mm/ysOWKSJ1d+7c5/6Db1HKsK9WM0SaqClhEVgtYJ8pN/vXreGj2JZmId/WrC1ZF0cIbLVKrUMaIbTCXt5+S5iKvh9AVjMMxT4IGjpIowQfYjxEE8/2U9OCHWy2CAuS4tJYG4adRgULZZf2cuTRPE8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Govq5dlr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752143154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3W2IgTdbFFaPJFOP6LjIBm0mn0cPrkAqV4qDvg19HRw=;
	b=Govq5dlrjzoPBlBHubs8uLq1iMMoz3t3/Cvx+ADDSlTZUPaKiYNtTbGjQacX+oRwd9UFtK
	Uj+19jAIrFjGv2Yx9X95AICaTA6/sv4ygoVy0HasxCMFajij8D+PQS5dIz2LeqMw67G9Qe
	GHbZMkAyi7HANEjZ12ChQH4WkHw1Nzs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-7feW1b4RO1Wafxvf2s-V3Q-1; Thu, 10 Jul 2025 06:25:53 -0400
X-MC-Unique: 7feW1b4RO1Wafxvf2s-V3Q-1
X-Mimecast-MFC-AGG-ID: 7feW1b4RO1Wafxvf2s-V3Q_1752143152
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-453a5d50b81so6168375e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 03:25:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752143151; x=1752747951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3W2IgTdbFFaPJFOP6LjIBm0mn0cPrkAqV4qDvg19HRw=;
        b=WrrO0qUwdA8IY9pAObqPRdX0e6NjIbApRVOmdcvx9pPjypxLsnUPs5XcetuQ1OzKAn
         5q+o/NZTr+6ArCSKcGYA0xjFhyGjAAxb8wh+dATmSxAjrUunxNz7jKgUKpP45n+mqUbR
         rCm/cKC9S7kJBHz1DNOybfqtTxGL/PrDXIk6y6vA/VkJYRF+8mscAYU/3u0M+2MLdIkq
         YK/2TjeT7mhpSoaQVZ6yIgmFRPVLLbAHOYdn0PIRK3qCgcAtAXh1rE/oqtVoPKMzWioZ
         lwkCXGqcglFtiHGJW0ZXJD2FvTOoBHzy2O2JtqvEG34bQy8RAGb7OdCBW1chkMogMaqz
         l1ZA==
X-Gm-Message-State: AOJu0Yx31jogdxlovif51jDDWgFQx462yzvf7SayZXbjexnUIjdgMvPn
	dR4mu1G8OVHhV0SHux1TalPw0ZUuycOYHjrGyDCKI14ZbZnj2vlvWmTpL/fVTHV/iqMM5GN6p6N
	GogBOOqGYyRiv8FKQV4JJ2CZaEHuHTpBDJA9T5ocj91/AmAQuU/ZSgFkFLZwGhg8hhEjBIpF/R7
	kMKU44uzRruk5NWSdrvwGeCzN7DXqyAcJPbjCQq/8SqUbRqCtl
X-Gm-Gg: ASbGncsm+65L5ENfAuDQlQoVl1gVjWXm442pRARAxbo4uMoU2Y3w8HvbP4gCyvNaR7b
	Q1yOfol/YwYYIYXqXua/95ziR0BnQIjrWtoaEFxd2DYFnmOy0w99Bx0E/8shIhJiUAHDW6SuVgR
	GPx8wloUDklvyPvOJbO/v12Qx674129CTo8uql7fhML98BEtduyT/DeuAegdI7N3s+HDmjZC19o
	VRNJfrtLHDz+uGQR7HZrslAP7iwrtgxU4xwvWsHTqUjMhdnMbmaDFsC/RIaSIN3f9UEXdWZSDto
	fAAPUOdmsnlHPaebKwfo5dk1sA6O4GqABXI3/6Sxz7FfEXw=
X-Received: by 2002:a5d:6f12:0:b0:3a5:541c:b40f with SMTP id ffacd0b85a97d-3b5e866b02bmr2197003f8f.9.1752143151246;
        Thu, 10 Jul 2025 03:25:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYyuh3RbSjbXJR2vaOyme03URqc7hkBzM8G+2mSRMCozNekrVnXy9u3oe2JBdtk2AzWjYxgg==
X-Received: by 2002:a5d:6f12:0:b0:3a5:541c:b40f with SMTP id ffacd0b85a97d-3b5e866b02bmr2196963f8f.9.1752143150719;
        Thu, 10 Jul 2025 03:25:50 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d5032fc0sm52460025e9.2.2025.07.10.03.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 03:25:50 -0700 (PDT)
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
Subject: [PATCH 2/3] drm/sitronix/st7571-i2c: Make the reset GPIO to be optional
Date: Thu, 10 Jul 2025 12:24:34 +0200
Message-ID: <20250710102453.101078-3-javierm@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250710102453.101078-1-javierm@redhat.com>
References: <20250710102453.101078-1-javierm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some Sitronix LCD controllers (such as the ST7567) don't have a reset pin,
so lets relax this in the driver and make the reset GPIO to be optional.

The devm_gpiod_get_optional() helper is similar to devm_gpiod_get(), but
returns NULL when there isn't a reset-gpios property defined in a DT node.

The DT binding schema for "sitronix,st7571" that require a reset GPIO will
enforce the "reset-gpios" to be present, due being a required DT property.
But in the driver itself the property can be made optional if not defined.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/sitronix/st7571-i2c.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sitronix/st7571-i2c.c b/drivers/gpu/drm/sitronix/st7571-i2c.c
index eec846892962..73e8db25f895 100644
--- a/drivers/gpu/drm/sitronix/st7571-i2c.c
+++ b/drivers/gpu/drm/sitronix/st7571-i2c.c
@@ -802,15 +802,19 @@ static int st7571_parse_dt(struct st7571_device *st7571)
 	st7571->nlines = dt.vactive.typ;
 	st7571->ncols = dt.hactive.typ;
 
-	st7571->reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
+	st7571->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(st7571->reset))
-		return PTR_ERR(st7571->reset);
+		return dev_err_probe(dev, PTR_ERR(st7571->reset),
+				     "Failed to get reset gpio\n");
 
 	return 0;
 }
 
 static void st7571_reset(struct st7571_device *st7571)
 {
+	if (!st7571->reset)
+		return;
+
 	gpiod_set_value_cansleep(st7571->reset, 1);
 	fsleep(20);
 	gpiod_set_value_cansleep(st7571->reset, 0);
-- 
2.49.0


