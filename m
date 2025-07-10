Return-Path: <linux-kernel+bounces-726103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3951EB00834
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 18:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EEFA188221A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 16:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB182EE99D;
	Thu, 10 Jul 2025 16:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FymL5RWK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F46F2EFD87
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 16:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752163698; cv=none; b=F3EC2in9BXtOFPr7EIz8jIAQUvw1SJ1Nn6AyIZFe80MOnbgGfYTyvAwR40Mo/zv1lNJ5Pk76h4pexy7JtezneLep5CoIDobcj16bIk5TvdUzf1627knepoK8hNV3wrZOUWcXe92xWo8Pk5SgRYZlmbo7PvJq3idQmiMKACxwMuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752163698; c=relaxed/simple;
	bh=oHw4EaNbWszhl2nWjfiTC4gPuNzXI86YghpIW4T3XYU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jldgRrVn/OZJg3jeB/xP60SyTqj7qYcHsdqqPIZzslmA6q8hvka+2Y+tB6cWTbdG6BvSKKBIWwaPLRlMSdATz0k7BBPxEwANfAZxS2UkQXMgvvqDXtQxszr8fUaVZ2Xt4La4A4/H5cSTE7jBoxdSK851aruuy5yqaUvqK2lU7d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FymL5RWK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752163695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9y0trkj4fUoS0RrnudnNCXl9kNIfdjh6JnTKD549Do8=;
	b=FymL5RWKXkWhvAIbMTnGO1zOcBkga/rpL69FZdDDohZs0kzbZW8rQHBM1ppwbEAnbs6FwU
	UBoh1UIOy3d5vIX5Am0axEBx3G25xIYj0p1bie5y5VyKVS9X4Rnho09qpHr8ivCXjXqau5
	hrrX9dTtjyara8/Xhy5683OJlebYu00=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-0pAcX9a5O3ymB1jCYJhLGg-1; Thu, 10 Jul 2025 12:08:09 -0400
X-MC-Unique: 0pAcX9a5O3ymB1jCYJhLGg-1
X-Mimecast-MFC-AGG-ID: 0pAcX9a5O3ymB1jCYJhLGg_1752163688
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6fb3654112fso20217666d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 09:08:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752163688; x=1752768488;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9y0trkj4fUoS0RrnudnNCXl9kNIfdjh6JnTKD549Do8=;
        b=jEf6jic3/NN1h6ulSQhioNYSoeaAnR/jHl0pLt6rSojwqfDCM1joP28lgkOfT7i055
         WsLiEO7AUswixgt8dWhOqZ+N6uqmUM0MqeYatXgfm1ocfBc1dz/X9rUTFNxOsc18tnSO
         YGX/ThCh93PfeWiVefgUHjPtOlymu8But5DFoAyKVQ9gYWFO19ZCzCMRuSP2FbF04vob
         0TutgSaICsZl7NBPUtx7CAXSv2jpTx3Xu+drRykq76WPFJKRegbaSnpuCSNJ0tDrKZZZ
         SQdvLywZmB2I31oh4AvdLqrsDKLEqqWVZBrqb0cdcLy0R1Fkp6UJXLXxJu+CjvnFiXhU
         he0A==
X-Forwarded-Encrypted: i=1; AJvYcCWOWJShDqbZJ/Hx3h3Uk1pERBKV3YEPYORZviAnT5S8ZlDsMioZfcBZjtISDkH5TYuBmfUFNGvcBNAnpEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyGtnphwefIbaanOvYgOy2uN2j4enjvWZpkeeAam7McVKXrPEp
	P9PeBn9XCf4Phikpqx+kJP9wfFUijuDGpJQBYnopENjxHar5xHYflNcgLXbSQss7fxdxySzmobr
	xO6zoiRCaxBx7p9JJTfD6NHRH1Zi/ChkG/SqZ8m+cOLOwg4u1sD5ThoM847XeHmLn4A==
X-Gm-Gg: ASbGnctGbDAU//X0u60c3rsEcndUo5jHB8+5Vk+vprQhAd3R55Yrf8pQEq30Ha+iMJ0
	RZmFN0Sx9fYfILLeZb4OSaOc6BDUvglPvHLZfjAmCRfgPduEUEMMQQxzE4dioOD93ctykG2LpBW
	G1R4ZvDbAwfIHC/G3aW2L5kemEQAeHr5AU5eTWTFm3FZWXWo7c38rj+Enh9JVOAqVVRowvpx0XS
	G1nvOdEGq3pbR9bQ4YSaZjmKndigS3VrC7ai+7jixBMFun/L5roS78FGZjosFBfkpDhh7fd05OT
	SmcHR88NvkdVJ1Zw5CFPmVqmjOlrLxbkFLmaxsXtPqwucmhc1WsaapH0ra9b
