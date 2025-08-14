Return-Path: <linux-kernel+bounces-769363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA92BB26D82
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 19:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5829A052E8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 17:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D26A221FDC;
	Thu, 14 Aug 2025 17:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jcQO2goa"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4DA139D0A;
	Thu, 14 Aug 2025 17:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755192149; cv=none; b=VmSkoJUkn1k77MDidvOujet69qVIb7tWyC6WV9YM6zRlStZOzu0fOsE8EOVNUfTUb0hFxBdUPeWSkIoD+O+2MjzGLEuSLPSrwsa2/4SBVebo+X4t6g89L1HrumND87LdTECAzHj//phioA+cp5DgbVyJF8y7gTiZFr9oWem61+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755192149; c=relaxed/simple;
	bh=120jGlfjlfdd7Emz7Fp/PilxZdEz4gAqwhu1OwG95+4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=jTkEaNpA9vAeW1otvk+EdlSNNlvSDB6D3bwmQ89a4O6SFzXYwLNkvAMggw9fQrus2MZZKnQchsp/CIYWr5CqePJi9yPo1c81i7kf5QOemOuwlKmW4s2Kk/7Srru0ekWm9xKrdg/N+0mTGtGMCpbPzjeQvqLP9omCgc+jAS5IoMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jcQO2goa; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-afcb731caaaso164344566b.0;
        Thu, 14 Aug 2025 10:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755192146; x=1755796946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bXQ4zFcP1VHzRpcQtDiXfue/khViqbfXGoh+G+cmdaU=;
        b=jcQO2goaVvlpNqnbCmk8MD2w2G4Ikl2AxA1FUHPcRX07lB9bsislIhhNBP31doOLep
         328L5SUupLrCpu2gG6cgUi8617cVlpB+dxinwxhE2plLPk+7t1n/iOeTMtzJErq6qnuC
         vZvZYIgT4TGrIUH3OnUyF5WQ9A6d5c3jQhtkQIZ/ET98C92ZWeDea8DhrcodArqtQttr
         Mge7+Cg0RU8L6VNVyGM+2+kEJhcejeSmO2voN33MRSuNxYpCkAsCyRLWi4NMd9SitPC1
         K+TS2tJlMGpvlBD+3FNgyce3Otw4yJNX/Ht8dqYHH4brrOyeFKJnC4p2elE7B4Htcg0j
         v36Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755192146; x=1755796946;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bXQ4zFcP1VHzRpcQtDiXfue/khViqbfXGoh+G+cmdaU=;
        b=RMUQIfxuw4PlhNgcr6SIB/JhGcHoJlDXFAhA9cc8zglYC3WZmvWXchYWGZHapNUV2k
         n902ux/AllxOk8vlIO3vjrrlpm8UAAHFHLlQ4uefu6br2TdZIxrL+18EJolni/rjlh7k
         lH8GAW9Ky2AHY1rdPY83nuA/evgpYEc4zh/mGyMXo73QsfhADt59sK9L9BIl7rzC7nvd
         zrn4YKEIlJi/rVj33mVYLei2hmNVVmdHdQHF8+GV5GA5zLUm6jTOsslbCoBpEY3nsbkx
         FTzTLbLxoANI27a17haiuc+L1GHKda0+wB81qUeQAjMync2OwZCFfuH7cHFQIiny+dfq
         RmsA==
X-Forwarded-Encrypted: i=1; AJvYcCWD1WnmvWmUsCzEpUEbrUrkTipmL2V8jOeexgQuU3RGwv44jzL1695TjfUOGpGcg1SQBaXxpPTDNeizPA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwB7ueFGy4XyMpx0sOrU91SGyhBSM0g9lYHxUF2j7sgMuwrIfXq
	jHdSHtdaLxpK5kaM0C5MViv8Eoa+zzVC61+OLs5EPX7c/mfdBflP6vNi
X-Gm-Gg: ASbGncuu9E2+ZauTXtLvp7/bbxEoK4Fw2JEmwJVkj7sgRY2ky8xz1eoI8c/SKz+aZ6a
	WWJWiL/+mlAIAyzyLhNZBTvjHqe4iX7ZeISz7Feu+zdA+8xDv7qpUVj6wDLpphi33zhmeYt56HW
	J/ZL/QR3eJ0nrri5OJCgtsQ8wVh2ZBO0BWNdICkfQSLbVASZrXWp/ZKBtQH0Y4nIX5leSx9xPkG
	CcXmmRTb/x3aCk6wYWyOZnAmWxrQs7fUijY6WtWtdi+EnXkIGDhL9o5wMEOi1beQKk8Fn1N4AVT
	G5+t3E+U2sv3VYU6kRiTRm+ErMMO90MRhAGK5ISjylA4t+ZwG3aXFEv5IgtiCqNJG76rkqtChSK
	5olzGDh5dzPrlGckzgsfT0CxNUdZg56pT0LsmT/DGSAhvBsQmT8b1t7E6akS24CP5VL3apVnwH4
	Wn2XM7DA==
