Return-Path: <linux-kernel+bounces-889523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C74C3DD49
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 00:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DDA974E40A6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 23:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A102A286D4E;
	Thu,  6 Nov 2025 23:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bpaQygL4";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XWVps1pF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1366B34E763
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 23:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762471609; cv=none; b=Y4TIseUH1dkJbyVfwJtmKnj8D/WfGAOnkltzhrQP4UMuIce+st584qpoAOFdSh/UoNe4zWyEofUqOeU0c87oOEmW+0h5oSPZOy9e+GLPExmNDN+ssadMDnvR5a80WU7Lv14HzpyYjVL4Foqs9xLW9mJxPhcJYpVKNNY3M1EPVf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762471609; c=relaxed/simple;
	bh=jDqYCzSqbnGJibZ0TWHt2xeNKFTolxoBt5YB5hnyZ0M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MP3NjcFSy99MsLOyBvX9OwC4vaSxTndZPukF7AtubZmtC3ASVfKozfbqGU+bZCd87xm2965M/DoGqJxW0qQfKy34rmCcYdqilnQHfDfmkUULAWRud7ZkB8kxKcs3SEPFemnjJn/2iodBV1DkQJ6D2G5eAREwsXiw50QQEhcAG74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bpaQygL4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XWVps1pF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762471607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FAJMsAfnDQTxhU296hQyXnd4WVpQmvZ3EitymZm2I2M=;
	b=bpaQygL4U8BIKfkqF7LuNWSEIX0Kbrk7gfCBpNGVWPSDCWeQNqjBdKcSkxO5W2Xy98QHV2
	Lo1oXduDh7/hEyQzaNbaRB8Uqwp+Tojr3AP/CMZDWmuI6ufVh8xDer+AHAiN0Ys1s7hTNJ
	VT9/1o6pd+zz1dwKHPb55PQEvT2zNNc=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-uvc52TEUPVq8GbCzsJXxjw-1; Thu, 06 Nov 2025 18:26:32 -0500
X-MC-Unique: uvc52TEUPVq8GbCzsJXxjw-1
X-Mimecast-MFC-AGG-ID: uvc52TEUPVq8GbCzsJXxjw_1762471591
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-88021ab477cso4776586d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 15:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762471591; x=1763076391; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FAJMsAfnDQTxhU296hQyXnd4WVpQmvZ3EitymZm2I2M=;
        b=XWVps1pFWiOcvJuzfEZq8UsAn+Ly0WWYecgvlw7CcOLg2Eqjlb201KmCVIguduHOyp
         62SVAtGllkLy0re0Ld1akJU4qqUn+qndmSWt4gWfQYGQhJ1utrPt9pg77T6q68qcpdgi
         h8gWiBqcdpp7dOhGhKUkOIV5JqeekvSy3HH6WX6B5pQd6eylRztv1qQ9NxYqToleRSok
         PuJW6S4vGqVIb8Eq2KaNNNMKeEkWvwtDgRiIjDCbjkfiZe2jIfvGrMB54qRmxHAaPX/E
         s95GBGe03Q2kEDperlfJ+mToH23vDjje79IqGxwnd3wCg85rx3oQIiZIV7puGnTp6aDO
         4GVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762471591; x=1763076391;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FAJMsAfnDQTxhU296hQyXnd4WVpQmvZ3EitymZm2I2M=;
        b=YhFvBiwRB+vE+c3kAQ6hcnqfODI03l+pB5pQ2lDOhR9i6O8lORlB78H3WsKBKYsnX7
         czUSF+RQbMU5iX2ZT+Oj6G1Hm4wfdFxhc63GKKfHhU7QJpUzcRIAWA5UiXe3BzTPVrLd
         f3MmSqNGaghPBC0DX+4DnvESmsrXahCy0UFyddFeJleBKQAbFMMcfGyPSz0a+vZF7JrX
         8kMy8qJu0mRpT2tQjoUJnP7pHqbJJYZmbqR40k3+IWq6hRSTvFmN/uIxTwiWey9RmWTf
         EGcpRfKHp2arKxY6AlvSKuouosHnLe4JN85w+FaFD08LpaSkU76pI1fSXP6CJ2M2LCaD
         vo9w==
X-Forwarded-Encrypted: i=1; AJvYcCVzsIpqsRbpLuQPdt9kSTZvRkSXs2rs485on7W1MrcX70G8XERWrLget8KReNoYQfnyTURsXXUsDKVouUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbxHYVZtnTDcZ1S1PtckYtX7bDu9h5yUI9gARsF1Vu+jhYZgNx
	qja3Peqiv+IFLZ0Dd79QQG25IZ3Bfj821TpZLKxr4W1RmtZ0gdzIluUWmtVcTfgmoW4oxOysord
	Tgac6AUkOFzoPwBpnfunnlCodmRDzc3lhdB/qqV0KKOFFM3YviibipdBKmpg4RImleQ==
