Return-Path: <linux-kernel+bounces-848779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65129BCE8E0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 22:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDDD819E1F21
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 20:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98573302CC7;
	Fri, 10 Oct 2025 20:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="h+zme0Ul"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E994277CB6;
	Fri, 10 Oct 2025 20:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760129289; cv=pass; b=Rt1IT9bZG69NxbRKh07enabdINwpJRAoDCcyIj/6496STFw8JX2H6uw/9kbtU1unMHHsTfTs+/dViSoXqEw6MQdqjQ5Wml/yk2Yo5CJDx4oMdGBgqMjFEsxa+6cilR1SWg90Sn2yEBZyvsjax/jW1QW1uHAlg2+bMzj6LWKAFD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760129289; c=relaxed/simple;
	bh=NmIUOt0rEOZ3PnRMcnQvX8xxxltSEUHm41Vx+veMZTI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tYMONjfz+gwd2y6valMxLnl2Dbz7X+UQ8TVZcirB5XATyNhnp6EYTwqquH0fzTIMeZWwFcj5vEpDjJudS2+gazJrzEWp8FBKPRRth7Esn9VmaBWIFxwOJhHoCtBmnBualVoZ08PY6hPs1ekDtxTlb2+RSxNM6IAHiomfMlCSKNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=h+zme0Ul; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1760129259; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=VZKHggyeABU3OGJAI+4LuoXOGqkYDuAm1YJp6szH5n75aeas9pNF+HpPbQHKZNoVfjJ9fmLcy7696RnNxYA6ps+ZWViQkQpIUBqpKcoYJMoE7FIEx2MCSJ9sAdcAOasWtSVBX/n4Nxj+tTA4MyKYQ7DndrbjzfhyGiCvMR7hUKY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760129259; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=sBsztCZvN1TwT/rBOoE+/nHWNkGvyC+G21JWeCvj0sc=; 
	b=WKgcd7d6HVGg90RC6R2W+zKwt6E0M/sp8EkH3POPcMeVJ4ETif/6L+KVgqsukfgtfTPD3oiscj7fhghvfmvMvyq44clmrGhMFUOApV9bCbJiFyu+Pj7+cyUlALVRYjgJPInyqI7zo36jGxjVahiP9lvDLtV94ltEG1Hg0/xE840=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760129259;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
	bh=sBsztCZvN1TwT/rBOoE+/nHWNkGvyC+G21JWeCvj0sc=;
	b=h+zme0UlaJTT9vfP76h00AELrCLEoUA/LaEQhlBYdFdn7OQv0trJU+bt+YWMapRa
	Q/pvgD4UayDlZsswNpXZJatfpHAyfjFTXh2pJVFRr5FlDki03lDRBAW2/h5+DAuaOM3
	0iLGIu4QtG6y+r3KCUx23JVIbIJ748jATm5TLeas=
Received: by mx.zohomail.com with SMTPS id 1760129258257217.68746607756066;
	Fri, 10 Oct 2025 13:47:38 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: [PATCH v3 0/5] MediaTek PLL Refactors and Fixes
Date: Fri, 10 Oct 2025 22:47:08 +0200
Message-Id: <20251010-mtk-pll-rpm-v3-0-fb1bd15d734a@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMxw6WgC/23O0Q6CIBTG8VdxXHfagVLAq96jdaFyKpaKAbla8
 91D29pqXX5sv//hyQJ5S4GV2ZN5Gm2wrk9js8pYc676E4E1aTOBIkctNHTxAkPbgh86qI9CcS2
 MQV6wJAZPR3tfavvDe3u63lI0vh9ZXQWCxnWdjWXW0z3CHOaIis3gbEN0/rH8ZuSL+Ht45ICw1
 fmWSymVVGbXuLatauerdaovrVF8/Nz/9iJ5LpEMFlrlBf76aZpeXo2U/xsBAAA=
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
 linux-mediatek@lists.infradead.org, 
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
Changes in v3:
- Make device_node forward declaration a device forward declaration
- Remove forward declarations of struct clk_ops and struct
  clk_hw_onecell_data. (clk-provider.h include remains as it's needed
  for a complete type of clk_hw)
- Move PLL_PARENT_EN flag to individual mfgpll definitions.
- Link to v2: https://lore.kernel.org/r/20251008-mtk-pll-rpm-v2-0-170ed0698560@collabora.com

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
 drivers/clk/mediatek/clk-mt8196-mfg.c        | 15 ++++++++-------
 drivers/clk/mediatek/clk-mt8196-vlpckgen.c   |  2 +-
 drivers/clk/mediatek/clk-mt8365-apmixedsys.c |  2 +-
 drivers/clk/mediatek/clk-mt8516-apmixedsys.c |  2 +-
 drivers/clk/mediatek/clk-pll.c               | 19 +++++++++++++------
 drivers/clk/mediatek/clk-pll.h               | 15 ++++++++-------
 drivers/clk/mediatek/clk-pllfh.c             | 13 ++++++++-----
 drivers/clk/mediatek/clk-pllfh.h             |  2 +-
 32 files changed, 87 insertions(+), 59 deletions(-)
---
base-commit: adff43957b0d8b9f6ad0e1b1f6daa7136f9ffbef
change-id: 20250929-mtk-pll-rpm-bf28192dd016

Best regards,
-- 
Nicolas Frattaroli <nicolas.frattaroli@collabora.com>


