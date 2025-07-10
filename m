Return-Path: <linux-kernel+bounces-725441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F68AFFF33
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 12:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDF927B1626
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C352D8DC4;
	Thu, 10 Jul 2025 10:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bHFOQQT8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D91F2D8397
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 10:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752143152; cv=none; b=ASB8/u6MELm+1D467hwTKtGdslNIgsiRYBNCdaD1hnWaiCP1WpGtBVIYjzVEdSc62HnXjCKOC8DZvfGo+STtRqVg2iNRDGEHSTYOeXKGIrEnzsxuAbS4qR4pq0liNh/9DVcpbZykYwLRxpSPVE+vXG/ENls1uy9YjhIptAt/If8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752143152; c=relaxed/simple;
	bh=YX5iIzBEC8wBhwRMB2EufE02wlzwKShJxxQ7NFiJwds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ccOOU1osmAeAIYth+N10/pwFsaWsnyii3ESu8ED82aFXrrm77HF8/XHQxNXjMjpoy7qPP/Aa6dMLjeXKr71Vqd2EI051apx2lbV1kg9yEgDxAwnl2scbITsXPSn/OGrpXXVqP/0Ai+24mNyywyzCsvc4fROEnfl0MYkKu7SX9cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bHFOQQT8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752143150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1ND1pGEOAughrkErjCqE+57XmE0dcte7108oeuugxKk=;
	b=bHFOQQT8/0PxWGbNUTgBsNUNy+Vel6aa8a+ZFSpheFMdY+K8X+0cDI+t/9xAduzgpajY/Z
	nu3a01hkK64RqicBRPj+ZQcnFjw5o8kAvi+BFVh2b4iX3B2s41kttn1kw1G969FJdb5wVP
	tMwO/ubXM2u6hmzmFjuzliQ6G5PIeV0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-DRLajjPCPaOqvjCb2xIczQ-1; Thu, 10 Jul 2025 06:25:48 -0400
X-MC-Unique: DRLajjPCPaOqvjCb2xIczQ-1
X-Mimecast-MFC-AGG-ID: DRLajjPCPaOqvjCb2xIczQ_1752143148
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a5780e8137so1125741f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 03:25:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752143147; x=1752747947;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1ND1pGEOAughrkErjCqE+57XmE0dcte7108oeuugxKk=;
        b=XBn8JAzoSvdusIzW66qv4eEuUOAbHTBurL7nfEX4HUG6rZvk3Z/xt2UvYQSFAgkbm4
         pBkC7mTzokB6R4TpqOaIpReaI2LWFVt+TyvvKRsF/5O5+TUvoMQjZ2lmcXL7c3UIhv6k
         mmgC2ZRXJse8C0d2YSydvhVsvFny6+ihXc+U7/tDnw5WFrq+jNz6uCH+2+Q5YS+x+91a
         Gk1Cem2gpxuSFL3RbW60YZJPpAAUTvNGAva9sX+X6qH7IGwrFlprk5H9Vel6bR+k4ybx
         bU72HA3sXVsCl/CpaXXsIg3aJqwtSj/tT7nnkCJZOWVnYJtLN1v5dC9hAfuF/rFnoNlX
         gorA==
X-Gm-Message-State: AOJu0Yz7l71+47VolErpFMvkNXUrqSQYhgxYqvSmKyUESez0HBlswr0t
	VduMq9YREFrWJiERdGvrfRhmuj9i0EPw4EYsN3DxsCgJttYhZq3aGwo1U+ja7VVVxjPd6kJUrp9
	05gic0G1oAJ+ZRiErRSW+oSmd96iZIXwjLnYdp5f0Pp6Ms9D4AoXr4ZA7N2LEOEqi0+MmY8WSaN
	ZOb3T883Bt78rdFwjQNE5orPEs8qmoSuVyVanVg9mIKy75U/ec
X-Gm-Gg: ASbGnctCYfpK/OBS1y/z8rC17qwc/tvc8UgBqbROx4tlxJujaOdjE1qiZGU15zUwRrI
	wnR6VF5UUAbCQYFBFqEG3DMKbp2LAL46MHmS1Brh7tnGa9X4T6i4QRroJcsm+PAGnZW/tVp5een
	iT+hYXnZ9ha318m7ueJVeTzC2BQt6/d+V3UuLDmhICtOyrWhmQDyxQARp3G0j9E38cyi7ezZS6v
	SbzU4kajSRZk+Av0FLqwbEd808Xxx6vx4yjX7uJ7BR8pxawQZpAyg6JQ1eynMYJuYuWPf6YBchE
	UnCALiJFB26Fh6diboOun+Ku3zpVi32z9UyT3QKjHlzTtqM=
X-Received: by 2002:a05:6000:230a:b0:3b5:e78f:f4b3 with SMTP id ffacd0b85a97d-3b5e7f142e5mr2661636f8f.11.1752143146984;
        Thu, 10 Jul 2025 03:25:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGw0Fp3hGMQ2ioeBb7L40qD3wSKjLbm3xoYLDE8V5zfgO85zTk2YhsvuUsIz4ABFDvjQSMY4g==
X-Received: by 2002:a05:6000:230a:b0:3b5:e78f:f4b3 with SMTP id ffacd0b85a97d-3b5e7f142e5mr2661593f8f.11.1752143146504;
        Thu, 10 Jul 2025 03:25:46 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e26daasm1512820f8f.91.2025.07.10.03.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 03:25:45 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: ipedrosa@redhat.com,
	Javier Martinez Canillas <javierm@redhat.com>,
	Conor Dooley <conor+dt@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Maxime Ripard <mripard@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Simona Vetter <simona@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 0/3] drm/sitronix/st7571-i2c: Add support for the ST7567 Controller
Date: Thu, 10 Jul 2025 12:24:32 +0200
Message-ID: <20250710102453.101078-1-javierm@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch-series adds support for the Sitronix ST7567 Controller, which is is a
monochrome Dot Matrix LCD Controller that has SPI, I2C and parallel interfaces.

The st7571-i2c driver only has support for I2C so displays using other transport
interfaces are currently not supported.

The DRM_FORMAT_R1 pixel format and data commands are the same than what is used
by the ST7571 controller, so only is needed a different callback that implements
the expected initialization sequence for the ST7567 chip.

Patch #1 adds a Device Tree binding schema for the ST7567 Controller.

Patch #2 makes the "reset-gpios" property in the driver to be optional since that
isn't needed for the ST7567.

Patch #3 finally extends the st7571-i2c driver to also support the ST7567 device.


Javier Martinez Canillas (3):
  dt-bindings: display: Add Sitronix ST7567 LCD Controller
  drm/sitronix/st7571-i2c: Make the reset GPIO to be optional
  drm/sitronix/st7571-i2c: Add support for the ST7567 Controller

 .../bindings/display/sitronix,st7567.yaml     | 63 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 drivers/gpu/drm/sitronix/st7571-i2c.c         | 55 +++++++++++++++-
 3 files changed, 117 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/sitronix,st7567.yaml

-- 
2.49.0

base-commit: 93eacfcdfbb590d9ed6889d381d5a586dd1ac860
branch: drm-st7567


