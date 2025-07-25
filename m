Return-Path: <linux-kernel+bounces-745821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3382CB11F32
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 15:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BCB91674CF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 13:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6AEE2ED17B;
	Fri, 25 Jul 2025 13:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QamXTq2R"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AE423F405
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 13:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753449173; cv=none; b=Yn/jOwihUqq32y1hAktCNGUERYVxCobllK8mdkbv2VgLqbSx+0/JKZFi8nnRoOaa6UT2iTdJb24NQE2nBsMdQ/UvnQFhaJtfQn421PknF6RT26PITKv9p/9HDeMFiZD5+fM7y7iQk4fCQ0aEkQj0K7PBnKJXfvdqseEt4oR6osk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753449173; c=relaxed/simple;
	bh=l5Ux4VHCzcv5mMVjRNR5wqteinXsHV9OnucVkhrZotY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ib3Vb2/8FvdeEb8WhT7gnJmouYADpc1xVRKN/DIoC674g/5/ZpDueyrJyJdf9qXoO4xfUFN1oo1HJSS6/AC8IzFQQzz13bhLKTV/f76nBTV8QhCQGY5E8SOe0zfrLcrSe4+wzeKbdsvEsMj1ALPrVJ0HWpAyyPRldaMunBb6Ous=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QamXTq2R; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-553e5df44f8so1969319e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 06:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753449169; x=1754053969; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=04Dq+ZPnInyqy4JPf902awXBaUBsHRlkPaa3NiI7vlg=;
        b=QamXTq2RghZNshp4HZWVBHgHJlhixYhl8R1C6UMaeCJiVBEaPJy0RGtR0rCg1t2fD6
         SXUCHsMz6R6/o6gg3MbIFZQSdwBZZZt7QKAUkkZbaMgg17+K5E5p+3Q6StQEuG3Nub1Y
         VTQoEHHlIlo+1QhvoCPBpKMpsWHGlDmuKYRGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753449169; x=1754053969;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=04Dq+ZPnInyqy4JPf902awXBaUBsHRlkPaa3NiI7vlg=;
        b=TRd26HZlIOEov/6NpBHEoSmBsLbuJj36xXtOlZDp7xsQEcS6Fm4RQd3O+qMvqXZe/J
         TXyTDIOpseQiwOBPghEMiQws0EsTD1ax0MCGx8VByJlsUCnusUSHfnDpcEW/U5aRtyh4
         eJ1ugdyFOEsZ1ibPcvfY41VyAQVP2zD6Kv/waT3ZLn4kvMZVf/UDK7cB11Hy+8i+7Irx
         Tv2+24C6Y79HzI1cHLlPw12PW6FjbGSZCrLotOdA4jchjE1y8YiNxM3K7Px6YMzj05Qt
         jsRYmHWLYkhxjY9/1gS2oKluhznvwVD4KlhTc49bVF6imNc4vT0jtBtZ5Z+I+zfgPzxR
         1u1A==
X-Forwarded-Encrypted: i=1; AJvYcCUtc+faJrHp3t3PrbTg9OxHTh6nXEkijdFtf1llZgVzJWB1bNEU4uT/N6oEZIbZBUlrFBEiMrzI7j5IV3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkXJQCfnfvJBRS5sNfeOFVM1z4NrI8O3UgExv0AfHRQw7dtja0
	ccazz7RaDXQdS1UrU6lMZoBqwXmaoK/n/jIPqfADf4X2eLS9mcdKcpiqlxLxRY+03Q==
X-Gm-Gg: ASbGncuN/At3mh+S2oaOevB9LTohDefpGa8JRxKANxJLuL6wIlZYJ/7wWRxhQpssaPo
	hkpg9kTa4PPm///r0m3tyN9aklEHWB0tfWgk0o46qJf59TZyvYNo8O5e5YEt9S1ekiIUmcLQnDE
	PvCTBKsWggYUR7O5ZnMq8go6avdgf89mqZaN76BqXk1kSHC6JHkncrsJdhzZFWQBNLYylLkQjQa
	FdbBEcv9xTpB4RILNFzWRgyOLCeXIgWIdwH9Yy0VYDewplI1C3BMguHcZtCdtNw39/RerKH2hmg
	8ubD4TZYUY4RIaQ/nBxmc6HAAlqIu1SYIhr7NDBQvQzR6h/VzrhZIKzXkvW8/amhul0sBHL4UC/
	0V3FZ4rKcUQUyUagTra8rrrtLEnw3fnxYRzeHkBoKmuabqg7HBlUreVsG29fS/dj7CYcbnvKHUW
	q67Q==
X-Google-Smtp-Source: AGHT+IHUDGVJ7d6eglLzivNxrjLU4k/zv2yf1PEgQOaTinVWCWm/wrdVTJjkmjh0Y2IHRILAWJcHhw==
X-Received: by 2002:a05:6512:ea4:b0:54a:cc04:ea24 with SMTP id 2adb3069b0e04-55b5f4a8d79mr573231e87.46.1753449169533;
        Fri, 25 Jul 2025 06:12:49 -0700 (PDT)
Received: from ribalda.c.googlers.com (166.141.88.34.bc.googleusercontent.com. [34.88.141.166])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b53c712d3sm934605e87.118.2025.07.25.06.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 06:12:49 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v2 0/2] media: uvcvideo: Drop one lock
Date: Fri, 25 Jul 2025 13:12:47 +0000
Message-Id: <20250725-uvc-onelocksless-v2-0-953477834929@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM+Cg2gC/2WNQQ6CMBBFr0JmbQ2DUgor72FYQB1gIlDTkUZDu
 LuVxJXL95L//gpCnkmgSlbwFFjYzRGyQwJ2aOaeFN8iQ5ZmeVqgVkuwys00OnuXkURUq7XODaX
 YmRLi7OGp49eevNaRB5an8+/9IeDX/mLFfyygQlVig605ndHo5mIH7yZepqPzPdTbtn0A4VIPU
 bMAAAA=
X-Change-ID: 20250716-uvc-onelocksless-b66658e01f89
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hansg@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.14.2

This is a follow-up patch for
https://git.linuxtv.org/media.git/commit/drivers/media/usb/uvc?id=c93d73c9c2cfa7658f7100d201a47c4856746222

media: uvcvideo: Use vb2 ioctl and fop helpers

Use this opportunity to refactor some more code.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Changes in v2:
- CodeStyle
- Link to v1: https://lore.kernel.org/r/20250717-uvc-onelocksless-v1-1-91a1b834186a@chromium.org

---
Ricardo Ribalda (2):
      media: uvcvideo: Drop stream->mutex
      media: uvcvideo: Move video_device under video_queue

 drivers/media/usb/uvc/uvc_driver.c   | 20 +++++++----------
 drivers/media/usb/uvc/uvc_metadata.c | 13 ++++-------
 drivers/media/usb/uvc/uvc_v4l2.c     | 43 ++++++++----------------------------
 drivers/media/usb/uvc/uvc_video.c    |  2 +-
 drivers/media/usb/uvc/uvcvideo.h     | 10 +--------
 5 files changed, 23 insertions(+), 65 deletions(-)
---
base-commit: d968e50b5c26642754492dea23cbd3592bde62d8
change-id: 20250716-uvc-onelocksless-b66658e01f89

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


