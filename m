Return-Path: <linux-kernel+bounces-870045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DA9C09CB3
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 18:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92E1358391C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 16:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6406305053;
	Sat, 25 Oct 2025 16:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNNszlW1"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871AF2F5A2D
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 16:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761410429; cv=none; b=joUC4vX+YppQabnkXE3QxyyV0QnW5Zj6PVH24TVnoM5ksFCpkuBZKQUymNGA/yoiB22bAp++kg1tp5cWqfGYKAvnL7XMmr0sK81+z2sBM39WiAuussNupFvu878jf24gffjKtM7VGfg035hEF2ISJFOt39lk74kbkNYmlM/gX0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761410429; c=relaxed/simple;
	bh=wYDEJOkutzgeKwpXuFbluDJGmCNQh0M5ItImkyWKOKs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tdRMmQfL+1F0WAJXvmsZvBSGtWErVbmJBoUT5qqwFoCz8kiL/6JhR2VWMXvbyL/+hqAjMTnwQ7c75h1sLFxIni/fC+6aKpI3xYaU8uALVvF22BYcTmFF9MSlHKQkUIkvXTqb5BlQUw3ahNJCZo5ADh5FoyWsuadql7zsTbxrX0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DNNszlW1; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-87dfba1b278so34281936d6.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 09:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761410426; x=1762015226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hi1uUI86KgiBELFP59v0Njk5QqcWzQJqQwBxfdpRtPI=;
        b=DNNszlW1wqNCOrHAVewqtrV2sNt9z6vmP8r/0Pn8qyYTgsG760p7hvmwCIoR34ZSWQ
         GNmuZAUK8RnZflqhQgJqGe5fXPZHyU3hOOXHFfzmAOWdYi7VLfgB/8/chpX6e9eGEPpK
         Yqbze5WJ254q8Soxw2bE8HXUofHoigCqYWZAA6Su4OSa0qlg2/NAhAydE6FEfryZuSaI
         xcWC0g78bfJqUXtXUn0O/kii3ytFQUhXE1s7EUltlK+pY1039GCXh8w9NZxbnCbjepVB
         9G8SzFmLPyaOGLBz9yOL5ZzloFbDYKRkKlwe4CkVpQ6F/hVRHzN+aQyMDjaU+AYJ2Rcq
         0ydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761410426; x=1762015226;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hi1uUI86KgiBELFP59v0Njk5QqcWzQJqQwBxfdpRtPI=;
        b=NZZlsTAD9y3T9I7yFKX88HjDHWrZQM/TrsE8JZdMDv7sVusUuYDXl+Jbw5oGB0d2Tg
         1iQdyWfRaOY4HkuokVA9oupMs7hOrSJZN/CeYlPp420FcAOJf2oWH0o6bkRhoGCbq84A
         iUCizmJ5EDjq7RHy35CsgRsUTAi7xQuxgClha8zYQwpRBeHz9K6XYDjKkfneqegj0bvA
         TodvHKp0k8lhiuOYygg1TF2in5JHIxN8ZksaOIy7uUlu2v1GCKxEkTb3NRDmeSuVYB/z
         Z56pwJc029nfXPVJALToN9qaZgR1ADg1Z9NbKt9fVSu3hfazhSZAmZQ2j8ATYtZ5fPEV
         fAiw==
X-Forwarded-Encrypted: i=1; AJvYcCXizGsPc+gGufkVNKstpJ17p9ZwnfjA/QIiXTxP0nBRPpaVlf4egf4N5dc3sP60HpcCqf/3rJ4+jUaHnK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZQjzn026GL/sAUVw12PLc5MSiby+x51mR2BBhK6sOynEg86+6
	q/XTrq46ySoyRw6OAkUfzh24eUj6z9LtCjFLcGprJKZsaZSVox9U1VqM
X-Gm-Gg: ASbGncuiHOfTqZVceXLjKjxtTkh1o5V3uegq7htBBudnESaDAPzZFprFTbs9y358vst
	byohozK6UrxXTI7OvnPpocT2ZU2iofl+3zig1+6sx7zqYeXoau+Bs2X5AFgD1D6pMe2R0BvIg2t
	ZNZdizSnfpe3DkONah4EppDuxzEbGwXKh7bQoLEybye2hns9FC/OU7/jz+G6+x2h3uKLNFcM7hC
	cy1SnwCgA0hctYAeHWMTuDoeHAeuSTXe7Y3q5Hf+qm9B8hgUeUpzU/ZRiOAtfSKdF7mGGOtKU/f
	Dg//HMnikfpkWOMfp7eRrfbsg7ok80DhlX+LCpPADovNx36tCUKkGnhtC3Uc+5bykFJeMOXFAfJ
	B6cRVMMuIQ4g8W34F0/LD13c98GNLs90GzulpMz6Ye6KSFzGhBDr7Wg7ouQfsXYrbTDJkAekz
X-Google-Smtp-Source: AGHT+IHwX3D/M4+lbLcnfKS2ap5vtju8DWcU6o/kt+dt/jmCuJCtj5pFD7Ln1uoSjUeS4JlMhaMDyA==
X-Received: by 2002:ad4:5f05:0:b0:87c:13b9:7b1f with SMTP id 6a1803df08f44-87f9edb592bmr125218096d6.23.1761410426483;
        Sat, 25 Oct 2025 09:40:26 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87fc49a3984sm16349036d6.50.2025.10.25.09.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 09:40:25 -0700 (PDT)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 00/21] lib: add alternatives for GENMASK()
Date: Sat, 25 Oct 2025 12:39:59 -0400
Message-ID: <20251025164023.308884-1-yury.norov@gmail.com>
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


