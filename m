Return-Path: <linux-kernel+bounces-836796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F639BAA949
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 22:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8A537A548E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 20:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5A72512E6;
	Mon, 29 Sep 2025 20:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eMSKPsfH"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A4F2512C8
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 20:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759176452; cv=none; b=VaNH+SwRfpppdb3apJZGThT3ULwkldbv3VYid+j8SkQavW1admdsU+j5Te7tWGD+yRfAEB/CME05VDo6xIEuIm5UdIePeyNKa6BlOFS+veMqTzoWkkLVGNLbOJ+Bm8kZzKuUUitcODMFuV0A79917TgK4jjFxHXODI1LKGAX/pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759176452; c=relaxed/simple;
	bh=RHwb48U8fCVWn3nr6/T+rqJV+3cSeXRzJTG8Gq6sSD4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=e3oFO2bSAfefMajtRO0MrHpXnFlBWuqAb8fWEYRWFjhEFJGy/9AADGa2GuOWwsLjPZKV0NdTG/8pX6VwTym4mnKHVE4OnvLi7AqSnkmdeN0iKlzn8ITUgiy/CMZ0297vyyOQqPTktkbELH+luu7IW1RpNwvy1O6Ot6tsqtRcqzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eMSKPsfH; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-781db5068b8so2025386b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 13:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759176450; x=1759781250; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eG2QgS10X4gfW9Fatnq3lFpV635CKEKJyfeiq36EgGU=;
        b=eMSKPsfHFx7BF2dVXN4Cu6ZLsx4sA6ixs95e87QK/r85jUu4En4phcqXiIz8A1M1/f
         CVLeIg9zGpvXMqdMM8HLOE+QO9ggq6qkHXepOCzFwpZpLP8P10CQdp4vPiH1hJ8mghde
         uIQw+y7luxJtjBbUH3lny/ssqrg7Wz100RMRHkrxc5HCOYy21AEC7Y1PFSGriXWPOGC2
         RB0YqrZyDHH2UET7HIqrdV2pLeFUdzEnzsrQhDZDzlFHPlzorCdsupCagBOp5n/2i441
         NhHXFTX0nNraFWkGpVr5tLPvdbeqJctarbRAFiROLXxQq0A4g4tPjXGLxFlgyBLKCZjZ
         xvIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759176450; x=1759781250;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eG2QgS10X4gfW9Fatnq3lFpV635CKEKJyfeiq36EgGU=;
        b=VBD94tTMbYV4jKta/wTPavj5bzOkQPKs3Gl3cZScA+ziU5aV/i0DAwiqaCaMrd6xiD
         9GbiYRNmkgNBds/PfxljLsR0+jHSwKkMlQXjkBtp9rRAkPXTdMjqzBboluF5Fk5wpee+
         33pji2oZ8k04t1Vfs+a/JYG03QnhmNYfPuvDCKTj8DoaB5ClgHGZvC4qCbTWscqT0Sqb
         kYHK0GYa0K58U3stkYCIWj4GgXIIVbGSW4VnTZ8KZi+wkN7agLjcfUbtsxC5aMArOqmo
         lnJUKFF0Yok00/5KnFsza/E91jEiF+ue8Xz4DnpIjgpq9holH07eyGj13UhYJg38vNAn
         8x3A==
X-Forwarded-Encrypted: i=1; AJvYcCUS5yBiJoXPGVh6Pu36PDyTrhEZEvhMO3csn+URYpjMjDpra+zaYBHVSneVdNXiO7MoVGue+D7U+M0oYH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuJCeWg5gmcCz+hLBKFo1Ump+XrlaLqEffnep9hAYmFSYVJkzQ
	JzZ77A0UyY9ulrt3W5rMZfd5iZ3c90/9klkZZgGVh7NeEv+ofYBg+eR5
X-Gm-Gg: ASbGncuXc3dfS9lPWoBAZ9khkKcVVgTkhUoOgl2Z+ACwPfYyrxGnr5Hu4PBcqqmpiG1
	gzvRAsDG6rLheS8y0l+PhCidlgWdXrpNBH/RVPGxnKTbVL5A66jYyfFfOihyGkRs2bHczLXrBSb
	9kebl/JGkm1NLQTgJ1ROLsm8VojHH/hDv1/n4Oml3X1AGmm97fJvXdJO8qmSywgFcIYZ1GEr3pk
	egSrR8g74bgr34pm9ibxh1NaQvvVyNjtzX/5n/G4X41xIyH2wywpi8E0qTf9gEizA+Vlw4doiZf
	vzop6JowcU9dNJvv42WUelmQxCTG2QVpsrQA6H0uL8V0g8bHB9LTCaZNmluFoWjmZQ0hIH2ELDt
	QeUuOwEVIpuQ6esxR+fdR8aE69RcHf0EG
X-Google-Smtp-Source: AGHT+IGEp52OBSzjpNqR9jS53ks+3+Q5JWsm8pJrSp7KxOKJtADXE5FpwPNkrpl8c2L+Jp0tN4MF+g==
X-Received: by 2002:a17:90b:3907:b0:336:b60f:3935 with SMTP id 98e67ed59e1d1-336b60f3b2emr9825619a91.23.1759176450227;
        Mon, 29 Sep 2025 13:07:30 -0700 (PDT)
