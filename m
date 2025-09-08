Return-Path: <linux-kernel+bounces-806411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18ADDB49671
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 19:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B93A617F68D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 17:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07013112D0;
	Mon,  8 Sep 2025 17:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LQCS373Q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F1831076B
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 17:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757351015; cv=none; b=jhBzfKyWd+Pji5HJ/GyIIha6us9flPVfPRBfIjxPCBaYOYY9+cHPwmRU4gCfnG/xb6D7Qyq7kjKI0RNf84w+0XdzJscV49cTiphif8Fvw9n7DjOM2900Ap9m/omaazU8R0T4PLhMvDvDA1j3VJxBbTn5ivsiGFuUPSc+K6amT4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757351015; c=relaxed/simple;
	bh=JJIr3JwYEtKqE16T02EZabF0YR19DxvTE/IO00zGvoU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ANslgZYxdBNmnwDhF+S4asXK++rU0aZO1JodLe4lVfhFqje0Twq2UiqbmT7pWjz6CAaTnpL0m+lhBj9Uy/FcKuFcZbHuLT89dk9KjdqUCjE3t9R5XgVPkqEFkFdBJKUe95syFtAlmBv8eHVd2S4gQoUY9guwHzZnlP9SzvVE6WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LQCS373Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757351012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=ku9lHQ5wnd38C2w2Bh5v+T3nc+j/8Ar4Coslasv/eiE=;
	b=LQCS373QEJCLQqybLOsVU5HLm7d+FEEtEDfZLiJZtLzzLBZpFfLuIgiuXehu8JkHNjd9h4
	TK/XF/FJRHKxAafeHPPl2v4HCAMdn7OjARR3eA9BYkAb/Ef/K8aBItk4jrlTBvdinjpHAH
	j56rUDlj88tYAJqPcHmiZSV5Qg8UMfQ=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-4rZtPVXxMhGocsMBZ1T1TQ-1; Mon, 08 Sep 2025 13:03:31 -0400
X-MC-Unique: 4rZtPVXxMhGocsMBZ1T1TQ-1
X-Mimecast-MFC-AGG-ID: 4rZtPVXxMhGocsMBZ1T1TQ_1757351011
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-7131866cdceso139896386d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 10:03:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757351010; x=1757955810;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ku9lHQ5wnd38C2w2Bh5v+T3nc+j/8Ar4Coslasv/eiE=;
        b=qG+yN7KyM0Ln1Er9lkb1yXn7cO69Le/qGODkhHG1QE5V9GTXxUby9zxFycePr8IYH9
         JcrDtIAiiy0v923qlWIrUVs9vO5Gg82xDaTwxJtrON5Z6V4A/kyTicWytKtXM2Ufrv/9
         Cxpa0y6gp59X1MPKMPrAFnAR767BDovqEra1TL94oWgPAT1bj7IVS9Nn76yDHolRQ2Fc
         1UnK5JX1xiOu+3q+eKmqYxrjA7V4p77M9hogk2AFTnpxkNNS50S61ZqZklFSf6yiOLNl
         Qz9gNYcas6pqy/xK1Pb8NqMGYO6q56VCAxwB7X0/uZRsUh85El8sDyV8gZogw/pLURET
         6Vhw==
X-Forwarded-Encrypted: i=1; AJvYcCUAR9Klyvwfp/EKtusDjwFZ4knDO2vovVlNflnjVkkDC/iCsuIRfR74f2xLf01MxgkUFF13HWFYLOia8s0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUZDcElkQX0P1U0ep6f9Upe3lfPnRNTap4/v9GqhUl6Axq9i5e
	HsxwphOIf1G8p2Izzyp+7ZGVuAH1Dor7OHQuX2rwGYJq+1RadQPvT8bbX1UhhclFF0do7vKtbsO
	+6Vd3wubsLXcf6Vp5ZRPjG+bY8sJfrS3OCcsmpvmC4ChPfg7yPba/mgPY6ZbkOTvuHdsVjKR3dw
	==
