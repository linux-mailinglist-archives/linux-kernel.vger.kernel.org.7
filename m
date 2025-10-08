Return-Path: <linux-kernel+bounces-845731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E7FBC600A
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 18:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B82024270DA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 16:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1062BDC01;
	Wed,  8 Oct 2025 16:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="Gl+StA1H"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51122BD02A;
	Wed,  8 Oct 2025 16:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759939656; cv=pass; b=MaGfpnhuGtV7yVCS3RXAtOyFoZaieTCQ+bavZ1oDSNxZ+GO+k4yJRswLAXBI5hwxxmexqI/k3j7N5MR1Jnbk8wZoQHGGyYUrFySHfqxlFUf5aby6brIzO16dPa6ix6UnK6wM43R4FrtLd1o4hVZUV0aO1IMfKSNVx5YhSjpctoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759939656; c=relaxed/simple;
	bh=/96yJw7IOpqI6hPVch1F2jY7Dzoyi6NmuPvpTMa3hV4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rdB4fQ1msiL1cXT5aWLF3nI4WAywBT8NDiz7BzsB1A8jh43SSOJoOC+DCgwfWa+G/fhR1fT2FmFDVIaufv9CKWKT2o/uZw1/8YdZtWsA1HvJyAUhOjDrZdzXi/0cN2Or/gS4c05P/flpSUphLLVUKJMZs7TyY+HU/K8ohJcGDCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=Gl+StA1H; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1759939547; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=WvgFhNQjFuF2w7vmkBR33tizRowq9p5DChLX8HhxldVQyoKsQkuYzE3pdwHFYTQdGsdchmtK17UD1kygsfd0bCK6whtHz6k2tVnzqk+Uk2lX9xKlJntcMRg/KaX9F9PbaMY/iWjBaA94yyA2V2Q8SnEqvTjB6/cnx2sJwfHp74w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1759939547; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=C6Dgx4PSW53d7cGyuFXrxBnWUw2p9vWZj5GWMum1gdM=; 
	b=aPXjLwxLRuF1Ai31FkBFBgrdapHSU9DNfeEavQ8deQnSSeG/kwoh/7N8meg0EjxmWFhxK6iFX5CPGLt0s3RZl64ZmzqIIevNEAbnhnLfTas/jBgcJOmT9OkljH7FzhvybEyERehKKqkZv0ZKLaVFNk1vnM9ONpox3xwPfpLzs6w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759939547;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
	bh=C6Dgx4PSW53d7cGyuFXrxBnWUw2p9vWZj5GWMum1gdM=;
	b=Gl+StA1H5jP7fNz2zNLRrP4kTVV8+at5FSUtga0KJk4xGBU449nWNrfKz8Ud7hjh
	dFA0fzNiGmI0rVkKpmJfEG8UYQyQ3IBYy1tjxbheiFQh6y8OcEqo/QAigf4HqSren6b
	N2F3xp81jLH0zoFJfdRf5UawBAgEw2bMcp1BtCXM=
Received: by mx.zohomail.com with SMTPS id 1759939544761761.1705555269986;
	Wed, 8 Oct 2025 09:05:44 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: [PATCH v2 0/5] MediaTek PLL Refactors and Fixes
Date: Wed, 08 Oct 2025 18:05:34 +0200
Message-Id: <20251008-mtk-pll-rpm-v2-0-170ed0698560@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM+L5mgC/22OQQ6CMBBFr0Jm7Zi2AWlZeQ/DosAgjUCxrQRDu
 LsFti7fJO/9WcGTM+ShSFZwNBtv7BhBXBKoOz0+CU0TGQQTGVNC4RBeOPU9umnAqhWSK9E0jN8
 gGpOj1ixH7VGe7Oj9idFwHqHSnrC2w2BCkYy0BNzDnDEJu9AZH6z7Ht/M/DD+Ds8cGaYqS3me5
 zKXzb22fa8r6/Q11qHctu0HXBHsAtsAAAA=
X-Change-ID: 20250929-mtk-pll-rpm-bf28192dd016
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Yassine Oudjana <y.oudjana@protonmail.com>, 
 Laura Nao <laura.nao@collabora.com>, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>, 
 Chia-I Wu <olvaffe@gmail.com>, Chen-Yu Tsai <wenst@chromium.org>
Cc: kernel@collabora.com, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Stephen Boyd <sboyd@codeaurora.org>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.2

This series refactors all users of mtk-pll, just so we can enable
runtime power management for the clock controllers that want it. It's
also generally more useful to have the struct device in the pll code,
rather than the device node.