X-Gm-Gg: ASbGncvAxgh5LiN+/gGuAMN6MFbtbWe3rFB0vbxSB79TMoCgXhBb+HiZGWjR/M+8REQ
	+epaYbMZK3eJWOrXY/qJyzhdJBmhwsoLx1WssXo0KC+/EprlSv8JwXxX5rtRjvAJo1jG45fTid4
	DjoiCbF4Pko9AGhhQWjEcBgLP10Qu3pdDXcYKW9Z8qbFLM+SWyndMc0G2UgL8p1sNUpY1VGsVjv
	EwkRsyXpC8dz4L1gXdNc3tF/7I/xdVWsStNLGwECBQyX+uOQCwOcYmNY1ovrav/N1ewcx9+Gwvw
	7+PFSRevjloHqxrxRA4ZhX1TrslsQ20/GYUxOBy9dJMyvwcUgP2uihJ/cgesZ85M4AVyap9+O19
	ruDIBZSejp5LwMsHY9OAgHYnoDwhWoQj9a59RhIFYvw==
X-Received: by 2002:a05:6214:b6c:b0:880:5d38:5411 with SMTP id 6a1803df08f44-881834dfe09mr19201116d6.57.1762471591434;
        Thu, 06 Nov 2025 15:26:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+ZOm7tarylyJioRDN+UtrP4l5Py54SY0NPKQjKouDoS43pKzvH1MTEWiaIrH2Yah85AxhDw==
X-Received: by 2002:a05:6214:b6c:b0:880:5d38:5411 with SMTP id 6a1803df08f44-881834dfe09mr19200796d6.57.1762471591096;
        Thu, 06 Nov 2025 15:26:31 -0800 (PST)
Received: from [10.197.115.224] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88082a3aa91sm27389196d6.56.2025.11.06.15.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 15:26:30 -0800 (PST)
From: Brian Masney <bmasney@redhat.com>
Subject: [PATCH RESEND v2 0/9] phy: convert from clk round_rate() to
 determine_rate()
Date: Thu, 06 Nov 2025 18:25:46 -0500
Message-Id: <20251106-phy-clk-route-rate-v2-resend-v1-0-e2058963bfb1@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHsuDWkC/x3MsQrCMBCA4VcJN3uQCxjU2a4OdRSHND3toaTl0
 gal9N0NLj98y79CZhXOcDIrKBfJMqYK2hmIQ0hPRumrwVm3J7Iep+GL8f1CHZeZUUNNcaicOfU
 YDj52jiwdfQd1MSk/5PPf36A40zbX5nKG+7b9AEy+0JR5AAAA
X-Change-ID: 20251106-phy-clk-route-rate-v2-resend-a86cb210196b
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Heiko Stuebner <heiko@sntech.de>, Stephen Boyd <sboyd@kernel.org>, 
 Maxime Ripard <mripard@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, Brian Masney <bmasney@redhat.com>, 
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6371; i=bmasney@redhat.com;
 s=20250903; h=from:subject:message-id;
 bh=jDqYCzSqbnGJibZ0TWHt2xeNKFTolxoBt5YB5hnyZ0M=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGDJ59Rb4nLOympMWNK85V7P7kd+6ig8Z8iyrkpyO9LTVv
 L2wiNO+o5SFQYyLQVZMkWVJrlFBROoq23t3NFlg5rAygQxh4OIUgImYr2P4nzJZcP7j4OSiJU++
 3zk4k8+2/Frr8mwdjUeuGTeL89leCzH8U557+Ny5Q6xsLO8TtE7MrRS0OtKyeXV28qwN2VKNB9I
 aWAE=
X-Developer-Key: i=bmasney@redhat.com; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087

This is a resend of my previous v2 series since I haven't receieved any
feedback.

https://lore.kernel.org/linux-phy/20250810-phy-clk-round-rate-v2-0-9162470bb9f2@redhat.com/T/

I'm hoping to get this merged for v6.19 so that I can remove the
round_rate() clk op from the clk core for v6.20. The clk maintainer
(Stephen) mentioned this work in his last pull to Linus:

https://lore.kernel.org/linux-clk/20251007051720.11386-1-sboyd@kernel.org/

The round_rate() clk ops is deprecated in the clk framework in favor
of the determine_rate() clk ops, so let's go ahead and convert the
drivers in the phy subsystem using the Coccinelle semantic patch
posted below. I did a few minor cosmetic cleanups of the code in a
few cases.

Changes since v2 RESEND:
- Collected up 3 Reviewed-by tags

Changes since v1:
- Patch 8 (phy-rockchip-samsung-hdptx): fix returning error code
  (Cristian)

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
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 14 ++++++-----
 drivers/phy/ti/phy-j721e-wiz.c                    | 11 ++++++---
 9 files changed, 68 insertions(+), 54 deletions(-)
---
base-commit: df5d79720b152e7ff058f11ed7e88d5b5c8d2a0c
change-id: 20251106-phy-clk-route-rate-v2-resend-a86cb210196b

Best regards,
-- 
Brian Masney <bmasney@redhat.com>


