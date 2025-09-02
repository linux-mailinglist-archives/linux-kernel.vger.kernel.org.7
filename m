Return-Path: <linux-kernel+bounces-797086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5CEB40BA1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 19:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A859C3A4771
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 17:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047F6341679;
	Tue,  2 Sep 2025 17:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hjqWFO/A"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AD62BE048
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 17:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756832841; cv=none; b=JU0tBIcWpdNa67pxj3GS98PKNMvTraLIKsm8BQ3et6O+g/qw3LOXVLkTsIZGla3QA13hmrgT8ChZADVSeQfcagznpUyVaVbGBukYZ44PUkur7p/+C7XkYF0yLSJJ74bNbvX/pk0iSLNvW/Oy+TgxZyoWkFZVEAfgHI1ql2yleDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756832841; c=relaxed/simple;
	bh=LR53mkG+mbobU4tLnlfm/nOI9xIl/+sBawJ/Q6bMwJY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eZ83KtYa6RViJMOZTtrLxzO7keEMp/JQLo2BluaQD+6qLgPTqBLR4WGO6WzDcYz2sCXEg9XMYqKm0sru4XQos/oqeNYHwK7AXZt2gDKPDJImPnaR1H4gBG2eXXG9ADZXbkr+CXs3xf0rr31gj1Be1aheJ/Ki4gyQlWrYlnFQGKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hjqWFO/A; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1756832837;
	bh=LR53mkG+mbobU4tLnlfm/nOI9xIl/+sBawJ/Q6bMwJY=;
	h=From:Subject:Date:To:Cc:From;
	b=hjqWFO/AJyR6esVG/If33vfD6nK5724Fj5f6i7dLHQqlLvtpKR7DdvjW2g6wsDkcI
	 pJsMJNT/r2FfU+ivkGofcFms1ZILN50b6hGZ5crcstPM/OB+cCekxw43KKt/hefGGB
	 37khEnSE7iNqPAcYxXb9Yxu10rrP5vLznjRMdo4cN1JXocjU0zA4imrKOpaR2/7jpN
	 CwqWZhHsUOxjENQWq0odRo4DofsuCk2H7eSBtZLtezDfW8+ULL8gh6/14cbEkzoTJh
	 tZ+4Jk+aid364ss9a7vwFL6p4wCVVe0ZYY4TVSyG6oCbkoN05QFhU0mdWs2dEjMaZq
	 WRdavYxbtN51w==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 7C8FB17E129F;
	Tue,  2 Sep 2025 19:07:17 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: [PATCH 0/3] Fixes for phy-rockchip-samsung-hdptx
Date: Tue, 02 Sep 2025 20:06:58 +0300
Message-Id: <20250902-phy-hdptx-fixes-v1-0-e8d9ef9748d6@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADIkt2gC/x3LTQqAIBBA4avIrBsw++8q0UJqzNmYaEQR3b2h5
 cfjPZApMWUY1QOJTs68B0FZKFi8DRshr2Iw2jR60Aajv9Gv8bjQ8UUZu0r3zpGtl9aCXDHRH2S
 a5vf9AMD+O6FhAAAA
X-Change-ID: 20250902-phy-hdptx-fixes-7308ffea4c6a
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, Dmitry Baryshkov <lumag@kernel.org>, 
 Algea Cao <algea.cao@rock-chips.com>
Cc: kernel@collabora.com, linux-phy@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Andy Yan <andy.yan@rock-chips.com>
X-Mailer: b4 0.14.2

These patches were initially part of the HDMI 2.1 FRL support series [1]
aiming to provide a few fixes for the Samsung HDMI/eDP Transmitter Combo
PHY.

I'm sending this as a distinct series right now, since the FRL part
might require additional time for review.

[1] https://lore.kernel.org/r/20250818-phy-hdptx-frl-v3-0-c79997d8bb2b@collabora.com

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
Cristian Ciocaltea (3):
      phy: rockchip: samsung-hdptx: Fix reported clock rate in high bpc mode
      phy: rockchip: samsung-hdptx: Reduce ROPLL loop bandwidth
      phy: rockchip: samsung-hdptx: Prevent Inter-Pair Skew from exceeding the limits

 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 27 +++++++++++++----------
 1 file changed, 15 insertions(+), 12 deletions(-)
---
base-commit: 33bcf93b9a6b028758105680f8b538a31bc563cf
change-id: 20250902-phy-hdptx-fixes-7308ffea4c6a


