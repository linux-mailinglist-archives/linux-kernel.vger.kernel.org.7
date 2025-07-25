Return-Path: <linux-kernel+bounces-745681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4219DB11D06
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 13:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EFD41C83D2E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 11:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74022D6604;
	Fri, 25 Jul 2025 11:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Uve6UZA/"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57E423815D
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 11:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753441296; cv=none; b=D24Uwl67q33G5eksU6bsmVsJoGKHMJ1IBuRlFSaFsLUQveQnITHzA7UcyX1LpaMh3EHUHp5VwgWo7D7fXRMVrLZatFGg+3vzH75pl8MT7y5ZIY3TKsSHXDuuSEnOYPHSrfK2HAV3x69PLiL1eaAzh9ut+sddWMrKl4rJbEt74p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753441296; c=relaxed/simple;
	bh=0yfVLDdU0XkdfYkF/JwPWmIHkTBXq9aKwos97aDQtZc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rwytI8sVY0q8BTZE4f2BaMQ2cwvpacp/chzBHbb8psMUxfn7FUInY1EVxLKzNIlHSFxIRNoXHfqeou3eFgSB+aUeZqYOr3NeRUhu5DYdVjtwEP5pwWhhMD/+ld6FoPYm2T1xjPOcDwUj1g2W9UTqssrkq9fAKC7iJb7k4jxBSSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Uve6UZA/; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-32ac42bb4e4so20888371fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 04:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753441293; x=1754046093; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=maOU4GuJF9epvvoL4BiDwdQ8hzIgQDIuqpbrf2fuD7E=;
        b=Uve6UZA/LAFW/ti4jJbRCuhUjxhgjEjzg80+VpsT0f3poX2yhchYteZj4t6BusWJRV
         PiCfaC/l+Gvon2N48XsKe1jrQhbs1nXs1VMev/s3kAp9fYLr6GW2EzB6TuiM2tOMsdU/
         sh4moalyzwBYAXhzYHSZkHIqIyvSjkbpn9i94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753441293; x=1754046093;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=maOU4GuJF9epvvoL4BiDwdQ8hzIgQDIuqpbrf2fuD7E=;
        b=iQ2kFPOj7eB6GyE6Vmci7qcIcTc+f1cRytvgsALG6vLJWNBkMZIhu/4Su4lKIKdWRp
         wG+l0XyBlSJQhm/NVQJYiF1nYfb6BPwQt/qndOMtXBVkb/qNYxKC1Rjzbv7THHcfZ7MI
         JH2IklK1i8Xo5aPFFBUevs2pGKRxZQ6KrxUZ6UnoPgxSmwTaA8n2mPLBrHex+dLvgOoA
         Agk022sjYE3kE6eHSauaktJ4yiHKELvDANug1HGo8vWFiEORKceVdbInl35vzu3P7VNQ
         ZMEIV07UNeUkJCa37PjT0b00/sFUYjql7e5s/U3fleBADhUTarLV2PocBr6upRUvvzKt
         4Mrg==
X-Forwarded-Encrypted: i=1; AJvYcCXChQwdKUV+cc8boTJDbf3EsJpt7dh0L5RRJn3lJyAsRJthFRxg0/KU2fD1Uk8B+EZpgpYHq2PolcGM1Vo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv3k8NhrSz6evGbxWkoxyQVjDy2coz5o5UXFAK1mhY9+ysnnfB
	wek/pUnam1tvasNgqHqXw+GopCiRPzHMeT1E5pUEwloVOhG4vYcBUmG2FSgyUBuZdw==
X-Gm-Gg: ASbGncvNtRvCwhWEojXjREj1GXqYLX67xOdxHj5q/fYCZE+0mUYUN9DFomTF7cFTwmt
	WV70dcfm2QFeQe1Euylxvk+IhwQb9sHM+NkEK6udQiyW9H9orPeDStlyaH4O6qYyIzusOHF225h
	OKNt7ZQ18PDw6ToEBJxajA4tQLMNDj8Dv3BlkEc6CecbBIohl3yY0tDcwhjo0OnSVHr8J0To//r
	UwVpWM6nOgLZ02kZ2eTva7S8021Ufkx4Yj6Ct7yYGvViuACPlZMa3CI0RXgQZyl9bUf/msoZ3vx
	hAfVOE/HcPPJ1hAPOLWpnT+Mdr/EwGG7JmYnc7qqXMH8zvZ3NtE/2YTnBB+H08MWJH9OiLUG/OW
	Lho7x2YVdZUT53lmyHlWZlUn9YAz+atopCz1XX0a75wBH9KAvjhGGVDsm+74n26jJUgqLiaY/zt
	XCGo+xc1SSgH4W
X-Google-Smtp-Source: AGHT+IGpk7pe7k1+G8UlqPiH4vZl4lVjiF++dwtYeQnbapf3I11U45+wBvNivszwo1QeIPCaE3dOuw==
X-Received: by 2002:a05:651c:408f:b0:32a:6a85:f294 with SMTP id 38308e7fff4ca-331ee760b32mr2546641fa.35.1753441292692;
        Fri, 25 Jul 2025 04:01:32 -0700 (PDT)
Received: from ribalda.c.googlers.com (166.141.88.34.bc.googleusercontent.com. [34.88.141.166])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-331e8940156sm4187141fa.97.2025.07.25.04.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 04:01:32 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH 0/2] media: uvcvideo: Use dev->intf for printk
Date: Fri, 25 Jul 2025 11:01:28 +0000
Message-Id: <20250725-uvc-nousbdev-v1-0-28f5a1fdf544@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAhkg2gC/x3MQQqAIBBA0avIrBNM0aSrRIvSqWajoSSBePek5
 Vv8XyFjIswwswoJC2WKoWMcGLhrCydy8t0ghdRikpo/xfEQn7x7LByVVUoY460W0JM74UHvv1v
 W1j5metVZXgAAAA==
X-Change-ID: 20250725-uvc-nousbdev-e3833066d850
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hansg@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.14.2

We have been using the usb device for printk in the driver, this makes
it difficult to distinguish the logging from this driver from other
interface drivers associated to the same usb device.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Ricardo Ribalda (2):
      media: uvcvideo: Use intf instead of udev for printks
      media: uvcvideo: Do not re-reference dev->udev

 drivers/media/usb/uvc/uvc_ctrl.c   | 10 +++++-----
 drivers/media/usb/uvc/uvc_driver.c | 22 +++++++++++-----------
 drivers/media/usb/uvc/uvc_entity.c |  4 ++--
 drivers/media/usb/uvc/uvc_status.c |  4 ++--
 drivers/media/usb/uvc/uvc_video.c  |  6 +++---
 drivers/media/usb/uvc/uvcvideo.h   |  4 ++--
 6 files changed, 25 insertions(+), 25 deletions(-)
---
base-commit: d968e50b5c26642754492dea23cbd3592bde62d8
change-id: 20250725-uvc-nousbdev-e3833066d850

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


