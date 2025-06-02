Return-Path: <linux-kernel+bounces-670787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D753ACB946
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jun 2025 18:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BC6C174A8D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jun 2025 16:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA1F224AF1;
	Mon,  2 Jun 2025 16:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gLLwfMYs"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F51224893
	for <linux-kernel@vger.kernel.org>; Mon,  2 Jun 2025 16:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748880411; cv=none; b=BsZUygLmgmTM3MRhyHzAGTfTzIo7jOKsN5+VEqjMeBgtm3Hfo/5j4va38EmL8IwPn7i2jFc0EpuEeDqbnnbSG82Gl4jgCK932FGLnoztRIE/RgoAeP06n/hHPEn+kYUfa48ZfK2E718Vbchim6S8rZGpuYvVZLQBB8h2g8nQX1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748880411; c=relaxed/simple;
	bh=wiLDiYMiYAMiGDYCyEnkZuvHBZXEChpbltfGGvNtWR4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jbBYwdSkhrNiaswFCTcY+p4UEhWWpXMNEWUxCvqEa8Tkrhz3q62vULy2RKumyEXsVqGrKWz6x5VxKkN8SAMXKJydqOPsbXDIaNvL9bh2nXOlWCWi+WfW3kCWekeT64AZL78QacRSwyDzCJdATMsiRghL0zuVGUMx+1V1ziApL38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gLLwfMYs; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5532f6d184eso5808951e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jun 2025 09:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1748880408; x=1749485208; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8tcj9iUnXGZBEOhCBrq076LDMLzc8aYpRUsnzGWmeR8=;
        b=gLLwfMYszhHIBkNJYiCQpWlnNRRDia5WA5omFuce1ATbNmgskJa2RvHrBfYWuBHZxH
         0kmE/6LLtGtQsud7dLar/kAnoQ3ZqFRVQCefnj4n2nZXK0LPCsLivqZxVlqYCRYiVPG/
         iAnTNvp+GbKT42jTLHsrdSOHb0bEHKXWPW0CY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748880408; x=1749485208;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8tcj9iUnXGZBEOhCBrq076LDMLzc8aYpRUsnzGWmeR8=;
        b=r6VE/14gGvJp7atYcWunvv9hLuUa8iwW81F8RGupsniZlBOs47gqn+Zry8cMR8TMuA
         BPECYIGIWsP4dog4RwKw39AEF8IACVOo5y1zo2LyOyQOoBvHmV/jVmhQk2EYAFhvk18C
         zek7poTlCAa8P3og/uvh+MckvVl2sIGYb/aKmKXOZ2qZVFqh5LoNEfynGJSdkvS3biFN
         peUo/u8lYOmbMWoun0arifiJfxYWtazKRt6u/FhvNwt7gH8HiUBjN6m7OC+yCn0ri/ED
         UgCB1TV9I/FxCM3/V5E4U2djMG1R0HDbBZKy3ztZaWlMF+kF5zIA3JHv0aPb/nvubd2v
         ynxA==
X-Forwarded-Encrypted: i=1; AJvYcCUKk/Jz5QgrfKrRbKhT1prqWK4lP3A+6vwVFPwM5ITSG/qWZiGeE9T2dxi+iRporSgK8n1zb/xZOJUqWVw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8Up1EY6X6T8XZsCo2/FwcRc1dsEDk8eEpFvq9bJj3v0HylshH
	cIUd5lei0pQ0SvszGyvSOBsEmO8VPsuV29k7iMnsfWzCchgqEErH5G59+HrUYd+8og==
X-Gm-Gg: ASbGncu3q82PyetvIHP1F9anzSb+LBQfwTIc1vh/yYub6Lc3EYBQ6dZoQpC9Wz5uduj
	azHB34Gh07HkzTzEA7ms8K8HpGTAx0yL4w6CuLRs/DqRLBECgh2I+FDL8YN4MzJ8r1jCmVrUzpQ
	oB9aKvKxgkxOtv0O8R+AA9LOrMZg8tVAuOAx+RV4wUKkDODDoo+AGwg4EnB5BR5c8l4x4bnqoTY
	FyT1sFexXCFqJem1S594RDkdu3O3fDYx5cJN/5Hgv+9MTU2FwpESwcKb82Wok9Z1/7K5G6ceM04
	AJvDplq+av7VLKlUzVYnNgxh+WDcSYSTHq+7ug5vUgF0gqRKwMrFGDbHkleb3y7I7TBX4xqQ086
	OrZ0+DAwMgDPf0g1wegZXv39aorY8Qx8nLAc2df8HBrsVpM4=
