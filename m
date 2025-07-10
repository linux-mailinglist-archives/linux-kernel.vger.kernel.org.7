Return-Path: <linux-kernel+bounces-726252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E284AB00A1E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 19:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEE991C42969
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 17:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3D42F0C74;
	Thu, 10 Jul 2025 17:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JNgUuJ/p"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336CE279DB6
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 17:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752169402; cv=none; b=rgGGyjaK4uwdcgazDR8AUjGRnCeFf8esZdzeRcQ29zNMk9bJO+d5WyK4Yg5Vc2xg7OlizpJt0dsXWgu0M5fWX+ZoMjSnzUBBtO0CAlJx5UP+1bYt+XNNqk7Hg9wyzAQxMcrEN8dW84zspdy1jmKsWuhI+7x+V0evM7Xuj6Baizk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752169402; c=relaxed/simple;
	bh=vneJkQuL/Z9KZYxCdcdDpCorNOqE4VZX51RmlX/8Hik=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ekEQOE8Jg3JXu5J9er8Rza1LIeA8R9fPDMGi1jT3Y16bkuot1h7AZK5EFxjLkmO7q2mnoVWfIrmwtICU/NAwv8V9mhIRyWWy5YP8CaYBCdgSVm5YZ919cKcruU9UEoawTkIY3eO44l6WzeDTCh1WVeCTprxWnxiMGHhze1QU+Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JNgUuJ/p; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752169400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DyfQeplimHxaigWHPTIL8Brwr48uc1PFyqGCkna6oLc=;
	b=JNgUuJ/pN1gE8zcHwMvQv34MIGDKxfc8zrUimEzGwlmOgvSWxLR8U4vnUPdJHBgFV5Oe5H
	Vw0rJ2+mlcVEo2Mu5JADPmh4OV9496ZYYx8GAnGS2OcovA2HjXRFZsSfSv9Rsxx8DrkLbg
	ANNt8wH3ECjrpQk0T/uwZmCHtf704TM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-fjxfia8kOamSMHdO8t2rVQ-1; Thu, 10 Jul 2025 13:43:18 -0400
X-MC-Unique: fjxfia8kOamSMHdO8t2rVQ-1
X-Mimecast-MFC-AGG-ID: fjxfia8kOamSMHdO8t2rVQ_1752169398
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4a581009dc5so23327081cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 10:43:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752169398; x=1752774198;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DyfQeplimHxaigWHPTIL8Brwr48uc1PFyqGCkna6oLc=;
        b=nxK6IYURcRonQ720rrxM92O/PRjjmfPP95JAdjgZJRkhr2a80r5v/9HqACvsuiPeSh
         xb6e5im3OxEvu9acncSnoi+fg8iDsaBCzznx8mhA5bQUNzRVyHv7VKjk/EBSQ+shu4vx
         E/agAD6bodqzGwZaQ4De8btNgDJmHfEjSeUnsXgia/KRKfbPmqF2Xbc2JOEyPKCRHgGZ
         o7UqJBmqx3ahfIbUnxolOzvwM6huc+ow52zKdeU9pnkjcth8fb4VzD05hNTypn20kb9Y
         u7hIU/pxcRI2SX3ctRbUsF09BK9pOczcMSnUppmex19Igmi/bLazhVuB0lJAGYnz9li9
         VTVA==
X-Forwarded-Encrypted: i=1; AJvYcCVd/loDvOQXPIv70A2Rhdkn6yXJZO4+P0r/QNmEQ5larBNhw1s4z0oKzTpPr6dBNftmYJMe22XP0ZzCadU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRad3D7mmY2x+hmK1BoZni+XiB3tQHmMtcTjYbssJ5DlIGE2Cu
	8Ngy6iP8oNw9pxBp8oY92FtWrmUTMrK9+zXtbgGNPlGPzQFMzbP50fYRcZVeHysXliWLMYun4Lq
	rkiZrd5w+F6XbcAt/YA1OqZJZBjBkHFMOL0H4ApRz33HtqonWOoQT+7YjM+DNM/JQhA==
X-Gm-Gg: ASbGncttAlF0EGi38t5P9T/9Px3hh+Nptvo0RHWUUH/C/qLyr/rw9P6MMGyWQmlXdjj
	4kAp+ZrNwcZAnOzElPorfI/WohlKyLv2OQidbWKt7bZK1h3l0tTqghownjRCSbG0/22BQHHeuZu
	Gc3S+YkwM3l0mUjsuK7tuTyu+BsnoYdOA/X3IlArtWqWIj1sSg3wO5d2LKAaCSg+v8FuEeOnsnl
	5FjTKtYpWYoTPWgWfS0AbqifNCLp61+k6dC1zrMI0kq/7nqhQxyM2/oRuszCOU3/scaGbarXZNp
	BXvCB7Cya3EtFU4AzX3AUGwQ9SwZwawxN6F+ulrJ/Z6q2KOYBmpw5qOmjuBF
