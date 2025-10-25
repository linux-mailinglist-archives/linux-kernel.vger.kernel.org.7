Return-Path: <linux-kernel+bounces-870018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2611BC09C92
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 18:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 398AC568929
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 16:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046803126BF;
	Sat, 25 Oct 2025 16:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8gBvqcm"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1595320CCE
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 16:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761409745; cv=none; b=J1z1EenVNDZx+e/vQ/OD8HIifUbjSsnXNY0g8NsNRqYyO6OozbJSkLxz9NoagizqiYTPGeYxMG2IxiwrgIfe+Gq2r/nNbRhdiedEVM1SCIU5QJrae1zlTl/ZNz1ZXd04IofVlrbk1CVgan/LJ1DNnrrbd8LO2hdNpHaNcX4r18U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761409745; c=relaxed/simple;
	bh=wYDEJOkutzgeKwpXuFbluDJGmCNQh0M5ItImkyWKOKs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hIzMHXpammmOCUSubYMlOccddF2vgOLcDVIyslqzgAi3KvvD1EPywk8coG0/33OZ6vJaz4t+6UFrYSj+Ezq9fAeCRJZG9WKWf/v+sdrt2q6/mdkS5FOPHMjKL1AERdwI6A8C2y0s81Rf5IHVGMLShUipfZBeWnuHUhBoc6XvK0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V8gBvqcm; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-81efcad9c90so36904166d6.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 09:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761409741; x=1762014541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hi1uUI86KgiBELFP59v0Njk5QqcWzQJqQwBxfdpRtPI=;
        b=V8gBvqcmHSpFyRlmHrrEbYF1VIFy1GiaGJJtBj9eJL8uw6CRrYxPBpnlGMSbN4udCj
         9kMfPI3YRmz9FTcMoXR42fMF0uvKwKtLFMuQfhnjl/G5ec32brj+nYEL7AUmNBtvQ8Io
         CyBeXZqum3yGRIbHBDS1mQLxH0fLYn6wARIQBWR6WH/XWmutwocIfB1eCaIZJ9VW1e9c
         xRduU3pk5OrS7E663W34lTW/QRjS0cRo6BzD0qxFz3f3DsQXQlk0+D0247/TjKJF6Emy
         xpzUJZNgh7nmvcO7gWNBt7lgp3Pcw7xveZ8d+NELkKy1B8j83DbRMni+fT6mGMdmL344
         3zcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761409741; x=1762014541;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hi1uUI86KgiBELFP59v0Njk5QqcWzQJqQwBxfdpRtPI=;
        b=CrLG9/sUFnPLblUnmyF881VRQbvOVRGRfB/6dzB1P69pURPpxkHqsLZswoWNlvhZ2O
         +IwZqGGG8mJ1hDT9HfqrtyxMz6iIHB5x0+SwuSscLJwusccSMuBHpafZGBvdqyd1XVPx
         Yhgt/x0Tt7z18dN19+EvjJw5kNJQH1Q8cl8DrcX+iq2Z5nVGeYBP7LQGhVGxKrjqah8x
         pms0LayCHhvaTSLytaI1gD8u4Hn2s4wh4+lXT4R4pry4+WW66hA5bIjVU2GYrY5P3nwP
         p34SmBDKFYVAXuRlfP6KEJI5CGXJ6naKH0FUtl+4vykxshOq8OdfKyV8ZfG5H4fqJKD2
         SZKw==
X-Forwarded-Encrypted: i=1; AJvYcCUBYk/0j4k4CMo5Uch+yRYQ5M8PZTqBt8eocXz5x7VaU3ed8XpxSHVRLZVqE9f2N11V4B+tqns3zPeDa5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YynibgjoPw77+Vhh3gSc3PsvtPC4l62Jkw3eByKt3ws0CZLgWKk
	vpjf2NyRTLSb7Lykr3y+OhoLDBvASplwY+x9szN81qok4t3UyXMizcIR
X-Gm-Gg: ASbGncv7vrFl89GG44DxjhU6SHIJDBkFSQNFP7Fjtn2Ti6m1PG4iknvPmXXwPvnbWEq
	hZtrht4KlQuNTe1c9gsZ63MycYynLFOmX3z0HZoNeu+98tV3ehtPRUpRja5IShSZUmG8MzEhan8
	mjArojRnDginGJPiEJaTEYO1oZa5Vvi5T3lXOIhFT0EAoOjC8enmWygN8I5zAZbufhNxvuXZWky
	usK5jMxOo6HfXDF3UZihVBK5jguhFBN7Dyyo5pwjTCAmFDZBVFzBRbbRiEwQX1DkoFCg4AS9xBF
	a11A212G+8OSZ7Dl1Sm0pek7MCLTwr2UkVfWD57AYlwX8415iCgn17AsQEl4MLkIth1T7DMoxzC
	2G/9z1HALHwOMC/cZ/6s6cOKoG4Gtm1B82GSH1WpY2mA6VlN2K4qCZ6bivnlKFNrB73KW8CzLOY
	mWVxTYPgA=
