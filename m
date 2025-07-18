Return-Path: <linux-kernel+bounces-737088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC32B0A78E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 17:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E01237BE7D6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 15:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEB92E0413;
	Fri, 18 Jul 2025 15:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eTPUcOZ3"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B67B1411EB
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 15:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752852556; cv=none; b=obbvICVLy1xflJHPUyaPki6SWtzuFxqZ8lBfiw32kswdvlklgL1OAe6/PKzDwwhQVhYkBgXL+tFHtVSua6+hbE0QOqRx7jy/s0XGTX2DSd+HdX9GbGFfkcQwriX4S9FEfVtzfsyI3PwVVr3D2EyTLCJwO29jzJmMIMgAWWeVJUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752852556; c=relaxed/simple;
	bh=uxVn8z5vNh8b0EqiZQiCnQQE1xnoXDxMYQl0MrMLYTg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=usfbTHe03HozXxdg+V+WyOqDlBCtyVLgsXPuWz7t4/tYniAx6IfHGe+a0iAR6sJYW3Ol7/XBlCCdIRViMfvbUD1VPg2h89xEiEDLluqQGzt11LCfJvAexivTXp6ntclNHfWLERV+y/NiRG4fOsNckxaaV6YmGOS1VFXZvI+CxuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eTPUcOZ3; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-32f1df5b089so21495771fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 08:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752852553; x=1753457353; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rpDHWMEfaZbT1j+vHvp6fYznBSkyjPMp+OhgKVI7GZI=;
        b=eTPUcOZ3ciPt0mrZ413bHiuaJmr3ydTd+HzDitI1AKvXznxqPY06Lc0os1FlBofQzm
         VqJrsipXemmiSDsKQP3xIZMlwIm7Q+p6kbKRFZ5+dNlCxAOX2Pi7AKT6IHhhSO13uAkL
         Hl5aTUvzRQqwl7ib04IjVMZ1fWTbyS27RCO9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752852553; x=1753457353;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rpDHWMEfaZbT1j+vHvp6fYznBSkyjPMp+OhgKVI7GZI=;
        b=bCDBywIL57jw5UmtzZXyfzfB4WnOdwm9kgidhfIflqTXQKEm0GYhdcHtj3paPvLcF7
         dV74rWwl8A6mcQ9Y458Tlh6QUtskZ07ZqJmjhdLzP2qjLfSGN/bV32ruRJRnc36hAhn4
         Q+wc0un6J0qHhHEUuinpbUw7ErXMwiB4rnuVnMgvoJVes6ctC42uf8QjQVJOyEJObakX
         KbSfkqpZl56juv79LK/iUcuxHkj3GsEzlIbbkJ4HefkmKuYMsyhNSRms17JYCCZ7gKDe
         /xoAxS9xIQMYh9fi8wt7M+Z27phwIX0kF+FEfHIhnKEKZs8sgzBKDyxDrjOQUCdx/6dg
         QRnw==
X-Gm-Message-State: AOJu0YzoSoZ0gphU3ZY73PStrnKp6aWIE2dss1OxpfcS6/Eh0j65T2mu
	o4t8fkeFYLxcPo5thcs/O+hFPq9CT3AnFIw4Bt5lPEJfJRnW4XloIIR217ruAU0kTQ==
X-Gm-Gg: ASbGncuqUVsNlFbIBiKbJwrQlP3o+boFdL5hcio3AFyCxOxxkjTdztlwF1Hik9IUR1+
	i9RcKYyuTsIaroCESiZavhJivmh+FoiCl9R2yZciBmavAvqJT3qZ0l7qC5lRLYPsSrQqWLns1dF
	0M8t7xjtOXhp92GrIzy0Wifc71OPZFNj6rGM+oG6idDAvnOhG0pPUfLuTwYBxBJPXea13CFFuQQ
	8X+8dM7Vb/e6lBLuIvnR0Cy1Cdo1snDpMEGNJSf75dM7buQs/yHYK2+bW554pBqDKNKR+O7hJwy
	4dOO7eIwG2zmGoDmJoAPBljChyD0Fl3jby0kB8NINY0H8lOzowIjVNBdCHDI/qbWwv5k+mSAhnG
	SfDY7MqiqEWjycVs+YpCo1YoxIfvVU/8R1grd/JYu8a9BcW68Om2tqkbvLq9BlyVO8yLNOYRTh+
	jeOQ==
X-Google-Smtp-Source: AGHT+IHCWWFRndQq5TQ10sqZoNxAVRRJdBRC8Iz2chXxrbesJiaBnj6t6V30lxJSk7p201wqjG9aTA==
X-Received: by 2002:a2e:be12:0:b0:32a:c14b:7db9 with SMTP id 38308e7fff4ca-330a7ae47d7mr9316611fa.7.1752852552744;
        Fri, 18 Jul 2025 08:29:12 -0700 (PDT)
