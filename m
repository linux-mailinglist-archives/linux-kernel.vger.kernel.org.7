Return-Path: <linux-kernel+bounces-761630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E6AB1FCC9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 00:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A3E01895298
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 22:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF861E5710;
	Sun, 10 Aug 2025 22:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A4r5NCpN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B968DC120
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 22:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754865959; cv=none; b=Tic3FfPKrTpN09gaqR6SssIiiYv4mMqDzw+Twsc4RLVJQZKMm9pIjL94s3KEmsDjwPazPYwR2K1EI9Vq0cazXOCFg67u7I2VbwVXr6q3lap25x/wtxhDMZEXZk3LwUtvKLGyL9AnfCUGEVArKJJBRnRFvPNMQfVkxfT7+OqR0PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754865959; c=relaxed/simple;
	bh=aLGfKmyNU+bomSynOaLohW6Y59bxgPyE9ULfin1cZyo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XaC4jUyCeDzD4gqkj/ItuJHXwVkFp2buN6v3u4Zfk7zis3S+/n1ggBtOqXbyRSqrMPHdwUcQww1wPrnKk7hhNyd6FqkCdAhi54UiKVKXtcM3yYk36AgO5OAhSOKk4XItks2nRPxKcPiLleCJTWmcz8VsLRvLkMNQNncKoVwgeBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A4r5NCpN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754865956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zejlDygpGrwzEF/Tl2mTtzsn7pmvzE6JdbSkjCZTc90=;
	b=A4r5NCpNjnWcOhf+Q3yw7XW4o6xxHxJ26XMfmXWAD8OarF44I9xCAine4xkuef8WMI2G5z
	5NW08BvTXrrqce15x35qdXFEoPoShgdQqXu2UgfqxhWG6mYOZMgIqAkNmXN1W94hWzJxy7
	/25ciug/9duuP88IGTSGhGKnmAzaEWQ=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-KyasgxKCOOCr20HIOw1otQ-1; Sun, 10 Aug 2025 18:45:55 -0400
X-MC-Unique: KyasgxKCOOCr20HIOw1otQ-1
X-Mimecast-MFC-AGG-ID: KyasgxKCOOCr20HIOw1otQ_1754865954
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b07b90d5cdso49067641cf.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 15:45:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754865954; x=1755470754;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zejlDygpGrwzEF/Tl2mTtzsn7pmvzE6JdbSkjCZTc90=;
        b=ZJpwj7EtDOrTygto1V2jCaFYjHqEp6gkn7ZJwCzsCFbwrhR9bAm5zsvmZ0V08QGAAZ
         kevCh4qNC/nbCt+Q2kueky5YVPo1jFj/OpZ3bRRfKsTBohYB65ua9TfFsCVNRB0t8Zj9
         6SwrPtmEphQTGUkD4RHvFc8O81GIi0k1+v9fuKQ0fSglIuw/qS/WyBzSvmpP/PP2JCu3
         0to9IHCm9QJ7q+CBKg2NfAXJxckXr66xTJKxDqHEBJHgbXqA1yml6pULbRl/MvBGzcay
         IMsIkJ+LYfohYs2OVAr4bXOorF/sZU2VGlIqGaNynTQYYNwkpqkvQcW7jpovCZNaHwMU
         Ngkw==
X-Forwarded-Encrypted: i=1; AJvYcCVdea6gRDDhrsdmzCR6eS8Msz3QbcNqss5fo7Ujikx7cJAYO9UcXPQc5ZzrTS/8pSDmhJtUI3Xbo0Xd8S0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxra7IiW3Oc94g7npWG5H6vz+3FDYpPBYaIsGQviE6Q2icLLfy+
	jFm0WqN2LQdw/gcpgcxAIvdQANh48ofm3gnqOmiPwLFUjBT7CbaNe1Vqqg/HhX4IGXd7aOXWE/2
	mjiQLzWgYky5tF/yiDA/mrQnzGGodPG+HOxFMvlrU5eeWk0DRBTay8pHAE3zU5Ixubg==
X-Gm-Gg: ASbGncvZBegRvClB/WXzmhCFcINuv+8IHHiuweyOP91xhsOexi1ZInk5/ZCzug8Q9M4
	O12kxqVCbjV0RWeGupcZ7RUJmudwPn15A/O3piVpoVPNaIXqu/NK2oKFd4ei8C3SB8EW5KzlHlG
	+WQlCQ3mteq5hZLRX3CmJElW4xfSkC1qQ19bxyTTf0PybYeShr00/s26wUUHhXeOASDyJ/0OSzU
	8MyJo8fjW8atUsi6d3CJvsIhWPEmKDnimBVp0IwgF6ZmqGQMwRJ5XcY86f97u9Bh6xSZf74vf3L
	xmmhY/SHAzqD4b+R+whvFZaVagxAcd213jJJGg2AJr6YJI0HBhlGrfpmmAnbDnwg/g+QPQuQ1MZ
	UJIzQ4g==
X-Received: by 2002:ac8:5992:0:b0:4b0:743a:b4f0 with SMTP id d75a77b69052e-4b0aedf6b1amr162625071cf.41.1754865954317;
        Sun, 10 Aug 2025 15:45:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMMVuRi+pB2hB00rh/4lBT2A6xNejEN6UKRgkLWeOvqElbSCAZq0WUzWxXHj0FePs3qQpk7g==
X-Received: by 2002:ac8:5992:0:b0:4b0:743a:b4f0 with SMTP id d75a77b69052e-4b0aedf6b1amr162624811cf.41.1754865953842;
        Sun, 10 Aug 2025 15:45:53 -0700 (PDT)
Received: from [10.144.145.224] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b0ad996459sm42685171cf.46.2025.08.10.15.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 15:45:53 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Subject: [PATCH v2 0/9] phy: convert from clk round_rate() to
 determine_rate()
Date: Sun, 10 Aug 2025 18:45:28 -0400
Message-Id: <20250810-phy-clk-round-rate-v2-0-9162470bb9f2@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAghmWgC/x3MQQ5AMBBA0avIrE1SDRquIhYNU52QkilCxN01l
 m/x/wORhClCmz0gdHLkNSToPIPB2zAR8pgMWulKmULh5m8clhllPcKIYnfC0lpDrqiVowZSuAk
 5vv5p17/vByfwFxlkAAAA
X-Change-ID: 20250710-phy-clk-round-rate-4aa7ef160fe9
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754865940; l=5842;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=aLGfKmyNU+bomSynOaLohW6Y59bxgPyE9ULfin1cZyo=;
 b=O9IhL3QDOUiwO05Lg7AXKinAxwzs6mf8jMpnbEWniYrx2Csle3lF/NzYZAfa6oTvLYjtyMKTB
 35n8Z5Wp2HwCqzPx1ryQAePsX3611g3M7mBqcbq1xRSaFHhbzl6z6wG
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated in the clk framework in favor
of the determine_rate() clk ops, so let's go ahead and convert the
drivers in the phy subsystem using the Coccinelle semantic patch
posted below. I did a few minor cosmetic cleanups of the code in a
few cases.

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
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250710-phy-clk-round-rate-4aa7ef160fe9

Best regards,
-- 
Brian Masney <bmasney@redhat.com>