X-Gm-Gg: ASbGncsMpBZWD1DwlnylmM6DuqZ22EIousN/lZhnIzabQiA2/WdfcThB/JfYC5USp+6
	ZpmOzDVfwYeSLTnHYxGNCJGm3E6uLeDDi6DZNbM9oydUMoOYsdTuZq0/NCqCiBdrNuoLnaW8I+t
	aird+Ol5Z7FpBV4UUPQyXKntn0QbXbohsfk/nHEss2WmtHHBYPOsGcJ+QRnoYw947Z/VtZ7SWnL
	oXGgsCHCOlQ+ZkC/ld/SPIXSbcVQDBU41XeuG4weY8pO5gWgoCHP4CkTj15k7UwjDTANqSyoHo/
	IcTxa4YwwRU98Z+ZQvo78Cx3Nh0vivnkbmK8yArPyem2J13jXV0lX93+sRs=
X-Received: by 2002:ad4:5f0f:0:b0:729:aa08:11f5 with SMTP id 6a1803df08f44-7394587e3b9mr89697796d6.64.1757351009240;
        Mon, 08 Sep 2025 10:03:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEix7nqXddcKWoFcqVO4KxiHdmCZGt+msyK3STl1lYxkH3shx6yyyabMgOnrkx1AHu0EleDow==
X-Received: by 2002:ad4:5f0f:0:b0:729:aa08:11f5 with SMTP id 6a1803df08f44-7394587e3b9mr89697186d6.64.1757351008401;
        Mon, 08 Sep 2025 10:03:28 -0700 (PDT)
Received: from x1 ([2600:382:8507:870e:b6f8:ee72:4f09:a16a])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-72ff98c3ef2sm71509746d6.60.2025.09.08.10.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 10:03:27 -0700 (PDT)
Date: Mon, 8 Sep 2025 13:03:25 -0400
From: Brian Masney <bmasney@redhat.com>
To: Stephen Boyd <sboyd@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	Maxime Ripard <mripard@kernel.org>
Subject: [GIT PULL] clk: convert drivers from deprecated round_rate() to
 determine_rate() for v6.18
Message-ID: <aL8MXYrR5uoBa4cB@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.2.14 (2025-02-20)

Hi Stephen and Michael,

Given the large number of patches that I have posted for the
round_rate() to determine_rate() conversion, and to avoid spamming
large numbers of people's inboxes where a v2 was needed on only a few
patches in a series with 114 patches, I submitted a v2 for only the
patches that needed it. Additionally, some of the other patches in the
large series have already been picked up by some of the clk
submaintainers, so should be excluded as well. This makes it more
complicated to merge everything, so I collected the most recent
versions of the conversion work for drivers/clk using the following b4
commands:

    MAILDIR=$(mktemp -d)
    b4 am -o "${MAILDIR}" --cherry-pick 1-1,3-3,5-8 \
            20250828-clk-round-rate-v2-v1-0-b97ec8ba6cc4@redhat.com
    b4 am -o "${MAILDIR}" \
            --cherry-pick 1-37,39-47,52-63,65-67,69-89,91-91,94-94,96-96,100-111,114-114 \
            20250811-clk-for-stephen-round-rate-v1-0-b3bf97b038dc@redhat.com
    b4 am -o "${MAILDIR}" \
            20250903-clk-tegra-round-rate-v2-v2-0-3126d321d4e4@redhat.com
    b4 am -o "${MAILDIR}" \
            20250811-b4-clk-ti-round-rate-v1-0-cc0840594a49@redhat.com
    b4 am -o "${MAILDIR}" \
            20250827-clk-scmi-round-rate-v2-1-3782a50835ed@redhat.com
    
    git am "${MAILDIR}"/20250828_bmasney_clk_convert_drivers_from_deprecated_round_rate_to_determine_rate.mbx
    git am "${MAILDIR}"/20250811_bmasney_clk_convert_drivers_from_deprecated_round_rate_to_determine_rate.mbx
    git am "${MAILDIR}"/v2_20250903_bmasney_clk_tegra_convert_from_clk_round_rate_to_determine_rate.mbx
    git am "${MAILDIR}"/20250811_bmasney_clk_ti_convert_from_clk_round_rate_to_determine_rate.mbx
    git am "${MAILDIR}"/v2_20250827_bmasney_clk_scmi_migrate_round_rate_to_determine_rate.mbx

Additionally I included the patch series for drivers/clk/ti and
drivers/clk/tegra since this is all related work.

Note the v2 clk/tegra series that I posted mistakenly had extra Link
tags added when I posted them to the mailinglist. I dropped the Link
tag for these commits so that those tags don't appear in the git history
in Linus's tree.


The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  https://github.com/masneyb/linux tags/clk-round-rate-6.18