Received: from ribalda.c.googlers.com (166.141.88.34.bc.googleusercontent.com. [34.88.141.166])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-330a91d9d6dsm2268601fa.83.2025.07.18.08.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 08:29:12 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v5 0/5] media: uvcvideo: Implement the Privacy GPIO as a
 evdev
Date: Fri, 18 Jul 2025 15:29:09 +0000
Message-Id: <20250718-uvc-subdev-v5-0-a5869b071b0d@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEVoemgC/23MSw6CMBSF4a2Yjq25tw8ojtyHcVDpRTpQTCuNx
 rB3C4kRDMNzku9/s0jBU2T7zZsFSj767paH3m5Y3drbhbh3eTMBQiFI4H2qeezPjhI3VaNUUVq
 As2YZ3AM1/jnFjqe8Wx8fXXhN7YTj+83gPJOQA7eFkRJrcq4Uh7oN3dX3110XLmwsJfHTCGahR
 dZGO2NBo5VOrmg50ygWWmYNZHUpnUKLZkWrmRZ6oVXWGgkU6Kpq0P7pYRg+AhwQAmEBAAA=
X-Change-ID: 20241030-uvc-subdev-89f4467a00b5
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Hans de Goede <hansg@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 Yunke Cao <yunkec@chromium.org>, linux-gpio@vger.kernel.org, 
 linux-usb@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>, 
 Hans Verkuil <hverkuil@kernel.org>, Hans de Goede <hansg@kernel.org>
X-Mailer: b4 0.14.2

Some notebooks have a button to disable the camera (not to be mistaken
with the mechanical cover). This is a standard GPIO linked to the
camera via the ACPI table.

4 years ago we added support for this button in UVC via the Privacy control.
This has three issues:
- If the camera has its own privacy control, it will be masked.
- We need to power-up the camera to read the privacy control gpio.
- Other drivers have not followed this approach and have used evdev.

We fixed the power-up isses with "granular power saving", but the other
issues are still open.

This patchset implements the Privacy GPIO as a evdev.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Changes in v5:
- Drop UVC_GUID_EXT_GPIO_CONTROLLER
- Remove merged patches and patches that will conflict with uvc-rotation
- Rebase
- Link to v4: https://lore.kernel.org/r/20241125-uvc-subdev-v4-0-51e040599f1a@chromium.org

Changes in v4:
- Remove gpio entity, it is not needed.
- Use unit->gpio.irq in free_irq to make smatch happy.
- Link to v3: https://lore.kernel.org/r/20241112-uvc-subdev-v3-0-0ea573d41a18@chromium.org

Changes in v3:
- CodeStyle (Thanks Sakari)
- Re-implement as input device
- Make the code depend on UVC_INPUT_EVDEV
- Link to v2: https://lore.kernel.org/r/20241108-uvc-subdev-v2-0-85d8a051a3d3@chromium.org

Changes in v2:
- Rebase on top of https://patchwork.linuxtv.org/project/linux-media/patch/20241106-uvc-crashrmmod-v6-1-fbf9781c6e83@chromium.org/
- Create uvc_gpio_cleanup and uvc_gpio_deinit
- Refactor quirk: do not disable irq
- Change define number for MEDIA_ENT_F_GPIO
- Link to v1: https://lore.kernel.org/r/20241031-uvc-subdev-v1-0-a68331cedd72@chromium.org

---
Ricardo Ribalda (5):
      media: uvcvideo: Factor out gpio functions to its own file
      media: uvcvideo: Re-implement privacy GPIO as an input device
      media: uvcvideo: Introduce UVC_QUIRK_PRIVACY_DURING_STREAM
      media: uvcvideo: Make gpio_unit entity-less
      media: uvcvideo: Remove UVC_EXT_GPIO entity

 drivers/media/usb/uvc/Kconfig      |   2 +-
 drivers/media/usb/uvc/Makefile     |   3 +
 drivers/media/usb/uvc/uvc_ctrl.c   |  20 ------
 drivers/media/usb/uvc/uvc_driver.c | 135 ++---------------------------------
 drivers/media/usb/uvc/uvc_entity.c |   1 -
 drivers/media/usb/uvc/uvc_gpio.c   | 139 +++++++++++++++++++++++++++++++++++++
 drivers/media/usb/uvc/uvc_status.c |  13 +++-
 drivers/media/usb/uvc/uvc_video.c  |   4 ++
 drivers/media/usb/uvc/uvcvideo.h   |  38 ++++++----
 include/linux/usb/uvc.h            |   3 -
 10 files changed, 185 insertions(+), 173 deletions(-)
---
base-commit: d968e50b5c26642754492dea23cbd3592bde62d8
change-id: 20241030-uvc-subdev-89f4467a00b5

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


