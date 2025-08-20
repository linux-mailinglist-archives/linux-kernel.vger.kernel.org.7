Return-Path: <linux-kernel+bounces-777316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D45B2D826
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3A481BA1901
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 09:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3A72DAFA5;
	Wed, 20 Aug 2025 09:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kh0fgA1t"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38211E9B1A
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 09:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755681438; cv=none; b=niPwffj/s7GSRAksQCbwJcbtR0i7myhGBNINqTAmOvMcX3r+QxkWQS7zfpDBbJuSCMVmDkV/9LO6/YWgQ2ABzd9gwNHz2cNdQP2oK/2jJZtz6vvZs6p6Fqr6+sNzdhbOIkLGr3XyM9W9UrywfX9zCE9Bm6o8W9nTXyobtHt0Vm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755681438; c=relaxed/simple;
	bh=J4N31BiNSaIZU4tXgGrc88Ztvr27PFZyKdQ8EQFdz2c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Dma/cd8XBqTV0erpg0BzqSS44bZScLN1kChDkBZHoST6itlg/sX2dkxvgtBI2R0lgPwdAvmOrnIso//za/5UsjN57ZDMMCWgIwlpgux5vBbT+TXSpwqcQmS2396USTSxvexoiksdPeAIT7kqZc01rSBmmBMvOmLlEvNCvshi3F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kh0fgA1t; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-76e563b25c4so2470728b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 02:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755681435; x=1756286235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=39cuczpygL/G/6AohQYcSCveWURyMSXomv0UnOGyLJM=;
        b=kh0fgA1t9Tp6b9WMLKZ+5tltRwyug0GQOWN5XBNQ2oWg42z2wn5Zx9qY+yt5fhqGFY
         Sr8lnVW1sDCa95dJx3NO9YoXbXnZjHQ+SNDVbM6w3qi5kgjzum15hLD9YPiq4XlzKmc4
         CibqGuki13H83AUqjy9WGsgVvMd+wmNsrSqkdVJ7vFsVB36VhPwfwOxkXJ+oNA6UZcb0
         I+EaE48kPnJcUTCqH9eic//nSAJOcdNS34tUQp5MSLgh6WwbiRSATe+2hjZwq54QTF/m
         jXJk7U8Xk55+xOfPT/d0H5V8RKHEmamLfe7KH+QlRAe9ydQdREsOXkm/k1rGD+6ZxhxW
         tYRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755681435; x=1756286235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=39cuczpygL/G/6AohQYcSCveWURyMSXomv0UnOGyLJM=;
        b=t4sgHFdrVFpeSNi5fDkR7cCbZIHFUGGqPXo1DnLvsE/tvXu1f+BM81ov2i2bIPmVn9
         /2T4JgdZ5TAlSNgQV92kbF3kd5CXWKA8dS4tR6rwBlCNkVu2AciRCdTHxef9iA07Ka2+
         cjtHs4Uii9ScxzpK76dCFOs9/FcvFzynHOKf8kiFl2kKD/JZBpR47AWhsv9eUBqq803C
         MQKEmcsFZ3fj4D06ujGt8yr7GKoL5J+o9nL4vrojOPVpjwYZ14vZR0MQSYHQcETNtad5
         PrfT1i0HO9JzYiVba8n73jMqGnu4exIpCss70I2ciAaR5mVD7dgq7I9+MQr3mBmn+7W1
         qzGw==
X-Gm-Message-State: AOJu0YyK4QX1YOLMjBTodu8H2Lm+sr2yxqQgiFqtGO2Gv+tW7UvkP8Fm
	DA5EFt4Jo+7z/TLUAsZO/eAJ807/YoQoZTz00Ik0pQub14s60FtXsZG3RSBu1iICCiI=
