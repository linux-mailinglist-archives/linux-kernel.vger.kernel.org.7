Return-Path: <linux-kernel+bounces-774313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A57D5B2B112
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 21:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3AED584706
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 19:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9182D2497;
	Mon, 18 Aug 2025 18:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="A+2qamSl"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AB8272E48
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 18:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755543565; cv=none; b=Bvk7zwhKt5ct6CcBzP2zvuvKtRq2VVDxQn9lk8rOQkfeprNqT9wa+RMu62epupqF5rIYqezGMVQUuAatcWbhNRhJ0R5wulc2vsQQabbZq0Z8V/sH75MukA7CfNhjB1qLXAZdGFgsevMPykgbtXBqDGCZrxoF3kBVtBgg40r63yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755543565; c=relaxed/simple;
	bh=CZzIqLl7txM9v2LMT0cPyUUYe+agcYOKK/tHV7hSgl0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IZNoi7wf5g1hkMP+aYBzaBbi2uq4zzOjyy9OK2sFdwYbBRnsAcAC0H7iXkMYjwPjXXb2QmjiSAYKR6SXJvRvo8bO32dmJYEjY+vS0OLR87N5ub6uO891XxhBWOF8+Zu7vcEQkN2pkGoi9ZTnS5q12PkCmP3I/T8xeQwN5OBsJ9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=A+2qamSl; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1755543562;
	bh=CZzIqLl7txM9v2LMT0cPyUUYe+agcYOKK/tHV7hSgl0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=A+2qamSlFvOOkTXKsmlDcOoY9MndK8kRVJlezQlz82QSjs1nMGEh8dch2/0Vv3wRz
	 Od5T2+NyapQKKgUTbDW2oALczAM6n9In4CxitKuVMZy1ZlOaUy94SDDqPRIND7itJW
	 N1i9Nd8Pe166TFaRvodYrhMn0I/CoSg58i61ZFMuQ8G2oi31raqw1HPusv3sSvDaIq
	 BuwTz1pY32DeSQ/yi9tm/a/WhpRQPUThRNHhVMF4nE6o9zIIlW6zJd1dJz2v4T8SGf
	 nkQTG3qkJBmQM0CUf4DMavNuPHgDY74GiW2sTozyfxADl6HYoaL6GbwN5TznclfDFz
	 lHmw5b9K+F10Q==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 413C717E1319;
	Mon, 18 Aug 2025 20:59:22 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Mon, 18 Aug 2025 21:59:03 +0300
Subject: [PATCH v3 03/14] phy: rockchip: samsung-hdptx: Reduce ROPLL loop
 bandwidth
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-phy-hdptx-frl-v3-3-c79997d8bb2b@collabora.com>
References: <20250818-phy-hdptx-frl-v3-0-c79997d8bb2b@collabora.com>
In-Reply-To: <20250818-phy-hdptx-frl-v3-0-c79997d8bb2b@collabora.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, Algea Cao <algea.cao@rock-chips.com>, 
 Dmitry Baryshkov <lumag@kernel.org>
Cc: kernel@collabora.com, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org
X-Mailer: b4 0.14.2

Due to its relatively low frequency, a noise stemming from the 24MHz PLL
reference clock may traverse the low-pass loop filter of ROPLL, which
could potentially generate some HDMI flash artifacts.

Reduce ROPLL loop bandwidth in an attempt to mitigate the problem.

Fixes: 553be2830c5f ("phy: rockchip: Add Samsung HDMI/eDP Combo PHY driver")
Co-developed-by: Algea Cao <algea.cao@rock-chips.com>
Signed-off-by: Algea Cao <algea.cao@rock-chips.com>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
index 8adf6e84fc0b762a7a6042459601c3271572de8e..9751f7ad00f4faf7041dbf4339f633e09f97b107 100644
--- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
+++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
@@ -500,9 +500,7 @@ static const struct reg_sequence rk_hdtpx_common_cmn_init_seq[] = {
 	REG_SEQ0(CMN_REG(0043), 0x00),
 	REG_SEQ0(CMN_REG(0044), 0x46),
 	REG_SEQ0(CMN_REG(0045), 0x24),
-	REG_SEQ0(CMN_REG(0046), 0xff),
 	REG_SEQ0(CMN_REG(0047), 0x00),
-	REG_SEQ0(CMN_REG(0048), 0x44),
 	REG_SEQ0(CMN_REG(0049), 0xfa),
 	REG_SEQ0(CMN_REG(004a), 0x08),
 	REG_SEQ0(CMN_REG(004b), 0x00),
@@ -575,6 +573,8 @@ static const struct reg_sequence rk_hdtpx_tmds_cmn_init_seq[] = {
 	REG_SEQ0(CMN_REG(0034), 0x00),
 	REG_SEQ0(CMN_REG(003d), 0x40),
 	REG_SEQ0(CMN_REG(0042), 0x78),
+	REG_SEQ0(CMN_REG(0046), 0xdd),
+	REG_SEQ0(CMN_REG(0048), 0x11),
 	REG_SEQ0(CMN_REG(004e), 0x34),
 	REG_SEQ0(CMN_REG(005c), 0x25),
 	REG_SEQ0(CMN_REG(005e), 0x4f),

-- 
2.50.1


