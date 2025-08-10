Return-Path: <linux-kernel+bounces-761428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F11B1F9FA
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 14:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75BA7179CC1
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 12:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFAC248889;
	Sun, 10 Aug 2025 12:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HxmxPALK"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BCA1E50E;
	Sun, 10 Aug 2025 12:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754830204; cv=none; b=JcF5xkFJmiMOrKKM9WMrn1wyQpOIN1zPBB8VXB3VdPqeNOnG2y0DxD/PwIcIVg6ngC5KqnWLkN9Ja5Fi1IgoUCfILmD+hMBHhOE6f60UmEAztArkG4mvzymbTAsjuSqqd307rKDdqgYLuT5AOts0L75DapdB88ndEkUV6LEFIH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754830204; c=relaxed/simple;
	bh=SX2FhM/BDCVOi0yCjhuETBqtpaVFzW+0BpZsuNHJalk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=UD04/4mMbmKEPjsfKZDi7C1NVeBNZkFB7qFDnjbrD+6Fvb2Y8VkVil8ALubou23FqO15Uc5MBpv9HH0HOjPHNQgXF22eWJ2HUaa10Ljtt+SFIT6intu+BtYGoAfXEfez7/fv96AXCiD6MsY7mJc6GOdAD1+uQbi7mxNfENV8seY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HxmxPALK; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-604bff84741so6547388a12.2;
        Sun, 10 Aug 2025 05:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754830201; x=1755435001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C+o7nDSW8S5VsIsdEGeVxZ5b16lyk61vGXIcme0BiNM=;
        b=HxmxPALKKX6psw1/6O0rc7TasXBm4HyWgQcnMxCTaxolpxmjlphAlHJRo06mN2AK5s
         Gvld4UImfcfzl0oljWJiUVSKU9i5GyaPL2RiK3aOp2apo5+/lUB0M7TnifSSGy7cI6oj
         i6NBW5Kxen5eQG9VkFnsgXrPjc5/qTmIctywNCr8A0vbJa7ChjTsUl9HMvv9OJed/bVy
         e6A7/Tjvo6y2yPeDZ5jXt6tvAJp3wQ/ooR90Yu8OpRcIoH+EsCnv2IFNbTUO7mbuytUB
         a//Ek4IpY82PrPlReiAx57eOafc8+yUADKpVfLHVlo9qLKghmY6SjaHdIYDQ4DvGUyw5
         Udfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754830201; x=1755435001;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C+o7nDSW8S5VsIsdEGeVxZ5b16lyk61vGXIcme0BiNM=;
        b=Ss8R4iX+cHq8M9tF+Z5zSV1sH+hTC0CqxsQA5AJnJKscwIoVjzNtHwwX5Bqxj8NI9Y
         jUZSUf5wQwzL65F0fF5SeI6NL/qQEb2w5KiBLDKlEKpwT5L3ijbI735Ezq6LCG44rjhj
         xlUwsVf+N69vI15fN4Et4l8mZ8hznhSIbWjWl/0QlQT4+a+uaX9t1IP8pQXN1iLwVdMt
         jIDwXUR+JZX2IwpfDp33MzRosvbg5ibxF4XKiV7KwkCsgXLc0qYGTsrCcc6tzVu2ktnw
         tQIfLei7WVYHkbuXk1D6+8H+6hvc5/Qu/JzxNeE+wKGwXLJ4Pmi0K/rqnglg+q/SxRKy
         /65w==
X-Forwarded-Encrypted: i=1; AJvYcCUtCcDY9BZiug8b4sdMCpAW7GavfVqjMHhp1qMeBSBHtxeXmqsgLT0YVM+8jwi8TNSjGKDaTpkhvNrCZWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdRDonw7Nni366qwWsSWCZAdP82yQjjOnUfRby8jQ3GZp6JZnI
	frDZZ+TMG5QTz5RouEa6xSzJeIbsS3kwAYfuuqXFP9j5xgUyiD6VaIZC
X-Gm-Gg: ASbGncuAQcf51uSeteu3zUzcgIbSVnotxvyBT3ADClRkdSjnDPciOaWnjCcsYud7SOg
	oj4UYvj6DlYxqMbOjrOn26k6HkR9Tk8DiJJOt4zv3DnFQ1RPsHiD4wr36n3gPNWW4t78HSpfsg1
	YWZ0KUSgsx4aLpAeuN+EBjQi2UvttE5DAwMgI9YPNsrQJKCtgB910aTBM6PUBezgxhdKg4AAo0/
	egzOJw5tgOUqiZBE0GbyBtU4rrgkmclCm5ifDdyooM4rk9DCicCvW5JhIRHw/OJAQLk9UxOJw1u
	C8WxjtD3lDgSJ3DFc89FRvAZTBzSD8o6H60IXuJIHyF8axQ+A+cV9ViOEyqSRhp6Sj3VhUHg6/Z
	ycQAy7Wqh2iSbZl70+Xg1GknxFEnhJSfOJ+Hv5lxtFrsFrXWAndgtAPCD3HPmoLCbAE4xCGH+iG
	nNh2Sk86GVkT8Zr7BG
