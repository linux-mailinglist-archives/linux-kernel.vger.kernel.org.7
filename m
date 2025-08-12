Return-Path: <linux-kernel+bounces-764882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAACAB22858
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EB921889035
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C2D27C84E;
	Tue, 12 Aug 2025 13:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OR5c6wYN"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABD6242D89;
	Tue, 12 Aug 2025 13:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755004934; cv=none; b=CbfAIxR5woO3VaM7u2Ija9oJWFaF2e56vdzycxoEfgow7TOPPlCTH+OlFcyWVzcRT0Z43cRCforGVs1Js2hRgSgBPBlQWiB4GW6JDhP+e65t/4oucJXczLSA/NhoYXBzGOvUa7sdv++eo8R5Q2MJH8mWjirvSvR7VmPqcVbBh5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755004934; c=relaxed/simple;
	bh=/GHvV3MVjXrR4T/tqmcRwGBSqBU2g5h5KcIoPkp9pQk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TAePbrIkP8U5ttndqbL3hFwziwHWjDlsaOM2pRUT3NXkMzZFghsNaD83kIA1/AeLKdgZ3c1r/KCIxvGEkuMmb8Bji9W2+sXx0FgzcW1rDHWyD9unFZNQ1K4AZh9ZVpABTdUNnKh3WEvi/N7l6YInAbDFZR87nmHxG6IZwXaA9nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OR5c6wYN; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-60bfcada295so8976974a12.1;
        Tue, 12 Aug 2025 06:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755004931; x=1755609731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oaY89I/5y1cPCPlKSw8XgOew52Df2jgwINaFHGG5zvI=;
        b=OR5c6wYNdtz2NSo5iV+idGz2DT9VfOA0fGCYMkhf6NTIWgIZZ4Iy3QnR1bE1chfKS/
         9sQGRz7I9HoU6oVTkRYsLzZg8wxUWaD+FUitm+oAc4783Bmlge3Zn8l8Sq65WCr4pTg2
         ygUS40vEoYvnfIMLcJG0n4HAaqKlRo55Bdy/f0VceCq+YNIk+QfmhoP16obukMVEX/kS
         BNF192CHlT3SfLmMcoO0czChCB1PGZvl3cem5wwiZQgoMe8u0L/2sqLEeiWzamZehSa8
         /6Y+QN43njGEICgNSpjGrOdvwV4b+IhYZ5fqaUjqTKcV5WKZFvj7b0ok4itRbY9pOZpj
         obPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755004931; x=1755609731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oaY89I/5y1cPCPlKSw8XgOew52Df2jgwINaFHGG5zvI=;
        b=KWHwtyXpit47qVHv8KRFWqBCys5WveeYdEg7Gz6GAUjR6yP/RLqYLTqWXUYWX5BjUq
         7TjTHCnHro7eODxH+u8fEK3dDvexi+rboArzI/i7W58ctBHlw9SiVxwjE+vjVMt3eLjI
         WuM0/2/orZGqsiq/YwSxSohoTYsMv5kuWCSWa123oEt245CuM4HOe9vTEUG/H1cCi+A2
         izy5ngAjTQ9RnA2NmT2L3zbRCOjzlhy60Vo6MC6fkGVV+44xlNpDb6kfwcOZX4AgQLFm
         7m7rVLWElLkLVltbaiOz3jENBG/svu6WSKMs0Lm5gMV9tJKMYSVrMAvPhZ3vkkli3Q9n
         sVYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVl6eT1IQdRWc863aViqBtEWfVmy3MlRNCdNrGVQCDLYo81+Erh/ZBvYhkLJiPrxp1AmEfIiQdVq5KHzw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwYBznnSGYw7pI6lyBNjUfWJs4yrw/k8ocu4uZqERtnCLh8CKGt
	Jrjf+Okqc+aGiOvw0HaDiIHBnjHpmIUR3FP/gV/5Cf/s01FumE8jKCKPFzSv1Pg7T48=
X-Gm-Gg: ASbGncvyFKeTfhIQKr6IfIGsThkc/SEcOCPfEDEo6S7/4hozmIom+4ipTPYiiZZ63zF
	/0s3dNbPC6+zBf2uv3ttTzwhec5Fl+OJzMT7ZMwTWuCv2+baYn4eUNW2QmkpjoTQbkaRp7lQP0R
	SQovJxrrGqC1Uq4wocI1/iuV9FkbVYVL2YgXMXQTgWokDe8TwT3u+9FDKMq7epLZyKW4nCGitsT
	2OmXGwPHjlr9tOkspNAwoWmfwdJS0cRNcCHI10hpWxh9pSO9zA2YzHLeGGhGBj5r60M/Ynh7GNz
	YZIJsfeZmAOUH+7STqsySsP8TCdYTeMu4Cil7qZnxceYJKzpc8YzCuqWspl5R/3uddfLJYKqPSt
	LRYj2Bn+ESQUqY2NYlUXZ4+NPXtG04BSOX1yky84+HpvKnfm5S7XjfBHpnP3w96tKYtG691ZLJf
	dazkiI3g==
X-Google-Smtp-Source: AGHT+IHEPMMpXwOoB5tXz3TbRkcQNk1i+Bf0xBqepb5UwgphYsuaFurjdUMlBjdW41ocFFY7R+qelg==
X-Received: by 2002:a50:d587:0:b0:609:7ed1:c791 with SMTP id 4fb4d7f45d1cf-617e2e9dfa8mr10134227a12.32.1755004930653;
        Tue, 12 Aug 2025 06:22:10 -0700 (PDT)
Received: from localhost.localdomain (93-87-121-223.dynamic.isp.telekom.rs. [93.87.121.223])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61850794509sm1315511a12.31.2025.08.12.06.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 06:22:10 -0700 (PDT)
From: =?UTF-8?q?=C5=A0erif=20Rami?= <ramiserifpersia@gmail.com>
To: perex@perex.cz,
	tiwai@suse.com
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	=?UTF-8?q?=C5=A0erif=20Rami?= <ramiserifpersia@gmail.com>
Subject: [PATCH v3 0/7] ALSA: usb-audio: Add driver for TASCAM US-144MKII
Date: Tue, 12 Aug 2025 15:22:02 +0200
Message-Id: <20250812132209.83728-1-ramiserifpersia@gmail.com>
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

Hi there,

I'm sorry if if this is inproper way to submit new version of the patches.
The v2 submission got mixed up with unusable patches.
Hopefully this isn't an issue for the verification of the changes and further
review.

Thanks,

This is v3 of the patch series to add a new driver
for the TASCAM US-144MKII USB audio interface.

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


