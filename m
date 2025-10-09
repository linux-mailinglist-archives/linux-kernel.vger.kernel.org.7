Return-Path: <linux-kernel+bounces-847159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC24EBCA1CB
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 18:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD7AB425B42
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 16:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EA52EFD9C;
	Thu,  9 Oct 2025 16:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kg1Spka+"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49ADA2EDD6F
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 16:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760026070; cv=none; b=DQAuV7QBIko+9EASFCC3//HYIx5x8c1c783yu9hIJ960j2V9RhsgJdm5TjgkDMcRDGTvamNmWD5jl4k/nwAkhOgqCmxrosd6WQ74QFmLyRoMyC2tmI9bvcJv9Ati4m/DlEd8qV8K9lWr1zmGvK6j8a0fnH7Gq6KJCWpXEprXbBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760026070; c=relaxed/simple;
	bh=DN8j9z4swmPbzPKIBHWy+/B/9Ha7pzPEWaFFp7dlByY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=igH6ruQbRQMI4HXZg8MJGtG8FXTDE8XWqE3HcRJG/LFw6jgDm9Fo1521BVLu79yLfFkGhTe0HnZo9czLaPM6CCHYsxoLpflglZpOhAONbJCDgm92lFQ+XDlogK6pZV9EeCMeExzDYAzJPnIYReF3bMHvFy1P0nkmSHD7Qz7dDIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kg1Spka+; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3f42b54d1b9so1068427f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 09:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760026066; x=1760630866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2af5ZWbBC/9OLhW/nzoY8CDCHerUl/T+QhinKzjtT78=;
        b=kg1Spka+DkfnNTj7fMU627kvccVJRI7UH8z4Wi844jfWh8gRFO1bfEQntouqlu59B5
         yRkikEgtDSzy2HPae3wswkfiXKIl67CER2o1eswT/gTcOixM8OuW5gvyM1bC23j3cCHO
         KuywFcZnzqU64EQeOMs7p323ce5L0kPcPhv9SMNhUzaUVGkswzAePN9rYeNvTALgckjH
         Ii9lt0exT0JX8GMfS8Scj7MBGM02XJVLRp20BDjIjvX1jNdbGBAYh+r4giBkvWn2Ab90
         PeU8rfqSgcJkGYGekXwlCB6mXyUYT2p1GFs5lkA81H9/hvlBJwvCchKSGPjKMPpqGeMU
         zraw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760026066; x=1760630866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2af5ZWbBC/9OLhW/nzoY8CDCHerUl/T+QhinKzjtT78=;
        b=ed3xYCd6nLusiEawZpwpGl2jbSaI+vyiAJsxpXXym3DLbRHP7dZzkQbSWxEat8/wDC
         6KzcSAfNjlQZUyBXGwuRGJ3lXjCjkV/yFoHgN+j7/4qFp45/23Zm39ni+IvVsxwsJLZ0
         Hls9GM/vDrT4+qnLJDmj9gYJA7UilkzufzWqzRkIkuOqdwIntdT4Nvo7Bll5e5ieBccL
         /38DTwP+/uWgDA6WEJ/mqyD2AEdnemDHqpGhuwS2YDJAlO2OKsOoEWh8a9J5H4Jldhz8
         EbPWGpU9S1VnlXUOPyCVrexEtp5SncuRMBrmsP/oxMOlAx12hVhadlkpxaHigxI7l71G
         R3Sg==
X-Forwarded-Encrypted: i=1; AJvYcCVWLzY4H6e1+dNcLlF2hcwiqDIbdnrdiQR0OHnQ4rr7Mwx7OS1VmDTchSMguc/jKB0vtJFVvSDQAoO6IS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpAKXJHp3Sv+o6JcDFJP9bpZr5Mzf5wsZmy7o0Kc4biG2BWu83
	CVEDdFlkQjg5uJ3QTmnRnqvGyRWA6tslFdjOeEOH26YdxEIJuwl/Yf/H