X-Received: by 2002:a05:6214:2b0b:b0:704:a23f:9d36 with SMTP id 6a1803df08f44-704a23fc534mr3788236d6.25.1752163688496;
        Thu, 10 Jul 2025 09:08:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4gXy2Dkx4egeBxiGddHTDVbGuVB+8YXO54lWBniB7kXUceb7curtnNMZMf9c09zPdEAmsFw==
X-Received: by 2002:a05:6214:2b0b:b0:704:a23f:9d36 with SMTP id 6a1803df08f44-704a23fc534mr3787296d6.25.1752163687765;
        Thu, 10 Jul 2025 09:08:07 -0700 (PDT)
Received: from [192.168.1.3] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70497d39749sm9670216d6.58.2025.07.10.09.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 09:08:07 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Subject: [PATCH 0/9] phy: convert from clk round_rate() to determine_rate()
Date: Thu, 10 Jul 2025 12:07:10 -0400
Message-Id: <20250710-phy-clk-round-rate-v1-0-0ff274055e42@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC/lb2gC/x3MQQ5AMBBA0avIrE3SChquIhYNU52QkilCxN01l
 m/x/wORhClCmz0gdHLkNSToPIPB2zAR8pgMhSoqZbTCzd84LDPKeoQRxe6EpbWGnK6VowZSuAk
 5vv5p17/vByQloVBkAAAA
X-Change-ID: 20250710-phy-clk-round-rate-4aa7ef160fe9
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Heiko Stuebner <heiko@sntech.de>, Maxime Ripard <mripard@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752163685; l=5746;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=oHw4EaNbWszhl2nWjfiTC4gPuNzXI86YghpIW4T3XYU=;
 b=+YTf6TGhVZLwRnFkAqozoviaA3InI8pyoCfUeHJRT13VIoshFQfOj4nk5h5s6PLxBjQMoxHBQ
 8+w6S9SAMg+C2VTLAoUj9UtD3pjNbsegU6UjRkwkyeFq4rIhJkVs1CU
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated in the clk framework in favor
of the determine_rate() clk ops, so let's go ahead and convert the
drivers in the phy subsystem using the Coccinelle semantic patch
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
      phy: freescale: phy-fsl-samsung-hdmi: convert from round_rate() to determine_rate()
      phy: mediatek: phy-mtk-hdmi-mt2701: convert from round_rate() to determine_rate()
      phy: mediatek: phy-mtk-hdmi-mt8173: convert from round_rate() to determine_rate()
      phy: mediatek: phy-mtk-hdmi-mt8195: convert from round_rate() to determine_rate()
      phy: mediatek: phy-mtk-mipi-dsi-mt8173: convert from round_rate() to determine_rate()
      phy: mediatek: phy-mtk-mipi-dsi-mt8183: convert from round_rate() to determine_rate()
      phy: rockchip: phy-rockchip-inno-hdmi: convert from round_rate() to determine_rate()
      phy: rockchip: phy-rockchip-samsung-hdptx: convert from round_rate() to determine_rate()
      phy: ti: phy-j721e-wiz: convert from round_rate() to determine_rate()

 drivers/phy/freescale/phy-fsl-samsung-hdmi.c      | 13 ++++++----
 drivers/phy/mediatek/phy-mtk-hdmi-mt2701.c        |  8 +++---
 drivers/phy/mediatek/phy-mtk-hdmi-mt8173.c        | 16 ++++++------
 drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c        | 10 ++++----
 drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8173.c    | 10 +++++---
 drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8183.c    | 10 +++++---
 drivers/phy/rockchip/phy-rockchip-inno-hdmi.c     | 30 ++++++++++++-----------
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 21 ++++++++++------
 drivers/phy/ti/phy-j721e-wiz.c                    | 11 ++++++---
 9 files changed, 73 insertions(+), 56 deletions(-)
---
base-commit: b551c4e2a98a177a06148cf16505643cd2108386
change-id: 20250710-phy-clk-round-rate-4aa7ef160fe9

Best regards,
-- 
Brian Masney <bmasney@redhat.com>