for you to fetch changes up to 80cb2b6edd8368f7e1e8bf2f66aabf57aa7de4b7:

  clk: scmi: migrate round_rate() to determine_rate() (2025-09-08 12:50:56 -0400)

----------------------------------------------------------------
The round_rate() clk ops is deprecated in the clk framework in favor
of the determine_rate() clk ops, so let's go ahead and convert the
various clk drivers using the Coccinelle semantic patch posted below.
I did some minor cosmetic cleanups of the code in some cases.

Coccinelle semantic patch:

    virtual patch

    // Look up the current name of the round_rate function
    @ has_round_rate @
    identifier round_rate_name =~ ".*_round_rate";
    identifier hw_param, rate_param, parent_rate_param;
    @@

    long round_rate_name(struct clk_hw *hw_param, unsigned long rate_param,
                  unsigned long *parent_rate_param)
    {
        ...
    }

    // Rename the route_rate function name to determine_rate()
    @ script:python generate_name depends on has_round_rate @
    round_rate_name << has_round_rate.round_rate_name;
    new_name;
    @@

    coccinelle.new_name = round_rate_name.replace("_round_rate", "_determine_rate")

    // Change rate to req->rate; also change occurrences of 'return XXX'.
    @ chg_rate depends on generate_name @
    identifier has_round_rate.round_rate_name;
    identifier has_round_rate.hw_param;
    identifier has_round_rate.rate_param;
    identifier has_round_rate.parent_rate_param;
    identifier ERR =~ "E.*";
    expression E;
    @@

    long round_rate_name(struct clk_hw *hw_param, unsigned long rate_param,
                  unsigned long *parent_rate_param)
    {
    <...
    (
    -return -ERR;
    +return -ERR;
    |
    - return rate_param;
    + return 0;
    |
    - return E;
    + req->rate = E;
    +
    + return 0;
    |
    - rate_param
    + req->rate
    )
    ...>
    }

    // Coccinelle only transforms the first occurrence of the rate parameter
    // Run a second time. FIXME: Is there a better way to do this?
    @ chg_rate2 depends on generate_name @
    identifier has_round_rate.round_rate_name;
    identifier has_round_rate.hw_param;
    identifier has_round_rate.rate_param;
    identifier has_round_rate.parent_rate_param;
    @@

    long round_rate_name(struct clk_hw *hw_param, unsigned long rate_param,
                  unsigned long *parent_rate_param)
    {
    <...
    - rate_param
    + req->rate
    ...>
    }

    // Change parent_rate to req->best_parent_rate
    @ chg_parent_rate depends on generate_name @
    identifier has_round_rate.round_rate_name;
    identifier has_round_rate.hw_param;
    identifier has_round_rate.rate_param;
    identifier has_round_rate.parent_rate_param;
    @@

    long round_rate_name(struct clk_hw *hw_param, unsigned long rate_param,
                  unsigned long *parent_rate_param)
    {
    <...
    (
    - *parent_rate_param
    + req->best_parent_rate
    |
    - parent_rate_param
    + &req->best_parent_rate
    )
    ...>
    }

    // Convert the function definition from round_rate() to determine_rate()
    @ func_definition depends on chg_rate @
    identifier has_round_rate.round_rate_name;
    identifier has_round_rate.hw_param;
    identifier has_round_rate.rate_param;
    identifier has_round_rate.parent_rate_param;
    identifier generate_name.new_name;
    @@

    - long round_rate_name(struct clk_hw *hw_param, unsigned long rate_param,
    -               unsigned long *parent_rate_param)
    + int new_name(struct clk_hw *hw, struct clk_rate_request *req)
    {
        ...
    }

    // Update the ops from round_rate() to determine_rate()
    @ ops depends on func_definition @
    identifier has_round_rate.round_rate_name;
    identifier generate_name.new_name;
    @@

    {
        ...,
    -   .round_rate = round_rate_name,
    +   .determine_rate = new_name,
        ...,
    }

Note that I used coccinelle 1.2 instead of 1.3 since the newer version
adds unnecessary braces as described in this post.
https://lore.kernel.org/cocci/67642477-5f3e-4b2a-914d-579a54f48cbd@intel.com/