X-Gm-Gg: ASbGncvlEYZgVz4r8oWrFlYY+pVXJ4GbeoXtw4WDgopJxTLW3mJwbBwViROokhZJvSu
	HyhkzZD/oru1kwTnd3Ms04wlnV6hHu4u9hZ9RDO6o7mkVe8YtGY2jFGPUcyqeDBeW7wOdE4v2zD
	shsG5GP3fhDdGTMSN2cmk+e4ppKMJVQzkVXCvhFCG/QhcLtENiKZ734h8Ucy0Xz4agJBDgDdd+7
	Wu7ilhXoXXHfDh6WRvg3j4FoK6J8lq4OoQ32qdOGldjHbYt2i1edQLRC67CPGwTsLyookoZgYL/
	GGupPFEy/1Qyk/IvkJM4HQub4oohI7INeQJX/YpiMJfIaJUmkNuiSWf/ViKQTaAFYNGhZ6KZKv1
	SyuJYavIeRuulTiOM/a2rksduM7ppH67OsUDVwlS4GR2xmhu0xdLXEwyZbI9VBh8udxS+AjiqDa
	KJn/11TA65X/BQSO0=
X-Google-Smtp-Source: AGHT+IE0KMq3ZsTbgVRvE9ZWmsGn0SaVRn1OTKWCKWyaqHw5jxmXzidd2ULsjc4Dgmp2DbpJwZm9eg==
X-Received: by 2002:a05:6000:24ca:b0:3f3:3c88:505e with SMTP id ffacd0b85a97d-4266e7dfcb8mr5595946f8f.29.1760026065423;
        Thu, 09 Oct 2025 09:07:45 -0700 (PDT)
Received: from iku.example.org ([2a06:5906:61b:2d00:480c:edeb:2884:a92a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426cd93e45fsm94632f8f.4.2025.10.09.09.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 09:07:44 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v10 5/6] drm: renesas: rz-du: mipi_dsi: Add LPCLK clock support
Date: Thu,  9 Oct 2025 17:07:31 +0100
Message-ID: <20251009160732.1623262-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009160732.1623262-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251009160732.1623262-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add LPCLK clock handling to the RZ/G2L MIPI DSI driver to support proper
DSI timing parameter configuration on RZ/V2H SoCs. While lpclk is present
on both RZ/G2L and RZ/V2H SoCs, the RZ/V2H SoC specifically uses the lpclk
rate to configure the DSI timing parameter ULPSEXIT.

Introduce a new lpclk field in the rzg2l_mipi_dsi structure and acquire
the "lpclk" clock during probe to enable lpclk rate-based timing
calculations on RZ/V2H while maintaining compatibility with RZ/G2L.

Co-developed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
---
v9->v10:
- No changes.

v8->v9:
- Added reviewed-by tag from Tomi

v7->v8:
- Updated commit message
- Switched to use devm_clk_get() instead of devm_clk_get_optional()
  as lpclk clock is available on all SoCs.

v6->v7:
- New patch
Note, this patch was previously part of series [0].
[0] https://lore.kernel.org/all/20250609225630.502888-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
---
 drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
index 3b52dfc0ea1e..bb03b49b1e85 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
@@ -68,6 +68,7 @@ struct rzg2l_mipi_dsi {
 	struct drm_bridge *next_bridge;
 
 	struct clk *vclk;
+	struct clk *lpclk;
 
 	enum mipi_dsi_pixel_format format;
 	unsigned int num_data_lanes;
@@ -979,6 +980,10 @@ static int rzg2l_mipi_dsi_probe(struct platform_device *pdev)
 	if (IS_ERR(dsi->vclk))
 		return PTR_ERR(dsi->vclk);
 
+	dsi->lpclk = devm_clk_get(dsi->dev, "lpclk");
+	if (IS_ERR(dsi->lpclk))
+		return PTR_ERR(dsi->lpclk);
+
 	dsi->rstc = devm_reset_control_get_optional_exclusive(dsi->dev, "rst");
 	if (IS_ERR(dsi->rstc))
 		return dev_err_probe(dsi->dev, PTR_ERR(dsi->rstc),
-- 
2.51.0