Received: from localhost ([216.228.125.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-338eb96849fsm267323a91.1.2025.09.29.13.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 13:07:29 -0700 (PDT)
Date: Mon, 29 Sep 2025 16:07:27 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Cc: NVIDIA <YuryNorovyury.norov@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>, Burak Emir <bqe@google.com>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Jakub Kicinski <kuba@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Subject: [GIT PULL] bitmap for 6.18
Message-ID: <aNrm_14uJmGE7MYC@yury>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull bitmap patches for 6.18:
 - almost complete consolidation for HIWORD_UPDATE()-like macros from Nicolas;
 - bitmaps wrapper for Rust from Burak together with dynamic ID pool based on
   it and  tests;
 - __fls() fix for arc from Kees.

The patches spent for over 2 weeks in -next with no issues.

Thanks,
Yury

The following changes since commit e6b9dce0aeeb91dfc0974ab87f02454e24566182:

  Merge tag 'sound-6.17-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound (2025-09-02 13:38:07 -0700)

are available in the Git repository at:

  https://github.com/norov/linux.git tags/bitmap-for-6.18

for you to fetch changes up to 2cdae413cd3ee6aad782cf4bce8c10fdb0f0657c:

  rust: add dynamic ID pool abstraction for bitmap (2025-09-22 15:52:44 -0400)

----------------------------------------------------------------
bitmap-for-6.18

Bits-related paches for 6.17:
 - FIELD_PREP_WM16() consolidation (Nicolas);
 - bitmaps for Rust (Burak);
 - __fls() fix for arc (Kees).

----------------------------------------------------------------
Burak Emir (5):
      rust: add bindings for bitmap.h
      rust: add bindings for bitops.h
      rust: add bitmap API.
      rust: add find_bit_benchmark_rust module.
      rust: add dynamic ID pool abstraction for bitmap

Kees Cook (1):
      arc: Fix __fls() const-foldability via __builtin_clzl()

Nicolas Frattaroli (19):
      bitmap: introduce hardware-specific bitfield operations
      mmc: dw_mmc-rockchip: switch to FIELD_PREP_WM16 macro
      soc: rockchip: grf: switch to FIELD_PREP_WM16_CONST macro
      media: synopsys: hdmirx: replace macros with bitfield variants
      drm/rockchip: lvds: switch to FIELD_PREP_WM16 macro
      phy: rockchip-emmc: switch to FIELD_PREP_WM16 macro
      drm/rockchip: dsi: switch to FIELD_PREP_WM16* macros
      drm/rockchip: vop2: switch to FIELD_PREP_WM16 macro
      phy: rockchip-samsung-dcphy: switch to FIELD_PREP_WM16 macro
      drm/rockchip: dw_hdmi_qp: switch to FIELD_PREP_WM16 macro
      drm/rockchip: inno-hdmi: switch to FIELD_PREP_WM16 macro
      phy: rockchip-usb: switch to FIELD_PREP_WM16 macro
      drm/rockchip: dw_hdmi: switch to FIELD_PREP_WM16* macros
      ASoC: rockchip: i2s-tdm: switch to FIELD_PREP_WM16_CONST macro
      net: stmmac: dwmac-rk: switch to FIELD_PREP_WM16 macro
      PCI: rockchip: Switch to FIELD_PREP_WM16* macros
      PCI: dw-rockchip: Switch to FIELD_PREP_WM16 macro
      clk: sp7021: switch to FIELD_PREP_WM16 macro
      phy: rockchip-pcie: switch to FIELD_PREP_WM16 macro

 MAINTAINERS                                        |  16 +
 arch/arc/include/asm/bitops.h                      |   2 +
 drivers/clk/clk-sp7021.c                           |  22 +-
 drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c    | 142 +++--
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c        |  80 ++-
 drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c     |  68 ++-
 drivers/gpu/drm/rockchip/inno_hdmi.c               |  11 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.h       |   1 -
 drivers/gpu/drm/rockchip/rockchip_lvds.h           |  21 +-
 drivers/gpu/drm/rockchip/rockchip_vop2_reg.c       |  15 +-
 .../media/platform/synopsys/hdmirx/snps_hdmirx.h   |   6 +-
 drivers/mmc/host/dw_mmc-rockchip.c                 |   9 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c     |   3 +-
 drivers/pci/controller/dwc/pcie-dw-rockchip.c      |  42 +-
 drivers/pci/controller/pcie-rockchip.h             |  35 +-
 drivers/phy/rockchip/phy-rockchip-emmc.c           |   3 +-
 drivers/phy/rockchip/phy-rockchip-pcie.c           |  70 +--
 drivers/phy/rockchip/phy-rockchip-samsung-dcphy.c  |  11 +-
 drivers/phy/rockchip/phy-rockchip-usb.c            |  51 +-
 drivers/soc/rockchip/grf.c                         |  35 +-
 include/linux/hw_bitfield.h                        |  62 +++
 lib/Kconfig.debug                                  |  13 +
 lib/Makefile                                       |   1 +
 lib/find_bit_benchmark_rust.rs                     | 104 ++++
 rust/bindings/bindings_helper.h                    |   2 +
 rust/helpers/bitmap.c                              |   9 +
 rust/helpers/bitops.c                              |  23 +
 rust/helpers/helpers.c                             |   2 +
 rust/kernel/bitmap.rs                              | 600 +++++++++++++++++++++
 rust/kernel/id_pool.rs                             | 226 ++++++++
 rust/kernel/lib.rs                                 |   2 +
 security/Kconfig.hardening                         |  10 +
 sound/soc/rockchip/rockchip_i2s_tdm.h              |   4 +-
 33 files changed, 1362 insertions(+), 339 deletions(-)
 create mode 100644 include/linux/hw_bitfield.h
 create mode 100644 lib/find_bit_benchmark_rust.rs
 create mode 100644 rust/helpers/bitmap.c
 create mode 100644 rust/helpers/bitops.c
 create mode 100644 rust/kernel/bitmap.rs
 create mode 100644 rust/kernel/id_pool.rs

