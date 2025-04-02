Return-Path: <linux-kernel+bounces-584900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18110A78D5F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 13:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1966189298B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 11:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2884C23815D;
	Wed,  2 Apr 2025 11:42:12 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9BB2AEE9;
	Wed,  2 Apr 2025 11:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.216.63.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743594131; cv=none; b=pWxUjAlunP3jyScTc+SpMbBm8/reZ6kKrcfn0TgmXwbq9uDBiBQqqKEAgEoQumd7RqMosXFmg7te3qinYQPsxigIgWqSVqzftF5vmKcmWHKhTdCM9pfl/7z5SYoBOkVpFWdsNzYZzyK4x7vMr+WwXZoCzhuXjRoYl3Hro3RDu9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743594131; c=relaxed/simple;
	bh=Zv5dbReFel/EO6cMf8sg7s7FyaAfk1JbfOgKVejN9G0=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=INzm4etnZZ0bPEhdFw3j6QubV/2DWFNcfRQbfmOQlh87DQ/YaSzfDsuE9ZaAYM2ki7UQ58QdXDpXJDA4f/zs/jdMK/iQVNLISkhk7hqmT9zsGYH9aBwPCryKL4p2ogSsKfRkwWSrSaq/x0DyeBC9PwevXaNQFgSvKgz9lPrkoWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=63.216.63.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4ZSNJD3hjJz8R040;
	Wed,  2 Apr 2025 19:42:04 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 532BfxoZ067902;
	Wed, 2 Apr 2025 19:41:59 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 2 Apr 2025 19:42:03 +0800 (CST)
Date: Wed, 2 Apr 2025 19:42:03 +0800 (CST)
X-Zmail-TransId: 2af967ed228b33d-29c29
X-Mailer: Zmail v1.0
Message-ID: <20250402194203426goMMzm9R9_yQBb7SMNGj1@zte.com.cn>
In-Reply-To: <20250402194100610qY6KQ4JPISk-4v214Qs36@zte.com.cn>
References: 20250402194100610qY6KQ4JPISk-4v214Qs36@zte.com.cn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <vkoul@kernel.org>, <robert.marko@sartura.hr>
Cc: <kishon@kernel.org>, <wens@csie.org>, <jernej.skrabec@gmail.com>,
        <samuel@sholland.org>, <zhang.enpei@zte.com.cn>,
        <linux-phy@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-sunxi@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <luka.perkov@sartura.hr>,
        <linux-arm-msm@vger.kernel.org>, <heiko@sntech.de>,
        <linux-rockchip@lists.infradead.org>, <yang.yang29@zte.com.cn>,
        <xu.xin16@zte.com.cn>, <ye.xingchen@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHQgMS81XSBwaHk6IGFsbHdpbm5lcjogcGh5LXN1bjUwaS11c2IzOiBVc2XCoGRldl9lcnJfcHJvYmUoKQ==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 532BfxoZ067902
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67ED228C.001/4ZSNJD3hjJz8R040

From: Zhang Enpei <zhang.enpei@zte.com.cn>

Replace the open-code with dev_err_probe() to simplify the code.

Signed-off-by: Zhang Enpei <zhang.enpei@zte.com.cn>
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
 drivers/phy/allwinner/phy-sun50i-usb3.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/allwinner/phy-sun50i-usb3.c b/drivers/phy/allwinner/phy-sun50i-usb3.c
index 363f9a0df503..b03faffc160d 100644
--- a/drivers/phy/allwinner/phy-sun50i-usb3.c
+++ b/drivers/phy/allwinner/phy-sun50i-usb3.c
@@ -141,11 +141,9 @@ static int sun50i_usb3_phy_probe(struct platform_device *pdev)
 		return -ENOMEM;

 	phy->clk = devm_clk_get(dev, NULL);
-	if (IS_ERR(phy->clk)) {
-		if (PTR_ERR(phy->clk) != -EPROBE_DEFER)
-			dev_err(dev, "failed to get phy clock\n");
-		return PTR_ERR(phy->clk);
-	}
+	if (IS_ERR(phy->clk))
+		return dev_err_probe(dev, PTR_ERR(phy->clk),
+				     "failed to get phy clock\n");

 	phy->reset = devm_reset_control_get(dev, NULL);
 	if (IS_ERR(phy->reset)) {
-- 
2.25.1

