Return-Path: <linux-kernel+bounces-824034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24327B87F65
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 07:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02CE01C872E9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 05:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9572877D7;
	Fri, 19 Sep 2025 05:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TqCCsuFt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A562848B5;
	Fri, 19 Sep 2025 05:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758261551; cv=none; b=uJfxdlqWZyiknMmQuNBkdAgJvfcs753p2Boe9tIZvSTLMmgCXwm/6kTZSkYG49B6IVLo1vPHeOuMjf81GVQ9deRISfY35VhzhUxFTxiO+Ts8cq6EwbZI9jqNEo4yWdNb9K9x6F/kvVR4X1OJH6fiPj8bfLRUhAe6O865sCdkA68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758261551; c=relaxed/simple;
	bh=vxKxe6c/ehRwg4Y0ba6xYL+uSGYy+9cgQxN0cPnDXHQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CaCV2WVMJ3XRyJgZCyzsZQn6kRbtb0OAJn/yWe2alkjb9LfiY43+CUmPqIMqwprnUERcmEpXiNU6bljYoLkurg6fX4O086x8rAdtjE3Tyh57NLnGWeM01VtE4rmTkR1jtnqlEIBSMKT/+cS3WrGQRqPpLXlAVes4O3Fh3G/70jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TqCCsuFt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AFA3AC4CEFC;
	Fri, 19 Sep 2025 05:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758261550;
	bh=vxKxe6c/ehRwg4Y0ba6xYL+uSGYy+9cgQxN0cPnDXHQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=TqCCsuFtMp9lQjdZUunivKKbFPlxcgzDyostmwz+hkEVnx4ELwic6L9D7KlgGcVPz
	 oilXZnHJ2ehuVRZcQl+xS+mzVvK/YVzZ/qB/pNArcwot88F8ZerxaFx+pXiD7z9kkU
	 t/fTKpE7XB6F7FWt9Z7VLaddA/+tTsB36ZWjJcSmmk531NSfnoK67AY2Hx4BabvB+I
	 KlT2SlZopfQ71ypEkS47zc5hKrBkXyqcfGMLaiyEc8WCzV08TH2Q3wqnIGBib40zh+
	 KsmrmrdteLJEiNUhO5sV7nij3erbVRd2bUjmVxYgEIJ30XuTYbnZzWY0okMT2dAKos
	 RKamPQ88mCn5A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3001CAC592;
	Fri, 19 Sep 2025 05:59:10 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Date: Fri, 19 Sep 2025 13:59:01 +0800
Subject: [PATCH v6 3/3] clk: amlogic: remove potentially unsafe flags from
 S4 video clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250919-add_video_clk-v6-3-fe223161fb3f@amlogic.com>
References: <20250919-add_video_clk-v6-0-fe223161fb3f@amlogic.com>
In-Reply-To: <20250919-add_video_clk-v6-0-fe223161fb3f@amlogic.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, Chuan Liu <chuan.liu@amlogic.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758261548; l=1493;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=pOpocCKNpaziWiHhDcJu1vTMZ5jdWqLvQRMLrgn1IXk=;
 b=r14O5cCFsk9df7Bw/kETEQkh7o9IKmZ5Q7JHBFdXPEM/dxZevMJ3AfIfwazFWlcs/xX0Ssh/0
 S6wSIFg/QLZBFbHr4/RDzoZr2PLcvw8lScuSWpG6CdNg7pj084sfRQX
X-Developer-Key: i=chuan.liu@amlogic.com; a=ed25519;
 pk=fnKDB+81SoWGKW2GJNFkKy/ULvsDmJZRGBE7pR5Xcpo=
X-Endpoint-Received: by B4 Relay for chuan.liu@amlogic.com/20240902 with
 auth_id=203
X-Original-From: Chuan Liu <chuan.liu@amlogic.com>
Reply-To: chuan.liu@amlogic.com

From: Chuan Liu <chuan.liu@amlogic.com>

The video clocks enci, encp, vdac and hdmitx share the same clock
source. Adding CLK_SET_RATE_PARENT to the mux may unintentionally change
the shared parent clock, which could affect other video clocks.

Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
---
 drivers/clk/meson/s4-peripherals.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/clk/meson/s4-peripherals.c b/drivers/clk/meson/s4-peripherals.c
index aa500ea8ef9c..ba41fcd90588 100644
--- a/drivers/clk/meson/s4-peripherals.c
+++ b/drivers/clk/meson/s4-peripherals.c
@@ -1107,7 +1107,6 @@ static struct clk_regmap s4_cts_enci_sel = {
 		.ops = &clk_regmap_mux_ops,
 		.parent_hws = s4_cts_parents,
 		.num_parents = ARRAY_SIZE(s4_cts_parents),
-		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -1123,7 +1122,6 @@ static struct clk_regmap s4_cts_encp_sel = {
 		.ops = &clk_regmap_mux_ops,
 		.parent_hws = s4_cts_parents,
 		.num_parents = ARRAY_SIZE(s4_cts_parents),
-		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -1154,7 +1152,6 @@ static struct clk_regmap s4_cts_vdac_sel = {
 		.ops = &clk_regmap_mux_ops,
 		.parent_hws = s4_cts_parents,
 		.num_parents = ARRAY_SIZE(s4_cts_parents),
-		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -1185,7 +1182,6 @@ static struct clk_regmap s4_hdmi_tx_sel = {
 		.ops = &clk_regmap_mux_ops,
 		.parent_hws = s4_hdmi_tx_parents,
 		.num_parents = ARRAY_SIZE(s4_hdmi_tx_parents),
-		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 

-- 
2.42.0



