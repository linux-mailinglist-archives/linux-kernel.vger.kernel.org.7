Return-Path: <linux-kernel+bounces-766722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE53B24A60
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 920C74E36F2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 13:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7280FEC2;
	Wed, 13 Aug 2025 13:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNxvn9Qk"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A162C0F64;
	Wed, 13 Aug 2025 13:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755090967; cv=none; b=d2wVleH89h1q3BD4gR415bWeikhJq6+xsLtYv2ZM+/ZiwA5L57DHVNNsGWa1J+AJNrIk2r/bafOyWCTc2UfpBVbi0tX410AvbMmCsrkDFS7EauvCAjZUXwROIPJ3ss1ddM4tqK8A9bsGZOK3yF1eQP7gmbwnfrIRtVbHhGSCWEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755090967; c=relaxed/simple;
	bh=1XVdR8bRoDvErfYQUqMRiHpYpy95MzntF87Qs8UmfUA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=nTdBMibCX8ys2CtBaOUyplMG+Iw3Fdhr+X9q1CvSH7sX0zWCwxa9ncqIxMqpNgOE/kxwzBxW3V03bBsori2+X6jCMVwgtyYKrTIBiu8uZZ+fr9mfAVNQNfLMAv2S6T88L5+wI9Reqy818E03kJb5fF3ojSZIVtvSWi+EhZyKDUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gNxvn9Qk; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-af9a25f091fso893381866b.0;
        Wed, 13 Aug 2025 06:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755090964; x=1755695764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WCghLjpiXkWDbjIsqNEwHtwcOYZtn+tDuo/4UkFdJWE=;
        b=gNxvn9QkR7yqghyEZqKIMZ6Uoy4YXUlhKbmpZT7mbz1xiWjBtvbtnbFRv1+t/4URkB
         HiQa1/CNzq8FhKS9Wh3HKwbfiOhsfhTeWXwu1ADChKKPCOoDYlpkaYw6zq+OLzVS+Big
         Z1YENxEU1iygSj2TqcDUb9xKYgwkKQxarU/GEWAtjp6PCG4B3AFO7NLyQskFoUfSMpTH
         V9OwqQk5hg6yLs9hchsBLosJpxLuEPIBwk/jMuwsZaEvT5BXRmNWijKNgUhXuJEiHLh+
         XrgdNt/GQrsYpjF0UYJxX5ceM5Xdrk9Scr2ehkGtCthLDWZKl0l+VqhC+zr5fhP29+IU
         P12A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755090964; x=1755695764;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WCghLjpiXkWDbjIsqNEwHtwcOYZtn+tDuo/4UkFdJWE=;
        b=mhvfGPoXBkaoAzZZgOEAc2D5sAKl5rTMoJN3cAmmLCYWR1g5DEN+/6UgoQsUcpREBE
         wt8okRpuQfE7Shy4vZ9B2+z6C3MnbKB4z3NtTG3tdWsQCzL8ZebgPO1Q66OHhPSR5SJI
         m9QfNsM6t7Lobke/Kc29W//W0hzKtJcw4Tb1MAUlHqLG3TfqgIXDbcl2PeNVVngUnTiV
         dd87RN4B5XkcqzqPd9x9TfyVKhujpwr3iDIlh9/Sdv3mH9mhvELgXdBAxOO8Zm9tbu+a
         rb8KYX6sRSFPLL/sNYvceRw7aJnYnYqu5/0JPpl6EuDYYhz523rbOgxoXK4mBPjC0nG6
         Mqsw==
X-Forwarded-Encrypted: i=1; AJvYcCWnsKWGjFvu/IW/EZkKHVQit75KZlqyxCzSjHBTnNTpOAl/pdr/41NP4nuI+MFlJ9jy0qaU2O0dvUj+Jw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyBbTaZLi6XIxZer7OjcmQpDSa7RY45CLkRURJzvI4pAmwZGrpU
	G9/80QgEdMMkuvk5LSn9bXx4l7j+BfUkG+w3MHyW9YjD2dDm9h/oUozlImSeMuXZzoI=
X-Gm-Gg: ASbGnctm/ldgXKmhYMfjXSuaQ8OKUyjCWWmC/j67MnzgqPb7ZbxJhCTnw+4fei0oLRd
	22t6Tu3Z8OuDLELQFHe7MmgLGAJSeq5rVXkR+D+hsKPGeEV/9A+/0lOSpdjBDnORTtSxVPvDK1A
	76xTOxbevzOc50Mv2mQYlpZaL6YtTDr/O5JoZR5BRVFNZtws5RnOwNxknuM3LYL5qftcyQQDKNj
	l/NJzec1zwnvIz1CRbbq485EAarPFFF1IY8elGmB1cjolPuRteaSJ2b4ehL3Q3h3DHYzw8ybBAh
	0YDrkUkr7vVgs/pdlw7isx+Fv+y2V4uEQ/EwlUv3BchACgx1sQYMc9flnHfoWHJIh9zrUVga2eJ
	ZllS3q6ukXgBg/fwMbVbz12mXbnVe8OZF3N8eewxVEO0aAVrDWoQ64BJKVpeI2j6R/l3X2ixcKc
	mLEA/k7w==
X-Google-Smtp-Source: AGHT+IEZ8gyKeDW8JzClqn831qoDK47fkFCkc39Kxzm6T3X6ErpVbk3kIp480UauN6Aug8ZF2aNsTg==
X-Received: by 2002:a17:907:97c4:b0:ae3:74be:4998 with SMTP id a640c23a62f3a-afca4cb5a7fmr162018166b.11.1755090964164;
        Wed, 13 Aug 2025 06:16:04 -0700 (PDT)
Received: from localhost.localdomain (93-87-121-223.dynamic.isp.telekom.rs. [93.87.121.223])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a1e88desm2420481266b.71.2025.08.13.06.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 06:16:03 -0700 (PDT)
From: =?UTF-8?q?=C5=A0erif=20Rami?= <ramiserifpersia@gmail.com>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	=?UTF-8?q?=C5=A0erif=20Rami?= <ramiserifpersia@gmail.com>
Subject: [PATCH v4 0/7] ALSA: usb-audio: Add driver for TASCAM US-144MKII
Date: Wed, 13 Aug 2025 15:15:11 +0200
Message-Id: <20250813131518.18985-1-ramiserifpersia@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is v4 of the patch series to add a new driver
for the TASCAM US-144MKII USB audio interface.

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
 sound/usb/usx2y/us144mkii_capture.c  | 325 ++++++++++++++
 sound/usb/usx2y/us144mkii_controls.c | 444 +++++++++++++++++++
 sound/usb/usx2y/us144mkii_midi.c     | 401 +++++++++++++++++
 sound/usb/usx2y/us144mkii_pcm.c      | 370 ++++++++++++++++
 sound/usb/usx2y/us144mkii_pcm.h      | 165 +++++++
 sound/usb/usx2y/us144mkii_playback.c | 458 ++++++++++++++++++++
 11 files changed, 3163 insertions(+), 6 deletions(-)
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


