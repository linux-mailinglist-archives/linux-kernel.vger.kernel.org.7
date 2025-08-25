Return-Path: <linux-kernel+bounces-785054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA48B34540
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 17:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6800B18826E6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 15:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A97D2FC863;
	Mon, 25 Aug 2025 15:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SGHwEaCs"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE042D9499
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 15:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756134585; cv=none; b=rYGtET5GZ4VDeTVHP9ncUfPzLuu3cn3GvzqyDSZHhOub3ZzjbLOUiCmJHn/Ko+zPJBevSuFF/DAyzdmnxUbYhjwR7ARxtIns8n0V/W23rpYdKtX2Lvv50ydQTfjiwDrKfxs0eXBDceVQ06b7J6HfeHtmg4dhq6Vhjht6N0Z2TPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756134585; c=relaxed/simple;
	bh=JowWEV5lcIHxp4u92sNNMOfatfjQ7ZENC4xcufj7568=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fA6eefAnts2jBnSzCLvMyGyNkCtVMG4tKQnH3AfJUqs8Kml8cTyhwTSaOzrzbY9mcsE7SKGw0lW0PXXjjonMxct6HMJQq3nw5/2JDn+PBPTYoilDJy7jrtsdWfc8HLduhjJQkpGorMTbRgKXnDrGJNXiIyQ2O4L13Y4tr/5187M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SGHwEaCs; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-32519b32b6cso2295684a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 08:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1756134582; x=1756739382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yb2SBUjk2cUBYlIMJ026/BKU22gh35Mp+MWKmgCVX6Y=;
        b=SGHwEaCsTl/Ya7s9iAkJnQRXcAZFGvMvtq4IQCcTLwUtJ38d4a0Fa9wilNhDB1RLeo
         4ikks68V7f0PVZiY3OaaBVrHMy8REu9Th1zi7GzRPvaY3d2zdqGo7kdbqguRbqZYyHjD
         lU2zB43Ef8lfzbgfItJS5+P4+EiDN+S1B+mxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756134582; x=1756739382;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yb2SBUjk2cUBYlIMJ026/BKU22gh35Mp+MWKmgCVX6Y=;
        b=u6bwr5471Z8X6NOPEJ4kHZTZrqnmsfF0E9G3Jq2y7A7spVNnLeKFxxmW/2v68swqM3
         szBoRPIi4eneBD6VHNPXY2L0B42cGwe4NJpo517PsUNuv/LOr70D0fsNrsij1qa9ZLot
         i7xd8x+8SnsaoDU+roEJSY7VusCW0HdXoaJW4jE/eutCzvUUKzEcRx9fNEpex4MSGqBV
         +7fUtp26q7ILfGgG+VxQr+wT2Jhd9stKIK1PrKWi+wYsfmhviy9cKQqVUDEE0tX2sYON
         nyeMYT7e9kQezmkdSR0BwoT3W3uoXfUL8K3DZ2ofGLnWEE2bvdmJlXgGlGn/7AHBkuuJ
         fynA==
X-Forwarded-Encrypted: i=1; AJvYcCXCwsCvTNDgKPmw3leeeTfWpa47lDTjkhThPpkibbech328HBAQH6ENWi+wJQVW+cmg5U4QtMEUbTmMxBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4hF9mw+RcWhPwQZJMRtSMSdbRhXq8GNo3cMYFo2JdtcsI4DxP
	bEKSdu+j8yOiLc0NrjI7s1c8dPMgKGlL5SC2hBx1Hz5+VwY1ccJRLMIvgUev2YK7aw==
X-Gm-Gg: ASbGncvkiu/L0xBUTg9DuKITYJLi4h2W0Rvswg4+RDHLd0lXt02IG/5Yq07Vv0jd6Tg
	5vVGhkiQOBK2Q7il97ftbrKr64c7L6HQgBJoLnnWeK/68DBaLeiQpyTeO3PVC9fPvluRxmrC9KE
	02+ZXs2cbX8XV23Bl5v35xn9DOeZiQsz6h6c+ofsoUI6NrXWKZVYq32RtOxR2Sqa9b/ToMkMkcb
	ZHdOVQjR3tmeOAhPX2c1OtfED1Hm3xWLWp3FaD36qE9InPhj+3Nk/S1fVZI/kF0PvX8cHzdq+U9
	uyPbq5vJQ4soktb39r48rrkq7/8Jo4S/wav8LHdqzdgiAboSEYBG968JXbyhbIwA/yAMbbdXibZ
	3FtTsb80NgnOd7vn/b5Bg0e85H3YVhvTpSF73D3ex
X-Google-Smtp-Source: AGHT+IHPJV4TXa61Ud+4jPZUdeIqShsQV2PbYlibNvBybfblxKwhUtY23QymfLSEF6L//QSRFz+xzQ==
X-Received: by 2002:a17:90b:3e44:b0:313:f9fc:7213 with SMTP id 98e67ed59e1d1-3251744bd41mr15706597a91.21.1756134582435;
        Mon, 25 Aug 2025 08:09:42 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:d5a9:711e:13f5:e60f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3254a1e4067sm7481215a91.10.2025.08.25.08.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 08:09:42 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Stephen Boyd <sboyd@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-clk@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] clk: mediatek: clk-mux: Do not pass flags to clk_mux_determine_rate_flags()
Date: Mon, 25 Aug 2025 23:09:31 +0800
Message-ID: <20250825150932.3695931-1-wenst@chromium.org>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `flags` in |struct mtk_mux| are core clk flags, not mux clk flags.
Passing one to the other is wrong.

Since there aren't any actual users adding CLK_MUX_* flags, just drop it
for now.

Fixes: b05ea3314390 ("clk: mediatek: clk-mux: Add .determine_rate() callback")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v1:
- Dropped unused variable
---
 drivers/clk/mediatek/clk-mux.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mux.c b/drivers/clk/mediatek/clk-mux.c
index 60990296450b..9a12e58230be 100644
--- a/drivers/clk/mediatek/clk-mux.c
+++ b/drivers/clk/mediatek/clk-mux.c
@@ -146,9 +146,7 @@ static int mtk_clk_mux_set_parent_setclr_lock(struct clk_hw *hw, u8 index)
 static int mtk_clk_mux_determine_rate(struct clk_hw *hw,
 				      struct clk_rate_request *req)
 {
-	struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
-
-	return clk_mux_determine_rate_flags(hw, req, mux->data->flags);
+	return clk_mux_determine_rate_flags(hw, req, 0);
 }
 
 const struct clk_ops mtk_mux_clr_set_upd_ops = {
-- 
2.51.0.261.g7ce5a0a67e-goog