----------------------------------------------------------------
Brian Masney (118):
      clk: nxp: lpc32xx: convert from round_rate() to determine_rate()
      clk: rockchip: half-divider: convert from round_rate() to determine_rate()
      clk: sophgo: sg2042-clkgen: convert from round_rate() to determine_rate()
      clk: sophgo: sg2042-pll: remove round_rate() in favor of determine_rate()
      clk: x86: cgu: convert from round_rate() to determine_rate()
      clk: zynqmp: divider: convert from round_rate() to determine_rate()
      clk: at91: peripheral: fix return value
      clk: at91: peripheral: convert from round_rate() to determine_rate()
      clk: fixed-factor: add determine_rate() ops
      clk: at91: audio-pll: convert from round_rate() to determine_rate()
      clk: at91: h32mx: convert from round_rate() to determine_rate()
      clk: at91: pll: convert from round_rate() to determine_rate()
      clk: at91: plldiv: convert from round_rate() to determine_rate()
      clk: at91: sam9x60-pll: convert from round_rate() to determine_rate()
      clk: at91: usb: convert from round_rate() to determine_rate()
      clk: baikal-t1: ccu-div: convert from round_rate() to determine_rate()
      clk: baikal-t1: ccu-pll: convert from round_rate() to determine_rate()
      clk: cdce925: convert from round_rate() to determine_rate()
      clk: cs2000-cp: convert from round_rate() to determine_rate()
      clk: ep93xx: convert from round_rate() to determine_rate()
      clk: fractional-divider: convert from round_rate() to determine_rate()
      clk: gemini: convert from round_rate() to determine_rate()
      clk: highbank: convert from round_rate() to determine_rate()
      clk: hisilicon: clkdivider-hi6220: convert from round_rate() to determine_rate()
      clk: hisilicon: hi3660-stub: move comma from declaration of DEFINE_CLK_STUB()
      clk: hisilicon: hi3660-stub: convert from round_rate() to determine_rate()
      clk: hisilicon: hi6220-stub: convert from round_rate() to determine_rate()
      clk: ingenic: cgu: convert from round_rate() to determine_rate()
      clk: ingenic: jz4780-cgu: convert from round_rate() to determine_rate()
      clk: ingenic: x1000-cgu: convert from round_rate() to determine_rate()
      clk: lmk04832: convert from round_rate() to determine_rate()
      clk: loongson1: convert from round_rate() to determine_rate()
      clk: max9485: convert from round_rate() to determine_rate()
      clk: milbeaut: convert from round_rate() to determine_rate()
      clk: mmp: audio: convert from round_rate() to determine_rate()
      clk: mmp: frac: convert from round_rate() to determine_rate()
      clk: multiplier: convert from round_rate() to determine_rate()
      clk: mxs: div: convert from round_rate() to determine_rate()
      clk: mxs: frac: convert from round_rate() to determine_rate()
      clk: mxs: ref: convert from round_rate() to determine_rate()
      clk: nuvoton: ma35d1-divider: convert from round_rate() to determine_rate()
      clk: nuvoton: ma35d1-pll: convert from round_rate() to determine_rate()
      clk: nxp: lpc18xx-cgu: convert from round_rate() to determine_rate()
      clk: pistachio: pll: convert from round_rate() to determine_rate()
      clk: scpi: convert from round_rate() to determine_rate()
      clk: si514: convert from round_rate() to determine_rate()
      clk: si521xx: convert from round_rate() to determine_rate()
      clk: si5341: convert from round_rate() to determine_rate()
      clk: si544: convert from round_rate() to determine_rate()
      clk: si570: convert from round_rate() to determine_rate()
      clk: sifive: sifive-prci: convert from round_rate() to determine_rate()
      clk: sophgo: cv18xx-ip: convert from round_rate() to determine_rate()
      clk: sparx5: convert from round_rate() to determine_rate()
      clk: sprd: div: convert from round_rate() to determine_rate()
      clk: sprd: pll: convert from round_rate() to determine_rate()
      clk: st: clkgen-fsyn: convert from round_rate() to determine_rate()
      clk: st: clkgen-pll: convert from round_rate() to determine_rate()
      clk: stm32f4: convert from round_rate() to determine_rate()
      clk: stm32: stm32-core: convert from round_rate() to determine_rate()
      clk: stm32: stm32mp1: convert from round_rate() to determine_rate()
      clk: tps68470: convert from round_rate() to determine_rate()
      clk: versaclock3: convert from round_rate() to determine_rate()
      clk: vt8500: convert from round_rate() to determine_rate()
      clk: wm831x: convert from round_rate() to determine_rate()
      clk: xgene: convert from round_rate() to determine_rate()
      clk: xilinx: xlnx-clock-wizard: convert from round_rate() to determine_rate()
      clk: xilinx: xlnx_vcu: convert from round_rate() to determine_rate()
      clk: zynqmp: pll: convert from round_rate() to determine_rate()
      clk: zynq: pll: convert from round_rate() to determine_rate()
      clk: actions: owl-composite: convert from round_rate() to determine_rate()
      clk: actions: owl-divider: convert from round_rate() to determine_rate()
      clk: actions: owl-factor: convert from round_rate() to determine_rate()
      clk: actions: owl-pll: convert from round_rate() to determine_rate()
      clk: apple-nco: convert from round_rate() to determine_rate()
      clk: axs10x: i2s_pll_clock: convert from round_rate() to determine_rate()
      clk: axs10x: pll_clock: convert from round_rate() to determine_rate()
      clk: bcm: iproc-asiu: convert from round_rate() to determine_rate()
      clk: bm1880: convert from round_rate() to determine_rate()
      clk: cdce706: convert from round_rate() to determine_rate()
      clk: hsdk-pll: convert from round_rate() to determine_rate()
      clk: mediatek: pll: convert from round_rate() to determine_rate()
      clk: microchip: core: convert from round_rate() to determine_rate()
      clk: mstar: msc313-cpupll: convert from round_rate() to determine_rate()
      clk: mvebu: ap-cpu-clk: convert from round_rate() to determine_rate()
      clk: mvebu: armada-37xx-periph: convert from round_rate() to determine_rate()
      clk: mvebu: corediv: convert from round_rate() to determine_rate()
      clk: mvebu: cpu: convert from round_rate() to determine_rate()
      clk: mvebu: dove-divider: convert from round_rate() to determine_rate()
      clk: qcom: regmap-divider: convert from round_rate() to determine_rate()
      clk: rockchip: ddr: convert from round_rate() to determine_rate()
      clk: rockchip: pll: convert from round_rate() to determine_rate()
      clk: sp7021: convert from round_rate() to determine_rate()
      clk: spear: aux-synth: convert from round_rate() to determine_rate()
      clk: spear: frac-synth: convert from round_rate() to determine_rate()
      clk: spear: gpt-synth: convert from round_rate() to determine_rate()
      clk: spear: vco-pll: convert from round_rate() to determine_rate()
      clk: ux500: prcmu: convert from round_rate() to determine_rate()
      clk: versaclock5: convert from round_rate() to determine_rate()
      clk: versaclock7: convert from round_rate() to determine_rate()
      clk: versatile: icst: convert from round_rate() to determine_rate()
      clk: versatile: vexpress-osc: convert from round_rate() to determine_rate()
      clk: visconti: pll: convert from round_rate() to determine_rate()
      clk: divider: remove round_rate() in favor of determine_rate()
      clk: fixed-factor: drop round_rate() clk ops
      clk: tegra: audio-sync: convert from round_rate() to determine_rate()
      clk: tegra: divider: convert from round_rate() to determine_rate()
      clk: tegra: periph: divider: convert from round_rate() to determine_rate()
      clk: tegra: pll: convert from round_rate() to determine_rate()
      clk: tegra: super: convert from round_rate() to determine_rate()
      clk: tegra: tegra210-emc: convert from round_rate() to determine_rate()
      clk: ti: dpll: remove round_rate() in favor of determine_rate()
      clk: ti: dpll: change error return from ~0 to -EINVAL
      clk: ti: dpll: convert from round_rate() to determine_rate()
      clk: ti: composite: convert from round_rate() to determine_rate()
      clk: ti: divider: convert from round_rate() to determine_rate()
      clk: ti: dra7-atl: convert from round_rate() to determine_rate()
      clk: ti: fapll: convert from round_rate() to determine_rate()
      clk: scmi: migrate round_rate() to determine_rate()

 drivers/clk/actions/owl-composite.c        |  8 +--
 drivers/clk/actions/owl-divider.c          | 13 +++--
 drivers/clk/actions/owl-factor.c           | 12 ++--
 drivers/clk/actions/owl-pll.c              | 25 ++++++---
 drivers/clk/at91/clk-audio-pll.c           | 42 +++++++-------
 drivers/clk/at91/clk-h32mx.c               | 33 +++++++----
 drivers/clk/at91/clk-peripheral.c          | 48 +++++++++-------
 drivers/clk/at91/clk-pll.c                 | 12 ++--
 drivers/clk/at91/clk-plldiv.c              | 34 ++++++++----
 drivers/clk/at91/clk-sam9x60-pll.c         | 29 ++++++----
 drivers/clk/at91/clk-usb.c                 | 20 ++++---
 drivers/clk/axs10x/i2s_pll_clock.c         | 14 ++---
 drivers/clk/axs10x/pll_clock.c             | 12 ++--
 drivers/clk/baikal-t1/ccu-div.c            | 27 +++++----
 drivers/clk/baikal-t1/ccu-pll.c            | 14 +++--
 drivers/clk/bcm/clk-iproc-asiu.c           | 25 +++++----
 drivers/clk/clk-apple-nco.c                | 14 +++--
 drivers/clk/clk-bm1880.c                   | 21 ++++---
 drivers/clk/clk-cdce706.c                  | 16 +++---
 drivers/clk/clk-cdce925.c                  | 50 ++++++++++-------
 drivers/clk/clk-cs2000-cp.c                | 14 +++--
 drivers/clk/clk-divider.c                  | 23 --------
 drivers/clk/clk-ep93xx.c                   | 18 +++---
 drivers/clk/clk-fixed-factor.c             | 16 +++---
 drivers/clk/clk-fractional-divider.c       | 25 ++++++---
 drivers/clk/clk-gemini.c                   | 15 +++--
 drivers/clk/clk-highbank.c                 | 26 +++++----
 drivers/clk/clk-hsdk-pll.c                 | 12 ++--
 drivers/clk/clk-lmk04832.c                 | 53 ++++++++++--------
 drivers/clk/clk-loongson1.c                | 12 ++--
 drivers/clk/clk-max9485.c                  | 27 +++++----
 drivers/clk/clk-milbeaut.c                 | 22 +++++---
 drivers/clk/clk-multiplier.c               | 12 ++--
 drivers/clk/clk-scmi.c                     | 35 ++++++------
 drivers/clk/clk-scpi.c                     | 18 +++---
 drivers/clk/clk-si514.c                    | 24 +++++---
 drivers/clk/clk-si521xx.c                  | 14 +++--
 drivers/clk/clk-si5341.c                   | 22 +++++---
 drivers/clk/clk-si544.c                    | 10 ++--
 drivers/clk/clk-si570.c                    | 24 +++++---
 drivers/clk/clk-sp7021.c                   | 22 ++++----
 drivers/clk/clk-sparx5.c                   | 10 ++--
 drivers/clk/clk-stm32f4.c                  | 26 +++++----
 drivers/clk/clk-tps68470.c                 | 12 ++--
 drivers/clk/clk-versaclock3.c              | 70 +++++++++++++----------
 drivers/clk/clk-versaclock5.c              | 71 +++++++++++++-----------
 drivers/clk/clk-versaclock7.c              | 30 ++++++----
 drivers/clk/clk-vt8500.c                   | 59 ++++++++++++--------
 drivers/clk/clk-wm831x.c                   | 14 +++--
 drivers/clk/clk-xgene.c                    | 41 ++++++++------
 drivers/clk/hisilicon/clk-hi3660-stub.c    | 18 +++---
 drivers/clk/hisilicon/clk-hi6220-stub.c    | 12 ++--
 drivers/clk/hisilicon/clkdivider-hi6220.c  | 12 ++--
 drivers/clk/ingenic/cgu.c                  | 12 ++--
 drivers/clk/ingenic/jz4780-cgu.c           | 24 ++++----
 drivers/clk/ingenic/x1000-cgu.c            | 19 ++++---
 drivers/clk/mediatek/clk-pll.c             | 13 +++--
 drivers/clk/mediatek/clk-pll.h             |  3 +-
 drivers/clk/mediatek/clk-pllfh.c           |  2 +-
 drivers/clk/microchip/clk-core.c           | 44 +++++++++------
 drivers/clk/mmp/clk-audio.c                | 18 +++---
 drivers/clk/mmp/clk-frac.c                 | 27 ++++-----
 drivers/clk/mstar/clk-msc313-cpupll.c      | 18 +++---
 drivers/clk/mvebu/ap-cpu-clk.c             | 12 ++--
 drivers/clk/mvebu/armada-37xx-periph.c     | 15 +++--
 drivers/clk/mvebu/clk-corediv.c            | 18 +++---
 drivers/clk/mvebu/clk-cpu.c                | 12 ++--
 drivers/clk/mvebu/dove-divider.c           | 16 +++---
 drivers/clk/mxs/clk-div.c                  |  8 +--
 drivers/clk/mxs/clk-frac.c                 | 16 +++---
 drivers/clk/mxs/clk-ref.c                  | 16 +++---
 drivers/clk/nuvoton/clk-ma35d1-divider.c   | 12 ++--
 drivers/clk/nuvoton/clk-ma35d1-pll.c       | 28 ++++++----
 drivers/clk/nxp/clk-lpc18xx-cgu.c          | 16 +++---
 drivers/clk/nxp/clk-lpc32xx.c              | 59 +++++++++++---------
 drivers/clk/pistachio/clk-pll.c            | 20 ++++---
 drivers/clk/qcom/clk-regmap-divider.c      | 27 +++++----
 drivers/clk/rockchip/clk-ddr.c             | 13 +++--
 drivers/clk/rockchip/clk-half-divider.c    | 12 ++--
 drivers/clk/rockchip/clk-pll.c             | 23 +++++---
 drivers/clk/sifive/fu540-prci.h            |  2 +-
 drivers/clk/sifive/fu740-prci.h            |  2 +-
 drivers/clk/sifive/sifive-prci.c           | 11 ++--
 drivers/clk/sifive/sifive-prci.h           |  4 +-
 drivers/clk/sophgo/clk-cv18xx-ip.c         | 10 ++--
 drivers/clk/sophgo/clk-sg2042-clkgen.c     | 17 +++---
 drivers/clk/sophgo/clk-sg2042-pll.c        | 26 +++------
 drivers/clk/spear/clk-aux-synth.c          | 12 ++--
 drivers/clk/spear/clk-frac-synth.c         | 12 ++--
 drivers/clk/spear/clk-gpt-synth.c          | 12 ++--
 drivers/clk/spear/clk-vco-pll.c            | 23 +++++---
 drivers/clk/sprd/div.c                     | 13 +++--
 drivers/clk/sprd/pll.c                     |  8 +--
 drivers/clk/st/clkgen-fsyn.c               | 33 +++++------
 drivers/clk/st/clkgen-pll.c                | 38 +++++++------
 drivers/clk/stm32/clk-stm32-core.c         | 28 ++++++----
 drivers/clk/stm32/clk-stm32mp1.c           | 13 +++--
 drivers/clk/tegra/clk-audio-sync.c         | 10 ++--
 drivers/clk/tegra/clk-divider.c            | 28 ++++++----
 drivers/clk/tegra/clk-periph.c             |  8 +--
 drivers/clk/tegra/clk-pll.c                | 52 ++++++++++-------
 drivers/clk/tegra/clk-super.c              |  9 +--
 drivers/clk/tegra/clk-tegra210-emc.c       | 24 +++++---
 drivers/clk/ti/clk-dra7-atl.c              | 12 ++--
 drivers/clk/ti/clkt_dpll.c                 | 36 ++++++------
 drivers/clk/ti/clock.h                     |  6 +-
 drivers/clk/ti/composite.c                 |  6 +-
 drivers/clk/ti/divider.c                   | 12 ++--
 drivers/clk/ti/dpll.c                      | 10 +---
 drivers/clk/ti/dpll3xxx.c                  |  7 ++-
 drivers/clk/ti/dpll44xx.c                  | 89 +++++++++++-------------------
 drivers/clk/ti/fapll.c                     | 48 +++++++++-------
 drivers/clk/ux500/clk-prcmu.c              | 14 +++--
 drivers/clk/versatile/clk-icst.c           | 72 +++++++++++++++---------
 drivers/clk/versatile/clk-vexpress-osc.c   | 16 +++---
 drivers/clk/visconti/pll.c                 | 17 ++++--
 drivers/clk/x86/clk-cgu.c                  | 35 +++++++-----
 drivers/clk/xilinx/clk-xlnx-clock-wizard.c | 55 +++++++++---------
 drivers/clk/xilinx/xlnx_vcu.c              | 15 +++--
 drivers/clk/zynq/pll.c                     | 12 ++--
 drivers/clk/zynqmp/divider.c               | 23 ++++----
 drivers/clk/zynqmp/pll.c                   | 24 ++++----
 include/linux/clk/ti.h                     |  8 +--
 123 files changed, 1518 insertions(+), 1185 deletions(-)


