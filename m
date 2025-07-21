Return-Path: <linux-kernel+bounces-739084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E1FB0C193
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 12:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58D3B1887F91
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 10:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F5228F937;
	Mon, 21 Jul 2025 10:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ioGnzcqZ"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DDF28FAA8;
	Mon, 21 Jul 2025 10:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753094655; cv=none; b=mvwUnrTY4IIx7iYTESyWQMAzPJ5sfXP8hibwEOXPhpeMNGU8zQPpBuEIzxuOwzVTgrHYq644XU1E0+owm9tI4cttknlbTOx5NGfNg/TiroizjwVtR+Hp+m0nysUgkCWAcmS3QjCmuVhisQIN+/jdoB1++SGVkfkGhCjRw2VEZgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753094655; c=relaxed/simple;
	bh=IBvWsfd1qdqQU3Rg1nmav2yYeSIn047JyVePtD2ctPQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rUVx5ssD8ozF54nlZ7/EaeRXENNonOiNcRnZCuKk2N3BFiXvfxPs8EaVl7Cor7wvZ9VlZE7Nendbu7zVIvxRx8eLJH6B3+yYvVczC1qRyCNdIx4s6fwxdChl/erIBMLFodzMo0nmiCTCqcBwdx1lo5pHE1g9j8CP+tHDOzo/kkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ioGnzcqZ; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-555024588a8so3887064e87.0;
        Mon, 21 Jul 2025 03:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753094651; x=1753699451; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uZgi0IGCTQu+xFbtpDGEBKVDI7Gw2v7i+CZyebbbBrc=;
        b=ioGnzcqZtmZsbAUppHqFG43SBRcDaBUycuR+cw4IPMRsYLV0zA56sYMHBycActFJj+
         xXMkKK1ZarnybnR3p4OzVodzC9ykmOUu69MPAca+btFuOAS4ytAc/Rar2P1K1tpEBIRT
         k7s10gA/hPGZDrIRLSro6rbshXtWyEs4AQXbY+vBIrje/UaTPduROtNjQ3/5Baprmbz2
         p6aaEoox8lvuuN55WKH/YKwB6W366qNetyG9hhEHvY5AO7DprXcSQC/ieeCHDpfp2hFW
         jcfHiHFzLUuJmt910mht41oKjv4fOGQTMZXblVfuTzPlKYDbcsQMKkwWvGmxfNkAJ8I/
         HKEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753094651; x=1753699451;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uZgi0IGCTQu+xFbtpDGEBKVDI7Gw2v7i+CZyebbbBrc=;
        b=AfsezZv0bsYk+DHDUp4c0UWOTiGWAhYPDT93j4mT6eIjm6TzVfzLKH2/qOScEWszNz
         PM3CuxH0/nltR4QTzMM7g8RT+h5f1m10sXrm+al5fBPJ7NjFaOGOlg6VgC5/PIx+crr2
         GUomoYzM6VQgkRtr86KIFmbsTqxqSvN4SGDRPlK5S1Psj2qD8EQgZPSVfIc9/9sF7IbT
         q3HAr8KUOOb6M2Pkn1cisBR6lW7g1M3fbKcJF7vwe2YLvctiUXfZ4TQMlOgJA1nU/+kN
         /dwJ74Zbf7vvtRvS+DL926ptxo27qHgXDLouaJWx8svEf+r73/kXqYZlXJ69ibWSh69M
         L/Nw==
X-Forwarded-Encrypted: i=1; AJvYcCWGt96AzNu4XWGgQZYwRHsV+DgGZ/kSNmk4N72YkM5FF1Wu8PQfD3hzKSb8o4qQ1i/HaiI5tK7tcT5Qp3fy@vger.kernel.org, AJvYcCWaivzqPaMQ7AdF383e+LhCSrWi7Dn8vxSK1Elbm6kpidHB6x2dzuQGHcHUX7LZMueJckHY4Iq6JPl3@vger.kernel.org
X-Gm-Message-State: AOJu0YwpxXtGAmxJhTU1z0n5ClWF0w3wl62dQ2OB22DnbDRWnjSV6ho7
	nYbgDWQTqcFwGNM5ie1kJwxcM/wJlT1qk6ANHBGBdw4cjCfHtYRAqpzJ06d3wwsCCPY=
X-Gm-Gg: ASbGncvq0VH0tpn8Dc3f0bhnWeE+Rvkk3Y7EuMyWja2RFMYIruvrVW3WiYWSeNKYN5F
	Xt0MpBmWITeLmu5PRRdd84DWJfs4sCD9lGQVj7dz69Jnr2DkhNOcqXno4mrhoxDW0MhmhTzZckf
	OAqk5jMFzD7wd+UpsvesKG113kEA0Faykmd/MBro+Ca5+jUGgkNhM7kcTZ4bKwDwE6puT7FRX3S
	nONxnWMdXEgvfe/lew93WHLom/5fptsOUmX2Qg8X9ZUd86D6xL5CXMQhycXX3ve0N9eizJe2mY0
	akdFD0Kp7DA0fwuHb6KnomycZkG03x+WNtGswu/9qfCIFhGmnKfL+GL5O6tH7V+ikPaIf5W6rti
	CQrGY+YLH4eQ4sk5Vu97XLWyOCtgdA0BfxKEJqcUyfwkevSB2RgYvX7eqTj8D8giDD10N5wAyif
	NW6w==