X-Received: by 2002:a05:622a:2587:b0:4a7:944:9af6 with SMTP id d75a77b69052e-4a9e9bb2cb6mr64645911cf.3.1752169397572;
        Thu, 10 Jul 2025 10:43:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzZd5sCbip5ZJYV/QhNlPWrkBJ+B+0jLvPSQhYSok5Gwj5HHCpjaKv310CLkZIEGxcJf2Gkg==
X-Received: by 2002:a05:622a:2587:b0:4a7:944:9af6 with SMTP id d75a77b69052e-4a9e9bb2cb6mr64645231cf.3.1752169397063;
        Thu, 10 Jul 2025 10:43:17 -0700 (PDT)
Received: from [192.168.1.3] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70497d71419sm10652876d6.86.2025.07.10.10.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 10:43:16 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Subject: [PATCH 0/9] drm: convert from clk round_rate() to determine_rate()
Date: Thu, 10 Jul 2025 13:43:01 -0400
Message-Id: <20250710-drm-clk-round-rate-v1-0-601b9ea384c3@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKX7b2gC/x2M0QpAQBAAf0X7bOuQdH5FHs7dYsPRHlKXf3d5n
 KaZCIGEKUCbRRC6OfDuExR5BnY2fiJklxhKVdaqKRQ62dCuC8p+eYdiTsIhKa2tspVpIIWH0Mj
 PP+369/0AcAOnAmQAAAA=
X-Change-ID: 20250710-drm-clk-round-rate-b25099c0c3a7
To: Philipp Zabel <p.zabel@pengutronix.de>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Yannick Fertre <yannick.fertre@foss.st.com>, 
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
 Philippe Cornu <philippe.cornu@foss.st.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Stephen Boyd <sboyd@kernel.org>
Cc: dri-devel@lists.freedesktop.org, imx@lists.linux.dev, 
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 freedreno@lists.freedesktop.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-sunxi@lists.linux.dev, Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752169393; l=5611;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=vneJkQuL/Z9KZYxCdcdDpCorNOqE4VZX51RmlX/8Hik=;
 b=SpSyr0e3I/aRNxEswleY3osHpqJj9B58Sz5Gtf7aIsUZ1Ktyc0g084VrIsjKHpCXHyL9qqOiF
 ZRnFirWq0YVBiYQPmMMBH7RCwJ87s3PvceRTEkBR4y7+BkHAKJo5Jbj
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated in the clk framework in favor
of the determine_rate() clk ops, so let's go ahead and convert the
drivers in the drm subsystem using the Coccinelle semantic patch
posted below. I did a few minor cosmetic cleanups of the code in a
few cases.

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

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
Brian Masney (9):
      drm/imx/ipuv3/imx-tve: convert from round_rate() to determine_rate()
      drm/mcde/mcde_clk_div: convert from round_rate() to determine_rate()
      drm/msm/disp/mdp4/mdp4_lvds_pll: convert from round_rate() to determine_rate()
      drm/msm/hdmi_pll_8960: convert from round_rate() to determine_rate()
      drm/pl111: convert from round_rate() to determine_rate()
      drm/stm/dw_mipi_dsi-stm: convert from round_rate() to determine_rate()
      drm/stm/lvds: convert from round_rate() to determine_rate()
      drm/sun4i/sun4i_hdmi_ddc_clk: convert from round_rate() to determine_rate()
      drm/sun4i/sun4i_tcon_dclk: convert from round_rate() to determine_rate()

 drivers/gpu/drm/imx/ipuv3/imx-tve.c           | 17 ++++++++++-------
 drivers/gpu/drm/mcde/mcde_clk_div.c           | 13 ++++++++-----
 drivers/gpu/drm/msm/disp/mdp4/mdp4_lvds_pll.c | 13 ++++++++-----
 drivers/gpu/drm/msm/hdmi/hdmi_pll_8960.c      | 12 +++++++-----
 drivers/gpu/drm/pl111/pl111_display.c         | 13 ++++++++-----
 drivers/gpu/drm/stm/dw_mipi_dsi-stm.c         | 14 ++++++++------
 drivers/gpu/drm/stm/lvds.c                    | 12 +++++++-----
 drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.c    | 12 +++++++-----
 drivers/gpu/drm/sun4i/sun4i_tcon_dclk.c       | 18 ++++++++++--------
 9 files changed, 73 insertions(+), 51 deletions(-)
---
base-commit: b551c4e2a98a177a06148cf16505643cd2108386
change-id: 20250710-drm-clk-round-rate-b25099c0c3a7

Best regards,
-- 
Brian Masney <bmasney@redhat.com>


