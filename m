Return-Path: <linux-kernel+bounces-764819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A75BFB22798
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F269680540
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C88525F796;
	Tue, 12 Aug 2025 12:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNUazFt+"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CE21E9B19;
	Tue, 12 Aug 2025 12:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755003398; cv=none; b=juxy7q7WAtVlm/rIDAySPwQm74LqvMyWg1vavz5EYteQ9kcj5NKyod7+YHkb9oVYRIMnGp96QpHRh/fiAL20Rp45Y7xS1hnCs1QoNLuSjOpAjriXS+yW1Vqt7wLXLtnagJ3VtoIDbdT1ZS9uLXa9P2y6SofpRiOiBPFgelvCIVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755003398; c=relaxed/simple;
	bh=mf3duEHJESRvPaAB11JCT1JY5xkEJKtp3WGuxWg7qUo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dRn3QJTdkKgo9mlfjVSYFz2pU1UfVPT30QRGrJ65ajP9+NHe6jjhTocGOo08CfoWy5hgG+LZAjqyg37eHZFIDzoK0IyMM5uoOP16xquM0wpC8tMiOkS7J8nkXhu92v5jt4Bj2lbswj1iXn2LFp/oTEnhlfgygQHBGMmxoSGhJvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eNUazFt+; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-adfb562266cso739770966b.0;
        Tue, 12 Aug 2025 05:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755003395; x=1755608195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+dWT3qwPW8fdc3Y+IWuANHr14YzOFSQ6K8iD8kS+KdY=;
        b=eNUazFt+KcBMGMNTt6/JbtKvLSHSJ1sjG3/9VM7s8aj5ZBBblW72X/xbv8N15g7nfX
         OUWi6e1y/Kr6+JwOWzMR17BkdoPQZ0HSo63eN7g1b4khBkUEBCWjnmo0H0Kv58uZXIB9
         hN5cwvW00ovg/55FRkJ0OkXmnDh1sfAv5MYrV20B9tLG6cX4cKbxB6+LSGc/EHVfk/k4
         ZcHDryVsWwr6znD6oXTL38tRTq6sH7OeXwxWKqjWN/jilFDQORIbF7sOrle3QaGOd9Os
         WK5BmOiXlNvZ2cS+2p8aJHM+RnyuI1Sce2bAwI41DbculZZsUfbdniwEqTD6jdO6YqTL
         j3Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755003395; x=1755608195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+dWT3qwPW8fdc3Y+IWuANHr14YzOFSQ6K8iD8kS+KdY=;
        b=rwvfUhVs67BCW7VFayH+Qp8QHI+iYOPE1CZjg5G4ikY0VahUwVRdoOWLZ4OeQkt2lM
         3FKYtZgN4b0CupEqWGyEgA69LWbQdVwOMEa1Q4olqMXrDYxzl5339+Q9HOHqnzOZy3fS
         FFh2jdL2rYlhunKz3ybjDEQLDgEXBYelvXSM7mlNEAeTk61t7Zu4oZfiYqeErdcaOFZo
         DE5BAXntDvRBk7xGiZdb2UkX5y8E/tO+iuoqkC3KRA4mfTrjfu4gtCVWCYSeuZ9WYhqx
         xR0l1Zj+P8EK86Bf1MZagD3SOGZfH58MBaAXzSbhTpn0kFKKdhesUeIEyAv0bWP7//Y+
         cItA==
X-Forwarded-Encrypted: i=1; AJvYcCX0Da6q89QMjZAecGBvnVy4NGQUXGSHmsTDZajguoh668PTchxJcXZMPrXjJhpAIRJnSu2JNT5kuMVsmw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxCQTCI87IzcUrsp8mz8M4jwpec1cL41gU/39ig6U0llJy5gJFh
	s5/qEFZja9TRLZpjEwFLBsq5QgAcTj8UKYn0tM1R79ZCxYHIrPVJG480U8VlPuBYsQ8=
X-Gm-Gg: ASbGnct7He4bsOG9xazKIpg79guOeVm2Xz1w1hh5Wcosi0Z7Qw+1qxPdRIhSJEL/Z2K
	AN5G2VBxaksAqlEkC4K01YQNew3u9FHk4gnywiTNF0vtwDaQwwC6WSJ7VUREuyzax/OTA41birm
	IweZdo06eBJmaDwh1EFUJETzXZ0O9wkfkuwtwH90KP6kmklhXlTDB7FG9uRHvrB1CtPRlJhDwz+
	dWA9e6I580Xf0mbtsodHL0Za2MH1phCarxosH7zVmb5BNoYXqRwqAD1y5yHFr5eABqUU3Hz1y6l
	qCZS2aS+mMbqqGgA9E+k/hpXt7CTmA2Ci5O6uJB0K8jlW7+6S05W/fAl3k2YSPB6OfZvSvp/M0r
	ZTWw8AJPszIDJ+5J3ExkWNZ2W8jHANgAXzVgJEqGvTc9A/q6O/645d1f7Qs2jQccOFefon9ITNr
	OC0SDiyg==
X-Google-Smtp-Source: AGHT+IFBB5VtmMcf9ZQMHS4reiHwHt1CtGiCJaDPCvRw9TnDsz+Cq+RLpPilsEu6J3K2eNK4zjSwkA==
X-Received: by 2002:a17:907:9728:b0:ae0:16c5:d429 with SMTP id a640c23a62f3a-afa1e1d5f10mr325309866b.58.1755003394977;
        Tue, 12 Aug 2025 05:56:34 -0700 (PDT)
Received: from localhost.localdomain (93-87-121-223.dynamic.isp.telekom.rs. [93.87.121.223])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a3361sm2199158266b.39.2025.08.12.05.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 05:56:34 -0700 (PDT)
From: =?UTF-8?q?=C5=A0erif=20Rami?= <ramiserifpersia@gmail.com>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	=?UTF-8?q?=C5=A0erif=20Rami?= <ramiserifpersia@gmail.com>
Subject: [PATCH v2 0/7] ALSA: usb-audio: Add driver for TASCAM US-144MKII
Date: Tue, 12 Aug 2025 14:56:20 +0200
Message-Id: <20250812125633.79270-1-ramiserifpersia@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250810124958.25309-1-ramiserifpersia@gmail.com>
References: <20250810124958.25309-1-ramiserifpersia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is v2 of the patch series to add a new driver
for the TASCAM US-144MKII USB audio interface.

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
 sound/usb/usx2y/us144mkii_pcm.c      | 372 ++++++++++++++++
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

-- 
2.39.5


