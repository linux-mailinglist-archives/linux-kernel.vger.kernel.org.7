Return-Path: <linux-kernel+bounces-762435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A06B20681
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39F7E3A94A7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B91274FF1;
	Mon, 11 Aug 2025 10:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SwZ68FYa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD806267B12
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754909789; cv=none; b=jrwkg6cg1E6egi2BtqcTOj+NLDme+4G3S8BJsf84CXlJ19nY+QMljuzroeAvWp91yhjwAehr7oUL8WjcQWysZOhZtyENDGDQ2F7AzxsmA18RdTh6o8n84To1UdOxWEdwWmdd1uc6GOK1UlxuIEd7058oei9LyuOQrHDuk2GHcto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754909789; c=relaxed/simple;
	bh=PIea/i4Y2q/6salydRYDw/qDzf1o1hZNE4V2kDbPHLM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FhKgCn9dYLhzlRWOGb+wosNS1Zw8wNwpuV6/qbxDFETenYZVKsBoL3qUxjJyFBL9Kj3eVypwkBLlGmo1a1NwLZ2wbJCTJKz8akIobvNomx0RfBKEqcmWpEOZB6xoQn6yV2GLueUAR2HRyoUVZ++gue7C+dPu+NobSx9nRpBmeJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SwZ68FYa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754909786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cXP3JhYEHDsI5xw9s9ngejjJCnQI06FB4xWiEKgLmT8=;
	b=SwZ68FYaYJVuatpEdEyfRD7K4sF/MHegrpXtISlSQO2MEayGidQRdwzhYDvVDzrrVXmzre
	SKtWrQ23FhxdQzCQUCwWT8Fc1H3yQwFGjtYlpShsBmaIwJaIgq296Izs8tcYIvWY2Fa/OY
	1CYv6AiEqnOe7WZCVlKzuJMT/iFN65U=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-VljmReHdMRCMlqp2zARxAQ-1; Mon, 11 Aug 2025 06:56:25 -0400
X-MC-Unique: VljmReHdMRCMlqp2zARxAQ-1
X-Mimecast-MFC-AGG-ID: VljmReHdMRCMlqp2zARxAQ_1754909785
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e82b4ed799so705328585a.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 03:56:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754909785; x=1755514585;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cXP3JhYEHDsI5xw9s9ngejjJCnQI06FB4xWiEKgLmT8=;
        b=LH5Yx9WKpyJP/2gyX/lHgxSJUws9ss+7RDHf9biNTfL5NS0JNbLv4eZejmP8kzIk5V
         exVRplfKH8S5MzC/MTW0JQsp/mUVOXtm+Gt3f6H3o7BvfzbngV1fWgeztJ2lNY7E0uXV
         Ke2hol8SLuiaLzwL+9OukQAqeuIzTgu7/9Z9+mNhW/KykX8/gHDVB5ubQAGCiyr+uOuk
         KgvbeWLFaKLGuF/p/5wmMyOnZ4UJ7eC+ex105mAXLLEQWd3hCfENNKAKOdp93e2fmMpi
         MM3UsHAJNJUHwoiIeh/irtfPtaRZzwRLEx3Q/swYjK/Z1DqJrvmIVd6amrm11BdNEVpR
         ZeiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVg9PInh1oWxEQm1+CQ97Q2UbVlZqUH3gldnZSqV7hdUUyu1shbM1XHL1eSjt6F0TVo03NK8TvAZ9ztZQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YycoUCgdslCS0UggQt46S3u4WOrlN6yZfGNulsJEiB7XpzZ1bbY
	Fs4PjoP+k/SctWQ5+EIJR3+towt1h95BeQksYonvh7L0RP9g3ZsxsoHDRRZjgVJv1M9e9WvgsRb
	Qg2cjQoAT1zr+4ioBdX/fEjcg7ZdNv75n8HGtwtfXliCsRhWfnRK2y+ejgeVS44JU2A==
X-Gm-Gg: ASbGncs42eaoa/muzbAuEnNeUNyk7K2AblrNwGf/aGeHTk5vokGzF/qJo/PfD8LJj66
	FmQikQAiG7Q5wZKBaVnc6IwXCFQE4C5ZLbJ5qRspomf6angaTthdSaTsISEX7Ilre6VyhkbIbs7
	kP6Xw2m79dfzMcEFx8uA/rc+guE8cuGoKzp9iIPqyhhHkDfLtGeev6NFqZlF1KEwwyg1djS2Mb5
	+asph+/F5skTtb/D96YTdYlcPnQBWRDp1LBnDZ8YpSDTCzsYTH+sSp2KsD5xqM0okvAhHU61UxH
	uutztB3PgAI7xW+K4K7WtM39F6zNI3mDza+yChcfOr6OM35QSZuZGV0KVi0J5+4jGL5/QpQJlKV
	CEUE=
X-Received: by 2002:a05:620a:19a7:b0:7e6:8580:67f9 with SMTP id af79cd13be357-7e82c7268b7mr1766286985a.39.1754909785085;
        Mon, 11 Aug 2025 03:56:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHR8+CCi/SOVhR+SKRFj6lKvJMHxUZZffNiDttlUcNIvFehaFMGmyLzcvBT31Mi5D8YTjxp6w==
X-Received: by 2002:a05:620a:19a7:b0:7e6:8580:67f9 with SMTP id af79cd13be357-7e82c7268b7mr1766283185a.39.1754909784503;
        Mon, 11 Aug 2025 03:56:24 -0700 (PDT)
Received: from [192.168.1.15] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e698de2df7sm1273446485a.80.2025.08.11.03.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 03:56:23 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Subject: [PATCH v2 0/9] drm: convert from clk round_rate() to
 determine_rate()
Date: Mon, 11 Aug 2025 06:56:04 -0400
Message-Id: <20250811-drm-clk-round-rate-v2-0-4a91ccf239cf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEXMmWgC/x2M0QpAQBAAf0X7bOucJH5FHs7dYsPRHlK6f3d5n
 KaZFwIJU4A2e0Ho5sC7T6DzDOxs/ETILjFopStVFwqdbGjXBWW/vEMxJ+GQVNNYZUtTQwoPoZG
 ff9r1MX5z1hFLZAAAAA==
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
Cc: linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 freedreno@lists.freedesktop.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-sunxi@lists.linux.dev, Brian Masney <bmasney@redhat.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754909781; l=5717;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=PIea/i4Y2q/6salydRYDw/qDzf1o1hZNE4V2kDbPHLM=;
 b=Fjs6oyZBop8brn89Wis9Wmv9d/YiKRi2CsQG8Y9p4VeZHPd25iPf4ZojTiOdduqVItv0hvHzz
 qP6WUnq2F02AwCFtKnsda9khMDCy+eoFbTEarTYyadGpvit3bjTpK8f
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated in the clk framework in favor
of the determine_rate() clk ops, so let's go ahead and convert the
drivers in the drm subsystem using the Coccinelle semantic patch
posted below. I did a few minor cosmetic cleanups of the code in a
few cases.

Changes since v1:
- Drop space after the cast (Maxime)
- Added various Acked-by and Reviewed-by tags

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
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250710-drm-clk-round-rate-b25099c0c3a7

Best regards,
-- 
Brian Masney <bmasney@redhat.com>


