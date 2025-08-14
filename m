Return-Path: <linux-kernel+bounces-768575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA50CB262D8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C5E1B660F2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1150B31812A;
	Thu, 14 Aug 2025 10:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awSCC8tL"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABCF318124;
	Thu, 14 Aug 2025 10:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755167142; cv=none; b=ZdVa5hGZzqox3Xlj+c9ieJZjCYijBBi1beHv5WrdDW7cjeBPFDkaHodE7rkGSENviKAMdJg41dnLVtgtS4hvqsm+x/UHFl9ffMwvmDtEHkyz6GgAdyeM9aP4skZ2aBy2OsfndsfBP2zdj8qE+orOg68RQcR9hxAJdrpHVqEc1V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755167142; c=relaxed/simple;
	bh=/+K3OD8MCTk4gMJFELwMbTcwXd10UKBWpodQtCX5epY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=WSWEXItv2rzeIYYcWcUz8bcwiNZT7NC6kISj8gwC6C6PXH/fv5yyqJU37MvcoLfqyESxRGpbM4ZTTTgaLLuRHS+gf6+5CIoT/vpXtJI/OepG8aPQ3Qifon/xfhD8fB0tfs3+YOI5STMizcq7yroolfHc4M68R3KPW0QUjlnw2mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=awSCC8tL; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-afcb61f6044so147236066b.0;
        Thu, 14 Aug 2025 03:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755167138; x=1755771938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PpoIVUM+zNiV047AhNhVrEOhCqdoUHKoqO7rt/ZEjRQ=;
        b=awSCC8tL+18/VgDX2DZHMVuWtSKYJ8y3bz8TTB7MYq6hNWAyoYnh7Li7Bc9Q62Dpu5
         TPqEUx3iGSb0ExRVvP9cpLnSxE6p1ajQ7LPpy6+cax+cxt0mBVl9E94eNi4vX67FjH+n
         6cBMQQf0xkRBjNkgFdWsJQcAb1ArfZNUAcKRtpmTsz7DnubgN/Q2Ipq1GiIdUWolAUah
         uqgpF0+954fw02ok4AeRiVXy66kNHV83zXAZU+5T1a6z79ji3P3eZ+muSKBTIIruExPC
         MWwymkXAWhV5RjNm+gtpYyQ5Bqcylu6n/DsKSpH9CQLdjmR60anzVq8xKZ7/cPAau0Mb
         foKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755167138; x=1755771938;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PpoIVUM+zNiV047AhNhVrEOhCqdoUHKoqO7rt/ZEjRQ=;
        b=HWzzysqX/7i55Y21wpp/PCoGrr9NSFf610N5kv7xr6Wiu0HushWuCIwuNocS2iH4TX
         XdsjpSZoX9fPx0eHBP+L3dB6GPlktdnekP8Sgr89fw9Px7zBCrzXFSaHz4RvZUT2ziqf
         uj4Ej1WWa/ZiDv4qCimGsIyS9fICEEvn6EEXLQJh3xGF0JMhVgOhZnXV8zqdhIuWYnYZ
         UHsfSeFzmkV+GpswwMoeH9VWAmnIER3MfxGSio5HtjAZAj076dp4ihJ5ki4V/xJdAbJh
         uxiG4fYTtfDG21TxvB5YEOOXOLpXEibjRTcyP5RMBN9Gm7hjDgk6P3EXxemIWOMwnDP4
         kJDg==
X-Forwarded-Encrypted: i=1; AJvYcCWfgFvhEDvzUeKePTX77OITrxS9ZYY4ZisMYHtW1J4cJqL16XYcltMf/YIiNbkXLE9gCpRd0h3j2Sxxeg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6qhnSVocPFuAgpqBxSRxJRDOBnCSbfTZ3LPMDbEyuUIlJPDZY
	B5u4cNWE13gPactPNHm2BHoGuI1x40637ZtJofcgIq9XkOjnjuibH2Bk
X-Gm-Gg: ASbGncvUznCoHkGwxUaAfbxOaXKD0AjnPnM7JZCUpYY9h9mlNN+pBC/oLkGWG6O0rJe
	HYDSFI0QCSfWZbaipxJnz3oGaPQXBFV3YMRsmGhaNOUefk/imt/CiKIasl+4UpANG9D0nTEn+Sq
	8OsLjZtQVHxYcX0QaroAYX7e756+LwozFNYc1aPyDVecZAB6ZjwvOTysj6fNaMbZBKyX/qJQ/rZ
	2/fpSGuXLwPVw5Vl9M6bjhGPG5EHEi4JrJgdJB/BpZfdRAGL9M/vKGcsytVkDWH4efiUEE838N0
	Cz8y5/5dvK+hMQhNDSmwCSUs+nkvEEDAnAPn9Yhbt9lfFiaON1Qdo7i9hriEB8qwmAUNZFM0Xr/
	qH23r/GUlrLdGJtgLyW1mAuSjYyh2FDgTli5tdtiehCfQQ4YIoVSeJv9N2ZRKVKvi46+WFnyXdU
	VvubE7Lg5DdtA8wwu6
X-Google-Smtp-Source: AGHT+IHfN0E8UlXzIZ6c128woeZOL/pqA058tSmYhnseXXkG4yvEzZ+V8jtf29UZ5yYpCln7p7kbsg==
X-Received: by 2002:a17:906:361a:b0:afa:1d2c:bbd1 with SMTP id a640c23a62f3a-afcbe95ca40mr162158766b.30.1755167137550;
        Thu, 14 Aug 2025 03:25:37 -0700 (PDT)
Received: from localhost.localdomain (93-87-121-223.dynamic.isp.telekom.rs. [93.87.121.223])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a219ef2sm2564819466b.96.2025.08.14.03.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 03:25:37 -0700 (PDT)
From: =?UTF-8?q?=C5=A0erif=20Rami?= <ramiserifpersia@gmail.com>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	=?UTF-8?q?=C5=A0erif=20Rami?= <ramiserifpersia@gmail.com>
Subject: [PATCH v5 0/7] ALSA: usb-audio: Add driver for TASCAM US-144MKII
Date: Thu, 14 Aug 2025 12:25:27 +0200
Message-Id: <20250814102534.34439-1-ramiserifpersia@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is v5 of the patch series to add a new driver
for the TASCAM US-144MKII USB audio interface.

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
 sound/usb/usx2y/us144mkii.c          | 618 +++++++++++++++++++++++++++
 sound/usb/usx2y/us144mkii.h          | 368 ++++++++++++++++
 sound/usb/usx2y/us144mkii_capture.c  | 323 ++++++++++++++
 sound/usb/usx2y/us144mkii_controls.c | 453 ++++++++++++++++++++
 sound/usb/usx2y/us144mkii_midi.c     | 400 +++++++++++++++++
 sound/usb/usx2y/us144mkii_pcm.c      | 370 ++++++++++++++++
 sound/usb/usx2y/us144mkii_pcm.h      | 165 +++++++
 sound/usb/usx2y/us144mkii_playback.c | 458 ++++++++++++++++++++
 11 files changed, 3169 insertions(+), 6 deletions(-)
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


