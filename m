Return-Path: <linux-kernel+bounces-840466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C437BB47ED
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 18:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFC277B4D4A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 16:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B756264A72;
	Thu,  2 Oct 2025 16:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVapzWaK"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0D125D53B
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 16:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759421870; cv=none; b=HkFRjED6Lh47rTe+jzeYkn/P9k8Zn9SMsbugqRbUtpCs6zUEWXrFQgMZQL1LxvR8RS0Q9Eu6WA6D2tIhWE0tdjCbJrFM08AAxuCNNIJp6iJ1onth5PQ08zECA0JzllIbTZXC/9mgW8T/Q89za+I9kkdCHHPmHMIDOLesXNXnnuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759421870; c=relaxed/simple;
	bh=Xk3vGDY+dbgDXhwjpZ5Y9vmLpKQHiUY58WcqSeQB640=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HJAI1gFu5olSiS9mjnJTB9mjIysySzWz/wSvfgVgEtQnGwcaUUcpVOewhhduZk5eSk6ar1D9o4rEPVr5IWmbp3xnF+Mockfdjl/QRyI4qyd1A7jXp4IyeQMyEIQXlM/xWhOk3cU+GvqUhDluzol908YQBIP2HxcC6gfyiq0wknI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TVapzWaK; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-46e5b7dfeb0so5564885e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 09:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759421867; x=1760026667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mku9ehBZVYr9qxRYLkJ4uKrLVeypEMB5DxHQCDkGT7E=;
        b=TVapzWaKfCskRhd8QswMXOKEiYdf6dIJdXWW9m4ndoDHGGkGsIAdHWd3qpxxLCUNDu
         yi2ZK9LnmOMWyfqPh3A5EeWGtk0sr94OlrRKV22j5QcSMpHxQqMHFv3rieMRHWcGu8OM
         xkhU4EoYuw+DL41VXy9ntW87cdNxFBGRhCA34BsWAkrQIzU7IFH4ZnAeXv9vV0EGwsOK
         76nAtAC3k5QWieI7ocO+Q1DgOY84r+i+Z7jBZs2eIu8stZefIhUg0ZwO63BE6I1ltwLj
         Wl1YmhxDIVwAbGTghND5gK4cwF3WQaBdlUK0mdnR6TMtFvi9z4NGPERJWrjG9yXUu9Pg
         SCHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759421867; x=1760026667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mku9ehBZVYr9qxRYLkJ4uKrLVeypEMB5DxHQCDkGT7E=;
        b=BuPIQW3PEVt8c0YvijUrgyJBAvFe3gNfek3vH0VfEe1+P9uMHXpZr1vCWhOcOB7qpN
         Bk2diNSCPfqxM5dFnwyEl4CJ9YPj9FCsZ731+EdpTVGBxI0Vy6tLVCTW0gFvlLtzeUOy
         ns4WCp7D9WWXfV24SpgbfQXns9UAnDNfgVsk57IysjaWO0ddWqZp1GoaQhWDJu5YbhLq
         mcc7P3Do/yItldeBIXunEo9m1/Fj9CxOy66v2Mov06N0QpZc0bMCsDOASJvnSjhxgiGZ
         Zymb2g/p/lvKMiHwHxgNmqNyet5geVpYZRlDpofi/AvsuckNbbFXuVH7fAdlcTE81t2g
         GMyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUacW8nR1DrW5YkNCN8JXPotZF+CxgBqUDHwRhXDDS1zxPTvGXbaiZOC+gdVKZymbtDPpOMMk/2L1Pim2M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1V+Dz6syNcCQ8yqI8JDGG1t6/VZxsE0XHgCX08OkJ0O3sM5aY
	tCzv7cxCaZvGacno7WZmGYh5NftyH8IMTNCCYK/kUfFumoRHu+I0EMf8
X-Gm-Gg: ASbGncvQRiUprweABU8j9wjSrn/QvZgZE5Q1o++wFXr1CHDJiAuNyf5uh1IS8XV0CBv
	ONnvXPQQwqVZJt2VLTds7cuEhq942ryHUBzsibzoUZE75WjUnEO+E1O+duytKDyh8p2ICgyGCWt
	oeNctBfI7M4X6BY9KQkw+jUqgSyoY2Vrax1y2xZH3uaXcLqEmG5k9V5B+usw+9Zx+QjSVo8DtXY
	KWkOKz63LkMVyx3kZtP/D8Tv6VgERdgusjdi7mCg1Un8WJACkSUFmHbBePntPxxG4sDqw/oz1UN
	/bG8yU2K/oRbf2ZJRZaJT5Alo2mr9vRai7vEQj7cwAFtxDdN/wr+P/LkkB+zfadhFArWTxeSeq4
	R6aIUHpGZYODH/uVoJa+oD3LLJSzwC7Q2E7LGKakGA9k43N1q76HKS/XGdpA/QOI3nySLkpBRxV
	rVYQov
X-Google-Smtp-Source: AGHT+IGeLiSiOTWvku0XOb7pjsu8OYgt/p6DzNcZOdgcfnQ7jJbiYwMNujXhPwp7rKsbuxI9FkchAg==
X-Received: by 2002:a05:600c:a08e:b0:46d:cfc9:1d20 with SMTP id 5b1f17b1804b1-46e612bab6cmr53404705e9.22.1759421866515;
        Thu, 02 Oct 2025 09:17:46 -0700 (PDT)
Received: from iku.example.org ([2a06:5906:61b:2d00:607d:d8e6:591c:c858])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e5b5e4922sm58605515e9.1.2025.10.02.09.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 09:17:45 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
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
	Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v9 5/6] drm: renesas: rz-du: mipi_dsi: Add LPCLK clock support
Date: Thu,  2 Oct 2025 17:17:27 +0100
Message-ID: <20251002161728.186024-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002161728.186024-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251002161728.186024-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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


