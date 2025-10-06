Return-Path: <linux-kernel+bounces-843292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A61FBBED9D
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 19:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED787189AB4E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 17:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15FCA2D948D;
	Mon,  6 Oct 2025 17:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WwWkXxpj"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23CB2D062E
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 17:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759772956; cv=none; b=UqBQMHs+mhbX8eQiaOaPNWPOJf8dpBNJrIHFL/wuevLk2f7/Rav3Btr0EpxMOAWn6S0H2mlvOHiK7vNxv12/WeEWOpp8SskirMm74nAkM4XjJ7ESYamKY+U+Gav1ohveXnuQGnJnK4OdBRg3RrGdNfrkHtFLcTieaw1nkVPWC/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759772956; c=relaxed/simple;
	bh=3ngI3i1BG0C9azbqBN/4q7nJ2yCSJxmqD7ABvsTPKbo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ik2CBbyZ38u411SsPlSTWfhtIBMSHbN4ibEJtEQfW2n15NEIujDGr8Jl5L1EDKpdCNzgOkRB6MLUZ+5OWTHQt3z7loqkITGNQE1NBccVTsa9B8HTHEkpDxYKor8L404t4NfvdSqESG/bWNnvgM/XYEtzbfd/mSSMZTW45B2jgt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WwWkXxpj; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3fa528f127fso3931637f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 10:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759772953; x=1760377753; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m97kyP3HTS70kAnw3EPRct0ZUapkHpzYxU+r81cO+AM=;
        b=WwWkXxpjYos2/qMK2ZLnapYpV2ifijI5TPpo1Xy+hmWOJ+dAfVzs8SNegpoye19zuJ
         YV4LBT5TweCPKQbXheOHqv8ygzTVUqywdrSum8YtZCEvpgSsLzkL7OLoOiBhqTGDErIn
         ZGigfVhE4mm89mCl8cjNdm9j6VDEkmyzYu0pTcUltnnlGr54z3VGPsis0sgnHMEhnWml
         22rHF/ppLvNbNFqh5Z9TBOQ5dPEU6mAjN7O+84QQ9/av+2sRYNQIQtasZwD5ZpQza2KI
         fY+gYTgkT/i/qG957LilELrODFGtjG5RuBcw+5RDk5PEkBLlPqDPt8LZpkCzM/o5Mq4M
         nTmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759772953; x=1760377753;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m97kyP3HTS70kAnw3EPRct0ZUapkHpzYxU+r81cO+AM=;
        b=jeFKUOwRZshIeSA8arrqmlAV1dlIsDIiJGPbzSqOnzULsDahYgUXpDHx03B16jc2xe
         3Twh5i/D7ZvZjS/dT2en4hN9r6Ieo/Qyrz8JPklVdCOzZR7LB/obl37NXPmb7S13lbOT
         VaTy6uLut/fOax33Y3v3N0ofYcQvEbsK1KW+y7cXsSovpwCbeJVM2E7hd9K3t87Lylq4
         ZBpAu0hC94ErjtgbkTZaNQXsq9AoIv9ACgQQHegxn4l3BdBQk3MtL1sGOicx0uKuN3bP
         /vWy9csZIr9WLrx7KI6+w41VtTqH4b4jp8p2KqWDT7R3IMQiWYecA4xTttuvDuMKweHl
         VtYg==
X-Gm-Message-State: AOJu0YzcXPN+O+ZiW2f4HteMGt0bzkfd0GcqhRTczM2dX6NQAMSu9m1A
	1uRyMnZqcuJfpwZeZ8bBCllja4c7QrC9JlbQncXijGdxO3hMjyg4z0/V
X-Gm-Gg: ASbGncsF5fuiwqAD2j9XSvuZEiSNY9qpHTcJIZ6QaikPB+7H5dMTIQnzaEnEEoid46O
	2ZafmCpdpmsLkc7DqNYn9m5PXq8JZ+ogrp4Ac2Xymd8KqADQFUv8b8u+m8PFpTFwRsQsyKHjBkk
	PdHMtgaR4x/l2ExgvjDhA/D2fJ/D2GqpPm2G/4haMi2Hke2zC+aq2HSOR0DijOLcB7G4CKxYS/Z
	P2q8kaiilTHDfeu+N9+L/osbMdFPrCrQw6OqqqO83/0awRPceofuPzVY62R9lGd0GqKfyJq/G9X
	RisrzmYk/tamlH0fQdtxriod/j22AfXalyGBFm+js/rVALA3HdAHi5urZmoCYSTVRh6fSoXn/Ac
	k5ZdI7H/R77BYDqCK1PNyRwiZxRUeRlE128C9shEEAXu8T5CrlM8cyWLfRdDeLIyoLo6JqrRPuk
	jmuWKhEwDeBkBo
X-Google-Smtp-Source: AGHT+IE2Pzmgs3VUZH/0TbCLMEfb48/r3e2i7E/BkZcZEo5ZwNdHsN2nAkcr5VfRqIzxaVDfKWYPyg==
X-Received: by 2002:adf:e58d:0:b0:425:82b4:a099 with SMTP id ffacd0b85a97d-42582b4a0bcmr165796f8f.0.1759772952950;
        Mon, 06 Oct 2025 10:49:12 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([5.225.139.156])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e723431f5sm165583805e9.2.2025.10.06.10.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 10:49:12 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Mon, 06 Oct 2025 19:48:55 +0200
Subject: [PATCH v3 3/3] MAINTAINERS: Add entry for Sitronix ST7920 driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251006-st7920-v3-3-4f89d656fa03@gmail.com>
References: <20251006-st7920-v3-0-4f89d656fa03@gmail.com>
In-Reply-To: <20251006-st7920-v3-0-4f89d656fa03@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Iker Pedrosa <ikerpedrosam@gmail.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org
X-Mailer: b4 0.14.2

Add Iker as ST7920 driver maintainer.

Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5ddf37f0acc960039422ef988cadfa7176972fc5..79b8a277e38b55ebcff05450d6c565c0d87c6b51 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7861,6 +7861,13 @@ T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
 F:	Documentation/devicetree/bindings/display/sitronix,st7735r.yaml
 F:	drivers/gpu/drm/sitronix/st7735r.c
 
+DRM DRIVER FOR SITRONIX ST7920 LCD DISPLAYS
+M:	Iker Pedrosa <ikerpedrosam@gmail.com>
+S:	Maintained
+T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
+F:	Documentation/devicetree/bindings/display/sitronix,st7920.yaml
+F:	drivers/gpu/drm/sitronix/st7920.c
+
 DRM DRIVER FOR SOLOMON SSD130X OLED DISPLAYS
 M:	Javier Martinez Canillas <javierm@redhat.com>
 S:	Maintained

-- 
2.51.0