X-Google-Smtp-Source: AGHT+IFriOJ8ZnmANV2FeKZ+6XVVgptoQeBb05x07kqdM2R8c0Su+SoYubCTW+1OEZR7AS+GByFCDg==
X-Received: by 2002:a05:6214:406:b0:87c:1dbf:2c21 with SMTP id 6a1803df08f44-87c206314cfmr323635096d6.51.1761409741340;
        Sat, 25 Oct 2025 09:29:01 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87fc48a8812sm16731436d6.11.2025.10.25.09.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 09:29:00 -0700 (PDT)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 00/21] lib: add alternatives for GENMASK()
Date: Sat, 25 Oct 2025 12:28:36 -0400
Message-ID: <20251025162858.305236-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GENMASK(high, low) notation reflects a common pattern to describe
hardware registers. However, out of drivers context it's confusing and
error-prone. 

This series introduces alternatives for GENMASK():

 - BITS(low, high);
 - FIRST_BITS(nbits);
 - LAST_BITS(start);

Patches 1-6 and 8 rename existing local BITS(). Patches 7 and 9 introduce
new generic macros. Patches 10-18 switch GENMASK() usage in core files to
better alternatives. Patch 19 adds Documentation section describing
preferred parameters ordering.

The series is inspired by:

https://lore.kernel.org/all/CAHk-=whoOUsqPKb7OQwhQf9H_3=5sXGPJrDbfQfwLB3Bi13tcQ@mail.gmail.com/

Yury Norov (NVIDIA) (21):
  arc: disasm: rename BITS() for FIELD()
  iwlwifi: drop unused BITS()
  select: rename BITS() to FDS_BITS()
  ALSA: rename BITS to R_BITS
  zlib: BITS() to LOWBITS()
  mfd: prepare to generalize BITS() macro
  bits: Add BITS() macro
  mfd: drop local BITS() macro
  bits: generalize BITMAP_{FIRST,LAST}_WORD_MASK
  i2c: nomadik: don't use GENMASK()
  drivers: don't use GENMASK() in FIELD_PREP_WM16()
  bitmap: don't use GENMASK()
  trace: don't use GENMASK()
  lib: 842: don't use GENMASK_ULL()
  bpf: don't use GENMASK()
  kcsan: don't use GENMASK()
  mm: don't use GENMASK()
  fprobe: don't use GENMASK()
  fs: don't use GENMASK()
  fortify-string: don't use GENMASK()
  Docs: add Functions parameters order section

 Documentation/process/coding-style.rst        | 48 ++++++++++++++
 arch/arc/include/asm/disasm.h                 | 62 +++++++++----------
 arch/arc/kernel/disasm.c                      | 46 +++++++-------
 drivers/gpu/drm/rockchip/rockchip_lvds.h      |  2 +-
 drivers/gpu/drm/rockchip/rockchip_vop2_reg.c  |  4 +-
 drivers/i2c/busses/i2c-nomadik.c              | 44 ++++++-------
 .../platform/synopsys/hdmirx/snps_hdmirx.h    |  4 +-
 drivers/mfd/db8500-prcmu-regs.h               |  2 -
 drivers/mmc/host/dw_mmc-rockchip.c            |  4 +-
 .../net/wireless/intel/iwlwifi/fw/api/coex.h  |  2 -
 drivers/soc/rockchip/grf.c                    |  4 +-
 fs/erofs/internal.h                           |  2 +-
 fs/f2fs/data.c                                |  2 +-
 fs/f2fs/inode.c                               |  2 +-
 fs/f2fs/segment.c                             |  2 +-
 fs/f2fs/super.c                               |  2 +-
 fs/proc/task_mmu.c                            |  2 +-
 fs/resctrl/pseudo_lock.c                      |  2 +-
 fs/select.c                                   |  6 +-
 include/asm-generic/fprobe.h                  |  7 +--
 include/linux/bitmap.h                        | 11 ++--
 include/linux/bits.h                          | 11 ++++
 include/linux/f2fs_fs.h                       |  2 +-
 include/linux/find.h                          | 34 +++++-----
 include/linux/fortify-string.h                |  4 +-
 kernel/bpf/verifier.c                         |  4 +-
 kernel/kcsan/encoding.h                       |  4 +-
 kernel/trace/fgraph.c                         | 10 +--
 kernel/trace/trace_probe.h                    |  2 +-
 lib/842/842_compress.c                        |  2 +-
 lib/842/842_decompress.c                      |  2 +-
 lib/bitmap.c                                  |  2 +-
 lib/test_bitmap.c                             | 14 ++---
 lib/zlib_inflate/inflate.c                    | 48 +++++++-------
 mm/debug_vm_pgtable.c                         |  2 +-
 sound/core/oss/rate.c                         | 12 ++--
 sound/soc/rockchip/rockchip_i2s_tdm.h         |  2 +-
 37 files changed, 235 insertions(+), 180 deletions(-)

-- 
2.43.0