X-Gm-Gg: ASbGnct6h7aBkuuZxV2JZCDk3Ajw2YQ81pCXwbBdYXT0BZyaP9Ez8RJeBob0si4xWyl
	oOpjFDjitY0/UMDFFP80xookJC9NUjE0SFCA6vN7KfC7w6DaHyTQLc4/Hy8JJJMorx0hDKoDWw9
	hmVzotG3cphzT+xG9RBeu3mh4+9KF2Pa3QcqU4E+AKYwgY31Fg/pE7tBlTAhV9PEIK8BJezCFvj
	Dyt1kB7co2t0rFD7HGTc49T06bXcUEVqO4GEFyP4S/NbTjIDKvPa7SPE4xjVDvR01k3+6EzkePb
	b2nr0hhCoxp35wKSOe2qMGZI8XTs4OCjJjej+Vmzt9mBgrxCeH9Im8eHSXldUoEB7PX7peQMwVU
	+AVdTboywxcynq8G7iZVAm7EjTXw4vEMHbEBq5awVMVIZaJCPn81Un/E0oilTA40G/GRoEmqPiO
	8=
X-Google-Smtp-Source: AGHT+IGimp2Vfkx5FLbA9GKV47qNjrS8KlSlVbSxe19ozZmYK/78Ib6/Yn0clNU/3c8fvaaQDGC57g==
X-Received: by 2002:a05:6a20:1590:b0:21f:5c9d:498b with SMTP id adf61e73a8af0-2431b993263mr3403647637.28.1755681435076;
        Wed, 20 Aug 2025 02:17:15 -0700 (PDT)
Received: from localhost.localdomain ([114.242.33.243])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7ccfa8d1sm4847120b3a.0.2025.08.20.02.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 02:17:14 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: pmladek@suse.com,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	feng.tang@linux.alibaba.com,
	joel.granados@kernel.org,
	john.ogness@linutronix.de,
	wangjinchao600@gmail.com,
	namcao@linutronix.de,
	sravankumarlpu@gmail.com
Subject: [PATCH 0/9] panic: introduce panic status function family
Date: Wed, 20 Aug 2025 17:14:45 +0800
Message-ID: <20250820091702.512524-1-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series introduces a family of helper functions
to manage panic state and updates existing code to
use them.

Before this series, panic state helpers were
scattered and inconsistent. For example,
panic_in_progress() was defined in printk/printk.c,
not in panic.c or panic.h. As a result, developers
had to look in unexpected places to understand or
re-use panic state logic. Other checks were open-
coded, duplicating logic across panic, crash, and
watchdog paths.

The new helpers centralize the functionality in
panic.c/panic.h:
  - panic_try_start()
  - panic_reset()
  - panic_in_progress()
  - panic_on_this_cpu()
  - panic_on_other_cpu()

Patches 1–8 add the helpers and convert panic/crash
and printk/nbcon code to use them.

Patch 9 fixes a bug in the watchdog subsystem by
skipping checks when a panic is in progress, avoiding
interference with the panic CPU.

Together, this makes panic state handling simpler,
more discoverable, and more robust.


Jinchao Wang (9):
  panic: Introduce helper functions for panic state
  fbdev: Use panic_in_progress() helper
  crash_core: use panic_try_start() in crash_kexec()
  panic: use panic_try_start() in nmi_panic()
  panic: use panic_try_start() in vpanic()
  printk/nbcon: use panic_on_this_cpu() helper
  panic/printk: replace this_cpu_in_panic() with panic_on_this_cpu()
  panic/printk: replace other_cpu_in_panic() with panic_on_other_cpu()
  watchdog: skip checks when panic is in progress

 drivers/video/fbdev/core/fbcon.c  |  9 +---
 include/linux/panic.h             |  6 +++
 include/linux/printk.h            |  2 -
 kernel/crash_core.c               | 15 ++-----
 kernel/panic.c                    | 71 +++++++++++++++++++++++++------
 kernel/printk/internal.h          |  1 -
 kernel/printk/nbcon.c             | 14 +++---
 kernel/printk/printk.c            | 37 +++-------------
 kernel/printk/printk_ringbuffer.c |  2 +-
 kernel/watchdog_buddy.c           |  5 +++
 kernel/watchdog_perf.c            |  3 ++
 lib/dump_stack.c                  |  2 +-
 12 files changed, 89 insertions(+), 78 deletions(-)

-- 
2.43.0