Also fix up MT8196 mfgpll to declare its parent-child relationship with
mfg_eb, and fix the common clock framework core to take
CLK_OPS_PARENT_ENABLE into account for the recalc_rate op as well.

The reason why this is all in the same series is that it grew out of me
first modelling this as an RPM clock for mfgpll, which Angelo disagreed
with, so I did some investigation and it seems MFG_EB indeed is a parent
clock. However, the earlier refactoring to pass the device pointer down
is still useful.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
Changes in v2:
- Drop bindings patch
- Drop mfgpll RPM patch
- Add patch to also transition pllfh to passing device
- Add fixes patch to make CLK_OPS_PARENT_ENABLE also apply to the
  recalc_rate operation
- Remodel mfgpll's mfg_eb dependency as parent-child with
  CLK_OPS_PARENT_ENABLE
- Link to v1: https://lore.kernel.org/r/20250929-mtk-pll-rpm-v1-0-49541777878d@collabora.com

---
Nicolas Frattaroli (5):
      clk: Respect CLK_OPS_PARENT_ENABLE during recalc
      clk: mediatek: Refactor pll registration to pass device
      clk: mediatek: Pass device to clk_hw_register for PLLs
      clk: mediatek: Refactor pllfh registration to pass device
      clk: mediatek: Add mfg_eb as parent to mt8196 mfgpll clocks

 drivers/clk/clk.c                            | 13 +++++++++++++
 drivers/clk/mediatek/clk-mt2701.c            |  2 +-
 drivers/clk/mediatek/clk-mt2712-apmixedsys.c |  2 +-
 drivers/clk/mediatek/clk-mt6735-apmixedsys.c |  4 ++--
 drivers/clk/mediatek/clk-mt6765.c            |  2 +-
 drivers/clk/mediatek/clk-mt6779.c            |  2 +-
 drivers/clk/mediatek/clk-mt6795-apmixedsys.c |  2 +-
 drivers/clk/mediatek/clk-mt6797.c            |  2 +-
 drivers/clk/mediatek/clk-mt7622-apmixedsys.c |  2 +-
 drivers/clk/mediatek/clk-mt7629.c            |  2 +-
 drivers/clk/mediatek/clk-mt7981-apmixed.c    |  2 +-
 drivers/clk/mediatek/clk-mt7986-apmixed.c    |  2 +-
 drivers/clk/mediatek/clk-mt7988-apmixed.c    |  2 +-
 drivers/clk/mediatek/clk-mt8135-apmixedsys.c |  3 ++-
 drivers/clk/mediatek/clk-mt8167-apmixedsys.c |  2 +-
 drivers/clk/mediatek/clk-mt8173-apmixedsys.c | 14 +++++++-------
 drivers/clk/mediatek/clk-mt8183-apmixedsys.c |  2 +-
 drivers/clk/mediatek/clk-mt8186-apmixedsys.c |  2 +-
 drivers/clk/mediatek/clk-mt8188-apmixedsys.c |  2 +-
 drivers/clk/mediatek/clk-mt8192-apmixedsys.c |  2 +-
 drivers/clk/mediatek/clk-mt8195-apmixedsys.c |  2 +-
 drivers/clk/mediatek/clk-mt8195-apusys_pll.c |  3 ++-
 drivers/clk/mediatek/clk-mt8196-apmixedsys.c |  3 ++-
 drivers/clk/mediatek/clk-mt8196-mcu.c        |  2 +-
 drivers/clk/mediatek/clk-mt8196-mfg.c        |  5 +++--
 drivers/clk/mediatek/clk-mt8196-vlpckgen.c   |  2 +-
 drivers/clk/mediatek/clk-mt8365-apmixedsys.c |  2 +-
 drivers/clk/mediatek/clk-mt8516-apmixedsys.c |  2 +-
 drivers/clk/mediatek/clk-pll.c               | 19 +++++++++++++------
 drivers/clk/mediatek/clk-pll.h               | 11 +++++++----
 drivers/clk/mediatek/clk-pllfh.c             | 13 ++++++++-----
 drivers/clk/mediatek/clk-pllfh.h             |  2 +-
 32 files changed, 81 insertions(+), 51 deletions(-)
---
base-commit: adff43957b0d8b9f6ad0e1b1f6daa7136f9ffbef
change-id: 20250929-mtk-pll-rpm-bf28192dd016

Best regards,
-- 
Nicolas Frattaroli <nicolas.frattaroli@collabora.com>


