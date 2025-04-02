Return-Path: <linux-kernel+bounces-584908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7162A78D71
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 13:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB4841896EE0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 11:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7A5238176;
	Wed,  2 Apr 2025 11:44:49 +0000 (UTC)
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7193802;
	Wed,  2 Apr 2025 11:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743594289; cv=none; b=r6hXqXQfcDZXqVJWOZamcHJncyn6Qkf2IM6GVHRtJ41l4bMqY4elYYi7Ual8T1Ppqd1UouYR5qI3d2JsEPJbXv1yRanjJxatallnUwX1tXzT1VelQIopdNZ8j8FP5G4nqmJ8G7bIz7dGB1PooqAj3Jc7lxKTex4lBCb7IkSfOH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743594289; c=relaxed/simple;
	bh=wmvOiXf3WnAWRLZDLUoaSymBeRBwXXVzJpfjdlZEBS0=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=C++Ox22DW1igFg5yiH+Ij5Kt1PQvbNgcafGS2vvvEk3mcw+WB1uj3ndcTo8iCxg7X+HB+0piBIpbf7nzzc4ipScW4jwc/SYlhowXa/u/nPN9NFZfGHjeTd6PiDX3MnMtq98mFsqlRiiJzqgkfbGmsn8iJ+t6oD8L6aPpwOgV7q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4ZSNMG2x1sz4x5ph;
	Wed,  2 Apr 2025 19:44:42 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl1.zte.com.cn with SMTP id 532Bidbx069351;
	Wed, 2 Apr 2025 19:44:39 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 2 Apr 2025 19:44:42 +0800 (CST)
Date: Wed, 2 Apr 2025 19:44:42 +0800 (CST)
X-Zmail-TransId: 2afa67ed232a199-28a86
X-Mailer: Zmail v1.0
Message-ID: <20250402194442934NKPLNa40VjBaWDWKBGi8l@zte.com.cn>
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
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHQgNC81XSBwaHk6IGxhbnRpcTogcGh5LWxhbnRpcS1yY3UtdXNiMjogVXNlwqBkZXZfZXJyX3Byb2JlKCk=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 532Bidbx069351
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67ED232A.001/4ZSNMG2x1sz4x5ph

From: Zhang Enpei <zhang.enpei@zte.com.cn>

Replace the open-code with dev_err_probe() to simplify the code.

Signed-off-by: Zhang Enpei <zhang.enpei@zte.com.cn>
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
 drivers/phy/lantiq/phy-lantiq-rcu-usb2.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/lantiq/phy-lantiq-rcu-usb2.c b/drivers/phy/lantiq/phy-lantiq-rcu-usb2.c
index 82f1ffc0b0ad..7e4e42d62dbc 100644
--- a/drivers/phy/lantiq/phy-lantiq-rcu-usb2.c
+++ b/drivers/phy/lantiq/phy-lantiq-rcu-usb2.c
@@ -192,11 +192,9 @@ static int ltq_rcu_usb2_of_parse(struct ltq_rcu_usb2_priv *priv,
 	}

 	priv->ctrl_reset = devm_reset_control_get_shared(dev, "ctrl");
-	if (IS_ERR(priv->ctrl_reset)) {
-		if (PTR_ERR(priv->ctrl_reset) != -EPROBE_DEFER)
-			dev_err(dev, "failed to get 'ctrl' reset\n");
-		return PTR_ERR(priv->ctrl_reset);
-	}
+	if (IS_ERR(priv->ctrl_reset))
+		return dev_err_probe(dev, PTR_ERR(priv->ctrl_reset),
+				     "failed to get 'ctrl' reset\n");

 	priv->phy_reset = devm_reset_control_get_optional(dev, "phy");

-- 
2.25.1