X-Google-Smtp-Source: AGHT+IER2zPzMvrw4CKEPAnHDQegy0Jro1MRokFhNcNZXbr3NRVE24nTIWs58dh8OLsl7TmsaP1jvQ==
X-Received: by 2002:a17:907:7208:b0:ad8:914b:7d0b with SMTP id a640c23a62f3a-afcb9357c3emr378205866b.11.1755192145818;
        Thu, 14 Aug 2025 10:22:25 -0700 (PDT)
Received: from localhost.localdomain (93-87-121-223.dynamic.isp.telekom.rs. [93.87.121.223])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8f2c265sm23774115a12.26.2025.08.14.10.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 10:22:25 -0700 (PDT)
From: =?UTF-8?q?=C5=A0erif=20Rami?= <ramiserifpersia@gmail.com>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	=?UTF-8?q?=C5=A0erif=20Rami?= <ramiserifpersia@gmail.com>
Subject: [PATCH v6 0/7] ALSA: usb-audio: Add driver for TASCAM US-144MKII
Date: Thu, 14 Aug 2025 19:22:15 +0200
Message-Id: <20250814172222.9448-1-ramiserifpersia@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is v6 of the patch series to add a new driver
for the TASCAM US-144MKII USB audio interface.

Changes in v6:
  - Addressed open brace cosmetic standards for scoped_guard() calls.
  - Added lost default values for digital in/out kcontrols.

Changes in v5:
  - Addressed u64 remainder in Patch 2/7.
  - Refactored guard() calls for spinlocks to scoped_guard() for ones
    that got missed(hopefully all).

Changes in v4:
  - Removing leading spaces from #defines as requested.
  - Renaming fpoInitPattern to fpo_init_pattern.
  - Removing unnecessary kfree() calls.
  - Replacing manual lock/unlock patterns with scoped_guard().

Changes in v3
  - Corrected v2 invalid patches order
  The v2 submission included mix of patches for v2 that were unusable.
  These new patches are valid now.

Changes in v2:
  - Patch 1: Dropped blank line, initialized `__free(kfree)` variable to
     NULL, and fixed `struct tascam_card` indentation.
  - Patch 2: Corrected indentation in `us144mkii.h`.
  - Patch 3: Changed `fpoInitPattern` to `fpo_init_pattern` (snake_case),
     initialized `__free(kfree)` variable, and replaced
     `guard(spinlock_irqsave)` with `scoped_guard()`.
  - Patch 5: Updated control names to standard "Playback Source" and
     "Capture Source" formats, and initialized `__free(kfree)` variable to NULL.
  - Patch 6: Re-organized code style alignments into previous patches.
  - Patch 7: Fixed trailing whitespace warning.

Šerif Rami (7):
  ALSA: usb-audio: Add initial driver for TASCAM US-144MKII
  ALSA: usb-audio: us144mkii: Add PCM core infrastructure
  ALSA: usb-audio: us144mkii: Implement audio playback and feedback
  ALSA: usb-audio: us144mkii: Implement audio capture and decoding
  ALSA: usb-audio: us144mkii: Add MIDI support and mixer controls
  ALSA: usb-audio: us144mkii: Add deep sleep command
  ALSA: usb-audio: Add infrastructure for TASCAM US-144MKII

 sound/usb/Kconfig                    |  12 +
 sound/usb/usx2y/Makefile             |   2 +
 sound/usb/usx2y/us122l.c             |   6 -
 sound/usb/usx2y/us144mkii.c          | 620 +++++++++++++++++++++++++++
 sound/usb/usx2y/us144mkii.h          | 368 ++++++++++++++++
 sound/usb/usx2y/us144mkii_capture.c  | 319 ++++++++++++++
 sound/usb/usx2y/us144mkii_controls.c | 444 +++++++++++++++++++
 sound/usb/usx2y/us144mkii_midi.c     | 399 +++++++++++++++++
 sound/usb/usx2y/us144mkii_pcm.c      | 370 ++++++++++++++++
 sound/usb/usx2y/us144mkii_pcm.h      | 165 +++++++
 sound/usb/usx2y/us144mkii_playback.c | 456 ++++++++++++++++++++
 11 files changed, 3155 insertions(+), 6 deletions(-)
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