X-Google-Smtp-Source: AGHT+IGuVsyJ1VoNtlX4uZdFa9de1M9socYdCeEuJ0l7LOrUdQ47lJmy6BhpBpxRED+In30jMQumsg==
X-Received: by 2002:ac2:54a5:0:b0:554:f9cc:bea5 with SMTP id 2adb3069b0e04-55a23f56157mr4445936e87.34.1753094651264;
        Mon, 21 Jul 2025 03:44:11 -0700 (PDT)
Received: from [192.168.1.198] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a31db89bbsm1505164e87.237.2025.07.21.03.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 03:44:10 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Mon, 21 Jul 2025 12:43:31 +0200
Subject: [PATCH v2 1/6] drm/st7571-i2c: correct pixel data format
 description
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-st7571-format-v2-1-159f4134098c@gmail.com>
References: <20250721-st7571-format-v2-0-159f4134098c@gmail.com>
In-Reply-To: <20250721-st7571-format-v2-0-159f4134098c@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Javier Martinez Canillas <javierm@redhat.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Marcus Folkesson <marcus.folkesson@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1260;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=IBvWsfd1qdqQU3Rg1nmav2yYeSIn047JyVePtD2ctPQ=;
 b=owEBbQKS/ZANAwAIAYiATm9ZXVIyAcsmYgBofhnZ77JL3v/9CnCts1MBF/beUtSWOM1Zx4r1l
 WDEMf69H3WJAjMEAAEIAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCaH4Z2QAKCRCIgE5vWV1S
 MrlOD/9190vl9+6uV8EbrJXDTugXGNXbo9Brq3oO8as6X3Q4KC7xtF+xgG2OZH6mpLq3BSlHo31
 jUWRusoZ9g8IERx42w8TWzIwxa+ukcZh8s+6bmw8pTG7yka0FhiH0e5TrSx0qADksGtEENVYFff
 9GSBsOAnzQPmMZCkk0UpIUFZ3OL8B8pr59zznppEr6eSMEjm+fdXCvPHDm7AGARnDm5dzIOn7UE
 EL6ZOfndlLePFOzp+jGv1nqXC1MI9f0sI/s46wM2EEbQUQ4N2AG41Oxg1l8u0N9FwfASN1nqOlT
 uMu8fq2YRa8ukI/AAeZKHNwbiau7tXIJqZE2d8uVA9Lm6OwqLL2RafZRyOZTOs2zCSCB3JPKP+B
 idXkuval3ZKCoRvUJxqRYLFm0VVvRA2gB8scZW7JrIKsVlZU44V5S28vL3JHshVrexBlaaYhdoT
 vuGMAeoTu6Pyi2U8AfGviPG46PlvD0puZ5KTL44i4BYKNpyyDRjPuAojSTARcYx4r6FxcsMMRku
 G1I2B5tEuDkhRPon9G017rsMB0UQ83Upgix82n4TM0Esr4G7DNNx8dAzknIrOfeREBRZT39ijf9
 /dNjrhOxeX9qU+j1pdnYIPpiUJ/pWqxhmPH9IVcwadzlBX4MAGeKp8yAebrxQH+tXoIpIMjzujv
 ka3cu8FDVHlWz/A==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

The comment describes the pixel data format as stated in
the st7571 datasheet, which is not necessary the same
as for the connected display.

Instead, describe the expected pixel data format which is used for
R1/R2/XRGB8888.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/gpu/drm/sitronix/st7571-i2c.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/sitronix/st7571-i2c.c b/drivers/gpu/drm/sitronix/st7571-i2c.c
index 453eb7e045e5fb5942720d6020b6279a4b7315d7..dfdd0fa4ff24090c3cbe7ab162285be45464d6a6 100644
--- a/drivers/gpu/drm/sitronix/st7571-i2c.c
+++ b/drivers/gpu/drm/sitronix/st7571-i2c.c
@@ -386,10 +386,10 @@ static int st7571_fb_update_rect_grayscale(struct drm_framebuffer *fb, struct dr
 			 * even if the format is monochrome.
 			 *
 			 * The bit values maps to the following grayscale:
-			 * 0 0 = White
-			 * 0 1 = Light gray
-			 * 1 0 = Dark gray
-			 * 1 1 = Black
+			 * 0 0 = Black
+			 * 0 1 = Dark gray
+			 * 1 0 = Light gray
+			 * 1 1 = White
 			 *
 			 * For monochrome formats, write the same value twice to get
 			 * either a black or white pixel.

-- 
2.49.0