X-Google-Smtp-Source: AGHT+IGxiZQaB3Qq7xyXBenSyGqLCP/KaDewlvTtO6kZrNuY1o2p0bYpz7PX/wOohvdAqRYpk7r0xA==
X-Received: by 2002:a50:a415:0:b0:615:cac6:2b07 with SMTP id 4fb4d7f45d1cf-617e2e9fba4mr5364717a12.34.1754830200716;
        Sun, 10 Aug 2025 05:50:00 -0700 (PDT)
Received: from localhost.localdomain (93-87-121-223.dynamic.isp.telekom.rs. [93.87.121.223])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8ffbdb4sm16636594a12.52.2025.08.10.05.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 05:49:59 -0700 (PDT)
From: =?UTF-8?q?=C5=A0erif=20Rami?= <ramiserifpersia@gmail.com>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?=C5=A0erif=20Rami?= <ramiserifpersia@gmail.com>
Subject: [PATCH 0/7] ALSA: usb-audio: Add driver for TASCAM US-144MKII
Date: Sun, 10 Aug 2025 14:49:51 +0200
Message-Id: <20250810124958.25309-1-ramiserifpersia@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch series introduces a new driver for the TASCAM US-144MKII USB audio interface.
This device is an entry-level audio interface, and adding
support will benefit users who want to use and fully utilize it under the linux kernel.

The series is structured as follows:
- Patch 1: Add initial driver for TASCAM US-144MKII.
- Patch 2: Adds the core PCM infrastructure.
- Patch 3: Implements audio playback functionality.
- Patch 4: Implements audio capture functionality.
- Patch 5: Adds MIDI support and mixer controls.
- Patch 6: Adds deep sleep and code style alignments
- Patch 7: Integrates the driver into the ALSA USB audio subsystem.

The driver has been tested on a TASCAM US-144MKII device,
verifying playback, recording, and MIDI functionality.

This driver was written for the TASCAM US-144MKII.
However, it is possible that it may also work for the original TASCAM US-144.

Šerif Rami (7):
  ALSA: usb-audio: Add initial driver for TASCAM US-144MKII
  ALSA: usb-audio: us144mkii: Add PCM core infrastructure
  ALSA: usb-audio: us144mkii: Implement audio playback and feedback
  ALSA: usb-audio: us144mkii: Implement audio capture and decoding
  ALSA: usb-audio: us144mkii: Add MIDI support and mixer controls
  ALSA: usb-audio: us144mkii: Add deep sleep and code style alignments
  ALSA: usb-audio: Add infrastructure for TASCAM US-144MKII

 sound/usb/Kconfig                    |  12 +
 sound/usb/usx2y/Makefile             |   2 +
 sound/usb/usx2y/us122l.c             |   7 +-
 sound/usb/usx2y/us144mkii.c          | 616 +++++++++++++++++++++++++++
 sound/usb/usx2y/us144mkii.h          | 368 ++++++++++++++++
 sound/usb/usx2y/us144mkii_capture.c  | 325 ++++++++++++++
 sound/usb/usx2y/us144mkii_controls.c | 444 +++++++++++++++++++
 sound/usb/usx2y/us144mkii_midi.c     | 401 +++++++++++++++++
 sound/usb/usx2y/us144mkii_pcm.c      | 373 ++++++++++++++++
 sound/usb/usx2y/us144mkii_pcm.h      | 165 +++++++
 sound/usb/usx2y/us144mkii_playback.c | 463 ++++++++++++++++++++
 11 files changed, 3170 insertions(+), 6 deletions(-)
 create mode 100644 sound/usb/usx2y/us144mkii.c
 create mode 100644 sound/usb/usx2y/us144mkii.h
 create mode 100644 sound/usb/usx2y/us144mkii_capture.c
 create mode 100644 sound/usb/usx2y/us144mkii_controls.c
 create mode 100644 sound/usb/usx2y/us144mkii_midi.c
 create mode 100644 sound/usb/usx2y/us144mkii_pcm.c
 create mode 100644 sound/usb/usx2y/us144mkii_pcm.h
 create mode 100644 sound/usb/usx2y/us144mkii_playback.c


base-commit: e8e4f3c242cc26de9d69bd8b3a678d1e50980abe
-- 
2.39.5