X-Google-Smtp-Source: AGHT+IHeytPRHCj7R+kHaNiiKnwajCFX8kyPCl8VtEOb/ENw6SDarsElI2Hq8evXiPtfpKeCsMIZuA==
X-Received: by 2002:a05:6512:12cc:b0:553:24f4:872a with SMTP id 2adb3069b0e04-5533b930aa4mr4391456e87.40.1748880407950;
        Mon, 02 Jun 2025 09:06:47 -0700 (PDT)
Received: from ribalda.c.googlers.com (90.52.88.34.bc.googleusercontent.com. [34.88.52.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5533789ff59sm1685113e87.70.2025.06.02.09.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 09:06:46 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v3 0/5] media: uvcvideo: use vb2 ioctl and fop helpers
Date: Mon, 02 Jun 2025 16:06:43 +0000
Message-Id: <20250602-uvc-fop-v3-0-a99e18f65640@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABPMPWgC/12Myw6CMBBFf4V0bc20tYKu/A/jotApzAJKWmk0h
 H+3kPiIy3Nzz5lZxEAY2bmYWcBEkfyQQe0K1nRmaJGTzcwkSA1aCj6lhjs/8ro84AmgtFYLlt9
 jQEePrXS9Ze4o3n14buEk1vXdkJ9GEhy4qh2WBsApYS9NF3xPU7/3oWVrJsmveoQfVWZVQ2XkS
 aHBSvypy7K8AHUOi6TcAAAA
X-Change-ID: 20250521-uvc-fop-b74e9007dd51
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, Hans Verkuil <hans@jjverkuil.nl>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, 
 Hans de Goede <hansg@kernel.org>
X-Mailer: b4 0.14.2

This is a rebump of a 4 years old patch from Hans.
https://lore.kernel.org/linux-media/20210618122923.385938-21-ribalda@chromium.org/

It brings "new" helpers to the uvcdriver and removes tons of code.

The patch:
media: uvcvideo: Refactor uvc_queue_streamon
Is already in the uvc tree. It is here just for CI purposes, do not
review.

I have uploaded my working tree at:
https://gitlab.freedesktop.org/linux-media/users/ribalda/-/commits/b4/uvc-fop
which shows the differences from the original patch, this is mainly for
helping the review to people familiar with the previous patch.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Changes in v3:
- Refactor start/stop_streaming(): make meta and video versions
- Link to v2: https://lore.kernel.org/r/20250602-uvc-fop-v2-0-508a293eae81@chromium.org

Changes in v2, Thanks HansV:
- Fix typos
- Use start_streaming and stop_streaming for managing pm
- Link to v1: https://lore.kernel.org/r/20250522-uvc-fop-v1-0-3bfe7a00f31d@chromium.org

---
Hans Verkuil (1):
      media: uvcvideo: Use vb2 ioctl and fop helpers

Ricardo Ribalda (4):
      media: uvcvideo: Refactor uvc_queue_streamon
      media: uvcvideo: Handle locks in uvc_queue_return_buffers
      media: uvcvideo: Split uvc_stop_streaming()
      media: uvcvideo: Remove stream->is_streaming field

 drivers/media/usb/uvc/uvc_driver.c   |  34 +---
 drivers/media/usb/uvc/uvc_metadata.c |   8 +-
 drivers/media/usb/uvc/uvc_queue.c    | 194 +++++------------------
 drivers/media/usb/uvc/uvc_v4l2.c     | 291 ++---------------------------------
 drivers/media/usb/uvc/uvcvideo.h     |  38 +----
 5 files changed, 64 insertions(+), 501 deletions(-)
---
base-commit: 02e8ee21bd40010ab00f4a8e995f4cc97dc83dea
change-id: 20250521-uvc-fop-b74e9007dd51

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


